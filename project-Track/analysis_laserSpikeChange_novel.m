function analysis_laserSpikeChange_novel()
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
    if ~isempty(lightTime)
        spkTimeTrack50hz = spikeWin(tData{iCell},lightTime,winCriProb);
        lightProbTrack = sum(double(~cellfun(@isempty,spkTimeTrack50hz)))/length(lightTime)*100;
    else
        lightProbTrack = NaN;            
    end
    save([cellName,'.mat'],'lightProbTrack','-append');
end
disp('### Calculating Light induced spike change is done! ###');