function analysis_spectrumTime
% analysis_spectrumTime calculate spectrogram (Frequency vs. Time)
%
%
%% variables
win = [-3 3]; % unit: sec
Fs = 2000;
winCSC = win*1000; % unit:ms
nTimeBin = diff(win)*Fs; 
F = 1:2:200; % frequencies interested in

load('Events.mat','sensor')
nLap = length(sensor.S1);

% load one csc data
cscNum = selectCSC;
[cscTime, csc_raw, cscList] = cscLoad;
cscTime = cscTime{1};
cscRaw = cell2mat(csc_raw(cscNum));
[cscPath, cscName, ~] = fileparts(cscList{cscNum});

disp(['### Analyzing ',cscPath,'_',cscName,'...']);

if regexp(cscPath,'Run')
    sensorOn = sensor.S6;
    sensorOff = sensor.S9;
else
    sensorOn = sensor.S10;
    sensorOff = sensor.S11;
end
% wavelet analysis
[coef_on, coef_off] = deal(cell(89,1));
for iLap = 1:nLap
    temp_coef_on = abs(cwt(cscRaw(sensorOn(iLap)+winCSC(1)<=cscTime & cscTime<=sensorOn(iLap)+winCSC(2)),centfrq('cmor1-1')*Fs./F,'cmor1-1'));
    if size(temp_coef_on,2) ~= nTimeBin
        temp_coef_on(:,end) = [];
    end
    coef_on{iLap,1} = temp_coef_on;
    
    temp_coef_off = abs(cwt(cscRaw(sensorOff(iLap)+winCSC(1)<=cscTime & cscTime<=sensorOff(iLap)+winCSC(2)),centfrq('cmor1-1')*Fs./F,'cmor1-1'));
    if size(temp_coef_off,2) ~= nTimeBin
        temp_coef_off(:,end) = [];
    end
    coef_off{iLap,1} = temp_coef_off;
end

%% Original code (before 11/20)
% sum_coef_on = sum(mean(cat(2,coef_on{1:89}),2)); % before correction
% sum_coef_off = sum(mean(cat(2,coef_off{1:89}),2)); % before correction
sum_coef_on = sum(sum(sum(cat(3,coef_on{1:89})))); % before correction
sum_coef_off = sum(sum(sum(cat(3,coef_off{1:89})))); % before correction

temp2_coef_on = cat(3,coef_on{1:89})/sum_coef_on;
temp2_coef_off = cat(3,coef_off{1:89})/sum_coef_off;

% PRE, STIM, POST spectrogram
[m_coef_on, m_coef_off] = deal(cell(3,1));
m_coef_on{1} = mean(temp2_coef_on(:,:,1:30),3);
m_coef_on{2} = mean(temp2_coef_on(:,:,31:60),3);
m_coef_on{3} = mean(temp2_coef_on(:,:,61:89),3);

m_coef_off{1} = mean(temp2_coef_off(:,:,1:30),3);
m_coef_off{2} = mean(temp2_coef_off(:,:,31:60),3);
m_coef_off{3} = mean(temp2_coef_off(:,:,61:89),3);

% compare [0, 1] sec from light-onset
timeOnset = abs(win(1))*Fs;
power_1sec_on = sum(temp2_coef_on(:,timeOnset:timeOnset+Fs-1,:),2); % 1 sec after light onset
power_1sec_off = sum(temp2_coef_off(:,timeOnset-Fs+1:timeOnset,:),2); % 1 sec after light onset

m_power_1sec_on(1,:) = mean(power_1sec_on(:,:,1:30),3);
m_power_1sec_on(2,:) = mean(power_1sec_on(:,:,31:60),3);
m_power_1sec_on(3,:) = mean(power_1sec_on(:,:,61:89),3);

sem_power_1sec_on(1,:) = std(power_1sec_on(:,:,1:30),0,3)/sqrt(30);
sem_power_1sec_on(2,:) = std(power_1sec_on(:,:,31:60),0,3)/sqrt(30);
sem_power_1sec_on(3,:) = std(power_1sec_on(:,:,61:89),0,3)/sqrt(29);

m_power_1sec_off(1,:) = mean(power_1sec_off(:,:,1:30),3);
m_power_1sec_off(2,:) = mean(power_1sec_off(:,:,31:60),3);
m_power_1sec_off(3,:) = mean(power_1sec_off(:,:,61:89),3);

sem_power_1sec_off(1,:) = std(power_1sec_off(:,:,1:30),0,3)/sqrt(30);
sem_power_1sec_off(2,:) = std(power_1sec_off(:,:,31:60),0,3)/sqrt(30);
sem_power_1sec_off(3,:) = std(power_1sec_off(:,:,61:89),0,3)/sqrt(29);

%% this is not used
% PRE, STIM, POST spectrogram
% [m_coef_on, m_coef_off] = deal(cell(3,1));
% coef_on = cat(3,coef_on{1:89});
% m_coef_on{1} = mean(coef_on(:,:,1:30),3);
% m_coef_on{2} = mean(coef_on(:,:,31:60),3);
% m_coef_on{3} = mean(coef_on(:,:,61:89),3);
% coef_off = cat(3,coef_off{1:89});
% m_coef_off{1} = mean(coef_off(:,:,1:30),3);
% m_coef_off{2} = mean(coef_off(:,:,31:60),3);
% m_coef_off{3} = mean(coef_off(:,:,61:89),3);
% 
% % compare [0, 1] sec from light-onset
% timeOnset = abs(win(1))*Fs;
% power_1sec_on = sum(coef_on(:,timeOnset:timeOnset+Fs-1,:),2); % 1 sec after light onset
% power_1sec_off = sum(coef_off(:,timeOnset-Fs+1:timeOnset,:),2); % 1 sec after light onset
% 
% m_power_1sec_on(1,:) = mean(power_1sec_on(:,:,1:30),3);
% m_power_1sec_on(2,:) = mean(power_1sec_on(:,:,31:60),3);
% m_power_1sec_on(3,:) = mean(power_1sec_on(:,:,61:89),3);
% 
% m_power_1sec_on(1,:) = m_power_1sec_on(1,:)/sum(m_power_1sec_on(1,:)); % to calculate relative power
% m_power_1sec_on(2,:) = m_power_1sec_on(2,:)/sum(m_power_1sec_on(2,:)); % to calculate relative power
% m_power_1sec_on(3,:) = m_power_1sec_on(3,:)/sum(m_power_1sec_on(3,:)); % to calculate relative power
% 
% sem_power_1sec_on(1,:) = std(power_1sec_on(:,:,1:30),0,3)/sqrt(30);
% sem_power_1sec_on(2,:) = std(power_1sec_on(:,:,31:60),0,3)/sqrt(30);
% sem_power_1sec_on(3,:) = std(power_1sec_on(:,:,61:89),0,3)/sqrt(29);
% 
% m_power_1sec_off(1,:) = mean(power_1sec_off(:,:,1:30),3);
% m_power_1sec_off(2,:) = mean(power_1sec_off(:,:,31:60),3);
% m_power_1sec_off(3,:) = mean(power_1sec_off(:,:,61:89),3);
% 
% m_power_1sec_off(1,:) = m_power_1sec_off(1,:)/sum(m_power_1sec_off(1,:)); % to calculate relative power
% m_power_1sec_off(2,:) = m_power_1sec_off(2,:)/sum(m_power_1sec_off(2,:)); % to calculate relative power
% m_power_1sec_off(3,:) = m_power_1sec_off(3,:)/sum(m_power_1sec_off(3,:)); % to calculate relative power
% 
% sem_power_1sec_off(1,:) = std(power_1sec_off(:,:,1:30),0,3)/sqrt(30);
% sem_power_1sec_off(2,:) = std(power_1sec_off(:,:,31:60),0,3)/sqrt(30);
% sem_power_1sec_off(3,:) = std(power_1sec_off(:,:,61:89),0,3)/sqrt(29);

save(['csc','.mat'],'m_coef_on','m_coef_off','m_power_1sec_on','sem_power_1sec_on','m_power_1sec_off','sem_power_1sec_off','-append');
disp('### analysis: cscPETH & peak Loc/Amp calculation for sensor on/off completed! ###')