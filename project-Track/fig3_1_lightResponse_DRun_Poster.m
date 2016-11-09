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
alpha = 0.001;

%% Condition
total_DRun = T.taskProb == '100' & T.taskType == 'DRun' & T.peakMap>1;
nTotal_DRun = sum(double(total_DRun));
PN = T.meanFR_task < 10;
% total_DRw = T.taskProb == '100' & T.taskType == 'DRw' & T.peakMap>1;
% nTotal_DRw = sum(double(total_DRw));
% total_No = T.taskProb == '100' & (T.taskType == 'noRun' | T.taskType == 'noRun') & T.peakMap>1;
% nTotal_No = sum(double(total_No));

%% Base light response
groupBaseA = total_DRun & T.pLR_Plfm<alpha & (T.statDir_Plfm == 1) & PN;
groupBaseA_in = total_DRun & T.pLR_Plfm<alpha & (T.statDir_Plfm == 1) & ~PN;
groupBaseB = total_DRun & T.pLR_Plfm<alpha & (T.statDir_Plfm == -1) & PN;
groupBaseB_in = total_DRun & T.pLR_Plfm<alpha & (T.statDir_Plfm == -1) & ~PN;
% groupBaseC = total_DRun & T.pLR_Plfm<alpha & (T.statDir_Plfm == 0);
groupBaseD = total_DRun & ~(T.pLR_Plfm<alpha);
groupBaseE = total_DRun & ~(T.pLR_Plfm<alpha) & ~PN;

meanFRBaseA = mean(T.meanFR_base(groupBaseA));
meanFRBaseA_in = mean(T.meanFR_base(groupBaseA_in));
meanFRBaseB = mean(T.meanFR_base(groupBaseB));
meanFRBaseB_in = mean(T.meanFR_base(groupBaseB_in));
meanFRBaseD = mean(T.meanFR_base(groupBaseD));
meanFRBaseE = mean(T.meanFR_base(groupBaseE));

stdFRBaseA = std(T.meanFR_base(groupBaseA));
stdFRBaseA_in = std(T.meanFR_base(groupBaseA_in));
stdFRBaseB = std(T.meanFR_base(groupBaseB));
stdFRBaseB_in = std(T.meanFR_base(groupBaseB_in));
stdFRBaseD = std(T.meanFR_base(groupBaseD));
stdFRBaseE = std(T.meanFR_base(groupBaseE));

ngroupBaseA = sum(double(groupBaseA));
ngroupBaseA_in = sum(double(groupBaseA_in));
ngroupBaseB = sum(double(groupBaseB));
ngroupBaseB_in = sum(double(groupBaseB_in));
ngroupBaseD = sum(double(groupBaseD));
ngroupBaseE = sum(double(groupBaseE));

latencyBaseA = mean(T.latencyPlfm(groupBaseA));
latencyBaseA_in = mean(T.latencyPlfm(groupBaseA_in));
latencyBaseB = mean(T.latencyPlfm(groupBaseB));
latencyBaseB_in = mean(T.latencyPlfm(groupBaseB_in));
latencyBaseD = mean(T.latencyPlfm(groupBaseD));
latencyBaseE = mean(T.latencyPlfm(groupBaseE));

stdLatBaseA = std(T.latencyPlfm(groupBaseA));
stdLatBaseA_in = std(T.latencyPlfm(groupBaseA_in));
stdLatBaseB = std(T.latencyPlfm(groupBaseB));
stdLatBaseB_in = std(T.latencyPlfm(groupBaseB));
stdLatBaseD = std(T.latencyPlfm(groupBaseD));
stdLatBaseE = std(T.latencyPlfm(groupBaseE));

% groupBaseF = total_DRun & ~(T.pLR_Plfm<alpha) & (T.statDir_Plfm == 0);
basePie = [sum(double(groupBaseA)),sum(double(groupBaseA_in)), sum(double(groupBaseB)), sum(double(groupBaseB_in)), sum(double(groupBaseD))];
labelsBase = {'PN activated: ';'IN activated: ';'PN inactivated: ';'IN inactivated: ';'PN unmodulated: '};

lightBase_pre = T.lighttagPreSpk(total_DRun & T.pLR_Plfm<alpha);
lightBase_stm = T.lighttagSpk(total_DRun & T.pLR_Plfm<alpha);
lightBase_post = T.lighttagPostSpk(total_DRun & T.pLR_Plfm<alpha);

yLimlightBase = max([lightBase_pre; lightBase_stm; lightBase_post])*1.1;

d_StmPre = (log10(lightBase_stm)-log10(lightBase_pre))/sqrt(2);
d_StmPost = (log10(lightBase_stm)-log10(lightBase_post))/sqrt(2);
d_PrePost = (log10(lightBase_pre)-log10(lightBase_post))/sqrt(2);
%% Track light response
groupTrackA = total_DRun & T.pLR_Track<alpha & (T.statDir_Track == 1) & ~(T.pLR_Track_pre<alpha) & PN;
groupTrackA_in = total_DRun & T.pLR_Track<alpha & (T.statDir_Track == 1) & ~(T.pLR_Track_pre<alpha) & ~PN;
groupTrackB = total_DRun & T.pLR_Track<alpha & (T.statDir_Track == -1) & ~(T.pLR_Track_pre<alpha) & PN;
groupTrackB_in = total_DRun & T.pLR_Track<alpha & (T.statDir_Track == -1) & ~(T.pLR_Track_pre<alpha) & ~PN;
% groupTrackC = total_DRun & T.pLR_Track<alpha & (T.statDir_Track == 0);
groupTrackD = (total_DRun & ~(T.pLR_Track<alpha)) | (total_DRun & T.pLR_Track<alpha & T.pLR_Track_pre<alpha);
groupTrackE = total_DRun & ~(T.pLR_Track<alpha) & ~PN;
% groupTrackF = total_DRun & ~(T.pLR_Track<alpha) & (T.statDir_Track == 0);

ngroupTrackA = sum(double(groupTrackA));
ngroupTrackA_in = sum(double(groupTrackA_in));
ngroupTrackB = sum(double(groupTrackB));
ngroupTrackB_in = sum(double(groupTrackB_in));
ngroupTrackD = sum(double(groupTrackD));
ngroupTrackE = sum(double(groupTrackE));

meanFRTrackA = mean(T.meanFR_task(groupTrackA));
meanFRTrackA_in = mean(T.meanFR_task(groupTrackA_in));
meanFRTrackB = mean(T.meanFR_task(groupTrackB));
meanFRTrackB_in = mean(T.meanFR_task(groupTrackB_in));
meanFRTrackD = mean(T.meanFR_task(groupTrackD));
meanFRTrackE = mean(T.meanFR_task(groupTrackE));

stdFRTrackA = std(T.meanFR_task(groupTrackA));
stdFRTrackA_in = std(T.meanFR_task(groupTrackA_in));
stdFRTrackB = std(T.meanFR_task(groupTrackB));
stdFRTrackB_in = std(T.meanFR_task(groupTrackB_in));
stdFRTrackD = std(T.meanFR_task(groupTrackD));
stdFRTrackE = std(T.meanFR_task(groupTrackE));

latencyTrackA = mean(T.latencyTrack(groupTrackA));
latencyTrackA_in = mean(T.latencyTrack(groupTrackA_in));
latencyTrackB = mean(T.latencyTrack(groupTrackB));
latencyTrackB_in = mean(T.latencyTrack(groupTrackB_in));
latencyTrackD = mean(T.latencyTrack(groupTrackD));
latencyTrackE = mean(T.latencyTrack(groupTrackE));

stdLatTrackA = std(T.latencyTrack(groupTrackA));
stdLatTrackA_in = std(T.latencyTrack(groupTrackA_in));
stdLatTrackB = std(T.latencyTrack(groupTrackB));
stdLatTrackB_in = std(T.latencyTrack(groupTrackB));
stdLatTrackD = std(T.latencyTrack(groupTrackD));
stdLatTrackE = std(T.latencyTrack(groupTrackE));

trackPie = [sum(double(groupTrackA)),sum(double(groupTrackA_in)), sum(double(groupTrackB)), sum(double(groupTrackB_in)), sum(double(groupTrackD))];
labelsTrack = {'PN activated: ';'IN activated: ';'PN inactivated: ';'IN inactivated: ';'PN unmodulated: '};

lightTrack_pre = T.lightPreSpk(total_DRun & T.pLR_Track<alpha);
lightTrack_stm = T.lightSpk(total_DRun & T.pLR_Track<alpha);
lightTrack_post = T.lightPostSpk(total_DRun & T.pLR_Track<alpha);

yLimlightTrack = max([lightTrack_pre; lightTrack_stm; lightTrack_post])*1.1;

%% Latency analysis
% latencyBase_Act = T.testLatencyPlfm2(groupBaseA);
% latencyBase_ActIN = T.testLatencyPlfm2(groupBaseA_in);
% latencyTrack_Act = T.testLatencyTrack2(groupTrackA);
% latencyTrack_ActIN = T.testLatencyTrack2(groupTrackA_in);
latencyBase_Act = T.latencyPlfm(groupBaseA);
latencyBase_ActIN = T.latencyPlfm(groupBaseA_in);
latencyTrack_Act = T.latencyTrack(groupTrackA);
latencyTrack_ActIN = T.latencyTrack(groupTrackA_in);
%% Figure (Base)
hBase(1) = axes('Position',axpt(10,4,1:2,1,[0.1 0.1 0.85 0.85],midInterval));
fBasePie = pie(basePie);
hBaseText = findobj(fBasePie,'Type','text');
valueBase = {num2str(basePie(1)); num2str(basePie(2)); num2str(basePie(3)); num2str(basePie(4)); num2str(basePie(5))};
hBaseColor = findobj(fBasePie,'Type','patch');
set(hBaseText,{'String'},strcat(labelsBase,valueBase ),'FontSize',fontL);
set(hBaseColor(1),'FaceColor',colorBlue);
set(hBaseColor(2),'FaceColor',colorRed);
set(hBaseColor(3),'FaceColor',colorLightBlue);
set(hBaseColor(4),'FaceColor',colorLightRed);
set(hBaseColor(5),'FaceColor',colorDarkGray);

hBase(2) = axes('Position',axpt(10,4,4:5,1,[0.1 0.1 0.85 0.85],midInterval));
bar(1:2:31,histc(latencyBase_Act,0:2:30),1,'FaceColor',colorBlue);
hold on;
bar(1:2:31,histc(latencyBase_ActIN,0:2:30),1,'FaceColor',colorRed);
% line([nanmedian(latencyBase_Act), nanmedian(latencyBase_Act)],[0,20],'Color',colorRed,'LineWidth',1.5);
text(18,18,['Activated neurons (n = ',num2str(sum(histc([latencyBase_Act;latencyBase_ActIN],0:2:30))),')'],'FontSize',fontL);
% text(18,16,['Latency: ',num2str(nanmedian(latencyBase_Act),3),' ms'],'FontSize',fontL);
xlabel('Latency (ms)','FontSize',fontL);
ylabel('Number of cells','FontSize',fontL);

% hBase(3) = axes('Position',axpt(5,4,3,1,[0.1 0.1 0.85 0.85],midInterval));
% bar(1:2:31,histc(latencyBase_Inalast,0:2:30),1,'FaceColor',colorLightGray);
% hold on;
% bar(1:2:31,histc(latencyBase_Inafirst,0:2:30),1,'FaceColor',colorGray);
% line([nanmedian(latencyBase_Inalast),nanmedian(latencyBase_Inalast)],[0,20],'Color',colorRed,'LineWidth',1.5);
% line([nanmedian(latencyBase_Inafirst),nanmedian(latencyBase_Inafirst)],[0,20],'Color',colorRed,'LineWidth',1.5);
% text(8,18,['Inactivated neurons (n = ',num2str(sum(histc(latencyBase_Inalast,0:2:30))),')'],'FontSize',fontL);
% text(8,16,['1st line: ',num2str(nanmedian(latencyBase_Inalast),3),' ms'],'FontSize',fontL);
% text(8,14,['2nd line: ',num2str(nanmedian(latencyBase_Inafirst),3),' ms'],'FontSize',fontL);
% xlabel('Latency (ms)','FontSize',fontL);
% ylabel('Number of cells','FontSize',fontL);

hBase(3) = axes('Position',axpt(10,4,7:8,1,[0.1 0.1 0.85 0.85],midInterval));
rectangle('Position',[1.7, -10, 0.6, yLimlightBase+10],'FaceColor',colorLightBlue,'EdgeColor','none');
hold on;
for iCell = 1:sum(double(total_DRun & T.pLR_Plfm<alpha))
    plot([1,2,3],[lightBase_pre(iCell), lightBase_stm(iCell), lightBase_post(iCell)],'-o','Color',colorGray,'MarkerFaceColor',colorGray,'MarkerEdgeColor','k','MarkerSize',markerM);
    hold on;
    plot(2,lightBase_stm(iCell),'o','MarkerEdgeColor','k','MarkerFaceColor',colorBlue,'MarkerSize',markerM);
    hold on;
end
plot([1,2,3],[mean(lightBase_pre),mean(lightBase_stm),mean(lightBase_post)],'-o','MarkerFaceColor','k','Color','k','LineWidth',2,'MarkerSize',markerM);
text(3,yLimlightBase*0.8,['n = ',num2str(sum(double(total_DRun & T.pLR_Plfm<alpha)))],'FontSize',fontL);
ylabel('Spike number','FontSize',fontL);

hBase(4) = axes('Position',axpt(10,4,1:2,2,[0.1 0.1 0.85 0.85],midInterval));
line([1,yLimlightBase],[1,yLimlightBase],'Color','k','LineWidth',1);
hold on;
scatter(lightBase_stm,lightBase_pre,markerXL,'filled','o','MarkerEdgeColor','k','MarkerFaceColor',colorGray);
xlabel('Spike number [Stm] ','fontSize',fontL);
ylabel('Spike number [Pre] ','fontSize',fontL);

hBase(5) = axes('Position',axpt(10,4,4:5,2,[0.1 0.1 0.85 0.85],midInterval));
line([1,yLimlightBase],[1,yLimlightBase],'Color','k','LineWidth',1);
hold on;
scatter(lightBase_stm,lightBase_post,markerXL,'filled','o','MarkerEdgeColor','k','MarkerFaceColor',colorGray);
xlabel('Spike number [Stm] ','fontSize',fontL);
ylabel('Spike number [Post] ','fontSize',fontL);

hBase(6) = axes('Position',axpt(10,4,7:8,2,[0.1 0.1 0.85 0.85],midInterval));
line([1,yLimlightBase],[1,yLimlightBase],'Color','k','LineWidth',1);
hold on;
scatter(lightBase_pre,lightBase_post,markerXL,'filled','o','MarkerEdgeColor','k','MarkerFaceColor',colorGray);
xlabel('Spike number [Pre] ','fontSize',fontL);
ylabel('Spike number [Post] ','fontSize',fontL);

set(hBase(2:6),'TickDir','out','FontSize',fontL,'Box','off')
set(hBase(3),'XLim',[0,4],'YLim',[-10,yLimlightBase],'XTick',[1,2,3],'XTickLabel',{'Pre','Stm','Post'});
set(hBase(2),'XLim',[0,30],'YLim',[0,20],'XTick',[0:4:30]);
set(hBase(4:6),'XLim',[1,yLimlightBase],'YLim',[1,yLimlightBase],'XScale','log','YScale','log');

%% Figure (Track)
hTrack(1) = axes('Position',axpt(10,4,1:2,3,[0.1 0.1 0.85 0.85],midInterval));
fTrackPie = pie(trackPie);
hTrackText = findobj(fTrackPie,'Type','text');
% percentValueTrack = get(hTrackText,'String');
valueTrack = {num2str(trackPie(1)); num2str(trackPie(2)); num2str(trackPie(3)); num2str(trackPie(4)); num2str(trackPie(5))};
hTrackColor = findobj(fTrackPie,'Type','patch');
set(hTrackText,{'String'},strcat(labelsTrack,valueTrack ),'FontSize',fontL);
set(hTrackColor(1),'FaceColor',colorBlue);
set(hTrackColor(2),'FaceColor',colorRed);
set(hTrackColor(3),'FaceColor',colorLightBlue);
set(hTrackColor(4),'FaceColor',colorLightRed);
set(hTrackColor(5),'FaceColor',colorDarkGray);

hTrack(2) = axes('Position',axpt(10,4,4:5,3,[0.1 0.1 0.85 0.85],midInterval));
bar(1:2:31,histc(latencyTrack_Act,0:2:30),1,'FaceColor',colorBlue);
hold on;
bar(1:2:31,histc(latencyTrack_ActIN,0:2:30),1,'FaceColor',colorRed);
% line([nanmedian(latencyTrack_Act), nanmedian(latencyTrack_Act)],[0,20],'Color',colorRed,'LineWidth',1.5);
text(18,18,['Activated neurons (n = ',num2str(sum(histc([latencyTrack_Act;latencyTrack_ActIN],0:2:30))),')'],'FontSize',fontL);
% text(18,16,['Latency: ',num2str(nanmedian(latencyTrack_Act),3),' ms'],'FontSize',fontL);
xlabel('Latency (ms)','FontSize',fontL);
ylabel('Number of cells','FontSize',fontL);

% hTrack(3) = axes('Position',axpt(5,4,3,3,[0.1 0.1 0.85 0.85],midInterval));
% bar(1:2:31,histc(latencyTrack_Inalast,0:2:30),1,'FaceColor',colorLightGray);
% hold on;
% bar(1:2:31,histc(latencyTrack_Inafirst,0:2:30),1,'FaceColor',colorGray);
% line([nanmedian(latencyTrack_Inalast),nanmedian(latencyTrack_Inalast)],[0,20],'Color',colorRed,'LineWidth',1.5);
% line([nanmedian(latencyTrack_Inafirst),nanmedian(latencyTrack_Inafirst)],[0,20],'Color',colorRed,'LineWidth',1.5);
% text(8,18,['Inactivated neuron (n = ',num2str(sum(histc(latencyTrack_Inalast,0:2:30))),')'],'FontSize',fontL);
% text(8,16,['1st line: ',num2str(nanmedian(latencyTrack_Inalast),3),' ms'],'FontSize',fontL);
% text(8,14,['2nd line: ',num2str(nanmedian(latencyTrack_Inafirst),3),' ms'],'FontSize',fontL);
% xlabel('Latency (ms)','FontSize',fontL);
% ylabel('Number of cells','FontSize',fontL);

hTrack(3) = axes('Position',axpt(10,4,7:8,3,[0.1 0.1 0.85 0.85],midInterval));
rectangle('Position',[1.7, -10, 0.6, yLimlightTrack+10],'FaceColor',colorLightBlue,'EdgeColor','none');
hold on;
for iCell = 1:sum(double(total_DRun & T.pLR_Track<alpha & T.pLR_Track_pre>alpha))
    plot([1,2,3],[lightTrack_pre(iCell), lightTrack_stm(iCell), lightTrack_post(iCell)],'-o','Color',colorGray,'MarkerFaceColor',colorGray,'MarkerEdgeColor','k','MarkerSize',markerM);
    hold on;
    plot(2,lightTrack_stm(iCell),'o','MarkerEdgeColor','k','MarkerFaceColor',colorBlue,'MarkerSize',markerM);
    hold on;
end
plot([1,2,3],[mean(lightTrack_pre),mean(lightTrack_stm),mean(lightTrack_post)],'-o','MarkerFaceColor','k','Color','k','LineWidth',2,'MarkerSize',markerM);
text(3,yLimlightTrack*0.8,['n = ',num2str(sum(double(total_DRun & T.pLR_Track<alpha & T.pLR_Track_pre>alpha)))],'FontSize',fontL);
ylabel('Spike number','FontSize',fontL);

hTrack(4) = axes('Position',axpt(10,4,1:2,4,[0.1 0.1 0.85 0.85],midInterval));
line([1,yLimlightTrack],[1,yLimlightTrack],'Color','k','LineWidth',1);
hold on;
scatter(lightTrack_stm,lightTrack_pre,markerXL,'filled','o','MarkerEdgeColor','k','MarkerFaceColor',colorGray);
xlabel('Spike number [Stm] ','fontSize',fontL);
ylabel('Spike number [Pre] ','fontSize',fontL);

hTrack(5) = axes('Position',axpt(10,4,4:5,4,[0.1 0.1 0.85 0.85],midInterval));
line([1,yLimlightTrack],[1,yLimlightTrack],'Color','k','LineWidth',1);
hold on;
scatter(lightTrack_stm,lightTrack_post,markerXL,'filled','o','MarkerEdgeColor','k','MarkerFaceColor',colorGray);
xlabel('Spike number [Stm] ','fontSize',fontL);
ylabel('Spike number [Post] ','fontSize',fontL);

hTrack(6) = axes('Position',axpt(10,4,7:8,4,[0.1 0.1 0.85 0.85],midInterval));
line([1,yLimlightTrack],[1,yLimlightTrack],'Color','k','LineWidth',1);
hold on;
scatter(lightTrack_pre,lightTrack_post,markerXL,'filled','o','MarkerEdgeColor','k','MarkerFaceColor',colorGray);
xlabel('Spike number [Pre] ','fontSize',fontL);
ylabel('Spike number [Post] ','fontSize',fontL);

set(hTrack(2:6),'TickDir','out','FontSize',fontL,'Box','off')
set(hTrack(3),'XLim',[0,4],'YLim',[-10,yLimlightTrack],'XTick',[1,2,3],'XTickLabel',{'Pre','Stm','Post'});
set(hTrack(2),'XLim',[0,30],'YLim',[0,20],'XTick',[0:4:30]);
set(hTrack(4:6),'XLim',[1,yLimlightTrack],'YLim',[1,yLimlightTrack],'XScale','log','YScale','log');

print(gcf,'-painters','-r300','Fig3_1_lightResponse_DRunPoster.ai','-depsc');