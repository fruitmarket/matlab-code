clearvars;
cd('D:\Dropbox\SNL\P2_Track');

load('D:\Dropbox\SNL\P2_Track\myParameters.mat');
formatOut = 'yymmdd';

markerS = 1.5;
dotS = 4;

% 1cm win
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


%%
% load('neuronList_ori50hz_171229.mat');
load('neuronList_ori50hz_180123.mat');
cri_meanFR = 1;
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

% normalize
% rateMapRaw10_PRE_Run = rateMapRaw10_PRE_Run./repmat(max(rateMapRaw10_PRE_Run,[],2),1,nTotalBin);
% rateMapRaw10_STIM_Run = rateMapRaw10_STIM_Run./repmat(max(rateMapRaw10_STIM_Run,[],2),1,nTotalBin);
% rateMapRaw10_POST_Run = rateMapRaw10_POST_Run./repmat(max(rateMapRaw10_POST_Run,[],2),1,nTotalBin);

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
%         rateMapRaw_Run{iCell} = rateMapRaw_Run{iCell}./repmat(max(rateMapRaw_Run{iCell},[],2),1,nTotalBin);
        tempTotal(iCell,:) = rateMapRaw_Run{iCell}(iLap,:);
        tempInzone_Run(iCell,:) = rateMapRaw_Run{iCell}(iLap,lightLoc_Run(1):lightLoc_Run(2));
        tempOutzone_Run(iCell,:) = rateMapRaw_Run{iCell}(iLap,[1:lightLoc_Run(1)-1,lightLoc_Run(2)+1:nTotalBin]);
    end
    rateMapLap_totalRun{iLap} = tempTotal;
    rateMapLap_inRun{iLap} = tempInzone_Run;
    rateMapLap_outRun{iLap} = tempOutzone_Run;
end

% Rw session
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


% load('neuronList_ori_171205.mat');
% load('neuronList_ori_171229.mat');
load('neuronList_ori_180123.mat');

%%% noRun %%%%
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

% PV calculation %%
% entire bin
[pv_tRun_basePRE, pv_tRun_baseSTIM, pv_tRun_basePOST] = deal(zeros(90,124));
[pv_tRw_basePRE, pv_tRw_baseSTIM, pv_tRw_basePOST] = deal(zeros(90,124));
[pv_tnoRun_basePRE, pv_tnoRun_baseSTIM, pv_tnoRun_basePOST] = deal(zeros(90,124));
[pv_tnoRw_basePRE, pv_tnoRw_baseSTIM, pv_tnoRw_basePOST] = deal(zeros(90,124));

for iLap = 1:90
    for iBin = 1:nTotalBin
        pv_tRun_basePRE(iLap,iBin) = corr(rateMapRaw10_PRE_Run(:,iBin),rateMapLap_totalRun{iLap}(:,iBin),'rows','complete','type','Pearson');
        pv_tRun_baseSTIM(iLap,iBin) = corr(rateMapRaw10_STIM_Run(:,iBin),rateMapLap_totalRun{iLap}(:,iBin),'rows','complete','type','Pearson');
        pv_tRun_basePOST(iLap,iBin) = corr(rateMapRaw10_POST_Run(:,iBin),rateMapLap_totalRun{iLap}(:,iBin),'rows','complete','type','Pearson');
        
        pv_tRw_basePRE(iLap,iBin) = corr(rateMapRaw10_PRE_Rw(:,iBin),rateMapLap_totalRw{iLap}(:,iBin),'rows','complete','type','Pearson');
        pv_tRw_baseSTIM(iLap,iBin) = corr(rateMapRaw10_STIM_Rw(:,iBin),rateMapLap_totalRw{iLap}(:,iBin),'rows','complete','type','Pearson');
        pv_tRw_basePOST(iLap,iBin) = corr(rateMapRaw10_POST_Rw(:,iBin),rateMapLap_totalRw{iLap}(:,iBin),'rows','complete','type','Pearson');
        
        pv_tnoRun_basePRE(iLap,iBin) = corr(rateMapRaw10_PRE_noRun(:,iBin),rateMapLap_totalnoRun{iLap}(:,iBin),'rows','complete','type','Pearson');
        pv_tnoRun_baseSTIM(iLap,iBin) = corr(rateMapRaw10_STIM_noRun(:,iBin),rateMapLap_totalnoRun{iLap}(:,iBin),'rows','complete','type','Pearson');
        pv_tnoRun_basePOST(iLap,iBin) = corr(rateMapRaw10_POST_noRun(:,iBin),rateMapLap_totalnoRun{iLap}(:,iBin),'rows','complete','type','Pearson');
        
        pv_tnoRw_basePRE(iLap,iBin) = corr(rateMapRaw10_PRE_noRw(:,iBin),rateMapLap_totalnoRw{iLap}(:,iBin),'rows','complete','type','Pearson');
        pv_tnoRw_baseSTIM(iLap,iBin) = corr(rateMapRaw10_STIM_noRw(:,iBin),rateMapLap_totalnoRw{iLap}(:,iBin),'rows','complete','type','Pearson');
        pv_tnoRw_basePOST(iLap,iBin) = corr(rateMapRaw10_POST_noRw(:,iBin),rateMapLap_totalnoRw{iLap}(:,iBin),'rows','complete','type','Pearson');
    end
end

% In-zone bin
[pv_inRun_basePRE, pv_inRun_baseSTIM, pv_inRun_basePOST] = deal(zeros(90,nInBin_Run));
[pv_outRun_basePRE, pv_outRun_baseSTIM, pv_outRun_basePOST] = deal(zeros(90,1));
[pv_inRw_basePRE, pv_inRw_baseSTIM, pv_inRw_basePOST] = deal(zeros(90,nInBin_Rw));
[pv_outRw_basePRE, pv_outRw_baseSTIM, pv_outRw_basePOST] = deal(zeros(90,1));
[pv_innoRun_basePRE, pv_innoRun_baseSTIM, pv_innoRun_basePOST] = deal(zeros(90,nInBin_Run));
[pv_outnoRun_basePRE, pv_outnoRun_baseSTIM, pv_outnoRun_basePOST] = deal(zeros(90,nOutBin_Run));
[pv_innoRw_basePRE, pv_innoRw_baseSTIM, pv_innoRw_basePOST] = deal(zeros(90,nInBin_Rw));
[pv_outnoRw_basePRE, pv_outnoRw_baseSTIM, pv_outnoRw_basePOST] = deal(zeros(90,nOutBin_Rw));

for iLap = 1:90
    for iCol = 1:nInBin_Run
        pv_inRun_basePRE(iLap,iCol) = corr(inBasePRE_Run(:,iCol), rateMapLap_inRun{iLap}(:,iCol),'rows','complete');
        pv_inRun_baseSTIM(iLap,iCol) = corr(inBaseSTIM_Run(:,iCol), rateMapLap_inRun{iLap}(:,iCol),'rows','complete');
        pv_inRun_basePOST(iLap,iCol) = corr(inBasePOST_Run(:,iCol), rateMapLap_inRun{iLap}(:,iCol),'rows','complete');
    end
    
    for iCol = 1:nOutBin_Run
        pv_outRun_basePRE(iLap,iCol) = corr(outBasePRE_Run(:,iCol), rateMapLap_outRun{iLap}(:,iCol),'rows','complete');
        pv_outRun_baseSTIM(iLap,iCol) = corr(outBaseSTIM_Run(:,iCol), rateMapLap_outRun{iLap}(:,iCol),'rows','complete');
        pv_outRun_basePOST(iLap,iCol) = corr(outBasePOST_Run(:,iCol), rateMapLap_outRun{iLap}(:,iCol),'rows','complete');
    end
    
    for iCol = 1:nInBin_Rw
        pv_inRw_basePRE(iLap,iCol) = corr(inBasePRE_Rw(:,iCol), rateMapLap_inRw{iLap}(:,iCol),'rows','complete');
        pv_inRw_baseSTIM(iLap,iCol) = corr(inBaseSTIM_Rw(:,iCol), rateMapLap_inRw{iLap}(:,iCol),'rows','complete');
        pv_inRw_basePOST(iLap,iCol) = corr(inBasePOST_Rw(:,iCol), rateMapLap_inRw{iLap}(:,iCol),'rows','complete');
    end
    
    for iCol = 1:nOutBin_Rw
        pv_outRw_basePRE(iLap,iCol) = corr(outBasePRE_Rw(:,iCol), rateMapLap_outRw{iLap}(:,iCol),'rows','complete');
        pv_outRw_baseSTIM(iLap,iCol) = corr(outBaseSTIM_Rw(:,iCol), rateMapLap_outRw{iLap}(:,iCol),'rows','complete');
        pv_outRw_basePOST(iLap,iCol) = corr(outBasePOST_Rw(:,iCol), rateMapLap_outRw{iLap}(:,iCol),'rows','complete');
    end
    
    for iCol = 1:nInBin_Run
        pv_innoRun_basePRE(iLap,iCol) = corr(inBasePRE_noRun(:,iCol), rateMapLap_innoRun{iLap}(:,iCol),'rows','complete');
        pv_innoRun_baseSTIM(iLap,iCol) = corr(inBaseSTIM_noRun(:,iCol), rateMapLap_innoRun{iLap}(:,iCol),'rows','complete');
        pv_innoRun_basePOST(iLap,iCol) = corr(inBasePOST_noRun(:,iCol), rateMapLap_innoRun{iLap}(:,iCol),'rows','complete');
    end
    
    for iCol = 1:nOutBin_Run
        pv_outnoRun_basePRE(iLap,iCol) = corr(outBasePRE_noRun(:,iCol), rateMapLap_outnoRun{iLap}(:,iCol),'rows','complete');
        pv_outnoRun_baseSTIM(iLap,iCol) = corr(outBaseSTIM_noRun(:,iCol), rateMapLap_outnoRun{iLap}(:,iCol),'rows','complete');
        pv_outnoRun_basePOST(iLap,iCol) = corr(outBasePOST_noRun(:,iCol), rateMapLap_outnoRun{iLap}(:,iCol),'rows','complete');
    end
    
    for iCol = 1:nInBin_Rw
        pv_innoRw_basePRE(iLap,iCol) = corr(inBasePRE_noRw(:,iCol), rateMapLap_innoRw{iLap}(:,iCol),'rows','complete');
        pv_innoRw_baseSTIM(iLap,iCol) = corr(inBaseSTIM_noRw(:,iCol), rateMapLap_innoRw{iLap}(:,iCol),'rows','complete');
        pv_innoRw_basePOST(iLap,iCol) = corr(inBasePOST_noRw(:,iCol), rateMapLap_innoRw{iLap}(:,iCol),'rows','complete');
    end
    
    for iCol = 1:nOutBin_Rw
        pv_outnoRw_basePRE(iLap,iCol) = corr(outBasePRE_noRw(:,iCol), rateMapLap_outnoRw{iLap}(:,iCol),'rows','complete');
        pv_outnoRw_baseSTIM(iLap,iCol) = corr(outBaseSTIM_noRw(:,iCol), rateMapLap_outnoRw{iLap}(:,iCol),'rows','complete');
        pv_outnoRw_basePOST(iLap,iCol) = corr(outBasePOST_noRw(:,iCol), rateMapLap_outnoRw{iLap}(:,iCol),'rows','complete');
    end
end

%% save variables
save('pvValue50hz.mat',...
    'pv_tRun_basePRE', 'pv_tRun_baseSTIM', 'pv_tRun_basePOST', 'pv_tRw_basePRE', 'pv_tRw_baseSTIM', 'pv_tRw_basePOST',...
    'pv_tnoRun_basePRE', 'pv_tnoRun_baseSTIM', 'pv_tnoRun_basePOST', 'pv_tnoRw_basePRE', 'pv_tnoRw_baseSTIM', 'pv_tnoRw_basePOST',...
    'pv_inRun_basePRE', 'pv_inRun_baseSTIM', 'pv_inRun_basePOST', 'pv_outRun_basePRE', 'pv_outRun_baseSTIM', 'pv_outRun_basePOST',...
    'pv_inRw_basePRE', 'pv_inRw_baseSTIM', 'pv_inRw_basePOST', 'pv_outRw_basePRE', 'pv_outRw_baseSTIM', 'pv_outRw_basePOST',... 
    'pv_innoRun_basePRE', 'pv_innoRun_baseSTIM', 'pv_innoRun_basePOST', 'pv_outnoRun_basePRE', 'pv_outnoRun_baseSTIM', 'pv_outnoRun_basePOST',...
    'pv_innoRw_basePRE', 'pv_innoRw_baseSTIM', 'pv_innoRw_basePOST', 'pv_outnoRw_basePRE', 'pv_outnoRw_baseSTIM', 'pv_outnoRw_basePOST')

%% mean % sem calculation
load('pvValue50hz.mat');
% Run session
m_pv_tRun_basePRE = nanmean(pv_tRun_basePRE,2);
sem_pv_tRun_basePRE = nanstd(pv_tRun_basePRE,0,2)./sum(double(~isnan(pv_tRun_basePRE)),2);
m_pv_tRun_baseSTIM = nanmean(pv_tRun_baseSTIM,2);
sem_pv_tRun_baseSTIM = nanstd(pv_tRun_baseSTIM,0,2)./sum(double(~isnan(pv_tRun_baseSTIM)),2);
m_pv_tRun_basePOST = nanmean(pv_tRun_basePOST,2);
sem_pv_tRun_basePOST = nanstd(pv_tRun_basePOST,0,2)./sum(double(~isnan(pv_tRun_basePOST)),2);

m_pv_inRun_basePRE = nanmean(pv_inRun_basePRE,2);
sem_pv_inRun_basePRE = nanstd(pv_inRun_basePRE,0,2)./sum(double(~isnan(pv_inRun_basePRE)),2);
m_pv_inRun_baseSTIM = nanmean(pv_inRun_baseSTIM,2);
sem_pv_inRun_baseSTIM = nanstd(pv_inRun_baseSTIM,0,2)./sum(double(~isnan(pv_inRun_baseSTIM)),2);
m_pv_inRun_basePOST = nanmean(pv_inRun_basePOST,2);
sem_pv_inRun_basePOST = nanstd(pv_inRun_basePOST,0,2)./sum(double(~isnan(pv_inRun_basePOST)),2);

m_pv_outRun_basePRE = nanmean(pv_outRun_basePRE,2);
sem_pv_outRun_basePRE = nanstd(pv_outRun_basePRE,0,2)./sum(double(~isnan(pv_outRun_basePOST)),2);
m_pv_outRun_baseSTIM = nanmean(pv_outRun_baseSTIM,2);
sem_pv_outRun_baseSTIM = nanstd(pv_outRun_baseSTIM,0,2)./sum(double(~isnan(pv_outRun_basePOST)),2);
m_pv_outRun_basePOST = nanmean(pv_outRun_basePOST,2);
sem_pv_outRun_basePOST = nanstd(pv_outRun_basePOST,0,2)./sum(double(~isnan(pv_outRun_basePOST)),2);

% Rw session
m_pv_tRw_basePRE = nanmean(pv_tRw_basePRE,2);
sem_pv_tRw_basePRE = nanstd(pv_tRw_basePRE,0,2)./sum(double(~isnan(pv_tRw_basePRE)),2);
m_pv_tRw_baseSTIM = nanmean(pv_tRw_baseSTIM,2);
sem_pv_tRw_baseSTIM = nanstd(pv_tRw_baseSTIM,0,2)./sum(double(~isnan(pv_tRw_baseSTIM)),2);
m_pv_tRw_basePOST = nanmean(pv_tRw_basePOST,2);
sem_pv_tRw_basePOST = nanstd(pv_tRw_basePOST,0,2)./sum(double(~isnan(pv_tRw_basePOST)),2);

m_pv_inRw_basePRE = nanmean(pv_inRw_basePRE,2);
sem_pv_inRw_basePRE = nanstd(pv_inRw_basePRE,0,2)./sum(double(~isnan(pv_inRw_basePRE)),2);
m_pv_inRw_baseSTIM = nanmean(pv_inRw_baseSTIM,2);
sem_pv_inRw_baseSTIM = nanstd(pv_inRw_baseSTIM,0,2)./sum(double(~isnan(pv_inRw_baseSTIM)),2);
m_pv_inRw_basePOST = nanmean(pv_inRw_basePOST,2);
sem_pv_inRw_basePOST = nanstd(pv_inRw_basePOST,0,2)./sum(double(~isnan(pv_inRw_basePOST)),2);

m_pv_outRw_basePRE = nanmean(pv_outRw_basePRE,2);
sem_pv_outRw_basePRE = nanstd(pv_outRw_basePRE,0,2)./sum(double(~isnan(pv_outRw_basePRE)),2);
m_pv_outRw_baseSTIM = nanmean(pv_outRw_baseSTIM,2);
sem_pv_outRw_baseSTIM = nanstd(pv_outRw_baseSTIM,0,2)./sum(double(~isnan(pv_outRw_baseSTIM)),2);
m_pv_outRw_basePOST = nanmean(pv_outRw_basePOST,2);
sem_pv_outRw_basePOST = nanstd(pv_outRw_basePOST,0,2)./sum(double(~isnan(pv_outRw_basePOST)),2);

% noRun session
m_pv_tnoRun_basePRE = nanmean(pv_tnoRun_basePRE,2);
sem_pv_tnoRun_basePRE = nanstd(pv_tnoRun_basePRE,0,2)./sum(double(~isnan(pv_tnoRun_basePRE)),2);
m_pv_tnoRun_baseSTIM = nanmean(pv_tnoRun_baseSTIM,2);
sem_pv_tnoRun_baseSTIM = nanstd(pv_tnoRun_baseSTIM,0,2)./sum(double(~isnan(pv_tnoRun_baseSTIM)),2);
m_pv_tnoRun_basePOST = nanmean(pv_tnoRun_basePOST,2);
sem_pv_tnoRun_basePOST = nanstd(pv_tnoRun_basePOST,0,2)./sum(double(~isnan(pv_tnoRun_basePOST)),2);

m_pv_innoRun_basePRE = nanmean(pv_innoRun_basePRE,2);
sem_pv_innoRun_basePRE = nanstd(pv_innoRun_basePRE,0,2)./sum(double(~isnan(pv_innoRun_basePRE)),2);
m_pv_innoRun_baseSTIM = nanmean(pv_innoRun_baseSTIM,2);
sem_pv_innoRun_baseSTIM = nanstd(pv_innoRun_baseSTIM,0,2)./sum(double(~isnan(pv_innoRun_baseSTIM)),2);
m_pv_innoRun_basePOST = nanmean(pv_innoRun_basePOST,2);
sem_pv_innoRun_basePOST = nanstd(pv_innoRun_basePOST,0,2)./sum(double(~isnan(pv_innoRun_basePOST)),2);

m_pv_outnoRun_basePRE = nanmean(pv_outnoRun_basePRE,2);
sem_pv_outnoRun_basePRE = nanstd(pv_outnoRun_basePRE,0,2)./sum(double(~isnan(pv_outnoRun_basePRE)),2);
m_pv_outnoRun_baseSTIM = nanmean(pv_outnoRun_baseSTIM,2);
sem_pv_outnoRun_baseSTIM = nanstd(pv_outnoRun_baseSTIM,0,2)./sum(double(~isnan(pv_outnoRun_baseSTIM)),2);
m_pv_outnoRun_basePOST = nanmean(pv_outnoRun_basePOST,2);
sem_pv_outnoRun_basePOST = nanstd(pv_outnoRun_basePOST,0,2)./sum(double(~isnan(pv_outnoRun_basePOST)),2);

% noRw session
m_pv_tnoRw_basePRE = nanmean(pv_tnoRw_basePRE,2);
sem_pv_tnoRw_basePRE = nanstd(pv_tnoRw_basePRE,0,2)./sum(double(~isnan(pv_tnoRw_basePRE)),2);
m_pv_tnoRw_baseSTIM = nanmean(pv_tnoRw_baseSTIM,2);
sem_pv_tnoRw_baseSTIM = nanstd(pv_tnoRw_baseSTIM,0,2)./sum(double(~isnan(pv_tnoRw_baseSTIM)),2);
m_pv_tnoRw_basePOST = nanmean(pv_tnoRw_basePOST,2);
sem_pv_tnoRw_basePOST = nanstd(pv_tnoRw_basePOST,0,2)./sum(double(~isnan(pv_tnoRw_basePOST)),2);

m_pv_innoRw_basePRE = nanmean(pv_innoRw_basePRE,2);
sem_pv_innoRw_basePRE = nanstd(pv_innoRw_basePRE,0,2)./sum(double(~isnan(pv_innoRw_basePRE)),2);
m_pv_innoRw_baseSTIM = nanmean(pv_innoRw_baseSTIM,2);
sem_pv_innoRw_baseSTIM = nanstd(pv_innoRw_baseSTIM,0,2)./sum(double(~isnan(pv_innoRw_baseSTIM)),2);
m_pv_innoRw_basePOST = nanmean(pv_innoRw_basePOST,2);
sem_pv_innoRw_basePOST = nanstd(pv_innoRw_basePOST,0,2)./sum(double(~isnan(pv_innoRw_basePOST)),2);

m_pv_outnoRw_basePRE = nanmean(pv_outnoRw_basePRE,2);
sem_pv_outnoRw_basePRE = nanstd(pv_outnoRw_basePRE,0,2)./sum(double(~isnan(pv_outnoRw_basePRE)),2);
m_pv_outnoRw_baseSTIM = nanmean(pv_outnoRw_baseSTIM,2);
sem_pv_outnoRw_baseSTIM = nanstd(pv_outnoRw_baseSTIM,0,2)./sum(double(~isnan(pv_outnoRw_baseSTIM)),2);
m_pv_outnoRw_basePOST = nanmean(pv_outnoRw_basePOST,2);
sem_pv_outnoRw_basePOST = nanstd(pv_outnoRw_basePOST,0,2)./sum(double(~isnan(pv_outnoRw_basePOST)),2);


%% plot
nCol = 2;
nRow = 1;
xpt = 1:90;
yLim = [-0.2, 1];
fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});

hPlotRun(1) = axes('Position',axpt(3,3,1,1,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch([30 60, 60, 30], [-0.2 -0.2 1 1],colorLightYellow,'LineStyle','none');
hold on;
patch([xpt, fliplr(xpt)],[m_pv_inRun_basePRE-sem_pv_inRun_basePRE;flipud(m_pv_inRun_basePRE+sem_pv_inRun_basePRE)]',colorLightBlue,'LineStyle','none');
hold on;
plot(xpt,m_pv_inRun_basePRE,'color',colorBlue);
hold on;
patch([xpt, fliplr(xpt)],[m_pv_innoRun_basePRE-sem_pv_innoRun_basePRE;flipud(m_pv_innoRun_basePRE+sem_pv_innoRun_basePRE)]',colorGray,'LineStyle','none');
hold on;
plot(xpt,m_pv_innoRun_basePRE,'color',colorBlack);
ylabel('PV correlation','fontSize',fontM);
xlabel('Lap','fontSize',fontM);

hPlotRun(2) = axes('Position',axpt(3,3,1,2,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch([30 60, 60, 30], [-0.2 -0.2 1 1],colorLightYellow,'LineStyle','none');
hold on;
patch([xpt, fliplr(xpt)],[m_pv_inRun_baseSTIM-sem_pv_inRun_baseSTIM;flipud(m_pv_inRun_baseSTIM+sem_pv_inRun_baseSTIM)]',colorLightBlue,'LineStyle','none');
hold on;
plot(xpt,m_pv_inRun_baseSTIM,'color',colorBlue);
hold on;
patch([xpt, fliplr(xpt)],[m_pv_innoRun_baseSTIM-sem_pv_innoRun_baseSTIM;flipud(m_pv_innoRun_baseSTIM+sem_pv_innoRun_baseSTIM)]',colorGray,'LineStyle','none');
hold on;
plot(xpt,m_pv_innoRun_baseSTIM,'color',colorBlack);

hPlotRun(3) = axes('Position',axpt(3,3,1,3,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch([30 60, 60, 30], [-0.2 -0.2 1 1],colorLightYellow,'LineStyle','none');
hold on;
patch([xpt, fliplr(xpt)],[m_pv_inRun_basePOST-sem_pv_inRun_basePOST;flipud(m_pv_inRun_basePOST+sem_pv_inRun_basePOST)]',colorLightBlue,'LineStyle','none');
hold on;
plot(xpt,m_pv_inRun_basePOST,'color',colorBlue);
hold on;
patch([xpt, fliplr(xpt)],[m_pv_innoRun_basePOST-sem_pv_innoRun_basePOST;flipud(m_pv_innoRun_basePOST+sem_pv_innoRun_basePOST)]',colorGray,'LineStyle','none');
hold on;
plot(xpt,m_pv_innoRun_basePOST,'color',colorBlack);

hPlotRun(4) = axes('Position',axpt(3,3,2,1,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch([30 60, 60, 30], [-0.2 -0.2 1 1],colorLightYellow,'LineStyle','none');
hold on;
patch([xpt, fliplr(xpt)],[m_pv_outRun_basePRE-sem_pv_outRun_basePRE;flipud(m_pv_outRun_basePRE+sem_pv_outRun_basePRE)]',colorLightBlue,'LineStyle','none');
hold on;
plot(xpt,m_pv_outRun_basePRE,'color',colorBlue);
hold on;
patch([xpt, fliplr(xpt)],[m_pv_outnoRun_basePRE-sem_pv_outnoRun_basePRE;flipud(m_pv_outnoRun_basePRE+sem_pv_outnoRun_basePRE)]',colorGray,'LineStyle','none');
hold on;
plot(xpt,m_pv_outnoRun_basePRE,'color',colorBlack);

hPlotRun(5) = axes('Position',axpt(3,3,2,2,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch([30 60, 60, 30], [-0.2 -0.2 1 1],colorLightYellow,'LineStyle','none');
hold on;
patch([xpt, fliplr(xpt)],[m_pv_outRun_baseSTIM-sem_pv_outRun_baseSTIM;flipud(m_pv_outRun_baseSTIM+sem_pv_outRun_baseSTIM)]',colorLightBlue,'LineStyle','none');
hold on;
plot(xpt,m_pv_outRun_baseSTIM,'color',colorBlue);
hold on;
patch([xpt, fliplr(xpt)],[m_pv_outnoRun_baseSTIM-sem_pv_outnoRun_baseSTIM;flipud(m_pv_outnoRun_baseSTIM+sem_pv_outnoRun_baseSTIM)]',colorGray,'LineStyle','none');
hold on;
plot(xpt,m_pv_outnoRun_baseSTIM,'color',colorBlack);

hPlotRun(6) = axes('Position',axpt(3,3,2,3,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch([30 60, 60, 30], [-0.2 -0.2 1 1],colorLightYellow,'LineStyle','none');
hold on;
patch([xpt, fliplr(xpt)],[m_pv_outRun_basePOST-sem_pv_outRun_basePOST;flipud(m_pv_outRun_basePOST+sem_pv_outRun_basePOST)]',colorLightBlue,'LineStyle','none');
hold on;
plot(xpt,m_pv_outRun_basePOST,'color',colorBlue);
hold on;
patch([xpt, fliplr(xpt)],[m_pv_outnoRun_basePOST-sem_pv_outnoRun_basePOST;flipud(m_pv_outnoRun_basePOST+sem_pv_outnoRun_basePOST)]',colorGray,'LineStyle','none');
hold on;
plot(xpt,m_pv_outnoRun_basePOST,'color',colorBlack);

hPlotRun(7) = axes('Position',axpt(3,3,3,1,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch([30 60, 60, 30], [-0.2 -0.2 1 1],colorLightYellow,'LineStyle','none');
hold on;
patch([xpt, fliplr(xpt)],[m_pv_tRun_basePRE-sem_pv_tRun_basePRE; flipud(m_pv_tRun_basePRE+sem_pv_tRun_basePRE)]',colorLightBlue,'LineStyle','none');
hold on;
plot(xpt,m_pv_tRun_basePRE,'color',colorBlue);
hold on;
patch([xpt, fliplr(xpt)],[m_pv_tnoRun_basePRE-sem_pv_tnoRun_basePRE;flipud(m_pv_tnoRun_basePRE+sem_pv_tnoRun_basePRE)]',colorGray,'LineStyle','none');
hold on;
plot(xpt,m_pv_tnoRun_basePRE,'color',colorBlack);

hPlotRun(8) = axes('Position',axpt(3,3,3,2,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch([30 60, 60, 30], [-0.2 -0.2 1 1],colorLightYellow,'LineStyle','none');
hold on;
patch([xpt, fliplr(xpt)],[m_pv_tRun_baseSTIM-sem_pv_tRun_baseSTIM;flipud(m_pv_tRun_baseSTIM+sem_pv_tRun_baseSTIM)]',colorLightBlue,'LineStyle','none');
hold on;
plot(xpt,m_pv_tRun_baseSTIM,'color',colorBlue);
hold on;
patch([xpt, fliplr(xpt)],[m_pv_tnoRun_baseSTIM-sem_pv_tnoRun_baseSTIM;flipud(m_pv_tnoRun_baseSTIM+sem_pv_tnoRun_baseSTIM)]',colorGray,'LineStyle','none');
hold on;
plot(xpt,m_pv_tnoRun_baseSTIM,'color',colorBlack);

hPlotRun(9) = axes('Position',axpt(3,3,3,3,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch([30 60, 60, 30], [-0.2 -0.2 1 1],colorLightYellow,'LineStyle','none');
hold on;
patch([xpt, fliplr(xpt)],[m_pv_tRun_basePOST-sem_pv_tRun_basePOST;flipud(m_pv_tRun_basePOST+sem_pv_tRun_basePOST)]',colorLightBlue,'LineStyle','none');
hold on;
plot(xpt,m_pv_tRun_basePOST,'color',colorBlue);
hold on;
patch([xpt, fliplr(xpt)],[m_pv_tnoRun_basePOST-sem_pv_tnoRun_basePOST;flipud(m_pv_tnoRun_basePOST+sem_pv_tnoRun_basePOST)]',colorGray,'LineStyle','none');
hold on;
plot(xpt,m_pv_tnoRun_basePOST,'color',colorBlack);

set(hPlotRun,'TickDir','out','Box','off','XLim',[0,90],'YLim',[yLim(1) yLim(2)],'XTick',[0 30 60 90],'fontSize',fontM);
set(hPlotRun,'TickLength',[0.03, 0.03]);


hPlotRw(1) = axes('Position',axpt(3,3,1,1,axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch([30 60, 60, 30], [-0.2 -0.2 1 1],colorLightYellow,'LineStyle','none');
hold on;
patch([xpt, fliplr(xpt)],[m_pv_inRw_basePRE-sem_pv_inRw_basePRE;flipud(m_pv_inRw_basePRE+sem_pv_inRw_basePRE)]',colorLightBlue,'LineStyle','none');
hold on;
plot(xpt,m_pv_inRw_basePRE,'color',colorBlue);
hold on;
patch([xpt, fliplr(xpt)],[m_pv_innoRw_basePRE-sem_pv_innoRw_basePRE;flipud(m_pv_innoRw_basePRE+sem_pv_innoRw_basePRE)]',colorGray,'LineStyle','none');
hold on;
plot(xpt,m_pv_innoRw_basePRE,'color',colorBlack);
ylabel('PV correlation','fontSize',fontM);
xlabel('Lap','fontSize',fontM);

hPlotRw(2) = axes('Position',axpt(3,3,1,2,axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch([30 60, 60, 30], [-0.2 -0.2 1 1],colorLightYellow,'LineStyle','none');
hold on;
patch([xpt, fliplr(xpt)],[m_pv_inRw_baseSTIM-sem_pv_inRw_baseSTIM;flipud(m_pv_inRw_baseSTIM+sem_pv_inRw_baseSTIM)]',colorLightBlue,'LineStyle','none');
hold on;
plot(xpt,m_pv_inRw_baseSTIM,'color',colorBlue);
hold on;
patch([xpt, fliplr(xpt)],[m_pv_innoRw_baseSTIM-sem_pv_innoRw_baseSTIM;flipud(m_pv_innoRw_baseSTIM+sem_pv_innoRw_baseSTIM)]',colorGray,'LineStyle','none');
hold on;
plot(xpt,m_pv_innoRw_baseSTIM,'color',colorBlack);

hPlotRw(3) = axes('Position',axpt(3,3,1,3,axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch([30 60, 60, 30], [-0.2 -0.2 1 1],colorLightYellow,'LineStyle','none');
hold on;
patch([xpt, fliplr(xpt)],[m_pv_inRw_basePOST-sem_pv_inRw_basePOST;flipud(m_pv_inRw_basePOST+sem_pv_inRw_basePOST)]',colorLightBlue,'LineStyle','none');
hold on;
plot(xpt,m_pv_inRw_basePOST,'color',colorBlue);
hold on;
patch([xpt, fliplr(xpt)],[m_pv_innoRw_basePOST-sem_pv_innoRw_basePOST;flipud(m_pv_innoRw_basePOST+sem_pv_innoRw_basePOST)]',colorGray,'LineStyle','none');
hold on;
plot(xpt,m_pv_innoRw_basePOST,'color',colorBlack);

hPlotRw(4) = axes('Position',axpt(3,3,2,1,axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch([30 60, 60, 30], [-0.2 -0.2 1 1],colorLightYellow,'LineStyle','none');
hold on;
patch([xpt, fliplr(xpt)],[m_pv_outRw_basePRE-sem_pv_outRw_basePRE;flipud(m_pv_outRw_basePRE+sem_pv_outRw_basePRE)]',colorLightBlue,'LineStyle','none');
hold on;
plot(xpt,m_pv_outRw_basePRE,'color',colorBlue);
hold on;
patch([xpt, fliplr(xpt)],[m_pv_outnoRw_basePRE-sem_pv_outnoRw_basePRE;flipud(m_pv_outnoRw_basePRE+sem_pv_outnoRw_basePRE)]',colorGray,'LineStyle','none');
hold on;
plot(xpt,m_pv_outnoRw_basePRE,'color',colorBlack);

hPlotRw(5) = axes('Position',axpt(3,3,2,2,axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch([30 60, 60, 30], [-0.2 -0.2 1 1],colorLightYellow,'LineStyle','none');
hold on;
patch([xpt, fliplr(xpt)],[m_pv_outRw_baseSTIM-sem_pv_outRw_baseSTIM;flipud(m_pv_outRw_baseSTIM+sem_pv_outRw_baseSTIM)]',colorLightBlue,'LineStyle','none');
hold on;
plot(xpt,m_pv_outRw_baseSTIM,'color',colorBlue);
hold on;
patch([xpt, fliplr(xpt)],[m_pv_outnoRw_baseSTIM-sem_pv_outnoRw_baseSTIM;flipud(m_pv_outnoRw_baseSTIM+sem_pv_outnoRw_baseSTIM)]',colorGray,'LineStyle','none');
hold on;
plot(xpt,m_pv_outnoRw_baseSTIM,'color',colorBlack);

hPlotRw(6) = axes('Position',axpt(3,3,2,3,axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch([30 60, 60, 30], [-0.2 -0.2 1 1],colorLightYellow,'LineStyle','none');
hold on;
patch([xpt, fliplr(xpt)],[m_pv_outRw_basePOST-sem_pv_outRw_basePOST;flipud(m_pv_outRw_basePOST+sem_pv_outRw_basePOST)]',colorLightBlue,'LineStyle','none');
hold on;
plot(xpt,m_pv_outRw_basePOST,'color',colorBlue);
hold on;
patch([xpt, fliplr(xpt)],[m_pv_outnoRw_basePOST-sem_pv_outnoRw_basePOST;flipud(m_pv_outnoRw_basePOST+sem_pv_outnoRw_basePOST)]',colorGray,'LineStyle','none');
hold on;
plot(xpt,m_pv_outnoRw_basePOST,'color',colorBlack);

hPlotRw(7) = axes('Position',axpt(3,3,3,1,axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch([30 60, 60, 30], [-0.2 -0.2 1 1],colorLightYellow,'LineStyle','none');
hold on;
patch([xpt, fliplr(xpt)],[m_pv_tRw_basePRE-sem_pv_tRw_basePRE; flipud(m_pv_tRw_basePRE+sem_pv_tRw_basePRE)]',colorLightBlue,'LineStyle','none');
hold on;
plot(xpt,m_pv_tRw_basePRE,'color',colorBlue);
hold on;
patch([xpt, fliplr(xpt)],[m_pv_tnoRw_basePRE-sem_pv_tnoRw_basePRE;flipud(m_pv_tnoRw_basePRE+sem_pv_tnoRw_basePRE)]',colorGray,'LineStyle','none');
hold on;
plot(xpt,m_pv_tnoRw_basePRE,'color',colorBlack);

hPlotRw(8) = axes('Position',axpt(3,3,3,2,axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch([30 60, 60, 30], [-0.2 -0.2 1 1],colorLightYellow,'LineStyle','none');
hold on;
patch([xpt, fliplr(xpt)],[m_pv_tRw_baseSTIM-sem_pv_tRw_baseSTIM;flipud(m_pv_tRw_baseSTIM+sem_pv_tRw_baseSTIM)]',colorLightBlue,'LineStyle','none');
hold on;
plot(xpt,m_pv_tRw_baseSTIM,'color',colorBlue);
hold on;
patch([xpt, fliplr(xpt)],[m_pv_tnoRw_baseSTIM-sem_pv_tnoRw_baseSTIM;flipud(m_pv_tnoRw_baseSTIM+sem_pv_tnoRw_baseSTIM)]',colorGray,'LineStyle','none');
hold on;
plot(xpt,m_pv_tnoRw_baseSTIM,'color',colorBlack);

hPlotRw(9) = axes('Position',axpt(3,3,3,3,axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch([30 60, 60, 30], [-0.2 -0.2 1 1],colorLightYellow,'LineStyle','none');
hold on;
patch([xpt, fliplr(xpt)],[m_pv_tRw_basePOST-sem_pv_tRw_basePOST;flipud(m_pv_tRw_basePOST+sem_pv_tRw_basePOST)]',colorLightBlue,'LineStyle','none');
hold on;
plot(xpt,m_pv_tRw_basePOST,'color',colorBlue);
hold on;
patch([xpt, fliplr(xpt)],[m_pv_tnoRw_basePOST-sem_pv_tnoRw_basePOST;flipud(m_pv_tnoRw_basePOST+sem_pv_tnoRw_basePOST)]',colorGray,'LineStyle','none');
hold on;
plot(xpt,m_pv_tnoRw_basePOST,'color',colorBlack);

set(hPlotRw,'TickDir','out','Box','off','XLim',[0,90],'YLim',[yLim(1) yLim(2)],'XTick',[0 30 60 90],'fontSize',fontM);
set(hPlotRw,'TickLength',[0.03, 0.03]);
% print('-painters','-r300','-dtiff',['f_Neuron_PVCorr_',datestr(now,formatOut),'_50Hz_zone','.tif']);
% print('-painters','-r300','-depsc',['f_CellRepors_PVCorr_8Hz_',datestr(now,formatOut),'.ai']);
% close;