clc; clearvars; close all;

%% parameters
Fs = 2000; % frequency: 2kHz
win = [-1, 4];
winCsc = win*Fs; % sec * Fs = samples
winSpk = win*1000; % unit: ms
xptTime = winCsc(1):winCsc(2);

binSize = 2;
resolution = 10;

bTheta = [4 12];
bSGamma = [20 50];
bFGamma = [65 140];
bRipple = [150 250];

load('Events.mat','reward2','reward4','sensor');
nReward1 = length(reward2);
nReward2 = length(reward4);
%%
[tData, tList] = tLoad;
[~,tName,~] = cellfun(@fileparts,tList,'UniformOutput',false);
temp_tetNum = cellfun(@(x) str2double(x(3)),tName);
tetNum = [unique(temp_tetNum)', histc(temp_tetNum,unique(temp_tetNum))'];
[~,tetIdx] = max(tetNum(:,2));
cscNum = tetNum(tetIdx,1);

[cscTime, cscSample, cscList] = cscLoad;
cscTime = cscTime{1}; % unit: ms

% Filtering
csc_raw = cell2mat(cscSample(cscNum));
filt_theta = filt_LFP(csc_raw, bTheta, Fs);
filt_sgamma = filt_LFP(csc_raw,bSGamma,Fs);
filt_fgamma = filt_LFP(csc_raw,bFGamma,Fs);
filt_ripple = filt_LFP(csc_raw,bRipple,Fs);

% Hilber transfer & find angle
ang_raw = angle(hilbert(csc_raw));
ang_theta = angle(hilbert(filt_theta));
ang_sgamma = angle(hilbert(filt_sgamma));
ang_fgamma = angle(hilbert(filt_fgamma));
ang_ripple = angle(hilbert(filt_ripple));

% CSC event align
r2_cscRaw = cscWin(csc_raw, cscTime, reward2, winCsc);
r2_theta = cscWin(filt_theta, cscTime, reward2, winCsc);
r2_sgamma = cscWin(filt_sgamma, cscTime, reward2, winCsc);
r2_fgamma = cscWin(filt_fgamma, cscTime, reward2, winCsc);
r2_ripple = cscWin(filt_ripple, cscTime, reward2, winCsc);

r2_ang_raw = cscWin(ang_raw, cscTime, reward2, winCsc);
r2_ang_theta = cscWin(ang_theta, cscTime, reward2, winCsc);
r2_ang_sgamma = cscWin(ang_sgamma, cscTime, reward2, winCsc);
r2_ang_fgamma = cscWin(ang_fgamma, cscTime, reward2, winCsc);
r2_ang_ripple = cscWin(ang_ripple, cscTime, reward2, winCsc);

% spike loading
spikeData = tData{1};

nSpike = length(spikeData);
[~, idx_spike2csc] = cellfun(@(x) min(abs(x-cscTime)),num2cell(spikeData));
newSpikeData = cscTime(idx_spike2csc);

result_theta = calc_basicPhase(newSpikeData, reward2, winSpk, ang_theta, cscTime, winCsc);



subplot(2,1,1)
plot(xptTime,r2_cscRaw{2});
hold on;





