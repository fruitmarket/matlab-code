clearvars;

load('E:\Dropbox\Lab_mwjung\P2_Track\myParameters.mat');
formatOut = 'yymmdd';
load('E:\Dropbox\Lab_mwjung\P4_FamiliarNovel\neuronList_novel_190301.mat');
T_nov = T;
PN = T_nov.neuronType == 'PN';
tt_ca3bc = ((T_nov.mouseID == 'rbp005' & (T_nov.tetrode == 'TT1' | T_nov.tetrode == 'TT5')) | (T_nov.mouseID == 'rbp006' & T_nov.tetrode == 'TT2') | (T_nov.mouseID == 'rbp010' & T_nov.tetrode == 'TT6')); % | (T_nov.mouseID == 'rbp015' & T_nov.tetrode == 'TT7')
PN_ca3bc = PN & tt_ca3bc;
PN_ca3a = PN & ~tt_ca3bc;

ca3a_nov_act = PN_ca3a & T_nov.idxmSpkIn == 1;
ca3a_nov_inh = PN_ca3a & T_nov.idxmSpkIn == -1;
ca3a_nov_non = PN_ca3a & T_nov.idxmSpkIn == 0;

ca3bc_nov_act = PN_ca3bc & T_nov.idxmSpkIn == 1;
ca3bc_nov_non = PN_ca3bc & T_nov.idxmSpkIn == 0;

n_ca3a_nov = sum(double(PN_ca3a));
n_ca3a_nov_act = sum(double(ca3a_nov_act));
n_ca3a_nov_inh = sum(double(ca3a_nov_inh));
n_ca3a_nov_non = sum(double(ca3a_nov_non));

n_ca3bc_nov = sum(double(PN_ca3bc));
n_ca3bc_nov_act = sum(double(ca3bc_nov_act));
n_ca3bc_nov_non = sum(double(ca3bc_nov_non));

fr_ca3a_nov_in = cell2mat(T_nov.m_lapFrInzone(PN_ca3a));
fr_ca3a_nov_in_act = cell2mat(T_nov.m_lapFrInzone(ca3a_nov_act));
fr_ca3a_nov_in_inh = cell2mat(T_nov.m_lapFrInzone(ca3a_nov_inh));
fr_ca3a_nov_in_non = cell2mat(T_nov.m_lapFrInzone(ca3a_nov_non));

fr_ca3bc_nov_in = cell2mat(T_nov.m_lapFrInzone(PN_ca3bc));
fr_ca3bc_nov_in_act = cell2mat(T_nov.m_lapFrInzone(ca3bc_nov_act));
fr_ca3bc_nov_in_non = cell2mat(T_nov.m_lapFrInzone(ca3bc_nov_non));

m_fr_ca3a_nov_in = mean(cell2mat(T_nov.m_lapFrInzone(PN_ca3a)),1); % ca3a
sem_fr_ca3a_nov_in = std(cell2mat(T_nov.m_lapFrInzone(PN_ca3a)),0,1)/sqrt(n_ca3a_nov); % ca3a

m_fr_ca3bc_nov_in = mean(cell2mat(T_nov.m_lapFrInzone(PN_ca3bc)),1); % ca3a
sem_fr_ca3bc_nov_in = std(cell2mat(T_nov.m_lapFrInzone(PN_ca3bc)),0,1)/sqrt(n_ca3bc_nov); % ca3a

[~,p_test_nov(1)] = ttest(fr_ca3a_nov_in(:,2),fr_ca3a_nov_in(:,4));
p_test_nov(2) = signrank(fr_ca3bc_nov_in(:,2),fr_ca3bc_nov_in(:,4));

%%
load('E:\Dropbox\Lab_mwjung\P4_FamiliarNovel\neuronList_familiar_190301.mat');
T_fam = T;
tt_ca3bc = ((T_fam.mouseID == 'rbp005' & (T_fam.tetrode == 'TT1' | T_fam.tetrode == 'TT5')) | (T_fam.mouseID == 'rbp006' & T_fam.tetrode == 'TT2') | (T_fam.mouseID == 'rbp010' & T_fam.tetrode == 'TT6')); % | (T_nov.mouseID == 'rbp015' & T_nov.tetrode == 'TT7')
PN = T_fam.neuronType == 'PN';
PN_ca3bc = PN & tt_ca3bc;
PN_ca3a = PN & ~tt_ca3bc;

ca3a_fam_act = PN_ca3a & T_fam.idxmSpkIn == 1;
ca3a_fam_inh = PN_ca3a & T_fam.idxmSpkIn == -1;
ca3a_fam_non = PN_ca3a & T_fam.idxmSpkIn == 0;

ca3bc_fam_act = PN_ca3bc & T_fam.idxmSpkIn == 1;
ca3bc_fam_inh = PN_ca3bc & T_fam.idxmSpkIn == -1;
ca3bc_fam_non = PN_ca3bc & T_fam.idxmSpkIn == 0;

n_ca3a_fam = sum(double(PN_ca3a));
n_ca3a_fam_act = sum(double(ca3a_fam_act));
n_ca3a_fam_inh = sum(double(ca3a_fam_inh));
n_ca3a_fam_non = sum(double(ca3a_fam_non));

n_ca3bc_fam = sum(double(PN_ca3bc));
n_ca3bc_fam_act = sum(double(ca3bc_fam_act));
n_ca3bc_fam_non = sum(double(ca3bc_fam_non));

fr_ca3a_fam_in = cell2mat(T.m_lapFrInzone(PN_ca3a));
fr_ca3a_fam_in_act = cell2mat(T.m_lapFrInzone(ca3a_fam_act));
fr_ca3a_fam_in_inh = cell2mat(T.m_lapFrInzone(ca3a_fam_inh));
fr_ca3a_fam_in_non = cell2mat(T.m_lapFrInzone(ca3a_fam_non));

fr_ca3bc_fam_in = cell2mat(T.m_lapFrInzone(PN_ca3bc));
fr_ca3bc_fam_in_act = cell2mat(T.m_lapFrInzone(ca3bc_fam_act));
fr_ca3bc_fam_in_non = cell2mat(T.m_lapFrInzone(ca3bc_fam_non));

m_fr_ca3a_fam_in = mean(cell2mat(T.m_lapFrInzone(PN_ca3a)),1); % ca3a
sem_fr_ca3a_fam_in = std(cell2mat(T.m_lapFrInzone(PN_ca3a)),0,1)/sqrt(n_ca3a_fam); % ca3a

m_fr_ca3bc_fam_in = mean(cell2mat(T.m_lapFrInzone(PN_ca3bc)),1); % ca3a
sem_fr_ca3bc_fam_in = std(cell2mat(T.m_lapFrInzone(PN_ca3bc)),0,1)/sqrt(n_ca3bc_fam); % ca3a

[~,p_test_fam(1)] = ttest(fr_ca3a_fam_in(:,1),fr_ca3a_fam_in(:,3));
p_test_fam(2) = signrank(fr_ca3bc_fam_in(:,1),fr_ca3bc_fam_in(:,3));

%% novel vs. familiar
% absolute value of the index
ab_ca3a_nov = (abs(fr_ca3a_nov_in(:,2)-fr_ca3a_nov_in(:,4)))./(fr_ca3a_nov_in(:,2)+fr_ca3a_nov_in(:,4));
ab_ca3a_fam = (abs(fr_ca3a_fam_in(:,1)-fr_ca3a_fam_in(:,3)))./(fr_ca3a_fam_in(:,1)+fr_ca3a_fam_in(:,3));
ab_ca3bc_nov = (abs(fr_ca3bc_nov_in(:,2)-fr_ca3bc_nov_in(:,4)))./(fr_ca3bc_nov_in(:,2)+fr_ca3bc_nov_in(:,4));
ab_ca3bc_fam = (abs(fr_ca3bc_fam_in(:,1)-fr_ca3bc_fam_in(:,3)))./(fr_ca3bc_fam_in(:,1)+fr_ca3bc_fam_in(:,3));

m_ab_ca3a = [nanmean(ab_ca3a_nov), nanmean(ab_ca3a_fam)];
sem_ab_ca3a = [nanstd(ab_ca3a_nov)/sqrt(sum(double(~isnan(ab_ca3a_nov)))), nanstd(ab_ca3a_fam)/sqrt(sum(double(~isnan(ab_ca3a_fam))))];
m_ab_ca3bc = [nanmean(ab_ca3bc_nov), nanmean(ab_ca3bc_fam)];
sem_ab_ca3bc = [nanstd(ab_ca3bc_nov)/sqrt(sum(double(~isnan(ab_ca3bc_nov)))), nanstd(ab_ca3bc_fam)/sqrt(sum(double(~isnan(ab_ca3bc_fam))))];

p_ca3bc_fn(1) = ranksum(ab_ca3a_nov,ab_ca3a_fam);
p_ca3bc_fn(2) = ranksum(ab_ca3bc_nov,ab_ca3bc_fam);

%% plot
nCol = 3;
nRow = 2;
barWidth = 0.5;
eBarWidth = 1;
eBarLength = 0.2;
xpt = [0.8,2.2];
xptScatter_ca3a_nov = (rand(n_ca3a_nov,1)-0.5)*0.85*barWidth;
xptScatter_ca3a_fam = (rand(n_ca3a_fam,1)-0.5)*0.85*barWidth;
xptScatter_ca3bc_nov = (rand(n_ca3bc_nov,1)-0.5)*0.85*barWidth;
xptScatter_ca3bc_fam = (rand(n_ca3bc_fam,1)-0.5)*0.85*barWidth;

markerS = 3;

figSize = [0.2 0.16 0.75 0.8];
wideInterval = [0.2 0.2];
fHandle = figure('PaperUnits','centimeters','PaperPosition',[0 0 12 14]);

hPlot(1) = axes('Position',axpt(nCol,nRow,1,1,figSize,wideInterval));
    plot(xpt,[fr_ca3a_nov_in(:,2),fr_ca3a_nov_in(:,4)],'lineStyle','-','marker','none','color',colorDarkGray);
    hold on;
    errorbarJun(xpt,[m_fr_ca3a_nov_in(2),m_fr_ca3a_nov_in(4)],[sem_fr_ca3a_nov_in(2),sem_fr_ca3a_nov_in(4)],eBarLength,eBarWidth,colorBlack);
    hold on;
    plot(xpt,[m_fr_ca3a_nov_in(2),m_fr_ca3a_nov_in(4)],'lineStyle','-','lineWidth',1,'marker','o','markerSize',markerS,'color',colorBlack,'markerFaceColor',colorLightRed);
    text(2,20,['n = ',num2str(n_ca3a_nov)],'fontSize',fontM);
    text(0,-6,['ttest: ',num2str(p_test_nov(1),3)],'fontSize',fontM);
    ylabel('Firing rate (Hz)','fontSize',fontM);

hPlot(2) = axes('Position',axpt(nCol,nRow,1,2,figSize,wideInterval));
    plot(xpt,[fr_ca3bc_nov_in(:,2),fr_ca3bc_nov_in(:,4)],'lineStyle','-','marker','none','color',colorDarkGray);
    hold on;
    errorbarJun(xpt,[m_fr_ca3bc_nov_in(2),m_fr_ca3bc_nov_in(4)],[sem_fr_ca3bc_nov_in(2),sem_fr_ca3bc_nov_in(4)],eBarLength,eBarWidth,colorBlack);
    hold on;
    plot(xpt,[m_fr_ca3bc_nov_in(2),m_fr_ca3bc_nov_in(4)],'lineStyle','-','lineWidth',1,'marker','o','markerSize',markerS,'color',colorBlack,'markerFaceColor',colorLightRed);
    text(2,15,['n = ',num2str(n_ca3bc_nov)],'fontSize',fontM);
    text(0,-5,['signRank: ',num2str(p_test_nov(2),3)],'fontSize',fontM);
    ylabel('Firing rate (Hz)','fontSize',fontM);

hPlot(3) = axes('Position',axpt(nCol,nRow,2,1,figSize,wideInterval));
    plot(xpt,[fr_ca3a_fam_in(:,1),fr_ca3a_fam_in(:,3)],'lineStyle','-','marker','none','color',colorDarkGray);
    hold on;
    errorbarJun(xpt,[m_fr_ca3a_fam_in(1),m_fr_ca3a_fam_in(3)],[sem_fr_ca3a_fam_in(1),sem_fr_ca3a_fam_in(3)],eBarLength,eBarWidth,colorBlack);
    hold on;
    plot(xpt,[m_fr_ca3a_fam_in(1),m_fr_ca3a_fam_in(3)],'lineStyle','-','lineWidth',1,'marker','o','markerSize',markerS,'color',colorBlack,'markerFaceColor',colorLightRed);
    text(2,20,['n = ',num2str(n_ca3a_fam)],'fontSize',fontM);
    text(0,-6,['ttest: ',num2str(p_test_fam(1),3)],'fontSize',fontM);
    ylabel('Firing rate (Hz)','fontSize',fontM);

hPlot(4) = axes('Position',axpt(nCol,nRow,2,2,figSize,wideInterval));
    plot(xpt,[fr_ca3bc_fam_in(:,1),fr_ca3bc_fam_in(:,3)],'lineStyle','-','marker','none','color',colorDarkGray);
    hold on;
    errorbarJun(xpt,[m_fr_ca3bc_fam_in(1),m_fr_ca3bc_fam_in(3)],[sem_fr_ca3bc_fam_in(1),sem_fr_ca3bc_fam_in(3)],eBarLength,eBarWidth,colorBlack);
    hold on;
    plot(xpt,[m_fr_ca3bc_fam_in(1),m_fr_ca3bc_fam_in(3)],'lineStyle','-','lineWidth',1,'marker','o','markerSize',markerS,'color',colorBlack,'markerFaceColor',colorLightRed);
    text(2,15,['n = ',num2str(n_ca3bc_fam)],'fontSize',fontM);
    text(0,-5,['signRank: ',num2str(p_test_fam(2),3)],'fontSize',fontM);
    ylabel('Firing rate (Hz)','fontSize',fontM);

hPlot(5) = axes('Position',axpt(nCol,nRow,3,1,figSize,wideInterval));
    plot(0.8+xptScatter_ca3a_nov,ab_ca3a_nov,'LineStyle','none','Marker','o','markerSize',markerS-1,'markerFaceColor',colorGray,'markerEdgeColor','none');
    hold on;
    plot(2.2+xptScatter_ca3a_fam,ab_ca3a_fam,'LineStyle','none','Marker','o','markerSize',markerS-1,'markerFaceColor',colorGray,'markerEdgeColor','none');
    hold on;
    errorbarJun([0.8,2.2],m_ab_ca3a,sem_ab_ca3a,eBarLength,eBarWidth,colorBlack);
    hold on;
    plot([0.8,2.2],m_ab_ca3a,'lineStyle','none','marker','o','markerSize',markerS,'markerFaceColor',colorDarkGray,'markerEdgeColor',colorBlack);
    text(1.5,1.2,'*','color',colorRed,'fontSize',fontL);
    text(0,-0.3,['ranksum: ',num2str(p_ca3bc_fn(1),3)],'fontSize',fontM);
    ylabel('Absolute value of difference','fontSize',fontM);
    
hPlot(6) = axes('Position',axpt(nCol,nRow,3,2,figSize,wideInterval));
    plot(0.8+xptScatter_ca3bc_nov,ab_ca3bc_nov,'LineStyle','none','Marker','o','markerSize',markerS-1,'markerFaceColor',colorGray,'markerEdgeColor','none');
    hold on;
    plot(2.2+xptScatter_ca3bc_fam,ab_ca3bc_fam,'LineStyle','none','Marker','o','markerSize',markerS-1,'markerFaceColor',colorGray,'markerEdgeColor','none');
    hold on;
    errorbarJun([0.8,2.2],m_ab_ca3bc,sem_ab_ca3bc,eBarLength,eBarWidth,colorBlack);
    hold on;
    plot([0.8,2.2],m_ab_ca3bc,'lineStyle','none','marker','o','markerSize',markerS,'markerFaceColor',colorDarkGray,'markerEdgeColor',colorBlack);
    text(0,-0.3,['ranksum: ',num2str(p_ca3bc_fn(2),3)],'fontSize',fontM);
    ylabel('Absolute value of difference','fontSize',fontM);
    
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
    
align_ylabel(hPlot,0.1,0);
set(hPlot,'Box','off','TickDir','out','TickLength',[0.03 0.03],'XLim',[0,3],'XTick',[0.8,2.2]);
set(hPlot(1),'YLim',[-0.5,20],'YTick',[0:5:20]);
set(hPlot(2),'YLim',[-0.5,15],'YTick',[0:5:15]);
set(hPlot(3),'YLim',[-0.5,20],'YTick',[0:5:20]);
set(hPlot(4),'YLim',[-0.5,15],'YTick',[0:5:15]);
set(hPlot(1:4),'XTickLabel',{'PRE','POST'},'fontSize',fontM);
set(hPlot(5:6),'YLim',[0,1.2],'YTick',[0:0.5:1]);
set(hPlot(5:6),'XTickLabel',{'Novel  ','  Familiar'},'fontSize',fontM);

print('-painters','-r300','-dtiff',['fig4_mFR_novel_',datestr(now,formatOut),'.tif']);
% print('-painters','-r300','-depsc',['fig4_mFR_novel_',datestr(now,formatOut),'.ai']);
close all;