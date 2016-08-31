function tagstatTrack(sessionFolder)
%tagstatCC calculates statistical significance using log-rank test

% Variables
dt = 0.1;
testRangeTag = 10; % unit: ms 
baseRangeTag = 450; % baseline 
testRangeModu = 10; % 8Hz: 10 // 20Hz: 20
baseRangeModu = 100; % 8Hz: 110 // 20Hz: 15
latencyTag = 0; % Disynaptic latency
latencyModu = 0; % Disynaptic latency

% Find files
if nargin == 0; sessionFolder = {}; end;
[tData, tList] = tLoad(sessionFolder);
if isempty(tList); return; end;

nCell = length(tList);
for iCell = 1:nCell
    disp(['### Tag stat test: ',tList{iCell}]);
    [cellPath,cellName,~] = fileparts(tList{iCell});
    cd(cellPath);
    
    clear lightTime
    load('Events.mat','lightTime');
    spikeData = tData{iCell};
    
%     [timeTag, censorTag] = tagDataLoad(spikeData, lightTime.Tag+latency, testRangeTag, baseRangeTag);
%     [timeModu, censorModu] = tagDataLoad(spikeData, lightTime.Modu+latency, testRangeModu, baseRangeModu);


% Baseline
    [timeTag, censorTag] = tagDataLoad(spikeData, lightTime.Tag+4, testRangeTag, baseRangeTag);
    [pLR_tag,timeLR_tag,H1_tag,H2_tag] = logRankTest(timeTag, censorTag); % H1: light induced firing H2: baseline    
    if ~isempty(nonzeros(H1_tag)) && ~isempty(nonzeros(H2_tag))
        latency = min(timeLR_tag(find((H1_tag(end)*3/10<H1_tag),1,'first'))); 
        if latency > 4
            calibTag = 4;
            [timeTag, censorTag] = tagDataLoad(spikeData, lightTime.Tag+calibTag, testRangeTag, baseRangeTag);
            [pLR_tag,timeLR_tag,H1_tag,H2_tag] = logRankTest(timeTag, censorTag); % H1: light induced firing H2: baseline
        else
            calibTag = 0;
        end
    end
    if isempty(pLR_tag)
        pLR_tag = 1;
    end
    
% Track
    [timeModu, censorModu] = tagDataLoad(spikeData, lightTime.Modu, testRangeModu, baseRangeModu);
    [pLR_modu,timeLR_modu,H1_modu,H2_modu] = logRankTest(timeModu, censorModu);
    if ~isempty(nonzeros(H1_modu)) && ~isempty(nonzeros(H2_modu))
        latency = min(timeLR_modu(find((H1_modu(end)*3/10<H1_modu),1,'first')));
        if latency > 4
            calibModu = 4;
            [timeModu, censorModu] = tagDataLoad(spikeData, lightTime.Modu+calibModu, testRangeModu, baseRangeModu);
            [pLR_modu,timeLR_modu,H1_modu,H2_modu] = logRankTest(timeModu, censorModu); % H1: light induced firing H2: baseline
        else
            calibModu = 0;
        end
    end  
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
    save([cellName,'.mat'],...
        'pSaltTag','lSaltTag',...
        'pSaltModu','lSaltModu','-append');

    % Modulation direction (activation/inactivation) & light latency
    if ~isempty(nonzeros(H1_tag)) && ~isempty(nonzeros(H2_tag))
        if H1_tag(end) > H2_tag(end)
            tagStatDir_tag = 1; % Activation
        else
            tagStatDir_tag = -1; % Inactivation
        end
        latency_tag = min(timeLR_tag(find((H1_tag(end)*3/10<H1_tag),1,'first')));
    else
        tagStatDir_tag = 0; % No light response
        latency_tag = NaN;
    end
    
    % Latency is calculated by the first point of 30% of H1_modu/tag(end)
    if isempty(lightTime.Modu);
        tagStatDir_modu = 2; % No modulation (No light stimulation on a track)
        latency_modu = NaN;
    else
        if ~isempty(nonzeros(H1_modu)) && ~isempty(nonzeros(H2_modu))
            if H1_modu(end) > H2_modu(end)
                tagStatDir_modu = 1;
            else
                tagStatDir_modu = -1;
            end
            latency_modu = min(timeLR_modu(find((H1_modu(end)*3/10<H1_modu),1,'first')));
        else
            tagStatDir_modu = 0; % No light response
            latency_modu = NaN;
        end
    end
    latencyTag = latency + latency_tag;
    latencyModu = latency + latency_modu;
    
    save([cellName, '.mat'],...
        'tagStatDir_tag','tagStatDir_modu','latencyTag','latencyModu','-append');
end
disp('### Tag stat test done!');

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
