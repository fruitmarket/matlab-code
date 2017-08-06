% plot [spike number Vs. Stimulation frequency]
%
%
clearvars;

rtDir = 'D:\Dropbox\SNL\P2_Track';
cd(rtDir);
load('myParameters.mat');
Txls = readtable('neuronList_freq_170616.xlsx');
% Txls.latencyIndex = categorical(Txls.latencyIndex);
load('neuronList_freq_170616.mat');

alpha = 0.01;
alpha2 = alpha/5;
cMeanFR = 9;
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
nCol = 3;
nRow = 2;

color1 = [38, 50, 56]./255;
color2 = [69, 90, 100]./255;
color3 = [96, 125, 139]./255;
color4 = [144, 164, 174]./255;
color5 = [207, 216, 220]./255;

xpt = 1:5;
hFigure = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});

hPlot_mean = axes('Position',axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval));
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

xlabel('n-th light pulse','fontSize',fontL);
ylabel('Spike fidelity (%)','fontSize',fontL);

set(hPlot_mean,'TickDir','out','Box','off');
set(hPlot_mean,'XLim',[0,6],'XTick',1:5,'fontSize',fontL,'YLim',[0 50],'YTick',0:10:50);

formatOut = 'yymmdd';
print('-painters','-r300','-dtiff',[datestr(now,formatOut),'_fig1_freq_DetoTest','.tif']);
print('-painters','-r300','-depsc',[datestr(now,formatOut),'_fig1_freq_DetoTest','.ai']);
close;