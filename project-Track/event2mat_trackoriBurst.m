function event2mat_trackoriBurst %(filename)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose: Creating event file
% Writer: Jun (Modified DK's eventmat.m)
% First written: 03/31/2015
% Last modified: 12. 3. 2016

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

% Time bins
recStart = find(strcmp(eventString,'Starting Recording'));
recEnd = find(strcmp(eventString,'Stopping Recording'));

baseTime = timeStamp([recStart(1), recEnd(1)]);
taskTime = timeStamp([recStart(2), recEnd(2)]);
if length(recStart) == 3
    plfmTime.twohz = timeStamp([recStart(3), recEnd(3)]);
end
if length(recStart) == 4
   plfmTime.twohz = timeStamp([recStart(3), recEnd(3)]);
   plfmTime.eighthz = timeStamp([recStart(4), recEnd(4)]); 
end

%% Sensor time

% sensorITICut = 3000; % sensor intevals shorter than 100ms are usually artifacts.
% sensor1 = timeStamp(~cellfun('isempty',regexp(eventString,'S01')));
% sensorOut = [false; (diff(sensor1(:,1)) < sensorITICut)]; 
% sensor1(sensorOut,:) = [];
% sensor(:,1) = sensor1;
% nTrial = length(sensor1);
% 
% sensorLabel = {'S02','S03','S04','S05','S06','S07','S08','S09','S10','S11','S12'};
% 
% for iSensor = 1:11
%     for iLap = 1:nTrial-1
%         tempSensor = timeStamp(~cellfun('isempty',regexp(eventString,sensorLabel(iSensor))));
%         sensor(iLap,iSensor+1) = min(tempSensor(sensor1(iLap)<tempSensor & tempSensor<sensor1(iLap+1)));
%     end
%     sensor(nTrial,iSensor+1) = min(tempSensor(tempSensor>sensor1(end)));
% end
% nTrial = size(sensor,1);

sensorITIThreshold = 1000; % sensor intevals shorter than 100ms are usually artifacts.
sensor1 = timeStamp((~cellfun('isempty',regexp(eventString,'S01'))));
sensorOut = [false; (diff(sensor1(:,1)) < sensorITIThreshold)] | (sensor1(:,1) < timeStamp(recStart(1)));
sensor1(sensorOut,:) = [];
sensor.S1 = sensor1;

sensor2 = timeStamp((~cellfun('isempty',regexp(eventString,'S02'))));
sensorOut = [false; (diff(sensor2(:,1)) < sensorITIThreshold)] | (sensor2(:,1) < timeStamp(recStart(2))); 
sensor2(sensorOut,:) = [];
sensor.S2 = sensor2;

sensor3 = timeStamp(~cellfun('isempty',regexp(eventString,'S03')));
sensorOut = [false; (diff(sensor3(:,1)) < sensorITIThreshold)] | (sensor3(:,1) < timeStamp(recStart(2))); 
sensor3(sensorOut,:) = [];
sensor.S3 = sensor3;

sensor4 = timeStamp(~cellfun('isempty',regexp(eventString,'S04')));
sensorOut = [false; (diff(sensor4(:,1)) < sensorITIThreshold)] | (sensor4(:,1) < timeStamp(recStart(2))); 
sensor4(sensorOut,:) = [];
sensor.S4 = sensor4;

sensor5 = timeStamp(~cellfun('isempty',regexp(eventString,'S05')));
sensorOut = [false; (diff(sensor5(:,1)) < sensorITIThreshold)] | (sensor5(:,1) < timeStamp(recStart(2))); 
sensor5(sensorOut,:) = [];
sensor.S5 = sensor5;

sensor6 = timeStamp(~cellfun('isempty',regexp(eventString,'S06')));
sensorOut = [false; (diff(sensor6(:,1)) < sensorITIThreshold)] | (sensor6(:,1) < timeStamp(recStart(2))); 
sensor6(sensorOut,:) = [];
sensor.S6 = sensor6;

sensor7 = timeStamp(~cellfun('isempty',regexp(eventString,'S07')));
sensorOut = [false; (diff(sensor7(:,1)) < sensorITIThreshold)] | (sensor7(:,1) < timeStamp(recStart(2))); 
sensor7(sensorOut,:) = [];
sensor.S7 = sensor7;
    
sensor8 = timeStamp(~cellfun('isempty',regexp(eventString,'S08')));
sensorOut = [false; (diff(sensor8(:,1)) < sensorITIThreshold)] | (sensor8(:,1) < timeStamp(recStart(2))); 
sensor8(sensorOut,:) = [];
sensor.S8 = sensor8;

sensor9 = timeStamp(~cellfun('isempty',regexp(eventString,'S09')));
sensorOut = [false; (diff(sensor9(:,1)) < sensorITIThreshold)] | (sensor9(:,1) < timeStamp(recStart(2))); 
sensor9(sensorOut,:) = [];
sensor.S9 = sensor9;

sensor10 = timeStamp(~cellfun('isempty',regexp(eventString,'S10')));
sensorOut = [false; (diff(sensor10(:,1)) < sensorITIThreshold)] | (sensor10(:,1) < timeStamp(recStart(2))); 
sensor10(sensorOut,:) = [];
sensor.S10 = sensor10;

sensor11 = timeStamp(~cellfun('isempty',regexp(eventString,'S11')));
sensorOut = [false; (diff(sensor11(:,1)) < sensorITIThreshold)] | (sensor11(:,1) < timeStamp(recStart(2))); 
sensor11(sensorOut,:) = [];
sensor.S11 = sensor11;

sensor12 = timeStamp(~cellfun('isempty',regexp(eventString,'S12')));
sensorOut = [false; (diff(sensor12(:,1)) < sensorITIThreshold)] | (sensor12(:,1) < timeStamp(recStart(2))); 
sensor12(sensorOut,:) = [];
sensor.S12 = sensor12;

fields = fieldnames(sensor);
for iField = 1: numel(fields)
    offSensor(iField) = isempty(sensor.(fields{iField}));
end
sensor = rmfield(sensor,fields(offSensor)); % unit: msec
nSensor = numel(fieldnames(sensor));
fields = fieldnames(sensor);

for iSensor = 2:(nSensor-1) % Sometimes there are sensor check errors. Incorrect sensor check
    if size(sensor.(fields{iSensor}),1) ~= 90;
%         sensor.(fields{iSensor})(1:size(sensor.(fields{iSensor}),1)-90) = [];
        if sensor.(fields{iSensor})(1) - sensor.(fields{iSensor+1})(1) > 0 | sensor.(fields{iSensor-1})(1) - sensor.(fields{iSensor})(1) > 0
            sensor.(fields{iSensor})(1) = [];
        else
            sensor.(fields{iSensor})(91:size(sensor.(fields{iSensor}),1))=[];
        end
    end
end
if size(sensor.S12,1) ~= 90;
    if sensor.S12(1) - sensor.S11(1) < 0
        sensor.S12(1) = [];
    else
        sensor.S12(91:size(sensor.S12,1)) = [];
    end
end
nTrial = size(sensor.(fields{1}),1);

%% Reward time
reward2 = timeStamp(~cellfun('isempty',regexp(eventString,'Reward2')));
reward4 = timeStamp(~cellfun('isempty',regexp(eventString,'Reward4')));

%% Result
A = [1,0,0]; B = [0,1,0]; C = [0,0,1];
trialIndex = logical([repmat(A,nTrial/3,1); repmat(B,nTrial/3,1); repmat(C,nTrial/3,1)]);

%%
    switch numel(recStart)
        case 3 % Baseline - Task - Resp check1
            lightTime.Total = timeStamp(strcmp(eventString,'Light')); % unit: msec
            lightTime.TrackTotal = lightTime.Total(lightTime.Total<=timeStamp(recEnd(2))); % unit: msec
            lightTime.Track50hz = lightTime.Total(lightTime.Total<=timeStamp(recEnd(2))); % unit: msec
            lightTime.Track2hz = [];
            lightTime.PlfmTotal = lightTime.Total(lightTime.Total>=timeStamp(recStart(3))); % unit: msec
            if length(lightTime.PlfmTotal) > 400
                lightTime.PlfmTotal = lightTime.PlfmTotal(end-599:end);
            else % short response check (2hz, 300 light pulse)
                lightTime.PlfmTotal = lightTime.PlfmTotal(end-299:end);
            end
            lightTime.Plfm2hz = lightTime.PlfmTotal; % unit: msec
            lightTime.Plfm50hz = [];
            preTime = [sensor.(fields{1})(1); sensor.(fields{end})(nTrial/3)]; % unit: msec
            stmTime = [sensor.(fields{1})(nTrial/3+1); sensor.(fields{end})(nTrial*2/3)]; % unit: msec
            postTime = [sensor.(fields{1})(nTrial*2/3+1); sensor.(fields{end})(nTrial)]; % unit: msec
        case 4 % Baseline - Task - Resp check1 - Resp check 2
            lightTime.Total = timeStamp(strcmp(eventString,'Light')); % unit: msec
            lightTime.TrackTotal = lightTime.Total(lightTime.Total<=timeStamp(recEnd(2))); % unit: msec
            lightTime.Track2hz = []; % unit: msec
            lightTime.Track50hz = lightTime.TrackTotal; % unit: msec
            lightTime.Plfm2hz = lightTime.Total(timeStamp(recStart(3))<lightTime.Total & lightTime.Total<timeStamp(recEnd(3))); % unit: msec
            lightTime.Plfm50hz = lightTime.Total(timeStamp(recStart(4))<lightTime.Total & lightTime.Total<timeStamp(recEnd(4)));
            lightTime.PlfmTotal = [lightTime.Plfm2hz; lightTime.Plfm50hz]; % unit: msec
            preTime = [sensor.(fields{1})(1); sensor.(fields{end})(nTrial/3)]; % unit: msec
            stmTime = [sensor.(fields{1})(nTrial/3+1); sensor.(fields{end})(nTrial*2/3)]; % unit: msec
            postTime = [sensor.(fields{1})(nTrial*2/3+1); sensor.(fields{end})(nTrial)]; % unit: msec
    end

%% Light time
lightTrack = lightTime.Track50hz;
isi_Track = diff(lightTrack);
nLight_Track = length(lightTrack);
nBurst_Track = sum(double(isi_Track>50))+1;
nTrain_Track = nLight_Track/nBurst_Track;
wPulse_Track = floor(mean(isi_Track(isi_Track<50)))/2;

lightPlfm = lightTime.Plfm50hz;
isi_Plfm = diff(lightPlfm);
nLight_Plfm = length(lightPlfm);
nBurst_Plfm = sum(double(isi_Plfm>50))+1;
nTrain_Plfm = nLight_Plfm/nBurst_Plfm;
wPulse_Plfm = floor(mean(isi_Plfm(isi_Plfm<50)))/2;

%% Pseudo light generation
eventFile = FindFiles('Events.nev');
[filePath, ~, ~] = fileparts(eventFile{1});
psdlightPre = [];
psdlightPost = [];

if(regexp(filePath,'Rw')) % DRw session
    for iLap = 31:60
        lightLap = lightTime.Track50hz((sensor.S10(iLap)<lightTime.Track50hz & lightTime.Track50hz<sensor.S11(iLap))) - sensor.S10(iLap);              
        temp_psdlightPre = sensor.S10(iLap-30)+lightLap;
        temp_psdlightPre = temp_psdlightPre(temp_psdlightPre<sensor.S11(iLap-30));
        temp_psdlightPost = sensor.S10(iLap+30)+lightLap;
        temp_psdlightPost = temp_psdlightPost(temp_psdlightPost<sensor.S11(iLap+30));
        psdlightPre = [psdlightPre; temp_psdlightPre];
        psdlightPost = [psdlightPost; temp_psdlightPost];        
    end
    
elseif(regexp(filePath,'Run')); % DRun session
    for iLap = 31:60
        lightLap = lightTime.Track50hz((sensor.S6(iLap)<lightTime.Track50hz & lightTime.Track50hz<sensor.S9(iLap))) - sensor.S6(iLap);                
        temp_psdlightPre = sensor.S6(iLap-30)+lightLap;
        temp_psdlightPre = temp_psdlightPre(temp_psdlightPre<sensor.S9(iLap-30));
        temp_psdlightPost = sensor.S6(iLap+30)+lightLap;
        temp_psdlightPost = temp_psdlightPost(temp_psdlightPost<sensor.S9(iLap+30));
        psdlightPre = [psdlightPre; temp_psdlightPre];
        psdlightPost = [psdlightPost; temp_psdlightPost];        
    end
    
elseif(regexp(filePath,'noRw')); % Nolight session (control session for DRw)
    switch ~isempty(lightTime.Track50hz)
        case 0
            laserDelay = 3+rand(30,1);
            for iLap = 31:60
                tempLighttime = sensor.S10(iLap)+laserDelay(iLap-30)+20*(1:floor((sensor.S11(iLap)-sensor.S10(iLap))/20))';
                lightTime.Track50hz = [lightTime.Track50hz;tempLighttime];
                lightTime.TrackTotal = lightTime.Track50hz;
                lightLap = lightTime.Track50hz((sensor.S10(iLap)<lightTime.Track50hz & lightTime.Track50hz<sensor.S11(iLap))) - sensor.S10(iLap);                
                temp_psdlightPre = sensor.S10(iLap-30)+lightLap;
                temp_psdlightPre = temp_psdlightPre(temp_psdlightPre<sensor.S11(iLap-30));
                temp_psdlightPost = sensor.S10(iLap+30)+lightLap;
                temp_psdlightPost = temp_psdlightPost(temp_psdlightPost<sensor.S11(iLap+30));
                psdlightPre = [psdlightPre; temp_psdlightPre];
                psdlightPost = [psdlightPost; temp_psdlightPost];        
            end
        case 1
            for iLap = 31:60
                lightLap = lightTime.Track50hz((sensor.S10(iLap)<lightTime.Track50hz & lightTime.Track50hz<sensor.S11(iLap))) - sensor.S10(iLap);                
                temp_psdlightPre = sensor.S10(iLap-30)+lightLap;
                temp_psdlightPre = temp_psdlightPre(temp_psdlightPre<sensor.S11(iLap-30));
                temp_psdlightPost = sensor.S10(iLap+30)+lightLap; 
                temp_psdlightPost = temp_psdlightPost(temp_psdlightPost<sensor.S11(iLap+30));
                psdlightPre = [psdlightPre; temp_psdlightPre];
                psdlightPost = [psdlightPost; temp_psdlightPost];        
            end
    end
    
else(regexp(filePath,'noRun')); % Nolight session (control session for DRun)
    switch ~isempty(lightTime.Track50hz)
        case 0
            laserDelay = 3+rand(30,1);
            for iLap = 31:60
                tempLighttime = sensor.S6(iLap)+laserDelay(iLap-30)+20*(1:floor((sensor.S9(iLap)-sensor.S6(iLap))/20))';
                lightTime.Track50hz = [lightTime.Track50hz; tempLighttime];
                lightTime.TrackTotal = lightTime.Track50hz;
                lightLap = lightTime.Track50hz((sensor.S6(iLap)<lightTime.Track50hz & lightTime.Track50hz<sensor.S9(iLap)))-sensor.S6(iLap);
                temp_psdlightPre = sensor.S6(iLap-30)+lightLap;
                temp_psdlightPre = temp_psdlightPre(temp_psdlightPre<sensor.S9(iLap-30));
                temp_psdlightPost = sensor.S6(iLap+30)+lightLap;
                temp_psdlightPost = temp_psdlightPost(temp_psdlightPost<sensor.S9(iLap+30));
                psdlightPre = [psdlightPre; temp_psdlightPre];
                psdlightPost = [psdlightPost; temp_psdlightPost];
            end           
        case 1
            for iLap = 31:60
                lightLap = lightTime.Track50hz((sensor.S6(iLap)<lightTime.Track50hz & lightTime.Track50hz<sensor.S9(iLap)))-sensor.S6(iLap);
                temp_psdlightPre = sensor.S6(iLap-30)+lightLap;
                temp_psdlightPre = temp_psdlightPre(temp_psdlightPre<sensor.S9(iLap-30));
                temp_psdlightPost = sensor.S6(iLap+30)+lightLap;
                temp_psdlightPost = temp_psdlightPost(temp_psdlightPost<sensor.S9(iLap+30));
                psdlightPre = [psdlightPre; temp_psdlightPre];
                psdlightPost = [psdlightPost; temp_psdlightPost];
            end
    end
end
% Save variables
save('Events.mat',...
    'baseTime','preTime','stmTime','postTime','taskTime','plfmTime','reward2','reward4',...
    'sensor','fields','nTrial','nSensor','trialIndex','psdlightPre','psdlightPost','lightTime',...
    'isi_Track','nLight_Track','nBurst_Track','nTrain_Track','wPulse_Track',...
    'nLight_Plfm','nBurst_Plfm','nTrain_Plfm','wPulse_Plfm');

%% Plfm burst light properties
lightT = lightTime.Plfm50hz;
isi_Plfm = diff(lightT);
ibi_total_Plfm = isi_Plfm(isi_Plfm>50);
ibi_mean_Plfm = mean(isi_Plfm(isi_Plfm>50));
ibi_std_Plfm = std(isi_Plfm(isi_Plfm>50));

nLight_Plfm =length(lightT);
nBurst_Plfm = sum(double(isi_Plfm>50))+1;
nPulse_Plfm = nLight_Plfm/nBurst_Plfm;
wPulse_Plfm = floor(mean(isi_Plfm(isi_Plfm<50)))/2;

save('Events.mat','ibi_total_Plfm','ibi_mean_Plfm','ibi_std_Plfm','nLight_Plfm','nBurst_Plfm','nPulse_Plfm','wPulse_Plfm','-append');

%% Location calibration
[vtTime, vtPosition, ~] = vtLoad;
winLinear = [1,125];
binSizeSpace = 1;
[~, theta, timeTrack, ~, ~, ~] = track2linear(vtPosition{1}(:,1), vtPosition{1}(:,2),vtTime{1},sensor.S1, [sensor.S1(1), sensor.S12(end)],winLinear, binSizeSpace);

% absolute position
    abso_reward2Posi = [3/6 4/6]*20*pi;
    abso_reward4Posi = [9/6 10/6]*20*pi;
    if(regexp(filePath,'Run'))
       abso_light = [5/6 8/6]*20*pi;
    else
       abso_light = [9/6 10/6]*20*pi;
    end

% Actual stimulation position
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

[temp_reward2on, temp_reward2off,temp_reward4on,temp_reward4off] = deal(zeros(90,1));
% Actual reward position
for iReward = 1:90
        [~,reward2on_idx] = min(abs(sensor.S4(iReward)-timeTrack));
        temp_reward2on(iReward) = theta(reward2on_idx)*20;
        [~,reward2off_idx] = min(abs(sensor.S5(iReward)-timeTrack));
        temp_reward2off(iReward) = theta(reward2off_idx)*20;
        [~,reward4on_idx] = min(abs(sensor.S10(iReward)-timeTrack));
        temp_reward4on(iReward) = theta(reward4on_idx)*20;
        [~,reward4off_idx] = min(abs(sensor.S11(iReward)-timeTrack));
        temp_reward4off(iReward) = theta(reward4off_idx)*20;     
end
reward2Loc = [round(mean(temp_reward2on)*10)/10 round(mean(temp_reward2off)*10)/10];
reward4Loc = [round(mean(temp_reward4on)*10)/10 round(mean(temp_reward4off)*10)/10];
rewardLoc = [reward2Loc; reward4Loc];

diff_light = abso_light - lightLoc;
diff_reward2 = abso_reward2Posi - reward2Loc;
diff_reward4 = abso_reward4Posi - reward4Loc;
calib_distance = round(mean([diff_light, diff_reward2, diff_reward4])); % calib_distance is an integer
    
save('Events.mat','lightLoc','rewardLoc','calib_distance','-append');
end
