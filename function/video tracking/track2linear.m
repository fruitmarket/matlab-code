function [theta, timeTrack, refPosition, numOccu] = track2linear(vtPositionX, vtPositionY, vtTime, refSensor, timeOnTrack, win)
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
% refSensor should be one sensor from sensor (ex. sensor.S1)
% timeOnTrack should contain two elements [startTime, endTime]
%

binSize = 1; % binSize: 1cm
spatialBin = win(1):binSize:win(2);
narginchk(4,6);
if isempty(vtPositionX);isempty(vtPositionY);isempty(vtTime);isempty(refSensor);isempty(timeOnTrack); return; end;

px2cm = 0.13;
timeTrack = vtTime(timeOnTrack(1)<=vtTime & vtTime<=timeOnTrack(2));
refSensorIdx = zeros(90,1);
for iSensor = 1:90
    [~,refSensorIdx(iSensor)] = (min(abs(refSensor(iSensor)-timeTrack)));
end

posiX = vtPositionX(timeOnTrack(1)<=vtTime & vtTime<=timeOnTrack(2));
posiY = vtPositionY(timeOnTrack(1)<=vtTime & vtTime<=timeOnTrack(2));

posiX = posiX((~isnan(posiX) & ~isnan(posiY)));
posiY = posiY((~isnan(posiX) & ~isnan(posiY)));

centerX = mean(posiX);
centerY = mean(posiY);
radius = mean(sqrt((posiX-centerX).^2+(posiY-centerY).^2));
        

nPosition = length(posiX);

% [newX, newY] = deal(zeros(nPosition,1));
% for iPosi = 1:nPosition
%     coefLine = polyfit([posiX(iPosi),centerX],[posiY(iPosi),centerY],1);
%     [tempX,tempY] = linecirc(coefLine(1,1),coefLine(1,2),centerX,centerY,radius);
%     if abs(tempX(1)-posiX(iPosi))+abs(tempY(1)-posiY(iPosi)) > abs(tempX(2)-posiX(iPosi))+abs(tempY(2)-posiY(iPosi))
%         newX(iPosi,1) = tempX(2);
%         newY(iPosi,1) = tempY(2);
%     else
%         newX(iPosi,1) = tempX(1);
%         newY(iPosi,1) = tempY(1);
%     end
% end
% 
% % make vector (sensor 1 is reference, 0 degree)
% vRef2 = [newX(1)-centerX,newY(1)-centerY];
% vSample2 = [newX-centerX,newY-centerY];
% 
% theta2 = zeros(nPosition,1); % angle between sensor1 to each position
% for iTheta = 1:nPosition
%     theta2(iTheta) = atan2(vSample2(iTheta,2),vSample2(iTheta,1))-atan2(vRef2(2),vRef2(1));
%     if theta2(iTheta,1) < 0
%         theta2(iTheta) = theta2(iTheta)+2*pi;
%     end
% end

vRef = [posiX(1)-centerX,posiY(1)-centerY];
vSample = [posiX-centerX,posiY-centerY];

theta = zeros(nPosition,1); % angle between sensor1 to each position
for iTheta = 1:nPosition
    theta(iTheta) = atan2(vSample(iTheta,2),vSample(iTheta,1))-atan2(vRef(2),vRef(1));
    if theta(iTheta,1) < 0
        theta(iTheta) = theta(iTheta)+2*pi;
    end
end
%%

 theta2cmPre = theta(refSensorIdx(1):(refSensorIdx(31)-1))*radius*px2cm;
 theta2cmStm = theta(refSensorIdx(31):(refSensorIdx(61)-1))*radius*px2cm;
 theta2cmPost = theta(refSensorIdx(61):end)*radius*px2cm;
 numOccu(:,1) = histc(theta2cmPre,spatialBin);
 numOccu(:,2) = histc(theta2cmStm,spatialBin);
 numOccu(:,3) = histc(theta2cmPost,spatialBin);
 numOccu = numOccu/30; % devid by video tracking frequency (30Hz)

realDist = [];
difTime = diff(refSensorIdx);
for i =1:89
    tempDist = ones(difTime(i),1)*2*pi*(i-1);
    realDist = [realDist;tempDist];
end
realDist(end+1:nPosition) = 2*pi*89;
theta = (theta+realDist)*radius*px2cm; % (degree >> cm) absolute distance in (cm)
refPosition = theta(refSensorIdx);
end