function event2mat_trackFamiliar %(filename)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose: Creating event file
% Writer: Jun
% session: plfm - A - plfm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%     [timeStamp, eventStrings] = Nlx2MatEV('Events.nev', [1 0 0 0 1], 0, 1, []);
%     timeStamp = timeStamp'/1000; % unit: ms
if exist('Events.xlsx','file')
    [timeStamp,eventString,~] = xlsread('Events.xlsx');
else
    [eData, eList] = eLoad; % Unit: msec
    timeStamp = eData.t;
    eventString = eData.s;
end
recStart = find(strcmp(eventString,'Starting Recording'));
recEnd = find(strcmp(eventString,'Stopping Recording'));

timeStamp_task = timeStamp(recStart(2):recEnd(2));
eventString_task = eventString(recStart(2):recEnd(2));

%% Sensor time
sensorITICut = 100; % sensor intevals shorter than 100ms are usually artifacts.
sensorLabel = {'S02','S03','S04','S05','S06','S07','S08','S09','S10','S11','S12'};
sensor = timeStamp_task(~cellfun('isempty',regexp(eventString_task,'S01')));
sensorOut = [false; (diff(sensor(:,1)) < sensorITICut)]; 
sensor(sensorOut,:) = [];
nTaskTrial = length(sensor);
for iSensor = 1:11
    for iLap = 1:nTaskTrial-1
        tempSensor = timeStamp_task(~cellfun('isempty',regexp(eventString_task,sensorLabel(iSensor))));
        sensor(iLap,iSensor+1) = min(tempSensor(sensor(iLap,iSensor)<tempSensor & tempSensor<sensor(iLap+1,1)));
    end
    sensor(nTaskTrial,iSensor+1) = min(tempSensor(tempSensor>sensor(90,iSensor)));
end
if size(sensor,1)>90
    sensor = sensor(1:90,:);
end
nTrial = size(sensor,1);

%% Light time
lightTime_all = timeStamp(strcmp(eventString,'Light'));
lightTime.Plfm2hz = lightTime_all(timeStamp(recStart(3))<lightTime_all & lightTime_all<timeStamp(recEnd(3)));
lightTime.Plfm50hz = lightTime_all(timeStamp(recStart(4))<lightTime_all & lightTime_all<timeStamp(recEnd(4)));
lightTime_track = [];
for iLap = 1:30
    temp_lightTime = lightTime_all(sensor(30+iLap,5) <= lightTime_all & lightTime_all <= sensor(30+iLap,10)); % 10 just be sure
    lightTime_track = [lightTime_track; temp_lightTime];
end
lightTime.Track = lightTime_track;
isi_Track = diff(lightTime_track);
nLight_Track = length(lightTime_track);
nBurst_Track = sum(double(isi_Track>50))+1;
nTrain_Track = nLight_Track/nBurst_Track;
wPulse_Track = floor(mean(isi_Track(isi_Track<50)))/2;

isi_Plfm = diff(lightTime.Plfm50hz);
nLight_Plfm = length(lightTime.Plfm50hz);
nBurst_Plfm = sum(double(isi_Plfm>50))+1;
nTrain_Plfm = nLight_Plfm/nBurst_Plfm;
wPulse_Plfm = floor(mean(isi_Plfm(isi_Plfm<50)))/2;

%% Time (plfm, task)
A = [1,0,0]; B = [0,1,0]; C = [0,0,1];
trialIndex = logical([repmat(A,nTrial/3,1); repmat(B,nTrial/3,1); repmat(C,nTrial/3,1)]);

timePlfmPre = timeStamp([recStart(1), recEnd(1)]);
timePre = [sensor(1,1), sensor(30,12)];
timeStim = [sensor(31,1), sensor(60,12)];
timePost = [sensor(61,1), sensor(90,12)];
timeTask = [sensor(1,1), sensor(90,12)];
timePlfmPost = timeStamp([recStart(end), recEnd(end)]);

timeBlock = round([diff(timePre), diff(timeStim), diff(timePost)]/(1000*60)*100)/100; % unit: min
%% Pseudo light generation
psdlightPre = [];
psdlightPost = [];

for iLap = 31:60 % Pre - Stim - Post
    lightLap = lightTime_track((sensor(iLap,6)<lightTime_track & lightTime_track<sensor(iLap,9))) - sensor(iLap,6);                
       
    temp_psdlightPre = sensor(iLap-30,6)+lightLap;
    temp_psdlightPre = temp_psdlightPre(temp_psdlightPre<sensor(iLap-30,9));
    psdlightPre = [psdlightPre; temp_psdlightPre];
    
    temp_psdlightPost = sensor(iLap+30,6)+lightLap;
    temp_psdlightPost = temp_psdlightPost(temp_psdlightPost<sensor(iLap+30,9));
    psdlightPost = [psdlightPost; temp_psdlightPost];
end

%% Save variables
save('Events.mat','sensor','nTrial','lightTime','trialIndex',...
    'nLight_Track','nBurst_Track','nTrain_Track','wPulse_Track',...
    'timePlfmPre','timePre','timeStim','timePost','timeTask','timePlfmPost','timeBlock',...
    'nLight_Track','nBurst_Track','nTrain_Track','wPulse_Track','nLight_Plfm','nBurst_Plfm','nTrain_Plfm','wPulse_Plfm',...
    'psdlightPre','psdlightPost');

%% Location calibration
% absolute position
radius = 20;
abso_reward2Posi = [3/6 4/6]*radius*pi;
abso_reward4Posi = [9/6 10/6]*radius*pi;

abso_light = [5/6 8/6]*radius*pi;

% lapStartLightIdx = [1;find(diff(lightTime)>1000)+1]; % longer than 1s = next lap
lapStartLightIdx = [];
for iLap = 1:30
    temp_idx = find(lightTime_track > sensor(30+iLap,6),1,'first');
    lapStartLightIdx = [lapStartLightIdx, temp_idx];
end

% light stimulation position
[vtTime, vtPosition, ~] = vtLoad;
winLinear = [1,125];
binSizeSpace = 1;
[~, theta, timeTrack, ~, ~, ~] = track2linear(vtPosition{1}(:,1), vtPosition{1}(:,2),vtTime{1},sensor(1:90,1), timeTask, winLinear, binSizeSpace);

temp_lightOnLoci = zeros(30,1);
for iIdx = 1:30
    [~, lightOnIdx] = min(abs(lightTime_track(lapStartLightIdx(iIdx))-timeTrack));
    temp_lightOnLoci(iIdx) = theta(lightOnIdx)*radius;
end
lightOnLoc = floor(mean(temp_lightOnLoci)*10)/10;
    
lapEndLightIdx = [lapStartLightIdx(2:end)-1,length(lightTime_track)];
temp_lightOffLoci = zeros(30,1);

for iIdx = 1:30
    [~, lightOffIdx] = min(abs(lightTime_track(lapEndLightIdx(iIdx))-timeTrack));
    temp_lightOffLoci(iIdx) = theta(lightOffIdx)*radius;
end
lightOffLoc = ceil(mean(temp_lightOffLoci)*10)/10;
lightLoc = [lightOnLoc, lightOffLoc];

%% Light stimulation location
lightPosi = [];
for iLight = 1:nLight_Track
    tempIdx = find(lightTime_track(iLight)-timeTrack<0,1,'first');
    lightPosi = [lightPosi; theta(tempIdx)];
end

%% Calib_main
[temp_reward2on, temp_reward2off, temp_reward4on, temp_reward4off] = deal(zeros(90,1));
% Actual reward position
for iReward = 1:90
    [~,reward2on_idxTask] = min(abs(sensor(iReward,4)-timeTrack));
    temp_reward2on(iReward) = theta(reward2on_idxTask)*radius;
    [~,reward2off_idxTask] = min(abs(sensor(iReward,5)-timeTrack));
    temp_reward2off(iReward) = theta(reward2off_idxTask)*radius;
    [~,reward4on_idxTask] = min(abs(sensor(iReward,10)-timeTrack));
    temp_reward4on(iReward) = theta(reward4on_idxTask)*radius;
    [~,reward4off_idxTask] = min(abs(sensor(iReward,11)-timeTrack));
    temp_reward4off(iReward) = theta(reward4off_idxTask)*radius;     
end
reward2Loc = [round(mean(temp_reward2on)*10)/10 round(mean(temp_reward2off)*10)/10];
reward4Loc = [round(mean(temp_reward4on)*10)/10 round(mean(temp_reward4off)*10)/10];
reLoc = [reward2Loc; reward4Loc];

diff_light = abso_light - lightLoc;
diff_reward2 = abso_reward2Posi - reward2Loc;
diff_reward4 = abso_reward4Posi - reward4Loc;
% calibTask = round(mean([diff_light, diff_reward2, diff_reward4])); % calib_distance is an integer / original
calibTask = round(mean(diff_light));
save('Events.mat','lightLoc','reLoc','calibTask','-append');

end