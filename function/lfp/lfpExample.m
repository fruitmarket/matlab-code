clearvars; clc; close all;

% Fs = 2000;
% Nyquist = Fs/2;
% 
% d = designfilt('bandstopiir','FilterOrder',2, ...
%                'HalfPowerFrequency1',59,'HalfPowerFrequency2',61, ...
%                'DesignMethod','butter','SampleRate',Fs);
%            
% time = -1000:0.5:4000;
% 
% load('Events.mat');
% [timestamp, sample, cscList] = cscLoad;
% timestamp = timestamp{1};
% sample = sample{6};
% 
% nTiral = 90;
% lfpPower = NaN(nTrial,length(time),20);
% for iTrial = 1:nTrial
%     inLap = (sensor.S1(iTrial)-1500)<timestamp & timestamp<(sensor.S1(iTrial)+5500);
%     temp_LFP = sample(inLap);
%     temp_time = timestamp(inLap) - sensor.S1(iTrial);
%     [~,zeroIdx] = min(abs(time_tmp));
%     temp_time = temp_time - temp_time(zeroIdx);
%     temp_time = round(temp_time*10)/10;
%     
%     lfp{iTrial,1} = temp_LFP(temp_time>=-1000 & temp_time<=4000);
% end



% window = [1 0.01];
% params.Fs = 2000; % unit: Hz
% params.fpass = [0:100];
% params.pad = 1; % padding: 2 (better visualization)
% params.tapers = [3, 5];
% params.trialave = 0; % 0: no average, 1: average trials
% params.err = 0;
% 
% [s, t, f] = mtspecgramc(LFP_6to10_16to20,window,params);
% imagesc(f,t,abs(s))

%% Exercise LFP

