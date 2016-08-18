function fig6_firingRate_Rw()
% clearvars;
clf; close all;

lineWth = [1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75];
fontS = 4; % font size small
fontM = 6; % font size middle
fontL = 8; % font size large
lineS = 0.2; % line width small
lineM = 0.5; % line width middle
lineL = 1; % line width large

colorBlue = [33 150 243] ./ 255;
colorLightBlue = [223 239 252] ./ 255;
colorRed = [237 50 52] ./ 255;
colorLightRed = [242 138 130] ./ 255;
colorGray = [189 189 189] ./ 255;
colorLightGray = [238, 238, 238] ./255;
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

tightInterval = [0.02 0.02];
midInterval = [0.09 0.09];
wideInterval = [0.14 0.14];

markerS = 2.2;
markerM = 4.4;
markerL = 6.6;
scatterS = 26;
scatterM = 36;
scatterL = 54;
%
load(['cellList_new_100','.mat']);
T((T.taskType == 'nolight'),:) = [];
T(~(T.taskProb == '100'),:) = [];
% T(~(T.taskType == 'DRun' | T.taskType == 'noRun'),:) = [];

tDRw = T;
tnoRw = T;

tDRw(~(tDRw.taskType == 'DRw'),:) = [];
tnoRw(~(tnoRw.taskType == 'noRw'),:) = [];

pnDRw = tDRw.fr_task > 0 & tDRw.fr_task < 10;
inDRw = tDRw.fr_task > 10;
pnnoRw = tnoRw.fr_task > 0 & tnoRw.fr_task < 10;
innoRw = tnoRw.fr_task > 10;

npnDRw = sum(double(pnDRw));
npnnoRw = sum(double(pnnoRw));
snpnDRw = sum(double(pnDRw & (tDRw.lighttagPreSpk<20)) & (tDRw.lighttagSpk<25));
snpnnoRw = sum(double(pnnoRw & (tnoRw.lighttagPreSpk<20) & (tnoRw.lighttagSpk<25)));
ninDRw = sum(double(inDRw));
ninnoRw = sum(double(innoRw));

% PN
laserBasePN_pre = tDRw.lighttagPreSpk(pnDRw); % Baseline
laserBasePN_stm = tDRw.lighttagSpk(pnDRw);
laserBasePN_post = tDRw.lighttagPostSpk(pnDRw);

nolaserBasePN_pre = tnoRw.lighttagPreSpk(pnnoRw);
nolaserBasePN_stm = tnoRw.lighttagSpk(pnnoRw);
nolaserBasePN_post = tnoRw.lighttagPostSpk(pnnoRw);

laserTrackPN_pre = tDRw.lightPreSpk(pnDRw); % Track
laserTrackPN_stm = tDRw.lightSpk(pnDRw);
laserTrackPN_post = tDRw.lightPostSpk(pnDRw);

nolaserTrackPN_pre = tnoRw.lightPreSpk(pnnoRw);
nolaserTrackPN_stm = tnoRw.lightSpk(pnnoRw);
nolaserTrackPN_post = tnoRw.lightPostSpk(pnnoRw);

laserMeanFRPN_pre = tDRw.meanFR_pre(pnDRw); % Mean FR
laserMeanFRPN_stm = tDRw.meanFR_stm(pnDRw);
laserMeanFRPN_post = tDRw.meanFR_post(pnDRw);

nolaserMeanFRPN_pre = tnoRw.meanFR_pre(pnnoRw);
nolaserMeanFRPN_stm = tnoRw.meanFR_stm(pnnoRw);
nolaserMeanFRPN_post = tnoRw.meanFR_post(pnnoRw);

% Scale PN
scalelaserBasePN_pre = tDRw.lighttagPreSpk(pnDRw & (tDRw.lighttagPreSpk<20) & (tDRw.lighttagSpk<25)); % Baseline
scalelaserBasePN_stm = tDRw.lighttagSpk(pnDRw & (tDRw.lighttagPreSpk<20) & (tDRw.lighttagSpk<25));
scalelaserBasePN_post = tDRw.lighttagPostSpk(pnDRw & (tDRw.lighttagPreSpk<20) & (tDRw.lighttagSpk<25));

scalenolaserBasePN_pre = tnoRw.lighttagPreSpk(pnnoRw & (tnoRw.lighttagPreSpk<20) & (tnoRw.lighttagSpk<25));
scalenolaserBasePN_stm = tnoRw.lighttagSpk(pnnoRw & (tnoRw.lighttagPreSpk<20) & (tnoRw.lighttagSpk<25));
scalenolaserBasePN_post = tnoRw.lighttagPostSpk(pnnoRw & (tnoRw.lighttagPreSpk<20) & (tnoRw.lighttagSpk<25));

scalelaserTrackPN_pre = tDRw.lightPreSpk(pnDRw & (tDRw.lightPreSpk<20) & (tDRw.lightSpk<25)); % Track
scalelaserTrackPN_stm = tDRw.lightSpk(pnDRw & (tDRw.lightPreSpk<20) & (tDRw.lightSpk<25));
scalelaserTrackPN_post = tDRw.lightPostSpk(pnDRw & (tDRw.lightPreSpk<20) & (tDRw.lightSpk<25));

scalenolaserTrackPN_pre = tnoRw.lightPreSpk(pnnoRw & (tnoRw.lightPreSpk<20) & (tnoRw.lightSpk<25));
scalenolaserTrackPN_stm = tnoRw.lightSpk(pnnoRw & (tnoRw.lightPreSpk<20) & (tnoRw.lightSpk<25));
scalenolaserTrackPN_post = tnoRw.lightPostSpk(pnnoRw & (tnoRw.lightPreSpk<20) & (tnoRw.lightSpk<25));


% IN
laserBaseIN_pre = tDRw.lighttagPreSpk(inDRw);
laserBaseIN_stm = tDRw.lighttagSpk(inDRw);
laserBaseIN_post = tDRw.lighttagPostSpk(inDRw);

nolaserBaseIN_pre = tnoRw.lighttagPreSpk(innoRw);
nolaserBaseIN_stm = tnoRw.lighttagSpk(innoRw);
nolaserBaseIN_post = tnoRw.lighttagPostSpk(innoRw);

laserTrackIN_pre = tDRw.lightPreSpk(inDRw);
laserTrackIN_stm = tDRw.lightSpk(inDRw);
laserTrackIN_post = tDRw.lightPostSpk(inDRw);

nolaserTrackIN_pre = tnoRw.lightPreSpk(innoRw);
nolaserTrackIN_stm = tnoRw.lightSpk(innoRw);
nolaserTrackIN_post = tnoRw.lightPostSpk(innoRw);

laserMeanFRIN_pre = tDRw.meanFR_pre(inDRw); % Mean FR
laserMeanFRIN_stm = tDRw.meanFR_stm(inDRw);
laserMeanFRIN_post = tDRw.meanFR_post(inDRw);

nolaserMeanFRIN_pre = tnoRw.meanFR_pre(innoRw);
nolaserMeanFRIN_stm = tnoRw.meanFR_stm(innoRw);
nolaserMeanFRIN_post = tnoRw.meanFR_post(innoRw);

%%
figure(1) % Baseline firing rate comparison
hBaseFR(1) = axes('Position',axpt(2,2,1,1,[0.1, 0.1, 0.85, 0.85],wideInterval));
rectangle('Position',[1.7,0,0.6,max([laserBasePN_pre; laserBasePN_stm; laserBasePN_post])+10],'FaceColor',colorLightBlue,'EdgeColor','none');
hold on;
for iCell = 1:npnDRw
    plot([1, 2, 3],[laserBasePN_pre(iCell), laserBasePN_stm(iCell), laserBasePN_post(iCell)],'-o','Color',colorGray,'MarkerFaceColor',colorGray);
    hold on;
    plot(2,laserBasePN_stm(iCell),'o','MarkerEdgeColor','k','MarkerFaceColor',colorBlue);
    hold on;
end
plot([1, 2, 3],[mean(laserBasePN_pre), mean(laserBasePN_stm), mean(laserBasePN_post)],'-o','MarkerFaceColor','k','Color','k','LineWidth',2);
text(3,max([laserBasePN_pre; laserBasePN_stm; laserBasePN_post])-10,['n = ',num2str(npnDRw)]);
ylabel('Spikes number');
title('Baseline response (track stimulation)','fontSize',fontL);

hBaseFR(2) = axes('Position',axpt(2,2,2,1,[0.1, 0.1, 0.85, 0.85],wideInterval));
rectangle('Position',[1.7,0,0.6,max([laserBasePN_pre; laserBasePN_stm; laserBasePN_post])+10],'FaceColor',colorLightBlue,'EdgeColor','none');
hold on;
for iCell = 1:npnnoRw
    plot([1,2,3],[nolaserBasePN_pre(iCell), nolaserBasePN_stm(iCell), nolaserBasePN_post(iCell)],'-o','Color',colorGray,'MarkerFaceColor',colorGray);
    hold on;
    plot(2,nolaserBasePN_stm(iCell),'o','MarkerEdgeColor','k','MarkerFaceColor',colorBlue);
    hold on;
end
plot([1,2,3],[mean(nolaserBasePN_pre), mean(nolaserBasePN_stm), mean(nolaserBasePN_post)],'-o','MarkerFaceColor','k','Color','k','LineWidth',2);
text(3,max([nolaserBasePN_pre; nolaserBasePN_stm; nolaserBasePN_post])-10,['n = ',num2str(npnnoRw)]);
ylabel('Spikes number');
title('Baseline response (track without stimulation)','fontSize',fontL);

% Track firing rate comparison
hBaseFR(3) = axes('Position',axpt(2,2,1,2,[0.1 0.1 0.85 0.85],wideInterval));
rectangle('Position',[1.7,0,0.6,max([laserTrackPN_pre;laserTrackPN_stm;laserTrackPN_post])+10],'FaceColor',colorLightBlue,'EdgeColor','none');
hold on;
for iCell = 1:npnDRw
    plot([1,2,3],[laserTrackPN_pre(iCell), laserTrackPN_stm(iCell), laserTrackPN_post(iCell)],'-o','Color',colorGray,'MarkerFaceColor',colorGray);
    hold on;
    plot(2,laserTrackPN_stm(iCell),'o','MarkerEdgeColor','k','MarkerFaceColor',colorBlue);
    hold on;
end
plot([1,2,3],[mean(laserTrackPN_pre),mean(laserTrackPN_stm),mean(laserTrackPN_post)],'-o','MarkerFaceColor','k','Color','k','LineWidth',2);
text(3,max([laserTrackPN_pre; laserTrackPN_stm; laserTrackPN_post])-10,['n = ',num2str(npnDRw)]);
ylabel('Spikes number');
title('On-Track response (with stimulation)','fontSize',fontL);

hBaseFR(4) = axes('Position',axpt(2,2,2,2,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
rectangle('Position',[1.7,0,0.6,max([laserTrackPN_pre;laserTrackPN_stm;laserTrackPN_post])+10],'FaceColor',colorLightGray,'EdgeColor','none');
for iCell = 1:npnnoRw
    plot([1, 2, 3],[nolaserTrackPN_pre(iCell), nolaserTrackPN_stm(iCell), nolaserTrackPN_post(iCell)],'-o','Color',colorGray,'MarkerFaceColor',colorGray);
    hold on;
    plot(2,nolaserTrackPN_stm(iCell),'o','MarkerEdgeColor','k','MarkerFaceColor',colorGray,'MarkerEdgeColor','k');
    hold on;
end
plot([1,2,3],[mean(nolaserTrackPN_pre), mean(nolaserTrackPN_stm), mean(nolaserTrackPN_post)],'-o','MarkerFaceColor','k','Color','k','LineWidth',2);
text(3,max([laserTrackPN_pre; laserTrackPN_stm; laserTrackPN_post])-10,['n = ',num2str(npnnoRw)]);
ylabel('Spikes number');
title('On-Track response (without stimulation)','fontSize',fontL);

set(hBaseFR(1),'XLim',[0,4],'YLim',[-1, max([laserBasePN_pre;laserBasePN_stm;laserBasePN_post])+10],'XTick',[1,2,3],'XTickLabel',{'Pre-stm','Stm','Post-stm'});
set(hBaseFR(2),'XLim',[0,4],'YLim',[-1, max([laserBasePN_pre;laserBasePN_stm;laserBasePN_post])+10],'XTick',[1,2,3],'XTickLabel',{'Pre-stm','Stm','Post-stm'});
set(hBaseFR(3),'XLim',[0,4],'YLim',[-1, max([laserTrackPN_pre;laserTrackPN_stm;laserTrackPN_post])+10],'XTick',[1,2,3],'XTickLabel',{'Pre-stm','Stm','Post-stm'});
set(hBaseFR(4),'XLim',[0,4],'YLim',[-1, max([laserTrackPN_pre;laserTrackPN_stm;laserTrackPN_post])+10],'XTick',[1,2,3],'XTickLabel',{'Pre-stm','Stm','Post-stm'});
set(hBaseFR,'TickDir','out');
print(gcf,'-dtiff','-r300','LightResponse_PN_Rw');

%%
figure(2) % Interneuron
hBaseFR(1) = axes('Position',axpt(2,2,1,1,[0.1, 0.1, 0.85, 0.85],wideInterval));
rectangle('Position',[1.7,0,0.6,1000],'FaceColor',colorLightBlue,'EdgeColor','none');
hold on;
for iCell = 1:ninDRw
    plot([1, 2, 3],[laserBaseIN_pre(iCell), laserBaseIN_stm(iCell), laserBaseIN_post(iCell)],'-o','Color',colorGray,'MarkerFaceColor',colorGray);
    hold on;
    plot(2,laserBaseIN_stm(iCell),'o','MarkerEdgeColor','k','MarkerFaceColor',colorBlue);
    hold on;
end
plot([1, 2, 3],[mean(laserBaseIN_pre), mean(laserBaseIN_stm), mean(laserBaseIN_post)],'-o','MarkerFaceColor','k','Color','k','LineWidth',2);
text(3,800,['n = ',num2str(ninDRw)]);
ylabel('Spikes number');
title('Baseline response (track stimulation)','fontSize',fontL);

hBaseFR(2) = axes('Position',axpt(2,2,2,1,[0.1, 0.1, 0.85, 0.85],wideInterval));
rectangle('Position',[1.7,0,0.6,1000],'FaceColor',colorLightBlue,'EdgeColor','none');
hold on;
for iCell = 1:ninnoRw
    plot([1,2,3],[nolaserBaseIN_pre(iCell), nolaserBaseIN_stm(iCell), nolaserBaseIN_post(iCell)],'-o','Color',colorGray,'MarkerFaceColor',colorGray);
    hold on;
    plot(2,nolaserBaseIN_stm(iCell),'o','MarkerEdgeColor','k','MarkerFaceColor',colorBlue);
    hold on;
end
plot([1,2,3],[mean(nolaserBaseIN_pre), mean(nolaserBaseIN_stm), mean(nolaserBaseIN_post)],'-o','MarkerFaceColor','k','Color','k','LineWidth',2);
text(3,800,['n = ',num2str(ninnoRw)]);
ylabel('Spikes number');
title('Baseline response (track without stimulation)','fontSize',fontL);

% Track firing rate comparison
hBaseFR(3) = axes('Position',axpt(2,2,1,2,[0.1 0.1 0.85 0.85],wideInterval));
rectangle('Position',[1.7,0,0.6,300],'FaceColor',colorLightBlue,'EdgeColor','none');
hold on;
for iCell = 1:ninDRw
    plot([1,2,3],[laserTrackIN_pre(iCell), laserTrackIN_stm(iCell), laserTrackIN_post(iCell)],'-o','Color',colorGray,'MarkerFaceColor',colorGray);
    hold on;
    plot(2,laserTrackIN_stm(iCell),'o','MarkerEdgeColor','k','MarkerFaceColor',colorBlue);
    hold on;
end
plot([1,2,3],[mean(laserTrackIN_pre),mean(laserTrackIN_stm),mean(laserTrackIN_post)],'-o','MarkerFaceColor','k','Color','k','LineWidth',2);
text(3,200,['n = ',num2str(ninDRw)]);
ylabel('Spikes number');
title('On-Track response (with stimulation)','fontSize',fontL);

hBaseFR(4) = axes('Position',axpt(2,2,2,2,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
rectangle('Position',[1.7,0,0.6,300],'FaceColor',colorLightGray,'EdgeColor','none');
for iCell = 1:ninnoRw
    plot([1, 2, 3],[nolaserTrackIN_pre(iCell), nolaserTrackIN_stm(iCell), nolaserTrackIN_post(iCell)],'-o','Color',colorGray,'MarkerFaceColor',colorGray);
    hold on;
    plot(2,nolaserTrackIN_stm(iCell),'o','MarkerEdgeColor','k','MarkerFaceColor',colorGray);
    hold on;
end
plot([1,2,3],[mean(nolaserTrackIN_pre), mean(nolaserTrackIN_stm), mean(nolaserTrackIN_post)],'-o','MarkerFaceColor','k','Color','k','LineWidth',2);
text(3,200,['n = ',num2str(ninnoRw)]);
ylabel('Spikes number');
title('On-Track response (without stimulation)','fontSize',fontL);
set(hBaseFR(1),'XLim',[0,4],'YLim',[-1, 1000],'XTick',[1,2,3],'XTickLabel',{'Pre-stm','Stm','Post-stm'});
set(hBaseFR(2),'XLim',[0,4],'YLim',[-1, 1000],'XTick',[1,2,3],'XTickLabel',{'Pre-stm','Stm','Post-stm'});
set(hBaseFR(3),'XLim',[0,4],'YLim',[-1, 300],'XTick',[1,2,3],'XTickLabel',{'Pre-stm','Stm','Post-stm'});
set(hBaseFR(4),'XLim',[0,4],'YLim',[-1, 300],'XTick',[1,2,3],'XTickLabel',{'Pre-stm','Stm','Post-stm'});
set(hBaseFR,'TickDir','out');
print(gcf,'-dtiff','-r300','LightResponse_IN_Rw');

%% Track meanFR chagne
figure(3)
hMeanFR(1) = axes('Position',axpt(2,2,1,1,[0.1 0.1 0.85 0.85],wideInterval));
rectangle('Position',[1.7,0,0.6,max([laserMeanFRPN_pre;laserMeanFRPN_stm;laserMeanFRPN_post])+10],'FaceColor',colorLightBlue,'EdgeColor','none');
hold on;
for iCell = 1:npnDRw
    plot([1,2,3,],[laserMeanFRPN_pre(iCell),laserMeanFRPN_stm(iCell),laserMeanFRPN_post(iCell)],'-o','Color',colorGray,'MarkerFaceColor',colorGray);
    hold on;
    plot(2,laserMeanFRPN_stm,'o','MarkerEdgeColor','k','MarkerFaceColor',colorBlue);
    hold on;
end
plot([1,2,3,],[mean(laserMeanFRPN_pre),mean(laserMeanFRPN_stm),mean(laserMeanFRPN_post)],'-o','MarkerFaceColor','k','Color','k','LineWidth',2);
text(3,max([laserMeanFRPN_pre;laserMeanFRPN_pre;laserMeanFRPN_pre])-5,['n = ',num2str(npnDRw)]);
ylabel('Mean firing rate (Hz)');
title('Mean firing change (Stimulation sess)','fontSize',fontL);

hMeanFR(2) = axes('Position',axpt(2,2,2,1,[0.1 0.1 0.85 0.85],wideInterval));
rectangle('Position',[1.7,0,0.6,max([nolaserMeanFRPN_pre;nolaserMeanFRPN_stm;nolaserMeanFRPN_post])+10],'FaceColor',colorLightGray,'EdgeColor','none');
hold on;
for iCell = 1:npnnoRw
    plot([1,2,3,],[nolaserMeanFRPN_pre(iCell),nolaserMeanFRPN_stm(iCell),nolaserMeanFRPN_post(iCell)],'-o','Color',colorGray,'MarkerFaceColor',colorGray);
    hold on;
    plot(2,nolaserMeanFRPN_stm,'o','MarkerEdgeColor','k','MarkerFaceColor',colorGray,'MarkerEdgeColor','k');
    hold on;
end
plot([1,2,3,],[mean(nolaserMeanFRPN_pre),mean(nolaserMeanFRPN_stm),mean(nolaserMeanFRPN_post)],'-o','MarkerFaceColor','k','Color','k','LineWidth',2);
text(3,max([nolaserMeanFRPN_pre;nolaserMeanFRPN_pre;nolaserMeanFRPN_pre])-5,['n = ',num2str(npnnoRw)]);
ylabel('Mean firing rate (Hz)');
title('Mean firing change (No stimulation sess)','fontSize',fontL);

hMeanFR(3) = axes('Position',axpt(2,2,1,2,[0.1 0.1 0.85 0.85],wideInterval));
rectangle('Position',[1.7,0,0.6,max([laserMeanFRIN_pre;laserMeanFRIN_stm;laserMeanFRIN_post])+10],'FaceColor',colorLightBlue,'EdgeColor','none');
hold on;
for iCell = 1:ninDRw
    plot([1,2,3,],[laserMeanFRIN_pre(iCell),laserMeanFRIN_stm(iCell),laserMeanFRIN_post(iCell)],'-o','Color',colorGray,'MarkerFaceColor',colorGray);
    hold on;
    plot(2,laserMeanFRIN_stm,'o','MarkerEdgeColor','k','MarkerFaceColor',colorBlue);
    hold on;
end
plot([1,2,3,],[mean(laserMeanFRIN_pre),mean(laserMeanFRIN_stm),mean(laserMeanFRIN_post)],'-o','MarkerFaceColor','k','Color','k','LineWidth',2);
text(3,max([laserMeanFRIN_pre;laserMeanFRIN_pre;laserMeanFRIN_pre])-5,['n = ',num2str(ninDRw)]);
ylabel('Mean firing rate (Hz)');
title('Mean firing change (Stimulation sess)','fontSize',fontL);

hMeanFR(4) = axes('Position',axpt(2,2,2,2,[0.1 0.1 0.85 0.85],wideInterval));
rectangle('Position',[1.7,0,0.6,max([nolaserMeanFRIN_pre;nolaserMeanFRIN_stm;nolaserMeanFRIN_post])+10],'FaceColor',colorLightGray,'EdgeColor','none');
hold on;
for iCell = 1:ninnoRw
    plot([1,2,3,],[nolaserMeanFRIN_pre(iCell),nolaserMeanFRIN_stm(iCell),nolaserMeanFRIN_post(iCell)],'-o','Color',colorGray,'MarkerFaceColor',colorGray);
    hold on;
    plot(2,nolaserMeanFRIN_stm,'o','MarkerEdgeColor','k','MarkerFaceColor',colorGray,'MarkerEdgeColor','k');
    hold on;
end
plot([1,2,3,],[mean(nolaserMeanFRIN_pre),mean(nolaserMeanFRIN_stm),mean(nolaserMeanFRIN_post)],'-o','MarkerFaceColor','k','Color','k','LineWidth',2);
text(3,max([nolaserMeanFRIN_pre;nolaserMeanFRIN_pre;nolaserMeanFRIN_pre])-5,['n = ',num2str(ninnoRw)]);
ylabel('Mean firing rate (Hz)');
title('Mean firing change (No stimulation sess)','fontSize',fontL);

set(hMeanFR(1),'XLim',[0,4],'YLim',[-1, 10],'XTick',[1,2,3],'XTickLabel',{'Pre-stm','Stm','Post-stm'});
set(hMeanFR(2),'XLim',[0,4],'YLim',[-1, 10],'XTick',[1,2,3],'XTickLabel',{'Pre-stm','Stm','Post-stm'});
set(hMeanFR(3),'XLim',[0,4],'YLim',[-1, 50],'XTick',[1,2,3],'XTickLabel',{'Pre-stm','Stm','Post-stm'});
set(hMeanFR(4),'XLim',[0,4],'YLim',[-1, 50],'XTick',[1,2,3],'XTickLabel',{'Pre-stm','Stm','Post-stm'});
set(hMeanFR,'TickDir','out');
print(gcf,'-dtiff','-r300','LightResponse_MeanFR_Rw');

%%
figure(4)
hScaleFR(1) = axes('Position',axpt(2,2,1,1,[0.1, 0.1, 0.85, 0.85],wideInterval));
rectangle('Position',[1.7,0,0.6,max([scalelaserBasePN_pre; scalelaserBasePN_stm; scalelaserBasePN_post])+10],'FaceColor',colorLightBlue,'EdgeColor','none');
hold on;
for iCell = 1:snpnDRw
    plot([1, 2, 3],[scalelaserBasePN_pre(iCell), scalelaserBasePN_stm(iCell), scalelaserBasePN_post(iCell)],'-o','Color',colorGray,'MarkerFaceColor',colorGray);
    hold on;
    plot(2,scalelaserBasePN_stm(iCell),'o','MarkerEdgeColor','k','MarkerFaceColor',colorBlue);
    hold on;
end
plot([1, 2, 3],[mean(scalelaserBasePN_pre), mean(scalelaserBasePN_stm), mean(scalelaserBasePN_post)],'-o','MarkerFaceColor','k','Color','k','LineWidth',2);
text(3,20,['n = ',num2str(snpnDRw)]);
ylabel('Spikes number');
title('Baseline response (track stimulation)','fontSize',fontL);

hScaleFR(2) = axes('Position',axpt(2,2,2,1,[0.1, 0.1, 0.85, 0.85],wideInterval));
rectangle('Position',[1.7,0,0.6,max([scalelaserBasePN_pre; scalelaserBasePN_stm; scalelaserBasePN_post])+10],'FaceColor',colorLightBlue,'EdgeColor','none');
hold on;
for iCell = 1:snpnnoRw
    plot([1,2,3],[scalenolaserBasePN_pre(iCell), scalenolaserBasePN_stm(iCell), scalenolaserBasePN_post(iCell)],'-o','Color',colorGray,'MarkerFaceColor',colorGray);
    hold on;
    plot(2,scalenolaserBasePN_stm(iCell),'o','MarkerEdgeColor','k','MarkerFaceColor',colorBlue);
    hold on;
end
plot([1,2,3],[mean(scalenolaserBasePN_pre), mean(scalenolaserBasePN_stm), mean(scalenolaserBasePN_post)],'-o','MarkerFaceColor','k','Color','k','LineWidth',2);
text(3,20,['n = ',num2str(snpnnoRw)]);
ylabel('Spikes number');
title('Baseline response (track without stimulation)','fontSize',fontL);

% Track firing rate comparison
hScaleFR(3) = axes('Position',axpt(2,2,1,2,[0.1 0.1 0.85 0.85],wideInterval));
rectangle('Position',[1.7,0,0.6,max([scalelaserTrackPN_pre;scalelaserTrackPN_stm;scalelaserTrackPN_post])+10],'FaceColor',colorLightBlue,'EdgeColor','none');
hold on;
for iCell = 1:snpnDRw
    plot([1,2,3],[scalelaserTrackPN_pre(iCell), scalelaserTrackPN_stm(iCell), scalelaserTrackPN_post(iCell)],'-o','Color',colorGray,'MarkerFaceColor',colorGray);
    hold on;
    plot(2,scalelaserTrackPN_stm(iCell),'o','MarkerEdgeColor','k','MarkerFaceColor',colorBlue);
    hold on;
end
plot([1,2,3],[mean(scalelaserTrackPN_pre),mean(scalelaserTrackPN_stm),mean(scalelaserTrackPN_post)],'-o','MarkerFaceColor','k','Color','k','LineWidth',2);
text(3,20,['n = ',num2str(snpnDRw)]);
ylabel('Spikes number');
title('On-Track response (with stimulation)','fontSize',fontL);

hScaleFR(4) = axes('Position',axpt(2,2,2,2,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
rectangle('Position',[1.7,0,0.6,max([scalelaserTrackPN_pre;scalelaserTrackPN_stm;scalelaserTrackPN_post])+10],'FaceColor',colorLightGray,'EdgeColor','none');
for iCell = 1:snpnnoRw
    plot([1, 2, 3],[scalenolaserTrackPN_pre(iCell), scalenolaserTrackPN_stm(iCell), scalenolaserTrackPN_post(iCell)],'-o','Color',colorGray,'MarkerFaceColor',colorGray);
    hold on;
    plot(2,scalenolaserTrackPN_stm(iCell),'o','MarkerEdgeColor','k','MarkerFaceColor',colorGray);
    hold on;
end
plot([1,2,3],[mean(scalenolaserTrackPN_pre), mean(scalenolaserTrackPN_stm), mean(scalenolaserTrackPN_post)],'-o','MarkerFaceColor','k','Color','k','LineWidth',2);
text(3,20,['n = ',num2str(snpnnoRw)]);
ylabel('Spikes number');
title('On-Track response (without stimulation)','fontSize',fontL);

set(hScaleFR(1),'XLim',[0,4],'YLim',[-1, 25],'XTick',[1,2,3],'XTickLabel',{'Pre-stm','Stm','Post-stm'});
set(hScaleFR(2),'XLim',[0,4],'YLim',[-1, 25],'XTick',[1,2,3],'XTickLabel',{'Pre-stm','Stm','Post-stm'});
set(hScaleFR(3),'XLim',[0,4],'YLim',[-1, 25],'XTick',[1,2,3],'XTickLabel',{'Pre-stm','Stm','Post-stm'});
set(hScaleFR(4),'XLim',[0,4],'YLim',[-1, 25],'XTick',[1,2,3],'XTickLabel',{'Pre-stm','Stm','Post-stm'});
set(hScaleFR,'TickDir','out');
print(gcf,'-dtiff','-r300','Scale up_Rw');

%%
figure(5)
h2Dplot(1) = axes('Position',axpt(2,2,1,1,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
line([0,25],[0,25],'Color','k','LineWidth',1);
hold on;
scatter(scalelaserBasePN_stm,scalelaserBasePN_pre,scatterS,'filled','o','MarkerEdgeColor','k','MarkerFaceColor',colorGray)
xlabel('Spike number (Stm)');
ylabel('Spike number (Pre)');
title('Laser session_Baseline','interpreter','none');

h2Dplot(2) = axes('Position',axpt(2,2,2,1,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
line([0,25],[0,25],'Color','k','LineWidth',1);
hold on;
scatter(scalelaserBasePN_stm,scalelaserBasePN_post,scatterS,'filled','o','MarkerEdgeColor','k','MarkerFaceColor',colorGray)
xlabel('Spike number (Stm)');
ylabel('Spike number (Post)');
title('Laser session_Baseline','interpreter','none');

h2Dplot(3) = axes('Position',axpt(2,2,1,2,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
line([0,25],[0,25],'Color','k','LineWidth',1);
hold on;
scatter(scalenolaserBasePN_stm,scalenolaserBasePN_pre,scatterS,'filled','o','MarkerEdgeColor','k','MarkerFaceColor',colorGray)
xlabel('Spike number (Stm)');
ylabel('Spike number (Pre)');
title('No laser session_Baseline','interpreter','none');

h2Dplot(4) = axes('Position',axpt(2,2,2,2,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
line([0,25],[0,25],'Color','k','LineWidth',1);
hold on;
scatter(scalenolaserBasePN_stm,scalenolaserBasePN_post,scatterS,'filled','o','MarkerEdgeColor','k','MarkerFaceColor',colorGray)
xlabel('Spike number (Stm)');
ylabel('Spike number (Post)');
title('No laser session_Baseline','interpreter','none');

set(h2Dplot,'XLim',[-1,25],'YLim',[-1, 25],'TickDir','out');
print(gcf,'-dtiff','-r300','2D-plotBaseline_Rw');

%%
figure(6)
h2Dplot(1) = axes('Position',axpt(2,2,1,1,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
line([0,25],[0,25],'Color','k','LineWidth',1);
hold on;
scatter(scalelaserTrackPN_stm,scalelaserTrackPN_pre,scatterS,'filled','o','MarkerEdgeColor','k','MarkerFaceColor',colorGray)
xlabel('Spike number (Stm)');
ylabel('Spike number (Pre)');
title('Laser session_Track','interpreter','none');

h2Dplot(2) = axes('Position',axpt(2,2,2,1,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
line([0,25],[0,25],'Color','k','LineWidth',1);
hold on;
scatter(scalelaserTrackPN_stm,scalelaserTrackPN_post,scatterS,'filled','o','MarkerEdgeColor','k','MarkerFaceColor',colorGray)
xlabel('Spike number (Stm)');
ylabel('Spike number (Post)');
title('Laser session_Track','interpreter','none');

h2Dplot(3) = axes('Position',axpt(2,2,1,2,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
line([0,25],[0,25],'Color','k','LineWidth',1);
hold on;
scatter(scalenolaserTrackPN_stm,scalenolaserTrackPN_pre,scatterS,'filled','o','MarkerEdgeColor','k','MarkerFaceColor',colorGray)
xlabel('Spike number (Stm)');
ylabel('Spike number (Pre)');
title('No laser session_Track','interpreter','none');

h2Dplot(4) = axes('Position',axpt(2,2,2,2,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
line([0,25],[0,25],'Color','k','LineWidth',1);
hold on;
scatter(scalenolaserTrackPN_stm,scalenolaserTrackPN_post,scatterS,'filled','o','MarkerEdgeColor','k','MarkerFaceColor',colorGray)
xlabel('Spike number (Stm)');
ylabel('Spike number (Post)');
title('No laser session_Track','interpreter','none');

set(h2Dplot,'XLim',[-1,25],'YLim',[-1, 25],'TickDir','out');
print(gcf,'-dtiff','-r300','2D-plot_Track_Rw');
%%
figure(7)
h2Dplot_meanFR(1) = axes('Position',axpt(2,2,1,1,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
line([0,25],[0,25],'Color','k','LineWidth',1);
hold on;
scatter(laserMeanFRPN_stm,laserMeanFRPN_pre,scatterS,'filled','o','MarkerEdgeColor','k','MarkerFaceColor',colorGray)
xlabel('Mean FR [Hz] (Stm)');
ylabel('Mean FR [Hz] (Pre)');
title('Laser session_Track','interpreter','none');

h2Dplot_meanFR(2) = axes('Position',axpt(2,2,2,1,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
line([0,25],[0,25],'Color','k','LineWidth',1);
hold on;
scatter(laserMeanFRPN_stm,laserMeanFRPN_post,scatterS,'filled','o','MarkerEdgeColor','k','MarkerFaceColor',colorGray)
xlabel('Mean FR [Hz] (Stm)');
ylabel('Mean FR [Hz] (Post)');
title('Laser session_Track','interpreter','none');

h2Dplot_meanFR(3) = axes('Position',axpt(2,2,1,2,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
line([0,25],[0,25],'Color','k','LineWidth',1);
hold on;
scatter(nolaserMeanFRPN_stm,nolaserMeanFRPN_pre,scatterS,'filled','o','MarkerEdgeColor','k','MarkerFaceColor',colorGray)
xlabel('Mean FR [Hz] (Stm)');
ylabel('Mean FR [Hz] (Pre)');
title('No laser session_Track','interpreter','none');

h2Dplot_meanFR(4) = axes('Position',axpt(2,2,2,2,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
line([0,25],[0,25],'Color','k','LineWidth',1);
hold on;
scatter(nolaserMeanFRPN_stm,nolaserMeanFRPN_post,scatterS,'filled','o','MarkerEdgeColor','k','MarkerFaceColor',colorGray)
xlabel('Mean FR [Hz] (Stm)');
ylabel('Mean FR [Hz] (Post)');
title('No laser session_Track','interpreter','none');

set(h2Dplot_meanFR,'XLim',[-1,10],'YLim',[-1, 10],'TickDir','out');
print(gcf,'-dtiff','-r300','2D-plot_TrackMeanFR_Rw');