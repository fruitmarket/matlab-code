function analysis_meanFRfreqTest()

[tData, tList] = tLoad;

nCell = length(tList);
for iCell = 1:nCell
    disp(['### mean firing analysis: ',tList{iCell}]);
    [cellPath, cellName, ~] = fileparts(tList{iCell});
    cd(cellPath);
    
    load('Events.mat');
    spikeData = tData{iCell};
    
    meanFR_plfm = meanFR(time_recStart, time_recEnd, spikeData);
    total_mFR = mean(meanFR_plfm);
    
    save([cellName,'.mat'],'total_mFR','-append');   
end