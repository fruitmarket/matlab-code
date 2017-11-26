clearvars;
cd('D:\Dropbox\SNL\P2_Track');
Txls = readtable('neuronList_ori50hz_171014.xlsx');
Txls.latencyIndex = categorical(Txls.latencyIndex);
load('neuronList_ori50hz_171014.mat');
load('D:\Dropbox\SNL\P2_Track\myParameters.mat');

formatOut = 'yymmdd';

% TN: track neuron
tPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;

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
tPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;

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

%%
barWidth = 0.3;
eBarLength = 0.3;
eBarWidth = 0.8;
eBarColor = colorBlack;
nCol = 2;
nRow = 1;
fHandle = figure('PaperUnits','centimeters','PaperPosition',[0 0 8.5 4.5]);

hPVCorr(1) = axes('Position',axpt(nCol,nRow,1,1,[0.1 0.08 0.85 0.80],wideInterval));
bar([1,3,5],m_tPC_DRun_PVcorr,barWidth,'faceColor',colorGray);
title('Total (DRun)','fontSize',fontS,'fontWeight','bold');
ylabel('PV correlation','fontSize',fontS);
text(4, 1.1,['n (DRun) = ',num2str(ntPC_DRun)],'fontSize',fontS,'color',colorDarkGray);


hPVCorr(2) = axes('Position',axpt(nCol,nRow,2,1,[0.1 0.08 0.85 0.80],wideInterval));
bar([1,3,5],m_tPC_DRw_PVcorr,barWidth,'faceColor',colorGray);
title('Total (DRw)','fontSize',fontS,'fontWeight','bold');
ylabel('PV correlation','fontSize',fontS);
text(4, 1.1,['n (DRw) = ',num2str(ntPC_DRw)],'fontSize',fontS,'color',colorDarkGray);

set(hPVCorr(1),'TickDir','out','Box','off','XLim',[0,6],'YLim',[0 1.15],'XTick',[1, 3, 5],'XTickLabel',[{'PRExSTM','PRExPOST','STMxPOST'}],'fontSize',fontS);
set(hPVCorr(2),'TickDir','out','Box','off','XLim',[0,6],'YLim',[0 1.15],'XTick',[1, 3, 5],'XTickLabel',[{'PRExSTM','PRExPOST','STMxPOST'}],'fontSize',fontS);

print('-painters','-r300','-dtiff',['final_figXX_placeField_PVCorr_DRunDRw_50hz_',datestr(now,formatOut),'.tif']);
print('-painters','-r300','-depsc',['final_figXX_placeField_PVCorr_DRunDRw_50hz_',datestr(now,formatOut),'.ai']);
close;