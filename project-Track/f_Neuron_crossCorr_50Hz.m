clearvars;
cd('D:\Dropbox\SNL\P2_Track');

load('D:\Dropbox\SNL\P2_Track\myParameters.mat');
formatOut = 'yymmdd';

markerS = 1.5;
dotS = 4;
colorGray = [100 100 100]./255;
colorLightGray = [240 240 240]./255;
colorDarkGray = [170 170 170]./255;

% 1cm win
load('neuronList_ori50hz_180117.mat');
lightLoc_Run = [floor(20*pi*5/6) ceil(20*pi*8/6)];
lightLoc_Rw = [floor(20*pi*9/6) ceil(20*pi*10/6)];

% 2cm win
% load('neuronList_ori50hz_171219_2cm.mat');
% lightLoc_Run = [27 42];
% lightLoc_Rw = [48 53];

% 4cm win
% load('neuronList_ori50hz_171219_4cm.mat');
% lightLoc_Run = [14 21];
% lightLoc_Rw = [24 26];

cri_nanmeanFR = 1;

%%
% TN: track neuron
% tPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN';
% tPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
tPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & cellfun(@(x) max(max(x)), T.pethconvSpatial)>cri_nanmeanFR; % nanmean firing rate > 1hz
% tPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR;

ntPC_DRun = sum(double(tPC_DRun));

r2_PRExPRE_Run = T.rCorr1D_preXpre(tPC_DRun);
r2_PRExSTIM_Run = T.rCorr1D_preXstm(tPC_DRun);
r2_PRExPOST_Run = T.rCorr1D_preXpost(tPC_DRun);
r2_STIMxPOST_Run = T.rCorr1D_stmXpost(tPC_DRun);

% r2_PRExPRE_Run = T.rCorr1D_preXpre(tPC_DRun).^2;
% r2_PRExSTIM_Run = T.rCorr1D_preXstm(tPC_DRun).^2;
% r2_PRExPOST_Run = T.rCorr1D_preXpost(tPC_DRun).^2;
% r2_STIMxPOST_Run = T.rCorr1D_stmXpost(tPC_DRun).^2;

% corr of total neurons
tPC_Run_PRE = cell2mat(T.rateMap1D_PRE(tPC_DRun));
tPC_Run_STM = cell2mat(T.rateMap1D_STM(tPC_DRun));
tPC_Run_POST = cell2mat(T.rateMap1D_POST(tPC_DRun));

nBin_50hz = size(tPC_Run_PRE,2);

%normalized
tPC_Run_PRE = tPC_Run_PRE./repmat(max(tPC_Run_PRE,[],2),1,nBin_50hz);
tPC_Run_STM = tPC_Run_STM./repmat(max(tPC_Run_STM,[],2),1,nBin_50hz);
tPC_Run_POST = tPC_Run_POST./repmat(max(tPC_Run_POST,[],2),1,nBin_50hz);


%%
% tPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN';
% tPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
tPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & cellfun(@(x) max(max(x)), T.pethconvSpatial)>cri_nanmeanFR; % nanmean firing rate > 1hz
% tPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR;

ntPC_DRw = sum(double(tPC_DRw));

r2_PRExPRE_Rw = T.rCorr1D_preXpre(tPC_DRw);
r2_PRExSTIM_Rw = T.rCorr1D_preXstm(tPC_DRw);
r2_PRExPOST_Rw = T.rCorr1D_preXpost(tPC_DRw);
r2_STIMxPOST_Rw = T.rCorr1D_stmXpost(tPC_DRw);

% r2_PRExPRE_Rw = T.rCorr1D_preXpre(tPC_DRw).^2;
% r2_PRExSTIM_Rw = T.rCorr1D_preXstm(tPC_DRw).^2;
% r2_PRExPOST_Rw = T.rCorr1D_preXpost(tPC_DRw).^2;
% r2_STIMxPOST_Rw = T.rCorr1D_stmXpost(tPC_DRw).^2;

% corr of total neurons
tPC_Rw_PRE = cell2mat(T.rateMap1D_PRE(tPC_DRw));
tPC_Rw_STM = cell2mat(T.rateMap1D_STM(tPC_DRw));
tPC_Rw_POST = cell2mat(T.rateMap1D_POST(tPC_DRw));

%normalized
tPC_Rw_PRE = tPC_Rw_PRE./repmat(max(tPC_Rw_PRE,[],2),1,nBin_50hz);
tPC_Rw_STM = tPC_Rw_STM./repmat(max(tPC_Rw_STM,[],2),1,nBin_50hz);
tPC_Rw_POST = tPC_Rw_POST./repmat(max(tPC_Rw_POST,[],2),1,nBin_50hz);


%% noLight 
% load('neuronList_ori_171205.mat');
load('neuronList_ori_171229.mat');
% load('neuronList_ori_171219_2cm.mat');
% load('neuronList_ori_171219_4cm.mat');

%%%% noRun %%%%
% tPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN';
% tPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
tPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & cellfun(@(x) max(max(x)), T.pethconvSpatial)>cri_nanmeanFR; % nanmean firing rate > 1hz
% tPC_noRun = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR;

ntPC_noRun = sum(double(tPC_noRun));

r2_PRExPRE_noRun = T.rCorr1D_preXpre(tPC_noRun);
r2_PRExSTIM_noRun = T.rCorr1D_preXstm(tPC_noRun);
r2_PRExPOST_noRun = T.rCorr1D_preXpost(tPC_noRun);
r2_STIMxPOST_noRun = T.rCorr1D_stmXpost(tPC_noRun);

% r2_PRExPRE_noRun = T.rCorr1D_preXpre(tPC_noRun).^2;
% r2_PRExSTIM_noRun = T.rCorr1D_preXstm(tPC_noRun).^2;
% r2_PRExPOST_noRun = T.rCorr1D_preXpost(tPC_noRun).^2;
% r2_STIMxPOST_noRun = T.rCorr1D_stmXpost(tPC_noRun).^2;

noRun_PRE = cell2mat(T.rateMap1D_PRE(tPC_noRun));
noRun_STM = cell2mat(T.rateMap1D_STM(tPC_noRun));
noRun_POST = cell2mat(T.rateMap1D_POST(tPC_noRun));
nBin_ctrl = size(noRun_PRE,2);

%normalized
noRun_PRE = noRun_PRE./repmat(max(noRun_PRE,[],2),1,nBin_ctrl);
noRun_STM = noRun_STM./repmat(max(noRun_STM,[],2),1,nBin_ctrl);
noRun_POST = noRun_POST./repmat(max(noRun_POST,[],2),1,nBin_ctrl);

%%%% noRw %%%%
% tPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN';
% tPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
tPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & cellfun(@(x) max(max(x)), T.pethconvSpatial)>cri_nanmeanFR; % nanmean firing rate > 1hz
% tPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR;
ntPC_noRw = sum(double(tPC_noRw));

r2_PRExPRE_noRw = T.rCorr1D_preXpre(tPC_noRw);
r2_PRExSTIM_noRw = T.rCorr1D_preXstm(tPC_noRw);
r2_PRExPOST_noRw = T.rCorr1D_preXpost(tPC_noRw);
r2_STIMxPOST_noRw = T.rCorr1D_stmXpost(tPC_noRw);

% r2_PRExPRE_noRw = T.rCorr1D_preXpre(tPC_noRw).^2;
% r2_PRExSTIM_noRw = T.rCorr1D_preXstm(tPC_noRw).^2;
% r2_PRExPOST_noRw = T.rCorr1D_preXpost(tPC_noRw).^2;
% r2_STIMxPOST_noRw = T.rCorr1D_stmXpost(tPC_noRw).^2;

noRw_PRE = cell2mat(T.rateMap1D_PRE(tPC_noRw));
noRw_STM = cell2mat(T.rateMap1D_STM(tPC_noRw));
noRw_POST = cell2mat(T.rateMap1D_POST(tPC_noRw));

%normalized
noRw_PRE = noRw_PRE./repmat(max(noRw_PRE,[],2),1,nBin_ctrl);
noRw_STM = noRw_STM./repmat(max(noRw_STM,[],2),1,nBin_ctrl);
noRw_POST = noRw_POST./repmat(max(noRw_POST,[],2),1,nBin_ctrl);

%% DY Lee
% save('rawData.mat','inlightZone_PRE_Run','inlightZone_STM_Run','inlightZone_POST_Run','outlightZone_PRE_Run','outlightZone_STM_Run','outlightZone_POST_Run','noRun_PRE','noRun_STM','noRun_POST',...
%     'inlightZone_PRE_Rw','inlightZone_STM_Rw','inlightZone_POST_Rw','outlightZone_PRE_Rw','outlightZone_STM_Rw','outlightZone_POST_Rw','noRw_PRE','noRw_STM','noRw_POST');
%% statistic

% nanmean & sem
m_Corr_Run = [nanmean(r2_PRExPRE_Run), nanmean(r2_PRExSTIM_Run), nanmean(r2_PRExPOST_Run), nanmean(r2_STIMxPOST_Run)];
sem_Corr_Run = [nanstd(r2_PRExPRE_Run)/sqrt(sum(double(~isnan(r2_PRExPRE_Run)))), nanstd(r2_PRExSTIM_Run)/sqrt(sum(double(~isnan(r2_PRExSTIM_Run)))), nanstd(r2_PRExPOST_Run)/sqrt(sum(double(~isnan(r2_PRExPOST_Run)))), nanstd(r2_STIMxPOST_Run)/sqrt(sum(double(~isnan(r2_STIMxPOST_Run))))];

m_Corr_Rw = [nanmean(r2_PRExPRE_Rw), nanmean(r2_PRExSTIM_Rw), nanmean(r2_PRExPOST_Rw), nanmean(r2_STIMxPOST_Rw)];
sem_Corr_Rw = [nanstd(r2_PRExPRE_Rw)/sqrt(sum(double(~isnan(r2_PRExPRE_Rw)))), nanstd(r2_PRExSTIM_Rw)/sqrt(sum(double(~isnan(r2_PRExSTIM_Rw)))), nanstd(r2_PRExPOST_Rw)/sqrt(sum(double(~isnan(r2_PRExPOST_Rw)))), nanstd(r2_STIMxPOST_Rw)/sqrt(sum(double(~isnan(r2_STIMxPOST_Rw))))];

m_Corr_noRun = [nanmean(r2_PRExPRE_noRun), nanmean(r2_PRExSTIM_noRun), nanmean(r2_PRExPOST_noRun), nanmean(r2_STIMxPOST_noRun)];
sem_Corr_noRun = [nanstd(r2_PRExPRE_noRun)/sqrt(sum(double(~isnan(r2_PRExPRE_noRun)))), nanstd(r2_PRExSTIM_noRun)/sqrt(sum(double(~isnan(r2_PRExSTIM_noRun)))), nanstd(r2_PRExPOST_noRun)/sqrt(sum(double(~isnan(r2_PRExPOST_noRun)))), nanstd(r2_STIMxPOST_noRun)/sqrt(sum(double(~isnan(r2_STIMxPOST_noRun))))];

m_Corr_noRw = [nanmean(r2_PRExPRE_noRw), nanmean(r2_PRExSTIM_noRw), nanmean(r2_PRExPOST_noRw), nanmean(r2_STIMxPOST_noRw)];
sem_Corr_noRw = [nanstd(r2_PRExPRE_noRw)/sqrt(sum(double(~isnan(r2_PRExPRE_noRw)))), nanstd(r2_PRExSTIM_noRw)/sqrt(sum(double(~isnan(r2_PRExSTIM_noRw)))), nanstd(r2_PRExPOST_noRw)/sqrt(sum(double(~isnan(r2_PRExPOST_noRw)))), nanstd(r2_STIMxPOST_noRw)/sqrt(sum(double(~isnan(r2_STIMxPOST_noRw))))];

% Run session
[~, p_Run(1)] = ttest2(r2_PRExPRE_Run(~isnan(r2_PRExPRE_Run)), r2_PRExPRE_noRun(~isnan(r2_PRExPRE_noRun)));
[~, p_Run(2)] = ttest2(r2_PRExSTIM_Run(~isnan(r2_PRExSTIM_Run)), r2_PRExSTIM_noRun(~isnan(r2_PRExSTIM_noRun)));
[~, p_Run(3)] = ttest2(r2_PRExPOST_Run(~isnan(r2_PRExPOST_Run)), r2_PRExPOST_noRun(~isnan(r2_PRExPOST_noRun)));
[~, p_Run(4)] = ttest2(r2_STIMxPOST_Run(~isnan(r2_STIMxPOST_Run)), r2_STIMxPOST_noRun(~isnan(r2_STIMxPOST_noRun)));

% Rw session
[~, p_Rw(1)] = ttest2(r2_PRExPRE_Rw(~isnan(r2_PRExPRE_Rw)), r2_PRExPRE_noRw(~isnan(r2_PRExPRE_noRw)));
[~, p_Rw(2)] = ttest2(r2_PRExSTIM_Rw(~isnan(r2_PRExSTIM_Rw)), r2_PRExSTIM_noRw(~isnan(r2_PRExSTIM_noRw)));
[~, p_Rw(3)] = ttest2(r2_PRExPOST_Rw(~isnan(r2_PRExPOST_Rw)), r2_PRExPOST_noRw(~isnan(r2_PRExPOST_noRw)));
[~, p_Rw(4)] = ttest2(r2_STIMxPOST_Rw(~isnan(r2_STIMxPOST_Rw)), r2_STIMxPOST_noRw(~isnan(r2_STIMxPOST_noRw)));

%%
barWidth = 0.18;
% barWidth = 0.8;
eBarLength = 0.3;
eBarWidth = 0.8;
eBarColor = colorBlack;
nCol = 2;
nRow = 5;

xScatterRun = (rand(ntPC_DRun,1)-0.5)*barWidth*2.2;
xScatterRw = (rand(ntPC_DRw,1)-0.5)*barWidth*2.2;
xScatterNoRun = (rand(ntPC_noRun,1)-0.5)*barWidth*2.2;
xScatterNoRw = (rand(ntPC_noRw,1)-0.5)*barWidth*2.2;


fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});

hPVCorr(1) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1,1,[0.1 0.1 0.80 0.85],midInterval),wideInterval));
bar([1,4,7,10],m_Corr_Run,barWidth,'faceColor',colorLLightBlue);
hold on;
errorbarJun([1,4,7,10],m_Corr_Run,sem_Corr_Run,0.3,1.0,colorBlack);
hold on;
bar([2,5,8,11],m_Corr_noRun,barWidth,'faceColor',colorLightGray)
hold on;
errorbarJun([2,5,8,11],m_Corr_noRun,sem_Corr_Run,0.3,1.0,colorBlack);

plot(1+xScatterRun, r2_PRExPRE_Run, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(2+xScatterNoRun, r2_PRExPRE_noRun, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;

plot(4+xScatterRun, r2_PRExSTIM_Run, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(5+xScatterNoRun, r2_PRExSTIM_noRun,'.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;

plot(7+xScatterRun, r2_PRExPOST_Run, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(8+xScatterNoRun, r2_PRExPOST_noRun, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;

plot(10+xScatterRun, r2_STIMxPOST_Run, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(11+xScatterNoRun, r2_STIMxPOST_noRun, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;

title('Run','fontSize',fontM);
ylabel('Spatial correlation (mean r ^2)','fontSize',fontM);

text(9,1.2,['Run: n=', num2str(ntPC_DRun)],'fontSize',fontM,'color',colorBlack);
text(9,1.1,['noRun: n=', num2str(ntPC_noRun)],'fontSize',fontM,'color',colorBlack);
text(0, -0.7,['p = ',num2str(p_Run(1,1))],'fontSize',fontM,'color',colorBlack);
text(4, -0.7,[num2str(p_Run(1,2))],'fontSize',fontM,'color',colorBlack);
text(7, -0.7,[num2str(p_Run(1,3))],'fontSize',fontM,'color',colorBlack);
text(10, -0.7,[num2str(p_Run(1,4))],'fontSize',fontM,'color',colorBlack);

%%
hPVCorr(2) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,2,1,[0.15 0.1 0.80 0.85],midInterval),wideInterval));
bar([1,4,7,10],m_Corr_Rw,barWidth,'faceColor',colorLLightBlue);
hold on;
errorbarJun([1,4,7,10],m_Corr_Rw,sem_Corr_Rw,0.3,1.0,colorBlack);
hold on;
bar([2,5,8,11],m_Corr_noRw,barWidth,'faceColor',colorLightGray)
hold on;
errorbarJun([2,5,8,11],m_Corr_noRw,sem_Corr_Rw,0.3,1.0,colorBlack);

plot(1+xScatterRw, r2_PRExPRE_Rw, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(2+xScatterNoRw, r2_PRExPRE_noRw, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;

plot(4+xScatterRw, r2_PRExSTIM_Rw, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(5+xScatterNoRw, r2_PRExSTIM_noRw,'.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;

plot(7+xScatterRw, r2_PRExPOST_Rw, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(8+xScatterNoRw, r2_PRExPOST_noRw, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;

plot(10+xScatterRw, r2_STIMxPOST_Rw, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(11+xScatterNoRw, r2_STIMxPOST_noRw, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;

title('Rw','fontSize',fontM);
ylabel('Spatial correlation (mean r ^2)','fontSize',fontM);

text(9,1.2,['Rw: n=', num2str(ntPC_DRw)],'fontSize',fontM,'color',colorBlack);
text(9,1.1,['noRw: n=', num2str(ntPC_noRw)],'fontSize',fontM,'color',colorBlack);
text(0, -0.7,['p = ',num2str(p_Rw(1,1))],'fontSize',fontM,'color',colorBlack);
text(4, -0.7,[num2str(p_Rw(1,2))],'fontSize',fontM,'color',colorBlack);
text(7, -0.7,[num2str(p_Rw(1,3))],'fontSize',fontM,'color',colorBlack);
text(10, -0.7,[num2str(p_Rw(1,4))],'fontSize',fontM,'color',colorBlack);

set(hPVCorr(1),'TickDir','out','Box','off','XLim',[0,12],'YLim',[-0.2 1.15],'XTick',[1.5, 4.5, 7.5, 10.5],'XTickLabel',[{'PRExPRE','PRExSTIM','PRExPOST','STIMxPOST'}],'fontSize',fontM);
set(hPVCorr(2),'TickDir','out','Box','off','XLim',[0,12],'YLim',[-0.2 1.15],'XTick',[1.5, 4.5, 7.5, 10.5],'XTickLabel',[{'PRExPRE','PRExSTIM','PRExPOST','STIMxPOST'}],'fontSize',fontM);
set(hPVCorr,'TickLength',[0.03, 0.03]);

% print('-painters','-r300','-dtiff',['f_CellReports_SpatialCorr_50Hz_',datestr(now,formatOut),'.tif']);
% print('-painters','-r300','-depsc',['f_cellreports_SpatialCorr_',datestr(now,formatOut),'.ai']);
% close;