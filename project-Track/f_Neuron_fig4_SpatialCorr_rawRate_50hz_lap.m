clearvars;
cd('E:\Dropbox\SNL\P2_Track');

load('E:\Dropbox\SNL\P2_Track\myParameters.mat');
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
% load('neuronList_ori50hz_180123.mat');
load('neuronList_ori50hz_180125_sd1.mat');
cri_meanFR = 1;
% TN: track neuron
% tPC_Run = T.taskType == 'DRun' & T.idxNeurontype == 'PN';
% tPC_Run = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
tPC_Run = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & cellfun(@(x) max(max(x)), T.pethconvSpatial)>cri_meanFR; % mean firing rate > 1hz
% tPC_Run = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR;

nPC_Run = sum(double(tPC_Run));

% corr of total neurons
rateMapConv_Run = T.rateMapConv_eachLap(tPC_Run);
rateMapConv10_PRE_Run = cell2mat(T.rateMapConv10_PRE(tPC_Run));
rateMapConv10_STIM_Run = cell2mat(T.rateMapConv10_STIM(tPC_Run));
rateMapConv10_POST_Run = cell2mat(T.rateMapConv10_POST(tPC_Run));

nTotalBin = size(rateMapConv10_PRE_Run,2);
nInBin_Run = length(lightLoc_Run(1):lightLoc_Run(2));
nOutBin_Run = length([1:lightLoc_Run(1)-1,lightLoc_Run(2)+1:nTotalBin]);
nInBin_Rw = length(lightLoc_Rw(1):lightLoc_Rw(2));
nOutBin_Rw = length([1:lightLoc_Rw(1)-1,lightLoc_Rw(2)+1:nTotalBin]);

% normalize
% rateMapConv10_PRE_Run = rateMapConv10_PRE_Run./repmat(max(rateMapConv10_PRE_Run,[],2),1,nTotalBin);
% rateMapConv10_STIM_Run = rateMapConv10_STIM_Run./repmat(max(rateMapConv10_STIM_Run,[],2),1,nTotalBin);
% rateMapConv10_POST_Run = rateMapConv10_POST_Run./repmat(max(rateMapConv10_POST_Run,[],2),1,nTotalBin);

tempTotal = zeros(nPC_Run,nTotalBin);
tempInzone_Run = zeros(nPC_Run,nInBin_Run);
tempOutzone_Run = zeros(nPC_Run,nOutBin_Run);
tempInzone_Rw = zeros(nPC_Run,nInBin_Rw);
tempOutzone_Rw = zeros(nPC_Run,nOutBin_Rw);
tempInzone_noRun = zeros(nPC_Run,nInBin_Run);
tempOutzone_noRun = zeros(nPC_Run,nOutBin_Run);
tempInzone_noRw = zeros(nPC_Run,nInBin_Rw);
tempOutzone_noRw = zeros(nPC_Run,nOutBin_Rw);

inBasePRE_Run = rateMapConv10_PRE_Run(:,lightLoc_Run(1):lightLoc_Run(2));
inBaseSTIM_Run = rateMapConv10_STIM_Run(:,lightLoc_Run(1):lightLoc_Run(2));
inBasePOST_Run = rateMapConv10_POST_Run(:,lightLoc_Run(1):lightLoc_Run(2));

outBasePRE_Run = rateMapConv10_PRE_Run(:,[1:lightLoc_Run(1)-1,lightLoc_Run(2)+1:nTotalBin]);
outBaseSTIM_Run = rateMapConv10_STIM_Run(:,[1:lightLoc_Run(1)-1,lightLoc_Run(2)+1:nTotalBin]);
outBasePOST_Run = rateMapConv10_POST_Run(:,[1:lightLoc_Run(1)-1,lightLoc_Run(2)+1:nTotalBin]);

[rateMapLap_totalRun, rateMapLap_inRun, rateMapLap_outRun] = deal(cell(90,1));
for iLap = 1:90
    for iCell = 1:nPC_Run
%         rateMapConv_Run{iCell} = rateMapConv_Run{iCell}./repmat(max(rateMapConv_Run{iCell},[],2),1,nTotalBin);
        tempTotal(iCell,:) = rateMapConv_Run{iCell}(iLap,:);
        tempInzone_Run(iCell,:) = rateMapConv_Run{iCell}(iLap,lightLoc_Run(1):lightLoc_Run(2));
        tempOutzone_Run(iCell,:) = rateMapConv_Run{iCell}(iLap,[1:lightLoc_Run(1)-1,lightLoc_Run(2)+1:nTotalBin]);
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

rateMapConv_Rw = T.rateMapConv_eachLap(tPC_Rw);
rateMapConv10_PRE_Rw = cell2mat(T.rateMapConv10_PRE(tPC_Rw));
rateMapConv10_STIM_Rw = cell2mat(T.rateMapConv10_STIM(tPC_Rw));
rateMapConv10_POST_Rw = cell2mat(T.rateMapConv10_POST(tPC_Rw));

inBasePRE_Rw = rateMapConv10_PRE_Rw(:,lightLoc_Rw(1):lightLoc_Rw(2));
inBaseSTIM_Rw = rateMapConv10_STIM_Rw(:,lightLoc_Rw(1):lightLoc_Rw(2));
inBasePOST_Rw = rateMapConv10_POST_Rw(:,lightLoc_Rw(1):lightLoc_Rw(2));

outBasePRE_Rw = rateMapConv10_PRE_Rw(:,[1:lightLoc_Rw(1)-1,lightLoc_Rw(2)+1:nTotalBin]);
outBaseSTIM_Rw = rateMapConv10_STIM_Rw(:,[1:lightLoc_Rw(1)-1,lightLoc_Rw(2)+1:nTotalBin]);
outBasePOST_Rw = rateMapConv10_POST_Rw(:,[1:lightLoc_Rw(1)-1,lightLoc_Rw(2)+1:nTotalBin]);

[rateMapLap_totalRw, rateMapLap_inRw, rateMapLap_outRw] = deal(cell(90,1));
for iLap = 1:90
    for iCell = 1:nPC_Rw
        tempTotal(iCell,:) = rateMapConv_Rw{iCell}(iLap,:);
        tempInzone_Rw(iCell,:) = rateMapConv_Rw{iCell}(iLap,lightLoc_Rw(1):lightLoc_Rw(2));
        tempOutzone_Rw(iCell,:) = rateMapConv_Rw{iCell}(iLap,[1:lightLoc_Rw(1)-1,lightLoc_Rw(2)+1:nTotalBin]);
    end
    rateMapLap_totalRw{iLap} = tempTotal;
    rateMapLap_inRw{iLap} = tempInzone_Rw;
    rateMapLap_outRw{iLap} = tempOutzone_Rw;
end


% load('neuronList_ori_171205.mat');
% load('neuronList_ori_171229.mat');
% load('neuronList_ori_180123.mat');
load('neuronList_ori_180125.mat');

%%% noRun %%%%
% tPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN';
% tPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
tPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & cellfun(@(x) max(max(x)), T.pethconvSpatial)>cri_meanFR; % mean firing rate > 1hz
% tPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR;

nPC_noRun = sum(double(tPC_noRun));

% corr of total neurons
rateMapConv_noRun = T.rateMapConv_eachLap(tPC_noRun);
rateMapConv10_PRE_noRun = cell2mat(T.rateMapConv10_PRE(tPC_noRun));
rateMapConv10_STIM_noRun = cell2mat(T.rateMapConv10_STIM(tPC_noRun));
rateMapConv10_POST_noRun = cell2mat(T.rateMapConv10_POST(tPC_noRun));

inBasePRE_noRun = rateMapConv10_PRE_noRun(:,lightLoc_Run(1):lightLoc_Run(2));
inBaseSTIM_noRun = rateMapConv10_STIM_noRun(:,lightLoc_Run(1):lightLoc_Run(2));
inBasePOST_noRun = rateMapConv10_POST_noRun(:,lightLoc_Run(1):lightLoc_Run(2));

outBasePRE_noRun = rateMapConv10_PRE_noRun(:,[1:lightLoc_Run(1)-1,lightLoc_Run(2)+1:nTotalBin]);
outBaseSTIM_noRun = rateMapConv10_STIM_noRun(:,[1:lightLoc_Run(1)-1,lightLoc_Run(2)+1:nTotalBin]);
outBasePOST_noRun = rateMapConv10_POST_noRun(:,[1:lightLoc_Run(1)-1,lightLoc_Run(2)+1:nTotalBin]);

[rateMapLap_totalnoRun, rateMapLap_innoRun, rateMapLap_outnoRun] = deal(cell(90,1));
for iLap = 1:90
    for iCell = 1:nPC_noRun
        tempTotal(iCell,:) = rateMapConv_noRun{iCell}(iLap,:);
        tempInzone_noRun(iCell,:) = rateMapConv_noRun{iCell}(iLap,lightLoc_Run(1):lightLoc_Run(2));
        tempOutzone_noRun(iCell,:) = rateMapConv_noRun{iCell}(iLap,[1:lightLoc_Run(1)-1,lightLoc_Run(2)+1:nTotalBin]);
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
rateMapConv_noRw = T.rateMapConv_eachLap(tPC_noRw);
rateMapConv10_PRE_noRw = cell2mat(T.rateMapConv10_PRE(tPC_noRw));
rateMapConv10_STIM_noRw = cell2mat(T.rateMapConv10_STIM(tPC_noRw));
rateMapConv10_POST_noRw = cell2mat(T.rateMapConv10_POST(tPC_noRw));

inBasePRE_noRw = rateMapConv10_PRE_noRw(:,lightLoc_Rw(1):lightLoc_Rw(2));
inBaseSTIM_noRw = rateMapConv10_STIM_noRw(:,lightLoc_Rw(1):lightLoc_Rw(2));
inBasePOST_noRw = rateMapConv10_POST_noRw(:,lightLoc_Rw(1):lightLoc_Rw(2));

outBasePRE_noRw = rateMapConv10_PRE_noRw(:,[1:lightLoc_Rw(1)-1,lightLoc_Rw(2)+1:nTotalBin]);
outBaseSTIM_noRw = rateMapConv10_STIM_noRw(:,[1:lightLoc_Rw(1)-1,lightLoc_Rw(2)+1:nTotalBin]);
outBasePOST_noRw = rateMapConv10_POST_noRw(:,[1:lightLoc_Rw(1)-1,lightLoc_Rw(2)+1:nTotalBin]);

[rateMapLap_totalnoRw, rateMapLap_innoRw, rateMapLap_outnoRw] = deal(cell(90,1));
for iLap = 1:90
    for iCell = 1:nPC_noRw
        tempTotal(iCell,:) = rateMapConv_noRw{iCell}(iLap,:);
        tempInzone_noRw(iCell,:) = rateMapConv_noRw{iCell}(iLap,lightLoc_Rw(1):lightLoc_Rw(2));
        tempOutzone_noRw(iCell,:) = rateMapConv_noRw{iCell}(iLap,[1:lightLoc_Rw(1)-1,lightLoc_Rw(2)+1:nTotalBin]);
    end
    rateMapLap_totalnoRw{iLap} = tempTotal;
    rateMapLap_innoRw{iLap} = tempInzone_noRw;
    rateMapLap_outnoRw{iLap} = tempOutzone_noRw;
end

% PV calculation %%
% entire bin
[sc_tRun_basePRE, sc_tRun_baseSTIM, sc_tRun_basePOST] = deal(zeros(90,124));
[sc_tRw_basePRE, sc_tRw_baseSTIM, sc_tRw_basePOST] = deal(zeros(90,124));
[sc_tnoRun_basePRE, sc_tnoRun_baseSTIM, sc_tnoRun_basePOST] = deal(zeros(90,124));
[sc_tnoRw_basePRE, sc_tnoRw_baseSTIM, sc_tnoRw_basePOST] = deal(zeros(90,124));

for iLap = 1:90
    for iBin = 1:nTotalBin
        sc_tRun_basePRE(iLap,iBin) = corr(rateMapConv10_PRE_Run(:,iBin),rateMapLap_totalRun{iLap}(:,iBin),'rows','complete','type','Pearson');
        sc_tRun_baseSTIM(iLap,iBin) = corr(rateMapConv10_STIM_Run(:,iBin),rateMapLap_totalRun{iLap}(:,iBin),'rows','complete','type','Pearson');
        sc_tRun_basePOST(iLap,iBin) = corr(rateMapConv10_POST_Run(:,iBin),rateMapLap_totalRun{iLap}(:,iBin),'rows','complete','type','Pearson');
        
        sc_tRw_basePRE(iLap,iBin) = corr(rateMapConv10_PRE_Rw(:,iBin),rateMapLap_totalRw{iLap}(:,iBin),'rows','complete','type','Pearson');
        sc_tRw_baseSTIM(iLap,iBin) = corr(rateMapConv10_STIM_Rw(:,iBin),rateMapLap_totalRw{iLap}(:,iBin),'rows','complete','type','Pearson');
        sc_tRw_basePOST(iLap,iBin) = corr(rateMapConv10_POST_Rw(:,iBin),rateMapLap_totalRw{iLap}(:,iBin),'rows','complete','type','Pearson');
        
        sc_tnoRun_basePRE(iLap,iBin) = corr(rateMapConv10_PRE_noRun(:,iBin),rateMapLap_totalnoRun{iLap}(:,iBin),'rows','complete','type','Pearson');
        sc_tnoRun_baseSTIM(iLap,iBin) = corr(rateMapConv10_STIM_noRun(:,iBin),rateMapLap_totalnoRun{iLap}(:,iBin),'rows','complete','type','Pearson');
        sc_tnoRun_basePOST(iLap,iBin) = corr(rateMapConv10_POST_noRun(:,iBin),rateMapLap_totalnoRun{iLap}(:,iBin),'rows','complete','type','Pearson');
        
        sc_tnoRw_basePRE(iLap,iBin) = corr(rateMapConv10_PRE_noRw(:,iBin),rateMapLap_totalnoRw{iLap}(:,iBin),'rows','complete','type','Pearson');
        sc_tnoRw_baseSTIM(iLap,iBin) = corr(rateMapConv10_STIM_noRw(:,iBin),rateMapLap_totalnoRw{iLap}(:,iBin),'rows','complete','type','Pearson');
        sc_tnoRw_basePOST(iLap,iBin) = corr(rateMapConv10_POST_noRw(:,iBin),rateMapLap_totalnoRw{iLap}(:,iBin),'rows','complete','type','Pearson');
    end
end

% In-zone bin
[sc_inRun_basePRE, sc_inRun_baseSTIM, sc_inRun_basePOST] = deal(zeros(90,nPC_Run));
[sc_outRun_basePRE, sc_outRun_baseSTIM, sc_outRun_basePOST] = deal(zeros(90,nPC_Run));
[sc_inRw_basePRE, sc_inRw_baseSTIM, sc_inRw_basePOST] = deal(zeros(90,nPC_Rw));
[sc_outRw_basePRE, sc_outRw_baseSTIM, sc_outRw_basePOST] = deal(zeros(90,nPC_Rw));
[sc_innoRun_basePRE, sc_innoRun_baseSTIM, sc_innoRun_basePOST] = deal(zeros(90,nPC_noRun));
[sc_outnoRun_basePRE, sc_outnoRun_baseSTIM, sc_outnoRun_basePOST] = deal(zeros(90,nPC_noRun));
[sc_innoRw_basePRE, sc_innoRw_baseSTIM, sc_innoRw_basePOST] = deal(zeros(90,nPC_noRw));
[sc_outnoRw_basePRE, sc_outnoRw_baseSTIM, sc_outnoRw_basePOST] = deal(zeros(90,nPC_noRw));

for iLap = 1:90
    for iCell = 1:nPC_Run
        sc_inRun_basePRE(iLap,iCell) = corr(inBasePRE_Run(iCell,:)', rateMapLap_inRun{iLap}(iCell,:)','rows','complete');
        sc_inRun_baseSTIM(iLap,iCell) = corr(inBaseSTIM_Run(iCell,:)', rateMapLap_inRun{iLap}(iCell,:)','rows','complete');
        sc_inRun_basePOST(iLap,iCell) = corr(inBasePOST_Run(iCell,:)', rateMapLap_inRun{iLap}(iCell,:)','rows','complete');
    end
    
    for iCell = 1:nPC_Run
        sc_outRun_basePRE(iLap,iCell) = corr(outBasePRE_Run(iCell,:)', rateMapLap_outRun{iLap}(iCell,:)','rows','complete');
        sc_outRun_baseSTIM(iLap,iCell) = corr(outBaseSTIM_Run(iCell,:)', rateMapLap_outRun{iLap}(iCell,:)','rows','complete');
        sc_outRun_basePOST(iLap,iCell) = corr(outBasePOST_Run(iCell,:)', rateMapLap_outRun{iLap}(iCell,:)','rows','complete');
    end
    
    for iCell = 1:nPC_Rw
        sc_inRw_basePRE(iLap,iCell) = corr(inBasePRE_Rw(iCell,:)', rateMapLap_inRw{iLap}(iCell,:)','rows','complete');
        sc_inRw_baseSTIM(iLap,iCell) = corr(inBaseSTIM_Rw(iCell,:)', rateMapLap_inRw{iLap}(iCell,:)','rows','complete');
        sc_inRw_basePOST(iLap,iCell) = corr(inBasePOST_Rw(iCell,:)', rateMapLap_inRw{iLap}(iCell,:)','rows','complete');
    end
    
    for iCell = 1:nPC_Rw
        sc_outRw_basePRE(iLap,iCell) = corr(outBasePRE_Rw(iCell,:)', rateMapLap_outRw{iLap}(iCell,:)','rows','complete');
        sc_outRw_baseSTIM(iLap,iCell) = corr(outBaseSTIM_Rw(iCell,:)', rateMapLap_outRw{iLap}(iCell,:)','rows','complete');
        sc_outRw_basePOST(iLap,iCell) = corr(outBasePOST_Rw(iCell,:)', rateMapLap_outRw{iLap}(iCell,:)','rows','complete');
    end
    
    for iCell = 1:nPC_noRun
        sc_innoRun_basePRE(iLap,iCell) = corr(inBasePRE_noRun(iCell,:)', rateMapLap_innoRun{iLap}(iCell,:)','rows','complete');
        sc_innoRun_baseSTIM(iLap,iCell) = corr(inBaseSTIM_noRun(iCell,:)', rateMapLap_innoRun{iLap}(iCell,:)','rows','complete');
        sc_innoRun_basePOST(iLap,iCell) = corr(inBasePOST_noRun(iCell,:)', rateMapLap_innoRun{iLap}(iCell,:)','rows','complete');
    end
    
    for iCell = 1:nPC_noRun
        sc_outnoRun_basePRE(iLap,iCell) = corr(outBasePRE_noRun(iCell,:)', rateMapLap_outnoRun{iLap}(iCell,:)','rows','complete');
        sc_outnoRun_baseSTIM(iLap,iCell) = corr(outBaseSTIM_noRun(iCell,:)', rateMapLap_outnoRun{iLap}(iCell,:)','rows','complete');
        sc_outnoRun_basePOST(iLap,iCell) = corr(outBasePOST_noRun(iCell,:)', rateMapLap_outnoRun{iLap}(iCell,:)','rows','complete');
    end
    
    for iCell = 1:nPC_noRw
        sc_innoRw_basePRE(iLap,iCell) = corr(inBasePRE_noRw(iCell,:)', rateMapLap_innoRw{iLap}(iCell,:)','rows','complete');
        sc_innoRw_baseSTIM(iLap,iCell) = corr(inBaseSTIM_noRw(iCell,:)', rateMapLap_innoRw{iLap}(iCell,:)','rows','complete');
        sc_innoRw_basePOST(iLap,iCell) = corr(inBasePOST_noRw(iCell,:)', rateMapLap_innoRw{iLap}(iCell,:)','rows','complete');
    end
    
    for iCell = 1:nPC_noRw
        sc_outnoRw_basePRE(iLap,iCell) = corr(outBasePRE_noRw(iCell,:)', rateMapLap_outnoRw{iLap}(iCell,:)','rows','complete');
        sc_outnoRw_baseSTIM(iLap,iCell) = corr(outBaseSTIM_noRw(iCell,:)', rateMapLap_outnoRw{iLap}(iCell,:)','rows','complete');
        sc_outnoRw_basePOST(iLap,iCell) = corr(outBasePOST_noRw(iCell,:)', rateMapLap_outnoRw{iLap}(iCell,:)','rows','complete');
    end
end

%% save variables
save('scValue50hz.mat',...
    'sc_tRun_basePRE', 'sc_tRun_baseSTIM', 'sc_tRun_basePOST', 'sc_tRw_basePRE', 'sc_tRw_baseSTIM', 'sc_tRw_basePOST',...
    'sc_tnoRun_basePRE', 'sc_tnoRun_baseSTIM', 'sc_tnoRun_basePOST', 'sc_tnoRw_basePRE', 'sc_tnoRw_baseSTIM', 'sc_tnoRw_basePOST',...
    'sc_inRun_basePRE', 'sc_inRun_baseSTIM', 'sc_inRun_basePOST', 'sc_outRun_basePRE', 'sc_outRun_baseSTIM', 'sc_outRun_basePOST',...
    'sc_inRw_basePRE', 'sc_inRw_baseSTIM', 'sc_inRw_basePOST', 'sc_outRw_basePRE', 'sc_outRw_baseSTIM', 'sc_outRw_basePOST',... 
    'sc_innoRun_basePRE', 'sc_innoRun_baseSTIM', 'sc_innoRun_basePOST', 'sc_outnoRun_basePRE', 'sc_outnoRun_baseSTIM', 'sc_outnoRun_basePOST',...
    'sc_innoRw_basePRE', 'sc_innoRw_baseSTIM', 'sc_innoRw_basePOST', 'sc_outnoRw_basePRE', 'sc_outnoRw_baseSTIM', 'sc_outnoRw_basePOST')

%% mean % sem calculation
load('scValue50hz.mat');
% Run session
m_sc_tRun_basePRE = nanmean(sc_tRun_basePRE,2);
sem_sc_tRun_basePRE = nanstd(sc_tRun_basePRE,0,2)./sum(double(~isnan(sc_tRun_basePRE)),2);
m_sc_tRun_baseSTIM = nanmean(sc_tRun_baseSTIM,2);
sem_sc_tRun_baseSTIM = nanstd(sc_tRun_baseSTIM,0,2)./sum(double(~isnan(sc_tRun_baseSTIM)),2);
m_sc_tRun_basePOST = nanmean(sc_tRun_basePOST,2);
sem_sc_tRun_basePOST = nanstd(sc_tRun_basePOST,0,2)./sum(double(~isnan(sc_tRun_basePOST)),2);

m_sc_inRun_basePRE = nanmean(sc_inRun_basePRE,2);
sem_sc_inRun_basePRE = nanstd(sc_inRun_basePRE,0,2)./sum(double(~isnan(sc_inRun_basePRE)),2);
m_sc_inRun_baseSTIM = nanmean(sc_inRun_baseSTIM,2);
sem_sc_inRun_baseSTIM = nanstd(sc_inRun_baseSTIM,0,2)./sum(double(~isnan(sc_inRun_baseSTIM)),2);
m_sc_inRun_basePOST = nanmean(sc_inRun_basePOST,2);
sem_sc_inRun_basePOST = nanstd(sc_inRun_basePOST,0,2)./sum(double(~isnan(sc_inRun_basePOST)),2);

m_sc_outRun_basePRE = nanmean(sc_outRun_basePRE,2);
sem_sc_outRun_basePRE = nanstd(sc_outRun_basePRE,0,2)./sum(double(~isnan(sc_outRun_basePOST)),2);
m_sc_outRun_baseSTIM = nanmean(sc_outRun_baseSTIM,2);
sem_sc_outRun_baseSTIM = nanstd(sc_outRun_baseSTIM,0,2)./sum(double(~isnan(sc_outRun_basePOST)),2);
m_sc_outRun_basePOST = nanmean(sc_outRun_basePOST,2);
sem_sc_outRun_basePOST = nanstd(sc_outRun_basePOST,0,2)./sum(double(~isnan(sc_outRun_basePOST)),2);

% Rw session
m_sc_tRw_basePRE = nanmean(sc_tRw_basePRE,2);
sem_sc_tRw_basePRE = nanstd(sc_tRw_basePRE,0,2)./sum(double(~isnan(sc_tRw_basePRE)),2);
m_sc_tRw_baseSTIM = nanmean(sc_tRw_baseSTIM,2);
sem_sc_tRw_baseSTIM = nanstd(sc_tRw_baseSTIM,0,2)./sum(double(~isnan(sc_tRw_baseSTIM)),2);
m_sc_tRw_basePOST = nanmean(sc_tRw_basePOST,2);
sem_sc_tRw_basePOST = nanstd(sc_tRw_basePOST,0,2)./sum(double(~isnan(sc_tRw_basePOST)),2);

m_sc_inRw_basePRE = nanmean(sc_inRw_basePRE,2);
sem_sc_inRw_basePRE = nanstd(sc_inRw_basePRE,0,2)./sum(double(~isnan(sc_inRw_basePRE)),2);
m_sc_inRw_baseSTIM = nanmean(sc_inRw_baseSTIM,2);
sem_sc_inRw_baseSTIM = nanstd(sc_inRw_baseSTIM,0,2)./sum(double(~isnan(sc_inRw_baseSTIM)),2);
m_sc_inRw_basePOST = nanmean(sc_inRw_basePOST,2);
sem_sc_inRw_basePOST = nanstd(sc_inRw_basePOST,0,2)./sum(double(~isnan(sc_inRw_basePOST)),2);

m_sc_outRw_basePRE = nanmean(sc_outRw_basePRE,2);
sem_sc_outRw_basePRE = nanstd(sc_outRw_basePRE,0,2)./sum(double(~isnan(sc_outRw_basePRE)),2);
m_sc_outRw_baseSTIM = nanmean(sc_outRw_baseSTIM,2);
sem_sc_outRw_baseSTIM = nanstd(sc_outRw_baseSTIM,0,2)./sum(double(~isnan(sc_outRw_baseSTIM)),2);
m_sc_outRw_basePOST = nanmean(sc_outRw_basePOST,2);
sem_sc_outRw_basePOST = nanstd(sc_outRw_basePOST,0,2)./sum(double(~isnan(sc_outRw_basePOST)),2);

% noRun session
m_sc_tnoRun_basePRE = nanmean(sc_tnoRun_basePRE,2);
sem_sc_tnoRun_basePRE = nanstd(sc_tnoRun_basePRE,0,2)./sum(double(~isnan(sc_tnoRun_basePRE)),2);
m_sc_tnoRun_baseSTIM = nanmean(sc_tnoRun_baseSTIM,2);
sem_sc_tnoRun_baseSTIM = nanstd(sc_tnoRun_baseSTIM,0,2)./sum(double(~isnan(sc_tnoRun_baseSTIM)),2);
m_sc_tnoRun_basePOST = nanmean(sc_tnoRun_basePOST,2);
sem_sc_tnoRun_basePOST = nanstd(sc_tnoRun_basePOST,0,2)./sum(double(~isnan(sc_tnoRun_basePOST)),2);

m_sc_innoRun_basePRE = nanmean(sc_innoRun_basePRE,2);
sem_sc_innoRun_basePRE = nanstd(sc_innoRun_basePRE,0,2)./sum(double(~isnan(sc_innoRun_basePRE)),2);
m_sc_innoRun_baseSTIM = nanmean(sc_innoRun_baseSTIM,2);
sem_sc_innoRun_baseSTIM = nanstd(sc_innoRun_baseSTIM,0,2)./sum(double(~isnan(sc_innoRun_baseSTIM)),2);
m_sc_innoRun_basePOST = nanmean(sc_innoRun_basePOST,2);
sem_sc_innoRun_basePOST = nanstd(sc_innoRun_basePOST,0,2)./sum(double(~isnan(sc_innoRun_basePOST)),2);

m_sc_outnoRun_basePRE = nanmean(sc_outnoRun_basePRE,2);
sem_sc_outnoRun_basePRE = nanstd(sc_outnoRun_basePRE,0,2)./sum(double(~isnan(sc_outnoRun_basePRE)),2);
m_sc_outnoRun_baseSTIM = nanmean(sc_outnoRun_baseSTIM,2);
sem_sc_outnoRun_baseSTIM = nanstd(sc_outnoRun_baseSTIM,0,2)./sum(double(~isnan(sc_outnoRun_baseSTIM)),2);
m_sc_outnoRun_basePOST = nanmean(sc_outnoRun_basePOST,2);
sem_sc_outnoRun_basePOST = nanstd(sc_outnoRun_basePOST,0,2)./sum(double(~isnan(sc_outnoRun_basePOST)),2);

% noRw session
m_sc_tnoRw_basePRE = nanmean(sc_tnoRw_basePRE,2);
sem_sc_tnoRw_basePRE = nanstd(sc_tnoRw_basePRE,0,2)./sum(double(~isnan(sc_tnoRw_basePRE)),2);
m_sc_tnoRw_baseSTIM = nanmean(sc_tnoRw_baseSTIM,2);
sem_sc_tnoRw_baseSTIM = nanstd(sc_tnoRw_baseSTIM,0,2)./sum(double(~isnan(sc_tnoRw_baseSTIM)),2);
m_sc_tnoRw_basePOST = nanmean(sc_tnoRw_basePOST,2);
sem_sc_tnoRw_basePOST = nanstd(sc_tnoRw_basePOST,0,2)./sum(double(~isnan(sc_tnoRw_basePOST)),2);

m_sc_innoRw_basePRE = nanmean(sc_innoRw_basePRE,2);
sem_sc_innoRw_basePRE = nanstd(sc_innoRw_basePRE,0,2)./sum(double(~isnan(sc_innoRw_basePRE)),2);
m_sc_innoRw_baseSTIM = nanmean(sc_innoRw_baseSTIM,2);
sem_sc_innoRw_baseSTIM = nanstd(sc_innoRw_baseSTIM,0,2)./sum(double(~isnan(sc_innoRw_baseSTIM)),2);
m_sc_innoRw_basePOST = nanmean(sc_innoRw_basePOST,2);
sem_sc_innoRw_basePOST = nanstd(sc_innoRw_basePOST,0,2)./sum(double(~isnan(sc_innoRw_basePOST)),2);

m_sc_outnoRw_basePRE = nanmean(sc_outnoRw_basePRE,2);
sem_sc_outnoRw_basePRE = nanstd(sc_outnoRw_basePRE,0,2)./sum(double(~isnan(sc_outnoRw_basePRE)),2);
m_sc_outnoRw_baseSTIM = nanmean(sc_outnoRw_baseSTIM,2);
sem_sc_outnoRw_baseSTIM = nanstd(sc_outnoRw_baseSTIM,0,2)./sum(double(~isnan(sc_outnoRw_baseSTIM)),2);
m_sc_outnoRw_basePOST = nanmean(sc_outnoRw_basePOST,2);
sem_sc_outnoRw_basePOST = nanstd(sc_outnoRw_basePOST,0,2)./sum(double(~isnan(sc_outnoRw_basePOST)),2);


%% plot
nCol = 2;
nRow = 1;
xpt = 1:90;
yLim = [-0.2, 1];
fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});

hPlotRun(1) = axes('Position',axpt(3,3,1,1,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch([30 60, 60, 30], [-0.2 -0.2 1 1],colorLightYellow,'LineStyle','none');
hold on;
patch([xpt, fliplr(xpt)],[m_sc_inRun_basePRE-sem_sc_inRun_basePRE;flipud(m_sc_inRun_basePRE+sem_sc_inRun_basePRE)]',colorLightBlue,'LineStyle','none');
hold on;
plot(xpt,m_sc_inRun_basePRE,'color',colorBlue);
hold on;
patch([xpt, fliplr(xpt)],[m_sc_innoRun_basePRE-sem_sc_innoRun_basePRE;flipud(m_sc_innoRun_basePRE+sem_sc_innoRun_basePRE)]',colorGray,'LineStyle','none');
hold on;
plot(xpt,m_sc_innoRun_basePRE,'color',colorBlack);
ylabel('PV correlation','fontSize',fontM);
xlabel('Lap','fontSize',fontM);

hPlotRun(2) = axes('Position',axpt(3,3,1,2,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch([30 60, 60, 30], [-0.2 -0.2 1 1],colorLightYellow,'LineStyle','none');
hold on;
patch([xpt, fliplr(xpt)],[m_sc_inRun_baseSTIM-sem_sc_inRun_baseSTIM;flipud(m_sc_inRun_baseSTIM+sem_sc_inRun_baseSTIM)]',colorLightBlue,'LineStyle','none');
hold on;
plot(xpt,m_sc_inRun_baseSTIM,'color',colorBlue);
hold on;
patch([xpt, fliplr(xpt)],[m_sc_innoRun_baseSTIM-sem_sc_innoRun_baseSTIM;flipud(m_sc_innoRun_baseSTIM+sem_sc_innoRun_baseSTIM)]',colorGray,'LineStyle','none');
hold on;
plot(xpt,m_sc_innoRun_baseSTIM,'color',colorBlack);

hPlotRun(3) = axes('Position',axpt(3,3,1,3,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch([30 60, 60, 30], [-0.2 -0.2 1 1],colorLightYellow,'LineStyle','none');
hold on;
patch([xpt, fliplr(xpt)],[m_sc_inRun_basePOST-sem_sc_inRun_basePOST;flipud(m_sc_inRun_basePOST+sem_sc_inRun_basePOST)]',colorLightBlue,'LineStyle','none');
hold on;
plot(xpt,m_sc_inRun_basePOST,'color',colorBlue);
hold on;
patch([xpt, fliplr(xpt)],[m_sc_innoRun_basePOST-sem_sc_innoRun_basePOST;flipud(m_sc_innoRun_basePOST+sem_sc_innoRun_basePOST)]',colorGray,'LineStyle','none');
hold on;
plot(xpt,m_sc_innoRun_basePOST,'color',colorBlack);

hPlotRun(4) = axes('Position',axpt(3,3,2,1,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch([30 60, 60, 30], [-0.2 -0.2 1 1],colorLightYellow,'LineStyle','none');
hold on;
patch([xpt, fliplr(xpt)],[m_sc_outRun_basePRE-sem_sc_outRun_basePRE;flipud(m_sc_outRun_basePRE+sem_sc_outRun_basePRE)]',colorLightBlue,'LineStyle','none');
hold on;
plot(xpt,m_sc_outRun_basePRE,'color',colorBlue);
hold on;
patch([xpt, fliplr(xpt)],[m_sc_outnoRun_basePRE-sem_sc_outnoRun_basePRE;flipud(m_sc_outnoRun_basePRE+sem_sc_outnoRun_basePRE)]',colorGray,'LineStyle','none');
hold on;
plot(xpt,m_sc_outnoRun_basePRE,'color',colorBlack);

hPlotRun(5) = axes('Position',axpt(3,3,2,2,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch([30 60, 60, 30], [-0.2 -0.2 1 1],colorLightYellow,'LineStyle','none');
hold on;
patch([xpt, fliplr(xpt)],[m_sc_outRun_baseSTIM-sem_sc_outRun_baseSTIM;flipud(m_sc_outRun_baseSTIM+sem_sc_outRun_baseSTIM)]',colorLightBlue,'LineStyle','none');
hold on;
plot(xpt,m_sc_outRun_baseSTIM,'color',colorBlue);
hold on;
patch([xpt, fliplr(xpt)],[m_sc_outnoRun_baseSTIM-sem_sc_outnoRun_baseSTIM;flipud(m_sc_outnoRun_baseSTIM+sem_sc_outnoRun_baseSTIM)]',colorGray,'LineStyle','none');
hold on;
plot(xpt,m_sc_outnoRun_baseSTIM,'color',colorBlack);

hPlotRun(6) = axes('Position',axpt(3,3,2,3,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch([30 60, 60, 30], [-0.2 -0.2 1 1],colorLightYellow,'LineStyle','none');
hold on;
patch([xpt, fliplr(xpt)],[m_sc_outRun_basePOST-sem_sc_outRun_basePOST;flipud(m_sc_outRun_basePOST+sem_sc_outRun_basePOST)]',colorLightBlue,'LineStyle','none');
hold on;
plot(xpt,m_sc_outRun_basePOST,'color',colorBlue);
hold on;
patch([xpt, fliplr(xpt)],[m_sc_outnoRun_basePOST-sem_sc_outnoRun_basePOST;flipud(m_sc_outnoRun_basePOST+sem_sc_outnoRun_basePOST)]',colorGray,'LineStyle','none');
hold on;
plot(xpt,m_sc_outnoRun_basePOST,'color',colorBlack);

hPlotRun(7) = axes('Position',axpt(3,3,3,1,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch([30 60, 60, 30], [-0.2 -0.2 1 1],colorLightYellow,'LineStyle','none');
hold on;
patch([xpt, fliplr(xpt)],[m_sc_tRun_basePRE-sem_sc_tRun_basePRE; flipud(m_sc_tRun_basePRE+sem_sc_tRun_basePRE)]',colorLightBlue,'LineStyle','none');
hold on;
plot(xpt,m_sc_tRun_basePRE,'color',colorBlue);
hold on;
patch([xpt, fliplr(xpt)],[m_sc_tnoRun_basePRE-sem_sc_tnoRun_basePRE;flipud(m_sc_tnoRun_basePRE+sem_sc_tnoRun_basePRE)]',colorGray,'LineStyle','none');
hold on;
plot(xpt,m_sc_tnoRun_basePRE,'color',colorBlack);

hPlotRun(8) = axes('Position',axpt(3,3,3,2,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch([30 60, 60, 30], [-0.2 -0.2 1 1],colorLightYellow,'LineStyle','none');
hold on;
patch([xpt, fliplr(xpt)],[m_sc_tRun_baseSTIM-sem_sc_tRun_baseSTIM;flipud(m_sc_tRun_baseSTIM+sem_sc_tRun_baseSTIM)]',colorLightBlue,'LineStyle','none');
hold on;
plot(xpt,m_sc_tRun_baseSTIM,'color',colorBlue);
hold on;
patch([xpt, fliplr(xpt)],[m_sc_tnoRun_baseSTIM-sem_sc_tnoRun_baseSTIM;flipud(m_sc_tnoRun_baseSTIM+sem_sc_tnoRun_baseSTIM)]',colorGray,'LineStyle','none');
hold on;
plot(xpt,m_sc_tnoRun_baseSTIM,'color',colorBlack);

hPlotRun(9) = axes('Position',axpt(3,3,3,3,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch([30 60, 60, 30], [-0.2 -0.2 1 1],colorLightYellow,'LineStyle','none');
hold on;
patch([xpt, fliplr(xpt)],[m_sc_tRun_basePOST-sem_sc_tRun_basePOST;flipud(m_sc_tRun_basePOST+sem_sc_tRun_basePOST)]',colorLightBlue,'LineStyle','none');
hold on;
plot(xpt,m_sc_tRun_basePOST,'color',colorBlue);
hold on;
patch([xpt, fliplr(xpt)],[m_sc_tnoRun_basePOST-sem_sc_tnoRun_basePOST;flipud(m_sc_tnoRun_basePOST+sem_sc_tnoRun_basePOST)]',colorGray,'LineStyle','none');
hold on;
plot(xpt,m_sc_tnoRun_basePOST,'color',colorBlack);

set(hPlotRun,'TickDir','out','Box','off','XLim',[0,90],'YLim',[yLim(1) yLim(2)],'XTick',[0 30 60 90],'fontSize',fontM);
set(hPlotRun,'TickLength',[0.03, 0.03]);


hPlotRw(1) = axes('Position',axpt(3,3,1,1,axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch([30 60, 60, 30], [-0.2 -0.2 1 1],colorLightYellow,'LineStyle','none');
hold on;
patch([xpt, fliplr(xpt)],[m_sc_inRw_basePRE-sem_sc_inRw_basePRE;flipud(m_sc_inRw_basePRE+sem_sc_inRw_basePRE)]',colorLightBlue,'LineStyle','none');
hold on;
plot(xpt,m_sc_inRw_basePRE,'color',colorBlue);
hold on;
patch([xpt, fliplr(xpt)],[m_sc_innoRw_basePRE-sem_sc_innoRw_basePRE;flipud(m_sc_innoRw_basePRE+sem_sc_innoRw_basePRE)]',colorGray,'LineStyle','none');
hold on;
plot(xpt,m_sc_innoRw_basePRE,'color',colorBlack);
ylabel('PV correlation','fontSize',fontM);
xlabel('Lap','fontSize',fontM);

hPlotRw(2) = axes('Position',axpt(3,3,1,2,axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch([30 60, 60, 30], [-0.2 -0.2 1 1],colorLightYellow,'LineStyle','none');
hold on;
patch([xpt, fliplr(xpt)],[m_sc_inRw_baseSTIM-sem_sc_inRw_baseSTIM;flipud(m_sc_inRw_baseSTIM+sem_sc_inRw_baseSTIM)]',colorLightBlue,'LineStyle','none');
hold on;
plot(xpt,m_sc_inRw_baseSTIM,'color',colorBlue);
hold on;
patch([xpt, fliplr(xpt)],[m_sc_innoRw_baseSTIM-sem_sc_innoRw_baseSTIM;flipud(m_sc_innoRw_baseSTIM+sem_sc_innoRw_baseSTIM)]',colorGray,'LineStyle','none');
hold on;
plot(xpt,m_sc_innoRw_baseSTIM,'color',colorBlack);

hPlotRw(3) = axes('Position',axpt(3,3,1,3,axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch([30 60, 60, 30], [-0.2 -0.2 1 1],colorLightYellow,'LineStyle','none');
hold on;
patch([xpt, fliplr(xpt)],[m_sc_inRw_basePOST-sem_sc_inRw_basePOST;flipud(m_sc_inRw_basePOST+sem_sc_inRw_basePOST)]',colorLightBlue,'LineStyle','none');
hold on;
plot(xpt,m_sc_inRw_basePOST,'color',colorBlue);
hold on;
patch([xpt, fliplr(xpt)],[m_sc_innoRw_basePOST-sem_sc_innoRw_basePOST;flipud(m_sc_innoRw_basePOST+sem_sc_innoRw_basePOST)]',colorGray,'LineStyle','none');
hold on;
plot(xpt,m_sc_innoRw_basePOST,'color',colorBlack);

hPlotRw(4) = axes('Position',axpt(3,3,2,1,axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch([30 60, 60, 30], [-0.2 -0.2 1 1],colorLightYellow,'LineStyle','none');
hold on;
patch([xpt, fliplr(xpt)],[m_sc_outRw_basePRE-sem_sc_outRw_basePRE;flipud(m_sc_outRw_basePRE+sem_sc_outRw_basePRE)]',colorLightBlue,'LineStyle','none');
hold on;
plot(xpt,m_sc_outRw_basePRE,'color',colorBlue);
hold on;
patch([xpt, fliplr(xpt)],[m_sc_outnoRw_basePRE-sem_sc_outnoRw_basePRE;flipud(m_sc_outnoRw_basePRE+sem_sc_outnoRw_basePRE)]',colorGray,'LineStyle','none');
hold on;
plot(xpt,m_sc_outnoRw_basePRE,'color',colorBlack);

hPlotRw(5) = axes('Position',axpt(3,3,2,2,axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch([30 60, 60, 30], [-0.2 -0.2 1 1],colorLightYellow,'LineStyle','none');
hold on;
patch([xpt, fliplr(xpt)],[m_sc_outRw_baseSTIM-sem_sc_outRw_baseSTIM;flipud(m_sc_outRw_baseSTIM+sem_sc_outRw_baseSTIM)]',colorLightBlue,'LineStyle','none');
hold on;
plot(xpt,m_sc_outRw_baseSTIM,'color',colorBlue);
hold on;
patch([xpt, fliplr(xpt)],[m_sc_outnoRw_baseSTIM-sem_sc_outnoRw_baseSTIM;flipud(m_sc_outnoRw_baseSTIM+sem_sc_outnoRw_baseSTIM)]',colorGray,'LineStyle','none');
hold on;
plot(xpt,m_sc_outnoRw_baseSTIM,'color',colorBlack);

hPlotRw(6) = axes('Position',axpt(3,3,2,3,axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch([30 60, 60, 30], [-0.2 -0.2 1 1],colorLightYellow,'LineStyle','none');
hold on;
patch([xpt, fliplr(xpt)],[m_sc_outRw_basePOST-sem_sc_outRw_basePOST;flipud(m_sc_outRw_basePOST+sem_sc_outRw_basePOST)]',colorLightBlue,'LineStyle','none');
hold on;
plot(xpt,m_sc_outRw_basePOST,'color',colorBlue);
hold on;
patch([xpt, fliplr(xpt)],[m_sc_outnoRw_basePOST-sem_sc_outnoRw_basePOST;flipud(m_sc_outnoRw_basePOST+sem_sc_outnoRw_basePOST)]',colorGray,'LineStyle','none');
hold on;
plot(xpt,m_sc_outnoRw_basePOST,'color',colorBlack);

hPlotRw(7) = axes('Position',axpt(3,3,3,1,axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch([30 60, 60, 30], [-0.2 -0.2 1 1],colorLightYellow,'LineStyle','none');
hold on;
patch([xpt, fliplr(xpt)],[m_sc_tRw_basePRE-sem_sc_tRw_basePRE; flipud(m_sc_tRw_basePRE+sem_sc_tRw_basePRE)]',colorLightBlue,'LineStyle','none');
hold on;
plot(xpt,m_sc_tRw_basePRE,'color',colorBlue);
hold on;
patch([xpt, fliplr(xpt)],[m_sc_tnoRw_basePRE-sem_sc_tnoRw_basePRE;flipud(m_sc_tnoRw_basePRE+sem_sc_tnoRw_basePRE)]',colorGray,'LineStyle','none');
hold on;
plot(xpt,m_sc_tnoRw_basePRE,'color',colorBlack);

hPlotRw(8) = axes('Position',axpt(3,3,3,2,axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch([30 60, 60, 30], [-0.2 -0.2 1 1],colorLightYellow,'LineStyle','none');
hold on;
patch([xpt, fliplr(xpt)],[m_sc_tRw_baseSTIM-sem_sc_tRw_baseSTIM;flipud(m_sc_tRw_baseSTIM+sem_sc_tRw_baseSTIM)]',colorLightBlue,'LineStyle','none');
hold on;
plot(xpt,m_sc_tRw_baseSTIM,'color',colorBlue);
hold on;
patch([xpt, fliplr(xpt)],[m_sc_tnoRw_baseSTIM-sem_sc_tnoRw_baseSTIM;flipud(m_sc_tnoRw_baseSTIM+sem_sc_tnoRw_baseSTIM)]',colorGray,'LineStyle','none');
hold on;
plot(xpt,m_sc_tnoRw_baseSTIM,'color',colorBlack);

hPlotRw(9) = axes('Position',axpt(3,3,3,3,axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch([30 60, 60, 30], [-0.2 -0.2 1 1],colorLightYellow,'LineStyle','none');
hold on;
patch([xpt, fliplr(xpt)],[m_sc_tRw_basePOST-sem_sc_tRw_basePOST;flipud(m_sc_tRw_basePOST+sem_sc_tRw_basePOST)]',colorLightBlue,'LineStyle','none');
hold on;
plot(xpt,m_sc_tRw_basePOST,'color',colorBlue);
hold on;
patch([xpt, fliplr(xpt)],[m_sc_tnoRw_basePOST-sem_sc_tnoRw_basePOST;flipud(m_sc_tnoRw_basePOST+sem_sc_tnoRw_basePOST)]',colorGray,'LineStyle','none');
hold on;
plot(xpt,m_sc_tnoRw_basePOST,'color',colorBlack);

set(hPlotRw,'TickDir','out','Box','off','XLim',[0,90],'YLim',[yLim(1) yLim(2)],'XTick',[0 30 60 90],'fontSize',fontM);
set(hPlotRw,'TickLength',[0.03, 0.03]);
% print('-painters','-r300','-dtiff',['f_Neuron_PVCorr_',datestr(now,formatOut),'_50Hz_zone','.tif']);
% print('-painters','-r300','-depsc',['f_CellRepors_PVCorr_8Hz_',datestr(now,formatOut),'.ai']);
% close;