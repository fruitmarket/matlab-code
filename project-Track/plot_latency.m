lineColor = {[144, 164, 174]./255,... % Before stimulation
    [33 150 243]./ 255,... % During stimulation
    [38, 50, 56]./255}; % After stimulation

lineWth = [1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75];
fontS = 4; fontM = 5; fontL = 7; % font size large
lineS = 0.2; lineM = 0.5; lineL = 1; % line width large

colorBlue = [33 150 243] ./ 255;
colorLightBlue = [100 181 246] ./ 255;
colorLLightBlue = [187, 222, 251]./255;
colorRed = [237 50 52] ./ 255;
colorLightRed = [242 138 130] ./ 255;
colorGray = [189 189 189] ./ 255;
colorLightGray = [238, 238, 238] ./255;
colorDarkGray = [117, 117, 117] ./255;
colorYellow = [255 243 3] ./ 255;
colorLightYellow = [255 249 196] ./ 255;
colorBlack = [0, 0, 0];

markerS = 2.2; markerM = 4.4; markerL = 6.6; markerXL = 8.8;
tightInterval = [0.02 0.02]; midInterval = [0.09, 0.09]; wideInterval = [0.14 0.14];
width = 0.7;

criteria_FR = 7;

load('cellList_ori.mat');

DRunPn = T.taskProb == '100' & T.taskType == 'DRun' & T.peakFR_track>1 & T.meanFR_task<criteria_FR;
DRunIn = T.taskProb == '100' & T.taskType == 'DRun' & T.peakFR_track>1 & T.meanFR_task>criteria_FR;
DRwPn = T.taskProb == '100' & T.taskType == 'DRw' & T.peakFR_track>1 & T.meanFR_task<criteria_FR;
DRwIn = T.taskProb == '100' & T.taskType == 'DRw' & T.peakFR_track>1 & T.meanFR_task>criteria_FR;

DRunPn_both = DRunPn & ((T.statDir_Plfm2hz==1 & T.pLR_Plfm2hz<0.005) & (T.statDir_Track==1 & T.pLR_Track<0.005));
DRunIn_both = DRunIn & ((T.statDir_Plfm2hz==1 & T.pLR_Plfm2hz<0.005) & (T.statDir_Track==1 & T.pLR_Track<0.005));

DRwPn_both = DRwPn & ((T.statDir_Plfm2hz==1 & T.pLR_Plfm2hz<0.005) & (T.statDir_Track==1 & T.pLR_Track<0.005));
DRwIn_both = DRwIn & ((T.statDir_Plfm2hz==1 & T.pLR_Plfm2hz<0.005) & (T.statDir_Track==1 & T.pLR_Track<0.005));

DRunPn_latency_Plfm2hz = nonzeros(T.latencyPlfm2hz(DRunPn & T.statDir_Plfm2hz==1));
DRunPn_latency_Plfm2hz_both = T.latencyPlfm2hz(DRunPn_both);

DRunPn_latency_Track = nonzeros(T.latencyTrack(DRunPn & T.statDir_Track==1));
DRunPn_latency_Track_both = T.latencyTrack(DRunPn_both);

DRunIn_latency_Plfm2hz = nonzeros(T.latencyPlfm2hz(DRunIn & T.statDir_Plfm2hz==1));
DRunIn_latency_Plfm2hz_both = T.latencyPlfm2hz(DRunIn_both);

DRunIn_latency_Track = T.latencyTrack(DRunIn & T.statDir_Track==1);
DRunIn_latency_Track_both = T.latencyTrack(DRunIn_both);


DRwPn_latency_Plfm2hz = nonzeros(T.latencyPlfm2hz(DRwPn & T.statDir_Plfm2hz==1 & T.pLR_Plfm2hz<0.005));
DRwPn_latency_Plfm2hz_both = T.latencyPlfm2hz(DRwPn_both);

DRwPn_latency_Track = nonzeros(T.latencyTrack(DRwPn & T.statDir_Track==1 & T.pLR_Track<0.005));
DRwPn_latency_Track_both = T.latencyTrack(DRwPn_both);

DRwIn_latency_Plfm2hz = nonzeros(T.latencyPlfm2hz(DRwIn & T.statDir_Plfm2hz==1 & T.pLR_Plfm2hz<0.005));
DRwIn_latency_Plfm2hz_both = T.latencyPlfm2hz(DRwIn_both);

DRwIn_latency_Track = nonzeros(T.latencyTrack(DRwIn & T.statDir_Track==1 & T.pLR_Track<0.005));
DRwIn_latency_Track_both = T.latencyTrack(DRwIn_both);


nCol = 9;
nRow = 6;
hText(1) = axes('Position',axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval));
text(0,0,'DRun sessions','fontSize',fontL,'fontWeight','bold');

hText(2) = axes('Position',axpt(nCol,nRow,6,1,[0.1 0.1 0.85 0.85],midInterval));
text(0,0,'DRw sessions','fontSize',fontL,'fontWeight','bold');
set(hText,'visible','off','Box','off');

hBar(1) = axes('Position',axpt(nCol,nRow,1:2,2:3,[0.1 0.1 0.85, 0.85],midInterval));
bar(1:2:31,histc(DRunPn_latency_Plfm2hz,0:2:30),1,'FaceColor',colorBlue);
hold on;
bar(1:2:31,histc(DRunPn_latency_Plfm2hz_both,0:2:30),1,'FaceColor',colorRed);
title('PN & Plfm','fontSize',fontL);

hBar(2) = axes('Position',axpt(nCol,nRow,3:4,2:3,[0.1 0.1 0.85, 0.85],midInterval));
bar(1:2:31,histc(DRunPn_latency_Track,0:2:30),1,'FaceColor',colorBlue);
hold on;
bar(1:2:31,histc(DRunPn_latency_Track_both,0:2:30),1,'FaceColor',colorRed);
title('PN & Track','fontSize',fontL);

hBar(3) = axes('Position',axpt(nCol,nRow,1:2,5:6,[0.1 0.1 0.85, 0.85],midInterval));
bar(1:2:31,histc(DRunIn_latency_Plfm2hz,0:2:30),1,'FaceColor',colorBlue);
hold on;
bar(1:2:31,histc(DRunIn_latency_Plfm2hz_both,0:2:30),1,'FaceColor',colorRed);
title('IN & Plfm','fontSize',fontL);

hBar(4) = axes('Position',axpt(nCol,nRow,3:4,5:6,[0.1 0.1 0.85, 0.85],midInterval));
bar(1:2:31,histc(DRunIn_latency_Track,0:2:30),1,'FaceColor',colorBlue);
hold on;
bar(1:2:31,histc(DRunIn_latency_Track_both,0:2:30),1,'FaceColor',colorRed);
title('IN & Track','fontSize',fontL);

hBar(5) = axes('Position',axpt(nCol,nRow,6:7,2:3,[0.1 0.1 0.85, 0.85],midInterval));
bar(1:2:31,histc(DRwPn_latency_Plfm2hz,0:2:30),1,'FaceColor',colorBlue);
hold on;
bar(1:2:31,histc(DRwPn_latency_Plfm2hz_both,0:2:30),1,'FaceColor',colorRed);
title('PN & Plfm','fontSize',fontL);

hBar(6) = axes('Position',axpt(nCol,nRow,8:9,2:3,[0.1 0.1 0.85, 0.85],midInterval));
bar(1:2:31,histc(DRwPn_latency_Track,0:2:30),1,'FaceColor',colorBlue);
hold on;
bar(1:2:31,histc(DRwPn_latency_Track_both,0:2:30),1,'FaceColor',colorRed);
title('PN & Track','fontSize',fontL);

hBar(7) = axes('Position',axpt(nCol,nRow,6:7,5:6,[0.1 0.1 0.85, 0.85],midInterval));
bar(1:2:31,histc(DRwIn_latency_Plfm2hz,0:2:30),1,'FaceColor',colorBlue);
hold on;
bar(1:2:31,histc(DRwIn_latency_Plfm2hz_both,0:2:30),1,'FaceColor',colorRed);
title('IN & Plfm','fontSize',fontL);

hBar(8) = axes('Position',axpt(nCol,nRow,8:9,5:6,[0.1 0.1 0.85, 0.85],midInterval));
bar(1:2:31,histc(DRwIn_latency_Track,0:2:30),1,'FaceColor',colorBlue);
hold on;
bar(1:2:31,histc(DRwIn_latency_Track_both,0:2:30),1,'FaceColor',colorRed);
title('IN & Track','fontSize',fontL);

set(hBar,'Box','off','TickDir','out','YLim',[0,10],'XLim',[-2,24],'XTick',[0:4:24],'fontSize',fontM);

print(gcf,'-painters','-r300','plot_latency.tiff','-dtiff');
close;


