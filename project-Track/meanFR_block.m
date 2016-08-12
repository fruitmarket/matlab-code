function meanFR_block()

% Event load
load('Events.mat','sensor');
sensor1 = sensor.S1;

time_pre = [sensor1(1), sensor1(30)];
time_stm = [sensor1(31), sensor1(60)];
time_post = [sensor1(61), sensor1(90)];

% Spike load
[tData, tList] = tLoad;
nCell = length(tList);

for iCell = 1:nCell
    disp(['### Analyzing ',tList{iCell}, '...']);
    [cellPath, cellName, ~] = fileparts(tList{iCell});
    cd(cellPath);
    
    meanFR_pre = sum(histc(tData{iCell},time_pre))/(diff(time_pre)/1000);
    meanFR_stm = sum(histc(tData{iCell},time_stm))/(diff(time_stm)/1000);
    meanFR_post = sum(histc(tData{iCell},time_post))/(diff(time_post)/1000);
    
    save([cellName,'.mat'],'meanFR_pre','meanFR_stm','meanFR_post','-append');
end
end
