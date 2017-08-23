% Latency of neurons which are activated on the platform. (Blue)
% Among neurons which are activated on the platform, latency of neurons which are also activated on the track

% common part
clearvars;

cd('D:\Dropbox\SNL\P2_Track'); % win version
% cd('/Users/Jun/Dropbox/SNL/P2_Track'); % mac version
Txls = readtable('neuronList_ori_170819.xlsx');
load('neuronList_ori_170819.mat');
load myParameters.mat;
Txls.latencyIndex = categorical(Txls.latencyIndex);

DRunPN = T.taskType == 'DRun' & T.idxNeurontype == 'PN';
DRunIN = T.taskType == 'DRun' & T.idxNeurontype == 'IN';
DRun_UNC = T.taskType == 'DRun' & T.idxNeurontype == 'UNC';

DRwPN = T.taskType == 'DRw' & T.idxNeurontype == 'PN';
DRwIN = T.taskType == 'DRw' & T.idxNeurontype == 'IN';
DRw_UNC = T.taskType == 'DRw' & T.idxNeurontype == 'UNC';

% total population (DRwPN / DRwIN / DRwPN / DRwIN) with light responsiveness (light activated)
PN_act = DRunPN & T.pLR_Track<alpha & T.statDir_Track == 1;
% PN_actDirect = DRunPN & T.pLR_Track<alpha & T.statDir_Track == 1 & T.latencyTrack1st<10;
% PN_actIndirect = DRwPN & T.pLR_Track<alpha & T.statDir_Track == 1 & T.latencyTrack1st>10;
PN_ina = DRunPN & T.pLR_Track<alpha & T.statDir_Track == -1;
PN_no = DRunPN & T.pLR_Track>alpha;

PN_actDirect = DRunPN & Txls.latencyIndex == 'direct';
PN_actIndirect = DRunPN & Txls.latencyIndex == 'indirect';
PN_actDouble = DRunPN & Txls.latencyIndex == 'double';

IN_act = DRunIN & T.pLR_Track<alpha & T.statDir_Track == 1;
IN_actDirect = DRunIN & T.pLR_Track<alpha & T.statDir_Track == 1 & T.latencyTrack1st<10;
IN_actIndirect = DRunIN & T.pLR_Track<alpha & T.statDir_Track == 1 & T.latencyTrack1st>10;
IN_ina = DRunIN & T.pLR_Track<alpha & T.statDir_Track == -1;
IN_no = DRunIN & T.pLR_Track>alpha;

%% PETH
DRunPN_act_pethTrack = T.pethTrackLight(PN_act,:);
DRunPN_actRapid_pethTrack = T.pethTrackLight(PN_actDirect,:);
DRunPN_actDelay_pethTrack = T.pethTrackLight(PN_actIndirect,:);
DRunPN_actDouble_pethTrack = T.pethTrackLight(PN_actDouble,:);
DRunPN_ina_pethTrack = T.pethTrackLight(PN_ina,:);
DRunPN_no_pethTrack = T.pethTrackLight(PN_no,:);

DRunIN_act_pethTrack = T.pethTrackLight(IN_act,:);
DRunIN_actRapid_pethTrack = T.pethTrackLight(IN_actDirect,:);
DRunIN_actDelay_pethTrack = T.pethTrackLight(IN_actIndirect,:);
DRunIN_ina_pethTrack = T.pethTrackLight(IN_ina,:);
DRunIN_no_pethTrack = T.pethTrackLight(IN_no,:);

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

n_DRunPN_actDouble_pethTrack = size(DRunPN_actDouble_pethTrack,1);
m_DRunPN_actDouble_pethTrack = mean(DRunPN_actDouble_pethTrack,1);
sem_DRunPN_actDouble_pethTrack = std(DRunPN_actDouble_pethTrack,1)/sqrt(n_DRunPN_actDouble_pethTrack);

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
nCol = 3;
nRow = 4;
xpt = T.pethtimeTrackLight(2,:);
yMaxDRunPN = max([m_DRunPN_act_pethTrack, m_DRunPN_ina_pethTrack, m_DRunPN_no_pethTrack])*2;
yMaxDRunIN = max([m_DRunIN_act_pethTrack, m_DRunIN_ina_pethTrack, m_DRunIN_no_pethTrack])*1.5;

yLimPN = [30 30 70 80 25 10];
yLimIN = [120, 50];
fHandle = figure('PaperUnits','centimeters','PaperPosition',[0 0 40 20],'Name','latDistribution');

% activated total
hPlotDRunPN(1) = axes('Position',axpt(nCol,nRow,1,1,[0.10 0.10 0.85 0.85],wideInterval));
bar(5,yLimPN(1),'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yLimPN(1)*0.925,10,yLimPN(1)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRunPN(1) = bar(xpt,m_DRunPN_act_pethTrack,'histc');
errorbarJun(xpt+1,m_DRunPN_act_pethTrack,sem_DRunPN_act_pethTrack,1,0.4,colorDarkGray);
text(80, yLimPN(1)*0.8,['n = ',num2str(n_DRunPN_act_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN: Total activated','fontSize',fontL,'fontWeight','bold');

% direct activated
hPlotDRunPN(2) = axes('Position',axpt(nCol,nRow,1,2,[0.10 0.10 0.85 0.85],wideInterval));
bar(5,yLimPN(2),'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yLimPN(2)*0.925,10,yLimPN(2)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRunPN(2) = bar(xpt,m_DRunPN_actRapid_pethTrack,'histc');
errorbarJun(xpt+1,m_DRunPN_actRapid_pethTrack,sem_DRunPN_actRapid_pethTrack,1,0.4,colorDarkGray);
text(80, yLimPN(2)*0.8,['n = ',num2str(n_DRunPN_actRapid_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN: Directly activated','fontSize',fontL,'fontWeight','bold');

% indirect activated
hPlotDRunPN(3) = axes('Position',axpt(nCol,nRow,2,2,[0.10 0.10 0.85 0.85],wideInterval));
bar(5,yLimPN(3),'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yLimPN(3)*0.925,10,yLimPN(3)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRunPN(3) = bar(xpt,m_DRunPN_actDelay_pethTrack,'histc');
errorbarJun(xpt+1,m_DRunPN_actDelay_pethTrack,sem_DRunPN_actDelay_pethTrack,1,0.4,colorDarkGray);
text(80, yLimPN(3)*0.8,['n = ',num2str(n_DRunPN_actDelay_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN: Indirectly activated','fontSize',fontL,'fontWeight','bold');

% double
hPlotDRunPN(4) = axes('Position',axpt(nCol,nRow,3,2,[0.10 0.10 0.85 0.85],wideInterval));
bar(5,yLimPN(4),'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yLimPN(4)*0.925,10,yLimPN(4)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRunPN(4) = bar(xpt,m_DRunPN_actDouble_pethTrack,'histc');
errorbarJun(xpt+1,m_DRunPN_actDouble_pethTrack,sem_DRunPN_actDouble_pethTrack,1,0.4,colorDarkGray);
text(80, yLimPN(4)*0.8,['n = ',num2str(n_DRunPN_actDouble_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN: Double activated','fontSize',fontL,'fontWeight','bold');

% inactivated
hPlotDRunPN(5) = axes('Position',axpt(nCol,nRow,2,1,[0.10 0.10 0.85 0.85],wideInterval));
bar(5,yLimPN(5),'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yLimPN(5)*0.925,10,yLimPN(5)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRunPN(5) = bar(xpt,m_DRunPN_ina_pethTrack,'histc');
errorbarJun(xpt+1,m_DRunPN_ina_pethTrack,sem_DRunPN_ina_pethTrack,1,0.4,colorDarkGray);
text(80, yLimPN(5)*0.8,['n = ',num2str(n_DRunPN_ina_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN: inactivated','fontSize',fontL,'fontWeight','bold');

% no response
hPlotDRunPN(6) = axes('Position',axpt(nCol,nRow,3,1,[0.10 0.10 0.85 0.85],wideInterval));
bar(5,yLimPN(6),'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yLimPN(6)*0.925,10,yLimPN(6)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRunPN(6) = bar(xpt,m_DRunPN_no_pethTrack,'histc');
errorbarJun(xpt+1,m_DRunPN_no_pethTrack,sem_DRunPN_no_pethTrack,1,0.4,colorDarkGray);
text(80, yLimPN(6)*0.8,['n = ',num2str(n_DRunPN_no_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN: no response','fontSize',fontL,'fontWeight','bold');

%% Interneuron
hPlotDRunIN(1) = axes('Position',axpt(nCol,nRow,1,3,[0.10 0.10 0.85 0.85],wideInterval));
bar(5,yLimIN(1),'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yLimIN(1)*0.925,10,yLimIN(1)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRunIN(1) = bar(xpt,m_DRunIN_act_pethTrack,'histc');
errorbarJun(xpt+1,m_DRunIN_act_pethTrack,sem_DRunIN_act_pethTrack,1,0.4,colorDarkGray);
text(80, yLimIN(1)*0.8,['n = ',num2str(n_DRunIN_act_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('IN: Total activated','fontSize',fontL,'fontWeight','bold');

hPlotDRunIN(2) = axes('Position',axpt(nCol,nRow,1,4,[0.10 0.10 0.85 0.85],wideInterval));
bar(5,yLimIN(1),'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yLimIN(1)*0.925,10,yLimIN(1)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRunIN(2) = bar(xpt,m_DRunIN_actRapid_pethTrack,'histc');
errorbarJun(xpt+1,m_DRunIN_actRapid_pethTrack,sem_DRunIN_actRapid_pethTrack,1,0.4,colorDarkGray);
text(80, yLimIN(1)*0.8,['n = ',num2str(n_DRunIN_actRapid_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('IN: Directly activated','fontSize',fontL,'fontWeight','bold');

% hPlotDRunIN(3) = axes('Position',axpt(nCol,nRow,2,3,[0.10 0.10 0.85 0.85],wideInterval));
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

hPlotDRunIN(3) = axes('Position',axpt(nCol,nRow,2,3,[0.10 0.10 0.85 0.85],wideInterval));
bar(5,yLimIN(2),'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yLimIN(2)*0.925,10,yLimIN(2)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRunIN(3) = bar(xpt,m_DRunIN_ina_pethTrack,'histc');
errorbarJun(xpt+1,m_DRunIN_ina_pethTrack,sem_DRunIN_ina_pethTrack,1,0.4,colorDarkGray);
text(80, yLimIN(2)*0.8,['n = ',num2str(n_DRunIN_ina_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('IN: inactivated','fontSize',fontL,'fontWeight','bold');

hPlotDRunIN(4) = axes('Position',axpt(nCol,nRow,3,3,[0.10 0.10 0.85 0.85],wideInterval));
bar(5,yLimIN(2),'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yLimIN(2)*0.925,10,yLimIN(2)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRunIN(4) = bar(xpt,m_DRunIN_no_pethTrack,'histc');
errorbarJun(xpt+1,m_DRunIN_no_pethTrack,sem_DRunIN_no_pethTrack,1,0.4,colorDarkGray);
text(80, yLimIN(2)*0.8,['n = ',num2str(n_DRunIN_no_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('IN: no response','fontSize',fontL,'fontWeight','bold');

set(hBarDRunPN,'FaceColor',colorBlack,'EdgeColor','none');
set(hBarDRunIN,'FaceColor',colorBlack,'EdgeColor','none');
set(hPlotDRunPN,'Box','off','TickDir','out','XLim',[-20,100],'XTick',[-20,0:5:40,100],'fontSize',fontM)
set(hPlotDRunPN(1),'YLim',[0, yLimPN(1)]);
set(hPlotDRunPN(2),'YLim',[0, yLimPN(2)]);
set(hPlotDRunPN(3),'YLim',[0, yLimPN(3)]);
set(hPlotDRunPN(4),'YLim',[0, yLimPN(4)]);
set(hPlotDRunPN(5),'YLim',[0, yLimPN(5)]);
set(hPlotDRunPN(6),'YLim',[0, yLimPN(6)]);

set(hPlotDRunIN(1:2),'Box','off','TickDir','out','XLim',[-20 100],'XTick',[-20,0:5:40,100],'YLim',[0, yLimIN(1)],'fontSize',fontM);
set(hPlotDRunIN(3:4),'Box','off','TickDir','out','XLim',[-20 100],'XTick',[-20,0:5:40,100],'YLim',[0, yLimIN(2)],'fontSize',fontM);

formatOut = 'yymmdd';
print('-painters','-r300','-dtiff',['final_fig3_track_lightPETH_DRun_',datestr(now,formatOut),'.tif']);
% print('-painters','-r300','-depsc',[datestr(now,formatOut),'_fig2_pethDRunTrack','.ai']);
close;
