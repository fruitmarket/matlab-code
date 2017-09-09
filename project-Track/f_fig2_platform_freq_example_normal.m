function f_fig2_platform_freq_example
lineColor = {[144, 164, 174]./255,... % Before stimulation
    [33 150 243]./ 255,... % During stimulation
    [38, 50, 56]./255}; % After stimulation

lineWth = [1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75];
fontS = 4; fontM = 5; fontL = 7; fontXL = 9; % font size large
lineS = 0.2; lineM = 0.5; lineL = 1; % line width large

colorBlue = [33 150 243] ./ 255;
colorLightBlue = [100 181 246] ./ 255;
colorLLightBlue = [187, 222, 251]./255;
colorRed = [237 50 52] ./ 255;
colorLightRed = [242 138 130] ./ 255;
colorGray = [189 189 189] ./ 255;
colorLightGray = [238, 238, 238] ./255;
colorDarkGray = [117, 117, 117] ./255;
colorYellow = [255 243 3] ./ 255;
colorLightYellow = [255 249 196] ./ 255;
colorBlack = [0, 0, 0];

markerS = 2.2; markerM = 4.4; markerL = 6.6; markerXL = 8.8;
tightInterval = [0.02 0.02]; midInterval = [0.03 0.03]; wideInterval = [0.07 0.07];
width = 0.7;

paperSize = {[0 0 21 29.7];
             [0 0 29.7 21];
             [0 0 15.7 21];
             [0 0 21.6 27.9]};
figSize = [0.15 0.10 0.85 0.90];

winCri_ori = [-5, 20];
win50hzPlot = [-50 350];

binSize = 2;
resolution = 10;

nTrial = 20;
nTrial_ori = 300;
posiTitle = [0, -0.4];

cd('D:\Projects\Track_161130-3_Rbp64freq\170304_DV2.05_1hz2hz8hz20hz50hz_T3'); % normal example \TT3_1.mat
load('TT3_1.mat');
load('Events.mat');
saveDir = 'D:\Dropbox\SNL\P2_Track';

% cd('D:\Projects\Track_161130-7_Rbp68freq\170302_DV2.00_1hz2hz8hz20hz50hz_T7'); % build up example \TT7_1.mat


fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});
nCol = 2;
nRow = 6;

%% Original 1Hz
hLight1hzOri(1) = axes('Position',axpt(5,1,1,1,axpt(nCol,nRow,1,1,[0.1 0.1 0.80 0.80],wideInterval),midInterval));
hLBar(1) = rectangle('Position',[0,0,10,nTrial_ori],'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
hLBar(2) = rectangle('Position',[0,270,10,nTrial_ori/10],'LineStyle','none','FaceColor',colorBlue);
hold on;
plot(xpt1hz_ori{1},ypt1hz_ori{1},'LineStyle','none','Marker','.','MarkerSize',markerL,'Color','k');
ylabel('Trials','FontSize',fontL);
xlabel('Time (ms)','FontSize',fontL);
title('1 Hz','fontSize',fontL);

set(hLight1hzOri(1),'XLim',winCri_ori,'XTick',[],'YLim',[0, nTrial_ori],'YTick',[0, nTrial_ori],'YTickLabel',{0, nTrial_ori});
set(hLight1hzOri,'Box','off','TickDir','out','fontSize',fontL);            

%% Original 2Hz
hLight2hzOri(1) = axes('Position',axpt(5,1,2,1,axpt(nCol,nRow,1,1,[0.1 0.1 0.80 0.80],wideInterval),midInterval));
hLBar(1) = rectangle('Position',[0,0,10,nTrial_ori],'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
hLBar(2) = rectangle('Position',[0,270,10,nTrial_ori/10],'LineStyle','none','FaceColor',colorBlue);
hold on;
plot(xpt2hz_ori{1},ypt2hz_ori{1},'LineStyle','none','Marker','.','MarkerSize',markerL,'Color','k');
xlabel('Time (ms)','FontSize',fontL);
title('2 Hz','fontSize',fontL);

set(hLight2hzOri(1),'XLim',winCri_ori,'XTick',[],'YLim',[0, nTrial_ori],'YTick',[],'YTickLabel',{0, nTrial_ori});
set(hLight2hzOri,'Box','off','TickDir','out','fontSize',fontL);

%% Original 8Hz
hLight8hzOri(1) = axes('Position',axpt(5,1,3,1,axpt(nCol,nRow,1,1,[0.1 0.1 0.80 0.80],wideInterval),midInterval));
hLBar(1) = rectangle('Position',[0,0,10,nTrial_ori],'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
hLBar(2) = rectangle('Position',[0,270,10,nTrial_ori/10],'LineStyle','none','FaceColor',colorBlue);
hold on;
plot(xpt8hz_ori{1},ypt8hz_ori{1},'LineStyle','none','Marker','.','MarkerSize',markerL,'Color','k');
xlabel('Time (ms)','FontSize',fontL);
title('8 Hz','fontSize',fontL);

set(hLight8hzOri(1),'XLim',winCri_ori,'XTick',[],'YLim',[0, nTrial_ori],'YTick',[],'YTickLabel',{0, nTrial_ori});
set(hLight8hzOri,'Box','off','TickDir','out','fontSize',fontL);

%% Original 20Hz
hLight20hzOri(1) = axes('Position',axpt(5,1,4,1,axpt(nCol,nRow,1,1,[0.1 0.1 0.80 0.80],wideInterval),midInterval));
hLBar(1) = rectangle('Position',[0,0,10,nTrial_ori],'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
hLBar(2) = rectangle('Position',[0,270,10,nTrial_ori/10],'LineStyle','none','FaceColor',colorBlue);
hold on;
plot(xpt20hz_ori{1},ypt20hz_ori{1},'LineStyle','none','Marker','.','MarkerSize',markerL,'Color','k');
xlabel('Time (ms)','FontSize',fontL);
title('20 Hz','fontSize',fontL);

set(hLight20hzOri(1),'XLim',winCri_ori,'XTick',[],'YLim',[0, nTrial_ori],'YTick',[],'YTickLabel',{0, nTrial_ori});
set(hLight20hzOri,'Box','off','TickDir','out','fontSize',fontL);

%% Original 50Hz
hLight50hzOri(1) = axes('Position',axpt(5,1,5,1,axpt(nCol,nRow,1,1,[0.1 0.1 0.80 0.80],wideInterval),midInterval));
hLBar(1) = rectangle('Position',[0,0,10,nTrial_ori],'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
hLBar(2) = rectangle('Position',[0,270,10,nTrial_ori/10],'LineStyle','none','FaceColor',colorBlue);
hold on;
plot(xpt50hz_ori{1},ypt50hz_ori{1},'LineStyle','none','Marker','.','MarkerSize',markerL,'Color','k');
xlabel('Time (ms)','FontSize',fontL);
title('50 Hz','fontSize',fontL);

set(hLight50hzOri(1),'XLim',winCri_ori,'XTick',[],'YLim',[0, nTrial_ori],'YTick',[],'YTickLabel',{0, nTrial_ori});
set(hLight50hzOri,'Box','off','TickDir','out','fontSize',fontL);

%% Each light (50Hz)
hFreq50hz(1) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1,2,[0.1 0.1 0.80 0.80],wideInterval),midInterval));
for iLight = 1:15
    hold on;
    hLBar(1) = rectangle('Position',[20*iLight-20, 0, 10, 20],'LineStyle','none','FaceColor',colorLLightBlue);
    hold on;
    hLBar(2) = rectangle('Position',[20*iLight-20, 18, 10, 2],'LineStyle','none','FaceColor',colorBlue);
end
plot(xpt50hz{1},ypt50hz{1},'LineStyle','none','Marker','.','MarkerSize',markerL,'Color','k');

set(hFreq50hz(1),'XLim',win50hzPlot,'XTick',[],'YLim',[0, nTrial],'YTick',[0, nTrial],'YTickLabel',{0, nTrial});
set(hFreq50hz,'Box','off','TickDir','out','fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Cycle','fontSize',fontL);
title('50 Hz stimulation','fontSize',fontL);

cd(saveDir);
print('-painters','-r300','-dtiff',['final_fig2_platform_freq_example1_',datestr(now,formatOut),'.tif']);
print('-painters','-r300','-depsc',['final_fig2_platform_freq_example1_',datestr(now,formatOut),'.ai']);
close;

function spikeTime = spikeWin(spikeData, eventTime, win)
% spikeWin makes raw spikeData to eventTime aligned data
%   spikeData: raw data from MClust. Unit must be ms.
%   eventTime: each output cell will be eventTime aligned spike data. unit must be ms
%   win: spike within windows will be included. unit must be ms.
narginchk(3,3);

if isempty(eventTime); spikeTime =[]; return; end;
nEvent = size(eventTime);
spikeTime = cell(nEvent);
for iEvent = 1:nEvent(1)
    for jEvent = 1:nEvent(2)
        timeIndex = [];
        if isnan(eventTime(iEvent,jEvent)); continue; end;
        [~,timeIndex] = histc(spikeData,eventTime(iEvent,jEvent)+win);
        if isempty(timeIndex); continue; end;
        spikeTime{iEvent,jEvent} = spikeData(logical(timeIndex))-eventTime(iEvent,jEvent);
    end
end
function [xpt,ypt,spikeBin,spikeHist,spikeConv,spikeConvZ] = rasterPETH(spikeTime, trialIndex, win, binSize, resolution, dot)
% raterPSTH converts spike time into raster plot
%   spikeTime: cell array. Each cell contains vector array of spike times per each trial unit is ms.
%   trialIndex: number of raws should be same as number of trials (length of spikeTime)
%   win: window range of xpt. should be 2 numbers. unit is msec.
%   resolution: sigma for convolution = binsize * resolution.
%   dot: 1-dot, 0-line
%   unit of xpt will be msec.
narginchk(5,6);
if isempty(spikeTime) || isempty(trialIndex) || length(spikeTime) ~= size(trialIndex,1) || length(win) ~= 2
    xpt = []; ypt = []; spikeBin = []; spikeHist = []; spikeConv = []; spikeConvZ = [];
    return;
end;

spikeBin = win(1):binSize:win(2); % unit: msec
nSpikeBin = length(spikeBin);

nTrial = length(spikeTime);
nCue = size(trialIndex,2);
trialResult = sum(trialIndex);
resultSum = [0 cumsum(trialResult)];

yTemp = [0:nTrial-1; 1:nTrial; NaN(1,nTrial)]; % template for ypt
xpt = cell(1,nCue);
ypt = cell(1,nCue);
spikeHist = zeros(nCue,nSpikeBin);
spikeConv = zeros(nCue,nSpikeBin);

for iCue = 1:nCue
    % raster
    nSpikePerTrial = cellfun(@length,spikeTime(trialIndex(:,iCue)));
    nSpikeTotal = sum(nSpikePerTrial);
    if nSpikeTotal == 0; continue; end;
    
    spikeTemp = cell2mat(spikeTime(trialIndex(:,iCue)))';
    
    xptTemp = [spikeTemp;spikeTemp;NaN(1,nSpikeTotal)];
    if (nargin == 6) && (dot==1)
        xpt{iCue} = xptTemp(2,:);
    else
        xpt{iCue} = xptTemp(:);
    end
    
    yptTemp = [];
    for iy = 1:trialResult(iCue)
        yptTemp = [yptTemp repmat(yTemp(:,resultSum(iCue)+iy),1,nSpikePerTrial(iy))];
    end
    if (nargin == 6) && (dot==1)
        ypt{iCue} = yptTemp(2,:);
    else
        ypt{iCue} = yptTemp(:);
    end
    
    % psth
    spkhist_temp = histc(spikeTemp,spikeBin)/(binSize/10^3*trialResult(iCue));
    spkconv_temp = conv(spkhist_temp,fspecial('Gaussian',[1 5*resolution],resolution),'same');
    spikeHist(iCue,:) = spkhist_temp;
    spikeConv(iCue,:) = spkconv_temp;
end

totalHist = histc(cell2mat(spikeTime),spikeBin)/(binSize/10^3*nTrial);
fireMean = mean(totalHist);
fireStd = std(totalHist);
spikeConvZ = (spikeConv-fireMean)/fireStd;    