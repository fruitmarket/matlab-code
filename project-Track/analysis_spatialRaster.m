% Variables for PETH & raster
win = [0, 100]; % 0 to 104 cm
binSize = 0.5; % 0.5 [unit: cm]
resolution = 10;
dot = 1;

% Load files
[vtTime, vtPosition, vtList] = vtLoad;
[tData, tList] = tLoad;
nCell = length(tList);

load('Events.mat','sensor','trialIndex');

% Linearize position data
[theta, timeTrack, eventPosition,~,~] = track2linear(vtPosition{1}(:,1), vtPosition{1}(:,2),vtTime{1},sensor.S1,[sensor.S1(1), sensor.S12(end)]); 

% align spike time to position time
for iCell = 1:nCell    
    disp(['### Analyzing ',tList{iCell},'...']);
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
    for i = 1:nSpike
        spkPositionIdx(i) = find((timeTrack == newSpikeData(i)));
    end
    spikeLocation = theta(spkPositionIdx); % position data of each spike

    spikePosition = spikeWin(spikeLocation,eventPosition,win);
    [xptSpatial,yptSpatial,pethtimeSpatial,pethbarSpatial,pethconvSpatial,pethconvZSpatial] = spatialrasterPETH(spikePosition, trialIndex, win, binSize, resolution, dot);
    
    save([cellName,'.mat'],'xptSpatial','yptSpatial','pethtimeSpatial','pethbarSpatial','pethconvSpatial','pethconvZSpatial','-append');
end
disp('### Making Spatial Raster & PETH is done!')