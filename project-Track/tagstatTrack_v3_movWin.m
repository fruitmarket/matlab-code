function tagstatTrack_v3_movWin(sessionFolder)
%tagstatCC calculates statistical significance using log-rank test

% Variables for log-rank test & salt test
dt = 0.1;
testRangePlfm = 10; % unit: ms 
baseRangePlfm = 480; % baseline 
testRangeTrack = 10; % 8Hz: 10 // 20Hz: 20
baseRangeTrack = 100; % 8Hz: 110 // 20Hz: 15

% variables for latency calculation
winTagChETA = [0, 20]; % unit: msec
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
    
    load('Events.mat','lightTime');
    spikeData = tData{iCell};
    
% Light modulation direction (Actiavtion / inactivation / no change)
    spkPlfmChETA = spikeWin(spikeData,lightTime.Tag,winDirChETA);
    [xptPlfm,~,~,~,~,~] = rasterPETH(spkPlfmChETA,true(size(lightTime.Tag)),winDirChETA,binSizePlfmBlue,resolution,1);
    if ~iscell(xptPlfm)
         xptPlfm = {xptPlfm};
    end
    if sum(-20<xptPlfm{1} & xptPlfm{1}<0) < sum(0 <= xptPlfm{1} & xptPlfm{1}<20) % activation
        statDir_Plfm = 1;
    elseif sum(-20<xptPlfm{1} & xptPlfm{1}<0) > sum(0 <= xptPlfm{1} & xptPlfm{1}<20) % inactivation
        statDir_Plfm = -1;
    else
        statDir_Plfm = 0;
    end

    spkTrackChETA = spikeWin(spikeData,lightTime.Modu,winDirChETA);
    [xptTrack,~,~,~,~,~] = rasterPETH(spkTrackChETA,true(size(lightTime.Modu)),winDirChETA,binSizePlfmBlue,resolution,1);
    if ~iscell(xptTrack)
        xptTrack = {xptTrack};
    end
    if sum(-20<xptTrack{1} & xptTrack{1}<0) < sum(0 <= xptTrack{1} & xptTrack{1}<20) % activation
        statDir_Track = 1;
    elseif sum(-20<xptTrack{1} & xptTrack{1}<0) > sum(0 <= xptTrack{1} & xptTrack{1}<20) % inactivation
        statDir_Track = -1;
    else
        statDir_Track = 0;
    end

% Baseline spontaneous latency
    [timePlfm_lat, ~] = tagDataLoad(spikeData, lightTime.Tag, testRangeTag_lat, baseRangeTag_lat);
    baseLatPlfm = min(timePlfm_lat);
    baseLatPlfm(baseLatPlfm==testRangeTag_lat) = [];
    baseLatencyPlfm = median(baseLatPlfm);
    [timeTrack_lat, ~] = tagDataLoad(spikeData, lightTime.Modu, testRangeModu_lat, baseRangeModu_lat);
    baseLatTrack = min(timeTrack_lat);
    baseLatTrack(baseLatTrack==testRangeModu_lat) = [];
    baseLatencyTrack = median(baseLatTrack);

% Light induced spike latency
    if isfield(lightTime,'Tag') && ~isempty(lightTime.Tag); % Activation (ChETA)
       spkPlfmChETA = spikeWin(spikeData,lightTime.Tag,winTagChETA);
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
    
    if isfield(lightTime,'Modu') && ~isempty(lightTime.Modu)
       spkTrackChETA = spikeWin(spikeData,lightTime.Modu,winTagChETA);
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
    save([cellName,'.mat'],'statDir_Plfm','testLatencyPlfm','baseLatencyPlfm','pLatencyPlfm',...
        'statDir_Track','testLatencyTrack','baseLatencyTrack','pLatencyTrack','-append');
    
% Log-rank test
%%%%%%%%%%%%%%%%%%%%%%% On Modification %%%%%%%%%%%%%%%%%%%%%%%%
movingWin = (0:2:20)';
[pSaltPlfm,pSaltTrack,lSaltPlfm,lSaltTrack,pLR_Plfm,pLR_Track] = deal(zeros(20,1));
[timeLR_Plfm,H1_Plfm,H2_Plfm,timeLR_Track,H1_Track,H2_Track] = deal(cell(20,1));

for iWin = 1:11
    [timePlfm, censorPlfm] = tagDataLoad(spikeData, lightTime.Tag+movingWin(iWin), testRangePlfm, baseRangePlfm);
    [timeTrack, censorTrack] = tagDataLoad(spikeData, lightTime.Modu+movingWin(iWin), testRangeTrack, baseRangeTrack);
    
    [pSaltPlfm(iWin,1), lSaltPlfm(iWin,1)] = saltTest(timePlfm, testRangePlfm, dt);
    [pSaltTrack(iWin,1), lSaltTrack(iWin,1)] = saltTest(timeTrack, testRangeTrack, dt);
    if isempty(pSaltTrack)
        pSaltTrack(iWin,1) = 1;
    end
    
    [pLR_Plfm(iWin,1),timeLR_Plfm{iWin,1},H1_Plfm{iWin,1},H2_Plfm{iWin,1}] = logRankTest(timePlfm, censorPlfm); % H1: light induced firing H2: baseline     
    [pLR_Track(iWin,1),timeLR_Track{iWin,1},H1_Track{iWin,1},H2_Track{iWin,1}] = logRankTest(timeTrack, censorTrack);
end
% pLR_Plfm = min(pLR_Plfm);
% pLR_Track = min(pLR_Track);

% Too less spike will be not calculater for log-rank test (criteria: more than 10 spikes)
    spkCriteria_Plfm = spikeWin(spikeData,lightTime.Tag,[-20,100]);
    spkCriteria_Track = spikeWin(spikeData,lightTime.Modu,[-20,100]);
    if sum(cell2mat(cellfun(@length,spkCriteria_Plfm,'UniformOutput',false))) < 10 | isempty(pLR_Plfm) % if the # of spikes are less than 10, do not calculate pLR
        pLR_Plfm = 1;
    end
    if sum(cell2mat(cellfun(@length,spkCriteria_Track,'UniformOutput',false))) < 10 | isempty(pLR_Track)
        pLR_Track = 1;
    end
%     save([cellName, '.mat'],'pLR_Plfm','timeLR_Plfm','H1_Plfm','H2_Plfm','pLR_Track','timeLR_Track','H1_Track','H2_Track','-append')
    
% Salt test

%     save([cellName,'.mat'],'pSaltPlfm','lSaltPlfm','pSaltTrack','lSaltTrack','-append');    
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