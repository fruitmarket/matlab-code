% Latency of neurons which are activated on the platform. (Blue)
% Among neurons which are activated on the platform, latency of neurons which are also activated on the track

% common part
clearvars;
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
Txls = readtable('neuronList_19-Mar-2017.xlsx');
load('neuronList_ori_19-Mar-2017.mat');

cri_meanFR = 7;
cri_peakFR = 0;
alpha = 0.01;

% TN: track neuron
DRunTN = (T.taskType == 'DRun') & (cellfun(@max, T.peakFR1D_track) > cri_peakFR);
DRwTN = (T.taskType == 'DRw') & (cellfun(@max, T.peakFR1D_track) > cri_peakFR);
noRunTN = (T.taskType == 'noRun') & (cellfun(@max, T.peakFR1D_track) > cri_peakFR);
noRwTN = (T.taskType == 'noRw') & (cellfun(@max, T.peakFR1D_track) > cri_peakFR);

% total population (DRunPN / DRunIN / DRwPN / DRwIN) with light responsiveness (light activated)
DRunPN = DRunTN & T.meanFR_task <= cri_meanFR & T.pLR_Track<alpha & T.statDir_Track == 1;
DRunIN = DRunTN & T.meanFR_task > cri_meanFR & T.pLR_Track<alpha & T.statDir_Track == 1;

DRwPN = DRwTN & T.meanFR_task <= cri_meanFR & T.pLR_Track<alpha & T.statDir_Track == 1;
DRwIN = DRwTN & T.meanFR_task > cri_meanFR & T.pLR_Track<alpha & T.statDir_Track == 1;

noRunPN = noRunTN & T.meanFR_task <= cri_meanFR & T.pLR_Track<alpha & T.statDir_Track == 1;
noRunIN = noRunTN & T.meanFR_task > cri_meanFR & T.pLR_Track<alpha & T.statDir_Track == 1;

noRwPN = noRwTN & T.meanFR_task <= cri_meanFR & T.pLR_Track<alpha & T.statDir_Track == 1;
noRwIN = noRwTN & T.meanFR_task > cri_meanFR & T.pLR_Track<alpha & T.statDir_Track == 1;

% Latency on platform
lat_DRunPN = T.latencyPlfm2hz(DRunPN);
lat_DRunIN = T.latencyPlfm2hz(DRunIN);

lat_DRwPN = T.latencyPlfm2hz(DRwPN);
lat_DRwIN = T.latencyPlfm2hz(DRwIN);

lat_noRunPN = T.latencyPlfm2hz(noRunPN);
lat_noRunIN = T.latencyPlfm2hz(noRunIN);

lat_noRwPN = T.latencyPlfm2hz(noRwPN);
lat_noRwIN = T.latencyPlfm2hz(noRwIN);

% same neurons but latency on track
latTrack_DRunPN = T.latencyTrack(DRunPN & T.pLR_Plfm2hz<alpha & T.statDir_Plfm2hz==1);
latTrack_DRunIN = T.latencyTrack(DRunIN & T.pLR_Plfm2hz<alpha & T.statDir_Plfm2hz==1);

latTrack_DRwPN = T.latencyTrack(DRwPN & T.pLR_Plfm2hz<alpha & T.statDir_Plfm2hz==1);
latTrack_DRwIN = T.latencyTrack(DRwIN & T.pLR_Plfm2hz<alpha & T.statDir_Plfm2hz==1);

latTrack_noRunPN = T.latencyTrack(noRunPN & T.pLR_Plfm2hz<alpha & T.statDir_Plfm2hz==1);
latTrack_noRunIN = T.latencyTrack(noRunIN & T.pLR_Plfm2hz<alpha & T.statDir_Plfm2hz==1);

latTrack_noRwPN = T.latencyTrack(noRwPN & T.pLR_Plfm2hz<alpha & T.statDir_Plfm2hz==1);
latTrack_noRwIN = T.latencyTrack(noRwIN & T.pLR_Plfm2hz<alpha & T.statDir_Plfm2hz==1);

%% plot
nCol = 2;
nRow = 4;
fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1},'Name','Latency on Platform');
xpt = 1:2:31;

hLat(1) = axes('Position',axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval));
bar(xpt,histc(lat_DRunPN,0:2:30),1,'FaceColor',colorBlue);
hold on;
bar(xpt,histc(latTrack_DRunPN,0:2:30),0.7,'FaceColor',colorRed);
text(20,6,['On Track (n = ',num2str(length(lat_DRunPN)),')'],'fontSize',fontL,'Color',colorBlue);
text(20,4,['On Platform (n = ',num2str(length(latTrack_DRunPN)),')'],'fontSize',fontL,'Color',colorRed);
title('PN & DRun','fontSize',fontL,'fontWeight','bold');
xlabel('Latency from light onset (ms)','fontSize',fontL);

hLat(2) = axes('Position',axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],wideInterval));
bar(xpt,histc(lat_DRunIN,0:2:30),1,'FaceColor',colorBlue);
hold on;
bar(xpt,histc(latTrack_DRunIN,0:2:30),0.7,'FaceColor',colorRed);
text(20,6,['On Track (n = ',num2str(length(lat_DRunIN)),')'],'fontSize',fontL,'Color',colorBlue);
text(20,4,['On Platform: (n = ',num2str(length(latTrack_DRunIN)),')'],'fontSize',fontL,'Color',colorRed);
title('IN & DRun','fontSize',fontL,'fontWeight','bold');
xlabel('Latency from light onset (ms)','fontSize',fontL);

hLat(3) = axes('Position',axpt(nCol,nRow,1,2,[0.1 0.1 0.85 0.85],wideInterval));
bar(xpt,histc(lat_DRwPN,0:2:30),1,'FaceColor',colorBlue);
hold on;
bar(xpt,histc(latTrack_DRwPN,0:2:30),0.7,'FaceColor',colorRed);
text(20,6,['On Track (n = ',num2str(length(lat_DRwPN)),')'],'fontSize',fontL,'Color',colorBlue);
text(20,4,['On Platform (n = ',num2str(length(latTrack_DRwPN)),')'],'fontSize',fontL,'Color',colorRed);
title('PN & DRw','fontSize',fontL,'fontWeight','bold');
xlabel('Latency from light onset (ms)','fontSize',fontL);

hLat(4) = axes('Position',axpt(nCol,nRow,2,2,[0.1 0.1 0.85 0.85],wideInterval));
bar(xpt,histc(lat_DRwIN,0:2:30),1,'FaceColor',colorBlue);
hold on;
bar(xpt,histc(latTrack_DRwIN,0:2:30),0.7,'FaceColor',colorRed);
text(20,6,['On Track (n = ',num2str(length(lat_DRwIN)),')'],'fontSize',fontL,'Color',colorBlue);
text(20,4,['On Platform (n = ',num2str(length(latTrack_DRwIN)),')'],'fontSize',fontL,'Color',colorRed);
title('IN & DRw','fontSize',fontL,'fontWeight','bold');
xlabel('Latency from light onset (ms)','fontSize',fontL);

set(hLat,'Box','off','TickDir','out','XLim',[0,30],'XTick',[0:4:30],'YLim',[0,8]);
print('-painters','-r300','plot_latencySession_track.tif','-dtiff');

%% collect examples
% folder = 'D:\Dropbox\SNL\P2_Track\latency_track\';
% 
% fd_DRunPN = [folder,'DRunPN'];
% fileName = T.path(DRunPN);
% cellID = Txls.cellID(DRunPN);
% plot_Track_multi_v3(fileName, cellID, fd_DRunPN);
% 
% fd_DRunIN = [folder,'DRunIN'];
% fileName = T.path(DRunIN);
% cellID = Txls.cellID(DRunIN);
% plot_Track_multi_v3(fileName, cellID, fd_DRunIN);
% 
% fd_DRwPN = [folder,'DRwPN'];
% fileName = T.path(DRwPN);
% cellID = Txls.cellID(DRwPN);
% plot_Track_multi_v3(fileName, cellID, fd_DRwPN);
% 
% fd_DRwIN = [folder,'DRwIN'];
% fileName = T.path(DRwIN);
% cellID = Txls.cellID(DRwIN);
% plot_Track_multi_v3(fileName, cellID, fd_DRwIN);
% 
% cd('D:\Dropbox\SNL\P2_Track');
% disp('### Done! :) ###');