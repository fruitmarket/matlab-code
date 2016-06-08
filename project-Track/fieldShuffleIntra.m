function fieldShuffleIntra()

alpha_v = 0.005;
fr_threshold = 3;
fieldsize_cutoff = 10;
field_ratio = [72, 48];


%% Loading data

[tData, tList] = tLoad;
nCell = length(tList);

for iCell = 119:nCell
    [cellPath, cellName, ~] = fileparts(tList{iCell});
    disp(['### Analyzing ',tList{iCell}, '...']);
    cd(cellPath);
    
    load('Events.mat','sensor','fields','nSensor','nTrial')
    [vtTime, vtPosition, ~] = vtLoad;
    
    vtTimestamp = vtTime{1};
    vtPosition = vtPosition{1};

    period1 = [sensor.S1(1),sensor.S12(15)];
    period2 = [sensor.S1(16),sensor.S12(30)];

    % random sequence
    for iSeq = 1:1000
        randSeq = randperm(size(vtPosition,1));
        randPosition{iSeq,1} = vtPosition(randSeq,:);
    end

        spkData = tData{iCell}; %unit: msec
        pCorrIntra.original = fieldPcorr(period1,period2,vtTimestamp,vtPosition,spkData);

        for iShuffle = 1:1000
            pCorrIntra.rand(iShuffle,1) = fieldPcorr(period1, period2, vtTimestamp, randPosition{iShuffle,1}, spkData);
        end
        pShfIntra = length(find(pCorrIntra.rand>pCorrIntra.original))/1000;

    save([cellName,'.mat'],'pCorrIntra','pShfIntra','-append')
end

disp('### Shuffling is done! ###');
end