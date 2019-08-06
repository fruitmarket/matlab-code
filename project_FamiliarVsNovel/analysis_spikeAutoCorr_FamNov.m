function analysis_spikeAutoCorr_FamNov

[tData, tList] = tLoad;
nCell = length(tList);
acorr_binSize = 4;

for iCell = 1:nCell
    disp(['### Analyzing ',tList{iCell},'...']);
    [cellPath,cellName,~] = fileparts(tList{iCell});
    cd(cellPath);
    
    load('Events.mat');
    spikeData = tData{iCell};
    if regexp(cellPath,'familiar')
        spike_PRE = spikeData(sensor(1,1)<=spikeData & spikeData<sensor(30,12));
        spike_STIM = spikeData(sensor(31,1)<=spikeData & spikeData<sensor(60,12));
        spike_POST = spikeData(sensor(61,1)<=spikeData & spikeData<sensor(90,12));
    else
        spike_PRE = spikeData(sensor(31,1)<=spikeData & spikeData<sensor(60,12));
        spike_STIM = spikeData(sensor(61,1)<=spikeData & spikeData<sensor(90,12));
        spike_POST = spikeData(sensor(91,1)<=spikeData & spikeData<sensor(120,12));
    end
    
    [histAcorr_PRE, xpt_acorr_PRE] = AutoCorr(spike_PRE*10,acorr_binSize,250); % from MClust-CheckCluster (spikedata should be 100 usec unit)
    [histAcorr_STIM, xpt_acorr_STIM] = AutoCorr(spike_STIM*10,acorr_binSize,250);
    [histAcorr_POST, xpt_acorr_POST] = AutoCorr(spike_POST*10,acorr_binSize,250);
    
    save([cellName,'.mat'],'xpt_acorr_PRE','histAcorr_PRE','xpt_acorr_STIM','histAcorr_STIM','xpt_acorr_POST','histAcorr_POST','-append');
end
disp('### Ananlysis: autocorrelation is done! ###');