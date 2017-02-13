% Variables for PETH & raster
winLinear = [1,105]; % 1 to 104 cm
winSpace = [0,104];
binSize = 1; % 1 [unit: cm]
resolution = 2;
dot = 1;

% Load files
[vtTime, vtPosition, vtList] = vtLoad;
[tData, tList] = tLoad;
nCell = length(tList);

load('Events.mat','sensor','trialIndex');

% Linearize position data
[theta, timeTrack, eventPosition, numOccu] = track2linear(vtPosition{1}(:,1), vtPosition{1}(:,2),vtTime{1},sensor.S1,[sensor.S1(1), sensor.S12(end)],winLinear); 

% align spike time to position time
for iCell = 1:nCell    
    disp(['### Spatial raster analysis: ',tList{iCell},'...']);
    [cellPath,cellName,~] = fileparts(tList{iCell});
    cd(cellPath);
    
    spikeData = tData{iCell}(sensor.S1(1)<tData{iCell} & tData{iCell}<sensor.S12(end));
    nSpike = length(spikeData);
    
    newSpikeData = zeros(nSpike,1);
    for iSpike = 1:nSpike
        [~,timeIndex] = min(abs(spikeData(iSpike)-timeTrack));
        newSpikeData(iSpike) = timeTrack(timeIndex);
    end

    spkPositionIdx = zeros(nSpike,1);
    for iSpike = 1:nSpike
        spkPositionIdx(iSpike) = find((timeTrack == newSpikeData(iSpike)));
    end
    spikeLocation = theta(spkPositionIdx); % position data of each spike

    spikePosition = spikeWin(spikeLocation,eventPosition,winSpace);
    [xptSpatial,yptSpatial,pethSpatial,pethbarSpatial,pethconvSpatial,pethconvZSpatial] = spatialrasterPETH(spikePosition, trialIndex, numOccu, winSpace, binSize, resolution, dot);
    save([cellName,'.mat'],'xptSpatial','yptSpatial','pethSpatial','pethbarSpatial','pethconvSpatial','pethconvZSpatial','-append');
end
disp('### Making Spatial Raster & PETH is done!')