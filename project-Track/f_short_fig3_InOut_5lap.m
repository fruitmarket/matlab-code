clc; clearvars; close all;
% cd('D:\Dropbox\SNL\P2_Track'); % win version
load('D:\Dropbox\SNL\P2_Track\myParameters.mat');
formatOut = 'yymmdd';
markerS = markerS-1;

% load('neuronList_ori50hz_171224.mat');
load('D:\Dropbox\SNL\P2_Track\neuronList_ori50hz_180207.mat');

m_lapFrInPRE = cellfun(@(x) x(1),T.m_lapFrInzone); % PRE lap firing rate inzone
m_lapFrInSTM = cellfun(@(x) x(2),T.m_lapFrInzone); % PRE lap firing rate inzone
m_lapFrInPOST = cellfun(@(x) x(3),T.m_lapFrInzone); % PRE lap firing rate inzone

DRunPN = T.taskType == 'DRun' & T.idxNeurontype == 'PN';
% threshold condition
idx_pPRExSTM = cellfun(@(x) x(1,1)<0.05, T.p_ttestFR);  % Find mean firing rate p-value
idx_inc = m_lapFrInPRE < m_lapFrInSTM;
idx_dec = m_lapFrInPRE > m_lapFrInSTM; % STM block decreased neurons (inactivation)
min_lapFrInPRE_Run = min(m_lapFrInPRE(DRunPN & idx_dec & idx_pPRExSTM));
idx_Fr_Run = m_lapFrInPRE>=min_lapFrInPRE_Run; % min firing rate that can be detected by inactivation
neuronList = DRunPN & idx_Fr_Run;

fr_Inzone_Run = [m_lapFrInPRE(neuronList), m_lapFrInSTM(neuronList), m_lapFrInPOST(neuronList)];

inzoneFr_Run = T.lapFrInzone(neuronList); 
nRun = length(inzoneFr_Run);
lapMean_Run = cellfun(@(x) mean(reshape(x,5,[]),1),inzoneFr_Run,'UniformOutput',false);
lapMean_Run = cell2mat(lapMean_Run);

norm_lapMean_Run = lapMean_Run./repmat(fr_Inzone_Run(:,1),1,18);
m_norm_lapMean_Run = mean(norm_lapMean_Run);
sem_norm_lapMean_Run = std(norm_lapMean_Run)/sqrt(nRun);

%% Reward zone stimulation
DRwPN = T.taskType == 'DRw' & T.idxNeurontype == 'PN';
min_lapFrInPRE_Rw = min(m_lapFrInPRE(DRwPN & idx_dec & idx_pPRExSTM));
idx_Fr_Rw = m_lapFrInPRE>=min_lapFrInPRE_Rw; % min firing rate that can be detected by inactivation
neuronList = DRwPN & idx_Fr_Rw;

fr_Inzone_Rw = [m_lapFrInPRE(neuronList), m_lapFrInSTM(neuronList), m_lapFrInPOST(neuronList)];
inzoneFr_Rw = T.lapFrInzone(neuronList);
nRw = length(inzoneFr_Rw);

lapMean_Rw = cellfun(@(x) mean(reshape(x,5,[]),1),inzoneFr_Rw,'UniformOutput',false);
lapMean_Rw = cell2mat(lapMean_Rw);

norm_lapMean_Rw = lapMean_Rw./repmat(fr_Inzone_Rw(:,1),1,18);
m_norm_lapMean_Rw = mean(norm_lapMean_Rw);
sem_norm_lapMean_Rw = std(norm_lapMean_Rw)/sqrt(nRw);

%% plot
xpt = 1:18;
yLimRun = [0 2];
yLimRw = [0 2];
fHandle = figure('PaperUnits','centimeters','Paperposition',[0 0 4.5 4]);
hPlot(1) = axes('Position',axpt(3,2,1:2,1,[0.25 0.1 0.85 0.85],wideInterval));
patch([xpt, fliplr(xpt)],[m_norm_lapMean_Run+sem_norm_lapMean_Run, fliplr(m_norm_lapMean_Run-sem_norm_lapMean_Run)],colorGray,'lineStyle','none');
hold on;
plot(mean(norm_lapMean_Run),'color',colorBlack);
hold on;
patch([6.5 12.5 12.5 6.5],[0.05 0.05 0.15 0.15],colorLightBlue,'lineStyle','none');
ylabel('Normalized mean firing rate','fontSize',fontM);

hPlot(2) = axes('Position',axpt(3,2,1:2,2,[0.25 0.1 0.85 0.85],wideInterval));
patch([xpt, fliplr(xpt)],[m_norm_lapMean_Rw+sem_norm_lapMean_Rw, fliplr(m_norm_lapMean_Rw-sem_norm_lapMean_Rw)],colorGray,'lineStyle','none');
hold on;
plot(mean(norm_lapMean_Rw),'color',colorBlack);
hold on;
patch([6.5 12.5 12.5 6.5],[0.05 0.05 0.15 0.15],colorLightBlue,'lineStyle','none');
ylabel('Normalized mean firing rate','fontSize',fontM);

set(hPlot,'Box','off','TickDir','out','XLim',[0,19],'XTick',[3.5 9.5 15.5],'XTickLabel',{'PRE','STIM','POST'},'TickLength',[0.03 0.03],'fontSize',fontM);
set(hPlot(1),'YLim',yLimRun);
set(hPlot(2),'YLim',yLimRw);

print('-painters','-r300','-dtiff',['f_Neuron_fig2_InOutZoneLap_50hz_',datestr(now,formatOut),'.tif']);
print('-painters','-r300','-depsc',['f_Neuron_fig2_InOutZoneLap_50hz_',datestr(now,formatOut),'.ai']);
close;