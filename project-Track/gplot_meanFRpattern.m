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
criteria_Peak = 1;
rtDir = 'D:\Dropbox\#team_hippocampus Team Folder\project_Track';

load('cellList_ori_04-Feb-2017.mat');

DRunPn = T.taskType == 'DRun' & T.peakFR_track>criteria_Peak & T.meanFR_task<criteria_FR;
DRunIn = T.taskType == 'DRun' & T.peakFR_track>criteria_Peak & T.meanFR_task>criteria_FR;
DRwPn = T.taskType == 'DRw' & T.peakFR_track>criteria_Peak & T.meanFR_task<criteria_FR;
DRwIn = T.taskType == 'DRw' & T.peakFR_track>criteria_Peak & T.meanFR_task>criteria_FR;
%%

plfmLight = T.statDir_Plfm2hz ~= 0 & T.pLR_Plfm2hz<0.005;
trackLight = T.statDir_Track ~= 0 & T.pLR_Track<0.005;

% DRunPn_none = DRunPn & ~(plfmLight | trackLight);
% DRunPn_either = DRunPn & (plfmLight | trackLight);
% DRunPn_both = DRunPn & (plfmLight & trackLight);
% 
% DRunIn_none = DRunIn & ~(plfmLight | trackLight);
% DRunIn_either = DRunIn & (plfmLight | trackLight);
% DRunIn_both = DRunIn & (plfmLight & trackLight);
% 
% DRwPn_none = DRwPn & ~(plfmLight | trackLight);
% DRwPn_either = DRwPn & (plfmLight | trackLight);
% DRwPn_both = DRwPn & (plfmLight & trackLight);
% 
% DRwIn_none = DRwIn & ~(plfmLight | trackLight);
% DRwIn_either = DRwIn & (plfmLight | trackLight);
% DRwIn_both = DRwIn & (plfmLight & trackLight);

%% condition 2 (used only light-activated population)
DRunPn_none = DRunPn & (T.pLR_Plfm2hz>0.005 & T.pLR_Track>0.005);
DRunPn_either = DRunPn & ((T.statDir_Plfm2hz == 1 & T.pLR_Plfm2hz<0.005) | (T.statDir_Track == 1 & T.pLR_Track<0.005));
DRunPn_both = DRunPn & ((T.statDir_Plfm2hz == 1 & T.pLR_Plfm2hz<0.005) & (T.statDir_Track == 1 & T.pLR_Track<0.005));

DRunIn_none = DRunIn & (T.pLR_Plfm2hz>0.005 & T.pLR_Track>0.005);
DRunIn_either = DRunIn & ((T.statDir_Plfm2hz == 1 & T.pLR_Plfm2hz<0.005) | (T.statDir_Track == 1 & T.pLR_Track<0.005));
DRunIn_both = DRunIn & ((T.statDir_Plfm2hz == 1 & T.pLR_Plfm2hz<0.005) & (T.statDir_Track == 1 & T.pLR_Track<0.005));

DRwPn_none = DRwPn & (T.pLR_Plfm2hz>0.005 & T.pLR_Track>0.005);
DRwPn_either = DRwPn & ((T.statDir_Plfm2hz == 1 & T.pLR_Plfm2hz<0.005) | (T.statDir_Track == 1 & T.pLR_Track<0.005));
DRwPn_both = DRwPn & ((T.statDir_Plfm2hz == 1 & T.pLR_Plfm2hz<0.005) & (T.statDir_Track == 1 & T.pLR_Track<0.005));

DRwIn_none = DRwIn & (T.pLR_Plfm2hz>0.005 & T.pLR_Track>0.005);
DRwIn_either = DRwIn & ((T.statDir_Plfm2hz == 1 & T.pLR_Plfm2hz<0.005) | (T.statDir_Track == 1 & T.pLR_Track<0.005));
DRwIn_both = DRwIn & ((T.statDir_Plfm2hz == 1 & T.pLR_Plfm2hz<0.005) & (T.statDir_Track == 1 & T.pLR_Track<0.005));
%%
totalMeanFR_PreStm = horzcat(T.meanFR_pre,T.meanFR_stm);

totalMFR_DRunPn_none = totalMeanFR_PreStm(DRunPn_none,:);
totalMFR_DRunPn_either = totalMeanFR_PreStm(DRunPn_either,:);
totalMFR_DRunPn_both = totalMeanFR_PreStm(DRunPn_both,:);

totalMFR_DRunIn_none = totalMeanFR_PreStm(DRunIn_none,:);
totalMFR_DRunIn_either = totalMeanFR_PreStm(DRunIn_either,:);
totalMFR_DRunIn_both = totalMeanFR_PreStm(DRunIn_both,:);

totalMFR_DRwPn_none = totalMeanFR_PreStm(DRwPn_none,:);
totalMFR_DRwPn_either = totalMeanFR_PreStm(DRwPn_either,:);
totalMFR_DRwPn_both = totalMeanFR_PreStm(DRwPn_both,:);

totalMFR_DRwIn_none = totalMeanFR_PreStm(DRwIn_none,:);
totalMFR_DRwIn_either = totalMeanFR_PreStm(DRwIn_either,:);
totalMFR_DRwIn_both = totalMeanFR_PreStm(DRwIn_both,:);

%% Mean Std calculation
mean_totalMFR_DRunPn_none = mean(totalMFR_DRunPn_none);
mean_totalMFR_DRunPn_either = mean(totalMFR_DRunPn_either);
mean_totalMFR_DRunPn_both = mean(totalMFR_DRunPn_both);

mean_totalMFR_DRunIn_none = mean(totalMFR_DRunIn_none);
mean_totalMFR_DRunIn_either = mean(totalMFR_DRunIn_either);
mean_totalMFR_DRunIn_both = mean(totalMFR_DRunIn_both);

mean_totalMFR_DRwPn_none = mean(totalMFR_DRwPn_none);
mean_totalMFR_DRwPn_either = mean(totalMFR_DRwPn_either);
mean_totalMFR_DRwPn_both = mean(totalMFR_DRwPn_both);

mean_totalMFR_DRwIn_none = mean(totalMFR_DRwIn_none);
mean_totalMFR_DRwIn_either = mean(totalMFR_DRwIn_either);
mean_totalMFR_DRwIn_both = mean(totalMFR_DRwIn_both);

std_totalMFR_DRunPn_none = std(totalMFR_DRunPn_none);
std_totalMFR_DRunPn_either = std(totalMFR_DRunPn_either);
std_totalMFR_DRunPn_both = std(totalMFR_DRunPn_both);

std_totalMFR_DRunIn_none = std(totalMFR_DRunIn_none);
std_totalMFR_DRunIn_either = std(totalMFR_DRunIn_either);
std_totalMFR_DRunIn_both = std(totalMFR_DRunIn_both);

std_totalMFR_DRwPn_none = std(totalMFR_DRwPn_none);
std_totalMFR_DRwPn_either = std(totalMFR_DRwPn_either);
std_totalMFR_DRwPn_both = std(totalMFR_DRwPn_both);

std_totalMFR_DRwIn_none = std(totalMFR_DRwIn_none);
std_totalMFR_DRwIn_either = std(totalMFR_DRwIn_either);
std_totalMFR_DRwIn_both = std(totalMFR_DRwIn_both);

nCol = 8;
nRow = 8;

%% Plot scatter
% fHandle = figure('PaperUnits','centimeters','PaperPosition',[0 0 18.3 13.725]);
fHandle = figure('PaperUnits','centimeters','PaperPosition',[0 0 18 18]);
hScatter(1) = axes('Position',axpt(nCol,nRow,1:2,2:3,[0.1 0.1 0.85 0.85],wideInterval));
scatter(totalMFR_DRunPn_none(:,1),totalMFR_DRunPn_none(:,2),markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
hold on;
scatter(totalMFR_DRunPn_either(:,1),totalMFR_DRunPn_either(:,2),markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorBlue);
hold on;
scatter(totalMFR_DRunPn_both(:,1),totalMFR_DRunPn_both(:,2),markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorRed);
text(1,10,['Grey (none): n = ',num2str(size(totalMFR_DRunPn_none,1))],'fontSize',fontL);
text(1,9,['Blue (either): n = ',num2str(size(totalMFR_DRunPn_either,1))],'fontSize',fontL);
text(1,8,['Red (both): n = ',num2str(size(totalMFR_DRunPn_both,1))],'fontSize',fontL);
xlabel('Mean FR (Pre)','fontSize',fontL);
ylabel('Mean FR (Stm)','fontSize',fontL);
title('mean FR total track, PN','fontSize',fontL,'fontWeight','bold');

hScatter(2) = axes('Position',axpt(nCol,nRow,1:2,4:5,[0.1 0.1 0.85 0.85],wideInterval));
scatter(totalMFR_DRunIn_none(:,1),totalMFR_DRunIn_none(:,2),markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
hold on;
scatter(totalMFR_DRunIn_either(:,1),totalMFR_DRunIn_either(:,2),markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorBlue);
hold on;
scatter(totalMFR_DRunIn_both(:,1),totalMFR_DRunIn_both(:,2),markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorRed);
text(1,50,['Grey (none): n = ',num2str(size(totalMFR_DRunIn_none,1))],'fontSize',fontL);
text(1,45,['Blue (either): n = ',num2str(size(totalMFR_DRunIn_either,1))],'fontSize',fontL);
text(1,40,['Red (both): n = ',num2str(size(totalMFR_DRunIn_both,1))],'fontSize',fontL);
xlabel('Mean FR (Pre)','fontSize',fontL);
ylabel('Mean FR (Stm)','fontSize',fontL);
title('mean FR total track, IN','fontSize',fontL,'fontWeight','bold');
 
hScatter(3) = axes('Position',axpt(nCol,nRow,5:6,2:3,[0.1 0.1 0.85 0.85],wideInterval));
scatter(totalMFR_DRwPn_none(:,1),totalMFR_DRwPn_none(:,2),markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
hold on;
scatter(totalMFR_DRwPn_either(:,1),totalMFR_DRwPn_either(:,2),markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorBlue);
hold on;
scatter(totalMFR_DRwPn_both(:,1),totalMFR_DRwPn_both(:,2),markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorRed);
text(1,10,['Grey (none): n = ',num2str(size(totalMFR_DRwPn_none,1))],'fontSize',fontL);
text(1,9,['Blue (either): n = ',num2str(size(totalMFR_DRwPn_either,1))],'fontSize',fontL);
text(1,8,['Red (both): n = ',num2str(size(totalMFR_DRwPn_both,1))],'fontSize',fontL);
xlabel('Mean FR (Pre)','fontSize',fontL);
ylabel('Mean FR (Stm)','fontSize',fontL);
title('mean FR total track, PN','fontSize',fontL,'fontWeight','bold');
 
hScatter(4) = axes('Position',axpt(nCol,nRow,5:6,4:5,[0.1 0.1 0.85 0.85],wideInterval));
scatter(totalMFR_DRwIn_none(:,1),totalMFR_DRwIn_none(:,2),markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
hold on;
scatter(totalMFR_DRwIn_either(:,1),totalMFR_DRwIn_either(:,2),markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorBlue);
hold on;
scatter(totalMFR_DRwIn_both(:,1),totalMFR_DRwIn_both(:,2),markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorRed);
text(1,50,['Grey (none): n = ',num2str(size(totalMFR_DRwIn_none,1))],'fontSize',fontL);
text(1,45,['Blue (either): n = ',num2str(size(totalMFR_DRwIn_either,1))],'fontSize',fontL);
text(1,40,['Red (both): n = ',num2str(size(totalMFR_DRwIn_both,1))],'fontSize',fontL);
xlabel('Mean FR (Pre)','fontSize',fontL);
ylabel('Mean FR (Stm)','fontSize',fontL);
title('mean FR total track, IN','fontSize',fontL,'fontWeight','bold');

set(hScatter(1),'XLim',[-1,10],'YLim',[-1,10]);
set(hScatter(2),'XLim',[-1,50],'YLim',[-1,50]);
set(hScatter(3),'XLim',[-1,10],'YLim',[-1,10]);
set(hScatter(4),'XLim',[-1,50],'YLim',[-1,50]);
set(hScatter,'Box','off','TickDir','out','fontSize',fontL);

%% Plot line
hPlot(1) = axes('Position',axpt(nCol,nRow,3:4,2:3,[0.1 0.1 0.85 0.85],wideInterval));
errorbar([1,2],mean_totalMFR_DRunPn_none,std_totalMFR_DRunPn_none/sqrt(size(totalMFR_DRunPn_none,1)),'Color',colorBlack)
hold on;
errorbar([4,5],mean_totalMFR_DRunPn_either,std_totalMFR_DRunPn_either/sqrt(size(totalMFR_DRunPn_either,1)),'Color',colorBlack)
hold on;
errorbar([7,8],mean_totalMFR_DRunPn_both,std_totalMFR_DRunPn_both/sqrt(size(totalMFR_DRunPn_both,1)),'Color',colorBlack)
hold on;
plot([1,2],mean_totalMFR_DRunPn_none,'-o','Color',colorBlack,'MarkerFaceColor',colorGray,'MarkerEdgeColor',colorBlack,'markerSize',markerS);
hold on;
plot([4,5],mean_totalMFR_DRunPn_either,'-o','Color',colorBlack,'MarkerFaceColor',colorBlue,'MarkerEdgeColor',colorBlack,'markerSize',markerS);
hold on;
plot([7,8],mean_totalMFR_DRunPn_both,'-o','Color',colorBlack,'MarkerFaceColor',colorRed,'MarkerEdgeColor',colorBlack,'markerSize',markerS);
ylabel('Firing rate (Hz)','fontSize',fontL);

hPlot(2) = axes('Position',axpt(nCol,nRow,3:4,4:5,[0.1 0.1 0.85 0.85],wideInterval));
errorbar([4,5],mean_totalMFR_DRunIn_either,std_totalMFR_DRunIn_either/sqrt(size(totalMFR_DRunIn_either,1)),'Color',colorBlack)
hold on;
errorbar([7,8],mean_totalMFR_DRunIn_both,std_totalMFR_DRunIn_both/sqrt(size(totalMFR_DRunIn_both,1)),'Color',colorBlack)
hold on;
plot([1,2],mean_totalMFR_DRunIn_none,'-o','Color',colorBlack,'MarkerFaceColor',colorGray,'MarkerEdgeColor',colorBlack,'markerSize',markerS);
hold on;
plot([4,5],mean_totalMFR_DRunIn_either,'-o','Color',colorBlack,'MarkerFaceColor',colorBlue,'MarkerEdgeColor',colorBlack,'markerSize',markerS);
hold on;
plot([7,8],mean_totalMFR_DRunIn_both,'-o','Color',colorBlack,'MarkerFaceColor',colorRed,'MarkerEdgeColor',colorBlack,'markerSize',markerS);
ylabel('Firing rate (Hz)','fontSize',fontL);

hPlot(3) = axes('Position',axpt(nCol,nRow,7:8,2:3,[0.1 0.1 0.85 0.85],wideInterval));
errorbar([1,2],mean_totalMFR_DRwPn_none,std_totalMFR_DRwPn_none/sqrt(size(totalMFR_DRwPn_none,1)),'Color',colorBlack)
hold on;
errorbar([4,5],mean_totalMFR_DRwPn_either,std_totalMFR_DRwPn_either/sqrt(size(totalMFR_DRwPn_either,1)),'Color',colorBlack)
hold on;
errorbar([7,8],mean_totalMFR_DRwPn_both,std_totalMFR_DRwPn_both/sqrt(size(totalMFR_DRwPn_both,1)),'Color',colorBlack)
hold on;
plot([1,2],mean_totalMFR_DRwPn_none,'-o','Color',colorBlack,'MarkerFaceColor',colorGray,'MarkerEdgeColor',colorBlack,'markerSize',markerS);
hold on;
plot([4,5],mean_totalMFR_DRwPn_either,'-o','Color',colorBlack,'MarkerFaceColor',colorBlue,'MarkerEdgeColor',colorBlack,'markerSize',markerS);
hold on;
plot([7,8],mean_totalMFR_DRwPn_both,'-o','Color',colorBlack,'MarkerFaceColor',colorRed,'MarkerEdgeColor',colorBlack,'markerSize',markerS);
ylabel('Firing rate (Hz)','fontSize',fontL);

hPlot(4) = axes('Position',axpt(nCol,nRow,7:8,4:5,[0.1 0.1 0.85 0.85],wideInterval));
errorbar([4,5],mean_totalMFR_DRwIn_either,std_totalMFR_DRwIn_either/sqrt(size(totalMFR_DRwIn_either,1)),'Color',colorBlack)
hold on;
errorbar([7,8],mean_totalMFR_DRwIn_both,std_totalMFR_DRwIn_both/sqrt(size(totalMFR_DRwIn_both,1)),'Color',colorBlack)
hold on;
plot([1,2],mean_totalMFR_DRwIn_none,'-o','Color',colorBlack,'MarkerFaceColor',colorGray,'MarkerEdgeColor',colorBlack,'markerSize',markerS);
hold on;
plot([4,5],mean_totalMFR_DRwIn_either,'-o','Color',colorBlack,'MarkerFaceColor',colorBlue,'MarkerEdgeColor',colorBlack,'markerSize',markerS);
hold on;
plot([7,8],mean_totalMFR_DRwIn_both,'-o','Color',colorBlack,'MarkerFaceColor',colorRed,'MarkerEdgeColor',colorBlack,'markerSize',markerS);
ylabel('Firing rate (Hz)','fontSize',fontL);

set(hPlot(1),'XLim',[0,9],'YLim',[0, 4]);
set(hPlot(2),'XLim',[0,9],'YLim',[10,30]);
set(hPlot(3),'XLim',[0,9],'YLim',[0, 4]);
set(hPlot(4),'XLim',[0,9],'YLim',[10,30]);
set(hPlot,'Box','off','TickDir','out','fontSize',fontL,'XTick',5,'XTickLabel',{'Pre-Stm'});

print(gcf,'-painters','-r300','plot_meanFRpattern_lightactivated.tif','-dtiff');
