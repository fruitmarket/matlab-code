clearvars;
cd('D:\Dropbox\SNL\P2_Track');
Txls = readtable('neuronList_ori_170819.xlsx');
Txls.latencyIndex = categorical(Txls.latencyIndex);
load('neuronList_ori_170819.mat');
load myParameters.mat;

formatOut = 'yymmdd';

% TN: track neuron
tPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
respPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track;
actPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == 1;
% directPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == 1 & Txls.latencyIndex == 'direct';
% indirectPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == 1 & Txls.latencyIndex == 'indirect';
% doublePC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == 1 & Txls.latencyIndex == 'double';
inaPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == -1;
norespPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxpLR_Track;

ntPC_DRw = sum(double(tPC_DRw));
nrespPC_DRw = sum(double(respPC_DRw));
nactPC_DRw = sum(double(actPC_DRw));
ninaPC_DRw = sum(double(inaPC_DRw));
nnorespPC_DRw = sum(double(norespPC_DRw));

% corr of total neurons
tPC_DRw_PRE = cell2mat(T.rateMap1D_PRE(tPC_DRw));
tPC_DRw_STM = cell2mat(T.rateMap1D_STM(tPC_DRw));
tPC_DRw_POST = cell2mat(T.rateMap1D_POST(tPC_DRw));

respPC_DRw_PRE = cell2mat(T.rateMap1D_PRE(respPC_DRw));
respPC_DRw_STM = cell2mat(T.rateMap1D_STM(respPC_DRw));
respPC_DRw_POST = cell2mat(T.rateMap1D_POST(respPC_DRw));

actPC_DRw_PRE = cell2mat(T.rateMap1D_PRE(actPC_DRw));
actPC_DRw_STM = cell2mat(T.rateMap1D_STM(actPC_DRw));
actPC_DRw_POST = cell2mat(T.rateMap1D_POST(actPC_DRw));

inaPC_DRw_PRE = cell2mat(T.rateMap1D_PRE(inaPC_DRw));
inaPC_DRw_STM = cell2mat(T.rateMap1D_STM(inaPC_DRw));
inaPC_DRw_POST = cell2mat(T.rateMap1D_POST(inaPC_DRw));

norespPC_DRw_PRE = cell2mat(T.rateMap1D_PRE(norespPC_DRw));
norespPC_DRw_STM = cell2mat(T.rateMap1D_STM(norespPC_DRw));
norespPC_DRw_POST = cell2mat(T.rateMap1D_POST(norespPC_DRw));

[tPC_DRw_PVcorr_preXstm, tPC_DRw_PVcorr_preXpost, tPC_DRw_PVcorr_stmXpost] = deal([]);
[respPC_DRw_PVcorr_preXstm, respPC_DRw_PVcorr_preXpost, respPC_DRw_PVcorr_stmXpost] = deal([]);
[actPC_DRw_PVcorr_preXstm, actPC_DRw_PVcorr_preXpost, actPC_DRw_PVcorr_stmXpost] = deal([]);
[inaPC_DRw_PVcorr_preXstm, inaPC_DRw_PVcorr_preXpost, inaPC_DRw_PVcorr_stmXpost] = deal([]);
[norespPC_DRw_PVcorr_preXstm, norespPC_DRw_PVcorr_preXpost, norespPC_DRw_PVcorr_stmXpost] = deal([]);

for iCol = 1:124
    tPC_DRw_PVcorr_preXstm(iCol) = corr(tPC_DRw_PRE(:,iCol),tPC_DRw_STM(:,iCol),'type','Pearson');
    tPC_DRw_PVcorr_preXpost(iCol) = corr(tPC_DRw_PRE(:,iCol),tPC_DRw_POST(:,iCol),'type','Pearson');
    tPC_DRw_PVcorr_stmXpost(iCol) = corr(tPC_DRw_STM(:,iCol),tPC_DRw_POST(:,iCol),'type','Pearson');
    
    respPC_DRw_PVcorr_preXstm(iCol) = corr(respPC_DRw_PRE(:,iCol),respPC_DRw_STM(:,iCol),'type','Pearson');
    respPC_DRw_PVcorr_preXpost(iCol) = corr(respPC_DRw_PRE(:,iCol),respPC_DRw_POST(:,iCol),'type','Pearson');
    respPC_DRw_PVcorr_stmXpost(iCol) = corr(respPC_DRw_STM(:,iCol),respPC_DRw_POST(:,iCol),'type','Pearson');
    
    actPC_DRw_PVcorr_preXstm(iCol) = corr(actPC_DRw_PRE(:,iCol),actPC_DRw_STM(:,iCol),'type','Pearson');
    actPC_DRw_PVcorr_preXpost(iCol) = corr(actPC_DRw_PRE(:,iCol),actPC_DRw_POST(:,iCol),'type','Pearson');
    actPC_DRw_PVcorr_stmXpost(iCol) = corr(actPC_DRw_STM(:,iCol),actPC_DRw_POST(:,iCol),'type','Pearson');
    
    inaPC_DRw_PVcorr_preXstm(iCol) = corr(inaPC_DRw_PRE(:,iCol),inaPC_DRw_STM(:,iCol),'type','Pearson');
    inaPC_DRw_PVcorr_preXpost(iCol) = corr(inaPC_DRw_PRE(:,iCol),inaPC_DRw_POST(:,iCol),'type','Pearson');
    inaPC_DRw_PVcorr_stmXpost(iCol) = corr(inaPC_DRw_STM(:,iCol),inaPC_DRw_POST(:,iCol),'type','Pearson');
    
    norespPC_DRw_PVcorr_preXstm(iCol) = corr(norespPC_DRw_PRE(:,iCol),norespPC_DRw_STM(:,iCol),'type','Pearson');
    norespPC_DRw_PVcorr_preXpost(iCol) = corr(norespPC_DRw_PRE(:,iCol),norespPC_DRw_POST(:,iCol),'type','Pearson');
    norespPC_DRw_PVcorr_stmXpost(iCol) = corr(norespPC_DRw_STM(:,iCol),norespPC_DRw_POST(:,iCol),'type','Pearson');    
end
m_tPC_DRw_PVcorr = [nanmean(tPC_DRw_PVcorr_preXstm), nanmean(tPC_DRw_PVcorr_preXpost), nanmean(tPC_DRw_PVcorr_stmXpost)];
m_respPC_DRw_PVcorr = [nanmean(respPC_DRw_PVcorr_preXstm), nanmean(respPC_DRw_PVcorr_preXpost), nanmean(respPC_DRw_PVcorr_stmXpost)];
m_actPC_DRw_PVcorr = [nanmean(actPC_DRw_PVcorr_preXstm), nanmean(actPC_DRw_PVcorr_preXpost), nanmean(actPC_DRw_PVcorr_stmXpost)];
m_inaPC_DRw_PVcorr = [nanmean(inaPC_DRw_PVcorr_preXstm), nanmean(inaPC_DRw_PVcorr_preXpost), nanmean(inaPC_DRw_PVcorr_stmXpost)];
m_norespPC_DRw_PVcorr = [nanmean(norespPC_DRw_PVcorr_preXstm), nanmean(norespPC_DRw_PVcorr_preXpost), nanmean(norespPC_DRw_PVcorr_stmXpost)];

sem_tPC_DRw_PVcorr = [nanstd(tPC_DRw_PVcorr_preXstm,0,2)/sqrt(ntPC_DRw), nanstd(tPC_DRw_PVcorr_preXpost,0,2)/sqrt(ntPC_DRw), nanstd(tPC_DRw_PVcorr_stmXpost,0,2)/sqrt(ntPC_DRw)];
sem_respPC_DRw_PVcorr = [nanstd(respPC_DRw_PVcorr_preXstm,0,2)/sqrt(nrespPC_DRw), nanstd(respPC_DRw_PVcorr_preXpost,0,2)/sqrt(nrespPC_DRw), nanstd(respPC_DRw_PVcorr_stmXpost,0,2)/sqrt(nrespPC_DRw)];
sem_actPC_DRw_PVcorr = [nanstd(actPC_DRw_PVcorr_preXstm,0,2)/sqrt(nactPC_DRw), nanstd(actPC_DRw_PVcorr_preXpost,0,2)/sqrt(nactPC_DRw), nanstd(actPC_DRw_PVcorr_stmXpost,0,2)/sqrt(nactPC_DRw)];
sem_inaPC_DRw_PVcorr = [nanstd(inaPC_DRw_PVcorr_preXstm,0,2)/sqrt(ninaPC_DRw), nanstd(inaPC_DRw_PVcorr_preXpost,0,2)/sqrt(ninaPC_DRw), nanstd(inaPC_DRw_PVcorr_stmXpost,0,2)/sqrt(ninaPC_DRw)];
sem_norespPC_DRw_PVcorr = [nanstd(norespPC_DRw_PVcorr_preXstm,0,2)/sqrt(nnorespPC_DRw), nanstd(norespPC_DRw_PVcorr_preXpost,0,2)/sqrt(nnorespPC_DRw), nanstd(norespPC_DRw_PVcorr_stmXpost,0,2)/sqrt(nnorespPC_DRw)];

% file example
% plot_Track_multi_v3(T.path(actPC_DRw),T.cellID(actPC_DRw),'C:\Users\Jun\Desktop\DRw_act');
% plot_Track_multi_v3(T.path(inaPC_DRw),T.cellID(inaPC_DRw),'C:\Users\Jun\Desktop\DRw_ina');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% noRw session %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
respPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track;
actPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == 1;
inaPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == -1;
norespPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxpLR_Track;

ntPC_noRw = sum(double(tPC_noRw));
nrespPC_noRw = sum(double(respPC_noRw));
nactPC_noRw = sum(double(actPC_noRw));
ninaPC_noRw = sum(double(inaPC_noRw));
nnorespPC_noRw = sum(double(norespPC_noRw));

% corr of total neurons
tPC_noRw_PRE = cell2mat(T.rateMap1D_PRE(tPC_noRw));
tPC_noRw_STM = cell2mat(T.rateMap1D_STM(tPC_noRw));
tPC_noRw_POST = cell2mat(T.rateMap1D_POST(tPC_noRw));

respPC_noRw_PRE = cell2mat(T.rateMap1D_PRE(respPC_noRw));
respPC_noRw_STM = cell2mat(T.rateMap1D_STM(respPC_noRw));
respPC_noRw_POST = cell2mat(T.rateMap1D_POST(respPC_noRw));

actPC_noRw_PRE = cell2mat(T.rateMap1D_PRE(actPC_noRw));
actPC_noRw_STM = cell2mat(T.rateMap1D_STM(actPC_noRw));
actPC_noRw_POST = cell2mat(T.rateMap1D_POST(actPC_noRw));

inaPC_noRw_PRE = cell2mat(T.rateMap1D_PRE(inaPC_noRw));
inaPC_noRw_STM = cell2mat(T.rateMap1D_STM(inaPC_noRw));
inaPC_noRw_POST = cell2mat(T.rateMap1D_POST(inaPC_noRw));

norespPC_noRw_PRE = cell2mat(T.rateMap1D_PRE(norespPC_noRw));
norespPC_noRw_STM = cell2mat(T.rateMap1D_STM(norespPC_noRw));
norespPC_noRw_POST = cell2mat(T.rateMap1D_POST(norespPC_noRw));

[tPC_noRw_PVcorr_preXstm, tPC_noRw_PVcorr_preXpost, tPC_noRw_PVcorr_stmXpost] = deal([]);
[respPC_noRw_PVcorr_preXstm, respPC_noRw_PVcorr_preXpost, respPC_noRw_PVcorr_stmXpost] = deal([]);
[actPC_noRw_PVcorr_preXstm, actPC_noRw_PVcorr_preXpost, actPC_noRw_PVcorr_stmXpost] = deal([]);
[inaPC_noRw_PVcorr_preXstm, inaPC_noRw_PVcorr_preXpost, inaPC_noRw_PVcorr_stmXpost] = deal([]);
[norespPC_noRw_PVcorr_preXstm, norespPC_noRw_PVcorr_preXpost, norespPC_noRw_PVcorr_stmXpost] = deal([]);

for iCol = 1:124
    tPC_noRw_PVcorr_preXstm(iCol) = corr(tPC_noRw_PRE(:,iCol),tPC_noRw_STM(:,iCol),'type','Pearson');
    tPC_noRw_PVcorr_preXpost(iCol) = corr(tPC_noRw_PRE(:,iCol),tPC_noRw_POST(:,iCol),'type','Pearson');
    tPC_noRw_PVcorr_stmXpost(iCol) = corr(tPC_noRw_STM(:,iCol),tPC_noRw_POST(:,iCol),'type','Pearson');
    
    respPC_noRw_PVcorr_preXstm(iCol) = corr(respPC_noRw_PRE(:,iCol),respPC_noRw_STM(:,iCol),'type','Pearson');
    respPC_noRw_PVcorr_preXpost(iCol) = corr(respPC_noRw_PRE(:,iCol),respPC_noRw_POST(:,iCol),'type','Pearson');
    respPC_noRw_PVcorr_stmXpost(iCol) = corr(respPC_noRw_STM(:,iCol),respPC_noRw_POST(:,iCol),'type','Pearson');
    
    actPC_noRw_PVcorr_preXstm(iCol) = corr(actPC_noRw_PRE(:,iCol),actPC_noRw_STM(:,iCol),'type','Pearson');
    actPC_noRw_PVcorr_preXpost(iCol) = corr(actPC_noRw_PRE(:,iCol),actPC_noRw_POST(:,iCol),'type','Pearson');
    actPC_noRw_PVcorr_stmXpost(iCol) = corr(actPC_noRw_STM(:,iCol),actPC_noRw_POST(:,iCol),'type','Pearson');
    
    inaPC_noRw_PVcorr_preXstm(iCol) = corr(inaPC_noRw_PRE(:,iCol),inaPC_noRw_STM(:,iCol),'type','Pearson');
    inaPC_noRw_PVcorr_preXpost(iCol) = corr(inaPC_noRw_PRE(:,iCol),inaPC_noRw_POST(:,iCol),'type','Pearson');
    inaPC_noRw_PVcorr_stmXpost(iCol) = corr(inaPC_noRw_STM(:,iCol),inaPC_noRw_POST(:,iCol),'type','Pearson');
    
    norespPC_noRw_PVcorr_preXstm(iCol) = corr(norespPC_noRw_PRE(:,iCol),norespPC_noRw_STM(:,iCol),'type','Pearson');
    norespPC_noRw_PVcorr_preXpost(iCol) = corr(norespPC_noRw_PRE(:,iCol),norespPC_noRw_POST(:,iCol),'type','Pearson');
    norespPC_noRw_PVcorr_stmXpost(iCol) = corr(norespPC_noRw_STM(:,iCol),norespPC_noRw_POST(:,iCol),'type','Pearson');    
end
m_tPC_noRw_PVcorr = [nanmean(tPC_noRw_PVcorr_preXstm), nanmean(tPC_noRw_PVcorr_preXpost), nanmean(tPC_noRw_PVcorr_stmXpost)];
m_respPC_noRw_PVcorr = [nanmean(respPC_noRw_PVcorr_preXstm), nanmean(respPC_noRw_PVcorr_preXpost), nanmean(respPC_noRw_PVcorr_stmXpost)];
m_actPC_noRw_PVcorr = [nanmean(actPC_noRw_PVcorr_preXstm), nanmean(actPC_noRw_PVcorr_preXpost), nanmean(actPC_noRw_PVcorr_stmXpost)];
m_inaPC_noRw_PVcorr = [nanmean(inaPC_noRw_PVcorr_preXstm), nanmean(inaPC_noRw_PVcorr_preXpost), nanmean(inaPC_noRw_PVcorr_stmXpost)];
m_norespPC_noRw_PVcorr = [nanmean(norespPC_noRw_PVcorr_preXstm), nanmean(norespPC_noRw_PVcorr_preXpost), nanmean(norespPC_noRw_PVcorr_stmXpost)];

sem_tPC_noRw_PVcorr = [nanstd(tPC_noRw_PVcorr_preXstm,0,2)/sqrt(ntPC_noRw), nanstd(tPC_noRw_PVcorr_preXpost,0,2)/sqrt(ntPC_noRw), nanstd(tPC_noRw_PVcorr_stmXpost,0,2)/sqrt(ntPC_noRw)];
sem_respPC_noRw_PVcorr = [nanstd(respPC_noRw_PVcorr_preXstm,0,2)/sqrt(nrespPC_noRw), nanstd(respPC_noRw_PVcorr_preXpost,0,2)/sqrt(nrespPC_noRw), nanstd(respPC_noRw_PVcorr_stmXpost,0,2)/sqrt(nrespPC_noRw)];
sem_actPC_noRw_PVcorr = [nanstd(actPC_noRw_PVcorr_preXstm,0,2)/sqrt(nactPC_noRw), nanstd(actPC_noRw_PVcorr_preXpost,0,2)/sqrt(nactPC_noRw), nanstd(actPC_noRw_PVcorr_stmXpost,0,2)/sqrt(nactPC_noRw)];
sem_inaPC_noRw_PVcorr = [nanstd(inaPC_noRw_PVcorr_preXstm,0,2)/sqrt(ninaPC_noRw), nanstd(inaPC_noRw_PVcorr_preXpost,0,2)/sqrt(ninaPC_noRw), nanstd(inaPC_noRw_PVcorr_stmXpost,0,2)/sqrt(ninaPC_noRw)];
sem_norespPC_noRw_PVcorr = [nanstd(norespPC_noRw_PVcorr_preXstm,0,2)/sqrt(nnorespPC_noRw), nanstd(norespPC_noRw_PVcorr_preXpost,0,2)/sqrt(nnorespPC_noRw), nanstd(norespPC_noRw_PVcorr_stmXpost,0,2)/sqrt(nnorespPC_noRw)];

%% Individual cross correlation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% DRw %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m_fcorr_tPC_DRw = [mean(T.fCorr1D_preXpre(tPC_DRw)), mean(T.fCorr1D_preXstm(tPC_DRw)), mean(T.fCorr1D_preXpost(tPC_DRw)), mean(T.fCorr1D_stmXpost(tPC_DRw))];
m_fcorr_respPC_DRw = [mean(T.fCorr1D_preXpre(respPC_DRw)), mean(T.fCorr1D_preXstm(respPC_DRw)), mean(T.fCorr1D_preXpost(respPC_DRw)), mean(T.fCorr1D_stmXpost(respPC_DRw))];
m_fcorr_actPC_DRw = [mean(T.fCorr1D_preXpre(actPC_DRw)), mean(T.fCorr1D_preXstm(actPC_DRw)), mean(T.fCorr1D_preXpost(actPC_DRw)), mean(T.fCorr1D_stmXpost(actPC_DRw))];
m_fcorr_inaPC_DRw = [mean(T.fCorr1D_preXpre(inaPC_DRw)), mean(T.fCorr1D_preXstm(inaPC_DRw)), mean(T.fCorr1D_preXpost(inaPC_DRw)), mean(T.fCorr1D_stmXpost(inaPC_DRw))];
m_fcorr_norespPC_DRw = [mean(T.fCorr1D_preXpre(norespPC_DRw)), mean(T.fCorr1D_preXstm(norespPC_DRw)), mean(T.fCorr1D_preXpost(norespPC_DRw)), mean(T.fCorr1D_stmXpost(norespPC_DRw))];

sem_fcorr_tPC_DRw = [std(T.fCorr1D_preXpre(tPC_DRw),0,1)/sqrt(ntPC_DRw) std(T.fCorr1D_preXstm(tPC_DRw),0,1)/sqrt(ntPC_DRw), std(T.fCorr1D_preXpost(tPC_DRw),0,1)/sqrt(ntPC_DRw), std(T.fCorr1D_stmXpost(tPC_DRw),0,1)/sqrt(ntPC_DRw)];
sem_fcorr_respPC_DRw = [std(T.fCorr1D_preXpre(respPC_DRw),0,1)/sqrt(nrespPC_DRw) std(T.fCorr1D_preXstm(respPC_DRw),0,1)/sqrt(nrespPC_DRw), std(T.fCorr1D_preXpost(respPC_DRw),0,1)/sqrt(nrespPC_DRw), std(T.fCorr1D_stmXpost(respPC_DRw),0,1)/sqrt(nrespPC_DRw)];
sem_fcorr_actPC_DRw = [std(T.fCorr1D_preXpre(actPC_DRw),0,1)/sqrt(nactPC_DRw), std(T.fCorr1D_preXstm(actPC_DRw),0,1)/sqrt(nactPC_DRw), std(T.fCorr1D_preXpost(actPC_DRw),0,1)/sqrt(nactPC_DRw), std(T.fCorr1D_stmXpost(actPC_DRw),0,1)/sqrt(nactPC_DRw)];
sem_fcorr_inaPC_DRw = [std(T.fCorr1D_preXpre(inaPC_DRw),0,1)/sqrt(ninaPC_DRw), std(T.fCorr1D_preXstm(inaPC_DRw),0,1)/sqrt(ninaPC_DRw), std(T.fCorr1D_preXpost(inaPC_DRw),0,1)/sqrt(ninaPC_DRw), std(T.fCorr1D_stmXpost(inaPC_DRw),0,1)/sqrt(ninaPC_DRw)];
sem_fcorr_norespPC_DRw = [std(T.fCorr1D_preXpre(norespPC_DRw),0,1)/sqrt(nnorespPC_DRw), std(T.fCorr1D_preXstm(norespPC_DRw),0,1)/sqrt(nnorespPC_DRw), std(T.fCorr1D_preXpost(norespPC_DRw),0,1)/sqrt(nnorespPC_DRw), std(T.fCorr1D_stmXpost(norespPC_DRw),0,1)/sqrt(nnorespPC_DRw)];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% noRw %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m_fcorr_tPC_noRw = [mean(T.fCorr1D_preXpre(tPC_noRw)), mean(T.fCorr1D_preXstm(tPC_noRw)), mean(T.fCorr1D_preXpost(tPC_noRw)), mean(T.fCorr1D_stmXpost(tPC_noRw))];
m_fcorr_respPC_noRw = [mean(T.fCorr1D_preXpre(respPC_noRw)), mean(T.fCorr1D_preXstm(respPC_noRw)), mean(T.fCorr1D_preXpost(respPC_noRw)), mean(T.fCorr1D_stmXpost(respPC_noRw))];
m_fcorr_actPC_noRw = [mean(T.fCorr1D_preXpre(actPC_noRw)), mean(T.fCorr1D_preXstm(actPC_noRw)), mean(T.fCorr1D_preXpost(actPC_noRw)), mean(T.fCorr1D_stmXpost(actPC_noRw))];
m_fcorr_inaPC_noRw = [mean(T.fCorr1D_preXpre(inaPC_noRw)), mean(T.fCorr1D_preXstm(inaPC_noRw)), mean(T.fCorr1D_preXpost(inaPC_noRw)), mean(T.fCorr1D_stmXpost(inaPC_noRw))];
m_fcorr_norespPC_noRw = [mean(T.fCorr1D_preXpre(norespPC_noRw)), mean(T.fCorr1D_preXstm(norespPC_noRw)), mean(T.fCorr1D_preXpost(norespPC_noRw)), mean(T.fCorr1D_stmXpost(norespPC_noRw))];

sem_fcorr_tPC_noRw = [std(T.fCorr1D_preXpre(tPC_noRw),0,1)/sqrt(ntPC_noRw) std(T.fCorr1D_preXstm(tPC_noRw),0,1)/sqrt(ntPC_noRw), std(T.fCorr1D_preXpost(tPC_noRw),0,1)/sqrt(ntPC_noRw), std(T.fCorr1D_stmXpost(tPC_noRw),0,1)/sqrt(ntPC_noRw)];
sem_fcorr_respPC_noRw = [std(T.fCorr1D_preXpre(respPC_noRw),0,1)/sqrt(nrespPC_noRw), std(T.fCorr1D_preXstm(respPC_noRw),0,1)/sqrt(nrespPC_noRw), std(T.fCorr1D_preXpost(respPC_noRw),0,1)/sqrt(nrespPC_noRw), std(T.fCorr1D_stmXpost(respPC_noRw),0,1)/sqrt(nrespPC_noRw)];
sem_fcorr_actPC_noRw = [std(T.fCorr1D_preXpre(actPC_noRw),0,1)/sqrt(nactPC_noRw), std(T.fCorr1D_preXstm(actPC_noRw),0,1)/sqrt(nactPC_noRw), std(T.fCorr1D_preXpost(actPC_noRw),0,1)/sqrt(nactPC_noRw), std(T.fCorr1D_stmXpost(actPC_noRw),0,1)/sqrt(nactPC_noRw)];
sem_fcorr_inaPC_noRw = [std(T.fCorr1D_preXpre(inaPC_noRw),0,1)/sqrt(ninaPC_noRw), std(T.fCorr1D_preXstm(inaPC_noRw),0,1)/sqrt(ninaPC_noRw), std(T.fCorr1D_preXpost(inaPC_noRw),0,1)/sqrt(ninaPC_noRw), std(T.fCorr1D_stmXpost(inaPC_noRw),0,1)/sqrt(ninaPC_noRw)];
sem_fcorr_norespPC_noRw = [std(T.fCorr1D_preXpre(norespPC_noRw),0,1)/sqrt(nnorespPC_noRw), std(T.fCorr1D_preXstm(norespPC_noRw),0,1)/sqrt(nnorespPC_noRw), std(T.fCorr1D_preXpost(norespPC_noRw),0,1)/sqrt(nnorespPC_noRw), std(T.fCorr1D_stmXpost(norespPC_noRw),0,1)/sqrt(nnorespPC_noRw)];

[~, p_preXpre] = ttest2(T.fCorr1D_preXpre(tPC_DRw),T.fCorr1D_preXpre(tPC_noRw));
[~, p_preXstm] = ttest2(T.fCorr1D_preXstm(tPC_DRw),T.fCorr1D_preXstm(tPC_noRw));
[~, p_preXpost] = ttest2(T.fCorr1D_preXpost(tPC_DRw),T.fCorr1D_preXpost(tPC_noRw));
[~, p_stmXpost] = ttest2(T.fCorr1D_stmXpost(tPC_DRw),T.fCorr1D_stmXpost(tPC_noRw));
%%
barWidth = 0.3;
eBarLength = 0.3;
eBarWidth = 0.8;
eBarColor = colorBlack;
nCol = 5;
nRow = 2;
fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{2});

hPVCorr(1) = axes('Position',axpt(nCol,nRow,1,1,[0.1 0.1 0.855 0.85],midInterval));
bar([1,4,7],m_tPC_DRw_PVcorr,barWidth,'faceColor',colorLightBlue);
hold on;
hold on;
bar([2,5,8],m_tPC_noRw_PVcorr,barWidth,'faceColor',colorGray);
hold on;
title('total place cells','fontSize',fontL,'fontWeight','bold');
ylabel('PV correlation','fontSize',fontL);
text(5, 1.1,['n (DRw) = ',num2str(ntPC_DRw)],'fontSize',fontL,'color',colorDarkBlue);
text(5, 1.0,['n (noRw) = ',num2str(ntPC_noRw)],'fontSize',fontL,'color',colorDarkGray);

hPVCorr(2) = axes('Position',axpt(nCol,nRow,2,1,[0.1 0.1 0.855 0.85],midInterval));
bar([1,4,7],m_respPC_DRw_PVcorr,barWidth,'faceColor',colorLightBlue);
hold on;
bar([2,5,8],m_respPC_noRw_PVcorr,barWidth,'faceColor',colorGray);
title('light responsive place cells','fontSize',fontL,'fontWeight','bold');
ylabel('PV correlation','fontSize',fontL);
text(5, 1.1,['n (DRw) = ',num2str(nrespPC_DRw)],'fontSize',fontL,'color',colorDarkBlue);
text(5, 1.0,['n (noRw) = ',num2str(nrespPC_noRw)],'fontSize',fontL,'color',colorDarkGray);

hPVCorr(3) = axes('Position',axpt(nCol,nRow,3,1,[0.1 0.1 0.855 0.85],midInterval));
bar([1,4,7],m_actPC_DRw_PVcorr,barWidth,'faceColor',colorLightBlue);
hold on;
bar([2,5,8],m_actPC_noRw_PVcorr,barWidth,'faceColor',colorGray);
title('activated place cells','fontSize',fontL,'fontWeight','bold');
ylabel('PV correlation','fontSize',fontL);
text(5, 1.1,['n (DRw) = ',num2str(nactPC_DRw)],'fontSize',fontL,'color',colorDarkBlue);
text(5, 1.0,['n (noRw) = ',num2str(nactPC_noRw)],'fontSize',fontL,'color',colorDarkGray);

hPVCorr(4) = axes('Position',axpt(nCol,nRow,4,1,[0.1 0.1 0.855 0.85],midInterval));
bar([1,4,7],m_inaPC_DRw_PVcorr,barWidth,'faceColor',colorLightBlue);
hold on;
bar([2,5,8],m_inaPC_noRw_PVcorr,barWidth,'faceColor',colorGray);
hold on;
title('inactivated place cells','fontSize',fontL,'fontWeight','bold');
ylabel('PV correlation','fontSize',fontL);
text(5, 1.1,['n (DRw) = ',num2str(ninaPC_DRw)],'fontSize',fontL,'color',colorDarkBlue);
text(5, 1.0,['n (noRw) = ',num2str(ninaPC_noRw)],'fontSize',fontL,'color',colorDarkGray);

hPVCorr(5) = axes('Position',axpt(nCol,nRow,5,1,[0.1 0.1 0.855 0.85],midInterval));
bar([1,4,7],m_norespPC_DRw_PVcorr,barWidth,'faceColor',colorLightBlue);
hold on;
bar([2,5,8],m_norespPC_noRw_PVcorr,barWidth,'faceColor',colorGray);
hold on;
title('noresponsive place cells','fontSize',fontL,'fontWeight','bold');
ylabel('PV correlation','fontSize',fontL);
text(5, 1.1,['n (DRw) = ',num2str(nnorespPC_DRw)],'fontSize',fontL,'color',colorDarkBlue);
text(5, 1.0,['n (noRw) = ',num2str(nnorespPC_noRw)],'fontSize',fontL,'color',colorDarkGray);
set(hPVCorr,'TickDir','out','Box','off','XLim',[0,9],'YLim',[0 1.2],'XTick',[1.5 4.5 7.5],'XTickLabel',[{'preXstm','preXpost','stmXpost'}],'fontSize',fontM);

%%%%%%%%%%%%%%%%%%%% Individual correlation %%%%%%%%%%%%%%%%%%%%%
hIndCorr(1) = axes('Position',axpt(nCol,nRow,1,2,[0.1 0.1 0.85 0.85],midInterval));
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

hIndCorr(2) = axes('Position',axpt(nCol,nRow,2,2,[0.1 0.1 0.85 0.85],midInterval));
bar([1,4,7,10],m_fcorr_respPC_DRw,barWidth,'faceColor',colorLightBlue);
hold on;
errorbarJun([1,4,7,10],m_fcorr_respPC_DRw,sem_fcorr_tPC_DRw,eBarLength,eBarWidth,eBarColor);
hold on;
bar([2,5,8,11],m_fcorr_respPC_noRw,barWidth,'faceColor',colorGray);
hold on;
errorbarJun([2,5,8,11],m_fcorr_respPC_noRw,sem_fcorr_tPC_noRw,eBarLength,eBarWidth,eBarColor);
title('light responsive place cells','fontSize',fontL,'fontWeight','bold');
ylabel('Corr(z-transformed)','fontSize',fontL);
text(7, 3.2,['n (DRw) = ',num2str(nrespPC_DRw)],'fontSize',fontL,'color',colorDarkBlue);
text(7, 2.8,['n (noRw) = ',num2str(nrespPC_noRw)],'fontSize',fontL,'color',colorDarkGray);

hIndCorr(3) = axes('Position',axpt(nCol,nRow,3,2,[0.1 0.1 0.85 0.85],midInterval));
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

hIndCorr(4) = axes('Position',axpt(nCol,nRow,4,2,[0.1 0.1 0.85 0.85],midInterval));
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

hIndCorr(5) = axes('Position',axpt(nCol,nRow,5,2,[0.1 0.1 0.85 0.85],midInterval));
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

set(hIndCorr,'TickDir','out','Box','off','XLim',[0,12],'YLim',[0 3.5],'XTick',[1.5 4.5 7.5 10.5],'XTickLabel',[{'preXpre','preXstm','preXpost','stmXpost'}],'fontSize',fontM);

print('-painters','-r300','-dtiff',['final_fig5_placeField_PVCorr_DRw_noRw_',datestr(now,formatOut),'.tif']);
close;