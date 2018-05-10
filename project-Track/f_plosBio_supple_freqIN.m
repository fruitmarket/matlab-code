clearvars;

rtDir = 'D:\Dropbox\SNL\P2_Track';
cd(rtDir);
load('D:\Dropbox\SNL\P2_Track\myParameters.mat');
winCri_ori = [-5, 20];
nTrial_ori = 300;
markerSS = 1;

formatOut = 'yymmdd';
saveDir = 'E:\Dropbox\SNL\P2_Track';

fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});
nCol = 4;
nRow = 6;

%% cell 39 normal
% load('D:\Projects\Track_161130-3_Rbp64freq\170304_DV2.05_1hz2hz8hz20hz50hz_T3\TT3_1.mat');
% load('D:\Projects\Track_161130-3_Rbp64freq\170304_DV2.05_1hz2hz8hz20hz50hz_T3\Events.mat');
% 
% hLightNormal(1) = axes('Position',axpt(5,4,1,1:4,axpt(nCol,nRow,1,1,[0.1 0.1 0.90 0.85],midInterval),midInterval+[0.015 0]));
% hLBarNor(1) = rectangle('Position',[0,0,10,nTrial_ori],'LineStyle','none','FaceColor',colorLLightBlue);
% hold on;
% plot(xpt1hz_ori{1},ypt1hz_ori{1},'LineStyle','none','Marker','o','MarkerSize',markerSS,'markerFaceColor','k','markerEdgeColor','none');
% ylabel('Light pulse #','FontSize',fontM);
% % xlabel('Time (ms)','FontSize',fontS);
% title('1 Hz','fontSize',fontM);
% 
% hLightNormal(2) = axes('Position',axpt(5,4,2,1:4,axpt(nCol,nRow,1,1,[0.1 0.1 0.90 0.85],midInterval),midInterval+[0.015 0]));
% hLBarNor(2) = rectangle('Position',[0,0,10,nTrial_ori],'LineStyle','none','FaceColor',colorLLightBlue);
% hold on;
% plot(xpt2hz_ori{1},ypt2hz_ori{1},'LineStyle','none','Marker','o','MarkerSize',markerSS,'markerFaceColor','k','markerEdgeColor','none');
% % xlabel('Time (ms)','FontSize',fontS);
% title('2 Hz','fontSize',fontM);
% 
% hLightNormal(3) = axes('Position',axpt(5,4,3,1:4,axpt(nCol,nRow,1,1,[0.1 0.1 0.90 0.85],midInterval),midInterval+[0.015 0]));
% hLBarNor(3) = rectangle('Position',[0,0,10,nTrial_ori],'LineStyle','none','FaceColor',colorLLightBlue);
% hold on;
% plot(xpt8hz_ori{1},ypt8hz_ori{1},'LineStyle','none','Marker','o','MarkerSize',markerSS,'markerFace','k','markerEdgeColor','none');
% xlabel('Time (ms)','FontSize',fontM);
% title('8 Hz','fontSize',fontM);
% 
% hLightNormal(4) = axes('Position',axpt(5,4,4,1:4,axpt(nCol,nRow,1,1,[0.1 0.1 0.90 0.85],midInterval),midInterval+[0.015 0]));
% hLBarNor(4) = rectangle('Position',[0,0,10,nTrial_ori],'LineStyle','none','FaceColor',colorLLightBlue);
% hold on;
% plot(xpt20hz_ori{1},ypt20hz_ori{1},'LineStyle','none','Marker','o','MarkerSize',markerSS,'markerFaceColor','k','markerEdgeColor','none');
% title('20 Hz','fontSize',fontM);
% 
% hLightNormal(5) = axes('Position',axpt(5,4,5,1:4,axpt(nCol,nRow,1,1,[0.1 0.1 0.90 0.85],midInterval),midInterval+[0.015 0]));
% hLBarNor(5) = rectangle('Position',[0,0,10,nTrial_ori],'LineStyle','none','FaceColor',colorLLightBlue);
% hold on;
% plot(xpt50hz_ori{1},ypt50hz_ori{1},'LineStyle','none','Marker','o','MarkerSize',markerSS,'markerFaceColor','k','markerEdgeColor','none');
% % xlabel('Time (ms)','FontSize',fontS);
% title('50 Hz','fontSize',fontM);
% 
% set(hLightNormal,'XLim',winCri_ori,'XTick',[0, 20],'YLim',[0, nTrial_ori],'YTick',[]);
% set(hLightNormal(1),'YTick',[0:100:300]);
% % set(hLightNormal(3),'XTickLabel',[0 20]);
% set(hLightNormal,'Box','off','TickDir','out','fontSize',fontM);
% set(hLightNormal,'TickLength',[0.03, 0.03]);

%% freq dependency
Txls = readtable('neuronList_freq_171127.xlsx');
load('neuronList_freq_171127.mat');
Txls.latencyIndex = categorical(Txls.latencyIndex);
formatOut = 'yymmdd';

alpha = 0.01;
alpha2 = alpha/5;
cSpkpvr = 1.2;

listPN = T.spkpvr > cSpkpvr;
listIN = ~listPN & T.meanFR>9;
listUNC = ~(listPN | listIN);

%% IN all examples
% plot_freqDependency_multi(T.path(listPN),T.cellID(listPN),'D:\Dropbox\SNL\P2_Track\example_plfm_freq_v3\pn');
% plot_freqDependency_multi(T.path(listIN),T.cellID(listIN),'D:\Dropbox\SNL\P2_Track\example_plfm_freq_v3\in');
% plot_freqDependency_multi(T.path(listUNC),T.cellID(listUNC),'D:\Dropbox\SNL\P2_Track\example_plfm_freq_v3\unc');
%%
% lightAct = listPN & (T.idx_light1hz == 1 | T.idx_light2hz == 1 | T.idx_light8hz == 1 | T.idx_light20hz == 1 | T.idx_light50hz == 1);
lightActIN = listIN & (T.idx_light1hz ~= 0 | T.idx_light2hz ~= 0 | T.idx_light8hz ~= 0 | T.idx_light20hz ~= 0 | T.idx_light50hz ~= 0);

lightProb1hzT = T.lightProb1hz(lightActIN);
lightProb2hzT = T.lightProb2hz(lightActIN);
lightProb8hzT = T.lightProb8hz(lightActIN);
lightProb20hzT = T.lightProb20hz(lightActIN);
lightProb50hzT = T.lightProb50hz(lightActIN);
nCellT = sum(double(lightActIN));

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
% a = [lightProb1hzT, lightProb2hzT, lightProb8hzT, lightProb20hzT, lightProb50hzT];
% [p,tbl,stats] = friedman(a,1,'off');
% [~,~,result] = multcompare(stats,'ctype','bonferroni');
% p_KW = result(:,end);
lightProb = [lightProb1hzT, lightProb2hzT, lightProb8hzT, lightProb20hzT, lightProb50hzT];
hPlot = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1,2,[0.1 0.1 0.85 0.85],midInterval),midInterval));
for iCycle = 1:size(lightProb,1)
    plot(lightProb(iCycle,:),'-o','color',colorGray,'markerSize',markerS-1.5,'markerEdgeColor',colorGray,'markerFaceColor',colorLightGray);
    hold on;
end
plot([1,2,3,4,5],[m_1hz_T, m_2hz_T, m_8hz_T, m_20hz_T, m_50hz_T],'o','color',colorBlack,'markerSize',markerS-0.5,'markerEdgeColor',colorBlack,'markerFaceColor',colorBlack);
hold on;
errorbarJun([1,2,3,4,5],[m_1hz_T, m_2hz_T, m_8hz_T, m_20hz_T, m_50hz_T],[sem_1hz_T,sem_2hz_T,sem_8hz_T,sem_20hz_T,sem_50hz_T],0.2, 0.8, colorBlack);
text(1,50,['n = ',num2str(nCellT)],'fontSize',fontM);
ylabel('Spike probability (%)','fontSize',fontM);
xlabel('Frequency (Hz)','fontSize',fontM);

set(hPlot,'TickDir','out','Box','off','TickLength',[0.03,0.03]);
set(hPlot,'XLim',[0,6],'XTick',[1:5],'XTickLabel',{'1';'2';'8';'20';'50'},'fontSize',fontM);
set(hPlot,'YLim',[-1,65]);

%% firing rate
lightFr1hzT = T.freq_light1hz(lightActIN);
lightFr2hzT = T.freq_light2hz(lightActIN);
lightFr8hzT = T.freq_light8hz(lightActIN);
lightFr20hzT = T.freq_light20hz(lightActIN);
lightFr50hzT = T.freq_light50hz(lightActIN);

mFR_1hz_T = mean(lightFr1hzT);
mFR_2hz_T = mean(lightFr2hzT);
mFR_8hz_T = mean(lightFr8hzT);
mFR_20hz_T = mean(lightFr20hzT);
mFR_50hz_T = mean(lightFr50hzT);

semFR_1hz_T = std(lightFr1hzT)/sqrt(nCellT);
semFR_2hz_T = std(lightFr2hzT)/sqrt(nCellT);
semFR_8hz_T = std(lightFr8hzT)/sqrt(nCellT);
semFR_20hz_T = std(lightFr20hzT)/sqrt(nCellT);
semFR_50hz_T = std(lightFr50hzT)/sqrt(nCellT);
a = [lightFr1hzT, lightFr2hzT, lightFr8hzT, lightFr20hzT, lightFr50hzT];
[p,tbl,stats] = friedman(a,1,'off');
lightFrProb = [lightFr1hzT, lightFr2hzT, lightFr8hzT, lightFr20hzT, lightFr50hzT];

hPlot = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1,3,[0.1 0.1 0.85 0.85],midInterval),midInterval));
for iCycle = 1:size(lightFrProb,1)
    plot(lightFrProb(iCycle,:),'-o','color',colorGray,'markerSize',markerS-1.5,'markerEdgeColor',colorGray,'markerFaceColor',colorLightGray);
    hold on;
end
plot([1,2,3,4,5],[mFR_1hz_T, mFR_2hz_T, mFR_8hz_T, mFR_20hz_T, mFR_50hz_T],'o','color',colorBlack,'markerSize',markerS-0.5,'markerEdgeColor',colorBlack,'markerFaceColor',colorBlack);
hold on;
errorbarJun([1,2,3,4,5],[mFR_1hz_T, mFR_2hz_T, mFR_8hz_T, mFR_20hz_T, mFR_50hz_T],[semFR_1hz_T,semFR_2hz_T,semFR_8hz_T,semFR_20hz_T,semFR_50hz_T],0.2, 0.8, colorBlack);
text(1,45,['n = ',num2str(nCellT)],'fontSize',fontM);
ylabel('Mean firing rate (Hz)','fontSize',fontM);
xlabel('Frequency (Hz)','fontSize',fontM);
% title('Total activated neuron','fontSize',fontS);

set(hPlot,'TickDir','out','Box','off','TickLength',[0.03,0.03]);
set(hPlot,'XLim',[0,6],'XTick',[1:5],'XTickLabel',{'1';'2';'8';'20';'50'},'fontSize',fontM);
set(hPlot,'YLim',[-1,60]);

%% population
pop_1hz_act = listIN & (T.idx_light1hz == 1);
pop_1hz_ina = listIN & (T.idx_light1hz == -1);
pop_1hz_no = listIN & (T.idx_light1hz == 0);

pop_2hz_act = listIN & (T.idx_light2hz == 1);
pop_2hz_ina = listIN & (T.idx_light2hz == -1);
pop_2hz_no = listIN & (T.idx_light2hz == 0);

pop_8hz_act = listIN & (T.idx_light8hz == 1);
pop_8hz_ina = listIN & (T.idx_light8hz == -1);
pop_8hz_no = listIN & (T.idx_light8hz == 0);

pop_20hz_act = listIN & (T.idx_light20hz == 1);
pop_20hz_ina = listIN & (T.idx_light20hz == -1);
pop_20hz_no = listIN & (T.idx_light20hz == 0);

pop_50hz_act = listIN & (T.idx_light50hz == 1);
pop_50hz_ina = listIN & (T.idx_light50hz == -1);
pop_50hz_no = listIN & (T.idx_light50hz == 0);

popul_1hz = [sum(double(pop_1hz_act)), sum(double(pop_1hz_ina)), sum(double(pop_1hz_no))];
popul_2hz = [sum(double(pop_2hz_act)), sum(double(pop_2hz_ina)), sum(double(pop_2hz_no))];
popul_8hz = [sum(double(pop_8hz_act)), sum(double(pop_8hz_ina)), sum(double(pop_8hz_no))];
popul_20hz = [sum(double(pop_20hz_act)), sum(double(pop_20hz_ina)), sum(double(pop_20hz_no))];
popul_50hz = [sum(double(pop_50hz_act)), sum(double(pop_50hz_ina)), sum(double(pop_50hz_no))];

pop_total = [popul_1hz; popul_2hz; popul_8hz; popul_20hz; popul_50hz];
pop_total_ratio = pop_total/sum(double(listIN))*100;

hProp = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1,4,[0.1 0.1 0.85 0.85],midInterval),midInterval));
plot([1,2,3,4,5],pop_total_ratio(:,1),'-o','color',colorDarkGray,'markerSize',markerS,'markerEdgeColor',colorDarkGray,'markerFaceColor',colorLightRed);
hold on;
plot([1,2,3,4,5],pop_total_ratio(:,2),'-o','color',colorDarkGray,'markerSize',markerS,'markerEdgeColor',colorDarkGray,'markerFaceColor',colorLightBlue);
% title('Proportion of light responsive neuron','fontSize',fontS);
ylabel('Proportion (%)','fontSize',fontM);
xlabel('Frequency (Hz)','fontSize',fontM);

set(hProp,'TickDir','out','Box','off');
set(hProp,'XLim',[0,6],'XTick',[1:5],'XTickLabel',{'1';'2';'8';'20';'50'},'YTick',[0:10:70],'fontSize',fontM);
set(hProp,'YLim',[-1,70]);
set(hProp,'TickLength',[0.03, 0.03]);

cd(rtDir);
print('-painters','-r300','-dtiff',['f_plosBio_fig2_platform_IN_',datestr(now,formatOut),'_v2.tif']);
% print('-painters','-r300','-depsc',['final_fig2_platform_total_',datestr(now,formatOut),'_v2.ai']);
% close;