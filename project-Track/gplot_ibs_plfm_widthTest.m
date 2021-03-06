clearvars;

rtDir = 'D:\Dropbox\SNL\P2_Track';
cd(rtDir);

load myParameters.mat         
load('neuronList_width_170617.mat');
Txls = readtable('neuronList_width_170617.xlsx');
formatOut = 'yymmdd';

cMeanFR = 9;
cMaxPeakFR = 1;
cSpkpvr = 1.2;
alpha = 0.01;
%% Population separation

% listPN = T.meanFR10<cMeanFR;
listPN = T.spkpvr>cSpkpvr;

lightResp = T.pLR_Plfm2hz<alpha;
% lightAct = T.pLR_Plfm2hz<alpha & T.statDir_Plfm2hz==1;
% lightIna = T.pLR_Plfm2hz<alpha & T.statDir_Plfm2hz==-1;
% lightNo = ~(T.pLR_Plfm2hz<alpha);
lightAct = T.pLR_Plfm2hz<alpha & Txls.statDir==1;
lightIna = T.pLR_Plfm2hz<alpha & Txls.statDir==-1;
lightNo = ~(T.pLR_Plfm2hz<alpha);

% Pyramidal neuron
actPN_peth10 = cell2mat(T.peth10ms(listPN & lightAct));
actPN_peth50 = cell2mat(T.peth50ms(listPN & lightAct));

inactPN_peth10 = cell2mat(T.peth10ms(listPN & lightIna));
inactPN_peth50 = cell2mat(T.peth50ms(listPN & lightIna));

noPN_peth10 = cell2mat(T.peth10ms(listPN & lightNo));
noPN_peth50 = cell2mat(T.peth50ms(listPN & lightNo));

% Interneuron
actIN_peth10 = cell2mat(T.peth10ms(~listPN & lightAct));
actIN_peth50 = cell2mat(T.peth50ms(~listPN & lightAct));

inactIN_peth10 = cell2mat(T.peth10ms(~listPN & lightIna));
inactIN_peth50 = cell2mat(T.peth50ms(~listPN & lightIna));

noIN_peth10 = cell2mat(T.peth10ms(~listPN & lightNo));
noIN_peth50 = cell2mat(T.peth50ms(~listPN & lightNo));

%% individual file
% fileName = T.path(~listPN & lightResp);
% cellID = T.cellID(~listPN & lightResp);
% plot_widthT_multi(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_pulse\INlight\');

%% Mean & SEM
nactPN10ms = size(actPN_peth10,1);
m_actPN_peth10ms = mean(actPN_peth10,1);
sem_actPN_peth10ms = std(actPN_peth10,0,1)/sqrt(nactPN10ms);
nactPN50ms = size(actPN_peth50,1);
m_actPN_peth50ms = mean(actPN_peth50,1);
sem_actPN_peth50ms = std(actPN_peth50,0,1)/sqrt(nactPN50ms);

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


nactIN10ms = size(actIN_peth10,1);
m_actIN_peth10ms = mean(actIN_peth10,1);
sem_actIN_peth10ms = std(actIN_peth10,0,1)/sqrt(nactIN10ms);
nactIN50ms = size(actIN_peth50,1);
m_actIN_peth50ms = mean(actIN_peth50,1);
sem_actIN_peth50ms = std(actIN_peth50,0,1)/sqrt(nactIN50ms);

ninactIN10ms = size(inactIN_peth10,1);
m_inactIN_peth10ms = mean(inactIN_peth10,1);
sem_inactIN_peth10ms = std(inactIN_peth10,0,1)/sqrt(ninactIN10ms);
ninactIN50ms = size(inactIN_peth50,1);
m_inactIN_peth50ms = mean(inactIN_peth50,1);
sem_inactIN_peth50ms = std(inactIN_peth50,0,1)/sqrt(ninactIN50ms);

nnoIN10ms = size(noIN_peth10,1);
m_noIN_peth10ms = mean(noIN_peth10,1);
sem_noIN_peth10ms = std(noIN_peth10,0,1)/sqrt(nnoIN10ms);
nnoIN50ms = size(noIN_peth50,1);
m_noIN_peth50ms = mean(noIN_peth50,1);
sem_noIN_peth50ms = std(noIN_peth50,0,1)/sqrt(nnoIN50ms);

%% Plot

% print('-painters','-r300','-dtiff',[datestr(now,formatOut),'_plot_ibs_plfm_laserWidth','.tif']);
% print('-painters','-r300','-depsc',[datestr(now,formatOut),'_plot_ibs_plfm_laserWidth','.ai']);
% close;

%% figure 1
nCol = 3;
nRow = 2;
xpt = -100:2:400;
yMaxPN = max([m_actPN_peth10ms,m_actPN_peth50ms])*1.5;
yMaxIN = max([m_actIN_peth10ms,m_actIN_peth50ms])*1.5;

fHandle = figure('PaperUnits','centimeters','PaperPosition',[0 0 40 20]);

hPlotPN2(1) = axes('Position',axpt(nCol,nRow,1,1,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxPN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxPN*0.925,10,yMaxPN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarPN(1) = bar(xpt,m_actPN_peth10ms,'histc');
errorbarJun(xpt+1,m_actPN_peth10ms,sem_actPN_peth10ms,1,0.4,colorDarkGray);
text(90, yMaxPN*0.8,['n = ',num2str(nactPN10ms)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN_activated','fontSize',fontL,'interpreter','none','fontWeight','bold');
hPlotPN2(2) = axes('Position',axpt(nCol,nRow,1,2,[0.10 0.10 0.85 0.8],wideInterval));
bar(25,yMaxPN,'BarWidth',50,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxPN*0.925,50,yMaxPN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarPN(2) = bar(xpt,m_actPN_peth50ms,'histc');
errorbarJun(xpt+1,m_actPN_peth50ms,sem_actPN_peth50ms,1,0.4,colorDarkGray);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);

set(hBarPN,'FaceColor',colorBlack,'EdgeColor',colorBlack,'FaceAlpha',1);
set(hPlotPN2,'Box','off','TickDir','out','XLim',[-20,120],'XTick',[-20:20:100],'YLim',[0,yMaxPN],'fontSize',fontL);

print('-painters','-r300','-dtiff',[datestr(now,formatOut),'_plot_plfm_laserWidth','.tif']);
print('-painters','-r300','-depsc',[datestr(now,formatOut),'_plot_plfm_laserWidth','.ai']);
close;