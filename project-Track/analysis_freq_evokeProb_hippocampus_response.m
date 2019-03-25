function analysis_freq_evokeProb_hippocampus_response

winCri_dr = [0, 10];
winCri_idr = [11, 20];
winCri_total = [0, 20];

% Load t-files
[tData, tList] = tLoad;
nCell = length(tList);
lightIdx = [];
for iCycle = 1:20
    temp_lightIdx = [1:5]+15*(iCycle-1);
    lightIdx = [lightIdx, temp_lightIdx];
end

for iCell = 1:nCell
    disp(['### Analyzing ',tList{iCell},'...']);
    [cellPath, cellName, ~] = fileparts(tList{iCell});
    cd(cellPath);

    load Events.mat
    if isfield(lightTime,'Plfm1hz')
        spkTime1hz = spikeWin(tData{iCell},lightTime.Plfm1hz(lightIdx),winCri_total);
        light5Prob1hz = sum(double(~cellfun(@isempty,spkTime1hz)))/length(lightTime.Plfm1hz(lightIdx))*100;
    else
        light5Prob1hz = NaN;
    end

    spkTime2hz = spikeWin(tData{iCell},lightTime.Plfm2hz(lightIdx),winCri_total);
    light5Prob2hz = sum(double(~cellfun(@isempty,spkTime2hz)))/length(lightTime.Plfm2hz(lightIdx))*100;
    
    spkTime8hz = spikeWin(tData{iCell},lightTime.Plfm8hz(lightIdx),winCri_total);
    light5Prob8hz = sum(double(~cellfun(@isempty,spkTime8hz)))/length(lightTime.Plfm8hz(lightIdx))*100;
    
    
    if isfield(lightTime,'Plfm20hz')
        spkTime20hz = spikeWin(tData{iCell},lightTime.Plfm20hz(lightIdx),winCri_total);
        light5Prob20hz = sum(double(~cellfun(@isempty,spkTime20hz)))/length(lightTime.Plfm20hz(lightIdx))*100;
    else
        light5Prob20hz = NaN;
    end

    if isfield(lightTime,'Plfm50hz')

        spkTime50hz = spikeWin(tData{iCell},lightTime.Plfm50hz(lightIdx),winCri_total);
        light5Prob50hz = sum(double(~cellfun(@isempty,spkTime50hz)))/length(lightTime.Plfm50hz(lightIdx))*100;
    else
        light5Prob50hz = NaN;
    end

    save([cellName,'.mat'],...
        'light5Prob1hz','light5Prob2hz','light5Prob8hz','light5Prob20hz','light5Prob50hz','-append');
end