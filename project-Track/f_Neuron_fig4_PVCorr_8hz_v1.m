clearvars;
cd('E:\Dropbox\SNL\P2_Track');

load('E:\Dropbox\SNL\P2_Track\myParameters.mat');
formatOut = 'yymmdd';

markerS = 1.5;
dotS = 4;
colorGray = [100 100 100]./255;
colorLightGray = [240 240 240]./255;
colorDarkGray = [170 170 170]./255;

% 1cm win
% load('neuronList_ori_171229.mat');
load('neuronList_ori_180125.mat');
lightLoc_Run = [floor(20*pi*5/6) ceil(20*pi*8/6)];
lightLoc_Rw = [floor(20*pi*9/6) ceil(20*pi*10/6)];

% 2cm win
% load('neuronList_ori50hz_171219_2cm.mat');
% lightLoc_Run = [27 42];
% lightLoc_Rw = [48 53];

% 4cm win
% load('neuronList_ori50hz_171219_4cm.mat');
% lightLoc_Run = [14 21];
% lightLoc_Rw = [24 26];

cri_meanFR = 1;

%%
% TN: track neuron
% tPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN';
% tPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField;
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
% tPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField;
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
% load('neuronList_ori_171229.mat');
load('neuronList_ori_180125.mat');
% load('neuronList_ori_171219_2cm.mat');
% load('neuronList_ori_171219_4cm.mat');

%%%% noRun %%%%
% tPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN';
% tPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField;
% tPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
tPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & cellfun(@(x) max(max(x)), T.pethconvSpatial)>cri_meanFR; % mean firing rate > 1hz
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

[pvCorr_noRun_preXstm, pvCorr_noRun_preXpost, pvCorr_noRun_stmXpost] = deal([]);
for iCol = 1:nBin_ctrl
    pvCorr_noRun_preXstm(iCol) = corr(noRun_PRE(:,iCol),noRun_STM(:,iCol),'rows','complete','type','Pearson');
    pvCorr_noRun_preXpost(iCol) = corr(noRun_PRE(:,iCol),noRun_POST(:,iCol),'rows','complete','type','Pearson');
    pvCorr_noRun_stmXpost(iCol) = corr(noRun_STM(:,iCol),noRun_POST(:,iCol),'rows','complete','type','Pearson');
end

%%%% noRw %%%%
% tPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN';
% tPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField;
% tPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
tPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & cellfun(@(x) max(max(x)), T.pethconvSpatial)>cri_meanFR; % mean firing rate > 1hz
% tPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR;
ntPC_noRw = sum(double(tPC_noRw));

noRw_PRE = cell2mat(T.rateMap1D_PRE(tPC_noRw));
noRw_STM = cell2mat(T.rateMap1D_STM(tPC_noRw));
noRw_POST = cell2mat(T.rateMap1D_POST(tPC_noRw));

%normalized
noRw_PRE = noRw_PRE./repmat(max(noRw_PRE,[],2),1,nBin_ctrl);
noRw_STM = noRw_STM./repmat(max(noRw_STM,[],2),1,nBin_ctrl);
noRw_POST = noRw_POST./repmat(max(noRw_POST,[],2),1,nBin_ctrl);

[pvCorr_noRw_preXstm, pvCorr_noRw_preXpost, pvCorr_noRw_stmXpost] = deal([]);
for iCol = 1:nBin_ctrl
    pvCorr_noRw_preXstm(iCol) = corr(noRw_PRE(:,iCol),noRw_STM(:,iCol),'rows','complete','type','Pearson');
    pvCorr_noRw_preXpost(iCol) = corr(noRw_PRE(:,iCol),noRw_POST(:,iCol),'rows','complete','type','Pearson');
    pvCorr_noRw_stmXpost(iCol) = corr(noRw_STM(:,iCol),noRw_POST(:,iCol),'rows','complete','type','Pearson');
end


%% statistic
group_Run = [ones(nBin_inlightRun,1);2*ones(nBin_outlightRun,1);3*ones(nBin_ctrl,1)];
group_Rw = [ones(nBin_inlightRw,1);2*ones(nBin_outlightRw,1);3*ones(nBin_ctrl,1)];

% mean & sem
m_pvCorr_inlight_Run = [mean(pvCorr_inRun_preXstm), mean(pvCorr_inRun_preXpost), mean(pvCorr_inRun_stmXpost)];
sem_pvCorr_inlight_Run = [std(pvCorr_inRun_preXstm,0,2)/sqrt(nBin_inlightRun), std(pvCorr_inRun_preXpost,0,2)/sqrt(nBin_inlightRun), std(pvCorr_inRun_stmXpost,0,2)/sqrt(nBin_inlightRun)];

m_pvCorr_outlight_Run = [mean(pvCorr_outRun_preXstm), mean(pvCorr_outRun_preXpost), mean(pvCorr_outRun_stmXpost)];
sem_pvCorr_outlight_Run = [std(pvCorr_outRun_preXstm,0,2)/sqrt(nBin_outlightRun), std(pvCorr_outRun_preXpost,0,2)/sqrt(nBin_outlightRun), std(pvCorr_outRun_stmXpost,0,2)/sqrt(nBin_outlightRun)];

m_pvCorr_inlight_Rw = [mean(pvCorr_inRw_preXstm), mean(pvCorr_inRw_preXpost), mean(pvCorr_inRw_stmXpost)];
sem_pvCorr_inlight_Rw = [std(pvCorr_inRw_preXstm,0,2)/sqrt(nBin_inlightRw), std(pvCorr_inRw_preXpost,0,2)/sqrt(nBin_inlightRw), std(pvCorr_inRw_stmXpost,0,2)/sqrt(nBin_inlightRw)];

m_pvCorr_outlight_Rw = [mean(pvCorr_outRw_preXstm), mean(pvCorr_outRw_preXpost), mean(pvCorr_outRw_stmXpost)];
sem_pvCorr_outlight_Rw = [std(pvCorr_outRw_preXstm,0,2)/sqrt(nBin_outlightRw), std(pvCorr_outRw_preXpost,0,2)/sqrt(nBin_outlightRw), std(pvCorr_outRw_stmXpost,0,2)/sqrt(nBin_outlightRw)];

m_pvCorr_noRun = [mean(pvCorr_noRun_preXstm), mean(pvCorr_noRun_preXpost), mean(pvCorr_noRun_stmXpost)];
sem_pvCorr_noRun = [std(pvCorr_noRun_preXstm,0,2)/sqrt(nBin_ctrl), std(pvCorr_noRun_preXpost,0,2)/sqrt(nBin_ctrl), std(pvCorr_noRun_stmXpost,0,2)/sqrt(nBin_ctrl)];

m_pvCorr_noRw = [mean(pvCorr_noRw_preXstm), mean(pvCorr_noRw_preXpost), mean(pvCorr_noRw_stmXpost)];
sem_pvCorr_noRw = [std(pvCorr_noRw_preXstm,0,2)/sqrt(nBin_ctrl), std(pvCorr_noRw_preXpost,0,2)/sqrt(nBin_ctrl), std(pvCorr_noRw_stmXpost,0,2)/sqrt(nBin_ctrl)];

% Run session
[p_totalRun(1), table, stats] = kruskalwallis([pvCorr_inRun_preXstm,pvCorr_outRun_preXstm,pvCorr_noRun_preXstm],group_Run,'off');
result_Run = multcompare(stats,'ctype','hsd','Display','off');
% result_Run = multcompare(stats,'ctype','bonferroni','Display','off');
% result_Run = multcompare(stats,'ctype','lsd','Display','off');
p_Run(:,1) = result_Run(:,end);

[p_totalRun(2), table, stats] = kruskalwallis([pvCorr_inRun_preXpost,pvCorr_outRun_preXpost,pvCorr_noRun_preXpost],group_Run,'off');
result_Run = multcompare(stats,'ctype','hsd','Display','off');
% result_Run = multcompare(stats,'ctype','bonferroni','Display','off');
% result_Run = multcompare(stats,'ctype','lsd','Display','off');
p_Run(:,2) = result_Run(:,end);

[p_totalRun(3), table, stats] = kruskalwallis([pvCorr_inRun_stmXpost,pvCorr_outRun_stmXpost,pvCorr_noRun_stmXpost],group_Run,'off');
result_Run = multcompare(stats,'ctype','hsd','Display','off');
% result_Run = multcompare(stats,'ctype','bonferroni','Display','off');
% result_Run = multcompare(stats,'ctype','lsd','Display','off');
p_Run(:,3) = result_Run(:,end);

% Rw session
[p_totalRw(1), table, stats] = kruskalwallis([pvCorr_inRw_preXstm,pvCorr_outRw_preXstm,pvCorr_noRw_preXstm],group_Rw,'off');
result_Rw = multcompare(stats,'ctype','hsd','Display','off');
% result_Rw = multcompare(stats,'ctype','bonferroni','Display','off');
% result_Rw = multcompare(stats,'ctype','lsd','Display','off');
p_Rw(:,1) = result_Rw(:,end);

[p_totalRw(2), table, stats] = kruskalwallis([pvCorr_inRw_preXpost,pvCorr_outRw_preXpost,pvCorr_noRw_preXpost],group_Rw,'off');
result_Rw = multcompare(stats,'ctype','hsd','Display','off');
% result_Rw = multcompare(stats,'ctype','bonferroni','Display','off');
% result_Rw = multcompare(stats,'ctype','lsd','Display','off');
p_Rw(:,2) = result_Rw(:,end);

[p_totalRw(3), table, stats] = kruskalwallis([pvCorr_inRw_stmXpost,pvCorr_outRw_stmXpost,pvCorr_noRw_stmXpost],group_Rw,'off');
result_Rw = multcompare(stats,'ctype','hsd','Display','off');
% result_Rw = multcompare(stats,'ctype','bonferroni','Display','off');
% result_Rw = multcompare(stats,'ctype','lsd','Display','off');
p_Rw(:,3) = result_Rw(:,end);

%%
barWidth = 0.18;
% barWidth = 0.8;
eBarLength = 0.3;
eBarWidth = 0.8;
eBarColor = colorBlack;
nCol = 3;
nRow = 5;

xScatterRunIn = (rand(nBin_inlightRun,1)-0.5)*barWidth*2.2;
xScatterRunOut = (rand(nBin_outlightRun,1)-0.5)*barWidth*2.2;
xScatterRwIn = (rand(nBin_inlightRw,1)-0.5)*barWidth*2.2;
xScatterRwOut = (rand(nBin_outlightRw,1)-0.5)*barWidth*2.2;
xScatterTotal = (rand(nBin_ctrl,1)-0.5)*barWidth*2.2;

fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});

hPVCorr(1) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
bar([1,5,9],m_pvCorr_inlight_Run,barWidth,'faceColor',colorLLightBlue);
hold on;
errorbarJun([1,5,9],m_pvCorr_inlight_Run,sem_pvCorr_inlight_Run,0.3,1.0,colorBlack);
hold on;
bar([2,6,10],m_pvCorr_outlight_Run,barWidth,'faceColor',colorLightGray)
hold on;
errorbarJun([2,6,10],m_pvCorr_outlight_Run,sem_pvCorr_inlight_Run,0.3,1.0,colorBlack);
hold on;
bar([3,7,11],m_pvCorr_noRun,barWidth,'faceColor',colorDarkGray)
hold on;
errorbarJun([3,7,11],m_pvCorr_noRun,sem_pvCorr_noRun,0.3,1.0,colorBlack);
hold on;

plot(1+xScatterRunIn, pvCorr_inRun_preXstm, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(2+xScatterRunOut, pvCorr_outRun_preXstm, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(3+xScatterTotal, pvCorr_noRun_preXstm, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;

plot(5+xScatterRunIn, pvCorr_inRun_preXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(6+xScatterRunOut, pvCorr_outRun_preXpost,'.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(7+xScatterTotal, pvCorr_noRun_preXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;

plot(9+xScatterRunIn, pvCorr_inRun_stmXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(10+xScatterRunOut, pvCorr_outRun_stmXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(11+xScatterTotal, pvCorr_noRun_stmXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;

title('Run','fontSize',fontM);
ylabel('PV correlation','fontSize',fontM);

text(-2, -0.7,['p12 = ',num2str(p_Run(1,1))],'fontSize',fontM,'color',colorBlack);
text(-2, -0.9,['p13 = ',num2str(p_Run(2,1))],'fontSize',fontM,'color',colorBlack);
text(-2, -1.1,['p23 = ',num2str(p_Run(3,1))],'fontSize',fontM,'color',colorBlack);

text(5.5, -0.7,[num2str(p_Run(1,2))],'fontSize',fontM,'color',colorBlack);
text(5.5, -0.9,[num2str(p_Run(2,2))],'fontSize',fontM,'color',colorBlack);
text(5.5, -1.1,[num2str(p_Run(3,2))],'fontSize',fontM,'color',colorBlack);

text(11, -0.7,[num2str(p_Run(1,3))],'fontSize',fontM,'color',colorBlack);
text(11, -0.9,[num2str(p_Run(2,3))],'fontSize',fontM,'color',colorBlack);
text(11, -1.1,[num2str(p_Run(3,3))],'fontSize',fontM,'color',colorBlack);


hPVCorr(2) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,2,1,[0.15 0.1 0.85 0.85],midInterval),wideInterval));
bar([1,5,9],m_pvCorr_inlight_Rw,barWidth,'faceColor',colorLLightBlue);
hold on;
errorbarJun([1,5,9],m_pvCorr_inlight_Rw,sem_pvCorr_inlight_Rw,0.3,1.0,colorBlack);
hold on;
bar([2,6,10],m_pvCorr_outlight_Rw,barWidth,'faceColor',colorLightGray)
hold on;
errorbarJun([2,6,10],m_pvCorr_outlight_Rw,sem_pvCorr_inlight_Run,0.3,1.0,colorBlack);
hold on;
bar([3,7,11],m_pvCorr_noRw,barWidth,'faceColor',colorDarkGray)
hold on;
errorbarJun([3,7,11],m_pvCorr_noRw,sem_pvCorr_noRw,0.3,1.0,colorBlack);
hold on;

plot(1+xScatterRwIn, pvCorr_inRw_preXstm, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(2+xScatterRwOut, pvCorr_outRw_preXstm, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(3+xScatterTotal, pvCorr_noRw_preXstm, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;

plot(5+xScatterRwIn, pvCorr_inRw_preXpost,'.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(6+xScatterRwOut, pvCorr_outRw_preXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(7+xScatterTotal, pvCorr_noRw_preXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;

plot(9+xScatterRwIn, pvCorr_inRw_stmXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(10+xScatterRwOut, pvCorr_outRw_stmXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(11+xScatterTotal, pvCorr_noRw_stmXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
 
title('Rw','fontSize',fontM);
ylabel('PV correlation','fontSize',fontM);

text(-2, -0.7,['p12 = ',num2str(p_Rw(1,1))],'fontSize',fontM,'color',colorBlack);
text(-2, -0.9,['p13 = ',num2str(p_Rw(2,1))],'fontSize',fontM,'color',colorBlack);
text(-2, -1.1,['p23 = ',num2str(p_Rw(3,1))],'fontSize',fontM,'color',colorBlack);

text(5.5, -0.7,[num2str(p_Rw(1,2))],'fontSize',fontM,'color',colorBlack);
text(5.5, -0.9,[num2str(p_Rw(2,2))],'fontSize',fontM,'color',colorBlack);
text(5.5, -1.1,[num2str(p_Rw(3,2))],'fontSize',fontM,'color',colorBlack);

text(11, -0.7,[num2str(p_Rw(1,3))],'fontSize',fontM,'color',colorBlack);
text(11, -0.9,[num2str(p_Rw(2,3))],'fontSize',fontM,'color',colorBlack);
text(11, -1.1,[num2str(p_Rw(3,3))],'fontSize',fontM,'color',colorBlack);

set(hPVCorr(1),'TickDir','out','Box','off','XLim',[0,12],'YLim',[-0.2 1.15],'XTick',[2, 6, 10],'XTickLabel',[{'PRExSTIM','PRExPOST','STIMxPOST'}],'fontSize',fontM);
set(hPVCorr(2),'TickDir','out','Box','off','XLim',[0,12],'YLim',[-0.2 1.15],'XTick',[2, 6, 10],'XTickLabel',[{'PRExSTIM','PRExPOST','STIMxPOST'}],'fontSize',fontM);
set(hPVCorr,'TickLength',[0.03, 0.03]);

% print('-painters','-r300','-dtiff',['f_short_suppleXX_PVCorr_InOutTotalZone_',datestr(now,formatOut),'_1cm1HzNormKW_withCC_dot.tif']);
% print('-painters','-r300','-depsc',['f_short_suppleXX_PVCorr_InOutTotalZone_',datestr(now,formatOut),'_1cm1HzNormKW_withCC_dot.ai']);
% close;