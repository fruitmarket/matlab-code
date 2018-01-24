clearvars;
cd('D:\Dropbox\SNL\P2_Track');
load('D:\Dropbox\SNL\P2_Track\myParameters.mat');
formatOut = 'yymmdd';

markerS = 1.5;
dotS = 4;
colorGray = [100 100 100]./255;
colorLightGray = [240 240 240]./255;
colorDarkGray = [170 170 170]./255;

%% light location
lightLoc_Run = [floor(20*pi*5/6) ceil(20*pi*8/6)];
lightLoc_Rw = [floor(20*pi*9/6) ceil(20*pi*10/6)];

%% load Results
load('neuronList_ori50hz_180122.mat');
T50 = T;
clear T;

load('neuronList_ori_180122.mat');
cri_meanFR = 1;

%%
% tPC_Run = T50.taskType == 'DRun' & T50.idxNeurontype == 'PN';
% tPC_Rw = T50.taskType == 'DRw' & T50.idxNeurontype == 'PN';
% tPC_Run = T.taskType == 'DRun' & T.idxNeurontype == 'PN';
% tPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN';
% tPC_Rw = T.taskType == 'DRw' & T.idxNeurontype == 'PN';
% tPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN';

% tPC_Run = T50.taskType == 'DRun' & T50.idxNeurontype == 'PN' & T50.idxPeakFR & T50.idxPlaceField & T50.idxTotalSpikeNum;
% tPC_Rw = T50.taskType == 'DRw' & T50.idxNeurontype == 'PN' & T50.idxPeakFR & T50.idxPlaceField & T50.idxTotalSpikeNum;
% tPC_Run = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
% tPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
% tPC_Rw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
% tPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;

tPC_Run50 = T50.taskType == 'DRun' & T50.idxNeurontype == 'PN' & cellfun(@(x) max(max(x)), T50.pethconvSpatial)>cri_meanFR; % nanmean firing rate > 1hz
tPC_Rw50 = T50.taskType == 'DRw' & T50.idxNeurontype == 'PN' & cellfun(@(x) max(max(x)), T50.pethconvSpatial)>cri_meanFR; % nanmean firing rate > 1hz
tPC_Run = (T.taskType == 'DRun') & T.idxNeurontype == 'PN' & cellfun(@(x) max(max(x)), T.pethconvSpatial)>cri_meanFR; % nanmean firing rate > 1hz
tPC_noRun = (T.taskType == 'noRun') & T.idxNeurontype == 'PN' & cellfun(@(x) max(max(x)), T.pethconvSpatial)>cri_meanFR; % nanmean firing rate > 1hz
tPC_Rw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & cellfun(@(x) max(max(x)), T.pethconvSpatial)>cri_meanFR; % nanmean firing rate > 1hz
tPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & cellfun(@(x) max(max(x)), T.pethconvSpatial)>cri_meanFR; % nanmean firing rate > 1hz

% tPC_Run = T50.taskType == 'DRun' & T50.idxNeurontype == 'PN' & T50.idxPeakFR;
% tPC_Rw = T50.taskType == 'DRw' & T50.idxNeurontype == 'PN' & T50.idxPeakFR;
% tPC_Run = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR;
% tPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR;
% tPC_Rw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR;
% tPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR;

nPC_Run50 = sum(double(tPC_Run50));
nPC_Rw50 = sum(double(tPC_Rw50));
nPC_Run8 = sum(double(tPC_Run));
nPC_Rw8 = sum(double(tPC_Rw));
nPC_noRun = sum(double(tPC_noRun));
nPC_noRw = sum(double(tPC_noRw));

%% Spatial correlation total track
corSP50_Run_preXstim = T50.rCorrRaw1D_preXstm(tPC_Run50);
corSP50_Run_preXpost = T50.rCorrRaw1D_preXpost(tPC_Run50);
corSP50_Run_stimXpost = T50.rCorrRaw1D_stmXpost(tPC_Run50);

corSP8_Run_preXstim = T.rCorrRaw1D_preXstm(tPC_Run);
corSP8_Run_preXpost = T.rCorrRaw1D_preXpost(tPC_Run);
corSP8_Run_stimXpost = T.rCorrRaw1D_stmXpost(tPC_Run);

corSP_noRun_preXstim = T.rCorrRaw1D_preXstm(tPC_noRun);
corSP_noRun_preXpost = T.rCorrRaw1D_preXpost(tPC_noRun);
corSP_noRun_stimXpost = T.rCorrRaw1D_stmXpost(tPC_noRun);

corSP50_Rw_preXstim = T50.rCorrRaw1D_preXstm(tPC_Rw50);
corSP50_Rw_preXpost = T50.rCorrRaw1D_preXpost(tPC_Rw50);
corSP50_Rw_stimXpost = T50.rCorrRaw1D_stmXpost(tPC_Rw50);

corSP8_Rw_preXstim = T.rCorrRaw1D_preXstm(tPC_Rw);
corSP8_Rw_preXpost = T.rCorrRaw1D_preXpost(tPC_Rw);
corSP8_Rw_stimXpost = T.rCorrRaw1D_stmXpost(tPC_Rw);

corSP_noRw_preXstim = T.rCorrRaw1D_preXstm(tPC_noRw);
corSP_noRw_preXpost = T.rCorrRaw1D_preXpost(tPC_noRw);
corSP_noRw_stimXpost = T.rCorrRaw1D_stmXpost(tPC_noRw);

%
m_corSP50_Run = [nanmean(corSP50_Run_preXstim) nanmean(corSP50_Run_preXpost) nanmean(corSP50_Run_stimXpost)];
sem_corSP50_Run = [nanstd(corSP50_Run_preXstim)/sqrt(nPC_Run50) nanstd(corSP50_Run_preXpost)/sqrt(nPC_Run50) nanstd(corSP50_Run_stimXpost)/sqrt(nPC_Run50)];

m_corSP8_Run = [nanmean(corSP8_Run_preXstim) nanmean(corSP8_Run_preXpost) nanmean(corSP8_Run_stimXpost)];
sem_corSP8_Run = [nanstd(corSP8_Run_preXstim)/sqrt(nPC_Run8) nanstd(corSP8_Run_preXpost)/sqrt(nPC_Run8) nanstd(corSP8_Run_stimXpost)/sqrt(nPC_Run8)];

m_corSP_noRun = [nanmean(corSP_noRun_preXstim) nanmean(corSP_noRun_preXpost) nanmean(corSP_noRun_stimXpost)];
sem_corSP_noRun = [nanstd(corSP_noRun_preXstim)/sqrt(nPC_noRun) nanstd(corSP_noRun_preXpost)/sqrt(nPC_noRun) nanstd(corSP_noRun_stimXpost)/sqrt(nPC_noRun)];

m_corSP50_Rw = [nanmean(corSP50_Rw_preXstim) nanmean(corSP50_Rw_preXpost) nanmean(corSP50_Rw_stimXpost)];
sem_corSP50_Rw = [nanstd(corSP50_Rw_preXstim)/sqrt(nPC_Rw50) nanstd(corSP50_Rw_preXpost)/sqrt(nPC_Rw50) nanstd(corSP50_Rw_stimXpost)/sqrt(nPC_Rw50)];

m_corSP8_Rw = [nanmean(corSP8_Rw_preXstim) nanmean(corSP8_Rw_preXpost) nanmean(corSP8_Rw_stimXpost)];
sem_corSP8_Rw = [nanstd(corSP8_Rw_preXstim)/sqrt(nPC_Rw8) nanstd(corSP8_Rw_preXpost)/sqrt(nPC_Rw8) nanstd(corSP8_Rw_stimXpost)/sqrt(nPC_Rw8)];

m_corSP_noRw = [nanmean(corSP_noRw_preXstim) nanmean(corSP_noRw_preXpost) nanmean(corSP_noRw_stimXpost)];
sem_corSP_noRw = [nanstd(corSP_noRw_preXstim)/sqrt(nPC_noRw) nanstd(corSP_noRw_preXpost)/sqrt(nPC_noRw) nanstd(corSP_noRw_stimXpost)/sqrt(nPC_noRw)];


%% Spatial correlation pixel separation
% 50 Hz stimulation
rateMap_PRE_Run50 = cell2mat(T50.rateMapRaw_PRE(tPC_Run50));
rateMap_STIM_Run50 = cell2mat(T50.rateMapRaw_STIM(tPC_Run50));
rateMap_POST_Run50 = cell2mat(T50.rateMapRaw_POST(tPC_Run50));
nBin = size(rateMap_PRE_Run50,2);

in_PRE_Run50 = rateMap_PRE_Run50(:,lightLoc_Run(1):lightLoc_Run(2));
in_STIM_Run50 = rateMap_STIM_Run50(:,lightLoc_Run(1):lightLoc_Run(2));
in_POST_Run50 = rateMap_POST_Run50(:,lightLoc_Run(1):lightLoc_Run(2));

out_PRE_Run50 = rateMap_PRE_Run50(:,[1:lightLoc_Run(1)-1,lightLoc_Run(2)+1:nBin]);
out_STIM_Run50 = rateMap_STIM_Run50(:,[1:lightLoc_Run(1)-1,lightLoc_Run(2)+1:nBin]);
out_POST_Run50 = rateMap_POST_Run50(:,[1:lightLoc_Run(1)-1,lightLoc_Run(2)+1:nBin]);

% 8 Hz stimulation
rateMap_PRE_Run8 = cell2mat(T.rateMapRaw_PRE(tPC_Run));
rateMap_STIM_Run8 = cell2mat(T.rateMapRaw_STIM(tPC_Run));
rateMap_POST_Run8 = cell2mat(T.rateMapRaw_POST(tPC_Run));

in_PRE_Run8 = rateMap_PRE_Run8(:,lightLoc_Run(1):lightLoc_Run(2));
in_STIM_Run8 = rateMap_STIM_Run8(:,lightLoc_Run(1):lightLoc_Run(2));
in_POST_Run8 = rateMap_POST_Run8(:,lightLoc_Run(1):lightLoc_Run(2));

out_PRE_Run8 = rateMap_PRE_Run8(:,[1:lightLoc_Run(1)-1,lightLoc_Run(2)+1:nBin]);
out_STIM_Run8 = rateMap_STIM_Run8(:,[1:lightLoc_Run(1)-1,lightLoc_Run(2)+1:nBin]);
out_POST_Run8 = rateMap_POST_Run8(:,[1:lightLoc_Run(1)-1,lightLoc_Run(2)+1:nBin]);

% No stimulation
rateMap_PRE_noRun = cell2mat(T50.rateMapRaw_PRE(tPC_noRun));
rateMap_STIM_noRun = cell2mat(T50.rateMapRaw_STIM(tPC_noRun));
rateMap_POST_noRun = cell2mat(T50.rateMapRaw_POST(tPC_noRun));

in_PRE_noRun = rateMap_PRE_noRun(:,lightLoc_Run(1):lightLoc_Run(2));
in_STIM_noRun = rateMap_STIM_noRun(:,lightLoc_Run(1):lightLoc_Run(2));
in_POST_noRun = rateMap_POST_noRun(:,lightLoc_Run(1):lightLoc_Run(2));

out_PRE_noRun = rateMap_PRE_noRun(:,[1:lightLoc_Run(1)-1,lightLoc_Run(2)+1:nBin]);
out_STIM_noRun = rateMap_STIM_noRun(:,[1:lightLoc_Run(1)-1,lightLoc_Run(2)+1:nBin]);
out_POST_noRun = rateMap_POST_noRun(:,[1:lightLoc_Run(1)-1,lightLoc_Run(2)+1:nBin]);



