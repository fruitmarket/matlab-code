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
load('cellList_ori.mat');

DRunPn = T.taskProb == '100' & T.taskType == 'DRun' & T.peakFR_track>1 & T.meanFR_task<criteria_FR;
DRunIn = T.taskProb == '100' & T.taskType == 'DRun' & T.peakFR_track>1 & T.meanFR_task>criteria_FR;
DRwPn = T.taskProb == '100' & T.taskType == 'DRw' & T.peakFR_track>1 & T.meanFR_task<criteria_FR;
DRwIn = T.taskProb == '100' & T.taskType == 'DRw' & T.peakFR_track>1 & T.meanFR_task>criteria_FR;

plfmLight = T.statDir_Plfm2hz ~= 0 & T.pLR_Plfm2hz<0.005;
trackLight = T.statDir_Track ~= 0 & T.pLR_Track<0.005;

% plfmLight = T.statDir_Plfm2hz == 1 & T.pLR_Plfm2hz<0.005;
% trackLight = T.statDir_Track == 1 & T.pLR_Track<0.005;

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

%% Mean Std calculation
mean_sensorMFR_DRunPn_none = mean(sensorMFR_DRunPn_none);
mean_sensorMFR_DRunPn_either = mean(sensorMFR_DRunPn_either);
mean_sensorMFR_DRunPn_both = mean(sensorMFR_DRunPn_both);

mean_sensorMFR_DRunIn_none = mean(sensorMFR_DRunIn_none);
mean_sensorMFR_DRunIn_either = mean(sensorMFR_DRunIn_either);
mean_sensorMFR_DRunIn_both = mean(sensorMFR_DRunIn_both);

mean_sensorMFR_DRwPn_none = mean(sensorMFR_DRwPn_none);
mean_sensorMFR_DRwPn_either = mean(sensorMFR_DRwPn_either);
mean_sensorMFR_DRwPn_both = mean(sensorMFR_DRwPn_both);

mean_sensorMFR_DRwIn_none = mean(sensorMFR_DRwIn_none);
mean_sensorMFR_DRwIn_either = mean(sensorMFR_DRwIn_either);
mean_sensorMFR_DRwIn_both = mean(sensorMFR_DRwIn_both);

std_sensorMFR_DRunPn_none = std(sensorMFR_DRunPn_none);
std_sensorMFR_DRunPn_either = std(sensorMFR_DRunPn_either);
std_sensorMFR_DRunPn_both = std(sensorMFR_DRunPn_both);

std_sensorMFR_DRunIn_none = std(sensorMFR_DRunIn_none);
std_sensorMFR_DRunIn_either = std(sensorMFR_DRunIn_either);
std_sensorMFR_DRunIn_both = std(sensorMFR_DRunIn_both);

std_sensorMFR_DRwPn_none = std(sensorMFR_DRwPn_none);
std_sensorMFR_DRwPn_either = std(sensorMFR_DRwPn_either);
std_sensorMFR_DRwPn_both = std(sensorMFR_DRwPn_both);

std_sensorMFR_DRwIn_none = std(sensorMFR_DRwIn_none);
std_sensorMFR_DRwIn_either = std(sensorMFR_DRwIn_either);
std_sensorMFR_DRwIn_both = std(sensorMFR_DRwIn_both);

nCol = 8;
nRow = 8;

%% Plot scatter
fHandle = figure('PaperUnits','centimeters','PaperPosition',[0 0 18 18]);
hScatter(1) = axes('Position',axpt(nCol,nRow,1:2,2:3,[0.05 0.05 0.85 0.85],wideInterval));
scatter(sensorMFR_DRunPn_none(:,1),sensorMFR_DRunPn_none(:,2),markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
hold on;
scatter(sensorMFR_DRunPn_either(:,1),sensorMFR_DRunPn_either(:,2),markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorBlue);
hold on;
scatter(sensorMFR_DRunPn_both(:,1),sensorMFR_DRunPn_both(:,2),markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorRed);
text(20,20,['Grey (none): n = ',num2str(size(sensorMFR_DRunPn_none,1))],'fontSize',fontL);
text(20,15,['Blue (either): n = ',num2str(size(sensorMFR_DRunPn_either,1))],'fontSize',fontL);
text(20,10,['Red (both): n = ',num2str(size(sensorMFR_DRunPn_both,1))],'fontSize',fontL);
xlabel('Mean FR (Pre)','fontSize',fontL);
ylabel('Mean FR (Stm)','fontSize',fontL);
title('mean FR btw S6-S9, PN','fontSize',fontL,'fontWeight','bold');

hScatter(2) = axes('Position',axpt(nCol,nRow,1:2,4:5,[0.05 0.05 0.85 0.85],wideInterval));
scatter(sensorMFR_DRunIn_none(:,1),sensorMFR_DRunIn_none(:,2),markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
hold on;
scatter(sensorMFR_DRunIn_either(:,1),sensorMFR_DRunIn_either(:,2),markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorBlue);
hold on;
scatter(sensorMFR_DRunIn_both(:,1),sensorMFR_DRunIn_both(:,2),markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorRed);
text(55,50,['Grey (none): n = ',num2str(size(sensorMFR_DRunIn_none,1))],'fontSize',fontL);
text(55,40,['Blue (either): n = ',num2str(size(sensorMFR_DRunIn_either,1))],'fontSize',fontL);
text(55,30,['Red (both): n = ',num2str(size(sensorMFR_DRunIn_both,1))],'fontSize',fontL);
xlabel('Mean FR (Pre)','fontSize',fontL);
ylabel('Mean FR (Stm)','fontSize',fontL);
title('mean FR btw S6-S9, IN','fontSize',fontL,'fontWeight','bold');

hScatter(3) = axes('Position',axpt(nCol,nRow,5:6,2:3,[0.05 0.05 0.85 0.85],wideInterval));
scatter(sensorMFR_DRwPn_none(:,1),sensorMFR_DRwPn_none(:,2),markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
hold on;
scatter(sensorMFR_DRwPn_either(:,1),sensorMFR_DRwPn_either(:,2),markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorBlue);
hold on;
scatter(sensorMFR_DRwPn_both(:,1),sensorMFR_DRwPn_both(:,2),markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorRed);
text(20,20,['Grey (none): n = ',num2str(size(sensorMFR_DRwPn_none,1))],'fontSize',fontL);
text(20,15,['Blue (either): n = ',num2str(size(sensorMFR_DRwPn_either,1))],'fontSize',fontL);
text(20,10,['Red (both): n = ',num2str(size(sensorMFR_DRwPn_both,1))],'fontSize',fontL);
xlabel('Mean FR (Pre)','fontSize',fontL);
ylabel('Mean FR (Stm)','fontSize',fontL);
title('mean FR btw S10-S11, PN','fontSize',fontL,'fontWeight','bold');

hScatter(4) = axes('Position',axpt(nCol,nRow,5:6,4:5,[0.05 0.05 0.85 0.85],wideInterval));
scatter(sensorMFR_DRwIn_none(:,1),sensorMFR_DRwIn_none(:,2),markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
hold on;
scatter(sensorMFR_DRwIn_either(:,1),sensorMFR_DRwIn_either(:,2),markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorBlue);
hold on;
scatter(sensorMFR_DRwIn_both(:,1),sensorMFR_DRwIn_both(:,2),markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorRed);
text(35,30,['Grey (none): n = ',num2str(size(sensorMFR_DRwIn_none,1))],'fontSize',fontL);
text(35,25,['Blue (either): n = ',num2str(size(sensorMFR_DRwIn_either,1))],'fontSize',fontL);
text(35,20,['Red (both): n = ',num2str(size(sensorMFR_DRwIn_both,1))],'fontSize',fontL);
xlabel('Mean FR (Pre)','fontSize',fontL);
ylabel('Mean FR (Stm)','fontSize',fontL);
title('mean FR btw S10-S11, IN','fontSize',fontL,'fontWeight','bold');

set(hScatter(1),'XLim',[-1,25],'YLim',[-1,25]);
set(hScatter(2),'XLim',[-1,55],'YLim',[-1,55]);
set(hScatter(3),'XLim',[-1,25],'YLim',[-1,25]);
set(hScatter(4),'XLim',[-1,35],'YLim',[-1,35]);
set(hScatter,'Box','off','TickDir','out','XTick',[0:10:55],'YTick',[0:10:55],'fontSize',fontL);

%% Plot line
hPlot(1) = axes('Position',axpt(nCol,nRow,3:4,2:3,[0.1 0.05 0.85 0.85],wideInterval));
errorbar([1,2],mean_sensorMFR_DRunPn_none,std_sensorMFR_DRunPn_none/sqrt(size(sensorMFR_DRunPn_none,1)),'Color',colorBlack)
hold on;
errorbar([4,5],mean_sensorMFR_DRunPn_either,std_sensorMFR_DRunPn_either/sqrt(size(sensorMFR_DRunPn_either,1)),'Color',colorBlack)
hold on;
errorbar([7,8],mean_sensorMFR_DRunPn_both,std_sensorMFR_DRunPn_both/sqrt(size(sensorMFR_DRunPn_both,1)),'Color',colorBlack)
hold on;
plot([1,2],mean_sensorMFR_DRunPn_none,'-o','Color',colorBlack,'MarkerFaceColor',colorGray,'MarkerEdgeColor',colorBlack,'markerSize',markerS);
hold on;
plot([4,5],mean_sensorMFR_DRunPn_either,'-o','Color',colorBlack,'MarkerFaceColor',colorBlue,'MarkerEdgeColor',colorBlack,'markerSize',markerS);
hold on;
plot([7,8],mean_sensorMFR_DRunPn_both,'-o','Color',colorBlack,'MarkerFaceColor',colorRed,'MarkerEdgeColor',colorBlack,'markerSize',markerS);
ylabel('Firing rate (Hz)','fontSize',fontL);

hPlot(2) = axes('Position',axpt(nCol,nRow,3:4,4:5,[0.1 0.05 0.85 0.85],wideInterval));
errorbar([4,5],mean_sensorMFR_DRunIn_either,std_sensorMFR_DRunIn_either/sqrt(size(sensorMFR_DRunIn_either,1)),'Color',colorBlack)
hold on;
errorbar([7,8],mean_sensorMFR_DRunIn_both,std_sensorMFR_DRunIn_both/sqrt(size(sensorMFR_DRunIn_both,1)),'Color',colorBlack)
hold on;
plot([1,2],mean_sensorMFR_DRunIn_none,'-o','Color',colorBlack,'MarkerFaceColor',colorGray,'MarkerEdgeColor',colorBlack,'markerSize',markerS);
hold on;
plot([4,5],mean_sensorMFR_DRunIn_either,'-o','Color',colorBlack,'MarkerFaceColor',colorBlue,'MarkerEdgeColor',colorBlack,'markerSize',markerS);
hold on;
plot([7,8],mean_sensorMFR_DRunIn_both,'-o','Color',colorBlack,'MarkerFaceColor',colorRed,'MarkerEdgeColor',colorBlack,'markerSize',markerS);
ylabel('Firing rate (Hz)','fontSize',fontL);

hPlot(3) = axes('Position',axpt(nCol,nRow,7:8,2:3,[0.1 0.05 0.85 0.85],wideInterval));
errorbar([1,2],mean_sensorMFR_DRwPn_none,std_sensorMFR_DRwPn_none/sqrt(size(sensorMFR_DRwPn_none,1)),'Color',colorBlack)
hold on;
errorbar([4,5],mean_sensorMFR_DRwPn_either,std_sensorMFR_DRwPn_either/sqrt(size(sensorMFR_DRwPn_either,1)),'Color',colorBlack)
hold on;
errorbar([7,8],mean_sensorMFR_DRwPn_both,std_sensorMFR_DRwPn_both/sqrt(size(sensorMFR_DRwPn_both,1)),'Color',colorBlack)
hold on;
plot([1,2],mean_sensorMFR_DRwPn_none,'-o','Color',colorBlack,'MarkerFaceColor',colorGray,'MarkerEdgeColor',colorBlack,'markerSize',markerS);
hold on;
plot([4,5],mean_sensorMFR_DRwPn_either,'-o','Color',colorBlack,'MarkerFaceColor',colorBlue,'MarkerEdgeColor',colorBlack,'markerSize',markerS);
hold on;
plot([7,8],mean_sensorMFR_DRwPn_both,'-o','Color',colorBlack,'MarkerFaceColor',colorRed,'MarkerEdgeColor',colorBlack,'markerSize',markerS);
ylabel('Firing rate (Hz)','fontSize',fontL);

hPlot(4) = axes('Position',axpt(nCol,nRow,7:8,4:5,[0.1 0.05 0.85 0.85],wideInterval));
errorbar([4,5],mean_sensorMFR_DRwIn_either,std_sensorMFR_DRwIn_either/sqrt(size(sensorMFR_DRwIn_either,1)),'Color',colorBlack)
hold on;
errorbar([7,8],mean_sensorMFR_DRwIn_both,std_sensorMFR_DRwIn_both/sqrt(size(sensorMFR_DRwIn_both,1)),'Color',colorBlack)
hold on;
plot([1,2],mean_sensorMFR_DRwIn_none,'-o','Color',colorBlack,'MarkerFaceColor',colorGray,'MarkerEdgeColor',colorBlack,'markerSize',markerS);
hold on;
plot([4,5],mean_sensorMFR_DRwIn_either,'-o','Color',colorBlack,'MarkerFaceColor',colorBlue,'MarkerEdgeColor',colorBlack,'markerSize',markerS);
hold on;
plot([7,8],mean_sensorMFR_DRwIn_both,'-o','Color',colorBlack,'MarkerFaceColor',colorRed,'MarkerEdgeColor',colorBlack,'markerSize',markerS);
ylabel('Firing rate (Hz)','fontSize',fontL);

set(hPlot(1),'XLim',[0,9],'YLim',[0, 8]);
set(hPlot(2),'XLim',[0,9],'YLim',[0,40]);
set(hPlot(3),'XLim',[0,9],'YLim',[0, 8]);
set(hPlot(4),'XLim',[0,9],'YLim',[0,40]);

set(hPlot,'Box','off','TickDir','out','fontSize',fontL,'XTick',5,'XTickLabel',{'Pre-Stm'});

print(gcf,'-painters','-r300','plot_evokedPattern.tiff','-dtiff');
% print(gcf,'-painters','-r300','plot_evokedPattern_activated.tiff','-dtiff');
