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

lightResp = T.spkpvr>cSpkpvr & (T.pLR_Plfm1hz<alpha2 | T.pLR_Plfm2hz<alpha2 | T.pLR_Plfm8hz<alpha2 | T.pLR_Plfm20hz<alpha2 | T.pLR_Plfm50hz<alpha2);
lightDirect = T.spkpvr>cSpkpvr & Txls.latencyIndex == 'direct';
lightIndirect = T.spkpvr>cSpkpvr & Txls.latencyIndex == 'indirect';
nolightCri = T.spkpvr>cSpkpvr & ~(T.pLR_Plfm1hz<alpha2 | T.pLR_Plfm2hz<alpha2 | T.pLR_Plfm8hz<alpha2 | T.pLR_Plfm20hz<alpha2 | T.pLR_Plfm50hz<alpha2);
cellID = T.cellID(lightResp);

% plot_freqDependency_multi(T.path(lightResp),cellID,'C:\Users\Jun\Desktop\freqExample');

lightProb1hz_dr = T.lightProb1hz_dr((lightDirect));
lightProb2hz_dr = T.lightProb2hz_dr((lightDirect));
lightProb8hz_dr = T.lightProb8hz_dr((lightDirect));
lightProb20hz_dr = T.lightProb20hz_dr((lightDirect));
lightProb50hz_dr = T.lightProb50hz_dr((lightDirect));

nCell_dr = sum(double(lightDirect));

nLight_1hz = sum(double(listPN & T.pLR_Plfm1hz<alpha));
nLight_2hz = sum(double(listPN & T.pLR_Plfm2hz<alpha));
nLight_8hz = sum(double(listPN & T.pLR_Plfm8hz<alpha));
nLight_20hz = sum(double(listPN & T.pLR_Plfm20hz<alpha));
nLight_50hz = sum(double(listPN & T.pLR_Plfm50hz<alpha));
nlight_all = sum(double(listPN & (T.pLR_Plfm1hz<alpha & T.pLR_Plfm2hz<alpha & T.pLR_Plfm8hz<alpha & T.pLR_Plfm20hz<alpha & T.pLR_Plfm50hz<alpha)));

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


%% statistics
anova_dr = kruskalwallis([lightProb1hz_dr, lightProb2hz_dr, lightProb8hz_dr, lightProb20hz_dr, lightProb50hz_dr],{'dr1hz','dr2hz','dr8hz','dr20hz','dr50hz'},'off');
anova_idr = kruskalwallis([lightProb1hz_idr, lightProb2hz_idr, lightProb8hz_idr, lightProb20hz_idr, lightProb50hz_idr],{'idr1hz','idr2hz','idr8hz','idr20hz','idr50hz'},'off');
anova_to = kruskalwallis([lightProb1hzT, lightProb2hzT, lightProb8hzT, lightProb20hzT, lightProb50hzT],{'total1hz','total2hz','total8hz','total20hz','total50hz'},'off');

%% Plot
nCol = 2;
nRow = 4;
hHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});

% light response population
hPlot(1) = axes('Position',axpt(3,1,1,1,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),midInterval));
plot([1,2,3,4,5],[lightProb1hz_dr, lightProb2hz_dr, lightProb8hz_dr, lightProb20hz_dr, lightProb50hz_dr],'-o','color',colorDarkGray,'markerSize',markerL,'markerEdgeColor',colorDarkGray,'markerFaceColor',colorLightGray);
hold on;
plot([1,2,3,4,5],[m_1hz_dr, m_2hz_dr, m_8hz_dr, m_20hz_dr, m_50hz_dr],'o','color',colorBlack,'markerSize',markerL,'markerEdgeColor',colorBlack,'markerFaceColor',colorBlack);
hold on;
errorbarJun([1,2,3,4,5],[m_1hz_dr, m_2hz_dr, m_8hz_dr, m_20hz_dr, m_50hz_dr],[sem_1hz_dr,sem_2hz_dr,sem_8hz_dr,sem_20hz_dr,sem_50hz_dr],0.2, 0.8, colorBlack);

text(1,30,['n = ',num2str(nCell_dr)],'fontSize',fontL);
xlabel('Frequency, Hz','fontSize',fontL);
ylabel('Spike fidelity (%)','fontSize',fontL);
title('Directly activated (< 10-ms)','fontSize',fontL);

hPlot(2) = axes('Position',axpt(3,1,2,1,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),midInterval));
plot([1,2,3,4,5],[lightProb1hz_idr, lightProb2hz_idr, lightProb8hz_idr, lightProb20hz_idr, lightProb50hz_idr],'-o','color',colorDarkGray,'markerSize',markerL,'markerEdgeColor',colorDarkGray,'markerFaceColor',colorLightGray);
hold on;
plot([1,2,3,4,5],[m_1hz_idr, m_2hz_idr, m_8hz_idr, m_20hz_idr, m_50hz_idr],'o','color',colorBlack,'markerSize',markerL,'markerEdgeColor',colorBlack,'markerFaceColor',colorBlack);
hold on;
errorbarJun([1,2,3,4,5],[m_1hz_idr, m_2hz_idr, m_8hz_idr, m_20hz_idr, m_50hz_idr],[sem_1hz_idr,sem_2hz_idr,sem_8hz_idr,sem_20hz_idr,sem_50hz_idr],0.2, 0.8, colorBlack);

text(1,30,['n = ',num2str(nCell_idr)],'fontSize',fontL);
xlabel('Frequency, Hz','fontSize',fontL);
ylabel('Spike fidelity (%)','fontSize',fontL);
title('Indirectly activated (> 10-ms)','fontSize',fontL);

hPlot(3) = axes('Position',axpt(3,1,3,1,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),midInterval));
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

%% deto 5 light
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

eBarM = 0.2;
color1 = [38, 50, 56]./255;
color2 = [69, 90, 100]./255;
color3 = [96, 125, 139]./255;
color4 = [144, 164, 174]./255;
color5 = [176, 190, 197]./255;

xpt = 1:5;
hPlot_mean = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1,2,[0.1 0.1 0.85 0.85],midInterval),midInterval));
% 1hz
errorbarJun(xpt,m_detoSpike1hz(1:5),sem_detoSpike1hz(1:5),eBarM,0.4,colorBlack);
hold on;
plot(xpt,m_detoSpike1hz(1:5),'-o','color',color1,'MarkerEdgeColor',colorBlack,'MarkerFaceColor',color1);
hold on;
% 2hz
errorbarJun(xpt,m_detoSpike2hz(1:5),sem_detoSpike2hz(1:5),eBarM,0.4,colorBlack);
hold on;
plot(xpt,m_detoSpike2hz(1:5),'-o','color',color2,'MarkerEdgeColor',colorBlack,'MarkerFaceColor',color2);
hold on;
% 8hz
errorbarJun(xpt,m_detoSpike8hz(1:5),sem_detoSpike8hz(1:5),eBarM,0.4,colorBlack);
hold on;
plot(xpt,m_detoSpike8hz(1:5),'-o','color',color3,'MarkerEdgeColor',colorBlack,'MarkerFaceColor',color3);
hold on;
% 20hz
errorbarJun(xpt,m_detoSpike20hz(1:5),sem_detoSpike20hz(1:5),eBarM,0.4,colorBlack);
hold on;
plot(xpt,m_detoSpike20hz(1:5),'-o','color',color4,'MarkerEdgeColor',colorBlack,'MarkerFaceColor',color4);
hold on;
% 50hz
errorbarJun(xpt,m_detoSpike50hz(1:5),sem_detoSpike50hz(1:5),eBarM,0.4,colorBlack);
hold on;
plot(xpt,m_detoSpike50hz(1:5),'-o','color',color5,'MarkerEdgeColor',colorBlack,'MarkerFaceColor',color5);
hold on;

text(3.5, 40, ['1 Hz (n = ',num2str(nLight1hz),')'],'color',color1,'fontSize',fontL);
text(3.5, 38, ['2 Hz (n = ',num2str(nLight2hz),')'],'color',color2,'fontSize',fontL);
text(3.5, 36, ['8 Hz (n = ',num2str(nLight8hz),')'],'color',color3,'fontSize',fontL);
text(3.5, 34, ['20 Hz (n = ',num2str(nLight20hz),')'],'color',color4,'fontSize',fontL);
text(3.5, 32, ['50 Hz (n = ',num2str(nLight50hz),')'],'color',color5,'fontSize',fontL);


print('-painters','-r300','-dtiff',['final_platform_freqTest',datestr(now,formatOut),'.tif']);
% print('-painters','-r300','-depsc',[datestr(now,formatOut),'_fig1_frequencyTest','.ai']);
close;
