clearvars; clf; close all;

cd('E:\Dropbox\SNL\P2_Track');
load('E:\Dropbox\SNL\P2_Track\myParameters.mat');
formatOut = 'yymmdd';

% load('cscList_ori50hz_181005.mat');
load('cscList_ori50hz_181121.mat');
%%
powerOn = T.m_power_1sec_on;
powerOff = T.m_power_1sec_off;

idxRun = T.taskType == 'DRun';
idxRw = T.taskType == 'DRw';

nRun = sum(double(idxRun));
nRw = sum(double(idxRw));

% extract spectrogram data
run_powerOn = powerOn(idxRun);
run_powerOff = powerOff(idxRun);
rw_powerOn = powerOn(idxRw);
rw_powerOff = powerOff(idxRw);

runPwOn = cat(3,run_powerOn{:});
runPwOff = cat(3,run_powerOff{:});
rwPwOn = cat(3,rw_powerOn{:});
rwPwOff = cat(3,rw_powerOff{:});

% normalized by sum of all blocks
% sum_runPwOn = sum(sum(runPwOn));
% sum_runPwOff = sum(sum(runPwOff));
% sum_rwPwOn = sum(sum(rwPwOn));
% sum_rwPwOff = sum(sum(rwPwOff));
% 
% runPwOn = runPwOn./sum_runPwOn;
% runPwOff = runPwOff./sum_runPwOff;
% rwPwOn = rwPwOn./sum_rwPwOn;
% rwPwOff = rwPwOff./sum_rwPwOff;

m_runPwOn = mean(runPwOn,3);
m_runPwOff = mean(runPwOff,3);
m_rwPwOn = mean(rwPwOn,3);
m_rwPwOff = mean(rwPwOff,3);

sem_runPwOn = std(runPwOn,0,3)/sqrt(nRun);
sem_runPwOff = std(runPwOff,0,3)/sqrt(nRun);
sem_rwPwOn = std(rwPwOn,0,3)/sqrt(nRw);
sem_rwPwOff = std(rwPwOff,0,3)/sqrt(nRw);

%% band
% band path reference
% Guise, K. G., & Shapiro, M. L. (2017). 
% Medial Prefrontal Cortex Reduces Memory Interference by Modifying Hippocampal Encoding. Neuron

bTheta = [4 12];
bSGamma = [30 80];

runPwOn_th = sum(runPwOn(:,3:7,:),2);
runPwOn_ga = sum(runPwOn(:,16:41,:),2);
% runPwOn_th = sum(runPwOn(:,3:7,:),2)./sum(runPwOn(:,:,:),2);
% runPwOn_ga = sum(runPwOn(:,16:41,:),2)./sum(runPwOn(:,:,:),2);
m_runPwOn_th = mean(runPwOn_th,3);
m_runPwOn_ga = mean(runPwOn_ga,3);
sem_runPwOn_th = std(runPwOn_th,0,3)/sqrt(nRun);
sem_runPwOn_ga = std(runPwOn_ga,0,3)/sqrt(nRun);

runPwOff_th = sum(runPwOff(:,3:7,:),2);
runPwOff_ga = sum(runPwOff(:,16:41,:),2);
% runPwOff_th = sum(runPwOff(:,3:7,:),2)./sum(runPwOff(:,:,:),2);
% runPwOff_ga = sum(runPwOff(:,16:41,:),2)./sum(runPwOff(:,:,:),2);
m_runPwOff_th = mean(runPwOff_th,3);
m_runPwOff_ga = mean(runPwOff_ga,3);
sem_runPwOff_th = std(runPwOff_th,0,3)/sqrt(nRun);
sem_runPwOff_ga = std(runPwOff_ga,0,3)/sqrt(nRun);

rwPwOn_th = sum(rwPwOn(:,3:7,:),2);
rwPwOn_ga = sum(rwPwOn(:,16:41,:),2);
% rwPwOn_th = sum(rwPwOn(:,3:7,:),2)./sum(rwPwOn(:,:,:),2);
% rwPwOn_ga = sum(rwPwOn(:,16:41,:),2)./sum(rwPwOn(:,:,:),2);
m_rwPwOn_th = mean(rwPwOn_th,3);
m_rwPwOn_ga = mean(rwPwOn_ga,3);
sem_rwPwOn_th = std(rwPwOn_th,0,3)/sqrt(nRw);
sem_rwPwOn_ga = std(rwPwOn_ga,0,3)/sqrt(nRw);

rwPwOff_th = sum(rwPwOff(:,3:7,:),2);
rwPwOff_ga = sum(rwPwOff(:,16:41,:),2);
% rwPwOff_th = sum(rwPwOff(:,3:7,:),2)./sum(rwPwOff(:,:,:),2);
% rwPwOff_ga = sum(rwPwOff(:,16:41,:),2)./sum(rwPwOff(:,:,:),2);
m_rwPwOff_th = mean(rwPwOff_th,3);
m_rwPwOff_ga = mean(rwPwOff_ga,3);
sem_rwPwOff_th = std(rwPwOff_th,0,3)/sqrt(nRw);
sem_rwPwOff_ga = std(rwPwOff_ga,0,3)/sqrt(nRw);

% statistic
stat_runOnTh = reshape(runPwOn_th,[3,nRun])';
stat_runOnGa = reshape(runPwOn_ga,[3,nRun])';
stat_runOffTh = reshape(runPwOff_th,[3,nRun])';
stat_runOffGa = reshape(runPwOff_ga,[3,nRun])';

[pKW_run(1,1),temp1,stats] = kruskalwallis(stat_runOnTh,[],'off');
    result = multcompare(stats,'ctype','lsd','Display','off');
    pKW_run(2:4,1) = result(:,end);
[pKW_run(1,2),temp2,stats] = kruskalwallis(stat_runOnGa,[],'off');
    result = multcompare(stats,'ctype','lsd','Display','off');
    pKW_run(2:4,2) = result(:,end);
[pKW_run(1,3),temp3,stats] = kruskalwallis(stat_runOffTh,[],'off');
    result = multcompare(stats,'ctype','lsd','Display','off');
    pKW_run(2:4,3) = result(:,end);
[pKW_run(1,4),temp4,stats] = kruskalwallis(stat_runOffGa,[],'off');
    result = multcompare(stats,'ctype','lsd','Display','off');
    pKW_run(2:4,4) = result(:,end);
    
stat_rwOnTh = reshape(rwPwOn_th,[3,nRw])';
stat_rwOnGa = reshape(rwPwOn_ga,[3,nRw])';
stat_rwOffTh = reshape(rwPwOff_th,[3,nRw])';
stat_rwOffGa = reshape(rwPwOff_ga,[3,nRw])';

[pKW_rw(1,1),temp5,stats] = kruskalwallis(stat_rwOnTh,[],'off');
    result = multcompare(stats,'ctype','lsd','Display','off');
    pKW_rw(2:4,1) = result(:,end);
[pKW_rw(1,2),temp6,stats] = kruskalwallis(stat_rwOnGa,[],'off');
    result = multcompare(stats,'ctype','lsd','Display','off');
    pKW_rw(2:4,2) = result(:,end);
[pKW_rw(1,3),temp7,stats] = kruskalwallis(stat_rwOffTh,[],'off');
    result = multcompare(stats,'ctype','lsd','Display','off');
    pKW_rw(2:4,3) = result(:,end);
[pKW_rw(1,4),temp8,stats] = kruskalwallis(stat_rwOffGa,[],'off');
    result = multcompare(stats,'ctype','lsd','Display','off');
    pKW_rw(2:4,4) = result(:,end);
%%
fontM = 8;
nCol = 3;
nRow = 4;

midInterval = [0.07 0.07];
spaceSize = [];
markerS = 1.5;
dotS = 4;
figSize = [0.07 0.07 0.85 0.85];
wideInterval = [0.10 0.10];
tightInterval = [0.05 0.05];
elineW = [0.7, 0.5];
colorBlueGrad = {[13,71,126]/255;
                 [21,101,192]/255;
                 [25,118,210]/255;
                 [30,136,229]/255;
                 [33,150,243]/255;
                 [66,165,245]/255;
                 [100,181,246]/255;
                 [144,202,249]/255;
                 [187,222,251]/255;
                 [227,242,253]/255};

xpt = 1:2:200;
xptError = [xpt,flip(xpt)];
xLim = [1, 150];
yLim = [0 4*10^-4];
% xTick = [0:50:200];
xTick = [0,4,12,30,50,80,100,150];
yTick = 0:10^-4:4*10^-4;

fHandle = figure('PaperUnits','centimeters','paperPosition',paperSize{1});

hPwRun(1) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1,1,figSize,wideInterval),wideInterval));
    patch([xptError],[m_runPwOn(1,:)-sem_runPwOn(1,:),flip(m_runPwOn(1,:)+sem_runPwOn(1,:))],colorLightYellow,'EdgeColor','none');
    hold on;
    plot(xpt,m_runPwOn(1,:),'color',colorYellow,'lineWidth',lineL);
    hold on;
       
    patch([xptError],[m_runPwOn(3,:)-sem_runPwOn(3,:),flip(m_runPwOn(3,:)+sem_runPwOn(3,:))],colorLLightGreen,'EdgeColor','none');
    hold on;
    plot(xpt,m_runPwOn(3,:),'color',colorGreen,'lineWidth',lineL);
    hold on;
    
    patch([xptError],[m_runPwOn(2,:)-sem_runPwOn(2,:),flip(m_runPwOn(2,:)+sem_runPwOn(2,:))],colorLLightBlue,'EdgeColor','none');
    hold on;
    plot(xpt,m_runPwOn(2,:),'color',colorBlue,'lineWidth',lineL);
    hold on;
    
%     for iCycle = 1:4
%         line([10 10]*iCycle,[0,400],'lineStyle',':','lineWidth',lineM,'color',colorBlack);
%         hold on;
%     end
    line([4 4],[0,400],'lineStyle',':','lineWidth',lineM,'color',colorBlack);
    line([12 12],[0,400],'lineStyle',':','lineWidth',lineM,'color',colorBlack);
    line([30 30],[0,400],'lineStyle',':','lineWidth',lineM,'color',colorBlack);
    line([80 80],[0,400],'lineStyle',':','lineWidth',lineM,'color',colorBlack);
    
    text(100,380,'PRE: Yellow','color',colorBlack,'color',colorYellow,'fontSize',fontM);
    text(100,360,'STIM: Blue','color',colorBlack,'color',colorBlue,'fontSize',fontM);
    text(100,340,'POST: Green','color',colorBlack,'color',colorGreen,'fontSize',fontM);
    text(100,320,['n = ',num2str(nRun)],'color',colorBlack,'fontSize',fontM);
    title('Run sessions (light onset align)','fontSize',fontM);
    xlabel('Frequency (Hz)','fontSize',fontM);
    ylabel('Relative power','fontSize',fontM);

hPwRun(2) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1,2,figSize,wideInterval),wideInterval));
    patch([xptError],[m_runPwOff(1,:)-sem_runPwOff(1,:),flip(m_runPwOff(1,:)+sem_runPwOff(1,:))],colorLightYellow,'EdgeColor','none');
    hold on;
    plot(xpt,m_runPwOff(1,:),'color',colorYellow,'lineWidth',lineL);
    hold on;
        
    patch([xptError],[m_runPwOff(3,:)-sem_runPwOff(3,:),flip(m_runPwOff(3,:)+sem_runPwOff(3,:))],colorLLightGreen,'EdgeColor','none');
    hold on;
    plot(xpt,m_runPwOff(3,:),'color',colorGreen,'lineWidth',lineL);
    hold on;
    
    patch([xptError],[m_runPwOff(2,:)-sem_runPwOff(2,:),flip(m_runPwOff(2,:)+sem_runPwOff(2,:))],colorLLightBlue,'EdgeColor','none');
    hold on;
    plot(xpt,m_runPwOff(2,:),'color',colorBlue,'lineWidth',lineL);
    hold on;
    
%     for iCycle = 1:4
%         line([10 10]*iCycle,[0,400],'lineStyle',':','lineWidth',lineM,'color',colorBlack);
%         hold on;
%     end
    line([4 4],[0,400],'lineStyle',':','lineWidth',lineM,'color',colorBlack);
    line([12 12],[0,400],'lineStyle',':','lineWidth',lineM,'color',colorBlack);
    line([30 30],[0,400],'lineStyle',':','lineWidth',lineM,'color',colorBlack);
    line([80 80],[0,400],'lineStyle',':','lineWidth',lineM,'color',colorBlack);
    
    title('Run sessions (light offset align)','fontSize',fontM);
    xlabel('Frequency (Hz)','fontSize',fontM);
    ylabel('Relative power','fontSize',fontM);

set(hPwRun,'Box','off','TickDir','out','XLim',xLim,'XTick',xTick,'YLim',yLim,'YTick',yTick,'fontSize',fontM);
    
hPwRw(1) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,2,1,figSize,wideInterval),wideInterval));
    patch([xptError],[m_rwPwOn(1,:)-sem_rwPwOn(1,:),flip(m_rwPwOn(1,:)+sem_rwPwOn(1,:))],colorLightYellow,'EdgeColor','none');
    hold on;
    plot(xpt,m_rwPwOn(1,:),'color',colorYellow,'lineWidth',lineL);
    hold on;
    
    patch([xptError],[m_rwPwOn(3,:)-sem_rwPwOn(3,:),flip(m_rwPwOn(3,:)+sem_rwPwOn(3,:))],colorLLightGreen,'EdgeColor','none');
    hold on;
    plot(xpt,m_rwPwOn(3,:),'color',colorGreen,'lineWidth',lineL);
    hold on;
    
    patch([xptError],[m_rwPwOn(2,:)-sem_rwPwOn(2,:),flip(m_rwPwOn(2,:)+sem_rwPwOn(2,:))],colorLLightBlue,'EdgeColor','none');
    hold on;
    plot(xpt,m_rwPwOn(2,:),'color',colorBlue,'lineWidth',lineL);
    hold on;
%     for iCycle = 1:4
%         line([10 10]*iCycle,[0,400],'lineStyle',':','lineWidth',lineM,'color',colorBlack);
%         hold on;
%     end
    text(100,320,['n = ',num2str(nRw)],'color',colorBlack,'fontSize',fontM);
    line([4 4],[0,400],'lineStyle',':','lineWidth',lineM,'color',colorBlack);
    line([12 12],[0,400],'lineStyle',':','lineWidth',lineM,'color',colorBlack);
    line([30 30],[0,400],'lineStyle',':','lineWidth',lineM,'color',colorBlack);
    line([80 80],[0,400],'lineStyle',':','lineWidth',lineM,'color',colorBlack);
    
    title('Rw sessions (light onset align)','fontSize',fontM);
    xlabel('Frequency (Hz)','fontSize',fontM);
    ylabel('Relative power','fontSize',fontM);

hPwRw(2) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,2,2,figSize,wideInterval),wideInterval));
    patch([xptError],[m_rwPwOff(1,:)-sem_rwPwOff(1,:),flip(m_rwPwOff(1,:)+sem_rwPwOff(1,:))],colorLightYellow,'EdgeColor','none');
    hold on;
    plot(xpt,m_rwPwOff(1,:),'color',colorYellow,'lineWidth',lineL);
    hold on;
    
    patch([xptError],[m_rwPwOff(3,:)-sem_rwPwOff(3,:),flip(m_rwPwOff(3,:)+sem_rwPwOff(3,:))],colorLLightGreen,'EdgeColor','none');
    hold on;
    plot(xpt,m_rwPwOff(3,:),'color',colorGreen,'lineWidth',lineL);
    hold on;
    
    patch([xptError],[m_rwPwOff(2,:)-sem_rwPwOff(2,:),flip(m_rwPwOff(2,:)+sem_rwPwOff(2,:))],colorLLightBlue,'EdgeColor','none');
    hold on;
    plot(xpt,m_rwPwOff(2,:),'color',colorBlue,'lineWidth',lineL);
    hold on;
    
%     for iCycle = 1:4
%         line([10 10]*iCycle,[0,400],'lineStyle',':','lineWidth',lineM,'color',colorBlack);
%         hold on;
%     end
    line([4 4],[0,400],'lineStyle',':','lineWidth',lineM,'color',colorBlack);
    line([12 12],[0,400],'lineStyle',':','lineWidth',lineM,'color',colorBlack);
    line([30 30],[0,400],'lineStyle',':','lineWidth',lineM,'color',colorBlack);
    line([80 80],[0,400],'lineStyle',':','lineWidth',lineM,'color',colorBlack);
    
    title('Rw sessions (light offset align)','fontSize',fontM);
    xlabel('Frequency (Hz)','fontSize',fontM);
    ylabel('Relative power','fontSize',fontM);
    
set(hPwRw,'Box','off','TickDir','out','XLim',xLim,'XTick',xTick,'YLim',yLim,'YTick',yTick,'fontSize',fontM);

print('-painters','-r300','-dtiff',['f_hippocampus_sup_powerLFP_ver3','.tif']);
print('-painters','-r300','-depsc',['f_hippocampus_sup_powerLFP_ver3','.ai']);

%% bar graph
fHandle = figure('PaperUnits','centimeters','paperPosition',paperSize{1});
nCol = 3;
nRow = 6;
xptBar = 1:3;
barWidth = 0.7;
eLength = 0.9;
elineW = 0.4;
yLimRun = [0 1.5*10^-3];
yLimRw = [0 1.5*10^-3];
xLabel = {'PRE','STIM','POST'};

hPwRun(1) = axes('Position',axpt(2,1,1,1,axpt(nCol,nRow,1,1,figSize,wideInterval),wideInterval));
    bar(xptBar,m_runPwOn_th,barWidth,'faceColor',colorGray);
    hold on;
    errorbarJun(xptBar,m_runPwOn_th,sem_runPwOn_th,elineW,eLength,colorBlack);
    text(0.5, 1650,'Theta','fontSize',fontM)
    title('Run sessions (light onset align)','fontSize',fontM);
    ylabel('Relative power','fontSize',fontM);

hPwRun(2) = axes('Position',axpt(2,1,2,1,axpt(nCol,nRow,1,1,figSize,wideInterval),wideInterval));
    bar(xptBar,m_runPwOn_ga,barWidth,'faceColor',colorGray);
    hold on;
    errorbarJun(xptBar,m_runPwOn_ga,sem_runPwOn_ga,elineW,eLength,colorBlack);
    text(0.5,1650,'Gamma','fontSize',fontM);
    title('Run sessions (light onset align)','fontSize',fontM);
%     ylabel('Norm. relative power','fontSize',fontM);
    
hPwRun(3) = axes('Position',axpt(2,1,1,1,axpt(nCol,nRow,1,2,figSize,wideInterval),wideInterval));
    bar(xptBar,m_runPwOff_th,barWidth,'faceColor',colorGray);
    hold on;
    errorbarJun(xptBar,m_runPwOff_th,sem_runPwOff_th,elineW,eLength,colorBlack);
    text(0.5, 1650,'Theta','fontSize',fontM)
    title('Run sessions (light offset align)','fontSize',fontM);
    ylabel('Relative power','fontSize',fontM);

hPwRun(4) = axes('Position',axpt(2,1,2,1,axpt(nCol,nRow,1,2,figSize,wideInterval),wideInterval));
    bar(xptBar,m_runPwOff_ga,barWidth,'faceColor',colorGray);
    hold on;
    errorbarJun(xptBar,m_runPwOff_ga,sem_runPwOff_ga,elineW,eLength,colorBlack);
    text(0.5,1650,'Gamma','fontSize',fontM);
    title('Run sessions (light offset align)','fontSize',fontM);
%     ylabel('Norm. relative power','fontSize',fontM);

hText = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1,3,figSize,wideInterval),wideInterval));
    text(0,0.5,num2str(pKW_run),'fontSize',fontM);
    set(hText,'visible','off');
    
set(hPwRun,'Box','off','TickDir','out','XLim',[0,4],'XTick',1:3,'XTickLabel',xLabel,'YLim',yLimRun,'fontSize',fontM);
% set(hPwRun(2),'YTickLabel',[]);

hPwRw(1) = axes('Position',axpt(2,1,1,1,axpt(nCol,nRow,2,1,figSize,wideInterval),wideInterval));
    bar(xptBar,m_rwPwOn_th,barWidth,'faceColor',colorGray);
    hold on;
    errorbarJun(xptBar,m_rwPwOn_th,sem_rwPwOn_th,elineW,eLength,colorBlack);
    text(0.5, 1250,'Theta','fontSize',fontM)
    title('Rw sessions (light onset align)','fontSize',fontM);
    ylabel('Relative power','fontSize',fontM);

hPwRw(2) = axes('Position',axpt(2,1,2,1,axpt(nCol,nRow,2,1,figSize,wideInterval),wideInterval));
    bar(xptBar,m_rwPwOn_ga,barWidth,'faceColor',colorGray);
    hold on;
    errorbarJun(xptBar,m_rwPwOn_ga,sem_rwPwOn_ga,elineW,eLength,colorBlack);
    text(0.5,1250,'Gamma','fontSize',fontM);
    title('Rw sessions (light onset align)','fontSize',fontM);
%     ylabel('Norm. relative power','fontSize',fontM);
    
hPwRw(3) = axes('Position',axpt(2,1,1,1,axpt(nCol,nRow,2,2,figSize,wideInterval),wideInterval));
    bar(xptBar,m_rwPwOff_th,barWidth,'faceColor',colorGray);
    hold on;
    errorbarJun(xptBar,m_rwPwOff_th,sem_rwPwOff_th,elineW,eLength,colorBlack);
    text(0.5, 1250,'Theta','fontSize',fontM)
    title('Rw sessions (light offset align)','fontSize',fontM);
    ylabel('Relative power','fontSize',fontM);

hPwRw(4) = axes('Position',axpt(2,1,2,1,axpt(nCol,nRow,2,2,figSize,wideInterval),wideInterval));
    bar(xptBar,m_rwPwOff_ga,barWidth,'faceColor',colorGray);
    hold on;
    errorbarJun(xptBar,m_rwPwOff_ga,sem_rwPwOff_ga,elineW,eLength,colorBlack);
    text(0.5,1250,'Gamma','fontSize',fontM);
    title('Rw sessions (light offset align)','fontSize',fontM);
%     ylabel('Norm. relative power','fontSize',fontM);

hText = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,2,3,figSize,wideInterval),wideInterval));
    text(0,0.5,num2str(pKW_rw),'fontSize',fontM);
    set(hText,'visible','off');
    
set(hPwRw,'Box','off','TickDir','out','XLim',[0,4],'XTick',1:3,'XTickLabel',xLabel,'YLim',yLimRw,'fontSize',fontM);

print('-painters','-r300','-dtiff',['f_hippocampus_sup_powerThetaGamma_prop_ver3','.tif']);
print('-painters','-r300','-depsc',['f_hippocampus_sup_powerThetaGamma_prop_ver3','.ai']);
close all;