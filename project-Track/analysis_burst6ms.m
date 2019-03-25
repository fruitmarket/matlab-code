function analysis_burst6ms()
narginchk(0,2);

[tData, tList] = tLoad;
nCell = length(tList);

for iCell = 1:nCell
    disp(['### burst6ms analysis: ',tList{iCell},'...']);
    [cellPath, cellName, ~] = fileparts(tList{iCell});
    cd(cellPath);
    
    load('Events.mat');
    spikeData = tData{iCell};
    if ~exist('timeTask')
        timeTask = taskTime;
    end
    
    spikeTask = (timeTask(1)<spikeData & spikeData<timeTask(2));
    spikeISI = diff(spikeData(spikeTask));
    burstIdx_6ms = sum(double(spikeISI<6))/length(spikeISI);
    
    save([cellName,'.mat'],'burstIdx_6ms','-append');
end
disp('### burstIdx_6ms is done! ###');