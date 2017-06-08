function analysis_stmzoneSpike()

% Load files
[tData, tList] = tLoad;
nCell = length(tList);
load('Events.mat','sensor');

% align spike time to position time
for iCell = 1:nCell
    disp(['### StmZone total spike: ',tList{iCell},'...']);
    [cellPath,cellName,~] = fileparts(tList{iCell});
    cd(cellPath);
    if ~isempty(regexp(cellPath,'DRun','once')) | ~isempty(regexp(cellPath,'noRun','once'))
        sensorOn = sensor.S6;
        sensorOff = sensor.S9;
    else
        sensorOn = sensor.S10;
        sensorOff = sensor.S11;
    end
    spikeData = tData{iCell};
    spikeTime = spikePeriod(spikeData, sensorOn, sensorOff);
    spikeNum = cellfun(@length,spikeTime);
   
    stmzoneSpike(1,1) = sum(spikeNum(1:30));
    stmzoneSpike(2,1) = sum(spikeNum(31:60));
    stmzoneSpike(3,1) = sum(spikeNum(61:90));
    
    m_stmzoneSpike(1,1) = mean(spikeNum(1:30));
    m_stmzoneSpike(2,1) = mean(spikeNum(31:60));
    m_stmzoneSpike(3,1) = mean(spikeNum(61:90));
    
    std_stmzoneSpike(1,1) = std(spikeNum(1:30));
    std_stmzoneSpike(2,1) = std(spikeNum(31:60));
    std_stmzoneSpike(3,1) = std(spikeNum(61:90));
    
    save([cellName,'.mat'],'stmzoneSpike','m_stmzoneSpike','std_stmzoneSpike','-append');
end
disp('### Calculating stmzone total spike is done!')