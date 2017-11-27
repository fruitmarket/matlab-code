clearvars;
load('D:\Dropbox\SNL\P2_Track\myParameters.mat');
winCri_ori = [-5, 20];
nTrial_ori = 300;
markerSS = 1;
fontS = 6;

formatOut = 'yymmdd';
saveDir = 'D:\Dropbox\SNL\P2_Track';

fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});
nCol = 4;
nRow = 6;

%% cell 39 normal
load('D:\Projects\Track_161130-3_Rbp64freq\170304_DV2.05_1hz2hz8hz20hz50hz_T3\TT3_1.mat');
load('D:\Projects\Track_161130-3_Rbp64freq\170304_DV2.05_1hz2hz8hz20hz50hz_T3\Events.mat');

hLightNormal(1) = axes('Position',axpt(5,4,1,1:4,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),midInterval));
hLBarNor(1) = rectangle('Position',[0,0,10,nTrial_ori],'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
plot(xpt1hz_ori{1},ypt1hz_ori{1},'LineStyle','none','Marker','o','MarkerSize',markerSS,'markerFaceColor','k','markerEdgeColor','none');
ylabel('Trials','FontSize',fontS);
% xlabel('Time (ms)','FontSize',fontS);
title('1 Hz','fontSize',fontS);

hLightNormal(2) = axes('Position',axpt(5,4,2,1:4,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),midInterval));
hLBarNor(2) = rectangle('Position',[0,0,10,nTrial_ori],'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
plot(xpt2hz_ori{1},ypt2hz_ori{1},'LineStyle','none','Marker','o','MarkerSize',markerSS,'markerFaceColor','k','markerEdgeColor','none');
% xlabel('Time (ms)','FontSize',fontS);
title('2 Hz','fontSize',fontS);

hLightNormal(3) = axes('Position',axpt(5,4,3,1:4,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),midInterval));
hLBarNor(3) = rectangle('Position',[0,0,10,nTrial_ori],'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
plot(xpt8hz_ori{1},ypt8hz_ori{1},'LineStyle','none','Marker','o','MarkerSize',markerSS,'markerFace','k','markerEdgeColor','none');
xlabel('Time (ms)','FontSize',fontS);
title('8 Hz','fontSize',fontS);

hLightNormal(4) = axes('Position',axpt(5,4,4,1:4,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),midInterval));
hLBarNor(4) = rectangle('Position',[0,0,10,nTrial_ori],'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
plot(xpt20hz_ori{1},ypt20hz_ori{1},'LineStyle','none','Marker','o','MarkerSize',markerSS,'markerFaceColor','k','markerEdgeColor','none');
title('20 Hz','fontSize',fontS);

hLightNormal(5) = axes('Position',axpt(5,4,5,1:4,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),midInterval));
hLBarNor(5) = rectangle('Position',[0,0,10,nTrial_ori],'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
plot(xpt50hz_ori{1},ypt50hz_ori{1},'LineStyle','none','Marker','o','MarkerSize',markerSS,'markerFaceColor','k','markerEdgeColor','none');
% xlabel('Time (ms)','FontSize',fontS);
title('50 Hz','fontSize',fontS);

set(hLightNormal,'XLim',winCri_ori,'XTick',[],'YLim',[0, nTrial_ori],'YTick',[]);
set(hLightNormal(1),'YTick',[0:100:300]);
set(hLightNormal(3),'XTick',[0 10]);
set(hLightNormal,'Box','off','TickDir','out','fontSize',fontS);


%% freq dependency
Txls = readtable('neuronList_freq_171127.xlsx');
load('neuronList_freq_171127.mat');
Txls.latencyIndex = categorical(Txls.latencyIndex);
formatOut = 'yymmdd';

alpha = 0.01;
alpha2 = alpha/5;
cSpkpvr = 1.2;

listPN = T.spkpvr > cSpkpvr;
listIN = ~listPN;

% lightAct = listPN & (Txls.latencyIndex == 'direct' | Txls.latencyIndex == 'indirect' | Txls.latencyIndex == 'double');
lightAct = listPN & (T.idx_light1hz == 1 | T.idx_light2hz == 1 | T.idx_light8hz == 1 | T.idx_light20hz == 1 | T.idx_light50hz == 1);
lightProb1hzT = T.lightProb1hz(lightAct);
lightProb2hzT = T.lightProb2hz(lightAct);
lightProb8hzT = T.lightProb8hz(lightAct);
lightProb20hzT = T.lightProb20hz(lightAct);
lightProb50hzT = T.lightProb50hz(lightAct);
nCellT = sum(double(lightAct));

% plot_freqDependency_multi(T.path(lightAct), T.cellID(lightAct), 'C:\Users\Jun\Desktop\example_50hzAct')

m_1hz_T = mean(lightProb1hzT);
m_2hz_T = mean(lightProb2hzT);
m_8hz_T = mean(lightProb8hzT);
m_20hz_T = mean(lightProb20hzT);
m_50hz_T = mean(lightProb50hzT);

sem_1hz_T = std(lightProb1hzT)/sqrt(nCellT);
sem_2hz_T = std(lightProb2hzT)/sqrt(nCellT);
sem_8hz_T = std(lightProb8hzT)/sqrt(nCellT);
sem_20hz_T = std(lightProb20hzT)/sqrt(nCellT);
sem_50hz_T = std(lightProb50hzT)/sqrt(nCellT);

hPlot = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1,2,[0.1 0.1 0.85 0.85],midInterval),midInterval));
plot([1,2,3,4,5],[lightProb1hzT, lightProb2hzT, lightProb8hzT, lightProb20hzT, lightProb50hzT],'-o','color',colorGray,'markerSize',markerS-1.5,'markerEdgeColor',colorGray,'markerFaceColor',colorLightGray);
hold on;
plot([1,2,3,4,5],[m_1hz_T, m_2hz_T, m_8hz_T, m_20hz_T, m_50hz_T],'o','color',colorBlack,'markerSize',markerS,'markerEdgeColor',colorBlack,'markerFaceColor',colorBlack);
hold on;
errorbarJun([1,2,3,4,5],[m_1hz_T, m_2hz_T, m_8hz_T, m_20hz_T, m_50hz_T],[sem_1hz_T,sem_2hz_T,sem_8hz_T,sem_20hz_T,sem_50hz_T],0.2, 0.8, colorBlack);
text(1,50,['n = ',num2str(nCellT)],'fontSize',fontS);
ylabel('Spike fidelity (%)','fontSize',fontS);
xlabel('Frequency (Hz)','fontSize',fontS);
% title('Total activated neuron','fontSize',fontS);

set(hPlot,'TickDir','out','Box','off');
set(hPlot,'XLim',[0,6],'XTick',[1:5],'XTickLabel',{'1';'2';'8';'20';'50'},'fontSize',fontS);
set(hPlot,'YLim',[-1,60]);

%%
pop_1hz_act = listPN & (T.idx_light1hz == 1);
pop_1hz_ina = listPN & (T.idx_light1hz == -1);
pop_1hz_no = listPN & (T.idx_light1hz == 0);

pop_2hz_act = listPN & (T.idx_light2hz == 1);
pop_2hz_ina = listPN & (T.idx_light2hz == -1);
pop_2hz_no = listPN & (T.idx_light2hz == 0);

pop_8hz_act = listPN & (T.idx_light8hz == 1);
pop_8hz_ina = listPN & (T.idx_light8hz == -1);
pop_8hz_no = listPN & (T.idx_light8hz == 0);

pop_20hz_act = listPN & (T.idx_light20hz == 1);
pop_20hz_ina = listPN & (T.idx_light20hz == -1);
pop_20hz_no = listPN & (T.idx_light20hz == 0);

pop_50hz_act = listPN & (T.idx_light50hz == 1);
pop_50hz_ina = listPN & (T.idx_light50hz == -1);
pop_50hz_no = listPN & (T.idx_light50hz == 0);

popul_1hz = [sum(double(pop_1hz_act)), sum(double(pop_1hz_ina)), sum(double(pop_1hz_no))];
popul_2hz = [sum(double(pop_2hz_act)), sum(double(pop_2hz_ina)), sum(double(pop_2hz_no))];
popul_8hz = [sum(double(pop_8hz_act)), sum(double(pop_8hz_ina)), sum(double(pop_8hz_no))];
popul_20hz = [sum(double(pop_20hz_act)), sum(double(pop_20hz_ina)), sum(double(pop_20hz_no))];
popul_50hz = [sum(double(pop_50hz_act)), sum(double(pop_50hz_ina)), sum(double(pop_50hz_no))];

pop_total = [popul_1hz; popul_2hz; popul_8hz; popul_20hz; popul_50hz];
pop_total_ratio = pop_total/122*100;

hProp = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1,3,[0.1 0.1 0.85 0.85],midInterval),midInterval));
plot([1,2,3,4,5],pop_total_ratio(:,1),'-o','color',colorDarkGray,'markerSize',markerS,'markerEdgeColor',colorDarkGray,'markerFaceColor',colorLightBlue);
hold on;
plot([1,2,3,4,5],pop_total_ratio(:,2),'-o','color',colorDarkGray,'markerSize',markerS,'markerEdgeColor',colorDarkGray,'markerFaceColor',colorLightRed);
% title('Proportion of light responsive neuron','fontSize',fontS);
ylabel('Proportion (%)','fontSize',fontS);
xlabel('Frequency (Hz)','fontSize',fontS);

set(hProp,'TickDir','out','Box','off');
set(hProp,'XLim',[0,6],'XTick',[1:5],'XTickLabel',{'1';'2';'8';'20';'50'},'YTick',[0:5:20],'fontSize',fontS);
set(hProp,'YLim',[-1,20]);

print('-painters','-r300','-dtiff',['final_fig2_platform_total_',datestr(now,formatOut),'_v2.tif']);
print('-painters','-r300','-depsc',['final_fig2_platform_total_',datestr(now,formatOut),'_v2.ai']);
close;