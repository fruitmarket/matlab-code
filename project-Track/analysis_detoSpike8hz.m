function analysis_detoSpike8hz()
% m_deto_spkTrack8hz or Plfm8hz: mean number of spikes activated by each light
%
%
winCri = [0, 10]; % time duration which are interested in
[tData, tList] = tLoad;
nCell = length(tList);
nLap = 30;
load Events.mat

lightIdxTrack8hz = [];
lightTrack8hz = lightTime.Track8hz;
lapLightIdx = [1;(find(diff(lightTrack8hz)>1000)+1)]; % find start light of each lap
minPulseTrack8hz = min([diff(lapLightIdx);(length(lightTrack8hz)-lapLightIdx(end)+1)]);

for iLap = 1:nLap
    temp_lightIdx = lapLightIdx(iLap):lapLightIdx(iLap)+minPulseTrack8hz-1 ;
    lightIdxTrack8hz = [lightIdxTrack8hz;temp_lightIdx'];
end

if isfield(lightTime,'Plfm8hz') & ~isempty(lightTime.Plfm8hz)
    lightIdxPlfm8hz = [];
    lightPlfm8hz = lightTime.Plfm8hz;
    lapLightIdx = [1;(find(diff(lightPlfm8hz)>1000)+1)]; % find start light of each lap
    minPulsePlfm8hz = min([diff(lapLightIdx);(length(lightPlfm8hz)-lapLightIdx(end)+1)]);
    for iLap = 1:nLap
        temp_lightIdx = lapLightIdx(iLap):lapLightIdx(iLap)+minPulsePlfm8hz-1 ;
        lightIdxPlfm8hz = [lightIdxPlfm8hz;temp_lightIdx'];
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
    
    spkTimeTrack8hz = spikeWin(tData{iCell},lightTrack8hz(lightIdxTrack8hz),winCri);
    deto_spkTrack8hz = ~cellfun(@isempty, spkTimeTrack8hz); % even though the light evoked severalspikes count as one spike
    evo_spkTrack8hz = cellfun(@length, spkTimeTrack8hz); % count all spikes
    m_deto_spkTrack8hz = mean(reshape(deto_spkTrack8hz,[minPulseTrack8hz,nLap]),2)'; % fidelity
    evoSpkTrack8hz = sum(reshape(evo_spkTrack8hz,[minPulseTrack8hz,nLap]),2)'; % number of spikes
     
    if ~isempty(lightTime.Plfm8hz)
        spkTimePlfm8hz = spikeWin(tData{iCell},lightPlfm8hz,winCri);
        deto_spkPlfm8hz = ~cellfun(@isempty, spkTimePlfm8hz);
        evo_spkPlfm8hz = cellfun(@length, spkTimePlfm8hz);
        m_deto_spkPlfm8hz = mean(reshape(deto_spkPlfm8hz,[minPulsePlfm8hz,nLap]),2)';
        evoSpkPlfm8hz = sum(reshape(evo_spkPlfm8hz,[minPulsePlfm8hz,nLap]),2)';
    else
        deto_spkPlfm8hz = NaN;
        m_deto_spkPlfm8hz = NaN;
        evoSpkPlfm8hz = NaN;
    end

%     if ~isempty(lightTime.Track2hz)
%         spkTimeTrack2hz = spikeWin(tData{iCell},lightTrack2hz,winCri);
%         deto_spkTrack2hz = cellfun(@length, spkTimeTrack2hz);
%         m_deto_spkTrack2hz = mean(reshape(deto_spkTrack2hz,[minPulse,nLap]),2);
%     else
%         deto_spkTrack2hz = NaN;
%         m_deto_spkTrack2hz = NaN;
%     end
    save([cellName,'.mat'],'m_deto_spkTrack8hz','m_deto_spkPlfm8hz','evoSpkTrack8hz','evoSpkPlfm8hz','-append');
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