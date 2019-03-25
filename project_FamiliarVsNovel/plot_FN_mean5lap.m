clearvars;
rtDir = 'E:\Dropbox\SNL\P4_FamiliarNovel';
load('E:\Dropbox\SNL\P2_Track\myParameters.mat');
formatOut = 'yymmdd';
load('E:\Dropbox\SNL\P4_FamiliarNovel\neuronList_familiar_190107.mat');

m_lapFrInPRE = cellfun(@(x) x(1), T.m_lapFrInzone);
m_lapFrInSTIM = cellfun(@(x) x(2), T.m_lapFrInzone);
m_lapFrInPOST = cellfun(@(x) x(3), T.m_lapFrInzone);

PN = T.neuronType == 'PN';

idx_inc = T.idxmFrIn == 1;
idx_dec = T.idxmFrIn == -1; % STM block decreased neurons (inactivation)
min_lapFrInPRE = min(m_lapFrInPRE(PN & idx_dec));
idx_thrPass = m_lapFrInPRE>=min_lapFrInPRE; % <<<<<<<<<<<<<<< threshold; min firing rate that can be detected by inactivation

PN_thr = PN & idx_thrPass;

m_fr = [m_lapFrInPRE(PN), m_lapFrInSTIM(PN), m_lapFrInPOST(PN)];
m_fr_thr = [m_lapFrInPRE(PN_thr), m_lapFrInSTIM(PN_thr), m_lapFrInPOST(PN_thr)];

rawFr = T.lapFrInzone(PN);
n_rawFr = length(rawFr);
lap5mean = cellfun(@(x) mean(reshape(x,5,[]),1),rawFr,'UniformOutput',0);
lap5mean = cell2mat(lap5mean);

m_lap5mean = mean(lap5mean);
sem_lap5mean = std(lap5mean)/sqrt(n_rawFr);

% threshold applied
rawFr_thr = T.lapFrInzone(PN_thr);
n_rawFr_thr = length(rawFr_thr);
lap5mean_thr = cellfun(@(x) mean(reshape(x,5,[]),1),rawFr_thr,'UniformOutput',0);
lap5mean_thr = cell2mat(lap5mean_thr);

norm_lap5mean_thr = lap5mean_thr./repmat(m_fr_thr(:,1),1,size(lap5mean_thr,2));
m_norm_lap5mean_thr = mean(norm_lap5mean_thr);
sem_norm_lap5mean_thr = std(norm_lap5mean_thr)/sqrt(n_rawFr_thr);

%% plot

nCol = 2;
nRow = 2;
xpt = 1:18; % 18 points (18*5 = 90)

fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});

hPlot(1) = axes('Position',axpt(nCol,nRow,1,1,[],wideInterval));
patch([xpt, fliplr(xpt)],[m_lap5mean+sem_lap5mean, fliplr(m_lap5mean-sem_lap5mean)],colorGray,'lineStyle','none');
hold on;
plot(m_lap5mean,'color',colorBlack);
hold on;
patch([6.5 12.5 12.5 6.5],[0.05 0.05 0.15 0.15],colorLightBlue,'lineStyle','none');
ylabel('Mean firing rate (Hz)','fontSize',fontM);
text(0, 7.2, ['Threshold not applied (n = ',num2str(n_rawFr),')'],'fontSize',fontM);

hPlot(2) = axes('Position',axpt(nCol,nRow,1,2,[],wideInterval));
patch([xpt, fliplr(xpt)],[m_norm_lap5mean_thr+sem_norm_lap5mean_thr, fliplr(m_norm_lap5mean_thr-sem_norm_lap5mean_thr)],colorGray,'lineStyle','none');
hold on;
plot(m_norm_lap5mean_thr,'color',colorBlack);
hold on;
patch([6.5 12.5 12.5 6.5],[0.05 0.05 0.15 0.15],colorLightBlue,'lineStyle','none');
ylabel('Normalized mean firing rate','fontSize',fontM);
text(0, 5.2, ['Threshold applied (n = ',num2str(n_rawFr_thr),')'],'fontSize',fontM);

set(hPlot,'Box','off','TickDir','out','TickLength',[0.03 0.03],'XLim',[0,19],'XTick',[3.5 9.5 15.5],'XTIckLabel',{'PRE','STIM','POST'},'fontSize',fontM);
set(hPlot(1),'YLim',[0, 7]);
set(hPlot(2),'YLim',[0, 5],'YTick',0:5);

cd(rtDir);
print('-painters','-r300','-dtiff',['plot_familiar_lap5mean_',datestr(now,formatOut),'.tif']);
close all;