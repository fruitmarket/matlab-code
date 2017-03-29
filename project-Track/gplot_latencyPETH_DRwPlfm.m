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
DRwTN = (T.taskType == 'DRw') & (cellfun(@max, T.peakFR1D_track) > cri_peakFR);
DRwTN = (T.taskType == 'DRw') & (cellfun(@max, T.peakFR1D_track) > cri_peakFR);
noRunTN = (T.taskType == 'noRun') & (cellfun(@max, T.peakFR1D_track) > cri_peakFR);
noRwTN = (T.taskType == 'noRw') & (cellfun(@max, T.peakFR1D_track) > cri_peakFR);

% total population (DRwPN / DRwIN / DRwPN / DRwIN) with light responsiveness (light activated)
DRwPN_act = DRwTN & T.meanFR_base<=cri_meanFR & T.pLR_Plfm2hz<alpha & T.statDir_Plfm2hz == 1;
DRwPN_actRapid = DRwTN & T.meanFR_base<=cri_meanFR & T.pLR_Plfm2hz<alpha & T.statDir_Plfm2hz == 1 & T.latencyPlfm2hz1st<10;
DRwPN_actDelay = DRwTN & T.meanFR_base<=cri_meanFR & T.pLR_Plfm2hz<alpha & T.statDir_Plfm2hz == 1 & T.latencyPlfm2hz1st>10;
DRwPN_ina = DRwTN & T.meanFR_base<=cri_meanFR & T.pLR_Plfm2hz<alpha & T.statDir_Plfm2hz == -1;
DRwPN_no = DRwTN & T.meanFR_base<=cri_meanFR & T.pLR_Plfm2hz>alpha;

DRwIN_act = DRwTN & T.meanFR_base>cri_meanFR & T.pLR_Track<alpha & T.statDir_Plfm2hz == 1;
DRwIN_actRapid = DRwTN & T.meanFR_base>cri_meanFR & T.pLR_Plfm2hz<alpha & T.statDir_Plfm2hz == 1 & T.latencyPlfm2hz1st<10;
DRwIN_actDelay = DRwTN & T.meanFR_base>cri_meanFR & T.pLR_Plfm2hz<alpha & T.statDir_Plfm2hz == 1 & T.latencyPlfm2hz1st>10;
DRwIN_ina = DRwTN & T.meanFR_base>cri_meanFR & T.pLR_Plfm2hz<alpha & T.statDir_Plfm2hz == -1;
DRwIN_no = DRwTN & T.meanFR_base>cri_meanFR & T.pLR_Plfm2hz>alpha;


%% PETH
DRwPN_act_pethPlfm2hz = cell2mat(T.pethPlfm2hz(DRwPN_act));
DRwPN_actRapid_pethPlfm2hz = cell2mat(T.pethPlfm2hz(DRwPN_actRapid));
DRwPN_actDelay_pethPlfm2hz = cell2mat(T.pethPlfm2hz(DRwPN_actDelay));
DRwPN_ina_pethPlfm2hz = cell2mat(T.pethPlfm2hz(DRwPN_ina));
DRwPN_no_pethPlfm2hz = cell2mat(T.pethPlfm2hz(DRwPN_no));

DRwIN_act_pethPlfm2hz = cell2mat(T.pethPlfm2hz(DRwIN_act));
DRwIN_actRapid_pethPlfm2hz = cell2mat(T.pethPlfm2hz(DRwIN_actRapid));
DRwIN_actDelay_pethPlfm2hz = cell2mat(T.pethPlfm2hz(DRwIN_actDelay));
DRwIN_ina_pethPlfm2hz = cell2mat(T.pethPlfm2hz(DRwIN_ina));
DRwIN_no_pethPlfm2hz = cell2mat(T.pethPlfm2hz(DRwIN_no));

%% Mean & Sem
n_DRwPN_act_pethPlfm2hz = size(DRwPN_act_pethPlfm2hz,1);
m_DRwPN_act_pethPlfm2hz = mean(DRwPN_act_pethPlfm2hz,1);
sem_DRwPN_act_pethPlfm2hz = std(DRwPN_act_pethPlfm2hz,1)/n_DRwPN_act_pethPlfm2hz;

n_DRwPN_actRapid_pethPlfm2hz = size(DRwPN_actRapid_pethPlfm2hz,1);
m_DRwPN_actRapid_pethPlfm2hz = mean(DRwPN_actRapid_pethPlfm2hz,1);
sem_DRwPN_actRapid_pethPlfm2hz = std(DRwPN_actRapid_pethPlfm2hz,1)/n_DRwPN_actRapid_pethPlfm2hz;

n_DRwPN_actDelay_pethPlfm2hz = size(DRwPN_actDelay_pethPlfm2hz,1);
m_DRwPN_actDelay_pethPlfm2hz = mean(DRwPN_actDelay_pethPlfm2hz,1);
sem_DRwPN_actDelay_pethPlfm2hz = std(DRwPN_actDelay_pethPlfm2hz,1)/n_DRwPN_actDelay_pethPlfm2hz;

n_DRwPN_ina_pethPlfm2hz = size(DRwPN_ina_pethPlfm2hz,1);
m_DRwPN_ina_pethPlfm2hz = mean(DRwPN_ina_pethPlfm2hz,1);
sem_DRwPN_ina_pethPlfm2hz = std(DRwPN_ina_pethPlfm2hz,1)/n_DRwPN_ina_pethPlfm2hz;

n_DRwPN_no_pethPlfm2hz = size(DRwPN_no_pethPlfm2hz,1);
m_DRwPN_no_pethPlfm2hz = mean(DRwPN_no_pethPlfm2hz,1);
sem_DRwPN_no_pethPlfm2hz = std(DRwPN_no_pethPlfm2hz,1)/n_DRwPN_no_pethPlfm2hz;


n_DRwIN_act_pethPlfm2hz = size(DRwIN_act_pethPlfm2hz,1);
m_DRwIN_act_pethPlfm2hz = mean(DRwIN_act_pethPlfm2hz,1);
sem_DRwIN_act_pethPlfm2hz = std(DRwIN_act_pethPlfm2hz,1)/n_DRwIN_act_pethPlfm2hz;

n_DRwIN_actRapid_pethPlfm2hz = size(DRwIN_actRapid_pethPlfm2hz,1);
m_DRwIN_actRapid_pethPlfm2hz = mean(DRwIN_actRapid_pethPlfm2hz,1);
sem_DRwIN_actRapid_pethPlfm2hz = std(DRwIN_actRapid_pethPlfm2hz,1)/n_DRwIN_actRapid_pethPlfm2hz;

n_DRwIN_actDelay_pethPlfm2hz = size(DRwIN_actDelay_pethPlfm2hz,1);
m_DRwIN_actDelay_pethPlfm2hz = mean(DRwIN_actDelay_pethPlfm2hz,1);
sem_DRwIN_actDelay_pethPlfm2hz = std(DRwIN_actDelay_pethPlfm2hz,1)/n_DRwIN_actDelay_pethPlfm2hz;

n_DRwIN_ina_pethPlfm2hz = size(DRwIN_ina_pethPlfm2hz,1);
m_DRwIN_ina_pethPlfm2hz = mean(DRwIN_ina_pethPlfm2hz,1);
sem_DRwIN_ina_pethPlfm2hz = std(DRwIN_ina_pethPlfm2hz,1)/n_DRwIN_ina_pethPlfm2hz;

n_DRwIN_no_pethPlfm2hz = size(DRwIN_no_pethPlfm2hz,1);
m_DRwIN_no_pethPlfm2hz = mean(DRwIN_no_pethPlfm2hz,1);
sem_DRwIN_no_pethPlfm2hz = std(DRwIN_no_pethPlfm2hz,1)/n_DRwIN_no_pethPlfm2hz;

%%
nCol = 2;
nRow = 5;
xpt = T.pethtimePlfm2hz{2};
yMaxDRwPN = max([m_DRwPN_act_pethPlfm2hz, m_DRwPN_ina_pethPlfm2hz, m_DRwPN_no_pethPlfm2hz])*2;
yMaxDRwIN = max([m_DRwIN_act_pethPlfm2hz, m_DRwIN_ina_pethPlfm2hz, m_DRwIN_no_pethPlfm2hz])*1.5;

fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1},'Name','latDistribution_PNIN_DRwTrack');

hPlotDRwPN(1) = axes('Position',axpt(nCol,nRow,1,1,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxDRwPN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxDRwPN*0.925,10,yMaxDRwPN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRwPN(1) = bar(xpt,m_DRwPN_act_pethPlfm2hz,'histc');
errorbarJun(xpt+1,m_DRwPN_act_pethPlfm2hz,sem_DRwPN_act_pethPlfm2hz,1,0.4,colorBlack);
text(80, yMaxDRwPN*0.8,['n = ',num2str(n_DRwPN_act_pethPlfm2hz)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN: Total activated','fontSize',fontL,'fontWeight','bold');

hPlotDRwPN(2) = axes('Position',axpt(nCol,nRow,1,2,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxDRwPN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxDRwPN*0.925,10,yMaxDRwPN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRwPN(2) = bar(xpt,m_DRwPN_actRapid_pethPlfm2hz,'histc');
errorbarJun(xpt+1,m_DRwPN_actRapid_pethPlfm2hz,sem_DRwPN_actRapid_pethPlfm2hz,1,0.4,colorBlack);
text(80, yMaxDRwPN*0.8,['n = ',num2str(n_DRwPN_actRapid_pethPlfm2hz)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN: Rapid activated','fontSize',fontL,'fontWeight','bold');

hPlotDRwPN(3) = axes('Position',axpt(nCol,nRow,1,3,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxDRwPN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxDRwPN*0.925,10,yMaxDRwPN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRwPN(3) = bar(xpt,m_DRwPN_actDelay_pethPlfm2hz,'histc');
errorbarJun(xpt+1,m_DRwPN_actDelay_pethPlfm2hz,sem_DRwPN_actDelay_pethPlfm2hz,1,0.4,colorBlack);
text(80, yMaxDRwPN*0.8,['n = ',num2str(n_DRwPN_actDelay_pethPlfm2hz)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN: Delay activated','fontSize',fontL,'fontWeight','bold');

hPlotDRwPN(4) = axes('Position',axpt(nCol,nRow,1,4,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxDRwPN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxDRwPN*0.925,10,yMaxDRwPN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRwPN(4) = bar(xpt,m_DRwPN_ina_pethPlfm2hz,'histc');
errorbarJun(xpt+1,m_DRwPN_ina_pethPlfm2hz,sem_DRwPN_ina_pethPlfm2hz,1,0.4,colorBlack);
text(80, yMaxDRwPN*0.8,['n = ',num2str(n_DRwPN_ina_pethPlfm2hz)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN: inactivated','fontSize',fontL,'fontWeight','bold');

hPlotDRwPN(5) = axes('Position',axpt(nCol,nRow,1,5,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxDRwPN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxDRwPN*0.925,10,yMaxDRwPN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRwPN(5) = bar(xpt,m_DRwPN_no_pethPlfm2hz,'histc');
errorbarJun(xpt+1,m_DRwPN_no_pethPlfm2hz,sem_DRwPN_no_pethPlfm2hz,1,0.4,colorBlack);
text(80, 10*0.8,['n = ',num2str(n_DRwPN_no_pethPlfm2hz)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN: no response','fontSize',fontL,'fontWeight','bold');

hPlotDRwIN(1) = axes('Position',axpt(nCol,nRow,2,1,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxDRwIN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxDRwIN*0.925,10,yMaxDRwIN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRwIN(1) = bar(xpt,m_DRwIN_act_pethPlfm2hz,'histc');
errorbarJun(xpt+1,m_DRwIN_act_pethPlfm2hz,sem_DRwIN_act_pethPlfm2hz,1,0.4,colorBlack);
text(80, yMaxDRwIN*0.8,['n = ',num2str(n_DRwIN_act_pethPlfm2hz)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('IN: Total activated','fontSize',fontL,'fontWeight','bold');

hPlotDRwIN(2) = axes('Position',axpt(nCol,nRow,2,2,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxDRwIN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxDRwIN*0.925,10,yMaxDRwIN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRwIN(2) = bar(xpt,m_DRwIN_actRapid_pethPlfm2hz,'histc');
errorbarJun(xpt+1,m_DRwIN_actRapid_pethPlfm2hz,sem_DRwIN_actRapid_pethPlfm2hz,1,0.4,colorBlack);
text(80, yMaxDRwIN*0.8,['n = ',num2str(n_DRwIN_actRapid_pethPlfm2hz)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('IN: Rapid activated','fontSize',fontL,'fontWeight','bold');

hPlotDRwIN(3) = axes('Position',axpt(nCol,nRow,2,3,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxDRwIN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxDRwIN*0.925,10,yMaxDRwIN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRwIN(3) = bar(xpt,m_DRwIN_actDelay_pethPlfm2hz,'histc');
% errorbarJun(xpt+1,m_DRwIN_actDelay_pethPlfm2hz,sem_DRwIN_actDelay_pethPlfm2hz,1,0.4,colorBlack);
text(100, yMaxDRwIN*0.8,['n = ',num2str(n_DRwIN_actDelay_pethPlfm2hz)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('IN: Delay activated','fontSize',fontL,'fontWeight','bold');

hPlotDRwIN(4) = axes('Position',axpt(nCol,nRow,2,4,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxDRwIN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxDRwIN*0.925,10,yMaxDRwIN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRwIN(4) = bar(xpt,m_DRwIN_ina_pethPlfm2hz,'histc');
errorbarJun(xpt+1,m_DRwIN_ina_pethPlfm2hz,sem_DRwIN_ina_pethPlfm2hz,1,0.4,colorBlack);
text(80, yMaxDRwIN*0.8,['n = ',num2str(n_DRwIN_ina_pethPlfm2hz)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('IN: inactivated','fontSize',fontL,'fontWeight','bold');

hPlotDRwIN(5) = axes('Position',axpt(nCol,nRow,2,5,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxDRwIN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxDRwIN*0.925,10,yMaxDRwIN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRwIN(5) = bar(xpt,m_DRwIN_no_pethPlfm2hz,'histc');
errorbarJun(xpt+1,m_DRwIN_no_pethPlfm2hz,sem_DRwIN_no_pethPlfm2hz,1,0.4,colorBlack);
text(80, yMaxDRwIN*0.8,['n = ',num2str(n_DRwIN_no_pethPlfm2hz)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('IN: no response','fontSize',fontL,'fontWeight','bold');

set(hBarDRwPN,'FaceColor',colorDarkGray,'EdgeColor','none');
set(hBarDRwIN,'FaceColor',colorDarkGray,'EdgeColor','none');
set(hPlotDRwPN(1:4),'Box','off','TickDir','out','XLim',[-20 105],'XTick',[-20,0:5:20,100],'YLim',[0, yMaxDRwPN],'fontSize',fontM);
set(hPlotDRwPN(5),'Box','off','TickDir','out','XLim',[-20 105],'XTick',[-20,0:5:20,100],'YLim',[0, 10],'fontSize',fontM);
set(hPlotDRwIN(1:4),'Box','off','TickDir','out','XLim',[-20 105],'XTick',[-20,0:5:20,100],'YLim',[0, yMaxDRwIN],'fontSize',fontM);
set(hPlotDRwIN(5),'Box','off','TickDir','out','XLim',[-20 105],'XTick',[-20,0:5:20,100],'YLim',[0, 50],'fontSize',fontM);

print('-painters','-r300','plot_latencyPETH_DRwPlfm1.tif','-dtiff');
close('all');