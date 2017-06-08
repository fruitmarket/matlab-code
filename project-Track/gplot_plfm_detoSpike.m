% plot [spike number Vs. Stimulation frequency]
%
%
%
%
clearvars;

rtDir = 'D:\Dropbox\SNL\P2_Track';
cd(rtDir);

load('myParameters.mat');
Txls = readtable('neuronList_freq_170601.xlsx');
% Txls.latencyIndex = categorical(Txls.latencyIndex);
load('neuronList_freq_170601.mat');

alpha = 0.01;
alpha2 = alpha/5;
c_latency = 10;
cMeanFR = 9;

light1hz = T.total_mFR<cMeanFR & T.pLR_Plfm1hz < alpha;
light2hz = T.total_mFR<cMeanFR & T.pLR_Plfm2hz < alpha;
light8hz = T.total_mFR<cMeanFR & T.pLR_Plfm8hz < alpha;
light20hz = T.total_mFR<cMeanFR & T.pLR_Plfm20hz < alpha;
light50hz = T.total_mFR<cMeanFR & T.pLR_Plfm50hz < alpha;

nLight1hz = sum(double(light1hz));
nLight2hz = sum(double(light2hz));
nLight8hz = sum(double(light8hz));
nLight20hz = sum(double(light20hz));
nLight50hz = sum(double(light50hz));

evoSpike1hz = T.evoSpk1hz(light1hz,:);
evoSpike2hz = T.evoSpk2hz(light2hz,:);
evoSpike8hz = T.evoSpk8hz(light8hz,:);
evoSpike20hz = T.evoSpk20hz(light20hz,:);
evoSpike50hz = T.evoSpk50hz(light50hz,:);

detoSpike1hz = T.detoSpk1hz(light1hz,:);
detoSpike2hz = T.detoSpk2hz(light2hz,:);
detoSpike8hz = T.detoSpk8hz(light8hz,:);
detoSpike20hz = T.detoSpk20hz(light20hz,:);
detoSpike50hz = T.detoSpk50hz(light50hz,:);

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
plot_freqDependency_v3(T.path(light1hz),'C:\Users\Jun\Desktop\light1hz');
plot_freqDependency_v3(T.path(light2hz),'C:\Users\Jun\Desktop\light2hz');
plot_freqDependency_v3(T.path(light8hz),'C:\Users\Jun\Desktop\light8hz');
plot_freqDependency_v3(T.path(light20hz),'C:\Users\Jun\Desktop\light20hz');
plot_freqDependency_v3(T.path(light50hz),'C:\Users\Jun\Desktop\light50hz');
%%
nCol = 2;
nRow = 6;

xpt = 1:15;
hFigure = figure('PaperUnits','centimeters','PaperPosition',[0 0 21 30]);

hPlot_single(1) = axes('Position',axpt(nCol,nRow,1,1,[0.1 0.1 0.80 0.85],midInterval));
plot(xpt,detoSpike1hz,'-o','color',colorBlack,'markerSize',markerM,'MarkerFaceColor',colorBlack);
hold on;
text(1,70,['1 Hz (n = ',num2str(nLight1hz),')'],'fontSize',fontL);
xlabel('n-th light pulse','fontSize',fontL);
ylabel('Spike fidelity (%)','fontSize',fontL);

hPlot_single(2) = axes('Position',axpt(nCol,nRow,1,2,[0.1 0.1 0.80 0.85],midInterval));
plot(xpt,detoSpike2hz,'-o','color',colorRed,'markerSize',markerM,'MarkerFaceColor',colorRed);
hold on;
text(1,70,['2 Hz (n = ',num2str(nLight2hz),')'],'fontSize',fontL);
xlabel('n-th light pulse','fontSize',fontL);
ylabel('Spike fidelity (%)','fontSize',fontL);

hPlot_single(3) = axes('Position',axpt(nCol,nRow,1,3,[0.1 0.1 0.80 0.85],midInterval));
plot(xpt,detoSpike8hz,'-o','color',colorBlue,'markerSize',markerM,'MarkerFaceColor',colorBlue);
hold on;
text(1,70,['8 Hz (n = ',num2str(nLight8hz),')'],'fontSize',fontL);
xlabel('n-th light pulse','fontSize',fontL);
ylabel('Spike fidelity (%)','fontSize',fontL);

hPlot_single(4) = axes('Position',axpt(nCol,nRow,1,4,[0.1 0.1 0.80 0.85],midInterval));
plot(xpt,detoSpike20hz,'-o','color',colorGreen,'markerSize',markerM,'MarkerFaceColor',colorGreen);
hold on;
text(1,70,['20 Hz (n = ',num2str(nLight20hz),')'],'fontSize',fontL);
xlabel('n-th light pulse','fontSize',fontL);
ylabel('Spike fidelity (%)','fontSize',fontL);

hPlot_single(5) = axes('Position',axpt(nCol,nRow,1,5,[0.1 0.1 0.80 0.85],midInterval));
plot(xpt,detoSpike50hz,'-o','color',colorGray,'markerSize',markerM,'MarkerFaceColor',colorGray);
hold on;
text(1,70,['50 Hz (n = ',num2str(nLight50hz),')'],'fontSize',fontL);
xlabel('n-th light pulse','fontSize',fontL);
ylabel('Spike fidelity (%)','fontSize',fontL);

set(hPlot_single,'TickDir','out','Box','off');
set(hPlot_single,'XLim',[0,16],'XTick',1:15,'fontSize',fontL,'YLim',[0 80],'YTick',0:10:80);


hPlot_mean(1) = axes('Position',axpt(nCol,nRow,2,1,[0.1 0.1 0.80 0.85],midInterval));
plot(xpt,m_detoSpike1hz,'-o','color',colorBlack);
hold on;
errorbarJun(xpt,m_detoSpike1hz,sem_detoSpike1hz,0.2, 0.8,colorBlack);
text(1,50,['1 Hz (n = ',num2str(nLight1hz),')'],'fontSize',fontL);
xlabel('n-th light pulse','fontSize',fontL);
ylabel('Spike fidelity (%)','fontSize',fontL);

hPlot_mean(2) = axes('Position',axpt(nCol,nRow,2,2,[0.1 0.1 0.80 0.85],midInterval));
plot(xpt,m_detoSpike2hz,'-o','color',colorRed);
hold on;
errorbarJun(xpt,m_detoSpike2hz,sem_detoSpike2hz,0.2, 0.8,colorRed);
text(1,50,['2 Hz (n = ',num2str(nLight2hz),')'],'fontSize',fontL);
xlabel('n-th light pulse','fontSize',fontL);
ylabel('Spike fidelity (%)','fontSize',fontL);

hPlot_mean(3) = axes('Position',axpt(nCol,nRow,2,3,[0.1 0.1 0.80 0.85],midInterval));
plot(xpt,m_detoSpike8hz,'-o','color',colorBlue);
hold on;
errorbarJun(xpt,m_detoSpike8hz,sem_detoSpike8hz,0.2, 0.8,colorBlue);
text(1,50,['8 Hz (n = ',num2str(nLight8hz),')'],'fontSize',fontL);
xlabel('n-th light pulse','fontSize',fontL);
ylabel('Spike fidelity (%)','fontSize',fontL);

hPlot_mean(4) = axes('Position',axpt(nCol,nRow,2,4,[0.1 0.1 0.80 0.85],midInterval));
plot(xpt,m_detoSpike20hz,'-o','color',colorGreen);
hold on;
errorbarJun(xpt,m_detoSpike20hz,sem_detoSpike20hz,0.2, 0.8,colorGreen);
text(1,50,['20 Hz (n = ',num2str(nLight20hz),')'],'fontSize',fontL);
xlabel('n-th light pulse','fontSize',fontL);
ylabel('Spike fidelity (%)','fontSize',fontL);

hPlot_mean(5) = axes('Position',axpt(nCol,nRow,2,5,[0.1 0.1 0.80 0.85],midInterval));
plot(xpt,m_detoSpike50hz,'-o','color',colorGray);
hold on;
errorbarJun(xpt,m_detoSpike50hz,sem_detoSpike50hz,0.2, 0.8,colorGray);
text(1,50,['50 Hz (n = ',num2str(nLight50hz),')'],'fontSize',fontL);
xlabel('n-th light pulse','fontSize',fontL);
ylabel('Spike fidelity (%)','fontSize',fontL);

hPlot_mean(6) = axes('Position',axpt(nCol,nRow,2,6,[0.1 0.1 0.80 0.85],midInterval));
plot(xpt,m_detoSpike1hz,'-o','color',colorBlack);
hold on;
plot(xpt,m_detoSpike2hz,'-o','color',colorRed);
hold on;
plot(xpt,m_detoSpike8hz,'-o','color',colorBlue);
hold on;
plot(xpt,m_detoSpike20hz,'-o','color',colorGreen);
hold on;
plot(xpt,m_detoSpike50hz,'-o','color',colorGray);
hold on;

xlabel('n-th light pulse','fontSize',fontL);
ylabel('Spike fidelity (%)','fontSize',fontL);

set(hPlot_mean,'TickDir','out','Box','off');
set(hPlot_mean,'XLim',[0,16],'XTick',1:15,'fontSize',fontL,'YLim',[0 50],'YTick',0:10:50);

formatOut = 'yymmdd';
print('-painters','-r300','-dtiff',['gplot_plfm_freqTest_',datestr(now,formatOut),'.tif']);
% print('-painters','-r300','-depsc',['fig1_frequencyTest_',datestr(now,formatOut),'.ai']);
% close();