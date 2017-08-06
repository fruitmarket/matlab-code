function gplot_neuralTrace_IndividualExample
% Latency of neurons which are activated on the platform. (Blue)
% Among neurons which are activated on the platform, latency of neurons
% which are also activated on the platform

% common part
clearvars;
rtDir = 'D:\Dropbox\SNL\P2_Track';
cd(rtDir);

load('D:\Dropbox\SNL\P2_Track\myParameters.mat');
load('neuronList_ori_170706.mat');
Txls = readtable('neuronList_ori_170706.xlsx');
Txls.taskType = categorical(Txls.taskType);
formatOut = 'yymmdd';

% total population (DRunPN / DRunIN / DRwPN / DRwIN) with light responsiveness (light activated)
DRun_PN = T.taskType == 'DRun' & T.idxNeurontype == 'PN';
DRun_IN = T.taskType == 'DRun' & T.idxNeurontype == 'IN';
DRun_UNC = T.taskType == 'DRun' & T.idxNeurontype == 'UNC';
alpha = 0.01;

DRun_PN_light = DRun_PN & T.pLR_Track<alpha;
DRun_PN_act = DRun_PN & T.pLR_Track<alpha & T.statDir_Track == 1;
DRun_PN_ina = DRun_PN & T.pLR_Track<alpha & T.statDir_Track == -1;
DRun_PN_no = DRun_PN & T.pLR_Track>=alpha;

%% Test population ?
testCell = DRun_PN_ina;
%% ID
cellID = T.cellID(testCell);

%% PETH
pethTime = T.pethtimeTrack8hz(testCell);
xptPETH = pethTime{1};

peth_DRunPN_PRE = T.pethPsdPre(testCell);
peth_DRunPN_STM = T.pethTrack8hz(testCell);
peth_DRunPN_POST = T.pethPsdPost(testCell);

%% Raw data
spikePsdPreD = cell2mat(T.spikePsdPreD(testCell));
spikePsdStmD = cell2mat(T.spikePsdStmD(testCell));
spikePsdPostD = cell2mat(T.spikePsdPostD(testCell));
nCell = size(spikePsdPreD,1);
nBin = size(spikePsdPreD,2);
%% Smoothed data
[spikeSmth_PRE, spikeSmth_STM, spikeSmth_POST] = deal(zeros(size(spikePsdPreD)));
winWidth = 5;
for iCell = 1:nCell
    spikeSmth_PRE(iCell,:) = smooth(spikePsdPreD(iCell,:),winWidth);
    spikeSmth_STM(iCell,:) = smooth(spikePsdStmD(iCell,:),winWidth);
    spikeSmth_POST(iCell,:) = smooth(spikePsdPostD(iCell,:),winWidth);
%     cellfun(@(x) smooth(x,winWidth)',spikePsdPreD,'UniformOutput',false);
%     spikeSmth_STM(iCell,:) = cellfun(@(x) smooth(x,winWidth)',spikePsdStmD,'UniformOutput',false);
%     spikeSmth_POST(iCell,:) = cellfun(@(x) smooth(x,winWidth)',spikePsdPostD,'UniformOutput',false);
end

%% Neural distance base
[spikeBase_PRE, spikeBase_STM, spikeBase_POST] = deal(zeros(nCell,1));
for iCell = 1:nCell
    spikeBase_PRE(iCell,1) = sum(spikeSmth_PRE(iCell,3:22))/20;
    spikeBase_STM(iCell,1) = sum(spikeSmth_STM(iCell,3:22))/20;
    spikeBase_POST(iCell,1) = sum(spikeSmth_POST(iCell,3:22))/20;
end
%% Neural distance test
[neuralTrace_PRE, neuralTrace_STM, neuralTrace_POST] = deal(zeros(size(spikePsdPreD)));
for iCell = 1:nCell
    for iBin = 1:nBin
        neuralTrace_PRE(iCell,iBin) = norm(spikeSmth_PRE(iCell,iBin)-spikeBase_PRE(iCell,1));
        neuralTrace_STM(iCell,iBin) = norm(spikeSmth_STM(iCell,iBin)-spikeBase_STM(iCell,1));
        neuralTrace_POST(iCell,iBin) = norm(spikeSmth_POST(iCell,iBin)-spikeBase_POST(iCell,1));
    end
end

%% neural trace
baseLine = [-22, -3]; %% first 2ms and last 2ms are dropped becaused of smoothing
[~, smthSpike_PRE, ~, ~, neuralDist_DRunPN_PRE, ~, pca_PRE, ~] = analysis_neuralTrace(spikePsdPreD,5,1,baseLine);
[~, smthSpike_STM, ~, ~, neuralDist_DRunPN_STM, ~, pca_STM, ~] = analysis_neuralTrace(spikePsdStmD,5,1,baseLine);
[~, smthSpike_POST, ~, ~, neuralDist_DRunPN_POST, ~, pca_POST, ~] = analysis_neuralTrace(spikePsdPostD,5,1,baseLine);

pca_PRE = pca_PRE(:,1:3);
pca_STM = pca_STM(:,1:3);
pca_POST = pca_POST(:,1:3);
nBin = size(pca_PRE,1);

for iBin = 1:nBin
    pcaDist_PRE(iBin) = sqrt(pca_PRE(iBin,1)^2+pca_PRE(iBin,2)^2+pca_PRE(iBin,3)^2);
    pcaDist_STM(iBin) = sqrt(pca_STM(iBin,1)^2+pca_STM(iBin,2)^2+pca_STM(iBin,3)^2);
    pcaDist_POST(iBin) = sqrt(pca_POST(iBin,1)^2+pca_POST(iBin,2)^2+pca_POST(iBin,3)^2);
end

%%
nCol = 3;
nRow = 5;
xpt = -20:100;
xpt2 = -22:102;
nCell = sum(double(testCell));
for iCell = 1:nCell
    fHandle(1) = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});

% PRE    
    hPETH(1) = axes('Position',axpt(nCol,nRow,1,1,[0.1 0.1 0.80 0.80],wideInterval));
    hBar(1) = bar(xptPETH, peth_DRunPN_PRE{iCell},'histc');
    xlabel('Time (ms)', 'fontSize', fontM);
    ylabel('Spikes/bin','fontSize',fontM);
    title('PRE block','fontSize',fontM);
    
    hRaw(1) = axes('Position',axpt(nCol,nRow,1,2,[0.1 0.1 0.80 0.80],wideInterval));
    hRawPlot(1) = plot(xpt2,spikePsdPreD(iCell,:),'-o','color',colorBlack,'MarkerFaceColor',colorGray,'MarkerSize',markerS,'LineWidth',lineL);
    
    hSmt(1) = axes('Position',axpt(nCol,nRow,1,3,[0.1 0.1 0.80 0.80],wideInterval));
    hSmtPlot(1) = plot(xpt2,smthSpike_PRE(iCell,:),'-o','color',colorBlack,'MarkerFaceColor',colorGray,'MarkerSize',markerS,'LineWidth',lineL);
    
    hNeuDist(1) = axes('Position',axpt(nCol,nRow,1,4,[0.1 0.1 0.80 0.80],wideInterval));
    plot(xpt,neuralDist_DRunPN_PRE(iCell,:),'-o','color',colorBlack,'MarkerFaceColor',colorGray,'MarkerSize',markerS,'LineWidth',lineL);

% STM
    hPETH(2) = axes('Position',axpt(nCol,nRow,2,1,[0.1 0.1 0.80 0.80],wideInterval));
    hBar(2) = bar(xptPETH, peth_DRunPN_STM{iCell},'histc');
    xlabel('Time (ms)', 'fontSize', fontM);
    ylabel('Spikes/bin','fontSize',fontM);
    title('STM block','fontSize',fontM);
    
    hRaw(2) = axes('Position',axpt(nCol,nRow,2,2,[0.1 0.1 0.80 0.80],wideInterval));
    hRawPlot(2) = plot(xpt2,spikePsdStmD(iCell,:),'-o','color',colorBlack,'MarkerFaceColor',colorGray,'MarkerSize',markerS,'LineWidth',lineL);
    title('Raw data','fontSize',fontM);
    
    hSmt(2) = axes('Position',axpt(nCol,nRow,2,3,[0.1 0.1 0.80 0.80],wideInterval));
    hSmtPlot(2) = plot(xpt2,smthSpike_STM(iCell,:),'-o','color',colorBlack,'MarkerFaceColor',colorGray,'MarkerSize',markerS,'LineWidth',lineL);
    title('Smoothed data','fontSize',fontM);
    
    hNeuDist(2) = axes('Position',axpt(nCol,nRow,2,4,[0.1 0.1 0.80 0.80],wideInterval));
    plot(xpt,neuralDist_DRunPN_STM(iCell,:),'-o','color',colorBlack,'MarkerFaceColor',colorGray,'MarkerSize',markerS,'LineWidth',lineL);

    xlabel('Time (ms)','fontSize',fontM);
    ylabel('Neural distance','fontSize',fontM);
    title('Neural Distance [DRun sessions]','fontSize',fontM);

% POST
    hPETH(3) = axes('Position',axpt(nCol,nRow,3,1,[0.1 0.1 0.80 0.80],wideInterval));
    hBar(3) = bar(xptPETH, peth_DRunPN_POST{iCell},'histc');
    xlabel('Time (ms)', 'fontSize', fontM);
    ylabel('Spikes/bin','fontSize',fontM);
    title('POST block','fontSize',fontM);
    
    hRaw(3) = axes('Position',axpt(nCol,nRow,3,2,[0.1 0.1 0.80 0.80],wideInterval));
    hRawPlot(3) = plot(xpt2,spikePsdPostD(iCell,:),'-o','color',colorBlack,'MarkerFaceColor',colorGray,'MarkerSize',markerS,'LineWidth',lineL);
    
    hSmt(3) = axes('Position',axpt(nCol,nRow,3,3,[0.1 0.1 0.80 0.80],wideInterval));
    hSmtPlot(3) = plot(xpt2,smthSpike_POST(iCell,:),'-o','color',colorBlack,'MarkerFaceColor',colorGray,'MarkerSize',markerS,'LineWidth',lineL);
    
    hNeuDist(3) = axes('Position',axpt(nCol,nRow,3,4,[0.1 0.1 0.80 0.80],wideInterval));
    plot(xpt,neuralDist_DRunPN_POST(iCell,:),'-o','color',colorBlack,'MarkerFaceColor',colorGray,'MarkerSize',markerS,'LineWidth',lineL);
    
    set(hBar,'FaceColor',colorBlack,'EdgeColor','none');
    set(hPETH,'Box','off','TickDir','out','Xlim',[-20,100],'XTick',[-20,0:5:40,100],'fontSize',fontM);
    set(hRaw,'Box','off','TickDir','out','Xlim',[-20,100],'XTick',[-20,0:5:40,100],'fontSize',fontM);
    set(hSmt,'Box','off','TickDir','out','Xlim',[-20,100],'XTick',[-20,0:5:40,100],'fontSize',fontM);
    set(hNeuDist,'Box','off','TickDir','out','Xlim',[-20,100],'XTick',[-20,0:5:40,100],'fontSize',fontM);

    cd('D:\Dropbox\SNL\P2_Track\analysis_neuralTrace\neuralTrace_ina');
    print('-painters','-r300','-dtiff',[datestr(now,formatOut),'_PETH_neuralTrace_',num2str(cellID(iCell)),'.tif']);
    close('all')
end

end

function [spike, smth_spike, m_neuralDist, sem_neuralDist, neuralDist, tracePCA, scorePCA, latentPCA] = analysis_neuralTrace(neuronList,winWidth,mvWinStep,baseLine)
% function analysis_neural Track calculates neural response distance and
% spike trace (by using PCA)
%   input: neuronList 1 x n cell array that each row represents spike times of each neuron 
%       winWidth: an range for window size
%       mvWinStep: moving Window step
%       baseLine: [x, y] start point and end point (unit: msec)
%   output:
%       m_neuralDist: mean neural dist of total neurons
%       neuralDist: each row represents neural dist of one neuron
%       tracePCA: pca results
%       scoePCA: now use score value
%       LatentPCA: representation proportion
%   Author: Joonyeup Lee
%   Version 1.0 (3/23/2017)

if nargin == 1
    winWidth = 5;
    mvWinStep = 1;
    baseLine = [-20, 0];
elseif nargin == 2 | nargin == 3 | nargin > 4
    error('Neural trace: The function needs four input elements.');
end

win = -22:mvWinStep:102;
% nBin = length(win)-1;
nBin = length(win);
nCell = size(neuronList,1);
[smth_spike,neuralDist] = deal(zeros(nCell,nBin));
m_neuralDist = zeros(nBin,1);

temp_spike = cellfun(@(x) histc(x,win),neuronList,'UniformOutput',false);
emptyIdx = find(cellfun(@isempty,temp_spike));

for iIdx = 1:length(emptyIdx)
    temp_spike{emptyIdx(iIdx)} = zeros(1,length(win));
end

spike = cell2mat(temp_spike);
% spike(:,end) = [];
for iCell = 1:nCell
   smth_spike(iCell,:) = smooth(spike(iCell,:),winWidth); % divided by winWidth
end
spikeBase = cellfun(@(x) sum(double(baseLine(1)<x & x<baseLine(2)))/abs(diff(baseLine)),neuronList); % firing rate (spikes/msec)
for iBin = 1:nBin
%     m_neuralDist(iBin,1) = norm(smth_spike(:,iBin)-spikeBase); %Euclidean distance
    for iCell = 1:nCell
        neuralDist(iCell,iBin) = norm(smth_spike(iCell,iBin)-spikeBase(iCell));
    end
end

% since five bins were averaged, first two and last two bins should be excluded.
% m_neuralDist = m_neuralDist(3:end-2)/nCell;
% m_neuralDist = m_neuralDist(3:end-2);
neuralDist = neuralDist(:,3:end-2);
m_neuralDist = mean(neuralDist,1);
sem_neuralDist = std(neuralDist,0,1)/sqrt(nCell);

[coeffPCA, scorePCA, latentPCA] = pca(smth_spike');
tracePCA = spike'*coeffPCA;
latentPCA = latentPCA/(sum(latentPCA))*100;
end