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
total_DRun = T.taskProb == '100' & T.taskType == 'DRun' & T.peakMap>1;
nTotal_DRun = sum(double(total_DRun));

% total_DRw = T.taskProb == '100' & T.taskType == 'DRw' & T.peakMap>1;
% nTotal_DRw = sum(double(total_DRw));
% total_No = T.taskProb == '100' & (T.taskType == 'noRun' | T.taskType == 'noRun') & T.peakMap>1;
% nTotal_No = sum(double(total_No));

%% Venn diagram
popBaseOnly = total_DRun & (T.pLR_tag<0.05 & ~(T.pLR_modu<0.05));
npopBaseOnly = sum(double(popBaseOnly));
popTrackOnly = total_DRun & (~(T.pLR_tag<0.05) & T.pLR_modu<0.05);
npopTrackOnly = sum(double(popTrackOnly));
popBoth = total_DRun & (T.pLR_tag<0.05 & T.pLR_modu<0.05);
npopBoth = sum(double(popBoth)); 
popNeither = total_DRun & (~(T.pLR_tag<0.05) & ~(T.pLR_modu<0.05));
npopNeither = sum(double(popNeither));

%% Base light response
groupBaseA = total_DRun & T.pLR_tag<0.05 & (T.statDir_tag == 1);
groupBaseB = total_DRun & T.pLR_tag<0.05 & (T.statDir_tag == -1);
groupBaseC = total_DRun & T.pLR_tag<0.05 & (T.statDir_tag == 0);
groupBaseD = total_DRun & ~(T.pLR_tag<0.05) & (T.statDir_tag == 1);
groupBaseE = total_DRun & ~(T.pLR_tag<0.05) & (T.statDir_tag == -1);
groupBaseF = total_DRun & ~(T.pLR_tag<0.05) & (T.statDir_tag == 0);
basePie = [sum(double(groupBaseA)), sum(double(groupBaseB)), sum(double(total_DRun & ~(T.pLR_tag<0.05)))];
labelsBase = {'Activated: ';'Inactivated: ';'Unmodulated: '};

lightBase_pre = T.lighttagPreSpk(total_DRun & T.pLR_tag<0.05);
lightBase_stm = T.lighttagSpk(total_DRun & T.pLR_tag<0.05);
lightBase_post = T.lighttagPostSpk(total_DRun & T.pLR_tag<0.05);

yLimlightBase = max([lightBase_pre; lightBase_stm; lightBase_post])*1.1;

%% Track light response
groupTrackA = total_DRun & T.pLR_modu<0.05 & (T.statDir_modu == 1);
groupTrackB = total_DRun & T.pLR_modu<0.05 & (T.statDir_modu == -1);
groupTrackC = total_DRun & T.pLR_modu<0.05 & (T.statDir_modu == 0);
groupTrackD = total_DRun & ~(T.pLR_modu<0.05) & (T.statDir_modu == 1);
groupTrackE = total_DRun & ~(T.pLR_modu<0.05) & (T.statDir_modu == -1);
groupTrackF = total_DRun & ~(T.pLR_modu<0.05) & (T.statDir_modu == 0);
trackPie = [sum(double(groupTrackA)), sum(double(groupTrackB)), sum(double(total_DRun & ~(T.pLR_modu<0.05)))];
labelsTrack = {'Activated: ';'Inactivated: ';'Unmodulated: '};

lightTrack_pre = T.lightPreSpk(total_DRun & T.pLR_modu<0.05);
lightTrack_stm = T.lightSpk(total_DRun & T.pLR_modu<0.05);
lightTrack_post = T.lightPostSpk(total_DRun & T.pLR_modu<0.05);

yLimlightTrack = max([lightTrack_pre; lightTrack_stm; lightTrack_post])*1.1;

%% Latency analysis
latencyBase_Act = T.testLatencyTag_first(groupBaseA);
latencyBase_Inalast = T.ina_lastSpk_tag(groupBaseB);
latencyBase_Inafirst = T.ina_firstSpk_tag(groupBaseB);

latencyTrack_Act = T.testLatencyModu_first(groupTrackA);
latencyTrack_Inalast = T.ina_lastSpk_modu(groupTrackB);
latencyTrack_Inafirst = T.ina_firstSpk_modu(groupTrackB);

%% Figure (Base)
hBase(1) = axes('Position',axpt(5,4,1,1,[0.1 0.1 0.85 0.85],midInterval));
fBasePie = pie(basePie);
hBaseText = findobj(fBasePie,'Type','text');
percentValueBase = get(hBaseText,'String');
hBaseColor = findobj(fBasePie,'Type','patch');
set(hBaseText,{'String'},strcat(labelsBase,percentValueBase),'FontSize',fontL);
set(hBaseColor(1),'FaceColor',colorBlue);
set(hBaseColor(2),'FaceColor',colorDarkGray);
set(hBaseColor(3),'FaceColor',colorLightGray);

hBase(2) = axes('Position',axpt(5,4,2,1,[0.1 0.1 0.85 0.85],midInterval));
bar(1:2:31,histc(latencyBase_Act,0:2:30),1,'FaceColor',colorBlue);
line([nanmedian(latencyBase_Act), nanmedian(latencyBase_Act)],[0,20],'Color',colorRed,'LineWidth',1.5);
text(18,16,['Activated neurons (n = ',num2str(sum(histc(latencyBase_Act,0:2:30))),')'],'FontSize',fontL);
text(18,14,['Latency: ',num2str(nanmedian(latencyBase_Act),3),' ms'],'FontSize',fontL);
xlabel('Latency (ms)','FontSize',fontL);
ylabel('Number of cells','FontSize',fontL);

hBase(3) = axes('Position',axpt(5,4,3,1,[0.1 0.1 0.85 0.85],midInterval));
bar(1:2:31,histc(latencyBase_Inalast,0:2:30),1,'FaceColor',colorLightGray);
hold on;
bar(1:2:31,histc(latencyBase_Inafirst,0:2:30),1,'FaceColor',colorGray);
line([nanmedian(latencyBase_Inalast),nanmedian(latencyBase_Inalast)],[0,20],'Color',colorRed,'LineWidth',1.5);
line([nanmedian(latencyBase_Inafirst),nanmedian(latencyBase_Inafirst)],[0,20],'Color',colorRed,'LineWidth',1.5);
text(18,18,['n_1 = ',num2str(sum(histc(latencyBase_Inalast,0:2:30)))],'FontSize',fontL);
text(18,16,['n_2 = ',num2str(sum(histc(latencyBase_Inafirst,0:2:30)))],'FontSize',fontL);
text(18,14,['1st line: ',num2str(nanmedian(latencyBase_Inalast),3),' ms'],'FontSize',fontL);
text(18,12,['2nd line: ',num2str(nanmedian(latencyBase_Inafirst),3),' ms'],'FontSize',fontL);
xlabel('Latency (ms)','FontSize',fontL);
ylabel('Number of cells','FontSize',fontL);

hBase(4) = axes('Position',axpt(5,4,1,2,[0.1 0.1 0.85 0.85],midInterval));
rectangle('Position',[1.7, -10, 0.6, yLimlightBase+10],'FaceColor',colorLightBlue,'EdgeColor','none');
hold on;
for iCell = 1:sum(double(total_DRun & T.pLR_tag<0.05))
    plot([1,2,3],[lightBase_pre(iCell), lightBase_stm(iCell), lightBase_post(iCell)],'-o','Color',colorGray,'MarkerFaceColor',colorGray,'MarkerEdgeColor','k','MarkerSize',markerM);
    hold on;
    plot(2,lightBase_stm(iCell),'o','MarkerEdgeColor','k','MarkerFaceColor',colorBlue,'MarkerSize',markerM);
    hold on;
end
plot([1,2,3],[mean(lightBase_pre),mean(lightBase_stm),mean(lightBase_post)],'-o','MarkerFaceColor','k','Color','k','LineWidth',2,'MarkerSize',markerM);
text(3,yLimlightBase*0.8,['n = ',num2str(sum(double(total_DRun & T.pLR_tag<0.05)))],'FontSize',fontL);
ylabel('Spike number','FontSize',fontM);

hBase(5) = axes('Position',axpt(5,4,2,2,[0.1 0.1 0.85 0.85],midInterval));
line([0,yLimlightBase],[0,yLimlightBase],'Color','k','LineWidth',1);
hold on;
scatter(lightBase_stm,lightBase_pre,markerXL,'filled','o','MarkerEdgeColor','k','MarkerFaceColor',colorGray);
xlabel('Spike number [Stm] ','fontSize',fontM);
ylabel('Spike number [Pre] ','fontSize',fontM);

hBase(6) = axes('Position',axpt(5,4,3,2,[0.1 0.1 0.85 0.85],midInterval));
line([0,yLimlightBase],[0,yLimlightBase],'Color','k','LineWidth',1);
hold on;
scatter(lightBase_stm,lightBase_post,markerXL,'filled','o','MarkerEdgeColor','k','MarkerFaceColor',colorGray);
xlabel('Spike number [Stm] ','fontSize',fontM);
ylabel('Spike number [Post] ','fontSize',fontM);

hBase(7) = axes('Position',axpt(5,4,4,2,[0.1 0.1 0.85 0.85],midInterval));
line([0,yLimlightBase],[0,yLimlightBase],'Color','k','LineWidth',1);
hold on;
scatter(lightBase_pre,lightBase_post,markerXL,'filled','o','MarkerEdgeColor','k','MarkerFaceColor',colorGray);
xlabel('Spike number [Pre] ','fontSize',fontM);
ylabel('Spike number [Post] ','fontSize',fontM);

set(hBase(2:7),'TickDir','out','FontSize',fontM,'Box','off')
set(hBase(4),'XLim',[0,4],'YLim',[-10,yLimlightBase],'XTick',[1,2,3],'XTickLabel',{'Pre','Stm','Post'});
set(hBase(2:3),'XLim',[0,30],'YLim',[0,20],'XTick',[0:4:30]);
set(hBase(5:7),'XLim',[-10,yLimlightBase],'YLim',[-10,yLimlightBase]);

%% Figure (Track)
hTrack(1) = axes('Position',axpt(5,4,1,3,[0.1 0.1 0.85 0.85],midInterval));
fTrackPie = pie(trackPie);
hTrackText = findobj(fTrackPie,'Type','text');
percentValueTrack = get(hTrackText,'String');
hTrackColor = findobj(fTrackPie,'Type','patch');
set(hTrackText,{'String'},strcat(labelsTrack,percentValueTrack),'FontSize',fontL);
set(hTrackColor(1),'FaceColor',colorBlue);
set(hTrackColor(2),'FaceColor',colorDarkGray);
set(hTrackColor(3),'FaceColor',colorLightGray);

hTrack(2) = axes('Position',axpt(5,4,2,3,[0.1 0.1 0.85 0.85],midInterval));
bar(1:2:31,histc(latencyTrack_Act,0:2:30),1,'FaceColor',colorBlue);
line([nanmedian(latencyTrack_Act), nanmedian(latencyTrack_Act)],[0,20],'Color',colorRed,'LineWidth',1.5);
text(18,16,['Activated neurons (n = ',num2str(sum(histc(latencyTrack_Act,0:2:30))),')'],'FontSize',fontL);
text(18,14,['Latency: ',num2str(nanmedian(latencyTrack_Act),3),' ms'],'FontSize',fontL);
xlabel('Latency (ms)','FontSize',fontL);
ylabel('Number of cells','FontSize',fontL);

hTrack(3) = axes('Position',axpt(5,4,3,3,[0.1 0.1 0.85 0.85],midInterval));
bar(1:2:31,histc(latencyTrack_Inalast,0:2:30),1,'FaceColor',colorLightGray);
hold on;
bar(1:2:31,histc(latencyTrack_Inafirst,0:2:30),1,'FaceColor',colorGray);
line([nanmedian(latencyTrack_Inalast),nanmedian(latencyTrack_Inalast)],[0,20],'Color',colorRed,'LineWidth',1.5);
line([nanmedian(latencyTrack_Inafirst),nanmedian(latencyTrack_Inafirst)],[0,20],'Color',colorRed,'LineWidth',1.5);
text(18,18,['n_1 = ',num2str(sum(histc(latencyTrack_Inalast,0:2:30)))],'FontSize',fontL);
text(18,16,['n_2 = ',num2str(sum(histc(latencyTrack_Inafirst,0:2:30)))],'FontSize',fontL);
text(18,14,['1st line: ',num2str(nanmedian(latencyTrack_Inalast),3),' ms'],'FontSize',fontL);
text(18,12,['2nd line: ',num2str(nanmedian(latencyTrack_Inafirst),3),' ms'],'FontSize',fontL);
xlabel('Latency (ms)','FontSize',fontL);
ylabel('Number of cells','FontSize',fontL);

hTrack(4) = axes('Position',axpt(5,4,1,4,[0.1 0.1 0.85 0.85],midInterval));
rectangle('Position',[1.7, -10, 0.6, yLimlightTrack+10],'FaceColor',colorLightBlue,'EdgeColor','none');
hold on;
for iCell = 1:sum(double(total_DRun & T.pLR_modu<0.05))
    plot([1,2,3],[lightTrack_pre(iCell), lightTrack_stm(iCell), lightTrack_post(iCell)],'-o','Color',colorGray,'MarkerFaceColor',colorGray,'MarkerEdgeColor','k','MarkerSize',markerM);
    hold on;
    plot(2,lightTrack_stm(iCell),'o','MarkerEdgeColor','k','MarkerFaceColor',colorBlue,'MarkerSize',markerM);
    hold on;
end
plot([1,2,3],[mean(lightTrack_pre),mean(lightTrack_stm),mean(lightTrack_post)],'-o','MarkerFaceColor','k','Color','k','LineWidth',2,'MarkerSize',markerM);
text(3,yLimlightTrack*0.8,['n = ',num2str(sum(double(total_DRun & T.pLR_modu<0.05)))],'FontSize',fontL);
ylabel('Spike number','FontSize',fontM);

hTrack(5) = axes('Position',axpt(5,4,2,4,[0.1 0.1 0.85 0.85],midInterval));
line([0,yLimlightTrack],[0,yLimlightTrack],'Color','k','LineWidth',1);
hold on;
scatter(lightTrack_stm,lightTrack_pre,markerXL,'filled','o','MarkerEdgeColor','k','MarkerFaceColor',colorGray);
xlabel('Spike number [Stm] ','fontSize',fontM);
ylabel('Spike number [Pre] ','fontSize',fontM);

hTrack(6) = axes('Position',axpt(5,4,3,4,[0.1 0.1 0.85 0.85],midInterval));
line([0,yLimlightTrack],[0,yLimlightTrack],'Color','k','LineWidth',1);
hold on;
scatter(lightTrack_stm,lightTrack_post,markerXL,'filled','o','MarkerEdgeColor','k','MarkerFaceColor',colorGray);
xlabel('Spike number [Stm] ','fontSize',fontM);
ylabel('Spike number [Post] ','fontSize',fontM);

hTrack(7) = axes('Position',axpt(5,4,4,4,[0.1 0.1 0.85 0.85],midInterval));
line([0,yLimlightTrack],[0,yLimlightTrack],'Color','k','LineWidth',1);
hold on;
scatter(lightTrack_pre,lightTrack_post,markerXL,'filled','o','MarkerEdgeColor','k','MarkerFaceColor',colorGray);
xlabel('Spike number [Pre] ','fontSize',fontM);
ylabel('Spike number [Post] ','fontSize',fontM);

set(hTrack(2:7),'TickDir','out','FontSize',fontM,'Box','off')
set(hTrack(4),'XLim',[0,4],'YLim',[-10,yLimlightTrack],'XTick',[1,2,3],'XTickLabel',{'Pre','Stm','Post'});
set(hTrack(2:3),'XLim',[0,30],'YLim',[0,20],'XTick',[0:4:30]);
set(hTrack(5:7),'XLim',[-10,yLimlightTrack],'YLim',[-10,yLimlightTrack]);

print(gcf,'-painters','-r300','Fig3_1_lightResponse_DRun.ai','-depsc');