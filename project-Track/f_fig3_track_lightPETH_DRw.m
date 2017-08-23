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

DRwPN = T.taskType == 'DRw' & T.idxNeurontype == 'PN';
DRwIN = T.taskType == 'DRw' & T.idxNeurontype == 'IN';
DRw_UNC = T.taskType == 'DRw' & T.idxNeurontype == 'UNC';

DRwPN = T.taskType == 'DRw' & T.idxNeurontype == 'PN';
DRwIN = T.taskType == 'DRw' & T.idxNeurontype == 'IN';
DRw_UNC = T.taskType == 'DRw' & T.idxNeurontype == 'UNC';

% total population (DRwPN / DRwIN / DRwPN / DRwIN) with light responsiveness (light activated)
PN_act = DRwPN & T.pLR_Track<alpha & T.statDir_Track == 1;
% PN_actDirect = DRwPN & T.pLR_Track<alpha & T.statDir_Track == 1 & T.latencyTrack1st<10;
% PN_actIndirect = DRwPN & T.pLR_Track<alpha & T.statDir_Track == 1 & T.latencyTrack1st>10;
PN_ina = DRwPN & T.pLR_Track<alpha & T.statDir_Track == -1;
PN_no = DRwPN & T.pLR_Track>alpha;

PN_actDirect = DRwPN & Txls.latencyIndex == 'direct';
PN_actIndirect = DRwPN & Txls.latencyIndex == 'indirect';
PN_actDouble = DRwPN & Txls.latencyIndex == 'double';

IN_act = DRwIN & T.pLR_Track<alpha & T.statDir_Track == 1;
IN_actDirect = DRwIN & T.pLR_Track<alpha & T.statDir_Track == 1 & T.latencyTrack1st<10;
IN_actIndirect = DRwIN & T.pLR_Track<alpha & T.statDir_Track == 1 & T.latencyTrack1st>10;
IN_ina = DRwIN & T.pLR_Track<alpha & T.statDir_Track == -1;
IN_no = DRwIN & T.pLR_Track>alpha;

%% PETH
DRwPN_act_pethTrack = T.pethTrackLight(PN_act,:);
DRwPN_actRapid_pethTrack = T.pethTrackLight(PN_actDirect,:);
DRwPN_actDelay_pethTrack = T.pethTrackLight(PN_actIndirect,:);
DRwPN_actDouble_pethTrack = T.pethTrackLight(PN_actDouble,:);
DRwPN_ina_pethTrack = T.pethTrackLight(PN_ina,:);
DRwPN_no_pethTrack = T.pethTrackLight(PN_no,:);

DRwIN_act_pethTrack = T.pethTrackLight(IN_act,:);
DRwIN_actRapid_pethTrack = T.pethTrackLight(IN_actDirect,:);
DRwIN_actDelay_pethTrack = T.pethTrackLight(IN_actIndirect,:);
DRwIN_ina_pethTrack = T.pethTrackLight(IN_ina,:);
DRwIN_no_pethTrack = T.pethTrackLight(IN_no,:);

%% Mean & Sem
n_DRwPN_act_pethTrack = size(DRwPN_act_pethTrack,1);
m_DRwPN_act_pethTrack = mean(DRwPN_act_pethTrack,1);
sem_DRwPN_act_pethTrack = std(DRwPN_act_pethTrack,1)/sqrt(n_DRwPN_act_pethTrack);

n_DRwPN_actRapid_pethTrack = size(DRwPN_actRapid_pethTrack,1);
m_DRwPN_actRapid_pethTrack = mean(DRwPN_actRapid_pethTrack,1);
sem_DRwPN_actRapid_pethTrack = std(DRwPN_actRapid_pethTrack,1)/sqrt(n_DRwPN_actRapid_pethTrack);

n_DRwPN_actDelay_pethTrack = size(DRwPN_actDelay_pethTrack,1);
m_DRwPN_actDelay_pethTrack = mean(DRwPN_actDelay_pethTrack,1);
sem_DRwPN_actDelay_pethTrack = std(DRwPN_actDelay_pethTrack,1)/sqrt(n_DRwPN_actDelay_pethTrack);

n_DRwPN_actDouble_pethTrack = size(DRwPN_actDouble_pethTrack,1);
m_DRwPN_actDouble_pethTrack = mean(DRwPN_actDouble_pethTrack,1);
sem_DRwPN_actDouble_pethTrack = std(DRwPN_actDouble_pethTrack,1)/sqrt(n_DRwPN_actDouble_pethTrack);

n_DRwPN_ina_pethTrack = size(DRwPN_ina_pethTrack,1);
m_DRwPN_ina_pethTrack = mean(DRwPN_ina_pethTrack,1);
sem_DRwPN_ina_pethTrack = std(DRwPN_ina_pethTrack,1)/sqrt(n_DRwPN_ina_pethTrack);

n_DRwPN_no_pethTrack = size(DRwPN_no_pethTrack,1);
m_DRwPN_no_pethTrack = mean(DRwPN_no_pethTrack,1);
sem_DRwPN_no_pethTrack = std(DRwPN_no_pethTrack,1)/sqrt(n_DRwPN_no_pethTrack);


n_DRwIN_act_pethTrack = size(DRwIN_act_pethTrack,1);
m_DRwIN_act_pethTrack = mean(DRwIN_act_pethTrack,1);
sem_DRwIN_act_pethTrack = std(DRwIN_act_pethTrack,1)/sqrt(n_DRwIN_act_pethTrack);

n_DRwIN_actRapid_pethTrack = size(DRwIN_actRapid_pethTrack,1);
m_DRwIN_actRapid_pethTrack = mean(DRwIN_actRapid_pethTrack,1);
sem_DRwIN_actRapid_pethTrack = std(DRwIN_actRapid_pethTrack,1)/sqrt(n_DRwIN_actRapid_pethTrack);

n_DRwIN_actDelay_pethTrack = size(DRwIN_actDelay_pethTrack,1);
m_DRwIN_actDelay_pethTrack = mean(DRwIN_actDelay_pethTrack,1);
sem_DRwIN_actDelay_pethTrack = std(DRwIN_actDelay_pethTrack,1)/sqrt(n_DRwIN_actDelay_pethTrack);

n_DRwIN_ina_pethTrack = size(DRwIN_ina_pethTrack,1);
m_DRwIN_ina_pethTrack = mean(DRwIN_ina_pethTrack,1);
sem_DRwIN_ina_pethTrack = std(DRwIN_ina_pethTrack,1)/sqrt(n_DRwIN_ina_pethTrack);

n_DRwIN_no_pethTrack = size(DRwIN_no_pethTrack,1);
m_DRwIN_no_pethTrack = mean(DRwIN_no_pethTrack,1);
sem_DRwIN_no_pethTrack = std(DRwIN_no_pethTrack,1)/sqrt(n_DRwIN_no_pethTrack);

%%
nCol = 3;
nRow = 4;
xpt = T.pethtimeTrackLight(2,:);
yMaxDRwPN = max([m_DRwPN_act_pethTrack, m_DRwPN_ina_pethTrack, m_DRwPN_no_pethTrack])*2;
yMaxDRwIN = max([m_DRwIN_act_pethTrack, m_DRwIN_ina_pethTrack, m_DRwIN_no_pethTrack])*1.5;

yLimPN = [30 30 70 80 25 10];
yLimIN = [120, 50];
fHandle = figure('PaperUnits','centimeters','PaperPosition',[0 0 40 20],'Name','latDistribution');

% activated total
hPlotDRwPN(1) = axes('Position',axpt(nCol,nRow,1,1,[0.10 0.10 0.85 0.85],wideInterval));
bar(5,yLimPN(1),'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yLimPN(1)*0.925,10,yLimPN(1)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRwPN(1) = bar(xpt,m_DRwPN_act_pethTrack,'histc');
errorbarJun(xpt+1,m_DRwPN_act_pethTrack,sem_DRwPN_act_pethTrack,1,0.4,colorDarkGray);
text(80, yLimPN(1)*0.8,['n = ',num2str(n_DRwPN_act_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN: Total activated','fontSize',fontL,'fontWeight','bold');

% direct activated
hPlotDRwPN(2) = axes('Position',axpt(nCol,nRow,1,2,[0.10 0.10 0.85 0.85],wideInterval));
bar(5,yLimPN(2),'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yLimPN(2)*0.925,10,yLimPN(2)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRwPN(2) = bar(xpt,m_DRwPN_actRapid_pethTrack,'histc');
errorbarJun(xpt+1,m_DRwPN_actRapid_pethTrack,sem_DRwPN_actRapid_pethTrack,1,0.4,colorDarkGray);
text(80, yLimPN(2)*0.8,['n = ',num2str(n_DRwPN_actRapid_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN: Directly activated','fontSize',fontL,'fontWeight','bold');

% indirect activated
hPlotDRwPN(3) = axes('Position',axpt(nCol,nRow,2,2,[0.10 0.10 0.85 0.85],wideInterval));
bar(5,yLimPN(3),'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yLimPN(3)*0.925,10,yLimPN(3)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRwPN(3) = bar(xpt,m_DRwPN_actDelay_pethTrack,'histc');
errorbarJun(xpt+1,m_DRwPN_actDelay_pethTrack,sem_DRwPN_actDelay_pethTrack,1,0.4,colorDarkGray);
text(80, yLimPN(3)*0.8,['n = ',num2str(n_DRwPN_actDelay_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN: Indirectly activated','fontSize',fontL,'fontWeight','bold');

% double
hPlotDRwPN(4) = axes('Position',axpt(nCol,nRow,3,2,[0.10 0.10 0.85 0.85],wideInterval));
bar(5,yLimPN(4),'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yLimPN(4)*0.925,10,yLimPN(4)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRwPN(4) = bar(xpt,m_DRwPN_actDouble_pethTrack,'histc');
errorbarJun(xpt+1,m_DRwPN_actDouble_pethTrack,sem_DRwPN_actDouble_pethTrack,1,0.4,colorDarkGray);
text(80, yLimPN(4)*0.8,['n = ',num2str(n_DRwPN_actDouble_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN: Double activated','fontSize',fontL,'fontWeight','bold');

% inactivated
hPlotDRwPN(5) = axes('Position',axpt(nCol,nRow,2,1,[0.10 0.10 0.85 0.85],wideInterval));
bar(5,yLimPN(5),'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yLimPN(5)*0.925,10,yLimPN(5)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRwPN(5) = bar(xpt,m_DRwPN_ina_pethTrack,'histc');
errorbarJun(xpt+1,m_DRwPN_ina_pethTrack,sem_DRwPN_ina_pethTrack,1,0.4,colorDarkGray);
text(80, yLimPN(5)*0.8,['n = ',num2str(n_DRwPN_ina_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN: inactivated','fontSize',fontL,'fontWeight','bold');

% no response
hPlotDRwPN(6) = axes('Position',axpt(nCol,nRow,3,1,[0.10 0.10 0.85 0.85],wideInterval));
bar(5,yLimPN(6),'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yLimPN(6)*0.925,10,yLimPN(6)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRwPN(6) = bar(xpt,m_DRwPN_no_pethTrack,'histc');
errorbarJun(xpt+1,m_DRwPN_no_pethTrack,sem_DRwPN_no_pethTrack,1,0.4,colorDarkGray);
text(80, yLimPN(6)*0.8,['n = ',num2str(n_DRwPN_no_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN: no response','fontSize',fontL,'fontWeight','bold');

%% Interneuron
hPlotDRwIN(1) = axes('Position',axpt(nCol,nRow,1,3,[0.10 0.10 0.85 0.85],wideInterval));
bar(5,yLimIN(1),'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yLimIN(1)*0.925,10,yLimIN(1)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRwIN(1) = bar(xpt,m_DRwIN_act_pethTrack,'histc');
errorbarJun(xpt+1,m_DRwIN_act_pethTrack,sem_DRwIN_act_pethTrack,1,0.4,colorDarkGray);
text(80, yLimIN(1)*0.8,['n = ',num2str(n_DRwIN_act_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('IN: Total activated','fontSize',fontL,'fontWeight','bold');

hPlotDRwIN(2) = axes('Position',axpt(nCol,nRow,1,4,[0.10 0.10 0.85 0.85],wideInterval));
bar(5,yLimIN(1),'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yLimIN(1)*0.925,10,yLimIN(1)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRwIN(2) = bar(xpt,m_DRwIN_actRapid_pethTrack,'histc');
errorbarJun(xpt+1,m_DRwIN_actRapid_pethTrack,sem_DRwIN_actRapid_pethTrack,1,0.4,colorDarkGray);
text(80, yLimIN(1)*0.8,['n = ',num2str(n_DRwIN_actRapid_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('IN: Directly activated','fontSize',fontL,'fontWeight','bold');

% hPlotDRwIN(3) = axes('Position',axpt(nCol,nRow,2,3,[0.10 0.10 0.85 0.85],wideInterval));
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

hPlotDRwIN(3) = axes('Position',axpt(nCol,nRow,2,3,[0.10 0.10 0.85 0.85],wideInterval));
bar(5,yLimIN(2),'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yLimIN(2)*0.925,10,yLimIN(2)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRwIN(3) = bar(xpt,m_DRwIN_ina_pethTrack,'histc');
errorbarJun(xpt+1,m_DRwIN_ina_pethTrack,sem_DRwIN_ina_pethTrack,1,0.4,colorDarkGray);
text(80, yLimIN(2)*0.8,['n = ',num2str(n_DRwIN_ina_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('IN: inactivated','fontSize',fontL,'fontWeight','bold');

hPlotDRwIN(4) = axes('Position',axpt(nCol,nRow,3,3,[0.10 0.10 0.85 0.85],wideInterval));
bar(5,yLimIN(2),'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yLimIN(2)*0.925,10,yLimIN(2)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRwIN(4) = bar(xpt,m_DRwIN_no_pethTrack,'histc');
errorbarJun(xpt+1,m_DRwIN_no_pethTrack,sem_DRwIN_no_pethTrack,1,0.4,colorDarkGray);
text(80, yLimIN(2)*0.8,['n = ',num2str(n_DRwIN_no_pethTrack)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('IN: no response','fontSize',fontL,'fontWeight','bold');

set(hBarDRwPN,'FaceColor',colorBlack,'EdgeColor','none');
set(hBarDRwIN,'FaceColor',colorBlack,'EdgeColor','none');
set(hPlotDRwPN,'Box','off','TickDir','out','XLim',[-20,100],'XTick',[-20,0:5:40,100],'fontSize',fontM)
set(hPlotDRwPN(1),'YLim',[0, yLimPN(1)]);
set(hPlotDRwPN(2),'YLim',[0, yLimPN(2)]);
set(hPlotDRwPN(3),'YLim',[0, yLimPN(3)]);
set(hPlotDRwPN(4),'YLim',[0, yLimPN(4)]);
set(hPlotDRwPN(5),'YLim',[0, yLimPN(5)]);
set(hPlotDRwPN(6),'YLim',[0, yLimPN(6)]);

set(hPlotDRwIN(1:2),'Box','off','TickDir','out','XLim',[-20 100],'XTick',[-20,0:5:40,100],'YLim',[0, yLimIN(1)],'fontSize',fontM);
set(hPlotDRwIN(3:4),'Box','off','TickDir','out','XLim',[-20 100],'XTick',[-20,0:5:40,100],'YLim',[0, yLimIN(2)],'fontSize',fontM);

formatOut = 'yymmdd';
print('-painters','-r300','-dtiff',['final_fig3_track_lightPETH_DRw_',datestr(now,formatOut),'.tif']);
% print('-painters','-r300','-depsc',[datestr(now,formatOut),'_fig2_pethDRwTrack','.ai']);
close;
