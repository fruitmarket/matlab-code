% clearvars;
clf; close all;

lineWth = [1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75];
fontS = 4; fontM = 6; fontL = 8; % font size
lineS = 0.2; lineM = 0.5; lineL = 1; % line width
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
rtDir_sig = 'D:\Dropbox\SNL\P2_Track\cellFigNoRun_lightSig';
rtDir_nosig = 'D:\Dropbox\SNL\P2_Track\cellFigNoRun_lightNoSig';

%% Conditio
% totalPN = T.taskProb == '100' & T.taskType == 'DRun' & T.meanFR_task>0 & T.meanFR_task<10;
% totalIN = T.taskProb == '100' & T.taskType == 'DRun' & T.meanFR_task>10;
% nTotalPN = sum(double(totalPN));
% nTotalIN = sum(double(totalIN));

% nototalPN = T.taskProb == '100' & T.taskType == 'noRun' & T.meanFR_task>0 & T.meanFR_task<10;
% nototalIN = T.taskProb == '100' & T.taskType == 'noRun' & T.meanFR_task>10;
% nonTotalPN = sum(double(nototalPN));
% nonTotalIN = sum(double(nototalIN));

totalPN = T.taskProb == '100' & T.taskType == 'DRw' & T.meanFR_task>0 & T.meanFR_task<10;
totalIN = T.taskProb == '100' & T.taskType == 'DRw' & T.meanFR_task>10;
nTotalPN = sum(double(totalPN));
nTotalIN = sum(double(totalIN));

% nototalPN = T.taskProb == '100' & T.taskType == 'noRw' & T.meanFR_task>0 & T.meanFR_task<10;
% nototalIN = T.taskProb == '100' & T.taskType == 'noRw' & T.meanFR_task>10;
% nonTotalPN = sum(double(nototalPN));
% nonTotalIN = sum(double(nototalIN));
%%
lightPN = (totalPN & T.pLR_tag<0.05) | (totalPN & T.pLR_modu<0.05);
lightIN = (totalIN & T.pLR_tag<0.05) | (totalIN & T.pLR_modu<0.05);
nlightPN = sum(double(lightPN));
nlightIN = sum(double(lightIN));

lightIN_tagAc = lightIN & T.statDir_tag == 1;
% lightIN_tagNo = lightIN & T.statDir_tag == 0;
lightIN_tagIn = lightIN & T.statDir_tag == -1;

lightIN_ModuAc = lightIN & T.statDir_modu == 1;
% lightIN_ModuNo = lightIN & T.statDir_modu == 0;
lightIN_ModuIn = lightIN & T.statDir_modu == -1;
 
lightPopu = [sum(double(lightIN_tagAc)), sum(double(lightIN_tagIn));
            sum(double(lightIN_ModuAc)), sum(double(lightIN_ModuIn))]'; % first column: base / second: track

laserBaseIN_pre = T.lighttagPreSpk(lightIN);
laserBaseIN_stm = T.lighttagSpk(lightIN);
laserBaseIN_post = T.lighttagPostSpk(lightIN);

laserTrackIN_pre = T.lightPreSpk(lightIN);
laserTrackIN_stm = T.lightSpk(lightIN);
laserTrackIN_post = T.lightPostSpk(lightIN);

ylimBase = max([laserBaseIN_pre; laserBaseIN_stm; laserBaseIN_post]);
ylimTrack = max([laserTrackIN_pre; laserTrackIN_stm; laserTrackIN_post]);

%% Single cell figure separation
% figList_DRunlightIN_sig = T.Path(lightIN);
% trackPlot_v3_multifig(figList_DRunlightIN_sig,rtDir_sig);
% 
% figList_DRunlightIN_nosig = T.Path((totalIN & ~(T.pLR_tag < 0.05)) & (totalIN & ~(T.pLR_modu < 0.05)));
% trackPlot_v3_multifig(figList_DRunlightIN_nosig,rtDir_nosig);
% cd('D:\Dropbox\SNL\P2_Track');


%% Light response_Total cell
totalBaseIN_pre = T.lighttagPreSpk(totalIN);
totalBaseIN_stm = T.lighttagSpk(totalIN);
totalBaseIN_post = T.lighttagPostSpk(totalIN);

totalTrackIN_pre = T.lightPreSpk(totalIN);
totalTrackIN_stm = T.lightSpk(totalIN);
totalTrackIN_post = T.lightPostSpk(totalIN);

ylimTotalBase = max([totalBaseIN_pre; totalBaseIN_stm; totalBaseIN_post]);
ylimTotalTrack = max([totalTrackIN_pre; totalTrackIN_stm; totalTrackIN_post]);

hTotalBase(1) = axes('Position',axpt(4,2,1,1,[0.1 0.1 0.85 0.85],midInterval));
rectangle('Position',[1.7, 0, 0.6, ylimTotalBase*1.1],'FaceColor',colorLightBlue,'EdgeColor','none');
hold on;
for iCell = 1:nTotalIN
    plot([1,2,3],[totalBaseIN_pre(iCell), totalBaseIN_stm(iCell), totalBaseIN_post(iCell)],'-o','Color',colorGray','MarkerFaceColor',colorGray,'MarkerEdgeColor','k','MarkerSize',markerM);
    hold on;
    plot(2,totalBaseIN_stm(iCell),'o','MarkerEdgeColor','k','MarkerFaceColor',colorBlue,'MarkerSize',markerM);
    hold on;
end
plot([1,2,3],[mean(totalBaseIN_pre),mean(totalBaseIN_stm),mean(totalBaseIN_post)],'-o','MarkerFaceColor','k','Color','k','LineWidth',2,'MarkerSize',markerM);
text(3,ylimTotalBase*0.9,['n = ',num2str(nTotalIN)],'FontSize',fontL);
ylabel('Spike number','fontSize',fontM);
title('Total baseline light response','fontSize',fontM);

hTotalBase(2) = axes('Position',axpt(4,2,2,1,[0.1 0.1 0.85 0.85],midInterval));
line([0,ylimTotalBase*1.1],[0,ylimTotalBase*1.1],'Color','k','LineWidth',1);
hold on;
scatter(totalBaseIN_stm,totalBaseIN_pre,markerXL,'filled','o','MarkerEdgeColor','k','MarkerFaceColor',colorGray);
xlabel('Spike number (Stm)','fontSize',fontM);
ylabel('Spike number (Pre)','fontSize',fontM);
title('Total baseline light response','fontSize',fontM);

hTotalBase(3) = axes('Position',axpt(4,2,3,1,[0.1 0.1 0.85 0.85],midInterval));
line([0,ylimBase*1.1],[0,ylimBase*1.1],'Color','k','LineWidth',1);
hold on;
scatter(totalBaseIN_stm,totalBaseIN_post,markerXL,'filled','o','MarkerEdgeColor','k','MarkerFaceColor',colorGray);
xlabel('Spike number (Stm)','fontSize',fontM);
ylabel('Spike number (Post)','fontSize',fontM);
title('Total baseline light response','fontSize',fontM);

hTotalBase(4) = axes('Position',axpt(4,2,4,1,[0.1 0.1 0.85 0.85],midInterval));
line([0,ylimTotalBase*1.1],[0,ylimTotalBase*1.1],'Color','k','LineWidth',1);
hold on;
scatter(totalBaseIN_pre,totalBaseIN_post,markerXL,'filled','o','MarkerEdgeColor','k','MarkerFaceColor',colorGray);
xlabel('Spike number (pre)','fontSize',fontM);
ylabel('Spike number (Post)','fontSize',fontM);
title('Baseline light response','fontSize',fontM);

set(hTotalBase,'TickDir','out','fontSize',fontM);
set(hTotalBase(1),'TickDir','out','XLim',[0,4],'YLim',[-1, ylimTotalBase*1.1],'XTick',[1,2,3],'XTickLabel',{'Pre-stm','Stm','Post-stm'});
set(hTotalBase(2),'XLim',[0,ylimTotalBase*1.1],'YLim',[0,ylimTotalBase*1.1]);
set(hTotalBase(3),'XLim',[0,ylimTotalBase*1.1],'YLim',[0,ylimTotalBase*1.1]);
set(hTotalBase(4),'XLim',[0,ylimTotalBase*1.1],'YLim',[0,ylimTotalBase*1.1]);

hTotalTrack(1) = axes('Position',axpt(4,2,1,2,[0.1 0.1 0.85 0.85],midInterval));
rectangle('Position',[1.7, 0, 0.6, ylimTotalTrack*1.1],'FaceColor',colorLightBlue,'EdgeColor','none');
hold on;
for iCell = 1:nTotalIN
    plot([1,2,3],[totalTrackIN_pre(iCell), totalTrackIN_stm(iCell), totalTrackIN_post(iCell)],'-o','Color',colorGray','MarkerFaceColor',colorGray,'MarkerEdgeColor','k','MarkerSize',markerM);
    hold on;
    plot(2,totalTrackIN_stm(iCell),'o','MarkerEdgeColor','k','MarkerFaceColor',colorBlue,'MarkerSize',markerM);
    hold on;
end
plot([1,2,3],[mean(totalTrackIN_pre),mean(totalTrackIN_stm),mean(totalTrackIN_post)],'-o','MarkerFaceColor','k','Color','k','LineWidth',2,'MarkerSize',markerM);
text(3, ylimTrack*0.9, ['n = ',num2str(nTotalIN)],'FontSize',fontL);
ylabel('Spike number','fontSize',fontM);
title('Track light response','fontSize',fontM);

hTotalTrack(2) = axes('Position',axpt(4,2,2,2,[0.1 0.1 0.85 0.85],midInterval));
line([0,ylimTotalBase*1.1],[0,ylimTotalBase*1.1],'Color','k','LineWidth',1);
hold on;
scatter(totalTrackIN_stm,totalTrackIN_pre,markerXL,'filled','o','MarkerEdgeColor','k','MarkerFaceColor',colorGray);
xlabel('Spike number (Stm)','fontSize',fontM);
ylabel('Spike number (Pre)','fontSize',fontM);
title('Track light response','fontSize',fontM);

hTotalTrack(3) = axes('Position',axpt(4,2,3,2,[0.1 0.1 0.85 0.85],midInterval));
line([0,ylimTotalBase*1.1],[0,ylimTotalBase*1.1],'Color','k','LineWidth',1);
hold on;
scatter(totalTrackIN_stm,totalTrackIN_post,markerXL,'filled','o','MarkerEdgeColor','k','MarkerFaceColor',colorGray);
xlabel('Spike number (Stm)','fontSize',fontM);
ylabel('Spike number (Post)','fontSize',fontM);
title('Track light response','fontSize',fontM);

hTotalTrack(4) = axes('Position',axpt(4,2,4,2,[0.1 0.1 0.85 0.85],midInterval));
line([0,ylimTotalBase*1.1],[0,ylimTotalBase*1.1],'Color','k','LineWidth',1);
hold on;
scatter(totalTrackIN_pre,totalTrackIN_post,markerXL,'filled','o','MarkerEdgeColor','k','MarkerFaceColor',colorGray);
xlabel('Spike number (pre)','fontSize',fontM);
ylabel('Spike number (Post)','fontSize',fontM);
title('Track light response','fontSize',fontM);

set(hTotalTrack,'TickDir','out','fontSize',fontM);
set(hTotalTrack(1),'TickDir','out','XLim',[0,4],'YLim',[-1, ylimTotalTrack*1.1],'XTick',[1,2,3],'XTickLabel',{'Pre-stm','Stm','Post-stm'});
set(hTotalTrack(2),'XLim',[0,ylimTotalBase*1.1],'YLim',[0,ylimTotalBase*1.1]);
set(hTotalTrack(3),'XLim',[0,ylimTotalBase*1.1],'YLim',[0,ylimTotalBase*1.1]);
set(hTotalTrack(4),'XLim',[0,ylimTotalBase*1.1],'YLim',[0,ylimTotalBase*1.1]);

print(gcf,'-dtiff','-r300','DRwIN_Light response_total')
%% Light Response_pLR cell
figure(2)
hPie(1) = axes('Position',axpt(4,4,1,1,[0.1 0.1 0.85 0.85],midInterval));
labels = {'Act: ';'InAct: '};
fPie = pie(lightPopu(:,1));
hText = findobj(fPie,'Type','text');
percentValue = get(hText,'String');
hColor = findobj(fPie,'Type','patch');
set(hText,{'String'},strcat(labels,percentValue),'FontSize',fontL);
set(hColor(1),'FaceColor',colorBlue);
set(hColor(2),'FaceColor',colorDarkGray);
% set(hColor(3),'FaceColor',colorLightGray);

hBase(1) = axes('Position',axpt(4,4,1,2,[0.1 0.1 0.85 0.85],midInterval));
rectangle('Position',[1.7, 0, 0.6, ylimBase*1.1],'FaceColor',colorLightBlue,'EdgeColor','none');
hold on;
for iCell = 1:nlightIN
    plot([1,2,3],[laserBaseIN_pre(iCell), laserBaseIN_stm(iCell), laserBaseIN_post(iCell)],'-o','Color',colorGray','MarkerFaceColor',colorGray,'MarkerEdgeColor','k','MarkerSize',markerM);
    hold on;
    plot(2,laserBaseIN_stm(iCell),'o','MarkerEdgeColor','k','MarkerFaceColor',colorBlue,'MarkerSize',markerM);
    hold on;
end
plot([1,2,3],[mean(laserBaseIN_pre),mean(laserBaseIN_stm),mean(laserBaseIN_post)],'-o','MarkerFaceColor','k','Color','k','LineWidth',2,'MarkerSize',markerM);
text(3,ylimBase*0.9,['n = ',num2str(nlightIN)],'FontSize',fontL);
ylabel('Spike number','fontSize',fontM);
title('Baseline light response','fontSize',fontM);

hBase(2) = axes('Position',axpt(4,4,2,2,[0.1 0.1 0.85 0.85],midInterval));
line([0,ylimBase*1.1],[0,ylimBase*1.1],'Color','k','LineWidth',1);
hold on;
scatter(laserBaseIN_stm,laserBaseIN_pre,markerXL,'filled','o','MarkerEdgeColor','k','MarkerFaceColor',colorGray);
xlabel('Spike number (Stm)','fontSize',fontM);
ylabel('Spike number (Pre)','fontSize',fontM);
title('Baseline light response','fontSize',fontM);

hBase(3) = axes('Position',axpt(4,4,3,2,[0.1 0.1 0.85 0.85],midInterval));
line([0,ylimBase*1.1],[0,ylimBase*1.1],'Color','k','LineWidth',1);
hold on;
scatter(laserBaseIN_stm,laserBaseIN_post,markerXL,'filled','o','MarkerEdgeColor','k','MarkerFaceColor',colorGray);
xlabel('Spike number (Stm)','fontSize',fontM);
ylabel('Spike number (Post)','fontSize',fontM);
title('Baseline light response','fontSize',fontM);

hBase(4) = axes('Position',axpt(4,4,4,2,[0.1 0.1 0.85 0.85],midInterval));
line([0,ylimBase*1.1],[0,ylimBase*1.1],'Color','k','LineWidth',1);
hold on;
scatter(laserBaseIN_pre,laserBaseIN_post,markerXL,'filled','o','MarkerEdgeColor','k','MarkerFaceColor',colorGray);
xlabel('Spike number (pre)','fontSize',fontM);
ylabel('Spike number (Post)','fontSize',fontM);
title('Baseline light response','fontSize',fontM);

set(hBase,'TickDir','out','FontSize',fontM);
set(hBase(1),'TickDir','out','XLim',[0,4],'YLim',[0,ylimBase*1.1],'XTick',[1,2,3],'XTickLabel',{'Pre-stm','Stm','Post-stm'});
set(hBase(2),'XLim',[0,ylimBase*1.1],'YLim',[0,ylimBase*1.1]);
set(hBase(3),'XLim',[0,ylimBase*1.1],'YLim',[0,ylimBase*1.1]);
set(hBase(4),'XLim',[0,ylimBase*1.1],'YLim',[0,ylimBase*1.1]);

hPie(2) = axes('Position',axpt(4,4,1,3,[0.1 0.1 0.85 0.85],midInterval));
labels = {'Act: ';'InAct: '};
fPie = pie(lightPopu(:,2));
hText = findobj(fPie,'Type','text');
percentValue = get(hText,'String');
hColor = findobj(fPie,'Type','patch');
set(hText,{'String'},strcat(labels,percentValue),'FontSize',fontL);
set(hColor(1),'FaceColor',colorBlue);
set(hColor(2),'FaceColor',colorDarkGray);
% set(hColor(3),'FaceColor',colorLightGray);

hTrack(1) = axes('Position',axpt(4,4,1,4,[0.1 0.1 0.85 0.85],midInterval));
rectangle('Position',[1.7, 0, 0.6, ylimTrack*1.1],'FaceColor',colorLightBlue,'EdgeColor','none');
hold on;
for iCell = 1:nlightIN
    plot([1,2,3],[laserTrackIN_pre(iCell), laserTrackIN_stm(iCell), laserTrackIN_post(iCell)],'-o','Color',colorGray','MarkerFaceColor',colorGray,'MarkerEdgeColor','k','MarkerSize',markerM);
    hold on;
    plot(2,laserTrackIN_stm(iCell),'o','MarkerEdgeColor','k','MarkerFaceColor',colorBlue,'MarkerSize',markerM);
    hold on;
end
plot([1,2,3],[mean(laserTrackIN_pre),mean(laserTrackIN_stm),mean(laserTrackIN_post)],'-o','MarkerFaceColor','k','Color','k','LineWidth',2,'MarkerSize',markerM);
text(3, ylimTrack*0.9, ['n = ',num2str(nlightIN)],'FontSize',fontL);
ylabel('Spike number','fontSize',fontM);
title('Track light response','fontSize',fontM);

hTrack(2) = axes('Position',axpt(4,4,2,4,[0.1 0.1 0.85 0.85],midInterval));
line([0,ylimBase*1.1],[0,ylimBase*1.1],'Color','k','LineWidth',1);
hold on;
scatter(laserTrackIN_stm,laserTrackIN_pre,markerXL,'filled','o','MarkerEdgeColor','k','MarkerFaceColor',colorGray);
xlabel('Spike number (Stm)','fontSize',fontM);
ylabel('Spike number (Pre)','fontSize',fontM);
title('Track light response','fontSize',fontM);

hTrack(3) = axes('Position',axpt(4,4,3,4,[0.1 0.1 0.85 0.85],midInterval));
line([0,ylimBase*1.1],[0,ylimBase*1.1],'Color','k','LineWidth',1);
hold on;
scatter(laserTrackIN_stm,laserTrackIN_post,markerXL,'filled','o','MarkerEdgeColor','k','MarkerFaceColor',colorGray);
xlabel('Spike number (Stm)','fontSize',fontM);
ylabel('Spike number (Post)','fontSize',fontM);
title('Track light response','fontSize',fontM);

hTrack(4) = axes('Position',axpt(4,4,4,4,[0.1 0.1 0.85 0.85],midInterval));
line([0,ylimBase*1.1],[0,ylimBase*1.1],'Color','k','LineWidth',1);
hold on;
scatter(laserTrackIN_pre,laserTrackIN_post,markerXL,'filled','o','MarkerEdgeColor','k','MarkerFaceColor',colorGray);
xlabel('Spike number (pre)','fontSize',fontM);
ylabel('Spike number (Post)','fontSize',fontM);
title('Track light response','fontSize',fontM);

set(hTrack,'TickDir','out','fontSize',fontM);
set(hTrack(1),'TickDir','out','XLim',[0,4],'YLim',[-1, ylimTrack*1.1],'XTick',[1,2,3],'XTickLabel',{'Pre-stm','Stm','Post-stm'});
set(hTrack(2),'XLim',[0,ylimTrack*1.1],'YLim',[0,ylimTrack*1.1]);
set(hTrack(3),'XLim',[0,ylimTrack*1.1],'YLim',[0,ylimTrack*1.1]);
set(hTrack(4),'XLim',[0,ylimTrack*1.1],'YLim',[0,ylimTrack*1.1]);
print(gcf,'-dtiff','-r300','DRwIN_Light response_light cell')