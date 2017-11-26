clearvars;
cd('D:\Dropbox\SNL\P2_Track');
% Txls = readtable('neuronList_ori_control_170814.xlsx');
% Txls.latencyIndex = categorical(Txls.latencyIndex);
load('neuronList_ori_control_170818.mat');
load myParameters.mat;

formatOut = 'yymmdd';

% TN: track neuron
tPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
actPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == 1;
% directPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == 1 & Txls.latencyIndex == 'direct';
% indirectPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == 1 & Txls.latencyIndex == 'indirect';
% doublePC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == 1 & Txls.latencyIndex == 'double';
inaPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == -1;
norespPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxpLR_Track;

ntPC_DRun = sum(double(tPC_DRun));
nactPC_DRun = sum(double(actPC_DRun));
ninaPC_DRun = sum(double(inaPC_DRun));
nnorespPC_DRun = sum(double(norespPC_DRun));

% corr of total neurons
tPC_DRun_PRE = cell2mat(T.rateMap1D_PRE(tPC_DRun));
tPC_DRun_STM = cell2mat(T.rateMap1D_STM(tPC_DRun));
tPC_DRun_POST = cell2mat(T.rateMap1D_POST(tPC_DRun));

actPC_DRun_PRE = cell2mat(T.rateMap1D_PRE(actPC_DRun));
actPC_DRun_STM = cell2mat(T.rateMap1D_STM(actPC_DRun));
actPC_DRun_POST = cell2mat(T.rateMap1D_POST(actPC_DRun));

inaPC_DRun_PRE = cell2mat(T.rateMap1D_PRE(inaPC_DRun));
inaPC_DRun_STM = cell2mat(T.rateMap1D_STM(inaPC_DRun));
inaPC_DRun_POST = cell2mat(T.rateMap1D_POST(inaPC_DRun));

norespPC_DRun_PRE = cell2mat(T.rateMap1D_PRE(norespPC_DRun));
norespPC_DRun_STM = cell2mat(T.rateMap1D_STM(norespPC_DRun));
norespPC_DRun_POST = cell2mat(T.rateMap1D_POST(norespPC_DRun));

[tPC_DRun_PVcorr_preXstm, tPC_DRun_PVcorr_preXpost, tPC_DRun_PVcorr_stmXpost] = deal([]);
[actPC_DRun_PVcorr_preXstm, actPC_DRun_PVcorr_preXpost, actPC_DRun_PVcorr_stmXpost] = deal([]);
[inaPC_DRun_PVcorr_preXstm, inaPC_DRun_PVcorr_preXpost, inaPC_DRun_PVcorr_stmXpost] = deal([]);
[norespPC_DRun_PVcorr_preXstm, norespPC_DRun_PVcorr_preXpost, norespPC_DRun_PVcorr_stmXpost] = deal([]);

for iCol = 1:124
    tPC_DRun_PVcorr_preXstm(iCol) = corr(tPC_DRun_PRE(:,iCol),tPC_DRun_STM(:,iCol),'type','Pearson');
    tPC_DRun_PVcorr_preXpost(iCol) = corr(tPC_DRun_PRE(:,iCol),tPC_DRun_POST(:,iCol),'type','Pearson');
    tPC_DRun_PVcorr_stmXpost(iCol) = corr(tPC_DRun_STM(:,iCol),tPC_DRun_POST(:,iCol),'type','Pearson');
    
%     actPC_DRun_PVcorr_preXstm(iCol) = corr(actPC_DRun_PRE(:,iCol)',actPC_DRun_STM(:,iCol),'type','Pearson');
%     actPC_DRun_PVcorr_preXpost(iCol) = corr(actPC_DRun_PRE(:,iCol)',actPC_DRun_POST(:,iCol),'type','Pearson');
%     actPC_DRun_PVcorr_stmXpost(iCol) = corr(actPC_DRun_STM(:,iCol)',actPC_DRun_POST(:,iCol)','type','Pearson');
    
%     inaPC_DRun_PVcorr_preXstm(iCol) = corr(inaPC_DRun_PRE(:,iCol)',inaPC_DRun_STM(:,iCol),'type','Pearson');
%     inaPC_DRun_PVcorr_preXpost(iCol) = corr(inaPC_DRun_PRE(:,iCol),inaPC_DRun_POST(:,iCol),'type','Pearson');
%     inaPC_DRun_PVcorr_stmXpost(iCol) = corr(inaPC_DRun_STM(:,iCol),inaPC_DRun_POST(:,iCol),'type','Pearson');
    
    norespPC_DRun_PVcorr_preXstm(iCol) = corr(norespPC_DRun_PRE(:,iCol),norespPC_DRun_STM(:,iCol),'type','Pearson');
    norespPC_DRun_PVcorr_preXpost(iCol) = corr(norespPC_DRun_PRE(:,iCol),norespPC_DRun_POST(:,iCol),'type','Pearson');
    norespPC_DRun_PVcorr_stmXpost(iCol) = corr(norespPC_DRun_STM(:,iCol),norespPC_DRun_POST(:,iCol),'type','Pearson');    
end
m_tPC_DRun_PVcorr = [nanmean(tPC_DRun_PVcorr_preXstm), nanmean(tPC_DRun_PVcorr_preXpost), nanmean(tPC_DRun_PVcorr_stmXpost)];
% m_actPC_DRun_PVcorr = [nanmean(actPC_DRun_PVcorr_preXstm), nanmean(actPC_DRun_PVcorr_preXpost), nanmean(actPC_DRun_PVcorr_stmXpost)];
% m_inaPC_DRun_PVcorr = [nanmean(inaPC_DRun_PVcorr_preXstm), nanmean(inaPC_DRun_PVcorr_preXpost), nanmean(inaPC_DRun_PVcorr_stmXpost)];
m_norespPC_DRun_PVcorr = [nanmean(norespPC_DRun_PVcorr_preXstm), nanmean(norespPC_DRun_PVcorr_preXpost), nanmean(norespPC_DRun_PVcorr_stmXpost)];

sem_tPC_DRun_PVcorr = [nanstd(tPC_DRun_PVcorr_preXstm,0,2)/sqrt(ntPC_DRun), nanstd(tPC_DRun_PVcorr_preXpost,0,2)/sqrt(ntPC_DRun), nanstd(tPC_DRun_PVcorr_stmXpost,0,2)/sqrt(ntPC_DRun)];
% sem_actPC_DRun_PVcorr = [nanstd(actPC_DRun_PVcorr_preXstm,0,2)/sqrt(nactPC_DRun), nanstd(actPC_DRun_PVcorr_preXpost,0,2)/sqrt(nactPC_DRun), nanstd(actPC_DRun_PVcorr_stmXpost,0,2)/sqrt(nactPC_DRun)];
% sem_inaPC_DRun_PVcorr = [nanstd(inaPC_DRun_PVcorr_preXstm,0,2)/sqrt(ninaPC_DRun), nanstd(inaPC_DRun_PVcorr_preXpost,0,2)/sqrt(ninaPC_DRun), nanstd(inaPC_DRun_PVcorr_stmXpost,0,2)/sqrt(ninaPC_DRun)];
sem_norespPC_DRun_PVcorr = [nanstd(norespPC_DRun_PVcorr_preXstm,0,2)/sqrt(nnorespPC_DRun), nanstd(norespPC_DRun_PVcorr_preXpost,0,2)/sqrt(nnorespPC_DRun), nanstd(norespPC_DRun_PVcorr_stmXpost,0,2)/sqrt(nnorespPC_DRun)];

%%
barWidth = 0.3;
eBarLength = 0.3;
eBarWidth = 0.8;
eBarColor = colorBlack;
nCol = 4;
nRow = 2;
fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{2});

hTotalCorr(1) = axes('Position',axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval));
bar([1,4,7],m_tPC_DRun_PVcorr,barWidth,'faceColor',colorDarkGray);
hold on;
% errorbarJun([1,4,7],m_tPC_DRun_PVcorr,sem_tPC_DRun_PVcorr,eBarLength,eBarWidth,eBarColor);
hold on;
title('total place cells','fontSize',fontL,'fontWeight','bold');
ylabel('PV correlation','fontSize',fontL);
text(5, 1.1,['n (DRun) = ',num2str(ntPC_DRun)],'fontSize',fontL,'color',colorDarkGray);

% hTotalCorr(2) = axes('Position',axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],midInterval));
% bar([1,4,7],m_actPC_DRun_PVcorr,barWidth,'faceColor',colorDarkGray);
% hold on;
% % errorbarJun([1,4,7],m_actPC_DRun_PVcorr,sem_actPC_DRun_PVcorr,eBarLength,eBarWidth,eBarColor);
% title('activated place cells','fontSize',fontL,'fontWeight','bold');
% ylabel('Corr(z-transformed)','fontSize',fontL);
% text(5, 1.1,['n (DRun) = ',num2str(nactPC_DRun)],'fontSize',fontL,'color',colorDarkBlue);


% hTotalCorr(2) = axes('Position',axpt(nCol,nRow,3,1,[0.1 0.1 0.85 0.85],midInterval));
% bar([1,4,7],m_inaPC_DRun_PVcorr,barWidth,'faceColor',colorDarkGray);
% hold on;
% % errorbarJun([1,4,7],m_inaPC_DRun_PVcorr,sem_inaPC_DRun_PVcorr,eBarLength,eBarWidth,eBarColor);
% title('inactivated place cells','fontSize',fontL,'fontWeight','bold');
% ylabel('Corr(z-transformed)','fontSize',fontL);
% text(5, 1.1,['n (DRun) = ',num2str(ninaPC_DRun)],'fontSize',fontL,'color',colorDarkBlue);

hTotalCorr(2) = axes('Position',axpt(nCol,nRow,4,1,[0.1 0.1 0.85 0.85],midInterval));
bar([1,4,7],m_norespPC_DRun_PVcorr,barWidth,'faceColor',colorDarkGray);
hold on;
% errorbarJun([1,4,7],m_norespPC_DRun_PVcorr,sem_norespPC_DRun_PVcorr,eBarLength,eBarWidth,eBarColor);
title('noresponsive place cells','fontSize',fontL,'fontWeight','bold');
ylabel('PV correlation','fontSize',fontL);
text(5, 1.1,['n (DRun) = ',num2str(nnorespPC_DRun)],'fontSize',fontL,'color',colorDarkGray);

set(hTotalCorr,'TickDir','out','Box','off','XLim',[0,9],'YLim',[0 1.2],'XTick',[1.5 4.5 7.5],'XTickLabel',[{'preXstm','preXpost','stmXpost'}],'fontSize',fontL);
print('-painters','-r300','-dtiff',[datestr(now,formatOut),'_placeField_PVCorrelation_control_DRun.tif']);