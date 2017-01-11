function laserFreqCheck

% binSize = 10; % Unit: msec
resolution = 10; % sigma = resoution * binSize = 100 msec

% Tag variables
winCri = [0, 30]; % unit: msec
binSizeBlue = 2;

[tData, tList] = tLoad;
nCell = length(tList);

for iCell = 1:nCell
    disp(['### Analyzing ',tList{iCell},'...']);
    [cellPath, cellName, ~] = fileparts(tList{iCell});
    cd(cellPath);
    
    % Load Events variables
    load('Events.mat','lightTime');
    
 %% Platform 2hz & 8hz
    if isempty(lightTime.Plfm2hz) | isempty(lightTime.Plfm8hz)
     [lightPlfmSpk2hz8mw,lightPlfmSpk8hz] = deal(NaN);
    else
     nPlfmLight2hz = length(lightTime.Plfm2hz);
     spikeTimePlfm = spikeWin(tData{iCell},lightTime.Plfm2hz,winCri);
     spikeTime2hz8mw = spikeTimePlfm(nPlfmLight2hz/3+1:nPlfmLight2hz*2/3,1);
     lightPlfmSpk2hz8mw = sum(cellfun(@length,spikeTime2hz8mw))/(nPlfmLight2hz/3);

     nPlfmLight8hz = length(lightTime.Plfm8hz);
     spikeTimePlfm8hz = spikeWin(tData{iCell},lightTime.Plfm8hz,winCri);
     lightPlfmSpk8hz = sum(cellfun(@length,spikeTimePlfm8hz))/nPlfmLight8hz;    
    end

%% Track 'Modi session' only
    if isempty(lightTime.Track2hz) | isemtpy(lightTime.Track8hz)
        [lightTrackSpk2hz8mw,lightTrackSpk8hz] = deal(NaN);
    else
        nTrackLight2hz = length(lightTime.Track2hz);
        spikeTimeTrack = spikeWin(tData{iCell},lightTime.Track2hz,winCri);
        spikeTimeTrack2hz8mw = spikeTimeTrack(nTrackLight2hz/3+1:nTrackLight2hz*2/3,1);
        lightTrackSpk2hz8mw = sum(cellfun(@length, spikeTimeTrack2hz8mw))/200; % spike fidelity. divided by the # of light

        nTrackLight8hz = length(lightTime.Track8hz);
        spikeTimeTrack8hz = spikeWin(tData{iCell},lightTime.Track8hz,winCri);
        lightTrackSpk8hz = sum(cellfun(@length, spikeTimeTrack8hz))/nTrackLight8hz;
    end

%%
save([cellName,'.mat'],'lightPlfmSpk2hz8mw','lightPlfmSpk8hz','lightTrackSpk2hz8mw','lightTrackSpk8hz','-append');
end

disp('### Laser Frequency Check is done!!!');

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