function event2mat_pulse2 %(filename)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose: 1,3, 5,10 ms pulse width comparison (freq: 8hz)
% Writer: Jun 

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

time1ms = timeStamp([recStart(1), recEnd(1)]);
time3ms = timeStamp([recStart(2), recEnd(2)]);
time5ms = timeStamp([recStart(3), recEnd(3)]);
time10ms = timeStamp([recStart(4), recEnd(4)]);

lightTime.Total = timeStamp(strcmp(eventString,'Light'));
lightTime.w1ms = lightTime.Total(time1ms(1) < lightTime.Total & lightTime.Total < time1ms(2));
lightTime.w3ms = lightTime.Total(time3ms(1) < lightTime.Total & lightTime.Total < time3ms(2));
lightTime.w5ms = lightTime.Total(time5ms(1) < lightTime.Total & lightTime.Total < time5ms(2));
lightTime.w10ms = lightTime.Total(time10ms(1) < lightTime.Total & lightTime.Total < time10ms(2));

save('Events.mat','time1ms','time3ms','time5ms','time10ms','lightTime');
end