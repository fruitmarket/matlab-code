function analysis_cscExample
%
%   #####  platform data #####
%
rtDir = 'D:\Dropbox\SNL\P2_Track';
cd(rtDir);
sFreq = 2000;
win = [-3, 6]*1000; % unit:sec
winCsc = win/1000*sFreq;
binSize = 2;
resolution = 10;
xpt = win(1):0.5:win(2);

%% Load rapid-activation file
cd('D:\Projects\Track_161130-3_Rbp64ori\170303_DV2.05_1_DRun_T23_Ori'); % example 2, (TT3_1) [Activated]
[tData, ~] = tLoad;
load('Events.mat','lightTime');
[cscTime_act, t_cscSample_act, cscList_act] = cscLoad;
raw_cscSample_act = t_cscSample_act{3};
lightTime_act = lightTime.Plfm8hz;
lapLightIdx_act = [1;(find(diff(lightTime_act)>1000)+1)]; % find start light of each lap
nLabLight_act = min(diff(lapLightIdx_act));
lightOn_act = lightTime_act(lapLightIdx_act);

spkTime_act = spikeWin(tData{2},lightTime_act(lapLightIdx_act),win);
[xpt_act, ypt_act, ~, ~, ~, ~] = rasterPETH(spkTime_act,true(size(spkTime_act)),win,binSize,resolution,1);

%% Load delayed-activation file
cd('D:\Projects\Track_160726-2_Rbp50ori\161206_DV2.20_2_DRun_100_T346'); % example 6, (TT6_4) [Delayed Activated]
[tData, ~] = tLoad;
load('Events.mat','lightTime');
[cscTime_actDelay, temp_cscSample_actDelay, cscList_actDelay] = cscLoad;
raw_cscSample_actDelay = temp_cscSample_actDelay{6};
lightTime_actDelay = lightTime.Plfm8hz;
lapLightIdx_actDelay = [1;(find(diff(lightTime_actDelay)>1000)+1)]; % find start light of each lap
nLabLight_actDelay = min(diff(lapLightIdx_actDelay));
lightOn_actDelay = lightTime_actDelay(lapLightIdx_actDelay);

spkTime_actDelay = spikeWin(tData{6},lightTime_actDelay(lapLightIdx_actDelay),win);
[xpt_actDelay, ypt_actDelay, ~, ~, ~, ~] = rasterPETH(spkTime_actDelay,true(size(spkTime_actDelay)),win,binSize,resolution,1);

%% Load inactivation file
cd('D:\Projects\Track_160824-5_Rbp60ori\170203_DV2.55_1_DRun_T5_Ori'); % example 2 (TT5_2) [Inactivated] 
[tData, ~] = tLoad;
load('Events.mat','lightTime');
[cscTime_ina, temp_cscSample_ina, cscList_ina] = cscLoad;
raw_cscSample_ina = temp_cscSample_ina{5};
lightTime_ina = lightTime.Plfm8hz;
lapLightIdx_ina = [1;(find(diff(lightTime_ina)>1000)+1)]; % find start light of each lap
nLabLight_ina = min(diff(lapLightIdx_ina));
lightOn_ina = lightTime_ina(lapLightIdx_ina);

spkTime_ina = spikeWin(tData{2},lightTime_ina(lapLightIdx_ina),win);
[xpt_ina, ypt_ina, ~, ~, ~, ~] = rasterPETH(spkTime_ina,true(size(spkTime_ina)),win,binSize,resolution,1);

%% Load no response file
cd('D:\Projects\Track_170119-1_Rbp70ori\170415_DV1.55_1_DRun_T1246_Ori'); % example 1 (TT2_1) [No response]
[tData, ~] = tLoad;
load('Events.mat','lightTime');
[cscTime_no, temp_cscSample_no, cscList_no] = cscLoad;
raw_cscSample_no = temp_cscSample_no{2};
lightTime_no = lightTime.Plfm8hz;
lapLightIdx_no = [1;(find(diff(lightTime_no)>1000)+1)]; % find start light of each lap
nLabLight_no = min(diff(lapLightIdx_no));
lightOn_no = lightTime_no(lapLightIdx_no);

spkTime_no = spikeWin(tData{1},lightTime_no(lapLightIdx_no),win);
[xpt_no, ypt_no, ~, ~, ~, ~] = rasterPETH(spkTime_no,true(size(spkTime_no)),win,binSize,resolution,1);

%%

% Find light event time
[idxLight_act, idxLight_actDelay, idxLight_ina, idxLight_no] = deal(zeros(30,1));
for iCycle = 1:30
    idxLight_act(iCycle,1) = find(cscTime_act{1}>lightOn_act(iCycle),1,'first');
    idxLight_actDelay(iCycle,1) = find(cscTime_actDelay{1}>lightOn_actDelay(iCycle),1,'first');
    idxLight_ina(iCycle,1) = find(cscTime_ina{1}>lightOn_ina(iCycle),1,'first');
    idxLight_no(iCycle,1) = find(cscTime_no{1}>lightOn_no(iCycle),1,'first');
end

% rearrange the data aligned by light [light - 3 sec,light + 3 sec]
[cscPlfm8hz_act, cscPlfm8hz_actDelay, cscPlfm8hz_ina, cscPlfm8hz_no] = deal(zeros(30,length(winCsc(1):winCsc(2))));

for iCycle = 1:30
    cscPlfm8hz_act(iCycle,:) = raw_cscSample_act((idxLight_act(iCycle)+winCsc(1)):(idxLight_act(iCycle)+winCsc(2)));
    cscPlfm8hz_actDelay(iCycle,:) = raw_cscSample_actDelay((idxLight_actDelay(iCycle)+winCsc(1)):(idxLight_actDelay(iCycle)+winCsc(2)));
    cscPlfm8hz_ina(iCycle,:) = raw_cscSample_ina((idxLight_ina(iCycle)+winCsc(1)):(idxLight_ina(iCycle)+winCsc(2)));
    cscPlfm8hz_no(iCycle,:) = raw_cscSample_no((idxLight_no(iCycle)+winCsc(1)):(idxLight_no(iCycle)+winCsc(2)));
end
m_cscPlfm8hz_act = mean(cscPlfm8hz_act,1);
m_cscPlfm8hz_actDelay = mean(cscPlfm8hz_actDelay,1);
m_cscPlfm8hz_ina = mean(cscPlfm8hz_ina,1);
m_cscPlfm8hz_no = mean(cscPlfm8hz_no,1);

f_cscPlfm8hz_act = bandpassFilter(m_cscPlfm8hz_act,sFreq,2,100);
f_cscPlfm8hz_actDelay = bandpassFilter(m_cscPlfm8hz_actDelay,sFreq,2,100);
f_cscPlfm8hz_ina = bandpassFilter(m_cscPlfm8hz_ina,sFreq,2,100);
f_cscPlfm8hz_no = bandpassFilter(m_cscPlfm8hz_no,sFreq,2,100);

yLim_act = [min(m_cscPlfm8hz_act), max(m_cscPlfm8hz_act)];
yLim_actDelay = [min(m_cscPlfm8hz_actDelay), max(m_cscPlfm8hz_actDelay)];
yLim_ina = [min(m_cscPlfm8hz_ina), max(m_cscPlfm8hz_ina)];
yLim_no = [min(m_cscPlfm8hz_no), max(m_cscPlfm8hz_no)];

cd(rtDir);

save('Info_LFP.mat','win','winCsc','xpt',...
    'xpt_act','ypt_act','xpt_actDelay','ypt_actDelay','xpt_ina','ypt_ina','xpt_no','ypt_no',...
    'cscPlfm8hz_act','cscPlfm8hz_actDelay','cscPlfm8hz_ina','cscPlfm8hz_no',...
    'm_cscPlfm8hz_act','m_cscPlfm8hz_actDelay','m_cscPlfm8hz_ina','m_cscPlfm8hz_no',...
    'f_cscPlfm8hz_act','f_cscPlfm8hz_actDelay','f_cscPlfm8hz_ina','f_cscPlfm8hz_no',...
    'yLim_act','yLim_actDelay','yLim_ina','yLim_no');

load myParameters.mat;

%% figure 1: raster & PETH [Platform]
fHandle(1) = figure('PaperUnits','centimeters','PaperPosition',[0, 0, 29.7*3, 21*2]);
nCol = 1;
nRow = 4;
iCycle = sortrows(randi(30,2,1));
hPlfmCSC(1) = axes('Position',axpt(nCol,nRow,1,1,axpt(1,1,1,1,[0.10 0.10 0.85 0.85],midInterval),midInterval));
for iLight = 1:nLabLight_act
    hLpatch = patch([125*(iLight-1), 125*(iLight-1)+10,125*(iLight-1)+10,125*(iLight-1)],[0, 0, 30, 30],colorLightBlue,'EdgeColor','none');
    hold on;
end
plot(xpt_act{1},ypt_act{1},'LineStyle','none','Marker','o','MarkerSize',markerS,'Color',colorBlack,'MarkerFaceColor',colorBlack);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Cycle','fontSize',fontL);

for iPlot = 1:length(iCycle)
    hPlfmCSC(iPlot+1) = axes('Position',axpt(nCol,nRow,1,iPlot+1,axpt(1,1,1,1,[0.10 0.10 0.85 0.85],midInterval),midInterval));
    for iLight = 1:nLabLight_act
        hLpatch = patch([125*(iLight-1), 125*(iLight-1)+10,125*(iLight-1)+10,125*(iLight-1)],[yLim_act(1), yLim_act(1), yLim_act(2), yLim_act(2)],colorLightBlue,'EdgeColor','none');
        hold on;
    end
    plot(xpt,cscPlfm8hz_act(iCycle(iPlot),:),'color',colorBlack,'lineWidth',0.8);
    text(-900,yLim_act(2)*2,['raw LFP trace ',num2str(iCycle(iPlot)),'th light cycle'],'fontSize',fontL);
end
hPlfmCSC(4) = axes('Position',axpt(nCol,nRow,1,4,axpt(1,1,1,1,[0.10 0.10 0.85 0.85],midInterval),midInterval));
for iLight = 1:nLabLight_act
    hLpatch = patch([125*(iLight-1), 125*(iLight-1)+10,125*(iLight-1)+10,125*(iLight-1)],[yLim_act(1), yLim_act(1), yLim_act(2), yLim_act(2)],colorLightBlue,'EdgeColor','none');
    hold on;
end
plot(xpt,m_cscPlfm8hz_act,'color',colorBlack,'lineWidth',0.8);
text(-900,yLim_act(2)*0.8,'Average LFP trace','fontSize',fontL);

set(hPlfmCSC,'Box','off','TickDir','out','fontSize',fontM,'XLim',[-1000,2000],'XTick',[-1000,0,2000],'fontSize',fontL);
set(hPlfmCSC(1),'YLim',[0,30],'YTick',[0:5:30]);
formatOut = 'yymmdd';
print('-painters','-r300','-dtiff',['plot_rawLFP_act',datestr(now,formatOut),'.tif']);
% print('-painters','-r300','-depsc',['plot_rasterExample_',datestr(now,formatOut),'.ai']);
close;

%% figure 2
fHandle(2) = figure('PaperUnits','centimeters','PaperPosition',[0, 0, 29.7*3, 21*2]);
nCol = 1;
nRow = 4;
hPlfmCSC(1) = axes('Position',axpt(nCol,nRow,1,1,axpt(1,1,1,1,[0.10 0.10 0.85 0.85],midInterval),midInterval));
for iLight = 1:nLabLight_actDelay
    hLpatch = patch([125*(iLight-1), 125*(iLight-1)+10,125*(iLight-1)+10,125*(iLight-1)],[0, 0, 30, 30],colorLightBlue,'EdgeColor','none');
    hold on;
end
plot(xpt_actDelay{1},ypt_actDelay{1},'LineStyle','none','Marker','o','MarkerSize',markerS,'Color',colorBlack,'MarkerFaceColor',colorBlack);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Cycle','fontSize',fontL);
for iPlot = 1:length(iCycle)
    hPlfmCSC(iPlot+1) = axes('Position',axpt(nCol,nRow,1,iPlot+1,axpt(1,1,1,1,[0.10 0.10 0.85 0.85],midInterval),midInterval));
    for iLight = 1:nLabLight_actDelay
        hLpatch = patch([125*(iLight-1), 125*(iLight-1)+10,125*(iLight-1)+10,125*(iLight-1)],[yLim_actDelay(1), yLim_actDelay(1), yLim_actDelay(2), yLim_actDelay(2)],colorLightBlue,'EdgeColor','none');
        hold on;
    end
    plot(xpt,cscPlfm8hz_actDelay(iCycle(iPlot),:),'color',colorBlack,'lineWidth',0.8);
    text(-900,yLim_actDelay(2)*2,['raw LFP trace ',num2str(iCycle(iPlot)),'th light cycle'],'fontSize',fontL);
end
hPlfmCSC(4) = axes('Position',axpt(nCol,nRow,1,4,axpt(1,1,1,1,[0.10 0.10 0.85 0.85],midInterval),midInterval));
for iLight = 1:nLabLight_ina
    hLpatch = patch([125*(iLight-1), 125*(iLight-1)+10,125*(iLight-1)+10,125*(iLight-1)],[yLim_actDelay(1), yLim_actDelay(1), yLim_actDelay(2), yLim_actDelay(2)],colorLightBlue,'EdgeColor','none');
    hold on;
end
plot(xpt,m_cscPlfm8hz_actDelay,'color',colorBlack,'lineWidth',0.8);
text(-900,yLim_actDelay(2)*0.8,'Average LFP trace','fontSize',fontL);

set(hPlfmCSC,'Box','off','TickDir','out','fontSize',fontM,'XLim',[-1000,2000],'XTick',[-1000,0,2000],'fontSize',fontL);
set(hPlfmCSC(1),'YLim',[0,30],'YTick',[0:5:30]);
print('-painters','-r300','-dtiff',['plot_rawLFP_actDelay_',datestr(now,formatOut),'.tif']);
close;

%% figure 3
fHandle(3) = figure('PaperUnits','centimeters','PaperPosition',[0, 0, 29.7*3, 21*2]);
nCol = 1;
nRow = 4;
hPlfmCSC(1) = axes('Position',axpt(nCol,nRow,1,1,axpt(1,1,1,1,[0.10 0.10 0.85 0.85],midInterval),midInterval));
for iLight = 1:nLabLight_no
    hLpatch = patch([125*(iLight-1), 125*(iLight-1)+10,125*(iLight-1)+10,125*(iLight-1)],[0, 0, 30, 30],colorLightBlue,'EdgeColor','none');
    hold on;
end
plot(xpt_ina{1},ypt_ina{1},'LineStyle','none','Marker','o','MarkerSize',markerS,'Color',colorBlack,'MarkerFaceColor',colorBlack);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Cycle','fontSize',fontL);
for iPlot = 1:length(iCycle)
    hPlfmCSC(iPlot+1) = axes('Position',axpt(nCol,nRow,1,iPlot+1,axpt(1,1,1,1,[0.10 0.10 0.85 0.85],midInterval),midInterval));
    for iLight = 1:nLabLight_ina
        hLpatch = patch([125*(iLight-1), 125*(iLight-1)+10,125*(iLight-1)+10,125*(iLight-1)],[yLim_ina(1), yLim_ina(1), yLim_ina(2), yLim_ina(2)],colorLightBlue,'EdgeColor','none');
        hold on;
    end
    plot(xpt,cscPlfm8hz_ina(iCycle(iPlot),:),'color',colorBlack,'lineWidth',0.8);
    text(-900,yLim_ina(2)*2,['raw LFP trace ',num2str(iCycle(iPlot)),'th light cycle'],'fontSize',fontL);
end
hPlfmCSC(4) = axes('Position',axpt(nCol,nRow,1,4,axpt(1,1,1,1,[0.10 0.10 0.85 0.85],midInterval),midInterval));
for iLight = 1:nLabLight_ina
    hLpatch = patch([125*(iLight-1), 125*(iLight-1)+10,125*(iLight-1)+10,125*(iLight-1)],[yLim_ina(1), yLim_ina(1), yLim_ina(2), yLim_ina(2)],colorLightBlue,'EdgeColor','none');
    hold on;
end
plot(xpt,m_cscPlfm8hz_ina,'color',colorBlack,'lineWidth',0.8);
text(-900,yLim_ina(2)*0.8,'Average LFP trace','fontSize',fontL);

set(hPlfmCSC,'Box','off','TickDir','out','fontSize',fontM,'XLim',[-1000,2000],'XTick',[-1000,0,2000],'fontSize',fontL);
set(hPlfmCSC(1),'YLim',[0,30],'YTick',[0:5:30]);
print('-painters','-r300','-dtiff',['plot_rawLFP_ina_',datestr(now,formatOut),'.tif']);
close;

%% figure 4
fHandle(4) = figure('PaperUnits','centimeters','PaperPosition',[0, 0, 29.7*3, 21*2]);
nCol = 1;
nRow = 4;
hPlfmCSC(1) = axes('Position',axpt(nCol,nRow,1,1,axpt(1,1,1,1,[0.10 0.10 0.85 0.85],midInterval),midInterval));
for iLight = 1:nLabLight_act
    hLpatch = patch([125*(iLight-1), 125*(iLight-1)+10,125*(iLight-1)+10,125*(iLight-1)],[0, 0, 30, 30],colorLightBlue,'EdgeColor','none');
    hold on;
end
plot(xpt_no{1},ypt_no{1},'LineStyle','none','Marker','o','MarkerSize',markerS,'Color',colorBlack,'MarkerFaceColor',colorBlack);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Cycle','fontSize',fontL);
for iPlot = 1:length(iCycle)
    hPlfmCSC(iPlot+1) = axes('Position',axpt(nCol,nRow,1,iPlot+1,axpt(1,1,1,1,[0.10 0.10 0.85 0.85],midInterval),midInterval));
    for iLight = 1:nLabLight_no
        hLpatch = patch([125*(iLight-1), 125*(iLight-1)+10,125*(iLight-1)+10,125*(iLight-1)],[yLim_no(1), yLim_no(1), yLim_no(2), yLim_no(2)],colorLightBlue,'EdgeColor','none');
        hold on;
    end
    plot(xpt,cscPlfm8hz_no(iCycle(iPlot),:),'color',colorBlack,'lineWidth',0.8);
    text(-900,yLim_no(2)*2,['raw LFP trace ',num2str(iCycle(iPlot)),'th light cycle'],'fontSize',fontL);
end
hPlfmCSC(4) = axes('Position',axpt(nCol,nRow,1,4,axpt(1,1,1,1,[0.10 0.10 0.85 0.85],midInterval),midInterval));
for iLight = 1:nLabLight_no
    hLpatch = patch([125*(iLight-1), 125*(iLight-1)+10,125*(iLight-1)+10,125*(iLight-1)],[yLim_no(1), yLim_no(1), yLim_no(2), yLim_no(2)],colorLightBlue,'EdgeColor','none');
    hold on;
end
plot(xpt,m_cscPlfm8hz_no,'color',colorBlack,'lineWidth',0.8);
text(-900,yLim_no(2)*0.8,'Average LFP trace','fontSize',fontL);

set(hPlfmCSC,'Box','off','TickDir','out','fontSize',fontM,'XLim',[-1000,2000],'XTick',[-1000,0,2000],'fontSize',fontL);
set(hPlfmCSC(1),'YLim',[0,30],'YTick',[0:5:30]);
print('-painters','-r300','-dtiff',['plot_rawLFP_no_',datestr(now,formatOut),'.tif']);
close;

%% sub-functions
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