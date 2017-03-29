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
% Txls = readtable('neuronList_21-Mar-2017.xlsx');
% load('neuronList_ori_21-Mar-2017.mat');
load('neuronList_ori_25-Mar-2017.mat');

cri_meanFR = 7;
cri_peakFR = 0;
alpha = 0.01;

% TN: track neuron
DRunTN = (T.taskType == 'DRun') & (cellfun(@max, T.peakFR1D_track) > cri_peakFR);
% DRwTN = (T.taskType == 'DRw') & (cellfun(@max, T.peakFR1D_track) > cri_peakFR);
% noRunTN = (T.taskType == 'noRun') & (cellfun(@max, T.peakFR1D_track) > cri_peakFR);
% noRwTN = (T.taskType == 'noRw') & (cellfun(@max, T.peakFR1D_track) > cri_peakFR);

% total population (DRunPN / DRunIN / DRwPN / DRwIN) with light responsiveness (light activated)
DRunPN_act = DRunTN & T.meanFR_task<=cri_meanFR & T.pLR_Track<alpha & T.statDir_Track == 1;
DRunPN_actRapid = DRunTN & T.meanFR_task<=cri_meanFR & T.pLR_Track<alpha & T.statDir_Track == 1 & T.latencyTrack1st<10;
DRunPN_actDelay = DRunTN & T.meanFR_task<=cri_meanFR & T.pLR_Track<alpha & T.statDir_Track == 1 & T.latencyTrack1st>10;
DRunPN_ina = DRunTN & T.meanFR_task<=cri_meanFR & T.pLR_Track<alpha & T.statDir_Track == -1;
DRunPN_no = DRunTN & T.meanFR_task<=cri_meanFR & T.pLR_Track>=alpha;

DRunIN_act = DRunTN & T.meanFR_task>cri_meanFR & T.pLR_Track<alpha & T.statDir_Track == 1;
DRunIN_actRapid = DRunTN & T.meanFR_task>cri_meanFR & T.pLR_Track<alpha & T.statDir_Track == 1 & T.latencyTrack1st<10;
DRunIN_actDelay = DRunTN & T.meanFR_task>cri_meanFR & T.pLR_Track<alpha & T.statDir_Track == 1 & T.latencyTrack1st>10;
DRunIN_ina = DRunTN & T.meanFR_task>cri_meanFR & T.pLR_Track<alpha & T.statDir_Track == -1;
DRunIN_no = DRunTN & T.meanFR_task>cri_meanFR & T.pLR_Track>=alpha;


%% PETH
DRunPN_act_pethTrack = cell2mat(T.pethTrack8hz(DRunPN_act));
DRunPN_actRapid_pethTrack = cell2mat(T.pethTrack8hz(DRunPN_actRapid));
DRunPN_actDelay_pethTrack = cell2mat(T.pethTrack8hz(DRunPN_actDelay));
DRunPN_ina_pethTrack = cell2mat(T.pethTrack8hz(DRunPN_ina));
DRunPN_no_pethTrack = cell2mat(T.pethTrack8hz(DRunPN_no));

DRunIN_act_pethTrack = cell2mat(T.pethTrack8hz(DRunIN_act));
DRunIN_actRapid_pethTrack = cell2mat(T.pethTrack8hz(DRunIN_actRapid));
DRunIN_actDelay_pethTrack = cell2mat(T.pethTrack8hz(DRunIN_actDelay));
DRunIN_ina_pethTrack = cell2mat(T.pethTrack8hz(DRunIN_ina));
DRunIN_no_pethTrack = cell2mat(T.pethTrack8hz(DRunIN_no));

%% Mean & Sem
n_DRunPN_act_pethTrack = size(DRunPN_act_pethTrack,1);
m_DRunPN_act_pethTrack = mean(DRunPN_act_pethTrack,1);
sem_DRunPN_act_pethTrack = std(DRunPN_act_pethTrack,1)/n_DRunPN_act_pethTrack;

n_DRunPN_actRapid_pethTrack = size(DRunPN_actRapid_pethTrack,1);
m_DRunPN_actRapid_pethTrack = mean(DRunPN_actRapid_pethTrack,1);
sem_DRunPN_actRapid_pethTrack = std(DRunPN_actRapid_pethTrack,1)/n_DRunPN_actRapid_pethTrack;

n_DRunPN_actDelay_pethTrack = size(DRunPN_actDelay_pethTrack,1);
m_DRunPN_actDelay_pethTrack = mean(DRunPN_actDelay_pethTrack,1);
sem_DRunPN_actDelay_pethTrack = std(DRunPN_actDelay_pethTrack,1)/n_DRunPN_actDelay_pethTrack;

n_DRunPN_ina_pethTrack = size(DRunPN_ina_pethTrack,1);
m_DRunPN_ina_pethTrack = mean(DRunPN_ina_pethTrack,1);
sem_DRunPN_ina_pethTrack = std(DRunPN_ina_pethTrack,1)/n_DRunPN_ina_pethTrack;

n_DRunPN_no_pethTrack = size(DRunPN_no_pethTrack,1);
m_DRunPN_no_pethTrack = mean(DRunPN_no_pethTrack,1);
sem_DRunPN_no_pethTrack = std(DRunPN_no_pethTrack,1)/n_DRunPN_no_pethTrack;


n_DRunIN_act_pethTrack = size(DRunIN_act_pethTrack,1);
m_DRunIN_act_pethTrack = mean(DRunIN_act_pethTrack,1);
sem_DRunIN_act_pethTrack = std(DRunIN_act_pethTrack,1)/n_DRunIN_act_pethTrack;

n_DRunIN_actRapid_pethTrack = size(DRunIN_actRapid_pethTrack,1);
m_DRunIN_actRapid_pethTrack = mean(DRunIN_actRapid_pethTrack,1);
sem_DRunIN_actRapid_pethTrack = std(DRunIN_actRapid_pethTrack,1)/n_DRunIN_actRapid_pethTrack;

n_DRunIN_actDelay_pethTrack = size(DRunIN_actDelay_pethTrack,1);
m_DRunIN_actDelay_pethTrack = mean(DRunIN_actDelay_pethTrack,1);
sem_DRunIN_actDelay_pethTrack = std(DRunIN_actDelay_pethTrack,1)/n_DRunIN_actDelay_pethTrack;

n_DRunIN_ina_pethTrack = size(DRunIN_ina_pethTrack,1);
m_DRunIN_ina_pethTrack = mean(DRunIN_ina_pethTrack,1);
sem_DRunIN_ina_pethTrack = std(DRunIN_ina_pethTrack,1)/n_DRunIN_ina_pethTrack;

n_DRunIN_no_pethTrack = size(DRunIN_no_pethTrack,1);
m_DRunIN_no_pethTrack = mean(DRunIN_no_pethTrack,1);
sem_DRunIN_no_pethTrack = std(DRunIN_no_pethTrack,1)/n_DRunIN_no_pethTrack;

%%
nCol = 2;
nRow = 5;
xpt = T.pethtimeTrack8hz{2};
yMaxDRunPN = max([m_DRunPN_act_pethTrack, m_DRunPN_ina_pethTrack, m_DRunPN_no_pethTrack])*2;
yMaxDRunIN = max([m_DRunIN_act_pethTrack, m_DRunIN_ina_pethTrack, m_DRunIN_no_pethTrack])*1.5;

fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1},'Name','latDistribution_PNIN_DRunTrack');

hPlotDRunPN(1) = axes('Position',axpt(nCol,nRow,1,1,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxDRunPN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxDRunPN*0.925,10,yMaxDRunPN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRunPN(1) = bar(xpt,m_DRunPN_act_pethTrack,'histc');
errorbarJun(xpt+1,m_DRunPN_act_pethTrack,sem_DRunPN_act_pethTrack,1,0.4,colorBlack);
text(80, yMaxDRunPN*0.8,['n = ',num2str(n_DRunPN_act_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN: Total activated','fontSize',fontL,'fontWeight','bold');

hPlotDRunPN(2) = axes('Position',axpt(nCol,nRow,1,2,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxDRunPN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxDRunPN*0.925,10,yMaxDRunPN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRunPN(2) = bar(xpt,m_DRunPN_actRapid_pethTrack,'histc');
errorbarJun(xpt+1,m_DRunPN_actRapid_pethTrack,sem_DRunPN_actRapid_pethTrack,1,0.4,colorBlack);
text(80, yMaxDRunPN*0.8,['n = ',num2str(n_DRunPN_actRapid_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN: Rapid activated','fontSize',fontL,'fontWeight','bold');

hPlotDRunPN(3) = axes('Position',axpt(nCol,nRow,1,3,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxDRunPN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxDRunPN*0.925,10,yMaxDRunPN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRunPN(3) = bar(xpt,m_DRunPN_actDelay_pethTrack,'histc');
errorbarJun(xpt+1,m_DRunPN_actDelay_pethTrack,sem_DRunPN_actDelay_pethTrack,1,0.4,colorBlack);
text(80, yMaxDRunPN*0.8,['n = ',num2str(n_DRunPN_actDelay_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN: Delay activated','fontSize',fontL,'fontWeight','bold');

hPlotDRunPN(4) = axes('Position',axpt(nCol,nRow,1,4,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxDRunPN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxDRunPN*0.925,10,yMaxDRunPN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRunPN(4) = bar(xpt,m_DRunPN_ina_pethTrack,'histc');
errorbarJun(xpt+1,m_DRunPN_ina_pethTrack,sem_DRunPN_ina_pethTrack,1,0.4,colorBlack);
text(80, yMaxDRunPN*0.8,['n = ',num2str(n_DRunPN_ina_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN: inactivated','fontSize',fontL,'fontWeight','bold');

hPlotDRunPN(5) = axes('Position',axpt(nCol,nRow,1,5,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxDRunPN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxDRunPN*0.925,10,yMaxDRunPN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRunPN(5) = bar(xpt,m_DRunPN_no_pethTrack,'histc');
errorbarJun(xpt+1,m_DRunPN_no_pethTrack,sem_DRunPN_no_pethTrack,1,0.4,colorBlack);
text(80, 10*0.8,['n = ',num2str(n_DRunPN_no_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN: no response','fontSize',fontL,'fontWeight','bold');

hPlotDRunIN(1) = axes('Position',axpt(nCol,nRow,2,1,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxDRunIN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxDRunIN*0.925,10,yMaxDRunIN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRunIN(1) = bar(xpt,m_DRunIN_act_pethTrack,'histc');
errorbarJun(xpt+1,m_DRunIN_act_pethTrack,sem_DRunIN_act_pethTrack,1,0.4,colorBlack);
text(80, yMaxDRunIN*0.8,['n = ',num2str(n_DRunIN_act_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('IN: Total activated','fontSize',fontL,'fontWeight','bold');

hPlotDRunIN(2) = axes('Position',axpt(nCol,nRow,2,2,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxDRunIN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxDRunIN*0.925,10,yMaxDRunIN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRunIN(2) = bar(xpt,m_DRunIN_actRapid_pethTrack,'histc');
errorbarJun(xpt+1,m_DRunIN_actRapid_pethTrack,sem_DRunIN_actRapid_pethTrack,1,0.4,colorBlack);
text(80, yMaxDRunIN*0.8,['n = ',num2str(n_DRunIN_actRapid_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('IN: Rapid activated','fontSize',fontL,'fontWeight','bold');

% hPlotDRunIN(3) = axes('Position',axpt(nCol,nRow,2,3,[0.10 0.10 0.85 0.8],wideInterval));
% bar(5,yMaxDRunIN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
% hold on;
% rectangle('Position',[0,yMaxDRunIN*0.925,10,yMaxDRunIN*0.075],'LineStyle','none','FaceColor',colorBlue);
% hold on;
% hBarDRunIN(3) = bar(xpt,m_DRunIN_actDelay_pethTrack,'histc');
% errorbarJun(xpt+1,m_DRunIN_actDelay_pethTrack,sem_DRunIN_actDelay_pethTrack,1,0.4,colorBlack);
% text(100, yMaxDRunIN*0.8,['n = ',num2str(n_DRunIN_actDelay_pethTrack)],'fontSize',fontL);
% xlabel('Time (ms)','fontSize',fontL);
% ylabel('Spikes/bin','fontSize',fontL);
% title('IN: Delay activated','fontSize',fontL,'fontWeight','bold');

hPlotDRunIN(3) = axes('Position',axpt(nCol,nRow,2,4,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxDRunIN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxDRunIN*0.925,10,yMaxDRunIN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRunIN(3) = bar(xpt,m_DRunIN_ina_pethTrack,'histc');
errorbarJun(xpt+1,m_DRunIN_ina_pethTrack,sem_DRunIN_ina_pethTrack,1,0.4,colorBlack);
text(80, yMaxDRunIN*0.8,['n = ',num2str(n_DRunIN_ina_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('IN: inactivated','fontSize',fontL,'fontWeight','bold');

hPlotDRunIN(4) = axes('Position',axpt(nCol,nRow,2,5,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxDRunIN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxDRunIN*0.925,10,yMaxDRunIN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRunIN(4) = bar(xpt,m_DRunIN_no_pethTrack,'histc');
errorbarJun(xpt+1,m_DRunIN_no_pethTrack,sem_DRunIN_no_pethTrack,1,0.4,colorBlack);
text(80, 50*0.8,['n = ',num2str(n_DRunIN_no_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('IN: no response','fontSize',fontL,'fontWeight','bold');

set(hBarDRunPN,'FaceColor',colorDarkGray,'EdgeColor','none');
set(hBarDRunIN,'FaceColor',colorDarkGray,'EdgeColor','none');
set(hPlotDRunPN(1:4),'Box','off','TickDir','out','XLim',[-20 105],'XTick',[-20,0:5:20,100],'YLim',[0, yMaxDRunPN],'fontSize',fontM);
set(hPlotDRunPN(5),'Box','off','TickDir','out','XLim',[-20 105],'XTick',[-20,0:5:20,100],'YLim',[0, 10],'fontSize',fontM);
set(hPlotDRunIN(1:3),'Box','off','TickDir','out','XLim',[-20 105],'XTick',[-20,0:5:20,100],'YLim',[0, yMaxDRunIN],'fontSize',fontM);
set(hPlotDRunIN(4),'Box','off','TickDir','out','XLim',[-20 105],'XTick',[-20,0:5:20,100],'YLim',[0, 50],'fontSize',fontM);

print('-painters','-r300','plot_latencyPETH_DRunTrack1.tif','-dtiff');
close('all');