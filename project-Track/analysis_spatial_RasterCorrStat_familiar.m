function analysis_spatial_RasterCorrStat_familiar
% 1. spatialRaster calculates data for raster plot, spike density function and PETH.
% 2. The function calculates spatial correlation (1D)
% 3. The function calculatesspatial information (bits/spike)

% Variables for PETH & raster
winLinear = [1,125]; % 1 to 125 cm / since the radius is 20 cm (ID: 17.5cm)
winSpace = [0,124];
binSize = 1; % 1 [unit: cm]
resolution = 2;
dot = 0;

% Load files
[vtTime, vtPosition, vtList] = vtLoad;
[tData, tList] = tLoad;
nCell = length(tList);

load('Events.mat','sensor','timeTask','trialIndex','calibTask');

% Linearize position data
[realDist, theta, timeTrack, eventPosition, ~, numOccuLap] = track2linear(vtPosition{1}(:,1), vtPosition{1}(:,2),vtTime{1}, sensor(1:90,1), timeTask, winLinear, binSize);

% align spike time to position time
for iCell = 1:nCell
    disp(['### Spatial ratemap, correlation analysis: ',tList{iCell},'...']);
    [cellPath,cellName,~] = fileparts(tList{iCell});
    cd(cellPath);
    
    spikeTask = tData{iCell}(sensor(1,1)<tData{iCell} & tData{iCell}<sensor(90,12));
    nSpikeTask = length(spikeTask);
        
    newSpikeTask = zeros(nSpikeTask,1); % spike time conversion to video tracking time
    for iSpike = 1:nSpikeTask
        [~,timeIndex] = min(abs(spikeTask(iSpike)-timeTrack));
        newSpikeTask(iSpike) = timeTrack(timeIndex);
    end
       
    spkPosiIdxTask = zeros(nSpikeTask,1);
    for iSpike = 1:nSpikeTask
        spkPosiIdxTask(iSpike) = find(timeTrack == newSpikeTask(iSpike));
    end
    
%%
    if calibTask > 0
        ePosi_calibTask = eventPosition - abs(calibTask);
        temp_numOccuLap = numOccuLap(:,1:end-1);
        numOccuLap_cali = [temp_numOccuLap(:,end-calibTask+1:end), temp_numOccuLap(:,1:end-calibTask)];
    else
        ePosi_calibTask = eventPosition + abs(calibTask);
        temp_numOccuLap = numOccuLap(:,1:end-1);
        numOccuLap_cali = [temp_numOccuLap(:,abs(calibTask)+1:end), temp_numOccuLap(:,1:abs(calibTask))];
    end

%% Spike location calibration
    spikeLocationTask = realDist(spkPosiIdxTask);
    spikePositionTask = spikeWin(spikeLocationTask,ePosi_calibTask,winSpace);
    
    numOccu = zeros(3,124);
    for iBlock = 1:3
        numOccu(iBlock,:) = sum(numOccuLap_cali(30*(iBlock-1)+1:30*iBlock,:),1);
    end
    [xptSpatial,yptSpatial,pethSpatial,pethRawSpatial,pethconvSpatial,pethconvZSpatial] = proj_fn_spatialrasterPETH(spikePositionTask, trialIndex, numOccu, winSpace, binSize, resolution, dot);
    peakFR1D_track = max(pethconvSpatial,[],2);
    save([cellName,'.mat'],'xptSpatial','yptSpatial','pethSpatial','pethRawSpatial','pethconvSpatial','pethconvZSpatial','peakFR1D_track','-append');

%% Ratemap (All lap)
    rateMap1D_PRE = pethconvSpatial(1,:);
    rateMap1D_STM = pethconvSpatial(2,:);
    rateMap1D_POST = pethconvSpatial(3,:);
    
%     [rCorr1D_preXstm, pCorr1D_preXstm] = corr(rateMap1D_PRE',rateMap1D_STM','rows','pairwise'); % corr calculates based on column vectors
%     [rCorr1D_preXpost, pCorr1D_preXpost] = corr(rateMap1D_PRE',rateMap1D_POST','rows','pairwise');
%     [rCorr1D_stmXpost, pCorr1D_stmXpost] = corr(rateMap1D_STM',rateMap1D_POST','rows','pairwise');
%         
%     fCorr1D_preXstm = fisherZ(rCorr1D_preXstm);
%     fCorr1D_preXpost = fisherZ(rCorr1D_preXpost);
%     fCorr1D_stmXpost = fisherZ(rCorr1D_stmXpost);
%     save([cellName,'.mat'],'rateMap1D_PRE','rateMap1D_STM','rateMap1D_POST','rCorr1D_preXstm','pCorr1D_preXstm','rCorr1D_preXpost','pCorr1D_preXpost','rCorr1D_stmXpost','pCorr1D_stmXpost','fCorr1D_preXstm','fCorr1D_preXpost','fCorr1D_stmXpost','-append');
    save([cellName,'.mat'],'rateMap1D_PRE','rateMap1D_STM','rateMap1D_POST','-append');
        
%% Moving correlation
    lightLoc_Run = [floor(20*pi*5/6) ceil(20*pi*8/6)];
    lightLoc_Rw = [floor(20*pi*9/6) ceil(20*pi*10/6)];
    nBaseLap = 10;
    nLap = size(trialIndex,1);

    spikePositionBase = spikePositionTask(1:nBaseLap);
    [~,~,~,~,rateMapConvBase,~] = proj_fn_spatialrasterPETH(spikePositionBase, true(nBaseLap,1), sum(numOccuLap_cali(1:nBaseLap,:),1), winSpace, binSize, resolution, dot);
    
    rCorrRawMov1D = zeros(1,nLap);
    rCorrConvMov1D = zeros(1,nLap);
    for iCorr = 1: nLap
        if iCorr == 1
            spikePositionTest = spikePositionTask(1);
            [~,~,~,~,rateMapConvEach,~] = proj_fn_spatialrasterPETH(spikePositionTest, true(1,1), sum(numOccuLap_cali(1,:),1), winSpace, binSize, resolution, dot);
            rCorrConvMov1D(iCorr) = corr(rateMapConvBase',rateMapConvEach','rows','pairwise');
        elseif iCorr == 2
            spikePositionTest = spikePositionTask(1:3);
            [~,~,~,~,rateMapConvEach,~] = proj_fn_spatialrasterPETH(spikePositionTest, true(3,1), sum(numOccuLap_cali(1:3,:),1), winSpace, binSize, resolution, dot);
            rCorrConvMov1D(iCorr) = corr(rateMapConvBase',rateMapConvEach','rows','pairwise');
        elseif iCorr == 89
            spikePositionTest = spikePositionTask(88:90);
            [~,~,~,~,rateMapConvEach,~] = proj_fn_spatialrasterPETH(spikePositionTest, true(3,1), sum(numOccuLap_cali(nLap-2:nLap,:),1), winSpace, binSize, resolution, dot);
            rCorrConvMov1D(iCorr) = corr(rateMapConvBase',rateMapConvEach','rows','pairwise');
        elseif iCorr == 90
            spikePositionTest = spikePositionTask(nLap);
            [~,~,~,~,rateMapConvEach,~] = proj_fn_spatialrasterPETH(spikePositionTest, true(1,1), sum(numOccuLap_cali(nLap,:),1), winSpace, binSize, resolution, dot);
            rCorrConvMov1D(iCorr) = corr(rateMapConvBase',rateMapConvEach','rows','pairwise');
        else
            spikePositionTest = spikePositionTask(iCorr-2:iCorr+2);
            [~,~,~,~,rateMapConvEach,~] = proj_fn_spatialrasterPETH(spikePositionTest, true(5,1), sum(numOccuLap_cali(iCorr-2:iCorr+2,:),1), winSpace, binSize, resolution, dot);
            rCorrConvMov1D(iCorr) = corr(rateMapConvBase',rateMapConvEach','rows','pairwise');
        end
    end
    save([cellName,'.mat'],'rCorrConvMov1D','-append');
    
%% Spatial information
    meanFR(1) = length(cell2mat(spikePositionTask(1:30)))/(sensor(30,12)-sensor(1,1))*1000;
    meanFR(2) = length(cell2mat(spikePositionTask(31:60)))/(sensor(60,12)-sensor(31,1))*1000;
    meanFR(3) = length(cell2mat(spikePositionTask(61:90)))/(sensor(90,12)-sensor(61,1))*1000;    
    meanFR(4) = length(cell2mat(spikePositionTask))/(sensor(end)-sensor(1,1))*1000; %  spikes/sec
    [spike, numOccuBlock] = deal([]);
    
    for iBlock = 1:3
        if meanFR(iBlock) ~= 0
            spike(iBlock,:) = reshape(histc(cell2mat(spikePositionTask((30*(iBlock-1)+1):30*iBlock)),winLinear(1):binSize:winLinear(2)),1,length(winLinear(1):binSize:winLinear(2)));
        else
            spike(iBlock,:) = zeros(1,125); % if there is no spikes, reshape can not calculate
        end
        numOccuBlock(iBlock,:) = sum(numOccuLap_cali(30*(iBlock-1)+1:30*iBlock,:));
    end
    spike(:,end) = [];
    P_spike = spike ./ numOccuBlock;
    P_posi = bsxfun(@rdivide,numOccuBlock,sum(numOccuBlock,2));
    
    [infoSpike, infoSecond] = deal(zeros(4,1));
    for iBlock = 1:3
        if meanFR(iBlock) ~= 0
            tempInfoSpike = P_posi(iBlock,:).*P_spike(iBlock,:)/meanFR(iBlock).*log2(P_spike(iBlock,:)/meanFR(iBlock));
            infoSpike(iBlock) = sum(tempInfoSpike(isfinite(tempInfoSpike)));
            tempInfoSecond = P_posi(iBlock,:).*P_spike(iBlock,:).*log2(P_spike(iBlock,:)/meanFR(iBlock));
            infoSecond(iBlock) = sum(tempInfoSecond(isfinite(tempInfoSecond)));
        else
            [infoSpike(iBlock), infoSecond(iBlock)] = deal(NaN);
        end
    end
    
    if meanFR(4) ~= 0;
        spikeTotal = reshape(histc(cell2mat(spikePositionTask),winLinear(1):binSize:winLinear(2)),1,length(winLinear(1):binSize:winLinear(2)));
        spikeTotal(:,end) = [];
        P_spikeTotal = spikeTotal ./ sum(numOccuLap_cali,1);
        P_posiTotal = sum(numOccuLap_cali,1)/sum(sum(numOccuLap_cali));
        tempInfoSpike = P_posiTotal.*(P_spikeTotal/meanFR(4)).*log2(P_spikeTotal/meanFR(4));
        infoSpike(4) = sum(tempInfoSpike(isfinite(tempInfoSpike)));
        tempInfoSecond = P_posiTotal.*P_spikeTotal.*log2(P_spikeTotal/meanFR(4));
        infoSecond(4) = sum(tempInfoSecond(isfinite(tempInfoSecond)));
    else
        [infoSpike(4), infoSecond(4)] = deal(NaN);
    end
    
    save([cellName,'.mat'],'infoSpike','infoSecond','-append');
    
%% stimzoneSpike
    [xptSpatial,~,~,~,~,~] = proj_fn_spatialrasterPETH(spikePositionTask, logical(diag(ones(1,90))), numOccuLap_cali, winSpace, binSize, resolution, 1);

    totalSpike = cellfun(@length, xptSpatial)';
    inzoneSpike = cellfun(@(x) length(find(lightLoc_Run(1)<x & x<lightLoc_Run(2))),xptSpatial)';
    outzoneSpike = totalSpike-inzoneSpike;
    
    [sum_inzoneSpike, m_inzoneSpike, sem_inzoneSpike] = deal([]);
    [sum_outzoneSpike, m_outzoneSpike, sem_outzoneSpike] = deal([]);
    [sum_totalSpike, m_totalSpike, sem_totalSpike] = deal([]);
    
    for iBlock = 1:3
        sum_inzoneSpike(iBlock) = sum(inzoneSpike(30*(iBlock-1)+1:30*iBlock));
        m_inzoneSpike(iBlock) = mean(inzoneSpike(30*(iBlock-1)+1:30*iBlock));
        sem_inzoneSpike(iBlock) = std(inzoneSpike(30*(iBlock-1)+1:30*iBlock))/sqrt(30);
        sum_outzoneSpike(iBlock) = sum(outzoneSpike(30*(iBlock-1)+1:30*iBlock));
        m_outzoneSpike(iBlock) = mean(outzoneSpike(30*(iBlock-1)+1:30*iBlock));
        sem_outzoneSpike(iBlock) = std(outzoneSpike(30*(iBlock-1)+1:30*iBlock))/sqrt(30);
        sum_totalSpike(iBlock) = sum(totalSpike(30*(iBlock-1)+1:30*iBlock));
        m_totalSpike(iBlock) = mean(totalSpike(30*(iBlock-1)+1:30*iBlock));
        sem_totalSpike(iBlock) = std(totalSpike(30*(iBlock-1)+1:30*iBlock))/sqrt(30);
    end

%% Firing rate calculation
    sensorOn = sensor(:,6);
    sensorOff = sensor(:,9);
    lapTime = zeros(90,1);
    for iLap = 1:89
        lapTime(iLap) = sensor(iLap+1,1)-sensor(iLap,1);
    end
    lapTime(90) = sensor(90,12)-sensor(90,1);
    lapTimeInzone = sensorOff-sensorOn;
    lapTimeOutzone = lapTime-lapTimeInzone;
    
    lapFrInzone = inzoneSpike./lapTimeInzone*1000; % unit change: ms --> Hz
    lapFrOutzone = outzoneSpike./lapTimeOutzone*1000;
    lapFrTotal = totalSpike./lapTime*1000;
    for iBlock = 1:3
        m_lapFrInzone(iBlock) = mean(lapFrInzone(30*(iBlock-1)+1:30*iBlock));
        sem_lapFrInzone(iBlock) = std(lapFrInzone(30*(iBlock-1)+1:30*iBlock))/sqrt(30);
        m_lapFrOutzone(iBlock) = mean(lapFrOutzone(30*(iBlock-1)+1:30*iBlock));
        sem_lapFrOutzone(iBlock) = std(lapFrOutzone(30*(iBlock-1)+1:30*iBlock))/sqrt(30);
        m_lapFrTotalzone(iBlock) = mean(lapFrTotal(30*(iBlock-1)+1:30*iBlock));
        sem_lapFrTotalzone(iBlock) = std(lapFrTotal(30*(iBlock-1)+1:30*iBlock))/sqrt(30);
    end

% Statistics
    group = {'PRE','STIM','POST'};
    p_ttestFr(1,1) = ranksum(lapFrInzone(1:30),lapFrInzone(31:60));
    p_ttestFr(2,1) = ranksum(lapFrInzone(1:30),lapFrInzone(61:90));
    p_ttestFr(3,1) = ranksum(lapFrInzone(31:60),lapFrInzone(61:90));
    p_ttestFr(1,2) = ranksum(lapFrOutzone(1:30),lapFrOutzone(31:60));
    p_ttestFr(2,2) = ranksum(lapFrOutzone(1:30),lapFrOutzone(61:90));
    p_ttestFr(3,2) = ranksum(lapFrOutzone(31:60),lapFrOutzone(61:90));
    p_ttestFr(1,3) = ranksum(lapFrTotal(1:30),lapFrTotal(31:60));
    p_ttestFr(2,3) = ranksum(lapFrTotal(1:30),lapFrTotal(61:90));
    p_ttestFr(3,3) = ranksum(lapFrTotal(31:60),lapFrTotal(61:90));
    
    p_ttestSpk(1,1) = ranksum(inzoneSpike(1:30),inzoneSpike(31:60));
    p_ttestSpk(2,1) = ranksum(inzoneSpike(1:30),inzoneSpike(61:90));
    p_ttestSpk(3,1) = ranksum(inzoneSpike(31:60),inzoneSpike(61:90));
    p_ttestSpk(1,2) = ranksum(outzoneSpike(1:30),outzoneSpike(31:60));
    p_ttestSpk(2,2) = ranksum(outzoneSpike(1:30),outzoneSpike(61:90));
    p_ttestSpk(3,2) = ranksum(outzoneSpike(31:60),outzoneSpike(61:90));
    p_ttestSpk(1,3) = ranksum(totalSpike(1:30),totalSpike(31:60));
    p_ttestSpk(2,3) = ranksum(totalSpike(1:30),totalSpike(61:90));
    p_ttestSpk(3,3) = ranksum(totalSpike(31:60),totalSpike(61:90));    
    
% Control-zone spike (half-half maze)
    lightLoc_RunHalf = [37:98];
    lightLoc_RunCtrl = [1:36,99:124];
    inzoneSpike_half = cellfun(@(x) length(find(lightLoc_RunHalf(1)<x & x<lightLoc_RunHalf(end))),xptSpatial)';
    outzoneSpike_half = totalSpike - inzoneSpike_half;
    sum_inzoneSpike_half = sum(inzoneSpike_half);
    sum_outzoneSpike_half = sum(outzoneSpike_half);
    
    save([cellName,'.mat'],...
        'inzoneSpike','sum_inzoneSpike','m_inzoneSpike','sem_inzoneSpike',...
        'outzoneSpike','sum_outzoneSpike','m_outzoneSpike','sem_outzoneSpike',...
        'totalSpike','sum_totalSpike','m_totalSpike','sem_totalSpike',...
        'lapFrInzone','lapFrOutzone','lapFrTotal',...
        'm_lapFrInzone','m_lapFrOutzone','m_lapFrTotalzone',...
        'lapTime','lapTimeInzone','lapTimeOutzone',...    
        'p_ttestFr','p_ttestSpk',...
        'inzoneSpike_half','sum_inzoneSpike_half','outzoneSpike_half','sum_outzoneSpike_half',...
        '-append');
end
disp('### rate map & correlation calculation is done! ###')
end