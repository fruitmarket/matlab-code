function detoSpike()

winCri = [0, 30]; % time duration which are interested in
[tData, tList] = tLoad;
nCell = length(tList);

for iCell = 1:nCell
    disp(['### Analyzing ',tList{iCell},'...']);
    [cellPath, cellName, ~] = fileparts(tList{iCell});
    cd(cellPath);
    
    load Events.mat
    light2hz = lightTime.Plfm2hz(1:5);
    spkTime2hz = spikeWin(tData{iCell},light2hz,winCri);
    deto_spkPlfm2hz = cellfun(@length, spkTime2hz);
     
    if ~isempty(lightTime.Plfm8hz)
        light8hz = lightTime.Plfm8hz(1:5);
        spkTime8hz = spikeWin(tData{iCell},light8hz,winCri);
        deto_spkPlfm8hz = cellfun(@length, spkTime8hz);
    else
        deto_spkPlfm8hz = NaN;
    end
    
%     save([cellName,'.mat'],'deto_spkPlfm2hz','deto_spkPlfm8hz','-append');
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