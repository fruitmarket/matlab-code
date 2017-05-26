function track_fig_1_rasterExample
rtDir = 'D:\Dropbox\SNL\P2_Track';
cd(rtDir);
load myParameters.mat;

%% Load activation file
% cd('D:\Projects\Track_161130-3_Rbp64ori\170304_DV2.05_1_DRw_T3_Ori'); % example 1, matfile:2, tetrode:3
cd('D:\Dropbox\SNL\P2_Track\Rbp48ori_161201_DV2.15_2_DRw_100_T246'); % example 2, matfile:1, tetrode:2 [Activated]
matFile = mLoad;
load(matFile{1});
load Events.mat;

nBlue_act = length(lightTime.Plfm8hz);
pethtimePlfm8hz_act = pethtimePlfm8hz;
xptPlfm8hz_act = xptPlfm8hz;
yptPlfm8hz_act = yptPlfm8hz;
winBlue_act = [min(pethtimePlfm8hz_act) max(pethtimePlfm8hz_act)];

%% Load inactivation file
cd('D:\Projects\Track_170109-2_Rbp72ori\170501_DV1.90_2_DRw_T1246_Ori'); % example 2 (TT2_1) [Inactivated] 
matFile = mLoad;
load(matFile{2});
load Events.mat;

nBlue_ina = length(lightTime.Plfm8hz);
pethtimePlfm8hz_ina = pethtimePlfm8hz;
xptPlfm8hz_ina = xptPlfm8hz;
yptPlfm8hz_ina = yptPlfm8hz;
winBlue_ina = [min(pethtimePlfm8hz_act) max(pethtimePlfm8hz_act)];

%% Load no response file
cd('D:\Projects\Track_160824-2_Rbp58ori\170125_DV2.15_2_DRw_T467_Ori'); % example 4 (TT6_2) [No response]
matFile = mLoad;
load(matFile{4});
load Events.mat;

nBlue_no = length(lightTime.Plfm8hz);
pethtimePlfm8hz_no = pethtimePlfm8hz;
xptPlfm8hz_no = xptPlfm8hz;
yptPlfm8hz_no = yptPlfm8hz;
winBlue_no = [min(pethtimePlfm8hz_act) max(pethtimePlfm8hz_act)];

cd(rtDir);
%% figure 1: raster & PETH [Platform]
fHandle = figure('PaperUnits','centimeters','PaperPosition',[0, 0, 6, 6]*2);

% Raster
hPlfmBlue(1) = axes('Position',axpt(1,3,1,1,axpt(1,1,1,1,[0.15 0.10 0.80 0.85],wideInterval),wideInterval));
patch([0 10 10 0],[0 0 nBlue_act nBlue_act],colorLLightBlue,'Edgecolor','none');
hold on;
plot(xptPlfm8hz_act{1},yptPlfm8hz_act{1},'LineStyle','none','Marker','.','MarkerSize',markerM,'Color','k');
text(70, 520,'Activated','fontSize',fontL);
ylabel('Light trials','FontSize',fontL);

hPlfmBlue(2) = axes('Position',axpt(1,3,1,2,axpt(1,1,1,1,[0.15 0.10 0.80 0.85],wideInterval),wideInterval));
patch([0 10 10 0],[0 0 nBlue_act nBlue_act],colorLLightBlue,'Edgecolor','none');
hold on;
plot(xptPlfm8hz_ina{1},yptPlfm8hz_ina{1},'LineStyle','none','Marker','.','MarkerSize',markerM,'Color','k');
text(70, 520,'Inactivated','fontSize',fontL);
ylabel('Light trials','FontSize',fontL);

hPlfmBlue(3) = axes('Position',axpt(1,3,1,3,axpt(1,1,1,1,[0.15 0.10 0.80 0.85],wideInterval),wideInterval));
patch([0 10 10 0],[0 0 nBlue_act nBlue_act],colorLLightBlue,'Edgecolor','none');
hold on;
plot(xptPlfm8hz_no{1},yptPlfm8hz_no{1},'LineStyle','none','Marker','.','MarkerSize',markerM,'Color','k');
text(70, 520,'No response','fontSize',fontL);
ylabel('Light trials','FontSize',fontL);
% Psth
% hPlfmBlue(2) = axes('Position',axpt(1,2,1,2,axpt(1,1,1,1,[0.15 0.15 0.80 0.80],wideInterval),wideInterval));
% hold on;
% yLimBarBlue = ceil(max(pethPlfm8hz(:))*1.1);
% bar(5, yLimBarBlue, 'BarWidth', 10, 'LineStyle','none', 'FaceColor', colorLLightBlue);
% rectangle('Position', [0 yLimBarBlue*0.925, 10, yLimBarBlue*0.075], 'LineStyle', 'none', 'FaceColor', colorBlue);
% hBarBlue = bar(pethtimePlfm8hz, pethPlfm8hz, 'histc');
% if statDir_Plfm8hz == 1
%     text(sum(winBlue_act)*0.3,yLimBarBlue*0.9,['latency = ', num2str(latencyPlfm8hz1st,3)],'FontSize',fontL,'interpreter','none');
% else
% end
% set(hPlfmBlue(2), 'XLim', winBlue_act, 'XTick', [winBlue_act(1) 0, 10, winBlue_act(2)],'XTickLabel',{winBlue_act(1),0,10,num2str(winBlue_act(2))},'YLim', [0 yLimBarBlue], 'YTick', [0 yLimBarBlue], 'YTickLabel', {[], yLimBarBlue});
set(hPlfmBlue,'Box','off','TickDir','out','XLim',winBlue_act,'XTick',[winBlue_act(1),0,10,winBlue_act(2)],'XTickLabel',{winBlue_act(1),0,10,num2str(winBlue_act(2))},'YLim',[0 nBlue_act], 'YTick', [0 nBlue_act], 'YTickLabel', {0, nBlue_act});
xlabel('Time (ms)','FontSize',fontL);
% Hazard function
%     hPlfmBlue(3) = axes('Position',axpt(2,8,2,7:8,axpt(nCol,nRow,1:4,2:5,[0.17 0.17 0.85 0.75],tightInterval),wideInterval));
%     hold on;
%     ylimH = min([ceil(max([H1_Plfm8hz;H2_Plfm8hz])*1100+0.0001)/1000 1]);
%     winHTag = [0 testRangeChETA];
%     stairs(timeLR_Plfm8hz, H2_Plfm8hz, 'LineStyle',':','LineWidth',lineL,'Color','k');
%     stairs(timeLR_Plfm8hz, H1_Plfm8hz,'LineStyle','-','LineWidth',lineL,'Color',colorBlue);
%     text(diff(winHTag)*0.1,ylimH*0.9,['p = ',num2str(pLR_Plfm8hz,3)],'FontSize',fontL,'Interpreter','none');
%     text(diff(winHTag)*0.1,ylimH*0.7,['calib: ',num2str(calibPlfm8hz,3),' ms'],'FontSize',fontL,'Interpreter','none');
%     set(hPlfmBlue(3),'XLim',winHTag,'XTick',winHTag,'YLim',[0 ylimH], 'YTick', [0 ylimH], 'YTickLabel', {[], ylimH});
%     xlabel('Time (ms)','FontSize',fontL);
%     ylabel('H(t)','FontSize',fontL);
%     title('LR test (platform 8Hz)','FontSize',fontL,'FontWeight','bold');
% align_ylabel(hPlfmBlue)
formatOut = 'yymmdd';
print('-painters','-r300','-dtiff',['fig1_rasterExample_',datestr(now,formatOut),'.tif']);
print('-painters','-r300','-depsc',['fig1_rasterExample_',datestr(now,formatOut),'.ai']);
close;

%% figure 2: waveform [Platform]
cd('D:\Dropbox\SNL\P2_Track\Rbp48ori_161201_DV2.15_2_DRw_100_T246'); % example 2, matfile:1, tetrode:2 [Activated]
matFile = mLoad;
load(matFile{1});
load Events.mat;

fHandle = figure('PaperUnits','centimeters','PaperPosition',[0, 0, 16, 4]);
hWaveform(1) = axes('Position',axpt(4,1,1,1,axpt(1,1,1,1,[0.15 0.15 0.80 0.80],wideInterval),wideInterval));
plot(m_evoked_wv{1},'color',colorBlue,'lineWidth',1.5);
hold on;
plot(m_spont_wv{1},'color',colorBlack,'lineWidth',1.5);

hWaveform(2) = axes('Position',axpt(4,1,2,1,axpt(1,1,1,1,[0.15 0.15 0.80 0.80],wideInterval),wideInterval));
plot(m_evoked_wv{2},'color',colorBlue,'lineWidth',1.5);
hold on;
plot(m_spont_wv{2},'color',colorBlack,'lineWidth',1.5);

hWaveform(3) = axes('Position',axpt(4,1,3,1,axpt(1,1,1,1,[0.15 0.15 0.80 0.80],wideInterval),wideInterval));
plot(m_evoked_wv{3},'color',colorBlue,'lineWidth',1.5);
hold on;
plot(m_spont_wv{3},'color',colorBlack,'lineWidth',1.5);

hWaveform(4) = axes('Position',axpt(4,1,4,1,axpt(1,1,1,1,[0.15 0.15 0.80 0.80],wideInterval),wideInterval));
plot(m_evoked_wv{4},'color',colorBlue,'lineWidth',1.5);
hold on;
plot(m_spont_wv{4},'color',colorBlack,'lineWidth',1.5);
set(hWaveform,'Box','off','TickDir','out','XTick',[],'YTick',[])
% print('-painters','-r300','-depsc',['fig1_waveform_',datestr(now,formatOut),'.ai']);
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