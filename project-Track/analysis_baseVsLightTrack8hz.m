function analysis_baseVsLightTrack8hz
 
winLight020 = [0, 20];
winBase = [-20, 0];

winBase2 = [-10, 0];
winLight010 = [0, 9];
winLight1020 = [10,19];

pValue = 0.05;
 
[tData, tList] = tLoad;
nCell = length(tList);
 
for iCell = 1:nCell
    disp(['### Analyzing ',tList{iCell},'...']);
    [cellPath, cellName, ~] = fileparts(tList{iCell});
    cd(cellPath);
 
    load Events.mat
    if ~isempty(lightTime.Plfm8hz)
        spkTime8hz = spikeWin(tData{iCell},lightTime.Plfm8hz,winLight020);
        plfmLightSpike8hz = cellfun(@length,spkTime8hz);
        freq_light8hz = mean(plfmLightSpike8hz/20*1000);

    % Baseline firing rate
        spikeTimeBase8hz = spikeWin(tData{iCell},lightTime.Plfm8hz,winBase);
        plfmBaseSpike8hz = cellfun(@length,spikeTimeBase8hz);

        freq_base8hz = mean(plfmBaseSpike8hz/20*1000);
        p_Plfm8hzResp = ranksum(plfmLightSpike8hz/20*1000, plfmBaseSpike8hz/20*1000);
        plfmLightSpike8hz = plfmLightSpike8hz';
        plfmBaseSpike8hz = plfmBaseSpike8hz';
        save([cellName,'.mat'],'plfmLightSpike8hz','plfmBaseSpike8hz','freq_light8hz','freq_base8hz','p_Plfm8hzResp','-append')

    %% peak location during 8 Hz stimulation
        spikeTime_base10 = spikeWin(tData{iCell},lightTime.Plfm8hz,winBase2);
        spikeBase010 = cellfun(@length,spikeTime_base10);

        spikeTime_light010 = spikeWin(tData{iCell},lightTime.Plfm8hz,winLight010);
        spikeLight010 = cellfun(@length,spikeTime_light010);

        spikeTime_light020 = spikeWin(tData{iCell},lightTime.Plfm8hz,winLight020);
        spikeLight020 = cellfun(@length,spikeTime_light020);

        spikeTime_light1020 = spikeWin(tData{iCell},lightTime.Plfm8hz,winLight1020);
        spikeLight1020 = cellfun(@length,spikeTime_light1020);

        p_Plfm8hzLatency(1) = ranksum(spikeBase010/10,spikeLight010/diff(winLight010));
        p_Plfm8hzLatency(2) = ranksum(spikeBase010/10,spikeLight1020/diff(winLight1020));

        if p_Plfm8hzLatency(1)<0.05 && ~(p_Plfm8hzLatency(2)<0.05)
            idx_plfm8hzLatency = 'direct'; % direct
            temp_latency = cellfun(@min, spikeTime_light020,'UniformOutput',false);
            plfm8hzLatency1 = mean(cell2mat(temp_latency));
            plfm8hzLatency2 = NaN;
        elseif ~(p_Plfm8hzLatency(1)<0.05) && p_Plfm8hzLatency(2)<0.05
            idx_plfm8hzLatency = 'indirect';
            temp_latency = cellfun(@min, spikeTime_light020,'UniformOutput',false);
            plfm8hzLatency1 = NaN;
            plfm8hzLatency2 = mean(cell2mat(temp_latency));
        elseif p_Plfm8hzLatency(1)< 0.05 && p_Plfm8hzLatency(2)<0.05
            idx_plfm8hzLatency = 'double';
            temp_latency1 = cellfun(@min,spikeTime_light010,'UniformOutput',false);
            plfm8hzLatency1 = mean(cell2mat(temp_latency1));
            temp_latency2 = cellfun(@min,spikeTime_light1020,'UniformOutput',false);
            plfm8hzLatency2 = mean(cell2mat(temp_latency2));
        else
            idx_plfm8hzLatency = 'nosig';
            [plfm8hzLatency1, plfm8hzLatency2] = deal(NaN);
        end
        save([cellName,'.mat'],'p_Plfm8hzLatency','idx_plfm8hzLatency','plfm8hzLatency1','plfm8hzLatency2','-append');   

    %% increase / decreasea / no change
        if (freq_base8hz < freq_light8hz) && (p_Plfm8hzResp<pValue)
            idx_plfm8hz = 1;
        elseif (freq_base8hz > freq_light8hz) && (p_Plfm8hzResp<pValue)
            idx_plfm8hz = -1;
        else
            idx_plfm8hz = 0;
        end

        save([cellName,'.mat'],'idx_plfm8hz','-append');
    else
        [plfmLightSpike8hz,plfmBaseSpike8hz,freq_light8hz,freq_base8hz,p_Plfm8hzResp,p_Plfm8hzLatency,plfm8hzLatency1,plfm8hzLatency2,idx_plfm8hz] = deal(NaN);
        idx_plfm8hzLatency = 'none';
        save([cellName,'.mat'],'plfmLightSpike8hz','plfmBaseSpike8hz','freq_light8hz','freq_base8hz','p_Plfm8hzResp','p_Plfm8hzLatency','idx_plfm8hzLatency','plfm8hzLatency1','plfm8hzLatency2','idx_plfm8hz','-append');
    end
end
disp('### Platform Light vs Base firing rate calculation is done! ###')
 
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