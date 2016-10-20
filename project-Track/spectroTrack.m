function spectroTrack()
% spectroTrack calculates spectrogram aligned on sensor, laser on track,
% and laser on platform. The function reads csc.ncs files and saves
% spectrogram, time, frequency.
%
% The function will generate csc.mat files
%
% Author: Joonyeup Lee
% Version 1.0 (Oct, 17, 2016)

sensorWin = [-1, 1]; % the number in the bracket should be in sec unit
lightWin = [-1, 1];
sensorInput = sensorWin*2*10^3; % unit of sensorInput: usec
lightInput = lightWin*2*10^3;

winSize = 500;
fs = 2000;
window = hanning(winSize);
nfft = 5000;
noverlap = winSize*0.98;

load('Events.mat','sensor','lightTime','nTrial','fields');
[timestamp, sample, cscList] = cscLoad;
nFile = length(cscList);

for iFile = 1:nFile
    disp(['### Analysing spectrogram of ',cscList{iFile}]);
    [filePath, fileName,~] = fileparts(cscList{iFile});
    channelSample = sample{iFile};

    if ~isempty(strfind(filePath,'DRun')) | ~isempty(strfind(filePath,'noRun'))
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
        [~, freqSensor, timeSensor,psdSensor(:,:,iTrial)] = spectrogram(sampleSensor(:,iTrial),window,noverlap,nfft,fs);     
    end
    psdSensor_pre = mean(psdSensor(:,:,1:30),3);
    psdSensor_stm = mean(psdSensor(:,:,31:60),3);
    psdSensor_post = mean(psdSensor(:,:,61:90),3);
    save([fileName,'.mat'],'psdSensor_pre','psdSensor_stm','psdSensor_post','freqSensor','timeSensor');
    
% Spectrum aligned on Platform light
    nLightPlfm = length(lightTime.Tag);
    idxLightPlfm = zeros(nLightPlfm,1);
    sampleLightPlfm = zeros((sum(abs(lightInput))+1),nLightPlfm);
    for iLight = 1:nLightPlfm
        idxLightPlfm(iLight,1) = find(lightTime.Tag(iLight)<timestamp,1,'first');
        sampleLightPlfm(:,iLight) = channelSample((idxLightPlfm(iLight,1)+lightInput(1)):(idxLightPlfm(iLight,1)+lightInput(2)));
        [~, freqLightPlfm, timeLightPlfm,psdLightPlfm(:,:,iLight)] = spectrogram(sampleLightPlfm(:,iLight),window,noverlap,nfft,fs);
    end
    psdLightPlfm = mean(psdLightPlfm,3);
    save([fileName,'.mat'],'psdLightPlfm','timeLightPlfm','freqLightPlfm','-append');
    
% Spectrum aligned on Track light (aligned by the first light of each trial)
    nLightTrack = nTrial/3;
    lightTimeTrack = lightTime.Modu([true;(find(diff(lightTime.Modu)>250)+1)]); % 250ms: sometimes the light ITI is not exactly 125ms.
    idxLightTrack = zeros((sum(abs(lightInput))+1),nLightTrack);
    sampleLightTrack = zeros((sum(abs(lightInput))+1),nLightTrack);
    for iLight = 1:nLightTrack
        idxLightTrack(iLight,1) = find(lightTimeTrack(iLight)<timestamp,1,'first');
        sampleLightTrack(:,iLight) = channelSample((idxLightTrack(iLight,1)+lightInput(1)):(idxLightTrack(iLight,1)+lightInput(2)));
        [~, freqLightTrack, timeLightTrack,psdLightTrack(:,:,iLight)] = spectrogram(sampleLightTrack(:,iLight),window,noverlap,nfft,fs);
    end
    psdLightTrack = mean(psdLightTrack,3);
    save([fileName,'.mat'],'psdLightTrack','timeLightTrack','freqLightTrack','-append');
end
disp('### Spectrogram analysis is completed ###');