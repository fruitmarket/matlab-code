function mapCorr()
clearvars;

[tData, tList] = tLoad;
nCell = length(tList);

for iCell = 1:nCell
    [cellPath, cellName, ~] = fileparts(tList{iCell});
    disp(['### Analyzing ',tList{iCell}, '...']);
    cd(cellPath);
    
    load('Events.mat','sensor','nSensor','nTrial');
    [vtTime, vtPosition, ~] = vtLoad;
    
    vtTimestamp = vtTime{1};
    vtPosition = vtPosition{1};
    
    % Lap 1~15  Vs. 16~30
    period1 = [sensor.S1(1), sensor.S12(15)];
    period2 = [sensor.S1(16), sensor.S12(30)];
    
    % Lap 1~30 Vs. 31~60
    period3 = [sensor.S1(1), sensor.S12(30)];
    period4 = [sensor.S1(31), sensor.S12(60)];
    
    % Lap 1~30  Vs. 61~90
    period5 = [sensor.S1(1), sensor.S12(30)];
    period6 = [sensor.S1(61), sensor.S12(90)];
    
    % Lap 31~60  Vs. 61~90
    period7 = [sensor.S1(31), sensor.S12(60)];
    period8 = [sensor.S1(61), sensor.S12(90)];
    
    spkData = tData{iCell};
    [r_Corrhfxhf, p_Corrhfxhf] = fieldPcorr(period1, period2, vtTimestamp, vtPosition, spkData);
    [r_Corrbfxdr, p_Corrbfxdr] = fieldPcorr(period3, period4, vtTimestamp, vtPosition, spkData);
    [r_Corrbfxaft, p_Corrbfxaft] = fieldPcorr(period5, period6, vtTimestamp, vtPosition, spkData);
    [r_Corrdrxaft, p_Corrdrxaft] = fieldPcorr(period7, period8, vtTimestamp, vtPosition, spkData);
    
    save([cellName, '.mat'],...
        'r_Corrhfxhf', 'p_Corrhfxhf', 'r_Corrbfxdr', 'p_Corrbfxdr', 'r_Corrbfxaft', 'p_Corrbfxaft', 'r_Corrdrxaft','p_Corrdrxaft','-append');
end

disp('### Correlation calculation is done! ###');
end