function analysis_plfm_laserIntTest
% 
% analysis_plfm_laserIntTest calculates spike probability and the number of
% spikes induced by the light stimulation.
%
% Joonyeup Lee

winCri = [0 20]; % unit: msec
[tData, tList] = tLoad;
nCell = length(tList);

for iCell = 1:nCell
    disp(['### laserIntPlfm analysis: ',tList{iCell},'...']);
    [cellPath, cellName, ~] = fileparts(tList{iCell});
    cd(cellPath);
    
    % Load Events variables
    load('Events.mat','lightTime');
 % Platform
    nPlfmLight = length(lightTime.Plfm2hz);
    
    spkTimePlfm = spikeWin(tData{iCell},lightTime.Plfm2hz,winCri);
    spkTime5mw = spkTimePlfm(1:nPlfmLight/3,1);
    spkTime8mw = spkTimePlfm(nPlfmLight/3+1:nPlfmLight*2/3,1);
    spkTime10mw = spkTimePlfm(nPlfmLight*2/3+1:nPlfmLight,1);
    
    lightProbPlfm5mw = sum(double(~cellfun(@isempty,spkTime5mw)))/(nPlfmLight/3)*100; % spike probability
    evoSpike5mw = sum(cellfun(@length, spkTime5mw)); % number of spike
    lightProbPlfm8mw = sum(double(~cellfun(@isempty,spkTime8mw)))/(nPlfmLight/3)*100;
    evoSpike8mw = sum(cellfun(@length, spkTime8mw));
    lightProbPlfm10mw = sum(double(~cellfun(@isempty,spkTime10mw)))/(nPlfmLight/3)*100;
    evoSpike10mw = sum(cellfun(@length, spkTime10mw));
    
    save([cellName,'.mat'],'lightProbPlfm5mw','lightProbPlfm8mw','lightProbPlfm10mw','evoSpike5mw','evoSpike8mw','evoSpike10mw','-append');
end
disp('### Laser Intensity Check is done!');