% Calculate cross correlation of rapid light activated population
%
%
% common part
lineColor = {[144, 164, 174]./255,... % Before stimulation
    [33 150 243]./ 255,... % During stimulation
    [38, 50, 56]./255}; % After stimulation

lineWth = [1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75];
fontS = 4; fontM = 6; fontL = 8; % font size large
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
Txls = readtable('neuronList_03-Mar-2017.xlsx');
load('neuronList_ori_07-Mar-2017.mat');

criPeak = 0;
criFR = 7;
alpha = 0.01;

% TN: track neuron
DRunTN = (T.taskType == 'DRun') & (cellfun(@max, T.peakFR1D_track) > criPeak);
DRwTN = (T.taskType == 'DRw') & (cellfun(@max, T.peakFR1D_track) > criPeak);
noRunTN = (T.taskType == 'noRun') & (cellfun(@max, T.peakFR1D_track) > criPeak);
noRwTN = (T.taskType == 'noRw') & (cellfun(@max, T.peakFR1D_track) > criPeak);

% total population (DRunPN / DRunIN / DRwPN / DRwIN)
DRunPN = DRunTN & T.meanFR_task <= criFR;
DRunIN = DRunTN & T.meanFR_task >= criFR;
DRwPN = DRwTN & T.meanFR_task <= criFR;
DRwIN = DRwTN & T.meanFR_task >= criFR;
noRunPN = noRunTN & T.meanFR_task <= criFR;
noRunIN = noRunTN & T.meanFR_task >= criFR;
noRwPN = noRwTN & T.meanFR_task <= criFR;
noRwIN = noRwTN & T.meanFR_task >= criFR;

% Separate light activated inactviated population (rapid act/inactivation)
DRunPNact = DRunPN & (T.pLR_Track<alpha & T.statDir_Track == 1 & T.latencyTrack<=10);
DRunPNina = DRunPN & (T.pLR_Track<alpha & T.statDir_Track == -1 & T.latencyTrack<=10);
DRunINact = DRunIN & (T.pLR_Track<alpha & T.statDir_Track == 1 & T.latencyTrack<=10);
DRunINina = DRunIN & (T.pLR_Track<alpha & T.statDir_Track == -1 & T.latencyTrack<=10);

DRwPNact = DRwPN & (T.pLR_Track<alpha & T.statDir_Track == 1 & T.latencyTrack<=10);
DRwPNina = DRwPN & (T.pLR_Track<alpha & T.statDir_Track == -1 & T.latencyTrack<=10);
DRwINact = DRwIN & (T.pLR_Track<alpha & T.statDir_Track == 1 & T.latencyTrack<=10);
DRwINina = DRwIN & (T.pLR_Track<alpha & T.statDir_Track == -1 & T.latencyTrack<=10);

nDRunPNact = sum(double(DRunPNact));
nDRunPNina = sum(double(DRunPNina));
nDRunINact = sum(double(DRunINact));
nDRunINina = sum(double(DRunINina));

nDRwPNact = sum(double(DRwPNact));
nDRwPNina = sum(double(DRwPNina));
nDRwINact = sum(double(DRwINact));
nDRwINina = sum(double(DRwINina));

% corr of light responsive neurons
corr_DRunPNact = [T.rCorr1D_preXstm(DRunPNact); T.rCorr1D_preXpost(DRunPNact); T.rCorr1D_stmXpost(DRunPNact)];
corr_DRunPNina = [T.rCorr1D_preXstm(DRunPNina); T.rCorr1D_preXpost(DRunPNina); T.rCorr1D_stmXpost(DRunPNina)];
corr_DRunINact = [T.rCorr1D_preXstm(DRunINact); T.rCorr1D_preXpost(DRunINact); T.rCorr1D_stmXpost(DRunINact)];
corr_DRunINina = [T.rCorr1D_preXstm(DRunINina); T.rCorr1D_preXpost(DRunINina); T.rCorr1D_stmXpost(DRunINina)];

corr_DRwPNact = [T.rCorr1D_preXstm(DRwPNact); T.rCorr1D_preXpost(DRwPNact); T.rCorr1D_stmXpost(DRwPNact)];
corr_DRwPNina = [T.rCorr1D_preXstm(DRwPNina); T.rCorr1D_preXpost(DRwPNina); T.rCorr1D_stmXpost(DRwPNina)];
corr_DRwINact = [T.rCorr1D_preXstm(DRwINact); T.rCorr1D_preXpost(DRwINact); T.rCorr1D_stmXpost(DRwINact)];
corr_DRwINina = [T.rCorr1D_preXstm(DRwINina); T.rCorr1D_preXpost(DRwINina); T.rCorr1D_stmXpost(DRwINina)];

xpt_DRunPNact = [ones(nDRunPNact,1);ones(nDRunPNact,1)*2;ones(nDRunPNact,1)*3];
xpt_DRunPNina = [ones(nDRunPNina,1);ones(nDRunPNina,1)*2;ones(nDRunPNina,1)*3];
xpt_DRunINact = [ones(nDRunINact,1);ones(nDRunINact,1)*2;ones(nDRunINact,1)*3];
xpt_DRunINina = [ones(nDRunINina,1);ones(nDRunINina,1)*2;ones(nDRunINina,1)*3];

xpt_DRwPNact = [ones(nDRwPNact,1);ones(nDRwPNact,1)*2;ones(nDRwPNact,1)*3];
xpt_DRwPNina = [ones(nDRwPNina,1);ones(nDRwPNina,1)*2;ones(nDRwPNina,1)*3];
xpt_DRwINact = [ones(nDRwINact,1);ones(nDRwINact,1)*2;ones(nDRwINact,1)*3];
xpt_DRwINina = [ones(nDRwINina,1);ones(nDRwINina,1)*2;ones(nDRwINina,1)*3];

%% plot each example
% folder = 'D:\Dropbox\SNL\P2_Track\rapidResponse\';
% 
% fd_DRunPN = [folder,'DRunPNact'];
% fileName = T.path(DRunPNact);
% cellID = Txls.cellID(DRunPNact);
% plot_Track_multi_v3(fileName, cellID, fd_DRunPN);
% 
% fd_DRunIN = [folder,'DRunPNina'];
% fileName = T.path(DRunPNina);
% cellID = Txls.cellID(DRunPNina);
% plot_Track_multi_v3(fileName, cellID, fd_DRunIN);
% 
% fd_DRwPN = [folder,'DRunINact'];
% fileName = T.path(DRunINact);
% cellID = Txls.cellID(DRunINact);
% plot_Track_multi_v3(fileName, cellID, fd_DRwPN);
% 
% fd_DRwIN = [folder,'DRunINina'];
% fileName = T.path(DRunINina);
% cellID = Txls.cellID(DRunINina);
% plot_Track_multi_v3(fileName, cellID, fd_DRwIN);
% 
% fd_DRunPN = [folder,'DRwPNact'];
% fileName = T.path(DRwPNact);
% cellID = Txls.cellID(DRwPNact);
% plot_Track_multi_v3(fileName, cellID, fd_DRunPN);
% 
% fd_DRunIN = [folder,'DRwPNina'];
% fileName = T.path(DRwPNina);
% cellID = Txls.cellID(DRwPNina);
% plot_Track_multi_v3(fileName, cellID, fd_DRunIN);
% 
% fd_DRwPN = [folder,'DRwINact'];
% fileName = T.path(DRwINact);
% cellID = Txls.cellID(DRwINact);
% plot_Track_multi_v3(fileName, cellID, fd_DRwPN);
% 
% fd_DRwIN = [folder,'DRwINina'];
% fileName = T.path(DRwINina);
% cellID = Txls.cellID(DRwINina);
% plot_Track_multi_v3(fileName, cellID, fd_DRwIN);

%% Plot
nCol = 4;
nRow = 3;

fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{2},'Name','Rapid light responsive population');

hCorr(1) = axes('Position',axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval));
plot([1,2,3],[T.rCorr1D_preXstm(DRunPNact), T.rCorr1D_preXpost(DRunPNact), T.rCorr1D_stmXpost(DRunPNact)],'lineStyle','-','lineWidth',0.5,'color',colorGray);
hold on;
MyScatterBarPlot(corr_DRunPNact,xpt_DRunPNact,0.35,{colorPurple,colorGreen,colorBlue,colorBlack},[]);
title('Stimulation during running zone [light activated PN]','fontSize',fontM,'fontWeight','bold');
text(3.5, 0.5,['n = ',num2str(nDRunPNact)],'fontSize',fontM);

hCorr(2) = axes('Position',axpt(nCol,nRow,1,2,[0.1 0.1 0.85 0.85],wideInterval));
plot([1,2,3],[T.rCorr1D_preXstm(DRunPNina), T.rCorr1D_preXpost(DRunPNina), T.rCorr1D_stmXpost(DRunPNina)],'lineStyle','-','lineWidth',0.5,'color',colorGray);
hold on;
MyScatterBarPlot(corr_DRunPNina,xpt_DRunPNina,0.35,{colorPurple,colorGreen,colorBlue,colorBlack},[]);
title('Stimulation during running zone [light inactivated PN]','fontSize',fontM,'fontWeight','bold');
text(3.5, 0.5,['n = ',num2str(nDRunPNina)],'fontSize',fontM);

hCorr(3) = axes('Position',axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],wideInterval));
plot([1,2,3],[T.rCorr1D_preXstm(DRunINact), T.rCorr1D_preXpost(DRunINact), T.rCorr1D_stmXpost(DRunINact)],'lineStyle','-','lineWidth',0.5,'color',colorGray);
hold on;
MyScatterBarPlot(corr_DRunINact,xpt_DRunINact,0.35,{colorPurple,colorGreen,colorBlue,colorBlack},[]);
title('Stimulation during running zone [light activated IN]','fontSize',fontM,'fontWeight','bold');
text(3.5, 0.5,['n = ',num2str(nDRunINact)],'fontSize',fontM);

hCorr(4) = axes('Position',axpt(nCol,nRow,2,2,[0.1 0.1 0.85 0.85],wideInterval));
plot([1,2,3],[T.rCorr1D_preXstm(DRunINina), T.rCorr1D_preXpost(DRunINina), T.rCorr1D_stmXpost(DRunINina)],'lineStyle','-','lineWidth',0.5,'color',colorGray);
hold on;
MyScatterBarPlot(corr_DRunINina,xpt_DRunINina,0.35,{colorPurple,colorGreen,colorBlue,colorBlack},[]);
title('Stimulation during running zone [light inactivated IN]','fontSize',fontM,'fontWeight','bold');
text(3.5, 0.5,['n = ',num2str(nDRunINina)],'fontSize',fontM);

hCorr(5) = axes('Position',axpt(nCol,nRow,3,1,[0.1 0.1 0.85 0.85],wideInterval));
plot([1,2,3],[T.rCorr1D_preXstm(DRwPNact), T.rCorr1D_preXpost(DRwPNact), T.rCorr1D_stmXpost(DRwPNact)],'lineStyle','-','lineWidth',0.5,'color',colorGray);
hold on;
MyScatterBarPlot(corr_DRwPNact,xpt_DRwPNact,0.35,{colorPurple,colorGreen,colorBlue,colorBlack},[]);
title('Stimulation during reward zone [light activated PN]','fontSize',fontM,'fontWeight','bold');
text(3.5, 0.5,['n = ',num2str(nDRwPNact)],'fontSize',fontM);

hCorr(6) = axes('Position',axpt(nCol,nRow,3,2,[0.1 0.1 0.85 0.85],wideInterval));
plot([1,2,3],[T.rCorr1D_preXstm(DRwPNina), T.rCorr1D_preXpost(DRwPNina), T.rCorr1D_stmXpost(DRwPNina)],'lineStyle','-','lineWidth',0.5,'color',colorGray);
hold on;
MyScatterBarPlot(corr_DRwPNina,xpt_DRwPNina,0.35,{colorPurple,colorGreen,colorBlue,colorBlack},[]);
title('Stimulation during reward zone [light inactivated PN]','fontSize',fontM,'fontWeight','bold');
text(3.5, 0.5,['n = ',num2str(nDRwPNina)],'fontSize',fontM);

hCorr(7) = axes('Position',axpt(nCol,nRow,4,1,[0.1 0.1 0.85 0.85],wideInterval));
plot([1,2,3],[T.rCorr1D_preXstm(DRwINact), T.rCorr1D_preXpost(DRwINact), T.rCorr1D_stmXpost(DRwINact)],'lineStyle','-','lineWidth',0.5,'color',colorGray);
hold on;
MyScatterBarPlot(corr_DRwINact,xpt_DRwINact,0.35,{colorPurple,colorGreen,colorBlue,colorBlack},[]);
title('Stimulation during reward zone [light activated IN]','fontSize',fontM,'fontWeight','bold');
text(3.5, 0.5,['n = ',num2str(nDRwINact)],'fontSize',fontM);

hCorr(8) = axes('Position',axpt(nCol,nRow,4,2,[0.1 0.1 0.85 0.85],wideInterval));
plot([1,2,3],[T.rCorr1D_preXstm(DRwINina), T.rCorr1D_preXpost(DRwINina), T.rCorr1D_stmXpost(DRwINina)],'lineStyle','-','lineWidth',0.5,'color',colorGray);
hold on;
MyScatterBarPlot(corr_DRwINina,xpt_DRwINina,0.35,{colorPurple,colorGreen,colorBlue,colorBlack},[]);
title('Stimulation during reward zone [light inactivated IN]','fontSize',fontM,'fontWeight','bold');
text(3.5, 0.5,['n = ',num2str(nDRunINina)],'fontSize',fontM);

set(hCorr,'TickDir','out','Box','off','XLim',[0.5,3.5],'YLim',[-0.4 1.2],'XTick',[1,2,3],'XTickLabel',{'preXstm','preXpost','stmXpost'},'fontSize',fontM);
print('-painters','-r300','plot_crosscor_rapidAct_peak0.tif','-dtiff');