function laserSpikeProb()
% Calculate light induced spike ratio

winCri = [0, 30];

[tData, tList] = tLoad;
nCell = length(tList);

for iCell = 1:nCell
    disp(['### Analyzing ',tList{iCell},'...']);
    [cellPath, cellName, ~] = fileparts(tList{iCell});
    cd(cellPath);

    load('Events.mat','lightTime');

    if isfield(lightTime,'Plfm2hz')
        if ~isempty(lightTime.Plfm2hz)
            spkTime2hz = spikeWin(tData{iCell},lightTime.Plfm2hz,winCri);
            lightProb2hzPlfm = sum(double(~cellfun(@isempty,spkTime2hz)))/length(lightTime.Plfm2hz)*100;        
        else
            lightProb2hzPlfm = NaN;
        end
    end
    
    if isfield(lightTime,'Plfm8hz')
        if ~isempty(lightTime.Plfm8hz)
            spkTime8hz = spikeWin(tData{iCell},lightTime.Plfm8hz,winCri);
            lightProb8hzPlfm = sum(double(~cellfun(@isempty,spkTime8hz)))/length(lightTime.Plfm8hz)*100;
        else
            lightProb8hzPlfm = NaN;            
        end
    end
    save([cellName,'.mat'],'lightProb2hzPlfm','lightProb8hzPlfm','-append');
    
    if isfield(lightTime,'Plfm20hz') & isfield(lightTime,'Plfm50hz')
        spkTime20hz = spikeWin(tData{iCell},lightTime.Plfm20hz,winCri);
        lightProb20hzPlfm = sum(double(~cellfun(@isempty,spkTime20hz)))/length(lightTime.Plfm20hz)*100;

        spkTime50hz = spikeWin(tData{iCell},lightTime.Plfm50hz,winCri);
        lightProb50hzPlfm = sum(double(~cellfun(@isempty,spkTime50hz)))/length(lightTime.Plfm50hz)*100;
    else
        lightProb20hzPlfm = NaN;
        lightProb50hzPlfm = NaN;
    end
    save([cellName,'.mat'],'lightProb20hzPlfm','lightProb50hzPlfm','-append');
end

disp('### Light induced spike ratio calculation is done ! ###')

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