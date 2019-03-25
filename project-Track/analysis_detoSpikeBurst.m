function analysis_detoSpikeBurst()
% m_deto_spkTrack50hz or Plfm50hz: mean number of spikes activated by each light
%
%
winCri = [0, 20]; % time duration which are interested in
[tData, tList] = tLoad;
nCell = length(tList);
nLap = 50;

cri_ibi = 50;
load Events.mat

lightIdxTrack50hz = [];
lightTrack50hz = lightTime.Track50hz;
lapLightIdx = [1;(find(diff(lightTrack50hz)>cri_ibi)+1)]; % find start light of each lap
minPulseTrack50hz = min([diff(lapLightIdx);(length(lightTrack50hz)-lapLightIdx(end)+1)]);

for iLap = 1:nLap
    temp_lightIdx = lapLightIdx(iLap):lapLightIdx(iLap)+minPulseTrack50hz-1 ;
    lightIdxTrack50hz = [lightIdxTrack50hz;temp_lightIdx'];
end

if isfield(lightTime,'Plfm50hz') & ~isempty(lightTime.Plfm50hz)
    lightIdxPlfm50hz = [];
    lightPlfm50hz = lightTime.Plfm50hz;
    lapLightIdx = [1;(find(diff(lightPlfm50hz)>cri_ibi)+1)]; % find start light of each lap
    minPulsePlfm50hz = min([diff(lapLightIdx);(length(lightPlfm50hz)-lapLightIdx(end)+1)]);
end

for iCell = 1:nCell
    disp(['### detoSpike analysis: ',tList{iCell},'...']);
    [cellPath, cellName, ~] = fileparts(tList{iCell});
    cd(cellPath);
    
    spkTimeTrack50hz = spikeWin(tData{iCell},lightTrack50hz(lightIdxTrack50hz),winCri);
    deto_spkTrack50hz = ~cellfun(@isempty, spkTimeTrack50hz); % even though the light evoked several spikes count as one spike
    evo_spkTrack50hz = cellfun(@length, spkTimeTrack50hz); % count all spikes
    m_deto_spkTrack50hz = mean(reshape(deto_spkTrack50hz,[minPulseTrack50hz,nLap]),2)'; % fidelity
    evoSpkTrack50hz = sum(reshape(evo_spkTrack50hz,[minPulseTrack50hz,nLap]),2)'; % number of spikes
     
    if ~isempty(lightTime.Plfm50hz)
        spkTimePlfm50hz = spikeWin(tData{iCell},lightPlfm50hz,winCri);
        deto_spkPlfm50hz = ~cellfun(@isempty, spkTimePlfm50hz);
        evo_spkPlfm50hz = cellfun(@length, spkTimePlfm50hz);
        m_deto_spkPlfm50hz = mean(reshape(deto_spkPlfm50hz,[minPulsePlfm50hz,nBurst_Plfm]),2)';
        evoSpkPlfm50hz = sum(reshape(evo_spkPlfm50hz,[minPulsePlfm50hz,nBurst_Plfm]),2)';
    else
        deto_spkPlfm50hz = NaN;
        m_deto_spkPlfm50hz = NaN;
        evoSpkPlfm50hz = NaN;
    end

    save([cellName,'.mat'],'m_deto_spkTrack50hz','m_deto_spkPlfm50hz','evoSpkTrack50hz','evoSpkPlfm50hz','-append');
end
disp('### detonate spike calculation is done! ###')