% common part
lineColor = {[144, 164, 174]./255,... % Before stimulation
    [33 150 243]./ 255,... % During stimulation
    [38, 50, 56]./255}; % After stimulation

lineWth = [1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75];
fontS = 4; fontM = 6; fontL = 8; % font size large
lineS = 0.2; lineM = 0.5; lineL = 1; % line width large

colorBlue = [33, 150, 243]/255;
colorLightBlue = [100, 181, 246]/255;
colorLLightBlue = [187, 222, 251]/255;
colorRed = [237, 50, 52]/255;
colorLightRed = [242, 138, 130]/255;
colorGray = [189, 189, 189]/255;
colorGreen = [46, 125, 50]/255;
colorLightGray = [238, 238, 238]/255;
colorDarkGray = [117, 117, 117]/255;
colorYellow = [255, 243, 3]/255;
colorLightYellow = [255, 249, 196]/255;
colorPurple = [123, 31, 162]/255;
colorBlack = [0, 0, 0];

markerS = 2.2; markerM = 4.4; markerL = 6.6; markerXL = 8.8;
tightInterval = [0.02 0.02]; midInterval = [0.09, 0.09]; wideInterval = [0.14 0.14];
width = 0.7;

paperSize = {[0 0 21.0 29.7]; % A4_portrait
             [0 0 29.7 21.0]; % A4_landscape
             [0 0 15.7 21.0]; % A4_half landscape
             [0 0 21.6 27.9]}; % Letter

cd('D:\Dropbox\SNL\P2_Track');

Txls = readtable('neuronList_02-Mar-2017.xlsx');
load('neuronList_ori_02-Mar-017.mat');

criteriaFR = 7;
alpha = 0.005;
T.taskType = categorical(T.taskType);
compareID = ~isnan(T.compCellID);

DRunTN = (T.taskType == 'DRun') & (cellfun(@max, T.peakFR1D_track) > 1) & compareID;
DRwTN = (T.taskType == 'DRw') & (cellfun(@max, T.peakFR1D_track) > 1) & compareID;
noRunTN = (T.taskType == 'noRun') & (cellfun(@max, T.peakFR1D_track) > 1) & compareID;
noRwTN = (T.taskType == 'noRw') & (cellfun(@max, T.peakFR1D_track) > 1) & compareID;

DRunTN_cellID = T.cellID(DRunTN);
DRunTN_compID = T.compCellID(DRunTN);
DRunTN_taskType = T.taskType(DRunTN);
DRunTN_evokeProb = T.lightProbTrack_8hz(DRunTN);

DRwTN_cellID = T.cellID(DRwTN);
DRwTN_compID = T.compCellID(DRwTN);
DRwTN_taskType = T.taskType(DRwTN);
DRwTN_evokeProb = T.lightProbTrack_8hz(DRwTN);

noRunTN_cellID = T.cellID(noRunTN);
noRunTN_compID = T.compCellID(noRunTN);
noRunTN_taskType = T.taskType(noRunTN);
noRunTN_evokeProb = T.lightProbTrack_8hz(noRunTN);

noRwTN_cellID = T.cellID(noRwTN);
noRwTN_compID = T.compCellID(noRwTN);
noRwTN_taskType = T.taskType(noRwTN);
noRwTN_evokeProb = T.lightProbTrack_8hz(noRwTN);

