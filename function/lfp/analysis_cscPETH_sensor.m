%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% cscPETH
% cscPETH calculate raw and filtered LFP based on 'light trigger sensor' and 'light'
%
delete('csc.mat');
%% parameters
Fs = 2000; % frequency: 2kHz0
winOn = [-0.5, 2];
winCscOn = winOn*Fs; % sec * Fs = samples

bTheta = [4 12];
bSGamma = [20 50];
bFGamma = [65 140];
bRipple = [150 250];

load('Events.mat','sensor','lightTime','psdlightPre','psdlightPost');
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
    eventOn = sensor.S6;
    eventOff = sensor.S9;
else
    eventOn = sensor.S10;
    eventOff = sensor.S11;
end

% Filter the raw trace
filt_th = filt_LFP(csc_raw,bTheta,Fs);
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

%% On sensor
rCscSOn_raw = cscWin(z_raw, cscTime, eventOn, winCscOn);
rCscSOn_th = cscWin(z_th, cscTime, eventOn, winCscOn);
rCscSOn_sg = cscWin(z_sg, cscTime, eventOn, winCscOn);
rCscSOn_fg = cscWin(z_fg, cscTime, eventOn, winCscOn);
rCscSOn_ri = cscWin(z_ri, cscTime, eventOn, winCscOn);

% calculate for mean csc
temp_csc_raw = cell2mat(rCscSOn_raw);
temp_csc_th = cell2mat(rCscSOn_th);
temp_csc_sg = cell2mat(rCscSOn_sg);
temp_csc_fg = cell2mat(rCscSOn_fg);
temp_csc_ri = cell2mat(rCscSOn_ri);

meanCscSOn_raw = {mean(temp_csc_raw(1:30,:),1); mean(temp_csc_raw(31:60,:),1); mean(temp_csc_raw(61:90,:),1)};
meanCscSOn_th = {mean(temp_csc_th(1:30,:),1); mean(temp_csc_th(31:60,:),1); mean(temp_csc_th(61:90,:),1)};
meanCscSOn_sg = {mean(temp_csc_sg(1:30,:),1); mean(temp_csc_sg(31:60,:),1); mean(temp_csc_sg(61:90,:),1)};
meanCscSOn_fg = {mean(temp_csc_fg(1:30,:),1); mean(temp_csc_fg(31:60,:),1); mean(temp_csc_fg(61:90,:),1)};
meanCscSOn_ri = {mean(temp_csc_ri(1:30,:),1); mean(temp_csc_ri(31:60,:),1); mean(temp_csc_ri(61:90,:),1)};

% calculate peak location before and after sensor onset
[peakAmSOn_th, peakLocSOn_th] = cellfun(@(x) findpeaks(x,Fs),meanCscSOn_th,'UniformOutput',0);
[peakAmSOn_sg, peakLocSOn_sg] = cellfun(@(x) findpeaks(x,Fs),meanCscSOn_sg,'UniformOutput',0);
[peakAmSOn_fg, peakLocSOn_fg] = cellfun(@(x) findpeaks(x,Fs),meanCscSOn_fg,'UniformOutput',0);
[peakAmSOn_ri, peakLocSOn_ri] = cellfun(@(x) findpeaks(x,Fs),meanCscSOn_ri,'UniformOutput',0);

peakLocOn_th_afterOn = cellfun(@(x) find(x>0.5,3,'first'),peakLocSOn_th,'UniformOutput',0);
peakAmpOn_th_afterOn = cellfun(@(x,y) x(y),peakAmSOn_th,peakLocOn_th_afterOn,'UniformOutput',0);
peakLocOn_th_beforeOn = cellfun(@(x) find(x<0.5,3,'last'),peakLocSOn_th,'UniformOutput',0);
peakAmpOn_th_beforeOn = cellfun(@(x,y) x(y),peakAmSOn_th,peakLocOn_th_beforeOn,'UniformOutput',0);

peakLocOn_sg_afterOn = cellfun(@(x) find(x>0.5,4,'first'),peakLocSOn_sg,'UniformOutput',0);
peakAmpOn_sg_afterOn = cellfun(@(x,y) x(y),peakAmSOn_sg,peakLocOn_sg_afterOn,'UniformOutput',0);
peakLocOn_sg_beforeOn = cellfun(@(x) find(x<0.5,4,'last'),peakLocSOn_sg,'UniformOutput',0);
peakAmpOn_sg_beforeOn = cellfun(@(x,y) x(y),peakAmSOn_sg,peakLocOn_sg_beforeOn,'UniformOutput',0);

peakLocOn_fg_afterOn = cellfun(@(x) find(x>0.5,4,'first'),peakLocSOn_fg,'UniformOutput',0);
peakAmpOn_fg_afterOn = cellfun(@(x,y) x(y),peakAmSOn_fg,peakLocOn_fg_afterOn,'UniformOutput',0);
peakLocOn_fg_beforeOn = cellfun(@(x) find(x<0.5,4,'last'),peakLocSOn_fg,'UniformOutput',0);
peakAmpOn_fg_beforeOn = cellfun(@(x,y) x(y),peakAmSOn_fg,peakLocOn_fg_beforeOn,'UniformOutput',0);

peakLocOn_ri_afterOn = cellfun(@(x) find(x>0.5,4,'first'),peakLocSOn_ri,'UniformOutput',0);
peakAmpOn_ri_afterOn = cellfun(@(x,y) x(y),peakAmSOn_ri,peakLocOn_ri_afterOn,'UniformOutput',0);
peakLocOn_ri_beforeOn = cellfun(@(x) find(x<0.5,4,'last'),peakLocSOn_ri,'UniformOutput',0);
peakAmpOn_ri_beforeOn = cellfun(@(x,y) x(y),peakAmSOn_ri,peakLocOn_ri_beforeOn,'UniformOutput',0);

save(['csc','.mat'],'rCscSOn_raw','rCscSOn_th','rCscSOn_sg','rCscSOn_fg','rCscSOn_ri',...
                    'meanCscSOn_raw', 'meanCscSOn_th', 'meanCscSOn_sg', 'meanCscSOn_fg','meanCscSOn_ri',...
                    'peakLocOn_th_afterOn','peakAmpOn_th_afterOn','peakLocOn_th_beforeOn','peakAmpOn_th_beforeOn',...
                    'peakLocOn_sg_afterOn','peakAmpOn_sg_afterOn','peakLocOn_sg_beforeOn','peakAmpOn_sg_beforeOn',...
                    'peakLocOn_fg_afterOn','peakAmpOn_fg_afterOn','peakLocOn_fg_beforeOn','peakAmpOn_fg_beforeOn',...
                    'peakLocOn_ri_afterOn','peakAmpOn_ri_afterOn','peakLocOn_ri_beforeOn','peakAmpOn_ri_beforeOn');
%% Off sensor
winOff = [-2, 0.5];
winCscOff = winOff*Fs;

% Align csc event to events
rCscSOff_raw = cscWin(z_raw, cscTime, eventOff, winCscOff);
rCscSOff_th = cscWin(z_th, cscTime, eventOff, winCscOff);
rCscSOff_sg = cscWin(z_sg, cscTime, eventOff, winCscOff);
rCscSOff_fg = cscWin(z_fg, cscTime, eventOff, winCscOff);
rCscSOff_ri = cscWin(z_ri, cscTime, eventOff, winCscOff);

% calculate for mean csc
temp_csc_raw = cell2mat(rCscSOff_raw);
temp_csc_th = cell2mat(rCscSOff_th);
temp_csc_sg = cell2mat(rCscSOff_sg);
temp_csc_fg = cell2mat(rCscSOff_fg);
temp_csc_ri = cell2mat(rCscSOff_ri);

meanCscSOff_raw = {mean(temp_csc_raw(1:30,:),1); mean(temp_csc_raw(31:60,:),1); mean(temp_csc_raw(61:90,:),1)};
meanCscSOff_th = {mean(temp_csc_th(1:30,:),1); mean(temp_csc_th(31:60,:),1); mean(temp_csc_th(61:90,:),1)};
meanCscSOff_sg = {mean(temp_csc_sg(1:30,:),1); mean(temp_csc_sg(31:60,:),1); mean(temp_csc_sg(61:90,:),1)};
meanCscSOff_fg = {mean(temp_csc_fg(1:30,:),1); mean(temp_csc_fg(31:60,:),1); mean(temp_csc_fg(61:90,:),1)};
meanCscSOff_ri = {mean(temp_csc_ri(1:30,:),1); mean(temp_csc_ri(31:60,:),1); mean(temp_csc_ri(61:90,:),1)};

% calculate peak location before and after sensor onset
[peakAmSOff_th, peakLocSOff_th] = cellfun(@(x) findpeaks(x,Fs),meanCscSOff_th,'UniformOutput',0);
[peakAmSOff_sg, peakLocSOff_sg] = cellfun(@(x) findpeaks(x,Fs),meanCscSOff_sg,'UniformOutput',0);
[peakAmSOff_fg, peakLocSOff_fg] = cellfun(@(x) findpeaks(x,Fs),meanCscSOff_fg,'UniformOutput',0);
[peakAmSOff_ri, peakLocSOff_ri] = cellfun(@(x) findpeaks(x,Fs),meanCscSOff_ri,'UniformOutput',0);

peakLocOff_th_afterOn = cellfun(@(x) find(x>2,3,'first'),peakLocSOff_th,'UniformOutput',0);
peakAmpOff_th_afterOn = cellfun(@(x,y) x(y),peakAmSOff_th,peakLocOff_th_afterOn,'UniformOutput',0);
peakLocOff_th_beforeOn = cellfun(@(x) find(x<2,3,'last'),peakLocSOff_th,'UniformOutput',0);
peakAmpOff_th_beforeOn = cellfun(@(x,y) x(y),peakAmSOff_th,peakLocOff_th_beforeOn,'UniformOutput',0);

peakLocOff_sg_afterOn = cellfun(@(x) find(x>2,4,'first'),peakLocSOff_sg,'UniformOutput',0);
peakAmpOff_sg_afterOn = cellfun(@(x,y) x(y),peakAmSOff_sg,peakLocOff_sg_afterOn,'UniformOutput',0);
peakLocOff_sg_beforeOn = cellfun(@(x) find(x<2,4,'last'),peakLocSOff_sg,'UniformOutput',0);
peakAmpOff_sg_beforeOn = cellfun(@(x,y) x(y),peakAmSOff_sg,peakLocOff_sg_beforeOn,'UniformOutput',0);

peakLocOff_fg_afterOn = cellfun(@(x) find(x>2,4,'first'),peakLocSOff_fg,'UniformOutput',0);
peakAmpOff_fg_afterOn = cellfun(@(x,y) x(y),peakAmSOff_fg,peakLocOff_fg_afterOn,'UniformOutput',0);
peakLocOff_fg_beforeOn = cellfun(@(x) find(x<2,4,'last'),peakLocSOff_fg,'UniformOutput',0);
peakAmpOff_fg_beforeOn = cellfun(@(x,y) x(y),peakAmSOff_fg,peakLocOff_fg_beforeOn,'UniformOutput',0);

peakLocOff_ri_afterOn = cellfun(@(x) find(x>2,4,'first'),peakLocSOff_ri,'UniformOutput',0);
peakAmpOff_ri_afterOn = cellfun(@(x,y) x(y),peakAmSOff_ri,peakLocOff_ri_afterOn,'UniformOutput',0);
peakLocOff_ri_beforeOn = cellfun(@(x) find(x<2,4,'last'),peakLocSOff_ri,'UniformOutput',0);
peakAmpOff_ri_beforeOn = cellfun(@(x,y) x(y),peakAmSOff_ri,peakLocOff_ri_beforeOn,'UniformOutput',0);

save(['csc','.mat'],'rCscSOff_raw','rCscSOff_th','rCscSOff_sg','rCscSOff_fg','rCscSOff_ri',...
                    'meanCscSOff_raw', 'meanCscSOff_th', 'meanCscSOff_sg', 'meanCscSOff_fg','meanCscSOff_ri',...
                    'peakLocOff_th_afterOn','peakAmpOff_th_afterOn','peakLocOff_th_beforeOn','peakAmpOff_th_beforeOn',...
                    'peakLocOff_sg_afterOn','peakAmpOff_sg_afterOn','peakLocOff_sg_beforeOn','peakAmpOff_sg_beforeOn',...
                    'peakLocOff_fg_afterOn','peakAmpOff_fg_afterOn','peakLocOff_fg_beforeOn','peakAmpOff_fg_beforeOn',...
                    'peakLocOff_ri_afterOn','peakAmpOff_ri_afterOn','peakLocOff_ri_beforeOn','peakAmpOff_ri_beforeOn','-append');

disp('### analysis: cscPETH & peak Loc/Amp calculation for sensor on/off completed! ###')

%% code not using

% [meanCscSOn_raw, peakLocSOn_raw, meanPeakSOn_raw, semPeakSOn_raw, ~, ~, ~] = cscTrace(rCscSOn_raw,nPeak);
% [meanCscSOn_th, peakLocSOn_th, meanPeakSOn_th, semPeakSOn_th, pGeneralSOn_th, pLsdSOn_th, varPeakSOn_th] = cscTrace(rCscSOn_th,nPeak);
% [meanCscSOn_sg, peakLocSOn_sg, meanPeakSOn_sg, semPeakSOn_sg, pGeneralSOn_sg, pLsdSOn_sg, varPeakSOn_sg] = cscTrace(rCscSOn_sg,nPeak);
% [meanCscSOn_fg, peakLocSOn_fg, meanPeakSOn_fg, semPeakSOn_fg, pGeneralSOn_fg, pLsdSOn_fg, varPeakSOn_fg] = cscTrace(rCscSOn_fg,nPeak);
% [meanCscSOn_ri, peakLocSOn_ri, meanPeakSOn_ri, semPeakSOn_ri, pGeneralSOn_ri, pLsdSOn_ri, varPeakSOn_ri] = cscTrace(rCscSOn_ri,nPeak);

% calculate for first three peaks 
% [meanCscSOff_raw, peakLocSOff_raw, meanPeakSOff_raw, semPeakSOff_raw, ~, ~, ~] = cscTrace(rCscSOff_raw,nPeak);
% [meanCscSOff_th, peakLocSOff_th, meanPeakSOff_th, semPeakSOff_th, pGeneralSOff_th, pLsdSOff_th, varPeakSOff_th] = cscTrace(rCscSOff_th,nPeak);
% [meanCscSOff_sg, peakLocSOff_sg, meanPeakSOff_sg, semPeakSOff_sg, pGeneralSOff_sg, pLsdSOff_sg, varPeakSOff_sg] = cscTrace(rCscSOff_sg,nPeak);
% [meanCscSOff_fg, peakLocSOff_fg, meanPeakSOff_fg, semPeakSOff_fg, pGeneralSOff_fg, pLsdSOff_fg, varPeakSOff_fg] = cscTrace(rCscSOff_fg,nPeak);
% [meanCscSOff_ri, peakLocSOff_ri, meanPeakSOff_ri, semPeakSOff_ri, pGeneralSOff_ri, pLsdSOff_ri, varPeakSOff_ri] = cscTrace(rCscSOff_ri,nPeak);
% save(['csc','.mat'],'rCscSOff_raw','rCscSOff_th','rCscSOff_sg','rCscSOff_fg','rCscSOff_ri',...
%                     'meanCscSOff_raw', 'peakLocSOff_raw', 'meanPeakSOff_raw', 'semPeakSOff_raw',...
%                     'meanCscSOff_th', 'peakLocSOff_th', 'meanPeakSOff_th', 'semPeakSOff_th', 'pGeneralSOff_th', 'pLsdSOff_th', 'varPeakSOff_th',...
%                     'meanCscSOff_sg', 'peakLocSOff_sg', 'meanPeakSOff_sg', 'semPeakSOff_sg', 'pGeneralSOff_sg', 'pLsdSOff_sg', 'varPeakSOff_sg',...
%                     'meanCscSOff_fg', 'peakLocSOff_fg', 'meanPeakSOff_fg', 'semPeakSOff_fg', 'pGeneralSOff_fg', 'pLsdSOff_fg', 'varPeakSOff_fg',...
%                     'meanCscSOff_ri', 'peakLocSOff_ri', 'meanPeakSOff_ri', 'semPeakSOff_ri', 'pGeneralSOff_ri', 'pLsdSOff_ri', 'varPeakSOff_ri');