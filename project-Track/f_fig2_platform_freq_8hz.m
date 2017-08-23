% Frequency dependency on platform
% the function plot Frequency Vs. spike probability
clearvars;

rtDir = 'D:\Dropbox\SNL\P2_Track';
cd(rtDir);

load('myParameters.mat');
Txls = readtable('neuronList_freq_170821.xlsx');
load('neuronList_freq_170821.mat');
Txls.latencyIndex = categorical(Txls.latencyIndex);
% folder = 'D:\Dropbox\#team_hippocampus Team Folder\project_Track\samples_v9\';
formatOut = 'yymmdd';

alpha = 0.01;
alpha2 = alpha/5;
cSpkpvr = 1.2;

% matFile = T.path(115:end);
% cellID = T.cellID(115:end);
% saveDir = 'C:\Users\Jun\Desktop\plfm_freq';
% plot_freqDependency_multi(matFile,cellID,saveDir);

%% Light responsive population
listPN = T.spkpvr > cSpkpvr;
listIN = ~listPN;

lightCri = T.spkpvr>cSpkpvr & (T.pLR_Plfm1hz<alpha2 | T.pLR_Plfm2hz<alpha2 | T.pLR_Plfm8hz<alpha2 | T.pLR_Plfm20hz<alpha2 | T.pLR_Plfm50hz<alpha2);
lightDirect = T.spkpvr>cSpkpvr & Txls.latencyIndex == 'direct';
lightIndirect = T.spkpvr>cSpkpvr & Txls.latencyIndex == 'indirect';
lightResp = T.spkpvr>cSpkpvr & (Txls.latencyIndex == 'direct' | Txls.latencyIndex == 'indirect');
nolightCri = T.spkpvr>cSpkpvr & ~(T.pLR_Plfm1hz<alpha2 | T.pLR_Plfm2hz<alpha2 | T.pLR_Plfm8hz<alpha2 | T.pLR_Plfm20hz<alpha2 | T.pLR_Plfm50hz<alpha2);
cellID = T.cellID(lightCri);

% plot_freqDependency_v3(T.path(lightCri),'C:\Users\Jun\Desktop\freqTest',cellID);

nLight = sum(double(lightResp));
respPN_peth = cell2mat(T.pethLight(lightResp));
m_respPN_peth = mean(respPN_peth,1);
sem_respPN_peth = std(respPN_peth,0,1)/sqrt(nLight);

nCol = 2;
nRow = 2;
xpt = 0:2:20;
yMaxPN = 30;

fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{2});

hPlotPN(1) = axes('Position',axpt(nCol,nRow,1,1,[0.10 0.10 0.85 0.8],wideInterval));
lightPatch(1) = patch([0 10 10 0],[0 0 yMaxPN yMaxPN],colorLLightBlue);
hold on;
lightPatch(2) = patch([0 10 10 0],[yMaxPN*0.925 yMaxPN*0.925 yMaxPN yMaxPN],colorBlue);
hold on;
hBarPN(1) = bar(xpt,m_respPN_peth,'histc');
errorbarJun(xpt+1,m_respPN_peth,sem_respPN_peth,1,0.4,colorDarkGray);
text(15, yMaxPN*0.8,['n = ',num2str(nLight)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN_activated','fontSize',fontL,'interpreter','none','fontWeight','bold');








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
lightProb1hz_idr = T.lightProb1hz_idr((lightIndirect));
lightProb2hz_idr = T.lightProb2hz_idr((lightIndirect));
lightProb8hz_idr = T.lightProb8hz_idr((lightIndirect));
lightProb20hz_idr = T.lightProb20hz_idr((lightIndirect));
lightProb50hz_idr = T.lightProb50hz_idr((lightIndirect));

nCell_idr = sum(double(lightIndirect));

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

%% light prob of (short and long)
lightProb1hzT = [lightProb1hz_dr; lightProb1hz_idr];
lightProb2hzT = [lightProb2hz_dr; lightProb2hz_idr];
lightProb8hzT = [lightProb8hz_dr; lightProb8hz_idr];
lightProb20hzT = [lightProb20hz_dr; lightProb20hz_idr];
lightProb50hzT = [lightProb50hz_dr; lightProb50hz_idr];
nCellT = length([lightProb1hz_dr; lightProb1hz_idr]);

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

%% Plot
nCol = 3;
nRow = 3;

hHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});
% light response population
hPlot(1) = axes('Position',axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval));
plot([1,2,3,4,5],[lightProb1hz_dr, lightProb2hz_dr, lightProb8hz_dr, lightProb20hz_dr, lightProb50hz_dr],'-o','color',colorDarkGray,'markerSize',markerL,'markerEdgeColor',colorDarkGray,'markerFaceColor',colorLightGray);
hold on;
plot([1,2,3,4,5],[m_1hz_dr, m_2hz_dr, m_8hz_dr, m_20hz_dr, m_50hz_dr],'o','color',colorBlack,'markerSize',markerL,'markerEdgeColor',colorBlack,'markerFaceColor',colorBlack);
hold on;
errorbarJun([1,2,3,4,5],[m_1hz_dr, m_2hz_dr, m_8hz_dr, m_20hz_dr, m_50hz_dr],[sem_1hz_dr,sem_2hz_dr,sem_8hz_dr,sem_20hz_dr,sem_50hz_dr],0.2, 0.8, colorBlack);

text(1,30,['n = ',num2str(nCell_dr)],'fontSize',fontL);
xlabel('Frequency, Hz','fontSize',fontL);
ylabel('Spike fidelity (%)','fontSize',fontL);
title('Directly activated (< 10-ms)','fontSize',fontL);

hPlot(2) = axes('Position',axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],wideInterval));
plot([1,2,3,4,5],[lightProb1hz_idr, lightProb2hz_idr, lightProb8hz_idr, lightProb20hz_idr, lightProb50hz_idr],'-o','color',colorDarkGray,'markerSize',markerL,'markerEdgeColor',colorDarkGray,'markerFaceColor',colorLightGray);
hold on;
plot([1,2,3,4,5],[m_1hz_idr, m_2hz_idr, m_8hz_idr, m_20hz_idr, m_50hz_idr],'o','color',colorBlack,'markerSize',markerL,'markerEdgeColor',colorBlack,'markerFaceColor',colorBlack);
hold on;
errorbarJun([1,2,3,4,5],[m_1hz_idr, m_2hz_idr, m_8hz_idr, m_20hz_idr, m_50hz_idr],[sem_1hz_idr,sem_2hz_idr,sem_8hz_idr,sem_20hz_idr,sem_50hz_idr],0.2, 0.8, colorBlack);

text(1,30,['n = ',num2str(nCell_idr)],'fontSize',fontL);
xlabel('Frequency, Hz','fontSize',fontL);
ylabel('Spike fidelity (%)','fontSize',fontL);
title('Indirectly activated (> 10-ms)','fontSize',fontL);

hPlot(3) = axes('Position',axpt(nCol,nRow,3,1,[0.1 0.1 0.85 0.85],wideInterval));
plot([1,2,3,4,5],[lightProb1hzT, lightProb2hzT, lightProb8hzT, lightProb20hzT, lightProb50hzT],'-o','color',colorDarkGray,'markerSize',markerL,'markerEdgeColor',colorDarkGray,'markerFaceColor',colorLightGray);
hold on;
plot([1,2,3,4,5],[m_1hz_T, m_2hz_T, m_8hz_T, m_20hz_T, m_50hz_T],'o','color',colorBlack,'markerSize',markerL,'markerEdgeColor',colorBlack,'markerFaceColor',colorBlack);
hold on;
errorbarJun([1,2,3,4,5],[m_1hz_T, m_2hz_T, m_8hz_T, m_20hz_T, m_50hz_T],[sem_1hz_T,sem_2hz_T,sem_8hz_T,sem_20hz_T,sem_50hz_T],0.2, 0.8, colorBlack);
text(1,30,['n = ',num2str(nCellT)],'fontSize',fontL);
xlabel('Frequency, Hz','fontSize',fontL);
ylabel('Spike fidelity (%)','fontSize',fontL);
title('Total neuron','fontSize',fontL);

set(hPlot,'TickDir','out','Box','off');
set(hPlot,'XLim',[0,6],'XTick',[1:5],'XTickLabel',{'1';'2';'8';'20';'50'},'fontSize',fontL);
set(hPlot,'YLim',[-1,35]);

print('-painters','-r300','-dtiff',['final_platform_freqTest',datestr(now,formatOut),'.tif']);
% print('-painters','-r300','-depsc',[datestr(now,formatOut),'_fig1_frequencyTest','.ai']);
close;

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