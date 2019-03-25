function [thetaDist, theta, timeTrack, refPosition, refSensorIdx, numOccuLap] = track2linear(vtPositionX, vtPositionY, vtTime, refSensor, timeOnTrack, win, binSizeSpace)
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

spatialBin = win(1):binSizeSpace:win(2);
narginchk(7,7);
if isempty(vtPositionX);isempty(vtPositionY);isempty(vtTime);isempty(refSensor);isempty(timeOnTrack); return; end

%% laserOnTime
% px2cm = 0.966;
timeTrack = vtTime(timeOnTrack(1)<=vtTime & vtTime<=timeOnTrack(2));
nCycle = size(refSensor,1);
refSensorIdx = zeros(nCycle,1);
for iSensor = 1:nCycle
%     [~,refSensorIdx(iSensor)] = (min(abs(refSensor(iSensor,1)-timeTrack))); previous version
    temp_diff = timeTrack-refSensor(iSensor,1);
    if max(temp_diff)<0
        [~, refSensorIdx(iSensor)] = min(temp_diff);
    else
        refSensorIdx(iSensor) = find(temp_diff>=0,1);
    end
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
vSample = filloutliers(vSample,'previous','mean',1); % detect and change outliers
degreeSample = zeros(nPosition,1);

degreeRef = atan(vRef(2)/vRef(1));
for iTheta = 1:nPosition
    degreeSample(iTheta) = atan(vSample(iTheta,2)/vSample(iTheta,1));
    if vSample(iTheta,1)>0 && vSample(iTheta,2)>0
        degreeSample(iTheta) = degreeSample(iTheta);
    elseif vSample(iTheta,1)<0 && vSample(iTheta,2)>0
        degreeSample(iTheta) = degreeSample(iTheta)-pi;
    elseif vSample(iTheta,1)<0 && vSample(iTheta,2)<0
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

%%
addDist = [];
difTime = diff(refSensorIdx);
for i = 1:nCycle-1
    tempDist = ones(difTime(i),1)*2*pi*(i-1);
    addDist = [addDist;tempDist];
end
addDist((end+1):nPosition,1) = 2*pi*(nCycle-1);
thetaDist = (theta+addDist)*radius; % (degree >> cm) absolute distance in (cm)
refPosition = thetaDist(refSensorIdx);

theta2cmLap = [];
for iLap = 1:nCycle-1
    theta2cmLap = theta(refSensorIdx(iLap):(refSensorIdx(iLap+1)-1))*radius;
    numOccuLap(iLap,:) = histc(theta2cmLap,spatialBin);
end
numOccuLap(nCycle,:) = histc((theta(refSensorIdx(end):end)*radius),spatialBin);
numOccuLap = (numOccuLap/30); % devid by video tracking frequency (30Hz)
    
if nCycle == 90
    theta2cmPre = theta(refSensorIdx(1):(refSensorIdx(31)-1))*radius;
    theta2cmStm = theta(refSensorIdx(31):(refSensorIdx(61)-1))*radius;
    theta2cmPost = theta(refSensorIdx(61):end)*radius;
    numOccu(:,1) = histc(theta2cmPre,spatialBin);
    numOccu(:,2) = histc(theta2cmStm,spatialBin);
    numOccu(:,3) = histc(theta2cmPost,spatialBin);
    numOccu = (numOccu/30)'; % devid by video tracking frequency (30Hz)

    theta2cmPRE1 = theta(refSensorIdx(1):(refSensorIdx(16)-1))*radius;
    theta2cmPRE2 = theta(refSensorIdx(16):(refSensorIdx(31)-1))*radius;
    numOccuPRE(:,1) = histc(theta2cmPRE1,spatialBin);
    numOccuPRE(:,2) = histc(theta2cmPRE2,spatialBin);
    numOccuPRE = (numOccuPRE/30)';

    theta2cmPOST1 = theta(refSensorIdx(61):(refSensorIdx(76)-1))*radius;
    theta2cmPOST2 = theta(refSensorIdx(76):end)*radius;
    numOccuPOST(:,1) = histc(theta2cmPOST1,spatialBin);
    numOccuPOST(:,2) = histc(theta2cmPOST2,spatialBin);
    numOccuPOST = (numOccuPOST/30)';
else
    [numOccu, numOccuPRE, numOccuPOST] = deal(NaN);
end