% Latency of neurons which are activated on the platform. (Blue)
% Among neurons which are activated on the platform, latency of neurons which are also activated on the track

% common part
clearvars;

cd('D:\Dropbox\SNL\P2_Track'); % win version
% cd('/Users/Jun/Dropbox/SNL/P2_Track'); % mac version
Txls = readtable('neuronList_ori_170909.xlsx');
% Txls = readtable('neuronList_ori_170819.xlsx');
% load('neuronList_ori_170819.mat');
load('neuronList_ori_170909.mat');
load myParameters.mat;
Txls.latencyIndex = categorical(Txls.latencyIndex);

DRunPN = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & logical([zeros(550,1);ones(468,1)]);
DRunIN = T.taskType == 'DRun' & T.idxNeurontype == 'IN' & logical([zeros(550,1);ones(468,1)]);
DRun_UNC = T.taskType == 'DRun' & T.idxNeurontype == 'UNC' & logical([zeros(550,1);ones(468,1)]);

DRwPN = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & logical([zeros(550,1);ones(468,1)]);
DRwIN = T.taskType == 'DRw' & T.idxNeurontype == 'IN' & logical([zeros(550,1);ones(468,1)]);
DRw_UNC = T.taskType == 'DRw' & T.idxNeurontype == 'UNC' & logical([zeros(550,1);ones(468,1)]);

% total population (DRwPN / DRwIN / DRwPN / DRwIN) with light responsiveness (light activated)
PN_act = DRunPN & T.pLR_Plfm8hz<alpha & T.statDir_Plfm8hz == 1;
PN_ina = DRunPN & T.pLR_Plfm8hz<alpha & T.statDir_Plfm8hz == -1;
PN_no = DRunPN & T.pLR_Plfm8hz>alpha;

PN_actDirect = DRunPN & Txls.latencyIndex == 'direct';
PN_actIndirect = DRunPN & Txls.latencyIndex == 'indirect';
PN_actDouble = DRunPN & Txls.latencyIndex == 'double';

%% PETH
DRunPN_act_pethTrack = cell2mat(T.pethPlfm8hz(PN_act,:));
DRunPN_actRapid_pethTrack = cell2mat(T.pethPlfm8hz(PN_actDirect,:));
DRunPN_actDelay_pethTrack = cell2mat(T.pethPlfm8hz(PN_actIndirect,:));
DRunPN_actDouble_pethTrack = cell2mat(T.pethPlfm8hz(PN_actDouble,:));
DRunPN_ina_pethTrack = cell2mat(T.pethPlfm8hz(PN_ina,:));
DRunPN_no_pethTrack = cell2mat(T.pethPlfm8hz(PN_no,:));

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


%%
nCol = 3;
nRow = 4;
xpt = cell2mat(T.pethtimePlfm8hz(551,:));
yMaxDRunPN = max([m_DRunPN_act_pethTrack, m_DRunPN_ina_pethTrack, m_DRunPN_no_pethTrack])*2;

yLimPN = [30 30 70 80 25 10];
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


set(hBarDRunPN,'FaceColor',colorBlack,'EdgeColor','none');
set(hPlotDRunPN,'Box','off','TickDir','out','XLim',[-20,100],'XTick',[-20,0:5:40,100],'fontSize',fontM)
set(hPlotDRunPN(1),'YLim',[0, yLimPN(1)]);
set(hPlotDRunPN(2),'YLim',[0, yLimPN(2)]);
set(hPlotDRunPN(3),'YLim',[0, yLimPN(3)]);
set(hPlotDRunPN(4),'YLim',[0, yLimPN(4)]);
set(hPlotDRunPN(5),'YLim',[0, yLimPN(5)]);
set(hPlotDRunPN(6),'YLim',[0, yLimPN(6)]);

formatOut = 'yymmdd';
% print('-painters','-r300','-dtiff',['final_fig3_track_lightPETH_DRun_',datestr(now,formatOut),'.tif']);
% print('-painters','-r300','-depsc',[datestr(now,formatOut),'_fig2_pethDRunTrack','.ai']);
% close;
