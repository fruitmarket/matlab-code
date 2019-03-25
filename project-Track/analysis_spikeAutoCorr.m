function analysis_spikeAutoCorr

[tData, tList] = tLoad;
nCell = length(tList);
acorr_binSize = 4;

for iCell = 1:nCell
    disp(['### Analyzing ',tList{iCell},'...']);
    [cellPath,cellName,~] = fileparts(tList{iCell});
    cd(cellPath);
    
    load('Events.mat');
    spikeData = tData{iCell};
    
    spikePRE = spikeData(sensor.S1(1)<=spikeData & spikeData<sensor.S12(30));
    spikeSTIM = spikeData(sensor.S1(31)<=spikeData & spikeData<sensor.S12(60));
    spikePOST = spikeData(sensor.S1(61)<=spikeData & spikeData<sensor.S12(90));
    
    [histAcorr_PRE, xpt_acorr_PRE] = AutoCorr(spikePRE*10,acorr_binSize,250); % from MClust-CheckCluster (spikedata should be 100 usec unit)
    [histAcorr_STIM, xpt_acorr_STIM] = AutoCorr(spikeSTIM*10,acorr_binSize,250);
    [histAcorr_POST, xpt_acorr_POST] = AutoCorr(spikePOST*10,acorr_binSize,250);
    
    save([cellName,'.mat'],'xpt_acorr_PRE','histAcorr_PRE','xpt_acorr_STIM','histAcorr_STIM','xpt_acorr_POST','histAcorr_POST','-append');
end
disp('### Ananlysis: autocorrelation is done! ###');