clearvars;

rtDir = 'E:\Dropbox\SNL\P4_FamiliarNovel';
load('E:\Dropbox\SNL\P2_Track\myParameters.mat');
formatOut = 'yymmdd';
load('E:\Dropbox\SNL\P4_FamiliarNovel\neuronList_familiar_190112.mat');
PN = T.neuronType == 'PN';
PN_ca3bc = PN & ((T.mouseID == 'rbp005' & (T.tetrode == 'TT1' | T.tetrode == 'TT5')) | (T.mouseID == 'rbp006' & T.tetrode == 'T2') | (T.mouseID == 'rbp010' & T.tetrode == 'T6'));
PN_ca3a = ~PN_ca3bc;

lightLoc_in = [37:98];
lightLoc_out = [1:36,99:124];

cri_peakFR = 2;

PN_th = PN & cellfun(@(x) max(max(x)), T.pethconvSpatial)>cri_peakFR;
nPN_th = sum(double(PN_th));

PRE = cell2mat(T.rateMap1D_PRE(PN_th));
STIM = cell2mat(T.rateMap1D_STM(PN_th));
POST = cell2mat(T.rateMap1D_POST(PN_th));

nBin = size(PRE,2);

% normalize
PRE = PRE./repmat(max(PRE,[],2),1,nBin);
STIM = STIM./repmat(max(STIM,[],2),1,nBin);
POST = POST./repmat(max(POST,[],2),1,nBin);

% inzone
inZone_PRE = PRE(:,lightLoc_in);
inZone_STIM = STIM(:,lightLoc_in);
inZone_POST = POST(:,lightLoc_in);

% outzone
outZone_PRE = PRE(:,lightLoc_out);
outZone_STIM = STIM(:,lightLoc_out);
outZone_POST = POST(:,lightLoc_out);

[rCor_all_PRExSTIM, rCor_all_PRExPOST, rCor_all_STIMxPOST] = deal([]);
[rCor_in_PRExSTIM, rCor_in_PRExPOST, rCor_in_STIMxPOST] = deal([]);
[rCor_out_PRExSTIM, rCor_out_PRExPOST, rCor_out_STIMxPOST] = deal([]);

for iCell = 1:nPN_th
    rCor_all_PRExSTIM(iCell,1) = corr(PRE(iCell,:)',STIM(iCell,:)','rows','complete','type','pearson');
    rCor_all_PRExPOST(iCell,1) = corr(PRE(iCell,:)',POST(iCell,:)','rows','complete','type','pearson');
    rCor_all_STIMxPOST(iCell,1) = corr(STIM(iCell,:)',POST(iCell,:)','rows','complete','type','pearson');
    
    rCor_in_PRExSTIM(iCell,1) = corr(inZone_PRE(iCell,:)',inZone_STIM(iCell,:)','rows','complete','type','pearson');
    rCor_in_PRExPOST(iCell,1) = corr(inZone_PRE(iCell,:)',inZone_POST(iCell,:)','rows','complete','type','pearson');
    rCor_in_STIMxPOST(iCell,1) = corr(inZone_STIM(iCell,:)',inZone_POST(iCell,:)','rows','complete','type','pearson');
    
    rCor_out_PRExSTIM(iCell,1) = corr(outZone_PRE(iCell,:)',outZone_STIM(iCell,:)','rows','complete','type','pearson');
    rCor_out_PRExPOST(iCell,1) = corr(outZone_PRE(iCell,:)',outZone_POST(iCell,:)','rows','complete','type','pearson');
    rCor_out_STIMxPOST(iCell,1) = corr(outZone_STIM(iCell,:)',outZone_POST(iCell,:)','rows','complete','type','pearson');
end

% mean spatial correlation
m_rCor_in = [nanmean(rCor_in_PRExSTIM), nanmean(rCor_in_PRExPOST), nanmean(rCor_in_STIMxPOST)];
sem_rCor_in = [nanmean(rCor_in_PRExSTIM)/sqrt(sum(double(~isnan(rCor_in_PRExSTIM)))), nanmean(rCor_in_PRExPOST)/sqrt(sum(double(~isnan(rCor_in_PRExPOST)))), nanmean(rCor_in_STIMxPOST)/sqrt(sum(double(~isnan(rCor_in_STIMxPOST))))];

m_rCor_out = [nanmean(rCor_out_PRExSTIM), nanmean(rCor_out_PRExPOST), nanmean(rCor_out_STIMxPOST)];
sem_rCor_out = [nanmean(rCor_out_PRExSTIM)/sqrt(sum(double(~isnan(rCor_out_PRExSTIM)))), nanmean(rCor_out_PRExPOST)/sqrt(sum(double(~isnan(rCor_out_PRExPOST)))), nanmean(rCor_out_STIMxPOST)/sqrt(sum(double(~isnan(rCor_out_STIMxPOST))))];

% histogram
point_all = [rCor_all_PRExSTIM,rCor_all_PRExPOST,zeros(nPN_th,1)];
point_in = [rCor_in_PRExSTIM,rCor_in_PRExPOST,zeros(nPN_th,1)];
point_out = [rCor_out_PRExSTIM,rCor_out_PRExPOST,zeros(nPN_th,1)];
[dist_all, dist_in, dist_out] = deal(zeros(nPN_th,1));
for iDist = 1:nPN_th
    dist_all(iDist,:) = point2line(point_all(iDist,:),[-1,-1,0],[1,1,0]);
    dist_in(iDist,:) = point2line(point_in(iDist,:),[-1,-1,0],[1,1,0]);
    dist_out(iDist,:) = point2line(point_out(iDist,:),[-1,-1,0],[1,1,0]);
end
[hist_in, xptBar] = histcounts(dist_in,[-1:0.1:1]);
xptBar(end) = [];
hist_out = histcounts(dist_out,[-1:0.1:1]);

%% plot
barWidth = 0.5;
barWidth2 = 0.3;
eBarWidth = 1;
eBarLength = 0.3;
dotS = 4;

xScatter = (rand(nPN_th,1)-0.5)*barWidth*2.2;
xScatter2 = (rand(nPN_th,1)-0.5)*barWidth2*2.2;
nCol = 2;
nRow = 4;

fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});

% PRExSTIM vs. PRExPOST
hCor(1) = axes('Position',axpt(3,1,1,1,axpt(nCol,nRow,1:2,1,[],wideInterval),wideInterval));
plot([-1,1],[-1,1],'lineStyle','--','color',colorDarkGray);
hold on;
plot(rCor_all_PRExSTIM,rCor_all_PRExPOST,'lineStyle','none','marker','o','markerSize',markerM);
grid on;
ylabel('PRExPOST','fontSize',fontM);
xlabel('PRExSTIM','fontSize',fontM);
title('Spatial correlation (r) [Total]','fontSize',fontM);

hCor(2) = axes('Position',axpt(3,1,2,1,axpt(nCol,nRow,1:2,1,[],wideInterval),wideInterval));
plot([-1,1],[-1,1],'lineStyle','--','color',colorDarkGray);
hold on;
plot(rCor_in_PRExSTIM,rCor_in_PRExPOST,'lineStyle','none','marker','o','markerSize',markerM);
grid on;
ylabel('PRExPOST','fontSize',fontM);
xlabel('PRExSTIM','fontSize',fontM);
title('Spatial correlation (r) [In-zone]','fontSize',fontM);

hCor(3) = axes('Position',axpt(3,1,3,1,axpt(nCol,nRow,1:2,1,[],wideInterval),wideInterval));
plot([-1,1],[-1,1],'lineStyle','--','color',colorDarkGray);
hold on;
plot(rCor_out_PRExSTIM,rCor_out_PRExPOST,'lineStyle','none','marker','o','markerSize',markerM);
grid on;
ylabel('PRExPOST','fontSize',fontM);
xlabel('PRExSTIM','fontSize',fontM);
title('Spatial correlation (r) [Out-zone]','fontSize',fontM);

hCor(4) = axes('Position',axpt(3,1,2,1,axpt(nCol,nRow,1:2,2,[],wideInterval),wideInterval));
barIn = bar(xptBar,hist_in,'histc');
barIn.FaceColor = colorDarkGray;
ylabel('Counts','fontSize',fontM);
xlabel('Distribution','fontSize',fontM);

hCor(5) = axes('Position',axpt(3,1,3,1,axpt(nCol,nRow,1:2,2,[],wideInterval),wideInterval));
barIn = bar(xptBar,hist_out,'histc');
barIn.FaceColor = colorDarkGray;
xlabel('Distribution','fontSize',fontM);

hCor(6) = axes('Position',axpt(3,1,1,1,axpt(nCol,nRow,1:2,3,[],wideInterval),wideInterval));
bar([1,4,7],m_rCor_in,0.3,'faceColor',colorLLightBlue);
hold on;
errorbarJun([1,4,7],m_rCor_in,sem_rCor_in,barWidth2,1,colorBlack);
hold on;
bar([2,5,8],m_rCor_out,0.3,'faceColor',colorDarkGray);
hold on;
errorbarJun([2,5,8],m_rCor_out,sem_rCor_out,barWidth2,1,colorBlack);

plot(1+xScatter2,rCor_in_PRExSTIM,'.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(4+xScatter2,rCor_in_PRExPOST,'.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(7+xScatter2,rCor_in_STIMxPOST,'.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(2+xScatter2,rCor_out_PRExSTIM,'.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(5+xScatter2,rCor_out_PRExPOST,'.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(8+xScatter2,rCor_out_STIMxPOST,'.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);

ylabel('Spatial correlation (r)','fontSize',fontM);

set(hCor(1:3),'XLim',[-1 1.1],'YLim',[-1 1.1],'XTick',-1:0.5:1,'YTick',-1:0.5:1);
set(hCor(4:5)','YLim',[0,25],'YTick',0:5:25);
set(hCor(6),'XLim',[0,9],'XTick',[1.5, 4.5, 7.5],'XTickLabel',{'PRExSTIM','PRExPOST','STIMxPOST'},'YLim',[-1,1.2],'YTick',-1:0.5:1);
set(hCor,'Box','off','TickDir','out','fontSize',fontM);

print('-painters','-r300','-dtiff',['plot_familiar_spatialCorr_',datestr(now,formatOut),'.tif']);
close all;