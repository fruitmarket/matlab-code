function tagstatTrack_Poster()
%tagstatCC calculates statistical significance using log-rank test

% Variables for log-rank test & salt test
dt = 0.1;
% testRangePlfm = 10; % unit: ms 
% baseRangePlfm = 480; % baseline 
% testRangeTrack = 10; % 8Hz: 10 // 20Hz: 20
% baseRangeTrack = 100; % 8Hz: 110 // 20Hz: 15

calibOnset = [0:2:20,0:2:16,0:2:10]';
calibDuration = [10*ones(1,11),15*ones(1,9),20*ones(1,6)]';
nRepeat = length(calibOnset);
baseRangePlfm = [485*ones(1,11),480*ones(1,9),475*ones(1,6)]';
baseRangeTrack = [100*ones(1,11),95*ones(1,9),90*ones(1,6)]';

% Modulation direction
winDir = [-30, 30];
resolution = 10;
binSize = 2;
winTest = [-30, 30];

if nargin == 0; sessionFolder = {}; end;
[tData, tList] = tLoad(sessionFolder);
if isempty(tList); return; end;

nCell = length(tList);
for iCell = 1:nCell
    disp(['### Tag stat test: ',tList{iCell}]);
    [cellPath,cellName,~] = fileparts(tList{iCell});
    cd(cellPath);

    load('Events.mat','lightTime','psdlightPre','psdlightPost');
    spikeData = tData{iCell};
    
    spkCriPlfm = 20;
    spkCriTrack = 20; % during 100ms, firing rate should be higher than 1Hz

    spkCriteria_Plfm = spikeWin(spikeData,lightTime.Tag,[-50,50]);
    spkCriteria_Track = spikeWin(spikeData,lightTime.Modu,[-50,50]);
    
    spkLatency_Plfm = spikeWin(spikeData,lightTime.Tag,[0,25]);
    spkLatency_Track = spikeWin(spikeData,lightTime.Modu,[0,25]);
    
    [pLR_Plfm2, pLR_Track2, statDir_Plfm2, statDir_Track2] = deal(zeros(1,27));

% Log-rank test    
    for iRepeat = 1:nRepeat
        [timePlfm, censorPlfm] = tagDataLoad(spikeData, lightTime.Tag+calibOnset(iRepeat),calibDuration(iRepeat),baseRangePlfm(iRepeat));
        [timeTrack, censorTrack] = tagDataLoad(spikeData, lightTime.Modu+calibOnset(iRepeat),calibDuration(iRepeat),baseRangeTrack(iRepeat));

        if sum(cell2mat(cellfun(@length,spkCriteria_Plfm,'UniformOutput',false))) < spkCriPlfm; % if the # of spikes are less than 1Hz, do not calculate pLR
                temp_pLR_Plfm = 1;
        else
            [temp_pLR_Plfm,~,~,~] = logRankTest(timePlfm,censorPlfm);
            if isempty(temp_pLR_Plfm)
                temp_pLR_Plfm = NaN;
            end
        end
        
        if sum(cell2mat(cellfun(@length,spkCriteria_Track,'UniformOutput',false))) < spkCriTrack; % if the # of spikes are less than 1Hz, do not calculate
             temp_pLR_Track = 1;
        else
            [temp_pLR_Track,~,~,~] = logRankTest(timeTrack,censorTrack);
            if isempty(temp_pLR_Track)
                temp_pLR_Track = NaN;
            end
        end       
% Modulation direction
        spkPlfmChETA = spikeWin(spikeData,lightTime.Tag+calibOnset(iRepeat),winDir);
        [xptPlfm,~,~,~,~,~] = rasterPETH(spkPlfmChETA,true(size(lightTime.Tag)),winDir,binSize,resolution,1);
        if ~iscell(xptPlfm)
             xptPlfm = {xptPlfm};
        end
        if sum(winTest(1)<xptPlfm{1} & xptPlfm{1}<0)*1.1 < sum(0 <= xptPlfm{1} & xptPlfm{1}<winTest(2)) % activation (10%)
            temp_statDir_Plfm = 1;
        elseif sum(winTest(1)<xptPlfm{1} & xptPlfm{1}<0) > sum(0 <= xptPlfm{1} & xptPlfm{1}<winTest(2))*0.9 % inactivation (10%)
            temp_statDir_Plfm = -1;
        else % no change
            temp_statDir_Plfm = 0;
        end
        spkTrackChETA = spikeWin(spikeData,lightTime.Modu+calibOnset(iRepeat),winDir);
        [xptTrack,~,~,~,~,~] = rasterPETH(spkTrackChETA,true(size(lightTime.Modu)),winDir,binSize,resolution,1);
        if ~iscell(xptTrack)
            xptTrack = {xptTrack};
        end
        if sum(winTest(1)<xptTrack{1} & xptTrack{1}<0)*1.1 < sum(0 <= xptTrack{1} & xptTrack{1}<winTest(2)) % activation
            temp_statDir_Track = 1;
        elseif sum(winTest(1)<xptTrack{1} & xptTrack{1}<0) > sum(0 <= xptTrack{1} & xptTrack{1}<winTest(2))*0.9 % inactivation
            temp_statDir_Track = -1;
        else
            temp_statDir_Track = 0;
        end
% Light Latency Calculation
        switch (temp_statDir_Plfm)
            case 1 % activation
                temp_latencyPlfm = cellfun(@min,spkLatency_Plfm,'UniformOutput',false);
                temp_latencyPlfm = nanmedian(cell2mat(temp_latencyPlfm));
            case -1 % inactivation
                temp_latencyPlfm = cellfun(@max,spkLatency_Plfm,'UniformOutput',false);
                temp_latencyPlfm = nanmedian(cell2mat(temp_latencyPlfm));
            case 0
                temp_latencyPlfm = 0;
        end
        switch (temp_statDir_Track)
            case 1
                temp_latencyTrack = cellfun(@min,spkLatency_Track,'UniformOut',false);
                temp_latencyTrack = nanmedian(cell2mat(temp_latencyTrack));
            case -1
                temp_latencyTrack = cellfun(@max,spkLatency_Track,'UniformOut',false);
                temp_latencyTrack = nanmedian(cell2mat(temp_latencyTrack));
            case 0
                temp_latencyTrack = 0;
        end
        pLR_Plfm2(1,iRepeat) = temp_pLR_Plfm;
        pLR_Track2(1,iRepeat) = temp_pLR_Track;
        statDir_Plfm2(1,iRepeat) = temp_statDir_Plfm;
        statDir_Plfm2(1,iRepeat) = temp_statDir_Track;
        latencyPlfm2(1,iRepeat) = temp_latencyPlfm - calibOnset(iRepeat);
        latencyTrack2(1,iRepeat) = temp_latencyTrack - calibOnset(iRepeat);

%         pLR_Plfm2 = [pLR_Plfm2,temp_pLR_Plfm];
%         pLR_Track2 = [pLR_Track2,temp_pLR_Track];
%         statDir_Plfm2 = [statDir_Plfm2,temp_statDir_Plfm];
%         statDir_Track2 = [statDir_Track2, temp_statDir_Track];
    end        
%%% Moving win %%%
    movingWin = (0:2:18)';
    [pLR_PlfmT,pLR_TrackT] = deal(zeros(6,1));
    if sum(cell2mat(cellfun(@length,spkCriteria_Plfm,'UniformOutput',false))) < spkCriPlfm % if the # of spikes are less than 10, do not calculate pLR
        pLR_Plfm2(1,27) = 1;
        statDir_Plfm2(1,27) = 0;
        latencyPlfm2(1,27) = 0;
    else
        for iWin = 1:10
            [timePlfm, censorPlfm] = tagDataLoad(spikeData, lightTime.Tag+movingWin(iWin), 10, 480);
            [pLR_PlfmT,~,~,~] = logRankTest(timePlfm, censorPlfm); % H1: light induced firing H2: baseline
            if isempty(pLR_PlfmT)
                pLR_PlfmT = 1;
            end
            pLR_PlfmT(iWin,1) = pLR_PlfmT;
            idxPlfm = find(pLR_PlfmT<0.005,1,'first');
            if isempty(idxPlfm)
                idxPlfm = 1;
            end
        end
        pLR_Plfm2(1,27) = pLR_PlfmT(idxPlfm);
        % Modulation direction (for moving window)_Platform
        spkPlfmChETA = spikeWin(spikeData,lightTime.Tag+movingWin(idxPlfm),winDir);
        [xptPlfm,~,~,~,~,~] = rasterPETH(spkPlfmChETA,true(size(lightTime.Tag)),winDir,binSize,resolution,1);
        if ~iscell(xptPlfm)
             xptPlfm = {xptPlfm};
        end
        if sum(winTest(1)<xptPlfm{1} & xptPlfm{1}<0)*1.1 < sum(0 <= xptPlfm{1} & xptPlfm{1}<winTest(2)) % activation (10%)
            statDir_Plfm2(1,27) = 1;
        elseif sum(winTest(1)<xptPlfm{1} & xptPlfm{1}<0) > sum(0 <= xptPlfm{1} & xptPlfm{1}<winTest(2))*0.9 % inactivation (10%)
            statDir_Plfm2(1,27) = -1;
        else % no change
            statDir_Plfm2(1,27) = 0;
        end
% Latency (Moving win)
        switch (statDir_Plfm2(1,27))
            case 1 % activation
                temp_latencyPlfm = cellfun(@min,spkLatency_Plfm,'UniformOutput',false);
                temp_latencyPlfm = nanmedian(cell2mat(temp_latencyPlfm));
            case -1 % inactivation
                temp_latencyPlfm = cellfun(@max,spkLatency_Plfm,'UniformOutput',false);
                temp_latencyPlfm = nanmedian(cell2mat(temp_latencyPlfm));
            case 0
                temp_latencyPlfm = 0;
        end
        latencyPlfm2(1,27) = temp_latencyPlfm-movingWin(idxPlfm);
    end

    if sum(cell2mat(cellfun(@length,spkCriteria_Track,'UniformOutput',false))) < spkCriTrack
        pLR_Track2(1,27) = 1;
        statDir_Track2(1,27) = 0;
        latencyTrack2(1,27) = 0;
    else
        for iWin = 1:10
            [timeTrack, censorTrack] = tagDataLoad(spikeData, lightTime.Modu+movingWin(iWin), 10, 100);
            [pLR_TrackT,~,~,~] = logRankTest(timeTrack, censorTrack);
            if isempty(pLR_TrackT)
                pLR_TrackT = 1;
            end
            pLR_TrackT(iWin,1) = pLR_TrackT;
        end
            idxTrack = find(pLR_TrackT<0.005,1,'first');
            if isempty(idxTrack)
                idxTrack = 1;
            end
        pLR_Track2(1,27) = pLR_TrackT(idxTrack);
        % Modulation direction (for moving window)_Track
        spkTrackChETA = spikeWin(spikeData,lightTime.Modu+movingWin(idxTrack),winDir);
        [xptTrack,~,~,~,~,~] = rasterPETH(spkTrackChETA,true(size(lightTime.Modu)),winDir,binSize,resolution,1);
        if ~iscell(xptTrack)
            xptTrack = {xptTrack};
        end
        if sum(winTest(1)<xptTrack{1} & xptTrack{1}<0)*1.1 < sum(0 <= xptTrack{1} & xptTrack{1}<winTest(2)) % activation
            statDir_Track2(1,27) = 1;
        elseif sum(winTest(1)<xptTrack{1} & xptTrack{1}<0) > sum(0 <= xptTrack{1} & xptTrack{1}<winTest(2))*0.9 % inactivation
            statDir_Track2(1,27) = -1;
        else
            statDir_Track2(1,27) = 0;
        end
% Latency (Moving win)
        switch (statDir_Track2(1,27))
            case 1 % activation
                temp_latencyTrack = cellfun(@min,spkLatency_Track,'UniformOutput',false);
                temp_latencyTrack = nanmedian(cell2mat(temp_latencyTrack));
            case -1 % inactivation
                temp_latencyTrack = cellfun(@max,spkLatency_Track,'UniformOutput',false);
                temp_latencyTrack = nanmedian(cell2mat(temp_latencyTrack));
            case 0
                temp_latencyTrack = 0;
        end
        latencyTrack2(1,27) = temp_latencyTrack-movingWin(idxTrack);
    end

%     save([cellName,'.mat'],'pLR_Plfm2','pLR_Track2','statDir_Plfm2','statDir_Track2','latencyPlfm2','latencyTrack2','-append')
end
disp('### TagStatTest & Latency calculation are done!');

function [time, censor] = tagDataLoad(spikeData, onsetTime, testRange, baseRange)
%tagDataLoad makes dataset for statistical tests
%   spikeData: raw data from MClust t file (in msec)
%   onsetTime: time of light stimulation (in msec)
%   testRange: binning time range for test (in msec)
%   baseRange: binning time range for baseline (in msec)
%
%   time: nBin (nBin-1 number of baselines and 1 test) x nLightTrial

narginchk(4,4);
if isempty(onsetTime); time = []; censor = []; return; end;

% If onsetTime interval is shorter than test+baseline range, omit.
outBin = find(diff(onsetTime)<=(testRange+baseRange));
outBin = [outBin;outBin+1];
onsetTime(outBin(:))=[];
if isempty(onsetTime); time = []; censor = []; return; end;
nLight = length(onsetTime);

% Rearrange data
bin = [-floor(baseRange/testRange)*testRange:testRange:0];
nBin = length(bin);
binMat = ones(nLight,nBin)*diag(bin);
lightBin = (repmat(onsetTime',nBin,1)+binMat');
time = zeros(nBin,nLight);
censor = zeros(nBin,nLight);

for iLight=1:nLight
    for iBin=1:nBin
        idx = find(spikeData > lightBin(iBin,iLight), 1, 'first');
        if isempty(idx)
            time(iBin,iLight) = testRange;
            censor(iBin,iLight) = 1;
        else
            time(iBin,iLight) = spikeData(idx) - lightBin(iBin,iLight);
            if time(iBin,iLight) > testRange
                time(iBin,iLight) = testRange;
                censor(iBin,iLight) = 1;
            end
        end     
    end
end

function [p,time,H1,H2] = logRankTest(time, censor)
%logRankTest makes dataset for log-rank test

if isempty(time) || isempty(censor); p = []; time = []; H1 = []; H2 = []; return; end;

base = [reshape(time(1:(end-1),:),1,[]);reshape(censor(1:(end-1),:),1,[])]';
test = [time(end,:);censor(end,:)]';

[p,time,H1,H2] = logrank(test,base);

function [p, l] = saltTest(time, wn, dt)
if isempty(time) ; p = []; l= []; return; end;

base = time(1:(end-1),:)';
test = time(end,:)';

[p, l] = salt2(test, base, wn, dt);

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