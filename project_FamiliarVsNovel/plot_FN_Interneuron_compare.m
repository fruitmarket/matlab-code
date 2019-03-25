clearvars; close all;

rtDir = 'E:\Dropbox\Lab_mwjung\P4_FamiliarNovel';
load('E:\Dropbox\Lab_mwjung\P2_Track\myParameters.mat');
formatOut = 'yymmdd';

load('E:\Dropbox\Lab_mwjung\P4_FamiliarNovel\neuronList_familiar_190301.mat');
T_fam = T;

load('E:\Dropbox\Lab_mwjung\P4_FamiliarNovel\neuronList_novel_190301.mat');
T_nov = T;

IN_nov = T_nov.neuronType == 'IN';
IN_fam = T_fam.neuronType == 'IN';

cellID_nov = [88, 90, 91];
cellID_fam = [118, 121, 120];

mFR_nov_inz = cell2mat(cellfun(@(x) x(2:4), T_nov.m_lapFrInzone,'UniformOutput',0));
mFR_fam_inz = cell2mat(cellfun(@(x) x(1:3), T_fam.m_lapFrInzone,'UniformOutput',0));
mFR_nov_outz = cell2mat(cellfun(@(x) x(2:4), T_nov.m_lapFrOutzone,'UniformOutput',0));
mFR_fam_outz = cell2mat(cellfun(@(x) x(1:3), T_fam.m_lapFrOutzone,'UniformOutput',0));
mFR_nov_totz = cell2mat(cellfun(@(x) x(2:4), T_nov.m_lapFrTotalzone,'UniformOutput',0));
mFR_fam_totz = cell2mat(cellfun(@(x) x(1:3), T_fam.m_lapFrTotalzone,'UniformOutput',0));
%% common neuron comparison
com_mFR_nov_inz = mFR_nov_inz(cellID_nov,:);
mean_mFR_nov_inz = mean(com_mFR_nov_inz);
sem_mFR_nov_inz = std(com_mFR_nov_inz)/sqrt(length(cellID_nov));

com_mFR_fam_inz = mFR_fam_inz(cellID_fam,:);
mean_mFR_fam_inz = mean(com_mFR_fam_inz);
sem_mFR_fam_inz = std(com_mFR_fam_inz)/sqrt(length(cellID_fam));

com_mFR_nov_outz = mFR_nov_outz(cellID_nov,:);
mean_mFR_nov_outz = mean(com_mFR_nov_outz);
sem_mFR_nov_outz = std(com_mFR_nov_outz)/sqrt(length(cellID_nov));

com_mFR_fam_outz = mFR_fam_outz(cellID_fam,:);
mean_mFR_fam_outz = mean(com_mFR_fam_outz);
sem_mFR_fam_outz = std(com_mFR_fam_outz)/sqrt(length(cellID_fam));

com_mFR_nov_totz = mFR_nov_totz(cellID_nov,:);
mean_mFR_nov_totz = mean(com_mFR_nov_totz);
sem_mFR_nov_totz = std(com_mFR_nov_totz)/sqrt(length(cellID_nov));

com_mFR_fam_totz = mFR_fam_totz(cellID_fam,:);
mean_mFR_fam_totz = mean(com_mFR_fam_totz);
sem_mFR_fam_totz = std(com_mFR_fam_totz)/sqrt(length(cellID_fam));

%% stat
[~, p_test(1,1)] = ttest(com_mFR_nov_inz(:,1),com_mFR_fam_inz(:,1));
[~, p_test(2,1)] = ttest(com_mFR_nov_inz(:,2),com_mFR_fam_inz(:,2));
[~, p_test(3,1)] = ttest(com_mFR_nov_inz(:,3),com_mFR_fam_inz(:,3));
[~, p_test(1,2)] = ttest(com_mFR_nov_outz(:,1),com_mFR_fam_outz(:,1));
[~, p_test(2,2)] = ttest(com_mFR_nov_outz(:,2),com_mFR_fam_outz(:,2));
[~, p_test(3,2)] = ttest(com_mFR_nov_outz(:,3),com_mFR_fam_outz(:,3));
[~, p_test(1,3)] = ttest(com_mFR_nov_totz(:,1),com_mFR_fam_totz(:,1));
[~, p_test(2,3)] = ttest(com_mFR_nov_totz(:,2),com_mFR_fam_totz(:,2));
[~, p_test(3,3)] = ttest(com_mFR_nov_totz(:,3),com_mFR_fam_totz(:,3));

%% plot
nCol = 3;
nRow = 6;

lineWidth = 1.2;
barWidth = 0.25;
eBarWidth = 1;
eBarLength = 0.3;
xptBar_nov = [1,4,7];
xptBar_fam = [2,5,8];
xptScatter = (rand(3,1)-0.5)*0.85*barWidth;
wideInterval = [0.11 0.8];

fHandle = figure('PaperUnits','centimeters','PaperPosition',[0 0 15 5]);

hBar(1) = axes('Position',axpt(nCol,nRow,1,2:6,[],wideInterval));
bar(xptBar_nov,mean_mFR_nov_inz,'barWidth',barWidth,'lineStyle','-','edgeColor',colorBlack,'faceColor',colorDarkGray,'lineWidth',lineWidth);
hold on;
errorbarJun(xptBar_nov,mean_mFR_nov_inz,sem_mFR_nov_inz,eBarLength,eBarWidth,colorBlack);
hold on;
bar(xptBar_fam,mean_mFR_fam_inz,'barWidth',barWidth,'lineStyle','-','edgeColor',colorBlack,'faceColor',colorLightGray,'lineWidth',lineWidth);
hold on;
errorbarJun(xptBar_fam,mean_mFR_fam_inz,sem_mFR_fam_inz,eBarLength,eBarWidth,colorBlack);
hold on;
for iBlock = 1:3
    plot(xptBar_nov(iBlock)+xptScatter,com_mFR_nov_inz(:,iBlock),'lineStyle','none','marker','o','markerSize',markerS,'markerFaceColor',colorLightGray,'markerEdgeColor',colorBlack);
    hold on;
    plot(xptBar_fam(iBlock)+xptScatter,com_mFR_fam_inz(:,iBlock),'lineStyle','none','marker','o','markerSize',markerS,'markerFaceColor',colorLightGray,'markerEdgeColor',colorBlack);
    hold on;
end
ylabel('Firing rate (Hz)','fontSize',fontM);
title('In-zone','fontSize',fontM);

hBar(2) = axes('Position',axpt(nCol,nRow,2,2:6,[],wideInterval));
bar(xptBar_nov,mean_mFR_nov_outz,'barWidth',barWidth,'lineStyle','-','edgeColor',colorBlack,'faceColor',colorDarkGray,'lineWidth',lineWidth);
hold on;
errorbarJun(xptBar_nov,mean_mFR_nov_outz,sem_mFR_nov_outz,eBarLength,eBarWidth,colorBlack);
hold on;
bar(xptBar_fam,mean_mFR_fam_outz,'barWidth',barWidth,'lineStyle','-','edgeColor',colorBlack,'faceColor',colorLightGray,'lineWidth',lineWidth);
hold on;
errorbarJun(xptBar_fam,mean_mFR_fam_outz,sem_mFR_fam_outz,eBarLength,eBarWidth,colorBlack);
hold on;
for iBlock = 1:3
    plot(xptBar_nov(iBlock)+xptScatter,com_mFR_nov_outz(:,iBlock),'lineStyle','none','marker','o','markerSize',markerS,'markerFaceColor',colorLightGray,'markerEdgeColor',colorBlack);
    hold on;
    plot(xptBar_fam(iBlock)+xptScatter,com_mFR_fam_outz(:,iBlock),'lineStyle','none','marker','o','markerSize',markerS,'markerFaceColor',colorLightGray,'markerEdgeColor',colorBlack);
    hold on;
end
ylabel('Firing rate (Hz)','fontSize',fontM);
title('Out-zone','fontSize',fontM);

hBar(3) = axes('Position',axpt(nCol,nRow,3,2:6,[],wideInterval));
bar(xptBar_nov,mean_mFR_nov_totz,'barWidth',barWidth,'lineStyle','-','edgeColor',colorBlack,'faceColor',colorDarkGray,'lineWidth',lineWidth);
hold on;
errorbarJun(xptBar_nov,mean_mFR_nov_totz,sem_mFR_nov_totz,eBarLength,eBarWidth,colorBlack);
hold on;
bar(xptBar_fam,mean_mFR_fam_totz,'barWidth',barWidth,'lineStyle','-','edgeColor',colorBlack,'faceColor',colorLightGray,'lineWidth',lineWidth);
hold on;
errorbarJun(xptBar_fam,mean_mFR_fam_totz,sem_mFR_fam_totz,eBarLength,eBarWidth,colorBlack);
hold on;
for iBlock = 1:3
    plot(xptBar_nov(iBlock)+xptScatter,com_mFR_nov_totz(:,iBlock),'lineStyle','none','marker','o','markerSize',markerS,'markerFaceColor',colorLightGray,'markerEdgeColor',colorBlack);
    hold on;
    plot(xptBar_fam(iBlock)+xptScatter,com_mFR_fam_totz(:,iBlock),'lineStyle','none','marker','o','markerSize',markerS,'markerFaceColor',colorLightGray,'markerEdgeColor',colorBlack);
    hold on;
end
ylabel('Firing rate (Hz)','fontSize',fontM);
title('Entire zone','fontSize',fontM);
set(hBar,'Box','off','TickDir','out','XLim',[0 9],'XTick',[1.5 4.5 7.5],'XTickLabel',{'PRE','STIM','POST'},'YLim',[0 50],'YTick',[0:10:50],'fontSize',fontM);

print('-painters','-r300','-dtiff',['plot_FN_interneuron_',datestr(now,formatOut),'.tif']);