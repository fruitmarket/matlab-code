clearvars;
rtDir = 'E:\Dropbox\Lab_mwjung\P4_FamiliarNovel';
load('E:\Dropbox\Lab_mwjung\P2_Track\myParameters.mat');
formatOut = 'yymmdd';

load('E:\Dropbox\Lab_mwjung\P4_FamiliarNovel\neuronList_familiar_190301.mat');
% load('E:\Dropbox\Lab_mwjung\P4_FamiliarNovel\neuronList_familiar_190203.mat');
PN = T.neuronType == 'PN';

% original
% lightLoc_in = [37:98];
% lightLoc_out = [1:36,99:124];

lightLoc_in = [50:84];
lightLoc_out = [112:124,1:22];

cri_peakFR = 2;

% CA3 total
PN_th = PN & cellfun(@(x) max(max(x)), T.pethconvSpatial)>cri_peakFR;
nPN_th_fam = sum(double(PN_th));

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

[rCor_fam_in_PRExSTIM, rCor_fam_in_PRExPOST, rCor_fam_in_STIMxPOST] = deal([]);
[rCor_fam_out_PRExSTIM, rCor_fam_out_PRExPOST, rCor_fam_out_STIMxPOST] = deal([]);

for iCell = 1:nPN_th_fam
    rCor_fam_in_PRExSTIM(iCell,1) = corr(inZone_PRE(iCell,:)',inZone_STIM(iCell,:)','rows','complete','type','pearson');
    rCor_fam_in_PRExPOST(iCell,1) = corr(inZone_PRE(iCell,:)',inZone_POST(iCell,:)','rows','complete','type','pearson');
    rCor_fam_in_STIMxPOST(iCell,1) = corr(inZone_STIM(iCell,:)',inZone_POST(iCell,:)','rows','complete','type','pearson');
    rCor_fam_out_PRExSTIM(iCell,1) = corr(outZone_PRE(iCell,:)',outZone_STIM(iCell,:)','rows','complete','type','pearson');
    rCor_fam_out_PRExPOST(iCell,1) = corr(outZone_PRE(iCell,:)',outZone_POST(iCell,:)','rows','complete','type','pearson');
    rCor_fam_out_STIMxPOST(iCell,1) = corr(outZone_STIM(iCell,:)',outZone_POST(iCell,:)','rows','complete','type','pearson');
end

% mean spatial correlation
m_rCor_fam_in = [nanmean(rCor_fam_in_PRExSTIM), nanmean(rCor_fam_in_PRExPOST), nanmean(rCor_fam_in_STIMxPOST)];
sem_rCor_fam_in = [nanstd(rCor_fam_in_PRExSTIM)/sqrt(sum(double(~isnan(rCor_fam_in_PRExSTIM)))), nanstd(rCor_fam_in_PRExPOST)/sqrt(sum(double(~isnan(rCor_fam_in_PRExPOST)))), nanstd(rCor_fam_in_STIMxPOST)/sqrt(sum(double(~isnan(rCor_fam_in_STIMxPOST))))];
m_rCor_fam_out = [nanmean(rCor_fam_out_PRExSTIM), nanmean(rCor_fam_out_PRExPOST), nanmean(rCor_fam_out_STIMxPOST)];
sem_rCor_fam_out = [nanstd(rCor_fam_out_PRExSTIM)/sqrt(sum(double(~isnan(rCor_fam_out_PRExSTIM)))), nanstd(rCor_fam_out_PRExPOST)/sqrt(sum(double(~isnan(rCor_fam_out_PRExPOST)))), nanstd(rCor_fam_out_STIMxPOST)/sqrt(sum(double(~isnan(rCor_fam_out_STIMxPOST))))];

% statistic test
[~, p_val_fam(1)] = ttest(rCor_fam_in_PRExSTIM, rCor_fam_out_PRExSTIM);
[~, p_val_fam(2)] = ttest(rCor_fam_in_PRExPOST, rCor_fam_out_PRExPOST);
[~, p_val_fam(3)] = ttest(rCor_fam_in_STIMxPOST, rCor_fam_out_STIMxPOST);


%%
load('E:\Dropbox\Lab_mwjung\P4_FamiliarNovel\neuronList_novel_190301.mat');
PN = T.neuronType == 'PN';

% CA3 total
PN_th = PN & cellfun(@(x) max(max(x(2:4,:))), T.pethconvSpatial)>cri_peakFR;
nPN_th_nov = sum(double(PN_th));

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

[rCor_nov_in_PRExSTIM, rCor_nov_in_PRExPOST, rCor_nov_in_STIMxPOST] = deal([]);
[rCor_nov_out_PRExSTIM, rCor_nov_out_PRExPOST, rCor_nov_out_STIMxPOST] = deal([]);

for iCell = 1:nPN_th_nov
    rCor_nov_in_PRExSTIM(iCell,1) = corr(inZone_PRE(iCell,:)',inZone_STIM(iCell,:)','rows','complete','type','pearson');
    rCor_nov_in_PRExPOST(iCell,1) = corr(inZone_PRE(iCell,:)',inZone_POST(iCell,:)','rows','complete','type','pearson');
    rCor_nov_in_STIMxPOST(iCell,1) = corr(inZone_STIM(iCell,:)',inZone_POST(iCell,:)','rows','complete','type','pearson');
    
    rCor_nov_out_PRExSTIM(iCell,1) = corr(outZone_PRE(iCell,:)',outZone_STIM(iCell,:)','rows','complete','type','pearson');
    rCor_nov_out_PRExPOST(iCell,1) = corr(outZone_PRE(iCell,:)',outZone_POST(iCell,:)','rows','complete','type','pearson');
    rCor_nov_out_STIMxPOST(iCell,1) = corr(outZone_STIM(iCell,:)',outZone_POST(iCell,:)','rows','complete','type','pearson');
end

% mean spatial correlation
m_rCor_nov_in = [nanmean(rCor_nov_in_PRExSTIM), nanmean(rCor_nov_in_PRExPOST), nanmean(rCor_nov_in_STIMxPOST)];
sem_rCor_nov_in = [nanstd(rCor_nov_in_PRExSTIM)/sqrt(sum(double(~isnan(rCor_nov_in_PRExSTIM)))), nanstd(rCor_nov_in_PRExPOST)/sqrt(sum(double(~isnan(rCor_nov_in_PRExPOST)))), nanstd(rCor_nov_in_STIMxPOST)/sqrt(sum(double(~isnan(rCor_nov_in_STIMxPOST))))];
m_rCor_nov_out = [nanmean(rCor_nov_out_PRExSTIM), nanmean(rCor_nov_out_PRExPOST), nanmean(rCor_nov_out_STIMxPOST)];
sem_rCor_nov_out = [nanstd(rCor_nov_out_PRExSTIM)/sqrt(sum(double(~isnan(rCor_nov_out_PRExSTIM)))), nanstd(rCor_nov_out_PRExPOST)/sqrt(sum(double(~isnan(rCor_nov_out_PRExPOST)))), nanstd(rCor_nov_out_STIMxPOST)/sqrt(sum(double(~isnan(rCor_nov_out_STIMxPOST))))];

% statistic test
[~, p_val_nov(1)] = ttest2(rCor_nov_in_PRExSTIM(~isnan(rCor_nov_in_PRExSTIM)), rCor_nov_out_PRExSTIM(~isnan(rCor_nov_out_PRExSTIM)));
[~, p_val_nov(2)] = ttest2(rCor_nov_in_PRExPOST(~isnan(rCor_nov_in_PRExPOST)), rCor_nov_out_PRExPOST(~isnan(rCor_nov_out_PRExPOST)));
[~, p_val_nov(3)] = ttest2(rCor_nov_in_STIMxPOST(~isnan(rCor_nov_in_STIMxPOST)), rCor_nov_out_STIMxPOST(~isnan(rCor_nov_out_STIMxPOST)));

[~, p_val_fam(1)] = ttest2(rCor_fam_in_PRExSTIM(~isnan(rCor_fam_in_PRExSTIM)), rCor_fam_out_PRExSTIM(~isnan(rCor_fam_out_PRExSTIM)));
[~, p_val_fam(2)] = ttest2(rCor_fam_in_PRExPOST(~isnan(rCor_fam_in_PRExPOST)), rCor_fam_out_PRExPOST(~isnan(rCor_fam_out_PRExPOST)));
[~, p_val_fam(3)] = ttest2(rCor_fam_in_STIMxPOST(~isnan(rCor_fam_in_STIMxPOST)), rCor_fam_out_STIMxPOST(~isnan(rCor_fam_out_STIMxPOST)));

%%
barWidth = 0.2;
eBarLength = 0.4;
eBarWidth = 1;
dotS = 4;
colorDot = [55 55 55]/255;

xBar = [1,5,9;
        2,6,10];       

xScatter_fam = (rand(nPN_th_fam,1)-0.5)*barWidth*2.2;
xScatter_nov = (rand(nPN_th_nov,1)-0.5)*barWidth*2.2;

nCol = 2;
nRow = 1;
figSize = [0.10 0.2 0.85 0.70];
wideInterval = [0.15 0.1];

fHandle = figure('PaperUnits','centimeters','PaperPosition',[0 0 14 5]);

hCor(1) = axes('Position',axpt(nCol,nRow,1,1,figSize,wideInterval));
    bar(xBar(1,:),m_rCor_nov_in,barWidth,'faceColor',colorLightBlue);
    hold on;
    errorbarJun(xBar(1,:),m_rCor_nov_in,sem_rCor_nov_in,eBarLength,eBarWidth,colorBlack);
    hold on;
    bar(xBar(2,:),m_rCor_nov_out,barWidth,'faceColor',colorDarkGray);
    hold on;
    errorbarJun(xBar(2,:),m_rCor_nov_out,sem_rCor_nov_out,eBarLength,eBarWidth,colorBlack);
    hold on;
    plot(1+xScatter_nov,rCor_nov_in_PRExSTIM,'.','markerSize',dotS,'markerEdgeColor',colorDot);
    hold on;
    plot(5+xScatter_nov,rCor_nov_in_PRExPOST,'.','markerSize',dotS,'markerEdgeColor',colorDot);
    hold on;
    plot(9+xScatter_nov,rCor_nov_in_STIMxPOST,'.','markerSize',dotS,'markerEdgeColor',colorDot);
    hold on;
    plot(2+xScatter_nov,rCor_nov_out_PRExSTIM,'.','markerSize',dotS,'markerEdgeColor',colorDot);
    hold on;
    plot(6+xScatter_nov,rCor_nov_out_PRExPOST,'.','markerSize',dotS,'markerEdgeColor',colorDot);
    hold on;
    plot(10+xScatter_nov,rCor_nov_out_STIMxPOST,'.','markerSize',dotS,'markerEdgeColor',colorDot);
    text(1,1.5,['n (novel) = ',num2str(nPN_th_nov,3)],'fontSize',fontM);
    text(0,-1.5,['two-ttest: ',num2str(p_val_nov,3)],'fontSize',fontM);
    ylabel('Spatial correlation (r)','fontSize',fontM);

hCor(2) = axes('Position',axpt(nCol,nRow,2,1,figSize,wideInterval));
    bar(xBar(1,:),m_rCor_fam_in,barWidth,'faceColor',colorLLightBlue);
    hold on;
    errorbarJun(xBar(1,:),m_rCor_fam_in,sem_rCor_fam_in,eBarLength,eBarWidth,colorBlack);
    hold on;
    bar(xBar(2,:),m_rCor_fam_out,barWidth,'faceColor',colorGray);
    hold on;
    errorbarJun(xBar(2,:),m_rCor_fam_out,sem_rCor_fam_out,eBarLength,eBarWidth,colorBlack);
    hold on;
    plot(1+xScatter_fam,rCor_fam_in_PRExSTIM,'.','markerSize',dotS,'markerEdgeColor',colorDot);
    hold on;
    plot(5+xScatter_fam,rCor_fam_in_PRExPOST,'.','markerSize',dotS,'markerEdgeColor',colorDot);
    hold on;
    plot(9+xScatter_fam,rCor_fam_in_STIMxPOST,'.','markerSize',dotS,'markerEdgeColor',colorDot);
    hold on;
    plot(2+xScatter_fam,rCor_fam_out_PRExSTIM,'.','markerSize',dotS,'markerEdgeColor',colorDot);
    hold on;
    plot(6+xScatter_fam,rCor_fam_out_PRExPOST,'.','markerSize',dotS,'markerEdgeColor',colorDot);
    hold on;
    plot(10+xScatter_fam,rCor_fam_out_STIMxPOST,'.','markerSize',dotS,'markerEdgeColor',colorDot);
    text(1,1.5,['n (familiar) = ',num2str(nPN_th_fam,3)],'fontSize',fontM);
    text(0,-1.5,['two-ttest: ',num2str(p_val_fam,3)],'fontSize',fontM);
    
    ylabel('Spatial correlation (r)','fontSize',fontM);

set(hCor,'Box','off','TickDir','out','XLim',[0,11],'XTick',[1.5, 5.5, 9.5],'XTickLabel',{'PRExSTIM','PRExPOST','STIMxPOST'},'YLim',[-1,1.5],'YTick',-1:0.5:1,'fontSize',fontM);

print('-painters','-r300','-dtiff',['fig5_spatialcorrelation_',datestr(now,formatOut),'.tif']);
print('-painters','-r300','-depsc',['fig5_spatialcorrelation_',datestr(now,formatOut),'.ai']);

close all;