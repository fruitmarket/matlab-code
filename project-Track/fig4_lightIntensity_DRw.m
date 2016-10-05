clearvars; clf; close all;

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

%% Condition
total_DRw = T.taskProb == '100' & T.taskType == 'DRw' & T.peakMap>1;
nTotal_DRw = sum(double(total_DRw));

% total_DRw = T.taskProb == '100' & T.taskType == 'DRw' & T.peakMap>1;
% nTotal_DRw = sum(double(total_DRw));
% total_No = T.taskProb == '100' & (T.taskType == 'noRun' | T.taskType == 'noRun') & T.peakMap>1;
% nTotal_No = sum(double(total_No));

%% Venn diagram
popBaseOnly = total_DRw & (T.pLR_tag<0.05 & ~(T.pLR_modu<0.05));
npopBaseOnly = sum(double(popBaseOnly));
popTrackOnly = total_DRw & (~(T.pLR_tag<0.05) & T.pLR_modu<0.05);
npopTrackOnly = sum(double(popTrackOnly));
popBoth = total_DRw & (T.pLR_tag<0.05 & T.pLR_modu<0.05);
npopBoth = sum(double(popBoth)); 
popNeither = total_DRw & (~(T.pLR_tag<0.05) & ~(T.pLR_modu<0.05));
npopNeither = sum(double(popNeither));

%% Base light response
groupBaseA = total_DRw & T.pLR_tag<0.05 & (T.statDir_tag == 1);
groupBaseB = total_DRw & T.pLR_tag<0.05 & (T.statDir_tag == -1) & ~isnan(T.ina_lastSpk_tag) & ~isnan(T.ina_firstSpk_tag);
groupBaseC = total_DRw & T.pLR_tag<0.05 & (T.statDir_tag == 0);
groupBaseD = total_DRw & ~(T.pLR_tag<0.05) & (T.statDir_tag == 1);
groupBaseE = total_DRw & ~(T.pLR_tag<0.05) & (T.statDir_tag == -1);
groupBaseF = total_DRw & ~(T.pLR_tag<0.05) & (T.statDir_tag == 0);
basePie = [sum(double(groupBaseA)), sum(double(groupBaseB)), sum(double(total_DRw & ~(T.pLR_tag<0.05)))];
labelsBase = {'Activated: ';'Inactivated: ';'Unmodulated: '};

lightBase5mw = T.lighttagSpk5mw(total_DRw & T.pLR_tag<0.05);
lightBase8mw = T.lighttagSpk8mw(total_DRw & T.pLR_tag<0.05);
lightBase10mw = T.lighttagSpk10mw(total_DRw & T.pLR_tag<0.05);

yLimlightBase = max([lightBase5mw; lightBase8mw; lightBase10mw])*1.1;

%% Figure (Base)
hBase(1) = axes('Position',axpt(2,2,1,1:2,[0.1 0.1 0.85 0.85],midInterval));
plot([1,2,3],[lightBase5mw, lightBase8mw, lightBase10mw],'-o','Color',colorGray,'MarkerFaceColor',colorBlue,'MarkerEdgeColor','k','MarkerSize',markerM);
hold on;
plot([1,2,3],[mean(lightBase5mw), mean(lightBase8mw), mean(lightBase10mw)],'-o','Color','k','MarkerFaceColor','k','LineWidth',2,'MarkerSize',markerM);

text(3.5, yLimlightBase*0.9,['n = ',num2str(length(lightBase5mw))]);
ylabel('Spike counts');
set(hBase,'XLim',[0,4],'YLim',[-20,yLimlightBase],'Box','off','TickDir','out','XTick',[1:3],'XTickLabel',{'5mW','8mW','10mW'});

print(gcf,'-dtiff','-r300','Fig4_lightIntensity_DRw');