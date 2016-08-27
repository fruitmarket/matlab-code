function psthTrack(sessionFolder)
% psthtrack Converts data from MClust t files to Matlab mat files

% ##### Modified Dohyoung Kim's code. Thanks to Dohyoung! ##### %
% 1. raster, psth aligned with each sensor
% 2. raster, psth aligned with light stimulation
% 3. save raw data for later use: spikeTime{trial}
% 4. tagging data under blue or yellow light

narginchk(0,2);

% Task variables
binSize = 5; % Unit: msec (=10 msec)
resolution = 10; % sigma = resoution * binSize = 100 msec

% Tag variables
winTagBlue = [-25 100]; % unit: msec
binSizeTagBlue = 2;
winTagYel = [-500 2000]; % unit: msec
binSizeTagYel = 20;

[tData, tList] = tLoad;
nCell = length(tList);

for iCell = 1:nCell
    disp(['### Analyzing ',tList{iCell},'...']);
    [cellPath,cellName,~] = fileparts(tList{iCell});
    cd(cellPath);
    
    % Load Events variables
    load('Events.mat');
    win = [-1, 1]*1000; % unit:msec, window for binning
    
    % Load Spike data
    spikeData = tData{iCell}; % unit: msec
    
    % Mean firing rate
    fr_base = sum(histc(spikeData,baseTime))/(diff(baseTime)/1000);
    fr_task = sum(histc(spikeData,taskTime))/(diff(taskTime)/1000);
    
    % Busrst index (Ref: Hyunjung's paper)
    spikeIdx = [taskTime(1)<spikeData & spikeData<taskTime(2)];
    spikeISI = diff(spikeData(spikeIdx));
    burstIdx = length(find(spikeISI<mean(spikeISI)/4))/length(spikeISI);
    
    for iSensor = 1:nSensor
        spikeTime.(fields{iSensor}) = spikeWin(spikeData, sensor.(fields{iSensor}), win(1,:));
    end
    
    % Making raster unit of xpt is sec. unit of ypt is trail.
    for iSensor = 1:nSensor
        [xpt.(fields{iSensor}), ypt.(fields{iSensor}), psthtime.(fields{iSensor}), psthbar.(fields{iSensor}), psthconv.(fields{iSensor}), psthconvz.(fields{iSensor})] = rasterPSTH(spikeTime.(fields{iSensor}), trialIndex, win, binSize, resolution, 1);
        xpt.(fields{iSensor}) = cellfun(@(x) x/1000, xpt.(fields{iSensor}), 'UniformOutput', false);
        psthtime.(fields{iSensor}) = psthtime.(fields{iSensor})/10^3;
    end

%     % Making raster unit of xpt is sec. unit of ypt is trail.
%     [xpt.S1, ypt.S1, psthtime.S1, psthbar.S1, psthconv.S1, psthconvz.S1] = rasterPSTH(spikeTime.S1, trialIndex, win, binSize, resolution, 1);
%     xpt.S1 = cellfun(@(x) x/1000, xpt.S1, 'UniformOutput', false); psthtime.S1 = psthtime.S1/10^3;
%     [xpt.S2, ypt.S2, psthtime.S2, psthbar.S2, psthconv.S2, psthconvz.S2] = rasterPSTH(spikeTime.S2, trialIndex, win, binSize, resolution, 1);

    save([cellName,'.mat'],...
        'fr_base','fr_task','burstIdx',...
        'spikeTime',...
        'win','xpt','ypt','psthtime','psthbar','psthconv','psthconvz');
    
    % Light Modulation
    if isfield(lightTime,'Modu') && ~isempty(lightTime.Modu);
        spikeTimeModuBlue = spikeWin(spikeData,lightTime.Modu,winTagBlue);
        [xptModuBlue, yptModuBlue, psthtimeModuBlue, psthModuBlue,~,~] = rasterPSTH(spikeTimeModuBlue,true(size(lightTime.Modu)),winTagBlue,binSizeTagBlue,resolution,1);
        save([cellName,'.mat'],...
            'spikeTimeModuBlue','xptModuBlue','yptModuBlue','psthtimeModuBlue','psthModuBlue','-append');
    else isfield(lightTime,'Modu') && ~isempty(lightTime.Modu) && size(lightTime.Modu,1)<60;
        spikeTimeModuYel = spikeWin(spikeData,lightTime.Modu,winTagYel);
        [xptModuYel, yptModuYel, psthtimeModuYel, psthModuYel,~,~] = rasterPSTH(spikeTimeModuYel,true(size(lightTime.Modu)),winTagYel,binSizeTagYel,resolution,1);
        save([cellName,'.mat'],...
            'spikeTimeModuYel','xptModuYel','yptModuYel','psthtimeModuYel','psthModuYel','-append');
    end
    
    % Tagging
    if isfield(lightTime,'Tag') && ~isempty(lightTime.Tag);
       spikeTimeTagBlue = spikeWin(spikeData,lightTime.Tag,winTagBlue);
       [xptTagBlue, yptTagBlue, psthtimeTagBlue, psthTagBlue,~,~] = rasterPSTH(spikeTimeTagBlue,true(size(lightTime.Tag)),winTagBlue,binSizeTagBlue,resolution,1);
       save([cellName,'.mat'],...
           'spikeTimeTagBlue','xptTagBlue','yptTagBlue','psthtimeTagBlue','psthTagBlue','-append');
    else isfield(lightTime,'Tag') && ~isempty(lightTime.Tag) && size(lightTime.Modu,1) < 60;
        spikeTimeTagYel = spikeWin(spikeData,lightTime.Tag,winTagYel);
        [xptTagYel, yptTagYel, psthtimeTagYel, psthTagYel,~,~] = rasterPSTH(spikeTimeTagYel,true(size(lightTime.Tag)),winTagYel,binSizeTagYel,resolution,1);
        save([cellName,'.mat'],...
            'spikeTimeTagYel','xptTagYel','yptTagYel','psthtimeTagYel','psthTagYel','-append');
    end
end
disp('### Making Raster, PSTH is done!');

function spikeTime = spikeWin(spikeData, eventTime, win)
% spikeWin makes raw spikeData to eventTime aligned data
%   spikeData: raw data from MClust. Unit must be ms.
%   eventTime: each output cell will be eventTime aligned spike data. unit must be ms
%   win: spike within windows will be included. unit must be ms.
narginchk(3,3);

if isempty(eventTime); spikeTime =[]; return; end;
nEvent = size(eventTime);
spikeTime = cell(nEvent);
for iEvent = 1:nEvent(1)
    for jEvent = 1:nEvent(2)
        timeIndex = [];
        if isnan(eventTime(iEvent,jEvent)); continue; end;
        [~,timeIndex] = histc(spikeData,eventTime(iEvent,jEvent)+win);
        if isempty(timeIndex); continue; end;
        spikeTime{iEvent,jEvent} = spikeData(logical(timeIndex))-eventTime(iEvent,jEvent);
    end
end

function [xpt,ypt,spikeBin,spikeHist,spikeConv,spikeConvZ] = rasterPSTH(spikeTime, trialIndex, win, binSize, resolution, dot)
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
end;

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
    if nSpikeTotal == 0; continue; end;
    
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