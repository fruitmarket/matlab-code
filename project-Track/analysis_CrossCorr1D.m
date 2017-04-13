% Variables for PETH & raster
winLinear = [1,125]; % 1 to 125 cm (lose around 4 cm)
winSpace = [0,124];
binSize = 1; % 1 [unit: cm]
resolution = 2;
dot = 1;

% Load files
[vtTime, vtPosition, vtList] = vtLoad;
[tData, tList] = tLoad;
nCell = length(tList);

load('Events.mat','sensor','trialIndex');

% Linearize position data
[realDist, theta, timeTrack, eventPosition, numOccu] = track2linear(vtPosition{1}(:,1), vtPosition{1}(:,2),vtTime{1},sensor.S1, [sensor.S1(1), sensor.S12(end)],winLinear);
numOccu = numOccu';
    
% align spike time to position time
for iCell = 1:nCell
    disp(['### 1D rate map CrossCorr analysis: ',tList{iCell},'...']);
    [cellPath,cellName,~] = fileparts(tList{iCell});
    cd(cellPath);
    
    spikeData = tData{iCell}(sensor.S1(1)<tData{iCell} & tData{iCell}<sensor.S12(end));
    nSpike = length(spikeData);
    
    newSpikeData = zeros(nSpike,1); % spike time conversion to video tracking time
    for iSpike = 1:nSpike
        [~,timeIndex] = min(abs(spikeData(iSpike)-timeTrack));
        newSpikeData(iSpike) = timeTrack(timeIndex);
    end

    spkPositionIdx = zeros(nSpike,1);
    for iSpike = 1:nSpike
        spkPositionIdx(iSpike) = find((timeTrack == newSpikeData(iSpike)));
    end
    
    spikeLocation = realDist(spkPositionIdx); % position data of each spike
    spikePosition = spikeWin(spikeLocation,eventPosition,winSpace);
    [~,~,~,~,pethconvSpatial,~] = spatialrasterPETH(spikePosition, trialIndex, numOccu(:,1:end-1), winSpace, binSize, resolution, dot); % drop the last bin of numOccu
%     [xptSpatial,yptSpatial,pethSpatial,pethbarSpatial,pethconvSpatial,pethconvZSpatial] = spatialrasterPETH(spikePosition, trialIndex, numOccu, winSpace, binSize, resolution, dot);
    rateMap1D_pre = pethconvSpatial(1,:);
    rateMap1D_stm = pethconvSpatial(2,:);
    rateMap1D_post = pethconvSpatial(3,:);
    
    idxCompare = min([sum(double(isfinite(rateMap1D_pre))), sum(double(isfinite(rateMap1D_stm))), sum(double(isfinite(rateMap1D_post)))]);
    
    [rCorr1D_preXstm, pCorr1D_preXstm] = corr(rateMap1D_pre(1:idxCompare)',rateMap1D_stm(1:idxCompare)','type','Pearson'); % corr calculates based on column vectors
    [rCorr1D_preXpost, pCorr1D_preXpost] = corr(rateMap1D_pre(1:idxCompare)',rateMap1D_post(1:idxCompare)','type','Pearson');
    [rCorr1D_stmXpost, pCorr1D_stmXpost] = corr(rateMap1D_stm(1:idxCompare)',rateMap1D_post(1:idxCompare)','type','Pearson');
    
    save([cellName,'.mat'],'rCorr1D_preXstm','pCorr1D_preXstm','rCorr1D_preXpost','pCorr1D_preXpost','rCorr1D_stmXpost','pCorr1D_stmXpost','-append');
end
disp('### 1D cross-correlation calculation is done!')