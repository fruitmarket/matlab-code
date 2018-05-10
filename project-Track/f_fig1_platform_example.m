function f_fig1_platform_example
rtDir = 'D:\Dropbox\SNL\P2_Track';
cd(rtDir);
load myParameters.mat;
cd('D:\Dropbox\SNL\P2_Track\Rbp48ori_161201_DV2.15_2_DRw_100_T246'); % example 2, matfile:1, tetrode:2

matFile = mLoad;
[tData, tList] = tLoad;
[cscTime, cscSample, cscList] = cscLoad;
tetrode = 2;

[cellDir, cellName, ~] = fileparts(matFile{1});
cellDirSplit = regexp(cellDir,'\','split');
cellFigName = strcat(cellDirSplit(end-1),'_',cellDirSplit(end),'_',cellName);
formatOut = 'yymmdd';
load(matFile{1});
load Events.mat;

cd(rtDir);

%%
lightPlfm8hz = lightTime.Plfm8hz;
lapLightIdx = [1;(find(diff(lightPlfm8hz)>1000)+1)]; % find start light of each lap
nLabLight = min(diff(lapLightIdx));
nLight = length(lightPlfm8hz);
winBlue = [-20 100];
% win = [-500,3000];
win = [-500,3000];
winAxis = [-200,2500];
binSize = 2;
resolution = 10;
lightOn8hz = lightPlfm8hz(lapLightIdx);

sFreq = 2000; % 2000 samples / sec
winCsc = win/1000*sFreq;
yLimSpike = [0,35];
yLimCSC = [-0.7, 0.8];

spkTimeTrack8hz = spikeWin(tData{2},lightPlfm8hz(lapLightIdx),win);
[xpt8hz, ypt8hz, pethtime8hz, peth8hz, peth8hzConv, peth8hzConvZ] = rasterPETH(spkTimeTrack8hz,true(size(spkTimeTrack8hz)),win,binSize,resolution,1);

idxLight8hz = zeros(30,1);
for iCycle = 1:30
    idxLight8hz(iCycle,1) = find(cscTime{1}>lightOn8hz(iCycle),1,'first');
end
temp_cscSample = cscSample{tetrode};
for iCycle = 1:30
    cscLight8hz(:,iCycle) = temp_cscSample((idxLight8hz(iCycle)+winCsc(1)):(idxLight8hz(iCycle)+winCsc(2)));
end
m_cscLight8hz = mean(cscLight8hz,2);
f_cscLight = bandpassFilter(m_cscLight8hz,sFreq,1,20);
xptCSC = [win(1):0.5:win(2)];

fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});
nCol = 2;
nRow = 2;
%% individual light
hFreq8hz(1) = axes('Position',axpt(3,5,1:2,2,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
for iLight = 1:nLabLight
%     hLBar(1) = rectangle('Position',[125*iLight-125,0,10,30],'LineStyle','none','FaceColor',colorLLightBlue);
%     hold on;
    hLpatch(1) = patch([125*(iLight-1), 125*(iLight-1)+10,125*(iLight-1)+10,125*(iLight-1)],[yLimSpike(2)*0.9, yLimSpike(2)*0.9, yLimSpike(2), yLimSpike(2)],colorLightBlue,'EdgeColor','none');
    hold on;
end
plot(xpt8hz{1},ypt8hz{1},'LineStyle','none','Marker','o','MarkerSize',1,'Color',colorBlack,'MarkerFaceColor',colorBlack,'MarkerEdgeColor','none');
xlabel('Time (ms)','fontSize',fontS);
ylabel('Cycle','fontSize',fontS);

%% csc
hFreq8hz(2) = axes('Position',axpt(3,5,1:2,1,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
for iLight = 1:nLabLight
%     hLBar(1) = rectangle('Position',[125*iLight-125,0,10,30],'LineStyle','none','FaceColor',colorLLightBlue);
%     hold on;
    hLpatch(2) = patch([125*(iLight-1) 125*(iLight-1)+10 125*(iLight-1)+10 125*(iLight-1)],[yLimCSC(2)*0.8 yLimCSC(2)*0.8 yLimCSC(2) yLimCSC(2)],colorLightBlue,'EdgeColor','none');
    hold on;
end
plot(xptCSC,m_cscLight8hz,'color',colorBlack,'lineWidth',1);
text(-350,yLimCSC(2)*0.7,'LFP signal','fontSize',fontS);

%% all light aligned
hFreq8hz(3) = axes('Position',axpt(3,5,1:2,3,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
hLpatch(3) = patch([0 10 10 0],[0 0 nLight nLight],colorLightBlue,'EdgeColor','none');
hold on;
plot(xptPlfm8hz{1}, yptPlfm8hz{1}, 'LineStyle','none','Marker','o','MarkerSize',1,'Color',colorBlack,'MarkerFaceColor',colorBlack,'MarkerEdgeColor','none');

ylabel('n-Light','fontSize',fontS);
xlabel('Time (ms)','fontSize',fontS);

align_ylabel([hFreq8hz(1),hFreq8hz(3)]);

set(hFreq8hz,'Box','off','XLim',winAxis,'XTick',[winAxis(1),0:500:winAxis(2)],'TickDir','out','fontSize',fontS);
set(hFreq8hz(1),'YLim',yLimSpike,'YTick',[0:10:30]);
set(hFreq8hz(2),'Box','off','visible','off','YLim',yLimCSC,'YTick',[]);
set(hFreq8hz(3),'XLim',winBlue,'XTick',[-25,0,10,20,100],'YLim',[0 nLight],'YTick',[0 nLight],'YTickLabel',{0, nLight});

% print('-painters','-r300','-dtiff',['final_fig1_example_',datestr(now,formatOut),'.tif']);
% print('-painters','-r300','-depsc',['final_fig1_example_',datestr(now,formatOut),'.ai']);
% close;
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