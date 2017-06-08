%
%
clearvars;
rtDir = 'D:\Dropbox\SNL\P2_Track';
cd(rtDir);

load myParameters.mat;
Txls = readtable('neuronList_ori_170602.xlsx');
load('neuronList_ori_170602.mat');

cMeanFR = 9;
cMaxPeakFR = 1;
cSpkpvr = 1.1;
alpha = 0.01;
areaDRun = [5/6 4/3]*pi*20; % 6-9 o'clock
areaDRw = [3/2 5/3]*pi*20; % 10-11 o'clock
areaRw1 = [1/2 2/3]*pi*20; % 4-5 o'clock
areaRw2 = [3/2 5/3]*pi*20; % 10-11 o'clock
errorPosi = 5;
correctY = 0.5;
lightBand = 3;

condiTN = (cellfun(@max, T.peakFR1D_track) > cMaxPeakFR) & ~(cellfun(@(x) any(isnan(x)),T.peakloci_total));
condiPN = T.spkpvr>cSpkpvr & T.meanFR_task<cMeanFR;
condiIN = ~condiPN;

% TN: track neuron
% TN: track neuron
DRunTN = (T.taskType == 'DRun') & condiTN;
DRunPN = DRunTN & condiPN;
DRunIN = DRunTN & condiIN;

DRwTN = (T.taskType == 'DRw') & condiTN;
DRwPN = DRwTN & condiPN;
DRwIN = DRwTN & condiIN;

% light activated total population (DRunPN / DRunIN / DRwPN / DRwIN)
DRunPN_plfm = DRunPN & (T.pLR_Plfm8hz<alpha & T.statDir_Plfm8hz == 1); % plfm8hz sessions were considered
DRunIN_plfm = DRunIN & (T.pLR_Plfm8hz<alpha & T.statDir_Plfm8hz == 1);
DRwPN_plfm = DRwPN & (T.pLR_Plfm8hz<alpha & T.statDir_Plfm8hz == 1);
DRwIN_plfm = DRwIN & (T.pLR_Plfm8hz<alpha & T.statDir_Plfm8hz == 1);

DRunPN_track = DRunPN & (T.pLR_Track<alpha & T.statDir_Track == 1);
DRunIN_track = DRunIN & (T.pLR_Track<alpha & T.statDir_Track == 1);
DRwPN_track = DRwPN & (T.pLR_Track<alpha & T.statDir_Track == 1);
DRwIN_track = DRwIN & (T.pLR_Track<alpha & T.statDir_Track == 1);

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
sem_deto_DRunPN_plfm = std(deto_DRunPN_plfm,1)/sqrt(size(deto_DRunPN_plfm,1));

temp_deto_DRunIN_plfm = (T.m_deto_spkPlfm8hz(DRunIN_plfm&noNanIdx));
minLight = min(cellfun(@length,temp_deto_DRunIN_plfm));
for iCell = 1:length(temp_deto_DRunIN_plfm)
    deto_DRunIN_plfm(iCell,:) = temp_deto_DRunIN_plfm{iCell}(1:minLight);
end
deto_DRunIN_plfm = deto_DRunIN_plfm*100;
m_deto_DRunIN_plfm = mean(deto_DRunIN_plfm,1);
sem_deto_DRunIN_plfm = std(deto_DRunIN_plfm,1)/sqrt(size(deto_DRunIN_plfm,1));

temp_deto_DRwPN_plfm = (T.m_deto_spkPlfm8hz(DRwPN_plfm&noNanIdx));
minLight = min(cellfun(@length,temp_deto_DRwPN_plfm));
for iCell = 1:length(temp_deto_DRwPN_plfm)
    deto_DRwPN_plfm(iCell,:) = temp_deto_DRwPN_plfm{iCell}(1:minLight);
end
deto_DRwPN_plfm = deto_DRwPN_plfm*100;
m_deto_DRwPN_plfm = mean(deto_DRwPN_plfm,1);
sem_deto_DRwPN_plfm = std(deto_DRwPN_plfm,1)/sqrt(size(deto_DRwPN_plfm,1));

temp_deto_DRwIN_plfm = (T.m_deto_spkPlfm8hz(DRwIN_plfm&noNanIdx));
minLight = min(cellfun(@length,temp_deto_DRwIN_plfm));
for iCell = 1:length(temp_deto_DRwIN_plfm)
    deto_DRwIN_plfm(iCell,:) = temp_deto_DRwIN_plfm{iCell}(1:minLight);
end
deto_DRwIN_plfm = deto_DRwIN_plfm*100;
m_deto_DRwIN_plfm = mean(deto_DRwIN_plfm,1);
sem_deto_DRwIN_plfm = std(deto_DRwIN_plfm,1)/sqrt(size(deto_DRwIN_plfm,1));

% Track
temp_deto_DRunPN_track = (T.m_deto_spkTrack8hz(DRunPN_track&noNanIdx));
minLight = min(cellfun(@length,temp_deto_DRunPN_track));
for iCell = 1:length(temp_deto_DRunPN_track)
    deto_DRunPN_track(iCell,:) = temp_deto_DRunPN_track{iCell}(1:minLight);
end
deto_DRunPN_track = deto_DRunPN_track*100;
m_deto_DRunPN_track = mean(deto_DRunPN_track,1);
sem_deto_DRunPN_track = std(deto_DRunPN_track,1)/sqrt(size(deto_DRunPN_track,1));

temp_deto_DRunIN_track = (T.m_deto_spkTrack8hz(DRunIN_track&noNanIdx));
minLight = min(cellfun(@length,temp_deto_DRunIN_track));
for iCell = 1:length(temp_deto_DRunIN_track)
    deto_DRunIN_track(iCell,:) = temp_deto_DRunIN_track{iCell}(1:minLight);
end
deto_DRunIN_track = deto_DRunIN_track*100;
m_deto_DRunIN_track = mean(deto_DRunIN_track,1);
sem_deto_DRunIN_track = std(deto_DRunIN_track,1)/sqrt(size(deto_DRunIN_track,1));

temp_deto_DRwPN_track = (T.m_deto_spkTrack8hz(DRwPN_track&noNanIdx));
minLight = min(cellfun(@length,temp_deto_DRwPN_track));
for iCell = 1:length(temp_deto_DRwPN_track)
    deto_DRwPN_track(iCell,:) = temp_deto_DRwPN_track{iCell}(1:minLight);
end
deto_DRwPN_track = deto_DRwPN_track*100;
m_deto_DRwPN_track = mean(deto_DRwPN_track,1);
sem_deto_DRwPN_track = std(deto_DRwPN_track,1)/sqrt(size(deto_DRwPN_track,1));

temp_deto_DRwIN_track = (T.m_deto_spkTrack8hz(DRwIN_track&noNanIdx));
minLight = min(cellfun(@length,temp_deto_DRwIN_track));
for iCell = 1:length(temp_deto_DRwIN_track)
    deto_DRwIN_track(iCell,:) = temp_deto_DRwIN_track{iCell}(1:minLight);
end
deto_DRwIN_track = deto_DRwIN_track*100;
m_deto_DRwIN_track = mean(deto_DRwIN_track,1);
sem_deto_DRwIN_track = std(deto_DRwIN_track,1)/sqrt(size(deto_DRwIN_track,1));

%%
nCol = 1;
nRow = 1;
eBarLength = 0.2;
barWidth = 0.8;
fHandle = figure('PaperUnits','centimeters','PaperPosition',[0, 0, 6, 6]*2);

hdetoDRun(1) = axes('Position',axpt(nCol,nRow,1,1,[0.10 0.10 0.80 0.85],wideInterval));
plot(1:length(m_deto_DRunPN_plfm),deto_DRunPN_plfm,'-o','color',colorDarkGray,'markerEdgeColor',colorDarkGray,'MarkerFaceColor',colorLightGray,'markerSize',markerL);
hold on;
plot(1:length(m_deto_DRunPN_plfm),m_deto_DRunPN_plfm,'o','color',colorBlack,'MarkerFaceColor',colorBlack,'markerSize',markerL);
hold on;
errorbarJun(1:length(m_deto_DRunPN_plfm),m_deto_DRunPN_plfm,sem_deto_DRunPN_plfm,eBarLength,barWidth,colorBlack);
text(5,30,['n = ',num2str(size(deto_DRunPN_plfm,1))],'fontSize',fontL);
ylabel('Spike fidelity (%)','fontSize',fontL);
xlabel('Light pulse','fontSize',fontL);
% title('Spike fidelity (%) [DRun_Plfm]','fontSize',fontL,'fontWeight','bold','interpreter','none');

set(hdetoDRun(1),'Box','off','TickDir','out','XLim',[0,6],'XTick',1:5,'YLim',[-1,70],'fontSize',fontL);

% hdetoDRun(2) = axes('Position',axpt(nCol,nRow,1,2,[0.1 0.1 0.85 0.85],wideInterval));
% plot(1:length(m_deto_DRunPN_track),m_deto_DRunPN_track,'-o','color',colorBlack,'MarkerFaceColor',colorBlue);
% hold on;
% errorbarJun(1:length(m_deto_DRunPN_track),m_deto_DRunPN_track,sem_deto_DRunPN_track,eBarLength,barWidth,colorBlack);
% text(5,40,['n = ',num2str(size(deto_DRunPN_track,1))],'fontSize',fontL);
% ylabel('Spike fidelity (%)','fontSize',fontXL);
% xlabel('Light pulse','fontSize',fontXL);
% title('Spike fidelity (%) [DRun_Track]','fontSize',fontL,'fontWeight','bold','interpreter','none');
% 
% hdetoDRw(1) = axes('Position',axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],wideInterval));
% plot(1:length(m_deto_DRwPN_plfm),m_deto_DRwPN_plfm,'-o','color',colorBlack,'MarkerFaceColor',colorBlue);
% hold on;
% errorbarJun(1:length(m_deto_DRwPN_plfm),m_deto_DRwPN_plfm,sem_deto_DRwPN_plfm,eBarLength,barWidth,colorBlack);
% text(15,40,['n = ',num2str(size(deto_DRwPN_plfm,1))],'fontSize',fontL);
% ylabel('Spike fidelity (%)','fontSize',fontXL);
% xlabel('Light pulse','fontSize',fontXL);
% title('Spike fidelity (%) [DRw_Plfm]','fontSize',fontL,'fontWeight','bold','interpreter','none');
% 
% hdetoDRw(2) = axes('Position',axpt(nCol,nRow,2,2,[0.1 0.1 0.85 0.85],wideInterval));
% plot(1:length(m_deto_DRwPN_track),m_deto_DRwPN_track,'-o','color',colorBlack,'MarkerFaceColor',colorBlue);
% hold on;
% errorbarJun(1:length(m_deto_DRwPN_track),m_deto_DRwPN_track,sem_deto_DRwPN_track,eBarLength,barWidth,colorBlack);
% text(15,40,['n = ',num2str(size(deto_DRwPN_track,1))],'fontSize',fontL);
% ylabel('Spike fidelity (%)','fontSize',fontXL);
% xlabel('Light pulse','fontSize',fontXL);
% title('Spike fidelity (%) [DRw_Track]','fontSize',fontL,'fontWeight','bold','interpreter','none');

% set(hdetoDRun,'TickDir','out','Box','off','YLim',[0,50],'XLim',[0,7]);
% set(hdetoDRw(1),'TickDir','out','Box','off','YLim',[0,50],'XLim',[0,20]);
% set(hdetoDRw(2),'TickDir','out','Box','off','YLim',[0,50],'XLim',[0,23]);

formatOut = 'yymmdd';
print('-painters','-r300','-dtiff',['fig1_detonateSpike_',datestr(now,formatOut),'.tif']);
% print('-painters','-r300','-depsc',['fig1_detonateSpike_',datestr(now,formatOut),'.ai']);
close;