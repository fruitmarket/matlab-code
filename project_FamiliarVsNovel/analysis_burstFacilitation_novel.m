winBurst = [0 80];
win4bst = [0 1000]; % 0~1 sec: approximately 4 bursts.
resolution = 10; % resoution * binSize = 20 msec (sigma)
binSize = 2;
dot = 1; % dot / 0: line

[tData, tList] = tLoad;
nCell = length(tList);

for iCell = 1:nCell
    disp(['### pethLight analysis: ',tList{iCell},'...']);
    [cellPath, cellName, ~] = fileparts(tList{iCell});
    cd(cellPath);
    
    load('Events.mat');
    
    nLight = length(lightTime);
    dif_lightTime = diff(lightTime);
    idx_burstOnset = [1; find(diff(lightTime)>120)+1];
    idx_lapLight = [1; find(dif_lightTime>2*1000)+1];
    nLap = length(idx_lapLight);
    nlapLight = [diff(idx_lapLight); nLight-idx_lapLight(end)+1];
    nlapBurst = nlapLight/4;
    
    idx_4bst = find(nlapBurst>=4);
    idx_onset4bst = idx_lapLight(idx_4bst); % index if light onset light trial (trial more than 4 bursts stim) for each lab
    
    % this is for plot
    spikeTime4bst = spikeWin(tData{iCell},lightTime(idx_onset4bst),win4bst);
    [xpt4bst,ypt4bst,pethtime4bst,peth4bst,pethConv4bst,pethConvZ4bst] = rasterPETH(spikeTime4bst,true(size(idx_lapLight)),win4bst,binSize,resolution,dot);
    
    % for actual calculation
    spikeTimeBurstOnset = spikeWin(tData{iCell},lightTime(idx_burstOnset),winBurst);
    [xptBurst, yptBurst, ~, ~, ~, ~] = rasterPETH(spikeTimeBurstOnset,true(size(idx_burstOnset)),winBurst,binSize,resolution,1);
    temp_nSpkBurst = cellfun(@length, spikeTimeBurstOnset);
    temp_idx_burstOnset = cumsum(nlapBurst);
    temp_idx_burstOnset = [1; temp_idx_burstOnset(1:end-1)+1];
    nSpkArray = zeros(length(idx_4bst),4);
    for iLap = 1:nLap
        nSpkArray(iLap,:) = temp_nSpkBurst(temp_idx_burstOnset(iLap):temp_idx_burstOnset(iLap)+3)';
    end
    spkBurstNum = sum(nSpkArray,1);
    spkBurstProb = (nLap - sum(double(nSpkArray==0)))/nLap*100;
    
    save([cellName,'.mat'],'xpt4bst','ypt4bst','pethtime4bst','peth4bst','pethConv4bst','pethConvZ4bst','spkBurstNum','spkBurstProb','-append');
end