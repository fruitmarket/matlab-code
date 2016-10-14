function spectroTrack()
movingWin = [0.05 0.01];
params.Fs = 2000;
params.fpass = [0, 200];
params.pad = 0;
params.tapers = [3, 5];
p = 0.05;
params.err = [1, p];

winSpect = [-2000 2000];

load('Events.mat');

[timestamp, sample, cscList] = cscLoad;

channelSample = sample{1};
% [spectrum, time, frequencies, sError] = mtspecgramc(sample{1},movingWin,params);
idxS6 = zeros(nTrial,1);
idxS10 = zeros(nTrial,1);

for iTrial = 1:nTrial
    idxS6(iTrial,1) = find(sensor.S6(iTrial)<timestamp,1,'first');
    idxS10(iTrial,1) = find(sensor.S10(iTrial)<timestamp,1,'first');
    sampleS6(:,iTrial) = channelSample((idxS6(iTrial,1)-sensorWin(1)):(idxS6(iTrial,1)+sensorWin(2)));
    sampleS10(:,iTrial) = channelSample((idxS10(iTrial,1)-sensorWin(1)):(idxS10(iTrial,1)+sensorWin(2)));
end

% sampleTrackLight
% samplePlfmLight
cscData = cscWin(timestamp,sensor.S6,winSpect);
a= cscData;

function cscTime = cscWin(cscData, eventTime, win)
% spikeWin makes raw spikeData to eventTime aligned data
%   spikeData: raw data from MClust. Unit must be ms.
%   eventTime: each output cell will be eventTime aligned spike data. unit must be ms
%   win: spike within windows will be included. unit must be ms.
narginchk(3,3);
if isempty(eventTime); cscTime =[]; return; end;
nEvent = size(eventTime);
cscTime = cell(nEvent);
for iEvent = 1:nEvent(1)
    for jEvent = 1:nEvent(2)
        timeIndex = [];
        if isnan(eventTime(iEvent,jEvent)); continue; end;
        [~,timeIndex] = histc(cscData,eventTime(iEvent,jEvent)+win);
        if isempty(timeIndex); continue; end;
        cscTime{iEvent,jEvent} = cscData(logical(timeIndex))-eventTime(iEvent,jEvent);
    end
end