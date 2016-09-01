function latencyLight()
% latencyLight calculates light response spike latencies (test) and the control
% (base) of those. The maximum latency is set to 30ms, so it could yield
% incorrect p-value. (calibrate the max. latency)
%
% 1. Calculate each spike latencies (Base, Test)
% 2. Rank sum test (Base vs. Test)
%
% Author: Joonyeup Lee
% Version 1.0 (9. 1. 2016)
%

winTagChETA = [-25, 100]; % unit: msec
winTagiC = [-500, 2000];
testRangeTag = 30;
baseRangeTag = 450;
testRangeModu = 30;
baseRangeModu = 90;
latency = 0;

[tData, tList] = tLoad;
nCell = length(tList);

for iCell = 1:nCell
    disp(['### Analyzing ', tList{iCell},'...']);
    [cellPath, cellName, ~] = fileparts(tList{iCell});
    cd(cellPath);
    
    load('Events.mat');
    spikeData = tData{iCell};
    
    % Spike latency of test
    if isfield(lightTime,'Modu') && ~isempty(lightTime.Modu)
       spkModuChETA = spikeWin(spikeData,lightTime.Modu+latency,winTagChETA);
       testLatModu = cellfun(@min, spkModuChETA,'UniformOutput',false);
       testLatModu = cell2mat(testLatModu);
       testLatModu = testLatModu(testLatModu>0);
       testLatencyModu = median(testLatModu);
       if testLatencyModu > 60 % in case of no light response, latency is 30ms
           testLatencyModu = 60;
       end
    end
    
    if isfield(lightTime,'Tag') && ~isempty(lightTime.Tag); % Activation (ChETA)
       spkTagChETA = spikeWin(spikeData,lightTime.Tag+latency,winTagChETA);
       testLatTag = cellfun(@min, spkTagChETA,'UniformOutput',false);
       testLatTag = cell2mat(testLatTag);
       testLatTag = testLatTag(testLatTag>0);
       testLatencyTag = median(testLatTag);
       if testLatencyTag > 60; % in case of no light response, latency is 30ms
           testLatencyTag = 60;
       end
    end
        
    % Spike latency of base
    [timeTag, ~] = tagDataLoad(spikeData, lightTime.Tag, testRangeTag, baseRangeTag);
    baseLatTag = min(timeTag);
    baseLatTag(find(baseLatTag==10)) = [];
    
    [timeModu, ~] = tagDataLoad(spikeData, lightTime.Modu, testRangeModu, baseRangeModu);
    baseLatModu = min(timeModu);
    baseLatModu(find(baseLatModu==10)) = [];
    
    % Rank sum test
    if 0 < testLatencyModu && testLatencyModu < 60
        pLatencyModu = ranksum(testLatModu,baseLatModu);
    else
        pLatencyModu = 1;
    end
    if 0 < testLatencyTag && testLatencyTag < 60
        pLatencyTag = ranksum(testLatTag,baseLatTag);
    else
        pLatencyTag = 1;
    end    
    save([cellName,'.mat'],'testLatencyModu','testLatencyTag','pLatencyModu','pLatencyTag','-append');        
end
disp('### Light latency test done!');

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

function [time, censor] = tagDataLoad(spikeData, onsetTime, testRange, baseRange)
%tagDataLoad makes dataset for statistical tests
%   spikeData: raw data from MClust t file (in msec)
%   onsetTime: time of light stimulation (in msec)
%   testRange: binning time range for test (in msec)
%   baseRange: binning time range for baseline (in msec)
%
%   time: nBin (nBin-1 number of baselines and 1 test) x nLightTrial
%
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