clearvars;
rtDir = 'D:\Dropbox\SNL\P2_Track';
cd(rtDir);

% load('D:\Dropbox\SNL\P2_Track\myParameters.mat');
load('neuronList_ori_170928.mat');
% Txls = readtable('neuronList_ori_170803.xlsx');
% Txls.taskType = categorical(Txls.taskType);
formatOut = 'yymmdd';

% total population (DRunPN / DRunIN / DRwPN / DRwIN) with light responsiveness (light activated)
DRun_PN = T.taskType == 'DRun' & T.idxNeurontype == 'PN';
DRun_IN = T.taskType == 'DRun' & T.idxNeurontype == 'IN';
DRun_UNC = T.taskType == 'DRun' & T.idxNeurontype == 'UNC';

DRw_PN = T.taskType == 'DRw' & T.idxNeurontype == 'PN';
DRw_IN = T.taskType == 'DRw' & T.idxNeurontype == 'IN';
DRw_UNC = T.taskType == 'DRw' & T.idxNeurontype == 'UNC';

%% DRun PN
nDRunPN = sum(double(DRun_PN));
meanFR_DRunPN = T.meanFR_task(DRun_PN);
m_meanFR_DRunPN = mean(meanFR_DRunPN);
sem_meanFR_DRunPN = std(meanFR_DRunPN,0,1)/sqrt(length(meanFR_DRunPN));

hvWidth_DRunPN = T.hfvwth(DRun_PN);
m_hvWidth_DRunPN = mean(hvWidth_DRunPN);
sem_hvWidth_DRunPN = std(hvWidth_DRunPN,0,1)/sqrt(length(hvWidth_DRunPN));

spkpvr_DRunPN = T.spkpvr(DRun_PN);
m_spkpvr_DRunPN = mean(spkpvr_DRunPN);
sem_spkpvr_DRunPN = std(spkpvr_DRunPN,0,1)/sqrt(length(spkpvr_DRunPN));

DRunPN = [nDRunPN, m_meanFR_DRunPN, sem_meanFR_DRunPN, m_hvWidth_DRunPN, sem_hvWidth_DRunPN, m_spkpvr_DRunPN, sem_spkpvr_DRunPN]
%% DRun IN
nDRunIN = sum(double(DRun_IN));
meanFR_DRunIN = T.meanFR_task(DRun_IN);
m_meanFR_DRunIN = mean(meanFR_DRunIN);
sem_meanFR_DRunIN = std(meanFR_DRunIN,0,1)/sqrt(length(meanFR_DRunIN));

hvWidth_DRunIN = T.hfvwth(DRun_IN);
m_hvWidth_DRunIN = mean(hvWidth_DRunIN);
sem_hvWidth_DRunIN = std(hvWidth_DRunIN,0,1)/sqrt(length(hvWidth_DRunIN));

spkpvr_DRunIN = T.spkpvr(DRun_IN);
m_spkpvr_DRunIN = mean(spkpvr_DRunIN);
sem_spkpvr_DRunIN = std(spkpvr_DRunIN,0,1)/sqrt(length(spkpvr_DRunIN));

DRunIN = [nDRunIN, m_meanFR_DRunIN, sem_meanFR_DRunIN, m_hvWidth_DRunIN, sem_hvWidth_DRunIN, m_spkpvr_DRunIN, sem_spkpvr_DRunIN]
%% DRw PN
nDRwPN = sum(double(DRw_PN));
meanFR_DRwPN = T.meanFR_task(DRw_PN);
m_meanFR_DRwPN = mean(meanFR_DRwPN);
sem_meanFR_DRwPN = std(meanFR_DRwPN,0,1)/sqrt(length(meanFR_DRwPN));

hvWidth_DRwPN = T.hfvwth(DRw_PN);
m_hvWidth_DRwPN = mean(hvWidth_DRwPN);
sem_hvWidth_DRwPN = std(hvWidth_DRwPN,0,1)/sqrt(length(hvWidth_DRwPN));

spkpvr_DRwPN = T.spkpvr(DRw_PN);
m_spkpvr_DRwPN = mean(spkpvr_DRwPN);
sem_spkpvr_DRwPN = std(spkpvr_DRwPN,0,1)/sqrt(length(spkpvr_DRwPN));

DRwPN = [nDRwPN, m_meanFR_DRwPN, sem_meanFR_DRwPN, m_hvWidth_DRwPN, sem_hvWidth_DRwPN, m_spkpvr_DRwPN, sem_spkpvr_DRwPN]
%% DRw IN
nDRwIN = sum(double(DRw_IN));
meanFR_DRwIN = T.meanFR_task(DRw_IN);
m_meanFR_DRwIN = mean(meanFR_DRwIN);
sem_meanFR_DRwIN = std(meanFR_DRwIN,0,1)/sqrt(length(meanFR_DRwIN));

hvWidth_DRwIN = T.hfvwth(DRw_IN);
m_hvWidth_DRwIN = mean(hvWidth_DRwIN);
sem_hvWidth_DRwIN = std(hvWidth_DRwIN,0,1)/sqrt(length(hvWidth_DRwIN));

spkpvr_DRwIN = T.spkpvr(DRw_IN);
m_spkpvr_DRwIN = mean(spkpvr_DRwIN);
sem_spkpvr_DRwIN = std(spkpvr_DRwIN,0,1)/sqrt(length(spkpvr_DRwIN));

DRwIN = [nDRwIN, m_meanFR_DRwIN, sem_meanFR_DRwIN, m_hvWidth_DRwIN, sem_hvWidth_DRwIN, m_spkpvr_DRwIN, sem_spkpvr_DRwIN]