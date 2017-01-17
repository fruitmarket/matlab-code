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

time2hz = timeStamp([recStart(1), recEnd(1)]);
time8hz = timeStamp([recStart(2), recEnd(2)]);

lightTotal = timeStamp(strcmp(eventString,'Light'));
light2hz = lightTotal(time2hz(1) < lightTotal & lightTotal < time2hz(2));
light8hz = lightTotal(time8hz(1) < lightTotal & lightTotal < time8hz(2));

save('Events.mat','time2hz','time8hz','lightTotal','light2hz','light8hz');
end