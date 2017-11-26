function gplot_neuralTrace_v4_DRun
% Neural distance calculated by mahalanobis distance

% common part
clearvars;
rtDir = 'D:\Dropbox\SNL\P2_Track';
cd(rtDir);

load('D:\Dropbox\SNL\P2_Track\myParameters.mat');
load('neuronList_ori_170815.mat');
Txls = readtable('neuronList_ori_170815.xlsx');
Txls.taskType = categorical(Txls.taskType);
formatOut = 'yymmdd';

% total population (DRunPN / DRunIN / DRwPN / DRwIN) with light responsiveness (light activated)
DRun_PN_ina = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == -1;

peri = DRun_PN_ina & ~T.idxOverLapLengthSTM;
center = DRun_PN_ina & T.idxOverLapLengthSTM;
fileList = T.path(peri);
cellID = T.cellID(peri);
plot_Track_multi_v3_lightconfirm(fileList,cellID,'C:\Users\Jun\Desktop\peri');

fileList = T.path(center);
cellID = T.cellID(center);
plot_Track_multi_v3_lightconfirm(fileList,cellID,'C:\Users\Jun\Desktop\center')

% peri = ~logical(T.idxOverLapLengthSTM(DRun_PN_ina)); % index of overlap
% center = logical(T.idxOverLapLengthSTM(DRun_PN_ina)); % index of overlap
%% Raw data
spikePsdPreD = cell2mat(T.spikePsdPreD);
spikePsdStmD = cell2mat(T.spikePsdStmD);
spikePsdPostD = cell2mat(T.spikePsdPostD);

spikePRE = spikePsdPreD(DRun_PN_ina,:);
spikeSTM = spikePsdStmD(DRun_PN_ina,:);
spikePOST = spikePsdPostD(DRun_PN_ina,:);

[nCell, nBin] = size(spikePRE);

%% Normalized first --> spike sum or spike norm
normF_SpikePRE = spikePRE./repmat(mean(spikePRE(:,1:10),2),1,124);
normF_SpikeSTM = spikeSTM./repmat(mean(spikeSTM(:,1:10),2),1,124);
normF_SpikePOST = spikePOST./repmat(mean(spikePOST(:,1:10),2),1,124);

sum_normF_SpikePRE = nansum(normF_SpikePRE,1);
sum_normF_SpikeSTM = sum(normF_SpikeSTM,1);
sum_normF_SpikePOST = sum(normF_SpikePOST,1);

mean_normF_SpikePRE = nanmean(normF_SpikePRE,1);
mean_normF_SpikeSTM = mean(normF_SpikeSTM,1);
mean_normF_SpikePOST = mean(normF_SpikePOST,1);

%% Smoothed data --> normalized --> spike sum / spike norm
[spikeSmthPRE, spikeSmthSTM, spikeSmthPOST] = deal(zeros(nCell,nBin));
winWidth = 5;
for iCell = 1:nCell
    spikeSmthPRE(iCell,:) = smooth(spikePRE(iCell,:),winWidth);
    spikeSmthSTM(iCell,:) = smooth(spikeSTM(iCell,:),winWidth);
    spikeSmthPOST(iCell,:) = smooth(spikePOST(iCell,:),winWidth);
end
spikeSmthPRE = spikeSmthPRE(:,3:end-2);
spikeSmthSTM = spikeSmthSTM(:,3:end-2);
spikeSmthPOST = spikeSmthPOST(:,3:end-2);

sum_spikeSmthPRE = sum(spikeSmthPRE./repmat(mean(spikeSmthPRE(:,1:10),2),1,120),1);
sum_spikeSmthSTM = sum(spikeSmthSTM./repmat(mean(spikeSmthSTM(:,1:10),2),1,120),1);
sum_spikeSmthPOST = sum(spikeSmthPOST./repmat(mean(spikeSmthPOST(:,1:10),2),1,120),1);

mean_spikeSmthPRE = mean(spikeSmthPRE./repmat(mean(spikeSmthPRE(:,1:10),2),1,120),1);
mean_spikeSmthSTM = mean(spikeSmthSTM./repmat(mean(spikeSmthSTM(:,1:10),2),1,120),1);
mean_spikeSmthPOST = mean(spikeSmthPOST./repmat(mean(spikeSmthPOST(:,1:10),2),1,120),1);

%% calculate base & normalized by base
basePRE = mean(spikeSmthPRE(:,1:10),2);
baseSTM = mean(spikeSmthSTM(:,1:10),2);
basePOST = mean(spikeSmthPOST(:,1:10),2);

[norm_NT_PRE, norm_NT_STM, norm_NT_POST] = deal(zeros(nCell,1));
nBin = size(spikeSmthPRE,2); % drop first two and last two elements
for iCell = 1:nCell
    for iBin = 1:nBin
        norm_NT_PRE(iCell,iBin) = (spikeSmthPRE(iCell,iBin)-basePRE(iCell,1))^2/basePRE(iCell,1);
        norm_NT_STM(iCell,iBin) = (spikeSmthSTM(iCell,iBin)-baseSTM(iCell,1))^2/baseSTM(iCell,1);
        norm_NT_POST(iCell,iBin) = (spikeSmthPOST(iCell,iBin)-basePOST(iCell,1))^2/basePOST(iCell,1);
    end
end
neuralTrace_PRE = sqrt(sum(norm_NT_PRE,1));
neuralTrace_STM = sqrt(sum(norm_NT_STM,1));
neuralTrace_POST = sqrt(sum(norm_NT_POST,1));

%% select abnormal(?) examples
ab_sum_normF_SpikePRE = sum(normF_SpikePRE(peri,:),1); % it was [8 11 12 14] but 12 is nan. so 12 was not included.
ab_sum_normF_SpikeSTM = sum(normF_SpikeSTM(peri,:),1);
ab_sum_normF_SpikePOST = sum(normF_SpikePOST(peri,:),1);

ab_mean_normF_SpikePRE = mean(normF_SpikePRE(peri,:),1);
ab_mean_normF_SpikeSTM = mean(normF_SpikeSTM(peri,:),1);
ab_mean_normF_SpikePOST = mean(normF_SpikePOST(peri,:),1);

ab_sum_spikeSmthPRE = sum(spikeSmthPRE(peri,:)./repmat(mean(spikeSmthPRE(peri,1:10),2),1,120),1);
ab_sum_spikeSmthSTM = sum(spikeSmthSTM(peri,:)./repmat(mean(spikeSmthSTM(peri,1:10),2),1,120),1);
ab_sum_spikeSmthPOST = sum(spikeSmthPOST(peri,:)./repmat(mean(spikeSmthPOST(peri,1:10),2),1,120),1);

ab_mean_spikeSmthPRE = mean(spikeSmthPRE(peri,:)./repmat(mean(spikeSmthPRE(peri,1:10),2),1,120),1);
ab_mean_spikeSmthSTM = mean(spikeSmthSTM(peri,:)./repmat(mean(spikeSmthSTM(peri,1:10),2),1,120),1);
ab_mean_spikeSmthPOST = mean(spikeSmthPOST(peri,:)./repmat(mean(spikeSmthPOST(peri,1:10),2),1,120),1);

ab_neuralTrace_PRE = sqrt(sum(norm_NT_PRE(peri,:),1));
ab_neuralTrace_STM = sqrt(sum(norm_NT_STM(peri,:),1));
ab_neuralTrace_POST = sqrt(sum(norm_NT_POST(peri,:),1));

%% normal population
nor_sum_normF_SpikePRE = nansum(normF_SpikePRE(center,:),1);
nor_sum_normF_SpikeSTM = sum(normF_SpikeSTM(center,:),1);
nor_sum_normF_SpikePOST = sum(normF_SpikePOST(center,:),1);

nor_mean_normF_SpikePRE = nanmean(normF_SpikePRE(center,:),1);
nor_mean_normF_SpikeSTM = mean(normF_SpikeSTM(center,:),1);
nor_mean_normF_SpikePOST = mean(normF_SpikePOST(center,:),1);

nor_sum_spikeSmthPRE = sum(spikeSmthPRE(center,:)./repmat(mean(spikeSmthPRE(center,1:10),2),1,120),1);
nor_sum_spikeSmthSTM = sum(spikeSmthSTM(center,:)./repmat(mean(spikeSmthSTM(center,1:10),2),1,120),1);
nor_sum_spikeSmthPOST = sum(spikeSmthPOST(center,:)./repmat(mean(spikeSmthPOST(center,1:10),2),1,120),1);

nor_mean_spikeSmthPRE = mean(spikeSmthPRE(center,:)./repmat(mean(spikeSmthPRE(center,1:10),2),1,120),1);
nor_mean_spikeSmthSTM = mean(spikeSmthSTM(center,:)./repmat(mean(spikeSmthSTM(center,1:10),2),1,120),1);
nor_mean_spikeSmthPOST = mean(spikeSmthPOST(center,:)./repmat(mean(spikeSmthPOST(center,1:10),2),1,120),1);

nor_neuralTrace_PRE = sqrt(sum(norm_NT_PRE(center,:),1));
nor_neuralTrace_STM = sqrt(sum(norm_NT_STM(center,:),1));
nor_neuralTrace_POST = sqrt(sum(norm_NT_POST(center,:),1));

%% reference figures


%% 
fHandle(1) = figure('PaperUnits','centimeters','PaperPosition',paperSize{2});
nCol = 3;
nRow = 3;
xpt = -10:109;
markerXS = 3;

%%
hRaw(1) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval),wideInterval));
plot(-12:111,sum_normF_SpikePRE,'-o','color',colorGray,'MarkerFaceColor',colorDarkGray,'markerSize',markerXS,'LineWidth',lineL);
hold on;
plot(-12:111,sum_normF_SpikeSTM,'-o','color',colorLightRed,'MarkerFaceColor',colorDarkRed,'markerSize',markerXS,'LineWidth',lineL);
hold on;
plot(-12:111,sum_normF_SpikePOST,'-o','color',colorBlack,'MarkerFaceColor',colorBlack,'markerSize',markerXS,'LineWidth',lineL);
text(-5,50,'Raw normalized spike sum','fontSize',fontM);
title(['Total inactivated neurons (n = ',num2str(length(peri)),')'],'fontSize',fontL,'fontWeight','bold');

hRaw(2) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval),wideInterval));
plot(-12:111,mean_normF_SpikePRE,'-o','color',colorGray,'MarkerFaceColor',colorDarkGray,'markerSize',markerXS,'LineWidth',lineL);
hold on;
plot(-12:111,mean_normF_SpikeSTM,'-o','color',colorLightRed,'MarkerFaceColor',colorDarkRed,'markerSize',markerXS,'LineWidth',lineL);
hold on;
plot(-12:111,mean_normF_SpikePOST,'-o','color',colorBlack,'MarkerFaceColor',colorBlack,'markerSize',markerXS,'LineWidth',lineL);
text(-5,8,'Raw normalized spike mean','fontSize',fontM);

hRaw(3) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],wideInterval),wideInterval));
plot(-12:111,ab_sum_normF_SpikePRE,'-o','color',colorGray,'MarkerFaceColor',colorDarkGray,'markerSize',markerXS,'LineWidth',lineL);
hold on;
plot(-12:111,ab_sum_normF_SpikeSTM,'-o','color',colorLightRed,'MarkerFaceColor',colorDarkRed,'markerSize',markerXS,'LineWidth',lineL);
hold on;
plot(-12:111,ab_sum_normF_SpikePOST,'-o','color',colorBlack,'MarkerFaceColor',colorBlack,'markerSize',markerXS,'LineWidth',lineL);
text(-5,50,'Raw normalized spike sum','fontSize',fontM);
title(['Neurons with place field at edge (n = ',num2str(sum(double(peri))),')'],'fontSize',fontL,'fontWeight','bold');

hRaw(4) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],wideInterval),wideInterval));
plot(-12:111,ab_mean_normF_SpikePRE,'-o','color',colorGray,'MarkerFaceColor',colorDarkGray,'markerSize',markerXS,'LineWidth',lineL);
hold on;
plot(-12:111,ab_mean_normF_SpikeSTM,'-o','color',colorLightRed,'MarkerFaceColor',colorDarkRed,'markerSize',markerXS,'LineWidth',lineL);
hold on;
plot(-12:111,ab_mean_normF_SpikePOST,'-o','color',colorBlack,'MarkerFaceColor',colorBlack,'markerSize',markerXS,'LineWidth',lineL);
text(-5,8,'Raw normalized spike mean','fontSize',fontM);

hRaw(5) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,3,1,[0.1 0.1 0.85 0.85],wideInterval),wideInterval));
plot(-12:111,nor_sum_normF_SpikePRE,'-o','color',colorGray,'MarkerFaceColor',colorDarkGray,'markerSize',markerXS,'LineWidth',lineL);
hold on;
plot(-12:111,nor_sum_normF_SpikeSTM,'-o','color',colorLightRed,'MarkerFaceColor',colorDarkRed,'markerSize',markerXS,'LineWidth',lineL);
hold on;
plot(-12:111,nor_sum_normF_SpikePOST,'-o','color',colorBlack,'MarkerFaceColor',colorBlack,'markerSize',markerXS,'LineWidth',lineL);
hold on;
text(-5,50,'Raw normalized spike sum','fontSize',fontM);
title(['Rest neurons (n = ',num2str(sum(double(center))),')'],'fontSize',fontL,'fontWeight','bold');

hRaw(6) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,3,1,[0.1 0.1 0.85 0.85],wideInterval),wideInterval));
plot(-12:111,nor_mean_normF_SpikePRE,'-o','color',colorGray,'MarkerFaceColor',colorDarkGray,'markerSize',markerXS,'LineWidth',lineL);
hold on;
plot(-12:111,nor_mean_normF_SpikeSTM,'-o','color',colorLightRed,'MarkerFaceColor',colorDarkRed,'markerSize',markerXS,'LineWidth',lineL);
hold on;
plot(-12:111,nor_mean_normF_SpikePOST,'-o','color',colorBlack,'MarkerFaceColor',colorBlack,'markerSize',markerXS,'LineWidth',lineL);
hold on;
text(-5,8,'Raw normalized spike mean','fontSize',fontM);

%% Smooth
hSmth(1) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,1,2,[0.1 0.1 0.85 0.85],wideInterval),wideInterval));
plot(xpt,sum_spikeSmthPRE,'-o','color',colorGray,'MarkerFaceColor',colorDarkGray,'markerSize',markerXS,'LineWidth',lineL);
hold on;
plot(xpt,sum_spikeSmthSTM,'-o','color',colorLightRed,'MarkerFaceColor',colorDarkRed,'markerSize',markerXS,'LineWidth',lineL);
hold on;
plot(xpt,sum_spikeSmthPOST,'-o','color',colorBlack,'MarkerFaceColor',colorBlack,'markerSize',markerXS,'LineWidth',lineL);
text(-5,30,'Smoothed normalized spike sum','fontSize',fontM);

hSmth(2) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,1,2,[0.1 0.1 0.85 0.85],wideInterval),wideInterval));
plot(xpt,mean_spikeSmthPRE,'-o','color',colorGray,'MarkerFaceColor',colorDarkGray,'markerSize',markerXS,'LineWidth',lineL);
hold on;
plot(xpt,mean_spikeSmthSTM,'-o','color',colorLightRed,'MarkerFaceColor',colorDarkRed,'markerSize',markerXS,'LineWidth',lineL);
hold on;
plot(xpt,mean_spikeSmthPOST,'-o','color',colorBlack,'MarkerFaceColor',colorBlack,'markerSize',markerXS,'LineWidth',lineL);
text(-5,5,'Smoothed normalized spike mean','fontSize',fontM);

hSmth(3) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,2,2,[0.1 0.1 0.85 0.85],wideInterval),wideInterval));
plot(xpt,ab_sum_spikeSmthPRE,'-o','color',colorGray,'MarkerFaceColor',colorDarkGray,'markerSize',markerXS,'LineWidth',lineL);
hold on;
plot(xpt,ab_sum_spikeSmthSTM,'-o','color',colorLightRed,'MarkerFaceColor',colorDarkRed,'markerSize',markerXS,'LineWidth',lineL);
hold on;
plot(xpt,ab_sum_spikeSmthPOST,'-o','color',colorBlack,'MarkerFaceColor',colorBlack,'markerSize',markerXS,'LineWidth',lineL);
text(-5,30,'Smoothed normalized spike sum','fontSize',fontM);

hSmth(4) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,2,2,[0.1 0.1 0.85 0.85],wideInterval),wideInterval));
plot(xpt,ab_mean_spikeSmthPRE,'-o','color',colorGray,'MarkerFaceColor',colorDarkGray,'markerSize',markerXS,'LineWidth',lineL);
hold on;
plot(xpt,ab_mean_spikeSmthSTM,'-o','color',colorLightRed,'MarkerFaceColor',colorDarkRed,'markerSize',markerXS,'LineWidth',lineL);
hold on;
plot(xpt,ab_mean_spikeSmthPOST,'-o','color',colorBlack,'MarkerFaceColor',colorBlack,'markerSize',markerXS,'LineWidth',lineL);
text(-5,5,'Smoothed normalized spike mean','fontSize',fontM);

hSmth(5) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,3,2,[0.1 0.1 0.85 0.85],wideInterval),wideInterval));
plot(xpt,nor_sum_spikeSmthPRE,'-o','color',colorGray,'MarkerFaceColor',colorDarkGray,'markerSize',markerXS,'LineWidth',lineL);
hold on;
plot(xpt,nor_sum_spikeSmthSTM,'-o','color',colorLightRed,'MarkerFaceColor',colorDarkRed,'markerSize',markerXS,'LineWidth',lineL);
hold on;
plot(xpt,nor_sum_spikeSmthPOST,'-o','color',colorBlack,'MarkerFaceColor',colorBlack,'markerSize',markerXS,'LineWidth',lineL);
hold on;
text(-5,30,'Smoothed normalized spike sum','fontSize',fontM);

hSmth(6) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,3,2,[0.1 0.1 0.85 0.85],wideInterval),wideInterval));
plot(xpt,nor_mean_spikeSmthPRE,'-o','color',colorGray,'MarkerFaceColor',colorDarkGray,'markerSize',markerXS,'LineWidth',lineL);
hold on;
plot(xpt,nor_mean_spikeSmthSTM,'-o','color',colorLightRed,'MarkerFaceColor',colorDarkRed,'markerSize',markerXS,'LineWidth',lineL);
hold on;
plot(xpt,nor_mean_spikeSmthPOST,'-o','color',colorBlack,'MarkerFaceColor',colorBlack,'markerSize',markerXS,'LineWidth',lineL);
hold on;
text(-5,5,'Smoothed normalized spike mean','fontSize',fontM);

%% Trace
hTrace(1) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1,3,[0.1 0.1 0.85 0.85],wideInterval),wideInterval));
plot(xpt,neuralTrace_PRE,'-o','color',colorGray,'MarkerFaceColor',colorDarkGray,'markerSize',markerXS,'LineWidth',lineL);
hold on;
plot(xpt,neuralTrace_STM,'-o','color',colorLightRed,'MarkerFaceColor',colorDarkRed,'markerSize',markerXS,'LineWidth',lineL);
hold on;
plot(xpt,neuralTrace_POST,'-o','color',colorBlack,'MarkerFaceColor',colorBlack,'markerSize',markerXS,'LineWidth',lineL);
ylabel('Distance','fontSize',fontM);
text(-5,8,'Neural trace','fontSize',fontM);

hTrace(2) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,2,3,[0.1 0.1 0.85 0.85],wideInterval),wideInterval));
plot(xpt,ab_neuralTrace_PRE,'-o','color',colorGray,'MarkerFaceColor',colorDarkGray,'markerSize',markerXS,'LineWidth',lineL);
hold on;
plot(xpt,ab_neuralTrace_STM,'-o','color',colorLightRed,'MarkerFaceColor',colorDarkRed,'markerSize',markerXS,'LineWidth',lineL);
hold on;
plot(xpt,ab_neuralTrace_POST,'-o','color',colorBlack,'MarkerFaceColor',colorBlack,'markerSize',markerXS,'LineWidth',lineL);
text(-5,8,'Neural trace','fontSize',fontM);

hTrace(3) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,3,3,[0.1 0.1 0.85 0.85],wideInterval),wideInterval));
plot(xpt,nor_neuralTrace_PRE,'-o','color',colorGray,'MarkerFaceColor',colorDarkGray,'markerSize',markerXS,'LineWidth',lineL);
hold on;
plot(xpt,nor_neuralTrace_STM,'-o','color',colorLightRed,'MarkerFaceColor',colorDarkRed,'markerSize',markerXS,'LineWidth',lineL);
hold on;
plot(xpt,nor_neuralTrace_POST,'-o','color',colorBlack,'MarkerFaceColor',colorBlack,'markerSize',markerXS,'LineWidth',lineL);
hold on;
% plot(xpt,sqrt(norm_NT_STM(center,:)),'-o','color',colorLightBlue,'MarkerFaceColor',colorBlue,'markerSize',markerXS,'LineWidth',lineL);
text(-5,8,'Neural trace','fontSize',fontM);

set(hRaw([1,3,5]),'Box','off','TickDir','out','XLim',[-12,111],'XTick',[-10:10:40,100],'YLim',[0 70],'fontSize',fontM);
set(hRaw([2,4,6]),'Box','off','TickDir','out','XLim',[-12,111],'XTick',[-10:10:40,100],'YLim',[0 10],'fontSize',fontM);
set(hSmth([1,3,5]),'Box','off','TickDir','out','XLim',[-10,109],'XTick',[-10:10:40,100],'YLim',[0 40],'fontSize',fontM);
set(hSmth([2,4,6]),'Box','off','TickDir','out','XLim',[-10,109],'XTick',[-10:10:40,100],'YLim',[0 5],'fontSize',fontM);
set(hTrace,'Box','off','TickDir','out','XLim',[-10,109],'YLim',[0, 10],'XTick',[-10:10:40,100],'fontSize',fontM);

print('-painters','-r300','-dtiff',[datestr(now,formatOut),'_neuralTrace_v4_DRun','.tif']);


%%
% fHandle(1) = figure('PaperUnits','centimeters','PaperPosition',[0 0 15 15]);
% nCol = 1;
% nRow = 1;
% hTrace(1) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval),wideInterval));
% plot(xpt,neuralTrace_PRE,'-o','color',colorGray,'MarkerFaceColor',colorDarkGray,'markerSize',markerXS,'LineWidth',lineL);
% hold on;
% plot(xpt,neuralTrace_STM,'-o','color',colorLightRed,'MarkerFaceColor',colorDarkRed,'markerSize',markerXS,'LineWidth',lineL);
% hold on;
% plot(xpt,neuralTrace_POST,'-o','color',colorBlack,'MarkerFaceColor',colorBlack,'markerSize',markerXS,'LineWidth',lineL);
% text(-5,130,'Neural trace','fontSize',fontL);

% hTrace(2) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],wideInterval),wideInterval));
% plot(xpt,ab_neuralTrace_PRE,'-o','color',colorGray,'MarkerFaceColor',colorDarkGray,'markerSize',markerXS,'LineWidth',lineL);
% hold on;
% plot(xpt,ab_neuralTrace_STM,'-o','color',colorLightRed,'MarkerFaceColor',colorDarkRed,'markerSize',markerXS,'LineWidth',lineL);
% hold on;
% plot(xpt,ab_neuralTrace_POST,'-o','color',colorBlack,'MarkerFaceColor',colorBlack,'markerSize',markerXS,'LineWidth',lineL);
% text(-5,130,'Neural trace','fontSize',fontM);
% 
% hTrace(3) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,3,1,[0.1 0.1 0.85 0.85],wideInterval),wideInterval));
% plot(xpt,nor_neuralTrace_PRE,'-o','color',colorGray,'MarkerFaceColor',colorDarkGray,'markerSize',markerXS,'LineWidth',lineL);
% hold on;
% plot(xpt,nor_neuralTrace_STM,'-o','color',colorLightRed,'MarkerFaceColor',colorDarkRed,'markerSize',markerXS,'LineWidth',lineL);
% hold on;
% plot(xpt,nor_neuralTrace_POST,'-o','color',colorBlack,'MarkerFaceColor',colorBlack,'markerSize',markerXS,'LineWidth',lineL);
% hold on;
% plot(xpt,norm_NT_STM(center,:),'-o','color',colorLightBlue,'MarkerFaceColor',colorBlue,'markerSize',markerXS,'LineWidth',lineL);
% text(-5,28,'Neural trace','fontSize',fontM);

% set(hTrace,'Box','off','TickDir','out','XLim',[-10,109],'XTick',[-10:10:40,100],'fontSize',fontL);
% print('-painters','-r300','-dtiff',[datestr(now,formatOut),'_neuralTrace_v4_normDist_example','.tif']);
close all;
end

function [spike, smth_spike, m_neuralDist, sem_neuralDist, neuralDist, tracePCA, scorePCA, latentPCA] = analysis_neuralTrace(neuronList,winWidth,mvWinStep,baseLine)
% function analysis_neural Track calculates neural response distance and
% spike trace (by using PCA)
%   input: neuronList 1 x n cell array that each row represents spike times of each neuron 
%       winWidth: an range for window size
%       mvWinStep: moving Window step
%       baseLine: [x, y] start point and end point (unit: msec)
%   output:
%       m_neuralDist: mean neural dist of total neurons
%       neuralDist: each row represents neural dist of one neuron
%       tracePCA: pca results
%       scoePCA: now use score value
%       LatentPCA: representation proportion
%   Author: Joonyeup Lee
%   Version 1.0 (3/23/2017)

if nargin == 1
    winWidth = 5;
    mvWinStep = 1;
    baseLine = [-20, 0];
elseif nargin == 2 | nargin == 3 | nargin > 4
    error('Neural trace: The function needs four input elements.');
end

win = -22:mvWinStep:102;
% nBin = length(win)-1;
nBin = length(win);
nCell = size(neuronList,1);
[smth_spike,neuralDist] = deal(zeros(nCell,nBin));
m_neuralDist = zeros(nBin,1);

temp_spike = cellfun(@(x) histc(x,win),neuronList,'UniformOutput',false);
emptyIdx = find(cellfun(@isempty,temp_spike));

for iIdx = 1:length(emptyIdx)
    temp_spike{emptyIdx(iIdx)} = zeros(1,length(win));
end

spike = cell2mat(temp_spike);
% spike(:,end) = [];
for iCell = 1:nCell
   smth_spike(iCell,:) = smooth(spike(iCell,:),winWidth); % divided by winWidth
end
spikeBase = cellfun(@(x) sum(double(baseLine(1)<x & x<baseLine(2)))/abs(diff(baseLine)),neuronList); % firing rate (spikes/msec)
for iBin = 1:nBin
%     m_neuralDist(iBin,1) = norm(smth_spike(:,iBin)-spikeBase); %Euclidean distance
    for iCell = 1:nCell
        neuralDist(iCell,iBin) = norm(smth_spike(iCell,iBin)-spikeBase(iCell));
    end
end

% since five bins were averaged, first two and last two bins should be excluded.
% m_neuralDist = m_neuralDist(3:end-2)/nCell;
% m_neuralDist = m_neuralDist(3:end-2);
neuralDist = neuralDist(:,3:end-2);
m_neuralDist = mean(neuralDist,1);
sem_neuralDist = std(neuralDist,0,1)/sqrt(nCell);

[coeffPCA, scorePCA, latentPCA] = pca(smth_spike');
tracePCA = spike'*coeffPCA;
latentPCA = latentPCA/(sum(latentPCA))*100;
end