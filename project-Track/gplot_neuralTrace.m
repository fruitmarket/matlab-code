% Latency of neurons which are activated on the platform. (Blue)
% Among neurons which are activated on the platform, latency of neurons
% which are also activated on the platform

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
% Txls = readtable('neuronList_24-Mar-2017.xlsx');
load('neuronList_ori_24-Mar-2017.mat');

cri_meanFR = 7;
cri_peakFR = 0;
alpha = 0.01;

% TN: track neuron
DRunTN = (T.taskType == 'DRun') & (cellfun(@max, T.peakFR1D_track) > cri_peakFR);

% total population (DRunPN / DRunIN / DRwPN / DRwIN) with light responsiveness (light activated)
DRunPN_act = DRunTN & T.meanFR_task<=cri_meanFR & T.pLR_Track<alpha & T.statDir_Track == 1;
DRunPN_ina = DRunTN & T.meanFR_task<=cri_meanFR & T.pLR_Track<alpha & T.statDir_Track == -1;
DRunPN_no = DRunTN & T.meanFR_task<=cri_meanFR & T.pLR_Track>=alpha;

DRunIN_act = DRunTN & T.meanFR_task>cri_meanFR & T.pLR_Track<alpha & T.statDir_Track == 1;
DRunIN_ina = DRunTN & T.meanFR_task>cri_meanFR & T.pLR_Track<alpha & T.statDir_Track == -1;
DRunIN_no = DRunTN & T.meanFR_task>cri_meanFR & T.pLR_Track>=alpha;

win = 0:2:125;

evoSpikeStm = cellfun(@(x) histc(x,win),T.evoXptTrackLight(DRunPN_ina),'UniformOutput',false);
evoSpikeStm = cell2mat(evoSpikeStm);
evoSpikeStm(:,end) = [];

evoSpikePre = cellfun(@(x) histc(x,win),T.evoXptTrackLight(DRunPN_no),'UniformOutput',false);
idxPre = cellfun(@isempty, evoSpikePre);
evoSpikePre = cell2mat(evoSpikePre(~idxPre));
evoSpikePre(:,end) = [];

% evoSpikePre = cellfun(@(x) histc(x,win),a);
% evoSpikePre = cell2mat(evoSpikePre);
% evoSpikePre(:,end) = [];
% 
% evoSpikePost = cellfun(@(x) histc(x,win),a);
% evoSpikePost = cell2mat(evoSpikePost);
% evoSpikePost(:,end) = [];

T.evoXptPsdPre
T.evoXptPsdPost


