clearvars;
cd('D:\Dropbox\SNL\P2_Track');
Txls = readtable('neuronList_ori_171018.xlsx');
Txls.latencyIndex = categorical(Txls.latencyIndex);
load('neuronList_ori_171018.mat');
load('D:\Dropbox\SNL\P2_Track\myParameters.mat');

formatOut = 'yymmdd';

% TN: track neuron
tPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
respPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track;
norespPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxpLR_Track;

ntPC_DRun = sum(double(tPC_DRun));
nrespPC_DRun = sum(double(respPC_DRun));
nnorespPC_DRun = sum(double(norespPC_DRun));

% corr of total neurons
tPC_DRun_PRE = cell2mat(T.rateMap1D_PRE(tPC_DRun));
tPC_DRun_STM = cell2mat(T.rateMap1D_STM(tPC_DRun));
tPC_DRun_POST = cell2mat(T.rateMap1D_POST(tPC_DRun));

respPC_DRun_PRE = cell2mat(T.rateMap1D_PRE(respPC_DRun));
respPC_DRun_STM = cell2mat(T.rateMap1D_STM(respPC_DRun));
respPC_DRun_POST = cell2mat(T.rateMap1D_POST(respPC_DRun));

norespPC_DRun_PRE = cell2mat(T.rateMap1D_PRE(norespPC_DRun));
norespPC_DRun_STM = cell2mat(T.rateMap1D_STM(norespPC_DRun));
norespPC_DRun_POST = cell2mat(T.rateMap1D_POST(norespPC_DRun));

[tPC_DRun_PVcorr_preXstm, tPC_DRun_PVcorr_preXpost, tPC_DRun_PVcorr_stmXpost] = deal([]);
[respPC_DRun_PVcorr_preXstm, respPC_DRun_PVcorr_preXpost, respPC_DRun_PVcorr_stmXpost] = deal([]);
[norespPC_DRun_PVcorr_preXstm, norespPC_DRun_PVcorr_preXpost, norespPC_DRun_PVcorr_stmXpost] = deal([]);

for iCol = 1:124
    tPC_DRun_PVcorr_preXstm(iCol) = corr(tPC_DRun_PRE(:,iCol),tPC_DRun_STM(:,iCol),'type','Pearson');
    tPC_DRun_PVcorr_preXpost(iCol) = corr(tPC_DRun_PRE(:,iCol),tPC_DRun_POST(:,iCol),'type','Pearson');
    tPC_DRun_PVcorr_stmXpost(iCol) = corr(tPC_DRun_STM(:,iCol),tPC_DRun_POST(:,iCol),'type','Pearson');
    
    respPC_DRun_PVcorr_preXstm(iCol) = corr(respPC_DRun_PRE(:,iCol),respPC_DRun_STM(:,iCol),'type','Pearson');
    respPC_DRun_PVcorr_preXpost(iCol) = corr(respPC_DRun_PRE(:,iCol),respPC_DRun_POST(:,iCol),'type','Pearson');
    respPC_DRun_PVcorr_stmXpost(iCol) = corr(respPC_DRun_STM(:,iCol),respPC_DRun_POST(:,iCol),'type','Pearson');
    
    norespPC_DRun_PVcorr_preXstm(iCol) = corr(norespPC_DRun_PRE(:,iCol),norespPC_DRun_STM(:,iCol),'type','Pearson');
    norespPC_DRun_PVcorr_preXpost(iCol) = corr(norespPC_DRun_PRE(:,iCol),norespPC_DRun_POST(:,iCol),'type','Pearson');
    norespPC_DRun_PVcorr_stmXpost(iCol) = corr(norespPC_DRun_STM(:,iCol),norespPC_DRun_POST(:,iCol),'type','Pearson');    
end
m_tPC_DRun_PVcorr = [nanmean(tPC_DRun_PVcorr_preXstm), nanmean(tPC_DRun_PVcorr_preXpost), nanmean(tPC_DRun_PVcorr_stmXpost)];
m_respPC_DRun_PVcorr = [nanmean(respPC_DRun_PVcorr_preXstm), nanmean(respPC_DRun_PVcorr_preXpost), nanmean(respPC_DRun_PVcorr_stmXpost)];
m_norespPC_DRun_PVcorr = [nanmean(norespPC_DRun_PVcorr_preXstm), nanmean(norespPC_DRun_PVcorr_preXpost), nanmean(norespPC_DRun_PVcorr_stmXpost)];

sem_tPC_DRun_PVcorr = [nanstd(tPC_DRun_PVcorr_preXstm,0,2)/sqrt(ntPC_DRun), nanstd(tPC_DRun_PVcorr_preXpost,0,2)/sqrt(ntPC_DRun), nanstd(tPC_DRun_PVcorr_stmXpost,0,2)/sqrt(ntPC_DRun)];
sem_respPC_DRun_PVcorr = [nanstd(respPC_DRun_PVcorr_preXstm,0,2)/sqrt(nrespPC_DRun), nanstd(respPC_DRun_PVcorr_preXpost,0,2)/sqrt(nrespPC_DRun), nanstd(respPC_DRun_PVcorr_stmXpost,0,2)/sqrt(nrespPC_DRun)];
sem_norespPC_DRun_PVcorr = [nanstd(norespPC_DRun_PVcorr_preXstm,0,2)/sqrt(nnorespPC_DRun), nanstd(norespPC_DRun_PVcorr_preXpost,0,2)/sqrt(nnorespPC_DRun), nanstd(norespPC_DRun_PVcorr_stmXpost,0,2)/sqrt(nnorespPC_DRun)];

% file example
% plot_Track_multi_v3(T.path(actPC_DRun),T.cellID(actPC_DRun),'C:\Users\Jun\Desktop\DRun_act');
% plot_Track_multi_v3(T.path(inaPC_DRun),T.cellID(inaPC_DRun),'C:\Users\Jun\Desktop\DRun_ina');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% noRun session %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
respPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track;
norespPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxpLR_Track;

ntPC_noRun = sum(double(tPC_noRun));
nrespPC_noRun = sum(double(respPC_noRun));
nnorespPC_noRun = sum(double(norespPC_noRun));

% corr of total neurons
tPC_noRun_PRE = cell2mat(T.rateMap1D_PRE(tPC_noRun));
tPC_noRun_STM = cell2mat(T.rateMap1D_STM(tPC_noRun));
tPC_noRun_POST = cell2mat(T.rateMap1D_POST(tPC_noRun));

respPC_noRun_PRE = cell2mat(T.rateMap1D_PRE(respPC_noRun));
respPC_noRun_STM = cell2mat(T.rateMap1D_STM(respPC_noRun));
respPC_noRun_POST = cell2mat(T.rateMap1D_POST(respPC_noRun));

norespPC_noRun_PRE = cell2mat(T.rateMap1D_PRE(norespPC_noRun));
norespPC_noRun_STM = cell2mat(T.rateMap1D_STM(norespPC_noRun));
norespPC_noRun_POST = cell2mat(T.rateMap1D_POST(norespPC_noRun));

[tPC_noRun_PVcorr_preXstm, tPC_noRun_PVcorr_preXpost, tPC_noRun_PVcorr_stmXpost] = deal([]);
[respPC_noRun_PVcorr_preXstm, respPC_noRun_PVcorr_preXpost, respPC_noRun_PVcorr_stmXpost] = deal([]);
[norespPC_noRun_PVcorr_preXstm, norespPC_noRun_PVcorr_preXpost, norespPC_noRun_PVcorr_stmXpost] = deal([]);

for iCol = 1:124
    tPC_noRun_PVcorr_preXstm(iCol) = corr(tPC_noRun_PRE(:,iCol),tPC_noRun_STM(:,iCol),'type','Pearson');
    tPC_noRun_PVcorr_preXpost(iCol) = corr(tPC_noRun_PRE(:,iCol),tPC_noRun_POST(:,iCol),'type','Pearson');
    tPC_noRun_PVcorr_stmXpost(iCol) = corr(tPC_noRun_STM(:,iCol),tPC_noRun_POST(:,iCol),'type','Pearson');
    
    respPC_noRun_PVcorr_preXstm(iCol) = corr(respPC_noRun_PRE(:,iCol),respPC_noRun_STM(:,iCol),'type','Pearson');
    respPC_noRun_PVcorr_preXpost(iCol) = corr(respPC_noRun_PRE(:,iCol),respPC_noRun_POST(:,iCol),'type','Pearson');
    respPC_noRun_PVcorr_stmXpost(iCol) = corr(respPC_noRun_STM(:,iCol),respPC_noRun_POST(:,iCol),'type','Pearson');
    
    norespPC_noRun_PVcorr_preXstm(iCol) = corr(norespPC_noRun_PRE(:,iCol),norespPC_noRun_STM(:,iCol),'type','Pearson');
    norespPC_noRun_PVcorr_preXpost(iCol) = corr(norespPC_noRun_PRE(:,iCol),norespPC_noRun_POST(:,iCol),'type','Pearson');
    norespPC_noRun_PVcorr_stmXpost(iCol) = corr(norespPC_noRun_STM(:,iCol),norespPC_noRun_POST(:,iCol),'type','Pearson');    
end
m_tPC_noRun_PVcorr = [nanmean(tPC_noRun_PVcorr_preXstm), nanmean(tPC_noRun_PVcorr_preXpost), nanmean(tPC_noRun_PVcorr_stmXpost)];
m_respPC_noRun_PVcorr = [nanmean(respPC_noRun_PVcorr_preXstm), nanmean(respPC_noRun_PVcorr_preXpost), nanmean(respPC_noRun_PVcorr_stmXpost)];
m_norespPC_noRun_PVcorr = [nanmean(norespPC_noRun_PVcorr_preXstm), nanmean(norespPC_noRun_PVcorr_preXpost), nanmean(norespPC_noRun_PVcorr_stmXpost)];

sem_tPC_noRun_PVcorr = [nanstd(tPC_noRun_PVcorr_preXstm,0,2)/sqrt(ntPC_noRun), nanstd(tPC_noRun_PVcorr_preXpost,0,2)/sqrt(ntPC_noRun), nanstd(tPC_noRun_PVcorr_stmXpost,0,2)/sqrt(ntPC_noRun)];
sem_respPC_noRun_PVcorr = [nanstd(respPC_noRun_PVcorr_preXstm,0,2)/sqrt(nrespPC_noRun), nanstd(respPC_noRun_PVcorr_preXpost,0,2)/sqrt(nrespPC_noRun), nanstd(respPC_noRun_PVcorr_stmXpost,0,2)/sqrt(nrespPC_noRun)];
sem_norespPC_noRun_PVcorr = [nanstd(norespPC_noRun_PVcorr_preXstm,0,2)/sqrt(nnorespPC_noRun), nanstd(norespPC_noRun_PVcorr_preXpost,0,2)/sqrt(nnorespPC_noRun), nanstd(norespPC_noRun_PVcorr_stmXpost,0,2)/sqrt(nnorespPC_noRun)];

%%
tPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
respPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track;
norespPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxpLR_Track;

ntPC_DRw = sum(double(tPC_DRw));
nrespPC_DRw = sum(double(respPC_DRw));
nnorespPC_DRw = sum(double(norespPC_DRw));

% corr of total neurons
tPC_DRw_PRE = cell2mat(T.rateMap1D_PRE(tPC_DRw));
tPC_DRw_STM = cell2mat(T.rateMap1D_STM(tPC_DRw));
tPC_DRw_POST = cell2mat(T.rateMap1D_POST(tPC_DRw));

respPC_DRw_PRE = cell2mat(T.rateMap1D_PRE(respPC_DRw));
respPC_DRw_STM = cell2mat(T.rateMap1D_STM(respPC_DRw));
respPC_DRw_POST = cell2mat(T.rateMap1D_POST(respPC_DRw));

norespPC_DRw_PRE = cell2mat(T.rateMap1D_PRE(norespPC_DRw));
norespPC_DRw_STM = cell2mat(T.rateMap1D_STM(norespPC_DRw));
norespPC_DRw_POST = cell2mat(T.rateMap1D_POST(norespPC_DRw));

[tPC_DRw_PVcorr_preXstm, tPC_DRw_PVcorr_preXpost, tPC_DRw_PVcorr_stmXpost] = deal([]);
[respPC_DRw_PVcorr_preXstm, respPC_DRw_PVcorr_preXpost, respPC_DRw_PVcorr_stmXpost] = deal([]);
[norespPC_DRw_PVcorr_preXstm, norespPC_DRw_PVcorr_preXpost, norespPC_DRw_PVcorr_stmXpost] = deal([]);

for iCol = 1:124
    tPC_DRw_PVcorr_preXstm(iCol) = corr(tPC_DRw_PRE(:,iCol),tPC_DRw_STM(:,iCol),'type','Pearson');
    tPC_DRw_PVcorr_preXpost(iCol) = corr(tPC_DRw_PRE(:,iCol),tPC_DRw_POST(:,iCol),'type','Pearson');
    tPC_DRw_PVcorr_stmXpost(iCol) = corr(tPC_DRw_STM(:,iCol),tPC_DRw_POST(:,iCol),'type','Pearson');
    
    respPC_DRw_PVcorr_preXstm(iCol) = corr(respPC_DRw_PRE(:,iCol),respPC_DRw_STM(:,iCol),'type','Pearson');
    respPC_DRw_PVcorr_preXpost(iCol) = corr(respPC_DRw_PRE(:,iCol),respPC_DRw_POST(:,iCol),'type','Pearson');
    respPC_DRw_PVcorr_stmXpost(iCol) = corr(respPC_DRw_STM(:,iCol),respPC_DRw_POST(:,iCol),'type','Pearson');
    
    norespPC_DRw_PVcorr_preXstm(iCol) = corr(norespPC_DRw_PRE(:,iCol),norespPC_DRw_STM(:,iCol),'type','Pearson');
    norespPC_DRw_PVcorr_preXpost(iCol) = corr(norespPC_DRw_PRE(:,iCol),norespPC_DRw_POST(:,iCol),'type','Pearson');
    norespPC_DRw_PVcorr_stmXpost(iCol) = corr(norespPC_DRw_STM(:,iCol),norespPC_DRw_POST(:,iCol),'type','Pearson');    
end
m_tPC_DRw_PVcorr = [nanmean(tPC_DRw_PVcorr_preXstm), nanmean(tPC_DRw_PVcorr_preXpost), nanmean(tPC_DRw_PVcorr_stmXpost)];
m_respPC_DRw_PVcorr = [nanmean(respPC_DRw_PVcorr_preXstm), nanmean(respPC_DRw_PVcorr_preXpost), nanmean(respPC_DRw_PVcorr_stmXpost)];
m_norespPC_DRw_PVcorr = [nanmean(norespPC_DRw_PVcorr_preXstm), nanmean(norespPC_DRw_PVcorr_preXpost), nanmean(norespPC_DRw_PVcorr_stmXpost)];

sem_tPC_DRw_PVcorr = [nanstd(tPC_DRw_PVcorr_preXstm,0,2)/sqrt(ntPC_DRw), nanstd(tPC_DRw_PVcorr_preXpost,0,2)/sqrt(ntPC_DRw), nanstd(tPC_DRw_PVcorr_stmXpost,0,2)/sqrt(ntPC_DRw)];
sem_respPC_DRw_PVcorr = [nanstd(respPC_DRw_PVcorr_preXstm,0,2)/sqrt(nrespPC_DRw), nanstd(respPC_DRw_PVcorr_preXpost,0,2)/sqrt(nrespPC_DRw), nanstd(respPC_DRw_PVcorr_stmXpost,0,2)/sqrt(nrespPC_DRw)];
sem_norespPC_DRw_PVcorr = [nanstd(norespPC_DRw_PVcorr_preXstm,0,2)/sqrt(nnorespPC_DRw), nanstd(norespPC_DRw_PVcorr_preXpost,0,2)/sqrt(nnorespPC_DRw), nanstd(norespPC_DRw_PVcorr_stmXpost,0,2)/sqrt(nnorespPC_DRw)];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% noRw session %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
respPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track;
norespPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxpLR_Track;

ntPC_noRw = sum(double(tPC_noRw));
nrespPC_noRw = sum(double(respPC_noRw));
nnorespPC_noRw = sum(double(norespPC_noRw));

% corr of total neurons
tPC_noRw_PRE = cell2mat(T.rateMap1D_PRE(tPC_noRw));
tPC_noRw_STM = cell2mat(T.rateMap1D_STM(tPC_noRw));
tPC_noRw_POST = cell2mat(T.rateMap1D_POST(tPC_noRw));

respPC_noRw_PRE = cell2mat(T.rateMap1D_PRE(respPC_noRw));
respPC_noRw_STM = cell2mat(T.rateMap1D_STM(respPC_noRw));
respPC_noRw_POST = cell2mat(T.rateMap1D_POST(respPC_noRw));

norespPC_noRw_PRE = cell2mat(T.rateMap1D_PRE(norespPC_noRw));
norespPC_noRw_STM = cell2mat(T.rateMap1D_STM(norespPC_noRw));
norespPC_noRw_POST = cell2mat(T.rateMap1D_POST(norespPC_noRw));

%% data for DR.DY
% save('PVcorr_170927.mat',...
%     'tPC_DRun_PRE','tPC_DRun_STM','tPC_DRun_POST',...
%     'respPC_DRun_PRE','respPC_DRun_STM','respPC_DRun_POST',...
%     'norespPC_DRun_PRE','norespPC_DRun_STM','norespPC_DRun_POST',...
%     'tPC_noRun_PRE','tPC_noRun_STM','tPC_noRun_POST',...
%     'respPC_noRun_PRE','respPC_noRun_STM','respPC_noRun_POST',...
%     'norespPC_noRun_PRE','norespPC_noRun_STM','norespPC_noRun_POST');
%%
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
    
    norespPC_noRw_PVcorr_preXstm(iCol) = corr(norespPC_noRw_PRE(:,iCol),norespPC_noRw_STM(:,iCol),'type','Pearson');
    norespPC_noRw_PVcorr_preXpost(iCol) = corr(norespPC_noRw_PRE(:,iCol),norespPC_noRw_POST(:,iCol),'type','Pearson');
    norespPC_noRw_PVcorr_stmXpost(iCol) = corr(norespPC_noRw_STM(:,iCol),norespPC_noRw_POST(:,iCol),'type','Pearson');
end
m_tPC_noRw_PVcorr = [nanmean(tPC_noRw_PVcorr_preXstm), nanmean(tPC_noRw_PVcorr_preXpost), nanmean(tPC_noRw_PVcorr_stmXpost)];
m_respPC_noRw_PVcorr = [nanmean(respPC_noRw_PVcorr_preXstm), nanmean(respPC_noRw_PVcorr_preXpost), nanmean(respPC_noRw_PVcorr_stmXpost)];
m_norespPC_noRw_PVcorr = [nanmean(norespPC_noRw_PVcorr_preXstm), nanmean(norespPC_noRw_PVcorr_preXpost), nanmean(norespPC_noRw_PVcorr_stmXpost)];

sem_tPC_noRw_PVcorr = [nanstd(tPC_noRw_PVcorr_preXstm,0,2)/sqrt(ntPC_noRw), nanstd(tPC_noRw_PVcorr_preXpost,0,2)/sqrt(ntPC_noRw), nanstd(tPC_noRw_PVcorr_stmXpost,0,2)/sqrt(ntPC_noRw)];
sem_respPC_noRw_PVcorr = [nanstd(respPC_noRw_PVcorr_preXstm,0,2)/sqrt(nrespPC_noRw), nanstd(respPC_noRw_PVcorr_preXpost,0,2)/sqrt(nrespPC_noRw), nanstd(respPC_noRw_PVcorr_stmXpost,0,2)/sqrt(nrespPC_noRw)];
sem_norespPC_noRw_PVcorr = [nanstd(norespPC_noRw_PVcorr_preXstm,0,2)/sqrt(nnorespPC_noRw), nanstd(norespPC_noRw_PVcorr_preXpost,0,2)/sqrt(nnorespPC_noRw), nanstd(norespPC_noRw_PVcorr_stmXpost,0,2)/sqrt(nnorespPC_noRw)];


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

print('-painters','-r300','-dtiff',['final_fig5_placeField_PVCorr_DRunDRw_ppt_',datestr(now,formatOut),'.tif']);
print('-painters','-r300','-depsc',['final_fig5_placeField_PVCorr_DRunDRw_ppt_',datestr(now,formatOut),'.ai']);
% close;