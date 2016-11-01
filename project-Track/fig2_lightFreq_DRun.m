clearvars; clf; close all;

lineWth = [1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75];
fontS = 4; fontM = 6; fontL = 8; % font size
lineS = 0.3; lineM = 0.6; lineL = 1.2; % line width
tightInterval = [0.02 0.02]; midInterval = [0.09, 0.09]; wideInterval = [0.14 0.14];
markerS = 2.2; markerM = 4.0; markerL = 6.6; markerXL = 8.8;
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
load(['cellList_v3new','.mat']);

%% Condition
total_DRun = T.taskProb == '100' & T.taskType == 'DRw';
nTotal_DRun = sum(double(total_DRun));

% total_DRw = T.taskProb == '100' & T.taskType == 'DRw' & T.peakMap>1;
% nTotal_DRw = sum(double(total_DRw));
% total_No = T.taskProb == '100' & (T.taskType == 'noRun' | T.taskType == 'noRun') & T.peakMap>1;
% nTotal_No = sum(double(total_No));

%% Base light response
% groupBaseA = total_DRun & T.pLR_Plfm<0.05 & (T.statDir_Plfm == 1);
% groupBaseB = total_DRun & T.pLR_Plfm<0.05 & (T.statDir_Plfm == -1) & ~isnan(T.ina_lastSpk_tag) & ~isnan(T.ina_firstSpk_tag);
% groupBaseC = total_DRun & T.pLR_Plfm<0.05 & (T.statDir_Plfm == 0);
% groupBaseD = total_DRun & ~(T.pLR_Plfm<0.05) & (T.statDir_Plfm == 1);
% groupBaseE = total_DRun & ~(T.pLR_Plfm<0.05) & (T.statDir_Plfm == -1);
% groupBaseF = total_DRun & ~(T.pLR_Plfm<0.05) & (T.statDir_Plfm == 0);
% basePie = [sum(double(groupBaseA)), sum(double(groupBaseB)), sum(double(total_DRun & ~(T.pLR_Plfm<0.05)))];
% labelsBase = {'Activated: ';'Inactivated: ';'Unmodulated: '};

%% Frequency
lightPlfm2hz = T.lightPlfmSpk2hz8mw(total_DRun & T.pLR_Plfm<0.01);
lightPlfm8hz = T.lightPlfmSpk8hz(total_DRun & T.pLR_Plfm<0.01);
yLimFreqPlfm = max([lightPlfm2hz, lightPlfm8hz])*1.1;

lightTrack2hz =  T.lightTrackSpk2hz8mw(total_DRun & T.pLR_Track<0.01);
lightTrack8hz = T.lightTrackSpk8hz(total_DRun & T.pLR_Track<0.01);
yLimFreqTrack = max([lightTrack2hz, lightTrack8hz])*1.1;

%% Power
lightPlfm5mw = T.lightPlfmSpk5mw(total_DRun & T.pLR_Plfm<0.01);
lightPlfm8mw = T.lightPlfmSpk8mw(total_DRun & T.pLR_Plfm<0.01);
lightPlfm10mw = T.lightPlfmSpk10mw(total_DRun & T.pLR_Plfm<0.01);
yLimPowerPlfm = max([lightPlfm5mw; lightPlfm8mw; lightPlfm10mw])*1.1;

lightTrack5mw = T.lightTrackSpk5mw(total_DRun & T.pLR_Track<0.01);
lightTrack8mw = T.lightTrackSpk8mw(total_DRun & T.pLR_Track<0.01);
lightTrack10mw = T.lightTrackSpk10mw(total_DRun & T.pLR_Track<0.01);
yLimPowerTrack = max([lightTrack5mw; lightTrack8mw; lightTrack10mw])*1.1;

%% Figure (Base)
hPower(1) = axes('Position',axpt(4,4,1,1,[0.1 0.1 0.85 0.85],midInterval));
plot([1,2,3],[lightPlfm5mw, lightPlfm8mw, lightPlfm10mw],'-o','Color',colorGray,'MarkerFaceColor',colorBlue,'MarkerEdgeColor','k','MarkerSize',markerM);
hold on;
plot([1,2,3],[mean(lightPlfm5mw), mean(lightPlfm8mw), mean(lightPlfm10mw)],'-o','Color','k','MarkerFaceColor','k','LineWidth',2,'MarkerSize',markerM);
text(3.3, 120,['n = ',num2str(length(lightPlfm5mw))],'FontSize',fontM);
ylabel('Spike counts','FontSize',fontM);
title('Power dependency (Platform)','FontSize',fontM);

hPower(2) = axes('Position',axpt(4,4,2,1,[0.1 0.1 0.85 0.85],midInterval));
plot([1,2,3],[lightTrack5mw, lightTrack8mw, lightTrack10mw],'-o','Color',colorGray,'MarkerFaceColor',colorBlue,'MarkerEdgeColor','k','MarkerSize',markerM);
hold on;
plot([1,2,3],[mean(lightTrack5mw), mean(lightTrack8mw), mean(lightTrack10mw)],'-o','Color','k','MarkerFaceColor','k','LineWidth',2,'MarkerSize',markerM);
text(3.3, 120,['n = ',num2str(length(lightTrack5mw))],'FontSize',fontM);
title('Power dependency (Track)','FontSize',fontM);

hFrequency(1) = axes('Position',axpt(4,4,1,2,[0.1 0.1 0.85 0.85],midInterval));
plot([1,2],[lightPlfm2hz, lightPlfm8hz], '-o','Color',colorGray,'MarkerFaceColor',colorBlue,'MarkerEdgeColor','k','MarkerSize',markerM);
ylabel('Probability','FontSize',fontM);
text(2.3, 0.8,['n = ',num2str(length(lightPlfm2hz))],'FontSize',fontM);
title('Frequency dependency (Platform)','FontSize',fontM);

hFrequency(2) = axes('Position',axpt(4,4,2,2,[0.1 0.1 0.85 0.85],midInterval));
plot([1,2],[lightTrack2hz, lightTrack8hz], '-o','Color',colorGray,'MarkerFaceColor',colorBlue,'MarkerEdgeColor','k','MarkerSize',markerM);
text(2.3, 0.8,['n = ',num2str(length(lightTrack2hz))],'FontSize',fontM);
title('Frequency dependency (Track)','FontSize',fontM);

set(hPower,'XLim',[0,4],'YLim',[-10 150],'Box','off','TickDir','out','XTick',[1:3],'XTickLabel',{'5 mW','8 mW','10 mW'},'FontSize',fontM);
set(hFrequency,'XLim',[0,3],'YLim',[-0.2, 1.5],'Box','off','TickDir','out','XTick',[1:2],'XTickLabel',{'2 Hz','8 Hz'},'FontSize',fontM);
% print(gcf,'-dtiff','-r300','Fig2_PowerFreq_DRun');
% print(gcf,'-painters','-r300','Fig2_PowerFreq_DRw_Poster.ai','-depsc');