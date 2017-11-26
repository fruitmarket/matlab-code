clearvars;

cd('D:\Dropbox\SNL\P2_Track'); % win version
Txls = readtable('neuronList_ori_171018.xlsx');
load('neuronList_ori_171018.mat');
load myParameters.mat;
Txls.latencyIndex = categorical(Txls.latencyIndex);
formatOut = 'yymmdd';

total = T.taskType == 'DRun';
DRunPN = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
rCorr = [T.rCorr1D_preXpre T.rCorr1D_preXstm T.rCorr1D_preXpost T.rCorr1D_stmXpost];


plot(T.meanFR_task(total),T.spkpvr(total),'o','color','k');
hold on;
plot(T.meanFR_task(DRunPN),T.spkpvr(DRunPN),'o','color','r');