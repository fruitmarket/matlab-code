function analysis_pethLight_Plfm()

winPlfm2hz = [-25 475]; % unit: msec
winPlfm50hz = [0 20];
binSize = 2;
winCri = 20; % light effect criteria: 20ms
resolution = 10; % sigma = resolution * binSize = 20 msec
dot = 0;

[tData, tList] = tLoad;
nCell = length(tList);

for iCell = 1:nCell
    disp(['### pethLight analysis: ',tList{iCell},'...']);
    [cellPath, cellName, ~] = fileparts(tList{iCell});
    cd(cellPath);
    load('Events.mat');
    
%% Light (Plfm) 8mw analysis [201:400]
    if isfield(lightTime,'Plfm2hz') % Activation (ChETA)
       spikeTimePlfm2hz = spikeWin(tData{iCell},lightTime.Plfm2hz(201:400),winPlfm2hz);
       [xptPlfm2hz, yptPlfm2hz, pethtimePlfm2hz, pethPlfm2hz,pethPlfm2hzConv,pethPlfm2hzConvZ] = rasterPETH(spikeTimePlfm2hz,true(size(lightTime.Plfm2hz(201:400))),winPlfm2hz,binSize,resolution,dot);
       lightSpkPlfm2hz = sum(0<xptPlfm2hz{1} & xptPlfm2hz{1}<winCri);
       lightSpkPlfm2hz_pre = sum(-winCri<xptPlfm2hz{1} & xptPlfm2hz{1}<0);
       lightSpkPlfm2hz_post = sum(winCri<xptPlfm2hz{1} & xptPlfm2hz{1}<2*winCri);
       
       save([cellName,'.mat'],'spikeTimePlfm2hz','xptPlfm2hz','yptPlfm2hz','pethtimePlfm2hz','pethPlfm2hz','lightSpkPlfm2hz','pethPlfm2hzConv','pethPlfm2hzConvZ','lightSpkPlfm2hz_pre','lightSpkPlfm2hz_post','-append');
    end
    
%% 50 Hz stimulation
    if isfield(lightTime,'Plfm50hz') & ~isempty(lightTime.Plfm50hz);
        spikeTimePlfm50hz = spikeWin(tData{iCell},lightTime.Plfm50hz,winPlfm50hz);
        [xptPlfm50hz, yptPlfm50hz, pethtimePlfm50hz, pethPlfm50hz,pethPlfm50hzConv,pethPlfm50hzConvZ] = rasterPETH(spikeTimePlfm50hz,true(size(lightTime.Plfm50hz)),winPlfm50hz,binSize,resolution,dot);
        lightSpkPlfm50hz = sum(0<xptPlfm50hz{1} & xptPlfm50hz{1}<winCri);
        lightSpkPlfm50hz_pre = sum(-winCri<xptPlfm50hz{1} & xptPlfm50hz{1}<0);
        lightSpkPlfm50hz_post = sum(winCri<xptPlfm50hz{1} & xptPlfm50hz{1}<2*winCri);
        save([cellName,'.mat'],'spikeTimePlfm50hz','xptPlfm50hz','yptPlfm50hz','pethtimePlfm50hz','pethPlfm50hz','pethPlfm50hzConv','pethPlfm50hzConvZ','lightSpkPlfm50hz','lightSpkPlfm50hz_pre','lightSpkPlfm50hz_post','-append');
    else
        [spikeTimePlfm50hz,xptPlfm50hz,yptPlfm50hz,pethtimePlfm50hz,pethPlfm50hz,pethPlfm50hzConv,pethPlfm50hzConvZ,lightSpkPlfm50hz,lightSpkPlfm50hz_pre,lightSpkPlfm50hz_post] = deal(NaN);
        save([cellName,'.mat'],'spikeTimePlfm50hz','xptPlfm50hz','yptPlfm50hz','pethtimePlfm50hz','pethPlfm50hz','pethPlfm50hzConv','pethPlfm50hzConvZ','lightSpkPlfm50hz','lightSpkPlfm50hz_pre','lightSpkPlfm50hz_post','-append');
    end
 
%% 50 Hz burst at 8 Hz (light pattern: |||_____|||_____|||_____)
    if regexp(cellPath,'familiar') % burst stimulation at familiar environment (platform stim) / 1st light onset
        lightPlfm50 = lightTime.Plfm50hz;
        lightOnStim = lightPlfm50([1; (find(diff(lightPlfm50)>50)+1)]);
        winBurst = [-20 120];
        spikeTimeStim = spikeWin(tData{iCell}, lightOnStim, winBurst);
        [xptPlfm1stBStm,yptPlfm1stBStm,pethtimePlfm1stBStm,peth1stPlfmBStm,pethConvPlfm1stBStm,pethConvZPlfm1stBStm] = rasterPETH(spikeTimeStim, true(size(lightOnStim)), winBurst, binSize, resolution, dot);
        save([cellName,'.mat'],'xptPlfm1stBStm','yptPlfm1stBStm','pethtimePlfm1stBStm','peth1stPlfmBStm','pethConvPlfm1stBStm','pethConvZPlfm1stBStm','-append');
    end   
end
disp('### analysis: pethLight_Platform is done! ###');