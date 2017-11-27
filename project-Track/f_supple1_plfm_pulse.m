clearvars;

rtDir = 'D:\Dropbox\SNL\P2_Track';
cd(rtDir);
load('D:\Dropbox\SNL\P2_Track\myParameters.mat');
load('neuronList_width_171127.mat');
Txls = readtable('neuronList_width_171127.xlsx');
Txls.latencyIndex = categorical(Txls.latencyIndex);

formatOut = 'yymmdd';
fontS = 6;
cSpkpvr = 1.2;

listPN = T.spkpvr > cSpkpvr;

% plot_widthT_multi(T.path(listPN & T.idx_light10ms == 1),T.cellID(listPN & T.idx_light10ms == 1),'C:\Users\Jun\Desktop\pulseT');

actPN_peth10_direct = cell2mat(T.peth10ms(listPN & Txls.latencyIndex == 'direct'));
actPN_peth50_direct = cell2mat(T.peth50ms(listPN & Txls.latencyIndex == 'direct'));

actPN_peth10_indirect = cell2mat(T.peth10ms(listPN & Txls.latencyIndex == 'indirect'));
actPN_peth50_indirect = cell2mat(T.peth50ms(listPN & Txls.latencyIndex == 'indirect'));

actPN_peth10_double = cell2mat(T.peth10ms(listPN & Txls.latencyIndex == 'double'));
actPN_peth50_double = cell2mat(T.peth50ms(listPN & Txls.latencyIndex == 'double'));

xpt = -100:2:400;
yLimWidth = [80 60 80 60 120 80];

nactPN10ms_direct = size(actPN_peth10_direct,1);
m_actPN_peth10ms_direct = mean(actPN_peth10_direct,1);
sem_actPN_peth10ms_direct = std(actPN_peth10_direct,0,1)/sqrt(nactPN10ms_direct);
nactPN50ms_direct = size(actPN_peth50_direct,1);
m_actPN_peth50ms_direct = mean(actPN_peth50_direct,1);
sem_actPN_peth50ms_direct = std(actPN_peth50_direct,0,1)/sqrt(nactPN50ms_direct);

nactPN10ms_indirect = size(actPN_peth10_indirect,1);
m_actPN_peth10ms_indirect = mean(actPN_peth10_indirect,1);
sem_actPN_peth10ms_indirect = std(actPN_peth10_indirect,0,1)/sqrt(nactPN10ms_indirect);
nactPN50ms_indirect = size(actPN_peth50_indirect,1);
m_actPN_peth50ms_indirect = mean(actPN_peth50_indirect,1);
sem_actPN_peth50ms_indirect = std(actPN_peth50_indirect,0,1)/sqrt(nactPN50ms_indirect);

nactPN10ms_double = size(actPN_peth10_double,1);
m_actPN_peth10ms_double = mean(actPN_peth10_double,1);
nactPN50ms_double = size(actPN_peth50_double,1);
m_actPN_peth50ms_double = mean(actPN_peth50_double,1);


fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});
nCol = 2;
nRow = 2;

%% width direct
hPlotWidth(1) = axes('Position',axpt(2,6,1,1,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
bar(5,yLimWidth(1),'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yLimWidth(1)*0.925,10,yLimWidth(1)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarWidth(1) = bar(xpt,m_actPN_peth10ms_direct,'histc');
errorbarJun(xpt+1,m_actPN_peth10ms_direct,sem_actPN_peth10ms_direct,1,0.4,colorDarkGray);
text(50, yLimWidth(1)*0.8,['n = ',num2str(nactPN10ms_direct)],'fontSize',fontS);
title('PN_direct','fontSize',fontS,'interpreter','none','fontWeight','bold');

hPlotWidth(2) = axes('Position',axpt(2,6,1,2,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
bar(25,yLimWidth(2),'BarWidth',50,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yLimWidth(2)*0.925,50,yLimWidth(2)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarWidth(2) = bar(xpt,m_actPN_peth50ms_direct,'histc');
errorbarJun(xpt+1,m_actPN_peth50ms_direct,sem_actPN_peth50ms_direct,1,0.4,colorDarkGray);

%% width indirect
hPlotWidth(3) = axes('Position',axpt(2,6,1,3,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
bar(5,yLimWidth(3),'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yLimWidth(3)*0.925,10,yLimWidth(3)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarWidth(3) = bar(xpt,m_actPN_peth10ms_indirect,'histc');
errorbarJun(xpt+1,m_actPN_peth10ms_indirect,sem_actPN_peth10ms_indirect,1,0.4,colorDarkGray);
text(50, yLimWidth(3)*0.8,['n = ',num2str(nactPN10ms_indirect)],'fontSize',fontS);
title('PN_inactivated','interpreter','none','fontSize',fontS,'fontWeight','bold');

hPlotWidth(4) = axes('Position',axpt(2,6,1,4,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
bar(25,yLimWidth(4),'BarWidth',50,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yLimWidth(4)*0.925,50,yLimWidth(4)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarWidth(4) = bar(xpt,m_actPN_peth50ms_indirect,'histc');
errorbarJun(xpt+1,m_actPN_peth50ms_indirect,sem_actPN_peth50ms_indirect,1,0.4,colorDarkGray);
% xlabel('Time (ms)','fontSize',fontS);
% ylabel('Spikes/bin','fontSize',fontS);

%% width double
hPlotWidth(5) = axes('Position',axpt(2,6,1,5,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
bar(5,yLimWidth(5),'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yLimWidth(5)*0.925,10,yLimWidth(5)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarWidth(5) = bar(xpt,m_actPN_peth10ms_double,'histc');
text(50, yLimWidth(5)*0.8,['n = ',num2str(nactPN10ms_double)],'fontSize',fontS);
title('PN_double','interpreter','none','fontSize',fontS,'fontWeight','bold');

hPlotWidth(6) = axes('Position',axpt(2,6,1,6,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
bar(25,yLimWidth(6),'BarWidth',50,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yLimWidth(6)*0.925,50,yLimWidth(6)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarWidth(6) = bar(xpt,m_actPN_peth50ms_double,'histc');
xlabel('Time (ms)','fontSize',fontS);

align_ylabel(hPlotWidth);
set(hBarWidth,'FaceColor',colorBlack,'EdgeColor',colorBlack,'FaceAlpha',1);
set(hPlotWidth,'Box','off','TickDir','out','XLim',[-10 75],'fontSize',fontS);
set(hPlotWidth(1),'YLim',[0 yLimWidth(1)]);
set(hPlotWidth(2),'YLim',[0 yLimWidth(2)]);
set(hPlotWidth(3),'YLim',[0 yLimWidth(3)]);
set(hPlotWidth(4),'YLim',[0 yLimWidth(4)]);
set(hPlotWidth(5),'YLim',[0 yLimWidth(5)]);
set(hPlotWidth(6),'YLim',[0 yLimWidth(6)]);
set(hPlotWidth(1:6),'XTick',[-10 0 10 20 50 75]);

print('-painters','-r300','-depsc',['f_supple1_plfm_pulseWidth_v3_',datestr(now,formatOut),'.ai']);
print('-painters','-r300','-dtiff',['f_supple1_plfm_pulseWidth_v3_',datestr(now,formatOut),'.tif']);
close;