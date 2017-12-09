clearvars;
load('D:\Dropbox\SNL\P2_Track\myParameters.mat');
winCri_ori = [-5, 20];
nTrial_ori = 300;
fontS = 8;

formatOut = 'yymmdd';
saveDir = 'D:\Dropbox\SNL\P2_Track';

fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});
nCol = 4;
nRow = 6;

%% cell 39 normal
load('D:\Projects\Track_161130-3_Rbp64freq\170304_DV2.05_1hz2hz8hz20hz50hz_T3\TT3_1.mat');
load('D:\Projects\Track_161130-3_Rbp64freq\170304_DV2.05_1hz2hz8hz20hz50hz_T3\Events.mat');

hLightNormal(1) = axes('Position',axpt(5,4,1,1:3,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),midInterval));
hLBarNor(1) = rectangle('Position',[0,0,10,nTrial_ori],'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
hLBarNor(2) = rectangle('Position',[0,270,10,nTrial_ori/10],'LineStyle','none','FaceColor',colorBlue);
hold on;
plot(xpt1hz_ori{1},ypt1hz_ori{1},'LineStyle','o','MarkerSize',markerSS,'markerFaceColor','k','markerEdgeColor','none');
ylabel('Trials','FontSize',fontS);
% xlabel('Time (ms)','FontSize',fontS);
title('1 Hz','fontSize',fontS);

hLightNormal(2) = axes('Position',axpt(5,4,2,1:3,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),midInterval));
hLBarNor(3) = rectangle('Position',[0,0,10,nTrial_ori],'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
hLBarNor(4) = rectangle('Position',[0,270,10,nTrial_ori/10],'LineStyle','none','FaceColor',colorBlue);
hold on;
plot(xpt2hz_ori{1},ypt2hz_ori{1},'LineStyle','o','MarkerSize',markerSS,'markerFaceColor','k','markerEdgeColor','none');
% xlabel('Time (ms)','FontSize',fontS);
title('2 Hz','fontSize',fontS);

hLightNormal(3) = axes('Position',axpt(5,4,3,1:3,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),midInterval));
hLBarNor(5) = rectangle('Position',[0,0,10,nTrial_ori],'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
hLBarNor(6) = rectangle('Position',[0,270,10,nTrial_ori/10],'LineStyle','none','FaceColor',colorBlue);
hold on;
plot(xpt8hz_ori{1},ypt8hz_ori{1},'LineStyle','o','MarkerSize',markerSS,'markerFace','k','markerEdgeColor','none');
xlabel('Time (ms)','FontSize',fontS);
title('8 Hz','fontSize',fontS);

hLightNormal(4) = axes('Position',axpt(5,4,4,1:3,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),midInterval));
hLBarNor(7) = rectangle('Position',[0,0,10,nTrial_ori],'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
hLBarNor(8) = rectangle('Position',[0,270,10,nTrial_ori/10],'LineStyle','none','FaceColor',colorBlue);
hold on;
plot(xpt20hz_ori{1},ypt20hz_ori{1},'LineStyle','o','MarkerSize',markerSS,'markerFaceColor','k','markerEdgeColor','none');
title('20 Hz','fontSize',fontS);

hLightNormal(5) = axes('Position',axpt(5,4,5,1:3,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),midInterval));
hLBarNor(9) = rectangle('Position',[0,0,10,nTrial_ori],'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
hLBarNor(10) = rectangle('Position',[0,270,10,nTrial_ori/10],'LineStyle','none','FaceColor',colorBlue);
hold on;
plot(xpt50hz_ori{1},ypt50hz_ori{1},'LineStyle','o','MarkerSize',markerSS,'markerFaceColor','k','markerEdgeColor','none');
% xlabel('Time (ms)','FontSize',fontS);
title('50 Hz','fontSize',fontS);

set(hLightNormal,'XLim',winCri_ori,'XTick',[],'YLim',[0, nTrial_ori],'YTick',[]);
set(hLightNormal(1),'YTick',[0:100:300]);
set(hLightNormal(3),'XTick',[0 10]);
set(hLightNormal,'Box','off','TickDir','out','fontSize',fontS);

%% Build up ID:120
load('D:\Projects\Track_170305-1_Rbp76freq_8mw\170710_DV2.20_2_1hz2hz8hz20hz50hz_T12_8mW\TT1_1.mat');
load('D:\Projects\Track_170305-1_Rbp76freq_8mw\170710_DV2.20_2_1hz2hz8hz20hz50hz_T12_8mW\Events.mat');

hLightBuild(1) = axes('Position',axpt(5,4,1,1:3,axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],midInterval),midInterval));
hLBar(1) = rectangle('Position',[0,0,10,nTrial_ori],'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
hLBar(2) = rectangle('Position',[0,270,10,nTrial_ori/10],'LineStyle','none','FaceColor',colorBlue);
hold on;
plot(xpt1hz_ori{1},ypt1hz_ori{1},'LineStyle','o','MarkerSize',markerSS,'markerFaceColor','k','markerEdgeColor','none');
ylabel('Trials','FontSize',fontS);
title('1 Hz','fontSize',fontS);

hLightBuild(2) = axes('Position',axpt(5,4,2,1:3,axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],midInterval),midInterval));
hLBar(3) = rectangle('Position',[0,0,10,nTrial_ori],'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
hLBar(4) = rectangle('Position',[0,270,10,nTrial_ori/10],'LineStyle','none','FaceColor',colorBlue);
hold on;
plot(xpt2hz_ori{1},ypt2hz_ori{1},'LineStyle','o','MarkerSize',markerSS,'markerFaceColor','k','markerEdgeColor','none');
title('2 Hz','fontSize',fontS);

hLightBuild(3) = axes('Position',axpt(5,4,3,1:3,axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],midInterval),midInterval));
hLBar(5) = rectangle('Position',[0,0,10,nTrial_ori],'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
hLBar(6) = rectangle('Position',[0,270,10,nTrial_ori/10],'LineStyle','none','FaceColor',colorBlue);
hold on;
plot(xpt8hz_ori{1},ypt8hz_ori{1},'LineStyle','o','MarkerSize',markerSS,'markerFace','k','markerEdgeColor','none');
xlabel('Time (ms)','FontSize',fontS);
title('8 Hz','fontSize',fontS);

hLightBuild(4) = axes('Position',axpt(5,4,4,1:3,axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],midInterval),midInterval));
hLBar(7) = rectangle('Position',[0,0,10,nTrial_ori],'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
hLBar(8) = rectangle('Position',[0,270,10,nTrial_ori/10],'LineStyle','none','FaceColor',colorBlue);
hold on;
plot(xpt20hz_ori{1},ypt20hz_ori{1},'LineStyle','o','MarkerSize',markerSS,'markerFaceColor','k','markerEdgeColor','none');
title('20 Hz','fontSize',fontS);

hLightBuild(5) = axes('Position',axpt(5,4,5,1:3,axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],midInterval),midInterval));
hLBar(9) = rectangle('Position',[0,0,10,nTrial_ori],'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
hLBar(10) = rectangle('Position',[0,270,10,nTrial_ori/10],'LineStyle','none','FaceColor',colorBlue);
hold on;
plot(xpt50hz_ori{1},ypt50hz_ori{1},'LineStyle','o','MarkerSize',markerSS,'markerFaceColor','k','markerEdgeColor','none');
title('50 Hz','fontSize',fontS);

set(hLightBuild,'XLim',winCri_ori,'XTick',[],'YLim',[0, nTrial_ori],'YTick',[]);
set(hLightBuild(1),'YTick',[0:100:300]);
set(hLightBuild(3),'XTick',[0 10]);
set(hLightBuild,'Box','off','TickDir','out','fontSize',fontS);

%%
rtDir = 'D:\Dropbox\SNL\P2_Track';
cd(rtDir);
Txls = readtable('neuronList_freq_170921.xlsx');
load('neuronList_freq_170921.mat');

alpha = 0.01;
cSpkpvr = 1.2;

% light1hz = T.spkpvr>cSpkpvr & T.pLR_Plfm1hz < alpha;
% light2hz = T.spkpvr>cSpkpvr & T.pLR_Plfm2hz < alpha;
% light8hz = T.spkpvr>cSpkpvr & T.pLR_Plfm8hz < alpha;
% light20hz = T.spkpvr>cSpkpvr & T.pLR_Plfm20hz < alpha;
% light50hz = T.spkpvr>cSpkpvr & T.pLR_Plfm50hz < alpha;

light1hz = T.spkpvr>cSpkpvr & T.pLR_Plfm1hz < alpha;
light2hz = T.spkpvr>cSpkpvr & T.pLR_Plfm2hz < alpha;
light8hz = T.spkpvr>cSpkpvr & T.pLR_Plfm8hz < alpha;
light20hz = T.spkpvr>cSpkpvr & T.pLR_Plfm20hz < alpha;
light50hz = T.spkpvr>cSpkpvr & T.pLR_Plfm50hz < alpha;

nLight1hz = sum(double(light1hz));
nLight2hz = sum(double(light2hz));
nLight8hz = sum(double(light8hz));
nLight20hz = sum(double(light20hz));
nLight50hz = sum(double(light50hz));

evoSpike1hz = T.evoDetoSpk1hz(light1hz,:);
evoSpike2hz = T.evoDetoSpk2hz(light2hz,:);
evoSpike8hz = T.evoDetoSpk8hz(light8hz,:);
evoSpike20hz = T.evoDetoSpk20hz(light20hz,:);
evoSpike50hz = T.evoDetoSpk50hz(light50hz,:);

detoSpike1hz = T.detoProb1hz(light1hz,:);
detoSpike2hz = T.detoProb2hz(light2hz,:);
detoSpike8hz = T.detoProb8hz(light8hz,:);
detoSpike20hz = T.detoProb20hz(light20hz,:);
detoSpike50hz = T.detoProb50hz(light50hz,:);

m_detoSpike1hz = mean(detoSpike1hz,1);
m_detoSpike2hz = mean(detoSpike2hz,1);
m_detoSpike8hz = mean(detoSpike8hz,1);
m_detoSpike20hz = mean(detoSpike20hz,1);
m_detoSpike50hz = mean(detoSpike50hz,1);

sem_detoSpike1hz = std(detoSpike1hz,0,1)/sqrt(nLight1hz);
sem_detoSpike2hz = std(detoSpike2hz,0,1)/sqrt(nLight2hz);
sem_detoSpike8hz = std(detoSpike8hz,0,1)/sqrt(nLight8hz);
sem_detoSpike20hz = std(detoSpike20hz,0,1)/sqrt(nLight20hz);
sem_detoSpike50hz = std(detoSpike50hz,0,1)/sqrt(nLight50hz);

%%
eBarM = 0.2;
% gray scale
% color1 = [38, 50, 56]./255;
% color2 = [69, 90, 100]./255;
% color3 = [96, 125, 139]./255;
% color4 = [144, 164, 174]./255;
% color5 = [176, 190, 197]./255;

% blue scale
color1 = [187, 222, 251]./255;
color2 = [100, 181, 246]./255;
color3 = [30, 136, 229]./255;
color4 = [13, 71, 161]./255;
color5 = [0, 0, 0]./255;

xpt = 1:5;

detoSpike1hz_build1 = T.detoProb1hz(T.cellID == 39,:);
detoSpike2hz_build1 = T.detoProb2hz(T.cellID == 39,:);
detoSpike8hz_build1 = T.detoProb8hz(T.cellID == 39,:);
detoSpike20hz_build1 = T.detoProb20hz(T.cellID == 39,:);
detoSpike50hz_build1 = T.detoProb50hz(T.cellID == 39,:);

hPlot_mean(1) = axes('Position',axpt(1,5,1,1:4,axpt(nCol,nRow,1,2,[0.1 0.1 0.85 0.85],midInterval),midInterval));
% 1hz
plot(xpt,detoSpike1hz_build1(1:5),'-o','color',color1,'MarkerEdgeColor',colorBlack,'MarkerFaceColor',color1,'markerSize',markerS);
hold on;
% 2hz
plot(xpt,detoSpike2hz_build1(1:5),'-o','color',color2,'MarkerEdgeColor',colorBlack,'MarkerFaceColor',color2,'markerSize',markerS);
hold on;
% 8hz
plot(xpt,detoSpike8hz_build1(1:5),'-o','color',color3,'MarkerEdgeColor',colorBlack,'MarkerFaceColor',color3,'markerSize',markerS);
hold on;
% 20hz
plot(xpt,detoSpike20hz_build1(1:5),'-o','color',color4,'MarkerEdgeColor',colorBlack,'MarkerFaceColor',color4,'markerSize',markerS);
hold on;
% 50hz
plot(xpt,detoSpike50hz_build1(1:5),'-o','color',color5,'MarkerEdgeColor',colorBlack,'MarkerFaceColor',color5,'markerSize',markerS);
xlabel('n-th light pulse','fontSize',fontS);
ylabel('Spike fidelity (%)','fontSize',fontS);
title('cell# 39','fontSize',fontS);

text(4, 45, ['1 Hz'],'color',color1,'fontSize',fontS);
text(4, 42, ['2 Hz'],'color',color2,'fontSize',fontS);
text(4, 39, ['8 Hz'],'color',color3,'fontSize',fontS);
text(4, 36, ['20 Hz'],'color',color4,'fontSize',fontS);
text(4, 33, ['50 Hz'],'color',color5,'fontSize',fontS);

detoSpike1hz_build2 = T.detoProb1hz(T.cellID == 120,:);
detoSpike2hz_build2 = T.detoProb2hz(T.cellID == 120,:);
detoSpike8hz_build2 = T.detoProb8hz(T.cellID == 120,:);
detoSpike20hz_build2 = T.detoProb20hz(T.cellID == 120,:);
detoSpike50hz_build2 = T.detoProb50hz(T.cellID == 120,:);

hPlot_mean(2) = axes('Position',axpt(1,5,1,1:4,axpt(nCol,nRow,2,2,[0.1 0.1 0.85 0.85],midInterval),midInterval));
% 1hz
plot(xpt,detoSpike1hz_build2(1:5),'-o','color',color1,'MarkerEdgeColor',colorBlack,'MarkerFaceColor',color1,'markerSize',markerS);
hold on;
% 2hz
plot(xpt,detoSpike2hz_build2(1:5),'-o','color',color2,'MarkerEdgeColor',colorBlack,'MarkerFaceColor',color2,'markerSize',markerS);
hold on;
% 8hz
plot(xpt,detoSpike8hz_build2(1:5),'-o','color',color3,'MarkerEdgeColor',colorBlack,'MarkerFaceColor',color3,'markerSize',markerS);
hold on;
% 20hz
plot(xpt,detoSpike20hz_build2(1:5),'-o','color',color4,'MarkerEdgeColor',colorBlack,'MarkerFaceColor',color4,'markerSize',markerS);
hold on;
% 50hz
plot(xpt,detoSpike50hz_build2(1:5),'-o','color',color5,'MarkerEdgeColor',colorBlack,'MarkerFaceColor',color5,'markerSize',markerS);
xlabel('n-th light pulse','fontSize',fontS);
ylabel('Spike fidelity (%)','fontSize',fontS);
title('cell# 120','fontSize',fontS);

%% Average data
hPlot_mean(3) = axes('Position',axpt(1,5,1,1:4,axpt(nCol,nRow,1,3,[0.1 0.1 0.80 0.85],midInterval),midInterval));
% 1hz
errorbarJun(xpt,m_detoSpike1hz(1:5),sem_detoSpike1hz(1:5),eBarM,0.6,color1);
hold on;
plot(xpt,m_detoSpike1hz(1:5),'-o','color',color1,'MarkerEdgeColor',colorBlack,'MarkerFaceColor',color1,'markerSize',markerS);
hold on;
% 2hz
errorbarJun(xpt,m_detoSpike2hz(1:5),sem_detoSpike2hz(1:5),eBarM,0.6,color2);
hold on;
plot(xpt,m_detoSpike2hz(1:5),'-o','color',color2,'MarkerEdgeColor',colorBlack,'MarkerFaceColor',color2,'markerSize',markerS);
hold on;
% 8hz
errorbarJun(xpt,m_detoSpike8hz(1:5),sem_detoSpike8hz(1:5),eBarM,0.6,color3);
hold on;
plot(xpt,m_detoSpike8hz(1:5),'-o','color',color3,'MarkerEdgeColor',colorBlack,'MarkerFaceColor',color3,'markerSize',markerS);
hold on;
% 20hz
errorbarJun(xpt,m_detoSpike20hz(1:5),sem_detoSpike20hz(1:5),eBarM,0.6,color4);
hold on;
plot(xpt,m_detoSpike20hz(1:5),'-o','color',color4,'MarkerEdgeColor',colorBlack,'MarkerFaceColor',color4,'markerSize',markerS);
hold on;
% 50hz
errorbarJun(xpt,m_detoSpike50hz(1:5),sem_detoSpike50hz(1:5),eBarM,0.6,color5);
hold on;
plot(xpt,m_detoSpike50hz(1:5),'-o','color',color5,'MarkerEdgeColor',colorBlack,'MarkerFaceColor',color5,'markerSize',markerS);

text(3.5, 35, ['1 Hz (n = ',num2str(nLight1hz),')'],'color',color1,'fontSize',fontS);
text(3.5, 32, ['2 Hz (n = ',num2str(nLight2hz),')'],'color',color2,'fontSize',fontS);
text(3.5, 29, ['8 Hz (n = ',num2str(nLight8hz),')'],'color',color3,'fontSize',fontS);
text(3.5, 26, ['20 Hz (n = ',num2str(nLight20hz),')'],'color',color4,'fontSize',fontS);
text(3.5, 23, ['50 Hz (n = ',num2str(nLight50hz),')'],'color',color5,'fontSize',fontS);
xlabel('n-th light pulse','fontSize',fontS);
ylabel('Spike fidelity (%)','fontSize',fontS);

set(hPlot_mean,'TickDir','out','Box','off');
set(hPlot_mean,'XLim',[0,6],'XTick',1:5,'fontSize',fontS,'YLim',[-0.5 50],'YTick',0:10:50);
set(hPlot_mean(2),'YLim',[-0.5 70],'YTick',0:10:70);
set(hPlot_mean(3),'YLim',[-0.5 30],'YTick',0:10:30);

print('-painters','-r300','-dtiff',['final_fig2_platform_total_',datestr(now,formatOut),'.tif']);
print('-painters','-r300','-depsc',['final_fig2_platform_total_',datestr(now,formatOut),'.ai']);
close;