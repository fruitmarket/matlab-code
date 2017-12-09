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

load('Events.mat','sensor','trialIndex','lightTime','reward2','reward4');

% Linearize position data
[realDist, theta, timeTrack, eventPosition, numOccu, numOccuPRE, numOccuPOST] = track2linear(vtPosition{1}(:,1), vtPosition{1}(:,2),vtTime{1},sensor.S1, [sensor.S1(1), sensor.S12(end)],winLinear);
numOccu = numOccu';
numOccuPRE = numOccuPRE';
numOccuPOST = numOccuPOST';
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
    lapStartLightIdx = [1;find(diff(lightTime.Track8hz)>1000)+1];
    temp_lightOnLoci = zeros(30,1);
    for iIdx = 1:30
        [~, lightOnIdx] = min(abs(lightTime.Track8hz(lapStartLightIdx(iIdx))-timeTrack));
        temp_lightOnLoci(iIdx) = theta(lightOnIdx)*20;
    end
    lightOnLoc = floor(mean(temp_lightOnLoci)*10)/10;
    
    lapEndLightIdx = [find(diff(lightTime.Track8hz)>1000);length(lightTime.Track8hz)];
    temp_lightOffLoci = zeros(30,1);
    ci = zeros(30,1);
    for iIdx = 1:30
        [~, lightOffIdx] = min(abs(lightTime.Track8hz(lapEndLightIdx(iIdx))-timeTrack));
        temp_lightOffLoci(iIdx) = theta(lightOffIdx)*20;
    end
    lightOffLoc = ceil(mean(temp_lightOffLoci)*10)/10;
    lightLoc = [lightOnLoc, lightOffLoc];

% Reward zone
    for iReward = 1:90
            [~,reward2on_idx] = min(abs(sensor.S4(iReward)-timeTrack));
            temp_reward2on_idx = theta(reward2on_idx)*20;
            [~,reward2off_idx] = min(abs(sensor.S5(iReward)-timeTrack));
            temp_reward2off_idx = theta(reward2off_idx)*20;
            [~,reward4on_idx] = min(abs(sensor.S10(iReward)-timeTrack));
            temp_reward4on_idx = theta(reward4on_idx)*20;
            [~,reward4off_idx] = min(abs(sensor.S11(iReward)-timeTrack));
            temp_reward4off_idx = theta(reward4off_idx)*20;     
    end
    reward2Loc = [round(mean(temp_reward2on_idx)*10)/10 round(mean(temp_reward2off_idx)*10)/10];
    reward4Loc = [round(mean(temp_reward4on_idx)*10)/10 round(mean(temp_reward4off_idx)*10)/10];
    rewardLoc = [reward2Loc; reward4Loc];

    abso_reward2Posi = [3/6 4/6]*20*pi;
    abso_reward4Posi = [9/6 10/6]*20*pi;
    if(regexp(cellPath,'Run'))
       abso_light = [5/6 8/6]*20*pi;
    else
       abso_light = [9/6 10/6]*20*pi;
    end
    diff_light = abso_light - lightLoc;
    diff_reward2 = abso_reward2Posi - reward2Loc;
    diff_reward4 = abso_reward4Posi - reward4Loc;
    calib_distance = mean([diff_light, diff_reward2, diff_reward4]);
    calib_distance = round(calib_distance);
    if calib_distance > 0
        eventPosition_calib = eventPosition - calib_distance;
        temp_numOccu = numOccu(:,1:end-1);
        numOccu_cali = [temp_numOccu(:,end-calib_distance+1:end), temp_numOccu(:,1:end-calib_distance)];
        temp_numOccu_PRE = numOccuPRE(:,1:end-1);
        numOccu_cali_PRE = [temp_numOccu_PRE(:,end-calib_distance+1:end), temp_numOccu_PRE(:,1:end-calib_distance)];
        temp_numOccu_POST = numOccuPOST(:,1:end-1);
        numOccu_cali_POST = [temp_numOccu_POST(:,end-calib_distance+1:end), temp_numOccu_POST(:,1:end-calib_distance)];
    else
        eventPosition_calib = eventPosition + calib_distance;
        temp_numOccu = numOccu(:,1:end-1);
        numOccu_cali = [temp_numOccu(:,abs(calib_distance)+1:end), temp_numOccu(:,1:abs(calib_distance))];
        temp_numOccu_PRE = numOccuPRE(:,1:end-1);
        numOccu_cali_PRE = [temp_numOccu_PRE(:,abs(calib_distance)+1:end), temp_numOccu_PRE(:,1:abs(calib_distance))];
        temp_numOccu_POST = numOccuPOST(:,1:end-1);
        numOccu_cali_POST = [temp_numOccu_POST(:,abs(calib_distance)+1:end), temp_numOccu_POST(:,1:abs(calib_distance))];
    end

% Spike location
    spikeLocation = realDist(spkPositionIdx); % position data of each spike
    spikePosition = spikeWin(spikeLocation,eventPosition_calib,winSpace); % spikeLocation is re-organized by each lap
    [xptSpatial,yptSpatial,pethSpatial,pethbarSpatial,pethconvSpatial,pethconvZSpatial] = spatialrasterPETH(spikePosition, trialIndex, numOccu_cali, winSpace, binSize, resolution, dot);
    
%% spatial correlation 1D
    pv_rateMap1D_PRE = pethconvSpatial(1,:);
    pv_rateMap1D_STM = pethconvSpatial(2,:);
    pv_rateMap1D_POST = pethconvSpatial(3,:);
    idxCompare = min([sum(double(isfinite(pv_rateMap1D_PRE))), sum(double(isfinite(pv_rateMap1D_STM))), sum(double(isfinite(pv_rateMap1D_POST)))]);
       
    spikePositionPRE = spikePosition(1:30);
    A = [1,0];
    B = [0,1];
    trialIndexPRE = logical([repmat(A,15,1);repmat(B,15,1)]);
    [~, ~, ~, ~, pethconvSpatialPRE, ~] = spatialrasterPETH(spikePositionPRE, trialIndexPRE, numOccu_cali_PRE(:,end-1), winSpace, binSize, resolution, dot);
    pv_rateMap1D_PRE1 = pethconvSpatialPRE(1,:);
    pv_rateMap1D_PRE2 = pethconvSpatialPRE(2,:);
    
    spikePositionPOST = spikePosition(61:90);
    trialIndexspikePositionPOST = logical([repmat(A,15,1);repmat(B,15,1)]);
    [~, ~, ~, ~, pethconvSpatialPOST, ~] = spatialrasterPETH(spikePositionPRE, trialIndexspikePositionPOST, numOccu_cali_PRE(:,end-1), winSpace, binSize, resolution, dot);
    pv_rateMap1D_POST1 = pethconvSpatialPOST(1,:);
    pv_rateMap1D_POST2 = pethconvSpatialPOST(2,:);
    save([cellName,'.mat'],'pv_rateMap1D_PRE','pv_rateMap1D_STM','pv_rateMap1D_POST','pv_rateMap1D_PRE1','pv_rateMap1D_PRE2','pv_rateMap1D_POST1','pv_rateMap1D_POST2','-append');
end
disp('### rateMap for PV correlation!')