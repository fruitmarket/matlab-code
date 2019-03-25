%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% cscPETH
% cscPETH calculate raw and filtered LFP based on 'light trigger sensor' and 'light'
% 

%% parameters
Fs = 2000; % frequency: 2kHz
win1 = [-0.5, 2];
win2 = [-2, 0.5];

winCscOn = win1*Fs; % sec * Fs = samples
winCscOff = win2*Fs;

xptTime = winCscOn(1):winCscOn(2);

bTheta = [4 12];
bSGamma = [20 50];
bFGamma = [65 140];
bRipple = [150 250];

load('Events.mat','sensor','lightTime','psdlightPre','psdlightPost');
nTrial = length(sensor.S1);
nPeak = 3;
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

lightT = lightTime.Track50hz;
lightOnStm = lightT([1; (find(diff(lightT)>1000)+1)]);
lightOnPre = psdlightPre([1; (find(diff(psdlightPre)>1000)+1)]);
lightOnPost = psdlightPost([1; (find(diff(psdlightPost)>1000)+1)]);
lightOnTotal = [lightOnPre; lightOnStm; lightOnPost];

lightOn_raw = cscWin(z_raw, cscTime, lightOnTotal, winCscOn);
lightOn_th = cscWin(z_th, cscTime, lightOnTotal, winCscOn);
lightOn_sg = cscWin(z_sg, cscTime, lightOnTotal, winCscOn);
lightOn_fg = cscWin(z_fg, cscTime, lightOnTotal, winCscOn);
lightOn_ri = cscWin(z_ri, cscTime, lightOnTotal, winCscOn);

liTraceOn.raw = lightOn_raw;
liTraceOn.th = lightOn_th;
liTraceOn.sg = lightOn_sg;
liTraceOn.fg = lightOn_fg;
liTraceOn.ri = lightOn_ri;
    
% calculate for first three peaks 
[meanCscOn_raw, peakOn_raw, meanPeakOn_raw, semPeakOn_raw, ~, ~, ~] = cscTrace(lightOn_raw,nPeak);
[meanCscOn_th, peakOn_th, meanPeakOn_th, semPeakOn_th, pGeneralOn_th, pLsdOn_th, varPeakOn_th] = cscTrace(lightOn_th,nPeak);
[meanCscOn_sg, peakOn_sg, meanPeakOn_sg, semPeakOn_sg, pGeneralOn_sg, pLsdOn_sg, varPeakOn_sg] = cscTrace(lightOn_sg,nPeak);
[meanCscOn_fg, peakOn_fg, meanPeakOn_fg, semPeakOn_fg, pGeneralOn_fg, pLsdOn_fg, varPeakOn_fg] = cscTrace(lightOn_fg,nPeak);
[meanCscOn_ri, peakOn_ri, meanPeakOn_ri, semPeakOn_ri, pGeneralOn_ri, pLsdOn_ri, varPeakOn_ri] = cscTrace(lightOn_ri,nPeak);

save(['csc','.mat'],'liTraceOn',...
                    'meanCscOn_raw', 'peakOn_raw', 'meanPeakOn_raw', 'semPeakOn_raw',...
                    'meanCscOn_th', 'peakOn_th', 'meanPeakOn_th', 'semPeakOn_th', 'pGeneralOn_th', 'pLsdOn_th', 'varPeakOn_th',...
                    'meanCscOn_sg', 'peakOn_sg', 'meanPeakOn_sg', 'semPeakOn_sg', 'pGeneralOn_sg', 'pLsdOn_sg', 'varPeakOn_sg',...
                    'meanCscOn_fg', 'peakOn_fg', 'meanPeakOn_fg', 'semPeakOn_fg', 'pGeneralOn_fg', 'pLsdOn_fg', 'varPeakOn_fg',...
                    'meanCscOn_ri', 'peakOn_ri', 'meanPeakOn_ri', 'semPeakOn_ri', 'pGeneralOn_ri', 'pLsdOn_ri', 'varPeakOn_ri',...
                    '-append');

lightOffStm = lightT([find(diff(lightT)>1000);length(lightT)]);
lightOffPre = psdlightPre([find(diff(psdlightPre)>1000);length(psdlightPre)]);
lightOffPost = psdlightPost([find(diff(psdlightPost)>1000);length(psdlightPost)]);
lightOffTotal = [lightOffPre;lightOffStm;lightOffPost];

lightOff_raw = cscWin(z_raw, cscTime, lightOffTotal, winCscOff);
lightOff_th = cscWin(z_th, cscTime, lightOffTotal, winCscOff);
lightOff_sg = cscWin(z_sg, cscTime, lightOffTotal, winCscOff);
lightOff_fg = cscWin(z_fg, cscTime, lightOffTotal, winCscOff);
lightOff_ri = cscWin(z_ri, cscTime, lightOffTotal, winCscOff);

% calculate for first three peaks 
[meanCscOff_raw, peakOff_raw, meanPeakOff_raw, semPeakOff_raw, ~, ~, ~] = cscTrace(lightOff_raw,nPeak);
[meanCscOff_th, peakOff_th, meanPeakOff_th, semPeakOff_th, pGeneralOff_th, pLsdOff_th, varPeakOff_th] = cscTrace(lightOff_th,nPeak);
[meanCscOff_sg, peakOff_sg, meanPeakOff_sg, semPeakOff_sg, pGeneralOff_sg, pLsdOff_sg, varPeakOff_sg] = cscTrace(lightOff_sg,nPeak);
[meanCscOff_fg, peakOff_fg, meanPeakOff_fg, semPeakOff_fg, pGeneralOff_fg, pLsdOff_fg, varPeakOff_fg] = cscTrace(lightOff_fg,nPeak);
[meanCscOff_ri, peakOff_ri, meanPeakOff_ri, semPeakOff_ri, pGeneralOff_ri, pLsdOff_ri, varPeakOff_ri] = cscTrace(lightOff_ri,nPeak);

liTraceOff.raw = lightOff_raw;
liTraceOff.th = lightOff_th;
liTraceOff.sg = lightOff_sg;
liTraceOff.fg = lightOff_fg;
liTraceOff.ri = lightOff_ri;

save(['csc','.mat'],'liTraceOff',...
                    'meanCscOff_raw', 'peakOff_raw', 'meanPeakOff_raw', 'semPeakOff_raw',...
                    'meanCscOff_th', 'peakOff_th', 'meanPeakOff_th', 'semPeakOff_th', 'pGeneralOff_th', 'pLsdOff_th', 'varPeakOff_th',...
                    'meanCscOff_sg', 'peakOff_sg', 'meanPeakOff_sg', 'semPeakOff_sg', 'pGeneralOff_sg', 'pLsdOff_sg', 'varPeakOff_sg',...
                    'meanCscOff_fg', 'peakOff_fg', 'meanPeakOff_fg', 'semPeakOff_fg', 'pGeneralOff_fg', 'pLsdOff_fg', 'varPeakOff_fg',...
                    'meanCscOff_ri', 'peakOff_ri', 'meanPeakOff_ri', 'semPeakOff_ri', 'pGeneralOff_ri', 'pLsdOff_ri', 'varPeakOff_ri',...
                    '-append');
                
disp('### analysis: cscTrace & cscPETH calculation light completed! ###')