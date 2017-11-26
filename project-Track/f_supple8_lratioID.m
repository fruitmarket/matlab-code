clearvars;
rtDir = 'D:\Dropbox\SNL\P2_Track';
cd(rtDir);
load myParameters.mat;
load neuronList_ori_170928.mat

formatOut = 'yymmdd';
winRatio = 0:0.01:0.15;
winID = 0:20:300;

xptIDBar = 10:20:290;
xptIDStairs = 0:20:280;
xptLRatioBar = 0.005:0.01:0.145;
xptLRatioStairs = 0:0.01:0.14;

lratio = T.LRatio;
isodist = T.ID;

% DRun
DRun = T.taskType == 'DRun';
DRw = T.taskType == 'DRw';

%% DRun
% L-ratio
lratioDRun_Btotal = histc(lratio(DRun),winRatio);
lratioDRun_Btotal(end) = [];

lratioDRun_Blight = histc(lratio(DRun & T.idxpLR_Track),winRatio);
lratioDRun_Blight(end) = [];

% light responsive population stairs
lratioDRun_Slight = cumsum(histc(lratio(DRun & T.idxpLR_Track),winRatio))/sum(histc(lratio(DRun & T.idxpLR_Track),winRatio))*max(lratioDRun_Btotal);
lratioDRun_Slight(end) = [];

% Isolation distance
isodistDRun_Btotal = histc(isodist(DRun),winID);
isodistDRun_Btotal(end) = [];

isodistDRun_Blight = histc(isodist(DRun & T.idxpLR_Track),winID);
isodistDRun_Blight(end) = [];

% light responsive population stairs
isodistDRun_Slight = cumsum(histc(isodist(DRun & T.idxpLR_Track),winID))/sum(histc(isodist(DRun & T.idxpLR_Track),winID))*max(isodistDRun_Btotal);
isodistDRun_Slight(end) = [];

%% DRw
% L-ratio
lratioDRw_Btotal = histc(lratio(DRw),winRatio);
lratioDRw_Btotal(end) = [];

lratioDRw_Blight = histc(lratio(DRw & T.idxpLR_Track),winRatio);
lratioDRw_Blight(end) = [];

% light responsive population stairs
lratioDRw_Slight = cumsum(histc(lratio(DRw & T.idxpLR_Track),winRatio))/sum(histc(lratio(DRw & T.idxpLR_Track),winRatio))*max(lratioDRw_Btotal);
lratioDRw_Slight(end) = [];

% Isolation distance
isodistDRw_Btotal = histc(isodist(DRw),winID);
isodistDRw_Btotal(end) = [];

isodistDRw_Blight = histc(isodist(DRw & T.idxpLR_Track),winID);
isodistDRw_Blight(end) = [];

% light responsive population stairs
isodistDRw_Slight = cumsum(histc(isodist(DRw & T.idxpLR_Track),winID))/sum(histc(isodist(DRw & T.idxpLR_Track),winID))*max(isodistDRw_Btotal);
isodistDRw_Slight(end) = [];

wideInterval = wideInterval + 0.05;
%% plot
fHandle = figure('PaperUnits','centimeters','PaperPosition',[0 0 8 8]);

hID(1) = axes('Position',axpt(2,2,1,1,[0.1 0.1 0.85 0.85],wideInterval));
bar(xptIDBar,isodistDRun_Btotal,1,'faceColor',colorGray,'lineWidth',lineM);
hold on;
bar(xptIDBar,isodistDRun_Blight,1,'faceColor',colorBlue,'lineWidth',lineM);
hold on;
stairs(xptIDStairs,isodistDRun_Slight,'Color',colorBlue,'lineWidth',lineM);
xlabel('Isolation distance','fontSize',fontS);
ylabel('Number of neurons','fontSize',fontS);
title('DRun neurons','fontSize',fontS);
set(hID(1),'Box','off','TickDir','out','XLim',[0,300],'XTick',[0:100:300],'fontSize',fontS);

hLRatio(1) = axes('Position',axpt(2,2,2,1,[0.1 0.1 0.85 0.85],wideInterval));
bar(xptLRatioBar,lratioDRun_Btotal,1,'faceColor',colorGray,'lineWidth',lineM);
hold on;
bar(xptLRatioBar,lratioDRun_Blight,1,'faceColor',colorBlue,'lineWidth',lineM);
hold on;
stairs(xptLRatioStairs,lratioDRun_Slight,'Color',colorBlue,'lineWidth',lineM);
xlabel('L-ratio','fontSize',fontS);
ylabel('Number of neurons','fontSize',fontS);
title('DRun neurons','fontSize',fontS);
set(hLRatio(1),'Box','off','TickDir','out','XLim',[0,0.15],'XTick',[0:0.05:0.15],'fontSize',fontS);

% DRw
hID(2) = axes('Position',axpt(2,2,1,2,[0.1 0.1 0.85 0.85],wideInterval));
bar(xptIDBar,isodistDRw_Btotal,1,'faceColor',colorGray,'lineWidth',lineM);
hold on;
bar(xptIDBar,isodistDRw_Blight,1,'faceColor',colorBlue,'lineWidth',lineM);
hold on;
stairs(xptIDStairs,isodistDRw_Slight,'Color',colorBlue,'lineWidth',lineM);
xlabel('Isolation distance','fontSize',fontS);
ylabel('Number of neurons','fontSize',fontS);
title('DRw neurons','fontSize',fontS);
set(hID(2),'Box','off','TickDir','out','XLim',[0,300],'XTick',[0:100:300],'fontSize',fontS);

hLRatio(2) = axes('Position',axpt(2,2,2,2,[0.1 0.1 0.85 0.85],wideInterval));
bar(xptLRatioBar,lratioDRw_Btotal,1,'faceColor',colorGray,'lineWidth',lineM);
hold on;
bar(xptLRatioBar,lratioDRw_Blight,1,'faceColor',colorBlue,'lineWidth',lineM);
hold on;
stairs(xptLRatioStairs,lratioDRw_Slight,'Color',colorBlue,'lineWidth',lineM);
xlabel('L-ratio','fontSize',fontS);
ylabel('Number of neurons','fontSize',fontS);
title('DRw neurons','fontSize',fontS);
set(hLRatio(2),'Box','off','TickDir','out','XLim',[0,0.15],'XTick',[0:0.05:0.15],'fontSize',fontS);

print('-painters','-depsc','-r300',['final_supple6_ID+LRatio','.ai']);
print('-painters','-dtiff','-r300',['final_supple6_ID+LRatio','.tif']);
% print('-painters','-dtiff','-r300',[datestr(now,formatOut),'_plot_LRatio-ID.tif']);
close;