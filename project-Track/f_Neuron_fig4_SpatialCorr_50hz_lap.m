clearvars;
cd('D:\Dropbox\SNL\P2_Track');

load('D:\Dropbox\SNL\P2_Track\myParameters.mat');
formatOut = 'yymmdd';

markerS = 1.5;
dotS = 4;

% 1cm win
lightLoc_Run = [floor(20*pi*5/6) ceil(20*pi*8/6)];
lightLoc_Rw = [floor(20*pi*9/6) ceil(20*pi*10/6)];

% 2cm win
% load('neuronList_ori50hz_171219_2cm.mat');
% lightLoc_Run = [27 42];
% lightLoc_Rw = [48 53];

% 4cm win
% load('neuronList_ori50hz_171219_4cm.mat');
% lightLoc_Run = [14 21];
% lightLoc_Rw = [24 26];


%%
load('neuronList_ori50hz_180128_bin5sd2.mat');
T50 = T;
clear T;
cri_meanFR = 3;
% TN: track neuron
% tPC_Run = T.taskType == 'DRun' & T.idxNeurontype == 'PN';
% tPC_50run = T50.taskType == 'DRun' & T50.idxNeurontype == 'PN' & T50.idxPeakFR & T50.idxPlaceField & T50.idxTotalSpikeNum;
tPC_50run = T50.taskType == 'DRun' & T50.idxNeurontype == 'PN' & cellfun(@(x) max(max(x)), T50.pethconvSpatial)>cri_meanFR; % mean firing rate > 1hz
% tPC_Run = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR;

% Rw session
% tPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN';
% tPC_50rw = T50.taskType == 'DRw' & T50.idxNeurontype == 'PN' & T50.idxPeakFR & T50.idxPlaceField & T50.idxTotalSpikeNum;
tPC_50rw = T50.taskType == 'DRw' & T50.idxNeurontype == 'PN' & cellfun(@(x) max(max(x)), T50.pethconvSpatial)>cri_meanFR; % mean firing rate > 1hz
% tPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR;

% 8 Hz
load('neuronList_ori_180128_bin5sd2.mat');

% DRun
% tPC_Run = T.taskType == 'DRun' & T.idxNeurontype == 'PN';
% tPC_8run = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
tPC_8run = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & cellfun(@(x) max(max(x)), T.pethconvSpatial)>cri_meanFR; % mean firing rate > 1hz
% tPC_Run = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR;

% Rw session
% tPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN';
% tPC_8rw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
tPC_8rw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & cellfun(@(x) max(max(x)), T.pethconvSpatial)>cri_meanFR; % mean firing rate > 1hz
% tPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR;

% noRun
% tPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN';
% tPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
tPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & cellfun(@(x) max(max(x)), T.pethconvSpatial)>cri_meanFR; % mean firing rate > 1hz
% tPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR;

% noRw
% tPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN';
% tPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
tPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & cellfun(@(x) max(max(x)), T.pethconvSpatial)>cri_meanFR; % mean firing rate > 1hz
% tPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR;
%%
nPC_50run = sum(double(tPC_50run));
nPC_50rw = sum(double(tPC_50rw));
nPC_8run = sum(double(tPC_8run)); 
nPC_8rw = sum(double(tPC_8rw));
nPC_noRun = sum(double(tPC_noRun));
nPC_noRw = sum(double(tPC_noRw));

% 50 Run
rMov_total_50run = cell2mat(T50.rCorrConvMov1D(tPC_50run));
rMov_in_50run = cell2mat(T50.rCorrConvMov1D_Inzone(tPC_50run));
rMov_out_50run = cell2mat(T50.rCorrConvMov1D_Outzone(tPC_50run));

m_rMov_total_50run = nanmean(rMov_total_50run,1);
m_rMov_in_50run = nanmean(rMov_in_50run,1);
m_rMov_out_50run = nanmean(rMov_out_50run,1);

sem_rMov_total_50run = nanstd(rMov_total_50run,0,1)/sqrt(nPC_50run);
sem_rMov_in_50run = nanstd(rMov_in_50run,0,1)/sqrt(nPC_50run);
sem_rMov_out_50run = nanstd(rMov_out_50run,0,1)/sqrt(nPC_50run);

% 50 Rw
rMov_total_50rw = cell2mat(T50.rCorrConvMov1D(tPC_50rw));
rMov_in_50rw = cell2mat(T50.rCorrConvMov1D_Inzone(tPC_50rw));
rMov_out_50rw = cell2mat(T50.rCorrConvMov1D_Outzone(tPC_50rw));

m_rMov_total_50rw = nanmean(rMov_total_50rw,1);
m_rMov_in_50rw = nanmean(rMov_in_50rw,1);
m_rMov_out_50rw = nanmean(rMov_out_50rw,1);

sem_rMov_total_50rw = nanstd(rMov_total_50rw,0,1)/sqrt(nPC_50rw);
sem_rMov_in_50rw = nanstd(rMov_in_50rw,0,1)/sqrt(nPC_50rw);
sem_rMov_out_50rw = nanstd(rMov_out_50rw,0,1)/sqrt(nPC_50rw);

% 8 Run
rMov_total_8run = cell2mat(T.rCorrConvMov1D(tPC_8run));
rMov_in_8run = cell2mat(T.rCorrConvMov1D_Inzone(tPC_8run));
rMov_out_8run = cell2mat(T.rCorrConvMov1D_Outzone(tPC_8run));

m_rMov_total_8run = nanmean(rMov_total_8run,1);
m_rMov_in_8run = nanmean(rMov_in_8run,1);
m_rMov_out_8run = nanmean(rMov_out_8run,1);

sem_rMov_total_8run = nanstd(rMov_total_8run,0,1)/sqrt(nPC_8run);
sem_rMov_in_8run = nanstd(rMov_in_8run,0,1)/sqrt(nPC_8run);
sem_rMov_out_8run = nanstd(rMov_out_8run,0,1)/sqrt(nPC_8run);

% 8 Rw
rMov_total_8rw = cell2mat(T.rCorrConvMov1D(tPC_8rw));
rMov_in_8rw = cell2mat(T.rCorrConvMov1D_Inzone(tPC_8rw));
rMov_out_8rw = cell2mat(T.rCorrConvMov1D_Outzone(tPC_8rw));

m_rMov_total_8rw = nanmean(rMov_total_8rw,1);
m_rMov_in_8rw = nanmean(rMov_in_8rw,1);
m_rMov_out_8rw = nanmean(rMov_out_8rw,1);

sem_rMov_total_8rw = nanstd(rMov_total_8rw,0,1)/sqrt(nPC_8rw);
sem_rMov_in_8rw = nanstd(rMov_in_8rw,0,1)/sqrt(nPC_8rw);
sem_rMov_out_8rw = nanstd(rMov_out_8rw,0,1)/sqrt(nPC_8rw);

% 8 noRun
rMov_total_noRun = cell2mat(T.rCorrConvMov1D(tPC_noRun));
rMov_in_noRun = cell2mat(T.rCorrConvMov1D_Inzone(tPC_noRun));
rMov_out_noRun = cell2mat(T.rCorrConvMov1D_Outzone(tPC_noRun));

m_rMov_total_noRun = nanmean(rMov_total_noRun,1);
m_rMov_in_noRun = nanmean(rMov_in_noRun,1);
m_rMov_out_noRun = nanmean(rMov_out_noRun,1);

sem_rMov_total_noRun = nanstd(rMov_total_noRun,0,1)/sqrt(nPC_noRun);
sem_rMov_in_noRun = nanstd(rMov_in_noRun,0,1)/sqrt(nPC_noRun);
sem_rMov_out_noRun = nanstd(rMov_out_noRun,0,1)/sqrt(nPC_noRun);

% 8 noRw
rMov_total_noRw = cell2mat(T.rCorrConvMov1D(tPC_noRw));
rMov_in_noRw = cell2mat(T.rCorrConvMov1D_Inzone(tPC_noRw));
rMov_out_noRw = cell2mat(T.rCorrConvMov1D_Outzone(tPC_noRw));

m_rMov_total_noRw = nanmean(rMov_total_noRw,1);
m_rMov_in_noRw = nanmean(rMov_in_noRw,1);
m_rMov_out_noRw = nanmean(rMov_out_noRw,1);

sem_rMov_total_noRw = nanstd(rMov_total_noRw,0,1)/sqrt(nPC_noRw);
sem_rMov_in_noRw = nanstd(rMov_in_noRw,0,1)/sqrt(nPC_noRw);
sem_rMov_out_noRw = nanstd(rMov_out_noRw,0,1)/sqrt(nPC_noRw);

%% plot
nCol = 4;
nRow = 6;
xpt = 1:90;
yLim = [0, 1];
xptPatch = [31, 60, 60, 31];
yptPatch = [0.01, 0.01, 1, 1];
fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});

hPlotRun(1) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch(xptPatch, yptPatch,colorLightYellow,'LineStyle','none');
hold on;
patch([xpt, fliplr(xpt)],[m_rMov_total_50run-sem_rMov_total_50run,fliplr(m_rMov_total_50run+sem_rMov_total_50run)],colorLightBlue,'LineStyle','none');
hold on;
plot(xpt,m_rMov_total_50run,'color',colorBlue);
hold on;
patch([xpt, fliplr(xpt)],[m_rMov_total_noRun-sem_rMov_total_noRun,fliplr(m_rMov_total_8run+sem_rMov_total_8run)],colorGray,'LineStyle','none');
hold on;
plot(xpt,m_rMov_total_noRun,'color',colorBlack);

ylabel('Spatial correlation','fontSize',fontM);
xlabel('Smoothed Lap (size: 5 lap)','fontSize',fontM);
title('50Hz stimulation (Run)','fontSize',fontM);

hPlotRun(2) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1,2,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch(xptPatch, yptPatch,colorLightYellow,'LineStyle','none');
hold on;
patch([xpt, fliplr(xpt)],[m_rMov_in_50run-sem_rMov_in_50run,fliplr(m_rMov_in_50run+sem_rMov_in_50run)],colorLightBlue,'LineStyle','none');
hold on;
plot(xpt,m_rMov_in_50run,'color',colorBlue);
hold on;
patch([xpt, fliplr(xpt)],[m_rMov_in_noRun-sem_rMov_in_noRun,fliplr(m_rMov_in_noRun+sem_rMov_in_noRun)],colorGray,'LineStyle','none');
hold on;
plot(xpt,m_rMov_in_noRun,'color',colorBlack);


hPlotRun(3) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1,3,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch(xptPatch, yptPatch,colorLightYellow,'LineStyle','none');
hold on;
patch([xpt, fliplr(xpt)],[m_rMov_out_50run-sem_rMov_out_50run,fliplr(m_rMov_out_50run+sem_rMov_out_50run)],colorLightBlue,'LineStyle','none');
hold on;
plot(xpt,m_rMov_out_50run,'color',colorBlue);
hold on;
patch([xpt, fliplr(xpt)],[m_rMov_out_noRun-sem_rMov_out_noRun,fliplr(m_rMov_out_noRun+sem_rMov_out_noRun)],colorGray,'LineStyle','none');
hold on;
plot(xpt,m_rMov_out_noRun,'color',colorBlack);


hPlotRun(4) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch(xptPatch, yptPatch,colorLightYellow,'LineStyle','none');
hold on;
patch([xpt, fliplr(xpt)],[m_rMov_total_8run-sem_rMov_total_8run,fliplr(m_rMov_total_8run+sem_rMov_total_8run)],colorLightBlue,'LineStyle','none');
hold on;
plot(xpt,m_rMov_total_8run,'color',colorBlue);
hold on;
patch([xpt, fliplr(xpt)],[m_rMov_total_noRun-sem_rMov_total_noRun,fliplr(m_rMov_total_8run+sem_rMov_total_8run)],colorGray,'LineStyle','none');
hold on;
plot(xpt,m_rMov_total_noRun,'color',colorBlack);

title('8Hz stimulation (Run)','fontSize',fontM);

hPlotRun(5) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,2,2,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch(xptPatch, yptPatch,colorLightYellow,'LineStyle','none');
hold on;
patch([xpt, fliplr(xpt)],[m_rMov_in_8run-sem_rMov_in_8run,fliplr(m_rMov_in_8run+sem_rMov_in_8run)],colorLightBlue,'LineStyle','none');
hold on;
plot(xpt,m_rMov_in_8run,'color',colorBlue);
hold on;
patch([xpt, fliplr(xpt)],[m_rMov_in_noRun-sem_rMov_in_noRun,fliplr(m_rMov_in_noRun+sem_rMov_in_noRun)],colorGray,'LineStyle','none');
hold on;
plot(xpt,m_rMov_in_noRun,'color',colorBlack);


hPlotRun(6) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,2,3,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch(xptPatch, yptPatch,colorLightYellow,'LineStyle','none');
hold on;
patch([xpt, fliplr(xpt)],[m_rMov_out_8run-sem_rMov_out_8run,fliplr(m_rMov_out_8run+sem_rMov_out_8run)],colorLightBlue,'LineStyle','none');
hold on;
plot(xpt,m_rMov_out_8run,'color',colorBlue);
hold on;
patch([xpt, fliplr(xpt)],[m_rMov_out_noRun-sem_rMov_out_noRun,fliplr(m_rMov_out_noRun+sem_rMov_out_noRun)],colorGray,'LineStyle','none');
hold on;
plot(xpt,m_rMov_out_noRun,'color',colorBlack);


hPlotRw(1) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,3,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch(xptPatch, yptPatch,colorLightYellow,'LineStyle','none');
hold on;
patch([xpt, fliplr(xpt)],[m_rMov_total_50rw-sem_rMov_total_50rw,fliplr(m_rMov_total_50rw+sem_rMov_total_50rw)],colorLightBlue,'LineStyle','none');
hold on;
plot(xpt,m_rMov_total_50rw,'color',colorBlue);
hold on;
patch([xpt, fliplr(xpt)],[m_rMov_total_noRw-sem_rMov_total_noRw,fliplr(m_rMov_total_noRw+sem_rMov_total_noRw)],colorGray,'LineStyle','none');
hold on;
plot(xpt,m_rMov_total_noRw,'color',colorBlack);
ylabel('Spatial correlation','fontSize',fontM);
xlabel('Smoothed Lap (size: 5 lap)','fontSize',fontM);
title('50Hz stimulation (Rw)','fontSize',fontM);

hPlotRw(2) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,3,2,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch(xptPatch, yptPatch,colorLightYellow,'LineStyle','none');
hold on;
patch([xpt, fliplr(xpt)],[m_rMov_in_50rw-sem_rMov_in_50rw,fliplr(m_rMov_in_50rw+sem_rMov_in_50rw)],colorLightBlue,'LineStyle','none');
hold on;
plot(xpt,m_rMov_in_50rw,'color',colorBlue);
hold on;
patch([xpt, fliplr(xpt)],[m_rMov_in_noRw-sem_rMov_in_noRw,fliplr(m_rMov_in_noRw+sem_rMov_in_noRw)],colorGray,'LineStyle','none');
hold on;
plot(xpt,m_rMov_in_noRw,'color',colorBlack);


hPlotRw(3) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,3,3,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch(xptPatch, yptPatch,colorLightYellow,'LineStyle','none');
hold on;
patch([xpt, fliplr(xpt)],[m_rMov_out_50rw-sem_rMov_out_50rw,fliplr(m_rMov_out_50rw+sem_rMov_out_50rw)],colorLightBlue,'LineStyle','none');
hold on;
plot(xpt,m_rMov_out_50rw,'color',colorBlue);
hold on;
patch([xpt, fliplr(xpt)],[m_rMov_out_noRw-sem_rMov_out_noRw,fliplr(m_rMov_out_noRw+sem_rMov_out_noRw)],colorGray,'LineStyle','none');
hold on;
plot(xpt,m_rMov_out_noRw,'color',colorBlack);


hPlotRw(4) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,4,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch(xptPatch, yptPatch,colorLightYellow,'LineStyle','none');
hold on;
patch([xpt, fliplr(xpt)],[m_rMov_total_8rw-sem_rMov_total_8rw,fliplr(m_rMov_total_8rw+sem_rMov_total_8rw)],colorLightBlue,'LineStyle','none');
hold on;
plot(xpt,m_rMov_total_8rw,'color',colorBlue);
hold on;
patch([xpt, fliplr(xpt)],[m_rMov_total_noRw-sem_rMov_total_noRw,fliplr(m_rMov_total_noRw+sem_rMov_total_noRw)],colorGray,'LineStyle','none');
hold on;
plot(xpt,m_rMov_total_noRw,'color',colorBlack);
title('8Hz stimulation (Rw)','fontSize',fontM);

hPlotRw(5) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,4,2,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch(xptPatch, yptPatch,colorLightYellow,'LineStyle','none');
hold on;
patch([xpt, fliplr(xpt)],[m_rMov_in_8rw-sem_rMov_in_8rw,fliplr(m_rMov_in_8rw+sem_rMov_in_8rw)],colorLightBlue,'LineStyle','none');
hold on;
plot(xpt,m_rMov_in_8rw,'color',colorBlue);
hold on;
patch([xpt, fliplr(xpt)],[m_rMov_in_noRw-sem_rMov_in_noRw,fliplr(m_rMov_in_noRw+sem_rMov_in_noRw)],colorGray,'LineStyle','none');
hold on;
plot(xpt,m_rMov_in_noRw,'color',colorBlack);

hPlotRw(6) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,4,3,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
patch(xptPatch, yptPatch,colorLightYellow,'LineStyle','none');
hold on;
patch([xpt, fliplr(xpt)],[m_rMov_out_8rw-sem_rMov_out_8rw,fliplr(m_rMov_out_8rw+sem_rMov_out_8rw)],colorLightBlue,'LineStyle','none');
hold on;
plot(xpt,m_rMov_out_8rw,'color',colorBlue);
hold on;
patch([xpt, fliplr(xpt)],[m_rMov_out_noRw-sem_rMov_out_noRw,fliplr(m_rMov_out_noRw+sem_rMov_out_noRw)],colorGray,'LineStyle','none');
hold on;
plot(xpt,m_rMov_out_noRw,'color',colorBlack);

set(hPlotRun,'TickDir','out','Box','off','XLim',[0,90],'YLim',[yLim(1) yLim(2)],'XTick',[0 30 60 90],'fontSize',fontM);
set(hPlotRw,'TickDir','out','Box','off','XLim',[0,90],'YLim',[yLim(1) yLim(2)],'XTick',[0 30 60 90],'fontSize',fontM);
set(hPlotRun,'TickLength',[0.03, 0.03]);
set(hPlotRw,'TickLength',[0.03, 0.03]);


xBar1 = [1,4,7];
xBar2 = [2,5,8];
barWidth = 0.3;
yptBar_total_50run = [mean(m_rMov_total_50run(1:30)), mean(m_rMov_total_50run(31:60)), mean(m_rMov_total_50run(61:90))];
eBar_total_50run = [std(m_rMov_total_50run(1:30),0,2)/sqrt(30),std(m_rMov_total_50run(31:60),0,2)/sqrt(30), std(m_rMov_total_50run(61:90),0,2)/sqrt(30)];
yptBar_in_50run = [mean(m_rMov_in_50run(1:30)), mean(m_rMov_in_50run(31:60)), mean(m_rMov_in_50run(61:90))];
eBar_in_50run = [std(m_rMov_in_50run(1:30),0,2)/sqrt(30),std(m_rMov_in_50run(31:60),0,2)/sqrt(30), std(m_rMov_in_50run(61:90),0,2)/sqrt(30)];
yptBar_out_50run = [mean(m_rMov_out_50run(1:30)), mean(m_rMov_out_50run(31:60)), mean(m_rMov_out_50run(61:90))];
eBar_out_50run = [std(m_rMov_out_50run(1:30),0,2)/sqrt(30),std(m_rMov_out_50run(31:60),0,2)/sqrt(30), std(m_rMov_out_50run(61:90),0,2)/sqrt(30)];

yptBar_total_50rw = [mean(m_rMov_total_50rw(1:30)), mean(m_rMov_total_50rw(31:60)), mean(m_rMov_total_50rw(61:90))];
eBar_total_50rw = [std(m_rMov_total_50rw(1:30),0,2)/sqrt(30),std(m_rMov_total_50rw(31:60),0,2)/sqrt(30), std(m_rMov_total_50rw(61:90),0,2)/sqrt(30)];
yptBar_in_50rw = [mean(m_rMov_in_50rw(1:30)), mean(m_rMov_in_50rw(31:60)), mean(m_rMov_in_50rw(61:90))];
eBar_in_50rw = [std(m_rMov_in_50rw(1:30),0,2)/sqrt(30),std(m_rMov_in_50rw(31:60),0,2)/sqrt(30), std(m_rMov_in_50rw(61:90),0,2)/sqrt(30)];
yptBar_out_50rw = [mean(m_rMov_out_50rw(1:30)), mean(m_rMov_out_50rw(31:60)), mean(m_rMov_out_50rw(61:90))];
eBar_out_50rw = [std(m_rMov_out_50rw(1:30),0,2)/sqrt(30),std(m_rMov_out_50rw(31:60),0,2)/sqrt(30), std(m_rMov_out_50rw(61:90),0,2)/sqrt(30)];

yptBar_total_8run = [mean(m_rMov_total_8run(1:30)), mean(m_rMov_total_8run(31:60)), mean(m_rMov_total_8run(61:90))];
eBar_total_8run = [std(m_rMov_total_8run(1:30),0,2)/sqrt(30),std(m_rMov_total_8run(31:60),0,2)/sqrt(30), std(m_rMov_total_8run(61:90),0,2)/sqrt(30)];
yptBar_in_8run = [mean(m_rMov_in_8run(1:30)), mean(m_rMov_in_8run(31:60)), mean(m_rMov_in_8run(61:90))];
eBar_in_8run = [std(m_rMov_in_8run(1:30),0,2)/sqrt(30),std(m_rMov_in_8run(31:60),0,2)/sqrt(30), std(m_rMov_in_8run(61:90),0,2)/sqrt(30)];
yptBar_out_8run = [mean(m_rMov_out_8run(1:30)), mean(m_rMov_out_8run(31:60)), mean(m_rMov_out_8run(61:90))];
eBar_out_8run = [std(m_rMov_out_8run(1:30),0,2)/sqrt(30),std(m_rMov_out_8run(31:60),0,2)/sqrt(30), std(m_rMov_out_8run(61:90),0,2)/sqrt(30)];

yptBar_total_8rw = [mean(m_rMov_total_8rw(1:30)), mean(m_rMov_total_8rw(31:60)), mean(m_rMov_total_8rw(61:90))];
eBar_total_8rw = [std(m_rMov_total_8rw(1:30),0,2)/sqrt(30),std(m_rMov_total_8rw(31:60),0,2)/sqrt(30), std(m_rMov_total_8rw(61:90),0,2)/sqrt(30)];
yptBar_in_8rw = [mean(m_rMov_in_8rw(1:30)), mean(m_rMov_in_8rw(31:60)), mean(m_rMov_in_8rw(61:90))];
eBar_in_8rw = [std(m_rMov_in_8rw(1:30),0,2)/sqrt(30),std(m_rMov_in_8rw(31:60),0,2)/sqrt(30), std(m_rMov_in_8rw(61:90),0,2)/sqrt(30)];
yptBar_out_8rw = [mean(m_rMov_out_8rw(1:30)), mean(m_rMov_out_8rw(31:60)), mean(m_rMov_out_8rw(61:90))];
eBar_out_8rw = [std(m_rMov_out_8rw(1:30),0,2)/sqrt(30),std(m_rMov_out_8rw(31:60),0,2)/sqrt(30), std(m_rMov_out_8rw(61:90),0,2)/sqrt(30)];

yptBar_total_noRun = [mean(m_rMov_total_noRun(1:30)), mean(m_rMov_total_noRun(31:60)), mean(m_rMov_total_noRun(61:90))];
eBar_total_noRun = [std(m_rMov_total_noRun(1:30),0,2)/sqrt(30),std(m_rMov_total_noRun(31:60),0,2)/sqrt(30), std(m_rMov_total_noRun(61:90),0,2)/sqrt(30)];
yptBar_in_noRun = [mean(m_rMov_in_noRun(1:30)), mean(m_rMov_in_noRun(31:60)), mean(m_rMov_in_noRun(61:90))];
eBar_in_noRun = [std(m_rMov_in_noRun(1:30),0,2)/sqrt(30),std(m_rMov_in_noRun(31:60),0,2)/sqrt(30), std(m_rMov_in_noRun(61:90),0,2)/sqrt(30)];
yptBar_out_noRun = [mean(m_rMov_out_noRun(1:30)), mean(m_rMov_out_noRun(31:60)), mean(m_rMov_out_noRun(61:90))];
eBar_out_noRun = [std(m_rMov_out_noRun(1:30),0,2)/sqrt(30),std(m_rMov_out_noRun(31:60),0,2)/sqrt(30), std(m_rMov_out_noRun(61:90),0,2)/sqrt(30)];

yptBar_total_noRw = [mean(m_rMov_total_noRw(1:30)), mean(m_rMov_total_noRw(31:60)), mean(m_rMov_total_noRw(61:90))];
eBar_total_noRw = [std(m_rMov_total_noRw(1:30),0,2)/sqrt(30),std(m_rMov_total_noRw(31:60),0,2)/sqrt(30), std(m_rMov_total_noRw(61:90),0,2)/sqrt(30)];
yptBar_in_noRw = [mean(m_rMov_in_noRw(1:30)), mean(m_rMov_in_noRw(31:60)), mean(m_rMov_in_noRw(61:90))];
eBar_in_noRw = [std(m_rMov_in_noRw(1:30),0,2)/sqrt(30),std(m_rMov_in_noRw(31:60),0,2)/sqrt(30), std(m_rMov_in_noRw(61:90),0,2)/sqrt(30)];
yptBar_out_noRw = [mean(m_rMov_out_noRw(1:30)), mean(m_rMov_out_noRw(31:60)), mean(m_rMov_out_noRw(61:90))];
eBar_out_noRw = [std(m_rMov_out_noRw(1:30),0,2)/sqrt(30),std(m_rMov_out_noRw(31:60),0,2)/sqrt(30), std(m_rMov_out_noRw(61:90),0,2)/sqrt(30)];

%% statistic
[~, p_total_50run(1)] = ttest(m_rMov_total_50run(1:30),m_rMov_total_noRun(1:30));
[~, p_total_50run(2)] = ttest(m_rMov_total_50run(31:60),m_rMov_total_noRun(31:60));
[~, p_total_50run(3)] = ttest(m_rMov_total_50run(61:90),m_rMov_total_noRun(61:90));
[~, p_in_50run(1)] = ttest(m_rMov_in_50run(1:30),m_rMov_in_noRun(1:30));
[~, p_in_50run(2)] = ttest(m_rMov_in_50run(31:60),m_rMov_in_noRun(31:60));
[~, p_in_50run(3)] = ttest(m_rMov_in_50run(61:90),m_rMov_in_noRun(61:90));
[~, p_out_50run(1)] = ttest(m_rMov_out_50run(1:30),m_rMov_out_noRun(1:30));
[~, p_out_50run(2)] = ttest(m_rMov_out_50run(31:60),m_rMov_out_noRun(31:60));
[~, p_out_50run(3)] = ttest(m_rMov_out_50run(61:90),m_rMov_out_noRun(61:90));

[~, p_total_8run(1)] = ttest(m_rMov_total_8run(1:30),m_rMov_total_noRun(1:30));
[~, p_total_8run(2)] = ttest(m_rMov_total_8run(31:60),m_rMov_total_noRun(31:60));
[~, p_total_8run(3)] = ttest(m_rMov_total_8run(61:90),m_rMov_total_noRun(61:90));
[~, p_in_8run(1)] = ttest(m_rMov_in_8run(1:30),m_rMov_in_noRun(1:30));
[~, p_in_8run(2)] = ttest(m_rMov_in_8run(31:60),m_rMov_in_noRun(31:60));
[~, p_in_8run(3)] = ttest(m_rMov_in_8run(61:90),m_rMov_in_noRun(61:90));
[~, p_out_8run(1)] = ttest(m_rMov_out_8run(1:30),m_rMov_out_noRun(1:30));
[~, p_out_8run(2)] = ttest(m_rMov_out_8run(31:60),m_rMov_out_noRun(31:60));
[~, p_out_8run(3)] = ttest(m_rMov_out_8run(61:90),m_rMov_out_noRun(61:90));

[~, p_total_50rw(1)] = ttest(m_rMov_total_50rw(1:30),m_rMov_total_noRw(1:30));
[~, p_total_50rw(2)] = ttest(m_rMov_total_50rw(31:60),m_rMov_total_noRw(31:60));
[~, p_total_50rw(3)] = ttest(m_rMov_total_50rw(61:90),m_rMov_total_noRw(61:90));
[~, p_in_50rw(1)] = ttest(m_rMov_in_50rw(1:30),m_rMov_in_noRw(1:30));
[~, p_in_50rw(2)] = ttest(m_rMov_in_50rw(31:60),m_rMov_in_noRw(31:60));
[~, p_in_50rw(3)] = ttest(m_rMov_in_50rw(61:90),m_rMov_in_noRw(61:90));
[~, p_out_50rw(1)] = ttest(m_rMov_out_50rw(1:30),m_rMov_out_noRw(1:30));
[~, p_out_50rw(2)] = ttest(m_rMov_out_50rw(31:60),m_rMov_out_noRw(31:60));
[~, p_out_50rw(3)] = ttest(m_rMov_out_50rw(61:90),m_rMov_out_noRw(61:90));

[~, p_total_8rw(1)] = ttest(m_rMov_total_8rw(1:30),m_rMov_total_noRw(1:30));
[~, p_total_8rw(2)] = ttest(m_rMov_total_8rw(31:60),m_rMov_total_noRw(31:60));
[~, p_total_8rw(3)] = ttest(m_rMov_total_8rw(61:90),m_rMov_total_noRw(61:90));
[~, p_in_8rw(1)] = ttest(m_rMov_in_8rw(1:30),m_rMov_in_noRw(1:30));
[~, p_in_8rw(2)] = ttest(m_rMov_in_8rw(31:60),m_rMov_in_noRw(31:60));
[~, p_in_8rw(3)] = ttest(m_rMov_in_8rw(61:90),m_rMov_in_noRw(61:90));
[~, p_out_8rw(1)] = ttest(m_rMov_out_8rw(1:30),m_rMov_out_noRw(1:30));
[~, p_out_8rw(2)] = ttest(m_rMov_out_8rw(31:60),m_rMov_out_noRw(31:60));
[~, p_out_8rw(3)] = ttest(m_rMov_out_8rw(61:90),m_rMov_out_noRw(61:90));
%% bar plot
hPlotBarRun(1) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1,4,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
bar(xBar1,yptBar_total_50run,barWidth,'faceColor',colorLLightBlue);
hold on;
errorbarJun(xBar1,yptBar_total_50run,eBar_total_50run,0.3,1.0,colorBlack);
bar(xBar2, yptBar_total_noRun,barWidth,'faceColor',colorDarkGray);
hold on;
errorbarJun(xBar2,yptBar_total_noRun,eBar_total_noRun,0.3,1.0,colorBlack);
text(-1,-0.5,['p = ',num2str(p_total_50run(1),3),'  ',num2str(p_total_50run(2),3),'  ',num2str(p_total_50run(3),3)],'fontSize',fontM);
ylabel('Spatial correlation','fontSize',fontM);

hPlotBarRun(2) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1,5,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
bar(xBar1,yptBar_in_50run,barWidth,'faceColor',colorLLightBlue);
hold on;
errorbarJun(xBar1,yptBar_in_50run,eBar_in_50run,0.3,1.0,colorBlack);
bar(xBar2, yptBar_in_noRun,barWidth,'faceColor',colorDarkGray);
hold on;
errorbarJun(xBar2,yptBar_in_noRun,eBar_in_noRun,0.3,1.0,colorBlack);
text(-1,-0.5,['p = ',num2str(p_in_50run(1),3),'  ',num2str(p_in_50run(2),3),'  ',num2str(p_in_50run(3),3)],'fontSize',fontM);

hPlotBarRun(3) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1,6,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
bar(xBar1,yptBar_out_50run,barWidth,'faceColor',colorLLightBlue);
hold on;
errorbarJun(xBar1,yptBar_out_50run,eBar_out_50run,0.3,1.0,colorBlack);
bar(xBar2, yptBar_out_noRun,barWidth,'faceColor',colorDarkGray);
hold on;
errorbarJun(xBar2,yptBar_out_noRun,eBar_out_noRun,0.3,1.0,colorBlack);
text(-1,-0.5,['p = ',num2str(p_out_50run(1),3),'  ',num2str(p_out_50run(2),3),'  ',num2str(p_out_50run(3),3)],'fontSize',fontM);

hPlotBarRun(4) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,2,4,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
bar(xBar1,yptBar_total_8run,barWidth,'faceColor',colorLLightBlue);
hold on;
errorbarJun(xBar1,yptBar_total_8run,eBar_total_8run,0.3,1.0,colorBlack);
bar(xBar2, yptBar_total_noRun,barWidth,'faceColor',colorDarkGray);
hold on;
errorbarJun(xBar2,yptBar_total_noRun,eBar_total_noRun,0.3,1.0,colorBlack);
text(-1,-0.5,['p = ',num2str(p_total_8run(1),3),'  ',num2str(p_total_8run(2),3),'  ',num2str(p_total_8run(3),3)],'fontSize',fontM);

hPlotBarRun(5) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,2,5,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
bar(xBar1,yptBar_in_8run,barWidth,'faceColor',colorLLightBlue);
hold on;
errorbarJun(xBar1,yptBar_in_8run,eBar_in_8run,0.3,1.0,colorBlack);
bar(xBar2, yptBar_in_noRun,barWidth,'faceColor',colorDarkGray);
hold on;
errorbarJun(xBar2,yptBar_in_noRun,eBar_in_noRun,0.3,1.0,colorBlack);
text(-1,-0.5,['p = ',num2str(p_in_8run(1),3),'  ',num2str(p_in_8run(2),3),'  ',num2str(p_in_8run(3),3)],'fontSize',fontM);

hPlotBarRun(6) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,2,6,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
bar(xBar1,yptBar_out_8run,barWidth,'faceColor',colorLLightBlue);
hold on;
errorbarJun(xBar1,yptBar_out_8run,eBar_out_8run,0.3,1.0,colorBlack);
bar(xBar2, yptBar_out_noRun,barWidth,'faceColor',colorDarkGray);
hold on;
errorbarJun(xBar2,yptBar_out_noRun,eBar_out_noRun,0.3,1.0,colorBlack);
text(-1,-0.5,['p = ',num2str(p_out_8run(1),3),'  ',num2str(p_out_8run(2),3),'  ',num2str(p_out_8run(3),3)],'fontSize',fontM);

hPlotBarRw(1) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,3,4,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
bar(xBar1,yptBar_total_50rw,barWidth,'faceColor',colorLLightBlue);
hold on;
errorbarJun(xBar1,yptBar_total_50rw,eBar_total_50rw,0.3,1.0,colorBlack);
bar(xBar2, yptBar_total_noRw,barWidth,'faceColor',colorDarkGray);
hold on;
errorbarJun(xBar2,yptBar_total_noRw,eBar_total_noRw,0.3,1.0,colorBlack);
text(-1,-0.5,['p = ',num2str(p_total_50rw(1),3),'  ',num2str(p_total_50rw(2),3),'  ',num2str(p_total_50rw(3),3)],'fontSize',fontM);

hPlotBarRw(2) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,3,5,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
bar(xBar1,yptBar_in_50rw,barWidth,'faceColor',colorLLightBlue);
hold on;
errorbarJun(xBar1,yptBar_in_50rw,eBar_in_50rw,0.3,1.0,colorBlack);
bar(xBar2, yptBar_in_noRw,barWidth,'faceColor',colorDarkGray);
hold on;
errorbarJun(xBar2,yptBar_in_noRw,eBar_in_noRw,0.3,1.0,colorBlack);
text(-1,-0.5,['p = ',num2str(p_in_50rw(1),3),'  ',num2str(p_in_50rw(2),3),'  ',num2str(p_in_50rw(3),3)],'fontSize',fontM);

hPlotBarRw(3) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,3,6,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
bar(xBar1,yptBar_out_50rw,barWidth,'faceColor',colorLLightBlue);
hold on;
errorbarJun(xBar1,yptBar_out_50rw,eBar_out_50rw,0.3,1.0,colorBlack);
bar(xBar2, yptBar_out_noRw,barWidth,'faceColor',colorDarkGray);
hold on;
errorbarJun(xBar2,yptBar_out_noRw,eBar_out_noRw,0.3,1.0,colorBlack);
text(-1,-0.5,['p = ',num2str(p_out_50rw(1),3),'  ',num2str(p_out_50rw(2),3),'  ',num2str(p_out_50rw(3),3)],'fontSize',fontM);

hPlotBarRw(4) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,4,4,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
bar(xBar1,yptBar_total_8rw,barWidth,'faceColor',colorLLightBlue);
hold on;
errorbarJun(xBar1,yptBar_total_8rw,eBar_total_8rw,0.3,1.0,colorBlack);
bar(xBar2, yptBar_total_noRw,barWidth,'faceColor',colorDarkGray);
hold on;
errorbarJun(xBar2,yptBar_total_noRw,eBar_total_noRw,0.3,1.0,colorBlack);
text(-1,-0.5,['p = ',num2str(p_total_8rw(1),3),'  ',num2str(p_total_8rw(2),3),'  ',num2str(p_total_8rw(3),3)],'fontSize',fontM);

hPlotBarRw(5) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,4,5,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
bar(xBar1,yptBar_in_8rw,barWidth,'faceColor',colorLLightBlue);
hold on;
errorbarJun(xBar1,yptBar_in_8rw,eBar_in_8rw,0.3,1.0,colorBlack);
bar(xBar2, yptBar_in_noRw,barWidth,'faceColor',colorDarkGray);
hold on;
errorbarJun(xBar2,yptBar_in_noRw,eBar_in_noRw,0.3,1.0,colorBlack);
text(-1,-0.5,['p = ',num2str(p_in_8rw(1),3),'  ',num2str(p_in_8rw(2),3),'  ',num2str(p_in_8rw(3),3)],'fontSize',fontM);

hPlotBarRw(6) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,4,6,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
bar(xBar1,yptBar_out_8rw,barWidth,'faceColor',colorLLightBlue);
hold on;
errorbarJun(xBar1,yptBar_out_8rw,eBar_out_8rw,0.3,1.0,colorBlack);
bar(xBar2, yptBar_out_noRw,barWidth,'faceColor',colorDarkGray);
hold on;
errorbarJun(xBar2,yptBar_out_noRw,eBar_out_noRw,0.3,1.0,colorBlack);
text(-1,-0.5,['p = ',num2str(p_out_8rw(1),3),'  ',num2str(p_out_8rw(2),3),'  ',num2str(p_out_8rw(3),3)],'fontSize',fontM);

set(hPlotBarRun,'TickDir','out','Box','off','XLim',[0,9],'YLim',[yLim(1), yLim(2)],'XTick',[1.5, 4.5, 7.5],'XTickLabel',[]);
set(hPlotBarRw,'TickDir','out','Box','off','XLim',[0,9],'YLim',[yLim(1), yLim(2)],'XTick',[1.5, 4.5, 7.5],'XTickLabel',[]);
set(hPlotBarRun(1),'XTickLabel',{'PRE','STIM','POST'},'fontSize',fontM);
set(hPlotBarRw(1),'XTickLabel',{'PRE','STIM','POST'},'fontSize',fontM);
set(hPlotBarRun,'TickLength',[0.03, 0.03]);
set(hPlotBarRw,'TickLength',[0.03, 0.03]);

print('-painters','-r300','-dtiff',['f_Neuron_SPCorr_smoothed_',datestr(now,formatOut),'_mFRpeak3','.tif']);
% print('-painters','-r300','-depsc',['f_CellRepors_PVCorr_8Hz_',datestr(now,formatOut),'.ai']);
% close;