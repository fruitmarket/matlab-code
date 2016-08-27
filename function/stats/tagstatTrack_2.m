function stats = tagstatTrack_2()
%tagstatWM does statistical tests for optogenetic tagging

% if nargin == 0; stats = []; return; end;
[tData, tList] = tLoad();
% if isempty(tList); return; end;

% Variables
dt = 0.1;
testWindow = 10;
baseWindow = 100;
latency = 4;

nT = length(tList);
[pSalt, lSalt, pLR] = deal(zeros(nT, 1));
[timeLR, H1LR, H2LR] = deal({});
for iT = 1:nT
    disp(['### Analyzing ', tList{iT}]);
    [cellPath, cellName,~] = fileparts(tList{iT});

    load([cellPath,'\Events.mat'], 'lightTime');
    lighttime = lightTime.Modu+latency;

    [spikeLatency, spikeCensor] = tagDataLoad(tData{iT}, lighttime', testWindow, baseWindow);

    [pSalt(iT), lSalt(iT)] = saltTest(spikeLatency, testWindow, dt);
    [pLR(iT), time, H1, H2] = logRankTest(spikeLatency, spikeCensor);
    timeLR = [timeLR; {time}];
    H1LR = [H1LR; {H1}];
    H2LR = [H2LR; {H2}];
end
stats = table(pSalt, lSalt, pLR, timeLR, H1LR, H2LR);

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
lightBin = repmat(onsetTime,nBin,1)+binMat';
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