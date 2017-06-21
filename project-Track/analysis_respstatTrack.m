function analysis_respstatTrack()
%tagstatCC calculates statistical significance using log-rank test
% Variables for log-rank test & salt test

testRange8hz = 8;
baseRange8hz = 100;
spkCri = 10; % spikes should be more than 10

allowance = 0.005; % 0.5% allowance for hazerd function.
movingWin = (0:2:8)';
alpha = 0.05/length(movingWin);

winLatency = [0 20];

warning('off','signal:findpeaks:largeMinPeakHeight');

if nargin == 0; sessionFolder = {}; end;
[tData, tList] = tLoad(sessionFolder);
matList = mLoad();
if isempty(tList); return; end;

nCell = length(tList);
for iCell = 1:nCell
    disp(['### Response stat analysis: ',tList{iCell}]);
    [cellPath,cellName,~] = fileparts(tList{iCell});
    cd(cellPath);

    load('Events.mat','lightTime','psdlightPre','psdlightPost');
    load(matList{iCell},'pethTrackLight');
    spikeData = tData{iCell};

    spkCriteria_Track8hz = spikeWin(spikeData,lightTime.Track8hz,[-50,50]);
  
%% Log-rank test
    [pLR_TrackT] = deal(zeros(5,1));
    [timeLR_TrackT,H1_TrackT,H2_TrackT] = deal(cell(5,1));
    
%% pLR_Track
    if sum(cell2mat(cellfun(@length,spkCriteria_Track8hz,'UniformOutput',false))) < spkCri
        [pLR_Track, statDir_Track, latencyTrack1st, latencyTrack2nd, timeLR_Track, H1_Track, H2_Track, calibTrack] = deal(NaN);
    else
        [baseTime, baseCensor] = tagDataLoad(spikeData, psdlightPre, testRange8hz, baseRange8hz);
        base = [reshape(baseTime(1:(end-1),:),1,[]);reshape(baseCensor(1:(end-1),:),1,[])]';
        for iWin = 1:length(movingWin)
            [timeTrack, censorTrack] = tagDataLoad(spikeData,lightTime.Track8hz+movingWin(iWin),testRange8hz,baseRange8hz);
%             [pLR_TrackTemp,timeLR_TrackT{iWin,1},H1_TrackT{iWin,1},H2_TrackT{iWin,1}] = logRankTest(timeTrack, censorTrack);
            test = [timeTrack(end,:);censorTrack(end,:)]';
            [pLR_TrackTemp,timeLR_TrackT{iWin,1},H1_TrackT{iWin,1},H2_TrackT{iWin,1}] = logrank(test,base);

            if isempty(pLR_TrackTemp)
                pLR_TrackTemp = 1;
            end
            pLR_TrackT(iWin,1) = pLR_TrackTemp;
        end
        if sum(double(isnan(pLR_TrackT))) == 5 % if all values are NaN, then do not calculate respstat. (no spikes at light zone)
            [pLR_Track, statDir_Track, latencyTrack1st, latencyTrack2nd, timeLR_Track, H1_Track, H2_Track, calibTrack, latencyTrack1stN, latencyTrack2ndN] = deal(NaN);
        else
            idxTrack = find(pLR_TrackT<alpha,1,'first');
            if isempty(idxTrack)
                idxTrack = 1;
            end
            idxH1_Track = find(~cellfun(@isempty,H1_TrackT));
            idxH2_Track = find(~cellfun(@isempty,H2_TrackT));
            idxcom_Track = idxH1_Track(idxH1_Track == idxH2_Track);
            for iTest = 1:length(idxcom_Track)
                testTrack(iTest) = all((H1_TrackT{iTest,:}-H2_TrackT{iTest,:})>= -max(H1_TrackT{iTest,:})*allowance) | all((H2_TrackT{iTest,:}-H1_TrackT{iTest,:})>= -max(H2_TrackT{iTest,:})*allowance);
            end
            idxH_Track = idxcom_Track(find(testTrack==1,1,'first'));
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

    % v2.0 (Based on H1, H2)
            if H1_Track(end) > H2_Track(end)
                statDir_Track = 1;
            elseif H1_Track(end) < H2_Track(end)
                statDir_Track = -1;
            else
                statDir_Track = 0;
            end
        
%% Latency (Moving win)
        [~,locTrack] = findpeaks(pethTrackLight,'minpeakheight',15); % check whether there are two peaks or not. if there are two peaks, calculate each peaek.
            switch (statDir_Track)
                case 1                
                    if length(locTrack) >= 2
                        spkLatency_Track1st = spikeWin(spikeData,lightTime.Track8hz,[0 9]);
                        temp_latencyTrack1st = cellfun(@min,spkLatency_Track1st,'UniformOutput',false);
                        temp_latencyTrack1st = nanmedian(cell2mat(temp_latencyTrack1st));

                        spkLatency_Track2nd = spikeWin(spikeData,lightTime.Track8hz,[11 20]);
                        temp_latencyTrack2nd = cellfun(@min,spkLatency_Track2nd,'UniformOutput',false);
                        temp_latencyTrack2nd = nanmedian(cell2mat(temp_latencyTrack2nd));
                    else
                        spkLatency_Track = spikeWin(spikeData,lightTime.Track8hz,winLatency);
                        temp_latencyTrack = cellfun(@min,spkLatency_Track,'UniformOutput',false);
                        temp_latencyTrack = nanmedian(cell2mat(temp_latencyTrack));
                    end
                case -1
                    spkLatency_Track = spikeWin(spikeData,lightTime.Track8hz,winLatency);
                    temp_latencyTrack = cellfun(@max,spkLatency_Track,'UniformOutput',false);
                    temp_latencyTrack = nanmedian(cell2mat(temp_latencyTrack));
                case 0
                    spkLatency_Track = spikeWin(spikeData,lightTime.Track8hz,winLatency);
                    temp_latencyTrack = 0;
            end
            if exist('temp_latencyTrack1st','var') & ~isnan(temp_latencyTrack1st)
                latencyTrack1st = temp_latencyTrack1st;
                latencyTrack2nd = temp_latencyTrack2nd;
            elseif exist('temp_latencyTrack1st','var') & isnan(temp_latencyTrack1st)
                latencyTrack1st = temp_latencyTrack2nd;
                latencyTrack2nd = NaN;
            else
                latencyTrack1st = temp_latencyTrack;
                latencyTrack2nd = NaN;
            end
        end
    end
    
    pLR_TrackN = pLR_Track;
    timeLR_TrackN = timeLR_Track;
    H1_TrackN = H1_Track;
    H2_TrackN = H2_Track;
    calibTrackN = calibTrack;
    statDir_TrackN = statDir_Track;
    latencyTrack1stN = latencyTrack1st;
    latencyTrack2ndN = latencyTrack2nd;

    save([cellName,'.mat'],'pLR_TrackN','timeLR_TrackN','H1_TrackN','H2_TrackN','calibTrackN','statDir_TrackN','latencyTrack1stN','latencyTrack2ndN','-append')

end
disp('### respstatTrack & Latency calculation are done!');

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