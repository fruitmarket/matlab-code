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
nFile = length(cscList);

for iFile = 1:nFile
    disp(['### Analysing Relative power of ',cscList{iFile}]);
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
    
% Spectrum aligned on Platform light
    nLightPlfm = length(lightTime.Tag);
    idxLightPlfm = zeros(nLightPlfm,1);
    sampleLightPlfm = zeros((sum(abs(lightInput))+1),nLightPlfm);
    for iLight = 1:nLightPlfm
        idxLightPlfm(iLight,1) = find(lightTime.Tag(iLight)<timestamp,1,'first');
        sampleLightPlfm(:,iLight) = channelSample((idxLightPlfm(iLight,1)+lightInput(1)):(idxLightPlfm(iLight,1)+lightInput(2)));
    end
    [pwLightPlfm_pre,freqLightPlfm_pre,~] = mtspectrumc(sampleLightPlfm(1:round(size(sampleLightPlfm,1)/2),:),params);
    [pwLightPlfm_post,freqLightPlfm_post,~] = mtspectrumc(sampleLightPlfm(round(size(sampleLightPlfm,1)/2):end,:),params);
    
    freqLightPlfm_pre = freqLightPlfm_pre*1000;
    freqLightPlfm_post = freqLightPlfm_post*1000;
    
    rangeLightPlfmTheta_pre = [find(freqLightPlfm_pre>4,1,'first'):find(freqLightPlfm_pre>12,1,'first')-1];
    rangeLightPlfmLGamma_pre = [find(freqLightPlfm_pre>30,1,'first'):find(freqLightPlfm_pre>50,1,'first')-1];
    rangeLightPlfmHGamma_pre = [find(freqLightPlfm_pre>55,1,'first'):find(freqLightPlfm_pre>85,1,'first')-1];
    
    rangeLightPlfmTheta_post = [find(freqLightPlfm_post>4,1,'first'):find(freqLightPlfm_post>12,1,'first')-1];
    rangeLightPlfmLGamma_post = [find(freqLightPlfm_post>30,1,'first'):find(freqLightPlfm_post>50,1,'first')-1];
    rangeLightPlfmHGamma_post = [find(freqLightPlfm_post>55,1,'first'):find(freqLightPlfm_post>85,1,'first')-1];
    
    totalAreaPlfm_pre = trapz(freqLightPlfm_pre(1:length(freqLightPlfm_pre)/2),pwLightPlfm_pre(1:length(freqLightPlfm_pre)/2));
    totalAreaPlfm_post = trapz(freqLightPlfm_post(1:length(freqLightPlfm_post)/2),pwLightPlfm_post(1:length(freqLightPlfm_post)/2));
    
    rPwLightPlfmTheta_pre = trapz(freqLightPlfm_pre(rangeLightPlfmTheta_pre),pwLightPlfm_pre(rangeLightPlfmTheta_pre))/totalAreaPlfm_pre;
    rPwLightPlfmLGamma_pre = trapz(freqLightPlfm_pre(rangeLightPlfmLGamma_pre),pwLightPlfm_pre(rangeLightPlfmLGamma_pre))/totalAreaPlfm_pre;
    rPwLightPlfmHGamma_pre = trapz(freqLightPlfm_pre(rangeLightPlfmHGamma_pre),pwLightPlfm_pre(rangeLightPlfmHGamma_pre))/totalAreaPlfm_pre;
    
    rPwLightPlfmTheta_post = trapz(freqLightPlfm_post(rangeLightPlfmTheta_post),pwLightPlfm_post(rangeLightPlfmTheta_post))/totalAreaPlfm_post;
    rPwLightPlfmLGamma_post = trapz(freqLightPlfm_post(rangeLightPlfmLGamma_post),pwLightPlfm_post(rangeLightPlfmLGamma_post))/totalAreaPlfm_post;
    rPwLightPlfmHGamma_post = trapz(freqLightPlfm_post(rangeLightPlfmHGamma_post),pwLightPlfm_post(rangeLightPlfmHGamma_post))/totalAreaPlfm_post;

    save([fileName,'.mat'],...
        'rPwLightPlfmTheta_pre','rPwLightPlfmTheta_stm','rPwLightPlfmTheta_post',...
        'rPwLightPlfmLGamma_pre','rPwLightPlfmLGamma_stm','rPwLightPlfmLGamma_post',...
        'rPwLightPlfmHGamma_pre','rPwLightPlfmHGamma_stm','rPwLightPlfmHGamma_post','-append')

% Spectrum aligned on Track light (aligned by the first light of each trial)
    nLightTrack = nTrial/3;
    lightTimeTrack = lightTime.Modu([true;(find(diff(lightTime.Modu)>250)+1)]); % 250ms: sometimes the light ITI is not exactly 125ms.
    idxLightTrack = zeros((sum(abs(lightInput))+1),nLightTrack);
    sampleLightTrack = zeros((sum(abs(lightInput))+1),nLightTrack);
    for iLight = 1:nLightTrack
        idxLightTrack(iLight,1) = find(lightTimeTrack(iLight)<timestamp,1,'first');
        sampleLightTrack(:,iLight) = channelSample((idxLightTrack(iLight,1)+lightInput(1)):(idxLightTrack(iLight,1)+lightInput(2)));
    end
    [pwLightTrack_pre,freqLightTrack_pre,~] = mtspectrumc(sampleLightTrack(1:round(size(sampleLightTrack,1)/2),:),params);
    [pwLightTrack_post,freqLightTrack_post,~] = mtspectrumc(sampleLightTrack(round(size(sampleLightTrack,1)/2):end,:),params);
    
    freqLightTrack_pre = freqLightTrack_pre*1000;
    freqLightTrack_post = freqLightTrack_post*1000;
    
    rangeLightTrackTheta_pre = [find(freqLightTrack_pre>4,1,'first'):find(freqLightTrack_pre>12,1,'first')-1];
    rangeLightTrackLGamma_pre = [find(freqLightTrack_pre>30,1,'first'):find(freqLightTrack_pre>50,1,'first')-1];
    rangeLightTrackHGamma_pre = [find(freqLightTrack_pre>55,1,'first'):find(freqLightTrack_pre>85,1,'first')-1];
    
    rangeLightTrackTheta_post = [find(freqLightTrack_post>4,1,'first'):find(freqLightTrack_post>12,1,'first')-1];
    rangeLightTrackLGamma_post = [find(freqLightTrack_post>30,1,'first'):find(freqLightTrack_post>50,1,'first')-1];
    rangeLightTrackHGamma_post = [find(freqLightTrack_post>55,1,'first'):find(freqLightTrack_post>85,1,'first')-1];
    
    totalAreaTrack_pre = trapz(freqLightTrack_pre(1:length(freqLightTrack_pre)/2),pwLightTrack_pre(1:length(freqLightTrack_pre)/2));
    totalAreaTrack_post = trapz(freqLightTrack_post(1:length(freqLightTrack_post)/2),pwLightTrack_post(1:length(freqLightTrack_post)/2));
    
    rPwLightTrackTheta_pre = trapz(freqLightTrack_pre(rangeLightTrackTheta_pre),pwLightTrack_pre(rangeLightTrackTheta_pre))/totalAreaTrack_pre;
    rPwLightTrackLGamma_pre = trapz(freqLightTrack_pre(rangeLightTrackLGamma_pre),pwLightTrack_pre(rangeLightTrackLGamma_pre))/totalAreaTrack_pre;
    rPwLightTrackHGamma_pre = trapz(freqLightTrack_pre(rangeLightTrackHGamma_pre),pwLightTrack_pre(rangeLightTrackHGamma_pre))/totalAreaTrack_pre;
    
    rPwLightTrackTheta_post = trapz(freqLightTrack_post(rangeLightTrackTheta_post),pwLightTrack_post(rangeLightTrackTheta_post))/totalAreaTrack_post;
    rPwLightTrackLGamma_post = trapz(freqLightTrack_post(rangeLightTrackLGamma_post),pwLightTrack_post(rangeLightTrackLGamma_post))/totalAreaTrack_post;
    rPwLightTrackHGamma_post = trapz(freqLightTrack_post(rangeLightTrackHGamma_post),pwLightTrack_post(rangeLightTrackHGamma_post))/totalAreaTrack_post;
    
    save([fileName,'.mat'],...
        'rPwLightTrackTheta_pre','rPwLightTrackTheta_stm','rPwLightTrackTheta_post',...
        'rPwLightTrackLGamma_pre','rPwLightTrackLGamma_stm','rPwLightTrackLGamma_post',...
        'rPwLightTrackHGamma_pre','rPwLightTrackHGamma_stm','rPwLightTrackHGamma_post','-append')    
end
disp('### spectrum power calculation is done! ###');