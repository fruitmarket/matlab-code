function analysis_baseVsLight
 
winLight = [0, 20];
winBase = [-300, 0];
winBase2 = [-15000, 0];
pValue = 0.05;
 
[tData, tList] = tLoad;
nCell = length(tList);
 
for iCell = 1:nCell
    disp(['### Analyzing ',tList{iCell},'...']);
    [cellPath, cellName, ~] = fileparts(tList{iCell});
    cd(cellPath);
 
    load Events.mat
 
    spkTime1hz = spikeWin(tData{iCell},lightTime.Plfm1hz,winLight);
    lightSpike1hz = cellfun(@length,spkTime1hz);
     
    spkTime2hz = spikeWin(tData{iCell},lightTime.Plfm2hz,winLight);
    lightSpike2hz = cellfun(@length,spkTime2hz);
    
    spkTime8hz = spikeWin(tData{iCell},lightTime.Plfm8hz,winLight);
    lightSpike8hz = cellfun(@length,spkTime8hz);
 
    spkTime20hz = spikeWin(tData{iCell},lightTime.Plfm20hz,winLight);
    lightSpike20hz = cellfun(@length,spkTime20hz);
    
    spkTime50hz = spikeWin(tData{iCell},lightTime.Plfm50hz,winLight);
    lightSpike50hz = cellfun(@length,spkTime50hz);
    
    lightSpike1hz = sum(reshape(lightSpike1hz,20,15),2);
    lightSpike2hz = sum(reshape(lightSpike2hz,20,15),2);
    lightSpike8hz = sum(reshape(lightSpike8hz,20,15),2);
    lightSpike20hz = sum(reshape(lightSpike20hz,20,15),2);
    lightSpike50hz = sum(reshape(lightSpike50hz,20,15),2);
    
    freq_light1hz = mean(lightSpike1hz/300*1000); % change to [Hz]
    freq_light2hz = mean(lightSpike2hz/300*1000);
    freq_light8hz = mean(lightSpike8hz/300*1000);
    freq_light20hz = mean(lightSpike20hz/300*1000);
    freq_light50hz = mean(lightSpike50hz/300*1000);
    
% Baseline firing rate
    spikeTimeBase1hz = spikeWin(tData{iCell},lightTime.Plfm1hz(1:15:end),winBase);
    baseSpike1hz = cellfun(@length,spikeTimeBase1hz);
    spikeTimeBase1hz_v2 = spikeWin(tData{iCell},[lightTime.Plfm1hz(16:15:end);time_recEnd(1)],winBase2);
    baseSpike1hz_v2 = cellfun(@length,spikeTimeBase1hz_v2);
    
%     spikeTimeBase2hz = spikeWin(tData{iCell},[lightTime.Plfm2hz(16:15:end);time_recEnd(2)],winBase);
    spikeTimeBase2hz = spikeWin(tData{iCell},lightTime.Plfm2hz(1:15:end),winBase);
    baseSpike2hz = cellfun(@length,spikeTimeBase2hz);
    spikeTimeBase2hz_v2 = spikeWin(tData{iCell},[lightTime.Plfm2hz(16:15:end);time_recEnd(2)],winBase2);
    baseSpike2hz_v2 = cellfun(@length,spikeTimeBase2hz_v2);
    
%     spikeTimeBase8hz = spikeWin(tData{iCell},[lightTime.Plfm8hz(16:15:end);time_recEnd(3)],winBase);
    spikeTimeBase8hz = spikeWin(tData{iCell},lightTime.Plfm8hz(1:15:end),winBase);
    baseSpike8hz = cellfun(@length,spikeTimeBase8hz);
    spikeTimeBase8hz_v2 = spikeWin(tData{iCell},[lightTime.Plfm8hz(16:15:end);time_recEnd(3)],winBase2);
    baseSpike8hz_v2 = cellfun(@length,spikeTimeBase8hz_v2);
    
%     spikeTimeBase20hz = spikeWin(tData{iCell},[lightTime.Plfm20hz(16:15:end);time_recEnd(4)],winBase);
    spikeTimeBase20hz = spikeWin(tData{iCell},lightTime.Plfm20hz(1:15:end),winBase);
    baseSpike20hz = cellfun(@length,spikeTimeBase20hz);
    spikeTimeBase20hz_v2 = spikeWin(tData{iCell},[lightTime.Plfm20hz(16:15:end);time_recEnd(4)],winBase2);
    baseSpike20hz_v2 = cellfun(@length,spikeTimeBase20hz_v2);
    
%     spikeTimeBase50hz = spikeWin(tData{iCell},[lightTime.Plfm50hz(16:15:end);time_recEnd(5)],winBase);
    spikeTimeBase50hz = spikeWin(tData{iCell},lightTime.Plfm50hz(1:15:end),winBase);
    baseSpike50hz = cellfun(@length,spikeTimeBase50hz);
    spikeTimeBase50hz_v2 = spikeWin(tData{iCell},[lightTime.Plfm50hz(16:15:end);time_recEnd(5)],winBase2);
    baseSpike50hz_v2 = cellfun(@length,spikeTimeBase50hz_v2);
    
    save([cellName,'.mat'],...
        'lightSpike1hz','baseSpike1hz','baseSpike1hz_v2',...
        'lightSpike2hz','baseSpike2hz','baseSpike2hz_v2',...
        'lightSpike8hz','baseSpike8hz','baseSpike8hz_v2',...
        'lightSpike20hz','baseSpike20hz','baseSpike20hz_v2',...
        'lightSpike50hz','baseSpike50hz','baseSpike50hz_v2','-append')


    freq_base1hz = mean(baseSpike1hz/300*1000); % change to [Hz]
    freq_base2hz = mean(baseSpike2hz/300*1000);
    freq_base8hz = mean(baseSpike8hz/300*1000);
    freq_base20hz = mean(baseSpike20hz/300*1000);
    freq_base50hz = mean(baseSpike50hz/300*1000);
    
    p_spike = zeros(5,1);
    p_spike(1) = ranksum(lightSpike1hz/300*1000, baseSpike1hz/300*1000);
    p_spike(2) = ranksum(lightSpike2hz/300*1000, baseSpike2hz/300*1000);
    p_spike(3) = ranksum(lightSpike8hz/300*1000, baseSpike8hz/300*1000);
    p_spike(4) = ranksum(lightSpike20hz/300*1000, baseSpike20hz/300*1000);
    p_spike(5) = ranksum(lightSpike50hz/300*1000, baseSpike50hz/300*1000);
    
    save([cellName,'.mat'],...
        'freq_light1hz','freq_light2hz','freq_light8hz','freq_light20hz','freq_light50hz',...
        'freq_base1hz','freq_base2hz','freq_base8hz','freq_base20hz','freq_base50hz',...
        'p_spike','-append')
%% increase / decreasea / no change
    if (freq_base1hz < freq_light1hz) && (p_spike(1)<pValue)
        idx_light1hz = 1;
    elseif (freq_base1hz > freq_light1hz) && (p_spike(1)<pValue)
        idx_light1hz = -1;
    else
        idx_light1hz = 0;
    end
    
    if (freq_base2hz < freq_light2hz) && (p_spike(2)<pValue)
        idx_light2hz = 1;
    elseif (freq_base2hz > freq_light2hz) && (p_spike(2)<pValue)
        idx_light2hz = -1;
    else
        idx_light2hz = 0;
    end
    
    if (freq_base8hz < freq_light8hz) && (p_spike(3)<pValue)
        idx_light8hz = 1;
    elseif (freq_base8hz > freq_light8hz) && (p_spike(3)<pValue)
        idx_light8hz = -1;
    else
        idx_light8hz = 0;
    end
    
    if (freq_base20hz < freq_light20hz) && (p_spike(4)<pValue)
        idx_light20hz = 1;
    elseif (freq_base20hz > freq_light20hz) && (p_spike(4)<pValue)
        idx_light20hz = -1;
    else
        idx_light20hz = 0;
    end
    
    if (freq_base50hz < freq_light50hz) && (p_spike(5)<pValue)
        idx_light50hz = 1;
    elseif (freq_base50hz > freq_light50hz) && (p_spike(5)<pValue)
        idx_light50hz = -1;
    else
        idx_light50hz = 0;
    end
 
    save([cellName,'.mat'],'idx_light1hz','idx_light2hz','idx_light8hz','idx_light20hz','idx_light50hz','-append');
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
