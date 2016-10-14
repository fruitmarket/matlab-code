function spectroTrack()
sensorWin = [1000 1000]*2; % unit: msec

movingWin = [0.05 0.01]; % unit: sec
params.Fs = 2000; % unit: Hz
params.fpass = [0, 100];
params.pad = 0;
params.tapers = [3, 5];
params.trialave = 1; % 0: no average, 1: average trials
p = 0.05;
params.err = [1, p];

load('Events.mat');

[timestamp, sample, cscList] = cscLoad;

channelSample = sample{1};

idxS6 = zeros(nTrial,1);
idxS10 = zeros(nTrial,1);

sampleS6 = zeros((sum(sensorWin)+1),nTrial);
sampleS10 = zeros((sum(sensorWin)+1),nTrial);


for iTrial = 1:nTrial
    idxS6(iTrial,1) = find(sensor.S6(iTrial)<timestamp,1,'first');
    sampleS6(:,iTrial) = channelSample((idxS6(iTrial,1)-sensorWin(1)):(idxS6(iTrial,1)+sensorWin(2)));
    idxS10(iTrial,1) = find(sensor.S10(iTrial)<timestamp,1,'first');
    sampleS10(:,iTrial) = channelSample((idxS10(iTrial,1)-sensorWin(1)):(idxS10(iTrial,1)+sensorWin(2)));
end

[spectrum, time, frequencies, sError] = mtspecgramc(sampleS6/1000,movingWin,params);

plot_matrix(spectrum,time,frequencies)
% sampleTrackLight
% samplePlfmLight



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