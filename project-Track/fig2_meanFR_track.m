% clearvars;
clf; close all;

lineWth = [1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75];
fontS = 4; fontM = 6; fontL = 8; % font size
lineS = 0.3; lineM = 0.6; lineL = 1.2; % line width
tightInterval = [0.02 0.02]; midInterval = [0.09, 0.09]; wideInterval = [0.14 0.14];
markerS = 2.2; markerM = 4.4; markerL = 6.6; markerXL = 8.8;
scatterS = 26; scatterM = 36; scatterL = 54;

colorBlue = [33 150 243] ./ 255;
colorLightBlue = [223 239 252] ./ 255;
colorRed = [237 50 52] ./ 255;
colorLightRed = [242 138 130] ./ 255;
colorGray = [189 189 189] ./ 255;
colorLightGray = [238, 238, 238] ./255;
colorDarkGray = [117, 117, 117] ./255;
colorYellow = [255 243 3] ./ 255;
colorLightYellow = [255 249 196] ./ 255;

% four group color
colorDarkRed4 = [183, 28, 28]./255;
colorLightRed4 = [211, 47, 47]./255;
colorDarkOrange4 = [255, 111, 0]./255;
colorLightOrange4 = [255, 160, 0]./255;
colorDarkBlue4 = [13, 71, 161]./255;
colorLightBlue4 = [25, 118, 210]./255;
colorDarkGreen4 = [27, 94, 32]./255;
colorLightGreen4 = [56, 142, 60]./255;

colorOrange = [27, 94, 32]./255;

% Stimulation during running
load(['cellList_add','.mat']);
% rtDir_sig = 'D:\Dropbox\SNL\P2_Track\cellFigDRw_Sig';
% rtDir_nosig = 'D:\Dropbox\SNL\P2_Track\cellFigDRw_NoSig';

%% Conditio
total_DRun = T.taskProb == '100' & T.taskType == 'DRun' & T.peakMap>1;
nTotal_DRun = sum(double(total_DRun));

total_DRw = T.taskProb == '100' & T.taskType == 'DRw' & T.peakMap>1;
nTotal_DRw = sum(double(total_DRw));

total_No = T.taskProb == '100' & (T.taskType == 'noRw' | T.taskType == 'noRun') & T.peakMap>1;
nTotal_No = sum(double(total_No));

%%
meanFR_DRunPre = T.meanFR_pre(total_DRun);
meanFR_DRunStm = T.meanFR_stm(total_DRun);
meanFR_DRunPost = T.meanFR_post(total_DRun);

meanFR_DRwPre = T.meanFR_pre(total_DRw);
meanFR_DRwStm = T.meanFR_stm(total_DRw);
meanFR_DRwPost = T.meanFR_post(total_DRw);

meanFR_NoPre = T.meanFR_pre(total_No);
meanFR_NoStm = T.meanFR_stm(total_No);
meanFR_NoPost = T.meanFR_post(total_No);

yLimDRun = max([meanFR_DRunPre; meanFR_DRunStm; meanFR_DRunPost])*1.1;
yLimDRw = max([meanFR_DRwPre; meanFR_DRwStm; meanFR_DRwPost])*1.1;
yLimNo = max([meanFR_NoPre; meanFR_NoStm; meanFR_NoPost])*1.1;

%% Light response_Total cell

hMeanFR(1) = axes('Position',axpt(3,2,1,1,[0.1 0.1 0.85 0.85],midInterval));
line([0,yLimDRun],[0,yLimDRun],'Color','k','LineWidth',lineM);
line([0,10],[10,10],'LineStyle',':','Color','k','LineWidth',lineM);
line([10,10],[0,10],'LineStyle',':','Color','k','LineWidth',lineM);
hold on;
scatter(meanFR_DRunStm,meanFR_DRunPre,markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
text(30,5,['n = ',num2str(nTotal_DRun)],'FontSize',fontL);
xlabel('Mean firing rate (Hz) [Stm] ','fontSize',fontM);
ylabel('Mean firing rate (Hz) [Pre] ','fontSize',fontM);
title('Stimulation during running zone','fontSize',fontL);

hMeanFR(2) = axes('Position',axpt(3,2,1,2,[0.1 0.1 0.85 0.85],midInterval));
line([0,yLimDRun],[0,yLimDRun],'Color','k','LineWidth',lineM);
line([0,10],[10,10],'LineStyle',':','Color','k','LineWidth',lineM);
line([10,10],[0,10],'LineStyle',':','Color','k','LineWidth',lineM);
hold on;
scatter(meanFR_DRunStm,meanFR_DRunPost,markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
xlabel('Mean firing rate (Hz) [Stm] ','fontSize',fontM);
ylabel('Mean firing rate (Hz) [Post] ','fontSize',fontM);

hMeanFR(3) = axes('Position',axpt(3,2,2,1,[0.1 0.1 0.85 0.85],midInterval));
line([0,yLimDRw],[0,yLimDRw],'Color','k','LineWidth',lineM);
line([0,10],[10,10],'LineStyle',':','Color','k','LineWidth',lineM);
line([10,10],[0,10],'LineStyle',':','Color','k','LineWidth',lineM);
hold on;
scatter(meanFR_DRwStm,meanFR_DRwPre,markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
text(30,5,['n = ',num2str(nTotal_DRw)],'FontSize',fontL);
xlabel('Mean firing rate (Hz) [Stm] ','fontSize',fontM);
ylabel('Mean firing rate (Hz) [Pre] ','fontSize',fontM);
title('Stimulation during reward zone','fontSize',fontL);

hMeanFR(4) = axes('Position',axpt(3,2,2,2,[0.1 0.1 0.85 0.85],midInterval));
line([0,yLimDRun],[0,yLimDRun],'Color','k','LineWidth',lineM);
line([0,10],[10,10],'LineStyle',':','Color','k','LineWidth',lineM);
line([10,10],[0,10],'LineStyle',':','Color','k','LineWidth',lineM);
hold on;
scatter(meanFR_DRwStm,meanFR_DRwPost,markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
xlabel('Mean firing rate (Hz) [Stm] ','fontSize',fontM);
ylabel('Mean firing rate (Hz) [Post] ','fontSize',fontM);

hMeanFR(5) = axes('Position',axpt(3,2,3,1,[0.1 0.1 0.85 0.85],midInterval));
line([0,yLimNo],[0,yLimNo],'Color','k','LineWidth',lineM);
line([0,10],[10,10],'LineStyle',':','Color','k','LineWidth',lineM);
line([10,10],[0,10],'LineStyle',':','Color','k','LineWidth',lineM);
hold on;
scatter(meanFR_NoStm,meanFR_NoPre,markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
text(30,5,['n = ',num2str(nTotal_No)],'FontSize',fontL);
xlabel('Mean firing rate (Hz) [Stm] ','fontSize',fontM);
ylabel('Mean firing rate (Hz) [Pre] ','fontSize',fontM);
title('No stimulation (Control)','fontSize',fontL);

hMeanFR(6) = axes('Position',axpt(3,2,3,2,[0.1 0.1 0.85 0.85],midInterval));
line([0,yLimNo],[0,yLimNo],'Color','k','LineWidth',lineM);
line([0,10],[10,10],'LineStyle',':','Color','k','LineWidth',lineM);
line([10,10],[0,10],'LineStyle',':','Color','k','LineWidth',lineM);
hold on;
scatter(meanFR_NoStm,meanFR_NoPost,markerXL,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
xlabel('Mean firing rate (Hz) [Stm] ','fontSize',fontM);
ylabel('Mean firing rate (Hz) [Post] ','fontSize',fontM);

set(hMeanFR,'TickDir','out');
set(hMeanFR(1:2),'XLim',[-1,yLimDRun],'YLim',[-1,yLimDRun]);
set(hMeanFR(3:4),'XLim',[-1,yLimDRw],'YLim',[-1,yLimDRw]);
set(hMeanFR(5:6),'XLim',[-1,yLimNo],'YLim',[-1,yLimNo]);

print(gcf,'-painters','-r300','Fig2_meanFR_.ai','-depsc');