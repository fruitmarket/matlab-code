function event2mat_pulse %(filename)
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

time10 = timeStamp([recStart(1), recEnd(1)]);
time50 = timeStamp([recStart(2), recEnd(2)]);

lightTotal = timeStamp(strcmp(eventString,'Light'));
light10 = lightTotal(lightTotal < timeStamp(recEnd(1)));
light50 = lightTotal(timeStamp(recStart(2)) < lightTotal & lightTotal < timeStamp(recEnd(2)));

save('Events.mat','time10','time50','lightTotal','light10','light50');
end