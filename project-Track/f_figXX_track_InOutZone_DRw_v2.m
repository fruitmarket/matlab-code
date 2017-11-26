clearvars;

cd('D:\Dropbox\SNL\P2_Track'); % win version
% cd('/Users/Jun/Dropbox/SNL/P2_Track'); % mac version
Txls = readtable('neuronList_ori_171018.xlsx');
load('neuronList_ori_171018.mat');
load 'D:\Dropbox\SNL\P2_Track\myParameters.mat';
Txls.latencyIndex = categorical(Txls.latencyIndex);
formatOut = 'yymmdd';

DRwPN = T.taskType == 'DRw' & T.idxNeurontype == 'PN';

% inzone
m_lapFrInPRE = cellfun(@(x) x(1),T.m_lapFrInzone); % PRE lap firing rate inzone
m_lapFrInSTM = cellfun(@(x) x(2),T.m_lapFrInzone); % PRE lap firing rate inzone
m_lapFrInPOST = cellfun(@(x) x(3),T.m_lapFrInzone); % PRE lap firing rate inzone

idx_pPRExSTM = cellfun(@(x) x(1,1)<0.05, T.p_ttestFR);  % Find mean firing rate p-value

% threshold condition
idx_dec = m_lapFrInPRE > m_lapFrInSTM; % STM block decreased neurons (inactivation)
min_lapFrInPRE = min(m_lapFrInPRE(DRwPN & idx_dec & idx_pPRExSTM));
index_Fr = m_lapFrInPRE>min_lapFrInPRE; % min firing rate that can be detected by inactivation

fr_Inzone = [m_lapFrInPRE(DRwPN & index_Fr), m_lapFrInSTM(DRwPN & index_Fr), m_lapFrInPOST(DRwPN & index_Fr)];
nInzone = size(fr_Inzone,1);
m_frInZone = mean(fr_Inzone,1);
sem_frInZone = std(fr_Inzone,0,1)/sqrt(nInzone);

% outzone
m_lapFrOutPRE = cellfun(@(x) x(1),T.m_lapFrOutzone); % PRE lap firing rate inzone
m_lapFrOutSTM = cellfun(@(x) x(2),T.m_lapFrOutzone); % PRE lap firing rate inzone
m_lapFrOutPOST = cellfun(@(x) x(3),T.m_lapFrOutzone); % PRE lap firing rate inzone

idx_pPRExSTM = cellfun(@(x) x(1,1)<0.05, T.p_ttestFR);  % Find mean firing rate p-value

% threshold condition
idx_dec = m_lapFrOutPRE > m_lapFrOutSTM; % STM block decreased neurons (inactivation)
min_lapFrOutPRE = min(m_lapFrOutPRE(DRwPN & idx_dec & idx_pPRExSTM));
index_Fr = m_lapFrOutPRE>min_lapFrOutPRE; % min firing rate that can be detected by inactivation

fr_Outzone = [m_lapFrOutPRE(DRwPN & index_Fr), m_lapFrOutSTM(DRwPN & index_Fr), m_lapFrOutPOST(DRwPN & index_Fr)];
nOutzone = size(fr_Outzone,1);
m_frOutZone = mean(fr_Outzone,1);
sem_frOutZone = std(fr_Outzone,0,1)/sqrt(nOutzone);

%%
nCol = 2;
nRow = 2;

barWidth = 0.7;
xBar = [1,3,5];
xScatter8hzIn = (rand(nInzone,1)-0.5)*0.85*barWidth;
xScatter8hzOut = (rand(nOutzone,1)-0.5)*0.85*barWidth;
eBarWidth = 1;
yLim = [25,20];
fHandle = figure('PaperUnits','centimeters','PaperPosition',[0 0 8.5 8]);

%% 8 Hz
hPlot(1) = axes('Position',axpt(2,2,1,1,[0.1 0.1 0.85 0.85],wideInterval));
bar(xBar,m_frInZone,'BarWidth',0.6,'LineStyle','-','edgeColor',colorBlack,'FaceColor',colorDarkGray,'lineWidth',1);
hold on;
line([0 6],[min_lapFrInPRE, min_lapFrInPRE],'lineStyle',':','color',colorRed);
hold on;
plot(1+xScatter8hzIn,fr_Inzone(:,1),'LineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorGray,'markerEdgeColor',colorBlack);
hold on;
plot(3+xScatter8hzIn,fr_Inzone(:,2),'LineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorGray,'markerEdgeColor',colorBlack);
hold on;
plot(5+xScatter8hzIn,fr_Inzone(:,3),'LineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorGray,'markerEdgeColor',colorBlack);
hold on;
for iLine = 1:nInzone
    plot([1+xScatter8hzIn(iLine),3+xScatter8hzIn(iLine),5+xScatter8hzIn(iLine)],[fr_Inzone(iLine,1), fr_Inzone(iLine,2), fr_Inzone(iLine,3)],'lineStyle','-','color',colorGray);
    hold on;
end
errorbarJun(xBar,m_frInZone,sem_frInZone,0.4,eBarWidth,colorBlack);
text(1,yLim(1)*0.9,['FR threshold: ',num2str(min_lapFrInPRE,3),' Hz'],'color',colorRed,'fontSize',fontS);
text(5, yLim(1)*0.8,['n = ',num2str(nInzone)],'fontSize',fontS);
ylabel('Firing rate (Hz)','fontSize',fontS);
title('In-zone (DRwPN)','fontSize',fontS,'fontWeight','bold');

% 8hz Out-zone
hPlot(2) = axes('Position',axpt(2,2,2,1,[0.1 0.1 0.85 0.85],wideInterval));
bar(xBar,m_frOutZone,'BarWidth',0.6,'LineStyle','-','edgeColor',colorBlack,'FaceColor',colorDarkGray,'lineWidth',1);
hold on;
line([0 6],[min_lapFrOutPRE, min_lapFrOutPRE],'lineStyle',':','color',colorRed);
hold on;
plot(1+xScatter8hzOut,fr_Outzone(:,1),'LineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorGray,'markerEdgeColor',colorBlack);
hold on;
plot(3+xScatter8hzOut,fr_Outzone(:,2),'LineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorGray,'markerEdgeColor',colorBlack);
hold on;
plot(5+xScatter8hzOut,fr_Outzone(:,3),'LineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorGray,'markerEdgeColor',colorBlack);
hold on;
for iLine = 1:nOutzone
    plot([1+xScatter8hzOut(iLine),3+xScatter8hzOut(iLine),5+xScatter8hzOut(iLine)],[fr_Outzone(iLine,1), fr_Outzone(iLine,2), fr_Outzone(iLine,3)],'lineStyle','-','color',colorGray);
    hold on;
end
errorbarJun(xBar,m_frOutZone,sem_frOutZone,0.4,eBarWidth,colorBlack);
text(1,yLim(1)*0.9,['FR threshold: ',num2str(min_lapFrOutPRE,3),' Hz'],'color',colorRed,'fontSize',fontS);
text(5, yLim(1)*0.8,['n = ',num2str(nOutzone)],'fontSize',fontS);
ylabel('Firing rate (Hz)','fontSize',fontS);
title('Out-zone (DRwPN)','fontSize',fontS,'fontWeight','bold');

%% 50 Hz
Txls = readtable('neuronList_ori50hz_171014.xlsx');
load('neuronList_ori50hz_171014.mat');
load myParameters.mat;
Txls.latencyIndex = categorical(Txls.latencyIndex);

DRwPN = T.taskType == 'DRw' & T.idxNeurontype == 'PN';

% inzone
m_lapFrInPRE = cellfun(@(x) x(1),T.m_lapFrInzone); % PRE lap firing rate inzone
m_lapFrInSTM = cellfun(@(x) x(2),T.m_lapFrInzone); % PRE lap firing rate inzone
m_lapFrInPOST = cellfun(@(x) x(3),T.m_lapFrInzone); % PRE lap firing rate inzone

idx_pPRExSTM = cellfun(@(x) x(1,1)<0.05, T.p_ttestFR);  % Find mean firing rate p-value

% threshold condition
idx_dec = m_lapFrInPRE > m_lapFrInSTM; % STM block decreased neurons (inactivation)
min_lapFrInPRE = min(m_lapFrInPRE(DRwPN & idx_dec & idx_pPRExSTM));
index_Fr = m_lapFrInPRE>min_lapFrInPRE; % min firing rate that can be detected by inactivation

fr_Inzone = [m_lapFrInPRE(DRwPN & index_Fr), m_lapFrInSTM(DRwPN & index_Fr), m_lapFrInPOST(DRwPN & index_Fr)];
nInzone = size(fr_Inzone,1);
m_frInZone = mean(fr_Inzone,1);
sem_frInZone = std(fr_Inzone,0,1)/sqrt(nInzone);

% outzone
m_lapFrOutPRE = cellfun(@(x) x(1),T.m_lapFrOutzone); % PRE lap firing rate inzone
m_lapFrOutSTM = cellfun(@(x) x(2),T.m_lapFrOutzone); % PRE lap firing rate inzone
m_lapFrOutPOST = cellfun(@(x) x(3),T.m_lapFrOutzone); % PRE lap firing rate inzone

idx_pPRExSTM = cellfun(@(x) x(1,1)<0.05, T.p_ttestFR);  % Find mean firing rate p-value

% threshold condition
idx_dec = m_lapFrOutPRE > m_lapFrOutSTM; % STM block decreased neurons (inactivation)
min_lapFrOutPRE = min(m_lapFrOutPRE(DRwPN & idx_dec & idx_pPRExSTM));
index_Fr = m_lapFrOutPRE>min_lapFrOutPRE; % min firing rate that can be detected by inactivation

fr_Outzone = [m_lapFrOutPRE(DRwPN & index_Fr), m_lapFrOutSTM(DRwPN & index_Fr), m_lapFrOutPOST(DRwPN & index_Fr)];
nOutzone = size(fr_Outzone,1);
m_frOutZone = mean(fr_Outzone,1);
sem_frOutZone = std(fr_Outzone,0,1)/sqrt(nOutzone);

group = {'PRE','STM','POST'};
[p,~,stats] = kruskalwallis([fr_Inzone(:,1),fr_Inzone(:,2),fr_Inzone(:,3)],group,'off');
result_inSpk = multcompare(stats,'Alpha',0.05,'Display','off');
p_ttest(:,1) = result_inSpk(:,end); % p-value of in-zone

xScatter50hzIn = (rand(nInzone,1)-0.5)*0.85*barWidth;
xScatter50hzOut = (rand(nOutzone,1)-0.5)*0.85*barWidth;

hPlot(3) = axes('Position',axpt(2,2,1,2,[0.1 0.1 0.85 0.85],wideInterval));
bar(xBar,m_frInZone,'BarWidth',0.6,'LineStyle','-','edgeColor',colorBlack,'FaceColor',colorDarkGray,'lineWidth',1);
hold on;
line([0 6],[min_lapFrInPRE, min_lapFrInPRE],'lineStyle',':','color',colorRed);
hold on;
plot(1+xScatter50hzIn,fr_Inzone(:,1),'LineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorGray,'markerEdgeColor',colorBlack);
hold on;
plot(3+xScatter50hzIn,fr_Inzone(:,2),'LineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorGray,'markerEdgeColor',colorBlack);
hold on;
plot(5+xScatter50hzIn,fr_Inzone(:,3),'LineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorGray,'markerEdgeColor',colorBlack);
hold on;
for iLine = 1:nInzone
    plot([1+xScatter50hzIn(iLine),3+xScatter50hzIn(iLine),5+xScatter50hzIn(iLine)],[fr_Inzone(iLine,1), fr_Inzone(iLine,2), fr_Inzone(iLine,3)],'lineStyle','-','color',colorGray);
    hold on;
end
errorbarJun(xBar,m_frInZone,sem_frInZone,0.4,eBarWidth,colorBlack);
text(2,yLim(2)*0.8,['p = ',num2str(round(p_ttest(1)*1000)/1000)],'fontSize',fontS);
text(1,yLim(2)*0.9,['FR threshold: ',num2str(min_lapFrInPRE,3),' Hz'],'color',colorRed,'fontSize',fontS);
text(5, yLim(2)*0.8,['n = ',num2str(nInzone)],'fontSize',fontS);
ylabel('Firing rate (Hz)','fontSize',fontS);
title('In-zone (DRwPN)','fontSize',fontS,'fontWeight','bold');

% 50hz Out-zone
hPlot(4) = axes('Position',axpt(2,2,2,2,[0.1 0.1 0.85 0.85],wideInterval));
bar(xBar,m_frOutZone,'BarWidth',0.6,'LineStyle','-','edgeColor',colorBlack,'FaceColor',colorDarkGray,'lineWidth',1);
hold on;
line([0 6],[min_lapFrOutPRE, min_lapFrOutPRE],'lineStyle',':','color',colorRed);
hold on;
plot(1+xScatter50hzOut,fr_Outzone(:,1),'LineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorGray,'markerEdgeColor',colorBlack);
hold on;
plot(3+xScatter50hzOut,fr_Outzone(:,2),'LineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorGray,'markerEdgeColor',colorBlack);
hold on;
plot(5+xScatter50hzOut,fr_Outzone(:,3),'LineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorGray,'markerEdgeColor',colorBlack);
hold on;
for iLine = 1:nOutzone
    plot([1+xScatter50hzOut(iLine),3+xScatter50hzOut(iLine),5+xScatter50hzOut(iLine)],[fr_Outzone(iLine,1), fr_Outzone(iLine,2), fr_Outzone(iLine,3)],'lineStyle','-','color',colorGray);
    hold on;
end
errorbarJun(xBar,m_frOutZone,sem_frOutZone,0.4,eBarWidth,colorBlack);
text(1,yLim(2)*0.9,['FR threshold: ',num2str(min_lapFrOutPRE,3),' Hz'],'color',colorRed,'fontSize',fontS);
text(5, yLim(2)*0.8,['n = ',num2str(nOutzone)],'fontSize',fontS);
ylabel('Firing rate (Hz)','fontSize',fontS);
title('Out-zone (DRwPN)','fontSize',fontS,'fontWeight','bold');

set(hPlot,'Box','off','TickDir','out','XLim',[0,6],'XTick',[1,3,5],'XTickLabel',{'PRE','STM','POST'},'fontSize',fontS);
set(hPlot(1),'YLim',[0,yLim(1)]);
set(hPlot(2),'YLim',[0,yLim(1)]);
set(hPlot(3),'YLim',[0,yLim(2)]);
set(hPlot(4),'YLim',[0,yLim(2)]);

print('-painters','-r300','-dtiff',['final_figXX_InOutZone_DRw_v2_nonorm_',datestr(now,formatOut),'.tif']);
print('-painters','-r300','-depsc',['final_figXX_InOutZone_DRw_v2_nonorm_',datestr(now,formatOut),'.ai']);
close;