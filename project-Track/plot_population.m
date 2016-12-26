lineColor = {[144, 164, 174]./255,... % Before stimulation
    [33 150 243]./ 255,... % During stimulation
    [38, 50, 56]./255}; % After stimulation

lineWth = [1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75];
fontS = 4; fontM = 6; fontL = 8; % font size large
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

load('cellList_ori.mat');
DRunTN = T.taskProb == '100' & T.taskType == 'DRun' & T.peakFR_track>1;
DRwTN = T.taskProb == '100' & T.taskType == 'DRw' & T.peakFR_track>1;

nDRunTN = sum(double(DRunTN));
nDRwTN = sum(double(DRwTN));

DRun_meanFR = T.meanFR_task(DRunTN);
DRun_burstIdx = T.burstIdx(DRunTN);
DRun_spkwth = T.spkwth(DRunTN);
DRun_hfvwth = T.hfvwth(DRunTN);
DRun_spkpvr = T.spkpvr(DRunTN);

DRw_meanFR = T.meanFR_task(DRwTN);
DRw_burstIdx = T.burstIdx(DRwTN);
DRw_spkwth = T.spkwth(DRwTN);
DRw_hfvwth = T.hfvwth(DRwTN);
DRw_spkpvr = T.spkpvr(DRwTN);

fHandle = figure('PaperUnits','centimeters','PaperOrientation','portrait');
% ,'PaperPosition',[0 0 16 13.725]
nCol = 5;
nRow = 13;

hText(1) = axes('Position',axpt(nCol,nRow,1:2,1:2,[0.1 0.1 0.85 0.85],midInterval));
text(0,0.5,'DRun Sessions','fontSize',fontL,'fontWeight','bold');

hText(2) = axes('Position',axpt(nCol,nRow,4:5,1:2,[0.1 0.1 0.85 0.85],midInterval));
text(0,0.5,'DRw Sessions','fontSize',fontL,'fontWeight','bold');

set(hText,'visible','off');

hDRun(1) = axes('Position',axpt(nCol,nRow,1:2,2:4,[0.1 0.1 0.85 0.85],midInterval));
scatter(DRun_meanFR,DRun_burstIdx,markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
text(30,0.8,['n = ', num2str((nDRunTN))],'FontSize',fontL);
ylabel('Burst index','fontSize',fontL);
title('meanFR vs. Burst index','fontSize',fontL,'fontWeight','bold');

hDRun(2) = axes('Position',axpt(nCol,nRow,1:2,5:7,[0.1 0.1 0.85 0.85],midInterval));
scatter(DRun_meanFR,DRun_spkwth,markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
ylabel('Spike width (usec)','fontSize',fontL);
title('meanFR vs. Spike width','fontSize',fontL,'fontWeight','bold');

hDRun(3) = axes('Position',axpt(nCol,nRow,1:2,8:10,[0.1 0.1 0.85 0.85],midInterval));
scatter(DRun_meanFR,DRun_hfvwth,markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
ylabel('Half valley width (usec)','fontSize',fontL);
title('meanFR vs. Half valley width','fontSize',fontL,'fontWeight','bold');

hDRun(4) = axes('Position',axpt(nCol,nRow,1:2,11:13,[0.1 0.1 0.85 0.85],midInterval));
scatter(DRun_meanFR,DRun_spkpvr,markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
ylabel('Peak valley ratio','fontSize',fontL);
xlabel('Mean firing rate on track (Hz)','fontSize',fontL);
title('meanFR vs. Peak-valley ratio','fontSize',fontL,'fontWeight','bold');

% align_ylabel(hDRun,0.9);
set(hDRun,'Box','off','TickDir','out','fontSize',fontL);
set(hDRun(1),'YLim',[0, 1]);
set(hDRun(2),'YLim',[0, max(DRun_spkwth)*1.1]);
set(hDRun(3),'YLim',[0, max(DRun_hfvwth)*1.1]);
set(hDRun(4),'YLim',[0, max(DRun_spkpvr)*1.1]);


hDRw(1) = axes('Position',axpt(nCol,nRow,4:5,2:4,[0.1 0.1 0.85 0.85],midInterval));
scatter(DRw_meanFR,DRw_burstIdx,markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
text(30,0.8,['n = ', num2str(nDRwTN)],'FontSize',fontL);
ylabel('Burst index','fontSize',fontL);
title('meanFR vs. Burst index','fontSize',fontL,'fontWeight','bold');

hDRw(2) = axes('Position',axpt(nCol,nRow,4:5,5:7,[0.1 0.1 0.85 0.85],midInterval));
scatter(DRw_meanFR,DRw_spkwth,markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
ylabel('Spike width (usec)','fontSize',fontL);
title('meanFR vs. Spike width','fontSize',fontL,'fontWeight','bold');

hDRw(3) = axes('Position',axpt(nCol,nRow,4:5,8:10,[0.1 0.1 0.85 0.85],midInterval));
scatter(DRw_meanFR,DRw_hfvwth,markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
ylabel('Half valley width (usec)','fontSize',fontL);
title('meanFR vs. Half valley width','fontSize',fontL,'fontWeight','bold');

hDRw(4) = axes('Position',axpt(nCol,nRow,4:5,11:13,[0.1 0.1 0.85 0.85],midInterval));
scatter(DRw_meanFR,DRw_spkpvr,markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
ylabel('Peak valley ratio','fontSize',fontL);
xlabel('Mean firing rate on track (Hz)','fontSize',fontL);
title('meanFR vs. Peak-valley ratio','fontSize',fontL,'fontWeight','bold');

% align_ylabel(hDRw,0.9);
set(hDRw,'Box','off','TickDir','out','fontSize',fontL);
set(hDRw(1),'YLim',[0, 1]);
set(hDRw(2),'YLim',[0, max(DRun_spkwth)*1.1]);
set(hDRw(3),'YLim',[0, max(DRun_hfvwth)*1.1]);
set(hDRw(4),'YLim',[0, max(DRun_spkpvr)*1.1]);

print(gcf,'-painters','-r300','plot_populDiscri.tiff','-dtiff');
close;