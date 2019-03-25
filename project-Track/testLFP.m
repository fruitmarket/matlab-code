cd('E:\Dropbox\SNL\P2_Track\161206_DV2.20_2_DRun_100_T346');

movingwin = [0.5 0.1]; % 500ms window, 100ms step
params.fpass = [4 12];
params.tapers = [5,9];
params.Fs = 2000;
params.trialave = 0;
params.err = 0;
    
[cscTime, cscSample, cscList] = cscLoad();
load('Events.mat')

cscTime = cscTime{1};
cscSample = cscSample{6};

cscTask = cscSample(taskTime(1)<=cscTime & cscTime<=taskTime(2));
[lfpPower, lfpTime, lfpFreq] = mtspecgramc(cscTask, movingwin, params);

[vtTime, vtPosition, vtList] = vtLoad;