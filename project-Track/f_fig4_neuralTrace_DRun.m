function f_fig4_neuralTrace_DRun
% Neural distance calculated by mahalanobis distance

% common part
clearvars;
rtDir = 'D:\Dropbox\SNL\P2_Track';
cd(rtDir);

load('D:\Dropbox\SNL\P2_Track\myParameters.mat');
load('neuronList_ori_170819.mat');
Txls = readtable('neuronList_ori_170819.xlsx');
Txls.taskType = categorical(Txls.taskType);
Txls.latencyIndex = categorical(Txls.latencyIndex);
formatOut = 'yymmdd';

% total population (DRunPN / DRunIN / DRwPN / DRwIN) with light responsiveness (light activated)
DRun_PN_total = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
DRun_PN_resp = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track;
DRun_PN_act = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == 1;
DRun_PN_ina = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == -1;
DRun_PN_noresp = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxpLR_Track;
DRun_PN_direct = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == 1 & Txls.latencyIndex == 'direct';
DRun_PN_indirect = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == 1 & Txls.latencyIndex == 'indirect';
DRun_PN_double = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == 1 & Txls.latencyIndex == 'double';

% peri = DRun_PN_ina & ~T.idxOverLapLengthSTM;
% center = DRun_PN_ina & T.idxOverLapLengthSTM;
% fileList = T.path(peri);
% cellID = T.cellID(peri);
% plot_Track_multi_v3_lightconfirm(fileList,cellID,'C:\Users\Jun\Desktop\peri');
% fileList = T.path(center);
% cellID = T.cellID(center);
% plot_Track_multi_v3_lightconfirm(fileList,cellID,'C:\Users\Jun\Desktop\center')

% peri = ~logical(T.idxOverLapLengthSTM(DRun_PN_ina)); % index of overlap
% center = logical(T.idxOverLapLengthSTM(DRun_PN_ina)); % index of overlap
%% Raw data
spikePsdPreD = cell2mat(T.spikePsdPreD);
spikePsdStmD = cell2mat(T.spikePsdStmD);
spikePsdPostD = cell2mat(T.spikePsdPostD);


spikeTotal = spikePsdStmD(DRun_PN_total,:);
spikeResp = spikePsdStmD(DRun_PN_resp,:);
spikeAct = spikePsdStmD(DRun_PN_act,:);
spikeIna = spikePsdStmD(DRun_PN_ina,:);
spikeNoresp = spikePsdStmD(DRun_PN_noresp,:);
spikeDirect = spikePsdStmD(DRun_PN_direct,:);
spikeIndirect = spikePsdStmD(DRun_PN_indirect,:);
spikeDouble = spikePsdStmD(DRun_PN_double,:);


[nTotal, nBin] = size(spikeTotal);
[nResp, ~] = size(spikeResp);
[nAct, ~] = size(spikeAct);
[nIna, ~] = size(spikeIna);
[nNoresp, ~] = size(spikeNoresp);
[nDirect, ~] = size(spikeDirect);
[nIndirect, ~] = size(spikeIndirect);
[nDouble, ~] = size(spikeDouble);

%% Smoothed data --> normalized --> spike sum / spike norm
[spikeSmthTotal, spikeSmthResp, spikeSmthAct, spikeSmthIna, spikeSmthNoresp, spikeSmthDirect, spikeSmthIndirect, spikeSmthDouble] = deal([]);
winWidth = 5;
for iCell = 1:nTotal
    spikeSmthTotal(iCell,:) = smooth(spikeTotal(iCell,:),winWidth);
end
for iCell = 1:nResp
    spikeSmthResp(iCell,:) = smooth(spikeResp(iCell,:),winWidth);
end
for iCell = 1:nAct
    spikeSmthAct(iCell,:) = smooth(spikeAct(iCell,:),winWidth);
end
for iCell = 1:nIna
    spikeSmthIna(iCell,:) = smooth(spikeIna(iCell,:),winWidth);
end
for iCell = 1:nNoresp
    spikeSmthNoresp(iCell,:) = smooth(spikeNoresp(iCell,:),winWidth);
end
for iCell = 1:nDirect
    spikeSmthDirect(iCell,:) = smooth(spikeDirect(iCell,:),winWidth);
end
for iCell = 1:nIndirect
    spikeSmthIndirect(iCell,:) = smooth(spikeIndirect(iCell,:),winWidth);
end
for iCell = 1:nDouble
    spikeSmthDouble(iCell,:) = smooth(spikeDouble(iCell,:),winWidth);
end

spikeSmthTotal = spikeSmthTotal(:,3:end-2);
spikeSmthResp = spikeSmthResp(:,3:end-2);
spikeSmthAct = spikeSmthAct(:,3:end-2);
spikeSmthIna = spikeSmthIna(:,3:end-2);
spikeSmthNoresp = spikeSmthNoresp(:,3:end-2);
spikeSmthDirect = spikeSmthDirect(:,3:end-2);
spikeSmthIndirect = spikeSmthIndirect(:,3:end-2);
spikeSmthDouble = spikeSmthDouble(:,3:end-2);

%% mean first then normalized
m_spikeTotal = mean(spikeSmthTotal,1);
m_spikeResp = mean(spikeSmthResp,1);
m_spikeAct = mean(spikeSmthAct,1);
m_spikeIna = mean(spikeSmthIna,1);
m_spikeNoresp = mean(spikeSmthNoresp,1);
m_spikeDirect = mean(spikeSmthDirect,1);
m_spikeIndirect = mean(spikeSmthIndirect,1);
m_spikeDouble = mean(spikeSmthDouble,1);

norm_m_spikeTotal = m_spikeTotal./repmat(mean(m_spikeTotal(:,1:10),2),1,120);
norm_m_spikeResp = m_spikeResp./repmat(mean(m_spikeResp(:,1:10),2),1,120);
norm_m_spikeAct = m_spikeAct./repmat(mean(m_spikeAct(:,1:10),2),1,120);
norm_m_spikeIna = m_spikeIna./repmat(mean(m_spikeIna(:,1:10),2),1,120);
norm_m_spikeNoresp = m_spikeNoresp./repmat(mean(m_spikeNoresp(:,1:10),2),1,120);
norm_m_spikeDirect = m_spikeDirect./repmat(mean(m_spikeDirect(:,1:10),2),1,120);
norm_m_spikeIndirect = m_spikeIndirect./repmat(mean(m_spikeIndirect(:,1:10),2),1,120);
norm_m_spikeDouble = m_spikeDouble./repmat(mean(m_spikeDouble(:,1:10),2),1,120);


%% reference figures
fHandle(1) = figure('PaperUnits','centimeters','PaperPosition',paperSize{2});
nCol = 2;
nRow = 1;
xpt = -10:109;
markerXS = 5;
yLim = max([norm_m_spikeTotal, norm_m_spikeResp, norm_m_spikeAct, norm_m_spikeIna, norm_m_spikeNoresp])*1.2;
%%
hPlot(1) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval),wideInterval));
plot(xpt,norm_m_spikeTotal,'-o','color',colorGray,'MarkerFaceColor',colorDarkGray,'markerSize',markerXS,'LineWidth',lineM);
hold on;
plot(xpt,norm_m_spikeResp,'-o','color',colorGreen,'MarkerFaceColor',colorDarkGreen,'markerSize',markerXS,'LineWidth',lineM);
hold on;
plot(xpt,norm_m_spikeAct,'-o','color',colorBlue,'MarkerFaceColor',colorDarkBlue,'markerSize',markerXS,'LineWidth',lineM);
hold on;
plot(xpt,norm_m_spikeIna,'-o','color',colorRed,'MarkerFaceColor',colorDarkRed,'markerSize',markerXS,'LineWidth',lineM);
hold on;
plot(xpt,norm_m_spikeNoresp,'-o','color',colorBlack,'MarkerFaceColor',colorDarkGray,'markerSize',markerXS,'LineWidth',lineM);
set(hPlot,'Box','off','TickDIr','out','XLim',[-10,110],'XTick',[-10:10:50,110],'YLim',[0, yLim]);
text(40, 6, ['Total (n = ',num2str(nTotal),')'],'color',colorDarkGray,'fontSize',fontL);
text(40, 5.5, ['Light modulated (n = ',num2str(nResp),')'],'color',colorGreen,'fontSize',fontL);
text(40, 5, ['Light activated (n = ',num2str(nAct),')'],'color',colorBlue,'fontSize',fontL);
text(40, 4.5, ['Light inactivated (n = ',num2str(nIna),')'],'color',colorRed,'fontSize',fontL);
text(40, 4, ['No response (n = ',num2str(nNoresp),')'],'color',colorBlack,'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Normalized mean spike','fontSize',fontL);

hPlot(2) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],wideInterval),wideInterval));
plot(xpt,norm_m_spikeDirect,'-o','color',colorBlack,'MarkerFaceColor',[230, 81, 0]./255,'markerSize',markerXS,'LineWidth',lineM);
hold on;
plot(xpt,norm_m_spikeIndirect,'-o','color',colorBlack,'MarkerFaceColor',[104, 159, 56]./255,'markerSize',markerXS,'LineWidth',lineM);
hold on;
plot(xpt,norm_m_spikeDouble,'-o','color',colorBlack,'MarkerFaceColor',[38, 50, 56]./255,'markerSize',markerXS,'LineWidth',lineM);
set(hPlot(2),'Box','off','TickDIr','out','XLim',[-10,110],'XTick',[-10:10:50,110],'YLim',[0, 30]);
text(40,25,['Direct response (n = ',num2str(nDirect),')'],'color',[230, 81, 0]./255,'fontSize',fontL);
text(40,23,['Indirect response (n = ',num2str(nIndirect),')'],'color',[104, 159, 56]./255,'fontSize',fontL);
text(40,21,['Double response (n = ',num2str(nDouble),')'],'color',[38, 50, 56]./255,'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Normalized mean spike','fontSize',fontL);

print('-painters','-r300','-dtiff',['final_fig4_track_neuralTrace_DRun_',datestr(now,formatOut),'.tif']);
close all;
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