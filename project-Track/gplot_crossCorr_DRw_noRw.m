clearvars;
cd('D:\Dropbox\SNL\P2_Track');
Txls = readtable('neuronList_ori_170814.xlsx');
Txls.latencyIndex = categorical(Txls.latencyIndex);
load('neuronList_ori_170814.mat');
load myParameters.mat;

formatOut = 'yymmdd';

% TN: track neuron
tPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
actPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == 1;
inaPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == -1;
norespPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxpLR_Track;

ntPC_DRw = sum(double(tPC_DRw));
nactPC_DRw = sum(double(actPC_DRw));
ninaPC_DRw = sum(double(inaPC_DRw));
nnorespPC_DRw = sum(double(norespPC_DRw));

% corr of total neurons
m_fcorr_tPC_DRw = [mean(T.fCorr1D_preXpre(tPC_DRw)), mean(T.fCorr1D_preXstm(tPC_DRw)), mean(T.fCorr1D_preXpost(tPC_DRw)), mean(T.fCorr1D_stmXpost(tPC_DRw))];
m_fcorr_actPC_DRw = [mean(T.fCorr1D_preXpre(actPC_DRw)), mean(T.fCorr1D_preXstm(actPC_DRw)), mean(T.fCorr1D_preXpost(actPC_DRw)), mean(T.fCorr1D_stmXpost(actPC_DRw))];
m_fcorr_inaPC_DRw = [mean(T.fCorr1D_preXpre(inaPC_DRw)), mean(T.fCorr1D_preXstm(inaPC_DRw)), mean(T.fCorr1D_preXpost(inaPC_DRw)), mean(T.fCorr1D_stmXpost(inaPC_DRw))];
m_fcorr_norespPC_DRw = [mean(T.fCorr1D_preXpre(norespPC_DRw)), mean(T.fCorr1D_preXstm(norespPC_DRw)), mean(T.fCorr1D_preXpost(norespPC_DRw)), mean(T.fCorr1D_stmXpost(norespPC_DRw))];

sem_fcorr_tPC_DRw = [std(T.fCorr1D_preXpre(tPC_DRw),0,1)/sqrt(ntPC_DRw) std(T.fCorr1D_preXstm(tPC_DRw),0,1)/sqrt(ntPC_DRw), std(T.fCorr1D_preXpost(tPC_DRw),0,1)/sqrt(ntPC_DRw), std(T.fCorr1D_stmXpost(tPC_DRw),0,1)/sqrt(ntPC_DRw)];
sem_fcorr_actPC_DRw = [std(T.fCorr1D_preXpre(actPC_DRw),0,1)/sqrt(nactPC_DRw), std(T.fCorr1D_preXstm(actPC_DRw),0,1)/sqrt(nactPC_DRw), std(T.fCorr1D_preXpost(actPC_DRw),0,1)/sqrt(nactPC_DRw), std(T.fCorr1D_stmXpost(actPC_DRw),0,1)/sqrt(nactPC_DRw)];
sem_fcorr_inaPC_DRw = [std(T.fCorr1D_preXpre(inaPC_DRw),0,1)/sqrt(ninaPC_DRw), std(T.fCorr1D_preXstm(inaPC_DRw),0,1)/sqrt(ninaPC_DRw), std(T.fCorr1D_preXpost(inaPC_DRw),0,1)/sqrt(ninaPC_DRw), std(T.fCorr1D_stmXpost(inaPC_DRw),0,1)/sqrt(ninaPC_DRw)];
sem_fcorr_norespPC_DRw = [std(T.fCorr1D_preXpre(norespPC_DRw),0,1)/sqrt(nnorespPC_DRw), std(T.fCorr1D_preXstm(norespPC_DRw),0,1)/sqrt(nnorespPC_DRw), std(T.fCorr1D_preXpost(norespPC_DRw),0,1)/sqrt(nnorespPC_DRw), std(T.fCorr1D_stmXpost(norespPC_DRw),0,1)/sqrt(nnorespPC_DRw)];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% noRw session %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
actPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == 1;
inaPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == -1;
norespPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxpLR_Track;

ntPC_noRw = sum(double(tPC_noRw));
nactPC_noRw = sum(double(actPC_noRw));
ninaPC_noRw = sum(double(inaPC_noRw));
nnorespPC_noRw = sum(double(norespPC_noRw));

% corr of total neurons
m_fcorr_tPC_noRw = [mean(T.fCorr1D_preXpre(tPC_noRw)), mean(T.fCorr1D_preXstm(tPC_noRw)), mean(T.fCorr1D_preXpost(tPC_noRw)), mean(T.fCorr1D_stmXpost(tPC_noRw))];
m_fcorr_actPC_noRw = [mean(T.fCorr1D_preXpre(actPC_noRw)), mean(T.fCorr1D_preXstm(actPC_noRw)), mean(T.fCorr1D_preXpost(actPC_noRw)), mean(T.fCorr1D_stmXpost(actPC_noRw))];
m_fcorr_inaPC_noRw = [mean(T.fCorr1D_preXpre(inaPC_noRw)), mean(T.fCorr1D_preXstm(inaPC_noRw)), mean(T.fCorr1D_preXpost(inaPC_noRw)), mean(T.fCorr1D_stmXpost(inaPC_noRw))];
m_fcorr_norespPC_noRw = [mean(T.fCorr1D_preXpre(norespPC_noRw)), mean(T.fCorr1D_preXstm(norespPC_noRw)), mean(T.fCorr1D_preXpost(norespPC_noRw)), mean(T.fCorr1D_stmXpost(norespPC_noRw))];

sem_fcorr_tPC_noRw = [std(T.fCorr1D_preXpre(tPC_noRw),0,1)/sqrt(ntPC_noRw) std(T.fCorr1D_preXstm(tPC_noRw),0,1)/sqrt(ntPC_noRw), std(T.fCorr1D_preXpost(tPC_noRw),0,1)/sqrt(ntPC_noRw), std(T.fCorr1D_stmXpost(tPC_noRw),0,1)/sqrt(ntPC_noRw)];
sem_fcorr_actPC_noRw = [std(T.fCorr1D_preXpre(actPC_noRw),0,1)/sqrt(nactPC_noRw), std(T.fCorr1D_preXstm(actPC_noRw),0,1)/sqrt(nactPC_noRw), std(T.fCorr1D_preXpost(actPC_noRw),0,1)/sqrt(nactPC_noRw), std(T.fCorr1D_stmXpost(actPC_noRw),0,1)/sqrt(nactPC_noRw)];
sem_fcorr_inaPC_noRw = [std(T.fCorr1D_preXpre(inaPC_noRw),0,1)/sqrt(ninaPC_noRw), std(T.fCorr1D_preXstm(inaPC_noRw),0,1)/sqrt(ninaPC_noRw), std(T.fCorr1D_preXpost(inaPC_noRw),0,1)/sqrt(ninaPC_noRw), std(T.fCorr1D_stmXpost(inaPC_noRw),0,1)/sqrt(ninaPC_noRw)];
sem_fcorr_norespPC_noRw = [std(T.fCorr1D_preXpre(norespPC_noRw),0,1)/sqrt(nnorespPC_noRw), std(T.fCorr1D_preXstm(norespPC_noRw),0,1)/sqrt(nnorespPC_noRw), std(T.fCorr1D_preXpost(norespPC_noRw),0,1)/sqrt(nnorespPC_noRw), std(T.fCorr1D_stmXpost(norespPC_noRw),0,1)/sqrt(nnorespPC_noRw)];

%% statistic test 
[~, p_preXpre] = ttest2(T.fCorr1D_preXpre(tPC_DRw),T.fCorr1D_preXpre(tPC_noRw));
[~, p_preXstm] = ttest2(T.fCorr1D_preXstm(tPC_DRw),T.fCorr1D_preXstm(tPC_noRw));
[~, p_preXpost] = ttest2(T.fCorr1D_preXpost(tPC_DRw),T.fCorr1D_preXpost(tPC_noRw));
[~, p_stmXpost] = ttest2(T.fCorr1D_stmXpost(tPC_DRw),T.fCorr1D_stmXpost(tPC_noRw));
%%
barWidth = 0.3;
eBarLength = 0.3;
eBarWidth = 0.8;
eBarColor = colorBlack;
nCol = 4;
nRow = 2;
fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{2});

hTotalCorr(1) = axes('Position',axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval));
bar([1,4,7,10],m_fcorr_tPC_DRw,barWidth,'faceColor',colorLightBlue);
hold on;
errorbarJun([1,4,7,10],m_fcorr_tPC_DRw,sem_fcorr_tPC_DRw,eBarLength,eBarWidth,eBarColor);
hold on;
bar([2,5,8,11],m_fcorr_tPC_noRw,barWidth,'faceColor',colorGray);
hold on;
errorbarJun([2,5,8,11],m_fcorr_tPC_noRw,sem_fcorr_tPC_noRw,eBarLength,eBarWidth,eBarColor);
title('total place cells','fontSize',fontL,'fontWeight','bold');
ylabel('Corr(z-transformed)','fontSize',fontL);
text(7, 3.2,['n (DRw) = ',num2str(ntPC_DRw)],'fontSize',fontL,'color',colorDarkBlue);
text(7, 2.8,['n (noRw) = ',num2str(ntPC_noRw)],'fontSize',fontL,'color',colorDarkGray);

hTotalCorr(2) = axes('Position',axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],midInterval));
bar([1,4,7,10],m_fcorr_actPC_DRw,barWidth,'faceColor',colorLightBlue);
hold on;
errorbarJun([1,4,7,10],m_fcorr_actPC_DRw,sem_fcorr_actPC_DRw,eBarLength,eBarWidth,eBarColor);
hold on;
bar([2,5,8,11],m_fcorr_actPC_noRw,barWidth,'faceColor',colorGray);
hold on;
errorbarJun([2,5,8,11],m_fcorr_actPC_noRw,sem_fcorr_actPC_noRw,eBarLength,eBarWidth,eBarColor);
title('activated place cells','fontSize',fontL,'fontWeight','bold');
ylabel('Corr(z-transformed)','fontSize',fontL);
text(7, 3.2,['n (DRw) = ',num2str(nactPC_DRw)],'fontSize',fontL,'color',colorDarkBlue);
text(7, 2.8,['n (noRw) = ',num2str(nactPC_noRw)],'fontSize',fontL,'color',colorDarkGray);

hTotalCorr(3) = axes('Position',axpt(nCol,nRow,3,1,[0.1 0.1 0.85 0.85],midInterval));
bar([1,4,7,10],m_fcorr_inaPC_DRw,barWidth,'faceColor',colorLightBlue);
hold on;
errorbarJun([1,4,7,10],m_fcorr_inaPC_DRw,sem_fcorr_inaPC_DRw,eBarLength,eBarWidth,eBarColor);
hold on;
bar([2,5,8,11],m_fcorr_inaPC_noRw,barWidth,'faceColor',colorGray);
hold on;
errorbarJun([2,5,8,11],m_fcorr_inaPC_noRw,sem_fcorr_inaPC_noRw,eBarLength,eBarWidth,eBarColor);
title('inactivated place cells','fontSize',fontL,'fontWeight','bold');
ylabel('Corr(z-transformed)','fontSize',fontL);
text(7, 3.2,['n (DRw) = ',num2str(ninaPC_DRw)],'fontSize',fontL,'color',colorDarkBlue);
text(7, 2.8,['n (noRw) = ',num2str(ninaPC_noRw)],'fontSize',fontL,'color',colorDarkGray);

hTotalCorr(4) = axes('Position',axpt(nCol,nRow,4,1,[0.1 0.1 0.85 0.85],midInterval));
bar([1,4,7,10],m_fcorr_norespPC_DRw,barWidth,'faceColor',colorLightBlue);
hold on;
errorbarJun([1,4,7,10],m_fcorr_norespPC_DRw,sem_fcorr_norespPC_DRw,eBarLength,eBarWidth,eBarColor);
hold on;
bar([2,5,8,11],m_fcorr_norespPC_noRw,barWidth,'faceColor',colorGray);
hold on;
errorbarJun([2,5,8,11],m_fcorr_norespPC_noRw,sem_fcorr_norespPC_noRw,eBarLength,eBarWidth,eBarColor);
title('noresponsive place cells','fontSize',fontL,'fontWeight','bold');
ylabel('Corr(z-transformed)','fontSize',fontL);
text(7, 3.2,['n (DRw) = ',num2str(nnorespPC_DRw)],'fontSize',fontL,'color',colorDarkBlue);
text(7, 2.8,['n (noRw) = ',num2str(nnorespPC_noRw)],'fontSize',fontL,'color',colorDarkGray);

set(hTotalCorr,'TickDir','out','Box','off','XLim',[0,12],'YLim',[0 3.5],'XTick',[1.5 4.5 7.5 10.5],'XTickLabel',[{'preXpre','preXstm','preXpost','stmXpost'}],'fontSize',fontL);
print('-painters','-r300','-dtiff',[datestr(now,formatOut),'_placeFieldCorrelation_DRw_noRw.tif']);