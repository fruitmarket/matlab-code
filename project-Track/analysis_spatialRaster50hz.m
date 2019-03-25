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

load('Events.mat','sensor','trialIndex','lightTime','reward2','reward4','calib_distance');

% Linearize position data
[realDist, theta, timeTrack, eventPosition, ~, numOccuLap] = track2linear(vtPosition{1}(:,1), vtPosition{1}(:,2),vtTime{1},sensor.S1, [sensor.S1(1), sensor.S12(end)],winLinear, binSize);
    
% align spike time to position time
for iCell = 1:nCell
    disp(['### Spatial raster analysis: ',tList{iCell},'...']);
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
    
%% location calibration 
    temp_numOccuLap = numOccuLap(:,1:end-1);
    if calib_distance > 0
        eventPosition_calib = eventPosition - abs(calib_distance);
        numOccuLap_cali = [temp_numOccuLap(:,end-calib_distance+1:end), temp_numOccuLap(:,1:end-calib_distance)];
    else
        eventPosition_calib = eventPosition + abs(calib_distance);
        numOccuLap_cali = [temp_numOccuLap(:,abs(calib_distance)+1:end), temp_numOccuLap(:,1:abs(calib_distance))];
    end
    numOccu_cali = [sum(numOccuLap_cali(1:30,:)); sum(numOccuLap_cali(31:60,:)); sum(numOccuLap_cali(61:90,:))];
% Spike location
    spikeLocation = realDist(spkPositionIdx); % position data of each spike
    spikePosition = spikeWin(spikeLocation,eventPosition_calib,winSpace);
    [xptSpatial,yptSpatial,pethSpatial,pethbarSpatial,pethconvSpatial,pethconvZSpatial] = spatialrasterPETH(spikePosition, trialIndex, numOccu_cali, winSpace, binSize, resolution, dot);
    peakFR1D_track = max(pethconvSpatial,[],2);
    save([cellName,'.mat'],'xptSpatial','yptSpatial','pethSpatial','pethbarSpatial','pethconvSpatial','pethconvZSpatial','peakFR1D_track','-append');

%% Ratemap (All lap)
    rateMap1D_PRE = pethconvSpatial(1,:);
    rateMap1D_STM = pethconvSpatial(2,:);
    rateMap1D_POST = pethconvSpatial(3,:);
    save([cellName,'.mat'],'rateMap1D_PRE','rateMap1D_STM','rateMap1D_POST','-append');
    
%% Moving correlation
% Baseline: 10 laps
    if regexp(cellPath,'Run')
        lightLoc = [floor(20*pi*5/6) ceil(20*pi*8/6)];
    else
        lightLoc = [floor(20*pi*9/6) ceil(20*pi*10/6)]; 
    end
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
        rCorrRawMov1D_Inzone(iTest) = corr(rateMapRawBase(lightLoc(1):lightLoc(2))',rateMapRawEach(lightLoc(1):lightLoc(2))','rows','pairwise');
        rCorrConvMov1D_Inzone(iTest) = corr(rateMapConvBase(lightLoc(1):lightLoc(2))',rateMapConvEach(lightLoc(1):lightLoc(2))','rows','pairwise');
        rCorrRawMov1D_Outzone(iTest) = corr(rateMapRawBase([1:lightLoc(1)-1,lightLoc(2)+1:124])',rateMapRawEach([1:lightLoc(1)-1,lightLoc(2)+1:124])','rows','pairwise');
        rCorrConvMov1D_Outzone(iTest) = corr(rateMapConvBase([1:lightLoc(1)-1,lightLoc(2)+1:124])',rateMapConvEach([1:lightLoc(1)-1,lightLoc(2)+1:124])','rows','pairwise');
    end
    save([cellName,'.mat'],'rCorrRawMov1D','rCorrConvMov1D','rCorrRawMov1D_Inzone','rCorrConvMov1D_Inzone','rCorrRawMov1D_Outzone','rCorrConvMov1D_Outzone','-append');

%% Spatial information (spikePosition, occupancy are required)
    meanFRPRE = length(cell2mat(spikePosition(1:30)))/(sensor.S1(30)-sensor.S1(1))*1000;
    meanFRSTM = length(cell2mat(spikePosition(31:60)))/(sensor.S1(60)-sensor.S1(31))*1000;
    meanFRPOST = length(cell2mat(spikePosition(61:90)))/(sensor.S12(90)-sensor.S1(61))*1000;
    meanFRTotal = length(cell2mat(spikePosition))/(sensor.S12(end)-sensor.S1(1))*1000; %  spikes/sec
    
    numOccuSI = numOccu_cali; % unit [sec]
%     numOccuSI(:,end) = []; % delete last bin
    if meanFRPRE ~= 0
        spikePRE = reshape(histc(cell2mat(spikePosition(1:30)),winLinear(1):binSize:winLinear(2)),1,length(winLinear(1):binSize:winLinear(2)));
        spikePRE(end) = [];
        PspikePRE = spikePRE./numOccuSI(1,:);
        PposiPRE = numOccuSI(1,:)/sum(numOccuSI(1,:));        
        tempInfoSpike = PposiPRE.*(PspikePRE/meanFRPRE).*log2(PspikePRE/meanFRPRE);
        infoSpikePRE = sum(tempInfoSpike(isfinite(tempInfoSpike)));
        tempInfoSecond = PposiPRE.*PspikePRE.*log2(PspikePRE/meanFRPRE);
        infoSecondPRE = sum(tempInfoSecond(isfinite(tempInfoSecond)));
    else
        infoSpikePRE = NaN;
        infoSecondPRE = NaN;
    end
    if meanFRSTM ~= 0
        spikeSTM = reshape(histc(cell2mat(spikePosition(31:60)),winLinear(1):binSize:winLinear(2)),1,length(winLinear(1):binSize:winLinear(2)));
        spikeSTM(end) = [];
        PspikeSTM = spikeSTM./numOccuSI(2,:);
        PposiSTM = numOccuSI(2,:)/sum(numOccuSI(2,:));
        tempInfoSpike = PposiSTM.*(PspikeSTM/meanFRSTM).*log2(PspikeSTM/meanFRSTM);
        infoSpikeSTM = sum(tempInfoSpike(isfinite(tempInfoSpike)));
        tempInfoSecond = PposiSTM.*PspikeSTM.*log2(PspikeSTM/meanFRSTM);
        infoSecondSTM = sum(tempInfoSecond(isfinite(tempInfoSecond)));
    else
        infoSpikeSTM = NaN;
        infoSecondSTM = NaN;
    end
    if meanFRPOST ~= 0
        spikePOST = reshape(histc(cell2mat(spikePosition(61:90)),winLinear(1):binSize:winLinear(2)),1,length(winLinear(1):binSize:winLinear(2)));
        spikePOST(end) = [];
        PspikePOST = spikePOST./numOccuSI(3,:);
        PposiPOST = numOccuSI(3,:)/sum(numOccuSI(3,:));
        tempInfoSpike = PposiPOST.*(PspikePOST/meanFRPOST).*log2(PspikePOST/meanFRPOST);
        infoSpikePOST = sum(tempInfoSpike(isfinite(tempInfoSpike)));
        tempInfoSecond = PposiPOST.*PspikePOST.*log2(PspikePOST/meanFRPOST);
        infoSecondPOST = sum(tempInfoSecond(isfinite(tempInfoSecond)));
    else
        infoSpikePOST = NaN;
        infoSecondPOST = NaN;
    end   
    if meanFRTotal ~= 0
        spikeTotal = reshape(histc(cell2mat(spikePosition),winLinear(1):binSize:winLinear(2)),1,length(winLinear(1):binSize:winLinear(2)));
        spikeTotal(end) = [];
        PspikeTotal = spikeTotal./sum(numOccuSI,1);
        PposiTotal = sum(numOccuSI,1)/sum(numOccuSI(:));
        tempInfoSpike = PposiTotal.*(PspikeTotal/meanFRTotal).*log2(PspikeTotal/meanFRTotal);
        infoSpikeTotal = sum(tempInfoSpike(isfinite(tempInfoSpike)));
        tempInfoSecond = PposiTotal.*PspikeTotal.*log2(PspikeTotal/meanFRTotal);
        infoSecondTotal = sum(tempInfoSecond(isfinite(tempInfoSecond)));
    else
        infoSpikeTotal = NaN;
        infoSecondTotal = NaN;
    end
    save([cellName,'.mat'],'infoSpikePRE','infoSecondPRE','infoSpikeSTM','infoSecondSTM','infoSpikePOST','infoSecondPOST','infoSpikeTotal','infoSecondTotal','-append');
    
%% Stimzone Spike
    [xptSpatial,~,~,~,~,~] = spatialrasterPETH(spikePosition, logical(diag(ones(1,90))), numOccuLap_cali, winSpace, binSize, resolution, dot);
    
    totalSpike = cellfun(@length, xptSpatial)';
    inzoneSpike = cellfun(@(x) length(find(lightLoc(1)<x & x<lightLoc(2))),xptSpatial)';
    outzoneSpike = totalSpike-inzoneSpike;

    [sum_inzoneSpike, m_inzoneSpike, sem_inzoneSpike] = deal([]);
    [sum_outzoneSpike, m_outzoneSpike, sem_outzoneSpike] = deal([]);
    [sum_totalSpike] = deal([]);
    for iBlock = 1:3
        sum_inzoneSpike(iBlock) = sum(inzoneSpike(30*(iBlock-1)+1:30*iBlock));
        m_inzoneSpike(iBlock) = mean(inzoneSpike(30*(iBlock-1)+1:30*iBlock));
        sem_inzoneSpike(iBlock) = std(inzoneSpike(30*(iBlock-1)+1:30*iBlock))/sqrt(30);
        
        sum_outzoneSpike(iBlock) = sum(outzoneSpike(30*(iBlock-1)+1:30*iBlock));
        m_outzoneSpike(iBlock) = mean(outzoneSpike(30*(iBlock-1)+1:30*iBlock));
        sem_outzoneSpike(iBlock) = std(outzoneSpike(30*(iBlock-1)+1:30*iBlock))/sqrt(30);
        
        sum_totalSpike(iBlock) = sum(totalSpike(30*(iBlock-1)+1:30*iBlock));
    end
    save([cellName,'.mat'],...
        'inzoneSpike','sum_inzoneSpike','m_inzoneSpike','sem_inzoneSpike',...
        'outzoneSpike','sum_outzoneSpike','m_outzoneSpike','sem_outzoneSpike',...
        'totalSpike','sum_totalSpike','-append');
    
%% Firing rate calculation
    lapTime = zeros(90,1);
    for iLap = 1:89
        lapTime(iLap) = sensor.S1(iLap+1)-sensor.S1(iLap);
    end
    lapTime(90) = sensor.S12(90)-sensor.S1(90);
    if regexp(cellPath,'Run')
        sensorOn = sensor.S6;
        sensorOff = sensor.S9;
    else
        sensorOn = sensor.S10;
        sensorOff= sensor.S11;
    end
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
    
% Firing rate statistic test
    group = {'PRE','STM','POST'};
    p_ttestFr(1,1) = ranksum(lapFrInzone(1:30),lapFrInzone(31:60));
    p_ttestFr(2,1) = ranksum(lapFrInzone(1:30),lapFrInzone(61:90));
    p_ttestFr(3,1) = ranksum(lapFrInzone(31:60),lapFrInzone(61:90));
    
    p_ttestFr(1,2) = ranksum(lapFrOutzone(1:30),lapFrOutzone(31:60));
    p_ttestFr(2,2) = ranksum(lapFrOutzone(1:30),lapFrOutzone(61:90));
    p_ttestFr(3,2) = ranksum(lapFrOutzone(31:60),lapFrOutzone(61:90));
    
    p_ttestFr(1,3) = ranksum(lapFrTotal(1:30),lapFrTotal(31:60));
    p_ttestFr(2,3) = ranksum(lapFrTotal(1:30),lapFrTotal(61:90));
    p_ttestFr(3,3) = ranksum(lapFrTotal(31:60),lapFrTotal(61:90));
    
    save([cellName,'.mat'],...
        'lapTime','lapTimeInzone','lapTimeOutzone',...
        'lapFrInzone','lapFrOutzone',...
        'm_lapFrInzone','sem_lapFrInzone',...
        'm_lapFrOutzone','sem_lapFrOutzone',...
        'm_lapFrTotalzone','sem_lapFrTotalzone','p_ttestFr','-append');
    
%% Control-zone spike (half-half maze)
    if regexp(cellPath,'Run')
        lightLoc = [37:98];
        inzoneSpike_half = cellfun(@(x) length(find(lightLoc(1)<x & x<lightLoc(end))),xptSpatial)';
        outzoneSpike_half = totalSpike - inzoneSpike_half;
        sum_inzoneSpike_half = sum(inzoneSpike_half);
        sum_outzoneSpike_half = sum(outzoneSpike_half);
    else
        lightLoc = [63:124];
        inzoneSpike_half = cellfun(@(x) length(find(lightLoc(1)<x & x<lightLoc(end))),xptSpatial)';
        outzoneSpike_half = totalSpike - inzoneSpike_half;
        sum_inzoneSpike_half = sum(inzoneSpike_half);
        sum_outzoneSpike_half = sum(outzoneSpike_half);
    end
    save([cellName,'.mat'],...
        'inzoneSpike_half','sum_inzoneSpike_half',...
        'outzoneSpike_half','sum_outzoneSpike_half','-append');
    
%% stay time in stm zone
    temp_dTime = sensorOff-sensorOn;
    diffTime = [mean(temp_dTime(1:30)), mean(temp_dTime(31:60)), mean(temp_dTime(61:90))]/mean(temp_dTime(1:30)); % normalized by PRE time
    timeIn_inzone = round(diffTime*100)/100;
    save([cellName,'.mat'],'timeIn_inzone','-append');
end
disp('### Analysis: Spatial Raster, PETH, Stimzone spike is done!')