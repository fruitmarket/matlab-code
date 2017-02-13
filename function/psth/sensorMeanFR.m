function sensorMeanFR()

load('Events.mat');
fields = fieldnames(sensor);

[tData, tList] = tLoad;
nCell = length(tList);

for iCell = 1:nCell
    disp(['### sensorMeanFR analysis: ', tList{iCell},'...']);
    [cellPath, cellName, ~] = fileparts(tList{iCell});
    cd(cellPath);
    
    spikeData = tData{iCell};
    sensorMeanFR_DRun = meanFR(sensor.S6, sensor.S9, spikeData);
    sensorMeanFR_DRw = meanFR(sensor.S10, sensor.S11, spikeData);
    
    save([cellName,'.mat'],'sensorMeanFR_DRun','sensorMeanFR_DRw','-append');
end
end