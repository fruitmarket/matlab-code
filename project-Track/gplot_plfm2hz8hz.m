lineColor = {[144, 164, 174]./255,... % Before stimulation
    [33 150 243]./ 255,... % During stimulation
    [38, 50, 56]./255}; % After stimulation

lineWth = [1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75];
fontS = 4; fontM = 5; fontL = 7; fontXL = 9; % font size large
lineS = 0.2; lineM = 0.5; lineL = 1; % line width large
markerS = 2.2; markerM = 4.4; markerL = 6.6; markerXL = 8.8;
tightInterval = [0.02 0.02]; midInterval = [0.09, 0.09]; wideInterval = [0.14 0.14];

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

width = 0.7;

paperSizeX = [18.3, 8.00];
figSize = [0.10 0.1 0.80 0.80];

rtDir = 'D:\Dropbox\#team_hippocampus Team Folder\project_Track';
criteria_FR = 7;
alpha = 0.005;

load('cellList_ori.mat');

%%%%%
%
% Draw a plot with "platform-light activated population".
%
%
%
%%%%%
DRunPn = T.taskProb == '100' & T.taskType == 'DRun' & T.peakFR_track>1 & T.meanFR_task<criteria_FR;
DRunIn = T.taskProb == '100' & T.taskType == 'DRun' & T.peakFR_track>1 & T.meanFR_task>criteria_FR;
DRwPn = T.taskProb == '100' & T.taskType == 'DRw' & T.peakFR_track>1 & T.meanFR_task<criteria_FR;
DRwIn = T.taskProb == '100' & T.taskType == 'DRw' & T.peakFR_track>1 & T.meanFR_task>criteria_FR;

DRunPn_both_lightProb2hzPlfm = T.lightProb2hzPlfm(DRunPn & (T.statDir_Plfm2hz ~= 0 & T.pLR_Plfm2hz<alpha) & (T.statDir_Plfm8hz ~= 0 & T.pLR_Plfm8hz<alpha));
DRunPn_both_lightProb8hzPlfm = T.lightProb8hzPlfm(DRunPn & (T.statDir_Plfm2hz ~= 0 & T.pLR_Plfm2hz<alpha) & (T.statDir_Plfm8hz ~= 0 & T.pLR_Plfm8hz<alpha));
DRunIn_both_lightProb2hzPlfm = T.lightProb2hzPlfm(DRunIn & (T.statDir_Plfm2hz ~= 0 & T.pLR_Plfm2hz<alpha) & (T.statDir_Plfm8hz ~= 0 & T.pLR_Plfm8hz<alpha));
DRunIn_both_lightProb8hzPlfm = T.lightProb8hzPlfm(DRunIn & (T.statDir_Plfm2hz ~= 0 & T.pLR_Plfm2hz<alpha) & (T.statDir_Plfm8hz ~= 0 & T.pLR_Plfm8hz<alpha));

DRwPn_both_lightProb2hzPlfm = T.lightProb2hzPlfm(DRwPn & (T.statDir_Plfm2hz ~= 0 & T.pLR_Plfm2hz<alpha) & (T.statDir_Plfm8hz ~= 0 & T.pLR_Plfm8hz<alpha));
DRwPn_both_lightProb8hzPlfm = T.lightProb8hzPlfm(DRwPn & (T.statDir_Plfm2hz ~= 0 & T.pLR_Plfm2hz<alpha) & (T.statDir_Plfm8hz ~= 0 & T.pLR_Plfm8hz<alpha));
DRwIn_both_lightProb2hzPlfm = T.lightProb2hzPlfm(DRwIn & (T.statDir_Plfm2hz ~= 0 & T.pLR_Plfm2hz<alpha) & (T.statDir_Plfm8hz ~= 0 & T.pLR_Plfm8hz<alpha));
DRwIn_both_lightProb8hzPlfm = T.lightProb8hzPlfm(DRwIn & (T.statDir_Plfm2hz ~= 0 & T.pLR_Plfm2hz<alpha) & (T.statDir_Plfm8hz ~= 0 & T.pLR_Plfm8hz<alpha));

DRunPn_either_lightProb2hzPlfm = T.lightProb2hzPlfm(DRunPn & (T.statDir_Plfm2hz ~= 0 & T.pLR_Plfm2hz<alpha));
DRunPn_either_lightProb8hzPlfm = T.lightProb8hzPlfm(DRunPn & (T.statDir_Plfm8hz ~= 0 & T.pLR_Plfm8hz<alpha));
DRunIn_either_lightProb2hzPlfm = T.lightProb2hzPlfm(DRunIn & (T.statDir_Plfm2hz ~= 0 & T.pLR_Plfm2hz<alpha));
DRunIn_either_lightProb8hzPlfm = T.lightProb8hzPlfm(DRunIn & (T.statDir_Plfm8hz ~= 0 & T.pLR_Plfm8hz<alpha));

DRwPn_either_lightProb2hzPlfm = T.lightProb2hzPlfm(DRwPn & (T.statDir_Plfm2hz ~= 0 & T.pLR_Plfm2hz<alpha));
DRwPn_either_lightProb8hzPlfm = T.lightProb8hzPlfm(DRwPn & (T.statDir_Plfm8hz ~= 0 & T.pLR_Plfm8hz<alpha));
DRwIn_either_lightProb2hzPlfm = T.lightProb2hzPlfm(DRwIn & (T.statDir_Plfm2hz ~= 0 & T.pLR_Plfm2hz<alpha));
DRwIn_either_lightProb8hzPlfm = T.lightProb8hzPlfm(DRwIn & (T.statDir_Plfm8hz ~= 0 & T.pLR_Plfm8hz<alpha));

%% statistics
[~,DRunPn_p] = ttest2(DRunPn_either_lightProb2hzPlfm,DRunPn_either_lightProb8hzPlfm);
[~,DRunIn_p] = ttest2(DRunIn_either_lightProb2hzPlfm,DRunIn_either_lightProb8hzPlfm);
[~,DRwPn_p] = ttest2(DRwPn_either_lightProb2hzPlfm,DRwPn_either_lightProb8hzPlfm);
[~,DRwIn_p] = ttest2(DRwIn_either_lightProb2hzPlfm,DRwIn_either_lightProb8hzPlfm);

%% Plot
fHandle = figure('PaperUnits','centimeters','PaperPosition',[0 0 15 10.5]);

nCol = 2;
nRow = 2;

h2hz8hz(1) = axes('Position',axpt(nCol,nRow,1,1,figSize,wideInterval));
plot(1,DRunPn_either_lightProb2hzPlfm,'o','Color',colorBlack,'MarkerEdgeColor',colorBlack,'MarkerFaceColor',colorBlue,'MarkerSize',markerM);
hold on;
plot(2,DRunPn_either_lightProb8hzPlfm,'o','Color',colorBlack,'MarkerEdgeColor',colorBlack,'MarkerFaceColor',colorBlue,'MarkerSize',markerM);
hold on;
plot([1,2], [DRunPn_both_lightProb2hzPlfm,DRunPn_both_lightProb8hzPlfm],'-o','Color',colorBlack,'MarkerEdgeColor',colorBlack,'MarkerFaceColor',colorRed,'MarkerSize',markerM);
text(1.2,80,['total neuron, n = ',num2str(sum(double(DRunPn)))],'fontSize',fontL);
text(1.2,70,['Avg., % (2 Hz: n = ',num2str(length(DRunPn_either_lightProb2hzPlfm)),'): ',num2str(mean(DRunPn_either_lightProb2hzPlfm),3)],'fontSize',fontL);
text(1.2,60,['Avg., % (8 Hz: n = ',num2str(length(DRunPn_either_lightProb8hzPlfm)),'): ',num2str(mean(DRunPn_either_lightProb8hzPlfm),3)],'fontSize',fontL);
text(1.2,50,['t-test: p = ',num2str(DRunPn_p,3)],'fontSize',fontL);
ylabel('Spike P, %','fontSize',fontXL);
title('DRun session, Pyramidal neurons','fontSize',fontXL);

h2hz8hz(2) = axes('Position',axpt(nCol,nRow,1,2,figSize,wideInterval));
plot(1,DRunIn_either_lightProb2hzPlfm,'o','Color',colorBlack,'MarkerEdgeColor',colorBlack,'MarkerFaceColor',colorBlue,'MarkerSize',markerM);
hold on;
plot(2,DRunIn_either_lightProb8hzPlfm,'o','Color',colorBlack,'MarkerEdgeColor',colorBlack,'MarkerFaceColor',colorBlue,'MarkerSize',markerM);
hold on;
plot([1,2],[DRunIn_both_lightProb2hzPlfm, DRunIn_both_lightProb8hzPlfm],'-o','Color',colorBlack,'MarkerEdgeColor',colorBlack,'MarkerFaceColor',colorRed,'MarkerSize',markerM);
text(1.2,80,['total neuron, n = ',num2str(sum(double(DRunIn)))],'fontSize',fontL);
text(1.2,70,['Avg., % (2 Hz: n = ',num2str(length(DRunIn_either_lightProb2hzPlfm)),'): ',num2str(mean(DRunIn_either_lightProb2hzPlfm),3)],'fontSize',fontL);
text(1.2,60,['Avg., % (8 Hz: n = ',num2str(length(DRunIn_either_lightProb8hzPlfm)),'): ',num2str(mean(DRunIn_either_lightProb8hzPlfm),3)],'fontSize',fontL);
text(1.2,50,['t-test: p = ',num2str(DRunIn_p,3)],'fontSize',fontL);
ylabel('Spike P, %','fontSize',fontXL);
title('DRun session, Interneurons','fontSize',fontXL);

h2hz8hz(3) = axes('Position',axpt(nCol,nRow,2,1,figSize,wideInterval));
plot(1,DRwPn_either_lightProb2hzPlfm,'o','Color',colorBlack,'MarkerEdgeColor',colorBlack,'MarkerFaceColor',colorBlue,'MarkerSize',markerM);
hold on;
plot(2,DRwPn_either_lightProb8hzPlfm,'o','Color',colorBlack,'MarkerEdgeColor',colorBlack,'MarkerFaceColor',colorBlue,'MarkerSize',markerM);
hold on;
plot([1,2],[DRwPn_both_lightProb2hzPlfm,DRwPn_both_lightProb8hzPlfm],'-o','Color',colorBlack,'MarkerEdgeColor',colorBlack,'MarkerFaceColor',colorRed,'MarkerSize',markerM);
text(1.2,80,['total neuron, n = ',num2str(sum(double(DRwPn)))],'fontSize',fontL);
text(1.2,70,['Avg., % (2 Hz: n = ',num2str(length(DRwPn_either_lightProb2hzPlfm)),'): ',num2str(mean(DRwPn_either_lightProb2hzPlfm),3)],'fontSize',fontL);
text(1.2,60,['Avg., % (8 Hz: n = ',num2str(length(DRwPn_either_lightProb8hzPlfm)),'): ',num2str(mean(DRwPn_either_lightProb8hzPlfm),3)],'fontSize',fontL);
text(1.2,50,['t-test: p = ',num2str(DRwPn_p,3)],'fontSize',fontL);
ylabel('Spike P, %','fontSize',fontXL);
title('DRw session, Pyramidal neurons','fontSize',fontXL);

h2hz8hz(4) = axes('Position',axpt(nCol,nRow,2,2,figSize,wideInterval));
plot(1,DRwIn_either_lightProb2hzPlfm,'o','Color',colorBlack,'MarkerEdgeColor',colorBlack,'MarkerFaceColor',colorBlue,'MarkerSize',markerM);
hold on;
plot(2,DRwIn_either_lightProb8hzPlfm,'o','Color',colorBlack,'MarkerEdgeColor',colorBlack,'MarkerFaceColor',colorBlue,'MarkerSize',markerM);
hold on;
plot([1,2],[DRwIn_both_lightProb2hzPlfm,DRwIn_both_lightProb8hzPlfm],'-o','Color',colorBlack,'MarkerEdgeColor',colorBlack,'MarkerFaceColor',colorRed,'MarkerSize',markerM);
text(1.2,80,['total neuron, n = ',num2str(sum(double(DRwIn)))],'fontSize',fontL);
text(1.2,70,['Avg., % (2 Hz: n = ',num2str(length(DRwIn_either_lightProb2hzPlfm)),'): ',num2str(mean(DRwIn_either_lightProb2hzPlfm),3)],'fontSize',fontL);
text(1.2,60,['Avg., % (8 Hz: n = ',num2str(length(DRwIn_either_lightProb8hzPlfm)),'): ',num2str(mean(DRwIn_either_lightProb8hzPlfm),3)],'fontSize',fontL);
text(1.2,50,['t-test: p = ',num2str(DRwIn_p,3)],'fontSize',fontL);
ylabel('Spike P, %','fontSize',fontXL);
title('DRw session, Interneurons','fontSize',fontXL);

set(h2hz8hz,'Box','off','TickDir','out','fontSize',fontXL);
set(h2hz8hz,'XLim',[0,3],'XTick',[1,2],'XTickLabel',{'2 Hz';'8 Hz'},'YLim',[-5 100]);

print('-painters','plot_plfm2hz8hz.tiff','-r300','-dtiff');
