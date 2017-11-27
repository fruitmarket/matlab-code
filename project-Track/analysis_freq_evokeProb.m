function analysis_freq_evokeProb

winCri_dr = [0, 10];
winCri_idr = [11, 20];
winCri_total = [0, 20];

% Load t-files
[tData, tList] = tLoad;
nCell = length(tList);

for iCell = 1:nCell
    disp(['### Analyzing ',tList{iCell},'...']);
    [cellPath, cellName, ~] = fileparts(tList{iCell});
    cd(cellPath);

    load Events.mat
    if isfield(lightTime,'Plfm1hz')
        spkTime1hz_dr = spikeWin(tData{iCell},lightTime.Plfm1hz,winCri_dr);
        lightProb1hz_dr = sum(double(~cellfun(@isempty,spkTime1hz_dr)))/length(lightTime.Plfm1hz)*100;
        evoSpike1hz_dr = sum(cellfun(@length,spkTime1hz_dr));
        spkTime1hz_idr = spikeWin(tData{iCell},lightTime.Plfm1hz,winCri_idr);
        lightProb1hz_idr = sum(double(~cellfun(@isempty,spkTime1hz_idr)))/length(lightTime.Plfm1hz)*100;
        evoSpike1hz_idr = sum(cellfun(@length,spkTime1hz_idr));
        
        spkTime1hz = spikeWin(tData{iCell},lightTime.Plfm1hz,winCri_total);
        lightProb1hz = sum(double(~cellfun(@isempty,spkTime1hz)))/length(lightTime.Plfm1hz)*100;
        evoSpike1hz = sum(cellfun(@length,spkTime1hz));

    else
        lightProb1hz_dr = NaN;
        evoSpike1hz_dr = NaN;
        lightProb1hz_idr = NaN;
        evoSpike1hz_idr = NaN;
        
        lightProb1hz = NaN;
        evoSpike1hz = NaN;
    end

    spkTime2hz_dr = spikeWin(tData{iCell},lightTime.Plfm2hz,winCri_dr);
    lightProb2hz_dr = sum(double(~cellfun(@isempty,spkTime2hz_dr)))/length(lightTime.Plfm2hz)*100;
    evoSpike2hz_dr = sum(cellfun(@length, spkTime2hz_dr));
    spkTime2hz_idr = spikeWin(tData{iCell},lightTime.Plfm2hz,winCri_idr);
    lightProb2hz_idr = sum(double(~cellfun(@isempty,spkTime2hz_idr)))/length(lightTime.Plfm2hz)*100;
    evoSpike2hz_idr = sum(cellfun(@length, spkTime2hz_idr));
    spkTime2hz = spikeWin(tData{iCell},lightTime.Plfm2hz,winCri_total);
    lightProb2hz = sum(double(~cellfun(@isempty,spkTime2hz)))/length(lightTime.Plfm2hz)*100;
    evoSpike2hz = sum(cellfun(@length,spkTime2hz));
    
    spkTime8hz_dr = spikeWin(tData{iCell},lightTime.Plfm8hz,winCri_dr);
    lightProb8hz_dr = sum(double(~cellfun(@isempty,spkTime8hz_dr)))/length(lightTime.Plfm8hz)*100;
    evoSpike8hz_dr = sum(cellfun(@length, spkTime8hz_dr));
    spkTime8hz_idr = spikeWin(tData{iCell},lightTime.Plfm8hz,winCri_idr);
    lightProb8hz_idr = sum(double(~cellfun(@isempty,spkTime8hz_idr)))/length(lightTime.Plfm8hz)*100;
    evoSpike8hz_idr = sum(cellfun(@length, spkTime8hz_idr));
    spkTime8hz = spikeWin(tData{iCell},lightTime.Plfm8hz,winCri_total);
    lightProb8hz = sum(double(~cellfun(@isempty,spkTime8hz)))/length(lightTime.Plfm8hz)*100;
    evoSpike8hz = sum(cellfun(@length,spkTime8hz));
    
    
    if isfield(lightTime,'Plfm20hz')
        spkTime20hz_dr = spikeWin(tData{iCell},lightTime.Plfm20hz,winCri_dr);
        lightProb20hz_dr = sum(double(~cellfun(@isempty,spkTime20hz_dr)))/length(lightTime.Plfm20hz)*100;
        evoSpike20hz_dr = sum(cellfun(@length, spkTime20hz_dr));
        spkTime20hz_idr = spikeWin(tData{iCell},lightTime.Plfm20hz,winCri_idr);
        lightProb20hz_idr = sum(double(~cellfun(@isempty,spkTime20hz_idr)))/length(lightTime.Plfm20hz)*100;
        evoSpike20hz_idr = sum(cellfun(@length, spkTime20hz_idr));
        spkTime20hz = spikeWin(tData{iCell},lightTime.Plfm20hz,winCri_total);
        lightProb20hz = sum(double(~cellfun(@isempty,spkTime20hz)))/length(lightTime.Plfm20hz)*100;
        evoSpike20hz = sum(cellfun(@length,spkTime20hz));
        
    else
        lightProb20hz_dr = NaN;
        evoSpike20hz_dr = NaN;
        lightProb20hz_idr = NaN;
        evoSpike20hz_idr = NaN;
        lightProb20hz = NaN;
        evoSpike20hz = NaN;
    end

    if isfield(lightTime,'Plfm50hz')
        spkTime50hz_dr = spikeWin(tData{iCell},lightTime.Plfm50hz,winCri_dr);
        lightProb50hz_dr = sum(double(~cellfun(@isempty,spkTime50hz_dr)))/length(lightTime.Plfm50hz)*100;
        evoSpike50hz_dr = sum(cellfun(@length, spkTime50hz_dr));
        spkTime50hz_idr = spikeWin(tData{iCell},lightTime.Plfm50hz,winCri_idr);
        lightProb50hz_idr = sum(double(~cellfun(@isempty,spkTime50hz_idr)))/length(lightTime.Plfm50hz)*100;
        evoSpike50hz_idr = sum(cellfun(@length, spkTime50hz_idr));
        spkTime50hz = spikeWin(tData{iCell},lightTime.Plfm50hz,winCri_total);
        lightProb50hz = sum(double(~cellfun(@isempty,spkTime50hz)))/length(lightTime.Plfm50hz)*100;
        evoSpike50hz = sum(cellfun(@length,spkTime50hz));
    else
        lightProb50hz_dr = NaN;
        evoSpike50hz_dr = NaN;
        lightProb50hz_idr = NaN;
        evoSpike50hz_idr = NaN;
        lightProb50hz = NaN;
        evoSpike50hz = NaN;
    end

    save([cellName,'.mat'],...
        'lightProb1hz','lightProb2hz','lightProb8hz','lightProb20hz','lightProb50hz',...
        'lightProb1hz_dr','lightProb2hz_dr','lightProb8hz_dr','lightProb20hz_dr','lightProb50hz_dr',...
        'evoSpike1hz_dr','evoSpike2hz_dr','evoSpike8hz_dr','evoSpike20hz_dr','evoSpike50hz_dr',...
        'lightProb1hz_idr','lightProb2hz_idr','lightProb8hz_idr','lightProb20hz_idr','lightProb50hz_idr',...
        'evoSpike1hz_idr','evoSpike2hz_idr','evoSpike8hz_idr','evoSpike20hz_idr','evoSpike50hz_idr','-append');
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