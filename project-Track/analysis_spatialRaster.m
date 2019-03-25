% 1. spatialRaster calculates data for raster plot, spike density function and PETH.
% 2. The function calculates spatial correlation (1D)
% 3. The function calculatesspatial information (bits/spike)

%% Load files
[vtTime, vtPosition, vtList] = vtLoad;
[tData, tList] = tLoad;
nCell = length(tList);
load('Events.mat','sensor','trialIndex','lightTime','reward2','reward4','calib_distance');

% Variables for PETH & raster
winLinear = [1,125]; %-calib_distance; % [1,125] total length of the track (r: 20 cm (ID: 17.5cm))
winSpace = [0,124]; % [0,124]
binSizeSpace = 1; % 1 [unit: cm]
resolution = 2;
dot = 1;

%% Linearize position data
[realDist, theta, timeTrack, eventPosition, ~, numOccu] = track2linear(vtPosition{1}(:,1), vtPosition{1}(:,2),vtTime{1},sensor.S1, [sensor.S1(1), sensor.S12(end)],winLinear, binSizeSpace);

% align spike time to position time
for iCell = 1:nCell
    disp(['### Spatial raster analysis: ',tList{iCell},'...']);
    [cellPath,cellName,~] = fileparts(tList{iCell});
    cd(cellPath);

%% Change spike time to spike position
    spikeData = tData{iCell}(sensor.S1(1)<tData{iCell} & tData{iCell}<sensor.S12(end));
    nSpike = length(spikeData);
    
    newSpikeData = zeros(nSpike,1); % spike time conversion to video tracking time
    spkPositionIdx = zeros(nSpike,1);
    for iSpike = 1:nSpike
        [~,timeIndex] = min(abs(spikeData(iSpike)-timeTrack));
        newSpikeData(iSpike) = timeTrack(timeIndex);
        spkPositionIdx(iSpike) = timeIndex;
    end

%% location calibration 
    if calib_distance > 0
        eventPosition_calib = eventPosition - calib_distance;
        temp_numOccu = numOccu(:,1:end-1);
        numOccu_cali = [temp_numOccu(:,end-calib_distance+1:end), temp_numOccu(:,1:end-calib_distance)];
    else
        eventPosition_calib = eventPosition + abs(calib_distance);
        temp_numOccu = numOccu(:,1:end-1);
        numOccu_cali = [temp_numOccu(:,abs(calib_distance)+1:end), temp_numOccu(:,1:abs(calib_distance))];
    end
    numOccu_cali = [sum(numOccu_cali(1:30,:)); sum(numOccu_cali(31:60,:)); sum(numOccu_cali(61:90,:))];

% Spike location
    spikeLocation = realDist(spkPositionIdx); % position data of each spike
    spikePosition = spikeWin(spikeLocation,eventPosition_calib,winSpace); % spikeLocation is re-organized by each lap
    [xptSpatial,yptSpatial,pethSpatial,pethbarSpatial,pethconvSpatial,pethconvZSpatial] = spatialrasterPETH(spikePosition, trialIndex, numOccu_cali, winSpace, binSizeSpace, resolution, dot);
    peakFR1D_track = max(pethconvSpatial,[],2);
    if calib_distance > 0
        
    else
    end
    save([cellName,'.mat'],'xptSpatial','yptSpatial','pethSpatial','pethbarSpatial','pethconvSpatial','pethconvZSpatial','peakFR1D_track','-append');
    
%% spatial correlation 1D
    rateMap1D_PRE = pethconvSpatial(1,:);
    rateMap1D_STM = pethconvSpatial(2,:);
    rateMap1D_POST = pethconvSpatial(3,:);
    
    [rCorr1D_preXstm, pCorr1D_preXstm] = corr(rateMap1D_PRE',rateMap1D_STM','rows','pairwise'); % corr calculates based on column vectors
    [rCorr1D_preXpost, pCorr1D_preXpost] = corr(rateMap1D_PRE',rateMap1D_POST','rows','pairwise');
    [rCorr1D_stmXpost, pCorr1D_stmXpost] = corr(rateMap1D_STM',rateMap1D_POST','rows','pairwise');
    fCorr1D_preXstm = fisherZ(rCorr1D_preXstm);
    fCorr1D_preXpost = fisherZ(rCorr1D_preXpost);
    fCorr1D_stmXpost = fisherZ(rCorr1D_stmXpost);
    
%% Spatial information (spikePosition, occupancy are required)
    meanFRPRE = length(cell2mat(spikePosition(1:30)))/(sensor.S1(30)-sensor.S1(1))*1000;
    meanFRSTM = length(cell2mat(spikePosition(31:60)))/(sensor.S1(60)-sensor.S1(31))*1000;
    meanFRPOST = length(cell2mat(spikePosition(61:90)))/(sensor.S12(90)-sensor.S1(61))*1000;
    meanFRTotal = length(cell2mat(spikePosition))/(sensor.S12(end)-sensor.S1(1))*1000; %  spikes/sec
    
    numOccuSI = numOccu_cali; % unit [sec]
    numOccuSI(:,end) = []; % delete last bin
    if meanFRPRE ~= 0
        spikePRE = reshape(histc(cell2mat(spikePosition(1:30)),winLinear(1):binSizeSpace:winLinear(2)),1,length(winLinear(1):binSizeSpace:winLinear(2))); % originally 125
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
        spikeSTM = reshape(histc(cell2mat(spikePosition(31:60)),winLinear(1):binSizeSpace:winLinear(2)),1,length(winLinear(1):binSizeSpace:winLinear(2)));
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
        spikePOST = reshape(histc(cell2mat(spikePosition(61:90)),winLinear(1):binSizeSpace:winLinear(2)),1,length(winLinear(1):binSizeSpace:winLinear(2)));
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
        spikeTotal = reshape(histc(cell2mat(spikePosition),winLinear(1):binSizeSpace:winLinear(2)),1,length(winLinear(1):binSizeSpace:winLinear(2)));
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
end
disp('### Making Spatial Raster & PETH & correlation(1D) & spatial information is done!')