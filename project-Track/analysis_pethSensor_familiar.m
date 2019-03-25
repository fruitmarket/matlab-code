function analysis_pethSensor_familiar()
% pethSensor Converts data from MClust t files to Matlab mat files

% ##### Modified Dohyoung Kim's code. Thanks to Dohyoung! ##### %
% 1. calculate mean firing rate, burst index
% 2. raster, psth aligned with each sensor
% 3. save raw data for later use: spikeTime{trial}
narginchk(0,2);

% Task variables
binSize = 5; % Unit: msec (=10 msec)
resolution = 10; % sigma = resoution * binSize
dot = 0; % line (0) or dot(1)
[tData, tList] = tLoad;
nCell = length(tList);

for iCell = 1:nCell
    disp(['### Analyzing ',tList{iCell},'...']);
    [cellPath,cellName,~] = fileparts(tList{iCell});
    cd(cellPath);
    
    % Load Events variables
    load('Events.mat');
    win = [-3, 3]*1000; % unit:msec, window for binning
    
    % Load Spike data
    spikeData = tData{iCell}; % unit: msec
    
%% Mean firing rate (base, track)
    meanFR_PlfmPre = sum(histc(spikeData,timePlfmPre))/(diff(timePlfmPre)/1000);
    meanFR_PlfmPost = sum(histc(spikeData,timePlfmPost))/(diff(timePlfmPost)/1000);
    meanFR_Pre = sum(histc(spikeData,timePre))/(diff(timePre)/1000);
    meanFR_Stim = sum(histc(spikeData,timeStim))/(diff(timeStim)/1000);
    meanFR_Post = sum(histc(spikeData,timePost))/(diff(timePost)/1000);
    meanFR_Task = sum(histc(spikeData,timeTask))/(diff(timeTask)/1000);    
        
%% between sensor firing rate
    sensorMeanFR_Run = meanFiringRate(sensor(:,6), sensor(:,9), spikeData);
    sensorMeanFR_Rw = meanFiringRate(sensor(:,10), sensor(:,11), spikeData);
    
%% Busrst index (Ref: Hyunjung's paper)
    spikeIdx = [timeTask(1)<spikeData & spikeData<timeTask(2)];
    spikeISI = diff(spikeData(spikeIdx));
    burstIdx = length(find(spikeISI<mean(spikeISI)/4))/length(spikeISI);
    
    sName = {'S01','S02','S03','S04','S05','S06','S07','S08','S09','S10','S11','S12'};
    for iSensor = 1:12
        spikeTime.(sName{iSensor}) = spikeWin(spikeData, sensor(:,iSensor), win);
    end
    
    % Making raster unit of xpt is msec. unit of ypt is trail.
    for iSensor = 1:12
        [xptS.(sName{iSensor}), yptS.(sName{iSensor}), pethtimeS.(sName{iSensor}), pethbarS.(sName{iSensor}), pethconvS.(sName{iSensor}), pethconvzS.(sName{iSensor})] = rasterPETH(spikeTime.(sName{iSensor}), trialIndex, win, binSize, resolution, dot);
    end

    save([cellName,'.mat'],...
        'meanFR_PlfmPre','meanFR_PlfmPost','meanFR_Pre','meanFR_Stim','meanFR_Post','meanFR_Task',...
        'sensorMeanFR_Run','sensorMeanFR_Rw',...
        'burstIdx','spikeTime','xptS','yptS','pethtimeS','pethbarS','pethconvS','pethconvzS');
end
disp('### Making Raster, PETH is done!');