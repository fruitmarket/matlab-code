function powerTrack()
% powerTrack calculates power of spectrum  aligned on sensor, laser on track,
% and laser on platform. The function reads csc.ncs files and saves
% relative power of theta (4~12), low-gamma (30-50), high-gamma (55-85).
%
% The band ranges are defined by [Middleton, S. J. & McHugh, T. J. 
% Silencing CA3 disrupts temporal coding in the CA1 ensemble. Nat.
% Neurosci. 19, 945?51 (2016).]
%
% Author: Joonyeup Lee
% Version 1.0 (Oct, 17, 2016)

params.tapers = [3, 5];
params.pad = 0;
params.FS = 2000;
params.err = [1 0.05]; % theta band
params.trialave = 1;
params.fpass = [0,params.FS];

sensorWin = [-1, 1]; % the number in the bracket should be in sec unit
sensorInput = sensorWin*2*10^3; % unit of sensorInput: usec

lightWin = [-1, 1];
lightInput = lightWin*2*10^3;

load('Events.mat');
[timestamp, sample, cscList] = cscLoad;
% nFile = length(cscList);
nFile = 1;

for iFile = 1:nFile
    disp(['### Analysing Relative Power of ',cscList{iFile}]);
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
    end

    [pwSensor_pre,freqSensor,~] = mtspectrumc(sampleSensor(:,1:30),params);
    [pwSensor_stm,~,~] = mtspectrumc(sampleSensor(:,31:60),params);
    [pwSensor_post,~,~] = mtspectrumc(sampleSensor(:,61:90),params);
    freqSensor = freqSensor*1000;

    rangeSensorTheta = [find(freqSensor>4,1,'first'):find(freqSensor>12,1,'first')-1];
    rangeSensorLGamma = [find(freqSensor>30,1,'first'):find(freqSensor>50,1,'first')-1];
    rangeSensorHGamma = [find(freqSensor>55,1,'first'):find(freqSensor>85,1,'first')-1];
        
    totalAreaSensor_pre = trapz(freqSensor(1:length(freqSensor)/2),pwSensor_pre(1:length(freqSensor)/2));
    totalAreaSensor_stm = trapz(freqSensor(1:length(freqSensor)/2),pwSensor_stm(1:length(freqSensor)/2));
    totalAreaSensor_post = trapz(freqSensor(1:length(freqSensor)/2),pwSensor_post(1:length(freqSensor)/2));
    
    rPwSensorTheta_pre = trapz(freqSensor(rangeSensorTheta),pwSensor_pre(rangeSensorTheta))/totalAreaSensor_pre;
    rPwSensorTheta_stm = trapz(freqSensor(rangeSensorTheta),pwSensor_stm(rangeSensorTheta))/totalAreaSensor_stm;
    rPwSensorTheta_post = trapz(freqSensor(rangeSensorTheta),pwSensor_post(rangeSensorTheta))/totalAreaSensor_post;
    
    rPwSensorLGamma_pre = trapz(freqSensor(rangeSensorLGamma),pwSensor_pre(rangeSensorLGamma))/totalAreaSensor_pre;
    rPwSensorLGamma_stm = trapz(freqSensor(rangeSensorLGamma),pwSensor_pre(rangeSensorLGamma))/totalAreaSensor_stm;
    rPwSensorLGamma_post = trapz(freqSensor(rangeSensorLGamma),pwSensor_pre(rangeSensorLGamma))/totalAreaSensor_post;

    rPwSensorHGamma_pre = trapz(freqSensor(rangeSensorHGamma),pwSensor_pre(rangeSensorHGamma))/totalAreaSensor_pre;
    rPwSensorHGamma_stm = trapz(freqSensor(rangeSensorHGamma),pwSensor_pre(rangeSensorHGamma))/totalAreaSensor_stm;
    rPwSensorHGamma_post = trapz(freqSensor(rangeSensorHGamma),pwSensor_pre(rangeSensorHGamma))/totalAreaSensor_post;
    
    save([fileName,'.mat'],...
        'rPwSensorTheta_pre','rPwSensorTheta_stm','rPwSensorTheta_post',...
        'rPwSensorLGamma_pre','rPwSensorLGamma_stm','rPwSensorLGamma_post',...
        'rPwSensorHGamma_pre','rPwSensorHGamma_stm','rPwSensorHGamma_post','-append')
    
%% Spectrum aligned on Platform light (2hz)
    nLightPlfm2hz = length(lightTime.Plfm2hz);
    idxLightPlfm2hz = zeros(nLightPlfm2hz,1);
    sampleLightPlfm2hz = zeros((sum(abs(lightInput))+1),nLightPlfm2hz);
    for iLight = 1:nLightPlfm2hz
        idxLightPlfm2hz(iLight,1) = find(lightTime.Plfm2hz(iLight)<timestamp,1,'first');
        sampleLightPlfm2hz(:,iLight) = channelSample((idxLightPlfm2hz(iLight,1)+lightInput(1)):(idxLightPlfm2hz(iLight,1)+lightInput(2)));
    end
    [pwLightPlfm2hz_pre,freqLightPlfm2hz_pre,~] = mtspectrumc(sampleLightPlfm2hz(1:round(size(sampleLightPlfm2hz,1)/2),:),params);
    [pwLightPlfm2hz_post,freqLightPlfm2hz_post,~] = mtspectrumc(sampleLightPlfm2hz(round(size(sampleLightPlfm2hz,1)/2):end,:),params);
    
    freqLightPlfm2hz_pre = freqLightPlfm2hz_pre*1000;
    freqLightPlfm2hz_post = freqLightPlfm2hz_post*1000;
    
    rangeLightPlfmTheta2hz_pre = [find(freqLightPlfm2hz_pre>4,1,'first'):find(freqLightPlfm2hz_pre>12,1,'first')-1];
    rangeLightPlfmLGamma2hz_pre = [find(freqLightPlfm2hz_pre>30,1,'first'):find(freqLightPlfm2hz_pre>50,1,'first')-1];
    rangeLightPlfmHGamma2hz_pre = [find(freqLightPlfm2hz_pre>55,1,'first'):find(freqLightPlfm2hz_pre>85,1,'first')-1];
    
    rangeLightPlfmTheta2hz_post = [find(freqLightPlfm2hz_post>4,1,'first'):find(freqLightPlfm2hz_post>12,1,'first')-1];
    rangeLightPlfmLGamma2hz_post = [find(freqLightPlfm2hz_post>30,1,'first'):find(freqLightPlfm2hz_post>50,1,'first')-1];
    rangeLightPlfmHGamma2hz_post = [find(freqLightPlfm2hz_post>55,1,'first'):find(freqLightPlfm2hz_post>85,1,'first')-1];
    
    totalAreaPlfm2hz_pre = trapz(freqLightPlfm2hz_pre(1:length(freqLightPlfm2hz_pre)/2),pwLightPlfm2hz_pre(1:length(freqLightPlfm2hz_pre)/2));
    totalAreaPlfm2hz_post = trapz(freqLightPlfm2hz_post(1:length(freqLightPlfm2hz_post)/2),pwLightPlfm2hz_post(1:length(freqLightPlfm2hz_post)/2));
    
    rPwLightPlfmTheta2hz_pre = trapz(freqLightPlfm2hz_pre(rangeLightPlfmTheta2hz_pre),pwLightPlfm2hz_pre(rangeLightPlfmTheta2hz_pre))/totalAreaPlfm2hz_pre;
    rPwLightPlfmLGamma2hz_pre = trapz(freqLightPlfm2hz_pre(rangeLightPlfmLGamma2hz_pre),pwLightPlfm2hz_pre(rangeLightPlfmLGamma2hz_pre))/totalAreaPlfm2hz_pre;
    rPwLightPlfmHGamma2hz_pre = trapz(freqLightPlfm2hz_pre(rangeLightPlfmHGamma2hz_pre),pwLightPlfm2hz_pre(rangeLightPlfmHGamma2hz_pre))/totalAreaPlfm2hz_pre;
    
    rPwLightPlfmTheta2hz_post = trapz(freqLightPlfm2hz_post(rangeLightPlfmTheta2hz_post),pwLightPlfm2hz_post(rangeLightPlfmTheta2hz_post))/totalAreaPlfm2hz_post;
    rPwLightPlfmLGamma2hz_post = trapz(freqLightPlfm2hz_post(rangeLightPlfmLGamma2hz_post),pwLightPlfm2hz_post(rangeLightPlfmLGamma2hz_post))/totalAreaPlfm2hz_post;
    rPwLightPlfmHGamma2hz_post = trapz(freqLightPlfm2hz_post(rangeLightPlfmHGamma2hz_post),pwLightPlfm2hz_post(rangeLightPlfmHGamma2hz_post))/totalAreaPlfm2hz_post;

    save([fileName,'.mat'],...
        'rPwLightPlfmTheta2hz_pre','rPwLightPlfmTheta2hz_post',...
        'rPwLightPlfmLGamma2hz_pre','rPwLightPlfmLGamma2hz_post',...
        'rPwLightPlfmHGamma2hz_pre','rPwLightPlfmHGamma2hz_post','-append')
    
%% Spectrum aligned on Platform light (8hz)
if ~isempty(lightTime.Plfm8hz)
    nLightPlfm8hz = length(lightTime.Plfm8hz);
    idxLightPlfm8hz = zeros(nLightPlfm8hz,1);
    sampleLightPlfm8hz = zeros((sum(abs(lightInput))+1),nLightPlfm8hz);
    for iLight = 1:nLightPlfm8hz
        idxLightPlfm8hz(iLight,1) = find(lightTime.Plfm8hz(iLight)<timestamp,1,'first');
        sampleLightPlfm8hz(:,iLight) = channelSample((idxLightPlfm8hz(iLight,1)+lightInput(1)):(idxLightPlfm8hz(iLight,1)+lightInput(2)));
    end
    [pwLightPlfm8hz_pre,freqLightPlfm8hz_pre,~] = mtspectrumc(sampleLightPlfm8hz(1:round(size(sampleLightPlfm8hz,1)/2),:),params);
    [pwLightPlfm8hz_post,freqLightPlfm8hz_post,~] = mtspectrumc(sampleLightPlfm8hz(round(size(sampleLightPlfm8hz,1)/2):end,:),params);
    
    freqLightPlfm8hz_pre = freqLightPlfm8hz_pre*1000;
    freqLightPlfm8hz_post = freqLightPlfm8hz_post*1000;
    
    rangeLightPlfmTheta8hz_pre = [find(freqLightPlfm8hz_pre>4,1,'first'):find(freqLightPlfm8hz_pre>12,1,'first')-1];
    rangeLightPlfmLGamma8hz_pre = [find(freqLightPlfm8hz_pre>30,1,'first'):find(freqLightPlfm8hz_pre>50,1,'first')-1];
    rangeLightPlfmHGamma8hz_pre = [find(freqLightPlfm8hz_pre>55,1,'first'):find(freqLightPlfm8hz_pre>85,1,'first')-1];
    
    rangeLightPlfmTheta8hz_post = [find(freqLightPlfm8hz_post>4,1,'first'):find(freqLightPlfm8hz_post>12,1,'first')-1];
    rangeLightPlfmLGamma8hz_post = [find(freqLightPlfm8hz_post>30,1,'first'):find(freqLightPlfm8hz_post>50,1,'first')-1];
    rangeLightPlfmHGamma8hz_post = [find(freqLightPlfm8hz_post>55,1,'first'):find(freqLightPlfm8hz_post>85,1,'first')-1];
    
    totalAreaPlfm8hz_pre = trapz(freqLightPlfm8hz_pre(1:length(freqLightPlfm8hz_pre)/2),pwLightPlfm8hz_pre(1:length(freqLightPlfm8hz_pre)/2));
    totalAreaPlfm8hz_post = trapz(freqLightPlfm8hz_post(1:length(freqLightPlfm8hz_post)/2),pwLightPlfm8hz_post(1:length(freqLightPlfm8hz_post)/2));
    
    rPwLightPlfmTheta8hz_pre = trapz(freqLightPlfm8hz_pre(rangeLightPlfmTheta8hz_pre),pwLightPlfm8hz_pre(rangeLightPlfmTheta8hz_pre))/totalAreaPlfm8hz_pre;
    rPwLightPlfmLGamma8hz_pre = trapz(freqLightPlfm8hz_pre(rangeLightPlfmLGamma8hz_pre),pwLightPlfm8hz_pre(rangeLightPlfmLGamma8hz_pre))/totalAreaPlfm8hz_pre;
    rPwLightPlfmHGamma8hz_pre = trapz(freqLightPlfm8hz_pre(rangeLightPlfmHGamma8hz_pre),pwLightPlfm8hz_pre(rangeLightPlfmHGamma8hz_pre))/totalAreaPlfm8hz_pre;
    
    rPwLightPlfmTheta8hz_post = trapz(freqLightPlfm8hz_post(rangeLightPlfmTheta8hz_post),pwLightPlfm8hz_post(rangeLightPlfmTheta8hz_post))/totalAreaPlfm8hz_post;
    rPwLightPlfmLGamma8hz_post = trapz(freqLightPlfm8hz_post(rangeLightPlfmLGamma8hz_post),pwLightPlfm8hz_post(rangeLightPlfmLGamma8hz_post))/totalAreaPlfm8hz_post;
    rPwLightPlfmHGamma8hz_post = trapz(freqLightPlfm8hz_post(rangeLightPlfmHGamma8hz_post),pwLightPlfm8hz_post(rangeLightPlfmHGamma8hz_post))/totalAreaPlfm8hz_post;

    save([fileName,'.mat'],...
        'rPwLightPlfmTheta8hz_pre','rPwLightPlfmTheta8hz_post',...
        'rPwLightPlfmLGamma8hz_pre','rPwLightPlfmLGamma8hz_post',...
        'rPwLightPlfmHGamma8hz_pre','rPwLightPlfmHGamma8hz_post','-append')
end
%% Spectrum aligned on Track light (aligned by the first light of each trial)
if isempty(lightTime.Track2hz) 
    nLightTrack8hz = nTrial/3; % laser stimulation: 30 trials
else
    nLightTrack8hz = 20; % laser stimulation: 20 trials
end
    lightTimeTrack8hz = lightTime.Track8hz([true;(find(diff(lightTime.Track8hz)>250)+1)]); % 250ms: sometimes the light ITI is not exactly 125ms.
    idxLightTrack8hz = zeros((sum(abs(lightInput))+1),nLightTrack8hz);
    sampleLightTrack8hz = zeros((sum(abs(lightInput))+1),nLightTrack8hz);
    for iLight = 1:nLightTrack8hz
        idxLightTrack8hz(iLight,1) = find(lightTimeTrack8hz(iLight)<timestamp,1,'first');
        sampleLightTrack8hz(:,iLight) = channelSample((idxLightTrack8hz(iLight,1)+lightInput(1)):(idxLightTrack8hz(iLight,1)+lightInput(2)));
    end
    [pwLightTrack8hz_pre,freqLightTrack8hz_pre,~] = mtspectrumc(sampleLightTrack8hz(1:round(size(sampleLightTrack8hz,1)/2),:),params);
    [pwLightTrack8hz_post,freqLightTrack8hz_post,~] = mtspectrumc(sampleLightTrack8hz(round(size(sampleLightTrack8hz,1)/2):end,:),params);
    
    freqLightTrack8hz_pre = freqLightTrack8hz_pre*1000;
    freqLightTrack8hz_post = freqLightTrack8hz_post*1000;
    
    rangeLightTrackTheta8hz_pre = [find(freqLightTrack8hz_pre>4,1,'first'):find(freqLightTrack8hz_pre>12,1,'first')-1];
    rangeLightTrackLGamma8hz_pre = [find(freqLightTrack8hz_pre>30,1,'first'):find(freqLightTrack8hz_pre>50,1,'first')-1];
    rangeLightTrackHGamma8hz_pre = [find(freqLightTrack8hz_pre>55,1,'first'):find(freqLightTrack8hz_pre>85,1,'first')-1];
    
    rangeLightTrackThet8hza_post = [find(freqLightTrack8hz_post>4,1,'first'):find(freqLightTrack8hz_post>12,1,'first')-1];
    rangeLightTrackLGamma8hz_post = [find(freqLightTrack8hz_post>30,1,'first'):find(freqLightTrack8hz_post>50,1,'first')-1];
    rangeLightTrackHGamma8hz_post = [find(freqLightTrack8hz_post>55,1,'first'):find(freqLightTrack8hz_post>85,1,'first')-1];
    
    totalAreaTrack8hz_pre = trapz(freqLightTrack8hz_pre(1:length(freqLightTrack8hz_pre)/2),pwLightTrack8hz_pre(1:length(freqLightTrack8hz_pre)/2));
    totalAreaTrack8hz_post = trapz(freqLightTrack8hz_post(1:length(freqLightTrack8hz_post)/2),pwLightTrack8hz_post(1:length(freqLightTrack8hz_post)/2));
    
    rPwLightTrackTheta8hz_pre = trapz(freqLightTrack8hz_pre(rangeLightTrackTheta8hz_pre),pwLightTrack8hz_pre(rangeLightTrackTheta8hz_pre))/totalAreaTrack8hz_pre;
    rPwLightTrackLGamma8hz_pre = trapz(freqLightTrack8hz_pre(rangeLightTrackLGamma8hz_pre),pwLightTrack8hz_pre(rangeLightTrackLGamma8hz_pre))/totalAreaTrack8hz_pre;
    rPwLightTrackHGamma8hz_pre = trapz(freqLightTrack8hz_pre(rangeLightTrackHGamma8hz_pre),pwLightTrack8hz_pre(rangeLightTrackHGamma8hz_pre))/totalAreaTrack8hz_pre;
    
    rPwLightTrackTheta8hz_post = trapz(freqLightTrack8hz_post(rangeLightTrackThet8hza_post),pwLightTrack8hz_post(rangeLightTrackThet8hza_post))/totalAreaTrack8hz_post;
    rPwLightTrackLGamma8hz_post = trapz(freqLightTrack8hz_post(rangeLightTrackLGamma8hz_post),pwLightTrack8hz_post(rangeLightTrackLGamma8hz_post))/totalAreaTrack8hz_post;
    rPwLightTrackHGamma8hz_post = trapz(freqLightTrack8hz_post(rangeLightTrackHGamma8hz_post),pwLightTrack8hz_post(rangeLightTrackHGamma8hz_post))/totalAreaTrack8hz_post;
    
    save([fileName,'.mat'],...
        'rPwLightTrackTheta8hz_pre','rPwLightTrackTheta8hz_post',...
        'rPwLightTrackLGamma8hz_pre','rPwLightTrackLGamma8hz_post',...
        'rPwLightTrackHGamma8hz_pre','rPwLightTrackHGamma8hz_post','-append')    

end
disp('### Spectrum power calculation is completed! ###');