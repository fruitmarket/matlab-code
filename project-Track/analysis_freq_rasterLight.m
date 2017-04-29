function analysis_freq_rasterLight()

winCri1hz = [-500, 15500];
winCri2hz = [-500, 8000];
winCri8hz = [-500, 2500];
winCri20hz = [-500, 1000];
winCri50hz = [-500, 1000];
winCri_ori = [-10, 100];
winCri_ori2 = [-10, 30];
winCri_ori3 = [-5, 15];

win1hz = [-500, 14500];
win2hz = [-500, 7500];
win8hz = [-500, 2000];
win20hz = [-500, 1000];
win50hz = [-500, 1000];

binSize = 2;
resolution = 10;

[tData, tList] = tLoad;
nCell = length(tList);

nTrial = 20;
nTrial_ori = 300;

for iCell = 1:nCell
    disp(['### Analyzing ',tList{iCell},'...']);
    [cellPath, cellName, ~] = fileparts(tList{iCell});
    cd(cellPath);
    
    load Events.mat

        spkTime1hz_ori = spikeWin(tData{iCell},lightTime.Plfm1hz,winCri_ori);
        [xpt1hz_ori, ypt1hz_ori, pethtime1hz_ori, peth1hz_ori, peth1hzConv_ori, peth1hzConvZ_ori] = rasterPETH(spkTime1hz_ori,true(size(lightTime.Plfm1hz)),winCri_ori,binSize,resolution,1);

        spkTime2hz_ori = spikeWin(tData{iCell},lightTime.Plfm2hz,winCri_ori);
        [xpt2hz_ori, ypt2hz_ori, pethtime2hz_ori, peth2hz_ori, peth2hzConv_ori, peth2hzConvZ_ori] = rasterPETH(spkTime2hz_ori,true(size(lightTime.Plfm2hz)),winCri_ori,binSize,resolution,1);

        spkTime8hz_ori = spikeWin(tData{iCell},lightTime.Plfm8hz,winCri_ori);
        [xpt8hz_ori, ypt8hz_ori, pethtime8hz_ori, peth8hz_ori, peth8hzConv_ori, peth8hzConvZ_ori] = rasterPETH(spkTime8hz_ori,true(size(lightTime.Plfm8hz)),winCri_ori,binSize,resolution,1);

        spkTime20hz_ori = spikeWin(tData{iCell},lightTime.Plfm20hz,winCri_ori);
        [xpt20hz_ori, ypt20hz_ori, pethtime20hz_ori, peth20hz_ori, peth20hzConv_ori, peth20hzConvZ_ori] = rasterPETH(spkTime20hz_ori,true(size(lightTime.Plfm20hz)),winCri_ori2,binSize,resolution,1);

        spkTime50hz_ori = spikeWin(tData{iCell},lightTime.Plfm50hz,winCri_ori);
        [xpt50hz_ori, ypt50hz_ori, pethtime50hz_ori, peth50hz_ori, peth50hzConv_ori, peth50hzConvZ_ori] = rasterPETH(spkTime50hz_ori,true(size(lightTime.Plfm50hz)),winCri_ori3,binSize,resolution,1);

    % Spikes are aligned on each light 
        spkTime1hz = spikeWin(tData{iCell},lightTime.Plfm1hz(1:15:end),winCri1hz);
        [xpt1hz, ypt1hz, pethtime1hz, peth1hz, peth1hzConv, peth1hzConvZ] = rasterPETH(spkTime1hz,true(size(spkTime1hz)),win1hz,binSize,resolution,1);

        spkTime2hz = spikeWin(tData{iCell},lightTime.Plfm2hz(1:15:end),winCri2hz);
        [xpt2hz, ypt2hz, pethtime2hz, peth2hz, peth2hzConv, peth2hzConvZ] = rasterPETH(spkTime2hz,true(size(spkTime2hz)),win2hz,binSize,resolution,1);

        spkTime8hz = spikeWin(tData{iCell},lightTime.Plfm8hz(1:15:end),winCri8hz);
        [xpt8hz, ypt8hz, pethtime8hz, peth8hz, peth8hzConv, peth8hzConvZ] = rasterPETH(spkTime8hz,true(size(spkTime8hz)),win8hz,binSize,resolution,1);

        spkTime20hz = spikeWin(tData{iCell},lightTime.Plfm20hz(1:15:end),winCri20hz);
        [xpt20hz, ypt20hz, pethtime20hz, peth20hz, peth20hzConv, peth20hzConvZ] = rasterPETH(spkTime20hz,true(size(spkTime20hz)),win20hz,binSize,resolution,1);

        spkTime50hz = spikeWin(tData{iCell},lightTime.Plfm50hz(1:15:end),winCri50hz);
        [xpt50hz, ypt50hz, pethtime50hz, peth50hz, peth50hzConv, peth50hzConvZ] = rasterPETH(spkTime50hz,true(size(spkTime50hz)),win50hz,binSize,resolution,1);
        
        save([cellName,'.mat'],'xpt1hz_ori','ypt1hz_ori','pethtime1hz_ori','peth1hz_ori','peth1hzConv_ori','peth1hzConvZ_ori',...
            'xpt2hz_ori','ypt2hz_ori','pethtime2hz_ori','peth2hz_ori','peth2hzConv_ori','peth2hzConvZ_ori',...
            'xpt8hz_ori','ypt8hz_ori','pethtime8hz_ori','peth8hz_ori','peth8hzConv_ori','peth8hzConvZ_ori',...
            'xpt20hz_ori','ypt20hz_ori','pethtime20hz_ori','peth20hz_ori','peth20hzConv_ori','peth20hzConvZ_ori',...
            'xpt50hz_ori','ypt50hz_ori','pethtime50hz_ori','peth50hz_ori','peth50hzConv_ori','peth50hzConvZ_ori',...
            'xpt1hz','ypt1hz','pethtime1hz','peth1hz','peth1hzConv','peth1hzConvZ',...
            'xpt2hz','ypt2hz','pethtime2hz','peth2hz','peth2hzConv','peth2hzConvZ',...
            'xpt8hz','ypt8hz','pethtime8hz','peth8hz','peth8hzConv','peth8hzConvZ',...
            'xpt20hz','ypt20hz','pethtime20hz','peth20hz','peth20hzConv','peth20hzConvZ',...
            'xpt50hz','ypt50hz','pethtime50hz','peth50hz','peth50hzConv','peth50hzConvZ')
end
disp('### rasterPETH is done! ###');

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
