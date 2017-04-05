% Calculate cross correlation of rapid light activated population
%
%
% common part
lineColor = {[144, 164, 174]./255,... % Before stimulation
    [33 150 243]./ 255,... % During stimulation
    [38, 50, 56]./255}; % After stimulation

lineWth = [1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75];
fontS = 4; fontM = 6; fontL = 8; fontXL = 10; % font size large
lineS = 0.2; lineM = 0.5; lineL = 1; % line width large

colorBlue = [33, 150, 243]/255;
colorLightBlue = [100, 181, 246]/255;
colorLLightBlue = [187, 222, 251]/255;
colorRed = [237, 50, 52]/255;
colorLightRed = [242, 138, 130]/255;
colorGray = [189, 189, 189]/255;
colorGreen = [46, 125, 50]/255;
colorLightGray = [238, 238, 238]/255;
colorDarkGray = [117, 117, 117]/255;
colorYellow = [255, 243, 3]/255;
colorLightYellow = [255, 249, 196]/255;
colorPurple = [123, 31, 162]/255;
colorBlack = [0, 0, 0];

markerS = 2.2; markerM = 4.4; markerL = 6.6; markerXL = 8.8;
tightInterval = [0.02 0.02]; midInterval = [0.09, 0.09]; wideInterval = [0.14 0.14];
width = 0.7;

paperSize = {[0 0 21.0 29.7]; % A4_portrait
             [0 0 29.7 21.0]; % A4_landscape
             [0 0 15.7 21.0]; % A4_half landscape
             [0 0 21.6 27.9]}; % Letter

cd('D:\Dropbox\SNL\P2_Track');
Txls = readtable('neuronList_170405.xlsx');
load('neuronList_ori_170405.mat');

criPeak = 0;
criFR = 7;
alpha = 0.01;

% TN: track neuron
DRunTN = (T.taskType == 'DRun') & (cellfun(@max, T.peakFR1D_track) > criPeak);
DRwTN = (T.taskType == 'DRw') & (cellfun(@max, T.peakFR1D_track) > criPeak);

% light activated total population (DRunPN / DRunIN / DRwPN / DRwIN)
DRunPN_plfm = DRunTN & T.meanFR_task <= criFR & (T.pLR_Plfm8hz<alpha & T.statDir_Plfm8hz == 1); % only consider plfm8hz sessions were performed
DRunIN_plfm = DRunTN & T.meanFR_task > criFR & (T.pLR_Plfm8hz<alpha & T.statDir_Plfm8hz == 1);
DRwPN_plfm = DRwTN & T.meanFR_task <= criFR & (T.pLR_Plfm8hz<alpha & T.statDir_Plfm8hz == 1);
DRwIN_plfm = DRwTN & T.meanFR_task > criFR & (T.pLR_Plfm8hz<alpha & T.statDir_Plfm8hz == 1);

DRunPN_track = DRunTN & T.meanFR_task <= criFR & (T.pLR_Track<alpha & T.statDir_Track == 1);
DRunIN_track = DRunTN & T.meanFR_task > criFR & (T.pLR_Track<alpha & T.statDir_Track == 1);
DRwPN_track = DRwTN & T.meanFR_task <= criFR & (T.pLR_Track<alpha & T.statDir_Track == 1);
DRwIN_track = DRwTN & T.meanFR_task > criFR & (T.pLR_Track<alpha & T.statDir_Track == 1);

noNanIdx = (cellfun(@length, T.m_deto_spkPlfm8hz)>1);

[deto_DRunPN_plfm,deto_DRunIN_plfm,deto_DRwPN_plfm,deto_DRwIN_plfm,deto_DRunPN_track,deto_DRunIN_track,deto_DRwPN_track,deto_DRwIN_track] = deal([]);

% Platform
temp_deto_DRunPN_plfm = (T.m_deto_spkPlfm8hz(DRunPN_plfm&noNanIdx));
minLight = min(cellfun(@length,temp_deto_DRunPN_plfm));
for iCell = 1:length(temp_deto_DRunPN_plfm)
    deto_DRunPN_plfm(iCell,:) = temp_deto_DRunPN_plfm{iCell}(1:minLight);
end
deto_DRunPN_plfm = deto_DRunPN_plfm*100;
m_deto_DRunPN_plfm = mean(deto_DRunPN_plfm,1);
sem_deto_DRunPN_plfm = std(deto_DRunPN_plfm,1)/size(deto_DRunPN_plfm,1);

temp_deto_DRunIN_plfm = (T.m_deto_spkPlfm8hz(DRunIN_plfm&noNanIdx));
minLight = min(cellfun(@length,temp_deto_DRunIN_plfm));
for iCell = 1:length(temp_deto_DRunIN_plfm)
    deto_DRunIN_plfm(iCell,:) = temp_deto_DRunIN_plfm{iCell}(1:minLight);
end
deto_DRunIN_plfm = deto_DRunIN_plfm*100;
m_deto_DRunIN_plfm = mean(deto_DRunIN_plfm,1);
sem_deto_DRunIN_plfm = std(deto_DRunIN_plfm,1)/size(deto_DRunIN_plfm,1);

temp_deto_DRwPN_plfm = (T.m_deto_spkPlfm8hz(DRwPN_plfm&noNanIdx));
minLight = min(cellfun(@length,temp_deto_DRwPN_plfm));
for iCell = 1:length(temp_deto_DRwPN_plfm)
    deto_DRwPN_plfm(iCell,:) = temp_deto_DRwPN_plfm{iCell}(1:minLight);
end
deto_DRwPN_plfm = deto_DRwPN_plfm*100;
m_deto_DRwPN_plfm = mean(deto_DRwPN_plfm,1);
sem_deto_DRwPN_plfm = std(deto_DRwPN_plfm,1)/size(deto_DRwPN_plfm,1);

temp_deto_DRwIN_plfm = (T.m_deto_spkPlfm8hz(DRwIN_plfm&noNanIdx));
minLight = min(cellfun(@length,temp_deto_DRwIN_plfm));
for iCell = 1:length(temp_deto_DRwIN_plfm)
    deto_DRwIN_plfm(iCell,:) = temp_deto_DRwIN_plfm{iCell}(1:minLight);
end
deto_DRwIN_plfm = deto_DRwIN_plfm*100;
m_deto_DRwIN_plfm = mean(deto_DRwIN_plfm,1);
sem_deto_DRwIN_plfm = std(deto_DRwIN_plfm,1)/size(deto_DRwIN_plfm,1);

% Track
temp_deto_DRunPN_track = (T.m_deto_spkTrack8hz(DRunPN_track&noNanIdx));
minLight = min(cellfun(@length,temp_deto_DRunPN_track));
for iCell = 1:length(temp_deto_DRunPN_track)
    deto_DRunPN_track(iCell,:) = temp_deto_DRunPN_track{iCell}(1:minLight);
end
deto_DRunPN_track = deto_DRunPN_track*100;
m_deto_DRunPN_track = mean(deto_DRunPN_track,1);
sem_deto_DRunPN_track = std(deto_DRunPN_track,1)/size(deto_DRunPN_track,1);

temp_deto_DRunIN_track = (T.m_deto_spkTrack8hz(DRunIN_track&noNanIdx));
minLight = min(cellfun(@length,temp_deto_DRunIN_track));
for iCell = 1:length(temp_deto_DRunIN_track)
    deto_DRunIN_track(iCell,:) = temp_deto_DRunIN_track{iCell}(1:minLight);
end
deto_DRunIN_track = deto_DRunIN_track*100;
m_deto_DRunIN_track = mean(deto_DRunIN_track,1);
sem_deto_DRunIN_track = std(deto_DRunIN_track,1)/size(deto_DRunIN_track,1);

temp_deto_DRwPN_track = (T.m_deto_spkTrack8hz(DRwPN_track&noNanIdx));
minLight = min(cellfun(@length,temp_deto_DRwPN_track));
for iCell = 1:length(temp_deto_DRwPN_track)
    deto_DRwPN_track(iCell,:) = temp_deto_DRwPN_track{iCell}(1:minLight);
end
deto_DRwPN_track = deto_DRwPN_track*100;
m_deto_DRwPN_track = mean(deto_DRwPN_track,1);
sem_deto_DRwPN_track = std(deto_DRwPN_track,1)/size(deto_DRwPN_track,1);

temp_deto_DRwIN_track = (T.m_deto_spkTrack8hz(DRwIN_track&noNanIdx));
minLight = min(cellfun(@length,temp_deto_DRwIN_track));
for iCell = 1:length(temp_deto_DRwIN_track)
    deto_DRwIN_track(iCell,:) = temp_deto_DRwIN_track{iCell}(1:minLight);
end
deto_DRwIN_track = deto_DRwIN_track*100;
m_deto_DRwIN_track = mean(deto_DRwIN_track,1);
sem_deto_DRwIN_track = std(deto_DRwIN_track,1)/size(deto_DRwIN_track,1);

%%
nCol = 2;
nRow = 2;
eBarLength = 0.5;
barWidth = 0.6;
fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{2},'Name','Detonate synapse');

hdetoDRun(1) = axes('Position',axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval));
plot(1:length(m_deto_DRunPN_plfm),m_deto_DRunPN_plfm,'-o','color',colorBlack,'MarkerFaceColor',colorBlue);
hold on;
errorbarJun(1:length(m_deto_DRunPN_plfm),m_deto_DRunPN_plfm,sem_deto_DRunPN_plfm,eBarLength,barWidth,colorBlack);
text(5,40,['n = ',num2str(size(deto_DRunPN_plfm,1))],'fontSize',fontL);
ylabel('Spike probability, P (%)','fontSize',fontXL);
xlabel('Light pulse','fontSize',fontXL);
title('Spike probability (%) [DRun_Plfm]','fontSize',fontL,'fontWeight','bold','interpreter','none');

hdetoDRun(2) = axes('Position',axpt(nCol,nRow,1,2,[0.1 0.1 0.85 0.85],wideInterval));
plot(1:length(m_deto_DRunPN_track),m_deto_DRunPN_track,'-o','color',colorBlack,'MarkerFaceColor',colorBlue);
hold on;
errorbarJun(1:length(m_deto_DRunPN_track),m_deto_DRunPN_track,sem_deto_DRunPN_track,eBarLength,barWidth,colorBlack);
text(5,40,['n = ',num2str(size(deto_DRunPN_track,1))],'fontSize',fontL);
ylabel('Spike probability, P (%)','fontSize',fontXL);
xlabel('Light pulse','fontSize',fontXL);
title('Spike probability (%) [DRun_Track]','fontSize',fontL,'fontWeight','bold','interpreter','none');

hdetoDRw(1) = axes('Position',axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],wideInterval));
plot(1:length(m_deto_DRwPN_plfm),m_deto_DRwPN_plfm,'-o','color',colorBlack,'MarkerFaceColor',colorBlue);
hold on;
errorbarJun(1:length(m_deto_DRwPN_plfm),m_deto_DRwPN_plfm,sem_deto_DRwPN_plfm,eBarLength,barWidth,colorBlack);
text(15,40,['n = ',num2str(size(deto_DRwPN_plfm,1))],'fontSize',fontL);
ylabel('Spike probability, P (%)','fontSize',fontXL);
xlabel('Light pulse','fontSize',fontXL);
title('Spike probability (%) [DRw_Plfm]','fontSize',fontL,'fontWeight','bold','interpreter','none');

hdetoDRw(2) = axes('Position',axpt(nCol,nRow,2,2,[0.1 0.1 0.85 0.85],wideInterval));
plot(1:length(m_deto_DRwPN_track),m_deto_DRwPN_track,'-o','color',colorBlack,'MarkerFaceColor',colorBlue);
hold on;
errorbarJun(1:length(m_deto_DRwPN_track),m_deto_DRwPN_track,sem_deto_DRwPN_track,eBarLength,barWidth,colorBlack);
text(15,40,['n = ',num2str(size(deto_DRwPN_track,1))],'fontSize',fontL);
ylabel('Spike probability, P (%)','fontSize',fontXL);
xlabel('Light pulse','fontSize',fontXL);
title('Spike probability (%) [DRw_Track]','fontSize',fontL,'fontWeight','bold','interpreter','none');

set(hdetoDRun,'TickDir','out','Box','off','YLim',[0,50],'XLim',[0,7]);
set(hdetoDRw(1),'TickDir','out','Box','off','YLim',[0,50],'XLim',[0,20]);
set(hdetoDRw(2),'TickDir','out','Box','off','YLim',[0,50],'XLim',[0,23]);

formatOut = 'yymmdd';
print('-painters','-r300','-dtiff',['plot_detonateSpike_',datestr(now,formatOut),'.tif']);