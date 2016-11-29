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
winDir = [-20, 20];
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
    
    spkCriPlfm = 15;
    spkCriTrack = 15; % spikes should be more than 15

    spkCriteria_Plfm = spikeWin(spikeData,lightTime.Plfm2hz,[-50,50]);
    spkCriteria_Track = spikeWin(spikeData,lightTime.Track8hz,[-50,50]);
    spkLatency_Plfm = spikeWin(spikeData,lightTime.Plfm2hz,[0,25]);
    spkLatency_Track = spikeWin(spikeData,lightTime.Track8hz,[0,25]);
    
    [pLR_Plfm2, pLR_Track2, statDir_Plfm, statDir_Track, latencyPlfm2, latencyTrack] = deal(zeros(1,27));

%% Log-rank test
    movingWin = (0:2:18)';
    [pLR_PlfmT,pLR_TrackT] = deal(zeros(6,1));
    [timeLR_PlfmT,H1_PlfmT,H2_PlfmT,timeLR_TrackT,H1_TrackT,H2_TrackT] = deal(cell(6,1));
%% pLR_Plfm
    if sum(cell2mat(cellfun(@length,spkCriteria_Plfm,'UniformOutput',false))) < spkCriPlfm % if the # of spikes are less than 10, do not calculate pLR
        pLR_Plfm = 1;
        statDir_Plfm = 0;
        latencyPlfm = 0;
        timeLR_Plfm = 0;
        H1_Plfm = 0;
        H2_Plfm = 0;
        calibPlfm = movingWin(1);
    else
        for iWin = 1:10
            [timePlfm, censorPlfm] = tagDataLoad(spikeData, lightTime.Plfm2hz+movingWin(iWin), 10, 480);
            [pLR_PlfmT,timeLR_PlfmT{iWin,1},H1_PlfmT{iWin,1},H2_PlfmT{iWin,1}] = logRankTest(timePlfm, censorPlfm); % H1: light induced firing H2: baseline
            if isempty(pLR_PlfmT)
                pLR_PlfmT = 1;
            end
            pLR_PlfmT(iWin,1) = pLR_PlfmT;
        end
        idxPlfm = find(pLR_PlfmT<0.001,1,'first');
        if isempty(idxPlfm)
            idxPlfm = 1;
        end
        idxH1_Plfm = find(~cellfun(@isempty,H1_PlfmT));
        idxH2_Plfm = find(~cellfun(@isempty,H2_PlfmT));
        idxcom_Plfm = idxH1_Plfm(idxH1_Plfm == idxH2_Plfm);
        for iTest = 1:length(idxcom_Plfm)
            testPlfm(iTest) = all((H1_PlfmT{iTest,:}-H2_PlfmT{iTest,:})>0) | all((H1_PlfmT{iTest,:}-H2_PlfmT{iTest,:})<0);
        end
        idxH_Plfm = idxcom_Plfm(find(testPlfm==1,1,'first'));
%         H1Start = cellfun(@(x) x(1), H1_PlfmT(idxH1_Plfm,1));
%         H1End = cellfun(@(x) x(end), H1_PlfmT(idxH1_Plfm,1));
%         H2Start = cellfun(@(x) x(1), H2_PlfmT(idxH2_Plfm,1));
%         H2End = cellfun(@(x) x(end), H2_PlfmT(idxH2_Plfm,1));
%         HproductPlfm = (H1Start-H1End).*(H2Start-H2End);
%         idxHPlfm = find(HproductPlfm~=-1,1,'first');
        if isempty(idxH_Plfm)
            idxH_Plfm = 1;
        end
        if idxPlfm >= idxH_Plfm
            pLR_Plfm = pLR_PlfmT(idxPlfm);
            timeLR_Plfm = timeLR_PlfmT{idxPlfm};        
            H1_Plfm = H1_PlfmT{idxPlfm};
            H2_Plfm = H2_PlfmT{idxPlfm};
            calibPlfm = movingWin(idxPlfm);
        else
            pLR_Plfm = pLR_PlfmT(idxH_Plfm);
            timeLR_Plfm = timeLR_PlfmT{idxH_Plfm};        
            H1_Plfm = H1_PlfmT{idxH_Plfm};
            H2_Plfm = H2_PlfmT{idxH_Plfm};
            calibPlfm = movingWin(idxH_Plfm);
        end
        
% Modulation direction (Platform)
        spkPlfmChETA = spikeWin(spikeData,lightTime.Plfm2hz+movingWin(idxPlfm),winDir);
        [xptPlfm,~,~,~,~,~] = rasterPETH(spkPlfmChETA,true(size(lightTime.Plfm2hz)),winDir,binSize,resolution,1);
        if ~iscell(xptPlfm)
             xptPlfm = {xptPlfm};
        end
        if sum(winTest(1)<xptPlfm{1} & xptPlfm{1}<0)*1.1 < sum(0 <= xptPlfm{1} & xptPlfm{1}<winTest(2)) % activation (10%)
            statDir_Plfm = 1;
        elseif sum(winTest(1)<xptPlfm{1} & xptPlfm{1}<0) > sum(0 <= xptPlfm{1} & xptPlfm{1}<winTest(2))*0.9 % inactivation (10%)
            statDir_Plfm = -1;
        else % no change
            statDir_Plfm = 0;
        end
        
% Latency (Platform) 
        switch (statDir_Plfm)
            case 1 % activation
                temp_latencyPlfm = cellfun(@min,spkLatency_Plfm,'UniformOutput',false);
                temp_latencyPlfm = nanmedian(cell2mat(temp_latencyPlfm));
            case -1 % inactivation
                temp_latencyPlfm = cellfun(@max,spkLatency_Plfm,'UniformOutput',false);
                temp_latencyPlfm = nanmedian(cell2mat(temp_latencyPlfm));
            case 0
                temp_latencyPlfm = 0;
        end
        latencyPlfm = temp_latencyPlfm;
    end
    
%% pLR_Track
    if sum(cell2mat(cellfun(@length,spkCriteria_Track,'UniformOutput',false))) < spkCriTrack
        pLR_Track = 1;
        statDir_Track = 0;
        latencyTrack = 0;
        timeLR_Track = 0;
        H1_Track = 0;
        H2_Track = 0;
        calibTrack = movingWin(1);
    else
        for iWin = 1:10
            [timeTrack, censorTrack] = tagDataLoad(spikeData,lightTime.Track8hz+movingWin(iWin),10,100);
            [pLR_TrackT,timeLR_TrackT{iWin,1},H1_TrackT{iWin,1},H2_TrackT{iWin,1}] = logRankTest(timeTrack, censorTrack);
            if isempty(pLR_TrackT)
                pLR_TrackT = 1;
            end
            pLR_TrackT(iWin,1) = pLR_TrackT;
        end
        idxTrack = find(pLR_TrackT<0.001,1,'first');
        if isempty(idxTrack)
            idxTrack = 1;
        end
        idxH1_Track = find(~cellfun(@isempty,H1_TrackT));
        idxH2_Track = find(~cellfun(@isempty,H2_TrackT));
        idxcom_Track = idxH1_Track(idxH1_Track == idxH2_Track);
        for iTest = 1:length(idxcom_Track)
            testTrack(iTest) = all((H1_TrackT{iTest,:}-H2_TrackT{iTest,:})>0) | all((H1_TrackT{iTest,:}-H2_TrackT{iTest,:})<0);
        end
        idxH_Track = idxcom_Track(find(testTrack==1,1,'first'));
%         H1Start = cellfun(@(x) x(1), H1_TrackT(idxH1_Track,1));
%         H1End = cellfun(@(x) x(end), H1_TrackT(idxH1_Track,1));
%         H2Start = cellfun(@(x) x(1), H2_TrackT(idxH2_Track,1));
%         H2End = cellfun(@(x) x(end), H2_TrackT(idxH2_Track,1));
%         Hproduct = (H1Start-H1End).*(H2Start-H2End);
%         idxH = find(Hproduct~=-1,1,'first');
        if isempty(idxH_Track)
            idxH_Track = 1;
        end
        if idxTrack >= idxH_Track
            pLR_Track = pLR_TrackT(idxTrack);
            timeLR_Track = timeLR_TrackT{idxTrack};
            H1_Track = H1_TrackT{idxTrack};
            H2_Track = H2_TrackT{idxTrack};
            calibTrack = movingWin(idxTrack);
        else
            pLR_Track = pLR_TrackT(idxH_Track);
            timeLR_Track = timeLR_TrackT{idxH_Track};
            H1_Track = H1_TrackT{idxH_Track};
            H2_Track = H2_TrackT{idxH_Track};
            calibTrack = movingWin(idxH_Track);
        end

% Modulation direction (for moving window)_Track
        spkTrackChETA = spikeWin(spikeData,lightTime.Track8hz+movingWin(idxTrack),winDir);
        [xptTrack,~,~,~,~,~] = rasterPETH(spkTrackChETA,true(size(lightTime.Track8hz)),winDir,binSize,resolution,1);
        if ~iscell(xptTrack)
            xptTrack = {xptTrack};
        end
        if sum(winTest(1)<xptTrack{1} & xptTrack{1}<0)*1.1 < sum(0 <= xptTrack{1} & xptTrack{1}<winTest(2)) % activation
            statDir_Track = 1;
        elseif sum(winTest(1)<xptTrack{1} & xptTrack{1}<0) > sum(0 <= xptTrack{1} & xptTrack{1}<winTest(2))*0.9 % inactivation
            statDir_Track = -1;
        else
            statDir_Track = 0;
        end
% Latency (Moving win)
        switch (statDir_Track)
            case 1 % activation
                temp_latencyTrack = cellfun(@min,spkLatency_Track,'UniformOutput',false);
                temp_latencyTrack = nanmedian(cell2mat(temp_latencyTrack));
            case -1 % inactivation
                temp_latencyTrack = cellfun(@max,spkLatency_Track,'UniformOutput',false);
                temp_latencyTrack = nanmedian(cell2mat(temp_latencyTrack));
            case 0
                temp_latencyTrack = 0;
        end
        latencyTrack = temp_latencyTrack;
    end

    save([cellName,'.mat'],'pLR_Plfm','timeLR_Plfm','H1_Plfm','H2_Plfm','pLR_Track','timeLR_Track','H1_Track','H2_Track','calibPlfm','calibTrack',...
        'statDir_Plfm','statDir_Track','latencyPlfm','latencyTrack','-append')
%% Pre & Post light stimulation p-value check
    [timeTrack_pre, censorTrack_pre] = tagDataLoad(spikeData, psdlightPre+calibTrack, 10, 100);
    [timeTrack_post, censorTrack_post] = tagDataLoad(spikeData, psdlightPost+calibTrack, 10, 100);
    
    [pLR_Track_pre,timeLR_Track_pre,H1_Track_pre,H2_Track_pre] = logRankTest(timeTrack_pre, censorTrack_pre);
    [pLR_Track_post,timeLR_Track_post,H1_Track_post,H2_Track_post] = logRankTest(timeTrack_post, censorTrack_post);
    
    spkCriteria_pre = spikeWin(spikeData,psdlightPre+calibTrack,[-50,50]);
    spkCriteria_post = spikeWin(spikeData,psdlightPost+calibTrack,[-50,50]);
    if sum(cell2mat(cellfun(@length,spkCriteria_pre,'UniformOutput',false))) < spkCriTrack  % if the # of spikes are less than 10, do not calculate pLR
        pLR_Track_pre = 1;
    end
    if sum(cell2mat(cellfun(@length,spkCriteria_post,'UniformOutput',false))) < spkCriTrack
        pLR_Track_post = 1;
    end
    save([cellName, '.mat'],'pLR_Track_pre','timeLR_Track_pre','H1_Track_pre','H2_Track_pre','pLR_Track_post','timeLR_Track_post','H1_Track_post','H2_Track_post','-append')
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