clearvars;

rtDir = 'D:\Dropbox\SNL\P2_Track';
cd(rtDir);
load('D:\Dropbox\SNL\P2_Track\myParameters.mat');
load('neuronList_freq_170921.mat');
Txls = readtable('neuronList_freq_170921.xlsx');
Txls.latencyIndex = categorical(Txls.latencyIndex);
formatOut = 'yymmdd';

%% Population separation
cSpkpvr = 1.2;
alpha = 0.01;

condiPN = T.spkpvr>cSpkpvr;
condiIN = ~condiPN;

lightActPN = condiPN & (Txls.statDir_visual == 1);
lightActDirectPN = condiPN & (Txls.statDir_visual == 1) & Txls.latencyIndex == 'direct';
lightActIndirectPN = condiPN & (Txls.statDir_visual == 1) & Txls.latencyIndex == 'indirect';
lightActDoublePN = condiPN & (Txls.statDir_visual == 1) & Txls.latencyIndex == 'double';
lightInaPN = condiPN & (Txls.statDir_visual == -1);
lightNoPN = condiPN & (Txls.statDir_visual == 0);

% Pyramidal neuron
actPN_peth = cell2mat(T.peth8hz_ori(lightActPN));
actPN_peth_direct = cell2mat(T.peth8hz_ori(lightActDirectPN));
actPN_peth_indirect = cell2mat(T.peth8hz_ori(lightActIndirectPN));
actDBPN_peth = cell2mat(T.peth8hz_ori(lightActDoublePN));
inactPN_peth = cell2mat(T.peth8hz_ori(lightInaPN));
noPN_peth = cell2mat(T.peth8hz_ori(lightNoPN));


%% Mean & SEM
nactPN = size(actPN_peth,1);
m_actPN_peth = mean(actPN_peth,1);
sem_actPN_peth = std(actPN_peth,0,1)/sqrt(nactPN);

nactPN_direct = size(actPN_peth_direct,1);
m_actPN_peth_direct = mean(actPN_peth_direct,1);
sem_actPN_peth_direct = std(actPN_peth_direct,0,1)/sqrt(nactPN_direct);

nactPN_indirect = size(actPN_peth_indirect,1);
m_actPN_peth_indirect = mean(actPN_peth_indirect,1);
sem_actPN_peth_indirect = std(actPN_peth_indirect,0,1)/sqrt(nactPN_indirect);

nactDBPN = size(actDBPN_peth,1); % double activated (both direct, indirect)
m_actDBPN_peth = mean(actDBPN_peth,1);
sem_actDBPN_peth = std(actDBPN_peth,0,1)/sqrt(nactDBPN);

ninactPN = size(inactPN_peth,1);
m_inactPN_peth = mean(inactPN_peth,1);
sem_inactPN_peth = std(inactPN_peth,0,1)/sqrt(ninactPN);

nnoPN = size(noPN_peth,1);
m_noPN_peth = mean(noPN_peth,1);
sem_noPN_peth = std(noPN_peth,0,1)/sqrt(nnoPN);

%% Plot
% Pyramidal neuron
xpt = T.pethtime8hz_ori{1};
yLim = [30 20 40 40 10 120];

fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});
nCol = 2;
nRow = 2;
%% PN activated
hPlotPN(1) = axes('Position',axpt(2,6,1,1,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
lightPatch(1) = patch([0 10 10 0],[0 0 yLim(1) yLim(1)],colorLLightBlue);
hold on;
lightPatch(2) = patch([0 10 10 0],[yLim(1)*0.925 yLim(1)*0.925 yLim(1) yLim(1)],colorBlue);
hold on;
hBarPN(1) = bar(xpt,m_actPN_peth,'histc');
errorbarJun(xpt+1,m_actPN_peth,sem_actPN_peth,1,0.4,colorDarkGray);
text(15, yLim(1)*0.8,['n = ',num2str(nactPN)],'fontSize',fontS);
% xlabel('Time (ms)','fontSize',fontS);
ylabel('Spikes/bin','fontSize',fontS);
title('PN_activated','fontSize',fontS,'interpreter','none','fontWeight','bold');

%% direct
hPlotPN(2) = axes('Position',axpt(2,6,1,2,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
lightPatch(3) = patch([0 10 10 0],[0 0 yLim(2) yLim(2)],colorLLightBlue);
hold on;
lightPatch(4) = patch([0 10 10 0],[yLim(2)*0.925 yLim(2)*0.925 yLim(2) yLim(2)],colorBlue);
hold on;
hBarPN(2) = bar(xpt,m_actPN_peth_direct,'histc');
errorbarJun(xpt+1,m_actPN_peth_direct,sem_actPN_peth_direct,1,0.4,colorDarkGray);
text(15, yLim(2)*0.8,['n = ',num2str(nactPN_direct)],'fontSize',fontS);
% xlabel('Time (ms)','fontSize',fontS);
ylabel('Spikes/bin','fontSize',fontS);
title('PN_direct','fontSize',fontS,'interpreter','none','fontWeight','bold');

%% indirect
hPlotPN(3) = axes('Position',axpt(2,6,1,3,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
lightPatch(5) = patch([0 10 10 0],[0 0 yLim(3) yLim(3)],colorLLightBlue);
hold on;
lightPatch(6) = patch([0 10 10 0],[yLim(3)*0.925 yLim(3)*0.925 yLim(3) yLim(3)],colorBlue);
hold on;
hBarPN(3) = bar(xpt,m_actPN_peth_indirect,'histc');
errorbarJun(xpt+1,m_actPN_peth_indirect,sem_actPN_peth_indirect,1,0.4,colorDarkGray);
text(15, yLim(3)*0.8,['n = ',num2str(nactPN_indirect)],'fontSize',fontS);
% xlabel('Time (ms)','fontSize',fontS);
ylabel('Spikes/bin','fontSize',fontS);
title('PN_indirect','fontSize',fontS,'interpreter','none','fontWeight','bold');

% hPlotPN(4) = axes('Position',axpt(nCol,nRow,1,4,[0.10 0.10 0.85 0.8],midInterval));
% lightPatch(7) = patch([0 10 10 0],[0 0 100 100],colorLLightBlue);
% hold on;
% lightPatch(8) = patch([0 10 10 0],[100*0.925 100*0.925 100 100],colorBlue);
% hold on;
% hBarPN(4) = bar(xpt,m_actDBPN_peth,'histc');
% errorbarJun(xpt+1,m_actDBPN_peth,sem_actDBPN_peth,1,0.4,colorDarkGray);
% text(15, 100*0.8,['n = ',num2str(nactDBPN)],'fontSize',fontS);
% xlabel('Time (ms)','fontSize',fontS);
% ylabel('Spikes/bin','fontSize',fontS);
% title('PN_double peak','fontSize',fontS,'interpreter','none','fontWeight','bold');

%% inactivated
hPlotPN(4) = axes('Position',axpt(2,6,1,5,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
lightPatch(7) = patch([0 10 10 0],[0 0 yLim(4) yLim(4)],colorLLightBlue);
hold on;
lightPatch(8) = patch([0 10 10 0],[yLim(4)*0.925 yLim(4)*0.925 yLim(4) yLim(4)],colorBlue);
hold on;
hBarPN(4) = bar(xpt,m_inactPN_peth,'histc');
errorbarJun(xpt+1,m_inactPN_peth,sem_inactPN_peth,1,0.4,colorDarkGray);
text(15, yLim(4)*0.8,['n = ',num2str(ninactPN)],'fontSize',fontS);
ylabel('Spikes/bin','fontSize',fontS);
title('PN_inactivated','interpreter','none','fontSize',fontS,'fontWeight','bold');

%% no resp
hPlotPN(5) = axes('Position',axpt(2,6,1,6,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
lightPatch(9) = patch([0 10 10 0],[0 0 yLim(5) yLim(5)],colorLLightBlue);
hold on;
lightPatch(10) = patch([0 10 10 0],[yLim(5)*0.925 yLim(5)*0.925 yLim(5) yLim(5)],colorBlue);
hold on;
hBarPN(5) = bar(xpt,m_noPN_peth,'histc');
errorbarJun(xpt+1,m_noPN_peth,sem_noPN_peth,1,0.4,colorDarkGray);
text(15, yLim(5)*0.8,['n = ',num2str(nnoPN)],'fontSize',fontS);
xlabel('Time (ms)','fontSize',fontS);
ylabel('Spikes/bin','fontSize',fontS);
title('PN_no response','fontSize',fontS,'interpreter','none','fontWeight','bold');

%% double
hPlotPN(6) = axes('Position',axpt(2,6,1,4,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
lightPatch(11) = patch([0 10 10 0],[0 0 yLim(6) yLim(6)],colorLLightBlue);
hold on;
lightPatch(12) = patch([0 10 10 0],[yLim(6)*0.925 yLim(6)*0.925 yLim(6) yLim(6)],colorBlue);
hold on;
hBarPN(6) = bar(xpt,m_actDBPN_peth,'histc');
text(15, yLim(6)*0.8,['n = ',num2str(nactDBPN)],'fontSize',fontS);
ylabel('Spikes/bin','fontSize',fontS);
title('PN_double response','fontSize',fontS,'interpreter','none','fontWeight','bold');

%%
load myParameters.mat         
load('neuronList_width_170922.mat');
Txls = readtable('neuronList_width_170922.xlsx');
Txls.latencyIndex = categorical(Txls.latencyIndex);

%% Population separation
listPN = T.spkpvr>cSpkpvr;
actPN_peth10_direct = cell2mat(T.peth10ms(listPN & T.statDir_Plfm2hz ==1 & Txls.latencyIndex == 'direct'));
actPN_peth50_direct = cell2mat(T.peth50ms(listPN & T.statDir_Plfm2hz ==1 & Txls.latencyIndex == 'direct'));

actPN_peth10_indirect = cell2mat(T.peth10ms(listPN & T.statDir_Plfm2hz ==1 & Txls.latencyIndex == 'indirect'));
actPN_peth50_indirect = cell2mat(T.peth50ms(listPN & T.statDir_Plfm2hz ==1 & Txls.latencyIndex == 'indirect'));

actPN_peth10_double = cell2mat(T.peth10ms(listPN & T.statDir_Plfm2hz ==1 & Txls.latencyIndex == 'double'));
actPN_peth50_double = cell2mat(T.peth50ms(listPN & T.statDir_Plfm2hz ==1 & Txls.latencyIndex == 'double'));

xpt = -100:2:400;
yLimWidth = [70 60 60 40 120 80];

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

%% width direct
hPlotWidth(1) = axes('Position',axpt(2,6,2,1,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
bar(5,yLimWidth(1),'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yLimWidth(1)*0.925,10,yLimWidth(1)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarWidth(1) = bar(xpt,m_actPN_peth10ms_direct,'histc');
errorbarJun(xpt+1,m_actPN_peth10ms_direct,sem_actPN_peth10ms_direct,1,0.4,colorDarkGray);
text(50, yLimWidth(1)*0.8,['n = ',num2str(nactPN10ms_direct)],'fontSize',fontS);
title('PN_direct','fontSize',fontS,'interpreter','none','fontWeight','bold');

hPlotWidth(2) = axes('Position',axpt(2,6,2,2,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
bar(25,yLimWidth(2),'BarWidth',50,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yLimWidth(2)*0.925,50,yLimWidth(2)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarWidth(2) = bar(xpt,m_actPN_peth50ms_direct,'histc');
errorbarJun(xpt+1,m_actPN_peth50ms_direct,sem_actPN_peth50ms_direct,1,0.4,colorDarkGray);

%% width indirect
hPlotWidth(3) = axes('Position',axpt(2,6,2,3,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
bar(5,yLimWidth(3),'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yLimWidth(3)*0.925,10,yLimWidth(3)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarWidth(3) = bar(xpt,m_actPN_peth10ms_indirect,'histc');
errorbarJun(xpt+1,m_actPN_peth10ms_indirect,sem_actPN_peth10ms_indirect,1,0.4,colorDarkGray);
text(50, yLimWidth(3)*0.8,['n = ',num2str(nactPN10ms_indirect)],'fontSize',fontS);
title('PN_inactivated','interpreter','none','fontSize',fontS,'fontWeight','bold');

hPlotWidth(4) = axes('Position',axpt(2,6,2,4,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
bar(25,yLimWidth(4),'BarWidth',50,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yLimWidth(4)*0.925,50,yLimWidth(4)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarWidth(4) = bar(xpt,m_actPN_peth50ms_indirect,'histc');
errorbarJun(xpt+1,m_actPN_peth50ms_indirect,sem_actPN_peth50ms_indirect,1,0.4,colorDarkGray);
% xlabel('Time (ms)','fontSize',fontS);
% ylabel('Spikes/bin','fontSize',fontS);

%% width double
hPlotWidth(5) = axes('Position',axpt(2,6,2,5,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
bar(5,yLimWidth(5),'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yLimWidth(5)*0.925,10,yLimWidth(5)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarWidth(5) = bar(xpt,m_actPN_peth10ms_double,'histc');
text(50, yLimWidth(5)*0.8,['n = ',num2str(nactPN10ms_double)],'fontSize',fontS);
title('PN_double','interpreter','none','fontSize',fontS,'fontWeight','bold');

hPlotWidth(6) = axes('Position',axpt(2,6,2,6,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
bar(25,yLimWidth(6),'BarWidth',50,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yLimWidth(6)*0.925,50,yLimWidth(6)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarWidth(6) = bar(xpt,m_actPN_peth50ms_double,'histc');
xlabel('Time (ms)','fontSize',fontS);
% ylabel('Spikes/bin','fontSize',fontS);
%%
align_ylabel(hPlotPN);
set(lightPatch,'LineStyle','none');
set(hBarPN,'FaceColor',colorBlack,'EdgeColor',colorBlack,'FaceAlpha',1);
set(hPlotPN,'Box','off','TickDir','out','XLim',[-10,75],'fontSize',fontS);
set(hPlotPN(1),'YLim',[0 yLim(1)]); % act
set(hPlotPN(2),'YLim',[0 yLim(2)]); % direct
set(hPlotPN(3),'YLim',[0 yLim(3)]); % indirect
set(hPlotPN(4),'YLim',[0 yLim(4)]); % inactivated
set(hPlotPN(5),'YLim',[0 yLim(5)]); % noresp
set(hPlotPN(6),'YLim',[0 yLim(6)]); % double
set(hPlotPN(1:6),'XTick',[-10 0 10 20 75]);
% set(hPlotPN(5),'XTick',[-10 0 10 20 75],'XTickLabel',[-10 0 10 20 75]);

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
% set(hPlotWidth(6),'XTick',[-10 0 10 20 50 75],'XTickLabel',[-10 0 10 20 50 75]);

print('-painters','-r300','-depsc',['final_fig2_platform_8hz_pulseWidth_v3_',datestr(now,formatOut),'.ai']);
print('-painters','-r300','-dtiff',['final_fig2_platform_8hz_pulseWidth_v3_',datestr(now,formatOut),'.tif']);
close;