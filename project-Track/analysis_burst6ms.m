function analysis_burst6ms()
narginchk(0,2);

[tData, tList] = tLoad;
nCell = length(tList);

for iCell = 1:nCell
    disp(['### Analyzing ',tList{iCell},'...']);
    [cellPath, cellName, ~] = fileparts(tList{iCell});
    cd(cellPath);
    
    load('Events.mat');
    spikeData = tData{iCell};
    
    spikeTask = (taskTime(1)<spikeData & spikeData<taskTime(2));
    spikeISI = diff(spikeData(spikeTask));
    burstIdx_6ms = sum(double(spikeISI<6))/length(spikeISI);
    
    save([cellName,'.mat'],'burstIdx_6ms','-append');
end
disp('### burstIdx_6ms is done! ###');