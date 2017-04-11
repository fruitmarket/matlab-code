function analysis_laserFreqTest

winCri = [0, 20];

% Load mat-files
mList = mLoad;

% Load t-files
[tData, tList] = tLoad;
nCell = length(tList);

for iCell = 1:nCell
    disp(['### Analyzing ',tList{iCell},'...']);
    [cellPath, cellName, ~] = fileparts(tList{iCell});
    cd(cellPath);
    
    load Events.mat
%     load(mList{iCell},'pLR_Plfm2hz','pLR_Plfm8hz');
    if isfield(lightTime,'Plfm1hz')
        spkTime1hz = spikeWin(tData{iCell},lightTime.Plfm1hz,winCri);
        lightProb1hz = sum(double(~cellfun(@isempty,spkTime1hz)))/length(lightTime.Plfm1hz)*100;
    else
        lightProb1hz = NaN;
    end

    spkTime2hz = spikeWin(tData{iCell},lightTime.Plfm2hz,winCri);
    lightProb2hz = sum(double(~cellfun(@isempty,spkTime2hz)))/length(lightTime.Plfm2hz)*100;

    spkTime8hz = spikeWin(tData{iCell},lightTime.Plfm8hz,winCri);
    lightProb8hz = sum(double(~cellfun(@isempty,spkTime8hz)))/length(lightTime.Plfm8hz)*100;
    
    if isfield(lightTime,'Plfm20hz')
        spkTime20hz = spikeWin(tData{iCell},lightTime.Plfm20hz,winCri);
        lightProb20hz = sum(double(~cellfun(@isempty,spkTime20hz)))/length(lightTime.Plfm20hz)*100;
    else
        lightProb20hz = NaN;
    end

    if isfield(lightTime,'Plfm50hz')
        spkTime50hz = spikeWin(tData{iCell},lightTime.Plfm50hz,winCri);
        lightProb50hz = sum(double(~cellfun(@isempty,spkTime50hz)))/length(lightTime.Plfm50hz)*100;
    else
        lightProb50hz = NaN;
    end

    save([cellName,'.mat'],'lightProb1hz','lightProb2hz','lightProb8hz','lightProb20hz','lightProb50hz','-append');
end

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
