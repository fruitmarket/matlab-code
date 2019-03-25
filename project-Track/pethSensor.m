function pethSensor(sessionFolder)
% pethSensor Converts data from MClust t files to Matlab mat files

% ##### Modified Dohyoung Kim's code. Thanks to Dohyoung! ##### %
% 1. calculate mean firing rate, burst index
% 2. raster, psth aligned with each sensor
% 3. save raw data for later use: spikeTime{trial}
narginchk(0,2);

% Task variables
binSize = 5; % Unit: msec (=10 msec)
resolution = 10; % sigma = resoution * binSize = 100 msec

[tData, tList] = tLoad;
nCell = length(tList);

for iCell = 1:nCell
    disp(['### Analyzing ',tList{iCell},'...']);
    [cellPath,cellName,~] = fileparts(tList{iCell});
    cd(cellPath);
    
    % Load Events variables
    load('Events.mat');
    win = [-7, 7]*1000; % unit:msec, window for binning
    
    % Load Spike data
    spikeData = tData{iCell}; % unit: msec
    
%% Mean firing rate (base, track)
    meanFR_base = sum(histc(spikeData,baseTime))/(diff(baseTime)/1000);
    meanFR_task = sum(histc(spikeData,taskTime))/(diff(taskTime)/1000);
        
    % Mean firing rate (block)
    time_post = [sensor.S1(61), sensor.S1(90)]; % for the case when light stimulation existed after sensor12(90)
    meanFR_pre = sum(histc(spikeData,preTime))/(diff(preTime)/1000);
    meanFR_stm = sum(histc(spikeData,stmTime))/(diff(stmTime)/1000);
    if isempty(postTime)
        meanFR_post = sum(histc(spikeData,time_post))/(diff(time_post)/1000);
    else
        meanFR_post = sum(histc(spikeData,postTime))/(diff(postTime)/1000);
    end
    
%% between sensor firing rate
    sensorMeanFR_Run = meanFiringRate(sensor.S6, sensor.S9, spikeData);
    sensorMeanFR_Rw = meanFiringRate(sensor.S10, sensor.S11, spikeData);
    
%% Busrst index (Ref: Hyunjung's paper)
    spikeIdx = [taskTime(1)<spikeData & spikeData<taskTime(2)];
    spikeISI = diff(spikeData(spikeIdx));
    burstIdx = length(find(spikeISI<mean(spikeISI)/4))/length(spikeISI);
    
    for iSensor = 1:nSensor
        spikeTime.(fields{iSensor}) = spikeWin(spikeData, sensor.(fields{iSensor}), win(1,:));
    end
    
    % Making raster unit of xpt is sec. unit of ypt is trail.
    for iSensor = 1:nSensor
        [xpt.(fields{iSensor}), ypt.(fields{iSensor}), pethtime.(fields{iSensor}), pethbar.(fields{iSensor}), pethconv.(fields{iSensor}), pethconvz.(fields{iSensor})] = rasterPETH(spikeTime.(fields{iSensor}), trialIndex, win, binSize, resolution, 1);
        xpt.(fields{iSensor}) = cellfun(@(x) x/1000, xpt.(fields{iSensor}), 'UniformOutput', false);
        pethtime.(fields{iSensor}) = pethtime.(fields{iSensor})/10^3; % devided to draw in 'sec' unit
    end

    save([cellName,'.mat'],...
        'meanFR_base','meanFR_task','meanFR_pre','meanFR_stm','meanFR_post',...
        'sensorMeanFR_Run','sensorMeanFR_Rw',...
        'burstIdx','spikeTime','win','xpt','ypt','pethtime','pethbar','pethconv','pethconvz');
end
disp('### Making Raster, PETH is done!');

function spikeTime = spikeWin(spikeData, eventTime, win)
% spikeWin makes raw spikeData to eventTime aligned data
%   spikeData: raw data from MClust. Unit must be ms.
%   eventTime: each output cell will be eventTime aligned spike data. unit must be ms
%   win: spike within windows will be included. unit must be ms.
narginchk(3,3);

if isempty(eventTime); spikeTime =[]; return; end
nEvent = size(eventTime);
spikeTime = cell(nEvent);
for iEvent = 1:nEvent(1)
    for jEvent = 1:nEvent(2)
        timeIndex = [];
        if isnan(eventTime(iEvent,jEvent)); continue; end
        [~,timeIndex] = histc(spikeData,eventTime(iEvent,jEvent)+win);
        if isempty(timeIndex); continue; end
        spikeTime{iEvent,jEvent} = spikeData(logical(timeIndex))-eventTime(iEvent,jEvent);
    end
end
function [xpt,ypt,spikeBin,spikeHist,spikeConv,spikeConvZ] = rasterPETH(spikeTime, trialIndex, win, binSize, resolution, dot)
% raterPSTH converts spike time into raster plot
%   spikeTime: cell array. Each cell contains vector array of spike times per each trial unit is ms.
%   trialIndex: number of raws should be same as number of trials (length of spikeTime)
%   win: window range of xpt. should be 2 numbers. unit is msec.
%   resolution: sigma for convolution = binsize * resolution.
%   dot: 1-dot, 0-line
%   unit of xpt will be msec.
narginchk(5,6);
if isempty(spikeTime) || isempty(trialIndex) || length(spikeTime) ~= size(trialIndex,1) || length(win) ~= 2
    xpt = []; ypt = []; spikeBin = []; spikeHist = []; spikeConv = []; spikeConvZ = [];
    return;
end

spikeBin = win(1):binSize:win(2); % unit: msec
nSpikeBin = length(spikeBin);

nTrial = length(spikeTime);
nCue = size(trialIndex,2);
trialResult = sum(trialIndex);
resultSum = [0 cumsum(trialResult)];

yTemp = [0:nTrial-1; 1:nTrial; NaN(1,nTrial)]; % template for ypt
xpt = cell(1,nCue);
ypt = cell(1,nCue);
spikeHist = zeros(nCue,nSpikeBin);
spikeConv = zeros(nCue,nSpikeBin);

for iCue = 1:nCue
    % raster
    nSpikePerTrial = cellfun(@length,spikeTime(trialIndex(:,iCue)));
    nSpikeTotal = sum(nSpikePerTrial);
    if nSpikeTotal == 0; continue; end
    
    spikeTemp = cell2mat(spikeTime(trialIndex(:,iCue)))';
    
    xptTemp = [spikeTemp;spikeTemp;NaN(1,nSpikeTotal)];
    if (nargin == 6) && (dot==1)
        xpt{iCue} = xptTemp(2,:);
    else
        xpt{iCue} = xptTemp(:);
    end
    
    yptTemp = [];
    for iy = 1:trialResult(iCue)
        yptTemp = [yptTemp repmat(yTemp(:,resultSum(iCue)+iy),1,nSpikePerTrial(iy))];
    end
    if (nargin == 6) && (dot==1)
        ypt{iCue} = yptTemp(2,:);
    else
        ypt{iCue} = yptTemp(:);
    end
    
    % psth
    spkhist_temp = histc(spikeTemp,spikeBin)/(binSize/10^3*trialResult(iCue));
    spkconv_temp = conv(spkhist_temp,fspecial('Gaussian',[1 5*resolution],resolution),'same');
    spikeHist(iCue,:) = spkhist_temp;
    spikeConv(iCue,:) = spkconv_temp;
end
totalHist = histc(cell2mat(spikeTime),spikeBin)/(binSize/10^3*nTrial);
fireMean = mean(totalHist);
fireStd = std(totalHist);
spikeConvZ = (spikeConv-fireMean)/fireStd;