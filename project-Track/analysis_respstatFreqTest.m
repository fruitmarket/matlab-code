function analysis_respstatFreqTest()
%respstatPlfm calculates statistical significance using log-rank test

% Variables for log-rank test & salt test
testRange8hz = 8;
testRange2hz = 8;

baseRange8hz = 80;
baseRange2hz = 450;

spkCriPlfm = 10;

movingWin = (0:2:8)';
alpha = 0.05/length(movingWin);
allowance = 0.005; % 0.5% allowance for hazerd function.

% Load data
if nargin == 0; sessionFolder = {}; end;
[tData, tList] = tLoad(sessionFolder);
if isempty(tList); return; end;

nCell = length(tList);
for iCell = 1:nCell
    disp(['### Response stat test: ',tList{iCell}]);
    [cellPath,cellName,~] = fileparts(tList{iCell});
    cd(cellPath);

    load('Events.mat','lightTime');
    spikeData = tData{iCell};

    spkCriteria_Plfm2hz = spikeWin(spikeData,lightTime.Plfm2hz,[-50,50]);      
    spkLatency_Plfm2hz = spikeWin(spikeData,lightTime.Plfm2hz,[0,25]);
    
    spkCriteria_Plfm8hz = spikeWin(spikeData,lightTime.Plfm8hz,[-50,50]);
    spkLatency_Plfm8hz = spikeWin(spikeData,lightTime.Plfm8hz,[0,25]);

%% Log-rank test
    [pLR_Plfm2hzT,pLR_Plfm8hzT] = deal(zeros(10,1));
    [timeLR_Plfm2hzT,H1_Plfm2hzT,H2_Plfm2hzT,timeLR_Plfm8hzT,H1_Plfm8hzT,H2_Plfm8hzT] = deal(cell(10,1));
%% pLR_Plfm2hz
    if sum(cell2mat(cellfun(@length,spkCriteria_Plfm2hz,'UniformOutput',false))) < spkCriPlfm % if the # of spikes are less than spkCri, do not calculate pLR
        pLR_Plfm2hz = 1;
        [statDir_Plfm2hz, latencyPlfm2hz, timeLR_Plfm2hz, H1_Plfm2hz, H2_Plfm2hz, calibPlfm2hz] = deal(0);
    else
        for iWin = 1:10
            [timePlfm2hz, censorPlfm2hz] = tagDataLoad(spikeData, lightTime.Plfm2hz+movingWin(iWin), testRange2hz, baseRange2hz);
            [pLR_Plfm2hzTemp,timeLR_Plfm2hzT{iWin,1},H1_Plfm2hzT{iWin,1},H2_Plfm2hzT{iWin,1}] = logRankTest(timePlfm2hz, censorPlfm2hz); % H1: light induced firing H2: baseline
            if isempty(pLR_Plfm2hzTemp)
                pLR_Plfm2hzTemp = 1;
            end
            pLR_Plfm2hzT(iWin,1) = pLR_Plfm2hzTemp;
        end
        idxPlfm2hz = find(pLR_Plfm2hzT<alpha,1,'first');
        if isempty(idxPlfm2hz)
            idxPlfm2hz = 1;
        end
        idxH1_Plfm2hz = find(~cellfun(@isempty,H1_Plfm2hzT));
        idxH2_Plfm2hz = find(~cellfun(@isempty,H2_Plfm2hzT));
        idxcom_Plfm2hz = idxH1_Plfm2hz(idxH1_Plfm2hz == idxH2_Plfm2hz);
        for iTest = 1:length(idxcom_Plfm2hz)
            testPlfm(iTest) = all((H1_Plfm2hzT{iTest,:}-H2_Plfm2hzT{iTest,:}) >= -max(H1_Plfm2hzT{iTest,:})*allowance) | all((H2_Plfm2hzT{iTest,:}-H1_Plfm2hzT{iTest,:}) >= -max(H2_Plfm2hzT{iTest,:})*allowance); % H1 should all bigger or smaller than H2 (0.1% allowance)
        end
        idxH_Plfm2hz = idxcom_Plfm2hz(find(testPlfm==1,1,'first'));
%         H1Start = cellfun(@(x) x(1), H1_PlfmT(idxH1_Plfm,1));
%         H1End = cellfun(@(x) x(end), H1_PlfmT(idxH1_Plfm,1));
%         H2Start = cellfun(@(x) x(1), H2_PlfmT(idxH2_Plfm,1));
%         H2End = cellfun(@(x) x(end), H2_PlfmT(idxH2_Plfm,1));
%         HproductPlfm = (H1Start-H1End).*(H2Start-H2End);
%         idxHPlfm = find(HproductPlfm~=-1,1,'first');
        if isempty(idxH_Plfm2hz)
            idxH_Plfm2hz = 1;
        end
        if idxPlfm2hz >= idxH_Plfm2hz
            pLR_Plfm2hz = pLR_Plfm2hzT(idxPlfm2hz);
            timeLR_Plfm2hz = timeLR_Plfm2hzT{idxPlfm2hz};        
            H1_Plfm2hz = H1_Plfm2hzT{idxPlfm2hz};
            H2_Plfm2hz = H2_Plfm2hzT{idxPlfm2hz};
            calibPlfm2hz = movingWin(idxPlfm2hz);
        else
            pLR_Plfm2hz = pLR_Plfm2hzT(idxH_Plfm2hz);
            timeLR_Plfm2hz = timeLR_Plfm2hzT{idxH_Plfm2hz};        
            H1_Plfm2hz = H1_Plfm2hzT{idxH_Plfm2hz};
            H2_Plfm2hz = H2_Plfm2hzT{idxH_Plfm2hz};
            calibPlfm2hz = movingWin(idxH_Plfm2hz);
        end
        
% Modulation direction (Platform)
    % v1.0 (based on spike counts)
%         spkPlfmChETA = spikeWin(spikeData,lightTime.Plfm2hz+movingWin(idxPlfm2hz),winTest);
%         [xptPlfm2hz,~,~,~,~,~] = rasterPETH(spkPlfmChETA,true(size(lightTime.Plfm2hz)),winTest,binSize,resolution,1);
%         if ~iscell(xptPlfm2hz)
%              xptPlfm2hz = {xptPlfm2hz};
%         end
%         if sum(winTest(1)<xptPlfm2hz{1} & xptPlfm2hz{1}<0)*1.1 < sum(0 <= xptPlfm2hz{1} & xptPlfm2hz{1}<winTest(2)) % activation (10%)
%             statDir_Plfm2hz = 1;
%         elseif sum(winTest(1)<xptPlfm2hz{1} & xptPlfm2hz{1}<0) > sum(0 <= xptPlfm2hz{1} & xptPlfm2hz{1}<winTest(2))*0.9 % inactivation (10%)
%             statDir_Plfm2hz = -1;
%         else % no change
%             statDir_Plfm2hz = 0;
%         end

% v2.0 (based on H1, H2)
        if H1_Plfm2hz(end)>H2_Plfm2hz(end)
            statDir_Plfm2hz = 1;
        elseif H1_Plfm2hz(end)<H2_Plfm2hz(end)
            statDir_Plfm2hz = -1;            
        else
            statDir_Plfm2hz = 0;
        end
        
% Latency (Platform) 
        switch (statDir_Plfm2hz)
            case 1 % activation
                temp_latencyPlfm2hz = cellfun(@min,spkLatency_Plfm2hz,'UniformOutput',false);
                temp_latencyPlfm2hz = nanmedian(cell2mat(temp_latencyPlfm2hz));
            case -1 % inactivation
                temp_latencyPlfm2hz = cellfun(@max,spkLatency_Plfm2hz,'UniformOutput',false);
                temp_latencyPlfm2hz = nanmedian(cell2mat(temp_latencyPlfm2hz));
            case 0
                temp_latencyPlfm2hz = 0;
        end
        latencyPlfm2hz = temp_latencyPlfm2hz;
    end
    
%% pLR_Plfm8hz
    if ~isnan(lightTime.Plfm8hz)
        if sum(cell2mat(cellfun(@length,spkCriteria_Plfm8hz,'UniformOutput',false))) < spkCriPlfm % if the # of spikes are less than 10, do not calculate pLR
            pLR_Plfm8hz = 1; 
            [statDir_Plfm8hz, latencyPlfm8hz, timeLR_Plfm8hz, H1_Plfm8hz, H2_Plfm8hz, calibPlfm8hz] = deal(0);
        else
            for iWin = 1:10
                [timePlfm8hz, censorPlfm8hz] = tagDataLoad(spikeData, lightTime.Plfm8hz+movingWin(iWin), testRange8hz, baseRange8hz);
                [pLR_Plfm8hzTemp,timeLR_Plfm8hzT{iWin,1},H1_Plfm8hzT{iWin,1},H2_Plfm8hzT{iWin,1}] = logRankTest(timePlfm8hz, censorPlfm8hz); % H1: light induced firing H2: baseline
                if isempty(pLR_Plfm8hzTemp)
                    pLR_Plfm8hzTemp = 1;
                end
                pLR_Plfm8hzT(iWin,1) = pLR_Plfm8hzTemp;
            end
            idxPlfm8hz = find(pLR_Plfm8hzT<alpha,1,'first');
            if isempty(idxPlfm8hz)
                idxPlfm8hz = 1;
            end
            idxH1_Plfm8hz = find(~cellfun(@isempty,H1_Plfm8hzT));
            idxH2_Plfm8hz = find(~cellfun(@isempty,H2_Plfm8hzT));
            idxcom_Plfm8hz = idxH1_Plfm8hz(idxH1_Plfm8hz == idxH2_Plfm8hz);
            for iTest = 1:length(idxcom_Plfm8hz)
                testPlfm(iTest) = all((H1_Plfm8hzT{iTest,:}-H2_Plfm8hzT{iTest,:}) >= - max(H1_Plfm8hzT{iTest,:})*allowance) | all((H2_Plfm8hzT{iTest,:}-H1_Plfm8hzT{iTest,:}) >= -max(H2_Plfm8hzT{iTest,:}));
            end
            idxH_Plfm8hz = idxcom_Plfm8hz(find(testPlfm==1,1,'first'));

            if isempty(idxH_Plfm8hz)
                idxH_Plfm8hz = 1;
            end
            if idxPlfm8hz >= idxH_Plfm8hz
                pLR_Plfm8hz = pLR_Plfm8hzT(idxPlfm8hz);
                timeLR_Plfm8hz = timeLR_Plfm8hzT{idxPlfm8hz};        
                H1_Plfm8hz = H1_Plfm8hzT{idxPlfm8hz};
                H2_Plfm8hz = H2_Plfm8hzT{idxPlfm8hz};
                calibPlfm8hz = movingWin(idxPlfm8hz);
            else
                pLR_Plfm8hz = pLR_Plfm8hzT(idxH_Plfm8hz);
                timeLR_Plfm8hz = timeLR_Plfm8hzT{idxH_Plfm8hz};        
                H1_Plfm8hz = H1_Plfm8hzT{idxH_Plfm8hz};
                H2_Plfm8hz = H2_Plfm8hzT{idxH_Plfm8hz};
                calibPlfm8hz = movingWin(idxH_Plfm8hz);
            end

% Modulation direction (Platform)
    % v1.0 (based on spike counts)
%             spkPlfmChETA = spikeWin(spikeData,lightTime.Plfm8hz+movingWin(idxPlfm8hz),winTest);
%             [xptPlfm8hz,~,~,~,~,~] = rasterPETH(spkPlfmChETA,true(size(lightTime.Plfm8hz)),winTest,binSize,resolution,1);
%             if ~iscell(xptPlfm8hz)
%                  xptPlfm8hz = {xptPlfm8hz};
%             end
%             if sum(winTest(1)<xptPlfm8hz{1} & xptPlfm8hz{1}<0)*1.1 < sum(0 <= xptPlfm8hz{1} & xptPlfm8hz{1}<winTest(2)) % activation (10%)
%                 statDir_Plfm8hz = 1;
%             elseif sum(winTest(1)<xptPlfm8hz{1} & xptPlfm8hz{1}<0) > sum(0 <= xptPlfm8hz{1} & xptPlfm8hz{1}<winTest(2))*0.9 % inactivation (10%)
%                 statDir_Plfm8hz = -1;
%             else % no change
%                 statDir_Plfm8hz = 0;
%             end
            
% v2.0 (based on H1, H2)
            if H1_Plfm8hz(end)>H2_Plfm8hz(end)
                statDir_Plfm8hz = 1;
            elseif H1_Plfm8hz(end)<H2_Plfm8hz(end)
                statDir_Plfm8hz = -1;            
            else
                statDir_Plfm8hz = 0;
            end

% Latency (Platform) 
            switch (statDir_Plfm8hz)
                case 1 % activation
                    temp_latencyPlfm8hz = cellfun(@min,spkLatency_Plfm8hz,'UniformOutput',false);
                    temp_latencyPlfm8hz = nanmedian(cell2mat(temp_latencyPlfm8hz));
                case -1 % inactivation
                    temp_latencyPlfm8hz = cellfun(@max,spkLatency_Plfm8hz,'UniformOutput',false);
                    temp_latencyPlfm8hz = nanmedian(cell2mat(temp_latencyPlfm8hz));
                case 0
                    temp_latencyPlfm8hz = 0;
            end
            latencyPlfm8hz = temp_latencyPlfm8hz;
        end
    else
        [pLR_Plfm8hz, timeLR_Plfm8hz, H1_Plfm8hz, H2_Plfm8hz, calibPlfm8hz, statDir_Plfm8hz, latencyPlfm8hz] = deal(NaN);
    end

    save([cellName,'.mat'],...
        'pLR_Plfm2hz','timeLR_Plfm2hz','H1_Plfm2hz','H2_Plfm2hz','calibPlfm2hz','statDir_Plfm2hz','latencyPlfm2hz',...
        'pLR_Plfm8hz','timeLR_Plfm8hz','H1_Plfm8hz','H2_Plfm8hz','calibPlfm8hz','statDir_Plfm8hz','latencyPlfm8hz')
        
end
disp('### RespStatTest & Latency calculation are done!');

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
