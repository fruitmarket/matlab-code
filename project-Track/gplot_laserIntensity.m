function plot_laserIntensity

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
tightInterval = [0.02 0.02]; wideInterval = [0.07 0.07];
width = 0.7;

paperSizeX = [18.3, 8.00];

%%
rtDir = 'D:\Dropbox\SNL\P2_Track';
cd(rtDir);

load('cellList_ori.mat');

criteria_FR = 7;

DRunPn = T.taskProb == '100' & T.taskType == 'DRun' & T.peakFR_track>1 & T.meanFR_task<criteria_FR;
DRunIn = T.taskProb == '100' & T.taskType == 'DRun' & T.peakFR_track>1 & T.meanFR_task>criteria_FR;
DRwPn = T.taskProb == '100' & T.taskType == 'DRw' & T.peakFR_track>1 & T.meanFR_task<criteria_FR;
DRwIn = T.taskProb == '100' & T.taskType == 'DRw' & T.peakFR_track>1 & T.meanFR_task>criteria_FR;

plfmLight = T.statDir_Plfm2hz ~= 0 & T.pLR_Plfm2hz<0.005;

% none/either/both : Activated on Platform or Track?
DRunPn_evoked = DRunPn & plfmLight;
DRunPn_notevoked = DRunPn & ~plfmLight;

DRunIn_evoked = DRunIn & plfmLight;
DRunIn_noevoked = DRunIn & ~plfmLight;

DRwPn_evoked = DRwPn & plfmLight;
DRwPn_notevoked = DRwPn & ~plfmLight;

DRwIn_evoked = DRwIn & plfmLight;
DRwIn_notevoked = DRwIn & ~plfmLight;

lightPlfm5mw_DRunPn = T.lightPlfmSpk5mw(DRunPn_evoked);
lightPlfm8mw_DRunPn = T.lightPlfmSpk8mw(DRunPn_evoked);
lightPlfm10mw_DRunPn = T.lightPlfmSpk10mw(DRunPn_evoked);

lightPlfm5mw_DRunIn = T.lightPlfmSpk5mw(DRunIn_evoked);
lightPlfm8mw_DRunIn = T.lightPlfmSpk8mw(DRunIn_evoked);
lightPlfm10mw_DRunIn = T.lightPlfmSpk10mw(DRunIn_evoked);

lightPlfm5mw_DRwPn = T.lightPlfmSpk5mw(DRwPn_evoked);
lightPlfm8mw_DRwPn = T.lightPlfmSpk8mw(DRwPn_evoked);
lightPlfm10mw_DRwPn = T.lightPlfmSpk10mw(DRwPn_evoked);

lightPlfm5mw_DRwIn = T.lightPlfmSpk5mw(DRwIn_evoked);
lightPlfm8mw_DRwIn = T.lightPlfmSpk8mw(DRwIn_evoked);
lightPlfm10mw_DRwIn = T.lightPlfmSpk10mw(DRwIn_evoked);


%% Figure (DRun)
nCol = 3;
nRow = 3;

hInten(1) = axes('Position',axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],tightInterval));
plot([1,2,3],[lightPlfm5mw_DRunPn, lightPlfm8mw_DRunPn, lightPlfm10mw_DRunPn],'-o','Color',colorGray,'MarkerFaceColor',colorBlue,'MarkerEdgeColor','k','MarkerSize',markerM);
hold on;
plot([1,2,3],[mean(lightPlfm5mw_DRunPn), mean(lightPlfm8mw_DRunPn), mean(lightPlfm10mw_DRunPn)],'-o','Color','k','MarkerFaceColor','k','LineWidth',2,'MarkerSize',markerM);
text(3.5, 50,['n = ',num2str(length(lightPlfm5mw_DRunPn))]);
ylabel('Spike counts');

hInten(2) = axes('Position',axpt(nCol,nRow,1,3,[0.1 0.1 0.85 0.85], tightInterval));
plot([1,2,3],[lightPlfm5mw_DRunIn, lightPlfm8mw_DRunIn, lightPlfm10mw_DRunIn],'-o','Color',colorGray,'MarkerFaceColor',colorBlue,'MarkerEdgeColor','k','MarkerSize',markerM);
hold on;
plot([1,2,3],[mean(lightPlfm5mw_DRunIn), mean(lightPlfm8mw_DRunIn), mean(lightPlfm10mw_DRunIn)],'-o','Color','k','MarkerFaceColor','k','LineWidth',2,'MarkerSize',markerM);
text(3.5, 50,['n = ',num2str(length(lightPlfm5mw_DRunIn))]);
ylabel('Spike counts');

hInten(3) = axes('Position',axpt(nCol,nRow,3,1,[0.1 0.1 0.85 0.85], tightInterval));
plot([1,2,3],[lightPlfm5mw_DRwPn, lightPlfm8mw_DRwPn, lightPlfm10mw_DRwPn],'-o','Color',colorGray,'MarkerFaceColor',colorBlue,'MarkerEdgeColor','k','MarkerSize',markerM);
hold on;
plot([1,2,3],[mean(lightPlfm5mw_DRwPn), mean(lightPlfm8mw_DRwPn), mean(lightPlfm10mw_DRwPn)],'-o','Color','k','MarkerFaceColor','k','LineWidth',2,'MarkerSize',markerM);
text(3.5, 50,['n = ',num2str(length(lightPlfm5mw_DRwPn))]);
ylabel('Spike counts');

hInten(4) = axes('Position',axpt(nCol,nRow,3,3,[0.1 0.1 0.85 0.85], tightInterval));
plot([1,2,3],[lightPlfm5mw_DRwIn, lightPlfm8mw_DRwIn, lightPlfm10mw_DRwIn],'-o','Color',colorGray,'MarkerFaceColor',colorBlue,'MarkerEdgeColor','k','MarkerSize',markerM);
hold on;
plot([1,2,3],[mean(lightPlfm5mw_DRwIn), mean(lightPlfm8mw_DRwIn), mean(lightPlfm10mw_DRwIn)],'-o','Color','k','MarkerFaceColor','k','LineWidth',2,'MarkerSize',markerM);
text(3.5, 50,['n = ',num2str(length(lightPlfm5mw_DRwIn))]);
ylabel('Spike counts');

set(hInten,'Box','off','TickDir','out','XLim',[0,4],'XTick',[1:3],'XTickLabel',{'5mW','8mW','10mW'});
set(hInten(1),'YLim',[0,300]);
set(hInten(2),'YLim',[0,400]);
set(hInten(3),'YLim',[0,300]);
set(hInten(4),'YLim',[0,400]);

print('-painters','plot_laserIntensity2hz.tiff','-r300','-dtiff');
