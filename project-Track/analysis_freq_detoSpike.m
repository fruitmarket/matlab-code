function analysis_freq_detoSpike
% analysis_freq_detoSpike calculates spike fidelity (%), the number of
% light evoked spikes.
%
%

winCri = [0, 20]; % time duration which are interested in
[tData, tList] = tLoad;
nCell = length(tList);
load Events.mat

light1hz = lightTime.Plfm1hz;
light2hz = lightTime.Plfm2hz;
light8hz = lightTime.Plfm8hz;
light20hz = lightTime.Plfm20hz;
light50hz = lightTime.Plfm50hz;

if length(lightTime.Plfm1hz) ~= 300
    light1hz = lightTime.Plfm1hz;
    light1hz(1) = [];
end

nLap = 20;

for iCell = 1:nCell
    disp(['### detoSpike analysis: ',tList{iCell},'...']);
    [cellPath, cellName, ~] = fileparts(tList{iCell});
    cd(cellPath);
    
    spkTime1hz = spikeWin(tData{iCell},light1hz,winCri);
    spkTime1hz = reshape(spkTime1hz,[15,20])';
    evoSpk1hz = sum(cellfun(@length,spkTime1hz),1);
    detoSpk1hz = sum(~cellfun(@isempty,spkTime1hz),1); % sum of 'first spike numbers' at n-th light train
    detoSpk1hz = detoSpk1hz/nLap*100; % fidelity (probability, %)

    spkTime2hz = spikeWin(tData{iCell},light2hz,winCri);
    spkTime2hz = reshape(spkTime2hz,[15,20])';
    evoSpk2hz = sum(cellfun(@length,spkTime2hz),1);
    detoSpk2hz = sum(~cellfun(@isempty,spkTime2hz),1); % sum of 'first spike numbers' at n-th light train
    detoSpk2hz = detoSpk2hz/nLap*100; % fidelity (probability, %)
    
    spkTime8hz = spikeWin(tData{iCell},light8hz,winCri);
    spkTime8hz = reshape(spkTime8hz,[15,20])';
    evoSpk8hz = sum(cellfun(@length,spkTime8hz),1);
    detoSpk8hz = sum(~cellfun(@isempty,spkTime8hz),1); % sum of 'first spike numbers' at n-th light train
    detoSpk8hz = detoSpk8hz/nLap*100; % fidelity (probability, %)
    
    spkTime20hz = spikeWin(tData{iCell},light20hz,winCri);
    spkTime20hz = reshape(spkTime20hz,[15,20])';
    evoSpk20hz = sum(cellfun(@length,spkTime20hz),1);
    detoSpk20hz = sum(~cellfun(@isempty,spkTime20hz),1); % sum of 'first spike numbers' at n-th light train
    detoSpk20hz = detoSpk20hz/nLap*100; % fidelity (probability, %)
    
    spkTime50hz = spikeWin(tData{iCell},light50hz,winCri);
    spkTime50hz = reshape(spkTime50hz,[15,20])';
    evoSpk50hz = sum(cellfun(@length,spkTime50hz),1);
    detoSpk50hz = sum(~cellfun(@isempty,spkTime50hz),1); % sum of 'first spike numbers' at n-th light train
    detoSpk50hz = detoSpk50hz/nLap*100; % fidelity (probability, %)

    save([cellName,'.mat'],'evoSpk1hz','detoSpk1hz','evoSpk2hz','detoSpk2hz','evoSpk8hz','detoSpk8hz','evoSpk20hz','detoSpk20hz','evoSpk50hz','detoSpk50hz','-append');
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