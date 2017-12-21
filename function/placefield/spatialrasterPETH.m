function [xpt,ypt,spikeBin,spikeHist,spikeConv,spikeConvZ] = spatialrasterPETH(spikePosition, trialIndex, occupancy, win, binSize, resolution, dot)
%   rasterPSTH converts spike time into raster plot
%   spikeTime: cell array. each cell contains vector array of spike times per each trial. unit is msec
%   trialIndex: number of rows should be same as number of trials (length of spikeTime)
%   Occupancy: visit time
%   win: window range of xpt. should be 2 numbers. unit is msec.
%   binsize: unit is msec.
%   resolution: sigma for convolution = binsize * resolution.
%   dot: 1-dot, 0-line
%   unit of xpt will be msec.
narginchk(6, 7);
if isempty(spikePosition) || isempty(trialIndex) || length(spikePosition) ~= size(trialIndex,1) || length(win) ~= 2
    xpt = []; ypt = []; spikeBin = []; spikeHist = []; spikeConv = []; spikeConvZ = [];
    return;
end;

spikeBin = win(1):binSize:win(2); % unit: cm
nSpikeBin = length(spikeBin)-1; % drop the last bin

nTrial = length(spikePosition);
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
    nSpikePerTrial = cellfun(@length,spikePosition(trialIndex(:,iCue)));
    nSpikeTotal = sum(nSpikePerTrial);
    if nSpikeTotal == 0; continue; end;
    
    spikeTemp = cell2mat(spikePosition(trialIndex(:,iCue)))';
    
    xptTemp = [spikeTemp;spikeTemp;NaN(1,nSpikeTotal)];
    if (nargin == 7) && (dot==1)
        xpt{iCue} = xptTemp(2,:);
    else
        xpt{iCue} = xptTemp(:);
    end

    yptTemp = [];
    for iy = 1:trialResult(iCue)
        yptTemp = [yptTemp repmat(yTemp(:,resultSum(iCue)+iy),1,nSpikePerTrial(iy))];
    end
    if (nargin == 7) && (dot==1)
        ypt{iCue} = yptTemp(2,:);
    else
        ypt{iCue} = yptTemp(:);
    end

% psth
    spikehist_temp = histc(spikeTemp,spikeBin)/binSize;
    spikehistOccu_temp = spikehist_temp(1:end-1)./occupancy(iCue,:);
    spikeconv_temp = conv(spikehistOccu_temp,fspecial('Gaussian',[1 5*resolution],resolution),'same');
    spikeHist(iCue,:) = spikehistOccu_temp;
    spikeConv(iCue,:) = spikeconv_temp;
end
totalHist = histc(cell2mat(spikePosition),spikeBin)/binSize*30;
if isempty(totalHist)
    [fireMean, fireStd, spikeConvZ] = deal(NaN);
else
    fireMean = mean(totalHist);
    fireStd = std(totalHist);
    spikeConvZ = (spikeConv-fireMean)/fireStd;
end