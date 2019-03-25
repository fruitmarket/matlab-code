clc; clearvars; close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% cscPETH
% cscPETH calculate raw and filtered LFP based on 'light trigger sensor' and 'light'
% 

%% parameters
Fs = 2000; % frequency: 2kHz0
win = [-1, 4];
winCsc = win*Fs; % sec * Fs = samples
xptTime = winCsc(1):winCsc(2);

bTheta = [4 12];
bSGamma = [20 50];
bFGamma = [65 140];
bRipple = [150 250];

load('Events.mat','sensor','lightTime');
nTrial = length(sensor.S1);

% Select a csc file for analysis (largest number of neurons recorded TT)
[tData, tList] = tLoad;
[~,tName,~] = cellfun(@fileparts,tList,'UniformOutput',false);
temp_tetNum = cellfun(@(x) str2double(x(3)),tName);
tetNum = [unique(temp_tetNum)', histc(temp_tetNum,unique(temp_tetNum))'];
[~,tetIdx] = max(tetNum(:,2));
cscNum = tetNum(tetIdx,1);

% load csc
[cscTime, cscSample, cscList] = cscLoad;
cscTime = cscTime{1}; % unit: ms
csc_raw = cell2mat(cscSample(cscNum));
[cscPath, cscName, ~] = fileparts(cscList{cscNum});

if regexp(cscPath,'Run')
    idxSensor = sensor.S6;
else
    idxSensor = sensor.S10;
end

% Filter the raw trace
filt_th = filt_LFP(csc_raw, bTheta, Fs);
filt_sg = filt_LFP(csc_raw,bSGamma,Fs);
filt_fg = filt_LFP(csc_raw,bFGamma,Fs);
filt_ri = filt_LFP(csc_raw,bRipple,Fs);

% z-normalization
meanCSC = [mean(csc_raw), mean(filt_th), mean(filt_sg), mean(filt_fg), mean(filt_ri)];
stdCSC = [std(csc_raw), std(filt_th), std(filt_sg), std(filt_fg), std(filt_ri)];
z_raw = (csc_raw-meanCSC(1))/stdCSC(1);
z_th = (filt_th-meanCSC(2))/stdCSC(2);
z_sg = (filt_sg-meanCSC(3))/stdCSC(3);
z_fg = (filt_fg-meanCSC(4))/stdCSC(4);
z_ri = (filt_ri-meanCSC(5))/stdCSC(5);

% Align csc event to events
sensor_Raw = cscWin(csc_raw, cscTime, idxSensor, winCsc);
sensor_th = cscWin(filt_th, cscTime, idxSensor, winCsc);
sensor_sg = cscWin(filt_sg, cscTime, idxSensor, winCsc);
sensor_fg = cscWin(filt_fg, cscTime, idxSensor, winCsc);
sensor_ri = cscWin(filt_ri, cscTime, idxSensor, winCsc);

mean_cscS = {mean(cell2mat(cellfun(@(x) x',sensor_Raw,'UniformOutput',0))),...
            mean(cell2mat(cellfun(@(x) x',sensor_th,'UniformOutput',0))),...
            mean(cell2mat(cellfun(@(x) x',sensor_sg,'UniformOutput',0))),...
            mean(cell2mat(cellfun(@(x) x',sensor_fg,'UniformOutput',0))),...
            mean(cell2mat(cellfun(@(x) x',sensor_ri,'UniformOutput',0)))};

% find peak location
[~,temp_peakloc_th] = cellfun(@(x) findpeaks(x,'NPeaks',5), sensor_th,'UniformOutput',0);
[~,temp_peakloc_sg] = cellfun(@(x) findpeaks(x,'NPeaks',5), sensor_sg,'UniformOutput',0);
[~,temp_peakloc_fg] = cellfun(@(x) findpeaks(x,'NPeaks',5), sensor_fg,'UniformOutput',0);
[~,temp_peakloc_ri] = cellfun(@(x) findpeaks(x,'NPeaks',5), sensor_ri,'UniformOutput',0);

peaklocS_th = cell2mat(cellfun(@(x) x',temp_peakloc_th,'UniformOutput',0));
peaklocS_sg = cell2mat(cellfun(@(x) x',temp_peakloc_sg,'UniformOutput',0));
peaklocS_fg = cell2mat(cellfun(@(x) x',temp_peakloc_fg,'UniformOutput',0));
peaklocS_ri = cell2mat(cellfun(@(x) x',temp_peakloc_ri,'UniformOutput',0));

% calculate variance
var_peaklocS = [var(peaklocS_th*0.5,0,1);
               var(peaklocS_sg*0.5,0,1);
               var(peaklocS_fg*0.5,0,1);
               var(peaklocS_ri*0.5,0,1)]; % change unit to msec

save(['csc','.mat'],'mean_cscS','sensor_Raw','sensor_th','sensor_sg','sensor_fg','sensor_ri',...
    'peaklocS_th','peaklocS_sg','peaklocS_fg','peaklocS_ri','var_peaklocS');

lightT = lightTime.Track8hz;
light_Raw = cscWin(csc_raw, cscTime, lightT, winCsc);
light_th = cscWin(filt_th, cscTime, lightT, winCsc);
light_sg = cscWin(filt_sg, cscTime, lightT, winCsc);
light_fg = cscWin(filt_fg, cscTime, lightT, winCsc);
light_ri = cscWin(filt_ri, cscTime, lightT, winCsc);

mean_cscL = {mean(cell2mat(cellfun(@(x) x',light_Raw,'UniformOutput',0))),...
            mean(cell2mat(cellfun(@(x) x',light_th,'UniformOutput',0))),...
            mean(cell2mat(cellfun(@(x) x',light_sg,'UniformOutput',0))),...
            mean(cell2mat(cellfun(@(x) x',light_fg,'UniformOutput',0))),...
            mean(cell2mat(cellfun(@(x) x',light_ri,'UniformOutput',0)))};

% find peak location
[~,temp_peakloc_th] = cellfun(@(x) findpeaks(x,'NPeaks',5), light_th,'UniformOutput',0);
[~,temp_peakloc_sg] = cellfun(@(x) findpeaks(x,'NPeaks',5), light_sg,'UniformOutput',0);
[~,temp_peakloc_fg] = cellfun(@(x) findpeaks(x,'NPeaks',5), light_fg,'UniformOutput',0);
[~,temp_peakloc_ri] = cellfun(@(x) findpeaks(x,'NPeaks',5), light_ri,'UniformOutput',0);

peaklocL_th = cell2mat(cellfun(@(x) x',temp_peakloc_th,'UniformOutput',0));
peaklocL_sg = cell2mat(cellfun(@(x) x',temp_peakloc_sg,'UniformOutput',0));
peaklocL_fg = cell2mat(cellfun(@(x) x',temp_peakloc_fg,'UniformOutput',0));
peaklocL_ri = cell2mat(cellfun(@(x) x',temp_peakloc_ri,'UniformOutput',0));

% calculate variance
var_peaklocL = [var(peaklocL_th*0.5,0,1);
               var(peaklocL_sg*0.5,0,1);
               var(peaklocL_fg*0.5,0,1);
               var(peaklocL_ri*0.5,0,1)]; % change unit to msec
           
save(['csc','.mat'],'mean_cscL','light_Raw','light_th','light_sg','light_fg','light_ri',...
    'peaklocL_th','peaklocL_sg','peaklocL_fg','peaklocL_ri','var_peaklocL','-append');

disp('### analysis: cscTrace & cscPETH calculation completed! ###')