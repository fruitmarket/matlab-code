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

% stay time in stm zone
    temp_dTime = sensorOff-sensorOn;
    diffTime = [mean(temp_dTime(1:30)), mean(temp_dTime(31:60)), mean(temp_dTime(61:90))]/mean(temp_dTime(1:30)); % normalized by PRE time
    timeIn_stmZone = round(diffTime*100)/100;
    
    save([cellName,'.mat'],'stmzoneSpike','m_stmzoneSpike','std_stmzoneSpike','timeIn_stmZone','-append');
end
disp('### Calculating stmzone total spike is done!')