function tagstatTrack_v3_movWin(sessionFolder)
%tagstatCC calculates statistical significance using log-rank test

% Variables for log-rank test & salt test
dt = 0.1;
testRangePlfm = 10; % unit: ms 
baseRangePlfm = 480; % baseline 
testRangeTrack = 10; % 8Hz: 10 // 20Hz: 20
baseRangeTrack = 100; % 8Hz: 110 // 20Hz: 15

% variables for latency calculation
winTagChETA = [0, 30]; % unit: msec
% winTagiC = [-500, 2000];
testRangeTag_lat = winTagChETA(2); % unit: ms
baseRangeTag_lat = 450; % baseline 
testRangeModu_lat = winTagChETA(2); % 8Hz: 10 // 20Hz: 20
baseRangeModu_lat = 90; % 8Hz: 110 // 20Hz: 15

winDirChETA = [-20, 40];
binSizePlfmBlue = 2;
resolution = 10;

% Find files
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
    
% Log-rank test (4ms moving window)
    movingWin = (0:2:20)';
    [pSaltPlfmT,pSaltTrackT,lSaltPlfmT,lSaltTrackT,pLR_PlfmT,pLR_TrackT] = deal(zeros(6,1));
    [timeLR_PlfmT,H1_PlfmT,H2_PlfmT,timeLR_TrackT,H1_TrackT,H2_TrackT] = deal(cell(6,1));

    for iWin = 1:11
        [timePlfm, censorPlfm] = tagDataLoad(spikeData, lightTime.Plfm2hz+movingWin(iWin), testRangePlfm, baseRangePlfm);
        [timeTrack, censorTrack] = tagDataLoad(spikeData, lightTime.Track8hz+movingWin(iWin), testRangeTrack, baseRangeTrack);

        [pSaltPlfmT, lSaltPlfmT] = saltTest(timePlfm, testRangePlfm, dt);
        [pSaltTrackT, lSaltTrackT] = saltTest(timeTrack, testRangeTrack, dt);
        if isempty(pSaltPlfmT)
            pSaltPlfmT = 1;
        end
        if isempty(lSaltPlfmT)
            lSaltPlfmT = NaN;
        end
        if isempty(pSaltTrackT)
            pSaltTrackT = 1;
        end
        if isempty(lSaltTrackT)
            lSaltTrackT = NaN;
        end
        pSaltPlfmT(iWin,1) = pSaltPlfmT;
        lSaltPlfmT(iWin,1) = lSaltPlfmT;
        pSaltTrackT(iWin,1) = pSaltTrackT;
        lSaltTrackT(iWin,1) = lSaltTrackT;
        [pLR_PlfmT,timeLR_PlfmT{iWin,1},H1_PlfmT{iWin,1},H2_PlfmT{iWin,1}] = logRankTest(timePlfm, censorPlfm); % H1: light induced firing H2: baseline
        [pLR_TrackT,timeLR_TrackT{iWin,1},H1_TrackT{iWin,1},H2_TrackT{iWin,1}] = logRankTest(timeTrack, censorTrack);
        if isempty(pLR_PlfmT)
            pLR_PlfmT = 1;
        end
        if isempty(pLR_TrackT)
            pLR_TrackT = 1;
        end
        pLR_PlfmT(iWin,1) = pLR_PlfmT;
        pLR_TrackT(iWin,1) = pLR_TrackT;
    end
    idxPlfm = find(pLR_PlfmT<0.01,1,'first');
    idxTrack = find(pLR_TrackT<0.01,1,'first');
    if isempty(idxPlfm)
        idxPlfm = 1;
    end
    if isempty(idxTrack)
        idxTrack = 1;
    end
    pLR_Plfm = pLR_PlfmT(idxPlfm);
    timeLR_Plfm = timeLR_PlfmT{idxPlfm};
    H1_Plfm = H1_PlfmT{idxPlfm};
    H2_Plfm = H2_PlfmT{idxPlfm};
    
    pLR_Track = pLR_TrackT(idxTrack);
    timeLR_Track = timeLR_TrackT{idxTrack};
    H1_Track = H1_TrackT{idxTrack};
    H2_Track = H2_TrackT{idxTrack};
    
    calibPlfm = movingWin(idxPlfm);
    calibTrack = movingWin(idxTrack);
% Too less spike will be not calculater for log-rank test (criteria: more than 10 spikes)
    spkCriteria_Plfm = spikeWin(spikeData,lightTime.Plfm2hz,[-20,30]);
    spkCriteria_Track = spikeWin(spikeData,lightTime.Track8hz,[-20,30]);
%     if sum(cell2mat(cellfun(@length,spkCriteria_Plfm,'UniformOutput',false))) < length(lightTime.Tag)*50/1000  | isempty(pLR_Plfm) % if the # of spikes are less than 1Hz, do not calculate pLR
    if sum(cell2mat(cellfun(@length,spkCriteria_Plfm,'UniformOutput',false))) < 10  | isempty(pLR_Plfm)
        pLR_Plfm = 1;
    end
    if sum(cell2mat(cellfun(@length,spkCriteria_Track,'UniformOutput',false))) < length(lightTime.Track8hz)*50/1000 | isempty(pLR_Track)
        pLR_Track = 1;
    end
    if pLR_Plfm == 1;
        calibPlfm = 0;
    end
    if pLR_Track == 1;
        calibTrack = 0;
    end
    save([cellName, '.mat'],'pLR_Plfm','timeLR_Plfm','H1_Plfm','H2_Plfm','pLR_Track','timeLR_Track','H1_Track','H2_Track','calibPlfm','calibTrack','-append')
    
%% Pre & Post light stimulation p-value check
    [timeTrack_pre, censorTrack_pre] = tagDataLoad(spikeData, psdlightPre+calibTrack, testRangeTrack, baseRangeTrack);
    [timeTrack_post, censorTrack_post] = tagDataLoad(spikeData, psdlightPost+calibTrack, testRangeTrack, baseRangeTrack);
    
    [pLR_Track_pre,timeLR_Track_pre,H1_Track_pre,H2_Track_pre] = logRankTest(timeTrack_pre, censorTrack_pre);
    [pLR_Track_post,timeLR_Track_post,H1_Track_post,H2_Track_post] = logRankTest(timeTrack_post, censorTrack_post);
    
    spkCriteria_pre = spikeWin(spikeData,psdlightPre+calibTrack,[-20,100]);
    spkCriteria_post = spikeWin(spikeData,psdlightPost+calibTrack,[-20,100]);
    if sum(cell2mat(cellfun(@length,spkCriteria_pre,'UniformOutput',false))) < 10 | isempty(pLR_Track_pre) % if the # of spikes are less than 10, do not calculate pLR
        pLR_Track_pre = 1;
    end
    if sum(cell2mat(cellfun(@length,spkCriteria_post,'UniformOutput',false))) < 10 | isempty(pLR_Track_post)
        pLR_Track_post = 1;
    end
    save([cellName, '.mat'],'pLR_Track_pre','timeLR_Track_pre','H1_Track_pre','H2_Track_pre','pLR_Track_post','timeLR_Track_post','H1_Track_post','H2_Track_post','-append')
    
% Salt test
    pSaltPlfm = pSaltPlfmT(idxPlfm);
    lSaltPlfm = lSaltPlfmT(idxPlfm);
    pSaltTrack = pSaltTrackT(idxTrack);
    lSaltTrack = lSaltTrackT(idxTrack);
    save([cellName,'.mat'],'pSaltPlfm','lSaltPlfm','pSaltTrack','lSaltTrack','-append');    

%% Light modulation direction (Actiavtion / inactivation / no change)
    spkPlfmChETA = spikeWin(spikeData,lightTime.Plfm2hz+calibPlfm,winDirChETA);
    [xptPlfm,~,~,~,~,~] = rasterPETH(spkPlfmChETA,true(size(lightTime.Plfm2hz)),winDirChETA,binSizePlfmBlue,resolution,1);
    if ~iscell(xptPlfm)
         xptPlfm = {xptPlfm};
    end
    if sum(-30<xptPlfm{1} & xptPlfm{1}<0) < sum(0 <= xptPlfm{1} & xptPlfm{1}<30) % activation
        statDir_Plfm = 1;
    elseif sum(-30<xptPlfm{1} & xptPlfm{1}<0) > sum(0 <= xptPlfm{1} & xptPlfm{1}<30) % inactivation
        statDir_Plfm = -1;
    else % no change
        statDir_Plfm = 0;
    end

    spkTrackChETA = spikeWin(spikeData,lightTime.Track8hz+calibTrack,winDirChETA);
    [xptTrack,~,~,~,~,~] = rasterPETH(spkTrackChETA,true(size(lightTime.Track8hz)),winDirChETA,binSizePlfmBlue,resolution,1);
    if ~iscell(xptTrack)
        xptTrack = {xptTrack};
    end
    if sum(-30<xptTrack{1} & xptTrack{1}<0) < sum(0 <= xptTrack{1} & xptTrack{1}<30) % activation
        statDir_Track = 1;
    elseif sum(-30<xptTrack{1} & xptTrack{1}<0) > sum(0 <= xptTrack{1} & xptTrack{1}<30) % inactivation
        statDir_Track = -1;
    else
        statDir_Track = 0;
    end

%% Latency (add calib after all calculation)
% Baseline spontaneous latency
    [timePlfm_lat, ~] = tagDataLoad(spikeData, lightTime.Plfm2hz, testRangeTag_lat, baseRangeTag_lat);
    baseLatPlfm = min(timePlfm_lat);
    baseLatPlfm(baseLatPlfm==testRangeTag_lat) = [];
    baseLatencyPlfm = median(baseLatPlfm);
    [timeTrack_lat, ~] = tagDataLoad(spikeData, lightTime.Track8hz, testRangeModu_lat, baseRangeModu_lat);
    baseLatTrack = min(timeTrack_lat);
    baseLatTrack(baseLatTrack==testRangeModu_lat) = [];
    baseLatencyTrack = median(baseLatTrack);

% Light induced spike latency
    if ~isempty(lightTime.Plfm2hz); % Activation (ChETA)
       spkPlfmChETA = spikeWin(spikeData,lightTime.Plfm2hz,winTagChETA);
       if statDir_Plfm >= 0
           testLatPlfm = cellfun(@min, spkPlfmChETA,'UniformOutput',false);
           testLatPlfm = cell2mat(testLatPlfm);
       else
           testLatPlfm = cellfun(@max, spkPlfmChETA, 'UniformOutput',false);
           testLatPlfm = cell2mat(testLatPlfm);
       end
       if ~isempty(baseLatPlfm) & ~isempty(testLatPlfm)
           pLatencyPlfm = ranksum(baseLatPlfm,testLatPlfm);
           testLatencyPlfm = nanmedian(testLatPlfm);
       else
           pLatencyPlfm = nan;
           testLatencyPlfm = nan;
       end
    end
    if ~isempty(lightTime.Track8hz)
       spkTrackChETA = spikeWin(spikeData,lightTime.Track8hz,winTagChETA);
       if statDir_Track >= 0
           testLatTrack = cellfun(@min, spkTrackChETA,'UniformOutput',false);
           testLatTrack = cell2mat(testLatTrack);
       else
           testLatTrack = cellfun(@max, spkTrackChETA, 'UniformOutput',false);
           testLatTrack = cell2mat(testLatTrack);
       end
       if ~isempty(baseLatTrack) & ~isempty(testLatTrack)
           pLatencyTrack = ranksum(baseLatTrack,testLatTrack);
           testLatencyTrack = nanmedian(testLatTrack);
       else
           pLatencyTrack = nan;
           testLatencyTrack = nan;
       end
    end
    testLatencyPlfm = testLatencyPlfm + calibPlfm;
    testLatencyTrack = testLatencyTrack + calibTrack;
    save([cellName,'.mat'],'statDir_Plfm','testLatencyPlfm','baseLatencyPlfm','pLatencyPlfm','statDir_Track','testLatencyTrack','baseLatencyTrack','pLatencyTrack','-append');
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