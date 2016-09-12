lineWth = [1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75];
fontS = 4; fontM = 6; fontL = 8; % font size
lineS = 0.2; lineM = 0.5; lineL = 1; % line width
tightInterval = [0.02 0.02]; midInterval = [0.09, 0.09]; wideInterval = [0.14 0.14];
markerS = 2.2; markerM = 4.4; markerL = 6.6;
scatterS = 26; scatterM = 36; scatterL = 54;

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

% Stimulation during running
load(['cellList_add','.mat']);
rtDir_sig = 'D:\Dropbox\SNL\P2_Track\cellFig_lightSig';
rtDir_nosig = 'D:\Dropbox\SNL\P2_Track\cellFig_lightNoSig';

% Condition
% totalPN = T.taskProb == '100' & T.taskType == 'DRun' & T.meanFR_task>0 & T.meanFR_task<10;
% totalIN = T.taskProb == '100' & T.taskType == 'DRun' & T.meanFR_task>10;
totalPN = T.taskProb == '100' & T.taskType == 'DRw' & T.meanFR_task>0 & T.meanFR_task<10;
totalIN = T.taskProb == '100' & T.taskType == 'DRw' & T.meanFR_task>10;

nTotalPN = sum(double(totalPN));
nTotalIN = sum(double(totalIN));

% nototalPN = T.taskProb == '100' & T.taskType == 'DRun' & T.meanFR_task>0 & T.meanFR_task<10;
% nototalIN = T.taskProb == '100' & T.taskType == 'DRun' & T.meanFR_task>10;
nototalPN = T.taskProb == '100' & T.taskType == 'DRw' & T.meanFR_task>0 & T.meanFR_task<10;
nototalIN = T.taskProb == '100' & T.taskType == 'DRw' & T.meanFR_task>10;

nonTotalPN = sum(double(nototalPN));
nonTotalIN = sum(double(nototalIN));


lightPN = (totalPN & T.pLR_tag<0.05) | (totalPN & T.pLR_modu<0.05);
lightIN = (totalIN & T.pLR_tag<0.05) | (totalIN & T.pLR_modu<0.05);
nlightPN = sum(double(lightPN));
nlightIN = sum(double(lightIN));

lightPN_tagAc = lightPN & T.statDir_tag == 1;
lightPN_tagNo = lightPN & T.statDir_tag == 0;
lightPN_tagIn = lightPN & T.statDir_tag == -1;

lightPN_ModuAc = lightPN & T.statDir_modu == 1;
lightPN_ModuNo = lightPN & T.statDir_modu == 0;
lightPN_ModuIn = lightPN & T.statDir_modu == -1;
 
lightPopu = [sum(double(lightPN_tagAc)), sum(double(lightPN_tagNo)), sum(double(lightPN_tagIn));
            sum(double(lightPN_ModuAc)), sum(double(lightPN_ModuNo)), sum(double(lightPN_ModuIn))]'; % first column: base / second: track

laserBasePN_pre = T.lighttagPreSpk(lightPN);
laserBasePN_stm = T.lighttagSpk(lightPN);
laserBasePN_post = T.lighttagPostSpk(lightPN);

laserTrackPN_pre = T.lightPreSpk(lightPN);
laserTrackPN_stm = T.lightSpk(lightPN);
laserTrackPN_post = T.lightPostSpk(lightPN);

ylimBase = max([laserBasePN_pre; laserBasePN_stm; laserBasePN_post]);
ylimTrack = max([laserTrackPN_pre; laserTrackPN_stm; laserTrackPN_post]);

%% Separation of light Response population
lightBoth = totalPN & T.pLR_tag<0.05 & T.pLR_modu<0.05;
lightBase = totalPN & T.pLR_tag<0.05 & ~(T.pLR_modu<0.05);
lightTrack = totalPN & ~(T.pLR_tag<0.05) & T.pLR_modu<0.05;

latencyBaseLight = T.testLatencyTag_first(totalPN & T.pLR_tag<0.05 & T.statDir_tag==1);
latencyTrackLight = T.testLatencyModu_first(totalPN & T.pLR_tag<0.05 & T.statDir_tag==1);

latencyBaseLight_Inalast = T.ina_lastSpk_tag(totalPN & T.pLR_tag<0.05 & T.statDir_tag==-1);
latencyBaseLight_Inafirst = T.ina_firstSpk_tag(totalPN & T.pLR_tag<0.05 & T.statDir_tag==-1);
latencyTrackLight_inalast = T.ina_lastSpk_modu(totalPN & T.pLR_tag<0.05 & T.statDir_tag==-1);
latencyTrackLight_inafirst = T.ina_firstSpk_modu(totalPN & T.pLR_tag<0.05 & T.statDir_tag==-1);

latencyBaseLight_ctr = T.baseLatencyTag(nototalPN & T.pLR_tag<0.05);
latencyTrackLight_ctr = T.baseLatencyModu(nototalPN & T.pLR_tag<0.05);

figure(1)
hLatency(1) = axes('Position',axpt(3,2,1,1,[0.1 0.1 0.85 0.85],wideInterval));
bar(1:2:31,histc([latencyBaseLight;latencyBaseLight_ctr],0:2:30),1,'FaceColor',colorBlue)
line([nanmedian([latencyBaseLight;latencyBaseLight_ctr]),nanmedian([latencyBaseLight;latencyBaseLight_ctr])],[0, 20],'Color',colorRed,'LineWidth',1.5);
text(18,16,['Light session (n = ',num2str(sum(histc(latencyBaseLight,0:2:30))),')'],'FontSize',fontL);
text(18,14,['No light session (n = ',num2str(sum(histc(latencyBaseLight_ctr,0:2:30))),')'],'FontSize',fontL);
text(18,12,['Latency: ',num2str(nanmedian([latencyBaseLight;latencyBaseLight_ctr]),3),' ms'],'FontSize',fontL);
xlabel('Latency (ms)','FontSize',fontL);
ylabel('Number of activated cells','FontSize',fontL);
title('Baseline Response (Light session)','FontSize',fontL);

hLatency(2) = axes('Position',axpt(3,2,2,1,[0.1 0.1 0.85 0.85],wideInterval));
bar(1:2:31,histc(latencyTrackLight,0:2:30),1,'FaceColor',colorBlue)
line([nanmedian(latencyTrackLight),nanmedian(latencyTrackLight)],[0, 20],'Color',colorRed,'LineWidth',1.5);
text(18,16,['n = ',num2str(sum(histc(latencyTrackLight,0:2:30)))],'FontSize',fontL);
text(18,14,['Latency: ',num2str(nanmedian(latencyTrackLight),3),' ms'],'FontSize',fontL);
xlabel('Latency (ms)','FontSize',fontL);
ylabel('Number of activated cells','FontSize',fontL);
title('Track Response (Light session)','FontSize',fontL);

hLatency(3) = axes('Position',axpt(3,2,3,1,[0.1 0.1 0.85 0.85],wideInterval));
bar(1:2:31,histc(latencyTrackLight_ctr,0:2:30),1,'FaceColor',colorGray)
line([nanmedian(latencyTrackLight_ctr),nanmedian(latencyTrackLight_ctr)],[0, 20],'Color',colorRed,'LineWidth',1.5);
text(18,16,['n = ',num2str(sum(histc(latencyTrackLight_ctr,0:2:30)))],'FontSize',fontL);
text(18,14,['Latency: ',num2str(nanmedian(latencyTrackLight_ctr),3),' ms'],'FontSize',fontL);
xlabel('Latency (ms)','FontSize',fontL);
ylabel('Number of activated cells','FontSize',fontL);
title('Track Response (No light session)','FontSize',fontL);

hLatency(4) = axes('Position',axpt(3,2,1,2,[0.1 0.1 0.85 0.85],wideInterval));
bar(1:2:31,histc(latencyBaseLight_Inalast,0:2:30),1,'FaceColor',colorLightGray)
hold on;
bar(1:2:31,histc(latencyBaseLight_Inafirst,0:2:30),1,'FaceColor',colorGray)
line([nanmedian(latencyBaseLight_Inalast),nanmedian(latencyBaseLight_Inalast)],[0, 20],'Color',colorRed,'LineWidth',1.5);
line([nanmedian(latencyBaseLight_Inafirst),nanmedian(latencyBaseLight_Inafirst)],[0, 20],'Color',colorRed,'LineWidth',1.5);
text(18,18,['n_1 = ',num2str(sum(histc(latencyBaseLight_Inalast,0:2:30)))],'FontSize',fontL);
text(18,16,['n_2 = ',num2str(sum(histc(latencyBaseLight_Inafirst,0:2:30)))],'FontSize',fontL);
text(18,14,['1st line: ',num2str(nanmedian(latencyBaseLight_Inalast),3),' ms'],'FontSize',fontL);
text(18,12,['2nd line: ',num2str(nanmedian(latencyBaseLight_Inafirst),3),' ms'],'FontSize',fontL);
xlabel('Latency (ms)','FontSize',fontL);
ylabel('Number of activated cells','FontSize',fontL);
title('Track Response (No light session)','FontSize',fontL);

hLatency(5) = axes('Position',axpt(3,2,2,2,[0.1 0.1 0.85 0.85],wideInterval));
bar(1:2:31,histc(latencyTrackLight_inalast,0:2:30),1,'FaceColor',colorLightGray)
hold on;
bar(1:2:31,histc(latencyTrackLight_inafirst,0:2:30),1,'FaceColor',colorGray)
line([nanmedian(latencyTrackLight_inalast), nanmedian(latencyTrackLight_inalast)],[0, 20],'Color',colorRed,'LineWidth',1.5);
line([nanmedian(latencyTrackLight_inafirst), nanmedian(latencyTrackLight_inafirst)],[0, 20],'Color',colorRed,'LineWidth',1.5);
text(18,18,['n_1 = ',num2str(sum(histc(latencyTrackLight_inalast,0:2:30)))],'FontSize',fontL);
text(18,16,['n_2 = ',num2str(sum(histc(latencyTrackLight_inafirst,0:2:30)))],'FontSize',fontL);
text(18,14,['Latency: ',num2str(nanmedian(latencyTrackLight_inalast),3),' ms'],'FontSize',fontL);
text(18,12,['Latency: ',num2str(nanmedian(latencyTrackLight_inafirst),3),' ms'],'FontSize',fontL);
xlabel('Latency (ms)','FontSize',fontL);
ylabel('Number of activated cells','FontSize',fontL);
title('Track Response (No light session)','FontSize',fontL);

set(hLatency(1:5),'XLim',[0,30],'YLim',[0,20],'XTick',[0:4:30],'Box','off','TickDir','out','FontSize',fontL);
print(gcf,'-dtiff','-r300','DRw_Latency');
