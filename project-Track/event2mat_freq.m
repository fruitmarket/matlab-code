function event2mat_freq %(filename)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose: Creating event file
% Writer: Jun (Modified DK's eventmat.m)
% First written: 03/31/2015
% Last modified: 12. 3. 2016

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[eData, eList] = eLoad; % Unit: msec
timeStamp = eData.t;
eventString = eData.s;

% Time bins
recStart = find(strcmp(eventString,'Starting Recording'));
recEnd = find(strcmp(eventString,'Stopping Recording'));
nSession = numel(recStart);

switch numel(recStart)
    case 2
        time2hz = timeStamp([recStart(1), recEnd(1)]);
        time8hz = timeStamp([recStart(2), recEnd(2)]);
        
        lightTotal = timeStamp(strcmp(eventString,'Light'));
        light2hz = lightTotal(time2hz(1) < lightTotal & lightTotal < time2hz(2));
        light8hz = lightTotal(time8hz(1) < lightTotal & lightTotal < time8hz(2));
        
        save('Events.mat','time2hz','time8hz','lightTotal','light2hz','light8hz','nSession');
    case 4
        time2hz = timeStamp([recStart(1), recEnd(1)]);
        time8hz = timeStamp([recStart(2), recEnd(2)]);
        time20hz = timeStamp([recStart(3), recEnd(3)]);
        time50hz = timeStamp([recStart(4), recEnd(4)]);

        lightTotal = timeStamp(strcmp(eventString,'Light'));
        light2hz = lightTotal(time2hz(1) < lightTotal & lightTotal < time2hz(2));
        light8hz = lightTotal(time8hz(1) < lightTotal & lightTotal < time8hz(2));
        light20hz = lightTotal(time20hz(1) < lightTotal & lightTotal < time20hz(2));
        light50hz = lightTotal(time50hz(1) < lightTotal & lightTotal < time50hz(2));

        save('Events.mat','time2hz','time8hz','time20hz','time50hz','lightTotal','light2hz','light8hz','light20hz','light50hz','nSession');
end
end