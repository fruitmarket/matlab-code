function analysis_lightPlaceSeparation()
% function pethLight(criteria_multi,criteria_add)
% Check whether the cell has light response or not.
% It calculates both in-block and between-block responses.
% criteria (%)
%   
%   Author: Joonyeup Lee
%   Version 1.0 (7/25/2016)

% Task variables
resolution = 10; % sigma = resoution * binSize = 100 msec
binSizeBlue = 2;
winTrack = [-25 100];

[tData, tList] = tLoad;
nCell = length(tList);

load('Events.mat');
lightOnset = lightTime.Track8hz;

for iCell = 1:nCell
    disp(['### pethLight analysis: ',tList{iCell},'...']);
    [cellPath, cellName, ~] = fileparts(tList{iCell});
    cd(cellPath);
    
    if ~isempty(strfind(cellPath,'DRun'));
        [light67, light78, light89] = deal([]);
        [psdPrelight67, psdPrelight78, psdPrelight89] = deal([]);
        [psdPostlight67, psdPostlight78, psdPostlight89] = deal([]);
        for iLap = 1:30
            temp_psdPrelight67 = psdlightPre(sensor.S6(iLap)<psdlightPre & psdlightPre<=sensor.S7(iLap));
            temp_psdPrelight78 = psdlightPre(sensor.S7(iLap)<psdlightPre & psdlightPre<=sensor.S8(iLap));
            temp_psdPrelight89 = psdlightPre(sensor.S8(iLap)<psdlightPre & psdlightPre<=sensor.S9(iLap));
            
            templightT67 = lightOnset(sensor.S6(iLap+30)<lightOnset & lightOnset<=sensor.S7(iLap+30));
            templightT78 = lightOnset(sensor.S7(iLap+30)<lightOnset & lightOnset<=sensor.S8(iLap+30));
            templightT89 = lightOnset(sensor.S8(iLap+30)<lightOnset & lightOnset<=sensor.S9(iLap+30));
            
            temp_psdPostlight67 = psdlightPost(sensor.S6(iLap+60)<psdlightPost & psdlightPost<=sensor.S7(iLap+60));
            temp_psdPostlight78 = psdlightPost(sensor.S7(iLap+60)<psdlightPost & psdlightPost<=sensor.S8(iLap+60));
            temp_psdPostlight89 = psdlightPost(sensor.S8(iLap+60)<psdlightPost & psdlightPost<=sensor.S9(iLap+60));
            
            psdPrelight67 = [psdPrelight67; temp_psdPrelight67];
            psdPrelight78 = [psdPrelight78; temp_psdPrelight78];
            psdPrelight89 = [psdPrelight89; temp_psdPrelight89];
            
            light67 = [light67; templightT67];
            light78 = [light78; templightT78];
            light89 = [light89; templightT89];
            
            psdPostlight67 = [psdPostlight67; temp_psdPostlight67];
            psdPostlight78 = [psdPostlight78; temp_psdPostlight78];
            psdPostlight89 = [psdPostlight89; temp_psdPostlight89];
        end
    spikeTimePsdPre67 = spikeWin(tData{iCell},psdPrelight67,winTrack);
    [xptPsdPre67, yptPsdPre67, pethtimePsdPre67, pethPsdPre67,pethPsdPre67Conv,pethPsdPre67ConvZ] = rasterPETH(spikeTimePsdPre67,true(size(psdPrelight67)),winTrack,binSizeBlue,resolution,1);
    spikeTimePsdPre78 = spikeWin(tData{iCell},psdPrelight78,winTrack);
    [xptPsdPre78, yptPsdPre78, pethtimePsdPre78, pethPsdPre78,pethPsdPre78Conv,pethPsdPre78ConvZ] = rasterPETH(spikeTimePsdPre78,true(size(psdPrelight78)),winTrack,binSizeBlue,resolution,1);
    spikeTimePsdPre89 = spikeWin(tData{iCell},psdPrelight89,winTrack);
    [xptPsdPre89, yptPsdPre89, pethtimePsdPre89, pethPsdPre89,pethPsdPre89Conv,pethPsdPre89ConvZ] = rasterPETH(spikeTimePsdPre89,true(size(psdPrelight89)),winTrack,binSizeBlue,resolution,1);    
    
    spikeTimeLight67 = spikeWin(tData{iCell},light67,winTrack);
    [xptLight67, yptLight67, pethtimeLight67, pethLight67,pethLight67Conv,pethLight67ConvZ] = rasterPETH(spikeTimeLight67,true(size(light67)),winTrack,binSizeBlue,resolution,1);
    spikeTimeLight78 = spikeWin(tData{iCell},light78,winTrack);
    [xptLight78, yptLight78, pethtimeLight78, pethLight78,pethLight78Conv,pethLight78ConvZ] = rasterPETH(spikeTimeLight78,true(size(light78)),winTrack,binSizeBlue,resolution,1);
    spikeTimeLight89 = spikeWin(tData{iCell},light89,winTrack);
    [xptLight89, yptLight89, pethtimeLight89, pethLight89,pethLight89Conv,pethLight89ConvZ] = rasterPETH(spikeTimeLight89,true(size(light89)),winTrack,binSizeBlue,resolution,1);
    
    spikeTimePsdPost67 = spikeWin(tData{iCell},psdPostlight67,winTrack);
    [xptPsdPost67, yptPsdPost67, pethtimePsdPost67, pethPsdPost67,pethPsdPost67Conv,pethPsdPost67ConvZ] = rasterPETH(spikeTimePsdPost67,true(size(psdPostlight67)),winTrack,binSizeBlue,resolution,1);
    spikeTimePsdPost78 = spikeWin(tData{iCell},psdPostlight78,winTrack);
    [xptPsdPost78, yptPsdPost78, pethtimePsdPost78, pethPsdPost78,pethPsdPost78Conv,pethPsdPost78ConvZ] = rasterPETH(spikeTimePsdPost78,true(size(psdPostlight78)),winTrack,binSizeBlue,resolution,1);
    spikeTimePsdPost89 = spikeWin(tData{iCell},psdPostlight89,winTrack);
    [xptPsdPost89, yptPsdPost89, pethtimePsdPost89, pethPsdPost89,pethPsdPost89Conv,pethPsdPost89ConvZ] = rasterPETH(spikeTimePsdPost89,true(size(psdPostlight89)),winTrack,binSizeBlue,resolution,1);

    else
        [psdPrelight67,psdPrelight78,psdPrelight89,light67,light78,light89,psdPostlight67,psdPostlight78,psdPostlight89] = deal(NaN);
        [xptPsdPre67, yptPsdPre67, pethtimePsdPre67, pethPsdPre67, pethPsdPre67Conv, pethPsdPre67ConvZ] = deal(NaN);
        [xptPsdPre78, yptPsdPre78, pethtimePsdPre78, pethPsdPre78, pethPsdPre78Conv, pethPsdPre78ConvZ] = deal(NaN);
        [xptPsdPre89, yptPsdPre89, pethtimePsdPre89, pethPsdPre89, pethPsdPre89Conv, pethPsdPre89ConvZ] = deal(NaN);
        [xptLight67, yptLight67, pethtimeLight67, pethLight67, pethLight67Conv, pethLight67ConvZ] = deal(NaN);
        [xptLight78, yptLight78, pethtimeLight78, pethLight78, pethLight78Conv, pethLight78ConvZ] = deal(NaN);
        [xptLight89, yptLight89, pethtimeLight89, pethLight89, pethLight89Conv, pethLight89ConvZ] = deal(NaN);
        [xptPsdPost67, yptPsdPost67, pethtimePsdPost67, pethPsdPost67, pethPsdPost67Conv, pethPsdPost67ConvZ] = deal(NaN);
        [xptPsdPost78, yptPsdPost78, pethtimePsdPost78, pethPsdPost78, pethPsdPost78Conv, pethPsdPost78ConvZ] = deal(NaN);
        [xptPsdPost89, yptPsdPost89, pethtimePsdPost89, pethPsdPost89, pethPsdPost89Conv, pethPsdPost89ConvZ] = deal(NaN);
    end

    save([cellName,'.mat'],...
        'psdPrelight67','psdPrelight78','psdPrelight89','light67','light78','light89','psdPostlight67','psdPostlight78','psdPostlight89',...
        'xptPsdPre67','yptPsdPre67','pethtimePsdPre67','pethPsdPre67','pethPsdPre67Conv','pethPsdPre67ConvZ',...
        'xptPsdPre78','yptPsdPre78','pethtimePsdPre78','pethPsdPre78','pethPsdPre78Conv','pethPsdPre78ConvZ',...
        'xptPsdPre89','yptPsdPre89','pethtimePsdPre89','pethPsdPre89','pethPsdPre89Conv','pethPsdPre89ConvZ',...
        'xptLight67','yptLight67','pethtimeLight67','pethLight67','pethLight67Conv','pethLight67ConvZ',...
        'xptLight78','yptLight78','pethtimeLight78','pethLight78','pethLight78Conv','pethLight78ConvZ',...
        'xptLight89','yptLight89','pethtimeLight89','pethLight89','pethLight89Conv','pethLight89ConvZ',...
        'xptPsdPost67','yptPsdPost67','pethtimePsdPost67','pethPsdPost67','pethPsdPost67Conv','pethPsdPost67ConvZ',...
        'xptPsdPost78','yptPsdPost78','pethtimePsdPost78','pethPsdPost78','pethPsdPost78Conv','pethPsdPost78ConvZ',...
        'xptPsdPost89','yptPsdPost89','pethtimePsdPost89','pethPsdPost89','pethPsdPost89Conv','pethPsdPost89ConvZ','-append');
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