% 1. spatialRaster calculates data for raster plot, spike density function and PETH.
% 2. The function calculates spatial correlation (1D)
% 3. The function calculatesspatial information (bits/spike)

% Variables for PETH & raster
winLinear = [1,125]; % 1 to 125 cm / since the radius is 20 cm (ID: 17.5cm)
winSpace = [0,124];
binSize = 1; % 1 [unit: cm]
resolution = 1;
dot = 1;

% Load files
[vtTime, vtPosition, vtList] = vtLoad;
[tData, tList] = tLoad;
nCell = length(tList);

load('Events.mat','sensor','trialIndex','lightTime','reward2','reward4','calib_distance');

% Linearize position data
[realDist, theta, timeTrack, eventPosition, numOccu, numOccuPRE, numOccuPOST, numOccuLap] = track2linear(vtPosition{1}(:,1), vtPosition{1}(:,2),vtTime{1},sensor.S1, [sensor.S1(1), sensor.S12(end)],winLinear,binSize);
% numOccu = numOccu';
% numOccuPRE = numOccuPRE';
% numOccuPOST = numOccuPOST';
% align spike time to position time
for iCell = 1:nCell
    disp(['### Spatial ratemap, correlation analysis: ',tList{iCell},'...']);
    [cellPath,cellName,~] = fileparts(tList{iCell});
    cd(cellPath);
    
    spikeData = tData{iCell}(sensor.S1(1)<tData{iCell} & tData{iCell}<sensor.S12(end));
    nSpike = length(spikeData);
    
    newSpikeData = zeros(nSpike,1); % spike time conversion to video tracking time
    for iSpike = 1:nSpike
        [~,timeIndex] = min(abs(spikeData(iSpike)-timeTrack));
        newSpikeData(iSpike) = timeTrack(timeIndex);
    end

    spkPositionIdx = zeros(nSpike,1);
    for iSpike = 1:nSpike
        spkPositionIdx(iSpike) = find((timeTrack == newSpikeData(iSpike)));
    end
    
%%
    if calib_distance > 0
        eventPosition_calib = eventPosition - calib_distance;
        temp_numOccu = numOccu(:,1:end-1);
        numOccu_cali = [temp_numOccu(:,end-calib_distance+1:end), temp_numOccu(:,1:end-calib_distance)];
        temp_numOccu_PRE = numOccuPRE(:,1:end-1);
        numOccu_cali_PRE = [temp_numOccu_PRE(:,end-calib_distance+1:end), temp_numOccu_PRE(:,1:end-calib_distance)];
        temp_numOccu_POST = numOccuPOST(:,1:end-1);
        numOccu_cali_POST = [temp_numOccu_POST(:,end-calib_distance+1:end), temp_numOccu_POST(:,1:end-calib_distance)];
        temp_numOccuLap = numOccuLap(:,1:end-1);
        numOccuLap_cali = [temp_numOccuLap(:,end-calib_distance+1:end), temp_numOccuLap(:,1:end-calib_distance)];
    else
        eventPosition_calib = eventPosition + calib_distance;
        temp_numOccu = numOccu(:,1:end-1);
        numOccu_cali = [temp_numOccu(:,abs(calib_distance)+1:end), temp_numOccu(:,1:abs(calib_distance))];
        temp_numOccu_PRE = numOccuPRE(:,1:end-1);
        numOccu_cali_PRE = [temp_numOccu_PRE(:,abs(calib_distance)+1:end), temp_numOccu_PRE(:,1:abs(calib_distance))];
        temp_numOccu_POST = numOccuPOST(:,1:end-1);
        numOccu_cali_POST = [temp_numOccu_POST(:,abs(calib_distance)+1:end), temp_numOccu_POST(:,1:abs(calib_distance))];
        temp_numOccuLap = numOccuLap(:,1:end-1);
        numOccuLap_cali = [temp_numOccuLap(:,abs(calib_distance)+1:end), temp_numOccuLap(:,1:abs(calib_distance))];
    end

%% Spike location calibration
    spikeLocation = realDist(spkPositionIdx); % position data of each spike
    spikePosition = spikeWin(spikeLocation,eventPosition_calib,winSpace); % spikeLocation is re-organized by each lap
    [~,~,pethSpatial,pethRawSpatial,pethconvSpatial,pethconvZSpatial] = spatialrasterPETH(spikePosition, trialIndex, numOccu_cali, winSpace, binSize, resolution, dot);
    
%% Ratemap (All lap)
    rateMap1D_PRE = pethconvSpatial(1,:);
    rateMap1D_STM = pethconvSpatial(2,:);
    rateMap1D_POST = pethconvSpatial(3,:);
    
    [rCorr1D_preXstm, pCorr1D_preXstm] = corr(rateMap1D_PRE',rateMap1D_STM','rows','pairwise'); % corr calculates based on column vectors
    [rCorr1D_preXpost, pCorr1D_preXpost] = corr(rateMap1D_PRE',rateMap1D_POST','rows','pairwise');
    [rCorr1D_stmXpost, pCorr1D_stmXpost] = corr(rateMap1D_STM',rateMap1D_POST','rows','pairwise');
    fCorr1D_preXstm = fisherZ(rCorr1D_preXstm);
    fCorr1D_preXpost = fisherZ(rCorr1D_preXpost);
    fCorr1D_stmXpost = fisherZ(rCorr1D_stmXpost);
    save([cellName,'.mat'],'rCorr1D_preXstm','pCorr1D_preXstm','rCorr1D_preXpost','pCorr1D_preXpost','rCorr1D_stmXpost','pCorr1D_stmXpost','fCorr1D_preXstm','fCorr1D_preXpost','fCorr1D_stmXpost','-append');
    
    spikePositionPRE = spikePosition(1:30);
    A = [1,0];
    B = [0,1];
    trialIndexPRE = logical([repmat(A,15,1);repmat(B,15,1)]);
    [~, ~, ~, ~, pethconvSpatialPRE, ~] = spatialrasterPETH(spikePositionPRE, trialIndexPRE, numOccuLap_cali(1:30,:), winSpace, binSize, resolution, dot);
    rateMap1D_PRE1 = pethconvSpatialPRE(1,:);
    rateMap1D_PRE2 = pethconvSpatialPRE(2,:);
    [rCorr1D_preXpre, pCorr1D_preXpre] = corr(rateMap1D_PRE1',rateMap1D_PRE2','rows','pairwise');
    fCorr1D_preXpre = fisherZ(rCorr1D_preXpre);
    save([cellName,'.mat'],'rateMap1D_PRE1','rateMap1D_PRE2','rCorr1D_preXpre','pCorr1D_preXpre','fCorr1D_preXpre','-append');
        
    spikePositionPOST = spikePosition(61:90);
    trialIndexspikePositionPOST = logical([repmat(A,15,1);repmat(B,15,1)]);
    [~, ~, ~, ~, pethconvSpatialPOST, ~] = spatialrasterPETH(spikePositionPOST, trialIndexspikePositionPOST, numOccuLap_cali(61:90,:), winSpace, binSize, resolution, dot);
    rateMap1D_POST1 = pethconvSpatialPOST(1,:); % lap 61~75
    rateMap1D_POST2 = pethconvSpatialPOST(2,:); % lap 76~90
    [rCorr1D_postXpost, pCorr1D_postXpost] = corr(rateMap1D_POST1',rateMap1D_POST2','rows','pairwise');
    fCorr1D_postXpost = fisherZ(rCorr1D_postXpost);
    save([cellName,'.mat'],'rateMap1D_POST1','rateMap1D_POST2','rCorr1D_postXpost','pCorr1D_postXpost','fCorr1D_postXpost','-append');
    
%% No-convolution, PRE, STIM, POST block ratemap
    rateMapRaw_PRE = pethRawSpatial(1,:);
    rateMapRaw_STIM = pethRawSpatial(2,:);
    rateMapRaw_POST = pethRawSpatial(3,:);
    
    [rCorrRaw1D_preXstm, pCorrRaw1D_preXstm] = corr(rateMapRaw_PRE',rateMapRaw_STIM','rows','pairwise'); % corr calculates based on column vectors
    [rCorrRaw1D_preXpost, pCorrRaw1D_preXpost] = corr(rateMapRaw_PRE',rateMapRaw_POST','rows','pairwise');
    [rCorrRaw1D_stmXpost, pCorrRaw1D_stmXpost] = corr(rateMapRaw_STIM',rateMapRaw_POST','rows','pairwise');
    save([cellName,'.mat'],'rateMapRaw_PRE','rateMapRaw_STIM','rateMapRaw_POST','rCorrRaw1D_preXstm','rCorrRaw1D_preXpost','rCorrRaw1D_stmXpost','-append');
    
%% No-convolution, Lap-by-lap ratemap
    trialIndexLap = logical(diag(ones(1,90)));
    [~, ~, ~, pethLapRawSpatial, rateMapConv_eachLap, ~] = spatialrasterPETH(spikePosition, trialIndexLap, numOccuLap_cali, winSpace, binSize, resolution, dot);
    rateMapRaw_eachLap = pethLapRawSpatial;
    save([cellName,'.mat'],'rateMapRaw_eachLap','rateMapConv_eachLap','-append');
    
%% No-convolution, Baseline ratemap (10 from middle of each block)
    spikePositionBasePRE = spikePosition(11:20);
    spikePositionBaseSTIM = spikePosition(41:50);
    spikePositionBasePOST = spikePosition(71:80);

    [~,~,~,pethLapRawBase10_PRE,rateMapConvBase10_PRE,~] = spatialrasterPETH(spikePositionBasePRE,true(10,1),sum(numOccuLap_cali(11:20,:),1),winSpace, binSize, resolution, dot);
    [~,~,~,pethLapRawBase10_STIM,rateMapConvBase10_STIM,~] = spatialrasterPETH(spikePositionBaseSTIM,true(10,1),sum(numOccuLap_cali(41:50,:),1),winSpace, binSize, resolution, dot);
    [~,~,~,pethLapRawBase10_POST,rateMapConvBase10_POST,~] = spatialrasterPETH(spikePositionBasePOST,true(10,1),sum(numOccuLap_cali(71:80,:),1),winSpace, binSize, resolution, dot);
    rateMapRaw10_PRE = pethLapRawBase10_PRE;
    rateMapRaw10_STIM = pethLapRawBase10_STIM;
    rateMapRaw10_POST = pethLapRawBase10_POST;

    [rCorrRawLap_basePRE, rCorrRawLap_baseSTIM, rCorrRawLap_basePOST] = deal(zeros(1,90));
    [rCorrConvLap_basePRE, rCorrConvLap_baseSTIM, rCorrConvLap_basePOST] = deal(zeros(1,90));
    for iLap = 1:90
        rCorrRawLap_basePRE(1,iLap) = corr(pethLapRawBase10_PRE', pethLapRawSpatial(iLap,:)','rows','pairwise');
        rCorrRawLap_baseSTIM(1,iLap) = corr(pethLapRawBase10_STIM', pethLapRawSpatial(iLap,:)','rows','pairwise');
        rCorrRawLap_basePOST(1,iLap) = corr(pethLapRawBase10_POST', pethLapRawSpatial(iLap,:)','rows','pairwise');
        rCorrConvLap_basePRE(1,iLap) = corr(rateMapConvBase10_PRE', rateMapConv_eachLap(iLap,:)','rows','pairwise');
        rCorrConvLap_baseSTIM(1,iLap) = corr(rateMapConvBase10_STIM', rateMapConv_eachLap(iLap,:)','rows','pairwise');
        rCorrConvLap_basePOST(1,iLap) = corr(rateMapConvBase10_POST', rateMapConv_eachLap(iLap,:)','rows','pairwise');        
    end
    save([cellName,'.mat'],'rateMapRaw10_PRE','rateMapRaw10_STIM','rateMapRaw10_POST','rCorrRawLap_basePRE','rCorrRawLap_baseSTIM','rCorrRawLap_basePOST',...
        'rateMapConv10_PRE','rateMapConv10_STIM','rateMapConv10_POST','rCorrConvLap_basePRE','rCorrConvLap_baseSTIM','rCorrConvLap_basePOST','-append');
    
%% Moving correlation
%     spikePositionBase = spikePosition(1:30);
%     [~,~,~,~,pethconvSpatialBase,~] = spatialrasterPETH(spikePositionBase, true(30,1), sum(numOccuLap_cali(1:30,:),1), winSpace, binSize, resolution, dot);
%     
%     nTest = 81;
%     rCorrMoving1D_total = zeros(1,81);
%     for iTest = 1: nTest
%         spikePositionTest = spikePosition(iTest:iTest+9);
%         [~,~,~,~,pethconvSpatialTest,~] = spatialrasterPETH(spikePositionTest, true(10,1), sum(numOccuLap_cali(iTest:iTest+9,:),1), winSpace, binSize, resolution, dot);
%         rCorrMoving1D_total(iTest) = corr(pethconvSpatialBase',pethconvSpatialTest','rows','pairwise');
%     end
%     save([cellName,'.mat'],'rCorrMoving1D_total','-append');
end
disp('### rate map & correlation calculation is done! ###')