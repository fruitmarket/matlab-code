lineColor = {[144, 164, 174]./255,... % Before stimulation
    [33 150 243]./ 255,... % During stimulation
    [38, 50, 56]./255}; % After stimulation

lineWth = [1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75];
fontS = 4; fontM = 5; fontL = 7; % font size large
lineS = 0.2; lineM = 0.5; lineL = 1; % line width large

colorBlue = [33 150 243] ./ 255;
colorLightBlue = [100 181 246] ./ 255;
colorLLightBlue = [187, 222, 251]./255;
colorRed = [237 50 52] ./ 255;
colorLightRed = [242 138 130] ./ 255;
colorGray = [189 189 189] ./ 255;
colorLightGray = [238, 238, 238] ./255;
colorDarkGray = [117, 117, 117] ./255;
colorYellow = [255 243 3] ./ 255;
colorLightYellow = [255 249 196] ./ 255;
colorBlack = [0, 0, 0];

markerS = 2.2; markerM = 4.4; markerL = 6.6; markerXL = 8.8;
tightInterval = [0.02 0.02]; midInterval = [0.09, 0.09]; wideInterval = [0.14 0.14];
width = 0.7;

criteria_FR = 7;

load('cellList_ori.mat');

DRunPn = T.taskProb == '100' & T.taskType == 'DRun' & T.peakTrack>1 & T.meanFR_task<criteria_FR;
DRunIn = T.taskProb == '100' & T.taskType == 'DRun' & T.peakTrack>1 & T.meanFR_task>criteria_FR;
DRwPn = T.taskProb == '100' & T.taskType == 'DRw' & T.peakTrack>1 & T.meanFR_task<criteria_FR;
DRwIn = T.taskProb == '100' & T.taskType == 'DRw' & T.peakTrack>1 & T.meanFR_task>criteria_FR;

DRunPn_latency_Track = T.latencyTrack(DRunPn);
DRunPn_latency_Plfm2hz = T.latencyPlfm2hz(DRunPn);

DRunIn_latency_Track = T.latencyTrack(DRunIn);
DRunIn_latency_Plfm2hz = T.latencyPlfm2hz(DRunIn);

DRwPn_latency_Track = T.latencyTrack(DRwPn);
DRwPn_latency_Plfm2hz = T.latencyPlfm2hz(DRwPn);

DRwIn_latency_Track = T.latencyTrack(DRwIn);
DRwIn_latency_Plfm2hz = T.latencyPlfm2hz(DRwIn);



