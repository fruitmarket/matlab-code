clearvars;
cd('D:\Dropbox\SNL\P2_Track');
Txls = readtable('neuronList_ori_170814.xlsx');
Txls.latencyIndex = categorical(Txls.latencyIndex);
load('neuronList_ori_170814.mat');
load myParameters.mat;

formatOut = 'yymmdd';

% TN: track neuron
tPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
actPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == 1;
directPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == 1 & Txls.latencyIndex == 'direct';
indirectPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == 1 & Txls.latencyIndex == 'indirect';
doublePC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == 1 & Txls.latencyIndex == 'double';
inaPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == -1;
norespPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxpLR_Track;

ntPC_DRun = sum(double(tPC_DRun));
nactPC_DRun = sum(double(actPC_DRun));
ninaPC_DRun = sum(double(inaPC_DRun));
nnorespPC_DRun = sum(double(norespPC_DRun));

% corr of total neurons
m_fcorr_tPC_DRun = [mean(T.fCorr1D_preXpre(tPC_DRun)), mean(T.fCorr1D_preXstm(tPC_DRun)), mean(T.fCorr1D_preXpost(tPC_DRun)), mean(T.fCorr1D_stmXpost(tPC_DRun))];
m_fcorr_actPC_DRun = [mean(T.fCorr1D_preXpre(actPC_DRun)), mean(T.fCorr1D_preXstm(actPC_DRun)), mean(T.fCorr1D_preXpost(actPC_DRun)), mean(T.fCorr1D_stmXpost(actPC_DRun))];
m_fcorr_inaPC_DRun = [mean(T.fCorr1D_preXpre(inaPC_DRun)), mean(T.fCorr1D_preXstm(inaPC_DRun)), mean(T.fCorr1D_preXpost(inaPC_DRun)), mean(T.fCorr1D_stmXpost(inaPC_DRun))];
m_fcorr_norespPC_DRun = [mean(T.fCorr1D_preXpre(norespPC_DRun)), mean(T.fCorr1D_preXstm(norespPC_DRun)), mean(T.fCorr1D_preXpost(norespPC_DRun)), mean(T.fCorr1D_stmXpost(norespPC_DRun))];

sem_fcorr_tPC_DRun = [std(T.fCorr1D_preXpre(tPC_DRun),0,1)/sqrt(ntPC_DRun) std(T.fCorr1D_preXstm(tPC_DRun),0,1)/sqrt(ntPC_DRun), std(T.fCorr1D_preXpost(tPC_DRun),0,1)/sqrt(ntPC_DRun), std(T.fCorr1D_stmXpost(tPC_DRun),0,1)/sqrt(ntPC_DRun)];
sem_fcorr_actPC_DRun = [std(T.fCorr1D_preXpre(actPC_DRun),0,1)/sqrt(nactPC_DRun), std(T.fCorr1D_preXstm(actPC_DRun),0,1)/sqrt(nactPC_DRun), std(T.fCorr1D_preXpost(actPC_DRun),0,1)/sqrt(nactPC_DRun), std(T.fCorr1D_stmXpost(actPC_DRun),0,1)/sqrt(nactPC_DRun)];
sem_fcorr_inaPC_DRun = [std(T.fCorr1D_preXpre(inaPC_DRun),0,1)/sqrt(ninaPC_DRun), std(T.fCorr1D_preXstm(inaPC_DRun),0,1)/sqrt(ninaPC_DRun), std(T.fCorr1D_preXpost(inaPC_DRun),0,1)/sqrt(ninaPC_DRun), std(T.fCorr1D_stmXpost(inaPC_DRun),0,1)/sqrt(ninaPC_DRun)];
sem_fcorr_norespPC_DRun = [std(T.fCorr1D_preXpre(norespPC_DRun),0,1)/sqrt(nnorespPC_DRun), std(T.fCorr1D_preXstm(norespPC_DRun),0,1)/sqrt(nnorespPC_DRun), std(T.fCorr1D_preXpost(norespPC_DRun),0,1)/sqrt(nnorespPC_DRun), std(T.fCorr1D_stmXpost(norespPC_DRun),0,1)/sqrt(nnorespPC_DRun)];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% noRun session %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
actPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == 1;
inaPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == -1;
norespPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxpLR_Track;

ntPC_noRun = sum(double(tPC_noRun));
nactPC_noRun = sum(double(actPC_noRun));
ninaPC_noRun = sum(double(inaPC_noRun));
nnorespPC_noRun = sum(double(norespPC_noRun));

% corr of total neurons
m_fcorr_tPC_noRun = [mean(T.fCorr1D_preXpre(tPC_noRun)), mean(T.fCorr1D_preXstm(tPC_noRun)), mean(T.fCorr1D_preXpost(tPC_noRun)), mean(T.fCorr1D_stmXpost(tPC_noRun))];
m_fcorr_actPC_noRun = [mean(T.fCorr1D_preXpre(actPC_noRun)), mean(T.fCorr1D_preXstm(actPC_noRun)), mean(T.fCorr1D_preXpost(actPC_noRun)), mean(T.fCorr1D_stmXpost(actPC_noRun))];
m_fcorr_inaPC_noRun = [mean(T.fCorr1D_preXpre(inaPC_noRun)), mean(T.fCorr1D_preXstm(inaPC_noRun)), mean(T.fCorr1D_preXpost(inaPC_noRun)), mean(T.fCorr1D_stmXpost(inaPC_noRun))];
m_fcorr_norespPC_noRun = [mean(T.fCorr1D_preXpre(norespPC_noRun)), mean(T.fCorr1D_preXstm(norespPC_noRun)), mean(T.fCorr1D_preXpost(norespPC_noRun)), mean(T.fCorr1D_stmXpost(norespPC_noRun))];

sem_fcorr_tPC_noRun = [std(T.fCorr1D_preXpre(tPC_noRun),0,1)/sqrt(ntPC_noRun) std(T.fCorr1D_preXstm(tPC_noRun),0,1)/sqrt(ntPC_noRun), std(T.fCorr1D_preXpost(tPC_noRun),0,1)/sqrt(ntPC_noRun), std(T.fCorr1D_stmXpost(tPC_noRun),0,1)/sqrt(ntPC_noRun)];
sem_fcorr_actPC_noRun = [std(T.fCorr1D_preXpre(actPC_noRun),0,1)/sqrt(nactPC_noRun), std(T.fCorr1D_preXstm(actPC_noRun),0,1)/sqrt(nactPC_noRun), std(T.fCorr1D_preXpost(actPC_noRun),0,1)/sqrt(nactPC_noRun), std(T.fCorr1D_stmXpost(actPC_noRun),0,1)/sqrt(nactPC_noRun)];
sem_fcorr_inaPC_noRun = [std(T.fCorr1D_preXpre(inaPC_noRun),0,1)/sqrt(ninaPC_noRun), std(T.fCorr1D_preXstm(inaPC_noRun),0,1)/sqrt(ninaPC_noRun), std(T.fCorr1D_preXpost(inaPC_noRun),0,1)/sqrt(ninaPC_noRun), std(T.fCorr1D_stmXpost(inaPC_noRun),0,1)/sqrt(ninaPC_noRun)];
sem_fcorr_norespPC_noRun = [std(T.fCorr1D_preXpre(norespPC_noRun),0,1)/sqrt(nnorespPC_noRun), std(T.fCorr1D_preXstm(norespPC_noRun),0,1)/sqrt(nnorespPC_noRun), std(T.fCorr1D_preXpost(norespPC_noRun),0,1)/sqrt(nnorespPC_noRun), std(T.fCorr1D_stmXpost(norespPC_noRun),0,1)/sqrt(nnorespPC_noRun)];

%% statistic test 
[~, p_preXpre] = ttest2(T.fCorr1D_preXpre(tPC_DRun),T.fCorr1D_preXpre(tPC_noRun));
[~, p_preXstm] = ttest2(T.fCorr1D_preXstm(tPC_DRun),T.fCorr1D_preXstm(tPC_noRun));
[~, p_preXpost] = ttest2(T.fCorr1D_preXpost(tPC_DRun),T.fCorr1D_preXpost(tPC_noRun));
[~, p_stmXpost] = ttest2(T.fCorr1D_stmXpost(tPC_DRun),T.fCorr1D_stmXpost(tPC_noRun));
%%
barWidth = 0.3;
eBarLength = 0.3;
eBarWidth = 0.8;
eBarColor = colorBlack;
nCol = 4;
nRow = 2;
fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{2});

hTotalCorr(1) = axes('Position',axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval));
bar([1,4,7,10],m_fcorr_tPC_DRun,barWidth,'faceColor',colorLightBlue);
hold on;
errorbarJun([1,4,7,10],m_fcorr_tPC_DRun,sem_fcorr_tPC_DRun,eBarLength,eBarWidth,eBarColor);
hold on;
bar([2,5,8,11],m_fcorr_tPC_noRun,barWidth,'faceColor',colorGray);
hold on;
errorbarJun([2,5,8,11],m_fcorr_tPC_noRun,sem_fcorr_tPC_noRun,eBarLength,eBarWidth,eBarColor);
title('total place cells','fontSize',fontL,'fontWeight','bold');
ylabel('Corr(z-transformed)','fontSize',fontL);
text(7, 3.2,['n (DRun) = ',num2str(ntPC_DRun)],'fontSize',fontL,'color',colorDarkBlue);
text(7, 2.8,['n (noRun) = ',num2str(ntPC_noRun)],'fontSize',fontL,'color',colorDarkGray);

hTotalCorr(2) = axes('Position',axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],midInterval));
bar([1,4,7,10],m_fcorr_actPC_DRun,barWidth,'faceColor',colorLightBlue);
hold on;
errorbarJun([1,4,7,10],m_fcorr_actPC_DRun,sem_fcorr_actPC_DRun,eBarLength,eBarWidth,eBarColor);
hold on;
bar([2,5,8,11],m_fcorr_actPC_noRun,barWidth,'faceColor',colorGray);
hold on;
errorbarJun([2,5,8,11],m_fcorr_actPC_noRun,sem_fcorr_actPC_noRun,eBarLength,eBarWidth,eBarColor);
title('activated place cells','fontSize',fontL,'fontWeight','bold');
ylabel('Corr(z-transformed)','fontSize',fontL);
text(7, 3.2,['n (DRun) = ',num2str(nactPC_DRun)],'fontSize',fontL,'color',colorDarkBlue);
text(7, 2.8,['n (noRun) = ',num2str(nactPC_noRun)],'fontSize',fontL,'color',colorDarkGray);

hTotalCorr(3) = axes('Position',axpt(nCol,nRow,3,1,[0.1 0.1 0.85 0.85],midInterval));
bar([1,4,7,10],m_fcorr_inaPC_DRun,barWidth,'faceColor',colorLightBlue);
hold on;
errorbarJun([1,4,7,10],m_fcorr_inaPC_DRun,sem_fcorr_inaPC_DRun,eBarLength,eBarWidth,eBarColor);
hold on;
bar([2,5,8,11],m_fcorr_inaPC_noRun,barWidth,'faceColor',colorGray);
hold on;
errorbarJun([2,5,8,11],m_fcorr_inaPC_noRun,sem_fcorr_inaPC_noRun,eBarLength,eBarWidth,eBarColor);
title('inactivated place cells','fontSize',fontL,'fontWeight','bold');
ylabel('Corr(z-transformed)','fontSize',fontL);
text(7, 3.2,['n (DRun) = ',num2str(ninaPC_DRun)],'fontSize',fontL,'color',colorDarkBlue);
text(7, 2.8,['n (noRun) = ',num2str(ninaPC_noRun)],'fontSize',fontL,'color',colorDarkGray);

hTotalCorr(4) = axes('Position',axpt(nCol,nRow,4,1,[0.1 0.1 0.85 0.85],midInterval));
bar([1,4,7,10],m_fcorr_norespPC_DRun,barWidth,'faceColor',colorLightBlue);
hold on;
errorbarJun([1,4,7,10],m_fcorr_norespPC_DRun,sem_fcorr_norespPC_DRun,eBarLength,eBarWidth,eBarColor);
hold on;
bar([2,5,8,11],m_fcorr_norespPC_noRun,barWidth,'faceColor',colorGray);
hold on;
errorbarJun([2,5,8,11],m_fcorr_norespPC_noRun,sem_fcorr_norespPC_noRun,eBarLength,eBarWidth,eBarColor);
title('noresponsive place cells','fontSize',fontL,'fontWeight','bold');
ylabel('Corr(z-transformed)','fontSize',fontL);
text(7, 3.2,['n (DRun) = ',num2str(nnorespPC_DRun)],'fontSize',fontL,'color',colorDarkBlue);
text(7, 2.8,['n (noRun) = ',num2str(nnorespPC_noRun)],'fontSize',fontL,'color',colorDarkGray);

set(hTotalCorr,'TickDir','out','Box','off','XLim',[0,12],'YLim',[0 3.5],'XTick',[1.5 4.5 7.5 10.5],'XTickLabel',[{'preXpre','preXstm','preXpost','stmXpost'}],'fontSize',fontL);
print('-painters','-r300','-dtiff',[datestr(now,formatOut),'_placeFieldCorrelation_DRun_noRun.tif']);