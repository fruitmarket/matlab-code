clearvars;
cd('D:\Dropbox\SNL\P2_Track');
% Txls = readtable('neuronList_ori50hz_171014.xlsx');
% Txls.latencyIndex = categorical(Txls.latencyIndex);
% load('neuronList_ori50hz_171014.mat');
load('neuronList_ori50hz_171014.mat');
load('D:\Dropbox\SNL\P2_Track\myParameters.mat');

formatOut = 'yymmdd';
lightLoc_Run = [floor(20*pi*5/6) ceil(20*pi*8/6)];
lightLoc_Rw = [floor(20*pi*9/6) ceil(20*pi*10/6)];

% TN: track neuron
tPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN';
ntPC_DRun = sum(double(tPC_DRun));

% corr of total neurons
tPC_DRun_PRE = cell2mat(T.rateMap1D_PRE(tPC_DRun));
tPC_DRun_STM = cell2mat(T.rateMap1D_STM(tPC_DRun));
tPC_DRun_POST = cell2mat(T.rateMap1D_POST(tPC_DRun));

inlightZone_PRE_Run = tPC_DRun_PRE(:,lightLoc_Run(1):lightLoc_Run(2));
inlightZone_STM_Run = tPC_DRun_STM(:,lightLoc_Run(1):lightLoc_Run(2));
inlightZone_POST_Run = tPC_DRun_POST(:,lightLoc_Run(1):lightLoc_Run(2));

outlightZone_PRE_Run = tPC_DRun_PRE(:,[1:lightLoc_Run(1)-1,lightLoc_Run(2)+1:124]);
outlightZone_STM_Run = tPC_DRun_STM(:,[1:lightLoc_Run(1)-1,lightLoc_Run(2)+1:124]);
outlightZone_POST_Run = tPC_DRun_POST(:,[1:lightLoc_Run(1)-1,lightLoc_Run(2)+1:124]);

[pvCorr_inRun_preXstm,pvCorr_inRun_preXpost,pvCorr_inRun_stmXpost] = deal([]);
[pvCorr_outRun_preXstm,pvCorr_outRun_preXpost,pvCorr_outRun_stmXpost] = deal([]);

for iCol = 1:33
    pvCorr_inRun_preXstm(iCol) = corr(inlightZone_PRE_Run(:,iCol),inlightZone_STM_Run(:,iCol),'type','Pearson');
    pvCorr_inRun_preXpost(iCol) = corr(inlightZone_PRE_Run(:,iCol),inlightZone_POST_Run(:,iCol),'type','Pearson');
    pvCorr_inRun_stmXpost(iCol) = corr(inlightZone_STM_Run(:,iCol),inlightZone_POST_Run(:,iCol),'type','Pearson');
end

for iCol = 1:91
    pvCorr_outRun_preXstm(iCol) = corr(outlightZone_PRE_Run(:,iCol),outlightZone_STM_Run(:,iCol),'type','Pearson');
    pvCorr_outRun_preXpost(iCol) = corr(outlightZone_PRE_Run(:,iCol),outlightZone_POST_Run(:,iCol),'type','Pearson');
    pvCorr_outRun_stmXpost(iCol) = corr(outlightZone_STM_Run(:,iCol),outlightZone_POST_Run(:,iCol),'type','Pearson');
end

f_pvCorr_inRun_preXstm = fisherZ(pvCorr_inRun_preXstm)';
f_pvCorr_inRun_preXpost = fisherZ(pvCorr_inRun_preXpost)';
f_pvCorr_inRun_stmXpost = fisherZ(pvCorr_inRun_stmXpost)';

f_pvCorr_outRun_preXstm = fisherZ(pvCorr_outRun_preXstm)';
f_pvCorr_outRun_preXpost = fisherZ(pvCorr_outRun_preXpost)';
f_pvCorr_outRun_stmXpost = fisherZ(pvCorr_outRun_stmXpost)';

m_pvCorr_inlight_Run = [nanmean(pvCorr_inRun_preXstm), nanmean(pvCorr_inRun_preXpost), nanmean(pvCorr_inRun_stmXpost)];
sem_pvCorr_inlight_Run = [nanstd(pvCorr_inRun_preXstm,0,2)/sqrt(33), nanstd(pvCorr_inRun_preXpost)/sqrt(33), nanstd(pvCorr_inRun_stmXpost)/sqrt(33)];

m_pvCorr_outlight_Run = [nanmean(pvCorr_outRun_preXstm), nanmean(pvCorr_outRun_preXpost), nanmean(pvCorr_outRun_stmXpost)];
sem_pvCorr_outlight_Run = [nanstd(pvCorr_outRun_preXstm,0,2)/sqrt(91), nanstd(pvCorr_outRun_preXpost)/sqrt(91), nanstd(pvCorr_outRun_stmXpost)/sqrt(91)];

%%
tPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN';
ntPC_DRw = sum(double(tPC_DRw));

% corr of total neurons
tPC_DRw_PRE = cell2mat(T.rateMap1D_PRE(tPC_DRw));
tPC_DRw_STM = cell2mat(T.rateMap1D_STM(tPC_DRw));
tPC_DRw_POST = cell2mat(T.rateMap1D_POST(tPC_DRw));

inlightZone_PRE_Rw = tPC_DRw_PRE(:,lightLoc_Rw(1):lightLoc_Rw(2));
inlightZone_STM_Rw = tPC_DRw_STM(:,lightLoc_Rw(1):lightLoc_Rw(2));
inlightZone_POST_Rw = tPC_DRw_POST(:,lightLoc_Rw(1):lightLoc_Rw(2));

outlightZone_PRE_Rw = tPC_DRw_PRE(:,[1:lightLoc_Rw(1)-1,lightLoc_Rw(2)+1:124]);
outlightZone_STM_Rw = tPC_DRw_STM(:,[1:lightLoc_Rw(1)-1,lightLoc_Rw(2)+1:124]);
outlightZone_POST_Rw = tPC_DRw_POST(:,[1:lightLoc_Rw(1)-1,lightLoc_Rw(2)+1:124]);

[pvCorr_inRw_preXstm,pvCorr_inRw_preXpost,pvCorr_inRw_stmXpost] = deal([]);
[pvCorr_outRw_preXstm,pvCorr_outRw_preXpost,pvCorr_outRw_stmXpost] = deal([]);

for iCol = 1:12
    pvCorr_inRw_preXstm(iCol) = corr(inlightZone_PRE_Rw(:,iCol),inlightZone_STM_Rw(:,iCol),'type','Pearson');
    pvCorr_inRw_preXpost(iCol) = corr(inlightZone_PRE_Rw(:,iCol),inlightZone_POST_Rw(:,iCol),'type','Pearson');
    pvCorr_inRw_stmXpost(iCol) = corr(inlightZone_STM_Rw(:,iCol),inlightZone_POST_Rw(:,iCol),'type','Pearson');
end

for iCol = 1:112
    pvCorr_outRw_preXstm(iCol) = corr(outlightZone_PRE_Rw(:,iCol),outlightZone_STM_Rw(:,iCol),'type','Pearson');
    pvCorr_outRw_preXpost(iCol) = corr(outlightZone_PRE_Rw(:,iCol),outlightZone_POST_Rw(:,iCol),'type','Pearson');
    pvCorr_outRw_stmXpost(iCol) = corr(outlightZone_STM_Rw(:,iCol),outlightZone_POST_Rw(:,iCol),'type','Pearson');
end

f_pvCorr_inRw_preXstm = fisherZ(pvCorr_inRw_preXstm)';
f_pvCorr_inRw_preXpost = fisherZ(pvCorr_inRw_preXpost)';
f_pvCorr_inRw_stmXpost = fisherZ(pvCorr_inRw_stmXpost)';

f_pvCorr_outRw_preXstm = fisherZ(pvCorr_outRw_preXstm)';
f_pvCorr_outRw_preXpost = fisherZ(pvCorr_outRw_preXpost)';
f_pvCorr_outRw_stmXpost = fisherZ(pvCorr_outRw_stmXpost)';

m_pvCorr_inlight_Rw = [nanmean(pvCorr_inRw_preXstm), nanmean(pvCorr_inRw_preXpost), nanmean(pvCorr_inRw_stmXpost)];
sem_pvCorr_inlight_Rw = [nanstd(pvCorr_inRw_preXstm,0,2)/sqrt(12), nanstd(pvCorr_inRw_preXpost)/sqrt(12), nanstd(pvCorr_inRw_stmXpost)/sqrt(12)];

m_pvCorr_outlight_Rw = [nanmean(pvCorr_outRw_preXstm), nanmean(pvCorr_outRw_preXpost), nanmean(pvCorr_outRw_stmXpost)];
sem_pvCorr_outlight_Rw = [nanstd(pvCorr_outRw_preXstm,0,2)/sqrt(112), nanstd(pvCorr_outRw_preXpost)/sqrt(112), nanstd(pvCorr_outRw_stmXpost)/sqrt(112)];

%% noLight 
load('neuronList_ori_171205.mat');
load('D:\Dropbox\SNL\P2_Track\myParameters.mat');

%%%% noRun %%%%
tPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN';
ntPC_noRun = sum(double(tPC_noRun));

tPC_noRun_PRE = cell2mat(T.rateMap1D_PRE(tPC_noRun));
tPC_noRun_STM = cell2mat(T.rateMap1D_STM(tPC_noRun));
tPC_noRun_POST = cell2mat(T.rateMap1D_POST(tPC_noRun));

[pvCorr_noRun_preXstm, pvCorr_noRun_preXpost, pvCorr_noRun_stmXpost] = deal([]);
for iCol = 1:124
    pvCorr_noRun_preXstm(iCol) = corr(tPC_noRun_PRE(:,iCol),tPC_noRun_STM(:,iCol),'type','Pearson');
    pvCorr_noRun_preXpost(iCol) = corr(tPC_noRun_PRE(:,iCol),tPC_noRun_POST(:,iCol),'type','Pearson');
    pvCorr_noRun_stmXpost(iCol) = corr(tPC_noRun_STM(:,iCol),tPC_noRun_POST(:,iCol),'type','Pearson');
end

f_pvCorr_noRun_preXstm = fisherZ(pvCorr_noRun_preXstm)';
f_pvCorr_noRun_preXpost = fisherZ(pvCorr_noRun_preXpost)';
f_pvCorr_noRun_stmXpost = fisherZ(pvCorr_noRun_stmXpost)';

m_pvCorr_noRun = [mean(pvCorr_noRun_preXstm), mean(pvCorr_noRun_preXpost), mean(pvCorr_noRun_stmXpost)];
sem_pvCorr_noRun = [std(pvCorr_noRun_preXstm,0,2)/sqrt(124), std(pvCorr_noRun_preXpost,0,2)/sqrt(124), std(pvCorr_noRun_stmXpost,0,2)/sqrt(124)];

%%%% noRw %%%%
tPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN';
ntPC_noRw = sum(double(tPC_noRw));

tPC_noRw_PRE = cell2mat(T.rateMap1D_PRE(tPC_noRw));
tPC_noRw_STM = cell2mat(T.rateMap1D_STM(tPC_noRw));
tPC_noRw_POST = cell2mat(T.rateMap1D_POST(tPC_noRw));

[pvCorr_noRw_preXstm, pvCorr_noRw_preXpost, pvCorr_noRw_stmXpost] = deal([]);
for iCol = 1:124
    pvCorr_noRw_preXstm(iCol) = corr(tPC_noRw_PRE(:,iCol),tPC_noRw_STM(:,iCol),'type','Pearson');
    pvCorr_noRw_preXpost(iCol) = corr(tPC_noRw_PRE(:,iCol),tPC_noRw_POST(:,iCol),'type','Pearson');
    pvCorr_noRw_stmXpost(iCol) = corr(tPC_noRw_STM(:,iCol),tPC_noRw_POST(:,iCol),'type','Pearson');
end

f_pvCorr_noRw_preXstm = fisherZ(pvCorr_noRw_preXstm)';
f_pvCorr_noRw_preXpost = fisherZ(pvCorr_noRw_preXpost)';
f_pvCorr_noRw_stmXpost = fisherZ(pvCorr_noRw_stmXpost)';

m_pvCorr_noRw = [nanmean(pvCorr_noRw_preXstm), nanmean(pvCorr_noRw_preXpost), nanmean(pvCorr_noRw_stmXpost)];
sem_pvCorr_noRw = [nanstd(pvCorr_noRw_preXstm,0,2)/sqrt(124), nanstd(pvCorr_noRw_preXpost,0,2)/sqrt(124), nanstd(pvCorr_noRw_stmXpost,0,2)/sqrt(124)];

%% statistic
% group
nInRun = 33;
nOutRun = 91;
nTotal = 124;
nInRw = 12;
nOutRw = 112;

group_Run = [ones(nInRun,1);2*ones(nOutRun,1);3*ones(nTotal,1)];
group_Rw = [ones(nInRw,1);2*ones(nOutRw,1);3*ones(nTotal,1)];

%% pv-correlation statistic
% Run session
[p_Run(1), ~, stats] = anova1([pvCorr_inRun_preXstm,pvCorr_outRun_preXstm,pvCorr_noRun_preXstm],group_Run,'off');
result_Run = multcompare(stats,'Alpha',0.05,'ctype','bonferroni','Display','off');
p_anova_Run(:,1) = result_Run(:,end);

[p_Run(2), ~, stats] = anova1([pvCorr_inRun_preXpost,pvCorr_outRun_preXpost,pvCorr_noRun_preXpost],group_Run,'off');
result_Run = multcompare(stats,'Alpha',0.05,'ctype','bonferroni','Display','off');
p_anova_Run(:,2) = result_Run(:,end);

[p_Run(3), ~, stats] = anova1([pvCorr_inRun_stmXpost,pvCorr_outRun_stmXpost,pvCorr_noRun_stmXpost],group_Run,'off');
result_Run = multcompare(stats,'Alpha',0.05,'ctype','bonferroni','Display','off');
p_anova_Run(:,3) = result_Run(:,end);

% Rw session
[p_Rw(1), ~, stats] = anova1([pvCorr_inRw_preXstm,pvCorr_outRw_preXstm,pvCorr_noRw_preXstm],group_Rw,'off');
result_Rw = multcompare(stats,'Alpha',0.05,'ctype','bonferroni','Display','off');
p_anova_Rw(:,1) = result_Rw(:,end);

[p_Rw(2), ~, stats] = anova1([pvCorr_inRw_preXpost,pvCorr_outRw_preXpost,pvCorr_noRw_preXpost],group_Rw,'off');
result_Rw = multcompare(stats,'Alpha',0.05,'ctype','bonferroni','Display','off');
p_anova_Rw(:,2) = result_Rw(:,end);

[p_Rw(3), ~, stats] = anova1([pvCorr_inRw_stmXpost,pvCorr_outRw_stmXpost,pvCorr_noRw_stmXpost],group_Rw,'off');
result_Rw = multcompare(stats,'Alpha',0.05,'ctype','bonferroni','Display','off');
p_anova_Rw(:,3) = result_Rw(:,end);

%% fisher-z transform statistic
% Run session
% [p_Run(1), ~, stats] = anova1([f_pvCorr_inRun_preXstm,f_pvCorr_outRun_preXstm,f_pvCorr_noRun_preXstm],group_Run','off');
% result_Run = multcompare(stats,'Alpha',0.05,'ctype','bonferroni','Display','off');
% p_anova_Run(:,1) = result_Run(:,end);
% 
% [p_Run(2), ~, stats] = anova1([f_pvCorr_inRun_preXpost,f_pvCorr_outRun_preXpost,f_pvCorr_noRun_preXpost],group_Run','off');
% result_Run = multcompare(stats,'Alpha',0.05,'ctype','bonferroni','Display','off');
% p_anova_Run(:,2) = result_Run(:,end);
% 
% [p_Run(3), ~, stats] = anova1([f_pvCorr_inRun_stmXpost,f_pvCorr_outRun_stmXpost,f_pvCorr_noRun_stmXpost],group_Run','off');
% result_Run = multcompare(stats,'Alpha',0.05,'ctype','bonferroni','Display','off');
% p_anova_Run(:,3) = result_Run(:,end);
% 
% % Rw session
% [p_Rw(1), ~, stats] = anova1([f_pvCorr_inRw_preXstm,f_pvCorr_outRw_preXstm,f_pvCorr_noRw_preXstm],group_Rw','off');
% result_Rw = multcompare(stats,'Alpha',0.05,'ctype','bonferroni','Display','off');
% p_anova_Rw(:,1) = result_Rw(:,end);
% 
% [p_Rw(2), ~, stats] = anova1([f_pvCorr_inRw_preXpost,f_pvCorr_outRw_preXpost,f_pvCorr_noRw_preXpost],group_Rw','off');
% result_Rw = multcompare(stats,'Alpha',0.05,'ctype','bonferroni','Display','off');
% p_anova_Rw(:,2) = result_Rw(:,end);
% 
% [p_Rw(3), ~, stats] = anova1([f_pvCorr_inRw_stmXpost,f_pvCorr_outRw_stmXpost,f_pvCorr_noRw_stmXpost],group_Rw','off');
% result_Rw = multcompare(stats,'Alpha',0.05,'ctype','bonferroni','Display','off');
% p_anova_Rw(:,3) = result_Rw(:,end);

%%
barWidth = 0.18;
% barWidth = 0.8;
eBarLength = 0.3;
eBarWidth = 0.8;
eBarColor = colorBlack;
nCol = 3;
nRow = 5;
fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});

hPVCorr(1) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
% bar([1,2,3],m_pvCorr_inlight_Run,barWidth,'faceColor',colorLLightBlue);
% hold on;
% errorbarJun([1,2,3],m_pvCorr_inlight_Run,sem_pvCorr_inlight_Run,0.3,1.0,colorBlack);
% hold on;
% bar([6,7,8],m_pvCorr_outlight_Run,barWidth,'faceColor',colorLightGray)
% hold on;
% errorbarJun([6,7,8],m_pvCorr_outlight_Run,sem_pvCorr_inlight_Run,0.3,1.0,colorBlack);
% hold on;
% bar([11,12,13],m_pvCorr_noRun,barWidth,'faceColor',colorDarkGray)
% hold on;
% errorbarJun([11,12,13],m_pvCorr_noRun,sem_pvCorr_noRun,0.3,1.0,colorBlack);
bar([1,6,11],m_pvCorr_inlight_Run,barWidth,'faceColor',colorLLightBlue);
hold on;
errorbarJun([1,6,11],m_pvCorr_inlight_Run,sem_pvCorr_inlight_Run,0.3,1.0,colorBlack);
hold on;
bar([2,7,12],m_pvCorr_outlight_Run,barWidth,'faceColor',colorLightGray)
hold on;
errorbarJun([2,7,12],m_pvCorr_outlight_Run,sem_pvCorr_inlight_Run,0.3,1.0,colorBlack);
hold on;
bar([3,8,13],m_pvCorr_noRun,barWidth,'faceColor',colorDarkGray)
hold on;
errorbarJun([3,8,13],m_pvCorr_noRun,sem_pvCorr_noRun,0.3,1.0,colorBlack);
title('Run','fontSize',fontM);
ylabel('PV correlation','fontSize',fontM);
% text(10, 1.2,['n (Run) = ',num2str(ntPC_DRun)],'fontSize',fontM,'color',colorDarkGray);

text(-2, -0.3,['p12 = ',num2str(p_anova_Run(1,1))],'fontSize',fontM,'color',colorBlack);
text(-2, -0.5,['p13 = ',num2str(p_anova_Run(2,1))],'fontSize',fontM,'color',colorBlack);
text(-2, -0.7,['p23 = ',num2str(p_anova_Run(3,1))],'fontSize',fontM,'color',colorBlack);

text(5.5, -0.3,[num2str(p_anova_Run(1,2))],'fontSize',fontM,'color',colorBlack);
text(5.5, -0.5,[num2str(p_anova_Run(2,2))],'fontSize',fontM,'color',colorBlack);
text(5.5, -0.7,[num2str(p_anova_Run(3,2))],'fontSize',fontM,'color',colorBlack);

text(11, -0.3,[num2str(p_anova_Run(1,3))],'fontSize',fontM,'color',colorBlack);
text(11, -0.5,[num2str(p_anova_Run(2,3))],'fontSize',fontM,'color',colorBlack);
text(11, -0.7,[num2str(p_anova_Run(3,3))],'fontSize',fontM,'color',colorBlack);

hPVCorr(2) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,2,1,[0.15 0.1 0.85 0.85],midInterval),wideInterval));
% bar([1,2,3],m_pvCorr_inlight_Rw,barWidth,'faceColor',colorLLightBlue);
% hold on;
% errorbarJun([1,2,3],m_pvCorr_inlight_Rw,sem_pvCorr_inlight_Rw,0.3,1.0,colorBlack);
% hold on;
% bar([6,7,8],m_pvCorr_outlight_Rw,barWidth,'faceColor',colorLightGray)
% hold on;
% errorbarJun([6,7,8],m_pvCorr_outlight_Rw,sem_pvCorr_inlight_Run,0.3,1.0,colorBlack);
% hold on;
% bar([11,12,13],m_pvCorr_noRw,barWidth,'faceColor',colorDarkGray)
% hold on;
% errorbarJun([11,12,13],m_pvCorr_noRw,sem_pvCorr_noRw,0.3,1.0,colorBlack);
bar([1,6,11],m_pvCorr_inlight_Rw,barWidth,'faceColor',colorLLightBlue);
hold on;
errorbarJun([1,6,11],m_pvCorr_inlight_Rw,sem_pvCorr_inlight_Rw,0.3,1.0,colorBlack);
hold on;
bar([2,7,12],m_pvCorr_outlight_Rw,barWidth,'faceColor',colorLightGray)
hold on;
errorbarJun([2,7,12],m_pvCorr_outlight_Rw,sem_pvCorr_inlight_Run,0.3,1.0,colorBlack);
hold on;
bar([3,8,13],m_pvCorr_noRw,barWidth,'faceColor',colorDarkGray)
hold on;
errorbarJun([3,8,13],m_pvCorr_noRw,sem_pvCorr_noRw,0.3,1.0,colorBlack);
title('Rw','fontSize',fontM);
ylabel('PV correlation','fontSize',fontM);
% text(10, 1.2,['n (Run) = ',num2str(ntPC_DRun)],'fontSize',fontM,'color',colorDarkGray);
text(-2, -0.3,['p12 = ',num2str(p_anova_Rw(1,1))],'fontSize',fontM,'color',colorBlack);
text(-2, -0.5,['p13 = ',num2str(p_anova_Rw(2,1))],'fontSize',fontM,'color',colorBlack);
text(-2, -0.7,['p23 = ',num2str(p_anova_Rw(3,1))],'fontSize',fontM,'color',colorBlack);

text(5.5, -0.3,[num2str(p_anova_Rw(1,2))],'fontSize',fontM,'color',colorBlack);
text(5.5, -0.5,[num2str(p_anova_Rw(2,2))],'fontSize',fontM,'color',colorBlack);
text(5.5, -0.7,[num2str(p_anova_Rw(3,2))],'fontSize',fontM,'color',colorBlack);

text(11, -0.3,[num2str(p_anova_Rw(1,3))],'fontSize',fontM,'color',colorBlack);
text(11, -0.5,[num2str(p_anova_Rw(2,3))],'fontSize',fontM,'color',colorBlack);
text(11, -0.7,[num2str(p_anova_Rw(3,3))],'fontSize',fontM,'color',colorBlack);

set(hPVCorr(1),'TickDir','out','Box','off','XLim',[0,14],'YLim',[0 1.15],'XTick',[2, 7, 12],'XTickLabel',[{'PRExSTIM','PRExPOST','STIMxPOST'}],'fontSize',fontM);
set(hPVCorr(2),'TickDir','out','Box','off','XLim',[0,14],'YLim',[0 1.15],'XTick',[2, 7, 12],'XTickLabel',[{'PRExSTIM','PRExPOST','STIMxPOST'}],'fontSize',fontM);

print('-painters','-r300','-dtiff',['f_short_suppleXX_PVCorr_InOutTotalZone_',datestr(now,formatOut),'.tif']);
print('-painters','-r300','-depsc',['f_short_suppleXX_PVCorr_InOutTotalZone_',datestr(now,formatOut),'.ai']);
close;