function laserWidthCheck

% binSize = 10; % Unit: msec
resolution = 10; % sigma = resoution * binSize = 100 msec

% Tag variables
winSpike = [-25 200]; % unit: msec
binSize = 2;
winLight = 70;

[tData, tList] = tLoad;
nCell = length(tList);

for iCell = 1:nCell
    disp(['### Analyzing ',tList{iCell},'...']);
    [cellPath, cellName, ~] = fileparts(tList{iCell});
    cd(cellPath);
    
% Load Events variables
    load('Events.mat');
    
% Mean FR
    meanFR10 = sum(histc(tData{iCell},time10))/(diff(time10)/1000);
    meanFR50 = sum(histc(tData{iCell},time50))/(diff(time50)/1000);

% Light
    nlight10ms = length(light10);
    nlight50ms = length(light50);
    
    spikeTime10ms = spikeWin(tData{iCell},light10,winSpike);
    spikeTime50ms = spikeWin(tData{iCell},light50,winSpike);
    
    [xpt10ms, ypt10ms, pethtime10ms, peth10ms, pethConv10ms, pethConvZ10ms] = rasterPETH(spikeTime10ms,true(size(light10)),winSpike,binSize,resolution,1);
    [xpt50ms, ypt50ms, pethtime50ms, peth50ms, pethConv50ms, pethConvZ50ms] = rasterPETH(spikeTime50ms,true(size(light50)),winSpike,binSize,resolution,1);
    
    lightspk10ms = sum(0<xpt10ms{1} & xpt10ms{1}<winLight);
    lightspk50ms = sum(0<xpt50ms{1} & xpt50ms{1}<winLight);
    
    save([cellName,'.mat'],'meanFR10','meanFR50',...
        'xpt10ms','ypt10ms','pethtime10ms','peth10ms','pethConv10ms','pethConvZ10ms','nlight10ms',...
        'xpt50ms','ypt50ms','pethtime50ms','peth50ms','pethConv50ms','pethConvZ50ms','nlight50ms');
    
    if exist('time20','var')
       meanFR20 = sum(histc(tData{iCell},time20))/(diff(time20)/1000);
       nlight20ms = length(light20);
       spikeTime20ms = spikeWin(tData{iCell},light20,winSpike);
       [xpt20ms, ypt20ms, pethtime20ms, peth20ms, pethConv20ms, pethConvZ20ms] = rasterPETH(spikeTime20ms,true(size(light20)),winSpike,binSize,resolution,1);
       lightspk20ms = sum(0<xpt10ms{1} & xpt10ms{1}<winLight);
       
       save([cellName,'.mat'],'meanFR20','xpt20ms','ypt20ms','pethtime20ms','peth20ms','pethConv20ms','pethConvZ20ms','nlight20ms','-append');
    end
end
disp('### Laser Intensity Check is done!!!');

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