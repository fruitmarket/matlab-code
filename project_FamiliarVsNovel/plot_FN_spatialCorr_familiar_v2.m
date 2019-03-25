clearvars;

rtDir = 'E:\Dropbox\SNL\P4_FamiliarNovel';
load('E:\Dropbox\SNL\P2_Track\myParameters.mat');
formatOut = 'yymmdd';
load('E:\Dropbox\SNL\P4_FamiliarNovel\neuronList_familiar_190113.mat');
PN = T.neuronType == 'PN';
tt_ca3bc = ((T.mouseID == 'rbp005' & (T.tetrode == 'TT1' | T.tetrode == 'TT5')) | (T.mouseID == 'rbp006' & T.tetrode == 'TT2') | (T.mouseID == 'rbp010' & T.tetrode == 'TT6')); % | (T.mouseID == 'rbp015' & T.tetrode == 'TT7')
PN_ca3bc = PN & tt_ca3bc;
PN_ca3a = PN & ~tt_ca3bc;

lightLoc_in = [37:98];
lightLoc_out = [1:36,99:124];

cri_peakFR = 2;

%% CA3 total
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

[rCor_in_PRExSTIM, rCor_in_PRExPOST, rCor_in_STIMxPOST] = deal([]);
[rCor_out_PRExSTIM, rCor_out_PRExPOST, rCor_out_STIMxPOST] = deal([]);

for iCell = 1:nPN_th
    rCor_in_PRExSTIM(iCell,1) = corr(inZone_PRE(iCell,:)',inZone_STIM(iCell,:)','rows','complete','type','pearson');
    rCor_in_PRExPOST(iCell,1) = corr(inZone_PRE(iCell,:)',inZone_POST(iCell,:)','rows','complete','type','pearson');
    rCor_in_STIMxPOST(iCell,1) = corr(inZone_STIM(iCell,:)',inZone_POST(iCell,:)','rows','complete','type','pearson');
    
    rCor_out_PRExSTIM(iCell,1) = corr(outZone_PRE(iCell,:)',outZone_STIM(iCell,:)','rows','complete','type','pearson');
    rCor_out_PRExPOST(iCell,1) = corr(outZone_PRE(iCell,:)',outZone_POST(iCell,:)','rows','complete','type','pearson');
    rCor_out_STIMxPOST(iCell,1) = corr(outZone_STIM(iCell,:)',outZone_POST(iCell,:)','rows','complete','type','pearson');
end

% mean spatial correlation
m_rCor_in = [nanmean(rCor_in_PRExSTIM), nanmean(rCor_in_PRExPOST), nanmean(rCor_in_STIMxPOST)];
sem_rCor_in = [nanstd(rCor_in_PRExSTIM)/sqrt(sum(double(~isnan(rCor_in_PRExSTIM)))), nanstd(rCor_in_PRExPOST)/sqrt(sum(double(~isnan(rCor_in_PRExPOST)))), nanstd(rCor_in_STIMxPOST)/sqrt(sum(double(~isnan(rCor_in_STIMxPOST))))];
m_rCor_out = [nanmean(rCor_out_PRExSTIM), nanmean(rCor_out_PRExPOST), nanmean(rCor_out_STIMxPOST)];
sem_rCor_out = [nanstd(rCor_out_PRExSTIM)/sqrt(sum(double(~isnan(rCor_out_PRExSTIM)))), nanstd(rCor_out_PRExPOST)/sqrt(sum(double(~isnan(rCor_out_PRExPOST)))), nanstd(rCor_out_STIMxPOST)/sqrt(sum(double(~isnan(rCor_out_STIMxPOST))))];

% statistic test
[~, p_val(1)] = ttest(rCor_in_PRExSTIM, rCor_out_PRExSTIM);
[~, p_val(2)] = ttest(rCor_in_PRExPOST, rCor_out_PRExPOST);
[~, p_val(3)] = ttest(rCor_in_STIMxPOST, rCor_out_STIMxPOST);

%% CA3a
PN_th_a = PN_ca3a & cellfun(@(x) max(max(x)), T.pethconvSpatial)>cri_peakFR;
nPN_th_a = sum(double(PN_th_a));

PRE_a = cell2mat(T.rateMap1D_PRE(PN_th_a));
STIM_a = cell2mat(T.rateMap1D_STM(PN_th_a));
POST_a = cell2mat(T.rateMap1D_POST(PN_th_a));

nBin_a = size(PRE_a,2);

% normalize
PRE_a = PRE_a./repmat(max(PRE_a,[],2),1,nBin_a);
STIM_a = STIM_a./repmat(max(STIM_a,[],2),1,nBin_a);
POST_a = POST_a./repmat(max(POST_a,[],2),1,nBin_a);

% inzone
inZone_PRE_a = PRE_a(:,lightLoc_in);
inZone_STIM_a = STIM_a(:,lightLoc_in);
inZone_POST_a = POST_a(:,lightLoc_in);

% outzone
outZone_PRE_a = PRE_a(:,lightLoc_out);
outZone_STIM_a = STIM_a(:,lightLoc_out);
outZone_POST_a = POST_a(:,lightLoc_out);

[rCor_in_PRExSTIM_a, rCor_in_PRExPOST_a, rCor_in_STIMxPOST_a] = deal([]);
[rCor_out_PRExSTIM_a, rCor_out_PRExPOST_a, rCor_out_STIMxPOST_a] = deal([]);

for iCell = 1:nPN_th_a
    rCor_in_PRExSTIM_a(iCell,1) = corr(inZone_PRE_a(iCell,:)',inZone_STIM_a(iCell,:)','rows','complete','type','pearson');
    rCor_in_PRExPOST_a(iCell,1) = corr(inZone_PRE_a(iCell,:)',inZone_POST_a(iCell,:)','rows','complete','type','pearson');
    rCor_in_STIMxPOST_a(iCell,1) = corr(inZone_STIM_a(iCell,:)',inZone_POST_a(iCell,:)','rows','complete','type','pearson');
    
    rCor_out_PRExSTIM_a(iCell,1) = corr(outZone_PRE_a(iCell,:)',outZone_STIM_a(iCell,:)','rows','complete','type','pearson');
    rCor_out_PRExPOST_a(iCell,1) = corr(outZone_PRE_a(iCell,:)',outZone_POST_a(iCell,:)','rows','complete','type','pearson');
    rCor_out_STIMxPOST_a(iCell,1) = corr(outZone_STIM_a(iCell,:)',outZone_POST_a(iCell,:)','rows','complete','type','pearson');
end

% mean spatial correlation
m_rCor_in_a = [nanmean(rCor_in_PRExSTIM_a), nanmean(rCor_in_PRExPOST_a), nanmean(rCor_in_STIMxPOST_a)];
sem_rCor_in_a = [nanstd(rCor_in_PRExSTIM_a)/sqrt(sum(double(~isnan(rCor_in_PRExSTIM_a)))), nanstd(rCor_in_PRExPOST_a)/sqrt(sum(double(~isnan(rCor_in_PRExPOST_a)))), nanstd(rCor_in_STIMxPOST_a)/sqrt(sum(double(~isnan(rCor_in_STIMxPOST_a))))];
m_rCor_out_a = [nanmean(rCor_out_PRExSTIM_a), nanmean(rCor_out_PRExPOST_a), nanmean(rCor_out_STIMxPOST_a)];
sem_rCor_out_a = [nanstd(rCor_out_PRExSTIM_a)/sqrt(sum(double(~isnan(rCor_out_PRExSTIM_a)))), nanstd(rCor_out_PRExPOST_a)/sqrt(sum(double(~isnan(rCor_out_PRExPOST_a)))), nanstd(rCor_out_STIMxPOST_a)/sqrt(sum(double(~isnan(rCor_out_STIMxPOST_a))))];

% statistic test
[~, p_val_a(1)] = ttest(rCor_in_PRExSTIM_a, rCor_out_PRExSTIM_a);
[~, p_val_a(2)] = ttest(rCor_in_PRExPOST_a, rCor_out_PRExPOST_a);
[~, p_val_a(3)] = ttest(rCor_in_STIMxPOST_a, rCor_out_STIMxPOST_a);

%% ca3bc
PN_th_bc = PN_ca3bc & cellfun(@(x) max(max(x)), T.pethconvSpatial)>cri_peakFR;
nPN_th_bc = sum(double(PN_th_bc));

PRE_bc = cell2mat(T.rateMap1D_PRE(PN_th_bc));
STIM_bc = cell2mat(T.rateMap1D_STM(PN_th_bc));
POST_bc = cell2mat(T.rateMap1D_POST(PN_th_bc));

nBin_bc = size(PRE_bc,2);

% normalize
PRE_bc = PRE_bc./repmat(max(PRE_bc,[],2),1,nBin_bc);
STIM_bc = STIM_bc./repmat(max(STIM_bc,[],2),1,nBin_bc);
POST_bc = POST_bc./repmat(max(POST_bc,[],2),1,nBin_bc);

% inzone
inZone_PRE_bc = PRE_bc(:,lightLoc_in);
inZone_STIM_bc = STIM_bc(:,lightLoc_in);
inZone_POST_bc = POST_bc(:,lightLoc_in);

% outzone
outZone_PRE_bc = PRE_bc(:,lightLoc_out);
outZone_STIM_bc = STIM_bc(:,lightLoc_out);
outZone_POST_bc = POST_bc(:,lightLoc_out);

[rCor_in_PRExSTIM_bc, rCor_in_PRExPOST_bc, rCor_in_STIMxPOST_bc] = deal([]);
[rCor_out_PRExSTIM_bc, rCor_out_PRExPOST_bc, rCor_out_STIMxPOST_bc] = deal([]);

for iCell = 1:nPN_th_bc
    rCor_in_PRExSTIM_bc(iCell,1) = corr(inZone_PRE_bc(iCell,:)',inZone_STIM_bc(iCell,:)','rows','complete','type','pearson');
    rCor_in_PRExPOST_bc(iCell,1) = corr(inZone_PRE_bc(iCell,:)',inZone_POST_bc(iCell,:)','rows','complete','type','pearson');
    rCor_in_STIMxPOST_bc(iCell,1) = corr(inZone_STIM_bc(iCell,:)',inZone_POST_bc(iCell,:)','rows','complete','type','pearson');
    
    rCor_out_PRExSTIM_bc(iCell,1) = corr(outZone_PRE_bc(iCell,:)',outZone_STIM_bc(iCell,:)','rows','complete','type','pearson');
    rCor_out_PRExPOST_bc(iCell,1) = corr(outZone_PRE_bc(iCell,:)',outZone_POST_bc(iCell,:)','rows','complete','type','pearson');
    rCor_out_STIMxPOST_bc(iCell,1) = corr(outZone_STIM_bc(iCell,:)',outZone_POST_bc(iCell,:)','rows','complete','type','pearson');
end

% mean spatial correlation
m_rCor_in_bc = [nanmean(rCor_in_PRExSTIM_bc), nanmean(rCor_in_PRExPOST_bc), nanmean(rCor_in_STIMxPOST_bc)];
sem_rCor_in_bc = [nanstd(rCor_in_PRExSTIM_bc)/sqrt(sum(double(~isnan(rCor_in_PRExSTIM_bc)))), nanstd(rCor_in_PRExPOST_bc)/sqrt(sum(double(~isnan(rCor_in_PRExPOST_bc)))), nanstd(rCor_in_STIMxPOST_bc)/sqrt(sum(double(~isnan(rCor_in_STIMxPOST_bc))))];
m_rCor_out_bc = [nanmean(rCor_out_PRExSTIM_bc), nanmean(rCor_out_PRExPOST_bc), nanmean(rCor_out_STIMxPOST_bc)];
sem_rCor_out_bc = [nanstd(rCor_out_PRExSTIM_bc)/sqrt(sum(double(~isnan(rCor_out_PRExSTIM_bc)))), nanstd(rCor_out_PRExPOST_bc)/sqrt(sum(double(~isnan(rCor_out_PRExPOST_bc)))), nanstd(rCor_out_STIMxPOST_bc)/sqrt(sum(double(~isnan(rCor_out_STIMxPOST_bc))))];

% statistic test
p_val_bc(1) = ranksum(rCor_in_PRExSTIM_bc, rCor_out_PRExSTIM_bc);
p_val_bc(2) = ranksum(rCor_in_PRExPOST_bc, rCor_out_PRExPOST_bc);
p_val_bc(3) = ranksum(rCor_in_STIMxPOST_bc, rCor_out_STIMxPOST_bc);

%% plot
barWidth = 0.3;
eBarWidth = 1;
eBarLength = 0.3;
dotS = 4;

xScatter = (rand(nPN_th,1)-0.5)*barWidth*2.2;
xScatter_a = (rand(nPN_th_a,1)-0.5)*barWidth*2.2;
xScatter_bc = (rand(nPN_th_bc,1)-0.5)*barWidth*2.2;

nCol = 3;
nRow = 3;

fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});

hCor(1) = axes('Position',axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval));
bar([1,4,7],m_rCor_in,0.3,'faceColor',colorLLightBlue);
hold on;
errorbarJun([1,4,7],m_rCor_in,sem_rCor_in,barWidth,1,colorBlack);
hold on;
bar([2,5,8],m_rCor_out,0.3,'faceColor',colorDarkGray);
hold on;
errorbarJun([2,5,8],m_rCor_out,sem_rCor_out,barWidth,1,colorBlack);
plot(1+xScatter,rCor_in_PRExSTIM,'.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(4+xScatter,rCor_in_PRExPOST,'.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(7+xScatter,rCor_in_STIMxPOST,'.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(2+xScatter,rCor_out_PRExSTIM,'.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(5+xScatter,rCor_out_PRExPOST,'.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(8+xScatter,rCor_out_STIMxPOST,'.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
text(7,1.1,['n = ',num2str(nPN_th)],'fontSize',fontM);
text(1,-0.9,['p = ', num2str(p_val,3)],'fontSize',fontM);
ylabel('Spatial correlation (r)','fontSize',fontM);

hCor(2) = axes('Position',axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],wideInterval));
bar([1,4,7],m_rCor_in_a,0.3,'faceColor',colorLLightBlue);
hold on;
errorbarJun([1,4,7],m_rCor_in_a,sem_rCor_in_a,barWidth,1,colorBlack);
hold on;
bar([2,5,8],m_rCor_out_a,0.3,'faceColor',colorDarkGray);
hold on;
errorbarJun([2,5,8],m_rCor_out_a,sem_rCor_out_a,barWidth,1,colorBlack);
plot(1+xScatter_a,rCor_in_PRExSTIM_a,'.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(4+xScatter_a,rCor_in_PRExPOST_a,'.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(7+xScatter_a,rCor_in_STIMxPOST_a,'.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(2+xScatter_a,rCor_out_PRExSTIM_a,'.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(5+xScatter_a,rCor_out_PRExPOST_a,'.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(8+xScatter_a,rCor_out_STIMxPOST_a,'.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
text(7,1.1,['n = ',num2str(nPN_th_a)],'fontSize',fontM);
text(1,-0.9,['p = ', num2str(p_val_a,3)],'fontSize',fontM);
ylabel('Spatial correlation (r)','fontSize',fontM);

hCor(3) = axes('Position',axpt(nCol,nRow,3,1,[0.1 0.1 0.85 0.85],wideInterval));
bar([1,4,7],m_rCor_in_bc,0.3,'faceColor',colorLLightBlue);
hold on;
errorbarJun([1,4,7],m_rCor_in_bc,sem_rCor_in_bc,barWidth,1,colorBlack);
hold on;
bar([2,5,8],m_rCor_out_bc,0.3,'faceColor',colorDarkGray);
hold on;
errorbarJun([2,5,8],m_rCor_out_bc,sem_rCor_out_bc,barWidth,1,colorBlack);
plot(1+xScatter_bc,rCor_in_PRExSTIM_bc,'.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(4+xScatter_bc,rCor_in_PRExPOST_bc,'.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(7+xScatter_bc,rCor_in_STIMxPOST_bc,'.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(2+xScatter_bc,rCor_out_PRExSTIM_bc,'.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(5+xScatter_bc,rCor_out_PRExPOST_bc,'.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(8+xScatter_bc,rCor_out_STIMxPOST_bc,'.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
text(7,1.1,['n = ',num2str(nPN_th_bc)],'fontSize',fontM);
text(1,-0.9,['p = ', num2str(p_val_bc,3)],'fontSize',fontM);
ylabel('Spatial correlation (r)','fontSize',fontM);

set(hCor,'XLim',[0,9],'XTick',[1.5, 4.5, 7.5],'XTickLabel',{'PRExSTIM','PRExPOST','STIMxPOST'},'YLim',[-1,1.2],'YTick',-1:0.5:1);
set(hCor,'Box','off','TickDir','out','fontSize',fontM);

% print('-painters','-r300','-dtiff',['plot_familiar_spatialCorr_v2_',datestr(now,formatOut),'.tif']);
% close all;