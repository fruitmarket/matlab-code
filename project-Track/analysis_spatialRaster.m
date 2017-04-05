% Variables for PETH & raster
winLinear = [1,125]; % 1 to 125 cm / since the radius is 20 cm (ID: 17.5cm)
winSpace = [0,124];
% winLinear = [1,111]; % 1 to 125 cm / since the radius is 20 cm (ID: 17.5cm)
% winSpace = [0,110];
binSize = 1; % 1 [unit: cm]
resolution = 2;
dot = 1;

% Load files
[vtTime, vtPosition, vtList] = vtLoad;
[tData, tList] = tLoad;
nCell = length(tList);

load('Events.mat','sensor','trialIndex','lightTime','reward2','reward4');

% Linearize position data
[realDist, theta, timeTrack, eventPosition, numOccu] = track2linear(vtPosition{1}(:,1), vtPosition{1}(:,2),vtTime{1},sensor.S1, [sensor.S1(1), sensor.S12(end)],winLinear);
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

% stimulation zone
    [~,lightOnIdx] = min(abs(lightTime.Track8hz(1)-timeTrack));
    lightOnLoc = round((theta(lightOnIdx)*20)*10)/10;
    [~,lightOffIdx] = min(abs(lightTime.Track8hz(end)-timeTrack));
    lightOffLoc = round((theta(lightOffIdx)*20)*10)/10;
    lightLoc = [lightOnLoc, lightOffLoc];

% Reward zone
    nReward2 = length(reward2);
    nReward4 = length(reward4);
    temp_reward2Loc = zeros(nReward2,1);
    temp_reward4Loc = zeros(nReward4,1);
    for iReward2 = 1:nReward2
        [~,reward2Idx] = min(abs(reward2(iReward2)-timeTrack));
        temp_reward2Loc(iReward2) = round((theta(reward2Idx)*20)*10)/10;
    end
    reward2Loc = mean(temp_reward2Loc);
    for iReward4 = 1:nReward4
        [~,reward4Idx] = min(abs(reward4(iReward4)-timeTrack));
        temp_reward4Loc(iReward4) = round((theta(reward4Idx)*20)*10)/10;
    end
    reward4Loc = mean(temp_reward4Loc);
    rewardLoc = [reward2Loc, reward4Loc];

% Spike location
    spikeLocation = realDist(spkPositionIdx); % position data of each spike
    spikePosition = spikeWin(spikeLocation,eventPosition,winSpace);
    [xptSpatial,yptSpatial,pethSpatial,pethbarSpatial,pethconvSpatial,pethconvZSpatial] = spatialrasterPETH(spikePosition, trialIndex, numOccu(:,1:end-1), winSpace, binSize, resolution, dot);
    peakFR1D_track = max(pethconvSpatial,[],2);
    
    save([cellName,'.mat'],'xptSpatial','yptSpatial','pethSpatial','pethbarSpatial','pethconvSpatial','pethconvZSpatial','peakFR1D_track','lightLoc','rewardLoc','-append');
end
disp('### Making Spatial Raster & PETH is done!')