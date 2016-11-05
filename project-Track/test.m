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
load(['cellList_v3st','.mat']);
alpha = 0.01;

%% Condition
total_DRun = T.taskProb == '100' & T.taskType == 'DRun' & T.peakMap>1;
nTotal_DRun = sum(double(total_DRun));
PN = T.meanFR_task < 10;
% total_DRw = T.taskProb == '100' & T.taskType == 'DRw' & T.peakMap>1;
% nTotal_DRw = sum(double(total_DRw));
% total_No = T.taskProb == '100' & (T.taskType == 'noRun' | T.taskType == 'noRun') & T.peakMap>1;
% nTotal_No = sum(double(total_No));

%%
total_DRunPN = total_DRun & PN;
total_DRunIN = total_DRun & (~PN);

for iCondi = 1:27
    pn_pLR_PlfmAc(iCondi) = sum(double(T.pLR_Plfm2(total_DRunPN,iCondi)<0.05 & T.statDir_Plfm2(total_DRunPN,iCondi)==1));
    pn_pLR_PlfmIn(iCondi) = sum(double(T.pLR_Plfm2(total_DRunPN,iCondi)<0.05 & T.statDir_Plfm2(total_DRunPN,iCondi)==-1));
    pn_pLR_TrackAc(iCondi) = sum(double(T.pLR_Track2(total_DRunPN,iCondi)<0.05 & T.statDir_Track2(total_DRunPN,iCondi)==1));
    pn_pLR_TrackIn(iCondi) = sum(double(T.pLR_Track2(total_DRunPN,iCondi)<0.05 & T.statDir_Track2(total_DRunPN,iCondi)==-1));
    
    in_pLR_PlfmAc(iCondi) = sum(double(T.pLR_Plfm2(total_DRunIN,iCondi)<0.05 & T.statDir_Plfm2(total_DRunIN,iCondi)==1));
    in_pLR_PlfmIn(iCondi) = sum(double(T.pLR_Plfm2(total_DRunIN,iCondi)<0.05 & T.statDir_Plfm2(total_DRunIN,iCondi)==-1));
    in_pLR_TrackAc(iCondi) = sum(double(T.pLR_Track2(total_DRunIN,iCondi)<0.05 & T.statDir_Track2(total_DRunIN,iCondi)==1));
    in_pLR_TrackIn(iCondi) = sum(double(T.pLR_Track2(total_DRunIN,iCondi)<0.05 & T.statDir_Track2(total_DRunIN,iCondi)==-1));
end
%%

%% Figure (Base)
hPlfm = axes('Position',axpt(4,3,1:2,1:3,[0.1 0.1 0.85 0.85],midInterval));
plot([1:27],pn_pLR_PlfmAc,'-o','MarkerFaceColor',colorBlue,'Color','k');
hold on;
plot([1:27],pn_pLR_PlfmIn,'-o','MarkerFaceColor',colorLightBlue,'Color',colorBlue);
hold on;
plot([1:27],in_pLR_PlfmAc,'-o','MarkerFaceColor',colorRed,'Color',colorRed);
hold on;
plot([1:27],in_pLR_PlfmIn,'-o','MarkerFaceColor',colorLightRed,'Color',colorRed);
text(15,50,'DarkBlue: Activated PN','FontSize',fontL);
text(15,47,'LightBlue: Inactivated PN','FontSize',fontL);
text(15,44,'DarkRed: Activated IN','FontSize',fontL);
text(15,41,'LightRed: Inactivated IN','FontSize',fontL);
set(hPlfm,'XTick',[1:27],'XLim',[0,28],'YLim',[0,60],'TickDir','out','Box','off');
ylabel('# of neurons');
title('Light responsive neurons on Platform');

hTrack = axes('Position',axpt(4,3,3:4,1:3,[0.1 0.1 0.85 0.85],midInterval));
plot([1:27],pn_pLR_TrackAc,'-o','MarkerFaceColor',colorBlue,'Color','k');
hold on;
plot([1:27],pn_pLR_TrackIn,'-o','MarkerFaceColor',colorLightBlue,'Color',colorBlue);
hold on;
plot([1:27],in_pLR_TrackAc,'-o','MarkerFaceColor',colorRed,'Color','k');
hold on;
plot([1:27],in_pLR_TrackIn,'-o','MarkerFaceColor',colorLightRed,'Color',colorRed);
text(15,50,'DarkBlue: Activated PN','FontSize',fontL);
text(15,47,'LightBlue: Inactivated PN','FontSize',fontL);
text(15,44,'DarkRed: Activated IN','FontSize',fontL);
text(15,41,'LightRed: Inactivated IN','FontSize',fontL);
set(hTrack,'XTick',[1:27],'XLim',[0,28],'YLim',[0,60],'TickDir','out','Box','off');
ylabel('# of neurons');
xlabel('Conditions');
title('Light responsive neurons on Track');

print(gcf,'-dtiff','-r300','lightResponseNeuron2st');
% print(gcf,'-painters','-r300','Fig3_1_lightResponse_DRunPoster.ai','-depsc');