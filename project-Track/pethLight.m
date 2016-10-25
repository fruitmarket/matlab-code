function pethLight()
% function pethLight(criteria_multi,criteria_add)
% Check whether the cell has light response or not.
% It calculates both in-block and between-block responses.
% criteria (%)
%   
%   Author: Joonyeup Lee
%   Version 1.0 (7/25/2016)

% Task variables
binSize = 10; % Unit: msec 
resolution = 10; % sigma = resoution * binSize = 100 msec

% Tag variables
winTagBlue = [-25 100]; % unit: msec
binSizeTagBlue = 2;
winTagYel = [-500 2000]; % unit: msec
binSizeTagYel = 20;

criteria_multi = 0;
criteria_add = 0;

[tData, tList] = tLoad;
nCell = length(tList);

for iCell = 1:nCell
    disp(['### Analyzing ',tList{iCell},'...']);
    [cellPath, cellName, ~] = fileparts(tList{iCell});
    cd(cellPath);
    
    % Load Events variables
    load('Events.mat');
    win = [-1, 1]*1000; % unit:msec, window for binning
    
    % Load spike data
    % tData{iCell} unit: msec
    
    % Light - ontrack
    if isfield(lightTime,'Modu') && ~isempty(lightTime.Modu); % ChETA
        spikeTimeModuBlue = spikeWin(tData{iCell},lightTime.Modu,winTagBlue);
        [xptModuBlue, yptModuBlue, pethtimeModuBlue, pethModuBlue,pethModuConv,pethModuConvZ] = rasterPETH(spikeTimeModuBlue,true(size(lightTime.Modu)),winTagBlue,binSizeTagBlue,resolution,1);     
        lightSpk = sum(0<xptModuBlue{1} & xptModuBlue{1}<15);
        lightPreSpk = sum(-15<xptModuBlue{1} & xptModuBlue{1}<0);
        lightPostSpk = sum(15<xptModuBlue{1} & xptModuBlue{1}<30);
        
        save([cellName,'.mat'],'spikeTimeModuBlue','xptModuBlue','yptModuBlue','pethtimeModuBlue','pethModuBlue','pethModuConv','pethModuConvZ','lightSpk','lightPreSpk','lightPostSpk','-append');
    
    else isfield(lightTime,'Modu') && ~isempty(lightTime.Modu) && size(lightTime.Modu,1)<60; % iC++ (inhibition)
        spikeTimeModuYel = spikeWin(tData{iCell},lightTime.Modu,winTagYel);
        [xptModuYel, yptModuYel, pethtimeModuYel, pethModuYel,~,~] = rasterPETH(spikeTimeModuYel,true(size(lightTime.Modu)),winTagYel,binSizeTagYel,resolution,1);
        
        lightSpk = sum(0<xptModuYel{1} & xptModuYel{1}<1000);
        lightPreSpk = sum(-500<xptModuYel{1} & xptModuYel{1}<0);
        lightPostSpk = sum(1000<xptModuYel{1} & xptModuYel{1}<1500);
        
        save([cellName,'.mat'],'spikeTimeModuYel','xptModuYel','yptModuYel','pethtimeModuYel','pethModuYel','lightSpk','lightPreSpk','lightPostSpk','-append');
    end
    
    if lightPreSpk*(criteria_multi/10+10)/10 + criteria_add < lightSpk % If spikes at light duration more than 10% of spikes during pre = activation
        intraLightDir = 1;
    elseif lightPreSpk*(10-criteria_multi/10)/10 - criteria_add > lightSpk % If spikes at light duration less than 10% of spikes during pre = activation
        intraLightDir = -1;
    else
        intraLightDir = 0;
    end
    save([cellName,'.mat'],'intraLightDir','-append');
        
    % Pseudo light 
    if exist('psdlightPre','var') && exist('psdlightPost','var')
        if ~isempty(lightTime.Modu) && size(lightTime.Modu,1)>60 % ChETA
            spikeTime_psdPre = spikeWin(tData{iCell},psdlightPre,winTagBlue); % Pseudo light Pre
            [xptPsdPre, yptPsdPre, pethtimePsdPre, pethPsdPre,pethPsdPreConv,pethPsdPreConvZ] = rasterPETH(spikeTime_psdPre,true(size(psdlightPre)),winTagBlue,binSizeTagBlue,resolution,1);
            spikeTime_psdPost = spikeWin(tData{iCell},psdlightPost,winTagBlue); % Pseudo light Post
            [xptPsdPost, yptPsdPost, pethtimePsdPost, pethPsdPost,pethPsdPostConv,pethPsdPostConvZ] = rasterPETH(spikeTime_psdPost,true(size(psdlightPost)),winTagBlue,binSizeTagBlue,resolution,1);
            
            psdPreSpk = sum(0<xptPsdPre{1} & xptPsdPre{1}<15);
            psdPostSpk = sum(0<xptPsdPost{1} & xptPsdPost{1}<15);
            save([cellName,'.mat'],'xptPsdPre','yptPsdPre','pethtimePsdPre','pethPsdPreConv','pethPsdPreConvZ','xptPsdPost','yptPsdPost','pethtimePsdPost','psdPostSpk','pethPsdPostConv','pethPsdPostConvZ','-append');
                        
        else ~isempty(lightTime.Modu) && size(lightTime.Modu,1)<60; % iC++ (inhibition)
            spikeTime_psdPre = spikeWin(tData{iCell},psdlightPre,winTagBlue); % Pseudo light Pre
            [xptPsdPre, yptPsdPre, pethtimePsdPre, pethPsdPre,~,~] = rasterPETH(spikeTime_psdPre,true(size(psdlightPre)),winTagBlue,binSizeTagBlue,resolution,1);
            spikeTime_psdPost = spikeWin(tData{iCell},psdlightPost,winTagBlue); % Pseudo light Post
            [xptPsdPost, yptPsdPost, pethtimePsdPost, pethPsdPost,~,~] = rasterPETH(spikeTime_psdPost,true(size(psdlightPost)),winTagBlue,binSizeTagBlue,resolution,1);
            
            psdPreSpk = sum(0<xptPsdPre{1} & xptPsdPre{1}<15);
            psdPostSpk = sum(0<xptPsdPost{1} & xptPsdPost{1}<15);
            save([cellName,'.mat'],'xptPsdPre','yptPsdPre','pethtimePsdPre','pethPsdPreConv','pethPsdPreConvZ','xptPsdPost','yptPsdPost','pethtimePsdPost','psdPostSpk','pethPsdPostConv','pethPsdPostConvZ','-append');
        end
        if psdPreSpk*(criteria_multi/10+10)/10 + criteria_add < lightSpk % If spikes at light duration more than 10% of spikes during pre = activation
            interLightDir = 1;
        elseif psdPreSpk*(10-criteria_multi/10)/10 - criteria_add > lightSpk % If spikes at light duration less than 10% of spikes during pre = inactivation
            interLightDir = -1;
        else
            interLightDir = 0;
        end
        save([cellName,'.mat'],'interLightDir','-append');
    end
    
    % Light - tagging
    if isfield(lightTime,'Tag') && ~isempty(lightTime.Tag); % Activation (ChETA)
       spikeTimeTagBlue = spikeWin(tData{iCell},lightTime.Tag,winTagBlue);
       [xptTagBlue, yptTagBlue, pethtimeTagBlue, pethTagBlue,~,~] = rasterPETH(spikeTimeTagBlue,true(size(lightTime.Tag)),winTagBlue,binSizeTagBlue,resolution,1);
              
       lighttagSpk = sum(0<xptTagBlue{1} & xptTagBlue{1}<15);
       lighttagPreSpk = sum(-15<xptTagBlue{1} & xptTagBlue{1}<0);
       lighttagPostSpk = sum(15<xptTagBlue{1} & xptTagBlue{1}<30);
       
       save([cellName,'.mat'],'spikeTimeTagBlue','xptTagBlue','yptTagBlue','pethtimeTagBlue','pethTagBlue','lighttagSpk','lighttagPreSpk','lighttagPostSpk','-append');
       
    else isfield(lightTime,'Tag') && ~isempty(lightTime.Tag) && size(lightTime.Modu,1) < 60; % inhibition (iC++)
        spikeTimeTagYel = spikeWin(tData{iCell},lightTime.Tag,winTagYel);
        [xptTagYel, yptTagYel, pethtimeTagYel, pethTagYel,~,~] = rasterPETH(spikeTimeTagYel,true(size(lightTime.Tag)),winTagYel,binSizeTagYel,resolution,1);
        
       lighttagSpk = sum(0<xptModuYel{1} & xptModuYel{1}<1000);
       lighttagPreSpk = sum(-500<xptModuYel{1} & xptModuYel{1}<0);
       lighttagPostSpk = sum(1000<xptModuYel{1} & xptModuYel{1}<1500);
        
       save([cellName,'.mat'],'spikeTimeTagYel','xptTagYel','yptTagYel','pethtimeTagYel','pethTagYel','lighttagSpk','lighttagPreSpk','lighttagPostSpk','-append');
    end
    if lighttagPreSpk*(criteria_multi/10+10)/10 + criteria_add < lighttagSpk % If spikes at light duration are more than 10% of spikes during pre = activation
        tagLightDir = 1;
    elseif lighttagPreSpk*(10-criteria_multi/10)/10 - criteria_add > lighttagSpk % If spikes at light duration are less than 10% of spikes during pre = activation
        tagLightDir = -1;
    else
        tagLightDir = 0;
    end
    save([cellName,'.mat'],'tagLightDir','-append');
end
disp('### pethLight is done! ###');

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