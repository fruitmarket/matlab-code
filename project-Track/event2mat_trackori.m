function event2mat_trackori %(filename)
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
sensorITIThreshold = 1000; % sensor intevals shorter than 100ms are usually artifacts.
sensor1 = timeStamp((~cellfun('isempty',regexp(eventString,'S1'))) & cellfun('length',eventString)==2);
sensorOut = [false; (diff(sensor1(:,1)) < sensorITIThreshold)] | (sensor1(:,1) < timeStamp(recStart(2)));
sensor1(sensorOut,:) = [];
sensor.S1 = sensor1;

sensor2 = timeStamp((~cellfun('isempty',regexp(eventString,'S2'))));
sensorOut = [false; (diff(sensor2(:,1)) < sensorITIThreshold)] | (sensor2(:,1) < timeStamp(recStart(2))); 
sensor2(sensorOut,:) = [];
sensor.S2 = sensor2;

sensor3 = timeStamp(~cellfun('isempty',regexp(eventString,'S3')));
sensorOut = [false; (diff(sensor3(:,1)) < sensorITIThreshold)] | (sensor3(:,1) < timeStamp(recStart(2))); 
sensor3(sensorOut,:) = [];
sensor.S3 = sensor3;

sensor4 = timeStamp(~cellfun('isempty',regexp(eventString,'S4')));
sensorOut = [false; (diff(sensor4(:,1)) < sensorITIThreshold)] | (sensor4(:,1) < timeStamp(recStart(2))); 
sensor4(sensorOut,:) = [];
sensor.S4 = sensor4;

sensor5 = timeStamp(~cellfun('isempty',regexp(eventString,'S5')));
sensorOut = [false; (diff(sensor5(:,1)) < sensorITIThreshold)] | (sensor5(:,1) < timeStamp(recStart(2))); 
sensor5(sensorOut,:) = [];
sensor.S5 = sensor5;

sensor6 = timeStamp(~cellfun('isempty',regexp(eventString,'S6')));
sensorOut = [false; (diff(sensor6(:,1)) < sensorITIThreshold)] | (sensor6(:,1) < timeStamp(recStart(2))); 
sensor6(sensorOut,:) = [];
sensor.S6 = sensor6;

sensor7 = timeStamp(~cellfun('isempty',regexp(eventString,'S7')));
sensorOut = [false; (diff(sensor7(:,1)) < sensorITIThreshold)] | (sensor7(:,1) < timeStamp(recStart(2))); 
sensor7(sensorOut,:) = [];
sensor.S7 = sensor7;
    
sensor8 = timeStamp(~cellfun('isempty',regexp(eventString,'S8')));
sensorOut = [false; (diff(sensor8(:,1)) < sensorITIThreshold)] | (sensor8(:,1) < timeStamp(recStart(2))); 
sensor8(sensorOut,:) = [];
sensor.S8 = sensor8;

sensor9 = timeStamp(~cellfun('isempty',regexp(eventString,'S9')));
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

%% Reward time
reward2 = timeStamp(~cellfun('isempty',regexp(eventString,'Reward2')));
reward4 = timeStamp(~cellfun('isempty',regexp(eventString,'Reward4')));

%% Result
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

A = [1,0,0]; B = [0,1,0]; C = [0,0,1];
trialIndex = logical([repmat(A,nTrial/3,1); repmat(B,nTrial/3,1); repmat(C,nTrial/3,1)]);

%%
    switch numel(recStart)
        case 3      % Baseline - Task - Tagging recording
            lightTime.Total = timeStamp(strcmp(eventString,'Light')); % unit: msec
            lightTime.TrackTotal = lightTime.Total(lightTime.Total<=timeStamp(recEnd(2))); % unit: msec
            lightTime.Track8hz = lightTime.Total(lightTime.Total<=timeStamp(recEnd(2))); % unit: msec
            lightTime.Track2hz = [];
            lightTime.PlfmTotal = lightTime.Total(lightTime.Total>=timeStamp(recStart(3))); % unit: msec
            if length(lightTime.PlfmTotal) > 400
                lightTime.PlfmTotal = lightTime.PlfmTotal(end-599:end);
            else
                lightTime.PlfmTotal = lightTime.PlfmTotal(end-299:end);
            end
            lightTime.Plfm2hz = lightTime.PlfmTotal; % unit: msec
            lightTime.Plfm8hz = [];
            preTime = [sensor.(fields{1})(1); sensor.(fields{end})(nTrial/3)]; % unit: msec
            stmTime = [sensor.(fields{1})(nTrial/3+1); sensor.(fields{end})(nTrial*2/3)]; % unit: msec
            postTime = [sensor.(fields{1})(nTrial*2/3+1); sensor.(fields{end})(nTrial)]; % unit: msec
        case 4
            lightTime.Total = timeStamp(strcmp(eventString,'Light')); % unit: msec
            lightTime.TrackTotal = lightTime.Total(lightTime.Total<=timeStamp(recEnd(2))); % unit: msec
            lightTime.Track2hz = []; % unit: msec
            lightTime.Track8hz = lightTime.TrackTotal; % unit: msec
            lightTime.Plfm2hz = lightTime.Total(timeStamp(recStart(3))<lightTime.Total & lightTime.Total<timeStamp(recEnd(3))); % unit: msec
            lightTime.Plfm2hz = lightTime.Plfm2hz(end-599:end);
            lightTime.Plfm8hz = lightTime.Total(timeStamp(recStart(4))<lightTime.Total & lightTime.Total<timeStamp(recEnd(4)));
            lightTime.PlfmTotal = [lightTime.Plfm2hz;lightTime.Plfm8hz]; % unit: msec
            preTime = [sensor.(fields{1})(1); sensor.(fields{end})(nTrial/3)]; % unit: msec
            stmTime = [sensor.(fields{1})(nTrial/3+1); sensor.(fields{end})(nTrial*2/3)]; % unit: msec
            postTime = [sensor.(fields{1})(nTrial*2/3+1); sensor.(fields{end})(nTrial)]; % unit: msec
    end
 
%% Pseudo light generation
eventFile = FindFiles('Events.nev');
[filePath, ~, ~] = fileparts(eventFile{1});
psdlightPre = [];
psdlightPost = [];

if(regexp(filePath,'DRw')) % DRw session
    for iLap = 31:60
        lightLap = lightTime.Track8hz((sensor.S10(iLap)<lightTime.Track8hz & lightTime.Track8hz<sensor.S11(iLap))) - sensor.S10(iLap);              
        temp_psdlightPre = sensor.S10(iLap-30)+lightLap;
        temp_psdlightPre = temp_psdlightPre(temp_psdlightPre<sensor.S11(iLap-30));
        temp_psdlightPost = sensor.S10(iLap+30)+lightLap;
        temp_psdlightPost = temp_psdlightPost(temp_psdlightPost<sensor.S11(iLap+30));
        psdlightPre = [psdlightPre; temp_psdlightPre];
        psdlightPost = [psdlightPost; temp_psdlightPost];        
    end
    
elseif(regexp(filePath,'DRun')); % DRun session
    for iLap = 31:60
        lightLap = lightTime.Track8hz((sensor.S6(iLap)<lightTime.Track8hz & lightTime.Track8hz<sensor.S9(iLap))) - sensor.S6(iLap);                
        temp_psdlightPre = sensor.S6(iLap-30)+lightLap;
        temp_psdlightPre = temp_psdlightPre(temp_psdlightPre<sensor.S9(iLap-30));
        temp_psdlightPost = sensor.S6(iLap+30)+lightLap;
        temp_psdlightPost = temp_psdlightPost(temp_psdlightPost<sensor.S9(iLap+30));
        psdlightPre = [psdlightPre; temp_psdlightPre];
        psdlightPost = [psdlightPost; temp_psdlightPost];        
    end
    
elseif(regexp(filePath,'noRw')); % Nolight session (control session for DRw)
    switch ~isempty(lightTime.Track8hz)
        case 0
            laserDelay = 3+rand(30,1);
            for iLap = 31:60
                tempLighttime = sensor.S10(iLap)+laserDelay(iLap-30)+125*(1:floor((sensor.S11(iLap)-sensor.S10(iLap))/125))';
                lightTime.Track8hz = [lightTime.Track8hz;tempLighttime];
                lightTime.TrackTotal = lightTime.Track8hz;
                lightLap = lightTime.Track8hz((sensor.S10(iLap)<lightTime.Track8hz & lightTime.Track8hz<sensor.S11(iLap))) - sensor.S10(iLap);                
                temp_psdlightPre = sensor.S10(iLap-30)+lightLap;
                temp_psdlightPre = temp_psdlightPre(temp_psdlightPre<sensor.S11(iLap-30));
                temp_psdlightPost = sensor.S10(iLap+30)+lightLap;
                temp_psdlightPost = temp_psdlightPost(temp_psdlightPost<sensor.S11(iLap+30));
                psdlightPre = [psdlightPre; temp_psdlightPre];
                psdlightPost = [psdlightPost; temp_psdlightPost];        
            end
        case 1
            for iLap = 31:60
                lightLap = lightTime.Track8hz((sensor.S10(iLap)<lightTime.Track8hz & lightTime.Track8hz<sensor.S11(iLap))) - sensor.S10(iLap);                
                temp_psdlightPre = sensor.S10(iLap-30)+lightLap;
                temp_psdlightPre = temp_psdlightPre(temp_psdlightPre<sensor.S11(iLap-30));
                temp_psdlightPost = sensor.S10(iLap+30)+lightLap; 
                temp_psdlightPost = temp_psdlightPost(temp_psdlightPost<sensor.S11(iLap+30));
                psdlightPre = [psdlightPre; temp_psdlightPre];
                psdlightPost = [psdlightPost; temp_psdlightPost];        
            end
    end
    
else(regexp(filePath,'noRun')); % Nolight session (control session for DRun)
    switch ~isempty(lightTime.Track8hz)
        case 0
            laserDelay = 3+rand(30,1);
            for iLap = 31:60
                tempLighttime = sensor.S6(iLap)+laserDelay(iLap-30)+125*(1:floor((sensor.S9(iLap)-sensor.S6(iLap))/125))';
                lightTime.Track8hz = [lightTime.Track8hz; tempLighttime];
                lightTime.TrackTotal = lightTime.Track8hz;
                lightLap = lightTime.Track8hz((sensor.S6(iLap)<lightTime.Track8hz & lightTime.Track8hz<sensor.S9(iLap)))-sensor.S6(iLap);
                temp_psdlightPre = sensor.S6(iLap-30)+lightLap;
                temp_psdlightPre = temp_psdlightPre(temp_psdlightPre<sensor.S9(iLap-30));
                temp_psdlightPost = sensor.S6(iLap+30)+lightLap;
                temp_psdlightPost = temp_psdlightPost(temp_psdlightPost<sensor.S9(iLap+30));
                psdlightPre = [psdlightPre; temp_psdlightPre];
                psdlightPost = [psdlightPost; temp_psdlightPost];
            end           
        case 1
            for iLap = 31:60
                lightLap = lightTime.Track8hz((sensor.S6(iLap)<lightTime.Track8hz & lightTime.Track8hz<sensor.S9(iLap)))-sensor.S6(iLap);
                temp_psdlightPre = sensor.S6(iLap-30)+lightLap;
                temp_psdlightPre = temp_psdlightPre(temp_psdlightPre<sensor.S9(iLap-30));
                temp_psdlightPost = sensor.S6(iLap+30)+lightLap;
                temp_psdlightPost = temp_psdlightPost(temp_psdlightPost<sensor.S9(iLap+30));
                psdlightPre = [psdlightPre; temp_psdlightPre];
                psdlightPost = [psdlightPost; temp_psdlightPost];
            end
    end
end
%% Save variables
        save('Events.mat',...
        'baseTime','preTime','stmTime','postTime','taskTime','plfmTime','reward2','reward4',...
        'sensor','fields','nTrial','nSensor','trialIndex','psdlightPre','psdlightPost','lightTime');
    
%% Location calibration
% absolute position
    abso_reward2Posi = [3/6 4/6]*20*pi;
    abso_reward4Posi = [9/6 10/6]*20*pi;
    if(regexp(cellPath,'Run'))
       abso_light = [5/6 8/6]*20*pi;
    else
       abso_light = [9/6 10/6]*20*pi;
    end

% Actual stimulation position
lapStartLightIdx = [1;find(diff(lightTime.Track8hz)>1000)+1];
temp_lightOnLoci = zeros(30,1);
for iIdx = 1:30
    [~, lightOnIdx] = min(abs(lightTime.Track8hz(lapStartLightIdx(iIdx))-taskTime));
    temp_lightOnLoci(iIdx) = theta(lightOnIdx)*20;
end
lightOnLoc = floor(mean(temp_lightOnLoci)*10)/10;
    
lapEndLightIdx = [find(diff(lightTime.Track8hz)>1000);length(lightTime.Track8hz)];
temp_lightOffLoci = zeros(30,1);
for iIdx = 1:30
    [~, lightOffIdx] = min(abs(lightTime.Track8hz(lapEndLightIdx(iIdx))-timeTrack));
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