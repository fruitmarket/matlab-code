clearvars; clf; close all;

cd('E:\Dropbox\SNL\P2_Track');
load('E:\Dropbox\SNL\P2_Track\myParameters.mat');
formatOut = 'yymmdd';

markerS = 1.5;
dotS = 4;

load('cscList_ori50hz_181005.mat');

Fs = 2000; % frequency: 2kHz0
win1 = [-3, 3];
winCscOn = win1*Fs; % sec * Fs = samples
xptTimeOn = winCscOn(1):winCscOn(2);

%%
specOn = T.m_coef_on;
specOff = T.m_coef_off;

idxRun = T.taskType == 'DRun';
idxRw = T.taskType == 'DRw';

nRun = sum(double(idxRun));
nRw = sum(double(idxRw));

% extract spectrogram data
run_specOn = specOn(idxRun);
run_specOff = specOff(idxRun);
rw_specOn = specOn(idxRw);
rw_specOff = specOff(idxRw);

%
run_specOn_PRE = cellfun(@(x) x{1}, run_specOn,'UniformOutput',0);
run_specOn_STIM = cellfun(@(x) x{2}, run_specOn,'UniformOutput',0);
run_specOn_POST = cellfun(@(x) x{3}, run_specOn,'UniformOutput',0);

run_specOff_PRE = cellfun(@(x) x{1}, run_specOff,'UniformOutput',0);
run_specOff_STIM = cellfun(@(x) x{2}, run_specOff,'UniformOutput',0);
run_specOff_POST = cellfun(@(x) x{3}, run_specOff,'UniformOutput',0);

rw_specOn_PRE = cellfun(@(x) x{1}, rw_specOn,'UniformOutput',0);
rw_specOn_STIM = cellfun(@(x) x{2}, rw_specOn,'UniformOutput',0);
rw_specOn_POST = cellfun(@(x) x{3}, rw_specOn,'UniformOutput',0);

rw_specOff_PRE = cellfun(@(x) x{1}, rw_specOff,'UniformOutput',0);
rw_specOff_STIM = cellfun(@(x) x{2}, rw_specOff,'UniformOutput',0);
rw_specOff_POST = cellfun(@(x) x{3}, rw_specOff,'UniformOutput',0);

% get averaged spectrogram
[m_run_specOn, m_run_specOff, m_rw_specOn, m_rw_specOff] = deal(cell(3,1));

m_run_specOn{1} = mean(cat(3,run_specOn_PRE{:}),3);
m_run_specOn{2} = mean(cat(3,run_specOn_STIM{:}),3);
m_run_specOn{3} = mean(cat(3,run_specOn_POST{:}),3);

m_run_specOff{1} = mean(cat(3,run_specOff_PRE{:}),3);
m_run_specOff{2} = mean(cat(3,run_specOff_STIM{:}),3);
m_run_specOff{3} = mean(cat(3,run_specOff_POST{:}),3);

m_rw_specOn{1} = mean(cat(3,rw_specOn_PRE{:}),3);
m_rw_specOn{2} = mean(cat(3,rw_specOn_STIM{:}),3);
m_rw_specOn{3} = mean(cat(3,rw_specOn_POST{:}),3);

m_rw_specOff{1} = mean(cat(3,rw_specOff_PRE{:}),3);
m_rw_specOff{2} = mean(cat(3,rw_specOff_STIM{:}),3);
m_rw_specOff{3} = mean(cat(3,rw_specOff_POST{:}),3);

%%

% wideInterval = [0.07 0.13];
tightInterval = [0.05 0.05];
lineW = [0.7, 0.5];
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

fontM = 9;
nCol = 2;
nRow = 4;
figSize = [0.1 0.1 0.85 0.85];
figSizeIn = [0.05 0.1 0.85 0.85];
midInterval = [0.05 0.07];
spaceSize = [];
xLimOn = [-2.5 1];
xLimOff = [-1,2.5];
yLim = [0 150];

xpt = -5999:6000;
ypt = 1:2:200;
xTickOn = -4000:2000:2000;
xLabelOn = -2:1;
xTickOff = -2000:2000:4000;
xLabelOff = -1:2;

fHandle = figure('PaperUnits','centimeters','paperPosition',paperSize{1});

hSpecRunOn(1) = axes('Position',axpt(2,1,1,1,axpt(nCol,nRow,1,1,figSize,wideInterval),wideInterval));
    hMapRun(1) = pcolor(xpt,ypt,m_run_specOn{1});
    for iCycle = 1:4
        line(xLimOn*Fs,[10 10]*iCycle,'lineStyle',':','lineWidth',lineM,'color',colorBlack);
        hold on;
    end
    text(-4500, 130, 'Laser on align (PRE)','fontSize',fontM);
    xlabel('Time (s)','fontSize',fontM);
    ylabel('Frequency (Hz)','fontSize',fontM);

hSpecRunOn(2) = axes('Position',axpt(2,1,1,1,axpt(nCol,nRow,1,2,figSize,wideInterval),wideInterval));
    hMapRun(3) = pcolor(xpt,ypt,m_run_specOn{2});
    for iCycle = 1:4
        line(xLimOn*Fs,[10 10]*iCycle,'lineStyle',':','lineWidth',lineM,'color',colorBlack);
        hold on;
    end
    line([0 0],yLim,'lineStyle',':','lineWidth',lineM,'color',colorRed);
    text(-4500, 130, 'Laser on align (STIM)','fontSize',fontM);
    ylabel('Frequency (Hz)','fontSize',fontM);
    xlabel('Time (s)','fontSize',fontM);

hSpecRunOn(3) = axes('Position',axpt(2,1,1,1,axpt(nCol,nRow,1,3,figSize,wideInterval),wideInterval));
    hMapRun(5) = pcolor(xpt,ypt,m_run_specOn{3});
    for iCycle = 1:4
        line(xLimOn*Fs,[10 10]*iCycle,'lineStyle',':','lineWidth',lineM,'color',colorBlack);
        hold on;
    end
    text(-4500, 130, 'Laser on align (POST)','fontSize',fontM);
    xlabel('Time (s)','fontSize',fontM);
    ylabel('Frequency (Hz)','fontSize',fontM);

hSpecRunOff(1) = axes('Position',axpt(2,1,2,1,axpt(nCol,nRow,1,1,figSize,wideInterval),wideInterval));
    hMapRun(2) = pcolor(xpt,ypt,m_run_specOff{1});
    for iCycle = 1:4
        line(xLimOff*Fs,[10 10]*iCycle,'lineStyle',':','lineWidth',lineM,'color',colorBlack);
        hold on;
    end
    text(-1500, 130, 'Laser off align (PRE)','fontSize',fontM);
    xlabel('Time (s)','fontSize',fontM);
    
hSpecRunOff(2) = axes('Position',axpt(2,1,2,1,axpt(nCol,nRow,1,2,figSize,wideInterval),wideInterval));
    hMapRun(4) = pcolor(xpt,ypt,m_run_specOff{2});
    for iCycle = 1:4
        line(xLimOff*Fs,[10 10]*iCycle,'lineStyle',':','lineWidth',lineM,'color',colorBlack);
        hold on;
    end
    line([0 0],yLim,'lineStyle',':','lineWidth',lineM,'color',colorRed);
    text(-1500, 130, 'Laser off align (STIM)','fontSize',fontM);
    xlabel('Time (s)','fontSize',fontM);

hSpecRunOff(3) = axes('Position',axpt(2,1,2,1,axpt(nCol,nRow,1,3,figSize,wideInterval),wideInterval));
    hMapRun(6) = pcolor(xpt,ypt,m_run_specOff{3});
    for iCycle = 1:4
        line(xLimOff*Fs,[10 10]*iCycle,'lineStyle',':','lineWidth',lineM,'color',colorBlack);
        hold on;
    end
    text(-1500, 130, 'Laser off align (POST)','fontSize',fontM);
    xlabel('Time (s)','fontSize',fontM);

set(hMapRun,'EdgeColor','none');
set(hSpecRunOn,'Box','off','TickDir','out','XLim',xLimOn*Fs,'XTick',xTickOn,'XTickLabel',xLabelOn,'YLim',yLim,'YTick',[0:50:200]);
set(hSpecRunOff,'Box','off','TickDir','out','XLim',xLimOff*Fs,'XTick',xTickOff,'XTickLabel',xLabelOff,'YLim',yLim,'YTick',[0:50:200],'YTickLabel',[]);

% Rw sessions
hSpecRwOn(1) = axes('Position',axpt(2,1,1,1,axpt(nCol,nRow,2,1,figSize,wideInterval),wideInterval));
    hMapRw(1) = pcolor(xpt,ypt,m_rw_specOn{1});
    for iCycle = 1:4
        line(xLimOn*Fs,[10 10]*iCycle,'lineStyle',':','lineWidth',lineM,'color',colorBlack);
        hold on;
    end
    text(-4500, 130, 'Laser on align (PRE)','fontSize',fontM);
    xlabel('Time (s)','fontSize',fontM);
    ylabel('Frequency (Hz)','fontSize',fontM);

hSpecRwOn(2) = axes('Position',axpt(2,1,1,1,axpt(nCol,nRow,2,2,figSize,wideInterval),wideInterval));
    hMapRw(3) = pcolor(xpt,ypt,m_rw_specOn{2});
    for iCycle = 1:4
        line(xLimOn*Fs,[10 10]*iCycle,'lineStyle',':','lineWidth',lineM,'color',colorBlack);
        hold on;
    end
    line([0 0],yLim,'lineStyle',':','lineWidth',lineM,'color',colorRed);
    text(-4500, 130, 'Laser on align (STIM)','fontSize',fontM);
    xlabel('Time (s)','fontSize',fontM);
    ylabel('Frequency (Hz)','fontSize',fontM);

hSpecRwOn(3) = axes('Position',axpt(2,1,1,1,axpt(nCol,nRow,2,3,figSize,wideInterval),wideInterval));
    hMapRw(5) = pcolor(xpt,ypt,m_rw_specOn{3});
    for iCycle = 1:4
        line(xLimOn*Fs,[10 10]*iCycle,'lineStyle',':','lineWidth',lineM,'color',colorBlack);
        hold on;
    end
    text(-4500, 130, 'Laser on align (POST)','fontSize',fontM);
    xlabel('Time (s)','fontSize',fontM);
    ylabel('Frequency (Hz)','fontSize',fontM);
    
hSpecRwOff(1) = axes('Position',axpt(2,1,2,1,axpt(nCol,nRow,2,1,figSize,wideInterval),wideInterval));
    hMapRw(2) = pcolor(xpt,ypt,m_rw_specOff{1});
    for iCycle = 1:4
        line(xLimOff*Fs,[10 10]*iCycle,'lineStyle',':','lineWidth',lineM,'color',colorBlack);
        hold on;
    end
    text(-1500, 130, 'Laser off align (PRE)','fontSize',fontM);
    xlabel('Time (s)','fontSize',fontM);
    
hSpecRwOff(2) = axes('Position',axpt(2,1,2,1,axpt(nCol,nRow,2,2,figSize,wideInterval),wideInterval));
    hMapRw(4) = pcolor(xpt,ypt,m_rw_specOff{2});
    for iCycle = 1:4
        line(xLimOff*Fs,[10 10]*iCycle,'lineStyle',':','lineWidth',lineM,'color',colorBlack);
        hold on;
    end
    line([0 0],yLim,'lineStyle',':','lineWidth',lineM,'color',colorRed);
    text(-1500, 130, 'Laser off align (STIM)','fontSize',fontM);
    xlabel('Time (s)','fontSize',fontM);
    
hSpecRwOff(3) = axes('Position',axpt(2,1,2,1,axpt(nCol,nRow,2,3,figSize,wideInterval),wideInterval));
    hMapRw(6) = pcolor(xpt,ypt,m_rw_specOff{3});
    for iCycle = 1:4
        line(xLimOff*Fs,[10 10]*iCycle,'lineStyle',':','lineWidth',lineM,'color',colorBlack);
        hold on;
    end
    text(-1500, 130, 'Laser off align (POST)','fontSize',fontM);
    xlabel('Time (s)','fontSize',fontM);
    
set(hMapRw,'EdgeColor','none');
set(hSpecRwOn,'Box','off','TickDir','out','XLim',xLimOn*Fs,'XTick',xTickOn,'XTickLabel',xLabelOn,'YLim',yLim,'YTick',[0:50:200]);
set(hSpecRwOff,'Box','off','TickDir','out','XLim',xLimOff*Fs,'XTick',xTickOff,'XTickLabel',xLabelOff,'YLim',yLim,'YTick',[0:50:200],'YTickLabel',[]);

print('-painters','-r300','-dtiff',['plot_spectrogram_log2','.tif']);
