function event2mat_DREADD
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose: Read event file and calculate baseTime, testTime, etc
% Unit: ms
% Writer: Joonyeup Lee (Modified DK's eventmat.m)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[timesTamp, eventStrings] = Nlx2MatEV('Events.nev', [1 0 0 0 1], 0, 1, []);
timesTamp = timesTamp'/1000; % unit: ms

recStart = find(strcmp(eventStrings,'Starting Recording'));
recEnd = find(strcmp(eventStrings, 'Stopping Recording'));

baseTime = timesTamp([recStart(1), recEnd(1)]); % unit: msec
testTime = timesTamp([recStart(2), recEnd(2)]); % unit: msec
nsession = size(recStart,1);

save('Events.mat',...
    'baseTime','testTime','nsession')
end

    