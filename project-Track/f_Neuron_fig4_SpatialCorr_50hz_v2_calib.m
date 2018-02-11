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

cri_nanmeanFR = 1;

%%
% TN: track neuron
% tPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN';
% tPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
tPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & cellfun(@(x) max(max(x)), T.pethconvSpatial)>cri_nanmeanFR; % nanmean firing rate > 1hz
% tPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR;

ntPC_DRun = sum(double(tPC_DRun));

% corr of total neurons
tPC_Run_PRE = cell2mat(T.rateMap1D_PRE(tPC_DRun));
tPC_Run_STM = cell2mat(T.rateMap1D_STM(tPC_DRun));
tPC_Run_POST = cell2mat(T.rateMap1D_POST(tPC_DRun));

nBin_50hz = size(tPC_Run_PRE,2);

%normalized
tPC_Run_PRE = tPC_Run_PRE./repmat(max(tPC_Run_PRE,[],2),1,nBin_50hz);
tPC_Run_STM = tPC_Run_STM./repmat(max(tPC_Run_STM,[],2),1,nBin_50hz);
tPC_Run_POST = tPC_Run_POST./repmat(max(tPC_Run_POST,[],2),1,nBin_50hz);

inlightZone_PRE_Run = tPC_Run_PRE(:,lightLoc_Run(1):lightLoc_Run(2));
inlightZone_STM_Run = tPC_Run_STM(:,lightLoc_Run(1):lightLoc_Run(2));
inlightZone_POST_Run = tPC_Run_POST(:,lightLoc_Run(1):lightLoc_Run(2));

outlightZone_PRE_Run = tPC_Run_PRE(:,ctrl_calib_run);
outlightZone_STM_Run = tPC_Run_STM(:,ctrl_calib_run);
outlightZone_POST_Run = tPC_Run_POST(:,ctrl_calib_run);

[rCorr_inRun_preXstm,rCorr_inRun_preXpost,rCorr_inRun_stmXpost] = deal([]);
[rCorr_outRun_preXstm,rCorr_outRun_preXpost,rCorr_outRun_stmXpost] = deal([]);

nBin_inlightRun = size(inlightZone_PRE_Run,2);
nBin_outlightRun = size(outlightZone_PRE_Run,2);

for iCell = 1:ntPC_DRun
    rCorr_inRun_preXstm(iCell,1) = corr(inlightZone_PRE_Run(iCell,:)',inlightZone_STM_Run(iCell,:)','rows','complete','type','Pearson');
    rCorr_inRun_preXpost(iCell,1) = corr(inlightZone_PRE_Run(iCell,:)',inlightZone_POST_Run(iCell,:)','rows','complete','type','Pearson');
    rCorr_inRun_stmXpost(iCell,1) = corr(inlightZone_STM_Run(iCell,:)',inlightZone_POST_Run(iCell,:)','rows','complete','type','Pearson');
end

for iCell = 1:ntPC_DRun
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
tPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & cellfun(@(x) max(max(x)), T.pethconvSpatial)>cri_nanmeanFR; % nanmean firing rate > 1hz
% tPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR;

ntPC_DRw = sum(double(tPC_DRw));

% corr of total neurons
tPC_Rw_PRE = cell2mat(T.rateMap1D_PRE(tPC_DRw));
tPC_Rw_STM = cell2mat(T.rateMap1D_STM(tPC_DRw));
tPC_Rw_POST = cell2mat(T.rateMap1D_POST(tPC_DRw));

%normalized
tPC_Rw_PRE = tPC_Rw_PRE./repmat(max(tPC_Rw_PRE,[],2),1,nBin_50hz);
tPC_Rw_STM = tPC_Rw_STM./repmat(max(tPC_Rw_STM,[],2),1,nBin_50hz);
tPC_Rw_POST = tPC_Rw_POST./repmat(max(tPC_Rw_POST,[],2),1,nBin_50hz);

inlightZone_PRE_Rw = tPC_Rw_PRE(:,lightLoc_Rw(1):lightLoc_Rw(2));
inlightZone_STM_Rw = tPC_Rw_STM(:,lightLoc_Rw(1):lightLoc_Rw(2));
inlightZone_POST_Rw = tPC_Rw_POST(:,lightLoc_Rw(1):lightLoc_Rw(2));

outlightZone_PRE_Rw = tPC_Rw_PRE(:,ctrl_calib_rw);
outlightZone_STM_Rw = tPC_Rw_STM(:,ctrl_calib_rw);
outlightZone_POST_Rw = tPC_Rw_POST(:,ctrl_calib_rw);

[rCorr_inRw_preXstm,rCorr_inRw_preXpost,rCorr_inRw_stmXpost] = deal([]);
[rCorr_outRw_preXstm,rCorr_outRw_preXpost,rCorr_outRw_stmXpost] = deal([]);

nBin_inlightRw = size(inlightZone_PRE_Rw,2);
nBin_outlightRw = size(outlightZone_PRE_Rw,2);

for iCell = 1:ntPC_DRw
    rCorr_inRw_preXstm(iCell,1) = corr(inlightZone_PRE_Rw(iCell,:)',inlightZone_STM_Rw(iCell,:)','rows','complete','type','Pearson');
    rCorr_inRw_preXpost(iCell,1) = corr(inlightZone_PRE_Rw(iCell,:)',inlightZone_POST_Rw(iCell,:)','rows','complete','type','Pearson');
    rCorr_inRw_stmXpost(iCell,1) = corr(inlightZone_STM_Rw(iCell,:)',inlightZone_POST_Rw(iCell,:)','rows','complete','type','Pearson');
end

for iCell = 1:ntPC_DRw
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

% rCri = 0.5;
% fileName_inRun = T.path(rCorr_inRun_preXpost<rCri);
% cellID_inRun = T.cellID(rCorr_inRun_preXpost<rCri);
% plot_Track_multi_v50hz(fileName_inRun,cellID_inRun,'D:\Dropbox\SNL\P2_Track\example_lowSpatialCorr\inRun_PRExPOST');
% 
% fileName_outRun = T.path(rCorr_outRun_preXpost<rCri);
% cellID_outRun = T.cellID(rCorr_outRun_preXpost<rCri);
% plot_Track_multi_v50hz(fileName_outRun,cellID_outRun,'D:\Dropbox\SNL\P2_Track\example_lowSpatialCorr\outRun_PRExPOST');
% 
% fileName_inRw = T.path(rCorr_inRw_preXpost<rCri);
% cellID_inRw = T.cellID(rCorr_inRw_preXpost<rCri);
% plot_Track_multi_v50hz(fileName_inRw,cellID_inRw,'D:\Dropbox\SNL\P2_Track\example_lowSpatialCorr\inRw_PRExPOST');
% 
% fileName_outRw = T.path(rCorr_outRw_preXpost<rCri);
% cellID_outRw = T.cellID(rCorr_outRw_preXpost<rCri);
% plot_Track_multi_v50hz(fileName_outRw,cellID_outRw,'D:\Dropbox\SNL\P2_Track\example_lowSpatialCorr\outRw_PRExPOST');

%% noLight 
% load('neuronList_ori_171205.mat');
% load('neuronList_ori_171229.mat');
load('neuronList_ori_180125_bin5sd2.mat');
% load('neuronList_ori_171219_2cm.mat');
% load('neuronList_ori_171219_4cm.mat');

%%%% noRun %%%%
% tPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN';
% tPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
tPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & cellfun(@(x) max(max(x)), T.pethconvSpatial)>cri_nanmeanFR; % nanmean firing rate > 1hz
% tPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR;

ntPC_noRun = sum(double(tPC_noRun));

noRun_PRE = cell2mat(T.rateMap1D_PRE(tPC_noRun));
noRun_STM = cell2mat(T.rateMap1D_STM(tPC_noRun));
noRun_POST = cell2mat(T.rateMap1D_POST(tPC_noRun));
nBin_ctrl = size(noRun_PRE,2);
%normalized
noRun_PRE = noRun_PRE./repmat(max(noRun_PRE,[],2),1,nBin_ctrl);
noRun_STM = noRun_STM./repmat(max(noRun_STM,[],2),1,nBin_ctrl);
noRun_POST = noRun_POST./repmat(max(noRun_POST,[],2),1,nBin_ctrl);

noRun_PRE = noRun_PRE(:,ctrl_calib_run);
noRun_STM = noRun_STM(:,ctrl_calib_run);
noRun_POST = noRun_POST(:,ctrl_calib_run);
nBin_ctrlrun = size(noRun_PRE,2);

[rCorr_noRun_preXstm, rCorr_noRun_preXpost, rCorr_noRun_stmXpost] = deal([]);
for iCell = 1:ntPC_noRun
    rCorr_noRun_preXstm(iCell,1) = corr(noRun_PRE(iCell,:)',noRun_STM(iCell,:)','rows','complete','type','Pearson');
    rCorr_noRun_preXpost(iCell,1) = corr(noRun_PRE(iCell,:)',noRun_POST(iCell,:)','rows','complete','type','Pearson');
    rCorr_noRun_stmXpost(iCell,1) = corr(noRun_STM(iCell,:)',noRun_POST(iCell,:)','rows','complete','type','Pearson');
end
% rCorr_noRun_preXstm = rCorr_noRun_preXstm.^2;
% rCorr_noRun_preXpost = rCorr_noRun_preXpost.^2;
% rCorr_noRun_stmXpost = rCorr_noRun_stmXpost.^2;

%%%% noRw %%%%
% tPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN';
% tPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
tPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & cellfun(@(x) max(max(x)), T.pethconvSpatial)>cri_nanmeanFR; % nanmean firing rate > 1hz
% tPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR;
ntPC_noRw = sum(double(tPC_noRw));

noRw_PRE = cell2mat(T.rateMap1D_PRE(tPC_noRw));
noRw_STM = cell2mat(T.rateMap1D_STM(tPC_noRw));
noRw_POST = cell2mat(T.rateMap1D_POST(tPC_noRw));

%normalized
noRw_PRE = noRw_PRE./repmat(max(noRw_PRE,[],2),1,nBin_ctrl);
noRw_STM = noRw_STM./repmat(max(noRw_STM,[],2),1,nBin_ctrl);
noRw_POST = noRw_POST./repmat(max(noRw_POST,[],2),1,nBin_ctrl);

noRw_PRE = noRw_PRE(:,ctrl_calib_rw);
noRw_STM = noRw_STM(:,ctrl_calib_rw);
noRw_POST = noRw_POST(:,ctrl_calib_rw);
nBin_ctrlrw = size(noRw_PRE,2);

[rCorr_noRw_preXstm, rCorr_noRw_preXpost, rCorr_noRw_stmXpost] = deal([]);
for iCell = 1:ntPC_noRw
    rCorr_noRw_preXstm(iCell,1) = corr(noRw_PRE(iCell,:)',noRw_STM(iCell,:)','rows','complete','type','Pearson');
    rCorr_noRw_preXpost(iCell,1) = corr(noRw_PRE(iCell,:)',noRw_POST(iCell,:)','rows','complete','type','Pearson');
    rCorr_noRw_stmXpost(iCell,1) = corr(noRw_STM(iCell,:)',noRw_POST(iCell,:)','rows','complete','type','Pearson');
end
% rCorr_noRw_preXstm = rCorr_noRw_preXstm.^2;
% rCorr_noRw_preXpost = rCorr_noRw_preXpost.^2;
% rCorr_noRw_stmXpost = rCorr_noRw_stmXpost.^2;

%% statistic
group_Run = [ones(ntPC_DRun,1);2*ones(ntPC_DRun,1);3*ones(ntPC_noRun,1)];
group_Rw = [ones(ntPC_DRw,1);2*ones(ntPC_DRw,1);3*ones(ntPC_noRw,1)];

% nanmean & sem
m_rCorr_inlight_Run = [nanmean(rCorr_inRun_preXstm), nanmean(rCorr_inRun_preXpost), nanmean(rCorr_inRun_stmXpost)];
sem_rCorr_inlight_Run = [nanstd(rCorr_inRun_preXstm,0,1)/sqrt(sum(double(~isnan(rCorr_inRun_preXstm)))), nanstd(rCorr_inRun_preXpost,0,1)/sqrt(sum(double(~isnan(rCorr_inRun_preXpost)))), nanstd(rCorr_inRun_stmXpost,0,1)/sqrt(sum(double(~isnan(rCorr_inRun_stmXpost))))];

m_rCorr_outlight_Run = [nanmean(rCorr_outRun_preXstm), nanmean(rCorr_outRun_preXpost), nanmean(rCorr_outRun_stmXpost)];
sem_rCorr_outlight_Run = [nanstd(rCorr_outRun_preXstm,0,1)/sqrt(sum(double(~isnan(rCorr_outRun_preXstm)))), nanstd(rCorr_outRun_preXpost,0,1)/sqrt(sum(double(~isnan(rCorr_outRun_preXpost)))), nanstd(rCorr_outRun_stmXpost,0,1)/sqrt(sum(double(~isnan(rCorr_outRun_stmXpost))))];

m_rCorr_inlight_Rw = [nanmean(rCorr_inRw_preXstm), nanmean(rCorr_inRw_preXpost), nanmean(rCorr_inRw_stmXpost)];
sem_rCorr_inlight_Rw = [nanstd(rCorr_inRw_preXstm,0,1)/sqrt(sum(double(~isnan(rCorr_inRw_preXstm)))), nanstd(rCorr_inRw_preXpost,0,1)/sqrt(sum(double(~isnan(rCorr_inRw_preXpost)))), nanstd(rCorr_inRw_stmXpost,0,1)/sqrt(sum(double(~isnan(rCorr_inRw_stmXpost))))];

m_rCorr_outlight_Rw = [nanmean(rCorr_outRw_preXstm), nanmean(rCorr_outRw_preXpost), nanmean(rCorr_outRw_stmXpost)];
sem_rCorr_outlight_Rw = [nanstd(rCorr_outRw_preXstm,0,1)/sqrt(sum(double(~isnan(rCorr_outRw_preXstm)))), nanstd(rCorr_outRw_preXpost,0,1)/sqrt(sum(double(~isnan(rCorr_outRw_preXpost)))), nanstd(rCorr_outRw_stmXpost,0,1)/sqrt(sum(double(~isnan(rCorr_outRw_stmXpost))))];

m_rCorr_noRun = [nanmean(rCorr_noRun_preXstm), nanmean(rCorr_noRun_preXpost), nanmean(rCorr_noRun_stmXpost)];
sem_rCorr_noRun = [nanstd(rCorr_noRun_preXstm,0,1)/sqrt(sum(double(~isnan(rCorr_noRun_preXstm)))), nanstd(rCorr_noRun_preXpost,0,1)/sqrt(sum(double(~isnan(rCorr_noRun_preXpost)))), nanstd(rCorr_noRun_stmXpost,0,1)/sqrt(sum(double(~isnan(rCorr_noRun_stmXpost))))];

m_rCorr_noRw = [nanmean(rCorr_noRw_preXstm), nanmean(rCorr_noRw_preXpost), nanmean(rCorr_noRw_stmXpost)];
sem_rCorr_noRw = [nanstd(rCorr_noRw_preXstm,0,1)/sqrt(sum(double(~isnan(rCorr_noRw_preXstm)))), nanstd(rCorr_noRw_preXpost,0,1)/sqrt(sum(double(~isnan(rCorr_noRw_preXpost)))), nanstd(rCorr_noRw_stmXpost,0,1)/sqrt(sum(double(~isnan(rCorr_noRw_stmXpost))))];

% Run session
[p_totalRun(1), table, stats] = kruskalwallis([rCorr_inRun_preXstm(~isnan(rCorr_inRun_preXstm)); rCorr_inRun_preXpost(~isnan(rCorr_inRun_preXpost)); rCorr_inRun_stmXpost(~isnan(rCorr_inRun_stmXpost))],[ones(sum(double(~isnan(rCorr_inRun_preXstm))),1); 2*ones(sum(double(~isnan(rCorr_inRun_preXpost))),1); 3*ones(sum(double(~isnan(rCorr_inRun_stmXpost))),1)],'off');
% result_Run = multcompare(stats,'ctype','hsd','Display','off');
% result_Run = multcompare(stats,'ctype','bonferroni','Display','off');
result_Run = multcompare(stats,'ctype','lsd','Display','off');
p_Run(:,1) = result_Run(:,end);

[p_totalRun(2), table, stats] = kruskalwallis([rCorr_outRun_preXstm(~isnan(rCorr_outRun_preXstm)); rCorr_outRun_preXpost(~isnan(rCorr_outRun_preXpost)); rCorr_outRun_stmXpost(~isnan(rCorr_outRun_stmXpost))],[ones(sum(double(~isnan(rCorr_outRun_preXstm))),1); 2*ones(sum(double(~isnan(rCorr_outRun_preXpost))),1); 3*ones(sum(double(~isnan(rCorr_outRun_stmXpost))),1)],'off');
% result_Run = multcompare(stats,'ctype','hsd','Display','off');
% result_Run = multcompare(stats,'ctype','bonferroni','Display','off');
result_Run = multcompare(stats,'ctype','lsd','Display','off');
p_Run(:,2) = result_Run(:,end);

[p_totalRun(3), table, stats] = kruskalwallis([rCorr_noRun_preXstm(~isnan(rCorr_noRun_preXstm)); rCorr_noRun_preXpost(~isnan(rCorr_noRun_preXpost)); rCorr_noRun_stmXpost(~isnan(rCorr_noRun_stmXpost))],[ones(sum(double(~isnan(rCorr_noRun_preXstm))),1); 2*ones(sum(double(~isnan(rCorr_noRun_preXpost))),1); 3*ones(sum(double(~isnan(rCorr_noRun_stmXpost))),1)],'off');
% result_Run = multcompare(stats,'ctype','hsd','Display','off');
% result_Run = multcompare(stats,'ctype','bonferroni','Display','off');
result_Run = multcompare(stats,'ctype','lsd','Display','off');
p_Run(:,3) = result_Run(:,end);

% Rw session
[p_totalRw(1), table, stats] = kruskalwallis([rCorr_inRw_preXstm(~isnan(rCorr_inRw_preXstm)); rCorr_inRw_preXpost(~isnan(rCorr_inRw_preXpost)); rCorr_inRw_stmXpost(~isnan(rCorr_inRw_stmXpost))],[ones(sum(double(~isnan(rCorr_inRw_preXstm))),1); 2*ones(sum(double(~isnan(rCorr_inRw_preXpost))),1); 3*ones(sum(double(~isnan(rCorr_inRw_stmXpost))),1)],'off');
% result_Rw = multcompare(stats,'ctype','hsd','Display','off');
% result_Rw = multcompare(stats,'ctype','bonferroni','Display','off');
result_Rw = multcompare(stats,'ctype','lsd','Display','off');
p_Rw(:,1) = result_Rw(:,end);

[p_totalRw(2), table, stats] = kruskalwallis([rCorr_outRw_preXstm(~isnan(rCorr_outRw_preXstm)); rCorr_outRw_preXpost(~isnan(rCorr_outRw_preXpost)); rCorr_outRw_stmXpost(~isnan(rCorr_outRw_stmXpost))],[ones(sum(double(~isnan(rCorr_outRw_preXstm))),1); 2*ones(sum(double(~isnan(rCorr_outRw_preXpost))),1); 3*ones(sum(double(~isnan(rCorr_outRw_stmXpost))),1)],'off');
% result_Rw = multcompare(stats,'ctype','hsd','Display','off');
% result_Rw = multcompare(stats,'ctype','bonferroni','Display','off');
result_Rw = multcompare(stats,'ctype','lsd','Display','off');
p_Rw(:,2) = result_Rw(:,end);

[p_totalRw(3), table, stats] = kruskalwallis([rCorr_noRw_preXstm(~isnan(rCorr_noRw_preXstm)); rCorr_noRw_preXpost(~isnan(rCorr_noRw_preXpost)); rCorr_noRw_stmXpost(~isnan(rCorr_noRw_stmXpost))],[ones(sum(double(~isnan(rCorr_noRw_preXstm))),1); 2*ones(sum(double(~isnan(rCorr_noRw_preXpost))),1); 3*ones(sum(double(~isnan(rCorr_noRw_stmXpost))),1)],'off');
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

xScatterRunIn = (rand(ntPC_DRun,1)-0.5)*barWidth*0.5;
xScatterRunOut = (rand(ntPC_DRun,1)-0.5)*barWidth*0.5;
xScatterRwIn = (rand(ntPC_DRw,1)-0.5)*barWidth*0.5;
xScatterRwOut = (rand(ntPC_DRw,1)-0.5)*barWidth*0.5;
xScatterNoRun = (rand(ntPC_noRun,1)-0.5)*barWidth*0.5;
xScatterNoRw = (rand(ntPC_noRw,1)-0.5)*barWidth*0.5;

fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});

hPVCorr(1) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
bar([1,2,3],m_rCorr_inlight_Run,barWidth,'faceColor',colorLLightBlue);
hold on;
errorbarJun([1,2,3],m_rCorr_inlight_Run,sem_rCorr_inlight_Run,0.3,1.0,colorBlack);
hold on;
bar([5,6,7],m_rCorr_outlight_Run,barWidth,'faceColor',colorLightGray)
hold on;
errorbarJun([5,6,7],m_rCorr_outlight_Run,sem_rCorr_outlight_Run,0.3,1.0,colorBlack);
hold on;
bar([9,10,11],m_rCorr_noRun,barWidth,'faceColor',colorDarkGray)
hold on;
errorbarJun([9,10,11],m_rCorr_noRun,sem_rCorr_noRun,0.3,1.0,colorBlack);
hold on;

plot(1+xScatterRunIn, rCorr_inRun_preXstm, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(2+xScatterRunIn, rCorr_inRun_preXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(3+xScatterRunIn, rCorr_inRun_stmXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;

plot(5+xScatterRunOut, rCorr_outRun_preXstm, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(6+xScatterRunOut, rCorr_outRun_preXpost,'.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(7+xScatterRunOut, rCorr_outRun_stmXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;


plot(9+xScatterNoRun, rCorr_noRun_preXstm, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(10+xScatterNoRun, rCorr_noRun_preXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(11+xScatterNoRun, rCorr_noRun_stmXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
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
bar([1,2,3],m_rCorr_inlight_Rw,barWidth,'faceColor',colorLLightBlue);
hold on;
errorbarJun([1,2,3],m_rCorr_inlight_Rw,sem_rCorr_inlight_Rw,0.3,1.0,colorBlack);
hold on;
bar([5,6,7],m_rCorr_outlight_Rw,barWidth,'faceColor',colorLightGray)
hold on;
errorbarJun([5,6,7],m_rCorr_outlight_Rw,sem_rCorr_outlight_Rw,0.3,1.0,colorBlack);
hold on;
bar([9,10,11],m_rCorr_noRw,barWidth,'faceColor',colorDarkGray)
hold on;
errorbarJun([9,10,11],m_rCorr_noRw,sem_rCorr_noRw,0.3,1.0,colorBlack);
hold on;

plot(1+xScatterRwIn, rCorr_inRw_preXstm, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(2+xScatterRwIn, rCorr_inRw_preXpost,'.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(3+xScatterRwIn, rCorr_inRw_stmXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;

plot(5+xScatterRwOut, rCorr_outRw_preXstm, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(6+xScatterRwOut, rCorr_outRw_preXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(7+xScatterRwOut, rCorr_outRw_stmXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;

plot(9+xScatterNoRw, rCorr_noRw_preXstm, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(10+xScatterNoRw, rCorr_noRw_preXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(11+xScatterNoRw, rCorr_noRw_stmXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
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

set(hPVCorr(1),'TickDir','out','Box','off','XLim',[0,12],'YLim',[-1.15 1.15],'XTick',[2, 6, 10],'XTickLabel',[{'In-zone','Out-zone','Control'}],'fontSize',fontM);
set(hPVCorr(2),'TickDir','out','Box','off','XLim',[0,12],'YLim',[-1.15 1.15],'XTick',[2, 6, 10],'XTickLabel',[{'In-zone','Out-zone','Control'}],'fontSize',fontM);
set(hPVCorr,'TickLength',[0.03, 0.03]);

print('-painters','-r300','-dtiff',['f_Neuron_SpatialCorr_',datestr(now,formatOut),'_50Hz_zone_bin5sd2_calib','.tif']);
% print('-painters','-r300','-depsc',['f_CellRepors_PVCorr_8Hz_',datestr(now,formatOut),'.ai']);
close;