% Latency of neurons which are activated on the platform. (Blue)
% Among neurons which are activated on the platform, latency of neurons which are also activated on the track

% common part
clearvars;

cd('D:\Dropbox\SNL\P2_Track'); % win version
% cd('/Users/Jun/Dropbox/SNL/P2_Track'); % mac version
Txls = readtable('neuronList_ori50hz_171012.xlsx');
load('neuronList_ori50hz_171012.mat');
load myParameters.mat;
Txls.latencyIndex = categorical(Txls.latencyIndex);
formatOut = 'yymmdd';

DRwPN = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
DRwIN = T.taskType == 'DRw' & T.idxNeurontype == 'IN';
DRw_UNC = T.taskType == 'DRw' & T.idxNeurontype == 'UNC';

% total population (DRwPN / DRwIN / DRwPN / DRwIN) with light responsiveness (light activated)
PN_act = DRwPN & T.idxpLR_Track & T.statDir_Track == 1;
PN_ina = DRwPN & T.idxpLR_Track & T.statDir_Track == -1;
PN_no = DRwPN & ~T.idxpLR_Track;

PN_actDirect = DRwPN & Txls.latencyIndex == 'direct';
PN_actIndirect = DRwPN & Txls.latencyIndex == 'indirect';
PN_actDouble = DRwPN & Txls.latencyIndex == 'double';

IN_act = DRwIN & T.idxpLR_Track & T.statDir_Track == 1;
IN_actDirect = DRwIN & T.idxpLR_Track & T.statDir_Track == 1 & Txls.latencyIndex == 'direct';
IN_actIndirect = DRwIN & T.idxpLR_Track & T.statDir_Track == 1 & Txls.latencyIndex == 'indirect';
IN_ina = DRwIN & T.idxpLR_Track & T.statDir_Track == -1;
IN_no = DRwIN & ~T.idxpLR_Track;

%% PETH
DRwPN_act_pethTrack = cell2mat(T.pethTrack50hz(PN_act,:));
DRwPN_actRapid_pethTrack = cell2mat(T.pethTrack50hz(PN_actDirect,:));
DRwPN_actDelay_pethTrack = cell2mat(T.pethTrack50hz(PN_actIndirect,:));
DRwPN_actDouble_pethTrack = cell2mat(T.pethTrack50hz(PN_actDouble,:));
DRwPN_ina_pethTrack = cell2mat(T.pethTrack50hz(PN_ina,:));
DRwPN_no_pethTrack = cell2mat(T.pethTrack50hz(PN_no,:));

DRwIN_act_pethTrack = cell2mat(T.pethTrack50hz(IN_act,:));
DRwIN_actRapid_pethTrack = cell2mat(T.pethTrack50hz(IN_actDirect,:));
DRwIN_actDelay_pethTrack = cell2mat(T.pethTrack50hz(IN_actIndirect,:));
DRwIN_ina_pethTrack = cell2mat(T.pethTrack50hz(IN_ina,:));
DRwIN_no_pethTrack = cell2mat(T.pethTrack50hz(IN_no,:));

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
nCol = 2;
nRow = 2;
xpt = cell2mat(T.pethtimeTrack50hz(2,:));
yMaxDRwPN = max([m_DRwPN_act_pethTrack, m_DRwPN_ina_pethTrack, m_DRwPN_no_pethTrack])*2;
yMaxDRwIN = max([m_DRwIN_act_pethTrack, m_DRwIN_ina_pethTrack, m_DRwIN_no_pethTrack])*1.5;

yLimPN = [30 25 10];
yLimIN = [120, 40, 100];

fHandle = figure('Paperunits','centimeters','PaperPosition',paperSize{1});
% activated total
hPlotDRwPN(1) = axes('Position',axpt(2,4,1,1,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
bar(5,yLimPN(1),'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yLimPN(1)*0.925,10,yLimPN(1)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRwPN(1) = bar(xpt,m_DRwPN_act_pethTrack,'histc');
errorbarJun(xpt+1,m_DRwPN_act_pethTrack,sem_DRwPN_act_pethTrack,1,0.4,colorDarkGray);
text(80, yLimPN(1)*0.8,['n = ',num2str(n_DRwPN_act_pethTrack)],'fontSize',fontS);
xlabel('Time (ms)','fontSize',fontS);
ylabel('Spikes/bin','fontSize',fontS);
title('PN: Total activated','fontSize',fontS,'fontWeight','bold');

% inactivated
hPlotDRwPN(2) = axes('Position',axpt(2,4,1,2,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
bar(5,yLimPN(2),'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yLimPN(2)*0.925,10,yLimPN(2)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRwPN(2) = bar(xpt,m_DRwPN_ina_pethTrack,'histc');
errorbarJun(xpt+1,m_DRwPN_ina_pethTrack,sem_DRwPN_ina_pethTrack,1,0.4,colorDarkGray);
text(80, yLimPN(2)*0.8,['n = ',num2str(n_DRwPN_ina_pethTrack)],'fontSize',fontS);
xlabel('Time (ms)','fontSize',fontS);
ylabel('Spikes/bin','fontSize',fontS);
title('PN: inactivated','fontSize',fontS,'fontWeight','bold');

% no response
hPlotDRwPN(3) = axes('Position',axpt(2,4,1,3,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
bar(5,yLimPN(3),'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yLimPN(3)*0.925,10,yLimPN(3)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRwPN(3) = bar(xpt,m_DRwPN_no_pethTrack,'histc');
errorbarJun(xpt+1,m_DRwPN_no_pethTrack,sem_DRwPN_no_pethTrack,1,0.4,colorDarkGray);
text(80, yLimPN(3)*0.8,['n = ',num2str(n_DRwPN_no_pethTrack)],'fontSize',fontS);
xlabel('Time (ms)','fontSize',fontS);
ylabel('Spikes/bin','fontSize',fontS);
title('PN: no response','fontSize',fontS,'fontWeight','bold');

%% Interneuron
hPlotDRwIN(1) = axes('Position',axpt(2,4,2,1,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
bar(5,yLimIN(1),'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yLimIN(1)*0.925,10,yLimIN(1)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRwIN(1) = bar(xpt,m_DRwIN_act_pethTrack,'histc');
errorbarJun(xpt+1,m_DRwIN_act_pethTrack,sem_DRwIN_act_pethTrack,1,0.4,colorDarkGray);
text(80, yLimIN(1)*0.8,['n = ',num2str(n_DRwIN_act_pethTrack)],'fontSize',fontS);
xlabel('Time (ms)','fontSize',fontS);
ylabel('Spikes/bin','fontSize',fontS);
title('IN: Total activated','fontSize',fontS,'fontWeight','bold');

hPlotDRwIN(2) = axes('Position',axpt(2,4,2,2,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
bar(5,yLimIN(2),'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yLimIN(2)*0.925,10,yLimIN(2)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRwIN(2) = bar(xpt,m_DRwIN_ina_pethTrack,'histc');
errorbarJun(xpt+1,m_DRwIN_ina_pethTrack,sem_DRwIN_ina_pethTrack,1,0.4,colorDarkGray);
text(80, yLimIN(2)*0.8,['n = ',num2str(n_DRwIN_ina_pethTrack)],'fontSize',fontS);
xlabel('Time (ms)','fontSize',fontS);
ylabel('Spikes/bin','fontSize',fontS);
title('IN: inactivated','fontSize',fontS,'fontWeight','bold');

hPlotDRwIN(3) = axes('Position',axpt(2,4,2,3,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
bar(5,yLimIN(3),'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yLimIN(3)*0.925,10,yLimIN(2)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRwIN(3) = bar(xpt,m_DRwIN_no_pethTrack,'histc');
% errorbarJun(xpt+1,m_DRwIN_no_pethTrack,sem_DRwIN_no_pethTrack,1,0.4,colorDarkGray);
text(80, yLimIN(3)*0.8,['n = ',num2str(n_DRwIN_no_pethTrack)],'fontSize',fontS);
xlabel('Time (ms)','fontSize',fontS);
ylabel('Spikes/bin','fontSize',fontS);
title('IN: no response','fontSize',fontS,'fontWeight','bold');

set(hBarDRwPN,'FaceColor',colorBlack,'EdgeColor','none');
set(hBarDRwIN,'FaceColor',colorBlack,'EdgeColor','none');
set(hPlotDRwPN,'Box','off','TickDir','out','XLim',[-20,100],'XTick',[-20,0,10,100],'fontSize',fontS)
set(hPlotDRwPN(1),'YLim',[0, yLimPN(1)]);
set(hPlotDRwPN(2),'YLim',[0, yLimPN(2)]);
set(hPlotDRwPN(3),'YLim',[0, yLimPN(3)]);

set(hPlotDRwIN(1),'Box','off','TickDir','out','XLim',[-20 100],'XTick',[-20,0,10,100],'YLim',[0, yLimIN(1)],'fontSize',fontS);
set(hPlotDRwIN(2),'Box','off','TickDir','out','XLim',[-20 100],'XTick',[-20,0,10,100],'YLim',[0, yLimIN(2)],'fontSize',fontS);
set(hPlotDRwIN(3),'Box','off','TickDir','out','XLim',[-20 100],'XTick',[-20,0,10,100],'YLim',[0, yLimIN(3)],'fontSize',fontS);

print('-painters','-r300','-dtiff',['f_supple_fig7_track_lightPETH_DRw50hz_',datestr(now,formatOut),'.tif']);
print('-painters','-r300','-depsc',['f_supple_fig7_track_lightPETH_DRw50hz_',datestr(now,formatOut),'.ai']);
close;