function spectroTrackChronux()
% spectroTrack calculates spectrogram aligned on sensor, laser on track,
% and laser on platform. The function reads csc.mat files and saves
% spectrogram, time, frequency.
%
% Author: Joonyeup Lee
% Version 1.0 (Oct, 17, 2016)

sensorWin = [-1 1]; % the number in the bracket should be in sec unit
lightWin = [-1 1];
sensorInput = sensorWin*2*10^3; % unit of sensorInput: usec
lightInput = lightWin*2*10^3;

mvWinSensor = [0.5 0.05]; % unit: sec (100ms window, 10ms moving)
mvWinLightPlfm = [0.5 0.01];
mvWinLightTrack = [0.5 0.01];
params.Fs = 2000; % unit: Hz
params.fpass = [0, 200];
params.pad = 2; % padding: 2 (better visualization)
params.tapers = [5, 5];
params.trialave = 0; % 0: no average, 1: average trials
p = 0.05;
params.err = [1, p];

load('Events.mat');
[timestamp, sample, cscList] = cscLoad;
% nFile = length(cscList);
nFile = 1;

for iFile = 1:nFile
    disp(['### CSC analysis: ',cscList{iFile}]);
    [filePath, ~, ~] = fileparts(cscList{iFile});
    filaName = 'CSC';
    
    channelSample = sample;

    if ~isempty(strfind(filePath,'DRun')|strfind(filePath,'noRun'))
        iSensor = 6;      
    else
        iSensor = 10;
    end

% Spectrum aligned on sensor
    idxSensor = zeros(nTrial,1);
    sampleSensor = zeros((sum(abs(sensorInput))+1),nTrial);
    for iTrial = 1:nTrial
        idxSensor(iTrial,1) = find(sensor.(fields{iSensor})(iTrial)<timestamp,1,'first');
        sampleSensor(:,iTrial) = channelSample((idxSensor(iTrial,1)+sensorInput(1)):(idxSensor(iTrial,1)+sensorInput(2)));
    end
    [specSensor, timeSensor, freqSensor, ~] = mtspecgramc(sampleSensor,mvWinSensor,params);
    specSensor_pre = specSensor(:,:,1:30);
    specSensor_stm = specSensor(:,:,31:60);
    specSensor_post = specSensor(:,:,61:90);
    save([fileName,'.mat'],'specSensor_pre','specSensor_stm','specSensor_post','timeSensor','freqSensor');

% Spectrum aligned on Platform light
    nLightPlfm = length(lightTime.Tag);
    idxLightPlfm = zeros(nLightPlfm,1);
    sampleLightPlfm = zeros((sum(abs(lightInput))+1),nLightPlfm);
    for iLight = 1:nLightPlfm
        idxLightPlfm(iLight,1) = find(lightTime.Tag(iLight)<timestamp,1,'first');
        sampleLightPlfm(:,iLight) = channelSample((idxLightPlfm(iLight,1)+lightInput(1)):(idxLightPlfm(iLight,1)+lightInput(2)));
    end
    [specLightPlfm, timeLightPlfm, freqLightPlfm,~] = mtspecgramc(sampleLightPlfm,mvWinLightPlfm,params);
    specLightPlfm = mean(specLightPlfm,3);
    save([fileName,'.mat'],'specLightPlfm','timeLightPlfm','freqLightPlfm','-append');
    
% Spectrum aligned on Track light (aligned by the first light of each trial)
    nLightTrack = length(nTrial);
    lightTimeTrack = lightTime.Modu([true;(find(diff(lightTime.Modu)>250)+1)]); % 250ms: sometimes the light ITI is not exactly 125ms.
    idxLightTrack = zeros((sum(abs(lightInput))+1),nLightTrack);
    sampleLightTrack = zeros((sum(abs(lightInput))+1),nLightTrack);
    for iLight = 1:nLightTrack
        idxLightTrack(iLight,1) = find(lightTimeTrack(iLight)<timestamp,1,'first');
        sampleLightTrack(:,iLight) = channelSample((idxLightTrack(iLight,1)+lightInput(1)):(idxLightTrack(iLight,1)+lightInput(2)));
    end
    [specLightTrack,timeLightTrack,freqLightTrack,~] = mtspecgramc(sampleLightTrack,mvWinLightTrack,params);
    specLightTrack = mean(specLightTrack,3);
    save([fileName,'.mat'],'specLightTrack','timeLightTrack','freqLightTrack','-append');

% Spectrum aligned on Platform light (aligned by each light)
%     nLightTrack = length(lightTime.Modu);
%     idxLightTrack = zeros((sum(abs(lightInput))+1),nLightTrack);
%     sampleLightTrack = zeros((sum(abs(lightInput))+1),nLightTrack);
%     for iLight = 1:nLightTrack
%         idxLightTrack(iLight,1) = find(lightTime.Modu(iLight)<timestamp,1,'first');
%         sampleLightTrack(:,iLight) = channelSample((idxLightTrack(iLight,1)+lightInput(1)):(idxLightTrack(iLight,1)+lightInput(2)));
%     end
%     [specLightTrack,timeLightTrack,freqLightTrack,~] = mtspecgramc(sampleLightTrack,mvWinLightTrack,params);
end
disp('### Spectrogram analysis is completed ###');