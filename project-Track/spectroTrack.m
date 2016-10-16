function spectroTrack()

tightInterval = [0.02 0.02]; wideInterval = [0.07 0.07];

sensorWin = [-1.5 1.5]; % the number in the bracket should be in sec unit
sensorInput = sensorWin*2*10^3;
movingWin = [0.5 0.05]; % unit: sec
params.Fs = 2000; % unit: Hz
params.fpass = [0, 150];
params.pad = 0;
params.tapers = [3, 5];
params.trialave = 1; % 0: no average, 1: average trials
p = 0.05;
params.err = [1, p];

load('Events.mat');

[timestamp, sample, cscList] = cscLoad;

channelSample = sample{1};

idxS6 = zeros(nTrial,1);
idxS10 = zeros(nTrial,1);

sampleS6 = zeros((sum(abs(sensorInput))+1),nTrial);
sampleS10 = zeros((sum(abs(sensorInput))+1),nTrial);


for iTrial = 1:nTrial
    idxS6(iTrial,1) = find(sensor.S6(iTrial)<timestamp,1,'first');
    sampleS6(:,iTrial) = channelSample((idxS6(iTrial,1)+sensorInput(1)):(idxS6(iTrial,1)+sensorInput(2)));
    idxS10(iTrial,1) = find(sensor.S10(iTrial)<timestamp,1,'first');
    sampleS10(:,iTrial) = channelSample((idxS10(iTrial,1)+sensorInput(1)):(idxS10(iTrial,1)+sensorInput(2)));
end

[spectrumS6, timeS6, frequenciesS6, sErrorS6] = mtspecgramc(sampleS6,movingWin,params);
[spectrumS10, timeS10, frequenciesS10, sErrorS10] = mtspecgramc(sampleS10,movingWin,params);

orient portrait
hSpectro = axes('Position',axpt(6,9,1,4:5,[],wideInterval));
hold on;
hSpecField = pcolor(timeS6,frequenciesS6, spectrumS6');
xLim = [mean(abs(sensorWin))-1, mean(abs(sensorWin))+1];
yLim = [0, 90];
line(xLim,[yLim(1),yLim(1)],'Color','k');
hLine = line([xLim(1),xLim(1)],yLim,'Color','k');
set(hSpecField,'EdgeColor','none','lineStyle','default');
set(hSpectro,'Box','off','XLim',xLim,'TickDir','out','XTick',[xLim(1),mean(xLim),xLim(2)],'XTickLabel',{-1;0;1},'YLim',yLim,'YTick',[0:20:yLim(2)],'YTickLabel',{0:20:yLim(2)});
ylabel('Frequency (Hz)');
xlabel('Time (sec)');
print(gcf,'-dtiff','-r300','exercise.tiff');
% sampleTrackLight
% samplePlfmLight