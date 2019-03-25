clearvars;

load('E:\Dropbox\Lab_mwjung\P2_Track\myParameters.mat');
formatOut = 'yymmdd';
load('E:\Dropbox\Lab_mwjung\P4_FamiliarNovel\neuronList_familiar_190301.mat');
PN = T.neuronType == 'PN';
tt_ca3bc = ((T.mouseID == 'rbp005' & (T.tetrode == 'TT1' | T.tetrode == 'TT5')) | (T.mouseID == 'rbp006' & T.tetrode == 'TT2') | (T.mouseID == 'rbp010' & T.tetrode == 'TT6')); % | (T.mouseID == 'rbp015' & T.tetrode == 'TT7')
PN_ca3bc = PN & tt_ca3bc;
PN_ca3a = PN & ~tt_ca3bc;

ca3a_act = PN_ca3a & T.idxmSpkIn == 1;
ca3a_inh = PN_ca3a & T.idxmSpkIn == -1;
ca3a_non = PN_ca3a & T.idxmSpkIn == 0;

ca3bc_act = PN_ca3bc & T.idxmSpkIn == 1;
ca3bc_inh = PN_ca3bc & T.idxmSpkIn == -1;
ca3bc_non = PN_ca3bc & T.idxmSpkIn == 0;

n_ca3a = sum(double(PN_ca3a));
n_ca3a_act = sum(double(ca3a_act));
n_ca3a_inh = sum(double(ca3a_inh));
n_ca3a_non = sum(double(ca3a_non));

n_ca3bc = sum(double(PN_ca3bc));
n_ca3bc_act = sum(double(ca3bc_act));
n_ca3bc_non = sum(double(ca3bc_non));

fr_ca3a_in = cell2mat(T.m_lapFrInzone(PN_ca3a));
fr_ca3a_in_act = cell2mat(T.m_lapFrInzone(ca3a_act));
fr_ca3a_in_inh = cell2mat(T.m_lapFrInzone(ca3a_inh));
fr_ca3a_in_non = cell2mat(T.m_lapFrInzone(ca3a_non));

fr_ca3bc_in = cell2mat(T.m_lapFrInzone(PN_ca3bc));
fr_ca3bc_in_act = cell2mat(T.m_lapFrInzone(ca3bc_act));
fr_ca3bc_in_non = cell2mat(T.m_lapFrInzone(ca3bc_non));

m_fr_ca3a_in = mean(cell2mat(T.m_lapFrInzone(PN_ca3a)),1); % ca3a
sem_fr_ca3a_in = std(cell2mat(T.m_lapFrInzone(PN_ca3a)),0,1)/sqrt(n_ca3a); % ca3a

m_fr_ca3bc_in = mean(cell2mat(T.m_lapFrInzone(PN_ca3bc)),1); % ca3a
sem_fr_ca3bc_in = std(cell2mat(T.m_lapFrInzone(PN_ca3bc)),0,1)/sqrt(n_ca3bc); % ca3a

[~,p_test(1)] = ttest(fr_ca3a_in(:,1),fr_ca3a_in(:,3));
p_test(2) = signrank(fr_ca3bc_in(:,1),fr_ca3bc_in(:,3));

%% plot
nCol = 1;
nRow = 2;
barWidth = 0.5;
eBarWidth = 1;
eBarLength = 0.2;
xpt = [0.8,2.2];
markerS = 3;

figSize = [0.3 0.2 0.65 0.75];
wideInterval = [0.11 0.2];
fHandle = figure('PaperUnits','centimeters','PaperPosition',[0 0 4 10]);

hPlot(1) = axes('Position',axpt(nCol,nRow,1,1,figSize,wideInterval));
    plot(xpt,[fr_ca3a_in(:,1),fr_ca3a_in(:,3)],'lineStyle','-','marker','none','color',colorDarkGray);
    hold on;
    errorbarJun(xpt,[m_fr_ca3a_in(1),m_fr_ca3a_in(3)],[sem_fr_ca3a_in(1),sem_fr_ca3a_in(3)],eBarLength,eBarWidth,colorBlack);
    hold on;
    plot(xpt,[m_fr_ca3a_in(1),m_fr_ca3a_in(3)],'lineStyle','-','lineWidth',1,'marker','o','markerSize',markerS,'color',colorBlack,'markerFaceColor',colorLightRed);
    text(2,20,['n = ',num2str(n_ca3a)],'fontSize',fontM);
    text(0,-6,['ttest: ',num2str(p_test(1),3)],'fontSize',fontM);
    ylabel('Firing rate (Hz)','fontSize',fontM);

hPlot(2) = axes('Position',axpt(nCol,nRow,1,2,figSize,wideInterval));
    plot(xpt,[fr_ca3bc_in(:,1),fr_ca3bc_in(:,3)],'lineStyle','-','marker','none','color',colorDarkGray);
    hold on;
    errorbarJun(xpt,[m_fr_ca3bc_in(1),m_fr_ca3bc_in(3)],[sem_fr_ca3bc_in(1),sem_fr_ca3bc_in(3)],eBarLength,eBarWidth,colorBlack);
    hold on;
    plot(xpt,[m_fr_ca3bc_in(1),m_fr_ca3bc_in(3)],'lineStyle','-','lineWidth',1,'marker','o','markerSize',markerS,'color',colorBlack,'markerFaceColor',colorLightRed);
    text(2,15,['n = ',num2str(n_ca3bc)],'fontSize',fontM);
    text(0,-5,['signRank: ',num2str(p_test(2),3)],'fontSize',fontM);
    ylabel('Firing rate (Hz)','fontSize',fontM);

% hPlot(1) = axes('Position',axpt(nCol,nRow,1,1,figSize,wideInterval));
%     hBar(1) = bar(xptBar,[m_fr_ca3a_in(2),m_fr_ca3a_in(4)],'barWidth',barWidth,'lineStyle','-','edgeColor',colorBlack,'faceColor',colorDarkGray,'lineWidth',1);
%     hold on;
%     errorbarJun(xptBar,[m_fr_ca3a_in(2),m_fr_ca3a_in(4)],[sem_fr_ca3a_in(2),sem_fr_ca3a_in(4)],eBarLength,eBarWidth,colorBlack);
%     text(2,3.5,['n = ',num2str(n_ca3a)],'fontSize',fontM);
%     
%     ylabel('Firing rate (Hz)','fontSize',fontM);
% 
% hPlot(2) = axes('Position',axpt(nCol,nRow,1,2,figSize,wideInterval));
%     hBar(2) = bar(xptBar,[m_fr_ca3bc_in(2),m_fr_ca3bc_in(4)],'barWidth',barWidth,'lineStyle','-','edgeColor',colorBlack,'faceColor',colorDarkGray,'lineWidth',1);
%     hold on;
%     errorbarJun(xptBar,[m_fr_ca3bc_in(2),m_fr_ca3bc_in(4)],[sem_fr_ca3bc_in(2),sem_fr_ca3bc_in(4)],eBarLength,eBarWidth,colorBlack);
%     text(2,3.5,['n = ',num2str(n_ca3bc)],'fontSize',fontM);
%     ylabel('Firing rate (Hz)','fontSize',fontM);
    
align_ylabel(hPlot,2.5,0);
set(hPlot,'Box','off','TickDir','out','TickLength',[0.03 0.03],'XLim',[0,3],'XTick',[0.8,2.2],'XTickLabel',{'PRE','POST'},'fontSize',fontM);
set(hPlot(1),'YLim',[-0.5,20],'YTick',[0:5:20]);
set(hPlot(2),'YLim',[-0.5,15],'YTick',[0:5:15]);

print('-painters','-r300','-dtiff',['supple4_mFR_familiar_',datestr(now,formatOut),'.tif']);
close all;