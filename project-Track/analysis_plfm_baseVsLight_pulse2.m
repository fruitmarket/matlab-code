function analysis_plfm_baseVsLight_pulse2
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % base vs. light statistic test for plfm 1, 3, 5, 10 ms pulse width
winLight1ms = [0, 11];
winLight3ms = [0, 13];
winLight5ms = [0, 15];
winLight10ms = [0, 20];

winBase1ms = [-11, 0];
winBase3ms = [-13, 0];
winBase5ms = [-15, 0];
winBase10ms = [-20, 0];

pValue = 0.05;
 
[tData, tList] = tLoad;
nCell = length(tList);
 
for iCell = 1:nCell
    disp(['### Analyzing ',tList{iCell},'...']);
    [cellPath, cellName, ~] = fileparts(tList{iCell});
    cd(cellPath);
 
    load Events.mat
 
% Light firing rate
    spkTime1ms = spikeWin(tData{iCell},lightTime.w1ms,winLight1ms);
    lightSpike1ms = cellfun(@length,spkTime1ms); 
    spike_light1ms = mean(lightSpike1ms); % change to [Hz]

    spkTime3ms = spikeWin(tData{iCell},lightTime.w3ms,winLight3ms);
    lightSpike3ms = cellfun(@length,spkTime3ms); 
    spike_light3ms = mean(lightSpike3ms); % change to [Hz]
    
    spkTime5ms = spikeWin(tData{iCell},lightTime.w5ms,winLight5ms);
    lightSpike5ms = cellfun(@length,spkTime5ms); 
    spike_light5ms = mean(lightSpike5ms); % change to [Hz]
    
    spkTime10ms = spikeWin(tData{iCell},lightTime.w10ms,winLight10ms);
    lightSpike10ms = cellfun(@length,spkTime10ms); 
    spike_light10ms = mean(lightSpike10ms); % change to [Hz]
    
% Baseline firing rate
    spikeTimeBase1ms = spikeWin(tData{iCell},lightTime.w1ms,winBase1ms);
    baseSpike1ms = cellfun(@length,spikeTimeBase1ms);    
    spike_base1ms = mean(baseSpike1ms); % change to [Hz]
    
    spikeTimeBase3ms = spikeWin(tData{iCell},lightTime.w3ms,winBase3ms);
    baseSpike3ms = cellfun(@length,spikeTimeBase3ms);    
    spike_base3ms = mean(baseSpike3ms); % change to [Hz]
    
    spikeTimeBase5ms = spikeWin(tData{iCell},lightTime.w5ms,winBase5ms);
    baseSpike5ms = cellfun(@length,spikeTimeBase5ms);    
    spike_base5ms = mean(baseSpike5ms); % change to [Hz]
    
    spikeTimeBase10ms = spikeWin(tData{iCell},lightTime.w10ms,winBase10ms);
    baseSpike10ms = cellfun(@length,spikeTimeBase10ms);    
    spike_base10ms = mean(baseSpike10ms); % change to [Hz]
    
% p-value
    p_spike = zeros(4,1);   
    [~,p_spike(1)] = ttest(lightSpike1ms, baseSpike1ms);
    [~,p_spike(2)] = ttest(lightSpike3ms, baseSpike3ms);
    [~,p_spike(3)] = ttest(lightSpike5ms, baseSpike5ms);
    [~,p_spike(4)] = ttest(lightSpike10ms, baseSpike10ms);
    
    save([cellName,'.mat'],...
        'spike_light1ms','spike_light3ms','spike_light5ms','spike_light10ms',...
        'spike_base1ms','spike_base3ms','spike_base5ms','spike_base10ms',...
        'p_spike','-append')
%% increase / decreasea / no change
    if (spike_base1ms < spike_light1ms) && (p_spike(1)<pValue)
        idx_light1ms = 1;
    elseif (spike_base1ms > spike_light1ms) && (p_spike(1)<pValue)
        idx_light1ms = -1;
    else
        idx_light1ms = 0;
    end
    
    if (spike_base3ms < spike_light3ms) && (p_spike(2)<pValue)
        idx_light3ms = 1;
    elseif (spike_base3ms > spike_light3ms) && (p_spike(2)<pValue)
        idx_light3ms = -1;
    else
        idx_light3ms = 0;
    end
    
    if (spike_base5ms < spike_light5ms) && (p_spike(3)<pValue)
        idx_light5ms = 1;
    elseif (spike_base5ms > spike_light5ms) && (p_spike(3)<pValue)
        idx_light5ms = -1;
    else
        idx_light5ms = 0;
    end
    
    if (spike_base10ms < spike_light10ms) && (p_spike(4)<pValue)
        idx_light10ms = 1;
    elseif (spike_base10ms > spike_light10ms) && (p_spike(4)<pValue)
        idx_light10ms = -1;
    else
        idx_light10ms = 0;
    end
 
    save([cellName,'.mat'],'idx_light1ms','idx_light3ms','idx_light5ms','idx_light10ms','-append');
end
disp('### Light vs Base firing rate calculation is done! ###')