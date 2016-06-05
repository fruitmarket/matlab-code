function event2mat%(filename)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose: Creating event file
% Writer: Jun (Modified DK's eventmat.m)
% First written: 03/31/2015
% Last modified: 11. 22. 2015

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
    [timeStamp, eventStrings] = Nlx2MatEV('Events.nev', [1 0 0 0 1], 0, 1, []);
    timeStamp = timeStamp'/1000; % unit: ms
    
    % Time bins
    recStart = find(strcmp(eventStrings,'Starting Recording'));
    recEnd = find(strcmp(eventStrings,'Stopping Recording'));
    
    baseTime = timeStamp([recStart(1), recEnd(1)]);
    taskTime = timeStamp([recStart(2), recEnd(2)]);
    if length(recStart) == 3
        tagTime = timeStamp([recStart(3), recEnd(3)]);
    end

%% Sensor time
sensorITIThreshold = 50; % sensor intevals shorter than 50ms are usually artifacts.
sensor1 = timeStamp((~cellfun('isempty',regexp(eventStrings,'S1'))) & cellfun('length',eventStrings)==2);
sensorOut = [false; (diff(sensor1(:,1)) < sensorITIThreshold)] | (sensor1(:,1) < timeStamp(recStart(2)));
sensor1(sensorOut,:) = [];
sensor.S1 = sensor1;

sensor2 = timeStamp((~cellfun('isempty',regexp(eventStrings,'S2'))));
sensorOut = [false; (diff(sensor2(:,1)) < sensorITIThreshold)] | (sensor2(:,1) < timeStamp(recStart(2))); 
sensor2(sensorOut,:) = [];
sensor.S2 = sensor2;

sensor3 = timeStamp(~cellfun('isempty',regexp(eventStrings,'S3')));
sensorOut = [false; (diff(sensor3(:,1)) < sensorITIThreshold)] | (sensor3(:,1) < timeStamp(recStart(2))); 
sensor3(sensorOut,:) = [];
sensor.S3 = sensor3;

sensor4 = timeStamp(~cellfun('isempty',regexp(eventStrings,'S4')));
sensorOut = [false; (diff(sensor4(:,1)) < sensorITIThreshold)] | (sensor4(:,1) < timeStamp(recStart(2))); 
sensor4(sensorOut,:) = [];
sensor.S4 = sensor4;

sensor5 = timeStamp(~cellfun('isempty',regexp(eventStrings,'S5')));
sensorOut = [false; (diff(sensor5(:,1)) < sensorITIThreshold)] | (sensor5(:,1) < timeStamp(recStart(2))); 
sensor5(sensorOut,:) = [];
sensor.S5 = sensor5;

sensor6 = timeStamp(~cellfun('isempty',regexp(eventStrings,'S6')));
sensorOut = [false; (diff(sensor6(:,1)) < sensorITIThreshold)] | (sensor6(:,1) < timeStamp(recStart(2))); 
sensor6(sensorOut,:) = [];
sensor.S6 = sensor6;

sensor7 = timeStamp(~cellfun('isempty',regexp(eventStrings,'S7')));
sensorOut = [false; (diff(sensor7(:,1)) < sensorITIThreshold)] | (sensor7(:,1) < timeStamp(recStart(2))); 
sensor7(sensorOut,:) = [];
sensor.S7 = sensor7;
    
sensor8 = timeStamp(~cellfun('isempty',regexp(eventStrings,'S8')));
sensorOut = [false; (diff(sensor8(:,1)) < sensorITIThreshold)] | (sensor8(:,1) < timeStamp(recStart(2))); 
sensor8(sensorOut,:) = [];
sensor.S8 = sensor8;

sensor9 = timeStamp(~cellfun('isempty',regexp(eventStrings,'S9')));
sensorOut = [false; (diff(sensor9(:,1)) < sensorITIThreshold)] | (sensor9(:,1) < timeStamp(recStart(2))); 
sensor9(sensorOut,:) = [];
sensor.S9 = sensor9;

sensor10 = timeStamp(~cellfun('isempty',regexp(eventStrings,'S10')));
sensorOut = [false; (diff(sensor10(:,1)) < sensorITIThreshold)] | (sensor10(:,1) < timeStamp(recStart(2))); 
sensor10(sensorOut,:) = [];
sensor.S10 = sensor10;

sensor11 = timeStamp(~cellfun('isempty',regexp(eventStrings,'S11')));
sensorOut = [false; (diff(sensor11(:,1)) < sensorITIThreshold)] | (sensor11(:,1) < timeStamp(recStart(2))); 
sensor11(sensorOut,:) = [];
sensor.S11 = sensor11;

sensor12 = timeStamp(~cellfun('isempty',regexp(eventStrings,'S12')));
sensorOut = [false; (diff(sensor12(:,1)) < sensorITIThreshold)] | (sensor12(:,1) < timeStamp(recStart(2))); 
sensor12(sensorOut,:) = [];
sensor.S12 = sensor12;

%% Result
fields = fieldnames(sensor);
for iField = 1: numel(fields)
    offSensor(iField) = isempty(sensor.(fields{iField}));
end
sensor = rmfield(sensor,fields(offSensor)); % unit: msec
nSensor = numel(fieldnames(sensor));
fields = fieldnames(sensor);

for iSensor = 1:nSensor % Sometimes there are sensor check errors. Incorrect sensor check
    if size(sensor.(fields{iSensor}),1) ~= 90;
        sensor.(fields{iSensor})(1:size(sensor.(fields{iSensor}),1)-90) = [];
    end
end
nTrial = size(sensor.(fields{1}),1);

A = [1,0,0]; B = [0,1,0]; C = [0,0,1];
trialIndex = logical([repmat(A,nTrial/3,1); repmat(B,nTrial/3,1); repmat(C,nTrial/3,1)]);

%%
    switch numel(recStart)
        case 1      % Baseline recording only
            lightTime.Total = timeStamp(strcmp(eventStrings,'Light'))';           
            
        case 2      % Baseline - Task recording
            lightTime.Total = timeStamp(strcmp(eventStrings,'Light'));
            lightTime.Modu = lightTime.Total(lightTime.Total<=timeStamp(recEnd(2)));
            preTime = [sensor.(fields{1})(1); sensor.(fields{end})(nTrial/3)]; % unit: msec
            stmTime = [sensor.(fields{1})(nTrial/3+1); sensor.(fields{end})(nTrial*2/3)]; % unit: msec
            postTime = [sensor.(fields{1})(nTrial*2/3+1); sensor.(fields{end})(nTrial)]; % unit: msec
            
        case 3      % Baseline - Task - Tagging recording
            lightTime.Total = timeStamp(strcmp(eventStrings,'Light')); % unit: msec
            lightTime.Modu = lightTime.Total(lightTime.Total<=timeStamp(recEnd(2))); % unit: msec
            lightTime.Tag = lightTime.Total(lightTime.Total>=timeStamp(recStart(3))); % unit: msec
            preTime = [sensor.(fields{1})(1); sensor.(fields{end})(nTrial/3)]; % unit: msec
            stmTime = [sensor.(fields{1})(nTrial/3+1); sensor.(fields{end})(nTrial*2/3)]; % unit: msec
            postTime = [sensor.(fields{1})(nTrial*2/3+1); sensor.(fields{end})(nTrial)]; % unit: msec
    end
 
    if exist('tagTime','var');
        save('Events.mat',...
        'baseTime','preTime','stmTime','postTime','taskTime','tagTime',...
        'sensor','fields',...
        'nTrial','nSensor','trialIndex',...
        'lightTime');
    else
        save('Events.mat',...
        'baseTime','preTime','stmTime','postTime','taskTime',...
        'sensor','fields',...
        'nTrial','nSensor','trialIndex',...
        'lightTime');
    end
end