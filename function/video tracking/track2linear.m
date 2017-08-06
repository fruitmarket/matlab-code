function [thetaDist, theta, timeTrack, refPosition, numOccu, numOccuPRE] = track2linear(vtPositionX, vtPositionY, vtTime, refSensor, timeOnTrack, win)
%
% outputs
% theta: cumulative position expressed in radian (2*pi is added for each lap)
% timeTrack: video time on the track
% newX: positionX
% newY: positionY
% numOccu: number of occupance of the position (1cm bin)
%
% Inputs
% vtPositionX, vtPositionY, vtTime should be same size arrays
% refSensor should be one sensor from 12 sensors (ex. sensor.S1)
% timeOnTrack should contain two elements [startTime, endTime]
%

binSize = 1; % binSize: 1cm
spatialBin = win(1):binSize:win(2);
narginchk(6,6);
if isempty(vtPositionX);isempty(vtPositionY);isempty(vtTime);isempty(refSensor);isempty(timeOnTrack); return; end;

%% laserOnTime
% px2cm = 0.966;
timeTrack = vtTime(timeOnTrack(1)<=vtTime & vtTime<=timeOnTrack(2));
refSensorIdx = zeros(90,1);
for iSensor = 1:90
    [~,refSensorIdx(iSensor)] = (min(abs(refSensor(iSensor)-timeTrack)));
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

%%
 theta2cmPre = theta(refSensorIdx(1):(refSensorIdx(31)-1))*radius;
 theta2cmStm = theta(refSensorIdx(31):(refSensorIdx(61)-1))*radius;
 theta2cmPost = theta(refSensorIdx(61):end)*radius;
 numOccu(:,1) = histc(theta2cmPre,spatialBin);
 numOccu(:,2) = histc(theta2cmStm,spatialBin);
 numOccu(:,3) = histc(theta2cmPost,spatialBin);
 numOccu = numOccu/30; % devid by video tracking frequency (30Hz)
 
 theta2cmPRE1 = theta(refSensorIdx(1):(refSensorIdx(16)-1))*radius;
 theta2cmPRE2 = theta(refSensorIdx(16):(refSensorIdx(61)-1))*radius;
 numOccuPRE(:,1) = histc(theta2cmPRE1,spatialBin);
 numOccuPRE(:,2) = histc(theta2cmPRE2,spatialBin);
 numOccuPRE = numOccuPRE/30;

addDist = [];
difTime = diff(refSensorIdx);
for i =1:89
    tempDist = ones(difTime(i),1)*2*pi*(i-1);
    addDist = [addDist;tempDist];
end
addDist((end+1):nPosition) = 2*pi*89;
thetaDist = (theta+addDist)*radius; % (degree >> cm) absolute distance in (cm)
refPosition = thetaDist(refSensorIdx);
end