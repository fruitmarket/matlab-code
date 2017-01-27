function event2mat_errorFix
%%%%%%%%%%
% Purpose: Use to eraze unwanted events.
% Author: Joonyeup Lee
% First written: 01/20/2017
%
%%%%%%%%%%

[eData, ~] = eLoad;
timeStamp = eData.t;
eventStrings = eData.s;

fileName = 'Events.xlsx';
sheet = 1;
xlRange1 = 'A1';
xlRange2 = 'B1';

xlswrite(fileName,eventStrings,sheet,xlRange1);
xlswrite(fileName,timeStamp,sheet,xlRange2);
end