function tagstatTrack(sessionFolder)
%tagstatCC calculates statistical significance using log-rank test

% Variables
dt = 0.1;
testRangeTag = 20; % unit: ms 
baseRangeTag = 400; % baseline 
testRangeModu = 20; % 8Hz: 20 // 20Hz: 20
baseRangeModu = 80; % 8Hz: 100 // 20Hz: 15

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
    
    [timeTag, censorTag] = tagDataLoad(spikeData, lightTime.Tag, testRangeTag, baseRangeTag);
    [timeModu, censorModu] = tagDataLoad(spikeData, lightTime.Modu, testRangeModu, baseRangeModu);
    
    [p_tag,time_tag,H1_tag,H2_tag] = logRankTest(timeTag, censorTag);
    save([cellName,'.mat'],...
        'p_tag','time_tag','H1_tag','H2_tag','-append');
      
    [p_modu,time_modu,H1_modu,H2_modu] = logRankTest(timeModu, censorModu);
    if isempty(p_modu)
        p_modu = 1;
    end
    save([cellName,'.mat'],...
        'p_modu','time_modu','H1_modu','H2_modu','-append');
    
    [p_saltTag, l_saltTag] = saltTest(timeTag, testRangeTag, dt);
    save([cellName,'.mat'],...
        'p_saltTag','l_saltTag','-append');
    
    [p_saltModu, l_saltModu] = saltTest(timeModu, testRangeModu, dt);
    if isempty(p_saltModu)
        p_saltModu = 1;
    end
    save([cellName,'.mat'],...
        'p_saltModu','l_saltModu','-append');
    
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
bin = [-floor(baseRange/testRange)*testRange:testRange:0]; % because of the latency (5ms), changed from 0 to 5.
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
