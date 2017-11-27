function analysis_pulse_baseVsLight
 
winLight10ms = [0, 20];
winLight50ms = [0, 60];
winBase10ms = [-20, 0];
winBase50ms = [-60, 0];

pValue = 0.05;
 
[tData, tList] = tLoad;
nCell = length(tList);
 
for iCell = 1:nCell
    disp(['### Analyzing ',tList{iCell},'...']);
    [cellPath, cellName, ~] = fileparts(tList{iCell});
    cd(cellPath);
 
    load Events.mat
 
    spkTime10ms = spikeWin(tData{iCell},lightTime.width10,winLight10ms);
    lightSpike10ms = cellfun(@length,spkTime10ms);
     
    spkTime50ms = spikeWin(tData{iCell},lightTime.width50,winLight50ms);
    lightSpike50ms = cellfun(@length,spkTime50ms);
    
    spike_light10ms = mean(lightSpike10ms); % change to [Hz]
    spike_light50ms = mean(lightSpike50ms);
    
% Baseline firing rate
    spikeTimeBase10ms = spikeWin(tData{iCell},lightTime.width10,winBase10ms);
    baseSpike10ms = cellfun(@length,spikeTimeBase10ms);
    
    spikeTimeBase50ms = spikeWin(tData{iCell},lightTime.width50,winBase50ms);
    baseSpike50ms = cellfun(@length,spikeTimeBase50ms);
    
    spike_base10ms = mean(baseSpike10ms); % change to [Hz]
    spike_base50ms = mean(baseSpike50ms);
    
    p_spike = zeros(2,1);
%     p_spike(1) = ranksum(lightSpike10ms, baseSpike10ms);
%     p_spike(2) = ranksum(lightSpike50ms, baseSpike50ms);
    
    [~,p_spike(1)] = ttest(lightSpike10ms, baseSpike10ms);
    [~,p_spike(2)] = ttest(lightSpike50ms, baseSpike50ms);
    
    save([cellName,'.mat'],...
        'spike_light10ms','spike_light50ms','spike_base10ms','spike_base50ms','p_spike','-append')
%% increase / decreasea / no change
    if (spike_base10ms < spike_light10ms) && (p_spike(1)<pValue)
        idx_light10ms = 1;
    elseif (spike_base10ms > spike_light10ms) && (p_spike(1)<pValue)
        idx_light10ms = -1;
    else
        idx_light10ms = 0;
    end
    
    if (spike_base50ms < spike_light50ms) && (p_spike(2)<pValue)
        idx_light50ms = 1;
    elseif (spike_base50ms > spike_light50ms) && (p_spike(2)<pValue)
        idx_light50ms = -1;
    else
        idx_light50ms = 0;
    end
 
    save([cellName,'.mat'],'idx_light10ms','idx_light50ms','-append');
end
disp('### Light vs Base firing rate calculation is done! ###')
 
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
