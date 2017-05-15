% Latency of neurons which are activated on the platform. (Blue)
% Among neurons which are activated on the platform, latency of neurons which are also activated on the track

% common part
clearvars;

cd('D:\Dropbox\SNL\P2_Track');
% Txls = readtable('neuronList_21-Mar-2017.xlsx');
% load('neuronList_ori_21-Mar-2017.mat');
load('neuronList_ori_170508.mat');
load myParameters.mat;

cMeanFR = 9;
cMaxPeakFR = 1;
cSpkpvr = 1.1;
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
PN_act = DRunPN & T.statDir_Track == 1;
PN_actRapid = DRunPN & T.pLR_Track<alpha & T.statDir_Track == 1 & T.latencyTrack1st<10;
PN_actDelay = DRunPN & T.pLR_Track<alpha & T.statDir_Track == 1 & T.latencyTrack1st>10;
PN_ina = DRunPN & T.pLR_Track<alpha & T.statDir_Track == -1;
PN_no = DRunPN & T.pLR_Track>alpha;

IN_act = DRunIN & T.pLR_Track<alpha & T.statDir_Track == 1;
IN_actRapid = DRunIN & T.pLR_Track<alpha & T.statDir_Track == 1 & T.latencyTrack1st<10;
IN_actDelay = DRunIN & T.pLR_Track<alpha & T.statDir_Track == 1 & T.latencyTrack1st>10;
IN_ina = DRunIN & T.pLR_Track<alpha & T.statDir_Track == -1;
IN_no = DRunIN & T.pLR_Track>alpha;


%% PETH
DRwPN_act_pethTrack = cell2mat(T.pethTrack8hz(PN_act));
DRwPN_actRapid_pethTrack = cell2mat(T.pethTrack8hz(PN_actRapid));
DRwPN_actDelay_pethTrack = cell2mat(T.pethTrack8hz(PN_actDelay));
DRwPN_ina_pethTrack = cell2mat(T.pethTrack8hz(PN_ina));
DRwPN_no_pethTrack = cell2mat(T.pethTrack8hz(PN_no));

DRwIN_act_pethTrack = cell2mat(T.pethTrack8hz(IN_act));
DRwIN_actRapid_pethTrack = cell2mat(T.pethTrack8hz(IN_actRapid));
DRwIN_actDelay_pethTrack = cell2mat(T.pethTrack8hz(IN_actDelay));
DRwIN_ina_pethTrack = cell2mat(T.pethTrack8hz(IN_ina));
DRwIN_no_pethTrack = cell2mat(T.pethTrack8hz(IN_no));

%% Mean & Sem
n_DRwPN_act_pethTrack = size(DRwPN_act_pethTrack,1);
m_DRwPN_act_pethTrack = mean(DRwPN_act_pethTrack,1);
sem_DRwPN_act_pethTrack = std(DRwPN_act_pethTrack,1)/n_DRwPN_act_pethTrack;

n_DRwPN_actRapid_pethTrack = size(DRwPN_actRapid_pethTrack,1);
m_DRwPN_actRapid_pethTrack = mean(DRwPN_actRapid_pethTrack,1);
sem_DRwPN_actRapid_pethTrack = std(DRwPN_actRapid_pethTrack,1)/n_DRwPN_actRapid_pethTrack;

n_DRwPN_actDelay_pethTrack = size(DRwPN_actDelay_pethTrack,1);
m_DRwPN_actDelay_pethTrack = mean(DRwPN_actDelay_pethTrack,1);
sem_DRwPN_actDelay_pethTrack = std(DRwPN_actDelay_pethTrack,1)/n_DRwPN_actDelay_pethTrack;

n_DRwPN_ina_pethTrack = size(DRwPN_ina_pethTrack,1);
m_DRwPN_ina_pethTrack = mean(DRwPN_ina_pethTrack,1);
sem_DRwPN_ina_pethTrack = std(DRwPN_ina_pethTrack,1)/n_DRwPN_ina_pethTrack;

n_DRwPN_no_pethTrack = size(DRwPN_no_pethTrack,1);
m_DRwPN_no_pethTrack = mean(DRwPN_no_pethTrack,1);
sem_DRwPN_no_pethTrack = std(DRwPN_no_pethTrack,1)/n_DRwPN_no_pethTrack;


n_DRwIN_act_pethTrack = size(DRwIN_act_pethTrack,1);
m_DRwIN_act_pethTrack = mean(DRwIN_act_pethTrack,1);
sem_DRwIN_act_pethTrack = std(DRwIN_act_pethTrack,1)/n_DRwIN_act_pethTrack;

n_DRwIN_actRapid_pethTrack = size(DRwIN_actRapid_pethTrack,1);
m_DRwIN_actRapid_pethTrack = mean(DRwIN_actRapid_pethTrack,1);
sem_DRwIN_actRapid_pethTrack = std(DRwIN_actRapid_pethTrack,1)/n_DRwIN_actRapid_pethTrack;

n_DRwIN_actDelay_pethTrack = size(DRwIN_actDelay_pethTrack,1);
m_DRwIN_actDelay_pethTrack = mean(DRwIN_actDelay_pethTrack,1);
sem_DRwIN_actDelay_pethTrack = std(DRwIN_actDelay_pethTrack,1)/n_DRwIN_actDelay_pethTrack;

n_DRwIN_ina_pethTrack = size(DRwIN_ina_pethTrack,1);
m_DRwIN_ina_pethTrack = mean(DRwIN_ina_pethTrack,1);
sem_DRwIN_ina_pethTrack = std(DRwIN_ina_pethTrack,1)/n_DRwIN_ina_pethTrack;

n_DRwIN_no_pethTrack = size(DRwIN_no_pethTrack,1);
m_DRwIN_no_pethTrack = mean(DRwIN_no_pethTrack,1);
sem_DRwIN_no_pethTrack = std(DRwIN_no_pethTrack,1)/n_DRwIN_no_pethTrack;

%%
nCol = 2;
nRow = 5;
xpt = T.pethtimeTrack8hz{end};
yMaxDRwPN = max([m_DRwPN_act_pethTrack, m_DRwPN_ina_pethTrack, m_DRwPN_no_pethTrack])*2;
yMaxDRwIN = max([m_DRwIN_act_pethTrack, m_DRwIN_ina_pethTrack, m_DRwIN_no_pethTrack])*1.5;

fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1},'Name','latDistribution_PNIN_DRwTrack');

hPlotDRwPN(1) = axes('Position',axpt(nCol,nRow,1,1,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxDRwPN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxDRwPN*0.925,10,yMaxDRwPN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRwPN(1) = bar(xpt,m_DRwPN_act_pethTrack,'histc');
errorbarJun(xpt+1,m_DRwPN_act_pethTrack,sem_DRwPN_act_pethTrack,1,0.4,colorDarkGray);
text(80, yMaxDRwPN*0.8,['n = ',num2str(n_DRwPN_act_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN: Total activated','fontSize',fontL,'fontWeight','bold');

hPlotDRwPN(2) = axes('Position',axpt(nCol,nRow,1,2,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxDRwPN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxDRwPN*0.925,10,yMaxDRwPN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRwPN(2) = bar(xpt,m_DRwPN_actRapid_pethTrack,'histc');
errorbarJun(xpt+1,m_DRwPN_actRapid_pethTrack,sem_DRwPN_actRapid_pethTrack,1,0.4,colorDarkGray);
text(80, yMaxDRwPN*0.8,['n = ',num2str(n_DRwPN_actRapid_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN: Rapid activated','fontSize',fontL,'fontWeight','bold');

hPlotDRwPN(3) = axes('Position',axpt(nCol,nRow,1,3,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxDRwPN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxDRwPN*0.925,10,yMaxDRwPN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRwPN(3) = bar(xpt,m_DRwPN_actDelay_pethTrack,'histc');
errorbarJun(xpt+1,m_DRwPN_actDelay_pethTrack,sem_DRwPN_actDelay_pethTrack,1,0.4,colorDarkGray);
text(80, yMaxDRwPN*0.8,['n = ',num2str(n_DRwPN_actDelay_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN: Delay activated','fontSize',fontL,'fontWeight','bold');

hPlotDRwPN(4) = axes('Position',axpt(nCol,nRow,1,4,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxDRwPN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxDRwPN*0.925,10,yMaxDRwPN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRwPN(4) = bar(xpt,m_DRwPN_ina_pethTrack,'histc');
errorbarJun(xpt+1,m_DRwPN_ina_pethTrack,sem_DRwPN_ina_pethTrack,1,0.4,colorDarkGray);
text(80, yMaxDRwPN*0.8,['n = ',num2str(n_DRwPN_ina_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN: inactivated','fontSize',fontL,'fontWeight','bold');

hPlotDRwPN(5) = axes('Position',axpt(nCol,nRow,1,5,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxDRwPN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxDRwPN*0.925,10,yMaxDRwPN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRwPN(5) = bar(xpt,m_DRwPN_no_pethTrack,'histc');
errorbarJun(xpt+1,m_DRwPN_no_pethTrack,sem_DRwPN_no_pethTrack,1,0.4,colorDarkGray);
text(80, 10*0.8,['n = ',num2str(n_DRwPN_no_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN: no response','fontSize',fontL,'fontWeight','bold');

hPlotDRwIN(1) = axes('Position',axpt(nCol,nRow,2,1,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxDRwIN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxDRwIN*0.925,10,yMaxDRwIN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRwIN(1) = bar(xpt,m_DRwIN_act_pethTrack,'histc');
errorbarJun(xpt+1,m_DRwIN_act_pethTrack,sem_DRwIN_act_pethTrack,1,0.4,colorDarkGray);
text(80, yMaxDRwIN*0.8,['n = ',num2str(n_DRwIN_act_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('IN: Total activated','fontSize',fontL,'fontWeight','bold');

hPlotDRwIN(2) = axes('Position',axpt(nCol,nRow,2,2,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxDRwIN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxDRwIN*0.925,10,yMaxDRwIN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRwIN(2) = bar(xpt,m_DRwIN_actRapid_pethTrack,'histc');
errorbarJun(xpt+1,m_DRwIN_actRapid_pethTrack,sem_DRwIN_actRapid_pethTrack,1,0.4,colorDarkGray);
text(80, yMaxDRwIN*0.8,['n = ',num2str(n_DRwIN_actRapid_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('IN: Rapid activated','fontSize',fontL,'fontWeight','bold');

% hPlotDRwIN(3) = axes('Position',axpt(nCol,nRow,2,3,[0.10 0.10 0.85 0.8],wideInterval));
% bar(5,yMaxDRwIN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
% hold on;
% rectangle('Position',[0,yMaxDRwIN*0.925,10,yMaxDRwIN*0.075],'LineStyle','none','FaceColor',colorBlue);
% hold on;
% hBarDRwIN(3) = bar(xpt,m_DRwIN_actDelay_pethTrack,'histc');
% errorbarJun(xpt+1,m_DRwIN_actDelay_pethTrack,sem_DRwIN_actDelay_pethTrack,1,0.4,colorDarkGray);
% text(100, yMaxDRwIN*0.8,['n = ',num2str(n_DRwIN_actDelay_pethTrack)],'fontSize',fontL);
% xlabel('Time (ms)','fontSize',fontL);
% ylabel('Spikes/bin','fontSize',fontL);
% title('IN: Delay activated','fontSize',fontL,'fontWeight','bold');

hPlotDRwIN(3) = axes('Position',axpt(nCol,nRow,2,4,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxDRwIN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxDRwIN*0.925,10,yMaxDRwIN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRwIN(3) = bar(xpt,m_DRwIN_ina_pethTrack,'histc');
errorbarJun(xpt+1,m_DRwIN_ina_pethTrack,sem_DRwIN_ina_pethTrack,1,0.4,colorDarkGray);
text(80, yMaxDRwIN*0.8,['n = ',num2str(n_DRwIN_ina_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('IN: inactivated','fontSize',fontL,'fontWeight','bold');

hPlotDRwIN(4) = axes('Position',axpt(nCol,nRow,2,5,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxDRwIN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxDRwIN*0.925,10,yMaxDRwIN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRwIN(4) = bar(xpt,m_DRwIN_no_pethTrack,'histc');
errorbarJun(xpt+1,m_DRwIN_no_pethTrack,sem_DRwIN_no_pethTrack,1,0.4,colorDarkGray);
text(80, yMaxDRwIN*0.8,['n = ',num2str(n_DRwIN_no_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('IN: no response','fontSize',fontL,'fontWeight','bold');

set(hBarDRwPN,'FaceColor',colorBlack,'EdgeColor','none');
set(hBarDRwIN,'FaceColor',colorBlack,'EdgeColor','none');
set(hPlotDRwPN(1:3),'Box','off','TickDir','out','XLim',[-20 100],'XTick',[-20,0:5:20,100],'YLim',[0, yMaxDRwPN],'fontSize',fontM);
set(hPlotDRwPN(4),'Box','off','TickDir','out','XLim',[-20 100],'XTick',[-20,0:5:20,100],'YLim',[0, yMaxDRwPN],'fontSize',fontM);
set(hPlotDRwPN(5),'Box','off','TickDir','out','XLim',[-20 100],'XTick',[-20,0:5:20,100],'YLim',[0, 10],'fontSize',fontM);
set(hPlotDRwIN(1:3),'Box','off','TickDir','out','XLim',[-20 100],'XTick',[-20,0:5:20,100],'YLim',[0, yMaxDRwIN],'fontSize',fontM);
set(hPlotDRwIN(4),'Box','off','TickDir','out','XLim',[-20 100],'XTick',[-20,0:5:20,100],'YLim',[0, yMaxDRwIN],'fontSize',fontM);

formatOut = 'yymmdd';
% print('-painters','-r300','plot_latencyPETH_DRwPlfm.tif','-dtiff');
print('-painters','-r300','-depsc',['fig2_pethDRunTrack_',datestr(now,formatOut),'.ai']);
close;
