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
rtDir_sig = 'D:\Dropbox\SNL\P2_Track\v2_cellFigDRun_lightSig';
rtDir_nosig = 'D:\Dropbox\SNL\P2_Track\v2_cellFigDRun_lightNoSig';

%%
total_DRun = T.taskProb == '100' & T.taskType == 'DRun' & T.peakMap>1;
nTotal_DRun = sum(double(total_DRun));

%% Conditio
% totalPN = T.taskProb == '100' & T.taskType == 'DRun' & T.meanFR_task>0 & T.meanFR_task<10 & T.peakMap>1;
% totalIN = T.taskProb == '100' & T.taskType == 'DRun' & T.meanFR_task>10;
% nTotalPN = sum(double(totalPN));
% nTotalIN = sum(double(totalIN));

% nototalPN = T.taskProb == '100' & T.taskType == 'noRun' & T.meanFR_task>0 & T.meanFR_task<10;
% nototalIN = T.taskProb == '100' & T.taskType == 'noRun' & T.meanFR_task>10;
% nonTotalPN = sum(double(nototalPN));
% nonTotalIN = sum(double(nototalIN));

% totalPN = T.taskProb == '100' & T.taskType == 'DRw' & T.meanFR_task>0 & T.meanFR_task<10 & T.peakMap>1;
% totalIN = T.taskProb == '100' & T.taskType == 'DRw' & T.meanFR_task>10;
% nTotalPN = sum(double(totalPN));
% nTotalIN = sum(double(totalIN));

% nototalPN = T.taskProb == '100' & T.taskType == 'noRw' & T.meanFR_task>0 & T.meanFR_task<10;
% nototalIN = T.taskProb == '100' & T.taskType == 'noRw' & T.meanFR_task>10;
% nonTotalPN = sum(double(nototalPN));
% nonTotalIN = sum(double(nototalIN));
%%
% lightPN = (totalPN & T.pLR_tag<0.05) | (totalPN & T.pLR_modu<0.05);
% lightIN = (totalIN & T.pLR_tag<0.05) | (totalIN & T.pLR_modu<0.05);
% nlightPN = sum(double(lightPN));
% nlightIN = sum(double(lightIN));

% lightPN = (nototalPN & T.pLR_tag<0.05) | (nototalPN & T.pLR_modu<0.05);
% lightIN = (nototalIN & T.pLR_tag<0.05) | (nototalIN & T.pLR_modu<0.05);
% nlightPN = sum(double(lightPN));
% nlightIN = sum(double(lightIN));

% lightPN_tagAc = lightPN & T.statDir_tag == 1;
% lightPN_tagNo = lightPN & T.statDir_tag == 0;
% lightPN_tagIn = lightPN & T.statDir_tag == -1;
% 
% lightPN_ModuAc = lightPN & T.statDir_modu == 1;
% lightPN_ModuNo = lightPN & T.statDir_modu == 0;
% lightPN_ModuIn = lightPN & T.statDir_modu == -1;
%  
% lightPopu = [sum(double(lightPN_tagAc)), sum(double(lightPN_tagNo)), sum(double(lightPN_tagIn));
%             sum(double(lightPN_ModuAc)), sum(double(lightPN_ModuNo)), sum(double(lightPN_ModuIn))]'; % first column: base / second: track
% 
% laserBasePN_pre = T.lighttagPreSpk(lightPN);
% laserBasePN_stm = T.lighttagSpk(lightPN);
% laserBasePN_post = T.lighttagPostSpk(lightPN);
% 
% laserTrackPN_pre = T.lightPreSpk(lightPN);
% laserTrackPN_stm = T.lightSpk(lightPN);
% laserTrackPN_post = T.lightPostSpk(lightPN);
% 
% ylimBase = max([laserBasePN_pre; laserBasePN_stm; laserBasePN_post]);
% ylimTrack = max([laserTrackPN_pre; laserTrackPN_stm; laserTrackPN_post]);

%% Single cell figure separation
figList_DRunlightPN_sig = T.Path((total_DRun & T.pLR_tag < 0.05) | (total_DRun & T.pLR_modu < 0.05));
trackPlot_v4_multifig(figList_DRunlightPN_sig,rtDir_sig);

figList_DRunlightPN_nosig = T.Path((total_DRun & ~(T.pLR_tag < 0.05)) & (total_DRun & ~(T.pLR_modu < 0.05)));
trackPlot_v4_multifig(figList_DRunlightPN_nosig,rtDir_nosig);
cd('D:\Dropbox\SNL\P2_Track');

%% Light response_Total cell
% totalBasePN_pre = T.lighttagPreSpk(totalPN);
% totalBasePN_stm = T.lighttagSpk(totalPN);
% totalBasePN_post = T.lighttagPostSpk(totalPN);
% 
% totalTrackPN_pre = T.lightPreSpk(totalPN);
% totalTrackPN_stm = T.lightSpk(totalPN);
% totalTrackPN_post = T.lightPostSpk(totalPN);
% 
% ylimTotalBase = max([totalBasePN_pre; totalBasePN_stm; totalBasePN_post]);
% ylimTotalTrack = max([totalTrackPN_pre; totalTrackPN_stm; totalTrackPN_post]);
% 
% hTotalBase(1) = axes('Position',axpt(4,2,1,1,[0.1 0.1 0.85 0.85],midInterval));
% rectangle('Position',[1.7, 0, 0.6, ylimTotalBase*1.1],'FaceColor',colorLightBlue,'EdgeColor','none');
% hold on;
% for iCell = 1:nTotalPN
%     plot([1,2,3],[totalBasePN_pre(iCell), totalBasePN_stm(iCell), totalBasePN_post(iCell)],'-o','Color',colorGray','MarkerFaceColor',colorGray,'MarkerEdgeColor','k','MarkerSize',markerM);
%     hold on;
%     plot(2,totalBasePN_stm(iCell),'o','MarkerEdgeColor','k','MarkerFaceColor',colorBlue,'MarkerSize',markerM);
%     hold on;
% end
% plot([1,2,3],[mean(totalBasePN_pre),mean(totalBasePN_stm),mean(totalBasePN_post)],'-o','MarkerFaceColor','k','Color','k','LineWidth',2,'MarkerSize',markerM);
% text(3,ylimTotalBase*0.9,['n = ',num2str(nTotalPN)],'FontSize',fontL);
% ylabel('Spike number','fontSize',fontM);
% title('Total baseline light response','fontSize',fontM);
% 
% hTotalBase(2) = axes('Position',axpt(4,2,2,1,[0.1 0.1 0.85 0.85],midInterval));
% line([0,ylimTotalBase*1.1],[0,ylimTotalBase*1.1],'Color','k','LineWidth',1);
% hold on;
% scatter(totalBasePN_stm,totalBasePN_pre,markerXL,'filled','o','MarkerEdgeColor','k','MarkerFaceColor',colorGray);
% xlabel('Spike number (Stm)','fontSize',fontM);
% ylabel('Spike number (Pre)','fontSize',fontM);
% title('Total baseline light response','fontSize',fontM);
% 
% hTotalBase(3) = axes('Position',axpt(4,2,3,1,[0.1 0.1 0.85 0.85],midInterval));
% line([0,ylimBase*1.1],[0,ylimBase*1.1],'Color','k','LineWidth',1);
% hold on;
% scatter(totalBasePN_stm,totalBasePN_post,markerXL,'filled','o','MarkerEdgeColor','k','MarkerFaceColor',colorGray);
% xlabel('Spike number (Stm)','fontSize',fontM);
% ylabel('Spike number (Post)','fontSize',fontM);
% title('Total baseline light response','fontSize',fontM);
% 
% hTotalBase(4) = axes('Position',axpt(4,2,4,1,[0.1 0.1 0.85 0.85],midInterval));
% line([0,ylimTotalBase*1.1],[0,ylimTotalBase*1.1],'Color','k','LineWidth',1);
% hold on;
% scatter(totalBasePN_pre,totalBasePN_post,markerXL,'filled','o','MarkerEdgeColor','k','MarkerFaceColor',colorGray);
% xlabel('Spike number (pre)','fontSize',fontM);
% ylabel('Spike number (Post)','fontSize',fontM);
% title('Baseline light response','fontSize',fontM);
% 
% set(hTotalBase,'TickDir','out','fontSize',fontM);
% set(hTotalBase(1),'TickDir','out','XLim',[0,4],'YLim',[-1, max([totalBasePN_pre; totalBasePN_stm; totalBasePN_post])+10],'XTick',[1,2,3],'XTickLabel',{'Pre-stm','Stm','Post-stm'});
% set(hTotalBase(2),'XLim',[0,ylimTotalBase*1.1],'YLim',[0,ylimTotalBase*1.1]);
% set(hTotalBase(3),'XLim',[0,ylimTotalBase*1.1],'YLim',[0,ylimTotalBase*1.1]);
% set(hTotalBase(4),'XLim',[0,ylimTotalBase*1.1],'YLim',[0,ylimTotalBase*1.1]);
% 
% hTotalTrack(1) = axes('Position',axpt(4,2,1,2,[0.1 0.1 0.85 0.85],midInterval));
% rectangle('Position',[1.7, 0, 0.6, ylimTotalTrack*1.1],'FaceColor',colorLightBlue,'EdgeColor','none');
% hold on;
% for iCell = 1:nTotalPN
%     plot([1,2,3],[totalTrackPN_pre(iCell), totalTrackPN_stm(iCell), totalTrackPN_post(iCell)],'-o','Color',colorGray','MarkerFaceColor',colorGray,'MarkerEdgeColor','k','MarkerSize',markerM);
%     hold on;
%     plot(2,totalTrackPN_stm(iCell),'o','MarkerEdgeColor','k','MarkerFaceColor',colorBlue,'MarkerSize',markerM);
%     hold on;
% end
% plot([1,2,3],[mean(totalTrackPN_pre),mean(totalTrackPN_stm),mean(totalTrackPN_post)],'-o','MarkerFaceColor','k','Color','k','LineWidth',2,'MarkerSize',markerM);
% text(3, ylimTrack*0.9, ['n = ',num2str(nTotalPN)],'FontSize',fontL);
% ylabel('Spike number','fontSize',fontM);
% title('Track light response','fontSize',fontM);
% 
% hTotalTrack(2) = axes('Position',axpt(4,2,2,2,[0.1 0.1 0.85 0.85],midInterval));
% line([0,ylimTotalBase*1.1],[0,ylimTotalBase*1.1],'Color','k','LineWidth',1);
% hold on;
% scatter(totalTrackPN_stm,totalTrackPN_pre,markerXL,'filled','o','MarkerEdgeColor','k','MarkerFaceColor',colorGray);
% xlabel('Spike number (Stm)','fontSize',fontM);
% ylabel('Spike number (Pre)','fontSize',fontM);
% title('Track light response','fontSize',fontM);
% 
% hTotalTrack(3) = axes('Position',axpt(4,2,3,2,[0.1 0.1 0.85 0.85],midInterval));
% line([0,ylimTotalBase*1.1],[0,ylimTotalBase*1.1],'Color','k','LineWidth',1);
% hold on;
% scatter(totalTrackPN_stm,totalTrackPN_post,markerXL,'filled','o','MarkerEdgeColor','k','MarkerFaceColor',colorGray);
% xlabel('Spike number (Stm)','fontSize',fontM);
% ylabel('Spike number (Post)','fontSize',fontM);
% title('Track light response','fontSize',fontM);
% 
% hTotalTrack(4) = axes('Position',axpt(4,2,4,2,[0.1 0.1 0.85 0.85],midInterval));
% line([0,ylimTotalBase*1.1],[0,ylimTotalBase*1.1],'Color','k','LineWidth',1);
% hold on;
% scatter(totalTrackPN_pre,totalTrackPN_post,markerXL,'filled','o','MarkerEdgeColor','k','MarkerFaceColor',colorGray);
% xlabel('Spike number (pre)','fontSize',fontM);
% ylabel('Spike number (Post)','fontSize',fontM);
% title('Track light response','fontSize',fontM);
% 
% set(hTotalTrack,'TickDir','out','fontSize',fontM);
% set(hTotalTrack(1),'TickDir','out','XLim',[0,4],'YLim',[-1, ylimTotalTrack*1.1],'XTick',[1,2,3],'XTickLabel',{'Pre-stm','Stm','Post-stm'});
% set(hTotalTrack(2),'XLim',[0,ylimTotalBase*1.1],'YLim',[0,ylimTotalBase*1.1]);
% set(hTotalTrack(3),'XLim',[0,ylimTotalBase*1.1],'YLim',[0,ylimTotalBase*1.1]);
% set(hTotalTrack(4),'XLim',[0,ylimTotalBase*1.1],'YLim',[0,ylimTotalBase*1.1]);
% set(hTotalTrack(1),'TickDir','out','XLim',[0,4],'YLim',[-1,max([totalTrackPN_pre; totalTrackPN_stm; totalTrackPN_post])+10],'XTick',[1,2,3],'XTickLabel',{'Pre-stm','Stm','Post-stm'});
% 
% print(gcf,'-dtiff','-r300','DRw_Light response_total2')
% %% Light Response_pLR cell
% figure(2)
% hPie(1) = axes('Position',axpt(4,4,1,1,[0.1 0.1 0.85 0.85],midInterval));
% labels = {'Act: ';'No: ';'InAct: '};
% fPie = pie(lightPopu(:,1));
% hText = findobj(fPie,'Type','text');
% percentValue = get(hText,'String');
% hColor = findobj(fPie,'Type','patch');
% set(hText,{'String'},strcat(labels,percentValue),'FontSize',fontL);
% set(hColor(1),'FaceColor',colorBlue);
% set(hColor(2),'FaceColor',colorDarkGray);
% set(hColor(3),'FaceColor',colorLightGray);
% 
% hBase(1) = axes('Position',axpt(4,4,1,2,[0.1 0.1 0.85 0.85],midInterval));
% rectangle('Position',[1.7, 0, 0.6, ylimBase*1.1],'FaceColor',colorLightBlue,'EdgeColor','none');
% hold on;
% for iCell = 1:nlightPN
%     plot([1,2,3],[laserBasePN_pre(iCell), laserBasePN_stm(iCell), laserBasePN_post(iCell)],'-o','Color',colorGray','MarkerFaceColor',colorGray,'MarkerEdgeColor','k','MarkerSize',markerM);
%     hold on;
%     plot(2,laserBasePN_stm(iCell),'o','MarkerEdgeColor','k','MarkerFaceColor',colorBlue,'MarkerSize',markerM);
%     hold on;
% end
% plot([1,2,3],[mean(laserBasePN_pre),mean(laserBasePN_stm),mean(laserBasePN_post)],'-o','MarkerFaceColor','k','Color','k','LineWidth',2,'MarkerSize',markerM);
% text(3,ylimBase*0.9,['n = ',num2str(nlightPN)],'FontSize',fontL);
% ylabel('Spike number','fontSize',fontM);
% title('Baseline light response','fontSize',fontM);
% 
% hBase(2) = axes('Position',axpt(4,4,2,2,[0.1 0.1 0.85 0.85],midInterval));
% line([0,ylimBase*1.1],[0,ylimBase*1.1],'Color','k','LineWidth',1);
% hold on;
% scatter(laserBasePN_stm,laserBasePN_pre,markerXL,'filled','o','MarkerEdgeColor','k','MarkerFaceColor',colorGray);
% xlabel('Spike number (Stm)','fontSize',fontM);
% ylabel('Spike number (Pre)','fontSize',fontM);
% title('Baseline light response','fontSize',fontM);
% 
% hBase(3) = axes('Position',axpt(4,4,3,2,[0.1 0.1 0.85 0.85],midInterval));
% line([0,ylimBase*1.1],[0,ylimBase*1.1],'Color','k','LineWidth',1);
% hold on;
% scatter(laserBasePN_stm,laserBasePN_post,markerXL,'filled','o','MarkerEdgeColor','k','MarkerFaceColor',colorGray);
% xlabel('Spike number (Stm)','fontSize',fontM);
% ylabel('Spike number (Post)','fontSize',fontM);
% title('Baseline light response','fontSize',fontM);
% 
% hBase(4) = axes('Position',axpt(4,4,4,2,[0.1 0.1 0.85 0.85],midInterval));
% line([0,ylimBase*1.1],[0,ylimBase*1.1],'Color','k','LineWidth',1);
% hold on;
% scatter(laserBasePN_pre,laserBasePN_post,markerXL,'filled','o','MarkerEdgeColor','k','MarkerFaceColor',colorGray);
% xlabel('Spike number (pre)','fontSize',fontM);
% ylabel('Spike number (Post)','fontSize',fontM);
% title('Baseline light response','fontSize',fontM);
% 
% set(hBase,'TickDir','out','FontSize',fontM);
% set(hBase(1),'TickDir','out','XLim',[0,4],'YLim',[-1, max([laserBasePN_pre; laserBasePN_stm; laserBasePN_post])+10],'XTick',[1,2,3],'XTickLabel',{'Pre-stm','Stm','Post-stm'});
% set(hBase(2),'XLim',[0,ylimBase*1.1],'YLim',[0,ylimBase*1.1]);
% set(hBase(3),'XLim',[0,ylimBase*1.1],'YLim',[0,ylimBase*1.1]);
% set(hBase(4),'XLim',[0,ylimBase*1.1],'YLim',[0,ylimBase*1.1]);
% 
% hPie(2) = axes('Position',axpt(4,4,1,3,[0.1 0.1 0.85 0.85],midInterval));
% labels = {'Act: ';'No: ';'InAct: '};
% fPie = pie(lightPopu(:,2));
% hText = findobj(fPie,'Type','text');
% percentValue = get(hText,'String');
% hColor = findobj(fPie,'Type','patch');
% set(hText,{'String'},strcat(labels,percentValue),'FontSize',fontL);
% set(hColor(1),'FaceColor',colorBlue);
% set(hColor(2),'FaceColor',colorDarkGray);
% set(hColor(3),'FaceColor',colorLightGray);
% 
% hTrack(1) = axes('Position',axpt(4,4,1,4,[0.1 0.1 0.85 0.85],midInterval));
% rectangle('Position',[1.7, 0, 0.6, ylimTrack*1.1],'FaceColor',colorLightBlue,'EdgeColor','none');
% hold on;
% for iCell = 1:nlightPN
%     plot([1,2,3],[laserTrackPN_pre(iCell), laserTrackPN_stm(iCell), laserTrackPN_post(iCell)],'-o','Color',colorGray','MarkerFaceColor',colorGray,'MarkerEdgeColor','k','MarkerSize',markerM);
%     hold on;
%     plot(2,laserTrackPN_stm(iCell),'o','MarkerEdgeColor','k','MarkerFaceColor',colorBlue,'MarkerSize',markerM);
%     hold on;
% end
% plot([1,2,3],[mean(laserTrackPN_pre),mean(laserTrackPN_stm),mean(laserTrackPN_post)],'-o','MarkerFaceColor','k','Color','k','LineWidth',2,'MarkerSize',markerM);
% text(3, ylimTrack*0.9, ['n = ',num2str(nlightPN)],'FontSize',fontL);
% ylabel('Spike number','fontSize',fontM);
% title('Track light response','fontSize',fontM);
% 
% hTrack(2) = axes('Position',axpt(4,4,2,4,[0.1 0.1 0.85 0.85],midInterval));
% line([0,ylimBase*1.1],[0,ylimBase*1.1],'Color','k','LineWidth',1);
% hold on;
% scatter(laserTrackPN_stm,laserTrackPN_pre,markerXL,'filled','o','MarkerEdgeColor','k','MarkerFaceColor',colorGray);
% xlabel('Spike number (Stm)','fontSize',fontM);
% ylabel('Spike number (Pre)','fontSize',fontM);
% title('Track light response','fontSize',fontM);
% 
% hTrack(3) = axes('Position',axpt(4,4,3,4,[0.1 0.1 0.85 0.85],midInterval));
% line([0,ylimBase*1.1],[0,ylimBase*1.1],'Color','k','LineWidth',1);
% hold on;
% scatter(laserTrackPN_stm,laserTrackPN_post,markerXL,'filled','o','MarkerEdgeColor','k','MarkerFaceColor',colorGray);
% xlabel('Spike number (Stm)','fontSize',fontM);
% ylabel('Spike number (Post)','fontSize',fontM);
% title('Track light response','fontSize',fontM);
% 
% hTrack(4) = axes('Position',axpt(4,4,4,4,[0.1 0.1 0.85 0.85],midInterval));
% line([0,ylimBase*1.1],[0,ylimBase*1.1],'Color','k','LineWidth',1);
% hold on;
% scatter(laserTrackPN_pre,laserTrackPN_post,markerXL,'filled','o','MarkerEdgeColor','k','MarkerFaceColor',colorGray);
% xlabel('Spike number (pre)','fontSize',fontM);
% ylabel('Spike number (Post)','fontSize',fontM);
% title('Track light response','fontSize',fontM);
% 
% set(hTrack,'TickDir','out','fontSize',fontM);
% set(hTrack(1),'TickDir','out','XLim',[0,4],'YLim',[-1, ylimTrack*1.1],'XTick',[1,2,3],'XTickLabel',{'Pre-stm','Stm','Post-stm'});
% set(hTrack(2),'XLim',[0,ylimBase*1.1],'YLim',[0,ylimBase*1.1]);
% set(hTrack(3),'XLim',[0,ylimBase*1.1],'YLim',[0,ylimBase*1.1]);
% set(hTrack(4),'XLim',[0,ylimBase*1.1],'YLim',[0,ylimBase*1.1]);
% set(hTrack(1),'TickDir','out','XLim',[0,4],'YLim',[-1,max([laserTrackPN_pre; laserTrackPN_stm; laserTrackPN_post])+10],'XTick',[1,2,3],'XTickLabel',{'Pre-stm','Stm','Post-stm'});
% print(gcf,'-dtiff','-r300','DRw_Light response_light cell2')