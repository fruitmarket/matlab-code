function [dT, newVTflag] = VTRecBreakProcess(time)

% Date: Jan-19-2015
% dT = diff(time); % T: 100usec
% newVTflag = mean(dT)>10000/40; % Is the sampling frequency 30Hz or 60Hz?
%     % 30Hz == 1 (New Cheetah), 60Hz == 0 (Old Cheetah);
% switch newVTflag
%     case 1
%     sampleFq = 30; % New Cheetah version
%     case 0
%     sampleFq = 60; % Old Cheetah version
% end
% meanDT = 10000/sampleFq; % mean dT = 33.3 msec(30Hz) or 16.7 msec(60Hz)
% RecBreak_idx = (dT>400);
% dT(RecBreak_idx) = meanDT;
% dT = [dT; meanDT];
% n = histc(spike_time, T);
% RecBreak_T = [T(RecBreak_idx+1); T(end)];
% RecBreak_T = [RecBreak_T, RecBreak_T+meanDT]';
% tmp_RecBreak_n = reshape(histc(spike_time,RecBreak_T(:)),2,size(RecBreak_T,2));
% n([RecBreak_idx+1,end]) = tmp_RecBreak_n(1,:);

dT = diff(time); % time: msec [time*10 = 100usec]
% newVTflag = mean(dT)>1000/50; % Is the sampling frequency 30Hz or 60Hz?
% 30Hz == 1 (New Cheetah), 60Hz == 0 (Old Cheetah);
newVTflag = 1; % Since Digital Cheetah is always 30Hz
switch newVTflag
    case 1
    sampleFq = 30; % New Cheetah version
    case 0
    sampleFq = 60; % Old Cheetah version
end
meanDT = 1000/sampleFq; % mean dT = 33.3 msec(30Hz) or 16.7 msec(60Hz)
RecBreak_idx = (dT>40);
dT(RecBreak_idx) = meanDT;
dT = [dT; meanDT];
end