clearvars;

rtDir = 'D:\Dropbox\SNL\P2_Track';
cd(rtDir);

load myParameters.mat         
load('neuronList_width_170922.mat');
Txls = readtable('neuronList_width_170922.xlsx');
Txls.latencyIndex = categorical(Txls.latencyIndex);

formatOut = 'yymmdd';

cMeanFR = 9;
cMaxPeakFR = 1;
cSpkpvr = 1.2;
alpha = 0.01;
%% Population separation

% listPN = T.meanFR10<cMeanFR;
listPN = T.spkpvr>cSpkpvr;

% Pyramidal neuron
actPN_peth10_direct = cell2mat(T.peth10ms(listPN & T.statDir_Plfm2hz ==1 & Txls.latencyIndex == 'direct'));
actPN_peth50_direct = cell2mat(T.peth50ms(listPN & T.statDir_Plfm2hz ==1 & Txls.latencyIndex == 'direct'));

actPN_peth10_indirect = cell2mat(T.peth10ms(listPN & T.statDir_Plfm2hz ==1 & Txls.latencyIndex == 'indirect'));
actPN_peth50_indirect = cell2mat(T.peth50ms(listPN & T.statDir_Plfm2hz ==1 & Txls.latencyIndex == 'indirect'));

inactPN_peth10 = cell2mat(T.peth10ms(listPN & T.statDir_Plfm2hz ==-1));
inactPN_peth50 = cell2mat(T.peth50ms(listPN & T.statDir_Plfm2hz ==-1));

noPN_peth10 = cell2mat(T.peth10ms(listPN & (T.statDir_Plfm2hz ==0 | isnan(T.statDir_Plfm2hz))));
noPN_peth50 = cell2mat(T.peth50ms(listPN & (T.statDir_Plfm2hz ==0 | isnan(T.statDir_Plfm2hz))));

% Interneuron
% actIN_peth10 = cell2mat(T.peth10ms(~listPN & lightAct));
% actIN_peth50 = cell2mat(T.peth50ms(~listPN & lightAct));
% 
% inactIN_peth10 = cell2mat(T.peth10ms(~listPN & lightIna));
% inactIN_peth50 = cell2mat(T.peth50ms(~listPN & lightIna));
% 
% noIN_peth10 = cell2mat(T.peth10ms(~listPN & lightNo));
% noIN_peth50 = cell2mat(T.peth50ms(~listPN & lightNo));

%% individual file
% fileName = T.path(~listPN & lightResp);
% cellID = T.cellID(~listPN & lightResp);
% plot_widthT_multi(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_pulse\INlight\');

%% Mean & SEM
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

ninactPN10ms = size(inactPN_peth10,1);
m_inactPN_peth10ms = mean(inactPN_peth10,1);
sem_inactPN_peth10ms = std(inactPN_peth10,0,1)/sqrt(ninactPN10ms);
ninactPN50ms = size(inactPN_peth50,1);
m_inactPN_peth50ms = mean(inactPN_peth50,1);
sem_inactPN_peth50ms = std(inactPN_peth50,0,1)/sqrt(ninactPN50ms);

nnoPN10ms = size(noPN_peth10,1);
m_noPN_peth10ms = mean(noPN_peth10,1);
sem_noPN_peth10ms = std(noPN_peth10,0,1)/sqrt(nnoPN10ms);
nnoPN50ms = size(noPN_peth50,1);
m_noPN_peth50ms = mean(noPN_peth50,1);
sem_noPN_peth50ms = std(noPN_peth50,0,1)/sqrt(nnoPN50ms);


% nactIN10ms = size(actIN_peth10,1);
% m_actIN_peth10ms = mean(actIN_peth10,1);
% sem_actIN_peth10ms = std(actIN_peth10,0,1)/sqrt(nactIN10ms);
% nactIN50ms = size(actIN_peth50,1);
% m_actIN_peth50ms = mean(actIN_peth50,1);
% sem_actIN_peth50ms = std(actIN_peth50,0,1)/sqrt(nactIN50ms);
% 
% ninactIN10ms = size(inactIN_peth10,1);
% m_inactIN_peth10ms = mean(inactIN_peth10,1);
% sem_inactIN_peth10ms = std(inactIN_peth10,0,1)/sqrt(ninactIN10ms);
% ninactIN50ms = size(inactIN_peth50,1);
% m_inactIN_peth50ms = mean(inactIN_peth50,1);
% sem_inactIN_peth50ms = std(inactIN_peth50,0,1)/sqrt(ninactIN50ms);
% 
% nnoIN10ms = size(noIN_peth10,1);
% m_noIN_peth10ms = mean(noIN_peth10,1);
% sem_noIN_peth10ms = std(noIN_peth10,0,1)/sqrt(nnoIN10ms);
% nnoIN50ms = size(noIN_peth50,1);
% m_noIN_peth50ms = mean(noIN_peth50,1);
% sem_noIN_peth50ms = std(noIN_peth50,0,1)/sqrt(nnoIN50ms);

%% Plot
nCol = 4;
nRow = 4;
xpt = -100:2:400;
yMaxPN = max([m_actPN_peth10ms_direct,m_actPN_peth50ms_direct])*1.5;
% yMaxIN = max([m_actIN_peth10ms,m_actIN_peth50ms])*1.5;

fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{2});

hPlotPN(1) = axes('Position',axpt(nCol,nRow,1,1,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxPN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxPN*0.925,10,yMaxPN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarPN(1) = bar(xpt,m_actPN_peth10ms_direct,'histc');
errorbarJun(xpt+1,m_actPN_peth10ms_direct,sem_actPN_peth10ms_direct,1,0.4,colorDarkGray);
text(100, yMaxPN*0.8,['n = ',num2str(nactPN10ms_direct)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN_direct','fontSize',fontL,'interpreter','none','fontWeight','bold');
hPlotPN(2) = axes('Position',axpt(nCol,nRow,1,2,[0.10 0.10 0.85 0.8],wideInterval));
bar(25,yMaxPN,'BarWidth',50,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxPN*0.925,50,yMaxPN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarPN(2) = bar(xpt,m_actPN_peth50ms_direct,'histc');
errorbarJun(xpt+1,m_actPN_peth50ms_direct,sem_actPN_peth50ms_direct,1,0.4,colorDarkGray);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);

hPlotPN(3) = axes('Position',axpt(nCol,nRow,3,1,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxPN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxPN*0.925,10,yMaxPN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarPN(3) = bar(xpt,m_inactPN_peth10ms,'histc');
errorbarJun(xpt+1,m_inactPN_peth10ms,sem_inactPN_peth10ms,1,0.4,colorDarkGray);
text(100, yMaxPN*0.8,['n = ',num2str(ninactPN10ms)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN_inactivated','interpreter','none','fontSize',fontL,'fontWeight','bold');
hPlotPN(4) = axes('Position',axpt(nCol,nRow,3,2,[0.10 0.10 0.85 0.8],wideInterval));
bar(25,yMaxPN,'BarWidth',50,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxPN*0.925,50,yMaxPN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarPN(4) = bar(xpt,m_inactPN_peth50ms,'histc');
errorbarJun(xpt+1,m_inactPN_peth50ms,sem_inactPN_peth50ms,1,0.4,colorDarkGray);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);

hPlotPN(5) = axes('Position',axpt(nCol,nRow,4,1,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxPN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxPN*0.925,10,yMaxPN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarPN(5) = bar(xpt,m_noPN_peth10ms,'histc');
errorbarJun(xpt+1,m_noPN_peth10ms,sem_noPN_peth10ms,1,0.4,colorDarkGray);
text(100, yMaxPN*0.8,['n = ',num2str(nnoPN10ms)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN_no response','fontSize',fontL,'interpreter','none','fontWeight','bold');
hPlotPN(6) = axes('Position',axpt(nCol,nRow,4,2,[0.10 0.10 0.85 0.8],wideInterval));
bar(25,yMaxPN,'BarWidth',50,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxPN*0.925,50,yMaxPN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarPN(6) = bar(xpt,m_noPN_peth50ms,'histc');
errorbarJun(xpt+1,m_noPN_peth50ms,sem_noPN_peth50ms,1,0.4,colorDarkGray);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);

hPlotPN(7) = axes('Position',axpt(nCol,nRow,2,1,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxPN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxPN*0.925,10,yMaxPN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarPN(7) = bar(xpt,m_actPN_peth10ms_indirect,'histc');
errorbarJun(xpt+1,m_actPN_peth10ms_indirect,sem_actPN_peth10ms_indirect,1,0.4,colorDarkGray);
text(100, yMaxPN*0.8,['n = ',num2str(nactPN10ms_indirect)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN_indirect','fontSize',fontL,'interpreter','none','fontWeight','bold');
hPlotPN(8) = axes('Position',axpt(nCol,nRow,2,2,[0.10 0.10 0.85 0.8],wideInterval));
bar(25,yMaxPN,'BarWidth',50,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxPN*0.925,50,yMaxPN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarPN(8) = bar(xpt,m_actPN_peth50ms_indirect,'histc');
errorbarJun(xpt+1,m_actPN_peth50ms_indirect,sem_actPN_peth50ms_indirect,1,0.4,colorDarkGray);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);

set(hBarPN,'FaceColor',colorBlack,'EdgeColor',colorBlack,'FaceAlpha',1);
set(hPlotPN,'Box','off','TickDir','out','XLim',[-20,120],'XTick',[-20:20:100],'YLim',[0,yMaxPN],'fontSize',fontL);

%% IN
% hPlotIN(1) = axes('Position',axpt(nCol,nRow,1,3,[0.10 0.10 0.85 0.8],wideInterval));
% bar(5,yMaxIN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
% hold on;
% rectangle('Position',[0,yMaxIN*0.925,10,yMaxIN*0.075],'LineStyle','none','FaceColor',colorBlue);
% hold on;
% hBarIN(1) = bar(xpt,m_actIN_peth10ms,'histc');
% errorbarJun(xpt+1,m_actIN_peth10ms,sem_actIN_peth10ms,1,0.4,colorDarkGray);
% text(100, yMaxIN*0.8,['n = ',num2str(nactIN10ms)],'fontSize',fontL);
% xlabel('Time (ms)','fontSize',fontL);
% ylabel('Spikes/bin','fontSize',fontL);
% title('IN_activated','fontSize',fontL,'interpreter','none','fontWeight','bold');
% hPlotIN(2) = axes('Position',axpt(nCol,nRow,1,4,[0.10 0.10 0.85 0.8],wideInterval));
% bar(25,yMaxIN,'BarWidth',50,'LineStyle','none','FaceColor',colorLLightBlue);
% hold on;
% rectangle('Position',[0,yMaxIN*0.925,50,yMaxIN*0.075],'LineStyle','none','FaceColor',colorBlue);
% hold on;
% hBarIN(2) = bar(xpt,m_actIN_peth50ms,'histc');
% errorbarJun(xpt+1,m_actIN_peth50ms,sem_actIN_peth50ms,1,0.4,colorDarkGray);
% xlabel('Time (ms)','fontSize',fontL);
% ylabel('Spikes/bin','fontSize',fontL);
% 
% hPlotIN(3) = axes('Position',axpt(nCol,nRow,2,3,[0.10 0.10 0.85 0.8],wideInterval));
% bar(5,yMaxIN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
% hold on;
% rectangle('Position',[0,yMaxIN*0.925,10,yMaxIN*0.075],'LineStyle','none','FaceColor',colorBlue);
% hold on;
% hBarIN(3) = bar(xpt,m_inactIN_peth10ms,'histc');
% errorbarJun(xpt+1,m_inactIN_peth10ms,sem_inactIN_peth10ms,1,0.4,colorDarkGray);
% text(100, yMaxIN*0.8,['n = ',num2str(ninactIN10ms)],'fontSize',fontL);
% xlabel('Time (ms)','fontSize',fontL);
% ylabel('Spikes/bin','fontSize',fontL);
% title('IN_inactivated','fontSize',fontL,'interpreter','none','fontWeight','bold');
% hPlotIN(4) = axes('Position',axpt(nCol,nRow,2,4,[0.10 0.10 0.85 0.8],wideInterval));
% bar(25,yMaxIN,'BarWidth',50,'LineStyle','none','FaceColor',colorLLightBlue);
% hold on;
% rectangle('Position',[0,yMaxIN*0.925,50,yMaxIN*0.075],'LineStyle','none','FaceColor',colorBlue);
% hold on;
% hBarIN(4) = bar(xpt,m_inactIN_peth50ms,'histc');
% errorbarJun(xpt+1,m_inactIN_peth50ms,sem_inactIN_peth50ms,1,0.4,colorDarkGray);
% uistack(hBarIN(4),'up');
% xlabel('Time (ms)','fontSize',fontL);
% ylabel('Spikes/bin','fontSize',fontL);
% 
% hPlotIN(5) = axes('Position',axpt(nCol,nRow,3,3,[0.10 0.10 0.85 0.8],wideInterval));
% bar(5,yMaxIN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
% hold on;
% rectangle('Position',[0,yMaxIN*0.925,10,yMaxIN*0.075],'LineStyle','none','FaceColor',colorBlue);
% hold on;
% hBarIN(5) = bar(xpt,m_noIN_peth10ms,'histc');
% errorbarJun(xpt+1,m_noIN_peth10ms,sem_noIN_peth10ms,1,0.4,colorDarkGray);
% text(100, yMaxIN*0.8,['n = ',num2str(nnoIN10ms)],'fontSize',fontL);
% xlabel('Time (ms)','fontSize',fontL);
% ylabel('Spikes/bin','fontSize',fontL);
% title('IN_no response','fontSize',fontL,'interpreter','none','fontWeight','bold');
% hPlotIN(6) = axes('Position',axpt(nCol,nRow,3,4,[0.10 0.10 0.85 0.8],wideInterval));
% bar(25,yMaxIN,'BarWidth',50,'LineStyle','none','FaceColor',colorLLightBlue);
% hold on;
% rectangle('Position',[0,yMaxIN*0.925,50,yMaxIN*0.075],'LineStyle','none','FaceColor',colorBlue);
% hold on;
% hBarIN(6) = bar(xpt,m_noIN_peth50ms,'histc');
% errorbarJun(xpt+1,m_noIN_peth50ms,sem_noIN_peth50ms,1,0.4,colorDarkGray);
% uistack(hBarIN(4),'up');
% xlabel('Time (ms)','fontSize',fontL);
% ylabel('Spikes/bin','fontSize',fontL);
% 
% set(hBarIN,'FaceColor',colorBlack,'EdgeAlpha',0);
% set(hPlotIN,'Box','off','TickDir','out','XLim',[-20,120],'XTick',[-20:20:100],'YLim',[0,yMaxIN],'fontSize',fontL);

print('-painters','-r300','-dtiff',['final_fig2_platform_laserWidth_direct_indirect_',datestr(now,formatOut),'.tif']);
% print('-painters','-r300','-depsc',['final_fig2_plfm_laserWidth',datestr(now,formatOut),'.ai']);
close;