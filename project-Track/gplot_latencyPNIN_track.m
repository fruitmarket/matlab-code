% Latency of neurons which are activated on the platform. (Blue)
% Among neurons which are activated on the platform, latency of neurons which are also activated on the track

% common part
clearvars;
lineColor = {[144, 164, 174]./255,... % Before stimulation
    [33 150 243]./ 255,... % During stimulation
    [38, 50, 56]./255}; % After stimulation

lineWth = [1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75];
fontS = 4; fontM = 6; fontL = 8; % font size large
lineS = 0.2; lineM = 0.5; lineL = 1; % line width large

colorBlue = [33, 150, 243]/255;
colorLightBlue = [100, 181, 246]/255;
colorLLightBlue = [187, 222, 251]/255;
colorRed = [237, 50, 52]/255;
colorLightRed = [242, 138, 130]/255;
colorGray = [189, 189, 189]/255;
colorGreen = [46, 125, 50]/255;
colorLightGray = [238, 238, 238]/255;
colorDarkGray = [117, 117, 117]/255;
colorYellow = [255, 243, 3]/255;
colorLightYellow = [255, 249, 196]/255;
colorPurple = [123, 31, 162]/255;
colorBlack = [0, 0, 0];

markerS = 2.2; markerM = 4.4; markerL = 6.6; markerXL = 8.8;
tightInterval = [0.02 0.02]; midInterval = [0.09, 0.09]; wideInterval = [0.14 0.14];
width = 0.7;

paperSize = {[0 0 21.0 29.7]; % A4_portrait
             [0 0 29.7 21.0]; % A4_landscape
             [0 0 15.7 21.0]; % A4_half landscape
             [0 0 21.6 27.9]}; % Letter

cd('D:\Dropbox\SNL\P2_Track');
Txls = readtable('neuronList_03-Mar-2017.xlsx');
load('neuronList_ori_09-Mar-2017.mat');

cri_meanFR = 7;
cri_peakFR = 0;
alpha = 0.01;

% TN: track neuron
DRunTN = (T.taskType == 'DRun') & (cellfun(@max, T.peakFR1D_track) > cri_peakFR);
DRwTN = (T.taskType == 'DRw') & (cellfun(@max, T.peakFR1D_track) > cri_peakFR);
noRunTN = (T.taskType == 'noRun') & (cellfun(@max, T.peakFR1D_track) > cri_peakFR);
noRwTN = (T.taskType == 'noRw') & (cellfun(@max, T.peakFR1D_track) > cri_peakFR);

% total population (DRunPN / DRunIN / DRwPN / DRwIN) with light responsiveness (light activated)
DRunPN_actRapid = DRunTN & T.meanFR_task<=cri_meanFR & T.pLR_Plfm2hz<alpha & T.statDir_Track == 1 & T.latencyTrack<10;
DRunPN_actDelay = DRunTN & T.meanFR_task<=cri_meanFR & T.pLR_Plfm2hz<alpha & T.statDir_Track == 1 & T.latencyTrack>10;
DRunPN_ina = DRunTN & T.meanFR_task<=cri_meanFR & T.pLR_Plfm2hz<alpha & T.statDir_Track == -1;
DRunPN_no = DRunTN & T.meanFR_task<=cri_meanFR & T.pLR_Plfm2hz>alpha;

DRunIN_actRapid = DRunTN & T.meanFR_task>cri_meanFR & T.pLR_Plfm2hz<alpha & T.statDir_Track == 1 & T.latencyTrack<10;
DRunIN_actDelay = DRunTN & T.meanFR_task>cri_meanFR & T.pLR_Plfm2hz<alpha & T.statDir_Track == 1 & T.latencyTrack>10;
DRunIN_ina = DRunTN & T.meanFR_task>cri_meanFR & T.pLR_Plfm2hz<alpha & T.statDir_Track == -1;
DRunIN_no = DRunTN & T.meanFR_task>cri_meanFR & T.pLR_Plfm2hz>alpha;

DRwPN_actRapid = DRwTN & T.meanFR_task<=cri_meanFR & T.pLR_Plfm2hz<alpha & T.statDir_Track == 1 & T.latencyTrack<10;
DRwPN_actDelay = DRwTN & T.meanFR_task<=cri_meanFR & T.pLR_Plfm2hz<alpha & T.statDir_Track == 1 & T.latencyTrack>10;
DRwPN_ina = DRwTN & T.meanFR_task<=cri_meanFR & T.pLR_Plfm2hz<alpha & T.statDir_Track == -1;
DRwPN_no = DRwTN & T.meanFR_task<=cri_meanFR & T.pLR_Plfm2hz>alpha;

DRwIN_actRapid = DRwTN & T.meanFR_task>cri_meanFR & T.pLR_Plfm2hz<alpha & T.statDir_Plfm2hz == 1 & T.latencyPlfm2hz<10;
DRwIN_actDelay = DRwTN & T.meanFR_task>cri_meanFR & T.pLR_Plfm2hz<alpha & T.statDir_Plfm2hz == 1 & T.latencyPlfm2hz>10;
DRwIN_ina = DRwTN & T.meanFR_task>cri_meanFR & T.pLR_Plfm2hz<alpha & T.statDir_Plfm2hz == -1;
DRwIN_no = DRwTN & T.meanFR_task>cri_meanFR & T.pLR_Plfm2hz>alpha;

%% PETH
DRunPN_actRapid_pethPlfm = cell2mat(T.pethPlfm2hz(DRunPN_actRapid));
DRunPN_actDelay_pethPlfm = cell2mat(T.pethPlfm2hz(DRunPN_actDelay));
DRunPN_ina_pethPlfm = cell2mat(T.pethPlfm2hz(DRunPN_ina));
DRunPN_no_pethPlfm = cell2mat(T.pethPlfm2hz(DRunPN_no));

DRunIN_actRapid_pethPlfm = cell2mat(T.pethPlfm2hz(DRunIN_actRapid));
DRunIN_actDelay_pethPlfm = cell2mat(T.pethPlfm2hz(DRunIN_actDelay));
DRunIN_ina_pethPlfm = cell2mat(T.pethPlfm2hz(DRunIN_ina));
DRunIN_no_pethPlfm = cell2mat(T.pethPlfm2hz(DRunIN_no));

DRwPN_actRapid_pethPlfm = cell2mat(T.pethPlfm2hz(DRwPN_actRapid));
DRwPN_actDelay_pethPlfm = cell2mat(T.pethPlfm2hz(DRwPN_actDelay));
DRwPN_ina_pethPlfm = cell2mat(T.pethPlfm2hz(DRwPN_ina));
DRwPN_no_pethPlfm = cell2mat(T.pethPlfm2hz(DRwPN_no));

DRwIN_actRapid_pethPlfm = cell2mat(T.pethPlfm2hz(DRwIN_actRapid));
DRwIN_actDelay_pethPlfm = cell2mat(T.pethPlfm2hz(DRwIN_actDelay));
DRwIN_ina_pethPlfm = cell2mat(T.pethPlfm2hz(DRwIN_ina));
DRwIN_no_pethPlfm = cell2mat(T.pethPlfm2hz(DRwIN_no));

%% Mean & Sem
n_DRunPN_actRapid_pethPlfm = size(DRunPN_actRapid_pethPlfm,1);
m_DRunPN_actRapid_pethPlfm = mean(DRunPN_actRapid_pethPlfm,1);
sem_DRunPN_actRapid_pethPlfm = std(DRunPN_actRapid_pethPlfm,1)/n_DRunPN_actRapid_pethPlfm;

n_DRunPN_actDelay_pethPlfm = size(DRunPN_actDelay_pethPlfm,1);
m_DRunPN_actDelay_pethPlfm = mean(DRunPN_actDelay_pethPlfm,1);
sem_DRunPN_actDelay_pethPlfm = std(DRunPN_actDelay_pethPlfm,1)/n_DRunPN_actDelay_pethPlfm;

n_DRunPN_ina_pethPlfm = size(DRunPN_ina_pethPlfm,1);
m_DRunPN_ina_pethPlfm = mean(DRunPN_ina_pethPlfm,1);
sem_DRunPN_ina_pethPlfm = std(DRunPN_ina_pethPlfm,1)/n_DRunPN_ina_pethPlfm;

n_DRunPN_no_pethPlfm = size(DRunPN_no_pethPlfm,1);
m_DRunPN_no_pethPlfm = mean(DRunPN_no_pethPlfm,1);
sem_DRunPN_no_pethPlfm = std(DRunPN_no_pethPlfm,1)/n_DRunPN_no_pethPlfm;

n_DRunIN_actRapid_pethPlfm = size(DRunIN_actRapid_pethPlfm,1);
m_DRunIN_actRapid_pethPlfm = mean(DRunIN_actRapid_pethPlfm,1);
sem_DRunIN_actRapid_pethPlfm = std(DRunIN_actRapid_pethPlfm,1)/n_DRunIN_actRapid_pethPlfm;

n_DRunIN_actDelay_pethPlfm = size(DRunIN_actDelay_pethPlfm,1);
% m_DRunIN_actDelay_pethPlfm = mean(DRunIN_actDelay_pethPlfm,1);
sem_DRunIN_actDelay_pethPlfm = std(DRunIN_actDelay_pethPlfm,1)/n_DRunIN_actDelay_pethPlfm;

n_DRunIN_ina_pethPlfm = size(DRunIN_ina_pethPlfm,1);
m_DRunIN_ina_pethPlfm = mean(DRunIN_ina_pethPlfm,1);
sem_DRunIN_ina_pethPlfm = std(DRunIN_ina_pethPlfm,1)/n_DRunIN_ina_pethPlfm;

n_DRunIN_no_pethPlfm = size(DRunIN_no_pethPlfm,1);
m_DRunIN_no_pethPlfm = mean(DRunIN_no_pethPlfm,1);
sem_DRunIN_no_pethPlfm = std(DRunIN_no_pethPlfm,1)/n_DRunIN_no_pethPlfm;

% DRw
n_DRwPN_actRapid_pethPlfm = size(DRwPN_actRapid_pethPlfm,1);
m_DRwPN_actRapid_pethPlfm = mean(DRwPN_actRapid_pethPlfm,1);
sem_DRwPN_actRapid_pethPlfm = std(DRwPN_actRapid_pethPlfm,1)/n_DRwPN_actRapid_pethPlfm;

n_DRwPN_actDelay_pethPlfm = size(DRwPN_actDelay_pethPlfm,1);
m_DRwPN_actDelay_pethPlfm = mean(DRwPN_actDelay_pethPlfm,1);
sem_DRwPN_actDelay_pethPlfm = std(DRwPN_actDelay_pethPlfm,1)/n_DRwPN_actDelay_pethPlfm;

n_DRwPN_ina_pethPlfm = size(DRwPN_ina_pethPlfm,1);
m_DRwPN_ina_pethPlfm = mean(DRwPN_ina_pethPlfm,1);
sem_DRwPN_ina_pethPlfm = std(DRwPN_ina_pethPlfm,1)/n_DRwPN_ina_pethPlfm;

n_DRwPN_no_pethPlfm = size(DRwPN_no_pethPlfm,1);
m_DRwPN_no_pethPlfm = mean(DRwPN_no_pethPlfm,1);
sem_DRwPN_no_pethPlfm = std(DRwPN_no_pethPlfm,1)/n_DRwPN_no_pethPlfm;

n_DRwIN_actRapid_pethPlfm = size(DRwIN_actRapid_pethPlfm,1);
m_DRwIN_actRapid_pethPlfm = mean(DRwIN_actRapid_pethPlfm,1);
sem_DRwIN_actRapid_pethPlfm = std(DRwIN_actRapid_pethPlfm,1)/n_DRwIN_actRapid_pethPlfm;

n_DRwIN_actDelay_pethPlfm = size(DRwIN_actDelay_pethPlfm,1);
m_DRwIN_actDelay_pethPlfm = mean(DRwIN_actDelay_pethPlfm,1);
sem_DRwIN_actDelay_pethPlfm = std(DRwIN_actDelay_pethPlfm,1)/n_DRwIN_actDelay_pethPlfm;

n_DRwIN_ina_pethPlfm = size(DRwIN_ina_pethPlfm,1);
m_DRwIN_ina_pethPlfm = mean(DRwIN_ina_pethPlfm,1);
sem_DRwIN_ina_pethPlfm = std(DRwIN_ina_pethPlfm,1)/n_DRwPN_ina_pethPlfm;
%%
nCol = 2;
nRow = 3;
xpt = T.pethtimePlfm2hz{2};
yMaxDRunPN = max([m_DRunPN_actRapid_pethPlfm, m_DRunPN_actDelay_pethPlfm, m_DRunPN_ina_pethPlfm, m_DRunPN_no_pethPlfm])*1.5;
yMaxDRunIN = max([m_DRunIN_actRapid_pethPlfm, m_DRunPN_actDelay_pethPlfm, m_DRunIN_ina_pethPlfm, m_DRunIN_no_pethPlfm])*1.5;
yMaxDRwPN = max([m_DRwPN_actRapid_pethPlfm, m_DRwPN_actDelay_pethPlfm, m_DRwPN_ina_pethPlfm, m_DRwPN_no_pethPlfm])*1.5;
yMaxDRwIN = max([m_DRwIN_actRapid_pethPlfm, m_DRwIN_actDelay_pethPlfm, m_DRwIN_ina_pethPlfm])*1.5;

fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1},'Name','latDistribution_PNIN_DRunPlfm');

hPlotDRunPN(1) = axes('Position',axpt(nCol,nRow,1,1,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxDRunPN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxDRunPN*0.925,10,yMaxDRunPN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRunPN(1) = bar(xpt,m_DRunPN_actRapid_pethPlfm,'histc');
errorbarJun(xpt+1,m_DRunPN_actRapid_pethPlfm,sem_DRunPN_actRapid_pethPlfm,1,0.4,colorBlack);
text(100, yMaxDRunPN*0.8,['n = ',num2str(n_DRunPN_actRapid_pethPlfm)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN: Rapid activated','fontSize',fontL,'fontWeight','bold');

hPlotDRunPN(2) = axes('Position',axpt(nCol,nRow,1,2,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxDRunPN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxDRunPN*0.925,10,yMaxDRunPN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRunPN(2) = bar(xpt,m_DRunPN_actDelay_pethPlfm,'histc');
errorbarJun(xpt+1,m_DRunPN_actDelay_pethPlfm,sem_DRunPN_actDelay_pethPlfm,1,0.4,colorBlack);
text(100, yMaxDRunPN*0.8,['n = ',num2str(n_DRunPN_actDelay_pethPlfm)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN: Delay activated','fontSize',fontL,'fontWeight','bold');

hPlotDRunPN(3) = axes('Position',axpt(nCol,nRow,1,3,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxDRunPN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxDRunPN*0.925,10,yMaxDRunPN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRunPN(3) = bar(xpt,m_DRunPN_ina_pethPlfm,'histc');
errorbarJun(xpt+1,m_DRunPN_ina_pethPlfm,sem_DRunPN_ina_pethPlfm,1,0.4,colorBlack);
text(100, yMaxDRunPN*0.8,['n = ',num2str(n_DRunPN_ina_pethPlfm)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN: inactivated','fontSize',fontL,'fontWeight','bold');

% hPlotDRunPN(4) = axes('Position',axpt(nCol,nRow,1,4,[0.10 0.10 0.85 0.8],wideInterval));
% bar(5,yMaxDRunPN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
% hold on;
% rectangle('Position',[0,yMaxDRunPN*0.925,10,yMaxDRunPN*0.075],'LineStyle','none','FaceColor',colorBlue);
% hold on;
% hBarDRunPN(4) = bar(xpt,m_DRunPN_no_pethPlfm,'histc');
% errorbarJun(xpt+1,m_DRunPN_no_pethPlfm,sem_DRunPN_no_pethPlfm,1,0.4,colorBlack);
% text(100, 20*0.8,['n = ',num2str(n_DRunPN_no_pethPlfm)],'fontSize',fontL);
% xlabel('Time (ms)','fontSize',fontL);
% ylabel('Spikes/bin','fontSize',fontL);
% title('PN: no response','fontSize',fontL,'fontWeight','bold');

hPlotDRunIN(1) = axes('Position',axpt(nCol,nRow,2,1,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxDRunIN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxDRunIN*0.925,10,yMaxDRunIN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRunIN(1) = bar(xpt,m_DRunIN_actRapid_pethPlfm,'histc');
errorbarJun(xpt+1,m_DRunIN_actRapid_pethPlfm,sem_DRunIN_actRapid_pethPlfm,1,0.4,colorBlack);
text(100, yMaxDRunIN*0.8,['n = ',num2str(n_DRunIN_actRapid_pethPlfm)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('IN: Rapid activated','fontSize',fontL,'fontWeight','bold');

% hPlotDRunIN(2) = axes('Position',axpt(nCol,nRow,2,2,[0.10 0.10 0.85 0.8],wideInterval));
% bar(5,yMaxDRunIN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
% hold on;
% rectangle('Position',[0,yMaxDRunIN*0.925,10,yMaxDRunIN*0.075],'LineStyle','none','FaceColor',colorBlue);
% hold on;
% hBarDRunIN(2) = bar(xpt,m_DRunIN_actDelay_pethPlfm,'histc');
% errorbarJun(xpt+1,m_DRunIN_actDelay_pethPlfm,sem_DRunIN_actDelay_pethPlfm,1,0.4,colorBlack);
% text(100, yMaxDRunIN*0.8,['n = ',num2str(n_DRunIN_actDelay_pethPlfm)],'fontSize',fontL);
% xlabel('Time (ms)','fontSize',fontL);
% ylabel('Spikes/bin','fontSize',fontL);
% title('IN: Delay activated','fontSize',fontL,'fontWeight','bold');

hPlotDRunIN(2) = axes('Position',axpt(nCol,nRow,2,3,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxDRunIN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxDRunIN*0.925,10,yMaxDRunIN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRunIN(2) = bar(xpt,m_DRunIN_ina_pethPlfm,'histc');
errorbarJun(xpt+1,m_DRunIN_ina_pethPlfm,sem_DRunIN_ina_pethPlfm,1,0.4,colorBlack);
text(100, yMaxDRunIN*0.8,['n = ',num2str(n_DRunIN_ina_pethPlfm)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('IN: inactivated','fontSize',fontL,'fontWeight','bold');

% hPlotDRunIN(4) = axes('Position',axpt(nCol,nRow,2,4,[0.10 0.10 0.85 0.8],wideInterval));
% bar(5,yMaxDRunIN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
% hold on;
% rectangle('Position',[0,yMaxDRunIN*0.925,10,yMaxDRunIN*0.075],'LineStyle','none','FaceColor',colorBlue);
% hold on;
% hBarDRunIN(4) = bar(xpt,m_DRunIN_no_pethPlfm,'histc');
% errorbarJun(xpt+1,m_DRunIN_no_pethPlfm,sem_DRunIN_no_pethPlfm,1,0.4,colorBlack);
% text(100, 20*0.8,['n = ',num2str(n_DRunIN_no_pethPlfm)],'fontSize',fontL);
% xlabel('Time (ms)','fontSize',fontL);
% ylabel('Spikes/bin','fontSize',fontL);
% title('IN: no response','fontSize',fontL,'fontWeight','bold');

set(hBarDRunPN,'FaceColor',colorDarkGray,'EdgeColor','none');
set(hBarDRunIN,'FaceColor',colorDarkGray,'EdgeColor','none');
set(hPlotDRunPN,'Box','off','TickDir','out','XLim',[-20 130],'XTick',[-20,0:5:20,130],'YLim',[0, yMaxDRunPN],'fontSize',fontM);
set(hPlotDRunIN,'Box','off','TickDir','out','XLim',[-20 130],'XTick',[-20,0:5:20,130],'YLim',[0, yMaxDRunIN],'fontSize',fontM);
print('-painters','-r300','plot_latencyPNIN_DRunTrack.tif','-dtiff');
%% DRw
fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1},'Name','latDistribution_PNIN_DRwPlfm');

hPlotDRwPN(1) = axes('Position',axpt(nCol,nRow,1,1,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxDRwPN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxDRwPN*0.925,10,yMaxDRwPN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRwPN(1) = bar(xpt,m_DRwPN_actRapid_pethPlfm,'histc');
errorbarJun(xpt+1,m_DRwPN_actRapid_pethPlfm,sem_DRwPN_actRapid_pethPlfm,1,0.4,colorBlack);
text(100, yMaxDRwPN*0.8,['n = ',num2str(n_DRwPN_actRapid_pethPlfm)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN: Rapid activated','fontSize',fontL,'fontWeight','bold');

hPlotDRwPN(2) = axes('Position',axpt(nCol,nRow,1,2,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxDRwPN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxDRwPN*0.925,10,yMaxDRwPN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRwPN(2) = bar(xpt,m_DRwPN_actDelay_pethPlfm,'histc');
errorbarJun(xpt+1,m_DRwPN_actDelay_pethPlfm,sem_DRwPN_actDelay_pethPlfm,1,0.4,colorBlack);
text(100, yMaxDRwPN*0.8,['n = ',num2str(n_DRwPN_actDelay_pethPlfm)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN: Delay activated','fontSize',fontL,'fontWeight','bold');

hPlotDRwPN(3) = axes('Position',axpt(nCol,nRow,1,3,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxDRwPN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxDRwPN*0.925,10,yMaxDRwPN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRwPN(3) = bar(xpt,m_DRwPN_ina_pethPlfm,'histc');
errorbarJun(xpt+1,m_DRwPN_ina_pethPlfm,sem_DRwPN_ina_pethPlfm,1,0.4,colorBlack);
text(100, yMaxDRwPN*0.8,['n = ',num2str(n_DRwPN_ina_pethPlfm)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN: inactivated','fontSize',fontL,'fontWeight','bold');

hPlotDRwIN(1) = axes('Position',axpt(nCol,nRow,2,1,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxDRwIN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxDRwIN*0.925,10,yMaxDRwIN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRwIN(1) = bar(xpt,m_DRwIN_actRapid_pethPlfm,'histc');
errorbarJun(xpt+1,m_DRwIN_actRapid_pethPlfm,sem_DRwIN_actRapid_pethPlfm,1,0.4,colorBlack);
text(100, yMaxDRwIN*0.8,['n = ',num2str(n_DRwIN_actRapid_pethPlfm)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('IN: Rapid activated','fontSize',fontL,'fontWeight','bold');

hPlotDRwIN(2) = axes('Position',axpt(nCol,nRow,2,2,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxDRwIN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxDRwIN*0.925,10,yMaxDRwIN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRwIN(2) = bar(xpt,m_DRwIN_actDelay_pethPlfm,'histc');
text(100, yMaxDRwIN*0.8,['n = ',num2str(n_DRwIN_actDelay_pethPlfm)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('IN: Delay activated','fontSize',fontL,'fontWeight','bold');

hPlotDRwIN(3) = axes('Position',axpt(nCol,nRow,2,3,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxDRwIN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxDRwIN*0.925,10,yMaxDRwIN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRwIN(3) = bar(xpt,m_DRwIN_ina_pethPlfm,'histc');
errorbarJun(xpt+1,m_DRwIN_ina_pethPlfm,sem_DRwIN_ina_pethPlfm,1,0.4,colorBlack);
text(100, yMaxDRwIN*0.8,['n = ',num2str(n_DRwIN_ina_pethPlfm)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('IN: inactivated','fontSize',fontL,'fontWeight','bold');

set(hBarDRwPN,'FaceColor',colorDarkGray,'EdgeColor','none');
set(hBarDRwIN,'FaceColor',colorDarkGray,'EdgeColor','none');
set(hPlotDRwPN,'Box','off','TickDir','out','XLim',[-20 130],'XTick',[-20,0:5:20,130],'YLim',[0, yMaxDRwPN],'fontSize',fontM);
set(hPlotDRwIN,'Box','off','TickDir','out','XLim',[-20 130],'XTick',[-20,0:5:20,130],'YLim',[0, yMaxDRwIN],'fontSize',fontM);
print('-painters','-r300','plot_latencyPNIN_DRwTrack.tif','-dtiff');
close('all');
