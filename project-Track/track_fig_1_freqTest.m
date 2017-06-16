% Frequency dependency on platform
% the function plot Frequency Vs. spike probability
%
clearvars;

rtDir = 'D:\Dropbox\SNL\P2_Track';
cd(rtDir);

load('myParameters.mat');
Txls = readtable('neuronList_freq_170613.xlsx');
load('neuronList_freq_170613.mat');
Txls.latencyIndex = categorical(Txls.latencyIndex);

% folder = 'D:\Dropbox\#team_hippocampus Team Folder\project_Track\samples_v9\';

alpha = 0.01;
alpha2 = alpha/5;
cSpkpvr = 1.2;
%% Light responsive population
lightCri = T.spkpvr>cSpkpvr & (T.pLR_Plfm1hz<alpha2 | T.pLR_Plfm2hz<alpha2 | T.pLR_Plfm8hz<alpha2 | T.pLR_Plfm20hz<alpha2 | T.pLR_Plfm50hz<alpha2);
lightShort = T.spkpvr>cSpkpvr & Txls.latencyIndex == 'rapid';
lightLong = T.spkpvr>cSpkpvr & Txls.latencyIndex == 'delay';
nolightCri = T.spkpvr>cSpkpvr & ~(T.pLR_Plfm1hz<alpha2 | T.pLR_Plfm2hz<alpha2 | T.pLR_Plfm8hz<alpha2 | T.pLR_Plfm20hz<alpha2 | T.pLR_Plfm50hz<alpha2);
cellID = T.cellID(lightCri);

% plot_freqDependency_v3(T.path(lightCri),'C:\Users\Jun\Desktop\freqTest',cellID);

lightProb1hz_dr = T.lightProb1hz_dr((lightShort));
lightProb2hz_dr = T.lightProb2hz_dr((lightShort));
lightProb8hz_dr = T.lightProb8hz_dr((lightShort));
lightProb20hz_dr = T.lightProb20hz_dr((lightShort));
lightProb50hz_dr = T.lightProb50hz_dr((lightShort));

nCell_dr = sum(double(lightShort));

nLight_1hz = sum(double(T.spkpvr>cSpkpvr & T.pLR_Plfm1hz<alpha));
nLight_2hz = sum(double(T.spkpvr>cSpkpvr & T.pLR_Plfm2hz<alpha));
nLight_8hz = sum(double(T.spkpvr>cSpkpvr & T.pLR_Plfm8hz<alpha));
nLight_20hz = sum(double(T.spkpvr>cSpkpvr & T.pLR_Plfm20hz<alpha));
nLight_50hz = sum(double(T.spkpvr>cSpkpvr & T.pLR_Plfm50hz<alpha));
nlight_all = sum(double(T.spkpvr>cSpkpvr & (T.pLR_Plfm1hz<alpha & T.pLR_Plfm2hz<alpha & T.pLR_Plfm8hz<alpha & T.pLR_Plfm20hz<alpha & T.pLR_Plfm50hz<alpha)));

m_1hz_dr = mean(lightProb1hz_dr);
m_2hz_dr = mean(lightProb2hz_dr);
m_8hz_dr = mean(lightProb8hz_dr);
m_20hz_dr = mean(lightProb20hz_dr);
m_50hz_dr = mean(lightProb50hz_dr);

sem_1hz_dr = std(lightProb1hz_dr)/sqrt(nCell_dr);
sem_2hz_dr = std(lightProb2hz_dr)/sqrt(nCell_dr);
sem_8hz_dr = std(lightProb8hz_dr)/sqrt(nCell_dr);
sem_20hz_dr = std(lightProb20hz_dr)/sqrt(nCell_dr);
sem_50hz_dr = std(lightProb50hz_dr)/sqrt(nCell_dr);

%% Indirect response
lightProb1hz_idr = T.lightProb1hz_idr((lightLong));
lightProb2hz_idr = T.lightProb2hz_idr((lightLong));
lightProb8hz_idr = T.lightProb8hz_idr((lightLong));
lightProb20hz_idr = T.lightProb20hz_idr((lightLong));
lightProb50hz_idr = T.lightProb50hz_idr((lightLong));

nCell_idr = sum(double(lightLong));

nLight_1hz = sum(double(T.spkpvr>cSpkpvr & T.pLR_Plfm1hz<alpha));
nLight_2hz = sum(double(T.spkpvr>cSpkpvr & T.pLR_Plfm2hz<alpha));
nLight_8hz = sum(double(T.spkpvr>cSpkpvr & T.pLR_Plfm8hz<alpha));
nLight_20hz = sum(double(T.spkpvr>cSpkpvr & T.pLR_Plfm20hz<alpha));
nLight_50hz = sum(double(T.spkpvr>cSpkpvr & T.pLR_Plfm50hz<alpha));
nlight_all = sum(double(T.spkpvr>cSpkpvr & (T.pLR_Plfm1hz<alpha & T.pLR_Plfm2hz<alpha & T.pLR_Plfm8hz<alpha & T.pLR_Plfm20hz<alpha & T.pLR_Plfm50hz<alpha)));

m_1hz_idr = mean(lightProb1hz_idr);
m_2hz_idr = mean(lightProb2hz_idr);
m_8hz_idr = mean(lightProb8hz_idr);
m_20hz_idr = mean(lightProb20hz_idr);
m_50hz_idr = mean(lightProb50hz_idr);

sem_1hz_idr = std(lightProb1hz_idr)/sqrt(nCell_idr);
sem_2hz_idr = std(lightProb2hz_idr)/sqrt(nCell_idr);
sem_8hz_idr = std(lightProb8hz_idr)/sqrt(nCell_idr);
sem_20hz_idr = std(lightProb20hz_idr)/sqrt(nCell_idr);
sem_50hz_idr = std(lightProb50hz_idr)/sqrt(nCell_idr);

%% No light responsive population
nolightProb1hz = T.lightProb1hz_dr(nolightCri);
nolightProb2hz = T.lightProb2hz_dr(nolightCri);
nolightProb8hz = T.lightProb8hz_dr(nolightCri);
nolightProb20hz = T.lightProb20hz_dr(nolightCri);
nolightProb50hz = T.lightProb50hz_dr(nolightCri);

nNoLCell = length(nolightProb1hz);

m_no_1hz = mean(nolightProb1hz);
m_no_2hz = mean(nolightProb2hz);
m_no_8hz = mean(nolightProb8hz);
m_no_20hz = mean(nolightProb20hz);
m_no_50hz = mean(nolightProb50hz);

sem_no_1hz = std(nolightProb1hz)/sqrt(nNoLCell);
sem_no_2hz = std(nolightProb2hz)/sqrt(nNoLCell);
sem_no_8hz = std(nolightProb8hz)/sqrt(nNoLCell);
sem_no_20hz = std(nolightProb20hz)/sqrt(nNoLCell);
sem_no_50hz = std(nolightProb50hz)/sqrt(nNoLCell);

%% Plot
nCol = 2;
nRow = 1;

hHandle = figure('PaperUnits','centimeters','PaperPosition',[0 0 12 6]*2);
% light response population
hPlot(1) = axes('Position',axpt(nCol,nRow,1,1,[0.1 0.1 0.80 0.85],wideInterval));
plot([1,2,3,4,5],[lightProb1hz_dr, lightProb2hz_dr, lightProb8hz_dr, lightProb20hz_dr, lightProb50hz_dr],'-o','color',colorDarkGray,'markerSize',markerL,'markerEdgeColor',colorDarkGray,'markerFaceColor',colorLightGray);
hold on;
plot([1,2,3,4,5],[m_1hz_dr, m_2hz_dr, m_8hz_dr, m_20hz_dr, m_50hz_dr],'o','color',colorBlack,'markerSize',markerL,'markerEdgeColor',colorBlack,'markerFaceColor',colorBlack);
hold on;
errorbarJun([1,2,3,4,5],[m_1hz_dr, m_2hz_dr, m_8hz_dr, m_20hz_dr, m_50hz_dr],[sem_1hz_dr,sem_2hz_dr,sem_8hz_dr,sem_20hz_dr,sem_50hz_dr],0.2, 0.8, colorBlack);

text(1,40,['n = ',num2str(nCell_dr)],'fontSize',fontL);
xlabel('Frequency, Hz','fontSize',fontL);
ylabel('Spike fidelity (%)','fontSize',fontL);
title('Short latency','fontSize',fontL);

hPlot(2) = axes('Position',axpt(nCol,nRow,2,1,[0.1 0.1 0.80 0.85],wideInterval));
plot([1,2,3,4,5],[lightProb1hz_idr, lightProb2hz_idr, lightProb8hz_idr, lightProb20hz_idr, lightProb50hz_idr],'-o','color',colorDarkGray,'markerSize',markerL,'markerEdgeColor',colorDarkGray,'markerFaceColor',colorLightGray);
hold on;
plot([1,2,3,4,5],[m_1hz_idr, m_2hz_idr, m_8hz_idr, m_20hz_idr, m_50hz_idr],'o','color',colorBlack,'markerSize',markerL,'markerEdgeColor',colorBlack,'markerFaceColor',colorBlack);
hold on;
errorbarJun([1,2,3,4,5],[m_1hz_idr, m_2hz_idr, m_8hz_idr, m_20hz_idr, m_50hz_idr],[sem_1hz_idr,sem_2hz_idr,sem_8hz_idr,sem_20hz_idr,sem_50hz_idr],0.2, 0.8, colorBlack);

text(1,40,['n = ',num2str(nCell_idr)],'fontSize',fontL);
xlabel('Frequency, Hz','fontSize',fontL);
ylabel('Spike fidelity (%)','fontSize',fontL);
title('Long latency','fontSize',fontL);

set(hPlot,'TickDir','out','Box','off');
set(hPlot,'XLim',[0,6],'XTick',[1:5],'XTickLabel',{'1';'2';'8';'20';'50'},'fontSize',fontL);
set(hPlot,'YLim',[-1,50]);

formatOut = 'yymmdd';
print('-painters','-r300','-dtiff',[datestr(now,formatOut),'_fig1_frequencyTest','.tif']);
% print('-painters','-r300','-depsc',['fig1_frequencyTest_',datestr(now,formatOut),'.ai']);
% close();

%%
% hPlot(1) = axes('Position',axpt(nCol,nRow,1:2,1:2,[0.1 0.1 0.85 0.85],wideInterval));
% plot([1,2,3,4,5],[lightProb1hz, lightProb2hz, lightProb8hz, lightProb20hz, lightProb50hz],'-o','color',colorDarkGray,'markerSize',markerM,'markerEdgeColor',colorDarkGray,'markerFaceColor',colorLightGray);
% hold on;
% plot([1,2,3,4,5],[m_1hz, m_2hz, m_8hz, m_20hz, m_50hz],'o','color',colorBlack,'markerSize',markerM,'markerEdgeColor',colorBlack,'markerFaceColor',colorBlack);
% hold on;
% errorbar([1,2,3,4,5],[m_1hz, m_2hz, m_8hz, m_20hz, m_50hz],[sem_1hz,sem_2hz,sem_8hz,sem_20hz,sem_50hz],'o','color',colorBlack,'markerSize',markerM);
% 
% text(1,60,['n = ',num2str(nCell)],'fontSize',fontM);
% xlabel('Frequency, Hz','fontSize',fontM);
% ylabel('Spike P, %','fontSize',fontM);
% 
% hPlot(2) = axes('Position',axpt(nCol,nRow,3:4,1:2,[0.1 0.1 0.85 0.85],wideInterval));
% plot([1,2,3,4,5],[nLight_1hz, nLight_2hz, nLight_8hz, nLight_20hz, nLight_50hz],'-o','color',colorBlack,'MarkerFaceColor',colorBlack,'MarkerSize',markerM);
% xlabel('Frequency, Hz','fontSize',fontM);
% ylabel('Number of light responsive neurons, n','fontSize',fontM);
% 
% % no light response
% hPlot(3) = axes('Position',axpt(nCol,nRow,1:2,3:4,[0.1 0.1 0.85 0.85],wideInterval));
% plot([1,2,3,4,5],[nolightProb1hz, nolightProb2hz, nolightProb8hz, nolightProb20hz, nolightProb50hz],'o','color',colorGray,'markerSize',markerM,'markerEdgeColor',colorDarkGray,'markerFaceColor',colorGray);
% hold on;
% plot([1,2,3,4,5],[m_no_1hz, m_no_2hz, m_no_8hz, m_no_20hz, m_no_50hz],'o','color',colorBlack,'markerSize',markerM,'markerEdgeColor',colorBlack,'markerFaceColor',colorBlack);
% hold on;
% errorbar([1,2,3,4,5],[m_no_1hz, m_no_2hz, m_no_8hz, m_no_20hz, m_no_50hz],[sem_no_1hz,sem_no_2hz,sem_no_8hz,sem_no_20hz,sem_no_50hz],'o','color',colorBlack,'markerSize',markerM);
% 
% text(1,60,['n = ',num2str(nNoLCell)],'fontSize',fontM);
% xlabel('Frequency, Hz','fontSize',fontM);
% ylabel('Spike P, %','fontSize',fontM);
% 
% set(hPlot,'TickDir','out','Box','off');
% set(hPlot,'XLim',[0,6],'XTick',[1:5],'XTickLabel',{'1';'2';'8';'20';'50'},'fontSize',fontM);
% set(hPlot(1),'YLim',[-1,70]);
% set(hPlot(2),'YLim',[1,15],'YTick',[5:2:15]);
% set(hPlot(3),'YLim',[-1,70]);
%% Example file classification
% path1hz = T.path(T.pLR_Plfm1hz < alpha);
% path2hz = T.path(T.pLR_Plfm2hz < alpha);
% path8hz = T.path(T.pLR_Plfm8hz < alpha);
% path20hz = T.path(T.pLR_Plfm20hz < alpha);
% path50hz = T.path(T.pLR_Plfm50hz < alpha);
% 
% dir1hz = 'D:\Dropbox\SNL\P2_Track\analysis_freq\1hz';
% dir2hz = 'D:\Dropbox\SNL\P2_Track\analysis_freq\2hz';
% dir8hz = 'D:\Dropbox\SNL\P2_Track\analysis_freq\8hz';
% dir20hz = 'D:\Dropbox\SNL\P2_Track\analysis_freq\20hz';
% dir50hz = 'D:\Dropbox\SNL\P2_Track\analysis_freq\50hz';
% 
% cellID1hz = T.cellID(T.pLR_Plfm1hz < alpha);
% cellID2hz = T.cellID(T.pLR_Plfm2hz < alpha);
% cellID8hz = T.cellID(T.pLR_Plfm8hz < alpha);
% cellID20hz = T.cellID(T.pLR_Plfm20hz < alpha);
% cellID50hz = T.cellID(T.pLR_Plfm50hz < alpha);
% 
% plot_freqDependency_v3(path1hz,dir1hz,cellID1hz);
% plot_freqDependency_v3(path2hz,dir2hz,cellID2hz);
% plot_freqDependency_v3(path8hz,dir8hz,cellID8hz);
% plot_freqDependency_v3(path20hz,dir20hz,cellID20hz);
% plot_freqDependency_v3(path50hz,dir50hz,cellID50hz);
% 
% close('all');
% cd(rtDir);