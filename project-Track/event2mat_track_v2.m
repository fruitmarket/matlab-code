function event2mat_track %(filename)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose: Creating event file
% Writer: Jun (Modified DK's eventmat.m)
% First written: 03/31/2015
% Last modified: 7. 25. 2016

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%     [timeStamp, eventStrings] = Nlx2MatEV('Events.nev', [1 0 0 0 1], 0, 1, []);
%     timeStamp = timeStamp'/1000; % unit: ms
    [eData, eList] = eLoad; % Unit: msec
    timeStamp = eData.t;
    eventString = eData.s;
    
    % Time bins
    recStart = find(strcmp(eventString,'Starting Recording'));
    recEnd = find(strcmp(eventString,'Stopping Recording'));
    
    baseTime = timeStamp([recStart(1), recEnd(1)]);
    taskTime = timeStamp([recStart(2), recEnd(2)]);
    plfm2hz = timeStamp([recStart(3), recEnd(3)]);
    if length(recStart) == 4
        plfm8hz = timeStamp([recStart(4), recEnd(4)]);
    end

%% Sensor time
sensorITIThreshold = 30; % sensor intevals shorter than 50ms are usually artifacts.
sensor1 = timeStamp((~cellfun('isempty',regexp(eventString,'S1'))) & cellfun('length',eventString)==2);
sensorOut = [false; (diff(sensor1(:,1)) < sensorITIThreshold)] | (sensor1(:,1) < timeStamp(recStart(1)));
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

%% Sensor result
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
            lightTime.Total = timeStamp(strcmp(eventString,'Light'))';           
            
        case 2      % Baseline - Task recording
            lightTime.Total = timeStamp(strcmp(eventString,'Light'));
            lightTime.Modu = lightTime.Total(lightTime.Total<=timeStamp(recEnd(2)));
            preTime = [sensor.(fields{1})(1); sensor.(fields{end})(nTrial/3)]; % unit: msec
            stmTime = [sensor.(fields{1})(nTrial/3+1); sensor.(fields{end})(nTrial*2/3)]; % unit: msec
            postTime = [sensor.(fields{1})(nTrial*2/3+1); sensor.(fields{end})(nTrial)]; % unit: msec
            
        case 3      % Baseline - Task - Tagging recording
            lightTime.Total = timeStamp(strcmp(eventString,'Light')); % unit: msec
            lightTime.TrackTotal = lightTime.Total(lightTime.Total<=timeStamp(recEnd(2))); % unit: msec
            lightTime.Track8hz = lightTime.Total(lightTime.Total<=timeStamp(recEnd(2))); % unit: msec
            lightTime.PlfmTotal = lightTime.Total(timeStamp(recStart(3))<lightTime.Total & lightTime.Total<timeStamp(recEnd(3))); % unit: msec
            lightTime.Plfm2hz = lightTime.Total(timeStamp(recStart(3))<lightTime.Total & lightTime.Total<timeStamp(recEnd(3))); % unit: msec
            preTime = [sensor.(fields{1})(1); sensor.(fields{end})(nTrial/3)]; % unit: msec
            stmTime = [sensor.(fields{1})(nTrial/3+1); sensor.(fields{end})(nTrial*2/3)]; % unit: msec
            postTime = [sensor.(fields{1})(nTrial*2/3+1); sensor.(fields{end})(nTrial)]; % unit: msec
        case 4
            lightTime.Total = timeStamp(strcmp(eventString,'Light')); % unit: msec
            lightTime.TrackTotal = lightTime.Total(lightTime.Total<=timeStamp(recEnd(2))); % unit: msec
            lightTime.Track2hz = lightTime.TrackTotal((end-599):end); % unit: msec
            lightTime.Track8hz = lightTime.TrackTotal(1:(end-599)); % unit: msec
            lightTime.Plfm2hz = lightTime.Total(timeStamp(recStart(3))<lightTime.Total & lightTime.Total<timeStamp(recEnd(3))); % unit: msec
            lightTime.Plfm8hz = lightTime.Total(timeStamp(recStart(4))<lightTime.Total & lightTime.Total<timeStamp(recEnd(4)));
            lightTime.PlfmTotal = [lightTime.Plfm2hz;lightTime.Plfm8hz];
            preTime = [sensor.(fields{1})(1); sensor.(fields{end})(nTrial/3)]; % unit: msec
            if lightTime.Track2hz(end) < sensor12(end)
                nLightLap = find(sensor12 > lightTime.Track2hz(end),1,'first'); % last laser stimulation lap
                stmTime = [sensor.(fields{1})(nTrial/3+1); sensor12(nLightLap)]; % unit: msec
                postTime = [sensor1(nLightLap+1);sensor12(nTrial)];
            else
                stmTime = [sensor.(fields{1})(nTrial/3+1); sensor.(fields{end})(nTrial*2/3)]; % unit: msec
                postTime = [];
            end
    end
 
%% Pseudo light generation (only 8hz lights are considered)
eventFile = FindFiles('Events.nev');
[filePath, ~, ~] = fileparts(eventFile{1});
psdlightPre = [];
psdlightPost = [];

if(regexp(filePath,'DRw')) % DRw session
    for iLap = 31:60
        lightLap = lightTime.Track8hz((sensor10(iLap)<lightTime.Track8hz & lightTime.Track8hz<sensor11(iLap))) - sensor10(iLap);              
        temp_psdlightPre = sensor10(iLap-30)+lightLap;
        temp_psdlightPost = sensor10(iLap+30)+lightLap;        
        psdlightPre = [psdlightPre; temp_psdlightPre];
        psdlightPost = [psdlightPost; temp_psdlightPost];        
    end
    
elseif(regexp(filePath,'DRun')); % DRun session
    for iLap = 31:60
        lightLap = lightTime.Track8hz((sensor6(iLap)<lightTime.Track8hz & lightTime.Track8hz<sensor9(iLap))) - sensor6(iLap);                
        temp_psdlightPre = sensor6(iLap-30)+lightLap;
        temp_psdlightPost = sensor6(iLap+30)+lightLap;        
        psdlightPre = [psdlightPre; temp_psdlightPre];
        psdlightPost = [psdlightPost; temp_psdlightPost];        
    end
    
elseif(regexp(filePath,'noRw')); % Nolight session (control session for DRw)
    switch ~isempty(lightTime.Track8hz)
        case 0
            laserDelay = randn(30,1);
            for iLap = 31:60
                tempLighttime = sensor10(iLap)+laserDelay(iLap-30)+125*(1:((sensor11(iLap)-sensor10(iLap))/125))';
                lightTime.Track8hz = [lightTime.Track8hz;tempLighttime];
                lightLap = lightTime.Track8hz((sensor10(iLap)<lightTime.Track8hz & lightTime.Track8hz<sensor11(iLap))) - sensor10(iLap);                
                temp_psdlightPre = sensor10(iLap-30)+lightLap;
                temp_psdlightPost = sensor10(iLap+30)+lightLap;        
                psdlightPre = [psdlightPre; temp_psdlightPre];
                psdlightPost = [psdlightPost; temp_psdlightPost];        
            end
        case 1
            for iLap = 31:60
                lightLap = lightTime.Track8hz((sensor10(iLap)<lightTime.Track8hz & lightTime.Track8hz<sensor11(iLap))) - sensor10(iLap);                
                temp_psdlightPre = sensor10(iLap-30)+lightLap;
                temp_psdlightPost = sensor10(iLap+30)+lightLap;        
                psdlightPre = [psdlightPre; temp_psdlightPre];
                psdlightPost = [psdlightPost; temp_psdlightPost];        
            end
    end
    
else(regexp(filePath,'noRun')); % Nolight session (control session for DRun)
    switch ~isempty(lightTime.Track8hz)
        case 0
            laserDelay = randn(30,1);
            for iLap = 31:60
                tempLighttime = sensor6(iLap)+laserDelay(iLap-30)+125*(1:((sensor9(iLap)-sensor6(iLap))/125))';
                lightTime.Track8hz = [lightTime.Track8hz; tempLighttime];
                lightLap = lightTime.Track8hz((sensor6(iLap)<lightTime.Track8hz & lightTime.Track8hz<sensor9(iLap)))-sensor6(iLap);
                temp_psdlightPre = sensor6(iLap-30)+lightLap;
                temp_psdlightPost = sensor6(iLap+30)+lightLap;
                psdlightPre = [psdlightPre; temp_psdlightPre];
                psdlightPost = [psdlightPost; temp_psdlightPost];
            end           
        case 1
            for iLap = 31:60
                lightLap = lightTime.Track8hz((sensor6(iLap)<lightTime.Track8hz & lightTime.Track8hz<sensor9(iLap)))-sensor6(iLap);
                temp_psdlightPre = sensor6(iLap-30)+lightLap;
                temp_psdlightPost = sensor6(iLap+30)+lightLap;
                psdlightPre = [psdlightPre; temp_psdlightPre];
                psdlightPost = [psdlightPost; temp_psdlightPost];
            end
    end
end

%% Save variables
    if exist('Plfm8hz','var');
        save('Events.mat',...
        'baseTime','preTime','stmTime','postTime','taskTime','plfm2hz','plfm8hz',...
        'sensor','fields','nTrial','nSensor','trialIndex',...
        'psdlightPre','psdlightPost',...
        'lightTime');
    else
        save('Events.mat',...
        'baseTime','preTime','stmTime','postTime','taskTime','plfm2hz',...
        'sensor','fields','nTrial','nSensor','trialIndex',...
        'psdlightPre','psdlightPost',...
        'lightTime');
    end
end