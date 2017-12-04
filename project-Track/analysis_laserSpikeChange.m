function analysis_laserSpikeChange()
% function analysis_laserSpikeChange calculates number of spikes in each
% period (preEarly, preLate, stmEarly, stmLate, postEarly, postLate). 
% Also the function calculates spike probability (fidelity) .
%
%   Author: Joonyeup Lee
%   Version 1.0 (3/23/2017)

% Task variables
resolution = 10; % sigma = resoution * binSize = 100 msec
winTrack = [0 125];
winCriProb = [0, 20];
winCri1 = [0 20];
winCri2 = [30 125];
winTest = [0 20];
winBase = [-20 0];
binSizeBlue = 2;

[tData, tList] = tLoad;
nCell = length(tList);

for iCell = 1:nCell
    disp(['### pethLight analysis:  ',tList{iCell},'...']);
    [cellPath, cellName, ~] = fileparts(tList{iCell});
    cd(cellPath);

% Load Events variables
    load('Events.mat');

%% On Track    
    if ~isempty(lightTime.Track8hz)
        spkTimeTrack8hz = spikeWin(tData{iCell},lightTime.Track8hz,winCriProb);
        lightProbTrack_8hz = sum(double(~cellfun(@isempty,spkTimeTrack8hz)))/length(lightTime.Track8hz)*100;
    else
        lightProbTrack_8hz = NaN;            
    end
    
    if isfield(lightTime,'Track2hz')
        if ~isempty(lightTime.Track2hz)
            spkTimeTrack2hz = spikeWin(tData{iCell},lightTime.Track2hz,winCriProb);
            lightProbTrack_2hz = sum(double(~cellfun(@isempty,spkTimeTrack2hz)))/length(lightTime.Track2hz)*100;
        else
            lightProbTrack_2hz = NaN;
        end
    end
    save([cellName,'.mat'],'lightProbTrack_2hz','lightProbTrack_8hz','-append');

%% On Platform
    if isfield(lightTime,'Plfm2hz')
        if ~isempty(lightTime.Plfm2hz)
            spkTime2hz = spikeWin(tData{iCell},lightTime.Plfm2hz(201:400),winCriProb);
            lightProbPlfm_2hz = sum(double(~cellfun(@isempty,spkTime2hz)))/length(lightTime.Plfm2hz(201:400))*100;        
        else
            lightProbPlfm_2hz = NaN;
        end
    end
    
    if isfield(lightTime,'Plfm8hz')
        if ~isempty(lightTime.Plfm8hz)
            spkTime8hz = spikeWin(tData{iCell},lightTime.Plfm8hz,winCriProb);
            lightProbPlfm_8hz = sum(double(~cellfun(@isempty,spkTime8hz)))/length(lightTime.Plfm8hz)*100;
        else
            lightProbPlfm_8hz = NaN;            
        end
    end
    save([cellName,'.mat'],'lightProbPlfm_2hz','lightProbPlfm_8hz','-append');
    
%% evoked spike number 
% Light - ontrack
    evoSpikeTimeTrack = spikeWin(tData{iCell},lightTime.Track8hz,winTrack);
    [evoXptTrackLight, ~, ~, ~, ~, ~] = rasterPETH(evoSpikeTimeTrack,true(size(lightTime.Track8hz)),winTrack,binSizeBlue,resolution,1);     
    evoSpike_stmEarly = sum(winCri1(1)<evoXptTrackLight{1} & evoXptTrackLight{1}<winCri1(2));
    evoSpike_stmLate = sum(winCri2(1)<evoXptTrackLight{1} & evoXptTrackLight{1}<winCri2(2));

% Pseudo light (On track)
    evoSpikeTime_psdPre = spikeWin(tData{iCell},psdlightPre,winTrack); % Pseudo light Pre
    [evoXptPsdPre, ~, ~, ~, ~, ~] = rasterPETH(evoSpikeTime_psdPre,true(size(psdlightPre)),winTrack,binSizeBlue,resolution,1);
    evoSpike_preEarly = sum(winCri1(1)<evoXptPsdPre{1} & evoXptPsdPre{1}<winCri1(2));
    evoSpike_preLate = sum(winCri2(1)<evoXptPsdPre{1} & evoXptPsdPre{1}<winCri2(2));

    evoSpikeTime_psdPost = spikeWin(tData{iCell},psdlightPost,winTrack); % Pseudo light Post
    [evoXptPsdPost, ~, ~, ~, ~, ~] = rasterPETH(evoSpikeTime_psdPost,true(size(psdlightPost)),winTrack,binSizeBlue,resolution,1);
    evoSpike_postEarly = sum(winCri1(1)<evoXptPsdPost{1} & evoXptPsdPost{1}<winCri1(2));
    evoSpike_postLate = sum(winCri2(1)<evoXptPsdPost{1} & evoXptPsdPost{1}<winCri2(2));

    save([cellName,'.mat'],'evoXptTrackLight','evoXptPsdPre','evoXptPsdPost','evoSpike_stmEarly','evoSpike_stmLate','evoSpike_preEarly','evoSpike_preLate','evoSpike_postEarly','evoSpike_postLate','-append');
    
%% [-20, 0] vs [0, 20]
    % base / test
    spikeBase = spikeWin(tData{iCell},lightTime.Track8hz,winBase);
    lap_spikeBase = cellfun(@length,spikeBase);
    spikeTest = spikeWin(tData{iCell},lightTime.Track8hz,winTest);
    lap_spikeTest = cellfun(@length,spikeTest);
    [~,p_evoSpike] = ttest(lap_spikeBase,lap_spikeTest);
    if sum(lap_spikeBase)>sum(lap_spikeTest) & p_evoSpike<0.05
        idx_evoSpikeDir = -1;
    elseif sum(lap_spikeBase)<sum(lap_spikeTest) & p_evoSpike<0.05
        idx_evoSpikeDir = 1;
    else
        idx_evoSpikeDir = 0;
    end
    save([cellName,'.mat'],'idx_evoSpikeDir','-append');
end
disp('### Calculating Light induced spike change is done! ###');

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