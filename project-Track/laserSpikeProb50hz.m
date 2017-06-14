function laserSpikeProb50hz()
% Calculate light induced spike ratio on both track and platform
% prob for plfm: only 8mW stimulation were calculated!!
% winCri = 20 ms;
winCri = [0, 20];

[tData, tList] = tLoad;
nCell = length(tList);

for iCell = 1:nCell
    disp(['### laserSpikeProb analysis: ',tList{iCell},'...']);
    [cellPath, cellName, ~] = fileparts(tList{iCell});
    cd(cellPath);

    load('Events.mat','lightTime');
%% On Track    
    if ~isempty(lightTime.Track50hz)
        spkTimeTrack50hz = spikeWin(tData{iCell},lightTime.Track50hz,winCri);
        lightProbTrack_50hz = sum(double(~cellfun(@isempty,spkTimeTrack50hz)))/length(lightTime.Track50hz)*100;
    else
        lightProbTrack_50hz = NaN;            
    end
    
    if isfield(lightTime,'Track2hz')
        if ~isempty(lightTime.Track2hz)
            spkTimeTrack2hz = spikeWin(tData{iCell},lightTime.Track2hz,winCri);
            lightProbTrack_2hz = sum(double(~cellfun(@isempty,spkTimeTrack2hz)))/length(lightTime.Track2hz)*100;
        else
            lightProbTrack_2hz = NaN;
        end
    end
    save([cellName,'.mat'],'lightProbTrack_2hz','lightProbTrack_50hz','-append');

%% On Platform
    if isfield(lightTime,'Plfm2hz')
        if ~isempty(lightTime.Plfm2hz)
            spkTime2hz = spikeWin(tData{iCell},lightTime.Plfm2hz(201:400),winCri);
            lightProbPlfm_2hz = sum(double(~cellfun(@isempty,spkTime2hz)))/length(lightTime.Plfm2hz(201:400))*100;        
        else
            lightProbPlfm_2hz = NaN;
        end
    end
    
    if isfield(lightTime,'Plfm50hz')
        if ~isempty(lightTime.Plfm50hz)
            spkTime50hz = spikeWin(tData{iCell},lightTime.Plfm50hz,winCri);
            lightProbPlfm_50hz = sum(double(~cellfun(@isempty,spkTime50hz)))/length(lightTime.Plfm50hz)*100;
        else
            lightProbPlfm_50hz = NaN;            
        end
    end
    save([cellName,'.mat'],'lightProbPlfm_2hz','lightProbPlfm_50hz','-append');
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