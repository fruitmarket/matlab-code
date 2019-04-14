clearvars;

load('D:\Dropbox\Lab_mwjung\P2_Track\myParameters.mat');
formatOut = 'yymmdd';
load('D:\Dropbox\Lab_mwjung\P4_FamiliarNovel\neuronList_novel_190301.mat');
T_nov = T;
pn_nov = T_nov.neuronType == 'PN';
in_nov = T_nov.neuronType == 'IN';
tt_ca3bc_nov = ((T_nov.mouseID == 'rbp005' & (T_nov.tetrode == 'TT1' | T_nov.tetrode == 'TT5')) | (T_nov.mouseID == 'rbp006' & T_nov.tetrode == 'TT2') | (T_nov.mouseID == 'rbp010' & T_nov.tetrode == 'TT6'));
ca3bc_nov = pn_nov & tt_ca3bc_nov;
ca3a_nov = pn_nov & ~tt_ca3bc_nov;

load('D:\Dropbox\Lab_mwjung\P4_FamiliarNovel\neuronList_familiar_190301.mat');
T_fam = T;
pn_fam = T_fam.neuronType == 'PN';
in_fam = T_fam.neuronType == 'IN';
tt_ca3bc_fam = ((T_fam.mouseID == 'rbp005' & (T_fam.tetrode == 'TT1' | T_fam.tetrode == 'TT5')) | (T_fam.mouseID == 'rbp006' & T_fam.tetrode == 'TT2') | (T_fam.mouseID == 'rbp010' & T_fam.tetrode == 'TT6'));
ca3bc_fam = pn_fam & tt_ca3bc_fam;
ca3a_fam = pn_fam & ~tt_ca3bc_fam;

%% mean firing rate of PN vs IN (Novel and Familiar)
n_pn_nov = sum(double(pn_nov));
mFR_pn_nov = T_nov.meanFR_Task(pn_nov);
m_mFR_pn_nov = mean(mFR_pn_nov);
sem_mFR_pn_nov = std(mFR_pn_nov)/sqrt(n_pn_nov);

% mFR_in_nov = T_nov.meanFR_Task(in_nov);
% m_mFR_in_nov = mean(mFR_in_nov);
% sem_mFR_in_nov = std(T_nov.meanFR_Task(in_nov))/sqrt(sum(double(in_nov)));

n_pn_fam = sum(double(pn_fam));
mFR_pn_fam = T_fam.meanFR_Task(pn_fam);
m_mFR_pn_fam = mean(mFR_pn_fam);
sem_mFR_pnfam = std(mFR_pn_fam)/sqrt(n_pn_fam);
 
% mFR_in_fam = T_fam.meanFR_Task(in_fam);
% m_mFR_in_fam = mean(mFR_in_fam);
% sem_mFR_in_fam = std(T_fam.meanFR_Task(in_fam))/sqrt(sum(double(in_fam)));

%% Mean & Peak firing rate of CA3a vs CA3bc (Novel and Familiar)
n_ca3a_nov = sum(double(ca3a_nov));
n_ca3bc_nov = sum(double(ca3bc_nov));
n_ca3a_fam = sum(double(ca3a_fam));
n_ca3bc_fam = sum(double(ca3bc_fam));

mFR_nov_all = T_nov.meanFR_Pre(pn_nov);
mFR_nov_ca3a = T_nov.meanFR_Pre(ca3a_nov);
mFR_nov_ca3bc = T_nov.meanFR_Pre(ca3bc_nov);
peakFR_nov_PRE = cellfun(@(x) max(x(2,:)), T_nov.pethconvSpatial);
peakFR_nov_all = peakFR_nov_PRE(pn_nov);
peakFR_nov_ca3a = peakFR_nov_PRE(ca3a_nov);
peakFR_nov_ca3bc = peakFR_nov_PRE(ca3bc_nov);

m_mFR_nov_all = mean(mFR_nov_all);
sem_mFR_nov_all = std(mFR_nov_all)/sqrt(n_pn_nov);
m_mFR_nov_ca3a = mean(mFR_nov_ca3a);
sem_mFR_nov_ca3a = std(mFR_nov_ca3a)/sqrt(n_ca3a_nov);
m_mFR_nov_ca3bc = mean(mFR_nov_ca3bc);
sem_mFR_nov_ca3bc = std(mFR_nov_ca3bc)/sqrt(n_ca3bc_nov);

m_peakFR_nov_all = mean(peakFR_nov_all);
sem_peakFR_nov_all = std(peakFR_nov_all)/sqrt(n_pn_nov);
m_peakFR_nov_ca3a = mean(peakFR_nov_ca3a);
sem_peakFR_nov_ca3a = std(peakFR_nov_ca3a)/sqrt(n_ca3a_nov);
m_peakFR_nov_ca3bc = mean(peakFR_nov_ca3bc);
sem_peakFR_nov_ca3bc = std(peakFR_nov_ca3bc)/sqrt(n_ca3bc_nov);

mFR_fam_all = T_fam.meanFR_Pre(pn_fam);
mFR_fam_ca3a = T_fam.meanFR_Pre(ca3a_fam);
mFR_fam_ca3bc = T_fam.meanFR_Pre(ca3bc_fam);
peakFR_fam_PRE = cellfun(@(x) max(x(1,:)), T_fam.pethconvSpatial);
peakFR_fam_all = peakFR_fam_PRE(pn_fam);
peakFR_fam_ca3a = peakFR_fam_PRE(ca3a_fam);
peakFR_fam_ca3bc = peakFR_fam_PRE(ca3bc_fam);

m_mFR_fam_all = mean(mFR_fam_all);
sem_mFR_fam_all = std(mFR_fam_all)/sqrt(n_pn_fam);
m_mFR_fam_ca3a = mean(mFR_fam_ca3a);
sem_mFR_fam_ca3a = std(mFR_fam_ca3a)/sqrt(n_ca3a_fam);
m_mFR_fam_ca3bc = mean(mFR_fam_ca3bc);
sem_mFR_fam_ca3bc = std(mFR_fam_ca3bc)/sqrt(n_ca3bc_fam);

m_peakFR_fam_all = mean(peakFR_fam_all);
sem_peakFR_fam_all = std(peakFR_fam_all)/sqrt(n_pn_fam);
m_peakFR_fam_ca3a = mean(peakFR_fam_ca3a);
sem_peakFR_fam_ca3a = std(peakFR_fam_ca3a)/sqrt(n_ca3a_fam);
m_peakFR_fam_ca3bc = mean(peakFR_fam_ca3bc);
sem_peakFR_fam_ca3bc = std(peakFR_fam_ca3bc)/sqrt(n_ca3bc_fam);

%% statistic
p_rs_mFR_nov = ranksum(mFR_nov_ca3a,mFR_nov_ca3bc);
p_rs_mFR_fam = ranksum(mFR_fam_ca3a,mFR_fam_ca3bc);
[~,p_t2_mFR_nf] = ttest2(mFR_nov_all, mFR_fam_all);

p_rs_peakFR_nov = ranksum(peakFR_nov_ca3a,peakFR_nov_ca3bc);
p_rs_peakFR_fam = ranksum(peakFR_fam_ca3a,peakFR_fam_ca3bc);
[~,p_t2_peakFR_nf] = ttest2(peakFR_nov_all, peakFR_fam_all);

%% plot
nCol = 3;
nRow = 2;
barWidth = 0.5;
eBarWidth = 1;
eBarLength = 0.2;
xpt = [0.8,2.2];

xptSct_nov = (rand(n_pn_nov,1)-0.5)*0.85*barWidth;
xptSct_ca3a_nov = (rand(n_ca3a_nov,1)-0.5)*0.85*barWidth;
xptSct_ca3bc_nov = (rand(n_ca3bc_nov,1)-0.5)*0.85*barWidth;
xptSct_fam = (rand(n_pn_fam,1)-0.5)*0.85*barWidth;
xptSct_ca3a_fam = (rand(n_ca3a_fam,1)-0.5)*0.85*barWidth;
xptSct_ca3bc_fam = (rand(n_ca3bc_fam,1)-0.5)*0.85*barWidth;

markerS = 3;

figSize = [0.1 0.1 0.77 0.8];
wideInterval = [0.15 0.2];
fHandle = figure('PaperUnits','centimeters','PaperPosition',[0 0 12 14]);

hPlot(1) = axes('Position',axpt(nCol,nRow,1,1,figSize,wideInterval));
    plot(xpt(1)+xptSct_ca3a_nov,mFR_nov_ca3a,'lineStyle','none','marker','o','markerSize',markerS-1,'color',colorDarkGray,'markerFaceColor',colorGray);
    hold on;
    plot(xpt(2)+xptSct_ca3bc_nov,mFR_nov_ca3bc,'lineStyle','none','marker','o','markerSize',markerS-1,'color',colorDarkGray,'markerFaceColor',colorGray);
    hold on;
    errorbarJun(xpt,[m_mFR_nov_ca3a, m_mFR_nov_ca3bc],[sem_mFR_nov_ca3a, m_mFR_nov_ca3bc],eBarLength,eBarWidth,colorBlack);
    hold on;
    plot(xpt,[m_mFR_nov_ca3a,m_mFR_nov_ca3bc],'lineStyle','-','lineWidth',1,'marker','o','markerSize',markerS,'color',colorBlack,'markerFaceColor',colorBlack);
    text(0.5,8.5,['Novel (n = ',num2str(n_ca3a_nov),'/',num2str(n_ca3bc_nov),')'],'fontSize',fontM);
    text(0,-2,['rank-sum: ',num2str(p_rs_mFR_nov,3)],'fontSize',fontM);
    ylabel('Mean firing rate (Hz)','fontSize',fontM);
    
hPlot(2) = axes('Position',axpt(nCol,nRow,2,1,figSize,wideInterval));
    plot(xpt(1)+xptSct_ca3a_fam,mFR_fam_ca3a,'lineStyle','none','marker','o','markerSize',markerS-1,'color',colorDarkGray,'markerFaceColor',colorGray);
    hold on;
    plot(xpt(2)+xptSct_ca3bc_fam,mFR_fam_ca3bc,'lineStyle','none','marker','o','markerSize',markerS-1,'color',colorDarkGray,'markerFaceColor',colorGray);
    hold on;
    errorbarJun(xpt,[m_mFR_fam_ca3a, m_mFR_fam_ca3bc],[sem_mFR_fam_ca3a, m_mFR_fam_ca3bc],eBarLength,eBarWidth,colorBlack);
    hold on;
    plot(xpt,[m_mFR_fam_ca3a,m_mFR_fam_ca3bc],'lineStyle','-','lineWidth',1,'marker','o','markerSize',markerS,'color',colorBlack,'markerFaceColor',colorBlack);
    text(0.5,8.5,['Familiar'],'fontSize',fontM);
    text(0,-2,['rank-sum: ',num2str(p_rs_mFR_fam,3)],'fontSize',fontM);
    ylabel('Mean firing rate (Hz)','fontSize',fontM);

hPlot(3) = axes('Position',axpt(nCol,nRow,3,1,figSize,wideInterval));
    plot(xpt(1)+xptSct_nov,mFR_nov_all,'lineStyle','none','marker','o','markerSize',markerS-1,'color',colorDarkGray,'markerFaceColor',colorGray);
    hold on;
    plot(xpt(2)+xptSct_fam,mFR_fam_all,'lineStyle','none','marker','o','markerSize',markerS-1,'color',colorDarkGray,'markerFaceColor',colorGray);
    hold on;
    errorbarJun(xpt,[m_mFR_nov_all, m_mFR_fam_all],[sem_mFR_nov_all, m_mFR_fam_all],eBarLength,eBarWidth,colorBlack);
    hold on;
    plot(xpt,[m_mFR_nov_all,m_mFR_fam_all],'lineStyle','-','lineWidth',1,'marker','o','markerSize',markerS,'color',colorBlack,'markerFaceColor',colorBlack);
    text(0.5,8.5,['n = ',num2str(n_pn_nov),'/',num2str(n_pn_fam)],'fontSize',fontM);
    text(1.5,7.5,'**','fontSize',10);
    text(0,-2,['ttest2: ',num2str(p_t2_mFR_nf,3)],'fontSize',fontM);
    ylabel('Mean firing rate (Hz)','fontSize',fontM);
    
hPlot(4) = axes('Position',axpt(nCol,nRow,1,2,figSize,wideInterval));
    plot(xpt(1)+xptSct_ca3a_nov,peakFR_nov_ca3a,'lineStyle','none','marker','o','markerSize',markerS-1,'color',colorDarkGray,'markerFaceColor',colorGray);
    hold on;
    plot(xpt(2)+xptSct_ca3bc_nov,peakFR_nov_ca3bc,'lineStyle','none','marker','o','markerSize',markerS-1,'color',colorDarkGray,'markerFaceColor',colorGray);
    hold on;
    errorbarJun(xpt,[m_peakFR_nov_ca3a, m_peakFR_nov_ca3bc],[sem_peakFR_nov_ca3a, m_peakFR_nov_ca3bc],eBarLength,eBarWidth,colorBlack);
    hold on;
    plot(xpt,[m_peakFR_nov_ca3a,m_peakFR_nov_ca3bc],'lineStyle','-','lineWidth',1,'marker','o','markerSize',markerS,'color',colorBlack,'markerFaceColor',colorBlack);
    text(0.5,55,['Novel (n = ',num2str(n_ca3a_nov),'/',num2str(n_ca3bc_nov),')'],'fontSize',fontM);
    text(0,-10,['rank-sum: ',num2str(p_rs_peakFR_nov,3)],'fontSize',fontM);
    ylabel('Peak firing rate (Hz)','fontSize',fontM);
    
hPlot(5) = axes('Position',axpt(nCol,nRow,2,2,figSize,wideInterval));
    plot(xpt(1)+xptSct_ca3a_fam,peakFR_fam_ca3a,'lineStyle','none','marker','o','markerSize',markerS-1,'color',colorDarkGray,'markerFaceColor',colorGray);
    hold on;
    plot(xpt(2)+xptSct_ca3bc_fam,peakFR_fam_ca3bc,'lineStyle','none','marker','o','markerSize',markerS-1,'color',colorDarkGray,'markerFaceColor',colorGray);
    hold on;
    errorbarJun(xpt,[m_peakFR_fam_ca3a, m_peakFR_fam_ca3bc],[sem_peakFR_fam_ca3a, m_peakFR_fam_ca3bc],eBarLength,eBarWidth,colorBlack);
    hold on;
    plot(xpt,[m_peakFR_fam_ca3a,m_peakFR_fam_ca3bc],'lineStyle','-','lineWidth',1,'marker','o','markerSize',markerS,'color',colorBlack,'markerFaceColor',colorBlack);
    text(0.5,55,['Familiar'],'fontSize',fontM);
    text(0,-10,['rank-sum: ',num2str(p_rs_peakFR_fam,3)],'fontSize',fontM);
    ylabel('Peak firing rate (Hz)','fontSize',fontM);

hPlot(6) = axes('Position',axpt(nCol,nRow,3,2,figSize,wideInterval));
    plot(xpt(1)+xptSct_nov,peakFR_nov_all,'lineStyle','none','marker','o','markerSize',markerS-1,'color',colorDarkGray,'markerFaceColor',colorGray);
    hold on;
    plot(xpt(2)+xptSct_fam,peakFR_fam_all,'lineStyle','none','marker','o','markerSize',markerS-1,'color',colorDarkGray,'markerFaceColor',colorGray);
    hold on;
    errorbarJun(xpt,[m_peakFR_nov_all, m_peakFR_fam_all],[sem_peakFR_nov_all, m_peakFR_fam_all],eBarLength,eBarWidth,colorBlack);
    hold on;
    plot(xpt,[m_peakFR_nov_all,m_peakFR_fam_all],'lineStyle','-','lineWidth',1,'marker','o','markerSize',markerS,'color',colorBlack,'markerFaceColor',colorBlack);
    text(0.5,55,['n = ',num2str(n_pn_nov),'/',num2str(n_pn_fam)],'fontSize',fontM);
    text(1.5,50,'**','fontSize',10);
    text(0,-10,['ttest2: ',num2str(p_t2_peakFR_nf,3)],'fontSize',fontM);
    ylabel('Peak firing rate (Hz)','fontSize',fontM);
    
set(hPlot,'Box','off','TickDir','out','TickLength',[0.03 0.03],'XLim',[0,3],'XTick',[0.8,2.2]);
set(hPlot(1:3),'YLim',[-0.5 8],'YTick',[0:8]);
set(hPlot(1:2),'XTickLabel',{'CA3a  '; '  CA3b/c'},'fontSize',fontM);
set(hPlot(3),'XTickLabel',{'Novel  ';'   Familiar'},'fontSize',fontM);
set(hPlot(4:6),'YLim',[-1 55],'YTick',[0:10:50]);
set(hPlot(4:5),'XTickLabel',{'CA3a  '; '  CA3b/c'},'fontSize',fontM);
set(hPlot(6),'XTickLabel',{'Novel  ';'   Familiar'},'fontSize',fontM);

print('-painters','-r300','-dtiff',['figX_fiirngrate_',datestr(now,formatOut),'.tif']);
close all;