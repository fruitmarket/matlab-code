function track2linear_v2()
%
% outputs
% thetaDist: cumulative position expressed in radian (2*pi is added for each lap)
% timeTrack: video time on the track
% newX: positionX
% newY: positionY
% numOccu: number of occupance of the position (1cm bin)
% refPosition: event position (either sensor or reward)
% Inputs
% vtPositionX, vtPositionY, vtTime should be same size arrays
% refSensor should be one sensor from 12 sensors (ex. sensor.S1)
% timeOnTrack should contain two elements [startTime, endTime]
%
winLinear = [1,125];
winSpace = [0, 124];
binSize = 1; %cm
resolution = 2;
dot = 1;

[vtTime, vtPosition, ~] = vtLoad;
vtTime = vtTime{1};
vtPosition = vtPosition{1};
vtPositionX = vtPosition(:,1);
vtPositionY = vtPosition(:,2);

[tData,tList] = tLoad;
nCell = length(tList);

load('Events.mat');
%% laserOnTime
[cellPath,cellName,~] = fileparts(tList{1});
cd(cellPath);
    
timeTrack = vtTime(sensor.S1(1)<=vtTime & vtTime<=sensor.S12(end));
timeOnTrack = [sensor.S1(1), sensor.S12(end)];
refSensorIdx = zeros(90,1);
for iSensor = 1:90
    [~,refSensorIdx(iSensor)] = (min(abs(sensor.S1(iSensor)-timeTrack)));
end
refSensorIdx = [refSensorIdx(1); refSensorIdx(2:end)+1]; % each component is the index of start position of each lap.
posiX = vtPositionX(timeOnTrack(1)<=vtTime & vtTime<=timeOnTrack(2));
posiY = vtPositionY(timeOnTrack(1)<=vtTime & vtTime<=timeOnTrack(2));

posiX = posiX((~isnan(posiX) & ~isnan(posiY)));
posiY = posiY((~isnan(posiX) & ~isnan(posiY)));

centerX = mean(posiX);
centerY = mean(posiY);
% radius = mean(sqrt((posiX-centerX).^2+(posiY-centerY).^2));
radius = 20; % r = 20 cm

nPosition = length(posiX);

vRef = [posiX(1)-centerX,-(posiY(1)-centerY)];
vSample = [posiX-centerX,-(posiY-centerY)];
degreeSample = zeros(nPosition,1);

degreeRef = atan(vRef(2)/vRef(1));
for iTheta = 1:nPosition
    degreeSample(iTheta) = atan(vSample(iTheta,2)/vSample(iTheta,1));
    if vSample(iTheta,1)>0 && vSample(iTheta,2)>0;
        degreeSample(iTheta) = degreeSample(iTheta);
    elseif vSample(iTheta,1)<0 && vSample(iTheta,2)>0;
        degreeSample(iTheta) = degreeSample(iTheta)-pi;
    elseif vSample(iTheta,1)<0 && vSample(iTheta,2)<0;
        degreeSample(iTheta) = degreeSample(iTheta)-pi;
    else vSample(iTheta,1)>0 && vSample(iTheta,2)<0;
        degreeSample(iTheta) = degreeSample(iTheta);
    end
end
theta = degreeSample-degreeRef;
% theta = degreeSample;

for iTheta = 1:nPosition
    if theta(iTheta)>0
        theta(iTheta) = theta(iTheta)-2*pi;
    end
end
theta = abs(theta);

% theta = atan2(vSample(:,2),vSample(:,1));
% theta = atan2(vSample(:,2),vSample(:,1))-atan2(vRef(2),vRef(1));

% theta = atan2(vRef(1)*vSample(:,2)-vRef(2)*vSample(:,1),vRef(1)*vSample(:,1)+vRef(2)*vSample(:,2)); % angle between sensor1 to each position

% theta = atan2d(vRef(2),vRef(1))-atan2d(vSample(:,2),vSample(:,1));
% if abs(theta) > 180
%     theta = theta - 360*sign(theta);
% end

%% calibration
    lapStartLightIdx = [1;find(diff(lightTime.Track50hz)>1000)+1];
    temp_lightOnLoci = zeros(30,1);
    for iIdx = 1:30
        [~, lightOnIdx] = min(abs(lightTime.Track50hz(lapStartLightIdx(iIdx))-timeTrack));
        temp_lightOnLoci(iIdx) = theta(lightOnIdx)*20;
    end
    lightOnLoc = floor(mean(temp_lightOnLoci)*10)/10;
    
    lapEndLightIdx = [find(diff(lightTime.Track50hz)>1000);length(lightTime.Track50hz)];
    temp_lightOffLoci = zeros(30,1);
    for iIdx = 1:30
        [~, lightOffIdx] = min(abs(lightTime.Track50hz(lapEndLightIdx(iIdx))-timeTrack));
        temp_lightOffLoci(iIdx) = theta(lightOffIdx)*20;
    end
    lightOffLoc = ceil(mean(temp_lightOffLoci)*10)/10;
    lightLoc = [lightOnLoc, lightOffLoc];
    
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
    
%%
addDist = [];
difTime = diff(refSensorIdx);
for i =1:89
    tempDist = ones(difTime(i),1)*2*pi*(i-1);
    addDist = [addDist;tempDist];
end
addDist((end+1):nPosition) = 2*pi*89;
thetaDist = (theta+addDist)*radius; % (degree >> cm) absolute distance in (cm)
positionStart = thetaDist(refSensorIdx);
positionStart = positionStart-calib_distance;

 theta2cmPre = theta(refSensorIdx(1):(refSensorIdx(31)-1))*radius;
 theta2cmStm = theta(refSensorIdx(31):(refSensorIdx(61)-1))*radius;
 theta2cmPost = theta(refSensorIdx(61):end)*radius;
 numOccu(:,1) = histc(theta2cmPre,spatialBin);
 numOccu(:,2) = histc(theta2cmStm,spatialBin);
 numOccu(:,3) = histc(theta2cmPost,spatialBin);
 numOccu = numOccu/30; % devid by video tracking frequency (30Hz)
 numOccu = numOccu(:,1:end-1);
 temp_numOccu = numOccu;
 numOccu_cali = [temp_numOccu(:,end-calib_distance+1:end), temp_numOccu(1:end-calib_distance)];
 
 theta2cmPRE1 = theta(refSensorIdx(1):(refSensorIdx(16)-1))*radius;
 theta2cmPRE2 = theta(refSensorIdx(16):(refSensorIdx(61)-1))*radius;
 numOccuPRE(:,1) = histc(theta2cmPRE1,spatialBin);
 numOccuPRE(:,2) = histc(theta2cmPRE2,spatialBin);
 numOccuPRE = numOccuPRE/30;


end