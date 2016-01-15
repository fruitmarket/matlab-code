[ttFile, nCell] = tfilecollector;
ttData = LoadSpikes(ttFile,'tsflag','ts','verbose',0);

win = 6*10^5; % unit msec (10 min)
binSize = 10^4; % unit msec (10 sec)

for iCell = 1:nCell
    disp(['### Analyzing ',ttFile{iCell},' ...']);
    [cellPath, cellName, ~] = fileparts(ttFile{iCell});
    cd(cellPath);
    
    load('Events.mat'); % unit: msec
    
    spikeData = Data(ttData{iCell})/10; % unit: msec
    
    % Mean firing rate
    frBase = sum(histc(spikeData,baseTime))/diff(baseTime)*1000;
    frTest = sum(histc(spikeData,testTime))/diff(testTime)*1000;
    
    % Mean firing rate for 10 min
    frBaseTen = sum(histc(spikeData,[(baseTime(2)-win):baseTime(2)]))/win*1000;
    frTestTen = sum(histc(spikeData,[(testTime(1)+21*10^5):(testTime(1)+27*10^5)]))/win*1000;
    
    baseT = baseTime(1):binSize:baseTime(2);
    baseT(end) = [];
    testT = testTime(1):binSize:testTime(2);
    testT(end) = [];        
    
    spikeBase = histcounts(spikeData,baseT)/binSize*1000; % unit: Hz
    spikeTest = histcounts(spikeData,testT)/binSize*1000; % unit: Hz
    
    xpt = [(baseT(1:end-1)-baseT(1))/binSize-size(baseT,2)-60, NaN, (testT(1:end-1)-testT(1))/binSize];
    ypt = [spikeBase, NaN, spikeTest];
        
    if frBaseTen > 0;
        frNormalized = frTestTen/frBaseTen;
    else
        frNormalized = [];
    end
    
    save([cellName, '.mat'],...
        'frBase','frTest','frBaseTen','frTestTen','frNormalized',...
        'xpt','ypt');  
end