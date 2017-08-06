function gplot_neuralTrace_IndividualExample_v2
% Neural distance normalized by peak

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
pethTime = T.pethtimePsdPreD(testCell);
xptPETH = pethTime{1};

peth_DRunPN_PRE = T.pethPsdPreD(testCell);
peth_DRunPN_STM = T.pethPsdStmD(testCell);
peth_DRunPN_POST = T.pethPsdPostD(testCell);

%% Raw data
spikePsdPreD = cell2mat(T.spikePsdPreD);
spikePsdStmD = cell2mat(T.spikePsdStmD);
spikePsdPostD = cell2mat(T.spikePsdPostD);
nCell = size(spikePsdPreD,1);
nBin = size(spikePsdPreD,2);
%% Smoothed data
[spikeSmth_PRE, spikeSmth_STM, spikeSmth_POST] = deal(zeros(size(spikePsdPreD)));
winWidth = 5;
for iCell = 1:nCell
    spikeSmth_PRE(iCell,:) = smooth(spikePsdPreD(iCell,:),winWidth);
    spikeSmth_STM(iCell,:) = smooth(spikePsdStmD(iCell,:),winWidth);
    spikeSmth_POST(iCell,:) = smooth(spikePsdPostD(iCell,:),winWidth);
end

%% Normalized by peak
[norm_PRE, norm_STM, norm_POST] = deal(zeros(size(spikePsdPreD)));
for iCell = 1:nCell
    norm_PRE(iCell,:) = spikeSmth_PRE(iCell,:)./max(spikeSmth_PRE(iCell,:));
    norm_STM(iCell,:) = spikeSmth_STM(iCell,:)./max(spikeSmth_STM(iCell,:));
    norm_POST(iCell,:) = spikeSmth_POST(iCell,:)./max(spikeSmth_POST(iCell,:));    
end

%% Neural distance base (norm)
[norm_spikeBase_PRE, norm_spikeBase_STM, norm_spikeBase_POST] = deal(zeros(nCell,1));
for iCell = 1:nCell
    norm_spikeBase_PRE(iCell,1) = sum(norm_PRE(iCell,3:22))/20;
    norm_spikeBase_STM(iCell,1) = sum(norm_STM(iCell,3:22))/20;
    norm_spikeBase_POST(iCell,1) = sum(norm_POST(iCell,3:22))/20;
end

%% Neural distance test (norm)
[norm_neuralTrace_PRE, norm_neuralTrace_STM, norm_neuralTrace_POST] = deal(zeros(size(spikePsdPreD)));
for iCell = 1:nCell
    for iBin = 1:nBin
        norm_neuralTrace_PRE(iCell,iBin) = norm(norm_PRE(iCell,iBin)-norm_spikeBase_PRE(iCell,1));
        norm_neuralTrace_STM(iCell,iBin) = norm(norm_STM(iCell,iBin)-norm_spikeBase_STM(iCell,1));
        norm_neuralTrace_POST(iCell,iBin) = norm(norm_POST(iCell,iBin)-norm_spikeBase_POST(iCell,1));
    end
end
normNT_PRE_light = nanmean(norm_neuralTrace_PRE(DRun_PN_light,:),1);
normNT_PRE_act = nanmean(norm_neuralTrace_PRE(DRun_PN_act,:),1);
normNT_PRE_ina = nanmean(norm_neuralTrace_PRE(DRun_PN_ina,:),1);
normNT_PRE_no = nanmean(norm_neuralTrace_PRE(DRun_PN_no,:),1);

normNT_STM_light = nanmean(norm_neuralTrace_STM(DRun_PN_light,:),1);
normNT_STM_act = nanmean(norm_neuralTrace_STM(DRun_PN_act,:),1);
normNT_STM_ina = nanmean(norm_neuralTrace_STM(DRun_PN_ina,:),1);
normNT_STM_no = nanmean(norm_neuralTrace_STM(DRun_PN_no,:),1);

normNT_POST_light = nanmean(norm_neuralTrace_POST(DRun_PN_light,:),1);
normNT_POST_act = nanmean(norm_neuralTrace_POST(DRun_PN_act,:),1);
normNT_POST_ina = nanmean(norm_neuralTrace_POST(DRun_PN_ina,:),1);
normNT_POST_no = nanmean(norm_neuralTrace_POST(DRun_PN_no,:),1);

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

%% PCA
[d_PCA_PRE_light, scorePCA_PRE_light, latentPCA_PRE_light] = analysis_neuralDistPCA(spikeSmth_PRE(DRun_PN_light,:)');
[d_PCA_PRE_act, scorePCA_PRE_act, latentPCA_PRE_act] = analysis_neuralDistPCA(spikeSmth_PRE(DRun_PN_act,:)');
[d_PCA_PRE_ina, scorePCA_PRE_ina, latentPCA_PRE_ina] = analysis_neuralDistPCA(spikeSmth_PRE(DRun_PN_ina,:)');
[d_PCA_PRE_no, scorePCA_PRE_no, latentPCA_PRE_no] = analysis_neuralDistPCA(spikeSmth_PRE(DRun_PN_no,:)');

[d_PCA_STM_light, scorePCA_STM_light, latentPCA_STM_light] = analysis_neuralDistPCA(spikeSmth_STM(DRun_PN_light,:)');
[d_PCA_STM_act, scorePCA_STM_act, latentPCA_STM_act] = analysis_neuralDistPCA(spikeSmth_STM(DRun_PN_act,:)');
[d_PCA_STM_ina, scorePCA_STM_ina, latentPCA_STM_ina] = analysis_neuralDistPCA(spikeSmth_STM(DRun_PN_ina,:)');
[d_PCA_STM_no, scorePCA_STM_no, latentPCA_STM_no] = analysis_neuralDistPCA(spikeSmth_STM(DRun_PN_no,:)');

[d_PCA_POST_light, scorePCA_POST_light, latentPCA_POST_light] = analysis_neuralDistPCA(spikeSmth_POST(DRun_PN_light,:)');
[d_PCA_POST_act, scorePCA_POST_act, latentPCA_POST_act] = analysis_neuralDistPCA(spikeSmth_POST(DRun_PN_act,:)');
[d_PCA_POST_ina, scorePCA_POST_ina, latentPCA_POST_ina] = analysis_neuralDistPCA(spikeSmth_POST(DRun_PN_ina,:)');
[d_PCA_POST_no, scorePCA_POST_no, latentPCA_POST_no] = analysis_neuralDistPCA(spikeSmth_POST(DRun_PN_no,:)');


%%
fHandle(1) = figure('PaperUnits','centimeters','PaperPosition',[0 0 60 20]);
xpt = -22:101;
hTrace(1) = axes('Position',axpt(3,1,1,1,[0.1 0.1 0.85 0.85],wideInterval));
plot(xpt,normNT_PRE_light,'-o','color',colorLightGreen,'MarkerFaceColor',colorDarkGreen,'MarkerSize',markerL,'LineWidth',lineL);
hold on;
plot(xpt,normNT_PRE_act,'-o','color',colorLightBlue,'MarkerFaceColor',colorDarkBlue,'MarkerSize',markerL,'LineWidth',lineL);
hold on;
plot(xpt,normNT_PRE_ina,'-o','color',colorLightRed,'MarkerFaceColor',colorDarkRed,'MarkerSize',markerL,'LineWidth',lineL);
hold on;
plot(xpt,normNT_PRE_no,'-o','color',colorGray,'MarkerFaceColor',colorBlack,'MarkerSize',markerL,'LineWidth',lineL);
hold on;

hTrace(2) = axes('Position',axpt(3,1,2,1,[0.1 0.1 0.85 0.85],wideInterval));
plot(xpt,normNT_STM_light,'-o','color',colorLightGreen,'MarkerFaceColor',colorDarkGreen,'MarkerSize',markerL,'LineWidth',lineL);
hold on;
plot(xpt,normNT_STM_act,'-o','color',colorLightBlue,'MarkerFaceColor',colorDarkBlue,'MarkerSize',markerL,'LineWidth',lineL);
hold on;
plot(xpt,normNT_STM_ina,'-o','color',colorLightRed,'MarkerFaceColor',colorDarkRed,'MarkerSize',markerL,'LineWidth',lineL);
hold on;
plot(xpt,normNT_STM_no,'-o','color',colorGray,'MarkerFaceColor',colorBlack,'MarkerSize',markerL,'LineWidth',lineL);
hold on;
text(45,0.5,['Light resp. (n = ',num2str(sum(double(DRun_PN_light))),')'],'color',colorDarkGreen,'fontSize',fontL);
text(45,0.45,['Light act. (n = ',num2str(sum(double(DRun_PN_act))),')'],'color',colorDarkBlue,'fontSize',fontL);
text(45,0.4,['Light ina. (n = ',num2str(sum(double(DRun_PN_ina))),')'],'color',colorDarkRed,'fontSize',fontL);
text(45,0.35,['Light no. (n = ',num2str(sum(double(DRun_PN_no))),')'],'color',colorBlack,'fontSize',fontL);

hTrace(3) = axes('Position',axpt(3,1,3,1,[0.1 0.1 0.85 0.85],wideInterval));
plot(xpt,normNT_POST_light,'-o','color',colorLightGreen,'MarkerFaceColor',colorDarkGreen,'MarkerSize',markerL,'LineWidth',lineL);
hold on;
plot(xpt,normNT_POST_act,'-o','color',colorLightBlue,'MarkerFaceColor',colorDarkBlue,'MarkerSize',markerL,'LineWidth',lineL);
hold on;
plot(xpt,normNT_POST_ina,'-o','color',colorLightRed,'MarkerFaceColor',colorDarkRed,'MarkerSize',markerL,'LineWidth',lineL);
hold on;
plot(xpt,normNT_POST_no,'-o','color',colorGray,'MarkerFaceColor',colorBlack,'MarkerSize',markerL,'LineWidth',lineL);
hold on;

set(hTrace,'TickDir','out','Box','off','XLim',[-25,105],'YLim',[0, 0.5]);
print('-painters','-r300','-dtiff',[datestr(now,formatOut),'_neuralTrace_v2','.tif']);

%% PCA distance
fHandle(1) = figure('PaperUnits','centimeters','PaperPosition',[0 0 60 20]);
xpt = -22:101;
hTrace(1) = axes('Position',axpt(3,1,1,1,[0.1 0.1 0.85 0.85],wideInterval));
plot(xpt,d_PCA_PRE_light,'-o','color',colorLightGreen,'MarkerFaceColor',colorDarkGreen,'MarkerSize',markerL,'LineWidth',lineL);
hold on;
plot(xpt,d_PCA_PRE_act,'-o','color',colorLightBlue,'MarkerFaceColor',colorDarkBlue,'MarkerSize',markerL,'LineWidth',lineL);
hold on;
plot(xpt,d_PCA_PRE_ina,'-o','color',colorLightRed,'MarkerFaceColor',colorDarkRed,'MarkerSize',markerL,'LineWidth',lineL);
hold on;
plot(xpt,d_PCA_PRE_no,'-o','color',colorGray,'MarkerFaceColor',colorBlack,'MarkerSize',markerL,'LineWidth',lineL);
hold on;

hTrace(2) = axes('Position',axpt(3,1,2,1,[0.1 0.1 0.85 0.85],wideInterval));
plot(xpt,d_PCA_STM_light,'-o','color',colorLightGreen,'MarkerFaceColor',colorDarkGreen,'MarkerSize',markerL,'LineWidth',lineL);
hold on;
plot(xpt,d_PCA_STM_act,'-o','color',colorLightBlue,'MarkerFaceColor',colorDarkBlue,'MarkerSize',markerL,'LineWidth',lineL);
hold on;
plot(xpt,d_PCA_STM_ina,'-o','color',colorLightRed,'MarkerFaceColor',colorDarkRed,'MarkerSize',markerL,'LineWidth',lineL);
hold on;
plot(xpt,d_PCA_STM_no,'-o','color',colorGray,'MarkerFaceColor',colorBlack,'MarkerSize',markerL,'LineWidth',lineL);
hold on;
text(45,30,['Light resp. (n = ',num2str(sum(double(DRun_PN_light))),')'],'color',colorDarkGreen,'fontSize',fontL);
text(45,27,['Light act. (n = ',num2str(sum(double(DRun_PN_act))),')'],'color',colorDarkBlue,'fontSize',fontL);
text(45,24,['Light ina. (n = ',num2str(sum(double(DRun_PN_ina))),')'],'color',colorDarkRed,'fontSize',fontL);
text(45,21,['Light no. (n = ',num2str(sum(double(DRun_PN_no))),')'],'color',colorBlack,'fontSize',fontL);

hTrace(3) = axes('Position',axpt(3,1,3,1,[0.1 0.1 0.85 0.85],wideInterval));
plot(xpt,d_PCA_POST_light,'-o','color',colorLightGreen,'MarkerFaceColor',colorDarkGreen,'MarkerSize',markerL,'LineWidth',lineL);
hold on;
plot(xpt,d_PCA_POST_act,'-o','color',colorLightBlue,'MarkerFaceColor',colorDarkBlue,'MarkerSize',markerL,'LineWidth',lineL);
hold on;
plot(xpt,d_PCA_POST_ina,'-o','color',colorLightRed,'MarkerFaceColor',colorDarkRed,'MarkerSize',markerL,'LineWidth',lineL);
hold on;
plot(xpt,d_PCA_POST_no,'-o','color',colorGray,'MarkerFaceColor',colorBlack,'MarkerSize',markerL,'LineWidth',lineL);
hold on;

set(hTrace,'TickDir','out','Box','off','XLim',[-20,100],'YLim',[0, 35]);
print('-painters','-r300','-dtiff',[datestr(now,formatOut),'_neuralTracePCA_v2','.tif']);

%%
nCol = 3;
nRow = 5;
xpt2 = -20:100;
xpt2 = -22:101;
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
    hSmtPlot(1) = plot(xpt2,spikeSmth_PRE(iCell,:),'-o','color',colorBlack,'MarkerFaceColor',colorGray,'MarkerSize',markerS,'LineWidth',lineL);
    
    hNeuDist(1) = axes('Position',axpt(nCol,nRow,1,4,[0.1 0.1 0.80 0.80],wideInterval));
    plot(xpt2,neuralTrace_PRE(iCell,:),'-o','color',colorBlack,'MarkerFaceColor',colorGray,'MarkerSize',markerS,'LineWidth',lineL);

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
    hSmtPlot(2) = plot(xpt2,spikeSmth_STM(iCell,:),'-o','color',colorBlack,'MarkerFaceColor',colorGray,'MarkerSize',markerS,'LineWidth',lineL);
    title('Smoothed data','fontSize',fontM);
    
    hNeuDist(2) = axes('Position',axpt(nCol,nRow,2,4,[0.1 0.1 0.80 0.80],wideInterval));
    plot(xpt2,neuralTrace_STM(iCell,:),'-o','color',colorBlack,'MarkerFaceColor',colorGray,'MarkerSize',markerS,'LineWidth',lineL);
    
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
    hSmtPlot(3) = plot(xpt2,spikeSmth_POST(iCell,:),'-o','color',colorBlack,'MarkerFaceColor',colorGray,'MarkerSize',markerS,'LineWidth',lineL);
    
    hNeuDist(3) = axes('Position',axpt(nCol,nRow,3,4,[0.1 0.1 0.80 0.80],wideInterval));
    plot(xpt2,neuralTrace_POST(iCell,:),'-o','color',colorBlack,'MarkerFaceColor',colorGray,'MarkerSize',markerS,'LineWidth',lineL);
    
    set(hBar,'FaceColor',colorBlack,'EdgeColor','none');
    set(hPETH,'Box','off','TickDir','out','Xlim',[-22,102],'XTick',[-20,0:5:40,100],'fontSize',fontM);
    set(hRaw,'Box','off','TickDir','out','Xlim',[-22,102],'XTick',[-20,0:5:40,100],'fontSize',fontM);
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