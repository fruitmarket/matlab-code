% common part
clearvars;
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
Txls = readtable('neuronList_23-Mar-2017.xlsx');
load('neuronList_ori_23-Mar-2017.mat');

cri_meanFR = 7;
cri_peakFR = 0;
alpha = 0.01;

% TN: track neuron
DRunTN = (T.taskType == 'DRun') & (cellfun(@max, T.peakFR1D_track) > cri_peakFR);
DRwTN = (T.taskType == 'DRw') & (cellfun(@max, T.peakFR1D_track) > cri_peakFR);

% total population (DRunPN / DRunIN / DRwPN / DRwIN) with light responsiveness (light activated)
DRunPN_act = DRunTN & T.meanFR_base<=cri_meanFR & T.pLR_Track<alpha & T.statDir_Track == 1;
DRunPN_ina = DRunTN & T.meanFR_base<=cri_meanFR & T.pLR_Track<alpha & T.statDir_Track == -1;
DRunPN_no = DRunTN & T.meanFR_base<=cri_meanFR & T.pLR_Track>=alpha;

DRunIN_act = DRunTN & T.meanFR_base>cri_meanFR & T.pLR_Track<alpha & T.statDir_Track == 1;
DRunIN_ina = DRunTN & T.meanFR_base>cri_meanFR & T.pLR_Track<alpha & T.statDir_Track == -1;
DRunIN_no = DRunTN & T.meanFR_base>cri_meanFR & T.pLR_Track>=alpha;

DRwPN_act = DRwTN & T.meanFR_base<=cri_meanFR & T.pLR_Track<alpha & T.statDir_Track == 1;
DRwPN_ina = DRwTN & T.meanFR_base<=cri_meanFR & T.pLR_Track<alpha & T.statDir_Track == -1;
DRwPN_no = DRwTN & T.meanFR_base<=cri_meanFR & T.pLR_Track>=alpha;

DRwIN_act = DRwTN & T.meanFR_base>cri_meanFR & T.pLR_Track<alpha & T.statDir_Track == 1;
DRwIN_ina = DRwTN & T.meanFR_base>cri_meanFR & T.pLR_Track<alpha & T.statDir_Track == -1;
DRwIN_no = DRwTN & T.meanFR_base>cri_meanFR & T.pLR_Track>=alpha;

%%
norPeriod_DRunPNact = T.evoSpike_preEarly(DRunPN_act);
norPeriod_DRunPNina = T.evoSpike_preEarly(DRunPN_ina);
norPeriod_DRunPNno = T.evoSpike_preEarly(DRunPN_no);

norPeriod_DRunIN = mean(T.evoSpike_preEarly(DRunPN_act | DRunPN_ina | DRunPN_no));
norPeriod_DRunIN = 0;

evoSpike_DRunPN_act = [T.evoSpike_preEarly(DRunPN_act)-norPeriod_DRunPNact, T.evoSpike_preLate(DRunPN_act)-norPeriod_DRunPNact, T.evoSpike_stmEarly(DRunPN_act)-norPeriod_DRunPNact, T.evoSpike_stmLate(DRunPN_act)-norPeriod_DRunPNact, T.evoSpike_postEarly(DRunPN_act)-norPeriod_DRunPNact, T.evoSpike_postLate(DRunPN_act)-norPeriod_DRunPNact];
evoSpike_DRunPN_ina = [T.evoSpike_preEarly(DRunPN_ina)-norPeriod_DRunPNina, T.evoSpike_preLate(DRunPN_ina)-norPeriod_DRunPNina, T.evoSpike_stmEarly(DRunPN_ina)-norPeriod_DRunPNina, T.evoSpike_stmLate(DRunPN_ina)-norPeriod_DRunPNina, T.evoSpike_postEarly(DRunPN_ina)-norPeriod_DRunPNina, T.evoSpike_postLate(DRunPN_ina)-norPeriod_DRunPNina];
evoSpike_DRunPN_no = [T.evoSpike_preEarly(DRunPN_no)-norPeriod_DRunPNno, T.evoSpike_preLate(DRunPN_no)-norPeriod_DRunPNno, T.evoSpike_stmEarly(DRunPN_no)-norPeriod_DRunPNno, T.evoSpike_stmLate(DRunPN_no)-norPeriod_DRunPNno, T.evoSpike_postEarly(DRunPN_no)-norPeriod_DRunPNno, T.evoSpike_postLate(DRunPN_no)-norPeriod_DRunPNno];

% evoSpike_DRunIN_act = [T.evoSpike_preEarly(DRunIN_act)-norPeriod_DRunIN, T.evoSpike_preLate(DRunIN_act)-norPeriod_DRunIN, T.evoSpike_stmEarly(DRunIN_act)-norPeriod_DRunIN, T.evoSpike_stmLate(DRunIN_act)-norPeriod_DRunIN, T.evoSpike_postEarly(DRunIN_act)-norPeriod_DRunIN, T.evoSpike_postLate(DRunIN_act)-norPeriod_DRunIN];
% evoSpike_DRunIN_ina = [T.evoSpike_preEarly(DRunIN_ina)-norPeriod_DRunIN, T.evoSpike_preLate(DRunIN_ina)-norPeriod_DRunIN, T.evoSpike_stmEarly(DRunIN_ina)-norPeriod_DRunIN, T.evoSpike_stmLate(DRunIN_ina)-norPeriod_DRunIN, T.evoSpike_postEarly(DRunIN_ina)-norPeriod_DRunIN, T.evoSpike_postLate(DRunIN_ina)-norPeriod_DRunIN];
% evoSpike_DRunIN_no = [T.evoSpike_preEarly(DRunIN_no)-norPeriod_DRunIN, T.evoSpike_preLate(DRunIN_no)-norPeriod_DRunIN, T.evoSpike_stmEarly(DRunIN_no)-norPeriod_DRunIN, T.evoSpike_stmLate(DRunIN_no)-norPeriod_DRunIN, T.evoSpike_postEarly(DRunIN_no)-norPeriod_DRunIN, T.evoSpike_postLate(DRunIN_no)-norPeriod_DRunIN];










