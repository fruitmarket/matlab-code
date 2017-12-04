clearvars;
cd('D:\Dropbox\SNL\P2_Track');
% Txls = readtable('neuronList_ori_control_171014.xlsx');
% Txls.latencyIndex = categorical(Txls.latencyIndex);
% load('neuronList_ori50hz_171014.mat');
load('neuronList_ori_control_171014.mat');
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

[pvCorr_inLight_preXstm_Run,pvCorr_inLight_preXpost_Run,pvCorr_inLight_stmXpost_Run] = deal([]);
[pvCorr_outLight_preXstm_Run,pvCorr_outLight_preXpost_Run,pvCorr_outLight_stmXpost_Run] = deal([]);

for iCol = 1:33
    pvCorr_inLight_preXstm_Run(iCol) = corr(inlightZone_PRE_Run(:,iCol),inlightZone_STM_Run(:,iCol),'type','Pearson');
    pvCorr_inLight_preXpost_Run(iCol) = corr(inlightZone_PRE_Run(:,iCol),inlightZone_POST_Run(:,iCol),'type','Pearson');
    pvCorr_inLight_stmXpost_Run(iCol) = corr(inlightZone_STM_Run(:,iCol),inlightZone_POST_Run(:,iCol),'type','Pearson');
end

for iCol = 1:91
    pvCorr_outLight_preXstm_Run(iCol) = corr(outlightZone_PRE_Run(:,iCol),outlightZone_STM_Run(:,iCol),'type','Pearson');
    pvCorr_outLight_preXpost_Run(iCol) = corr(outlightZone_PRE_Run(:,iCol),outlightZone_POST_Run(:,iCol),'type','Pearson');
    pvCorr_outLight_stmXpost_Run(iCol) = corr(outlightZone_STM_Run(:,iCol),outlightZone_POST_Run(:,iCol),'type','Pearson');
end

m_pvCorr_inlight_Run = [nanmean(pvCorr_inLight_preXstm_Run), nanmean(pvCorr_inLight_preXpost_Run), nanmean(pvCorr_inLight_stmXpost_Run)];
sem_pvCorr_inlight_Run = [nanstd(pvCorr_inLight_preXstm_Run,0,2)/sqrt(33), nanstd(pvCorr_inLight_preXpost_Run)/sqrt(33), nanstd(pvCorr_inLight_stmXpost_Run)/sqrt(33)];

m_pvCorr_outlight_Run = [nanmean(pvCorr_outLight_preXstm_Run), nanmean(pvCorr_outLight_preXpost_Run), nanmean(pvCorr_outLight_stmXpost_Run)];
sem_pvCorr_outlight_Run = [nanstd(pvCorr_outLight_preXstm_Run,0,2)/sqrt(91), nanstd(pvCorr_outLight_preXpost_Run)/sqrt(91), nanstd(pvCorr_outLight_stmXpost_Run)/sqrt(91)];

%%
% tPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
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

[pvCorr_inLight_preXstm_Rw,pvCorr_inLight_preXpost_Rw,pvCorr_inLight_stmXpost_Rw] = deal([]);
[pvCorr_outLight_preXstm_Rw,pvCorr_outLight_preXpost_Rw,pvCorr_outLight_stmXpost_Rw] = deal([]);

for iCol = 1:12
    pvCorr_inLight_preXstm_Rw(iCol) = corr(inlightZone_PRE_Rw(:,iCol),inlightZone_STM_Rw(:,iCol),'type','Pearson');
    pvCorr_inLight_preXpost_Rw(iCol) = corr(inlightZone_PRE_Rw(:,iCol),inlightZone_POST_Rw(:,iCol),'type','Pearson');
    pvCorr_inLight_stmXpost_Rw(iCol) = corr(inlightZone_STM_Rw(:,iCol),inlightZone_POST_Rw(:,iCol),'type','Pearson');
end

for iCol = 1:112
    pvCorr_outLight_preXstm_Rw(iCol) = corr(outlightZone_PRE_Rw(:,iCol),outlightZone_STM_Rw(:,iCol),'type','Pearson');
    pvCorr_outLight_preXpost_Rw(iCol) = corr(outlightZone_PRE_Rw(:,iCol),outlightZone_POST_Rw(:,iCol),'type','Pearson');
    pvCorr_outLight_stmXpost_Rw(iCol) = corr(outlightZone_STM_Rw(:,iCol),outlightZone_POST_Rw(:,iCol),'type','Pearson');
end

m_pvCorr_inlight_Rw = [nanmean(pvCorr_inLight_preXstm_Rw), nanmean(pvCorr_inLight_preXpost_Rw), nanmean(pvCorr_inLight_stmXpost_Rw)];
sem_pvCorr_inlight_Rw = [nanstd(pvCorr_inLight_preXstm_Rw,0,2)/sqrt(12), nanstd(pvCorr_inLight_preXpost_Rw)/sqrt(12), nanstd(pvCorr_inLight_stmXpost_Rw)/sqrt(12)];

m_pvCorr_outlight_Rw = [nanmean(pvCorr_outLight_preXstm_Rw), nanmean(pvCorr_outLight_preXpost_Rw), nanmean(pvCorr_outLight_stmXpost_Rw)];
sem_pvCorr_outlight_Rw = [nanstd(pvCorr_outLight_preXstm_Rw,0,2)/sqrt(112), nanstd(pvCorr_outLight_preXpost_Rw)/sqrt(112), nanstd(pvCorr_outLight_stmXpost_Rw)/sqrt(112)];

%% statistics 1
[~, p_Runttest_in(1)] = ttest(pvCorr_inLight_preXstm_Run, pvCorr_inLight_preXpost_Run);
[~, p_Runttest_in(2)] = ttest(pvCorr_inLight_preXstm_Run, pvCorr_inLight_stmXpost_Run);
[~, p_Runttest_in(3)] = ttest(pvCorr_inLight_preXpost_Run, pvCorr_inLight_stmXpost_Run);

[~, p_Runttest_out(1)] = ttest(pvCorr_outLight_preXstm_Run, pvCorr_outLight_preXpost_Run);
[~, p_Runttest_out(2)] = ttest(pvCorr_outLight_preXstm_Run, pvCorr_outLight_stmXpost_Run);
[~, p_Runttest_out(3)] = ttest(pvCorr_outLight_preXpost_Run, pvCorr_outLight_stmXpost_Run);

[p_Rwttest_in(1)] = ranksum(pvCorr_inLight_preXstm_Rw, pvCorr_inLight_preXpost_Rw);
[p_Rwttest_in(2)] = ranksum(pvCorr_inLight_preXstm_Rw, pvCorr_inLight_stmXpost_Rw);
[p_Rwttest_in(3)] = ranksum(pvCorr_inLight_preXpost_Rw, pvCorr_inLight_stmXpost_Rw);

[~, p_Rwttest_out(1)] = ttest(pvCorr_outLight_preXstm_Rw, pvCorr_outLight_preXpost_Rw);
[~, p_Rwttest_out(2)] = ttest(pvCorr_outLight_preXstm_Rw, pvCorr_outLight_stmXpost_Rw);
[~, p_Rwttest_out(3)] = ttest(pvCorr_outLight_preXpost_Rw, pvCorr_outLight_stmXpost_Rw);

%%
barWidth = 0.3;
eBarLength = 0.3;
eBarWidth = 0.8;
eBarColor = colorBlack;
nCol = 3;
nRow = 5;
fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});

hPVCorr(1) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
bar([1,3,5],m_pvCorr_inlight_Run,barWidth,'faceColor',colorGray);
hold on;
errorbarJun([1,3,5],m_pvCorr_inlight_Run,sem_pvCorr_inlight_Run,0.3,1.0,colorBlack);
title('Run_InlightZone','fontSize',fontM,'fontWeight','bold','interpreter','none');
ylabel('PV correlation','fontSize',fontM);
text(4.2, 1.2,['n (Run) = ',num2str(ntPC_DRun)],'fontSize',fontM,'color',colorDarkGray);
text(1, -0.5,['p12 = ',num2str(p_Runttest_in(1))],'fontSize',fontM,'color',colorBlack);
text(1, -0.7,['p13 = ',num2str(p_Runttest_in(2))],'fontSize',fontM,'color',colorBlack);
text(1, -0.9,['p23 = ',num2str(p_Runttest_in(3))],'fontSize',fontM,'color',colorBlack);

hPVCorr(2) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1,3,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
bar([1,3,5],m_pvCorr_outlight_Run,barWidth,'faceColor',colorGray);
hold on;
errorbarJun([1,3,5],m_pvCorr_outlight_Run,sem_pvCorr_outlight_Run,0.3,1.0,colorBlack);
title('Run_OutlightZone','fontSize',fontM,'fontWeight','bold','interpreter','none');
ylabel('PV correlation','fontSize',fontM);
text(4.2, 1.2,['n (Run) = ',num2str(ntPC_DRun)],'fontSize',fontM,'color',colorDarkGray);
text(1, -0.5,['p12 = ',num2str(p_Rwttest_out(1))],'fontSize',fontM,'color',colorBlack);
text(1, -0.7,['p13 = ',num2str(p_Rwttest_out(2))],'fontSize',fontM,'color',colorBlack);
text(1, -0.9,['p23 = ',num2str(p_Rwttest_out(3))],'fontSize',fontM,'color',colorBlack);

hPVCorr(3) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
bar([1,3,5],m_pvCorr_inlight_Rw,barWidth,'faceColor',colorGray);
hold on;
errorbarJun([1,3,5],m_pvCorr_inlight_Rw,sem_pvCorr_inlight_Rw,0.3,1.0,colorBlack);
title('Rw_InlightZone','fontSize',fontM,'fontWeight','bold','interpreter','none');
ylabel('PV correlation','fontSize',fontM);
text(4.2, 1.2,['n (Rw) = ',num2str(ntPC_DRw)],'fontSize',fontM,'color',colorDarkGray);
text(1, -0.5,['p = ',num2str(p_Rwttest_in(1))],'fontSize',fontM,'color',colorBlack);
text(1, -0.7,['p = ',num2str(p_Rwttest_in(2))],'fontSize',fontM,'color',colorBlack);
text(1, -0.9,['p = ',num2str(p_Rwttest_in(3))],'fontSize',fontM,'color',colorBlack);

hPVCorr(4) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,2,3,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
bar([1,3,5],m_pvCorr_outlight_Rw,barWidth,'faceColor',colorGray);
hold on;
errorbarJun([1,3,5],m_pvCorr_outlight_Rw,sem_pvCorr_outlight_Rw,0.3,1.0,colorBlack);
title('Rw_OutlightZone','fontSize',fontM,'fontWeight','bold','interpreter','none');
ylabel('PV correlation','fontSize',fontM);
text(4.2, 1.2,['n (Rw) = ',num2str(ntPC_DRw)],'fontSize',fontM,'color',colorDarkGray);
text(1, -0.5,['p = ',num2str(p_Rwttest_out(1))],'fontSize',fontM,'color',colorBlack);
text(1, -0.7,['p = ',num2str(p_Rwttest_out(2))],'fontSize',fontM,'color',colorBlack);
text(1, -0.9,['p = ',num2str(p_Rwttest_out(3))],'fontSize',fontM,'color',colorBlack);

set(hPVCorr(1),'TickDir','out','Box','off','XLim',[0,6],'YLim',[0 1.15],'XTick',[1, 3, 5],'XTickLabel',[{'PRExSTIM','PRExPOST','STIMxPOST'}],'fontSize',fontM);
set(hPVCorr(2),'TickDir','out','Box','off','XLim',[0,6],'YLim',[0 1.15],'XTick',[1, 3, 5],'XTickLabel',[{'PRExSTIM','PRExPOST','STIMxPOST'}],'fontSize',fontM);
set(hPVCorr(3),'TickDir','out','Box','off','XLim',[0,6],'YLim',[0 1.15],'XTick',[1, 3, 5],'XTickLabel',[{'PRExSTIM','PRExPOST','STIMxPOST'}],'fontSize',fontM);
set(hPVCorr(4),'TickDir','out','Box','off','XLim',[0,6],'YLim',[0 1.15],'XTick',[1, 3, 5],'XTickLabel',[{'PRExSTIM','PRExPOST','STIMxPOST'}],'fontSize',fontM);

print('-painters','-r300','-dtiff',['f_short_suppleXX_PVCorr_RunRw_lightZone_eYFP_totalPN_',datestr(now,formatOut),'.tif']);
print('-painters','-r300','-depsc',['f_figXX_suppleXX_PVCorr_RunRw_lightZone_eYFP_totalPN_',datestr(now,formatOut),'.ai']);
close;