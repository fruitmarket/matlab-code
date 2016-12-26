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

markerS = 4; markerM = 6; markerL = 8; markerXL = 12*2;
tightInterval = [0.02 0.02]; midInterval = [0.09, 0.09]; wideInterval = [0.14 0.14];
width = 0.7;

criteria_FR = 7;
rtDir = 'D:\Dropbox\#team_hippocampus Team Folder\project_Track';

load('cellList_ori2.mat');

DRunPn = T.taskProb == '100' & T.taskType == 'DRun' & T.peakFR_track>1 & T.meanFR_task<criteria_FR;
DRunIn = T.taskProb == '100' & T.taskType == 'DRun' & T.peakFR_track>1 & T.meanFR_task>criteria_FR;
DRwPn = T.taskProb == '100' & T.taskType == 'DRw' & T.peakFR_track>1 & T.meanFR_task<criteria_FR;
DRwIn = T.taskProb == '100' & T.taskType == 'DRw' & T.peakFR_track>1 & T.meanFR_task>criteria_FR;

plfmLight = T.statDir_Plfm2hz ~= 0 & T.pLR_Plfm2hz<0.005;
trackLight = T.statDir_Track ~= 0 & T.pLR_Track<0.005;

DRunPn_none = DRunPn & ~(plfmLight | trackLight);
DRunPn_either = DRunPn & (plfmLight | trackLight);
DRunPn_both = DRunPn & (plfmLight & trackLight);

DRunIn_none = DRunIn & ~(plfmLight | trackLight);
DRunIn_either = DRunIn & (plfmLight | trackLight);
DRunIn_both = DRunIn & (plfmLight & trackLight);

DRwPn_none = DRwPn & ~(plfmLight | trackLight);
DRwPn_either = DRwPn & (plfmLight | trackLight);
DRwPn_both = DRwPn & (plfmLight & trackLight);

DRwIn_none = DRwIn & ~(plfmLight | trackLight);
DRwIn_either = DRwIn & (plfmLight | trackLight);
DRwIn_both = DRwIn & (plfmLight & trackLight);

[sensorMeanFR_DRunPreStm, sensorMeanFR_DRwPreStm] = deal(zeros(30,1));

nCell = size(T,1);
for iCell = 1:nCell
    sensorMeanFR_DRunPreStm(iCell,1) = mean(T.sensorMeanFR_DRun{iCell}(1:30));
    sensorMeanFR_DRunPreStm(iCell,2) = mean(T.sensorMeanFR_DRun{iCell}(31:60));

    sensorMeanFR_DRwPreStm(iCell,1) = mean(T.sensorMeanFR_DRw{iCell}(1:30));
    sensorMeanFR_DRwPreStm(iCell,2) = mean(T.sensorMeanFR_DRw{iCell}(31:60));
end

sensorMFR_DRunPn_none = sensorMeanFR_DRunPreStm(DRunPn_none,:);
sensorMFR_DRunPn_either = sensorMeanFR_DRunPreStm(DRunPn_either,:);
sensorMFR_DRunPn_both = sensorMeanFR_DRunPreStm(DRunPn_both,:);

sensorMFR_DRunIn_none = sensorMeanFR_DRunPreStm(DRunIn_none,:);
sensorMFR_DRunIn_either = sensorMeanFR_DRunPreStm(DRunIn_either,:);
sensorMFR_DRunIn_both = sensorMeanFR_DRunPreStm(DRunIn_both,:);

sensorMFR_DRwPn_none = sensorMeanFR_DRwPreStm(DRwPn_none,:);
sensorMFR_DRwPn_either = sensorMeanFR_DRwPreStm(DRwPn_either,:);
sensorMFR_DRwPn_both = sensorMeanFR_DRwPreStm(DRwPn_both,:);

sensorMFR_DRwIn_none = sensorMeanFR_DRwPreStm(DRwIn_none,:);
sensorMFR_DRwIn_either = sensorMeanFR_DRwPreStm(DRwIn_either,:);
sensorMFR_DRwIn_both = sensorMeanFR_DRwPreStm(DRwIn_both,:);

nCol = 2;
nRow = 2;

lim = [25, 55, 20, 35];

hScatter(1) = axes('Position',axpt(nCol,nRow,1,1,[0.1 0.1 0.80 0.80],wideInterval));
scatter(sensorMFR_DRunPn_none(:,1),sensorMFR_DRunPn_none(:,2),markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
hold on;
scatter(sensorMFR_DRunPn_either(:,1),sensorMFR_DRunPn_either(:,2),markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorBlue);
hold on;
scatter(sensorMFR_DRunPn_both(:,1),sensorMFR_DRunPn_both(:,2),markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorRed);
text(20,23,['Grey (none): n = ',num2str(size(sensorMFR_DRunPn_none,1))],'fontSize',fontL);
text(20,21,['Blue (either): n = ',num2str(size(sensorMFR_DRunPn_either,1))],'fontSize',fontL);
text(20,19,['Red (both): n = ',num2str(size(sensorMFR_DRunPn_both,1))],'fontSize',fontL);
xlabel('Mean FR (Pre)','fontSize',fontL);
ylabel('Mean FR (Stm)','fontSize',fontL);
title('mean FR btw S6-S9, PN','fontSize',fontL);

hScatter(2) = axes('Position',axpt(nCol,nRow,1,2,[0.1 0.1 0.80 0.80],wideInterval));
scatter(sensorMFR_DRunIn_none(:,1),sensorMFR_DRunIn_none(:,2),markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
hold on;
scatter(sensorMFR_DRunIn_either(:,1),sensorMFR_DRunIn_either(:,2),markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorBlue);
hold on;
scatter(sensorMFR_DRunIn_both(:,1),sensorMFR_DRunIn_both(:,2),markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorRed);
text(40,21,['Grey (none): n = ',num2str(size(sensorMFR_DRunIn_none,1))],'fontSize',fontL);
text(40,19,['Blue (either): n = ',num2str(size(sensorMFR_DRunIn_either,1))],'fontSize',fontL);
text(40,17,['Red (both): n = ',num2str(size(sensorMFR_DRunIn_both,1))],'fontSize',fontL);
xlabel('Mean FR (Pre)','fontSize',fontL);
ylabel('Mean FR (Stm)','fontSize',fontL);
title('mean FR btw S6-S9, IN','fontSize',fontL);

hScatter(3) = axes('Position',axpt(nCol,nRow,2,1,[0.1 0.1 0.80 0.80],wideInterval));
scatter(sensorMFR_DRwPn_none(:,1),sensorMFR_DRwPn_none(:,2),markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
hold on;
scatter(sensorMFR_DRwPn_either(:,1),sensorMFR_DRwPn_either(:,2),markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorBlue);
hold on;
scatter(sensorMFR_DRwPn_both(:,1),sensorMFR_DRwPn_both(:,2),markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorRed);
text(15,19,['Grey (none): n = ',num2str(size(sensorMFR_DRwPn_none,1))],'fontSize',fontL);
text(15,17,['Blue (either): n = ',num2str(size(sensorMFR_DRwPn_either,1))],'fontSize',fontL);
text(15,15,['Red (both): n = ',num2str(size(sensorMFR_DRwPn_both,1))],'fontSize',fontL);
xlabel('Mean FR (Pre)','fontSize',fontL);
ylabel('Mean FR (Stm)','fontSize',fontL);
title('mean FR btw S10-S11, PN','fontSize',fontL);

hScatter(4) = axes('Position',axpt(nCol,nRow,2,2,[0.1 0.1 0.80 0.80],wideInterval));
scatter(sensorMFR_DRwIn_none(:,1),sensorMFR_DRwIn_none(:,2),markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
hold on;
scatter(sensorMFR_DRwIn_either(:,1),sensorMFR_DRwIn_either(:,2),markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorBlue);
hold on;
scatter(sensorMFR_DRwIn_both(:,1),sensorMFR_DRwIn_both(:,2),markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorRed);
text(25,15,['Grey (none): n = ',num2str(size(sensorMFR_DRwIn_none,1))],'fontSize',fontL);
text(25,13,['Blue (either): n = ',num2str(size(sensorMFR_DRwIn_either,1))],'fontSize',fontL);
text(25,11,['Red (both): n = ',num2str(size(sensorMFR_DRwIn_both,1))],'fontSize',fontL);
xlabel('Mean FR (Pre)','fontSize',fontL);
ylabel('Mean FR (Stm)','fontSize',fontL);
title('mean FR btw S10-S11, IN','fontSize',fontL);

set(hScatter(1),'XLim',[-1,lim(1)],'YLim',[-1,lim(1)]);
set(hScatter(2),'XLim',[-1,lim(2)],'YLim',[-1,lim(2)]);
set(hScatter(3),'XLim',[-1,lim(3)],'YLim',[-1,lim(3)]);
set(hScatter(4),'XLim',[-1,lim(4)],'YLim',[-1,lim(4)]);
set(hScatter,'Box','off','TickDir','out','XTick',[0:5:55],'YTick',[0:5:55],'fontSize',fontL);

print(gcf,'-painters','-r300','plot_evokedPattern.tiff','-dtiff');