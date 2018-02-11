clearvars;
cd('D:\Dropbox\SNL\P2_Track');

load('D:\Dropbox\SNL\P2_Track\myParameters.mat');
formatOut = 'yymmdd';

markerS = 1.5;
dotS = 4;
colorGray = [100 100 100]./255;
colorLightGray = [240 240 240]./255;
colorDarkGray = [170 170 170]./255;

% 1cm win
% load('neuronList_ori50hz_180117.mat');
% load('neuronList_ori50hz_180128_bin5sd2.mat');
load('neuronList_ori50hz_180202.mat');
% load('neuronList_ori_180202.mat');
% lightLoc_Run = [32:93];
% lightLoc_RunCtrl = [1:31,94:124];
lightLoc_Run = [37:98];
lightLoc_RunCtrl = [1:36,99:124];
lightLoc_Rw = [63:124];
lightLoc_RwCtrl = [1:62];
% 2cm win
% load('neuronList_ori50hz_171219_2cm.mat');
% lightLoc_Run = [27 42];
% lightLoc_Rw = [48 53];

% 4cm win
% load('neuronList_ori50hz_171219_4cm.mat');
% lightLoc_Run = [14 21];
% lightLoc_Rw = [24 26];

freq = 50;
cri_spike = 50;
%%
% TN: track neuron
% tPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN';
% tPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
% tPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & cellfun(@(x) max(max(x)), T.pethconvSpatial)>cri_nanmeanFR; % nanmean firing rate > 1hz
% tPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR;
tPC_inRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & cellfun(@(x) sum(x(1:90)),T.inzoneSpike)>cri_spike; % mean firing rate > 1hz
tPC_outRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & cellfun(@(x) sum(x(1:90)),T.outCtrlSpike)>cri_spike; % mean firing rate > 1hz

ntPC_inRun = sum(double(tPC_inRun));
ntPC_outRun = sum(double(tPC_outRun));
% ntPC_DRun = sum(double(tPC_DRun));

% corr of total neurons
tPC_inRun_PRE = cell2mat(T.rateMap1D_PRE(tPC_inRun));
tPC_inRun_STM = cell2mat(T.rateMap1D_STM(tPC_inRun));
tPC_inRun_POST = cell2mat(T.rateMap1D_POST(tPC_inRun));
tPC_outRun_PRE = cell2mat(T.rateMap1D_PRE(tPC_outRun));
tPC_outRun_STM = cell2mat(T.rateMap1D_STM(tPC_outRun));
tPC_outRun_POST = cell2mat(T.rateMap1D_POST(tPC_outRun));

nBin_50hz = size(tPC_inRun_PRE,2);

%normalized
tPC_inRun_PRE = tPC_inRun_PRE./repmat(max(tPC_inRun_PRE,[],2),1,nBin_50hz);
tPC_inRun_STM = tPC_inRun_STM./repmat(max(tPC_inRun_STM,[],2),1,nBin_50hz);
tPC_inRun_POST = tPC_inRun_POST./repmat(max(tPC_inRun_POST,[],2),1,nBin_50hz);
tPC_outRun_PRE = tPC_outRun_PRE./repmat(max(tPC_outRun_PRE,[],2),1,nBin_50hz);
tPC_outRun_STM = tPC_outRun_STM./repmat(max(tPC_outRun_STM,[],2),1,nBin_50hz);
tPC_outRun_POST = tPC_outRun_POST./repmat(max(tPC_outRun_POST,[],2),1,nBin_50hz);

inlightZone_PRE_Run = tPC_inRun_PRE(:,lightLoc_Run);
inlightZone_STM_Run = tPC_inRun_STM(:,lightLoc_Run);
inlightZone_POST_Run = tPC_inRun_POST(:,lightLoc_Run);

outlightZone_PRE_Run = tPC_outRun_PRE(:,lightLoc_RunCtrl);
outlightZone_STM_Run = tPC_outRun_STM(:,lightLoc_RunCtrl);
outlightZone_POST_Run = tPC_outRun_POST(:,lightLoc_RunCtrl);

[rCorr_inRun_preXstm,rCorr_inRun_preXpost,rCorr_inRun_stmXpost] = deal([]);
[rCorr_outRun_preXstm,rCorr_outRun_preXpost,rCorr_outRun_stmXpost] = deal([]);

nBin_inlightRun = size(inlightZone_PRE_Run,2);
nBin_outlightRun = size(outlightZone_PRE_Run,2);

for iCell = 1:ntPC_inRun
    rCorr_inRun_preXstm(iCell,1) = corr(inlightZone_PRE_Run(iCell,:)',inlightZone_STM_Run(iCell,:)','rows','complete','type','Pearson');
    rCorr_inRun_preXpost(iCell,1) = corr(inlightZone_PRE_Run(iCell,:)',inlightZone_POST_Run(iCell,:)','rows','complete','type','Pearson');
    rCorr_inRun_stmXpost(iCell,1) = corr(inlightZone_STM_Run(iCell,:)',inlightZone_POST_Run(iCell,:)','rows','complete','type','Pearson');
end

for iCell = 1:ntPC_outRun
    rCorr_outRun_preXstm(iCell,1) = corr(outlightZone_PRE_Run(iCell,:)',outlightZone_STM_Run(iCell,:)','rows','complete','type','Pearson');
    rCorr_outRun_preXpost(iCell,1) = corr(outlightZone_PRE_Run(iCell,:)',outlightZone_POST_Run(iCell,:)','rows','complete','type','Pearson');
    rCorr_outRun_stmXpost(iCell,1) = corr(outlightZone_STM_Run(iCell,:)',outlightZone_POST_Run(iCell,:)','rows','complete','type','Pearson');
end

% rCorr_inRun_preXstm = rCorr_inRun_preXstm.^2;
% rCorr_inRun_preXpost = rCorr_inRun_preXpost.^2;
% rCorr_inRun_stmXpost = rCorr_inRun_stmXpost.^2;
% 
% rCorr_outRun_preXstm = rCorr_outRun_preXstm.^2;
% rCorr_outRun_preXpost = rCorr_outRun_preXpost.^2;
% rCorr_outRun_stmXpost = rCorr_outRun_stmXpost.^2;


%%
% tPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN';
% tPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
% tPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & cellfun(@(x) max(max(x)), T.pethconvSpatial)>cri_nanmeanFR; % nanmean firing rate > 1hz
tPC_inRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & cellfun(@(x) sum(x(1:90)),T.inzoneSpike)>cri_spike; % mean firing rate > 1hz
tPC_outRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & cellfun(@(x) sum(x(1:90)),T.outCtrlSpike)>cri_spike; % mean firing rate > 1hz
% tPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR;

ntPC_inRw = sum(double(tPC_inRw));
ntPC_outRw = sum(double(tPC_outRw));

% corr of total neurons
tPC_inRw_PRE = cell2mat(T.rateMap1D_PRE(tPC_inRw));
tPC_inRw_STM = cell2mat(T.rateMap1D_STM(tPC_inRw));
tPC_inRw_POST = cell2mat(T.rateMap1D_POST(tPC_inRw));
tPC_outRw_PRE = cell2mat(T.rateMap1D_PRE(tPC_outRw));
tPC_outRw_STM = cell2mat(T.rateMap1D_STM(tPC_outRw));
tPC_outRw_POST = cell2mat(T.rateMap1D_POST(tPC_outRw));

%normalized
tPC_inRw_PRE = tPC_inRw_PRE./repmat(max(tPC_inRw_PRE,[],2),1,nBin_50hz);
tPC_inRw_STM = tPC_inRw_STM./repmat(max(tPC_inRw_STM,[],2),1,nBin_50hz);
tPC_inRw_POST = tPC_inRw_POST./repmat(max(tPC_inRw_POST,[],2),1,nBin_50hz);
tPC_outRw_PRE = tPC_outRw_PRE./repmat(max(tPC_outRw_PRE,[],2),1,nBin_50hz);
tPC_outRw_STM = tPC_outRw_STM./repmat(max(tPC_outRw_STM,[],2),1,nBin_50hz);
tPC_outRw_POST = tPC_outRw_POST./repmat(max(tPC_outRw_POST,[],2),1,nBin_50hz);

inlightZone_PRE_Rw = tPC_inRw_PRE(:,lightLoc_Rw);
inlightZone_STM_Rw = tPC_inRw_STM(:,lightLoc_Rw);
inlightZone_POST_Rw = tPC_inRw_POST(:,lightLoc_Rw);
outlightZone_PRE_Rw = tPC_outRw_PRE(:,lightLoc_RwCtrl);
outlightZone_STM_Rw = tPC_outRw_STM(:,lightLoc_RwCtrl);
outlightZone_POST_Rw = tPC_outRw_POST(:,lightLoc_RwCtrl);

[rCorr_inRw_preXstm,rCorr_inRw_preXpost,rCorr_inRw_stmXpost] = deal([]);
[rCorr_outRw_preXstm,rCorr_outRw_preXpost,rCorr_outRw_stmXpost] = deal([]);

nBin_inlightRw = size(inlightZone_PRE_Rw,2);
nBin_outlightRw = size(outlightZone_PRE_Rw,2);

for iCell = 1:ntPC_inRw
    rCorr_inRw_preXstm(iCell,1) = corr(inlightZone_PRE_Rw(iCell,:)',inlightZone_STM_Rw(iCell,:)','rows','complete','type','Pearson');
    rCorr_inRw_preXpost(iCell,1) = corr(inlightZone_PRE_Rw(iCell,:)',inlightZone_POST_Rw(iCell,:)','rows','complete','type','Pearson');
    rCorr_inRw_stmXpost(iCell,1) = corr(inlightZone_STM_Rw(iCell,:)',inlightZone_POST_Rw(iCell,:)','rows','complete','type','Pearson');
end

for iCell = 1:ntPC_outRw
    rCorr_outRw_preXstm(iCell,1) = corr(outlightZone_PRE_Rw(iCell,:)',outlightZone_STM_Rw(iCell,:)','rows','complete','type','Pearson');
    rCorr_outRw_preXpost(iCell,1) = corr(outlightZone_PRE_Rw(iCell,:)',outlightZone_POST_Rw(iCell,:)','rows','complete','type','Pearson');
    rCorr_outRw_stmXpost(iCell,1) = corr(outlightZone_STM_Rw(iCell,:)',outlightZone_POST_Rw(iCell,:)','rows','complete','type','Pearson');
end

% rCorr_inRw_preXstm = rCorr_inRw_preXstm.^2;
% rCorr_inRw_preXpost = rCorr_inRw_preXpost.^2;
% rCorr_inRw_stmXpost = rCorr_inRw_stmXpost.^2;
% 
% rCorr_outRw_preXstm = rCorr_outRw_preXstm.^2;
% rCorr_outRw_preXpost = rCorr_outRw_preXpost.^2;
% rCorr_outRw_stmXpost = rCorr_outRw_stmXpost.^2;

%% noLight 
% load('neuronList_ori_171205.mat');
% load('neuronList_ori_171229.mat');
% load('neuronList_ori_180128_bin5sd2.mat');
load('neuronList_ori_180202.mat');
% load('neuronList_ori_171219_2cm.mat');
% load('neuronList_ori_171219_4cm.mat');

%%%% noRun %%%%
% tPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN';
% tPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
% tPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & cellfun(@(x) max(max(x)), T.pethconvSpatial)>cri_nanmeanFR; % nanmean firing rate > 1hz
% tPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR;
tPC_innoRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & cellfun(@(x) sum(x(1:90)),T.inzoneSpike)>cri_spike; % mean firing rate > 1hz
tPC_outnoRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & cellfun(@(x) sum(x(1:90)),T.outCtrlSpike)>cri_spike; % mean firing rate > 1hzntPC_innoRun = sum(double(tPC_innoRun));
ntPC_innoRun = sum(double(tPC_innoRun));
ntPC_outnoRun = sum(double(tPC_outnoRun));

innoRun_PRE = cell2mat(T.rateMap1D_PRE(tPC_innoRun));
innoRun_STM = cell2mat(T.rateMap1D_STM(tPC_innoRun));
innoRun_POST = cell2mat(T.rateMap1D_POST(tPC_innoRun));
outnoRun_PRE = cell2mat(T.rateMap1D_PRE(tPC_outnoRun));
outnoRun_STM = cell2mat(T.rateMap1D_STM(tPC_outnoRun));
outnoRun_POST = cell2mat(T.rateMap1D_POST(tPC_outnoRun));
nBin_ctrl = size(innoRun_PRE,2);

%normalized
innoRun_PRE = innoRun_PRE./repmat(max(innoRun_PRE,[],2),1,nBin_ctrl);
innoRun_STM = innoRun_STM./repmat(max(innoRun_STM,[],2),1,nBin_ctrl);
innoRun_POST = innoRun_POST./repmat(max(innoRun_POST,[],2),1,nBin_ctrl);
outnoRun_PRE = outnoRun_PRE./repmat(max(outnoRun_PRE,[],2),1,nBin_ctrl);
outnoRun_STM = outnoRun_STM./repmat(max(outnoRun_STM,[],2),1,nBin_ctrl);
outnoRun_POST = outnoRun_POST./repmat(max(outnoRun_POST,[],2),1,nBin_ctrl);

innoRun_PRE = innoRun_PRE(:,lightLoc_Run);
innoRun_STM = innoRun_STM(:,lightLoc_Run);
innoRun_POST = innoRun_POST(:,lightLoc_Run);
% outnoRun_PRE = outnoRun_PRE(:,ctrl_calib_run();
% outnoRun_STM = outnoRun_STM(:,ctrl_calib_run);
% outnoRun_POST = outnoRun_POST(:,ctrl_calib_run);
nBin_ctrlrun = size(innoRun_PRE,2);

[rCorr_innoRun_preXstm, rCorr_innoRun_preXpost, rCorr_innoRun_stmXpost] = deal([]);
for iCell = 1:ntPC_innoRun
    rCorr_innoRun_preXstm(iCell,1) = corr(innoRun_PRE(iCell,:)',innoRun_STM(iCell,:)','rows','complete','type','Pearson');
    rCorr_innoRun_preXpost(iCell,1) = corr(innoRun_PRE(iCell,:)',innoRun_POST(iCell,:)','rows','complete','type','Pearson');
    rCorr_innoRun_stmXpost(iCell,1) = corr(innoRun_STM(iCell,:)',innoRun_POST(iCell,:)','rows','complete','type','Pearson');
end
% rCorr_noRun_preXstm = rCorr_noRun_preXstm.^2;
% rCorr_noRun_preXpost = rCorr_noRun_preXpost.^2;
% rCorr_noRun_stmXpost = rCorr_noRun_stmXpost.^2;

% Run_a = T.path(tPC_innoRun);
% Run_b = T.cellID(tPC_innoRun);
% Run_c = rCorr_innoRun_stmXpost<0;
% plot_Track_multi_v3(Run_a(Run_c),Run_b(Run_c),'D:\Dropbox\SNL\P2_Track\example_lowSpatialCorr\noRun_lowRcor')


%%%% noRw %%%%
% tPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN';
% tPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
% tPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & cellfun(@(x) max(max(x)), T.pethconvSpatial)>cri_nanmeanFR; % nanmean firing rate > 1hz
tPC_innoRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & cellfun(@(x) sum(x(1:90)),T.inzoneSpike)>cri_spike; % mean firing rate > 1hz
tPC_outnoRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & cellfun(@(x) sum(x(1:90)),T.outCtrlSpike)>cri_spike; % mean firing rate > 1hzntPC_innoRun = sum(double(tPC_innoRun));
% tPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR;
ntPC_innoRw = sum(double(tPC_innoRw));
ntPC_outnoRw = sum(double(tPC_outnoRw));

innoRw_PRE = cell2mat(T.rateMap1D_PRE(tPC_innoRw));
innoRw_STM = cell2mat(T.rateMap1D_STM(tPC_innoRw));
innoRw_POST = cell2mat(T.rateMap1D_POST(tPC_innoRw));

%normalized
innoRw_PRE = innoRw_PRE./repmat(max(innoRw_PRE,[],2),1,nBin_ctrl);
innoRw_STM = innoRw_STM./repmat(max(innoRw_STM,[],2),1,nBin_ctrl);
innoRw_POST = innoRw_POST./repmat(max(innoRw_POST,[],2),1,nBin_ctrl);

innoRw_PRE = innoRw_PRE(:,lightLoc_Rw);
innoRw_STM = innoRw_STM(:,lightLoc_Rw);
innoRw_POST = innoRw_POST(:,lightLoc_Rw);
nBin_ctrlrw = size(innoRw_PRE,2);

[rCorr_innoRw_preXstm, rCorr_innoRw_preXpost, rCorr_innoRw_stmXpost] = deal([]);
for iCell = 1:ntPC_innoRw
    rCorr_innoRw_preXstm(iCell,1) = corr(innoRw_PRE(iCell,:)',innoRw_STM(iCell,:)','rows','complete','type','Pearson');
    rCorr_innoRw_preXpost(iCell,1) = corr(innoRw_PRE(iCell,:)',innoRw_POST(iCell,:)','rows','complete','type','Pearson');
    rCorr_innoRw_stmXpost(iCell,1) = corr(innoRw_STM(iCell,:)',innoRw_POST(iCell,:)','rows','complete','type','Pearson');
end
% rCorr_noRw_preXstm = rCorr_noRw_preXstm.^2;
% rCorr_noRw_preXpost = rCorr_noRw_preXpost.^2;
% rCorr_noRw_stmXpost = rCorr_noRw_stmXpost.^2;

% Rw_a = T.path(tPC_innoRw);
% Rw_b = T.cellID(tPC_innoRw);
% Rw_c = rCorr_innoRw_stmXpost<-0.5;
% plot_Track_multi_v3(Rw_a(Rw_c),Rw_b(Rw_c),'D:\Dropbox\SNL\P2_Track\example_lowSpatialCorr\noRw_lowRcor')

%% statistic
% group_Run = [ones(ntPC_DRun,1);2*ones(ntPC_DRun,1);3*ones(ntPC_noRun,1)];
% group_Rw = [ones(ntPC_DRw,1);2*ones(ntPC_DRw,1);3*ones(ntPC_noRw,1)];

% nanmean & sem
m_rCorr_inlight_Run = [nanmean(rCorr_inRun_preXstm), nanmean(rCorr_inRun_preXpost), nanmean(rCorr_inRun_stmXpost)];
sem_rCorr_inlight_Run = [nanstd(rCorr_inRun_preXstm,0,1)/sqrt(sum(double(~isnan(rCorr_inRun_preXstm)))), nanstd(rCorr_inRun_preXpost,0,1)/sqrt(sum(double(~isnan(rCorr_inRun_preXpost)))), nanstd(rCorr_inRun_stmXpost,0,1)/sqrt(sum(double(~isnan(rCorr_inRun_stmXpost))))];

m_rCorr_outlight_Run = [nanmean(rCorr_outRun_preXstm), nanmean(rCorr_outRun_preXpost), nanmean(rCorr_outRun_stmXpost)];
sem_rCorr_outlight_Run = [nanstd(rCorr_outRun_preXstm,0,1)/sqrt(sum(double(~isnan(rCorr_outRun_preXstm)))), nanstd(rCorr_outRun_preXpost,0,1)/sqrt(sum(double(~isnan(rCorr_outRun_preXpost)))), nanstd(rCorr_outRun_stmXpost,0,1)/sqrt(sum(double(~isnan(rCorr_outRun_stmXpost))))];

m_rCorr_inlight_Rw = [nanmean(rCorr_inRw_preXstm), nanmean(rCorr_inRw_preXpost), nanmean(rCorr_inRw_stmXpost)];
sem_rCorr_inlight_Rw = [nanstd(rCorr_inRw_preXstm,0,1)/sqrt(sum(double(~isnan(rCorr_inRw_preXstm)))), nanstd(rCorr_inRw_preXpost,0,1)/sqrt(sum(double(~isnan(rCorr_inRw_preXpost)))), nanstd(rCorr_inRw_stmXpost,0,1)/sqrt(sum(double(~isnan(rCorr_inRw_stmXpost))))];

m_rCorr_outlight_Rw = [nanmean(rCorr_outRw_preXstm), nanmean(rCorr_outRw_preXpost), nanmean(rCorr_outRw_stmXpost)];
sem_rCorr_outlight_Rw = [nanstd(rCorr_outRw_preXstm,0,1)/sqrt(sum(double(~isnan(rCorr_outRw_preXstm)))), nanstd(rCorr_outRw_preXpost,0,1)/sqrt(sum(double(~isnan(rCorr_outRw_preXpost)))), nanstd(rCorr_outRw_stmXpost,0,1)/sqrt(sum(double(~isnan(rCorr_outRw_stmXpost))))];

m_rCorr_noRun = [nanmean(rCorr_innoRun_preXstm), nanmean(rCorr_innoRun_preXpost), nanmean(rCorr_innoRun_stmXpost)];
sem_rCorr_noRun = [nanstd(rCorr_innoRun_preXstm,0,1)/sqrt(sum(double(~isnan(rCorr_innoRun_preXstm)))), nanstd(rCorr_innoRun_preXpost,0,1)/sqrt(sum(double(~isnan(rCorr_innoRun_preXpost)))), nanstd(rCorr_innoRun_stmXpost,0,1)/sqrt(sum(double(~isnan(rCorr_innoRun_stmXpost))))];

m_rCorr_noRw = [nanmean(rCorr_innoRw_preXstm), nanmean(rCorr_innoRw_preXpost), nanmean(rCorr_innoRw_stmXpost)];
sem_rCorr_noRw = [nanstd(rCorr_innoRw_preXstm,0,1)/sqrt(sum(double(~isnan(rCorr_innoRw_preXstm)))), nanstd(rCorr_innoRw_preXpost,0,1)/sqrt(sum(double(~isnan(rCorr_innoRw_preXpost)))), nanstd(rCorr_innoRw_stmXpost,0,1)/sqrt(sum(double(~isnan(rCorr_innoRw_stmXpost))))];

% Run session
[p_totalRun(1), table, stats] = kruskalwallis([rCorr_inRun_preXstm(~isnan(rCorr_inRun_preXstm)); rCorr_outRun_preXstm(~isnan(rCorr_outRun_preXstm)); rCorr_innoRun_preXstm(~isnan(rCorr_innoRun_preXstm))],[ones(sum(double(~isnan(rCorr_inRun_preXstm))),1); 2*ones(sum(double(~isnan(rCorr_outRun_preXstm))),1); 3*ones(sum(double(~isnan(rCorr_innoRun_preXstm))),1)],'off');
% result_Run = multcompare(stats,'ctype','bonferroni','Display','off');
result_Run = multcompare(stats,'ctype','lsd','Display','off');
p_Run(:,1) = result_Run(:,end);

[p_totalRun(2), table, stats] = kruskalwallis([rCorr_inRun_preXpost(~isnan(rCorr_inRun_preXpost)); rCorr_outRun_preXpost(~isnan(rCorr_outRun_preXpost)); rCorr_innoRun_preXpost(~isnan(rCorr_innoRun_preXpost))],[ones(sum(double(~isnan(rCorr_inRun_preXpost))),1); 2*ones(sum(double(~isnan(rCorr_outRun_preXpost))),1); 3*ones(sum(double(~isnan(rCorr_innoRun_preXpost))),1)],'off');
% result_Run = multcompare(stats,'ctype','bonferroni','Display','off');
result_Run = multcompare(stats,'ctype','lsd','Display','off');
p_Run(:,2) = result_Run(:,end);

[p_totalRun(3), table, stats] = kruskalwallis([rCorr_inRun_stmXpost(~isnan(rCorr_inRun_stmXpost)); rCorr_outRun_stmXpost(~isnan(rCorr_outRun_stmXpost)); rCorr_innoRun_stmXpost(~isnan(rCorr_innoRun_stmXpost))],[ones(sum(double(~isnan(rCorr_inRun_stmXpost))),1); 2*ones(sum(double(~isnan(rCorr_outRun_stmXpost))),1); 3*ones(sum(double(~isnan(rCorr_innoRun_stmXpost))),1)],'off');
% result_Run = multcompare(stats,'ctype','bonferroni','Display','off');
result_Run = multcompare(stats,'ctype','lsd','Display','off');
p_Run(:,3) = result_Run(:,end);

% Rw session
[p_totalRw(1), table, stats] = kruskalwallis([rCorr_inRw_preXstm(~isnan(rCorr_inRw_preXstm)); rCorr_outRw_preXstm(~isnan(rCorr_outRw_preXstm)); rCorr_innoRw_preXstm(~isnan(rCorr_innoRw_preXstm))],[ones(sum(double(~isnan(rCorr_inRw_preXstm))),1); 2*ones(sum(double(~isnan(rCorr_outRw_preXstm))),1); 3*ones(sum(double(~isnan(rCorr_innoRw_preXstm))),1)],'off');
% result_Rw = multcompare(stats,'ctype','bonferroni','Display','off');
result_Rw = multcompare(stats,'ctype','lsd','Display','off');
p_Rw(:,1) = result_Rw(:,end);

[p_totalRw(2), table, stats] = kruskalwallis([rCorr_inRw_preXpost(~isnan(rCorr_inRw_preXpost)); rCorr_outRw_preXpost(~isnan(rCorr_outRw_preXpost)); rCorr_innoRw_preXpost(~isnan(rCorr_innoRw_preXpost))],[ones(sum(double(~isnan(rCorr_inRw_preXpost))),1); 2*ones(sum(double(~isnan(rCorr_outRw_preXpost))),1); 3*ones(sum(double(~isnan(rCorr_innoRw_preXpost))),1)],'off');
% result_Rw = multcompare(stats,'ctype','bonferroni','Display','off');
result_Rw = multcompare(stats,'ctype','lsd','Display','off');
p_Rw(:,2) = result_Rw(:,end);

[p_totalRw(3), table, stats] = kruskalwallis([rCorr_inRw_stmXpost(~isnan(rCorr_inRw_stmXpost)); rCorr_outRw_stmXpost(~isnan(rCorr_outRw_stmXpost)); rCorr_innoRw_stmXpost(~isnan(rCorr_innoRw_stmXpost))],[ones(sum(double(~isnan(rCorr_inRw_stmXpost))),1); 2*ones(sum(double(~isnan(rCorr_outRw_stmXpost))),1); 3*ones(sum(double(~isnan(rCorr_innoRw_stmXpost))),1)],'off');
% result_Rw = multcompare(stats,'ctype','bonferroni','Display','off');
result_Rw = multcompare(stats,'ctype','lsd','Display','off');
p_Rw(:,3) = result_Rw(:,end);

%%
barWidth = 0.18;
% barWidth = 0.8;
eBarLength = 0.3;
eBarWidth = 0.8;
eBarColor = colorBlack;
nCol = 3;
nRow = 5;

xScatterRunIn = (rand(ntPC_inRun,1)-0.5)*barWidth*2.2;
xScatterRunOut = (rand(ntPC_outRun,1)-0.5)*barWidth*2.2;
xScatterRwIn = (rand(ntPC_inRw,1)-0.5)*barWidth*2.2;
xScatterRwOut = (rand(ntPC_outRw,1)-0.5)*barWidth*2.2;
xScatterNoRun = (rand(ntPC_innoRun,1)-0.5)*barWidth*2.2;
xScatterNoRw = (rand(ntPC_innoRw,1)-0.5)*barWidth*2.2;

fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});

hPVCorr(1) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
bar([1,5,9],m_rCorr_inlight_Run,barWidth,'faceColor',colorLLightBlue);
hold on;
errorbarJun([1,5,9],m_rCorr_inlight_Run,sem_rCorr_inlight_Run,0.3,1.0,colorBlack);
hold on;
bar([2,6,10],m_rCorr_outlight_Run,barWidth,'faceColor',colorLightGray)
hold on;
errorbarJun([2,6,10],m_rCorr_outlight_Run,sem_rCorr_outlight_Run,0.3,1.0,colorBlack);
hold on;
bar([3,7,11],m_rCorr_noRun,barWidth,'faceColor',colorDarkGray)
hold on;
errorbarJun([3,7,11],m_rCorr_noRun,sem_rCorr_noRun,0.3,1.0,colorBlack);
hold on;

plot(1+xScatterRunIn, rCorr_inRun_preXstm, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(2+xScatterRunOut, rCorr_outRun_preXstm, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(3+xScatterNoRun, rCorr_innoRun_preXstm, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;

plot(5+xScatterRunIn, rCorr_inRun_preXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(6+xScatterRunOut, rCorr_outRun_preXpost,'.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(7+xScatterNoRun, rCorr_innoRun_preXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;

plot(9+xScatterRunIn, rCorr_inRun_stmXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(10+xScatterRunOut, rCorr_outRun_stmXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(11+xScatterNoRun, rCorr_innoRun_stmXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;

title('Run','fontSize',fontM);
ylabel('Spatial correlation','fontSize',fontM);

text(0.5, -1.9,['p12 = ',num2str(p_Run(1,1),3)],'fontSize',fontM,'color',colorBlack);
text(0.5, -2.1,['p13 = ',num2str(p_Run(2,1),3)],'fontSize',fontM,'color',colorBlack);
text(0.5, -2.3,['p23 = ',num2str(p_Run(3,1),3)],'fontSize',fontM,'color',colorBlack);

text(5.5, -1.9,[num2str(p_Run(1,2),3)],'fontSize',fontM,'color',colorBlack);
text(5.5, -2.1,[num2str(p_Run(2,2),3)],'fontSize',fontM,'color',colorBlack);
text(5.5, -2.3,[num2str(p_Run(3,2),3)],'fontSize',fontM,'color',colorBlack);

text(9.5, -1.9,[num2str(p_Run(1,3),3)],'fontSize',fontM,'color',colorBlack);
text(9.5, -2.1,[num2str(p_Run(2,3),3)],'fontSize',fontM,'color',colorBlack);
text(9.5, -2.3,[num2str(p_Run(3,3),3)],'fontSize',fontM,'color',colorBlack);


hPVCorr(2) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,2,1,[0.15 0.1 0.85 0.85],midInterval),wideInterval));
bar([1,5,9],m_rCorr_inlight_Rw,barWidth,'faceColor',colorLLightBlue);
hold on;
errorbarJun([1,5,9],m_rCorr_inlight_Rw,sem_rCorr_inlight_Rw,0.3,1.0,colorBlack);
hold on;
bar([2,6,10],m_rCorr_outlight_Rw,barWidth,'faceColor',colorLightGray)
hold on;
errorbarJun([2,6,10],m_rCorr_outlight_Rw,sem_rCorr_outlight_Rw,0.3,1.0,colorBlack);
hold on;
bar([3,7,11],m_rCorr_noRw,barWidth,'faceColor',colorDarkGray)
hold on;
errorbarJun([3,7,11],m_rCorr_noRw,sem_rCorr_noRw,0.3,1.0,colorBlack);
hold on;

plot(1+xScatterRwIn, rCorr_inRw_preXstm, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(2+xScatterRwOut, rCorr_outRw_preXstm, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(3+xScatterNoRw, rCorr_innoRw_preXstm, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;

plot(5+xScatterRwIn, rCorr_inRw_preXpost,'.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(6+xScatterRwOut, rCorr_outRw_preXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(7+xScatterNoRw, rCorr_innoRw_preXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;

plot(9+xScatterRwIn, rCorr_inRw_stmXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(10+xScatterRwOut, rCorr_outRw_stmXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(11+xScatterNoRw, rCorr_innoRw_stmXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
 
title('Rw','fontSize',fontM);
ylabel('Spatial correlation','fontSize',fontM);

text(0.5, -1.9,['p12 = ',num2str(p_Rw(1,1),3)],'fontSize',fontM,'color',colorBlack);
text(0.5, -2.1,['p13 = ',num2str(p_Rw(2,1),3)],'fontSize',fontM,'color',colorBlack);
text(0.5, -2.3,['p23 = ',num2str(p_Rw(3,1),3)],'fontSize',fontM,'color',colorBlack);

text(5.5, -1.9,[num2str(p_Rw(1,2),3)],'fontSize',fontM,'color',colorBlack);
text(5.5, -2.1,[num2str(p_Rw(2,2),3)],'fontSize',fontM,'color',colorBlack);
text(5.5, -2.3,[num2str(p_Rw(3,2),3)],'fontSize',fontM,'color',colorBlack);

text(9.5, -1.9,[num2str(p_Rw(1,3),3)],'fontSize',fontM,'color',colorBlack);
text(9.5, -2.1,[num2str(p_Rw(2,3),3)],'fontSize',fontM,'color',colorBlack);
text(9.5, -2.3,[num2str(p_Rw(3,3),3)],'fontSize',fontM,'color',colorBlack);

set(hPVCorr(1),'TickDir','out','Box','off','XLim',[0,12],'YLim',[-1.15 1.15],'XTick',[2, 6, 10],'XTickLabel',[{'PRExSTIM','PRExPOST','STIMxPOST'}],'fontSize',fontM);
set(hPVCorr(2),'TickDir','out','Box','off','XLim',[0,12],'YLim',[-1.15 1.15],'XTick',[2, 6, 10],'XTickLabel',[{'PRExSTIM','PRExPOST','STIMxPOST'}],'fontSize',fontM);
set(hPVCorr,'TickLength',[0.03, 0.03]);

print('-painters','-r300','-dtiff',['f_Neuron_SpatialCorr_',datestr(now,formatOut),'_',num2str(freq),'_half_threshold_',num2str(cri_spike),'.tif']);
% print('-painters','-r300','-depsc',['f_CellRepors_PVCorr_8Hz_',datestr(now,formatOut),'.ai']);
close;