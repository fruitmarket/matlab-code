clearvars;
cd('D:\Dropbox\SNL\P2_Track');

load('D:\Dropbox\SNL\P2_Track\myParameters.mat');
formatOut = 'yymmdd';

markerS = 1.5;
dotS = 4;
colorGray = [100 100 100]./255;
colorLightGray = [240 240 240]./255;
colorDarkGray = [170 170 170]./255;

% 1cm win
% load('neuronList_ori50hz_171229.mat');
load('neuronList_ori50hz_180123.mat');
lightLoc_Run = [floor(20*pi*5/6) ceil(20*pi*8/6)];
lightLoc_Rw = [floor(20*pi*9/6) ceil(20*pi*10/6)];

% 2cm win
% load('neuronList_ori50hz_171219_2cm.mat');
% lightLoc_Run = [27 42];
% lightLoc_Rw = [48 53];

% 4cm win
% load('neuronList_ori50hz_171219_4cm.mat');
% lightLoc_Run = [14 21];
% lightLoc_Rw = [24 26];

cri_meanFR = 1;

%%
% TN: track neuron
% tPC_Run = T.taskType == 'DRun' & T.idxNeurontype == 'PN';
% tPC_Run = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
tPC_Run = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & cellfun(@(x) max(max(x)), T.pethconvSpatial)>cri_meanFR; % mean firing rate > 1hz
% tPC_Run = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR;

nPC_Run = sum(double(tPC_Run));

% corr of total neurons
rateMapRaw_Run = T.rateMapRaw_eachLap(tPC_Run);
rateMapRaw10_PRE_Run = cell2mat(T.rateMapRaw10_PRE(tPC_Run));
rateMapRaw10_STIM_Run = cell2mat(T.rateMapRaw10_STIM(tPC_Run));
rateMapRaw10_POST_Run = cell2mat(T.rateMapRaw10_POST(tPC_Run));

nTotalBin = size(rateMapRaw10_PRE_Run,2);
nInBin_Run = length(lightLoc_Run(1):lightLoc_Run(2));
nOutBin_Run = length([1:lightLoc_Run(1)-1,lightLoc_Run(2)+1:nTotalBin]);
nInBin_Rw = length(lightLoc_Rw(1):lightLoc_Rw(2));
nOutBin_Rw = length([1:lightLoc_Rw(1)-1,lightLoc_Rw(2)+1:nTotalBin]);

tempTotal = zeros(nPC_Run,nTotalBin);
tempInzone_Run = zeros(nPC_Run,nInBin_Run);
tempOutzone_Run = zeros(nPC_Run,nOutBin_Run);
tempInzone_Rw = zeros(nPC_Run,nInBin_Rw);
tempOutzone_Rw = zeros(nPC_Run,nOutBin_Rw);
tempInzone_noRun = zeros(nPC_Run,nInBin_Run);
tempOutzone_noRun = zeros(nPC_Run,nOutBin_Run);
tempInzone_noRw = zeros(nPC_Run,nInBin_Rw);
tempOutzone_noRw = zeros(nPC_Run,nOutBin_Rw);

inBasePRE_Run = rateMapRaw10_PRE_Run(:,lightLoc_Run(1):lightLoc_Run(2));
inBaseSTIM_Run = rateMapRaw10_STIM_Run(:,lightLoc_Run(1):lightLoc_Run(2));
inBasePOST_Run = rateMapRaw10_POST_Run(:,lightLoc_Run(1):lightLoc_Run(2));

outBasePRE_Run = rateMapRaw10_PRE_Run(:,[1:lightLoc_Run(1)-1,lightLoc_Run(2)+1:nTotalBin]);
outBaseSTIM_Run = rateMapRaw10_STIM_Run(:,[1:lightLoc_Run(1)-1,lightLoc_Run(2)+1:nTotalBin]);
outBasePOST_Run = rateMapRaw10_POST_Run(:,[1:lightLoc_Run(1)-1,lightLoc_Run(2)+1:nTotalBin]);

[rateMapLap_totalRun, rateMapLap_inRun, rateMapLap_outRun] = deal(cell(90,1));
for iLap = 1:90
    for iCell = 1:nPC_Run
        tempTotal(iCell,:) = rateMapRaw_Run{iCell}(iLap,:);
        tempInzone_Run(iCell,:) = rateMapRaw_Run{iCell}(iLap,lightLoc_Run(1):lightLoc_Run(2));
        tempOutzone_Run(iCell,:) = rateMapRaw_Run{iCell}(iLap,[1:lightLoc_Run(1)-1,lightLoc_Run(2)+1:nTotalBin]);
    end
    rateMapLap_totalRun{iLap} = tempTotal;
    rateMapLap_inRun{iLap} = tempInzone_Run;
    rateMapLap_outRun{iLap} = tempOutzone_Run;
end

%%%%%%% PV calculation %%%%%%%
% entire bin
[pv_tRun_basePRE, pv_tRun_baseSTIM, pv_tRun_basePOST] = deal(zeros(90,124));
for iLap = 1:90
    for iBin = 1:nTotalBin
        pv_tRun_basePRE(iLap,iBin) = corr(rateMapRaw10_PRE_Run(:,iBin),rateMapLap_totalRun{iLap}(:,iBin),'rows','complete','type','Pearson');
        pv_tRun_baseSTIM(iLap,iBin) = corr(rateMapRaw10_STIM_Run(:,iBin),rateMapLap_totalRun{iLap}(:,iBin),'rows','complete','type','Pearson');
        pv_tRun_basePOST(iLap,iBin) = corr(rateMapRaw10_POST_Run(:,iBin),rateMapLap_totalRun{iLap}(:,iBin),'rows','complete','type','Pearson');
    end
end

% In-zone bin
[pv_inRun_basePRE, pv_inRun_baseSTIM, pv_inRun_basePOST] = deal(zeros(90,nInBin_Run));
for iLap = 1:90
    for iCol = 1:nInBin_Run
        pv_inRun_basePRE(iLap,iCol) = corr(inBasePRE_Run(:,iCol), rateMapLap_inRun{iLap}(:,iCol),'rows','complete');
        pv_inRun_baseSTIM(iLap,iCol) = corr(inBaseSTIM_Run(:,iCol), rateMapLap_inRun{iLap}(:,iCol),'rows','complete');
        pv_inRun_basePOST(iLap,iCol) = corr(inBasePOST_Run(:,iCol), rateMapLap_inRun{iLap}(:,iCol),'rows','complete');
    end
end

% Out-zone bin
[pv_outRun_basePRE, pv_outRun_baseSTIM, pv_outRun_basePOST] = deal(zeros(90,1));
for iLap = 1:90
    for iCol = 1:nOutBin_Run
        pv_outRun_basePRE(iLap,iCol) = corr(outBasePRE_Run(:,iCol), rateMapLap_outRun{iLap}(:,iCol),'rows','complete');
        pv_outRun_baseSTIM(iLap,iCol) = corr(outBaseSTIM_Run(:,iCol), rateMapLap_outRun{iLap}(:,iCol),'rows','complete');
        pv_outRun_basePOST(iLap,iCol) = corr(outBasePOST_Run(:,iCol), rateMapLap_outRun{iLap}(:,iCol),'rows','complete');
    end
end

m_pv_tRun_basePRE = nanmean(pv_tRun_basePRE,2);
sem_pv_tRun_basePRE = nanstd(pv_tRun_basePRE,0,2)/sqrt(nTotalBin);
m_pv_tRun_baseSTIM = nanmean(pv_tRun_baseSTIM,2);
sem_pv_tRun_baseSTIM = nanstd(pv_tRun_baseSTIM,0,2)/sqrt(nTotalBin);
m_pv_tRun_basePOST = nanmean(pv_tRun_basePOST,2);
sem_pv_tRun_basePOST = nanstd(pv_tRun_basePOST,0,2)/sqrt(nTotalBin);

m_pv_inRun_basePRE = nanmean(pv_inRun_basePRE,2);
sem_pv_inRun_basePRE = nanstd(pv_inRun_basePRE,0,2)/sqrt(nInBin_Run);
m_pv_inRun_baseSTIM = nanmean(pv_inRun_baseSTIM,2);
sem_pv_inRun_baseSTIM = nanstd(pv_inRun_baseSTIM,0,2)/sqrt(nInBin_Run);
m_pv_inRun_basePOST = nanmean(pv_inRun_basePOST,2);
sem_pv_inRun_basePOST = nanstd(pv_inRun_basePOST,0,2)/sqrt(nInBin_Run);

m_pv_outRun_basePRE = nanmean(pv_outRun_basePRE,2);
sem_pv_outRun_basePRE = nanstd(pv_outRun_basePRE,0,2)/sqrt(nOutBin_Run);
m_pv_outRun_baseSTIM = nanmean(pv_outRun_baseSTIM,2);
sem_pv_outRun_baseSTIM = nanstd(pv_outRun_baseSTIM,0,2)/sqrt(nOutBin_Run);
m_pv_outRun_basePOST = nanmean(pv_outRun_basePOST,2);
sem_pv_outRun_basePOST = nanstd(pv_outRun_basePOST,0,2)/sqrt(nOutBin_Run);

%% Rw session
% tPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN';
% tPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
tPC_Rw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & cellfun(@(x) max(max(x)), T.pethconvSpatial)>cri_meanFR; % mean firing rate > 1hz
% tPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR;

nPC_Rw = sum(double(tPC_Rw));

rateMapRaw_Rw = T.rateMapRaw_eachLap(tPC_Rw);
rateMapRaw10_PRE_Rw = cell2mat(T.rateMapRaw10_PRE(tPC_Rw));
rateMapRaw10_STIM_Rw = cell2mat(T.rateMapRaw10_STIM(tPC_Rw));
rateMapRaw10_POST_Rw = cell2mat(T.rateMapRaw10_POST(tPC_Rw));

inBasePRE_Rw = rateMapRaw10_PRE_Rw(:,lightLoc_Rw(1):lightLoc_Rw(2));
inBaseSTIM_Rw = rateMapRaw10_STIM_Rw(:,lightLoc_Rw(1):lightLoc_Rw(2));
inBasePOST_Rw = rateMapRaw10_POST_Rw(:,lightLoc_Rw(1):lightLoc_Rw(2));

outBasePRE_Rw = rateMapRaw10_PRE_Rw(:,[1:lightLoc_Rw(1)-1,lightLoc_Rw(2)+1:nTotalBin]);
outBaseSTIM_Rw = rateMapRaw10_STIM_Rw(:,[1:lightLoc_Rw(1)-1,lightLoc_Rw(2)+1:nTotalBin]);
outBasePOST_Rw = rateMapRaw10_POST_Rw(:,[1:lightLoc_Rw(1)-1,lightLoc_Rw(2)+1:nTotalBin]);

[rateMapLap_totalRw, rateMapLap_inRw, rateMapLap_outRw] = deal(cell(90,1));
for iLap = 1:90
    for iCell = 1:nPC_Rw
        tempTotal(iCell,:) = rateMapRaw_Rw{iCell}(iLap,:);
        tempInzone_Rw(iCell,:) = rateMapRaw_Rw{iCell}(iLap,lightLoc_Rw(1):lightLoc_Rw(2));
        tempOutzone_Rw(iCell,:) = rateMapRaw_Rw{iCell}(iLap,[1:lightLoc_Rw(1)-1,lightLoc_Rw(2)+1:nTotalBin]);
    end
    rateMapLap_totalRw{iLap} = tempTotal;
    rateMapLap_inRw{iLap} = tempInzone_Rw;
    rateMapLap_outRw{iLap} = tempOutzone_Rw;
end

%%%%%%% PV calculation %%%%%%%
% entire bin
[pv_tRw_basePRE, pv_tRw_baseSTIM, pv_tRw_basePOST] = deal(zeros(90,124));
for iLap = 1:90
    for iBin = 1:nTotalBin
        pv_tRw_basePRE(iLap,iBin) = corr(rateMapRaw10_PRE_Rw(:,iBin),rateMapLap_totalRw{iLap}(:,iBin),'rows','complete','type','Pearson');
        pv_tRw_baseSTIM(iLap,iBin) = corr(rateMapRaw10_STIM_Rw(:,iBin),rateMapLap_totalRw{iLap}(:,iBin),'rows','complete','type','Pearson');
        pv_tRw_basePOST(iLap,iBin) = corr(rateMapRaw10_POST_Rw(:,iBin),rateMapLap_totalRw{iLap}(:,iBin),'rows','complete','type','Pearson');
    end
end

% In-zone bin
[pv_inRw_basePRE, pv_inRw_baseSTIM, pv_inRw_basePOST] = deal(zeros(90,nInBin_Rw));
for iLap = 1:90
    for iCol = 1:nInBin_Rw
        pv_inRw_basePRE(iLap,iCol) = corr(inBasePRE_Rw(:,iCol), rateMapLap_inRw{iLap}(:,iCol),'rows','complete');
        pv_inRw_baseSTIM(iLap,iCol) = corr(inBaseSTIM_Rw(:,iCol), rateMapLap_inRw{iLap}(:,iCol),'rows','complete');
        pv_inRw_basePOST(iLap,iCol) = corr(inBasePOST_Rw(:,iCol), rateMapLap_inRw{iLap}(:,iCol),'rows','complete');
    end
end

% Out-zone bin
[pv_outRw_basePRE, pv_outRw_baseSTIM, pv_outRw_basePOST] = deal(zeros(90,1));
for iLap = 1:90
    for iCol = 1:nOutBin_Rw
        pv_outRw_basePRE(iLap,iCol) = corr(outBasePRE_Rw(:,iCol), rateMapLap_outRw{iLap}(:,iCol),'rows','complete');
        pv_outRw_baseSTIM(iLap,iCol) = corr(outBaseSTIM_Rw(:,iCol), rateMapLap_outRw{iLap}(:,iCol),'rows','complete');
        pv_outRw_basePOST(iLap,iCol) = corr(outBasePOST_Rw(:,iCol), rateMapLap_outRw{iLap}(:,iCol),'rows','complete');
    end
end

m_pv_tRw_basePRE = nanmean(pv_tRw_basePRE,2);
sem_pv_tRw_basePRE = nanstd(pv_tRw_basePRE,0,2)/sqrt(nTotalBin);
m_pv_tRw_baseSTIM = nanmean(pv_tRw_baseSTIM,2);
sem_pv_tRw_baseSTIM = nanstd(pv_tRw_baseSTIM,0,2)/sqrt(nTotalBin);
m_pv_tRw_basePOST = nanmean(pv_tRw_basePOST,2);
sem_pv_tRw_basePOST = nanstd(pv_tRw_basePOST,0,2)/sqrt(nTotalBin);

m_pv_inRw_basePRE = nanmean(pv_inRw_basePRE,2);
sem_pv_inRw_basePRE = nanstd(pv_inRw_basePRE,0,2)/sqrt(nInBin_Rw);
m_pv_inRw_baseSTIM = nanmean(pv_inRw_baseSTIM,2);
sem_pv_inRw_baseSTIM = nanstd(pv_inRw_baseSTIM,0,2)/sqrt(nInBin_Rw);
m_pv_inRw_basePOST = nanmean(pv_inRw_basePOST,2);
sem_pv_inRw_basePOST = nanstd(pv_inRw_basePOST,0,2)/sqrt(nInBin_Rw);

m_pv_outRw_basePRE = nanmean(pv_outRw_basePRE,2);
sem_pv_outRw_basePRE = nanstd(pv_outRw_basePRE,0,2)/sqrt(nOutBin_Rw);
m_pv_outRw_baseSTIM = nanmean(pv_outRw_baseSTIM,2);
sem_pv_outRw_baseSTIM = nanstd(pv_outRw_baseSTIM,0,2)/sqrt(nOutBin_Rw);
m_pv_outRw_basePOST = nanmean(pv_outRw_basePOST,2);
sem_pv_outRw_basePOST = nanstd(pv_outRw_basePOST,0,2)/sqrt(nOutBin_Rw);

%% noLight 
% load('neuronList_ori_171205.mat');
% load('neuronList_ori_171229.mat');
load('neuronList_ori_180123.mat');
% load('neuronList_ori_171219_2cm.mat');
% load('neuronList_ori_171219_4cm.mat');

%%%% noRun %%%%
% tPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN';
% tPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
tPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & cellfun(@(x) max(max(x)), T.pethconvSpatial)>cri_meanFR; % mean firing rate > 1hz
% tPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR;

nPC_noRun = sum(double(tPC_noRun));

% corr of total neurons
rateMapRaw_noRun = T.rateMapRaw_eachLap(tPC_noRun);
rateMapRaw10_PRE_noRun = cell2mat(T.rateMapRaw10_PRE(tPC_noRun));
rateMapRaw10_STIM_noRun = cell2mat(T.rateMapRaw10_STIM(tPC_noRun));
rateMapRaw10_POST_noRun = cell2mat(T.rateMapRaw10_POST(tPC_noRun));

inBasePRE_noRun = rateMapRaw10_PRE_noRun(:,lightLoc_Run(1):lightLoc_Run(2));
inBaseSTIM_noRun = rateMapRaw10_STIM_noRun(:,lightLoc_Run(1):lightLoc_Run(2));
inBasePOST_noRun = rateMapRaw10_POST_noRun(:,lightLoc_Run(1):lightLoc_Run(2));

outBasePRE_noRun = rateMapRaw10_PRE_noRun(:,[1:lightLoc_Run(1)-1,lightLoc_Run(2)+1:nTotalBin]);
outBaseSTIM_noRun = rateMapRaw10_STIM_noRun(:,[1:lightLoc_Run(1)-1,lightLoc_Run(2)+1:nTotalBin]);
outBasePOST_noRun = rateMapRaw10_POST_noRun(:,[1:lightLoc_Run(1)-1,lightLoc_Run(2)+1:nTotalBin]);

[rateMapLap_totalnoRun, rateMapLap_innoRun, rateMapLap_outnoRun] = deal(cell(90,1));
for iLap = 1:90
    for iCell = 1:nPC_noRun
        tempTotal(iCell,:) = rateMapRaw_noRun{iCell}(iLap,:);
        tempInzone_noRun(iCell,:) = rateMapRaw_noRun{iCell}(iLap,lightLoc_Run(1):lightLoc_Run(2));
        tempOutzone_noRun(iCell,:) = rateMapRaw_noRun{iCell}(iLap,[1:lightLoc_Run(1)-1,lightLoc_Run(2)+1:nTotalBin]);
    end
    rateMapLap_totalnoRun{iLap} = tempTotal;
    rateMapLap_innoRun{iLap} = tempInzone_noRun;
    rateMapLap_outnoRun{iLap} = tempOutzone_noRun;
end

%%%%%%% PV calculation %%%%%%%
% entire bin
[pv_tnoRun_basePRE, pv_tnoRun_baseSTIM, pv_tnoRun_basePOST] = deal(zeros(90,124));
for iLap = 1:90
    for iBin = 1:nTotalBin
        pv_tnoRun_basePRE(iLap,iBin) = corr(rateMapRaw10_PRE_noRun(:,iBin),rateMapLap_totalnoRun{iLap}(:,iBin),'rows','complete','type','Pearson');
        pv_tnoRun_baseSTIM(iLap,iBin) = corr(rateMapRaw10_STIM_noRun(:,iBin),rateMapLap_totalnoRun{iLap}(:,iBin),'rows','complete','type','Pearson');
        pv_tnoRun_basePOST(iLap,iBin) = corr(rateMapRaw10_POST_noRun(:,iBin),rateMapLap_totalnoRun{iLap}(:,iBin),'rows','complete','type','Pearson');
    end
end

% In-zone bin
[pv_innoRun_basePRE, pv_innoRun_baseSTIM, pv_innoRun_basePOST] = deal(zeros(90,nInBin_Run));
for iLap = 1:90
    for iCol = 1:nInBin_Run
        pv_innoRun_basePRE(iLap,iCol) = corr(inBasePRE_noRun(:,iCol), rateMapLap_innoRun{iLap}(:,iCol),'rows','complete');
        pv_innoRun_baseSTIM(iLap,iCol) = corr(inBaseSTIM_noRun(:,iCol), rateMapLap_innoRun{iLap}(:,iCol),'rows','complete');
        pv_innoRun_basePOST(iLap,iCol) = corr(inBasePOST_noRun(:,iCol), rateMapLap_innoRun{iLap}(:,iCol),'rows','complete');
    end
end

% Out-zone bin
[pv_outnoRun_basePRE, pv_outnoRun_baseSTIM, pv_outnoRun_basePOST] = deal(zeros(90,nOutBin_Run));
for iLap = 1:90
    for iCol = 1:nOutBin_Run
        pv_outnoRun_basePRE(iLap,iCol) = corr(outBasePRE_noRun(:,iCol), rateMapLap_outnoRun{iLap}(:,iCol),'rows','complete');
        pv_outnoRun_baseSTIM(iLap,iCol) = corr(outBaseSTIM_noRun(:,iCol), rateMapLap_outnoRun{iLap}(:,iCol),'rows','complete');
        pv_outnoRun_basePOST(iLap,iCol) = corr(outBasePOST_noRun(:,iCol), rateMapLap_outnoRun{iLap}(:,iCol),'rows','complete');
    end
end

m_pv_tnoRun_basePRE = nanmean(pv_tnoRun_basePRE,2);
sem_pv_tnoRun_basePRE = nanstd(pv_tnoRun_basePRE,0,2)/sqrt(nTotalBin);
m_pv_tnoRun_baseSTIM = nanmean(pv_tnoRun_baseSTIM,2);
sem_pv_tnoRun_baseSTIM = nanstd(pv_tnoRun_baseSTIM,0,2)/sqrt(nTotalBin);
m_pv_tnoRun_basePOST = nanmean(pv_tnoRun_basePOST,2);
sem_pv_tnoRun_basePOST = nanstd(pv_tnoRun_basePOST,0,2)/sqrt(nTotalBin);

m_pv_innoRun_basePRE = nanmean(pv_innoRun_basePRE,2);
sem_pv_innoRun_basePRE = nanstd(pv_innoRun_basePRE,0,2)/sqrt(nInBin_Run);
m_pv_innoRun_baseSTIM = nanmean(pv_innoRun_baseSTIM,2);
sem_pv_innoRun_baseSTIM = nanstd(pv_innoRun_baseSTIM,0,2)/sqrt(nInBin_Run);
m_pv_innoRun_basePOST = nanmean(pv_innoRun_basePOST,2);
sem_pv_innoRun_basePOST = nanstd(pv_innoRun_basePOST,0,2)/sqrt(nInBin_Run);

m_pv_outnoRun_basePRE = nanmean(pv_outnoRun_basePRE,2);
sem_pv_outnoRun_basePRE = nanstd(pv_outnoRun_basePRE,0,2)/sqrt(nOutBin_Run);
m_pv_outnoRun_baseSTIM = nanmean(pv_outnoRun_baseSTIM,2);
sem_pv_outnoRun_baseSTIM = nanstd(pv_outnoRun_baseSTIM,0,2)/sqrt(nOutBin_Run);
m_pv_outnoRun_basePOST = nanmean(pv_outnoRun_basePOST,2);
sem_pv_outnoRun_basePOST = nanstd(pv_outnoRun_basePOST,0,2)/sqrt(nOutBin_Run);


%%%% noRw %%%%
% tPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN';
% tPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
tPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & cellfun(@(x) max(max(x)), T.pethconvSpatial)>cri_meanFR; % mean firing rate > 1hz
% tPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR;

nPC_noRw = sum(double(tPC_noRw));

% corr of total neurons
rateMapRaw_noRw = T.rateMapRaw_eachLap(tPC_noRw);
rateMapRaw10_PRE_noRw = cell2mat(T.rateMapRaw10_PRE(tPC_noRw));
rateMapRaw10_STIM_noRw = cell2mat(T.rateMapRaw10_STIM(tPC_noRw));
rateMapRaw10_POST_noRw = cell2mat(T.rateMapRaw10_POST(tPC_noRw));

inBasePRE_noRw = rateMapRaw10_PRE_noRw(:,lightLoc_Rw(1):lightLoc_Rw(2));
inBaseSTIM_noRw = rateMapRaw10_STIM_noRw(:,lightLoc_Rw(1):lightLoc_Rw(2));
inBasePOST_noRw = rateMapRaw10_POST_noRw(:,lightLoc_Rw(1):lightLoc_Rw(2));

outBasePRE_noRw = rateMapRaw10_PRE_noRw(:,[1:lightLoc_Rw(1)-1,lightLoc_Rw(2)+1:nTotalBin]);
outBaseSTIM_noRw = rateMapRaw10_STIM_noRw(:,[1:lightLoc_Rw(1)-1,lightLoc_Rw(2)+1:nTotalBin]);
outBasePOST_noRw = rateMapRaw10_POST_noRw(:,[1:lightLoc_Rw(1)-1,lightLoc_Rw(2)+1:nTotalBin]);

[rateMapLap_totalnoRw, rateMapLap_innoRw, rateMapLap_outnoRw] = deal(cell(90,1));
for iLap = 1:90
    for iCell = 1:nPC_noRw
        tempTotal(iCell,:) = rateMapRaw_noRw{iCell}(iLap,:);
        tempInzone_noRw(iCell,:) = rateMapRaw_noRw{iCell}(iLap,lightLoc_Rw(1):lightLoc_Rw(2));
        tempOutzone_noRw(iCell,:) = rateMapRaw_noRw{iCell}(iLap,[1:lightLoc_Rw(1)-1,lightLoc_Rw(2)+1:nTotalBin]);
    end
    rateMapLap_totalnoRw{iLap} = tempTotal;
    rateMapLap_innoRw{iLap} = tempInzone_noRw;
    rateMapLap_outnoRw{iLap} = tempOutzone_noRw;
end

%%%%%%% PV calculation %%%%%%%
% entire bin
[pv_tnoRw_basePRE, pv_tnoRw_baseSTIM, pv_tnoRw_basePOST] = deal(zeros(90,124));
for iLap = 1:90
    for iBin = 1:nTotalBin
        pv_tnoRw_basePRE(iLap,iBin) = corr(rateMapRaw10_PRE_noRw(:,iBin),rateMapLap_totalnoRw{iLap}(:,iBin),'rows','complete','type','Pearson');
        pv_tnoRw_baseSTIM(iLap,iBin) = corr(rateMapRaw10_STIM_noRw(:,iBin),rateMapLap_totalnoRw{iLap}(:,iBin),'rows','complete','type','Pearson');
        pv_tnoRw_basePOST(iLap,iBin) = corr(rateMapRaw10_POST_noRw(:,iBin),rateMapLap_totalnoRw{iLap}(:,iBin),'rows','complete','type','Pearson');
    end
end

% In-zone bin
[pv_innoRw_basePRE, pv_innoRw_baseSTIM, pv_innoRw_basePOST] = deal(zeros(90,nInBin_Rw));
for iLap = 1:90
    for iCol = 1:nInBin_Rw
        pv_innoRw_basePRE(iLap,iCol) = corr(inBasePRE_noRw(:,iCol), rateMapLap_innoRw{iLap}(:,iCol),'rows','complete');
        pv_innoRw_baseSTIM(iLap,iCol) = corr(inBaseSTIM_noRw(:,iCol), rateMapLap_innoRw{iLap}(:,iCol),'rows','complete');
        pv_innoRw_basePOST(iLap,iCol) = corr(inBasePOST_noRw(:,iCol), rateMapLap_innoRw{iLap}(:,iCol),'rows','complete');
    end
end

% Out-zone bin
[pv_outnoRw_basePRE, pv_outnoRw_baseSTIM, pv_outnoRw_basePOST] = deal(zeros(90,nOutBin_Rw));
for iLap = 1:90
    for iCol = 1:nOutBin_Rw
        pv_outnoRw_basePRE(iLap,iCol) = corr(outBasePRE_noRw(:,iCol), rateMapLap_outnoRw{iLap}(:,iCol),'rows','complete');
        pv_outnoRw_baseSTIM(iLap,iCol) = corr(outBaseSTIM_noRw(:,iCol), rateMapLap_outnoRw{iLap}(:,iCol),'rows','complete');
        pv_outnoRw_basePOST(iLap,iCol) = corr(outBasePOST_noRw(:,iCol), rateMapLap_outnoRw{iLap}(:,iCol),'rows','complete');
    end
end

m_pv_tnoRw_basePRE = nanmean(pv_tnoRw_basePRE,2);
sem_pv_tnoRw_basePRE = nanstd(pv_tnoRw_basePRE,0,2)/sqrt(nTotalBin);
m_pv_tnoRw_baseSTIM = nanmean(pv_tnoRw_baseSTIM,2);
sem_pv_tnoRw_baseSTIM = nanstd(pv_tnoRw_baseSTIM,0,2)/sqrt(nTotalBin);
m_pv_tnoRw_basePOST = nanmean(pv_tnoRw_basePOST,2);
sem_pv_tnoRw_basePOST = nanstd(pv_tnoRw_basePOST,0,2)/sqrt(nTotalBin);

m_pv_innoRw_basePRE = nanmean(pv_innoRw_basePRE,2);
sem_pv_innoRw_basePRE = nanstd(pv_innoRw_basePRE,0,2)/sqrt(nInBin_Rw);
m_pv_innoRw_baseSTIM = nanmean(pv_innoRw_baseSTIM,2);
sem_pv_innoRw_baseSTIM = nanstd(pv_innoRw_baseSTIM,0,2)/sqrt(nInBin_Rw);
m_pv_innoRw_basePOST = nanmean(pv_innoRw_basePOST,2);
sem_pv_innoRw_basePOST = nanstd(pv_innoRw_basePOST,0,2)/sqrt(nInBin_Rw);

m_pv_outnoRw_basePRE = nanmean(pv_outnoRw_basePRE,2);
sem_pv_outnoRw_basePRE = nanstd(pv_outnoRw_basePRE,0,2)/sqrt(nOutBin_Rw);
m_pv_outnoRw_baseSTIM = nanmean(pv_outnoRw_baseSTIM,2);
sem_pv_outnoRw_baseSTIM = nanstd(pv_outnoRw_baseSTIM,0,2)/sqrt(nOutBin_Rw);
m_pv_outnoRw_basePOST = nanmean(pv_outnoRw_basePOST,2);
sem_pv_outnoRw_basePOST = nanstd(pv_outnoRw_basePOST,0,2)/sqrt(nOutBin_Rw);
%% statistic


%% plot
nCol = 2;
nRow = 1;
xpt = 1:90;
fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});

hPlot(1) = axes('Position',axpt(3,3,1,1,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch([xpt, fliplr(xpt)],[m_pv_inRun_basePRE-sem_pv_inRun_basePRE;m_pv_inRun_basePRE+sem_pv_inRun_basePRE],colorBlue,'LineStyle','none');

hPlot(2) = axes('Position',axpt(3,3,1,2,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));

hPlot(3) = axes('Position',axpt(3,3,1,3,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));

hPlot(4) = axes('Position',axpt(3,3,2,1,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));

hPlot(5) = axes('Position',axpt(3,3,2,2,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));

hPlot(6) = axes('Position',axpt(3,3,2,3,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));

hPlot(7) = axes('Position',axpt(3,3,3,1,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));

hPlot(8) = axes('Position',axpt(3,3,3,2,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));

hPlot(9) = axes('Position',axpt(3,3,3,3,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));

bar([1,2,3],m_pvCorr_inlight_Run,barWidth,'faceColor',colorLLightBlue);
hold on;
errorbarJun([1,2,3],m_pvCorr_inlight_Run,sem_pvCorr_inlight_Run,0.3,1.0,colorBlack);
hold on;
bar([5,6,7],m_pvCorr_outlight_Run,barWidth,'faceColor',colorLightGray)
hold on;
errorbarJun([5,6,7],m_pvCorr_outlight_Run,sem_pvCorr_inlight_Run,0.3,1.0,colorBlack);
hold on;
bar([9,10,11],m_pvCorr_noRun,barWidth,'faceColor',colorDarkGray)
hold on;
errorbarJun([9,10,11],m_pvCorr_noRun,sem_pvCorr_noRun,0.3,1.0,colorBlack);
hold on;

plot(1+xScatterRunIn, pvCorr_inRun_preXstm, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(2+xScatterRunIn, pvCorr_inRun_preXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(3+xScatterRunIn, pvCorr_inRun_stmXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;

plot(5+xScatterRunOut, pvCorr_outRun_preXstm, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(6+xScatterRunOut, pvCorr_outRun_preXpost,'.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(7+xScatterRunOut, pvCorr_outRun_stmXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;

plot(9+xScatterTotal, pvCorr_noRun_preXstm, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(10+xScatterTotal, pvCorr_noRun_preXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(11+xScatterTotal, pvCorr_noRun_stmXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;

title('Run','fontSize',fontM);
ylabel('PV correlation','fontSize',fontM);

text(0.5, -1.9,['p12 = ',num2str(p_Run(1,1),3)],'fontSize',fontM,'color',colorBlack);
text(0.5, -2.1,['p13 = ',num2str(p_Run(2,1),3)],'fontSize',fontM,'color',colorBlack);
text(0.5, -2.3,['p23 = ',num2str(p_Run(3,1),3)],'fontSize',fontM,'color',colorBlack);

text(5.5, -1.9,[num2str(p_Run(1,2),3)],'fontSize',fontM,'color',colorBlack);
text(5.5, -2.1,[num2str(p_Run(2,2),3)],'fontSize',fontM,'color',colorBlack);
text(5.5, -2.3,[num2str(p_Run(3,2),3)],'fontSize',fontM,'color',colorBlack);

text(9.5, -1.9,[num2str(p_Run(1,3),3)],'fontSize',fontM,'color',colorBlack);
text(9.5, -2.1,[num2str(p_Run(2,3),3)],'fontSize',fontM,'color',colorBlack);
text(9.5, -2.3,[num2str(p_Run(3,3),3)],'fontSize',fontM,'color',colorBlack);


hPlot(2) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,2,1,[0.15 0.1 0.85 0.85],midInterval),wideInterval));
bar([1,2,3],m_pvCorr_inlight_Rw,barWidth,'faceColor',colorLLightBlue);
hold on;
errorbarJun([1,2,3],m_pvCorr_inlight_Rw,sem_pvCorr_inlight_Rw,0.3,1.0,colorBlack);
hold on;
bar([5,6,7],m_pvCorr_outlight_Rw,barWidth,'faceColor',colorLightGray)
hold on;
errorbarJun([5,6,7],m_pvCorr_outlight_Rw,sem_pvCorr_inlight_Run,0.3,1.0,colorBlack);
hold on;
bar([9,10,11],m_pvCorr_noRw,barWidth,'faceColor',colorDarkGray)
hold on;
errorbarJun([9,10,11],m_pvCorr_noRw,sem_pvCorr_noRw,0.3,1.0,colorBlack);
hold on;

plot(1+xScatterRwIn, pvCorr_inRw_preXstm, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(2+xScatterRwIn, pvCorr_inRw_preXpost,'.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(3+xScatterRwIn, pvCorr_inRw_stmXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;

plot(5+xScatterRwOut, pvCorr_outRw_preXstm, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(6+xScatterRwOut, pvCorr_outRw_preXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(7+xScatterRwOut, pvCorr_outRw_stmXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;

plot(9+xScatterTotal, pvCorr_noRw_preXstm, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(10+xScatterTotal, pvCorr_noRw_preXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(11+xScatterTotal, pvCorr_noRw_stmXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
 
title('Rw','fontSize',fontM);
ylabel('PV correlation','fontSize',fontM);

text(0.5, -1.9,['p12 = ',num2str(p_Rw(1,1),3)],'fontSize',fontM,'color',colorBlack);
text(0.5, -2.1,['p13 = ',num2str(p_Rw(2,1),3)],'fontSize',fontM,'color',colorBlack);
text(0.5, -2.3,['p23 = ',num2str(p_Rw(3,1),3)],'fontSize',fontM,'color',colorBlack);

text(5.5, -1.9,[num2str(p_Rw(1,2),3)],'fontSize',fontM,'color',colorBlack);
text(5.5, -2.1,[num2str(p_Rw(2,2),3)],'fontSize',fontM,'color',colorBlack);
text(5.5, -2.3,[num2str(p_Rw(3,2),3)],'fontSize',fontM,'color',colorBlack);

text(9.5, -1.9,[num2str(p_Rw(1,3),3)],'fontSize',fontM,'color',colorBlack);
text(9.5, -2.1,[num2str(p_Rw(2,3),3)],'fontSize',fontM,'color',colorBlack);
text(9.5, -2.3,[num2str(p_Rw(3,3),3)],'fontSize',fontM,'color',colorBlack);

set(hPlot(1),'TickDir','out','Box','off','XLim',[0,12],'YLim',[-1.15 1.15],'XTick',[2, 6, 10],'XTickLabel',[{'In-zone','Out-zone','Control'}],'fontSize',fontM);
set(hPlot(2),'TickDir','out','Box','off','XLim',[0,12],'YLim',[-1.15 1.15],'XTick',[2, 6, 10],'XTickLabel',[{'In-zone','Out-zone','Control'}],'fontSize',fontM);
set(hPlot,'TickLength',[0.03, 0.03]);
 
print('-painters','-r300','-dtiff',['f_Neuron_PVCorr_',datestr(now,formatOut),'_50Hz_zone','.tif']);
% print('-painters','-r300','-depsc',['f_CellRepors_PVCorr_8Hz_',datestr(now,formatOut),'.ai']);
% close;