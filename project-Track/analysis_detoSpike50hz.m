function analysis_detoSpike50hz()
% m_deto_spkTrack50hz or Plfm50hz: mean number of spikes activated by each light
%
%
winCri = [0, 20]; % time duration which are interested in
[tData, tList] = tLoad;
nCell = length(tList);
nLap = 30;
load Events.mat

lightIdxTrack50hz = [];
lightTrack50hz = lightTime.Track50hz;
lapLightIdx = [1;(find(diff(lightTrack50hz)>1000)+1)]; % find start light of each lap
minPulseTrack50hz = min([diff(lapLightIdx);(length(lightTrack50hz)-lapLightIdx(end)+1)]);

for iLap = 1:nLap
    temp_lightIdx = lapLightIdx(iLap):lapLightIdx(iLap)+minPulseTrack50hz-1 ;
    lightIdxTrack50hz = [lightIdxTrack50hz;temp_lightIdx'];
end

if isfield(lightTime,'Plfm50hz') & ~isempty(lightTime.Plfm50hz)
    lightIdxPlfm50hz = [];
    lightPlfm50hz = lightTime.Plfm50hz;
    lapLightIdx = [1;(find(diff(lightPlfm50hz)>1000)+1)]; % find start light of each lap
    minPulsePlfm50hz = min([diff(lapLightIdx);(length(lightPlfm50hz)-lapLightIdx(end)+1)]);
    for iLap = 1:nLap
        temp_lightIdx = lapLightIdx(iLap):lapLightIdx(iLap)+minPulsePlfm50hz-1 ;
        lightIdxPlfm50hz = [lightIdxPlfm50hz;temp_lightIdx'];
    end
end

% if isfield(lightTime,'Track2hz') & ~isempty(lightTime.Track2hz)
%     lightIdxTrack2hz = [];
%     lightTrack2hz = lightTime.Track2hz;
%     lapLightIdx = [1;(find(diff(lightTrack2hz)>1000)+1)]; % find start light of each lap
%     minPulse = min(diff(lapLightIdx));
%     for iLap = 1:nLap
%         temp_lightIdx = lapLightIdx(iLap):lapLightIdx(iLap)+minPulse-1 ;
%         lightIdxTrack2hz = [lightIdxTrack2hz;temp_lightIdx'];
%     end
% end

for iCell = 1:nCell
    disp(['### detoSpike analysis: ',tList{iCell},'...']);
    [cellPath, cellName, ~] = fileparts(tList{iCell});
    cd(cellPath);
    
    spkTimeTrack50hz = spikeWin(tData{iCell},lightTrack50hz(lightIdxTrack50hz),winCri);
    deto_spkTrack50hz = ~cellfun(@isempty, spkTimeTrack50hz); % even though the light evoked severalspikes count as one spike
    evo_spkTrack50hz = cellfun(@length, spkTimeTrack50hz); % count all spikes
    m_deto_spkTrack50hz = mean(reshape(deto_spkTrack50hz,[minPulseTrack50hz,nLap]),2)'; % fidelity
    evoSpkTrack50hz = sum(reshape(evo_spkTrack50hz,[minPulseTrack50hz,nLap]),2)'; % number of spikes
     
    if ~isempty(lightTime.Plfm50hz)
        spkTimePlfm50hz = spikeWin(tData{iCell},lightPlfm50hz,winCri);
        deto_spkPlfm50hz = ~cellfun(@isempty, spkTimePlfm50hz);
        evo_spkPlfm50hz = cellfun(@length, spkTimePlfm50hz);
        m_deto_spkPlfm50hz = mean(reshape(deto_spkPlfm50hz,[minPulsePlfm50hz,nLap]),2)';
        evoSpkPlfm50hz = sum(reshape(evo_spkPlfm50hz,[minPulsePlfm50hz,nLap]),2)';
    else
        deto_spkPlfm50hz = NaN;
        m_deto_spkPlfm50hz = NaN;
        evoSpkPlfm50hz = NaN;
    end

%     if ~isempty(lightTime.Track2hz)
%         spkTimeTrack2hz = spikeWin(tData{iCell},lightTrack2hz,winCri);
%         deto_spkTrack2hz = cellfun(@length, spkTimeTrack2hz);
%         m_deto_spkTrack2hz = mean(reshape(deto_spkTrack2hz,[minPulse,nLap]),2);
%     else
%         deto_spkTrack2hz = NaN;
%         m_deto_spkTrack2hz = NaN;
%     end
    save([cellName,'.mat'],'m_deto_spkTrack50hz','m_deto_spkPlfm50hz','evoSpkTrack50hz','evoSpkPlfm50hz','-append');
end
disp('### detonate spike calculation is done! ###')
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