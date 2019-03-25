function analysis_laserSpikeChange_familiar()
% function analysis_laserSpikeChange calculates number of spikes induced by the light stimulation 
%   
%   Author: Joonyeup Lee

% Task variables
winCriProb = [0, 20];

[tData, tList] = tLoad;
nCell = length(tList);

for iCell = 1:nCell
    disp(['### Spike change analysis:  ',tList{iCell},'...']);
    [cellPath, cellName, ~] = fileparts(tList{iCell});
    cd(cellPath);

    % Load Events variables
    load('Events.mat');
%% On Track    
    if ~isempty(lightTime.Track)
        spkTimeTrack50hz = spikeWin(tData{iCell},lightTime.Track,winCriProb);
        lightProbTrack_50hz = sum(double(~cellfun(@isempty,spkTimeTrack50hz)))/length(lightTime.Track)*100;
    else
        lightProbTrack_50hz = NaN;            
    end
    save([cellName,'.mat'],'lightProbTrack_50hz','-append');
%% On Platform
    if isfield(lightTime,'Plfm2hz')
        if ~isempty(lightTime.Plfm2hz)
            spkTime2hz = spikeWin(tData{iCell},lightTime.Plfm2hz(201:400),winCriProb);
            lightProbPlfm_2hz = sum(double(~cellfun(@isempty,spkTime2hz)))/length(lightTime.Plfm2hz(201:400))*100;        
        else
            lightProbPlfm_2hz = NaN;
        end
    end
    
    if isfield(lightTime,'Plfm50hz')
        if ~isempty(lightTime.Plfm50hz)
            spkTime50hz = spikeWin(tData{iCell},lightTime.Plfm50hz,winCriProb);
            lightProbPlfm_50hz = sum(double(~cellfun(@isempty,spkTime50hz)))/length(lightTime.Plfm50hz)*100;
        else
            lightProbPlfm_50hz = NaN;            
        end
    end
    save([cellName,'.mat'],'lightProbPlfm_2hz','lightProbPlfm_50hz','-append');

end
disp('### Calculating Light induced spike change is done! ###');