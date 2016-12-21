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
lightWin2hz = [-1, 1]; % 0.2 (= 200 usec)
lightWin8hz = [-1, 1]; % 0.05 (= 200 usec)

sensorInput = sensorWin*2*10^3; % unit of sensorInput: usec
lightInput2hz = lightWin2hz*2*10^3;
lightInput8hz = lightWin8hz*2*10^3;

winSize = 500;
fs = 2000; % 2kHz
window = hanning(winSize);
nfft = 5000;
noverlap = winSize*0.98;

load('Events.mat','sensor','lightTime','nTrial','fields');
[timestamp, sample, cscList] = cscLoad;
% nFile = length(cscList);
nFile = 1;

for iFile = 1:nFile
    disp(['### Analysing Spectrogram of ',cscList{iFile}]);
    [filePath, ~, ~] = fileparts(cscList{iFile});
    fileName = 'CSC';
%     channelSample = sample{iFile}; % calculate EEG from each tetrode
    channelSample = sample;

    if ~isempty(strfind(filePath,'DRun')) | ~isempty(strfind(filePath,'noRun'))
        iSensor = 6;
    else
        iSensor = 10;
    end

%% Spectrum aligned on sensor
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
    
%% Spectrum aligned on Platform light (2hz, 5mW, 8mW, 10mW)
    nLightPlfm2hz = length(lightTime.Plfm2hz)/3;
    nSweepPlfm2hz = nLightPlfm2hz/4;
    idxLightPlfm2hz = zeros(nSweepPlfm2hz,1);
    sampleLightPlfm2hz = zeros((sum(abs(lightInput2hz))+1),nSweepPlfm2hz);
    for iLight = 1:nSweepPlfm2hz
        idxLightPlfm2hz(iLight,1) = find(lightTime.Plfm2hz(4*iLight-3)<timestamp,1,'first');
        sampleLightPlfm2hz(:,iLight) = channelSample((idxLightPlfm2hz(iLight,1)+lightInput2hz(1)):(idxLightPlfm2hz(iLight,1)+lightInput2hz(2)));
        [~, freqLightPlfm2hz5mw, timeLightPlfm2hz5mw, psdLightPlfm2hz5mw(:,:,iLight)] = spectrogram(sampleLightPlfm2hz(:,iLight),window,noverlap,nfft,fs);
    end
    psdLightPlfm2hz5mw = mean(psdLightPlfm2hz5mw,3);
    save([fileName,'.mat'],'psdLightPlfm2hz5mw','timeLightPlfm2hz5mw','freqLightPlfm2hz5mw','-append');
   
    for iLight = 1:nSweepPlfm2hz
        if length(lightTime.Plfm2hz) == 600;
            idxLightPlfm2hz(iLight,1) = find(lightTime.Plfm2hz(4*(iLight+25*2)-3)<timestamp,1,'first');
        else % when light response check is 300 trials
            idxLightPlfm2hz(iLight,1) = find(lightTime.Plfm2hz(4*(iLight+25*1)-3)<timestamp,1,'first');
        end
        sampleLightPlfm2hz(:,iLight) = channelSample((idxLightPlfm2hz(iLight,1)+lightInput2hz(1)):(idxLightPlfm2hz(iLight,1)+lightInput2hz(2)));
        [~, freqLightPlfm2hz8mw, timeLightPlfm2hz8mw, psdLightPlfm2hz8mw(:,:,iLight)] = spectrogram(sampleLightPlfm2hz(:,iLight),window,noverlap,nfft,fs);
    end
    psdLightPlfm2hz8mw = mean(psdLightPlfm2hz8mw,3);
    save([fileName,'.mat'],'psdLightPlfm2hz8mw','timeLightPlfm2hz8mw','freqLightPlfm2hz8mw','-append');
    
    for iLight = 1:nSweepPlfm2hz
        if length(lightTime.Plfm2hz) == 600;
            idxLightPlfm2hz(iLight,1) = find(lightTime.Plfm2hz(4*(iLight+25*4)-3)<timestamp,1,'first');
        else % when light response check is 300 trials
            idxLightPlfm2hz(iLight,1) = find(lightTime.Plfm2hz(4*(iLight+25*1)-3)<timestamp,1,'first');
        end
        sampleLightPlfm2hz(:,iLight) = channelSample((idxLightPlfm2hz(iLight,1)+lightInput2hz(1)):(idxLightPlfm2hz(iLight,1)+lightInput2hz(2)));
        [~, freqLightPlfm2hz10mw, timeLightPlfm2hz10mw, psdLightPlfm2hz10mw(:,:,iLight)] = spectrogram(sampleLightPlfm2hz(:,iLight),window,noverlap,nfft,fs);
    end
    psdLightPlfm2hz10mw = mean(psdLightPlfm2hz10mw,3);
    save([fileName,'.mat'],'psdLightPlfm2hz10mw','timeLightPlfm2hz10mw','freqLightPlfm2hz10mw','-append');    
    
%% Spectrum aligned on Platform light (8hz)
if ~isempty(lightTime.Plfm8hz)
    nLightPlfm8hz = length(lightTime.Plfm8hz);
    nSweepPlfm8hz = length(find(diff(lightTime.Plfm8hz)>1000))+1; % ITI longer than 1000 usec is considered as a 1 sweep
    idxLightTrainStart = [true; find(diff(lightTime.Plfm8hz)>1000)+1];
    sampleLightPlfm8hz = zeros((sum(abs(lightInput8hz))+1),nSweepPlfm8hz);
    for iLightPlfm8hz = 1:nSweepPlfm8hz
        idxLightPlfm8hz(iLightPlfm8hz,1) = find(lightTime.Plfm8hz(idxLightTrainStart(iLightPlfm8hz))<timestamp,1,'first');
        sampleLightPlfm8hz(:,iLightPlfm8hz) = channelSample((idxLightPlfm8hz(iLightPlfm8hz,1)+lightInput8hz(1)):(idxLightPlfm8hz(iLightPlfm8hz,1)+lightInput8hz(2)));
        [~, freqLightPlfm8hz, timeLightPlfm8hz,psdLightPlfm8hz(:,:,iLightPlfm8hz)] = spectrogram(sampleLightPlfm8hz(:,iLightPlfm8hz),window,noverlap,nfft,fs);
    end
    psdLightPlfm8hz = mean(psdLightPlfm8hz,3);
    save([fileName,'.mat'],'psdLightPlfm8hz','timeLightPlfm8hz','freqLightPlfm8hz','-append');
else
    [psdLightPlfm8hz, timeLightPlfm8hz, freqLightPlfm8hz] = deal(NaN);
    save([fileName,'.mat'],'psdLightPlfm8hz','timeLightPlfm8hz','freqLightPlfm8hz','-append');
end
%% Spectrum aligned on Track light (aligned by the first light of each trial) [similar to sensor onset]
%     nLightTrack = nTrial/3;
%     lightTimeTrack = lightTime.Track8hz([true;(find(diff(lightTime.Track8hz)>250)+1)]); % 250ms: sometimes the light ITI is not exactly 125ms.
%     idxLightTrack = zeros((sum(abs(lightInput2hz))+1),nLightTrack);
%     sampleLightTrack = zeros((sum(abs(lightInput2hz))+1),nLightTrack);
%     for iLight = 1:nLightTrack
%         idxLightTrack(iLight,1) = find(lightTimeTrack(iLight)<timestamp,1,'first');
%         sampleLightTrack(:,iLight) = channelSample((idxLightTrack(iLight,1)+lightInput2hz(1)):(idxLightTrack(iLight,1)+lightInput2hz(2)));
%         [~, freqLightTrack, timeLightTrack,psdLightTrack(:,:,iLight)] = spectrogram(sampleLightTrack(:,iLight),window,noverlap,nfft,fs);
%     end
%     psdLightTrack = mean(psdLightTrack,3);
%     save([fileName,'.mat'],'psdLightTrack','timeLightTrack','freqLightTrack','-append');
end
disp('### Spectrogram analysis is completed! ###');