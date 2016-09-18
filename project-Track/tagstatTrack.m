function tagstatTrack(sessionFolder)
%tagstatCC calculates statistical significance using log-rank test

% Variables for log-rank test & salt test
dt = 0.1;
testRangeTag = 20; % unit: ms 
baseRangeTag = 450; % baseline 
testRangeModu = 20; % 8Hz: 10 // 20Hz: 20
baseRangeModu = 100; % 8Hz: 110 // 20Hz: 15

% variables for latency calculation
winTagChETA = [0, 30]; % unit: msec
% winTagiC = [-500, 2000];
testRangeTag_lat = winTagChETA(2); % unit: ms
baseRangeTag_lat = 450; % baseline 
testRangeModu_lat = winTagChETA(2); % 8Hz: 10 // 20Hz: 20
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
% Baseline spontaneous latency
    [timeTag_lat, ~] = tagDataLoad(spikeData, lightTime.Tag, testRangeTag_lat, baseRangeTag_lat);
    baseLatTag = min(timeTag_lat);
    baseLatTag(baseLatTag==testRangeTag_lat) = [];
    baseLatencyTag = median(baseLatTag);
    [timeModu_lat, ~] = tagDataLoad(spikeData, lightTime.Modu, testRangeModu_lat, baseRangeModu_lat);
    baseLatModu = min(timeModu_lat);
    baseLatModu(baseLatModu==testRangeModu_lat) = [];
    baseLatencyModu = median(baseLatModu);
% Light induced spike latency
    if isfield(lightTime,'Modu') && ~isempty(lightTime.Modu)
       spkModuChETA = spikeWin(spikeData,lightTime.Modu,winTagChETA);
       testLatModu = cellfun(@min, spkModuChETA,'UniformOutput',false);
       testLatModu = cell2mat(testLatModu);
       latBinModu = histc(testLatModu,[0,4,8,20]); % 0~4ms / 4~8ms / 8~20ms
       idxModu = find(latBinModu>sum(latBinModu)*30/100);
       if isempty(idxModu)
           testLatModu_first = NaN;
           testLatModu_second = NaN;
           pLatencyModu_first = NaN;
           pLatencyModu_second = NaN;
       end
       if length(double(idxModu)) == 1;
           testLatModu_first = testLatModu;
           testLatModu_second = NaN;           
           if ~isnan(timeModu_lat) % Rank-sum test
               pLatencyModu_first = ranksum(baseLatModu,testLatModu_first);
           else
               pLatencyModu_first = NaN;
           end
           pLatencyModu_second = NaN;
       elseif length(double(idxModu)) == 2 || length(double(idxModu)) == 3;
           testLatModu_first = testLatModu(testLatModu<6);
           testLatModu_second = testLatModu(6<testLatModu & testLatModu<20);       
           if ~isnan(timeModu_lat) % Rank-sum test
               if ~isnan(testLatModu_first)
                   pLatencyModu_first = ranksum(baseLatModu,testLatModu_first);
               else
                   pLatencyModu_first = NaN;
               end
               if ~isnan(testLatModu_second)
                   pLatencyModu_second = ranksum(baseLatModu,testLatModu_second);
               else
                   pLatencyModu_second = NaN;
               end
           else
               pLatencyModu_first = NaN;
               pLatencyModu_second = NaN;
           end
       else
       end
       testLatencyModu_first = nanmedian(testLatModu_first);
       testLatencyModu_second = nanmedian(testLatModu_second);       
    end
    if isfield(lightTime,'Tag') && ~isempty(lightTime.Tag); % Activation (ChETA)
       spkTagChETA = spikeWin(spikeData,lightTime.Tag,winTagChETA);
       testLatTag = cellfun(@min, spkTagChETA,'UniformOutput',false);
       testLatTag = cell2mat(testLatTag);
       latBinTag = histc(testLatTag,[0,4,8,20]);  % 0~4ms / 4~8ms / 8~20ms
       idxTag = find(latBinTag>sum(latBinTag)*30/100);
       if isempty(idxTag)
           testLatTag_first = NaN;
           testLatTag_second = NaN;
           pLatencyTag_first = NaN;
           pLatencyTag_second = NaN;
       end
       if length(double(idxTag)) == 1;
           testLatTag_first = testLatTag;
           testLatTag_second = NaN;       
           if ~isnan(timeTag_lat);
               pLatencyTag_first = ranksum(baseLatTag,testLatTag_first); % Rank-sum test               
           else
               pLatencyTag_first = NaN;               
           end
           pLatencyTag_second = NaN;
       elseif length(double(idxTag)) == 2 || length(double(idxTag)) == 3;
           testLatTag_first = testLatTag(testLatTag<6);
           testLatTag_second = testLatTag(6<testLatTag & testLatTag<20);       
           if ~isnan(timeTag_lat)
               if ~isnan(testLatTag_first)
                   pLatencyTag_first = ranksum(baseLatTag,testLatTag_first); % Rank-sum test
               else
                   pLatencyTag_first = NaN;
               end
               if ~isnan(testLatTag_second)
                   pLatencyTag_second = ranksum(baseLatTag,testLatTag_second);
               else
                   pLatencyTag_second = NaN;
               end
           else
               pLatencyTag_first = NaN;
               pLatencyTag_second = NaN;
           end
       else
       end
       testLatencyTag_first = nanmedian(testLatTag_first);
       testLatencyTag_second = nanmedian(testLatTag_second);
    end
    save([cellName,'.mat'],'testLatencyModu_first','testLatencyModu_second','testLatencyTag_first','testLatencyTag_second',...
        'baseLatencyModu','baseLatencyTag','pLatencyModu_first','pLatencyModu_second',...
        'pLatencyTag_first','pLatencyTag_second','-append');
    
    if (idxModu==1) & (idxTag==1);
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
            statDir_tag = 1; % Activation
            ina_lastSpk_tag = NaN;
            ina_firstSpk_tag = NaN;
        else
            statDir_tag = -1; % Inactivation
            inaSpk_1sthalf = spikeWin(spikeData,lightTime.Modu,[0, 15]);
            ina_lastSpk_tag = cellfun(@max,inaSpk_1sthalf,'UniformOutput',false);
            ina_lastSpk_tag = median(cell2mat(ina_lastSpk_tag));
            
            inaSpk_2ndhalf = spikeWin(spikeData,lightTime.Modu,[15,30]);
            ina_firstSpk_tag = cellfun(@min, inaSpk_2ndhalf,'UniformOutput',false);
            ina_firstSpk_tag = median(cell2mat(ina_firstSpk_tag));
            
            if ina_lastSpk_tag > 4
            calibStat = 4;
            [timeTag, censorTag] = tagDataLoad(spikeData, lightTime.Tag+calibStat, testRangeTag, baseRangeTag);
            [pLR_tag,timeLR_tag,H1_tag,H2_tag] = logRankTest(timeTag, censorTag);
            end
        end
    else
        statDir_tag = 0; % No modulation
        ina_lastSpk_tag = NaN;
        ina_firstSpk_tag = NaN;
    end
    if isempty(lightTime.Modu);
        statDir_modu = 2; % No modulation (No light stimulation on a track)
    else
        if ~isempty(nonzeros(H1_modu)) && ~isempty(nonzeros(H2_modu))
            if H1_modu(end) > H2_modu(end)
                statDir_modu = 1;
                ina_lastSpk_modu = NaN;
                ina_firstSpk_modu = NaN;
            else
                statDir_modu = -1;
                inaSpk_1sthalf = spikeWin(spikeData,lightTime.Modu,[0, 15]);
                ina_lastSpk_modu = cellfun(@min,inaSpk_1sthalf,'UniformOutput',false);
                ina_lastSpk_modu = median(cell2mat(ina_lastSpk_modu));
                
                inaSpk_2ndhalf = spikeWin(spikeData,lightTime.Modu,[15,30]);
                ina_firstSpk_modu = cellfun(@min, inaSpk_2ndhalf,'UniformOutput',false);
                ina_firstSpk_modu = median(cell2mat(ina_firstSpk_modu));
                
                if ina_lastSpk_modu > 4;
                calibStat = 4;
                [timeModu, censorModu] = tagDataLoad(spikeData, lightTime.Modu+calibStat, testRangeModu, baseRangeModu);
                [pLR_modu,timeLR_modu,H1_modu,H2_modu] = logRankTest(timeModu, censorModu);
                end
            end
        else
            statDir_modu = 0; % No light response
            ina_lastSpk_modu = NaN;
            ina_firstSpk_modu = NaN;
        end
    end
    save([cellName, '.mat'],'statDir_tag','statDir_modu','ina_lastSpk_tag','ina_firstSpk_tag','ina_lastSpk_modu','ina_firstSpk_modu',...
        'pLR_tag','timeLR_tag','H1_tag','H2_tag','pLR_modu','timeLR_modu','H1_modu','H2_modu','-append')
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