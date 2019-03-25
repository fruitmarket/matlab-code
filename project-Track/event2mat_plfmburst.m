function event2mat_plfmburst %(filename)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose: Creating event file
% Writer: Jun
% First written: 05/15/2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if exist('Events.xlsx','file')
    [timeStamp,eventString,~] = xlsread('Events.xlsx');
else
    [eData, eList] = eLoad; % Unit: msec
    timeStamp = eData.t;
    eventString = eData.s;
end

% Events
recStart = strcmp(eventString,'Starting Recording');
recEnd = strcmp(eventString,'Stopping Recording');
nSession = sum(double(recStart));
time_recStart = timeStamp(recStart);
time_recEnd =  timeStamp(recEnd);
lightT = timeStamp(strcmp(eventString,'Light'));

time_PRE = [time_recStart, lightT(1)]; % unit: ms
time_STIM = [lightT(1), lightT(end)];
time_POST = [lightT(end), time_recEnd];

isi = diff(lightT); % unit: ms
ibi_total = isi(isi>50);
ibi_mean = mean(isi(isi>50));
ibi_std = std(isi(isi>50));

nLight = length(lightT);
nBurst = sum(double(isi>50))+1; % number of burst sets
nPulse = nLight/nBurst;
wPulse = floor(mean(isi(isi<50)))/2; % pulse width

save('Events.mat',...
    'time_recStart','time_recEnd','lightT',...
    'time_PRE','time_STIM','time_POST',...
    'isi','ibi_total','ibi_mean','ibi_std','nLight','nBurst','nPulse','wPulse');
end