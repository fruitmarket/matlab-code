function pethLight()
% function pethLight(criteria_multi,criteria_add)
% Check whether the cell has light response or not.
% It calculates both in-block and between-block responses.
% criteria (%)
%   
%   Author: Joonyeup Lee
%   Version 1.0 (7/25/2016)

% Task variables
resolution = 10; % sigma = resoution * binSize = 100 msec
winTrack = [0 125];

% Plfm variables
winPlfm2hz = [-25 475]; % unit: msec
winPlfm8hz = [0 125];
binSizeBlue = 2;

winCri = 20; % light effect criteria: 20ms

[tData, tList] = tLoad;
nCell = length(tList);

for iCell = 1:nCell
    disp(['### pethLight analysis: ',tList{iCell},'...']);
    [cellPath, cellName, ~] = fileparts(tList{iCell});
    cd(cellPath);
    
    % Load Events variables
    load('Events.mat');    
    % Load spike data
    % tData{iCell} unit: msec

% Light - ontrack
    if ~isempty(lightTime.Track8hz); % ChETA
        spikeTimeTrackLight = spikeWin(tData{iCell},lightTime.Track8hz,winTrack);
        [xptTrackLight, yptTrackLight, pethtimeTrackLight, pethTrackLight,pethTrackLightConv,pethTrackLightConvZ] = rasterPETH(spikeTimeTrackLight,true(size(lightTime.Track8hz)),winTrack,binSizeBlue,resolution,1);     
        lightSpk = sum(0<xptTrackLight{1} & xptTrackLight{1}<winCri);
        lightPreSpk = sum(-winCri<xptTrackLight{1} & xptTrackLight{1}<0);
        lightPostSpk = sum(winCri<xptTrackLight{1} & xptTrackLight{1}<2*winCri);      
        
        save([cellName,'.mat'],'spikeTimeTrackLight','xptTrackLight','yptTrackLight','pethtimeTrackLight','pethTrackLight','pethTrackLightConv','pethTrackLightConvZ','lightSpk','lightPreSpk','lightPostSpk','-append');
    end
    
% Pseudo light (On track)
    if exist('psdlightPre','var') && exist('psdlightPost','var')
        spikeTime_psdPre = spikeWin(tData{iCell},psdlightPre,winTrack); % Pseudo light Pre
        [xptPsdPre, yptPsdPre, pethtimePsdPre, pethPsdPre,pethPsdPreConv,pethPsdPreConvZ] = rasterPETH(spikeTime_psdPre,true(size(psdlightPre)),winTrack,binSizeBlue,resolution,1);
        spikeTime_psdPost = spikeWin(tData{iCell},psdlightPost,winTrack); % Pseudo light Post
        [xptPsdPost, yptPsdPost, pethtimePsdPost, pethPsdPost,pethPsdPostConv,pethPsdPostConvZ] = rasterPETH(spikeTime_psdPost,true(size(psdlightPost)),winTrack,binSizeBlue,resolution,1);
        psdPreSpk = sum(0<xptPsdPre{1} & xptPsdPre{1}<winCri);
        psdPostSpk = sum(0<xptPsdPost{1} & xptPsdPost{1}<winCri);
        
        save([cellName,'.mat'],'xptPsdPre','yptPsdPre','pethtimePsdPre','psdPreSpk','pethPsdPreConv','pethPsdPreConvZ','xptPsdPost','yptPsdPost','pethtimePsdPost','psdPostSpk','pethPsdPostConv','pethPsdPostConvZ','-append');
    end
    
% Light (Plfm) 8mw analysis [201:400]
    if isfield(lightTime,'Plfm2hz') % Activation (ChETA)
       spikeTimePlfm2hz = spikeWin(tData{iCell},lightTime.Plfm2hz(201:400),winPlfm2hz);
       [xptPlfm2hz, yptPlfm2hz, pethtimePlfm2hz, pethPlfm2hz,pethPlfm2hzConv,pethPlfm2hzConvZ] = rasterPETH(spikeTimePlfm2hz,true(size(lightTime.Plfm2hz(201:400))),winPlfm2hz,binSizeBlue,resolution,1);
       lightSpkPlfm2hz = sum(0<xptPlfm2hz{1} & xptPlfm2hz{1}<winCri);
       lightSpkPlfm2hz_pre = sum(-winCri<xptPlfm2hz{1} & xptPlfm2hz{1}<0);
       lightSpkPlfm2hz_post = sum(winCri<xptPlfm2hz{1} & xptPlfm2hz{1}<2*winCri);
       
       save([cellName,'.mat'],'spikeTimePlfm2hz','xptPlfm2hz','yptPlfm2hz','pethtimePlfm2hz','pethPlfm2hz','lightSpkPlfm2hz','pethPlfm2hzConv','pethPlfm2hzConvZ','lightSpkPlfm2hz_pre','lightSpkPlfm2hz_post','-append');
    end
    
    if isfield(lightTime,'Plfm8hz') & ~isempty(lightTime.Plfm8hz);
        spikeTimePlfm8hz = spikeWin(tData{iCell},lightTime.Plfm8hz,winPlfm8hz);
        [xptPlfm8hz, yptPlfm8hz, pethtimePlfm8hz, pethPlfm8hz,pethPlfm8hzConv,pethPlfm8hzConvZ] = rasterPETH(spikeTimePlfm8hz,true(size(lightTime.Plfm8hz)),winPlfm8hz,binSizeBlue,resolution,1);
        lightSpkPlfm8hz = sum(0<xptPlfm8hz{1} & xptPlfm8hz{1}<winCri);
        lightSpkPlfm8hz_pre = sum(-winCri<xptPlfm8hz{1} & xptPlfm8hz{1}<0);
        lightSpkPlfm8hz_post = sum(winCri<xptPlfm8hz{1} & xptPlfm8hz{1}<2*winCri);
        save([cellName,'.mat'],'spikeTimePlfm8hz','xptPlfm8hz','yptPlfm8hz','pethtimePlfm8hz','pethPlfm8hz','pethPlfm8hzConv','pethPlfm8hzConvZ','lightSpkPlfm8hz','lightSpkPlfm8hz_pre','lightSpkPlfm8hz_post','-append');
    else
        [spikeTimePlfm8hz,xptPlfm8hz,yptPlfm8hz,pethtimePlfm8hz,pethPlfm8hz,pethPlfm8hzConv,pethPlfm8hzConvZ,lightSpkPlfm8hz,lightSpkPlfm8hz_pre,lightSpkPlfm8hz_post] = deal(NaN);
        save([cellName,'.mat'],'spikeTimePlfm8hz','xptPlfm8hz','yptPlfm8hz','pethtimePlfm8hz','pethPlfm8hz','pethPlfm8hzConv','pethPlfm8hzConvZ','lightSpkPlfm8hz','lightSpkPlfm8hz_pre','lightSpkPlfm8hz_post','-append');
    end
end
disp('### pethLight is done! ###');

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