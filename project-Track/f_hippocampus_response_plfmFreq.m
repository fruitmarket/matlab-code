clearvars;
cd('E:\Dropbox\SNL\P2_Track');
load('E:\Dropbox\SNL\P2_Track\myParameters.mat');
winCri_ori = [-5, 20];
nTrial_ori = 300;
markerSS = 1;

saveDir = 'E:\Dropbox\SNL\P2_Track';

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
nAct = sum(double(lightAct));

deto1hzT = T.detoProb1hz(lightAct,:);
deto2hzT = T.detoProb2hz(lightAct,:);
deto8hzT = T.detoProb8hz(lightAct,:);
deto20hzT = T.detoProb20hz(lightAct,:);
deto50hzT = T.detoProb50hz(lightAct,:);

m_1hz = mean(deto1hzT,1);
m_2hz = mean(deto2hzT,1);
m_8hz = mean(deto8hzT,1);
m_20hz = mean(deto20hzT,1);
m_50hz = mean(deto50hzT,1);

sem_1hz = std(deto1hzT,0,1)/sqrt(nAct);
sem_2hz = std(deto2hzT,0,1)/sqrt(nAct);
sem_8hz = std(deto8hzT,0,1)/sqrt(nAct);
sem_20hz = std(deto20hzT,0,1)/sqrt(nAct);
sem_50hz = std(deto50hzT,0,1)/sqrt(nAct);

%%
fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});
nCol = 4;
nRow = 6;

xpt = 1:15;

eWidth = 1;
eLength = 0.5;

markerM = 4;
markerS = 2.5;

xLim = [0, 16];
yLim = [-1 50];
yLim50 = [-0.5 80];

hPlot(1) = axes('Position',axpt(2,5,1,1,[],wideInterval));
for iCycle = 1:nAct
    plot(xpt,deto1hzT(iCycle,:),'-o','color',colorGray,'markerSize',markerS,'markerEdgeColor','none','markerFaceColor',colorGray,'lineWidth',lineM);
    hold on; 
end
plot(xpt,m_1hz,'-o','color',colorBlack,'markerSize',markerM,'markerEdgeColor','none','markerFaceColor',colorBlack,'lineWidth',lineM);
errorbarJun(xpt,m_1hz,sem_1hz,eLength,eWidth,colorBlack);
text(11,45,'1 Hz (n = 25)','color',colorBlack,'fontSize',fontM);
xlabel('n-th laser pulse','fontSize',fontM);
ylabel('Spike probability (%)','fontSize',fontM);

hPlot(2) = axes('Position',axpt(2,5,2,1,[],wideInterval));
for iCycle = 1:nAct
    plot(xpt,deto2hzT(iCycle,:),'-o','color',colorGray,'markerSize',markerS,'markerEdgeColor','none','markerFaceColor',colorGray,'lineWidth',lineM);
    hold on; 
end
plot(xpt,m_2hz,'-o','color',colorBlack,'markerSize',markerM,'markerEdgeColor','none','markerFaceColor',colorBlack,'lineWidth',lineM);
errorbarJun(xpt,m_2hz,sem_2hz,eLength,eWidth,colorBlack);
text(13,45,'2 Hz','color',colorBlack,'fontSize',fontM);
xlabel('n-th laser pulse','fontSize',fontM);
ylabel('Spike probability (%)','fontSize',fontM);

hPlot(3) = axes('Position',axpt(2,5,1,2,[],wideInterval));
for iCycle = 1:nAct
    plot(xpt,deto8hzT(iCycle,:),'-o','color',colorGray,'markerSize',markerS,'markerEdgeColor','none','markerFaceColor',colorGray,'lineWidth',lineM);
    hold on; 
end
plot(xpt,m_8hz,'-o','color',colorBlack,'markerSize',markerM,'markerEdgeColor','none','markerFaceColor',colorBlack,'lineWidth',lineM);
errorbarJun(xpt,m_8hz,sem_8hz,eLength,eWidth,colorBlack);
text(13,45,'8 Hz','color',colorBlack,'fontSize',fontM);
xlabel('n-th laser pulse','fontSize',fontM);
ylabel('Spike probability (%)','fontSize',fontM);

hPlot(4) = axes('Position',axpt(2,5,2,2,[],wideInterval));
for iCycle = 1:nAct
    plot(xpt,deto20hzT(iCycle,:),'-o','color',colorGray,'markerSize',markerS,'markerEdgeColor','none','markerFaceColor',colorGray,'lineWidth',lineM);
    hold on; 
end
plot(xpt,m_20hz,'-o','color',colorBlack,'markerSize',markerM,'markerEdgeColor','none','markerFaceColor',colorBlack,'lineWidth',lineM);
errorbarJun(xpt,m_20hz,sem_20hz,eLength,eWidth,colorBlack);
text(13,45,'20 Hz','color',colorBlack,'fontSize',fontM);
xlabel('n-th laser pulse','fontSize',fontM);
ylabel('Spike probability (%)','fontSize',fontM);

hPlot(5) = axes('Position',axpt(2,5,1,3,[],wideInterval));
for iCycle = 1:nAct
    plot(xpt,deto50hzT(iCycle,:),'-o','color',colorGray,'markerSize',markerS,'markerEdgeColor','none','markerFaceColor',colorGray,'lineWidth',lineM);
    hold on; 
end
plot(xpt,m_50hz,'-o','color',colorBlack,'markerSize',markerM,'markerEdgeColor','none','markerFaceColor',colorBlack,'lineWidth',lineM);
errorbarJun(xpt,m_50hz,sem_50hz,eLength,eWidth,colorBlack);
text(13,70,'50 Hz','color',colorBlack,'fontSize',fontM);
xlabel('n-th laser pulse','fontSize',fontM);
ylabel('Spike probability (%)','fontSize',fontM);

set(hPlot,'Box','off','TickDir','out','XLim',xLim,'XTick',[1:15],'YLim',yLim,'YTick',[0:10:50],'fontSize',fontM);
set(hPlot(5),'YLim',yLim50,'YTick',[0:10:80]);

print('-painters','-r300','-dtiff',['f_hippocampus_response_plfmFreq.tif']);
print('-painters','-r300','-depsc',['f_hippocampus_response_plfmFreq.ai']);
close;