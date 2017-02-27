% Variables for PETH & raster
winLinear = [1,108]; % 1 to 104 cm
winSpace = [0,107];
binSize = 1; % 1 [unit: cm]
resolution = 2;
dot = 1;

% Load files
[vtTime, vtPosition, vtList] = vtLoad;
[tData, tList] = tLoad;
nCell = length(tList);

load('Events.mat','sensor','trialIndex');

% Linearize position data
[realDist, timeTrack, eventPosition, numOccu] = track2linear(vtPosition{1}(:,1), vtPosition{1}(:,2),vtTime{1},sensor.S1, [sensor.S1(1), sensor.S12(end)],winLinear);
numOccu = numOccu';
    
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
    
    spikeLocation = realDist(spkPositionIdx); % position data of each spike
    spikePosition = spikeWin(spikeLocation,eventPosition,winSpace);
    [~,~,~,~,pethconvSpatial,~] = spatialrasterPETH(spikePosition, trialIndex, numOccu, winSpace, binSize, resolution, dot);
%     [xptSpatial,yptSpatial,pethSpatial,pethbarSpatial,pethconvSpatial,pethconvZSpatial] = spatialrasterPETH(spikePosition, trialIndex, numOccu, winSpace, binSize, resolution, dot);
    rateMap1D_pre = pethconvSpatial(1,:);
    rateMap1D_stm = pethconvSpatial(2,:);
    rateMap1D_post = pethconvSpatial(3,:);
    
    [rCorr1D_preXstm, pCorr1D_preXstm] = corr(rateMap1D_pre,rateMap1D_stm,'type','Pearson');
    [rCorr1D_preXpost, pCorr1D_preXpost] = corr(rateMap1D_pre,rateMap1D_post,'type','Pearson');
    
    save([cellName,'.mat'],'rCorr1D_preXstm','pCorr1D_preXstm','rCorr1D_preXpost','pCorr1D_preXpost','-append');
end
disp('### 1D cross-correlation calculation is done!')