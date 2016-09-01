function tagstatTrack(sessionFolder)
%tagstatCC calculates statistical significance using log-rank test

% Variables for log-rank test & salt test
dt = 0.1;
testRangeTag = 10; % unit: ms 
baseRangeTag = 450; % baseline 
testRangeModu = 10; % 8Hz: 10 // 20Hz: 20
baseRangeModu = 100; % 8Hz: 110 // 20Hz: 15

% variables for latency calculation
winTagChETA = [-25, 100]; % unit: msec
winTagiC = [-500, 2000];
testRangeTag_lat = 30; % unit: ms 
baseRangeTag_lat = 450; % baseline 
testRangeModu_lat = 30; % 8Hz: 10 // 20Hz: 20
baseRangeModu_lat = 90; % 8Hz: 110 // 20Hz: 15

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
    
% Spike latency of test
    if isfield(lightTime,'Modu') && ~isempty(lightTime.Modu)
       spkModuChETA = spikeWin(spikeData,lightTime.Modu,winTagChETA);
       testLatModu = cellfun(@min, spkModuChETA,'UniformOutput',false);
       testLatModu = cell2mat(testLatModu);
       testLatModu = testLatModu(0<testLatModu & testLatModu<40); % calculate spikes which are between 0 ~ 40 ms
       testLatencyModu = median(testLatModu);
    end
    if isfield(lightTime,'Tag') && ~isempty(lightTime.Tag); % Activation (ChETA)
       spkTagChETA = spikeWin(spikeData,lightTime.Tag,winTagChETA);
       testLatTag = cellfun(@min, spkTagChETA,'UniformOutput',false);
       testLatTag = cell2mat(testLatTag);
       testLatTag = testLatTag(0<testLatTag & testLatTag<40);
       testLatencyTag = median(testLatTag);
    end
    [timeTag_lat, ~] = tagDataLoad(spikeData, lightTime.Tag, testRangeTag_lat, baseRangeTag_lat);
    baseLatTag = min(timeTag_lat);
    baseLatTag(find(baseLatTag==testRangeTag_lat)) = [];
    [timeModu_lat, ~] = tagDataLoad(spikeData, lightTime.Modu, testRangeModu_lat, baseRangeModu_lat);
    baseLatModu = min(timeModu_lat);
    baseLatModu(baseLatModu==testRangeModu_lat) = [];
    
% Rank sum test for latency (light response spike vs. spontaneous spike)
    if ~isempty(testLatModu) && ~isempty(baseLatModu)
            pLatencyModu = ranksum(testLatModu,baseLatModu);
    else
            pLatencyModu = 1;
    end
    if ~isempty(testLatTag) && ~isempty(baseLatTag)
            pLatencyTag = ranksum(testLatTag,baseLatTag);
    else
            pLatencyTag = 1;
    end
    
    save([cellName,'.mat'],'testLatencyModu','testLatencyTag','pLatencyModu','pLatencyTag','-append');
    
    if (testLatencyModu < 10) && (testLatencyTag < 10) % if the latency is shorter than 10ms, calib = 0ms. otherwize, apply 4ms calib for stat.
        calibStat = 0;
    else
        calibStat = 4;
    end
    
% Log-rank test    
    [timeTag, censorTag] = tagDataLoad(spikeData, lightTime.Tag+calibStat, testRangeTag, baseRangeTag);
    [timeModu, censorModu] = tagDataLoad(spikeData, lightTime.Modu+calibStat, testRangeModu, baseRangeModu);
    [pLR_tag,timeLR_tag,H1_tag,H2_tag] = logRankTest(timeTag, censorTag); % H1: light induced firing H2: baseline     
    [pLR_modu,timeLR_modu,H1_modu,H2_modu] = logRankTest(timeModu, censorModu);
    if isempty(pLR_modu)
        pLR_modu = 1;
    end
    save([cellName,'.mat'],...
        'pLR_tag','timeLR_tag','H1_tag','H2_tag','-append',...
        'pLR_modu','timeLR_modu','H1_modu','H2_modu','-append');
% Salt test
    [pSaltTag, lSaltTag] = saltTest(timeTag, testRangeTag, dt);
    [pSaltModu, lSaltModu] = saltTest(timeModu, testRangeModu, dt);
    if isempty(pSaltModu)
        pSaltModu = 1;
    end
    save([cellName,'.mat'],'pSaltTag','lSaltTag','pSaltModu','lSaltModu','-append');
    
% Modulation direction (activation/inactivation) & light latency
    if ~isempty(nonzeros(H1_tag)) && ~isempty(nonzeros(H2_tag))
        if H1_tag(end) > H2_tag(end)
            tagStatDir_tag = 1; % Activation
        else
            tagStatDir_tag = -1; % Inactivation
        end
    else
        tagStatDir_tag = 0; % No modulation
    end
    if isempty(lightTime.Modu);
        tagStatDir_modu = 2; % No modulation (No light stimulation on a track)
    else
        if ~isempty(nonzeros(H1_modu)) && ~isempty(nonzeros(H2_modu))
            if H1_modu(end) > H2_modu(end)
                tagStatDir_modu = 1;
            else
                tagStatDir_modu = -1;
            end
        else
            tagStatDir_modu = 0; % No light response
        end
    end
    save([cellName, '.mat'],'tagStatDir_tag','tagStatDir_modu','-append')
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
