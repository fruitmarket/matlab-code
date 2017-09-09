clearvars;
cd('D:\Dropbox\SNL\P2_Track');
Txls = readtable('neuronList_ori_170814.xlsx');
Txls.latencyIndex = categorical(Txls.latencyIndex);
load('neuronList_ori_170814.mat');
load myParameters.mat;

formatOut = 'yymmdd';

% TN: track neuron
tPC = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
actPC = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == 1;
directPC = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == 1 & Txls.latencyIndex == 'direct';
indirectPC = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == 1 & Txls.latencyIndex == 'indirect';
doublePC = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == 1 & Txls.latencyIndex == 'double';
inaPC = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == -1;
norespPC = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxpLR_Track;

ntPC = sum(double(tPC));
nactPC = sum(double(actPC));
ndirectPC = sum(double(directPC));
nindirectPC = sum(double(indirectPC));
ndoublePC = sum(double(doublePC));
ninaPC = sum(double(inaPC));
nnorespPC = sum(double(norespPC));

% corr of total neurons
fcorr_tPC = [T.fCorr1D_preXpre(tPC); T.fCorr1D_preXstm(tPC); T.fCorr1D_preXpost(tPC); T.fCorr1D_stmXpost(tPC)];
fcorr_actPC = [T.fCorr1D_preXpre(actPC); T.fCorr1D_preXstm(actPC); T.fCorr1D_preXpost(actPC); T.fCorr1D_stmXpost(actPC)];
fcorr_rapidPC = [T.fCorr1D_preXpre(directPC); T.fCorr1D_preXstm(directPC); T.fCorr1D_preXpost(directPC); T.fCorr1D_stmXpost(directPC)];
fcorr_slowPC = [T.fCorr1D_preXpre(indirectPC); T.fCorr1D_preXstm(indirectPC); T.fCorr1D_preXpost(indirectPC); T.fCorr1D_stmXpost(indirectPC)];
fcorr_doublePC = [T.fCorr1D_preXpre(doublePC); T.fCorr1D_preXstm(doublePC); T.fCorr1D_preXpost(doublePC); T.fCorr1D_stmXpost(doublePC)];
fcorr_inaPC = [T.fCorr1D_preXpre(inaPC); T.fCorr1D_preXstm(inaPC); T.fCorr1D_preXpost(inaPC); T.fCorr1D_stmXpost(inaPC)];
fcorr_norespPC = [T.fCorr1D_preXpre(norespPC); T.fCorr1D_preXstm(norespPC); T.fCorr1D_preXpost(norespPC); T.fCorr1D_stmXpost(norespPC)];

xpt_tPC = [ones(sum(double(tPC)),1); ones(sum(double(tPC)),1)*2; ones(sum(double(tPC)),1)*3; ones(sum(double(tPC)),1)*4];
xpt_actPC = [ones(sum(double(actPC)),1); ones(sum(double(actPC)),1)*2; ones(sum(double(actPC)),1)*3; ones(sum(double(actPC)),1)*4];
xpt_rapidPC = [ones(sum(double(directPC)),1); ones(sum(double(directPC)),1)*2; ones(sum(double(directPC)),1)*3; ones(sum(double(directPC)),1)*4];
xpt_slowPC = [ones(sum(double(indirectPC)),1); ones(sum(double(indirectPC)),1)*2; ones(sum(double(indirectPC)),1)*3; ones(sum(double(indirectPC)),1)*4];
xpt_doublePC = [ones(sum(double(doublePC)),1); ones(sum(double(doublePC)),1)*2; ones(sum(double(doublePC)),1)*3; ones(sum(double(doublePC)),1)*4];
xpt_inaPC = [ones(sum(double(inaPC)),1); ones(sum(double(inaPC)),1)*2; ones(sum(double(inaPC)),1)*3; ones(sum(double(inaPC)),1)*4];
xpt_norespPC = [ones(sum(double(norespPC)),1); ones(sum(double(norespPC)),1)*2; ones(sum(double(norespPC)),1)*3; ones(sum(double(norespPC)),1)*4];

%%
nCol = 4;
nRow = 2;
fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{2});

hTotalCorr(1) = axes('Position',axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval));
% plot([1,2,3,4],[T.fCorr1D_preXpre(tPC), T.fCorr1D_preXstm(tPC), T.fCorr1D_preXpost(tPC), T.fCorr1D_stmXpost(tPC)],'lineStyle','-','lineWidth',0.5,'color',colorGray);
hold on;
MyScatterBarPlot(fcorr_tPC,xpt_tPC,0.45,{colorGray,colorGreen,colorBlue,colorPurple},[]);
title('total place cells','fontSize',fontM,'fontWeight','bold');
ylabel('Corr(z-transformed)','fontSize',fontM);
text(3.5, 4.5,['n = ',num2str(sum(double(tPC)))],'fontSize',fontM);

hTotalCorr(2) = axes('Position',axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],midInterval));
% plot([1,2,3],[T.fCorr1D_preXstm(rapidPC), T.fCorr1D_preXpost(rapidPC), T.fCorr1D_stmXpost(rapidPC)],'lineStyle','-','lineWidth',0.5,'color',colorGray);
hold on;
MyScatterBarPlot(fcorr_actPC,xpt_actPC,0.45,{colorGray,colorGreen,colorBlue,colorPurple},[]);
title('activated place cells','fontSize',fontM,'fontWeight','bold');
ylabel('Corr(z-transformed)','fontSize',fontM);
text(3.5,4.5,['n = ',num2str(sum(double(actPC)))],'fontSize',fontM);

% hTotalCorr(3) = axes('Position',axpt(nCol,nRow,1,3,[0.1 0.1 0.85 0.85],midInterval));
% plot([1,2,3],[T.fCorr1D_preXstm(rapidPC), T.fCorr1D_preXpost(rapidPC), T.fCorr1D_stmXpost(rapidPC)],'lineStyle','-','lineWidth',0.5,'color',colorGray);
% hold on;
% MyScatterBarPlot(fcorr_rapidPC,xpt_rapidPC,0.45,{colorGray,colorGreen,colorBlue,colorPurple},[]);
% title('direct activated place cells','fontSize',fontM,'fontWeight','bold');
% ylabel('Corr(z-transformed)','fontSize',fontM);
% text(3.5,4.5,['n = ',num2str(sum(double(directPC)))],'fontSize',fontM);

% hTotalCorr(4) = axes('Position',axpt(nCol,nRow,2,3,[0.1 0.1 0.85 0.85],midInterval));
% plot([1,2,3],[T.fCorr1D_preXstm(slowPC), T.fCorr1D_preXpost(slowPC), T.fCorr1D_stmXpost(slowPC)],'lineStyle','-','lineWidth',0.5,'color',colorGray);
% hold on;
% MyScatterBarPlot(fcorr_slowPC,xpt_slowPC,0.45,{colorGray,colorGreen,colorBlue,colorPurple},[]);
% title('indirect activated place cells','fontSize',fontM,'fontWeight','bold');
% ylabel('Corr(z-transformed)','fontSize',fontM);
% text(3.5,4.5,['n = ',num2str(sum(double(indirectPC)))],'fontSize',fontM);

% hTotalCorr(5) = axes('Position',axpt(nCol,nRow,3,3,[0.1 0.1 0.85 0.85],midInterval));
% plot([1,2,3],[T.fCorr1D_preXstm(doublePC), T.fCorr1D_preXpost(doublePC), T.fCorr1D_stmXpost(doublePC)],'lineStyle','-','lineWidth',0.5,'color',colorGray);
% hold on;
% MyScatterBarPlot(fcorr_doublePC,xpt_doublePC,0.45,{colorGray,colorGreen,colorBlue,colorPurple},[]);
% title('double activated place cells','fontSize',fontM,'fontWeight','bold');
% ylabel('Corr(z-transformed)','fontSize',fontM);
% text(3.5,4.5,['n = ',num2str(sum(double(doublePC)))],'fontSize',fontM);

hTotalCorr(3) = axes('Position',axpt(nCol,nRow,3,1,[0.1 0.1 0.85 0.85],midInterval));
% plot([1,2,3],[T.fCorr1D_preXstm(inaPC), T.fCorr1D_preXpost(inaPC), T.fCorr1D_stmXpost(inaPC)],'lineStyle','-','lineWidth',0.5,'color',colorGray);
hold on;
MyScatterBarPlot(fcorr_inaPC,xpt_inaPC,0.45,{colorGray,colorGreen,colorBlue,colorPurple},[]);
title('inactivated place cells','fontSize',fontM,'fontWeight','bold');
ylabel('Corr(z-transformed)','fontSize',fontM);
text(3.5,4.5,['n = ',num2str(sum(double(inaPC)))],'fontSize',fontM);

hTotalCorr(4) = axes('Position',axpt(nCol,nRow,4,1,[0.1 0.1 0.85 0.85],midInterval));
% plot([1,2,3],[T.fCorr1D_preXstm(norespPC), T.fCorr1D_preXpost(norespPC), T.fCorr1D_stmXpost(norespPC)],'lineStyle','-','lineWidth',0.5,'color',colorGray);
hold on;
MyScatterBarPlot(fcorr_norespPC,xpt_norespPC,0.45,{colorGray,colorGreen,colorBlue,colorPurple},[]);
title('noresponsive place cells','fontSize',fontM,'fontWeight','bold');
ylabel('Corr(z-transformed)','fontSize',fontM);
text(3.5,4.5,['n = ',num2str(sum(double(norespPC)))],'fontSize',fontM);

set(hTotalCorr,'TickDir','out','Box','off','XLim',[0.5,4.5],'YLim',[-0.5 5],'XTick',[1,2,3,4],'XTickLabel',[{'preXpre','preXstm','preXpost','stmXpost'}],'fontSize',fontM);
print('-painters','-r300','-dtiff',[datestr(now,formatOut),'_placeFieldCorrelation_noRun.tif']);

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% noRw sessions %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tPC = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
actPC = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == 1;
directPC = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == 1 & Txls.latencyIndex == 'direct';
indirectPC = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == 1 & Txls.latencyIndex == 'indirect';
doublePC = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == 1 & Txls.latencyIndex == 'double';
inaPC = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == -1;
norespPC = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxpLR_Track;

ntPC = sum(double(tPC));
ndirectPC = sum(double(directPC));
nindirectPC = sum(double(indirectPC));
ndoublePC = sum(double(doublePC));
ninaPC = sum(double(inaPC));
nnorespPC = sum(double(norespPC));

% corr of total neurons
fcorr_tPC = [T.fCorr1D_preXpre(tPC); T.fCorr1D_preXstm(tPC); T.fCorr1D_preXpost(tPC); T.fCorr1D_stmXpost(tPC)];
fcorr_actPC = [T.fCorr1D_preXpre(actPC); T.fCorr1D_preXstm(actPC); T.fCorr1D_preXpost(actPC); T.fCorr1D_stmXpost(actPC)];
fcorr_rapidPC = [T.fCorr1D_preXpre(directPC); T.fCorr1D_preXstm(directPC); T.fCorr1D_preXpost(directPC); T.fCorr1D_stmXpost(directPC)];
fcorr_slowPC = [T.fCorr1D_preXpre(indirectPC); T.fCorr1D_preXstm(indirectPC); T.fCorr1D_preXpost(indirectPC); T.fCorr1D_stmXpost(indirectPC)];
fcorr_doublePC = [T.fCorr1D_preXpre(doublePC); T.fCorr1D_preXstm(doublePC); T.fCorr1D_preXpost(doublePC); T.fCorr1D_stmXpost(doublePC)];
fcorr_inaPC = [T.fCorr1D_preXpre(inaPC); T.fCorr1D_preXstm(inaPC); T.fCorr1D_preXpost(inaPC); T.fCorr1D_stmXpost(inaPC)];
fcorr_norespPC = [T.fCorr1D_preXpre(norespPC); T.fCorr1D_preXstm(norespPC); T.fCorr1D_preXpost(norespPC); T.fCorr1D_stmXpost(norespPC)];

xpt_tPC = [ones(sum(double(tPC)),1); ones(sum(double(tPC)),1)*2; ones(sum(double(tPC)),1)*3; ones(sum(double(tPC)),1)*4];
xpt_actPC = [ones(sum(double(actPC)),1); ones(sum(double(actPC)),1)*2; ones(sum(double(actPC)),1)*3; ones(sum(double(actPC)),1)*4];
xpt_rapidPC = [ones(sum(double(directPC)),1); ones(sum(double(directPC)),1)*2; ones(sum(double(directPC)),1)*3; ones(sum(double(directPC)),1)*4];
xpt_slowPC = [ones(sum(double(indirectPC)),1); ones(sum(double(indirectPC)),1)*2; ones(sum(double(indirectPC)),1)*3; ones(sum(double(indirectPC)),1)*4];
xpt_doublePC = [ones(sum(double(doublePC)),1); ones(sum(double(doublePC)),1)*2; ones(sum(double(doublePC)),1)*3; ones(sum(double(doublePC)),1)*4];
xpt_inaPC = [ones(sum(double(inaPC)),1); ones(sum(double(inaPC)),1)*2; ones(sum(double(inaPC)),1)*3; ones(sum(double(inaPC)),1)*4];
xpt_norespPC = [ones(sum(double(norespPC)),1); ones(sum(double(norespPC)),1)*2; ones(sum(double(norespPC)),1)*3; ones(sum(double(norespPC)),1)*4];


nCol = 4;
nRow = 3;
fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{2});

hTotalCorr(1) = axes('Position',axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval));
% plot([1,2,3,4],[T.fCorr1D_preXpre(tPC), T.fCorr1D_preXstm(tPC), T.fCorr1D_preXpost(tPC), T.fCorr1D_stmXpost(tPC)],'lineStyle','-','lineWidth',0.5,'color',colorGray);
hold on;
MyScatterBarPlot(fcorr_tPC,xpt_tPC,0.45,{colorGray,colorGreen,colorBlue,colorPurple},[]);
title('total place cells','fontSize',fontM,'fontWeight','bold');
ylabel('Corr(z-transformed)','fontSize',fontM);
text(3.5, 4.5,['n = ',num2str(sum(double(tPC)))],'fontSize',fontM);

hTotalCorr(2) = axes('Position',axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],midInterval));
% plot([1,2,3],[T.fCorr1D_preXstm(rapidPC), T.fCorr1D_preXpost(rapidPC), T.fCorr1D_stmXpost(rapidPC)],'lineStyle','-','lineWidth',0.5,'color',colorGray);
hold on;
MyScatterBarPlot(fcorr_actPC,xpt_actPC,0.45,{colorGray,colorGreen,colorBlue,colorPurple},[]);
title('activated place cells','fontSize',fontM,'fontWeight','bold');
ylabel('Corr(z-transformed)','fontSize',fontM);
text(3.5,4.5,['n = ',num2str(sum(double(actPC)))],'fontSize',fontM);

% hTotalCorr(3) = axes('Position',axpt(nCol,nRow,1,3,[0.1 0.1 0.85 0.85],midInterval));
% plot([1,2,3],[T.fCorr1D_preXstm(rapidPC), T.fCorr1D_preXpost(rapidPC), T.fCorr1D_stmXpost(rapidPC)],'lineStyle','-','lineWidth',0.5,'color',colorGray);
% hold on;
% MyScatterBarPlot(fcorr_rapidPC,xpt_rapidPC,0.45,{colorGray,colorGreen,colorBlue,colorPurple},[]);
% title('direct activated place cells','fontSize',fontM,'fontWeight','bold');
% ylabel('Corr(z-transformed)','fontSize',fontM);
% text(3.5,4.5,['n = ',num2str(sum(double(directPC)))],'fontSize',fontM);

% hTotalCorr(4) = axes('Position',axpt(nCol,nRow,2,3,[0.1 0.1 0.85 0.85],midInterval));
% plot([1,2,3],[T.fCorr1D_preXstm(slowPC), T.fCorr1D_preXpost(slowPC), T.fCorr1D_stmXpost(slowPC)],'lineStyle','-','lineWidth',0.5,'color',colorGray);
% hold on;
% MyScatterBarPlot(fcorr_slowPC,xpt_slowPC,0.45,{colorGray,colorGreen,colorBlue,colorPurple},[]);
% title('indirect activated place cells','fontSize',fontM,'fontWeight','bold');
% ylabel('Corr(z-transformed)','fontSize',fontM);
% text(3.5,4.5,['n = ',num2str(sum(double(indirectPC)))],'fontSize',fontM);

% hTotalCorr(5) = axes('Position',axpt(nCol,nRow,3,3,[0.1 0.1 0.85 0.85],midInterval));
% plot([1,2,3],[T.fCorr1D_preXstm(doublePC), T.fCorr1D_preXpost(doublePC), T.fCorr1D_stmXpost(doublePC)],'lineStyle','-','lineWidth',0.5,'color',colorGray);
% hold on;
% MyScatterBarPlot(fcorr_doublePC,xpt_doublePC,0.45,{colorGray,colorGreen,colorBlue,colorPurple},[]);
% title('double activated place cells','fontSize',fontM,'fontWeight','bold');
% ylabel('Corr(z-transformed)','fontSize',fontM);
% text(3.5,4.5,['n = ',num2str(sum(double(doublePC)))],'fontSize',fontM);

hTotalCorr(3) = axes('Position',axpt(nCol,nRow,3,1,[0.1 0.1 0.85 0.85],midInterval));
% plot([1,2,3],[T.fCorr1D_preXstm(inaPC), T.fCorr1D_preXpost(inaPC), T.fCorr1D_stmXpost(inaPC)],'lineStyle','-','lineWidth',0.5,'color',colorGray);
hold on;
MyScatterBarPlot(fcorr_inaPC,xpt_inaPC,0.45,{colorGray,colorGreen,colorBlue,colorPurple},[]);
title('inactivated place cells','fontSize',fontM,'fontWeight','bold');
ylabel('Corr(z-transformed)','fontSize',fontM);
text(3.5,4.5,['n = ',num2str(sum(double(inaPC)))],'fontSize',fontM);

hTotalCorr(4) = axes('Position',axpt(nCol,nRow,4,1,[0.1 0.1 0.85 0.85],midInterval));
% plot([1,2,3],[T.fCorr1D_preXstm(norespPC), T.fCorr1D_preXpost(norespPC), T.fCorr1D_stmXpost(norespPC)],'lineStyle','-','lineWidth',0.5,'color',colorGray);
hold on;
MyScatterBarPlot(fcorr_norespPC,xpt_norespPC,0.45,{colorGray,colorGreen,colorBlue,colorPurple},[]);
title('noresponsive place cells','fontSize',fontM,'fontWeight','bold');
ylabel('Corr(z-transformed)','fontSize',fontM);
text(3.5,4.5,['n = ',num2str(sum(double(norespPC)))],'fontSize',fontM);

set(hTotalCorr,'TickDir','out','Box','off','XLim',[0.5,4.5],'YLim',[-0.5 5],'XTick',[1,2,3,4],'XTickLabel',[{'preXpre','preXstm','preXpost','stmXpost'}],'fontSize',fontM);
print('-painters','-r300','-dtiff',[datestr(now,formatOut),'_placeFieldCorrelation_noRw.tif']);
close('all');