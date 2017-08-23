clearvars;
cd('D:\Dropbox\SNL\P2_Track');
Txls = readtable('neuronList_ori_170819.xlsx');
Txls.latencyIndex = categorical(Txls.latencyIndex);
load('neuronList_ori_170819.mat');
load myParameters.mat;

formatOut = 'yymmdd';

% TN: track neuron
tPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
respPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track;
actPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == 1;
% directPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == 1 & Txls.latencyIndex == 'direct';
% indirectPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == 1 & Txls.latencyIndex == 'indirect';
% doublePC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == 1 & Txls.latencyIndex == 'double';
inaPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == -1;
norespPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxpLR_Track;

ntPC_DRun = sum(double(tPC_DRun));
nrespPC_DRun = sum(double(respPC_DRun));
nactPC_DRun = sum(double(actPC_DRun));
ninaPC_DRun = sum(double(inaPC_DRun));
nnorespPC_DRun = sum(double(norespPC_DRun));

% corr of total neurons
tPC_DRun_PRE = cell2mat(T.rateMap1D_PRE(tPC_DRun));
tPC_DRun_STM = cell2mat(T.rateMap1D_STM(tPC_DRun));
tPC_DRun_POST = cell2mat(T.rateMap1D_POST(tPC_DRun));

respPC_DRun_PRE = cell2mat(T.rateMap1D_PRE(respPC_DRun));
respPC_DRun_STM = cell2mat(T.rateMap1D_STM(respPC_DRun));
respPC_DRun_POST = cell2mat(T.rateMap1D_POST(respPC_DRun));

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
[respPC_DRun_PVcorr_preXstm, respPC_DRun_PVcorr_preXpost, respPC_DRun_PVcorr_stmXpost] = deal([]);
[actPC_DRun_PVcorr_preXstm, actPC_DRun_PVcorr_preXpost, actPC_DRun_PVcorr_stmXpost] = deal([]);
[inaPC_DRun_PVcorr_preXstm, inaPC_DRun_PVcorr_preXpost, inaPC_DRun_PVcorr_stmXpost] = deal([]);
[norespPC_DRun_PVcorr_preXstm, norespPC_DRun_PVcorr_preXpost, norespPC_DRun_PVcorr_stmXpost] = deal([]);

for iCol = 1:124
    tPC_DRun_PVcorr_preXstm(iCol) = corr(tPC_DRun_PRE(:,iCol),tPC_DRun_STM(:,iCol),'type','Pearson');
    tPC_DRun_PVcorr_preXpost(iCol) = corr(tPC_DRun_PRE(:,iCol),tPC_DRun_POST(:,iCol),'type','Pearson');
    tPC_DRun_PVcorr_stmXpost(iCol) = corr(tPC_DRun_STM(:,iCol),tPC_DRun_POST(:,iCol),'type','Pearson');
    
    respPC_DRun_PVcorr_preXstm(iCol) = corr(respPC_DRun_PRE(:,iCol),respPC_DRun_STM(:,iCol),'type','Pearson');
    respPC_DRun_PVcorr_preXpost(iCol) = corr(respPC_DRun_PRE(:,iCol),respPC_DRun_POST(:,iCol),'type','Pearson');
    respPC_DRun_PVcorr_stmXpost(iCol) = corr(respPC_DRun_STM(:,iCol),respPC_DRun_POST(:,iCol),'type','Pearson');
    
    actPC_DRun_PVcorr_preXstm(iCol) = corr(actPC_DRun_PRE(:,iCol),actPC_DRun_STM(:,iCol),'type','Pearson');
    actPC_DRun_PVcorr_preXpost(iCol) = corr(actPC_DRun_PRE(:,iCol),actPC_DRun_POST(:,iCol),'type','Pearson');
    actPC_DRun_PVcorr_stmXpost(iCol) = corr(actPC_DRun_STM(:,iCol),actPC_DRun_POST(:,iCol),'type','Pearson');
    
    inaPC_DRun_PVcorr_preXstm(iCol) = corr(inaPC_DRun_PRE(:,iCol),inaPC_DRun_STM(:,iCol),'type','Pearson');
    inaPC_DRun_PVcorr_preXpost(iCol) = corr(inaPC_DRun_PRE(:,iCol),inaPC_DRun_POST(:,iCol),'type','Pearson');
    inaPC_DRun_PVcorr_stmXpost(iCol) = corr(inaPC_DRun_STM(:,iCol),inaPC_DRun_POST(:,iCol),'type','Pearson');
    
    norespPC_DRun_PVcorr_preXstm(iCol) = corr(norespPC_DRun_PRE(:,iCol),norespPC_DRun_STM(:,iCol),'type','Pearson');
    norespPC_DRun_PVcorr_preXpost(iCol) = corr(norespPC_DRun_PRE(:,iCol),norespPC_DRun_POST(:,iCol),'type','Pearson');
    norespPC_DRun_PVcorr_stmXpost(iCol) = corr(norespPC_DRun_STM(:,iCol),norespPC_DRun_POST(:,iCol),'type','Pearson');    
end
m_tPC_DRun_PVcorr = [nanmean(tPC_DRun_PVcorr_preXstm), nanmean(tPC_DRun_PVcorr_preXpost), nanmean(tPC_DRun_PVcorr_stmXpost)];
m_respPC_DRun_PVcorr = [nanmean(respPC_DRun_PVcorr_preXstm), nanmean(respPC_DRun_PVcorr_preXpost), nanmean(respPC_DRun_PVcorr_stmXpost)];
m_actPC_DRun_PVcorr = [nanmean(actPC_DRun_PVcorr_preXstm), nanmean(actPC_DRun_PVcorr_preXpost), nanmean(actPC_DRun_PVcorr_stmXpost)];
m_inaPC_DRun_PVcorr = [nanmean(inaPC_DRun_PVcorr_preXstm), nanmean(inaPC_DRun_PVcorr_preXpost), nanmean(inaPC_DRun_PVcorr_stmXpost)];
m_norespPC_DRun_PVcorr = [nanmean(norespPC_DRun_PVcorr_preXstm), nanmean(norespPC_DRun_PVcorr_preXpost), nanmean(norespPC_DRun_PVcorr_stmXpost)];

sem_tPC_DRun_PVcorr = [nanstd(tPC_DRun_PVcorr_preXstm,0,2)/sqrt(ntPC_DRun), nanstd(tPC_DRun_PVcorr_preXpost,0,2)/sqrt(ntPC_DRun), nanstd(tPC_DRun_PVcorr_stmXpost,0,2)/sqrt(ntPC_DRun)];
sem_respPC_DRun_PVcorr = [nanstd(respPC_DRun_PVcorr_preXstm,0,2)/sqrt(nrespPC_DRun), nanstd(respPC_DRun_PVcorr_preXpost,0,2)/sqrt(nrespPC_DRun), nanstd(respPC_DRun_PVcorr_stmXpost,0,2)/sqrt(nrespPC_DRun)];
sem_actPC_DRun_PVcorr = [nanstd(actPC_DRun_PVcorr_preXstm,0,2)/sqrt(nactPC_DRun), nanstd(actPC_DRun_PVcorr_preXpost,0,2)/sqrt(nactPC_DRun), nanstd(actPC_DRun_PVcorr_stmXpost,0,2)/sqrt(nactPC_DRun)];
sem_inaPC_DRun_PVcorr = [nanstd(inaPC_DRun_PVcorr_preXstm,0,2)/sqrt(ninaPC_DRun), nanstd(inaPC_DRun_PVcorr_preXpost,0,2)/sqrt(ninaPC_DRun), nanstd(inaPC_DRun_PVcorr_stmXpost,0,2)/sqrt(ninaPC_DRun)];
sem_norespPC_DRun_PVcorr = [nanstd(norespPC_DRun_PVcorr_preXstm,0,2)/sqrt(nnorespPC_DRun), nanstd(norespPC_DRun_PVcorr_preXpost,0,2)/sqrt(nnorespPC_DRun), nanstd(norespPC_DRun_PVcorr_stmXpost,0,2)/sqrt(nnorespPC_DRun)];

% file example
% plot_Track_multi_v3(T.path(actPC_DRun),T.cellID(actPC_DRun),'C:\Users\Jun\Desktop\DRun_act');
% plot_Track_multi_v3(T.path(inaPC_DRun),T.cellID(inaPC_DRun),'C:\Users\Jun\Desktop\DRun_ina');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% noRun session %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
respPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track;
actPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == 1;
inaPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == -1;
norespPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxpLR_Track;

ntPC_noRun = sum(double(tPC_noRun));
nrespPC_noRun = sum(double(respPC_noRun));
nactPC_noRun = sum(double(actPC_noRun));
ninaPC_noRun = sum(double(inaPC_noRun));
nnorespPC_noRun = sum(double(norespPC_noRun));

% corr of total neurons
tPC_noRun_PRE = cell2mat(T.rateMap1D_PRE(tPC_noRun));
tPC_noRun_STM = cell2mat(T.rateMap1D_STM(tPC_noRun));
tPC_noRun_POST = cell2mat(T.rateMap1D_POST(tPC_noRun));

respPC_noRun_PRE = cell2mat(T.rateMap1D_PRE(respPC_noRun));
respPC_noRun_STM = cell2mat(T.rateMap1D_STM(respPC_noRun));
respPC_noRun_POST = cell2mat(T.rateMap1D_POST(respPC_noRun));

actPC_noRun_PRE = cell2mat(T.rateMap1D_PRE(actPC_noRun));
actPC_noRun_STM = cell2mat(T.rateMap1D_STM(actPC_noRun));
actPC_noRun_POST = cell2mat(T.rateMap1D_POST(actPC_noRun));

inaPC_noRun_PRE = cell2mat(T.rateMap1D_PRE(inaPC_noRun));
inaPC_noRun_STM = cell2mat(T.rateMap1D_STM(inaPC_noRun));
inaPC_noRun_POST = cell2mat(T.rateMap1D_POST(inaPC_noRun));

norespPC_noRun_PRE = cell2mat(T.rateMap1D_PRE(norespPC_noRun));
norespPC_noRun_STM = cell2mat(T.rateMap1D_STM(norespPC_noRun));
norespPC_noRun_POST = cell2mat(T.rateMap1D_POST(norespPC_noRun));

[tPC_noRun_PVcorr_preXstm, tPC_noRun_PVcorr_preXpost, tPC_noRun_PVcorr_stmXpost] = deal([]);
[respPC_noRun_PVcorr_preXstm, respPC_noRun_PVcorr_preXpost, respPC_noRun_PVcorr_stmXpost] = deal([]);
[actPC_noRun_PVcorr_preXstm, actPC_noRun_PVcorr_preXpost, actPC_noRun_PVcorr_stmXpost] = deal([]);
[inaPC_noRun_PVcorr_preXstm, inaPC_noRun_PVcorr_preXpost, inaPC_noRun_PVcorr_stmXpost] = deal([]);
[norespPC_noRun_PVcorr_preXstm, norespPC_noRun_PVcorr_preXpost, norespPC_noRun_PVcorr_stmXpost] = deal([]);

for iCol = 1:124
    tPC_noRun_PVcorr_preXstm(iCol) = corr(tPC_noRun_PRE(:,iCol),tPC_noRun_STM(:,iCol),'type','Pearson');
    tPC_noRun_PVcorr_preXpost(iCol) = corr(tPC_noRun_PRE(:,iCol),tPC_noRun_POST(:,iCol),'type','Pearson');
    tPC_noRun_PVcorr_stmXpost(iCol) = corr(tPC_noRun_STM(:,iCol),tPC_noRun_POST(:,iCol),'type','Pearson');
    
    respPC_noRun_PVcorr_preXstm(iCol) = corr(respPC_noRun_PRE(:,iCol),respPC_noRun_STM(:,iCol),'type','Pearson');
    respPC_noRun_PVcorr_preXpost(iCol) = corr(respPC_noRun_PRE(:,iCol),respPC_noRun_POST(:,iCol),'type','Pearson');
    respPC_noRun_PVcorr_stmXpost(iCol) = corr(respPC_noRun_STM(:,iCol),respPC_noRun_POST(:,iCol),'type','Pearson');
    
    actPC_noRun_PVcorr_preXstm(iCol) = corr(actPC_noRun_PRE(:,iCol),actPC_noRun_STM(:,iCol),'type','Pearson');
    actPC_noRun_PVcorr_preXpost(iCol) = corr(actPC_noRun_PRE(:,iCol),actPC_noRun_POST(:,iCol),'type','Pearson');
    actPC_noRun_PVcorr_stmXpost(iCol) = corr(actPC_noRun_STM(:,iCol),actPC_noRun_POST(:,iCol),'type','Pearson');
    
    inaPC_noRun_PVcorr_preXstm(iCol) = corr(inaPC_noRun_PRE(:,iCol),inaPC_noRun_STM(:,iCol),'type','Pearson');
    inaPC_noRun_PVcorr_preXpost(iCol) = corr(inaPC_noRun_PRE(:,iCol),inaPC_noRun_POST(:,iCol),'type','Pearson');
    inaPC_noRun_PVcorr_stmXpost(iCol) = corr(inaPC_noRun_STM(:,iCol),inaPC_noRun_POST(:,iCol),'type','Pearson');
    
    norespPC_noRun_PVcorr_preXstm(iCol) = corr(norespPC_noRun_PRE(:,iCol),norespPC_noRun_STM(:,iCol),'type','Pearson');
    norespPC_noRun_PVcorr_preXpost(iCol) = corr(norespPC_noRun_PRE(:,iCol),norespPC_noRun_POST(:,iCol),'type','Pearson');
    norespPC_noRun_PVcorr_stmXpost(iCol) = corr(norespPC_noRun_STM(:,iCol),norespPC_noRun_POST(:,iCol),'type','Pearson');    
end
m_tPC_noRun_PVcorr = [nanmean(tPC_noRun_PVcorr_preXstm), nanmean(tPC_noRun_PVcorr_preXpost), nanmean(tPC_noRun_PVcorr_stmXpost)];
m_respPC_noRun_PVcorr = [nanmean(respPC_noRun_PVcorr_preXstm), nanmean(respPC_noRun_PVcorr_preXpost), nanmean(respPC_noRun_PVcorr_stmXpost)];
m_actPC_noRun_PVcorr = [nanmean(actPC_noRun_PVcorr_preXstm), nanmean(actPC_noRun_PVcorr_preXpost), nanmean(actPC_noRun_PVcorr_stmXpost)];
m_inaPC_noRun_PVcorr = [nanmean(inaPC_noRun_PVcorr_preXstm), nanmean(inaPC_noRun_PVcorr_preXpost), nanmean(inaPC_noRun_PVcorr_stmXpost)];
m_norespPC_noRun_PVcorr = [nanmean(norespPC_noRun_PVcorr_preXstm), nanmean(norespPC_noRun_PVcorr_preXpost), nanmean(norespPC_noRun_PVcorr_stmXpost)];

sem_tPC_noRun_PVcorr = [nanstd(tPC_noRun_PVcorr_preXstm,0,2)/sqrt(ntPC_noRun), nanstd(tPC_noRun_PVcorr_preXpost,0,2)/sqrt(ntPC_noRun), nanstd(tPC_noRun_PVcorr_stmXpost,0,2)/sqrt(ntPC_noRun)];
sem_respPC_noRun_PVcorr = [nanstd(respPC_noRun_PVcorr_preXstm,0,2)/sqrt(nrespPC_noRun), nanstd(respPC_noRun_PVcorr_preXpost,0,2)/sqrt(nrespPC_noRun), nanstd(respPC_noRun_PVcorr_stmXpost,0,2)/sqrt(nrespPC_noRun)];
sem_actPC_noRun_PVcorr = [nanstd(actPC_noRun_PVcorr_preXstm,0,2)/sqrt(nactPC_noRun), nanstd(actPC_noRun_PVcorr_preXpost,0,2)/sqrt(nactPC_noRun), nanstd(actPC_noRun_PVcorr_stmXpost,0,2)/sqrt(nactPC_noRun)];
sem_inaPC_noRun_PVcorr = [nanstd(inaPC_noRun_PVcorr_preXstm,0,2)/sqrt(ninaPC_noRun), nanstd(inaPC_noRun_PVcorr_preXpost,0,2)/sqrt(ninaPC_noRun), nanstd(inaPC_noRun_PVcorr_stmXpost,0,2)/sqrt(ninaPC_noRun)];
sem_norespPC_noRun_PVcorr = [nanstd(norespPC_noRun_PVcorr_preXstm,0,2)/sqrt(nnorespPC_noRun), nanstd(norespPC_noRun_PVcorr_preXpost,0,2)/sqrt(nnorespPC_noRun), nanstd(norespPC_noRun_PVcorr_stmXpost,0,2)/sqrt(nnorespPC_noRun)];

%% Individual cross correlation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% DRun %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m_fcorr_tPC_DRun = [mean(T.fCorr1D_preXpre(tPC_DRun)), mean(T.fCorr1D_preXstm(tPC_DRun)), mean(T.fCorr1D_preXpost(tPC_DRun)), mean(T.fCorr1D_stmXpost(tPC_DRun))];
m_fcorr_respPC_DRun = [mean(T.fCorr1D_preXpre(respPC_DRun)), mean(T.fCorr1D_preXstm(respPC_DRun)), mean(T.fCorr1D_preXpost(respPC_DRun)), mean(T.fCorr1D_stmXpost(respPC_DRun))];
m_fcorr_actPC_DRun = [mean(T.fCorr1D_preXpre(actPC_DRun)), mean(T.fCorr1D_preXstm(actPC_DRun)), mean(T.fCorr1D_preXpost(actPC_DRun)), mean(T.fCorr1D_stmXpost(actPC_DRun))];
m_fcorr_inaPC_DRun = [mean(T.fCorr1D_preXpre(inaPC_DRun)), mean(T.fCorr1D_preXstm(inaPC_DRun)), mean(T.fCorr1D_preXpost(inaPC_DRun)), mean(T.fCorr1D_stmXpost(inaPC_DRun))];
m_fcorr_norespPC_DRun = [mean(T.fCorr1D_preXpre(norespPC_DRun)), mean(T.fCorr1D_preXstm(norespPC_DRun)), mean(T.fCorr1D_preXpost(norespPC_DRun)), mean(T.fCorr1D_stmXpost(norespPC_DRun))];

sem_fcorr_tPC_DRun = [std(T.fCorr1D_preXpre(tPC_DRun),0,1)/sqrt(ntPC_DRun) std(T.fCorr1D_preXstm(tPC_DRun),0,1)/sqrt(ntPC_DRun), std(T.fCorr1D_preXpost(tPC_DRun),0,1)/sqrt(ntPC_DRun), std(T.fCorr1D_stmXpost(tPC_DRun),0,1)/sqrt(ntPC_DRun)];
sem_fcorr_respPC_DRun = [std(T.fCorr1D_preXpre(respPC_DRun),0,1)/sqrt(nrespPC_DRun) std(T.fCorr1D_preXstm(respPC_DRun),0,1)/sqrt(nrespPC_DRun), std(T.fCorr1D_preXpost(respPC_DRun),0,1)/sqrt(nrespPC_DRun), std(T.fCorr1D_stmXpost(respPC_DRun),0,1)/sqrt(nrespPC_DRun)];
sem_fcorr_actPC_DRun = [std(T.fCorr1D_preXpre(actPC_DRun),0,1)/sqrt(nactPC_DRun), std(T.fCorr1D_preXstm(actPC_DRun),0,1)/sqrt(nactPC_DRun), std(T.fCorr1D_preXpost(actPC_DRun),0,1)/sqrt(nactPC_DRun), std(T.fCorr1D_stmXpost(actPC_DRun),0,1)/sqrt(nactPC_DRun)];
sem_fcorr_inaPC_DRun = [std(T.fCorr1D_preXpre(inaPC_DRun),0,1)/sqrt(ninaPC_DRun), std(T.fCorr1D_preXstm(inaPC_DRun),0,1)/sqrt(ninaPC_DRun), std(T.fCorr1D_preXpost(inaPC_DRun),0,1)/sqrt(ninaPC_DRun), std(T.fCorr1D_stmXpost(inaPC_DRun),0,1)/sqrt(ninaPC_DRun)];
sem_fcorr_norespPC_DRun = [std(T.fCorr1D_preXpre(norespPC_DRun),0,1)/sqrt(nnorespPC_DRun), std(T.fCorr1D_preXstm(norespPC_DRun),0,1)/sqrt(nnorespPC_DRun), std(T.fCorr1D_preXpost(norespPC_DRun),0,1)/sqrt(nnorespPC_DRun), std(T.fCorr1D_stmXpost(norespPC_DRun),0,1)/sqrt(nnorespPC_DRun)];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% noRun %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m_fcorr_tPC_noRun = [mean(T.fCorr1D_preXpre(tPC_noRun)), mean(T.fCorr1D_preXstm(tPC_noRun)), mean(T.fCorr1D_preXpost(tPC_noRun)), mean(T.fCorr1D_stmXpost(tPC_noRun))];
m_fcorr_respPC_noRun = [mean(T.fCorr1D_preXpre(respPC_noRun)), mean(T.fCorr1D_preXstm(respPC_noRun)), mean(T.fCorr1D_preXpost(respPC_noRun)), mean(T.fCorr1D_stmXpost(respPC_noRun))];
m_fcorr_actPC_noRun = [mean(T.fCorr1D_preXpre(actPC_noRun)), mean(T.fCorr1D_preXstm(actPC_noRun)), mean(T.fCorr1D_preXpost(actPC_noRun)), mean(T.fCorr1D_stmXpost(actPC_noRun))];
m_fcorr_inaPC_noRun = [mean(T.fCorr1D_preXpre(inaPC_noRun)), mean(T.fCorr1D_preXstm(inaPC_noRun)), mean(T.fCorr1D_preXpost(inaPC_noRun)), mean(T.fCorr1D_stmXpost(inaPC_noRun))];
m_fcorr_norespPC_noRun = [mean(T.fCorr1D_preXpre(norespPC_noRun)), mean(T.fCorr1D_preXstm(norespPC_noRun)), mean(T.fCorr1D_preXpost(norespPC_noRun)), mean(T.fCorr1D_stmXpost(norespPC_noRun))];

sem_fcorr_tPC_noRun = [std(T.fCorr1D_preXpre(tPC_noRun),0,1)/sqrt(ntPC_noRun) std(T.fCorr1D_preXstm(tPC_noRun),0,1)/sqrt(ntPC_noRun), std(T.fCorr1D_preXpost(tPC_noRun),0,1)/sqrt(ntPC_noRun), std(T.fCorr1D_stmXpost(tPC_noRun),0,1)/sqrt(ntPC_noRun)];
sem_fcorr_respPC_noRun = [std(T.fCorr1D_preXpre(respPC_noRun),0,1)/sqrt(nrespPC_noRun), std(T.fCorr1D_preXstm(respPC_noRun),0,1)/sqrt(nrespPC_noRun), std(T.fCorr1D_preXpost(respPC_noRun),0,1)/sqrt(nrespPC_noRun), std(T.fCorr1D_stmXpost(respPC_noRun),0,1)/sqrt(nrespPC_noRun)];
sem_fcorr_actPC_noRun = [std(T.fCorr1D_preXpre(actPC_noRun),0,1)/sqrt(nactPC_noRun), std(T.fCorr1D_preXstm(actPC_noRun),0,1)/sqrt(nactPC_noRun), std(T.fCorr1D_preXpost(actPC_noRun),0,1)/sqrt(nactPC_noRun), std(T.fCorr1D_stmXpost(actPC_noRun),0,1)/sqrt(nactPC_noRun)];
sem_fcorr_inaPC_noRun = [std(T.fCorr1D_preXpre(inaPC_noRun),0,1)/sqrt(ninaPC_noRun), std(T.fCorr1D_preXstm(inaPC_noRun),0,1)/sqrt(ninaPC_noRun), std(T.fCorr1D_preXpost(inaPC_noRun),0,1)/sqrt(ninaPC_noRun), std(T.fCorr1D_stmXpost(inaPC_noRun),0,1)/sqrt(ninaPC_noRun)];
sem_fcorr_norespPC_noRun = [std(T.fCorr1D_preXpre(norespPC_noRun),0,1)/sqrt(nnorespPC_noRun), std(T.fCorr1D_preXstm(norespPC_noRun),0,1)/sqrt(nnorespPC_noRun), std(T.fCorr1D_preXpost(norespPC_noRun),0,1)/sqrt(nnorespPC_noRun), std(T.fCorr1D_stmXpost(norespPC_noRun),0,1)/sqrt(nnorespPC_noRun)];

[~, p_preXpre] = ttest2(T.fCorr1D_preXpre(tPC_DRun),T.fCorr1D_preXpre(tPC_noRun));
[~, p_preXstm] = ttest2(T.fCorr1D_preXstm(tPC_DRun),T.fCorr1D_preXstm(tPC_noRun));
[~, p_preXpost] = ttest2(T.fCorr1D_preXpost(tPC_DRun),T.fCorr1D_preXpost(tPC_noRun));
[~, p_stmXpost] = ttest2(T.fCorr1D_stmXpost(tPC_DRun),T.fCorr1D_stmXpost(tPC_noRun));
%%
barWidth = 0.3;
eBarLength = 0.3;
eBarWidth = 0.8;
eBarColor = colorBlack;
nCol = 5;
nRow = 2;
fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{2});

hPVCorr(1) = axes('Position',axpt(nCol,nRow,1,1,[0.1 0.1 0.855 0.85],midInterval));
bar([1,4,7],m_tPC_DRun_PVcorr,barWidth,'faceColor',colorLightBlue);
hold on;
hold on;
bar([2,5,8],m_tPC_noRun_PVcorr,barWidth,'faceColor',colorGray);
hold on;
title('total place cells','fontSize',fontL,'fontWeight','bold');
ylabel('PV correlation','fontSize',fontL);
text(5, 1.1,['n (DRun) = ',num2str(ntPC_DRun)],'fontSize',fontL,'color',colorDarkBlue);
text(5, 1.0,['n (noRun) = ',num2str(ntPC_noRun)],'fontSize',fontL,'color',colorDarkGray);

hPVCorr(2) = axes('Position',axpt(nCol,nRow,2,1,[0.1 0.1 0.855 0.85],midInterval));
bar([1,4,7],m_respPC_DRun_PVcorr,barWidth,'faceColor',colorLightBlue);
hold on;
bar([2,5,8],m_respPC_noRun_PVcorr,barWidth,'faceColor',colorGray);
title('light responsive place cells','fontSize',fontL,'fontWeight','bold');
ylabel('PV correlation','fontSize',fontL);
text(5, 1.1,['n (DRun) = ',num2str(nrespPC_DRun)],'fontSize',fontL,'color',colorDarkBlue);
text(5, 1.0,['n (noRun) = ',num2str(nrespPC_noRun)],'fontSize',fontL,'color',colorDarkGray);

hPVCorr(3) = axes('Position',axpt(nCol,nRow,3,1,[0.1 0.1 0.855 0.85],midInterval));
bar([1,4,7],m_actPC_DRun_PVcorr,barWidth,'faceColor',colorLightBlue);
hold on;
bar([2,5,8],m_actPC_noRun_PVcorr,barWidth,'faceColor',colorGray);
title('activated place cells','fontSize',fontL,'fontWeight','bold');
ylabel('PV correlation','fontSize',fontL);
text(5, 1.1,['n (DRun) = ',num2str(nactPC_DRun)],'fontSize',fontL,'color',colorDarkBlue);
text(5, 1.0,['n (noRun) = ',num2str(nactPC_noRun)],'fontSize',fontL,'color',colorDarkGray);

hPVCorr(4) = axes('Position',axpt(nCol,nRow,4,1,[0.1 0.1 0.855 0.85],midInterval));
bar([1,4,7],m_inaPC_DRun_PVcorr,barWidth,'faceColor',colorLightBlue);
hold on;
bar([2,5,8],m_inaPC_noRun_PVcorr,barWidth,'faceColor',colorGray);
hold on;
title('inactivated place cells','fontSize',fontL,'fontWeight','bold');
ylabel('PV correlation','fontSize',fontL);
text(5, 1.1,['n (DRun) = ',num2str(ninaPC_DRun)],'fontSize',fontL,'color',colorDarkBlue);
text(5, 1.0,['n (noRun) = ',num2str(ninaPC_noRun)],'fontSize',fontL,'color',colorDarkGray);

hPVCorr(5) = axes('Position',axpt(nCol,nRow,5,1,[0.1 0.1 0.855 0.85],midInterval));
bar([1,4,7],m_norespPC_DRun_PVcorr,barWidth,'faceColor',colorLightBlue);
hold on;
bar([2,5,8],m_norespPC_noRun_PVcorr,barWidth,'faceColor',colorGray);
hold on;
title('noresponsive place cells','fontSize',fontL,'fontWeight','bold');
ylabel('PV correlation','fontSize',fontL);
text(5, 1.1,['n (DRun) = ',num2str(nnorespPC_DRun)],'fontSize',fontL,'color',colorDarkBlue);
text(5, 1.0,['n (noRun) = ',num2str(nnorespPC_noRun)],'fontSize',fontL,'color',colorDarkGray);
set(hPVCorr,'TickDir','out','Box','off','XLim',[0,9],'YLim',[0 1.2],'XTick',[1.5 4.5 7.5],'XTickLabel',[{'preXstm','preXpost','stmXpost'}],'fontSize',fontM);

%%%%%%%%%%%%%%%%%%%% Individual correlation %%%%%%%%%%%%%%%%%%%%%
hIndCorr(1) = axes('Position',axpt(nCol,nRow,1,2,[0.1 0.1 0.85 0.85],midInterval));
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

hIndCorr(2) = axes('Position',axpt(nCol,nRow,2,2,[0.1 0.1 0.85 0.85],midInterval));
bar([1,4,7,10],m_fcorr_respPC_DRun,barWidth,'faceColor',colorLightBlue);
hold on;
errorbarJun([1,4,7,10],m_fcorr_respPC_DRun,sem_fcorr_tPC_DRun,eBarLength,eBarWidth,eBarColor);
hold on;
bar([2,5,8,11],m_fcorr_respPC_noRun,barWidth,'faceColor',colorGray);
hold on;
errorbarJun([2,5,8,11],m_fcorr_respPC_noRun,sem_fcorr_tPC_noRun,eBarLength,eBarWidth,eBarColor);
title('light responsive place cells','fontSize',fontL,'fontWeight','bold');
ylabel('Corr(z-transformed)','fontSize',fontL);
text(7, 3.2,['n (DRun) = ',num2str(nrespPC_DRun)],'fontSize',fontL,'color',colorDarkBlue);
text(7, 2.8,['n (noRun) = ',num2str(nrespPC_noRun)],'fontSize',fontL,'color',colorDarkGray);

hIndCorr(3) = axes('Position',axpt(nCol,nRow,3,2,[0.1 0.1 0.85 0.85],midInterval));
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

hIndCorr(4) = axes('Position',axpt(nCol,nRow,4,2,[0.1 0.1 0.85 0.85],midInterval));
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

hIndCorr(5) = axes('Position',axpt(nCol,nRow,5,2,[0.1 0.1 0.85 0.85],midInterval));
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

set(hIndCorr,'TickDir','out','Box','off','XLim',[0,12],'YLim',[0 3.5],'XTick',[1.5 4.5 7.5 10.5],'XTickLabel',[{'preXpre','preXstm','preXpost','stmXpost'}],'fontSize',fontM);

print('-painters','-r300','-dtiff',['final_fig5_placeField_PVCorr_DRun_noRun_',datestr(now,formatOut),'.tif']);
close;