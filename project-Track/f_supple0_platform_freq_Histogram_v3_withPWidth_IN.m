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

condiIN = ~(T.spkpvr>cSpkpvr);

lightActIN = condiIN & (Txls.statDir_visual == 1);
lightInaIN = condiIN & (Txls.statDir_visual == -1);
lightNoIN = condiIN & (Txls.statDir_visual == 0);

% Pyramidal neuron
actIN_peth = cell2mat(T.peth8hz_ori(lightActIN));
inactIN_peth = cell2mat(T.peth8hz_ori(lightInaIN));
noIN_peth = cell2mat(T.peth8hz_ori(lightNoIN));


%% Mean & SEM
nactIN = size(actIN_peth,1);
m_actIN_peth = mean(actIN_peth,1);
sem_actIN_peth = std(actIN_peth,0,1)/sqrt(nactIN);

ninactIN = size(inactIN_peth,1);
m_inactIN_peth = mean(inactIN_peth,1);
sem_inactIN_peth = std(inactIN_peth,0,1)/sqrt(ninactIN);

nnoIN = size(noIN_peth,1);
m_noIN_peth = mean(noIN_peth,1);
sem_noIN_peth = std(noIN_peth,0,1)/sqrt(nnoIN);

%% Plot
% Pyramidal neuron
xpt = T.pethtime8hz_ori{1};
yLim = [60 60 20];

fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});
nCol = 2;
nRow = 2;
%% IN activated
hPlotIN(1) = axes('Position',axpt(2,6,1,1,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
lightPatch(1) = patch([0 10 10 0],[0 0 yLim(1) yLim(1)],colorLLightBlue);
hold on;
lightPatch(2) = patch([0 10 10 0],[yLim(1)*0.925 yLim(1)*0.925 yLim(1) yLim(1)],colorBlue);
hold on;
hBarIN(1) = bar(xpt,m_actIN_peth,'histc');
errorbarJun(xpt+1,m_actIN_peth,sem_actIN_peth,1,0.4,colorDarkGray);
text(15, yLim(1)*0.8,['n = ',num2str(nactIN)],'fontSize',fontS);
% xlabel('Time (ms)','fontSize',fontS);
ylabel('Spikes/bin','fontSize',fontS);
title('IN (Activated)','fontSize',fontS,'interpreter','none','fontWeight','bold');

%% inactivated
hPlotIN(2) = axes('Position',axpt(2,6,1,2,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
lightPatch(3) = patch([0 10 10 0],[0 0 yLim(2) yLim(2)],colorLLightBlue);
hold on;
lightPatch(4) = patch([0 10 10 0],[yLim(2)*0.925 yLim(2)*0.925 yLim(2) yLim(2)],colorBlue);
hold on;
hBarIN(2) = bar(xpt,m_inactIN_peth,'histc');
errorbarJun(xpt+1,m_inactIN_peth,sem_inactIN_peth,1,0.4,colorDarkGray);
text(15, yLim(2)*0.8,['n = ',num2str(ninactIN)],'fontSize',fontS);
ylabel('Spikes/bin','fontSize',fontS);
title('IN (Inactivated)','interpreter','none','fontSize',fontS,'fontWeight','bold');

%% no resp
hPlotIN(3) = axes('Position',axpt(2,6,1,3,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
lightPatch(5) = patch([0 10 10 0],[0 0 yLim(3) yLim(3)],colorLLightBlue);
hold on;
lightPatch(6) = patch([0 10 10 0],[yLim(3)*0.925 yLim(3)*0.925 yLim(3) yLim(3)],colorBlue);
hold on;
hBarIN(3) = bar(xpt,m_noIN_peth,'histc');
errorbarJun(xpt+1,m_noIN_peth,sem_noIN_peth,1,0.4,colorDarkGray);
text(15, yLim(3)*0.8,['n = ',num2str(nnoIN)],'fontSize',fontS);
xlabel('Time (ms)','fontSize',fontS);
ylabel('Spikes/bin','fontSize',fontS);
title('IN (No response)','fontSize',fontS,'interpreter','none','fontWeight','bold');

%% double
% hPlotIN(6) = axes('Position',axpt(2,6,1,4,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
% lightPatch(11) = patch([0 10 10 0],[0 0 yLim(6) yLim(6)],colorLLightBlue);
% hold on;
% lightPatch(12) = patch([0 10 10 0],[yLim(6)*0.925 yLim(6)*0.925 yLim(6) yLim(6)],colorBlue);
% hold on;
% hBarIN(6) = bar(xpt,m_actDBIN_peth,'histc');
% text(15, yLim(6)*0.8,['n = ',num2str(nactDBIN)],'fontSize',fontS);
% ylabel('Spikes/bin','fontSize',fontS);
% title('IN_double response','fontSize',fontS,'interpreter','none','fontWeight','bold');

%%
load myParameters.mat         
load('neuronList_width_170922.mat');
Txls = readtable('neuronList_width_170922.xlsx');
Txls.latencyIndex = categorical(Txls.latencyIndex);

%% Population separation
listIN = ~(T.spkpvr>cSpkpvr);
actIN_peth10 = cell2mat(T.peth10ms(listIN & T.statDir_Plfm2hz ==1));
actIN_peth50 = cell2mat(T.peth50ms(listIN & T.statDir_Plfm2hz ==1));

xpt = -100:2:400;
yLimWidth = [110 110];

nactIN10ms = size(actIN_peth10,1);
m_actIN_peth10ms = mean(actIN_peth10,1);
sem_actIN_peth10ms = std(actIN_peth10,0,1)/sqrt(nactIN10ms);
nactIN50ms = size(actIN_peth50,1);
m_actIN_peth50ms = mean(actIN_peth50,1);
sem_actIN_peth50ms = std(actIN_peth50,0,1)/sqrt(nactIN50ms);

%% width direct
hPlotWidth(1) = axes('Position',axpt(2,6,2,1,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
bar(5,yLimWidth(1),'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yLimWidth(1)*0.925,10,yLimWidth(1)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarWidth(1) = bar(xpt,m_actIN_peth10ms,'histc');
errorbarJun(xpt+1,m_actIN_peth10ms,sem_actIN_peth10ms,1,0.4,colorDarkGray);
text(50, yLimWidth(1)*0.8,['n = ',num2str(nactIN10ms)],'fontSize',fontS);
title('IN (activated)','fontSize',fontS,'interpreter','none','fontWeight','bold');

hPlotWidth(2) = axes('Position',axpt(2,6,2,2,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
bar(25,yLimWidth(2),'BarWidth',50,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yLimWidth(2)*0.925,50,yLimWidth(2)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarWidth(2) = bar(xpt,m_actIN_peth50ms,'histc');
errorbarJun(xpt+1,m_actIN_peth50ms,sem_actIN_peth50ms,1,0.4,colorDarkGray);

%%
align_ylabel(hPlotIN);
set(lightPatch,'LineStyle','none');
set(hBarIN,'FaceColor',colorBlack,'EdgeColor',colorBlack,'FaceAlpha',1);
set(hPlotIN,'Box','off','TickDir','out','XLim',[-10,75],'fontSize',fontS);
set(hPlotIN(1),'YLim',[0 yLim(1)]); % act
set(hPlotIN(2),'YLim',[0 yLim(2)]); % direct
set(hPlotIN(3),'YLim',[0 yLim(3)]); % indirect
set(hPlotIN(1:3),'XTick',[-10 0 10 20 75]);

align_ylabel(hPlotWidth);
set(hBarWidth,'FaceColor',colorBlack,'EdgeColor',colorBlack,'FaceAlpha',1);
set(hPlotWidth,'Box','off','TickDir','out','XLim',[-10 75],'fontSize',fontS);
set(hPlotWidth(1),'YLim',[0 yLimWidth(1)]);
set(hPlotWidth(2),'YLim',[0 yLimWidth(2)]);
set(hPlotWidth(1:2),'XTick',[-10 0 10 20 50 75]);

print('-painters','-r300','-depsc',['final_supple1_platform_8hz_pulseWidth_v3_IN_',datestr(now,formatOut),'.ai']);
print('-painters','-r300','-dtiff',['final_supple1_platform_8hz_pulseWidth_v3_IN_',datestr(now,formatOut),'.tif']);
close;