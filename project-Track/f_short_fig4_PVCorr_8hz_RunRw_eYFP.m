clearvars;
cd('D:\Dropbox\SNL\P2_Track');
load('neuronList_ori_control_171014.mat');
load('D:\Dropbox\SNL\P2_Track\myParameters.mat');

formatOut = 'yymmdd';

% TN: track neuron
tPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN';
% tPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
% tPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & cellfun(@(x) max(max(x)), T.pethconvSpatial)>1; % mean firing rate > 1hz

ntPC_DRun = sum(double(tPC_DRun));

% corr of total neurons
tPC_DRun_PRE = cell2mat(T.rateMap1D_PRE(tPC_DRun));
tPC_DRun_STM = cell2mat(T.rateMap1D_STM(tPC_DRun));
tPC_DRun_POST = cell2mat(T.rateMap1D_POST(tPC_DRun));

[tPC_DRun_PVcorr_preXstm, tPC_DRun_PVcorr_preXpost, tPC_DRun_PVcorr_stmXpost] = deal([]);

for iCol = 1:124
    tPC_DRun_PVcorr_preXstm(iCol) = corr(tPC_DRun_PRE(:,iCol),tPC_DRun_STM(:,iCol),'type','Pearson');
    tPC_DRun_PVcorr_preXpost(iCol) = corr(tPC_DRun_PRE(:,iCol),tPC_DRun_POST(:,iCol),'type','Pearson');
    tPC_DRun_PVcorr_stmXpost(iCol) = corr(tPC_DRun_STM(:,iCol),tPC_DRun_POST(:,iCol),'type','Pearson');    
end
m_tPC_DRun_PVcorr = [nanmean(tPC_DRun_PVcorr_preXstm), nanmean(tPC_DRun_PVcorr_preXpost), nanmean(tPC_DRun_PVcorr_stmXpost)];
sem_tPC_DRun_PVcorr = [nanstd(tPC_DRun_PVcorr_preXstm,0,2)/sqrt(ntPC_DRun), nanstd(tPC_DRun_PVcorr_preXpost,0,2)/sqrt(ntPC_DRun), nanstd(tPC_DRun_PVcorr_stmXpost,0,2)/sqrt(ntPC_DRun)];

% file example
% plot_Track_multi_v3(T.path(actPC_DRun),T.cellID(actPC_DRun),'C:\Users\Jun\Desktop\DRun_act');
% plot_Track_multi_v3(T.path(inaPC_DRun),T.cellID(inaPC_DRun),'C:\Users\Jun\Desktop\DRun_ina');

%%
% tPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
tPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN';
% tPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & cellfun(@(x) max(max(x)), T.pethconvSpatial)>1;

ntPC_DRw = sum(double(tPC_DRw));

% corr of total neurons
tPC_DRw_PRE = cell2mat(T.rateMap1D_PRE(tPC_DRw));
tPC_DRw_STM = cell2mat(T.rateMap1D_STM(tPC_DRw));
tPC_DRw_POST = cell2mat(T.rateMap1D_POST(tPC_DRw));

[tPC_DRw_PVcorr_preXstm, tPC_DRw_PVcorr_preXpost, tPC_DRw_PVcorr_stmXpost] = deal([]);

for iCol = 1:124
    tPC_DRw_PVcorr_preXstm(iCol) = corr(tPC_DRw_PRE(:,iCol),tPC_DRw_STM(:,iCol),'type','Pearson');
    tPC_DRw_PVcorr_preXpost(iCol) = corr(tPC_DRw_PRE(:,iCol),tPC_DRw_POST(:,iCol),'type','Pearson');
    tPC_DRw_PVcorr_stmXpost(iCol) = corr(tPC_DRw_STM(:,iCol),tPC_DRw_POST(:,iCol),'type','Pearson');
end
m_tPC_DRw_PVcorr = [nanmean(tPC_DRw_PVcorr_preXstm), nanmean(tPC_DRw_PVcorr_preXpost), nanmean(tPC_DRw_PVcorr_stmXpost)];
sem_tPC_DRw_PVcorr = [nanstd(tPC_DRw_PVcorr_preXstm,0,2)/sqrt(ntPC_DRw), nanstd(tPC_DRw_PVcorr_preXpost,0,2)/sqrt(ntPC_DRw), nanstd(tPC_DRw_PVcorr_stmXpost,0,2)/sqrt(ntPC_DRw)];

%% statistics 1
[~, p_Runttest(1)] = ttest(tPC_DRun_PVcorr_preXstm, tPC_DRun_PVcorr_preXpost);
[~, p_Runttest(2)] = ttest(tPC_DRun_PVcorr_preXstm, tPC_DRun_PVcorr_stmXpost);
[~, p_Runttest(3)] = ttest(tPC_DRun_PVcorr_preXpost, tPC_DRun_PVcorr_stmXpost);

[~, p_Rwttest(1)] = ttest(tPC_DRw_PVcorr_preXstm, tPC_DRw_PVcorr_preXpost);
[~, p_Rwttest(2)] = ttest(tPC_DRw_PVcorr_preXstm, tPC_DRw_PVcorr_stmXpost);
[~, p_Rwttest(3)] = ttest(tPC_DRw_PVcorr_preXpost, tPC_DRw_PVcorr_stmXpost);

%% statistics 2
% [p_Run_PRExSTIM, pv_Run_PRExSTIM] = bootstrapJun(tPC_DRun_PRE, tPC_DRun_STM,1000);
% [p_Run_STIMxPOST, pv_Run_STIMxPOST] = bootstrapJun(tPC_DRun_STM, tPC_DRun_POST,1000);
% [p_Run_PRExPOST, pv_Run_PRExPOST] = bootstrapJun(tPC_DRun_PRE, tPC_DRun_POST,1000);
% 
% [p_Rw_PRExSTIM, pv_Rw_PRExSTIM] = bootstrapJun(tPC_DRw_PRE, tPC_DRw_STM,1000);
% [p_Rw_STIMxPOST, pv_Rw_STIMxPOST] = bootstrapJun(tPC_DRw_STM, tPC_DRw_POST,1000);
% [p_Rw_PRExPOST, pv_Rw_PRExPOST] = bootstrapJun(tPC_DRw_PRE, tPC_DRw_POST,1000);
% 
% m_tPC_DRun_PVcorr = [pv_Run_PRExSTIM, pv_Run_STIMxPOST, pv_Run_PRExPOST];
% m_tPC_DRw_PVcorr = [pv_Rw_PRExSTIM, pv_Rw_STIMxPOST, pv_Rw_PRExPOST];

%%
barWidth = 0.3;
eBarLength = 0.3;
eBarWidth = 0.8;
eBarColor = colorBlack;
nCol = 3;
nRow = 5;
fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});

hPVCorr(1) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
bar([1,3,5],m_tPC_DRun_PVcorr,barWidth,'faceColor',colorGray);
hold on;
errorbarJun([1,3,5],m_tPC_DRun_PVcorr,sem_tPC_DRun_PVcorr,0.3,1.0,colorBlack);
title('Total (DRun)','fontSize',fontM,'fontWeight','bold');
ylabel('PV correlation','fontSize',fontM);
text(4.2, 1.2,['n (DRun) = ',num2str(ntPC_DRun)],'fontSize',fontM,'color',colorDarkGray);
text(-1, -0.8,['p12 = ',num2str(p_Runttest(1))],'fontSize',fontM,'color',colorBlack);
text(-1, -1.1,['p13 = ',num2str(p_Runttest(2))],'fontSize',fontM,'color',colorBlack);
text(-1, -1.4,['p23 = ',num2str(p_Runttest(3))],'fontSize',fontM,'color',colorBlack);

hPVCorr(2) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
bar([1,3,5],m_tPC_DRw_PVcorr,barWidth,'faceColor',colorGray);
hold on;
errorbarJun([1,3,5],m_tPC_DRw_PVcorr,sem_tPC_DRw_PVcorr,0.3,1.0,colorBlack);
title('Total (DRw)','fontSize',fontM,'fontWeight','bold');
ylabel('PV correlation','fontSize',fontM);
text(4.2, 1.2,['n (DRw) = ',num2str(ntPC_DRw)],'fontSize',fontM,'color',colorDarkGray);
text(-1, -0.8,['p12 = ',num2str(p_Rwttest(1))],'fontSize',fontM,'color',colorBlack);
text(-1, -1.1,['p13 = ',num2str(p_Rwttest(2))],'fontSize',fontM,'color',colorBlack);
text(-1, -1.4,['p23 = ',num2str(p_Rwttest(3))],'fontSize',fontM,'color',colorBlack);

set(hPVCorr(1),'TickDir','out','Box','off','XLim',[0,6],'YLim',[0 1.15],'XTick',[1, 3, 5],'XTickLabel',[{'PRExSTIM','PRExPOST','STIMxPOST'}],'fontSize',fontM);
set(hPVCorr(2),'TickDir','out','Box','off','XLim',[0,6],'YLim',[0 1.15],'XTick',[1, 3, 5],'XTickLabel',[{'PRExSTIM','PRExPOST','STIMxPOST'}],'fontSize',fontM);

print('-painters','-r300','-dtiff',['f_short_suppleXX_PVCorr_RunRw_8hz_totalPN_eYFP_',datestr(now,formatOut),'.tif']);
print('-painters','-r300','-depsc',['f_short_suppleXX_PVCorr_RunRw_8hz_totalPN_eYFP_',datestr(now,formatOut),'.ai']);
close;