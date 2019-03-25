function analysis_plfm_pulseWidth
% compare 1, 3, 5, 10 ms laser pulse on plfm

resolution = 10; % sigma = resolution * binSize

winSpike = [-25 100];
binSize = 2;

winLight_1ms = 11;
winLight_3ms = 13;
winLight_5ms = 15;
winLight_10ms = 20;

[tData, tList] = tLoad;
nCell = length(tList);

for iCell = 1:nCell
    disp(['### Analyzing ', tList{iCell},'...']);
    [cellPath, cellName, ~] = fileparts(tList{iCell});
    cd(cellPath);
    
    load('Events.mat');

% mean firing rate
    meanFR_1ms = sum(histc(tData{iCell},time1ms))/(diff(time1ms)/1000);
    meanFR_3ms = sum(histc(tData{iCell},time3ms))/(diff(time3ms)/1000);
    meanFR_5ms = sum(histc(tData{iCell},time5ms))/(diff(time5ms)/1000);
    meanFR_10ms = sum(histc(tData{iCell},time10ms))/(diff(time10ms)/1000);

% Light
    nLight1ms = length(lightTime.w1ms);
    nLight3ms = length(lightTime.w3ms);
    nLight5ms = length(lightTime.w5ms);
    nLight10ms = length(lightTime.w10ms);
    
    spikeTime1ms = spikeWin(tData{iCell}, lightTime.w1ms, winSpike);
    spikeTime3ms = spikeWin(tData{iCell}, lightTime.w3ms, winSpike);
    spikeTime5ms = spikeWin(tData{iCell}, lightTime.w5ms, winSpike);
    spikeTime10ms = spikeWin(tData{iCell}, lightTime.w10ms, winSpike);
    
    [xpt1ms, ypt1ms, pethtime1ms, peth1ms, pethConv1ms, pethConvZ1ms] = rasterPETH(spikeTime1ms, true(size(lightTime.w1ms)), winSpike, binSize, resolution, 1);
    [xpt3ms, ypt3ms, pethtime3ms, peth3ms, pethConv3ms, pethConvZ3ms] = rasterPETH(spikeTime3ms, true(size(lightTime.w3ms)), winSpike, binSize, resolution, 1);
    [xpt5ms, ypt5ms, pethtime5ms, peth5ms, pethConv5ms, pethConvZ5ms] = rasterPETH(spikeTime5ms, true(size(lightTime.w5ms)), winSpike, binSize, resolution, 1);
    [xpt10ms, ypt10ms, pethtime10ms, peth10ms, pethConv10ms, pethConvZ10ms] = rasterPETH(spikeTime10ms, true(size(lightTime.w10ms)), winSpike, binSize, resolution, 1);
    
    lightspk1ms = sum(0<xpt1ms{1} & xpt1ms{1}<winLight_1ms);
    lightspk3ms = sum(0<xpt3ms{1} & xpt3ms{1}<winLight_3ms);
    lightspk5ms = sum(0<xpt5ms{1} & xpt5ms{1}<winLight_5ms);
    lightspk10ms = sum(0<xpt10ms{1} & xpt10ms{1}<winLight_10ms);
    
    save([cellName, '.mat'],'meanFR_1ms','meanFR_3ms','meanFR_5ms','meanFR_10ms',...
        'xpt1ms','ypt1ms','pethtime1ms','peth1ms','pethConv1ms','pethConvZ1ms','nLight1ms','lightspk1ms',...
        'xpt3ms','ypt3ms','pethtime3ms','peth3ms','pethConv3ms','pethConvZ3ms','nLight3ms','lightspk3ms',...
        'xpt5ms','ypt5ms','pethtime5ms','peth5ms','pethConv5ms','pethConvZ5ms','nLight5ms','lightspk5ms',...
        'xpt10ms','ypt10ms','pethtime10ms','peth10ms','pethConv10ms','pethConvZ10ms','nLight10ms','lightspk10ms');
end
disp('### Laser Intensity Check is done!!! ###');

end