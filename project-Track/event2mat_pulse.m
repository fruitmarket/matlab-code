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

lightTime.Total = timeStamp(strcmp(eventString,'Light'));
lightTime.width10 = lightTime.Total(time10(1) < lightTime.Total & lightTime.Total < time10(2));
lightTime.width50 = lightTime.Total(time50(1) < lightTime.Total & lightTime.Total < time50(2));

save('Events.mat','time10','time50','lightTime');

if length(recStart) == 3
    time20 = timeStamp([recStart(2), recEnd(2)]);
    lightTime.width20 = lightTime.Total(time20(1) < lightTime.Total & lightTime.Total < time20(2));
    save('Events.mat','time20','lightTime','-append');
end

end