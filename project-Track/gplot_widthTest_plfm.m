clearvars;
lineColor = {[144, 164, 174]./255,... % Before stimulation
    [33 150 243]./ 255,... % During stimulation
    [38, 50, 56]./255}; % After stimulation

lineWth = [1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75];
fontS = 4; fontM = 5; fontL = 7; fontXL = 9; % font size large
lineS = 0.2; lineM = 0.5; lineL = 1; % line width large

colorBlue = [33 150 243] ./ 255;
colorLightBlue = [100 181 246] ./ 255;
colorLLightBlue = [187, 222, 251]./255;
colorRed = [237 50 52] ./ 255;
colorLightRed = [242 138 130] ./ 255;
colorGray = [189 189 189] ./ 255;
colorLightGray = [238, 238, 238] ./255;
colorDarkGray = [117, 117, 117] ./255;
colorYellow = [255 243 3] ./ 255;
colorLightYellow = [255 249 196] ./ 255;
colorBlack = [0, 0, 0];

markerS = 4; markerM = 6; markerL = 8; markerXL = 12*2;
tightInterval = [0.02 0.02]; midInterval = [0.09, 0.09]; wideInterval = [0.14 0.14];
width = 0.7;

paperSize = {[0 0 21.0 29.7]; % A4_portrait
             [0 0 29.7 21.0]; % A4_landscape
             [0 0 21.6 27.9]}; % Letter
         
rtDir = 'D:\Dropbox\SNL\P2_Track';
load('neuronList_pulse_07-Feb-2017.mat');

%% Population separation
cri_meanFR = 7;
listPN = T.meanFR10<cri_meanFR;
cri_lightAct = T.pLR_Plfm2hz<0.005 & T.statDir_Plfm2hz==1;
cri_lightInAct = T.pLR_Plfm2hz<0.005 & T.statDir_Plfm2hz==-1;
cri_lightNo = ~(T.pLR_Plfm2hz<0.005);

% Pyramidal neuron
actPN_peth10ms = cell2mat(T.peth10ms(listPN & cri_lightAct));
actPN_peth50ms = cell2mat(T.peth50ms(listPN & cri_lightAct));

inactPN_peth10ms = cell2mat(T.peth10ms(listPN & cri_lightInAct));
inactPN_peth50ms = cell2mat(T.peth50ms(listPN & cri_lightInAct));

noPN_peth10ms = cell2mat(T.peth10ms(listPN & cri_lightNo));
noPN_peth50ms = cell2mat(T.peth50ms(listPN & cri_lightNo));

% Interneuron
actIN_peth10ms = cell2mat(T.peth10ms(~listPN & cri_lightAct));
actIN_peth50ms = cell2mat(T.peth50ms(~listPN & cri_lightAct));

inactIN_peth10ms = cell2mat(T.peth10ms(~listPN & cri_lightInAct));
inactIN_peth50ms = cell2mat(T.peth50ms(~listPN & cri_lightInAct));

noIN_peth10ms = cell2mat(T.peth10ms(~listPN & cri_lightNo));
noIN_peth50ms = cell2mat(T.peth50ms(~listPN & cri_lightNo));

%% Mean & SEM
nactPN10ms = size(actPN_peth10ms,1);
m_actPN_peth10ms = mean(actPN_peth10ms,1);
sem_actPN_peth10ms = std(actPN_peth10ms,1)/nactPN10ms;
nactPN50ms = size(actPN_peth50ms,1);
m_actPN_peth50ms = mean(actPN_peth50ms,1);
sem_actPN_peth50ms = std(actPN_peth50ms,1)/nactPN50ms;

ninactPN10ms = size(inactPN_peth10ms,1);
m_inactPN_peth10ms = mean(inactPN_peth10ms,1);
sem_inactPN_peth10ms = std(inactPN_peth10ms,1)/ninactPN10ms;
ninactPN50ms = size(inactPN_peth50ms,1);
m_inactPN_peth50ms = mean(inactPN_peth50ms,1);
sem_inactPN_peth50ms = std(inactPN_peth50ms,1)/ninactPN50ms;

nnoPN10ms = size(noPN_peth10ms,1);
m_noPN_peth10ms = mean(noPN_peth10ms,1);
sem_noPN_peth10ms = std(noPN_peth10ms,1)/nnoPN10ms;
nnoPN50ms = size(noPN_peth50ms,1);
m_noPN_peth50ms = mean(noPN_peth50ms,1);
sem_noPN_peth50ms = std(noPN_peth50ms,1)/nnoPN50ms;


nactIN10ms = size(actIN_peth10ms,1);
m_actIN_peth10ms = mean(actIN_peth10ms,1);
sem_actIN_peth10ms = std(actIN_peth10ms,1)/nactIN10ms;
nactIN50ms = size(actIN_peth50ms,1);
m_actIN_peth50ms = mean(actIN_peth50ms,1);
sem_actIN_peth50ms = std(actIN_peth50ms,1)/nactIN50ms;

ninactIN10ms = size(inactIN_peth10ms,1);
m_inactIN_peth10ms = mean(inactIN_peth10ms,1);
sem_inactIN_peth10ms = std(inactIN_peth10ms,1)/ninactIN10ms;
ninactIN50ms = size(inactIN_peth50ms,1);
m_inactIN_peth50ms = mean(inactIN_peth50ms,1);
sem_inactIN_peth50ms = std(inactIN_peth50ms,1)/ninactIN50ms;

nnoIN10ms = size(noIN_peth10ms,1);
m_noIN_peth10ms = mean(noIN_peth10ms,1);
sem_noIN_peth10ms = std(noIN_peth10ms,1)/nnoIN10ms;
nnoIN50ms = size(noIN_peth50ms,1);
m_noIN_peth50ms = mean(noIN_peth50ms,1);
sem_noIN_peth50ms = std(noIN_peth50ms,1)/nnoIN50ms;

%% Plot
nCol = 3;
nRow = 4;
xpt = -200:2:300;
yMaxPN = max([m_actPN_peth10ms,m_actPN_peth50ms])*1.1;
yMaxIN = max([m_actIN_peth10ms,m_actIN_peth50ms])*1.1;

fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{2});

hPlotPN(1) = axes('Position',axpt(nCol,nRow,1,1,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxPN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxPN*0.925,10,yMaxPN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarPN(1) = bar(xpt,m_actPN_peth10ms,'histc');
text(100, yMaxPN*0.8,['n = ',num2str(nactPN10ms)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);

hPlotPN(2) = axes('Position',axpt(nCol,nRow,1,2,[0.10 0.10 0.85 0.8],wideInterval));
bar(25,yMaxPN,'BarWidth',50,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxPN*0.925,50,yMaxPN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarPN(2) = bar(xpt,m_actPN_peth50ms,'histc');
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);

hPlotPN(3) = axes('Position',axpt(nCol,nRow,2,1,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxPN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxPN*0.925,10,yMaxPN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarPN(3) = bar(xpt,m_inactPN_peth10ms,'histc');
text(100, yMaxPN*0.8,['n = ',num2str(ninactPN10ms)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
hPlotPN(4) = axes('Position',axpt(nCol,nRow,2,2,[0.10 0.10 0.85 0.8],wideInterval));
bar(25,yMaxPN,'BarWidth',50,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxPN*0.925,50,yMaxPN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarPN(4) = bar(xpt,m_inactPN_peth50ms,'histc');
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);

hPlotPN(5) = axes('Position',axpt(nCol,nRow,3,1,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxPN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxPN*0.925,10,yMaxPN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarPN(5) = bar(xpt,m_noPN_peth10ms,'histc');
text(100, yMaxPN*0.8,['n = ',num2str(nnoPN10ms)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
hPlotPN(6) = axes('Position',axpt(nCol,nRow,3,2,[0.10 0.10 0.85 0.8],wideInterval));
bar(25,yMaxPN,'BarWidth',50,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxPN*0.925,50,yMaxPN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarPN(6) = bar(xpt,m_noPN_peth50ms,'histc');
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);

set(hBarPN,'FaceColor',colorBlack,'EdgeColor',colorBlack,'FaceAlpha',1);
set(hPlotPN,'Box','off','TickDir','out','XLim',[-50,150],'XTick',[-50:50:150],'YLim',[0,yMaxPN],'fontSize',fontL);

%% IN
hPlotIN(1) = axes('Position',axpt(nCol,nRow,1,3,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxIN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxIN*0.925,10,yMaxIN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarIN(1) = bar(xpt,m_actIN_peth10ms,'histc');
text(100, yMaxIN*0.8,['n = ',num2str(nactIN10ms)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
hPlotIN(2) = axes('Position',axpt(nCol,nRow,1,4,[0.10 0.10 0.85 0.8],wideInterval));
bar(25,yMaxIN,'BarWidth',50,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxIN*0.925,50,yMaxIN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarIN(2) = bar(xpt,m_actIN_peth50ms,'histc');
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);

hPlotIN(3) = axes('Position',axpt(nCol,nRow,2,3,[0.10 0.10 0.85 0.8],wideInterval));
bar(5,yMaxIN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxIN*0.925,10,yMaxIN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarIN(3) = bar(xpt,m_inactIN_peth10ms,'histc');
text(100, yMaxIN*0.8,['n = ',num2str(ninactIN10ms)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
hPlotIN(4) = axes('Position',axpt(nCol,nRow,2,4,[0.10 0.10 0.85 0.8],wideInterval));
bar(25,yMaxIN,'BarWidth',50,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxIN*0.925,50,yMaxIN*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarIN(4) = bar(xpt,m_inactIN_peth50ms,'histc');
uistack(hBarIN(4),'up');
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);

% hPlotIN(5) = axes('Position',axpt(nCol,nRow,3,1,[0.10 0.15 0.85 0.8],wideInterval));
% hBar(5) = bar(xpt,m_noIN_peth10ms,'histc');
% hPlotIN(6) = axes('Position',axpt(nCol,nRow,3,2,[0.10 0.15 0.85 0.8],wideInterval));
% hBar(6) = bar(xpt,m_noIN_peth50ms,'histc');

set(hBarIN,'FaceColor',colorBlack,'EdgeAlpha',0);
set(hPlotIN,'Box','off','TickDir','out','XLim',[-50,150],'XTick',[-50:50:150],'YLim',[0,yMaxIN],'fontSize',fontL);

print('-painters',['plot_widthTest_plfm_',datestr(date),'.tif'],'-r300','-dtiff');
