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
Txls = readtable('neuronList_21-Mar-2017.xlsx');
load('neuronList_ori_21-Mar-2017.mat');

cri_meanFR = 7;
cri_peakFR = 0;
alpha = 0.01;

% TN: track neuron
noRwTN = (T.taskType == 'noRw') & (cellfun(@max, T.peakFR1D_track) > cri_peakFR);

% total population (noRwPN / noRwIN / DRwPN / DRwIN) with light responsiveness (light activated)
noRwPN_act = noRwTN & T.meanFR_task<=cri_meanFR & T.pLR_Plfm2hz<alpha & T.statDir_Plfm2hz == 1;
noRwPN_actRapid = noRwTN & T.meanFR_task<=cri_meanFR & T.pLR_Plfm2hz<alpha & T.statDir_Plfm2hz == 1 & T.latencyPlfm2hz<10;
noRwPN_actDelay = noRwTN & T.meanFR_task<=cri_meanFR & T.pLR_Plfm2hz<alpha & T.statDir_Plfm2hz == 1 & T.latencyPlfm2hz>10;
noRwPN_ina = noRwTN & T.meanFR_task<=cri_meanFR & T.pLR_Plfm2hz<alpha & T.statDir_Plfm2hz == -1;
noRwPN_no = noRwTN & T.meanFR_task<=cri_meanFR & T.pLR_Plfm2hz>alpha;

noRwIN_act = noRwTN & T.meanFR_task>cri_meanFR & T.pLR_Plfm2hz<alpha & T.statDir_Plfm2hz == 1;
noRwIN_actRapid = noRwTN & T.meanFR_task>cri_meanFR & T.pLR_Plfm2hz<alpha & T.statDir_Plfm2hz == 1 & T.latencyPlfm2hz<10;
noRwIN_actDelay = noRwTN & T.meanFR_task>cri_meanFR & T.pLR_Plfm2hz<alpha & T.statDir_Plfm2hz == 1 & T.latencyPlfm2hz>10;
noRwIN_ina = noRwTN & T.meanFR_task>cri_meanFR & T.pLR_Plfm2hz<alpha & T.statDir_Plfm2hz == -1;
noRwIN_no = noRwTN & T.meanFR_task>cri_meanFR & T.pLR_Plfm2hz>alpha;


%% PETH
noRwPN_act_pethPlfm2hz = cell2mat(T.pethPlfm2hz(noRwPN_act));
noRwPN_actRapid_pethPlfm2hz = cell2mat(T.pethPlfm2hz(noRwPN_actRapid));
noRwPN_actDelay_pethPlfm2hz = cell2mat(T.pethPlfm2hz(noRwPN_actDelay));
noRwPN_ina_pethPlfm2hz = cell2mat(T.pethPlfm2hz(noRwPN_ina));
noRwPN_no_pethPlfm2hz = cell2mat(T.pethPlfm2hz(noRwPN_no));

noRwIN_act_pethPlfm2hz = cell2mat(T.pethPlfm2hz(noRwIN_act));
noRwIN_actRapid_pethPlfm2hz = cell2mat(T.pethPlfm2hz(noRwIN_actRapid));
noRwIN_actDelay_pethPlfm2hz = cell2mat(T.pethPlfm2hz(noRwIN_actDelay));
noRwIN_ina_pethPlfm2hz = cell2mat(T.pethPlfm2hz(noRwIN_ina));
noRwIN_no_pethPlfm2hz = cell2mat(T.pethPlfm2hz(noRwIN_no));

%% Mean & Sem
n_noRwPN_act_pethPlfm2hz = size(noRwPN_act_pethPlfm2hz,1);
m_noRwPN_act_pethPlfm2hz = mean(noRwPN_act_pethPlfm2hz,1);
sem_noRwPN_act_pethPlfm2hz = std(noRwPN_act_pethPlfm2hz,1)/n_noRwPN_act_pethPlfm2hz;

n_noRwPN_actRapid_pethPlfm2hz = size(noRwPN_actRapid_pethPlfm2hz,1);
m_noRwPN_actRapid_pethPlfm2hz = mean(noRwPN_actRapid_pethPlfm2hz,1);
sem_noRwPN_actRapid_pethPlfm2hz = std(noRwPN_actRapid_pethPlfm2hz,1)/n_noRwPN_actRapid_pethPlfm2hz;

n_noRwPN_actDelay_pethPlfm2hz = size(noRwPN_actDelay_pethPlfm2hz,1);
m_noRwPN_actDelay_pethPlfm2hz = mean(noRwPN_actDelay_pethPlfm2hz,1);
sem_noRwPN_actDelay_pethPlfm2hz = std(noRwPN_actDelay_pethPlfm2hz,1)/n_noRwPN_actDelay_pethPlfm2hz;

n_noRwPN_ina_pethPlfm2hz = size(noRwPN_ina_pethPlfm2hz,1);
m_noRwPN_ina_pethPlfm2hz = mean(noRwPN_ina_pethPlfm2hz,1);
sem_noRwPN_ina_pethPlfm2hz = std(noRwPN_ina_pethPlfm2hz,1)/n_noRwPN_ina_pethPlfm2hz;

n_noRwPN_no_pethPlfm2hz = size(noRwPN_no_pethPlfm2hz,1);
m_noRwPN_no_pethPlfm2hz = mean(noRwPN_no_pethPlfm2hz,1);
sem_noRwPN_no_pethPlfm2hz = std(noRwPN_no_pethPlfm2hz,1)/n_noRwPN_no_pethPlfm2hz;


n_noRwIN_act_pethPlfm2hz = size(noRwIN_act_pethPlfm2hz,1);
m_noRwIN_act_pethPlfm2hz = mean(noRwIN_act_pethPlfm2hz,1);
sem_noRwIN_act_pethPlfm2hz = std(noRwIN_act_pethPlfm2hz,1)/n_noRwIN_act_pethPlfm2hz;

n_noRwIN_actRapid_pethPlfm2hz = size(noRwIN_actRapid_pethPlfm2hz,1);
m_noRwIN_actRapid_pethPlfm2hz = mean(noRwIN_actRapid_pethPlfm2hz,1);
sem_noRwIN_actRapid_pethPlfm2hz = std(noRwIN_actRapid_pethPlfm2hz,1)/n_noRwIN_actRapid_pethPlfm2hz;

n_noRwIN_actDelay_pethPlfm2hz = size(noRwIN_actDelay_pethPlfm2hz,1);
m_noRwIN_actDelay_pethPlfm2hz = mean(noRwIN_actDelay_pethPlfm2hz,1);
sem_noRwIN_actDelay_pethPlfm2hz = std(noRwIN_actDelay_pethPlfm2hz,1)/n_noRwIN_actDelay_pethPlfm2hz;

n_noRwIN_ina_pethPlfm2hz = size(noRwIN_ina_pethPlfm2hz,1);
m_noRwIN_ina_pethPlfm2hz = mean(noRwIN_ina_pethPlfm2hz,1);
sem_noRwIN_ina_pethPlfm2hz = std(noRwIN_ina_pethPlfm2hz,1)/n_noRwIN_ina_pethPlfm2hz;

n_noRwIN_no_pethPlfm2hz = size(noRwIN_no_pethPlfm2hz,1);
m_noRwIN_no_pethPlfm2hz = mean(noRwIN_no_pethPlfm2hz,1);
sem_noRwIN_no_pethPlfm2hz = std(noRwIN_no_pethPlfm2hz,1)/n_noRwIN_no_pethPlfm2hz;

%%
nCol = 2;
nRow = 5;
xpt = T.pethtimePlfm2hz{2};
yMaxnoRwPN = max([m_noRwPN_actRapid_pethPlfm2hz, m_noRwPN_actDelay_pethPlfm2hz, m_noRwPN_ina_pethPlfm2hz, m_noRwPN_no_pethPlfm2hz])*1.5;
yMaxnoRwIN = max([m_noRwIN_actRapid_pethPlfm2hz, m_noRwIN_actDelay_pethPlfm2hz, m_noRwIN_ina_pethPlfm2hz, m_noRwIN_no_pethPlfm2hz])*1.5;

fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1},'Name','latDistribution_PNIN_noRwTrack');

hPlotnoRwPN(1) = axes('Position',axpt(nCol,nRow,1,1,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxnoRwPN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxnoRwPN*0.925,10,yMaxnoRwPN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarnoRwPN(1) = bar(xpt,m_noRwPN_act_pethPlfm2hz,'histc');
errorbarJun(xpt+1,m_noRwPN_act_pethPlfm2hz,sem_noRwPN_act_pethPlfm2hz,1,0.4,colorBlack);
text(80, yMaxnoRwPN*0.8,['n = ',num2str(n_noRwPN_act_pethPlfm2hz)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN: Total activated','fontSize',fontL,'fontWeight','bold');

hPlotnoRwPN(2) = axes('Position',axpt(nCol,nRow,1,2,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxnoRwPN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxnoRwPN*0.925,10,yMaxnoRwPN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarnoRwPN(2) = bar(xpt,m_noRwPN_actRapid_pethPlfm2hz,'histc');
errorbarJun(xpt+1,m_noRwPN_actRapid_pethPlfm2hz,sem_noRwPN_actRapid_pethPlfm2hz,1,0.4,colorBlack);
text(80, yMaxnoRwPN*0.8,['n = ',num2str(n_noRwPN_actRapid_pethPlfm2hz)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN: Rapid activated','fontSize',fontL,'fontWeight','bold');

hPlotnoRwPN(3) = axes('Position',axpt(nCol,nRow,1,3,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxnoRwPN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxnoRwPN*0.925,10,yMaxnoRwPN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarnoRwPN(3) = bar(xpt,m_noRwPN_actDelay_pethPlfm2hz,'histc');
errorbarJun(xpt+1,m_noRwPN_actDelay_pethPlfm2hz,sem_noRwPN_actDelay_pethPlfm2hz,1,0.4,colorBlack);
text(80, yMaxnoRwPN*0.8,['n = ',num2str(n_noRwPN_actDelay_pethPlfm2hz)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN: Delay activated','fontSize',fontL,'fontWeight','bold');

hPlotnoRwPN(4) = axes('Position',axpt(nCol,nRow,1,4,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxnoRwPN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxnoRwPN*0.925,10,yMaxnoRwPN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarnoRwPN(4) = bar(xpt,m_noRwPN_ina_pethPlfm2hz,'histc');
errorbarJun(xpt+1,m_noRwPN_ina_pethPlfm2hz,sem_noRwPN_ina_pethPlfm2hz,1,0.4,colorBlack);
text(80, yMaxnoRwPN*0.8,['n = ',num2str(n_noRwPN_ina_pethPlfm2hz)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN: inactivated','fontSize',fontL,'fontWeight','bold');

hPlotnoRwPN(5) = axes('Position',axpt(nCol,nRow,1,5,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxnoRwPN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxnoRwPN*0.925,10,yMaxnoRwPN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarnoRwPN(5) = bar(xpt,m_noRwPN_no_pethPlfm2hz,'histc');
errorbarJun(xpt+1,m_noRwPN_no_pethPlfm2hz,sem_noRwPN_no_pethPlfm2hz,1,0.4,colorBlack);
text(80, yMaxnoRwPN*0.8,['n = ',num2str(n_noRwPN_no_pethPlfm2hz)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN: no response','fontSize',fontL,'fontWeight','bold');

hPlotnoRwIN(1) = axes('Position',axpt(nCol,nRow,2,1,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxnoRwIN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxnoRwIN*0.925,10,yMaxnoRwIN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarnoRwIN(1) = bar(xpt,m_noRwIN_act_pethPlfm2hz,'histc');
errorbarJun(xpt+1,m_noRwIN_act_pethPlfm2hz,sem_noRwIN_act_pethPlfm2hz,1,0.4,colorBlack);
text(80, yMaxnoRwIN*0.8,['n = ',num2str(n_noRwIN_act_pethPlfm2hz)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('IN: Total activated','fontSize',fontL,'fontWeight','bold');

hPlotnoRwIN(2) = axes('Position',axpt(nCol,nRow,2,2,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxnoRwIN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxnoRwIN*0.925,10,yMaxnoRwIN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarnoRwIN(2) = bar(xpt,m_noRwIN_actRapid_pethPlfm2hz,'histc');
errorbarJun(xpt+1,m_noRwIN_actRapid_pethPlfm2hz,sem_noRwIN_actRapid_pethPlfm2hz,1,0.4,colorBlack);
text(80, yMaxnoRwIN*0.8,['n = ',num2str(n_noRwIN_actRapid_pethPlfm2hz)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('IN: Rapid activated','fontSize',fontL,'fontWeight','bold');

hPlotnoRwIN(3) = axes('Position',axpt(nCol,nRow,2,3,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxnoRwIN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxnoRwIN*0.925,10,yMaxnoRwIN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarnoRwIN(3) = bar(xpt,m_noRwIN_actDelay_pethPlfm2hz,'histc');
errorbarJun(xpt+1,m_noRwIN_actDelay_pethPlfm2hz,sem_noRwIN_actDelay_pethPlfm2hz,1,0.4,colorBlack);
text(100, yMaxnoRwIN*0.8,['n = ',num2str(n_noRwIN_actDelay_pethPlfm2hz)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('IN: Delay activated','fontSize',fontL,'fontWeight','bold');

hPlotnoRwIN(4) = axes('Position',axpt(nCol,nRow,2,4,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxnoRwIN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxnoRwIN*0.925,10,yMaxnoRwIN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarnoRwIN(4) = bar(xpt,m_noRwIN_ina_pethPlfm2hz,'histc');
errorbarJun(xpt+1,m_noRwIN_ina_pethPlfm2hz,sem_noRwIN_ina_pethPlfm2hz,1,0.4,colorBlack);
text(80, yMaxnoRwIN*0.8,['n = ',num2str(n_noRwIN_ina_pethPlfm2hz)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('IN: inactivated','fontSize',fontL,'fontWeight','bold');

hPlotnoRwIN(5) = axes('Position',axpt(nCol,nRow,2,5,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxnoRwIN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxnoRwIN*0.925,10,yMaxnoRwIN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarnoRwIN(5) = bar(xpt,m_noRwIN_no_pethPlfm2hz,'histc');
errorbarJun(xpt+1,m_noRwIN_no_pethPlfm2hz,sem_noRwIN_no_pethPlfm2hz,1,0.4,colorBlack);
text(80, yMaxnoRwIN*0.8,['n = ',num2str(n_noRwIN_no_pethPlfm2hz)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('IN: no response','fontSize',fontL,'fontWeight','bold');

set(hBarnoRwPN,'FaceColor',colorDarkGray,'EdgeColor','none');
set(hBarnoRwIN,'FaceColor',colorDarkGray,'EdgeColor','none');
set(hPlotnoRwPN,'Box','off','TickDir','out','XLim',[-20 105],'XTick',[-20,0:5:20,100],'YLim',[0, yMaxnoRwPN],'fontSize',fontM);
set(hPlotnoRwIN,'Box','off','TickDir','out','XLim',[-20 105],'XTick',[-20,0:5:20,100],'YLim',[0, yMaxnoRwIN],'fontSize',fontM);

print('-painters','-r300','plot_latencyPETH_noRwPlfm.tif','-dtiff');
close('all');