function event2mat_pulse %(filename)
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

time10 = timeStamp([recStart(1), recEnd(1)]);
time50 = timeStamp([recStart(end), recEnd(end)]);

lightTotal = timeStamp(strcmp(eventString,'Light'));
light10 = lightTotal(lightTotal < time10(2));
light50 = lightTotal(time50(1) < lightTotal & lightTotal < time50(2));

save('Events.mat','time10','time50','lightTotal','light10','light50');

if length(recStart) == 3
    time20 = timeStamp([recStart(2), recEnd(2)]);
    light20 = lightTotal(time20(1) < lightTotal & lightTotal < time20(2));
    save('Events.mat','time20','light20','-append');
end

end