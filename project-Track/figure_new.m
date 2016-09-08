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

tightInterval = [0.02 0.02]; midInterval = [0.09, 0.09]; wideInterval = [0.14 0.14];

markerS = 2.2; markerM = 4.4; markerL = 6.6;

scatterS = 26; scatterM = 36; scatterL = 54;

% Stimulation during running
load(['cellList_add','.mat']);

% Condition
lightPN = (T.taskProb == '100' & T.taskType == 'DRun' & T.meanFR_task>0 & T.meanFR_task<10 & T.pLR_tag<0.05 | T.pLR_modu<0.05);
lightIN = (T.taskProb == '100' & T.taskType == 'DRun' & T.meanFR_task>10 & T.pLR_tag<0.05 | T.pLR_modu<0.05);
nlightPN = sum(double(lightPN));
nlightIN = sum(double(lightIN));

lightPN_tagAc = lightPN & T.tagStatDir_tag == 1;
lightPN_tagNo = lightPN & T.tagStatDir_tag == 0;
lightPN_tagIn = lightPN & T.tagStatDir_tag == -1;

lightPN_ModuAc = lightPN & T.tagStatDir_modu == 1;
lightPN_ModuNo = lightPN & T.tagStatDir_modu == 0;
lightPN_ModuIn = lightPN & T.tagStatDir_modu == -1;
 
lightPopu = [sum(double(lightPN_tagAc)), sum(double(lightPN_tagNo)), sum(double(lightPN_tagIn));
            sum(double(lightPN_ModuAc)), sum(double(lightPN_ModuNo)), sum(double(lightPN_ModuIn))]'; % first column: base / second: track

laserBasePN_pre = T.lighttagPreSpk(lightPN);
laserBasePN_stm = T.lighttagSpk(lightPN);
laserBasePN_post = T.lighttagPostSpk(lightPN);

laserTrackPN_pre = T.lightPreSpk(lightPN);
laserTrackPN_stm = T.lightSpk(lightPN);
laserTrackPN_post = T.lightPostSpk(lightPN);

figure(1)
hBase(1) = axes('Position',axpt(4,2,1,1,[0.1 0.1 0.85 0.85],midInterval));
rectangle('Position',[1.7, 0, 0.6, max([laserBasePN_pre; laserBasePN_stm; laserBasePN_post])],'FaceColor',colorLightBlue,'EdgeColor','none');
hold on;
for iCell = 1:nlightPN
    plot([1,2,3],[laserBasePN_pre(iCell), laserBasePN_stm(iCell), laserBasePN_post(iCell)],'-o','Color',colorGray','MarkerFaceColor',colorGray,'MarkerEdgeColor','k');
    hold on;
    plot(2,laserBasePN_stm(iCell),'o','MarkerEdgeColor','k','MarkerFaceColor',colorBlue);
    hold on;
end
plot([1,2,3],[mean(laserBasePN_pre),mean(laserBasePN_stm),mean(laserBasePN_post)],'-o','MarkerFaceColor','k','Color','k','LineWidth',2);
text(3,max([laserBasePN_pre; laserBasePN_stm; laserBasePN_post])-10,['n = ',num2str(nlightPN)]);
ylabel('Spike number');
title('Baseline light response','fontSize',fontL);
set(hBase(1),'TickDir','out','XLim',[0,4],'YLim',[-1, max([laserBasePN_pre; laserBasePN_stm; laserBasePN_post])+10],'XTick',[1,2,3],'XTickLabel',{'Pre-stm','Stm','Post-stm'});

hBase(2) = axes('Position',axpt(4,2,2,1,[0.1 0.1 0.85 0.85],midInterval));
hold on;
scatter(laserBasePN_stm,laserBasePN_pre,'filled','o','MarkerEdgeColor','k','MarkerFacecColor',colorGray);
xlabel('Spike number (Stm)');
ylabel('Spike number (Pre)');



hBase(3) = axes('Position',axpt(4,2,3,1,[0.1 0.1 0.85 0.85],midInterval));
hold on;
scatter(laserBasePN_stm,laserBasePN_post);


hBase(4) = axes('Position',axpt(4,2,4,1,[0.1 0.1 0.85 0.85],midInterval));
hold on;
scatter(laserBasePN_pre_laserBasePN_post);

% 
% 
% hBasePopul(3) = axes('Position',axpt(4,2,3,1,[0.1 0.1 0.85 0.85],midInterval));
% 
% 
% hBasePopul(4) = axes('Position',axpt(4,2,4,1,[0.1 0.1 0.85 0.85],midInterval));


hTrack(1) = axes('Position',axpt(4,2,1,2,[0.1 0.1 0.85 0.85],midInterval));
rectangle('Position',[1.7, 0, 0.6, max([laserTrackPN_pre; laserTrackPN_stm; laserTrackPN_post])],'FaceColor',colorLightBlue,'EdgeColor','none');
hold on;
for iCell = 1:nlightPN
    plot([1,2,3],[laserTrackPN_pre(iCell), laserTrackPN_stm(iCell), laserTrackPN_post(iCell)],'-o','Color',colorGray','MarkerFaceColor',colorGray,'MarkerEdgeColor','k');
    hold on;
    plot(2,laserTrackPN_stm(iCell),'o','MarkerEdgeColor','k','MarkerFaceColor',colorBlue);
    hold on;
end
plot([1,2,3],[mean(laserTrackPN_pre),mean(laserTrackPN_stm),mean(laserTrackPN_post)],'-o','MarkerFaceColor','k','Color','k','LineWidth',2);
text(3,max([laserTrackPN_pre; laserTrackPN_stm; laserTrackPN_post])-10,['n = ',num2str(nlightPN)]);
ylabel('Spike number');
title('Track light response','fontSize',fontL);
set(hTrack(1),'TickDir','out','XLim',[0,4],'YLim',[-1,max([laserTrackPN_pre; laserTrackPN_stm; laserTrackPN_post])+10],'XTick',[1,2,3],'XTickLabel',{'Pre-stm','Stm','Post-stm'});