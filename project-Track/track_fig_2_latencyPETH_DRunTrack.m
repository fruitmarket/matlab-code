% Latency of neurons which are activated on the platform. (Blue)
% Among neurons which are activated on the platform, latency of neurons which are also activated on the track

% common part
clearvars;

% cd('D:\Dropbox\SNL\P2_Track'); % win version
cd('/Users/Jun/Dropbox/SNL/P2_Track'); % mac version
Txls = readtable('neuronList_ori_170606.xlsx');
load('neuronList_ori_170606.mat');
load myParameters.mat;

cMeanFR = 9;
cMaxPeakFR = 1;
cSpkpvr = 1.2;
alpha = 0.01;

condiTN = (cellfun(@max, T.peakFR1D_track) > cMaxPeakFR) & ~(cellfun(@(x) any(isnan(x)),T.peakloci_total));
condiPN = T.spkpvr>cSpkpvr & T.meanFR_task<cMeanFR;
condiIN = ~condiPN;

% TN: track neuron
DRunTN = (T.taskType == 'DRun') & condiTN;
DRunPN = DRunTN & condiPN;
DRunIN = DRunTN & condiIN;

DRwTN = (T.taskType == 'DRw') & condiTN;
DRwPN = DRwTN & condiPN;
DRwIN = DRwTN & condiIN;

% total population (DRwPN / DRwIN / DRwPN / DRwIN) with light responsiveness (light activated)
PN_act = DRunPN & T.pLR_Track<alpha & T.statDir_Track == 1;
PN_actRapid = DRunPN & T.pLR_Track<alpha & T.statDir_Track == 1 & T.latencyTrack1st<10;
PN_actDelay = DRwPN & T.pLR_Track<alpha & T.statDir_Track == 1 & T.latencyTrack1st>10;
PN_ina = DRunPN & T.pLR_Track<alpha & T.statDir_Track == -1;
PN_no = DRunPN & T.pLR_Track>alpha;

IN_act = DRunIN & T.pLR_Track<alpha & T.statDir_Track == 1;
IN_actRapid = DRunIN & T.pLR_Track<alpha & T.statDir_Track == 1 & T.latencyTrack1st<10;
IN_actDelay = DRunIN & T.pLR_Track<alpha & T.statDir_Track == 1 & T.latencyTrack1st>10;
IN_ina = DRunIN & T.pLR_Track<alpha & T.statDir_Track == -1;
IN_no = DRunIN & T.pLR_Track>alpha;

fileName = T.path(PN_actDelay);
cellID = Txls.cellID(PN_actDelay);
plot_Track_multi_v3(fileName, cellID, 'C:\Users\Jun\Desktop\DRw_delay');
%% PETH
DRunPN_act_pethTrack = cell2mat(T.pethTrack8hz(PN_act));
DRunPN_actRapid_pethTrack = cell2mat(T.pethTrack8hz(PN_actRapid));
DRunPN_actDelay_pethTrack = cell2mat(T.pethTrack8hz(PN_actDelay));
DRunPN_ina_pethTrack = cell2mat(T.pethTrack8hz(PN_ina));
DRunPN_no_pethTrack = cell2mat(T.pethTrack8hz(PN_no));

DRunIN_act_pethTrack = cell2mat(T.pethTrack8hz(IN_act));
DRunIN_actRapid_pethTrack = cell2mat(T.pethTrack8hz(IN_actRapid));
DRunIN_actDelay_pethTrack = cell2mat(T.pethTrack8hz(IN_actDelay));
DRunIN_ina_pethTrack = cell2mat(T.pethTrack8hz(IN_ina));
DRunIN_no_pethTrack = cell2mat(T.pethTrack8hz(IN_no));

%% Mean & Sem
n_DRunPN_act_pethTrack = size(DRunPN_act_pethTrack,1);
m_DRunPN_act_pethTrack = mean(DRunPN_act_pethTrack,1);
sem_DRunPN_act_pethTrack = std(DRunPN_act_pethTrack,1)/sqrt(n_DRunPN_act_pethTrack);

n_DRunPN_actRapid_pethTrack = size(DRunPN_actRapid_pethTrack,1);
m_DRunPN_actRapid_pethTrack = mean(DRunPN_actRapid_pethTrack,1);
sem_DRunPN_actRapid_pethTrack = std(DRunPN_actRapid_pethTrack,1)/sqrt(n_DRunPN_actRapid_pethTrack);

n_DRunPN_actDelay_pethTrack = size(DRunPN_actDelay_pethTrack,1);
m_DRunPN_actDelay_pethTrack = mean(DRunPN_actDelay_pethTrack,1);
sem_DRunPN_actDelay_pethTrack = std(DRunPN_actDelay_pethTrack,1)/sqrt(n_DRunPN_actDelay_pethTrack);

n_DRunPN_ina_pethTrack = size(DRunPN_ina_pethTrack,1);
m_DRunPN_ina_pethTrack = mean(DRunPN_ina_pethTrack,1);
sem_DRunPN_ina_pethTrack = std(DRunPN_ina_pethTrack,1)/sqrt(n_DRunPN_ina_pethTrack);

n_DRunPN_no_pethTrack = size(DRunPN_no_pethTrack,1);
m_DRunPN_no_pethTrack = mean(DRunPN_no_pethTrack,1);
sem_DRunPN_no_pethTrack = std(DRunPN_no_pethTrack,1)/sqrt(n_DRunPN_no_pethTrack);


n_DRunIN_act_pethTrack = size(DRunIN_act_pethTrack,1);
m_DRunIN_act_pethTrack = mean(DRunIN_act_pethTrack,1);
sem_DRunIN_act_pethTrack = std(DRunIN_act_pethTrack,1)/sqrt(n_DRunIN_act_pethTrack);

n_DRunIN_actRapid_pethTrack = size(DRunIN_actRapid_pethTrack,1);
m_DRunIN_actRapid_pethTrack = mean(DRunIN_actRapid_pethTrack,1);
sem_DRunIN_actRapid_pethTrack = std(DRunIN_actRapid_pethTrack,1)/sqrt(n_DRunIN_actRapid_pethTrack);

n_DRunIN_actDelay_pethTrack = size(DRunIN_actDelay_pethTrack,1);
m_DRunIN_actDelay_pethTrack = mean(DRunIN_actDelay_pethTrack,1);
sem_DRunIN_actDelay_pethTrack = std(DRunIN_actDelay_pethTrack,1)/sqrt(n_DRunIN_actDelay_pethTrack);

n_DRunIN_ina_pethTrack = size(DRunIN_ina_pethTrack,1);
m_DRunIN_ina_pethTrack = mean(DRunIN_ina_pethTrack,1);
sem_DRunIN_ina_pethTrack = std(DRunIN_ina_pethTrack,1)/sqrt(n_DRunIN_ina_pethTrack);

n_DRunIN_no_pethTrack = size(DRunIN_no_pethTrack,1);
m_DRunIN_no_pethTrack = mean(DRunIN_no_pethTrack,1);
sem_DRunIN_no_pethTrack = std(DRunIN_no_pethTrack,1)/sqrt(n_DRunIN_no_pethTrack);

%%
nCol = 2;
nRow = 5;
xpt = T.pethtimeTrack8hz{end};
yMaxDRunPN = max([m_DRunPN_act_pethTrack, m_DRunPN_ina_pethTrack, m_DRunPN_no_pethTrack])*2;
yMaxDRunIN = max([m_DRunIN_act_pethTrack, m_DRunIN_ina_pethTrack, m_DRunIN_no_pethTrack])*1.5;

fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1},'Name','latDistribution_PNIN_DRunTrack');

hPlotDRunPN(1) = axes('Position',axpt(nCol,nRow,1,1,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxDRunPN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxDRunPN*0.925,10,yMaxDRunPN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRunPN(1) = bar(xpt,m_DRunPN_act_pethTrack,'histc');
errorbarJun(xpt+1,m_DRunPN_act_pethTrack,sem_DRunPN_act_pethTrack,1,0.4,colorDarkGray);
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
errorbarJun(xpt+1,m_DRunPN_actRapid_pethTrack,sem_DRunPN_actRapid_pethTrack,1,0.4,colorDarkGray);
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
errorbarJun(xpt+1,m_DRunPN_actDelay_pethTrack,sem_DRunPN_actDelay_pethTrack,1,0.4,colorDarkGray);
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
errorbarJun(xpt+1,m_DRunPN_ina_pethTrack,sem_DRunPN_ina_pethTrack,1,0.4,colorDarkGray);
text(80, yMaxDRunPN*0.8,['n = ',num2str(n_DRunPN_ina_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN: inactivated','fontSize',fontL,'fontWeight','bold');

hPlotDRunPN(5) = axes('Position',axpt(nCol,nRow,1,5,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,10,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,10*0.925,10,10*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRunPN(5) = bar(xpt,m_DRunPN_no_pethTrack,'histc');
errorbarJun(xpt+1,m_DRunPN_no_pethTrack,sem_DRunPN_no_pethTrack,1,0.4,colorDarkGray);
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
errorbarJun(xpt+1,m_DRunIN_act_pethTrack,sem_DRunIN_act_pethTrack,1,0.4,colorDarkGray);
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
errorbarJun(xpt+1,m_DRunIN_actRapid_pethTrack,sem_DRunIN_actRapid_pethTrack,1,0.4,colorDarkGray);
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
% errorbarJun(xpt+1,m_DRunIN_actDelay_pethTrack,sem_DRunIN_actDelay_pethTrack,1,0.4,colorDarkGray);
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
errorbarJun(xpt+1,m_DRunIN_ina_pethTrack,sem_DRunIN_ina_pethTrack,1,0.4,colorDarkGray);
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
errorbarJun(xpt+1,m_DRunIN_no_pethTrack,sem_DRunIN_no_pethTrack,1,0.4,colorDarkGray);
text(80, yMaxDRunIN*0.8,['n = ',num2str(n_DRunIN_no_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('IN: no response','fontSize',fontL,'fontWeight','bold');

set(hBarDRunPN,'FaceColor',colorBlack,'EdgeColor','none');
set(hBarDRunIN,'FaceColor',colorBlack,'EdgeColor','none');
set(hPlotDRunPN(1:3),'Box','off','TickDir','out','XLim',[-20 100],'XTick',[-20,0:5:40,100],'YLim',[0, yMaxDRunPN],'fontSize',fontM);
set(hPlotDRunPN(4),'Box','off','TickDir','out','XLim',[-20 100],'XTick',[-20,0:5:40,100],'YLim',[0, yMaxDRunPN],'fontSize',fontM);
set(hPlotDRunPN(5),'Box','off','TickDir','out','XLim',[-20 100],'XTick',[-20,0:5:40,100],'YLim',[0, 10],'fontSize',fontM);
set(hPlotDRunIN(1:3),'Box','off','TickDir','out','XLim',[-20 100],'XTick',[-20,0:5:40,100],'YLim',[0, yMaxDRunIN],'fontSize',fontM);
set(hPlotDRunIN(4),'Box','off','TickDir','out','XLim',[-20 100],'XTick',[-20,0:5:40,100],'YLim',[0, yMaxDRunIN],'fontSize',fontM);

formatOut = 'yymmdd';
print('-painters','-r300','-dtiff',['fig2_pethDRunTrack_',datestr(now,formatOut),'.tif']);
% print('-painters','-r300','-depsc',['fig2_pethDRunTrack_',datestr(now,formatOut),'.ai']);
close;
