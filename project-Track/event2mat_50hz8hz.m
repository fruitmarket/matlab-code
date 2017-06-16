function event2mat_50hz8hz
% event2mat_50hz8hz store recording on/off time and light event time
%
% Light train (50hz 8hz stm) x 8 EA - 10 sec pause - again - ...
% |||______|||______|||______|||______|||______|||______|||______|||______|||______|||______
%
%
%

if exist('Events.xlsx','file')
    [timeStamp,eventString,~] = xlsread('Events.xlsx');
else
    [eData, eList] = eLoad; % Unit: msec
    timeStamp = eData.t;
    eventString = eData.s;
end

recStart = find(strcmp(eventString,'Starting Recording'));
recEnd = find(strcmp(eventString,'Stopping Recording'));
nSession = numel(recStart);
time_recStart = timeStamp(recStart);
time_recEnd =  timeStamp(recEnd);

lightT = timeStamp(strcmp(eventString,'Light'));
nLight = length(lightT);

lightT_50hzLoop1st = lightT(1:3:end);
lightT_50hzLoop2nd = lightT(2:3:end);
lightT_50hzLoop3rd = lightT(3:3:end);
lightT_8hzLoopStart = lightT(1:24:end);

lightT_Pw1 = lightT(1:nLight/3);
lightT_Pw2 = lightT(nLight/3+1:nLight/3*2);
lightT_Pw3 = lightT(nLight/3*2+1:nLight);

save('Events.mat','time_recStart','time_recEnd','lightT','nLight',...
    'lightT_50hzLoop1st','lightT_50hzLoop2nd','lightT_50hzLoop3rd','lightT_8hzLoopStart','lightT_Pw1','lightT_Pw2','lightT_Pw3');
end