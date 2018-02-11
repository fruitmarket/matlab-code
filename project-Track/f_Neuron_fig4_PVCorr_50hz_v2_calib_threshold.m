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
% load('neuronList_ori50hz_171229.mat');
load('neuronList_ori50hz_180125_bin5sd2.mat');
lightLoc_Run = [floor(20*pi*5/6) ceil(20*pi*8/6)];
lightLoc_Rw = [floor(20*pi*9/6) ceil(20*pi*10/6)];
% location calibration (opposite side of light stimulation zone)
ctrl_calib_run = [1:ceil(20*2/6*pi)+1, floor(20*11/6*pi)-1:124];
ctrl_calib_rw = floor(20*3/6*pi):ceil(20*4/6*pi);

% 2cm win
% load('neuronList_ori50hz_171219_2cm.mat');
% lightLoc_Run = [27 42];
% lightLoc_Rw = [48 53];

% 4cm win
% load('neuronList_ori50hz_171219_4cm.mat');
% lightLoc_Run = [14 21];
% lightLoc_Rw = [24 26];

cri_meanFR = 1;
cri_spike = 100;

%%
% TN: track neuron
% tPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN';
% tPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
% tPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & cellfun(@(x) max(max(x)), T.pethconvSpatial)>cri_meanFR; % mean firing rate > 1hz
tPC_inRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & cellfun(@(x) sum(x), T.inzoneSpike) > cri_spike; % mean firing rate > 1hz
tPC_outRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & cellfun(@(x) sum(x), T.outzoneSpike) > cri_spike; % mean firing rate > 1hz
% tPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR;

ntPC_inRun = sum(double(tPC_inRun));
ntPC_outRun = sum(double(tPC_outRun));

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

inlightZone_PRE_Run = tPC_inRun_PRE(:,lightLoc_Run(1):lightLoc_Run(2));
inlightZone_STM_Run = tPC_inRun_STM(:,lightLoc_Run(1):lightLoc_Run(2));
inlightZone_POST_Run = tPC_inRun_POST(:,lightLoc_Run(1):lightLoc_Run(2));
outlightZone_PRE_Run = tPC_outRun_PRE(:,ctrl_calib_run);
outlightZone_STM_Run = tPC_outRun_STM(:,ctrl_calib_run);
outlightZone_POST_Run = tPC_outRun_POST(:,ctrl_calib_run);

[pvCorr_inRun_preXstm,pvCorr_inRun_preXpost,pvCorr_inRun_stmXpost] = deal([]);
[pvCorr_outRun_preXstm,pvCorr_outRun_preXpost,pvCorr_outRun_stmXpost] = deal([]);

nBin_inlightRun = size(inlightZone_PRE_Run,2);
nBin_outlightRun = size(outlightZone_PRE_Run,2);

for iCol = 1:nBin_inlightRun
    pvCorr_inRun_preXstm(iCol) = corr(inlightZone_PRE_Run(:,iCol),inlightZone_STM_Run(:,iCol),'rows','complete','type','Pearson');
    pvCorr_inRun_preXpost(iCol) = corr(inlightZone_PRE_Run(:,iCol),inlightZone_POST_Run(:,iCol),'rows','complete','type','Pearson');
    pvCorr_inRun_stmXpost(iCol) = corr(inlightZone_STM_Run(:,iCol),inlightZone_POST_Run(:,iCol),'rows','complete','type','Pearson');
end

for iCol = 1:nBin_outlightRun
    pvCorr_outRun_preXstm(iCol) = corr(outlightZone_PRE_Run(:,iCol),outlightZone_STM_Run(:,iCol),'rows','complete','type','Pearson');
    pvCorr_outRun_preXpost(iCol) = corr(outlightZone_PRE_Run(:,iCol),outlightZone_POST_Run(:,iCol),'rows','complete','type','Pearson');
    pvCorr_outRun_stmXpost(iCol) = corr(outlightZone_STM_Run(:,iCol),outlightZone_POST_Run(:,iCol),'rows','complete','type','Pearson');
end

%%
% tPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN';
% tPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
tPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & cellfun(@(x) max(max(x)), T.pethconvSpatial)>cri_meanFR; % mean firing rate > 1hz
tPC_inRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & cellfun(@(x) sum(x), T.inzoneSpike) > cri_spike; % mean firing rate > 1hz
tPC_outRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & cellfun(@(x) sum(x), T.outzoneSpike) > cri_spike; % mean firing rate > 1hz
% tPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR;

ntPC_DRw = sum(double(tPC_DRw));

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

inlightZone_PRE_Rw = tPC_inRw_PRE(:,lightLoc_Rw(1):lightLoc_Rw(2));
inlightZone_STM_Rw = tPC_inRw_STM(:,lightLoc_Rw(1):lightLoc_Rw(2));
inlightZone_POST_Rw = tPC_inRw_POST(:,lightLoc_Rw(1):lightLoc_Rw(2));

outlightZone_PRE_Rw = tPC_outRw_PRE(:,ctrl_calib_rw);
outlightZone_STM_Rw = tPC_outRw_STM(:,ctrl_calib_rw);
outlightZone_POST_Rw = tPC_outRw_POST(:,ctrl_calib_rw);

[pvCorr_inRw_preXstm,pvCorr_inRw_preXpost,pvCorr_inRw_stmXpost] = deal([]);
[pvCorr_outRw_preXstm,pvCorr_outRw_preXpost,pvCorr_outRw_stmXpost] = deal([]);

nBin_inlightRw = size(inlightZone_PRE_Rw,2);
nBin_outlightRw = size(outlightZone_PRE_Rw,2);

for iCol = 1:nBin_inlightRw
    pvCorr_inRw_preXstm(iCol) = corr(inlightZone_PRE_Rw(:,iCol),inlightZone_STM_Rw(:,iCol),'rows','complete','type','Pearson');
    pvCorr_inRw_preXpost(iCol) = corr(inlightZone_PRE_Rw(:,iCol),inlightZone_POST_Rw(:,iCol),'rows','complete','type','Pearson');
    pvCorr_inRw_stmXpost(iCol) = corr(inlightZone_STM_Rw(:,iCol),inlightZone_POST_Rw(:,iCol),'rows','complete','type','Pearson');
end

for iCol = 1:nBin_outlightRw
    pvCorr_outRw_preXstm(iCol) = corr(outlightZone_PRE_Rw(:,iCol),outlightZone_STM_Rw(:,iCol),'rows','complete','type','Pearson');
    pvCorr_outRw_preXpost(iCol) = corr(outlightZone_PRE_Rw(:,iCol),outlightZone_POST_Rw(:,iCol),'rows','complete','type','Pearson');
    pvCorr_outRw_stmXpost(iCol) = corr(outlightZone_STM_Rw(:,iCol),outlightZone_POST_Rw(:,iCol),'rows','complete','type','Pearson');
end

%% noLight 
% load('neuronList_ori_171205.mat');
% load('neuronList_ori_171229.mat');
load('neuronList_ori_180125_bin5sd2.mat');
% load('neuronList_ori_171219_2cm.mat');
% load('neuronList_ori_171219_4cm.mat');

%%%% noRun %%%%
% tPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN';
% tPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
% tPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & cellfun(@(x) max(max(x)), T.pethconvSpatial)>cri_meanFR; % mean firing rate > 1hz
tPC_innoRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & cellfun(@(x) sum(x), T.inzoneSpike) > cri_spike; % mean firing rate > 1hz
tPC_outnoRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & cellfun(@(x) sum(x), T.outzoneSpike) > cri_spike; % mean firing rate > 1hz
% tPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR;

ntPC_noRun = sum(double(tPC_innoRun));

innoRun_PRE = cell2mat(T.rateMap1D_PRE(tPC_innoRun));
innoRun_STM = cell2mat(T.rateMap1D_STM(tPC_innoRun));
innoRun_POST = cell2mat(T.rateMap1D_POST(tPC_innoRun));
outnoRun_PRE = cell2mat(T.rateMap1D_PRE(tPC_innoRun));
outnoRun_STM = cell2mat(T.rateMap1D_STM(tPC_innoRun));
outnoRun_POST = cell2mat(T.rateMap1D_POST(tPC_innoRun));
nBin_ctrl = size(innoRun_PRE,2);

%normalized
innoRun_PRE = innoRun_PRE./repmat(max(innoRun_PRE,[],2),1,nBin_ctrl);
innoRun_STM = innoRun_STM./repmat(max(innoRun_STM,[],2),1,nBin_ctrl);
innoRun_POST = innoRun_POST./repmat(max(innoRun_POST,[],2),1,nBin_ctrl);
outnoRun_PRE = outnoRun_PRE./repmat(max(outnoRun_PRE,[],2),1,nBin_ctrl);
outnoRun_STM = outnoRun_STM./repmat(max(outnoRun_STM,[],2),1,nBin_ctrl);
outnoRun_POST = outnoRun_POST./repmat(max(outnoRun_POST,[],2),1,nBin_ctrl);

innoRun_PRE = innoRun_PRE(:,ctrl_calib_run);
innoRun_STM = innoRun_STM(:,ctrl_calib_run);
innoRun_POST = innoRun_POST(:,ctrl_calib_run);
outnoRun_PRE = outnoRun_PRE(:,ctrl_calib_run);
outnoRun_STM = outnoRun_STM(:,ctrl_calib_run);
outnoRun_POST = outnoRun_POST(:,ctrl_calib_run);
nBin_ctrlrun = size(innoRun_PRE,2);

[pvCorr_innoRun_preXstm, pvCorr_innoRun_preXpost, pvCorr_innoRun_stmXpost] = deal([]);
for iCol = 1:nBin_ctrlrun
    pvCorr_innoRun_preXstm(iCol) = corr(innoRun_PRE(:,iCol),innoRun_STM(:,iCol),'rows','complete','type','Pearson');
    pvCorr_innoRun_preXpost(iCol) = corr(innoRun_PRE(:,iCol),innoRun_POST(:,iCol),'rows','complete','type','Pearson');
    pvCorr_innoRun_stmXpost(iCol) = corr(innoRun_STM(:,iCol),innoRun_POST(:,iCol),'rows','complete','type','Pearson');
end

%%%% noRw %%%%
% tPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN';
% tPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
% tPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & cellfun(@(x) max(max(x)), T.pethconvSpatial)>cri_meanFR; % mean firing rate > 1hz
tPC_innoRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & cellfun(@(x) sum(x), T.inzoneSpike) > cri_spike; % mean firing rate > 1hz
tPC_outnoRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & cellfun(@(x) sum(x), T.outzoneSpike) > cri_spike; % mean firing rate > 1hz
% tPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR;
ntPC_noRw = sum(double(tPC_innoRw));

innoRw_PRE = cell2mat(T.rateMap1D_PRE(tPC_innoRw));
innoRw_STM = cell2mat(T.rateMap1D_STM(tPC_innoRw));
innoRw_POST = cell2mat(T.rateMap1D_POST(tPC_innoRw));

%normalized
innoRw_PRE = innoRw_PRE./repmat(max(innoRw_PRE,[],2),1,nBin_ctrl);
innoRw_STM = innoRw_STM./repmat(max(innoRw_STM,[],2),1,nBin_ctrl);
innoRw_POST = innoRw_POST./repmat(max(innoRw_POST,[],2),1,nBin_ctrl);

innoRw_PRE = innoRw_PRE(:,ctrl_calib_rw);
innoRw_STM = innoRw_STM(:,ctrl_calib_rw);
innoRw_POST = innoRw_POST(:,ctrl_calib_rw);
nBin_ctrlrw = size(innoRw_PRE,2);
[pvCorr_innoRw_preXstm, pvCorr_innoRw_preXpost, pvCorr_innoRw_stmXpost] = deal([]);
for iCol = 1:nBin_ctrlrw
    pvCorr_innoRw_preXstm(iCol) = corr(innoRw_PRE(:,iCol),innoRw_STM(:,iCol),'rows','complete','type','Pearson');
    pvCorr_innoRw_preXpost(iCol) = corr(innoRw_PRE(:,iCol),innoRw_POST(:,iCol),'rows','complete','type','Pearson');
    pvCorr_innoRw_stmXpost(iCol) = corr(innoRw_STM(:,iCol),innoRw_POST(:,iCol),'rows','complete','type','Pearson');
end

%% statistic
group_InRun = [ones(nBin_inlightRun,1);2*ones(nBin_inlightRun,1);3*ones(nBin_inlightRun,1)];
group_OutRun = [ones(nBin_outlightRun,1);2*ones(nBin_outlightRun,1);3*ones(nBin_outlightRun,1)];
group_ctrl = [ones(nBin_ctrl,1);2*ones(nBin_ctrl,1);3*ones(nBin_ctrl,1)];
group_InRw = [ones(nBin_inlightRw,1);2*ones(nBin_inlightRw,1);3*ones(nBin_inlightRw,1)];
group_OutRw = [ones(nBin_outlightRw,1);2*ones(nBin_outlightRw,1);3*ones(nBin_outlightRw,1)];
group_ctrlrun = [ones(nBin_ctrlrun,1);2*ones(nBin_ctrlrun,1);3*ones(nBin_ctrlrun,1)];
group_ctrlrw = [ones(nBin_ctrlrw,1);2*ones(nBin_ctrlrw,1);3*ones(nBin_ctrlrw,1)];

% mean & sem
m_pvCorr_inlight_Run = [mean(pvCorr_inRun_preXstm), mean(pvCorr_inRun_preXpost), mean(pvCorr_inRun_stmXpost)];
sem_pvCorr_inlight_Run = [std(pvCorr_inRun_preXstm,0,2)/sqrt(nBin_inlightRun), std(pvCorr_inRun_preXpost,0,2)/sqrt(nBin_inlightRun), std(pvCorr_inRun_stmXpost,0,2)/sqrt(nBin_inlightRun)];

m_pvCorr_outlight_Run = [mean(pvCorr_outRun_preXstm), mean(pvCorr_outRun_preXpost), mean(pvCorr_outRun_stmXpost)];
sem_pvCorr_outlight_Run = [std(pvCorr_outRun_preXstm,0,2)/sqrt(nBin_outlightRun), std(pvCorr_outRun_preXpost,0,2)/sqrt(nBin_outlightRun), std(pvCorr_outRun_stmXpost,0,2)/sqrt(nBin_outlightRun)];

m_pvCorr_inlight_Rw = [mean(pvCorr_inRw_preXstm), mean(pvCorr_inRw_preXpost), mean(pvCorr_inRw_stmXpost)];
sem_pvCorr_inlight_Rw = [std(pvCorr_inRw_preXstm,0,2)/sqrt(nBin_inlightRw), std(pvCorr_inRw_preXpost,0,2)/sqrt(nBin_inlightRw), std(pvCorr_inRw_stmXpost,0,2)/sqrt(nBin_inlightRw)];

m_pvCorr_outlight_Rw = [mean(pvCorr_outRw_preXstm), mean(pvCorr_outRw_preXpost), mean(pvCorr_outRw_stmXpost)];
sem_pvCorr_outlight_Rw = [std(pvCorr_outRw_preXstm,0,2)/sqrt(nBin_outlightRw), std(pvCorr_outRw_preXpost,0,2)/sqrt(nBin_outlightRw), std(pvCorr_outRw_stmXpost,0,2)/sqrt(nBin_outlightRw)];

m_pvCorr_noRun = [mean(pvCorr_innoRun_preXstm), mean(pvCorr_innoRun_preXpost), mean(pvCorr_innoRun_stmXpost)];
sem_pvCorr_noRun = [std(pvCorr_innoRun_preXstm,0,2)/sqrt(nBin_ctrl), std(pvCorr_innoRun_preXpost,0,2)/sqrt(nBin_ctrl), std(pvCorr_innoRun_stmXpost,0,2)/sqrt(nBin_ctrl)];

m_pvCorr_noRw = [mean(pvCorr_innoRw_preXstm), mean(pvCorr_innoRw_preXpost), mean(pvCorr_innoRw_stmXpost)];
sem_pvCorr_noRw = [std(pvCorr_innoRw_preXstm,0,2)/sqrt(nBin_ctrl), std(pvCorr_innoRw_preXpost,0,2)/sqrt(nBin_ctrl), std(pvCorr_innoRw_stmXpost,0,2)/sqrt(nBin_ctrl)];

% Run session
[p_totalRun(1), table, stats] = friedman([pvCorr_inRun_preXstm',pvCorr_inRun_preXpost',pvCorr_inRun_stmXpost'],1,'off');
% [p_totalRun(1), table, stats] = friedman([pvCorr_inRun_preXstm,pvCorr_outRun_preXstm,pvCorr_noRun_preXstm],group_Run,'off');
% result_Run = multcompare(stats,'ctype','hsd','Display','off');
% result_Run = multcompare(stats,'ctype','bonferroni','Display','off');
result_Run = multcompare(stats,'ctype','lsd','Display','off');
p_Run(:,1) = result_Run(:,end);

[p_totalRun(2), table, stats] = friedman([pvCorr_outRun_preXstm',pvCorr_outRun_preXpost',pvCorr_outRun_stmXpost'],1,'off');
% [p_totalRun(2), table, stats] = friedman([pvCorr_inRun_preXpost,pvCorr_outRun_preXpost,pvCorr_noRun_preXpost],group_Run,'off');
% result_Run = multcompare(stats,'ctype','hsd','Display','off');
% result_Run = multcompare(stats,'ctype','bonferroni','Display','off');
result_Run = multcompare(stats,'ctype','lsd','Display','off');
p_Run(:,2) = result_Run(:,end);

[p_totalRun(3), table, stats] = friedman([pvCorr_innoRun_preXstm',pvCorr_innoRun_preXpost',pvCorr_innoRun_stmXpost'],1,'off');
% [p_totalRun(3), table, stats] = friedman([pvCorr_noRun_preXstm,pvCorr_noRun_preXpost,pvCorr_noRun_stmXpost],group_ctrl,'off');
% result_Run = multcompare(stats,'ctype','hsd','Display','off');
% result_Run = multcompare(stats,'ctype','bonferroni','Display','off');
result_Run = multcompare(stats,'ctype','lsd','Display','off');
p_Run(:,3) = result_Run(:,end);

% Rw session
[p_totalRw(1), table, stats] = friedman([pvCorr_inRw_preXstm',pvCorr_inRw_preXpost',pvCorr_inRw_stmXpost'],1,'off');
% [p_totalRw(1), table, stats] = friedman([pvCorr_inRw_preXstm,pvCorr_outRw_preXstm,pvCorr_noRw_preXstm],group_Rw,'off');
% result_Rw = multcompare(stats,'ctype','hsd','Display','off');
% result_Rw = multcompare(stats,'ctype','bonferroni','Display','off');
result_Rw = multcompare(stats,'ctype','lsd','Display','off');
p_Rw(:,1) = result_Rw(:,end);

[p_totalRw(2), table, stats] = friedman([pvCorr_outRw_preXstm',pvCorr_outRw_preXpost',pvCorr_outRw_stmXpost'],1,'off');
% [p_totalRw(2), table, stats] = friedman([pvCorr_inRw_preXpost,pvCorr_outRw_preXpost,pvCorr_noRw_preXpost],group_Rw,'off');
% result_Rw = multcompare(stats,'ctype','hsd','Display','off');
% result_Rw = multcompare(stats,'ctype','bonferroni','Display','off');
result_Rw = multcompare(stats,'ctype','lsd','Display','off');
p_Rw(:,2) = result_Rw(:,end);

[p_totalRw(3), table, stats] = friedman([pvCorr_innoRw_preXstm',pvCorr_innoRw_preXpost',pvCorr_innoRw_stmXpost'],1,'off');
% [p_totalRw(3), table, stats] = friedman([pvCorr_inRw_stmXpost,pvCorr_outRw_stmXpost,pvCorr_noRw_stmXpost],group_Rw,'off');
% result_Rw = multcompare(stats,'ctype','hsd','Display','off');
% result_Rw = multcompare(stats,'ctype','bonferroni','Display','off');
result_Rw = multcompare(stats,'ctype','lsd','Display','off');
p_Rw(:,3) = result_Rw(:,end);


%%
% barWidth = 0.18;
barWidth = 0.8;
eBarLength = 0.3;
eBarWidth = 0.8;
eBarColor = colorBlack;
nCol = 3;
nRow = 5;

xScatterRunIn = (rand(nBin_inlightRun,1)-0.5)*barWidth*0.5;
xScatterRunOut = (rand(nBin_outlightRun,1)-0.5)*barWidth*0.5;
xScatterRwIn = (rand(nBin_inlightRw,1)-0.5)*barWidth*0.5;
xScatterRwOut = (rand(nBin_outlightRw,1)-0.5)*barWidth*0.5;
xScatterTotal = (rand(nBin_ctrl,1)-0.5)*barWidth*0.5;
xScatterTotalrun = (rand(nBin_ctrlrun,1)-0.5)*barWidth*0.5;
xScatterTotalrw = (rand(nBin_ctrlrw,1)-0.5)*barWidth*0.5;

fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});

hPVCorr(1) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
bar([1,2,3],m_pvCorr_inlight_Run,barWidth,'faceColor',colorLLightBlue);
hold on;
errorbarJun([1,2,3],m_pvCorr_inlight_Run,sem_pvCorr_inlight_Run,0.3,1.0,colorBlack);
hold on;
bar([5,6,7],m_pvCorr_outlight_Run,barWidth,'faceColor',colorLightGray)
hold on;
errorbarJun([5,6,7],m_pvCorr_outlight_Run,sem_pvCorr_inlight_Run,0.3,1.0,colorBlack);
hold on;
bar([9,10,11],m_pvCorr_noRun,barWidth,'faceColor',colorDarkGray)
hold on;
errorbarJun([9,10,11],m_pvCorr_noRun,sem_pvCorr_noRun,0.3,1.0,colorBlack);
hold on;

plot(1+xScatterRunIn, pvCorr_inRun_preXstm, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(2+xScatterRunIn, pvCorr_inRun_preXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(3+xScatterRunIn, pvCorr_inRun_stmXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;

plot(5+xScatterRunOut, pvCorr_outRun_preXstm, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(6+xScatterRunOut, pvCorr_outRun_preXpost,'.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(7+xScatterRunOut, pvCorr_outRun_stmXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;

plot(9+xScatterTotalrun, pvCorr_innoRun_preXstm, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(10+xScatterTotalrun, pvCorr_innoRun_preXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(11+xScatterTotalrun, pvCorr_innoRun_stmXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;

title('Run','fontSize',fontM);
ylabel('PV correlation','fontSize',fontM);

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
bar([1,2,3],m_pvCorr_inlight_Rw,barWidth,'faceColor',colorLLightBlue);
hold on;
errorbarJun([1,2,3],m_pvCorr_inlight_Rw,sem_pvCorr_inlight_Rw,0.3,1.0,colorBlack);
hold on;
bar([5,6,7],m_pvCorr_outlight_Rw,barWidth,'faceColor',colorLightGray)
hold on;
errorbarJun([5,6,7],m_pvCorr_outlight_Rw,sem_pvCorr_inlight_Run,0.3,1.0,colorBlack);
hold on;
bar([9,10,11],m_pvCorr_noRw,barWidth,'faceColor',colorDarkGray)
hold on;
errorbarJun([9,10,11],m_pvCorr_noRw,sem_pvCorr_noRw,0.3,1.0,colorBlack);
hold on;

plot(1+xScatterRwIn, pvCorr_inRw_preXstm, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(2+xScatterRwIn, pvCorr_inRw_preXpost,'.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(3+xScatterRwIn, pvCorr_inRw_stmXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;

plot(5+xScatterRwOut, pvCorr_outRw_preXstm, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(6+xScatterRwOut, pvCorr_outRw_preXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(7+xScatterRwOut, pvCorr_outRw_stmXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;

plot(9+xScatterTotalrw, pvCorr_innoRw_preXstm, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(10+xScatterTotalrw, pvCorr_innoRw_preXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(11+xScatterTotalrw, pvCorr_innoRw_stmXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
 
title('Rw','fontSize',fontM);
ylabel('PV correlation','fontSize',fontM);

text(0.5, -1.9,['p12 = ',num2str(p_Rw(1,1),3)],'fontSize',fontM,'color',colorBlack);
text(0.5, -2.1,['p13 = ',num2str(p_Rw(2,1),3)],'fontSize',fontM,'color',colorBlack);
text(0.5, -2.3,['p23 = ',num2str(p_Rw(3,1),3)],'fontSize',fontM,'color',colorBlack);

text(5.5, -1.9,[num2str(p_Rw(1,2),3)],'fontSize',fontM,'color',colorBlack);
text(5.5, -2.1,[num2str(p_Rw(2,2),3)],'fontSize',fontM,'color',colorBlack);
text(5.5, -2.3,[num2str(p_Rw(3,2),3)],'fontSize',fontM,'color',colorBlack);

text(9.5, -1.9,[num2str(p_Rw(1,3),3)],'fontSize',fontM,'color',colorBlack);
text(9.5, -2.1,[num2str(p_Rw(2,3),3)],'fontSize',fontM,'color',colorBlack);
text(9.5, -2.3,[num2str(p_Rw(3,3),3)],'fontSize',fontM,'color',colorBlack);

set(hPVCorr(1),'TickDir','out','Box','off','XLim',[0,12],'YLim',[-1.15 1.15],'XTick',[2, 6, 10],'XTickLabel',[{'In-zone','Out-zone','Control'}],'fontSize',fontM);
set(hPVCorr(2),'TickDir','out','Box','off','XLim',[0,12],'YLim',[-1.15 1.15],'XTick',[2, 6, 10],'XTickLabel',[{'In-zone','Out-zone','Control'}],'fontSize',fontM);
set(hPVCorr,'TickLength',[0.03, 0.03]);

print('-painters','-r300','-dtiff',['f_Neuron_PVCorr_',datestr(now,formatOut),'_50Hz_zone_bin5sd2_calib_threshold','.tif']);
% print('-painters','-r300','-depsc',['f_CellRepors_PVCorr_8Hz_',datestr(now,formatOut),'.ai']);
close;