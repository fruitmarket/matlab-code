function spectroTrack()
clc; clearvars; close all;

tightInterval = [0.02 0.02]; wideInterval = [0.07 0.07];

sensorWin = [-1.5 1.5]; % the number in the bracket should be in sec unit
sensorInput = sensorWin*2*10^3;
movingWin = [0.5 0.05]; % unit: sec
params.Fs = 2000; % unit: Hz
params.fpass = [0, 150];
params.pad = 0;
params.tapers = [3, 5];
params.trialave = 0; % 0: no average, 1: average trials
p = 0.05;
params.err = [1, p];

load('Events.mat');
[timestamp, sample, cscList] = cscLoad;
nFile = length(cscList);

for iFile = 1:nFile
    [filePath, fileName,~] = fileparts(cscList{iFile});
    channelSample = sample{iFile};

    if ~isempty(strfind(filePath,'DRun')|strfind(filePath,'noRun'))
        iSensor = 6;
    else
        iSensor = 10;
    end

    idxSensor = zeros(nTrial,1);
    sampleSensor = zeros((sum(abs(sensorInput))+1),nTrial);
    
    for iTrial = 1:nTrial
        idxSensor(iTrial,1) = find(sensor.(fields{iSensor})(iTrial)<timestamp,1,'first');
        sampleSensor(:,iTrial) = channelSample((idxSensor(iTrial,1)+sensorInput(1)):(idxSensor(iTrial,1)+sensorInput(2)));
    end

    [specSensor, timeSensor, freqSensor, ~] = mtspecgramc(sampleSensor,movingWin,params);
    specSensor_pre = specSensor(:,:,1:30);
    specSensor_stm = specSensor(:,:,31:60);
    specSensor_post = specSensor(:,:,61:90);
    
    save([fileName,'.mat'],'specSensor_pre','specSensor_stm','specSensor_post','timeSensor','freqSensor');
end


orient portrait
hSpectro = axes('Position',axpt(6,9,1,4:5,[],wideInterval));
hold on;
hSpecField = pcolor(timeSensor,freqSensor, specSensor');
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