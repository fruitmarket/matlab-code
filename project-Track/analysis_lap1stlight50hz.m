function analysis_lap1stlight50hz()
% m_deto_spkTrack50hz or Plfm50hz: mean number of spikes activated by each light
%
winTrack = [-500, 5000]; % time duration which are interested in
binSizeBlue = 2;
resolution = 10;

[tData, tList] = tLoad;
nCell = length(tList);
nLap = 30;
load Events.mat

lightIdxTrack50hz = [];
lightTrack50hz = lightTime.Track50hz;
lapLightIdx = [1;(find(diff(lightTrack50hz)>1000)+1)]; % find start light of each lap
minPulseTrack50hz = min([diff(lapLightIdx);(length(lightTrack50hz)-lapLightIdx(end)+1)]);
maxPulseTrack50hz = max([diff(lapLightIdx);(length(lightTrack50hz)-lapLightIdx(end)+1)]);
prelapidx = [1;(find(diff(psdlightPre)>1000)+1)];
postlapidx = [1;(find(diff(psdlightPost)>1000)+1)];

for iLap = 1:nLap
    temp_lightIdx = lapLightIdx(iLap):lapLightIdx(iLap)+minPulseTrack50hz-1 ;
    lightIdxTrack50hz = [lightIdxTrack50hz;temp_lightIdx'];
end

for iCell = 1:nCell
    disp(['### detoSpike analysis: ',tList{iCell},'...']);
    [cellPath, cellName, ~] = fileparts(tList{iCell});
    cd(cellPath);
    
    spkTimeLight50hz = spikeWin(tData{iCell},lightTrack50hz(lapLightIdx),winTrack);
    [xptLight1st, yptLight1st, pethtimeLight1st, pethLight1st,pethLight1stConv,pethLight1stConvZ] = rasterPETH(spkTimeLight50hz,true(size(lapLightIdx)),winTrack,binSizeBlue,resolution,1);
    
    spkTimePre50hz = spikeWin(tData{iCell},psdlightPre(prelapidx),winTrack);
    [xptPre1st, yptPre1st, pethtimePre1st, pethPre1st,pethPre1stConv,pethPre1stConvZ] = rasterPETH(spkTimePre50hz,true(size(prelapidx)),winTrack,binSizeBlue,resolution,1);
    
    spkTimePost50hz = spikeWin(tData{iCell},psdlightPost(postlapidx),winTrack);
    [xptPost1st, yptPost1st, pethtimePost1st, pethPost1st,pethPost1stConv,pethPost1stConvZ] = rasterPETH(spkTimePost50hz,true(size(postlapidx)),winTrack,binSizeBlue,resolution,1);

    save([cellName,'.mat'], 'minPulseTrack50hz', 'maxPulseTrack50hz', 'xptLight1st', 'yptLight1st', 'pethtimeLight1st', 'pethLight1st', 'pethLight1stConv', 'pethLight1stConvZ',...
        'xptPre1st', 'yptPre1st', 'pethtimePre1st', 'pethPre1st', 'pethPre1stConv', 'pethPre1stConvZ',...
        'xptPost1st', 'yptPost1st', 'pethtimePost1st', 'pethPost1st', 'pethPost1stConv', 'pethPost1stConvZ','-append');
end
disp('### detonate spike calculation is done! ###')

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