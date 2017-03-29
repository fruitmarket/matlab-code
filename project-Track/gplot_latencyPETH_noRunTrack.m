% Latency of neurons which are activated on the platform. (Blue)
% Among neurons which are activated on the platform, latency of neurons which are also activated on the track
% Used light responsive neurons at platform

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
noRunTN = (T.taskType == 'noRun') & (cellfun(@max, T.peakFR1D_track) > cri_peakFR);

% total population (noRunPN / noRunIN / DRwPN / DRwIN) with light responsiveness (light activated)
noRunPN_act = noRunTN & T.meanFR_task<=cri_meanFR & T.pLR_Plfm2hz<alpha & T.statDir_Plfm2hz == 1;
noRunPN_actRapid = noRunTN & T.meanFR_task<=cri_meanFR & T.pLR_Plfm2hz<alpha & T.statDir_Plfm2hz == 1 & T.latencyPlfm2hz1st<10;
noRunPN_actDelay = noRunTN & T.meanFR_task<=cri_meanFR & T.pLR_Plfm2hz<alpha & T.statDir_Plfm2hz == 1 & T.latencyPlfm2hz1st>10;
noRunPN_ina = noRunTN & T.meanFR_task<=cri_meanFR & T.pLR_Plfm2hz<alpha & T.statDir_Plfm2hz == -1;
noRunPN_no = noRunTN & T.meanFR_task<=cri_meanFR & T.pLR_Plfm2hz>alpha;

noRunIN_act = noRunTN & T.meanFR_task>cri_meanFR & T.pLR_Plfm2hz<alpha & T.statDir_Plfm2hz == 1;
noRunIN_actRapid = noRunTN & T.meanFR_task>cri_meanFR & T.pLR_Plfm2hz<alpha & T.statDir_Plfm2hz == 1 & T.latencyPlfm2hz1st<10;
noRunIN_actDelay = noRunTN & T.meanFR_task>cri_meanFR & T.pLR_Plfm2hz<alpha & T.statDir_Plfm2hz == 1 & T.latencyPlfm2hz1st>10;
noRunIN_ina = noRunTN & T.meanFR_task>cri_meanFR & T.pLR_Plfm2hz<alpha & T.statDir_Plfm2hz == -1;
noRunIN_no = noRunTN & T.meanFR_task>cri_meanFR & T.pLR_Plfm2hz>alpha;


%% PETH
noRunPN_act_pethTrack = cell2mat(T.pethTrack8hz(noRunPN_act));
noRunPN_actRapid_pethTrack = cell2mat(T.pethTrack8hz(noRunPN_actRapid));
noRunPN_actDelay_pethTrack = cell2mat(T.pethTrack8hz(noRunPN_actDelay));
noRunPN_ina_pethTrack = cell2mat(T.pethTrack8hz(noRunPN_ina));
noRunPN_no_pethTrack = cell2mat(T.pethTrack8hz(noRunPN_no));

noRunIN_act_pethTrack = cell2mat(T.pethTrack8hz(noRunIN_act));
noRunIN_actRapid_pethTrack = cell2mat(T.pethTrack8hz(noRunIN_actRapid));
noRunIN_actDelay_pethTrack = cell2mat(T.pethTrack8hz(noRunIN_actDelay));
noRunIN_ina_pethTrack = cell2mat(T.pethTrack8hz(noRunIN_ina));
noRunIN_no_pethTrack = cell2mat(T.pethTrack8hz(noRunIN_no));

%% Mean & Sem
n_noRunPN_act_pethTrack = size(noRunPN_act_pethTrack,1);
m_noRunPN_act_pethTrack = mean(noRunPN_act_pethTrack,1);
sem_noRunPN_act_pethTrack = std(noRunPN_act_pethTrack,1)/n_noRunPN_act_pethTrack;

n_noRunPN_actRapid_pethTrack = size(noRunPN_actRapid_pethTrack,1);
m_noRunPN_actRapid_pethTrack = mean(noRunPN_actRapid_pethTrack,1);
sem_noRunPN_actRapid_pethTrack = std(noRunPN_actRapid_pethTrack,1)/n_noRunPN_actRapid_pethTrack;

n_noRunPN_actDelay_pethTrack = size(noRunPN_actDelay_pethTrack,1);
m_noRunPN_actDelay_pethTrack = mean(noRunPN_actDelay_pethTrack,1);
sem_noRunPN_actDelay_pethTrack = std(noRunPN_actDelay_pethTrack,1)/n_noRunPN_actDelay_pethTrack;

n_noRunPN_ina_pethTrack = size(noRunPN_ina_pethTrack,1);
m_noRunPN_ina_pethTrack = mean(noRunPN_ina_pethTrack,1);
sem_noRunPN_ina_pethTrack = std(noRunPN_ina_pethTrack,1)/n_noRunPN_ina_pethTrack;

n_noRunPN_no_pethTrack = size(noRunPN_no_pethTrack,1);
m_noRunPN_no_pethTrack = mean(noRunPN_no_pethTrack,1);
sem_noRunPN_no_pethTrack = std(noRunPN_no_pethTrack,1)/n_noRunPN_no_pethTrack;


n_noRunIN_act_pethTrack = size(noRunIN_act_pethTrack,1);
m_noRunIN_act_pethTrack = mean(noRunIN_act_pethTrack,1);
sem_noRunIN_act_pethTrack = std(noRunIN_act_pethTrack,1)/n_noRunIN_act_pethTrack;

n_noRunIN_actRapid_pethTrack = size(noRunIN_actRapid_pethTrack,1);
m_noRunIN_actRapid_pethTrack = mean(noRunIN_actRapid_pethTrack,1);
sem_noRunIN_actRapid_pethTrack = std(noRunIN_actRapid_pethTrack,1)/n_noRunIN_actRapid_pethTrack;

n_noRunIN_actDelay_pethTrack = size(noRunIN_actDelay_pethTrack,1);
m_noRunIN_actDelay_pethTrack = mean(noRunIN_actDelay_pethTrack,1);
sem_noRunIN_actDelay_pethTrack = std(noRunIN_actDelay_pethTrack,1)/n_noRunIN_actDelay_pethTrack;

n_noRunIN_ina_pethTrack = size(noRunIN_ina_pethTrack,1);
m_noRunIN_ina_pethTrack = mean(noRunIN_ina_pethTrack,1);
sem_noRunIN_ina_pethTrack = std(noRunIN_ina_pethTrack,1)/n_noRunIN_ina_pethTrack;

n_noRunIN_no_pethTrack = size(noRunIN_no_pethTrack,1);
m_noRunIN_no_pethTrack = mean(noRunIN_no_pethTrack,1);
sem_noRunIN_no_pethTrack = std(noRunIN_no_pethTrack,1)/n_noRunIN_no_pethTrack;

%%
nCol = 2;
nRow = 5;
xpt = T.pethtimeTrack8hz{2};
yMaxnoRunPN = max([m_noRunPN_act_pethTrack, m_noRunPN_ina_pethTrack, m_noRunPN_no_pethTrack])*2;
yMaxnoRunIN = max([m_noRunIN_act_pethTrack, m_noRunIN_ina_pethTrack, m_noRunIN_no_pethTrack])*1.5;

fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1},'Name','latDistribution_PNIN_noRunTrack');

hPlotnoRunPN(1) = axes('Position',axpt(nCol,nRow,1,1,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxnoRunPN,'BarWidth',10,'LineStyle','none','FaceColor',colorLightGray);
hold on;
rectangle('Position',[0,yMaxnoRunPN*0.925,10,yMaxnoRunPN*0.075],'LineStyle','none','FaceColor',colorGray);
hold on;
hBarnoRunPN(1) = bar(xpt,m_noRunPN_act_pethTrack,'histc');
errorbarJun(xpt+1,m_noRunPN_act_pethTrack,sem_noRunPN_act_pethTrack,1,0.4,colorBlack);
text(80, yMaxnoRunPN*0.8,['n = ',num2str(n_noRunPN_act_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN: Total activated','fontSize',fontL,'fontWeight','bold');

hPlotnoRunPN(2) = axes('Position',axpt(nCol,nRow,1,2,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxnoRunPN,'BarWidth',10,'LineStyle','none','FaceColor',colorLightGray);
hold on;
rectangle('Position',[0,yMaxnoRunPN*0.925,10,yMaxnoRunPN*0.075],'LineStyle','none','FaceColor',colorGray);
hold on;
hBarnoRunPN(2) = bar(xpt,m_noRunPN_actRapid_pethTrack,'histc');
% errorbarJun(xpt+1,m_noRunPN_actRapid_pethTrack,sem_noRunPN_actRapid_pethTrack,1,0.4,colorBlack);
text(80, yMaxnoRunPN*0.8,['n = ',num2str(n_noRunPN_actRapid_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN: Rapid activated','fontSize',fontL,'fontWeight','bold');

hPlotnoRunPN(3) = axes('Position',axpt(nCol,nRow,1,3,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxnoRunPN,'BarWidth',10,'LineStyle','none','FaceColor',colorLightGray);
hold on;
rectangle('Position',[0,yMaxnoRunPN*0.925,10,yMaxnoRunPN*0.075],'LineStyle','none','FaceColor',colorGray);
hold on;
hBarnoRunPN(3) = bar(xpt,m_noRunPN_actDelay_pethTrack,'histc');
errorbarJun(xpt+1,m_noRunPN_actDelay_pethTrack,sem_noRunPN_actDelay_pethTrack,1,0.4,colorBlack);
text(80, yMaxnoRunPN*0.8,['n = ',num2str(n_noRunPN_actDelay_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN: Delay activated','fontSize',fontL,'fontWeight','bold');

hPlotnoRunPN(4) = axes('Position',axpt(nCol,nRow,1,4,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxnoRunPN,'BarWidth',10,'LineStyle','none','FaceColor',colorLightGray);
hold on;
rectangle('Position',[0,yMaxnoRunPN*0.925,10,yMaxnoRunPN*0.075],'LineStyle','none','FaceColor',colorGray);
hold on;
hBarnoRunPN(4) = bar(xpt,m_noRunPN_ina_pethTrack,'histc');
% errorbarJun(xpt+1,m_noRunPN_ina_pethTrack,sem_noRunPN_ina_pethTrack,1,0.4,colorBlack);
text(80, yMaxnoRunPN*0.8,['n = ',num2str(n_noRunPN_ina_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN: inactivated','fontSize',fontL,'fontWeight','bold');

hPlotnoRunPN(5) = axes('Position',axpt(nCol,nRow,1,5,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxnoRunPN,'BarWidth',10,'LineStyle','none','FaceColor',colorLightGray);
hold on;
rectangle('Position',[0,yMaxnoRunPN*0.925,10,yMaxnoRunPN*0.075],'LineStyle','none','FaceColor',colorGray);
hold on;
hBarnoRunPN(5) = bar(xpt,m_noRunPN_no_pethTrack,'histc');
errorbarJun(xpt+1,m_noRunPN_no_pethTrack,sem_noRunPN_no_pethTrack,1,0.4,colorBlack);
text(80, yMaxnoRunPN*0.8,['n = ',num2str(n_noRunPN_no_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN: no response','fontSize',fontL,'fontWeight','bold');

hPlotnoRunIN(1) = axes('Position',axpt(nCol,nRow,2,1,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxnoRunIN,'BarWidth',10,'LineStyle','none','FaceColor',colorLightGray);
hold on;
rectangle('Position',[0,yMaxnoRunIN*0.925,10,yMaxnoRunIN*0.075],'LineStyle','none','FaceColor',colorGray);
hold on;
hBarnoRunIN(1) = bar(xpt,m_noRunIN_act_pethTrack,'histc');
errorbarJun(xpt+1,m_noRunIN_act_pethTrack,sem_noRunIN_act_pethTrack,1,0.4,colorBlack);
text(80, yMaxnoRunIN*0.8,['n = ',num2str(n_noRunIN_act_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('IN: Total activated','fontSize',fontL,'fontWeight','bold');

hPlotnoRunIN(2) = axes('Position',axpt(nCol,nRow,2,2,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxnoRunIN,'BarWidth',10,'LineStyle','none','FaceColor',colorLightGray);
hold on;
rectangle('Position',[0,yMaxnoRunIN*0.925,10,yMaxnoRunIN*0.075],'LineStyle','none','FaceColor',colorGray);
hold on;
hBarnoRunIN(2) = bar(xpt,m_noRunIN_actRapid_pethTrack,'histc');
errorbarJun(xpt+1,m_noRunIN_actRapid_pethTrack,sem_noRunIN_actRapid_pethTrack,1,0.4,colorBlack);
text(80, yMaxnoRunIN*0.8,['n = ',num2str(n_noRunIN_actRapid_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('IN: Rapid activated','fontSize',fontL,'fontWeight','bold');

hPlotnoRunIN(3) = axes('Position',axpt(nCol,nRow,2,3,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxnoRunIN,'BarWidth',10,'LineStyle','none','FaceColor',colorLightGray);
hold on;
rectangle('Position',[0,yMaxnoRunIN*0.925,10,yMaxnoRunIN*0.075],'LineStyle','none','FaceColor',colorGray);
hold on;
hBarnoRunIN(3) = bar(xpt,m_noRunIN_actDelay_pethTrack,'histc');
errorbarJun(xpt+1,m_noRunIN_actDelay_pethTrack,sem_noRunIN_actDelay_pethTrack,1,0.4,colorBlack);
text(100, yMaxnoRunIN*0.8,['n = ',num2str(n_noRunIN_actDelay_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('IN: Delay activated','fontSize',fontL,'fontWeight','bold');

hPlotnoRunIN(4) = axes('Position',axpt(nCol,nRow,2,4,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxnoRunIN,'BarWidth',10,'LineStyle','none','FaceColor',colorLightGray);
hold on;
rectangle('Position',[0,yMaxnoRunIN*0.925,10,yMaxnoRunIN*0.075],'LineStyle','none','FaceColor',colorGray);
hold on;
hBarnoRunIN(4) = bar(xpt,m_noRunIN_ina_pethTrack,'histc');
errorbarJun(xpt+1,m_noRunIN_ina_pethTrack,sem_noRunIN_ina_pethTrack,1,0.4,colorBlack);
text(80, yMaxnoRunIN*0.8,['n = ',num2str(n_noRunIN_ina_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('IN: inactivated','fontSize',fontL,'fontWeight','bold');

hPlotnoRunIN(5) = axes('Position',axpt(nCol,nRow,2,5,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxnoRunIN,'BarWidth',10,'LineStyle','none','FaceColor',colorLightGray);
hold on;
rectangle('Position',[0,yMaxnoRunIN*0.925,10,yMaxnoRunIN*0.075],'LineStyle','none','FaceColor',colorGray);
hold on;
hBarnoRunIN(5) = bar(xpt,m_noRunIN_no_pethTrack,'histc');
% errorbarJun(xpt+1,m_noRunIN_no_pethTrack,sem_noRunIN_no_pethTrack,1,0.4,colorBlack);
text(80, yMaxnoRunIN*0.8,['n = ',num2str(n_noRunIN_no_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('IN: no response','fontSize',fontL,'fontWeight','bold');

set(hBarnoRunPN,'FaceColor',colorDarkGray,'EdgeColor','none');
set(hBarnoRunIN,'FaceColor',colorDarkGray,'EdgeColor','none');
set(hPlotnoRunPN,'Box','off','TickDir','out','XLim',[-20 105],'XTick',[-20,0:5:20,100],'YLim',[0, yMaxnoRunPN],'fontSize',fontM);
set(hPlotnoRunIN,'Box','off','TickDir','out','XLim',[-20 105],'XTick',[-20,0:5:20,100],'YLim',[0, yMaxnoRunIN],'fontSize',fontM);
print('-painters','-r300','plot_latencyPETH_noRunTrack1.tif','-dtiff');

close('all');