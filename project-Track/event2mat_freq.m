function event2mat_freq %(filename)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose: Creating event file
% Writer: Jun (Modified DK's eventmat.m)
% First written: 03/31/2015
% Last modified: 12. 3. 2016

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
nSession = numel(recStart);

switch numel(recStart)
    case 2
        time2hz = timeStamp([recStart(1), recEnd(1)]);
        time8hz = timeStamp([recStart(2), recEnd(2)]);
        
        lightTime.Total = timeStamp(strcmp(eventString,'Light'));
        lightTime.Plfm2hz = lightTime.Total(time2hz(1) < lightTime.Total & lightTime.Total < time2hz(2));
        lightTime.Plfm8hz = lightTime.Total(time8hz(1) < lightTime.Total & lightTime.Total < time8hz(2));
        
        save('Events.mat','time2hz','time8hz','lightTime','nSession');
    case 4
        time2hz = timeStamp([recStart(1), recEnd(1)]);
        time8hz = timeStamp([recStart(2), recEnd(2)]);
        time20hz = timeStamp([recStart(3), recEnd(3)]);
        time50hz = timeStamp([recStart(4), recEnd(4)]);

        lightTime.Total = timeStamp(strcmp(eventString,'Light'));
        lightTime.Plfm2hz = lightTime.Total(time2hz(1) < lightTime.Total & lightTime.Total < time2hz(2));
        lightTime.Plfm8hz = lightTime.Total(time8hz(1) < lightTime.Total & lightTime.Total < time8hz(2));
        lightTime.Plfm20hz = lightTime.Total(time20hz(1) < lightTime.Total & lightTime.Total < time20hz(2));
        lightTime.Plfm50hz = lightTime.Total(time50hz(1) < lightTime.Total & lightTime.Total < time50hz(2));

        save('Events.mat','time2hz','time8hz','time20hz','time50hz','lightTime','nSession');
    
    case 5
        time1hz = timeStamp([recStart(1), recEnd(1)]);
        time2hz = timeStamp([recStart(2), recEnd(2)]);
        time8hz = timeStamp([recStart(3), recEnd(3)]);
        time20hz = timeStamp([recStart(4), recEnd(4)]);
        time50hz = timeStamp([recStart(5), recEnd(5)]);

        lightTime.Total = timeStamp(strcmp(eventString,'Light'));
        lightTime.Plfm1hz = lightTime.Total(time1hz(1) < lightTime.Total & lightTime.Total < time1hz(2));
        lightTime.Plfm2hz = lightTime.Total(time2hz(1) < lightTime.Total & lightTime.Total < time2hz(2));
        lightTime.Plfm8hz = lightTime.Total(time8hz(1) < lightTime.Total & lightTime.Total < time8hz(2));
        lightTime.Plfm20hz = lightTime.Total(time20hz(1) < lightTime.Total & lightTime.Total < time20hz(2));
        lightTime.Plfm50hz = lightTime.Total(time50hz(1) < lightTime.Total & lightTime.Total < time50hz(2));
        
        save('Events.mat','time1hz','time2hz','time8hz','time20hz','time50hz','lightTime','nSession');
end
end