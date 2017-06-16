function analysis_pethLight50hz8hz

binSize = 10; % unit: msec
resolution = 10; % unit: msec, rasterPETH sigma = resoution * binSize (usually 100 ms works fine). Big resolution --> wide distribution
winPlot = [-25, 99];
winFidel = [0 10];
[tData, tList] = tLoad;
nCell = length(tList);

for iCell = 1:nCell
    [cellPath, cellName, ~] = fileparts(tList{iCell});
    cd(cellPath);
    
    load('Events.mat');
    
    spikeData = tData{iCell};
    meanFR = meanFiringRate(time_recStart,time_recEnd,spikeData);
    
    spkTime = spikeWin(spikeData,lightT_50hzLoop1st,winPlot);
    [xpt, ypt, pethtime, peth, pethConv, pethConvZ] = rasterPETH(spkTime,true(size(lightT_50hzLoop1st)),winPlot,binSize,resolution,1);
    
% Calculating light evoked spike number 10ms window
    spkLight_1 = sum(double(0<xpt{1} & xpt{1}<10));
    spkLight_2 = sum(double(20<xpt{1} & xpt{1}<30));
    spkLight_3 = sum(double(40<xpt{1} & xpt{1}<50));
    
% Spike fidelity
    spkTime_1 = spikeWin(spikeData,lightT_50hzLoop1st,winFidel);
    spkFidel_1 = sum(double(~cellfun(@isempty,spkTime_1)))/length(lightT_50hzLoop1st)*100;
    
    spkTime_2 = spikeWin(spikeData,lightT_50hzLoop2nd,winFidel);
    spkFidel_2 = sum(double(~cellfun(@isempty,spkTime_2)))/length(lightT_50hzLoop2nd)*100;
    
    spkTime_3 = spikeWin(spikeData,lightT_50hzLoop3rd,winFidel);
    spkFidel_3 = sum(double(~cellfun(@isempty,spkTime_3)))/length(lightT_50hzLoop3rd)*100;
    
    save([cellName,'.mat'],'meanFR','xpt','ypt','pethtime','peth','pethConv','pethConvZ',...
        'spkLight_1','spkLight_2','spkLight_3','spkFidel_1','spkFidel_2','spkFidel_3');
end
disp('### Analyzing: pethLight50hz8hz is complete! ###');

%% Sub function
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