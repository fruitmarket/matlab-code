function event2mat_trackNovel %(filename)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose: Creating event file
% Writer: Jun
% First written: 03/31/2015
% session: plfm - A - B - A - plfm
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

timeStamp_basePre = timeStamp(recStart(2):recEnd(2));
timeStamp_task = timeStamp(recStart(3):recEnd(3));
timeStamp_basePost = timeStamp(recStart(4):recEnd(4));

eventString_basePre = eventString(recStart(2):recEnd(2));
eventString_task = eventString(recStart(3):recEnd(3));
eventString_basePost = eventString(recStart(4):recEnd(4));
%% Sensor time
sensorITICut = 500; % sensor intevals shorter than 100ms are usually artifacts.
sensorLabel_v1 = {'S01','S02','S03','S04','S05','S06','S07','S08','S09','S10','S11','S12'};
for iSensor = 1:12
    tempSensorPre = timeStamp_basePre(~cellfun('isempty',regexp(eventString_basePre,sensorLabel_v1(iSensor))));
    sensorOut = [false; (diff(tempSensorPre(:,1)) < sensorITICut)];
    tempSensorPre(sensorOut,:) = [];
    sensor_basePre(:,iSensor) = tempSensorPre;
    tempSensorPost = timeStamp_basePost(~cellfun('isempty',regexp(eventString_basePost,sensorLabel_v1(iSensor))));
    sensorOut = [false; (diff(tempSensorPost(:,1)) < sensorITICut)];
    tempSensorPost(sensorOut,:) = [];
    sensor_basePost(:,iSensor) = tempSensorPost;
end

sensorITICut = 4000;
sensorLabel = {'S02','S03','S04','S05','S06','S07','S08','S09','S10','S11','S12'};
sensor_task = timeStamp_task(~cellfun('isempty',regexp(eventString_task,'S01')));

%%
sensorOut = [false; (diff(sensor_task(:,1)) < sensorITICut)]; 
sensor_task(sensorOut,:) = [];
nTaskTrial = length(sensor_task);
for iSensor = 1:11
    for iLap = 1:nTaskTrial-1
        tempSensor = timeStamp_task(~cellfun('isempty',regexp(eventString_task,sensorLabel(iSensor))));
        sensor_task(iLap,iSensor+1) = min(tempSensor(sensor_task(iLap,iSensor)<tempSensor & tempSensor<sensor_task(iLap+1,1)));
    end
    sensor_task(nTaskTrial,iSensor+1) = min(tempSensor(tempSensor>sensor_task(90,iSensor)));
end
if size(sensor_task,1)>90
    sensor_task = sensor_task(1:90,:);
end
sensor = [sensor_basePre; sensor_task; sensor_basePost];
nTrial = size(sensor,1);

%% Light time
lightTime_all = timeStamp(strcmp(eventString,'Light'));
lightTime = [];
for iLap = 1:30
    temp_lightTime = lightTime_all(sensor(60+iLap,5) <= lightTime_all & lightTime_all <= sensor(60+iLap,10)); % 10 just be sure
    lightTime = [lightTime; temp_lightTime];
end

isi = diff(lightTime);
nLight = length(lightTime);
nBurst = sum(double(isi>50))+1;
nTrain = nLight/nBurst;
wPulse = floor(mean(isi(isi<50)))/2;

%% Time (plfm, task)
A = [1,0,0,0,0]; B = [0,1,0,0,0]; C = [0,0,1,0,0]; D = [0,0,0,1,0]; E = [0,0,0,0,1];
trialIndex = logical([repmat(A,nTrial/5,1); repmat(B,nTrial/5,1); repmat(C,nTrial/5,1); repmat(D,nTrial/5,1); repmat(E,nTrial/5,1)]);

timePlfmPre = timeStamp([recStart(1), recEnd(1)]);
timeBasePre = [sensor(1,1), sensor(30,12)];
timePre = [sensor(31,1), sensor(60,12)];
timeStim = [sensor(61,1), sensor(90,12)];
timePost = [sensor(91,1), sensor(120,12)];
timeTask = [sensor(31,1), sensor(120,12)];
timeBasePost = [sensor(121,1), sensor(end)];
timePlfmPost = timeStamp([recStart(end), recEnd(end)]);

timeBlock = round([diff(timeBasePre), diff(timePre), diff(timeStim), diff(timePost), diff(timeBasePost)]/(1000*60)*100)/100; % unit: min
%% Pseudo light generation
eventFile = FindFiles('Events.nev');
[filePath, ~, ~] = fileparts(eventFile{1});
psdlightBasePre = [];
psdlightBasePost = [];
psdlightPre = [];
psdlightPost = [];

for iLap = 61:90 % BasePre - Pre - Stim - Post - BasePost
    lightLap = lightTime((sensor(iLap,6)<lightTime & lightTime<sensor(iLap,9))) - sensor(iLap,6);                
    
    temp_psdlightBasePre = sensor(iLap-60,6)+lightLap;
    temp_psdlightBasePre = temp_psdlightBasePre(temp_psdlightBasePre<sensor(iLap-60,9));
    psdlightBasePre = [psdlightBasePre; temp_psdlightBasePre];    
    
    temp_psdlightBasePost = sensor(iLap+60,6)+lightLap;
    temp_psdlightBasePost = temp_psdlightBasePost(temp_psdlightBasePost<sensor(iLap+60,9));
    psdlightBasePost = [psdlightBasePost; temp_psdlightBasePost];
    
    temp_psdlightPre = sensor(iLap-30,6)+lightLap;
    temp_psdlightPre = temp_psdlightPre(temp_psdlightPre<sensor(iLap-30,9));
    psdlightPre = [psdlightPre; temp_psdlightPre];
    
    temp_psdlightPost = sensor(iLap+30,6)+lightLap;
    temp_psdlightPost = temp_psdlightPost(temp_psdlightPost<sensor(iLap+30,9));
    psdlightPost = [psdlightPost; temp_psdlightPost];
end

% if (regexp(filePath,'noRun')) % Nolight session (control session for DRun)
%     for iLap = 61:90
%         lightLap = lightTime.track((sensor(6,iLap)<lightTime.track & lightTime.track<sensor(9,iLap))) - sensor(6,iLap);                
%         temp_psdlightBasePre = sensor(6,iLap-30)+lightLap;
%         temp_psdlightBasePre = temp_psdlightBasePre(temp_psdlightBasePre<sensor(9,iLap-30));
%         temp_psdlightBasePost = sensor(6,iLap+30)+lightLap;
%         temp_psdlightBasePost = temp_psdlightBasePost(temp_psdlightBasePost<sensor(9,iLap+30));
%         temp_psdlightPre = sensor(6,iLap-60)+lightLap;
%         temp_psdlightPre = temp_psdlightPre(temp_psdlightPre<sensor(9,iLap-60));
%         temp_psdlightPost = sensor(6,iLap+60)+lightLap;
%         temp_psdlightPost = temp_psdlightPost(temp_psdlightPost<sensor(9,iLap+60));
%         psdlightBasePre = [psdlightBasePre; temp_psdlightBasePre];
%         psdlightBasePost = [psdlightBasePost; temp_psdlightBasePost];
%         psdlightPre = [psdlightPre; temp_psdlightPre];
%         psdlightPost = [psdlightPost; temp_psdlightPost];
%     end
% end

%% Save variables
save('Events.mat','sensor','nTrial','lightTime','trialIndex',...
    'nLight','nBurst','nTrain','wPulse',...
    'timePlfmPre','timeBasePre','timePre','timeStim','timePost','timeTask','timeBasePost','timePlfmPost','timeBlock',...
    'psdlightBasePre','psdlightBasePost','psdlightPre','psdlightPost');

%% Location calibration
% absolute position
radius = 20;
abso_reward2Posi = [3/6 4/6]*radius*pi;
abso_reward4Posi = [9/6 10/6]*radius*pi;
abso_light = [5/6 8/6]*radius*pi;

% Actual stimulation position
% lapStartLightIdx = [1;find(diff(lightTime)>1000)+1]; % longer than 1s = next lap
lapStartLightIdx = [];
for iLap = 1:30
    temp_idx = find(lightTime > sensor(60+iLap,6),1,'first');
    lapStartLightIdx = [lapStartLightIdx, temp_idx];
end

% light stimulation position
[vtTime, vtPosition, ~] = vtLoad;
winLinear = [1,125];
binSizeSpace = 1;
[~, theta, timeTrack, ~, ~, ~] = track2linear(vtPosition{1}(:,1), vtPosition{1}(:,2),vtTime{1},sensor(31:120,1), timeTask, winLinear, binSizeSpace);

temp_lightOnLoci = zeros(30,1);
for iIdx = 1:30
    [~, lightOnIdx] = min(abs(lightTime(lapStartLightIdx(iIdx))-timeTrack));
    temp_lightOnLoci(iIdx) = theta(lightOnIdx)*radius;
end
lightOnLoc = floor(mean(temp_lightOnLoci)*10)/10;
    
lapEndLightIdx = [lapStartLightIdx(2:end)-1,length(lightTime)];
temp_lightOffLoci = zeros(30,1);

for iIdx = 1:30
    [~, lightOffIdx] = min(abs(lightTime(lapEndLightIdx(iIdx))-timeTrack));
    temp_lightOffLoci(iIdx) = theta(lightOffIdx)*radius;
end
lightOffLoc = ceil(mean(temp_lightOffLoci)*10)/10;
lightLoc = [lightOnLoc, lightOffLoc];

%% Reward location
[~, thetaBasePre, timeTrackBasePre, ~, ~, ~] = track2linear(vtPosition{1}(:,1), vtPosition{1}(:,2), vtTime{1}, sensor(1:30,1), timeBasePre, winLinear, binSizeSpace);
[~, thetaBasePost, timeTrackBasePost, ~, ~, ~] = track2linear(vtPosition{1}(:,1), vtPosition{1}(:,2), vtTime{1}, sensor(121:150,1), timeBasePost, winLinear, binSizeSpace);

%% Light stimulation location
lightPosi = [];
for iLight = 1:nLight
    tempIdx = find(lightTime(iLight)-timeTrack<0,1,'first');
    lightPosi = [lightPosi; theta(tempIdx)];
end

%% Calib_main
[temp_reward2on, temp_reward2off, temp_reward4on, temp_reward4off] = deal(zeros(90,1));
% Actual reward position
for iReward = 1:90
    [~,reward2on_idxTask] = min(abs(sensor(iReward+30,4)-timeTrack));
    temp_reward2on(iReward) = theta(reward2on_idxTask)*radius;
    [~,reward2off_idxTask] = min(abs(sensor(iReward+30,5)-timeTrack));
    temp_reward2off(iReward) = theta(reward2off_idxTask)*radius;
    [~,reward4on_idxTask] = min(abs(sensor(iReward+30,10)-timeTrack));
    temp_reward4on(iReward) = theta(reward4on_idxTask)*radius;
    [~,reward4off_idxTask] = min(abs(sensor(iReward+30,11)-timeTrack));
    temp_reward4off(iReward) = theta(reward4off_idxTask)*radius;     
end
reward2Loc = [round(mean(temp_reward2on)*10)/10 round(mean(temp_reward2off)*10)/10];
reward4Loc = [round(mean(temp_reward4on)*10)/10 round(mean(temp_reward4off)*10)/10];
reLoc = [reward2Loc; reward4Loc];

diff_light = abso_light - lightLoc;
diff_reward2 = abso_reward2Posi - reward2Loc;
diff_reward4 = abso_reward4Posi - reward4Loc;
% calibTask = round(mean([diff_light, diff_reward2, diff_reward4])); % calib_distance is an integer
calibTask = round(mean(diff_light)); % calib_distance is an integer
save('Events.mat','lightLoc','reLoc','calibTask','-append');

%% Calib_basePRE
[tempPre_reward2on, tempPre_reward2off,tempPre_reward4on,tempPre_reward4off] = deal(zeros(30,1));
for iReward = 1:30
    [~,reward2on_idxBPre] = min(abs(sensor(iReward,4)-timeTrackBasePre));
    tempPre_reward2on(iReward) = thetaBasePre(reward2on_idxBPre)*radius;
    [~,reward2off_idxBPre] = min(abs(sensor(iReward,5)-timeTrackBasePre));
    tempPre_reward2off(iReward) = thetaBasePre(reward2off_idxBPre)*radius;
    [~,reward4on_idxBPre] = min(abs(sensor(iReward,10)-timeTrackBasePre));
    tempPre_reward4on(iReward) = thetaBasePre(reward4on_idxBPre)*radius;
    [~,reward4off_idxBPre] = min(abs(sensor(iReward,11)-timeTrackBasePre));
    tempPre_reward4off(iReward) = thetaBasePre(reward4off_idxBPre)*radius;  
end
reward2LocPre = [round(mean(tempPre_reward2on)*10)/10 round(mean(tempPre_reward2off)*10)/10];
reward4LocPre = [round(mean(tempPre_reward4on)*10)/10 round(mean(tempPre_reward4off)*10)/10];
reLocBasePre = [reward2LocPre; reward4LocPre];
% calibBasePre = round(mean([abso_reward2Posi-reward2LocPre,abso_reward4Posi-reward4LocPre]));
calibBasePre = round(mean(mean(reLoc - reLocBasePre)))+calibTask;
save('Events.mat','reLocBasePre','calibBasePre','-append');

%% Calib_basePost
[tempPost_reward2on, tempPost_reward2off, tempPost_reward4on, tempPost_reward4off] = deal(zeros(30,1));
for iReward = 1:30
    [~,reward2on_idxBPost] = min(abs(sensor(iReward+120,4)-timeTrackBasePost));
    tempPost_reward2on(iReward) = thetaBasePost(reward2on_idxBPost)*radius;
    [~,reward2off_idxBPost] = min(abs(sensor(iReward+120,5)-timeTrackBasePost));
    tempPost_reward2off(iReward) = thetaBasePost(reward2off_idxBPost)*radius;
    [~,reward4on_idxBPost] = min(abs(sensor(iReward+120,10)-timeTrackBasePost));
    tempPost_reward4on(iReward) = thetaBasePost(reward4on_idxBPost)*radius;
    [~,reward4off_idxBPost] = min(abs(sensor(iReward+120,11)-timeTrackBasePost));
    tempPost_reward4off(iReward) = thetaBasePost(reward4off_idxBPost)*radius;  
end
reward2LocPost = [round(mean(tempPost_reward2on)*10)/10 round(mean(tempPost_reward2off)*10)/10];
reward4LocPost = [round(mean(tempPost_reward4on)*10)/10 round(mean(tempPost_reward4off)*10)/10];
reLocBasePost = [reward2LocPost; reward4LocPost];
% calibBasePost = round(mean([abso_reward2Posi-reward2LocPost,abso_reward4Posi-reward4LocPost]));
calibBasePost = round(mean(mean(reLoc - reLocBasePost)))+calibTask;
save('Events.mat','reLocBasePost','calibBasePost','-append');
end