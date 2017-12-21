clearvars;
cd('D:\Dropbox\SNL\P2_Track');
% Txls = readtable('neuronList_ori50hz_171014.xlsx');
% Txls.latencyIndex = categorical(Txls.latencyIndex);

% load('neuronList_ori50hz_171014.mat');

load('D:\Dropbox\SNL\P2_Track\myParameters.mat');
formatOut = 'yymmdd';
cri_meanFR = 1;

%% Bin size
% 1cm win
% load('neuronList_ori50hz_171219_1cm.mat');
% lightLoc_Run = [floor(20*pi*5/6) ceil(20*pi*8/6)];
% lightLoc_Rw = [floor(20*pi*9/6) ceil(20*pi*10/6)];

% 2cm win
% load('neuronList_ori50hz_171219_2cm.mat');
% lightLoc_Run = [27 42];
% lightLoc_Rw = [48 53];

% 4cm win
load('neuronList_ori50hz_171205_4cm.mat');
lightLoc_Run = [14 21];
lightLoc_Rw = [24 26];

%%
% TN: track neuron
% tPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN';
% tPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
tPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & cellfun(@(x) max(max(x)), T.pethconvSpatial)>cri_meanFR; % mean firing rate > 1hz
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

outlightZone_PRE_Run = tPC_Run_PRE(:,[1:lightLoc_Run(1)-1,lightLoc_Run(2)+1:nBin_50hz]);
outlightZone_STM_Run = tPC_Run_STM(:,[1:lightLoc_Run(1)-1,lightLoc_Run(2)+1:nBin_50hz]);
outlightZone_POST_Run = tPC_Run_POST(:,[1:lightLoc_Run(1)-1,lightLoc_Run(2)+1:nBin_50hz]);

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

outlightZone_PRE_Rw = tPC_Rw_PRE(:,[1:lightLoc_Rw(1)-1,lightLoc_Rw(2)+1:nBin_50hz]);
outlightZone_STM_Rw = tPC_Rw_STM(:,[1:lightLoc_Rw(1)-1,lightLoc_Rw(2)+1:nBin_50hz]);
outlightZone_POST_Rw = tPC_Rw_POST(:,[1:lightLoc_Rw(1)-1,lightLoc_Rw(2)+1:nBin_50hz]);

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
% load('neuronList_ori_171219_1cm.mat');
% load('neuronList_ori_171219_2cm.mat');
load('neuronList_ori_171219_4cm.mat');

%%%% noRun %%%%
% tPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN';
% tPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
tPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & cellfun(@(x) max(max(x)), T.pethconvSpatial)>cri_meanFR; % mean firing rate > 1hz
% tPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR;

ntPC_noRun = sum(double(tPC_noRun));

noRun_PRE = cell2mat(T.rateMap1D_PRE(tPC_noRun));
noRun_STM = cell2mat(T.rateMap1D_STM(tPC_noRun));
noRun_POST = cell2mat(T.rateMap1D_POST(tPC_noRun));
nBin_total = size(noRun_PRE,2);
%normalized
noRun_PRE = noRun_PRE./repmat(max(noRun_PRE,[],2),1,nBin_total);
noRun_STM = noRun_STM./repmat(max(noRun_STM,[],2),1,nBin_total);
noRun_POST = noRun_POST./repmat(max(noRun_POST,[],2),1,nBin_total);

inlightZone_PRE_noRun = noRun_PRE(:,lightLoc_Run(1):lightLoc_Run(2));
inlightZone_STM_noRun = noRun_STM(:,lightLoc_Run(1):lightLoc_Run(2));
inlightZone_POST_noRun = noRun_POST(:,lightLoc_Run(1):lightLoc_Run(2));

outlightZone_PRE_noRun = noRun_PRE(:,[1:lightLoc_Run(1)-1,lightLoc_Run(2)+1:nBin_50hz]);
outlightZone_STM_noRun = noRun_STM(:,[1:lightLoc_Run(1)-1,lightLoc_Run(2)+1:nBin_50hz]);
outlightZone_POST_noRun = noRun_POST(:,[1:lightLoc_Run(1)-1,lightLoc_Run(2)+1:nBin_50hz]);

[pvCorr_inNoRun_preXstm,pvCorr_inNoRun_preXpost,pvCorr_inNoRun_stmXpost] = deal([]);
[pvCorr_outNoRun_preXstm,pvCorr_outNoRun_preXpost,pvCorr_outNoRun_stmXpost] = deal([]);

nBin_inlightNoRun = size(inlightZone_PRE_noRun,2);
nBin_outlightNoRun = size(outlightZone_PRE_noRun,2);

for iCol = 1:nBin_inlightNoRun
    pvCorr_inNoRun_preXstm(iCol) = corr(inlightZone_PRE_noRun(:,iCol),inlightZone_STM_noRun(:,iCol),'rows','complete','type','Pearson');
    pvCorr_inNoRun_preXpost(iCol) = corr(inlightZone_PRE_noRun(:,iCol),inlightZone_POST_noRun(:,iCol),'rows','complete','type','Pearson');
    pvCorr_inNoRun_stmXpost(iCol) = corr(inlightZone_STM_noRun(:,iCol),inlightZone_POST_noRun(:,iCol),'rows','complete','type','Pearson');
end

for iCol = 1:nBin_outlightNoRun
    pvCorr_outNoRun_preXstm(iCol) = corr(outlightZone_PRE_noRun(:,iCol),outlightZone_STM_noRun(:,iCol),'rows','complete','type','Pearson');
    pvCorr_outNoRun_preXpost(iCol) = corr(outlightZone_PRE_noRun(:,iCol),outlightZone_POST_noRun(:,iCol),'rows','complete','type','Pearson');
    pvCorr_outNoRun_stmXpost(iCol) = corr(outlightZone_STM_noRun(:,iCol),outlightZone_POST_noRun(:,iCol),'rows','complete','type','Pearson');
end


%%%% noRw %%%%
% tPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN';
% tPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
tPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & cellfun(@(x) max(max(x)), T.pethconvSpatial)>cri_meanFR; % mean firing rate > 1hz
% tPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR;
ntPC_noRw = sum(double(tPC_noRw));

noRw_PRE = cell2mat(T.rateMap1D_PRE(tPC_noRw));
noRw_STM = cell2mat(T.rateMap1D_STM(tPC_noRw));
noRw_POST = cell2mat(T.rateMap1D_POST(tPC_noRw));

%normalized
noRw_PRE = noRw_PRE./repmat(max(noRw_PRE,[],2),1,nBin_total);
noRw_STM = noRw_STM./repmat(max(noRw_STM,[],2),1,nBin_total);
noRw_POST = noRw_POST./repmat(max(noRw_POST,[],2),1,nBin_total);

inlightZone_PRE_noRw = noRw_PRE(:,lightLoc_Rw(1):lightLoc_Rw(2));
inlightZone_STM_noRw = noRw_STM(:,lightLoc_Rw(1):lightLoc_Rw(2));
inlightZone_POST_noRw = noRw_POST(:,lightLoc_Rw(1):lightLoc_Rw(2));

outlightZone_PRE_noRw = noRw_PRE(:,[1:lightLoc_Rw(1)-1,lightLoc_Rw(2)+1:nBin_50hz]);
outlightZone_STM_noRw = noRw_STM(:,[1:lightLoc_Rw(1)-1,lightLoc_Rw(2)+1:nBin_50hz]);
outlightZone_POST_noRw = noRw_POST(:,[1:lightLoc_Rw(1)-1,lightLoc_Rw(2)+1:nBin_50hz]);

[pvCorr_inNoRw_preXstm,pvCorr_inNoRw_preXpost,pvCorr_inNoRw_stmXpost] = deal([]);
[pvCorr_outNoRw_preXstm,pvCorr_outNoRw_preXpost,pvCorr_outNoRw_stmXpost] = deal([]);

nBin_inlightNoRw = size(inlightZone_PRE_noRw,2);
nBin_outlightNoRw = size(outlightZone_PRE_noRw,2);

for iCol = 1:nBin_inlightNoRw
    pvCorr_inNoRw_preXstm(iCol) = corr(inlightZone_PRE_noRw(:,iCol),inlightZone_STM_noRw(:,iCol),'rows','complete','type','Pearson');
    pvCorr_inNoRw_preXpost(iCol) = corr(inlightZone_PRE_noRw(:,iCol),inlightZone_POST_noRw(:,iCol),'rows','complete','type','Pearson');
    pvCorr_inNoRw_stmXpost(iCol) = corr(inlightZone_STM_noRw(:,iCol),inlightZone_POST_noRw(:,iCol),'rows','complete','type','Pearson');
end

for iCol = 1:nBin_outlightNoRw
    pvCorr_outNoRw_preXstm(iCol) = corr(outlightZone_PRE_noRw(:,iCol),outlightZone_STM_noRw(:,iCol),'rows','complete','type','Pearson');
    pvCorr_outNoRw_preXpost(iCol) = corr(outlightZone_PRE_noRw(:,iCol),outlightZone_POST_noRw(:,iCol),'rows','complete','type','Pearson');
    pvCorr_outNoRw_stmXpost(iCol) = corr(outlightZone_STM_noRw(:,iCol),outlightZone_POST_noRw(:,iCol),'rows','complete','type','Pearson');
end

%% DY Lee
% save('rawData.mat','inlightZone_PRE_Run','inlightZone_STM_Run','inlightZone_POST_Run','outlightZone_PRE_Run','outlightZone_STM_Run','outlightZone_POST_Run','noRun_PRE','noRun_STM','noRun_POST',...
%     'inlightZone_PRE_Rw','inlightZone_STM_Rw','inlightZone_POST_Rw','outlightZone_PRE_Rw','outlightZone_STM_Rw','outlightZone_POST_Rw','noRw_PRE','noRw_STM','noRw_POST');
%% statistic
% mean & sem
m_pvCorr_inlight_Run = [mean(pvCorr_inRun_preXstm), mean(pvCorr_inRun_preXpost), mean(pvCorr_inRun_stmXpost)];
sem_pvCorr_inlight_Run = [std(pvCorr_inRun_preXstm,0,2)/sqrt(nBin_inlightRun), std(pvCorr_inRun_preXpost)/sqrt(nBin_inlightRun), std(pvCorr_inRun_stmXpost)/sqrt(nBin_inlightRun)];
m_pvCorr_outlight_Run = [mean(pvCorr_outRun_preXstm), mean(pvCorr_outRun_preXpost), mean(pvCorr_outRun_stmXpost)];
sem_pvCorr_outlight_Run = [std(pvCorr_outRun_preXstm,0,2)/sqrt(nBin_outlightRun), std(pvCorr_outRun_preXpost)/sqrt(nBin_outlightRun), std(pvCorr_outRun_stmXpost)/sqrt(nBin_outlightRun)];

m_pvCorr_inlight_Rw = [mean(pvCorr_inRw_preXstm), mean(pvCorr_inRw_preXpost), mean(pvCorr_inRw_stmXpost)];
sem_pvCorr_inlight_Rw = [std(pvCorr_inRw_preXstm,0,2)/sqrt(nBin_inlightRw), std(pvCorr_inRw_preXpost)/sqrt(nBin_inlightRw), std(pvCorr_inRw_stmXpost)/sqrt(nBin_inlightRw)];
m_pvCorr_outlight_Rw = [mean(pvCorr_outRw_preXstm), mean(pvCorr_outRw_preXpost), mean(pvCorr_outRw_stmXpost)];
sem_pvCorr_outlight_Rw = [std(pvCorr_outRw_preXstm,0,2)/sqrt(nBin_outlightRw), std(pvCorr_outRw_preXpost)/sqrt(nBin_outlightRw), std(pvCorr_outRw_stmXpost)/sqrt(nBin_outlightRw)];

m_pvCorr_inNoRun = [mean(pvCorr_inNoRun_preXstm), mean(pvCorr_inNoRun_preXpost), mean(pvCorr_inNoRun_stmXpost)];
sem_pvCorr_inNoRun = [std(pvCorr_inNoRun_preXstm,0,2)/sqrt(nBin_inlightNoRun), std(pvCorr_inNoRun_preXpost,0,2)/sqrt(nBin_inlightNoRun), std(pvCorr_inNoRun_stmXpost,0,2)/sqrt(nBin_inlightNoRun)];
m_pvCorr_outNoRun = [mean(pvCorr_outNoRun_preXstm), mean(pvCorr_outNoRun_preXpost), mean(pvCorr_outNoRun_stmXpost)];
sem_pvCorr_outNoRun = [std(pvCorr_outNoRun_preXstm,0,2)/sqrt(nBin_outlightNoRun), std(pvCorr_outNoRun_preXpost,0,2)/sqrt(nBin_outlightNoRun), std(pvCorr_outNoRun_stmXpost,0,2)/sqrt(nBin_outlightNoRun)];

m_pvCorr_inNoRw = [mean(pvCorr_inNoRw_preXstm), mean(pvCorr_inNoRw_preXpost), mean(pvCorr_inNoRw_stmXpost)];
sem_pvCorr_inNoRw = [std(pvCorr_inNoRw_preXstm,0,2)/sqrt(nBin_inlightNoRw), std(pvCorr_inNoRw_preXpost,0,2)/sqrt(nBin_inlightNoRw), std(pvCorr_inNoRw_stmXpost,0,2)/sqrt(nBin_inlightNoRw)];
m_pvCorr_outNoRw = [mean(pvCorr_outNoRw_preXstm), mean(pvCorr_outNoRw_preXpost), mean(pvCorr_outNoRw_stmXpost)];
sem_pvCorr_outNoRw = [std(pvCorr_outNoRw_preXstm,0,2)/sqrt(nBin_outlightNoRw), std(pvCorr_outNoRw_preXpost,0,2)/sqrt(nBin_outlightNoRw), std(pvCorr_outNoRw_stmXpost,0,2)/sqrt(nBin_outlightNoRw)];

% Run session
[p_Run(1,1), ~] = ranksum(pvCorr_inRun_preXstm,pvCorr_inNoRun_preXstm);
[p_Run(2,1), ~] = ranksum(pvCorr_inRun_preXpost,pvCorr_inNoRun_preXpost);
[p_Run(3,1), ~] = ranksum(pvCorr_inRun_stmXpost,pvCorr_inNoRun_stmXpost);

[~, p_Run(1,2)] = ttest2(pvCorr_outRun_preXstm,pvCorr_outNoRun_preXstm);
[~, p_Run(2,2)] = ttest2(pvCorr_outRun_preXpost,pvCorr_outNoRun_preXpost);
[~, p_Run(3,2)] = ttest2(pvCorr_outRun_stmXpost,pvCorr_outNoRun_stmXpost);

% Rw session
[p_Rw(1,1), ~] = ranksum(pvCorr_inRw_preXstm,pvCorr_inNoRw_preXstm);
[p_Rw(2,1), ~] = ranksum(pvCorr_inRw_preXpost,pvCorr_inNoRw_preXpost);
[p_Rw(3,1), ~] = ranksum(pvCorr_inRw_stmXpost,pvCorr_inNoRw_stmXpost);

[~, p_Rw(1,2)] = ttest2(pvCorr_outRw_preXstm,pvCorr_outNoRw_preXstm);
[~, p_Rw(2,2)] = ttest2(pvCorr_outRw_preXpost,pvCorr_outNoRw_preXpost);
[~, p_Rw(3,2)] = ttest2(pvCorr_outRw_stmXpost,pvCorr_outNoRw_stmXpost);

%% Run
barWidth = 0.10;
% barWidth = 0.8;
eBarLength = 0.3;
eBarWidth = 0.8;
eBarColor = colorBlack;
nCol = 2;
nRow = 5;
fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});

hPVCorr(1) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1,1,[0.08 0.1 0.85 0.85],midInterval),wideInterval));
bar([1,9,17],m_pvCorr_inlight_Run,barWidth,'faceColor',colorLLightBlue);
hold on;
errorbarJun([1,9,17],m_pvCorr_inlight_Run,sem_pvCorr_inlight_Run,0.3,1.0,colorBlack);
hold on;

bar([2,10,18],m_pvCorr_inNoRun,barWidth,'faceColor',colorDarkGray)
hold on;
errorbarJun([2,10,18],m_pvCorr_inNoRun,sem_pvCorr_inNoRun,0.3,1.0,colorBlack);
hold on;

bar([4,12,20],m_pvCorr_outlight_Run,barWidth,'faceColor',colorLightGray)
hold on;
errorbarJun([4,12,20],m_pvCorr_outlight_Run,sem_pvCorr_outlight_Run,0.3,1.0,colorBlack);
hold on;

bar([5,13,21],m_pvCorr_outNoRun,barWidth,'faceColor',colorDarkGray)
hold on;
errorbarJun([5,13,21],m_pvCorr_outNoRun,sem_pvCorr_outNoRun,0.3,1.0,colorBlack);

title('Run','fontSize',fontM);
ylabel('PV correlation','fontSize',fontM);

text(0, -0.4,['p_i_n = ',num2str(p_Run(1,1),3)],'fontSize',fontM,'color',colorBlack);
text(0, -0.6,['p_o_u_t = ',num2str(p_Run(1,2),3)],'fontSize',fontM,'color',colorBlack);
text(8, -0.4,['p_i_n = ',num2str(p_Run(2,1),3)],'fontSize',fontM,'color',colorBlack);
text(8, -0.6,['p_o_u_t = ',num2str(p_Run(2,2),3)],'fontSize',fontM,'color',colorBlack);
text(16, -0.4,['p_i_n = ',num2str(p_Run(3,1),3)],'fontSize',fontM,'color',colorBlack);
text(16, -0.6,['p_o_u_t = ',num2str(p_Run(3,2),3)],'fontSize',fontM,'color',colorBlack);

%% Rw
hPVCorr(2) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
bar([1,9,17],m_pvCorr_inlight_Rw,barWidth,'faceColor',colorLLightBlue);
hold on;
errorbarJun([1,9,17],m_pvCorr_inlight_Rw,sem_pvCorr_inlight_Rw,0.3,1.0,colorBlack);
hold on;

bar([2,10,18],m_pvCorr_inNoRw,barWidth,'faceColor',colorDarkGray)
hold on;
errorbarJun([2,10,18],m_pvCorr_inNoRw,sem_pvCorr_inNoRw,0.3,1.0,colorBlack);
hold on;

bar([4,12,20],m_pvCorr_outlight_Rw,barWidth,'faceColor',colorLightGray)
hold on;
errorbarJun([4,12,20],m_pvCorr_outlight_Rw,sem_pvCorr_outlight_Rw,0.3,1.0,colorBlack);
hold on;

bar([5,13,21],m_pvCorr_outNoRw,barWidth,'faceColor',colorDarkGray)
hold on;
errorbarJun([5,13,21],m_pvCorr_outNoRw,sem_pvCorr_outNoRw,0.3,1.0,colorBlack);

title('Rw','fontSize',fontM);
ylabel('PV correlation','fontSize',fontM);

text(0, -0.4,['p_i_n = ',num2str(p_Rw(1,1))],'fontSize',fontM,'color',colorBlack);
text(0, -0.6,['p_o_u_t = ',num2str(p_Rw(1,2))],'fontSize',fontM,'color',colorBlack);
text(8, -0.4,['p_i_n = ',num2str(p_Rw(2,1))],'fontSize',fontM,'color',colorBlack);
text(8, -0.6,['p_o_u_t = ',num2str(p_Rw(2,2))],'fontSize',fontM,'color',colorBlack);
text(16, -0.4,['p_i_n = ',num2str(p_Rw(3,1))],'fontSize',fontM,'color',colorBlack);
text(16, -0.6,['p_o_u_t = ',num2str(p_Rw(3,2))],'fontSize',fontM,'color',colorBlack);

set(hPVCorr(1),'TickDir','out','Box','off','XLim',[0,22],'YLim',[0 1.15],'XTick',[3, 11, 19],'XTickLabel',[{'PRExSTIM','PRExPOST','STIMxPOST'}],'fontSize',fontM);
set(hPVCorr(2),'TickDir','out','Box','off','XLim',[0,22],'YLim',[0 1.15],'XTick',[3, 11, 19],'XTickLabel',[{'PRExSTIM','PRExPOST','STIMxPOST'}],'fontSize',fontM);

print('-painters','-r300','-dtiff',['f_short_suppleXX_PVCorr_InOutTotalZone_',datestr(now,formatOut),'_4cm1HzNorm_v2.tif']);
% print('-painters','-r300','-depsc',['f_short_suppleXX_PVCorr_InOutTotalZone_',datestr(now,formatOut),'_2cm1HzNormKW_v2.ai']);
close;