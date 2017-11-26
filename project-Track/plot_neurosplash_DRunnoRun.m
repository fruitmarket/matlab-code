clearvars;
cd('D:\Dropbox\SNL\P2_Track');
Txls = readtable('neuronList_ori_170814.xlsx');
Txls.latencyIndex = categorical(Txls.latencyIndex);
load('neuronList_ori_170814.mat');
load myParameters.mat;

formatOut = 'yymmdd';

% TN: track neuron
tPC = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
actPC = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == 1;
directPC = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == 1 & Txls.latencyIndex == 'direct';
indirectPC = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == 1 & Txls.latencyIndex == 'indirect';
doublePC = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == 1 & Txls.latencyIndex == 'double';
inaPC = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == -1;
norespPC = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxpLR_Track;

ntPC_DRun = sum(double(tPC));
nactPC_DRun = sum(double(actPC));
ninaPC_DRun = sum(double(inaPC));
nnorespPC_DRun = sum(double(norespPC));

% corr of total neurons
m_fcorr_tPC_DRun = [mean(T.fCorr1D_preXpre(tPC)), mean(T.fCorr1D_preXstm(tPC)), mean(T.fCorr1D_preXpost(tPC)), mean(T.fCorr1D_stmXpost(tPC))];
m_fcorr_actPC_DRun = [mean(T.fCorr1D_preXpre(actPC)), mean(T.fCorr1D_preXstm(actPC)), mean(T.fCorr1D_preXpost(actPC)), mean(T.fCorr1D_stmXpost(actPC))];
m_fcorr_inaPC_DRun = [mean(T.fCorr1D_preXpre(inaPC)), mean(T.fCorr1D_preXstm(inaPC)), mean(T.fCorr1D_preXpost(inaPC)), mean(T.fCorr1D_stmXpost(inaPC))];
m_fcorr_norespPC_DRun = [mean(T.fCorr1D_preXpre(norespPC)), mean(T.fCorr1D_preXstm(norespPC)), mean(T.fCorr1D_preXpost(norespPC)), mean(T.fCorr1D_stmXpost(norespPC))];

sem_fcorr_tPC_DRun = [std(T.fCorr1D_preXpre(tPC),0,1)/sqrt(ntPC_DRun) std(T.fCorr1D_preXstm(tPC),0,1)/sqrt(ntPC_DRun), std(T.fCorr1D_preXpost(tPC),0,1)/sqrt(ntPC_DRun), std(T.fCorr1D_stmXpost(tPC),0,1)/sqrt(ntPC_DRun)];
sem_fcorr_actPC_DRun = [std(T.fCorr1D_preXpre(actPC),0,1)/sqrt(nactPC_DRun), std(T.fCorr1D_preXstm(actPC),0,1)/sqrt(nactPC_DRun), std(T.fCorr1D_preXpost(actPC),0,1)/sqrt(nactPC_DRun), std(T.fCorr1D_stmXpost(actPC),0,1)/sqrt(nactPC_DRun)];
sem_fcorr_inaPC_DRun = [std(T.fCorr1D_preXpre(inaPC),0,1)/sqrt(ninaPC_DRun), std(T.fCorr1D_preXstm(inaPC),0,1)/sqrt(ninaPC_DRun), std(T.fCorr1D_preXpost(inaPC),0,1)/sqrt(ninaPC_DRun), std(T.fCorr1D_stmXpost(inaPC),0,1)/sqrt(ninaPC_DRun)];
sem_fcorr_norespPC_DRun = [std(T.fCorr1D_preXpre(norespPC),0,1)/sqrt(nnorespPC_DRun), std(T.fCorr1D_preXstm(norespPC),0,1)/sqrt(nnorespPC_DRun), std(T.fCorr1D_preXpost(norespPC),0,1)/sqrt(nnorespPC_DRun), std(T.fCorr1D_stmXpost(norespPC),0,1)/sqrt(nnorespPC_DRun)];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% noRun session %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tPC = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
actPC = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == 1;
inaPC = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == -1;
norespPC = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxpLR_Track;

ntPC_noRun = sum(double(tPC));
nactPC_noRun = sum(double(actPC));
ninaPC_noRun = sum(double(inaPC));
nnorespPC_noRun = sum(double(norespPC));

% corr of total neurons
m_fcorr_tPC_noRun = [mean(T.fCorr1D_preXpre(tPC)), mean(T.fCorr1D_preXstm(tPC)), mean(T.fCorr1D_preXpost(tPC)), mean(T.fCorr1D_stmXpost(tPC))];
m_fcorr_actPC_noRun = [mean(T.fCorr1D_preXpre(actPC)), mean(T.fCorr1D_preXstm(actPC)), mean(T.fCorr1D_preXpost(actPC)), mean(T.fCorr1D_stmXpost(actPC))];
m_fcorr_inaPC_noRun = [mean(T.fCorr1D_preXpre(inaPC)), mean(T.fCorr1D_preXstm(inaPC)), mean(T.fCorr1D_preXpost(inaPC)), mean(T.fCorr1D_stmXpost(inaPC))];
m_fcorr_norespPC_noRun = [mean(T.fCorr1D_preXpre(norespPC)), mean(T.fCorr1D_preXstm(norespPC)), mean(T.fCorr1D_preXpost(norespPC)), mean(T.fCorr1D_stmXpost(norespPC))];

sem_fcorr_tPC_noRun = [std(T.fCorr1D_preXpre(tPC),0,1)/sqrt(ntPC_noRun) std(T.fCorr1D_preXstm(tPC),0,1)/sqrt(ntPC_noRun), std(T.fCorr1D_preXpost(tPC),0,1)/sqrt(ntPC_noRun), std(T.fCorr1D_stmXpost(tPC),0,1)/sqrt(ntPC_noRun)];
sem_fcorr_actPC_noRun = [std(T.fCorr1D_preXpre(actPC),0,1)/sqrt(nactPC_noRun), std(T.fCorr1D_preXstm(actPC),0,1)/sqrt(nactPC_noRun), std(T.fCorr1D_preXpost(actPC),0,1)/sqrt(nactPC_noRun), std(T.fCorr1D_stmXpost(actPC),0,1)/sqrt(nactPC_noRun)];
sem_fcorr_inaPC_noRun = [std(T.fCorr1D_preXpre(inaPC),0,1)/sqrt(ninaPC_noRun), std(T.fCorr1D_preXstm(inaPC),0,1)/sqrt(ninaPC_noRun), std(T.fCorr1D_preXpost(inaPC),0,1)/sqrt(ninaPC_noRun), std(T.fCorr1D_stmXpost(inaPC),0,1)/sqrt(ninaPC_noRun)];
sem_fcorr_norespPC_noRun = [std(T.fCorr1D_preXpre(norespPC),0,1)/sqrt(nnorespPC_noRun), std(T.fCorr1D_preXstm(norespPC),0,1)/sqrt(nnorespPC_noRun), std(T.fCorr1D_preXpost(norespPC),0,1)/sqrt(nnorespPC_noRun), std(T.fCorr1D_stmXpost(norespPC),0,1)/sqrt(nnorespPC_noRun)];

%%
barWidth = 0.2;
eBarLength = 0.3;
eBarWidth = 0.8;
eBarColor = colorBlack;
nCol = 4;
nRow = 2;
fHandle = figure('PaperUnits','centimeters','PaperPosition',[0 0 10 4]*5);

hTotalCorr(1) = axes('Position',axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval));
bar([1,5,9,13],m_fcorr_tPC_DRun,barWidth,'faceColor',colorLightBlue);
hold on;
errorbarJun([1,5,9,13],m_fcorr_tPC_DRun,sem_fcorr_tPC_DRun,eBarLength,eBarWidth,eBarColor);
hold on;
bar([2,6,10,14],m_fcorr_tPC_noRun,barWidth,'faceColor',colorGray);
hold on;
errorbarJun([2,6,10,14],m_fcorr_tPC_noRun,sem_fcorr_tPC_noRun,eBarLength,eBarWidth,eBarColor);
title('Total place cells','fontSize',fontL,'fontWeight','bold');
ylabel('Corr (z-transformed)','fontSize',fontL);
text(9, 3.2,['Light (n = ',num2str(ntPC_DRun),')'],'fontSize',fontL,'color',colorBlue);
text(9, 2.8,['No light (n = ',num2str(ntPC_noRun),')'],'fontSize',fontL,'color',colorDarkGray);

set(hTotalCorr,'TickDir','out','Box','off','XLim',[0,15],'YLim',[0 3.5],'XTick',[1.5 5.5 9.5 13.5],'XTickLabel',[{'PRE X PRE','PRE X STM','PRE X POST','STM X POST'}],'fontSize',fontL);
% print('-painters','-r300','-dtiff',[datestr(now,formatOut),'_neuroSplash_DRun_noRun.tif']);
print('-painters','-r300','-depsc',[datestr(now,formatOut),'_neuroSplash_DRun_noRun.ai']);