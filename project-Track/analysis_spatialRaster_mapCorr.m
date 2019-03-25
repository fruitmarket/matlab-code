% 1. spatialRaster calculates data for raster plot, spike density function and PETH.
% 2. The function calculates spatial correlation (1D)
% 3. The function calculatesspatial information (bits/spike)

% Variables for PETH & raster
winLinear = [1,125]; % 1 to 125 cm / since the radius is 20 cm (ID: 17.5cm)
winSpace = [0,124];
binSize = 1; % 1 [unit: cm]
resolution = 2;
dot = 1;

% Load files
[vtTime, vtPosition, vtList] = vtLoad;
[tData, tList] = tLoad;
nCell = length(tList);

load('Events.mat','sensor','trialIndex','calib_distance');

% Linearize position data
[realDist, theta, timeTrack, eventPosition, ~, numOccuLap] = track2linear(vtPosition{1}(:,1), vtPosition{1}(:,2),vtTime{1},sensor.S1, [sensor.S1(1), sensor.S12(end)],winLinear,binSize);

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
        eventPosition_calib = eventPosition - abs(calib_distance);
        temp_numOccuLap = numOccuLap(:,1:end-1);
        numOccuLap_cali = [temp_numOccuLap(:,end-calib_distance+1:end), temp_numOccuLap(:,1:end-calib_distance)];
    else
        eventPosition_calib = eventPosition + abs(calib_distance);
        temp_numOccuLap = numOccuLap(:,1:end-1);
        numOccuLap_cali = [temp_numOccuLap(:,abs(calib_distance)+1:end), temp_numOccuLap(:,1:abs(calib_distance))];
    end
    numOccu_cali = [numOccuLap_cali(1:30,:); numOccuLap_cali(31:60,:); numOccuLap_cali(61:90,:)];

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
    save([cellName,'.mat'],'rateMap1D_PRE','rateMap1D_STM','rateMap1D_POST','rCorr1D_preXstm','pCorr1D_preXstm','rCorr1D_preXpost','pCorr1D_preXpost','rCorr1D_stmXpost','pCorr1D_stmXpost','fCorr1D_preXstm','fCorr1D_preXpost','fCorr1D_stmXpost','-append');
    
    [~, ~, ~, ~, rateMap1D_PRE1, ~] = spatialrasterPETH(spikePosition(1:15), true(15,1), sum(numOccuLap_cali(1:15,:)), winSpace, binSize, resolution, dot);
    [~, ~, ~, ~, rateMap1D_PRE2, ~] = spatialrasterPETH(spikePosition(16:30), true(15,1), sum(numOccuLap_cali(16:30,:)), winSpace, binSize, resolution, dot);
    [rCorr1D_preXpre, pCorr1D_preXpre] = corr(rateMap1D_PRE1',rateMap1D_PRE2','rows','pairwise');
    fCorr1D_preXpre = fisherZ(rCorr1D_preXpre);
    save([cellName,'.mat'],'rateMap1D_PRE1','rateMap1D_PRE2','rCorr1D_preXpre','pCorr1D_preXpre','fCorr1D_preXpre','-append');
        
    [~, ~, ~, ~, rateMap1D_POST1, ~] = spatialrasterPETH(spikePosition(61:75), true(15,1), sum(numOccuLap_cali(61:75,:)), winSpace, binSize, resolution, dot);
    [~, ~, ~, ~, rateMap1D_POST2, ~] = spatialrasterPETH(spikePosition(76:90), true(15,1), sum(numOccuLap_cali(76:90,:)), winSpace, binSize, resolution, dot);
    [rCorr1D_postXpost, pCorr1D_postXpost] = corr(rateMap1D_POST1',rateMap1D_POST2','rows','pairwise');
    fCorr1D_postXpost = fisherZ(rCorr1D_postXpost);
    save([cellName,'.mat'],'rateMap1D_POST1','rateMap1D_POST2','rCorr1D_postXpost','pCorr1D_postXpost','fCorr1D_postXpost','-append');
        
%% Moving correlation
    lightLoc_Run = [floor(20*pi*5/6) ceil(20*pi*8/6)];
    lightLoc_Rw = [floor(20*pi*9/6) ceil(20*pi*10/6)];
    nBaseLap = 10;

    spikePositionBase = spikePosition(1:nBaseLap);
    [~,~,~,rateMapRawBase,rateMapConvBase,~] = spatialrasterPETH(spikePositionBase, true(nBaseLap,1), sum(numOccuLap_cali(1:nBaseLap,:),1), winSpace, binSize, resolution, dot);
    
    nTest = 90;
    rCorrRawMov1D = zeros(1,90);
    rCorrConvMov1D = zeros(1,90);
    [rCorrRawMov1D_Inzone, rCorrConvMov1D_Inzone, rCorrRawMov1D_Outzone, rCorrConvMov1D_Outzone] = deal(zeros(1,90)); 
    for iTest = 1: nTest
        if iTest == 1
            spikePositionTest = spikePosition(1);
            [~,~,~,rateMapRawEach,rateMapConvEach,~] = spatialrasterPETH(spikePositionTest, true(1,1), sum(numOccuLap_cali(1,:),1), winSpace, binSize, resolution, dot);
            rCorrRawMov1D(iTest) = corr(rateMapRawBase',rateMapRawEach','rows','pairwise');
            rCorrConvMov1D(iTest) = corr(rateMapConvBase',rateMapConvEach','rows','pairwise');
        elseif iTest == 2
            spikePositionTest = spikePosition(1:3);
            [~,~,~,rateMapRawEach,rateMapConvEach,~] = spatialrasterPETH(spikePositionTest, true(3,1), sum(numOccuLap_cali(1:3,:),1), winSpace, binSize, resolution, dot);
            rCorrRawMov1D(iTest) = corr(rateMapRawBase',rateMapRawEach','rows','pairwise');
            rCorrConvMov1D(iTest) = corr(rateMapConvBase',rateMapConvEach','rows','pairwise');
        elseif iTest == 89
            spikePositionTest = spikePosition(88:90);
            [~,~,~,rateMapRawEach,rateMapConvEach,~] = spatialrasterPETH(spikePositionTest, true(3,1), sum(numOccuLap_cali(88:90,:),1), winSpace, binSize, resolution, dot);
            rCorrRawMov1D(iTest) = corr(rateMapRawBase',rateMapRawEach','rows','pairwise');
            rCorrConvMov1D(iTest) = corr(rateMapConvBase',rateMapConvEach','rows','pairwise');
        elseif iTest == 90
            spikePositionTest = spikePosition(90);
            [~,~,~,rateMapRawEach,rateMapConvEach,~] = spatialrasterPETH(spikePositionTest, true(1,1), sum(numOccuLap_cali(90,:),1), winSpace, binSize, resolution, dot);
            rCorrRawMov1D(iTest) = corr(rateMapRawBase',rateMapRawEach','rows','pairwise');
            rCorrConvMov1D(iTest) = corr(rateMapConvBase',rateMapConvEach','rows','pairwise');
        else
            spikePositionTest = spikePosition(iTest-2:iTest+2);
            [~,~,~,rateMapRawEach,rateMapConvEach,~] = spatialrasterPETH(spikePositionTest, true(5,1), sum(numOccuLap_cali(iTest-2:iTest+2,:),1), winSpace, binSize, resolution, dot);
            rCorrRawMov1D(iTest) = corr(rateMapRawBase',rateMapRawEach','rows','pairwise');
            rCorrConvMov1D(iTest) = corr(rateMapConvBase',rateMapConvEach','rows','pairwise');
        end
    end
    save([cellName,'.mat'],'rCorrRawMov1D','rCorrConvMov1D','-append');
end
disp('### rate map & correlation calculation is done! ###')