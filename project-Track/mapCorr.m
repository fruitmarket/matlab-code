function mapCorr()

[tData, tList] = tLoad;
nCell = length(tList);

for iCell = 1:nCell
    [cellPath, cellName, ~] = fileparts(tList{iCell});
    disp('### Analyzing ',tList{iCell}, '...');
    cd(cellPath);
    
    load('Events.mat','sensor','nSensor','nTrial');
    [vtTime, vtPosition, ~] = vtLoad;
    
    vtTimestamp = vtTime{1};
    vtPosition = vtPosition{1};
    
    period1 = [sensor.S1(1), sensor.S12(15)];
    period2 = [sensor.S1(16), sensor.S12(30)];
    
    period3 = [sensor.S1(1), sensor.S12(30)];
    period4 = [sensor.S1(61), sensor.S12(90)];
    
    spkData = tData{iCell};
    [r.CorrIntra, p.CorrIntra] = fieldPcorr(period1, period2, vtTimestamp, vtPosition, spkData);
    [r.CorrInter, p.CorrInter] = fieldPcorr(period3, period4, vtTimestamp, vtPosition, spkData);
    
    save([cellName, '.mat'], 'r','p','-append');
end

disp('### Shuffling is done! ###');
end
