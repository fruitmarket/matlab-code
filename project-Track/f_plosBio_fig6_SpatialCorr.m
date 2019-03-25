clearvars;
cd('E:\Dropbox\SNL\P2_Track');
load('E:\Dropbox\SNL\P2_Track\myParameters.mat');
formatOut = 'yymmdd';

markerS = 1.5;
dotS = 4;
colorGray = [100 100 100]./255;
colorLightGray = [240 240 240]./255;
colorDarkGray = [170 170 170]./255;

% load('neuronList_ori50hz_180517.mat'); % 50Hz
load('neuronList_ori_180517.mat'); % 8Hz

lightLoc_Run = [37:98];
lightLoc_RunCtrl = [1:36,99:124];
lightLoc_Rw = [63:124];
lightLoc_RwCtrl = [1:62];

cri_peakFR = 2;
%%
% TN: track neuron
tPC_DRun = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & cellfun(@(x) max(max(x)), T.pethconvSpatial)>cri_peakFR; % nanmean firing rate > 1hz
ntPC_DRun = sum(double(tPC_DRun));

% corr of total neurons
tPC_Run_PRE = cell2mat(T.rateMap1D_PRE(tPC_DRun));
tPC_Run_STM = cell2mat(T.rateMap1D_STM(tPC_DRun));
tPC_Run_POST = cell2mat(T.rateMap1D_POST(tPC_DRun));

nBin_50hz = size(tPC_Run_PRE,2);

%normalized
tPC_Run_PRE = tPC_Run_PRE./repmat(max(tPC_Run_PRE,[],2),1,nBin_50hz);
tPC_Run_STM = tPC_Run_STM./repmat(max(tPC_Run_STM,[],2),1,nBin_50hz);
tPC_Run_POST = tPC_Run_POST./repmat(max(tPC_Run_POST,[],2),1,nBin_50hz);

inlightZone_PRE_Run = tPC_Run_PRE(:,lightLoc_Run);
inlightZone_STM_Run = tPC_Run_STM(:,lightLoc_Run);
inlightZone_POST_Run = tPC_Run_POST(:,lightLoc_Run);

outlightZone_PRE_Run = tPC_Run_PRE(:,lightLoc_RunCtrl);
outlightZone_STM_Run = tPC_Run_STM(:,lightLoc_RunCtrl);
outlightZone_POST_Run = tPC_Run_POST(:,lightLoc_RunCtrl);

[rCorr_inRun_preXstm,rCorr_inRun_preXpost,rCorr_inRun_stmXpost] = deal([]);
[rCorr_outRun_preXstm,rCorr_outRun_preXpost,rCorr_outRun_stmXpost] = deal([]);

nBin_inlightRun = size(inlightZone_PRE_Run,2);
nBin_outlightRun = size(outlightZone_PRE_Run,2);

for iCell = 1:ntPC_DRun
    rCorr_inRun_preXstm(iCell,1) = corr(inlightZone_PRE_Run(iCell,:)',inlightZone_STM_Run(iCell,:)','rows','complete','type','Pearson');
    rCorr_inRun_preXpost(iCell,1) = corr(inlightZone_PRE_Run(iCell,:)',inlightZone_POST_Run(iCell,:)','rows','complete','type','Pearson');
    rCorr_inRun_stmXpost(iCell,1) = corr(inlightZone_STM_Run(iCell,:)',inlightZone_POST_Run(iCell,:)','rows','complete','type','Pearson');
end

for iCell = 1:ntPC_DRun
    rCorr_outRun_preXstm(iCell,1) = corr(outlightZone_PRE_Run(iCell,:)',outlightZone_STM_Run(iCell,:)','rows','complete','type','Pearson');
    rCorr_outRun_preXpost(iCell,1) = corr(outlightZone_PRE_Run(iCell,:)',outlightZone_POST_Run(iCell,:)','rows','complete','type','Pearson');
    rCorr_outRun_stmXpost(iCell,1) = corr(outlightZone_STM_Run(iCell,:)',outlightZone_POST_Run(iCell,:)','rows','complete','type','Pearson');
end

%%
tPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & cellfun(@(x) max(max(x)), T.pethconvSpatial)>cri_peakFR; % nanmean firing rate > 1hz
ntPC_DRw = sum(double(tPC_DRw));

% corr of total neurons
tPC_Rw_PRE = cell2mat(T.rateMap1D_PRE(tPC_DRw));
tPC_Rw_STM = cell2mat(T.rateMap1D_STM(tPC_DRw));
tPC_Rw_POST = cell2mat(T.rateMap1D_POST(tPC_DRw));

%normalized
tPC_Rw_PRE = tPC_Rw_PRE./repmat(max(tPC_Rw_PRE,[],2),1,nBin_50hz);
tPC_Rw_STM = tPC_Rw_STM./repmat(max(tPC_Rw_STM,[],2),1,nBin_50hz);
tPC_Rw_POST = tPC_Rw_POST./repmat(max(tPC_Rw_POST,[],2),1,nBin_50hz);

inlightZone_PRE_Rw = tPC_Rw_PRE(:,lightLoc_Rw);
inlightZone_STM_Rw = tPC_Rw_STM(:,lightLoc_Rw);
inlightZone_POST_Rw = tPC_Rw_POST(:,lightLoc_Rw);

outlightZone_PRE_Rw = tPC_Rw_PRE(:,lightLoc_RwCtrl);
outlightZone_STM_Rw = tPC_Rw_STM(:,lightLoc_RwCtrl);
outlightZone_POST_Rw = tPC_Rw_POST(:,lightLoc_RwCtrl);

[rCorr_inRw_preXstm,rCorr_inRw_preXpost,rCorr_inRw_stmXpost] = deal([]);
[rCorr_outRw_preXstm,rCorr_outRw_preXpost,rCorr_outRw_stmXpost] = deal([]);

nBin_inlightRw = size(inlightZone_PRE_Rw,2);
nBin_outlightRw = size(outlightZone_PRE_Rw,2);

for iCell = 1:ntPC_DRw
    rCorr_inRw_preXstm(iCell,1) = corr(inlightZone_PRE_Rw(iCell,:)',inlightZone_STM_Rw(iCell,:)','rows','complete','type','Pearson');
    rCorr_inRw_preXpost(iCell,1) = corr(inlightZone_PRE_Rw(iCell,:)',inlightZone_POST_Rw(iCell,:)','rows','complete','type','Pearson');
    rCorr_inRw_stmXpost(iCell,1) = corr(inlightZone_STM_Rw(iCell,:)',inlightZone_POST_Rw(iCell,:)','rows','complete','type','Pearson');
end

for iCell = 1:ntPC_DRw
    rCorr_outRw_preXstm(iCell,1) = corr(outlightZone_PRE_Rw(iCell,:)',outlightZone_STM_Rw(iCell,:)','rows','complete','type','Pearson');
    rCorr_outRw_preXpost(iCell,1) = corr(outlightZone_PRE_Rw(iCell,:)',outlightZone_POST_Rw(iCell,:)','rows','complete','type','Pearson');
    rCorr_outRw_stmXpost(iCell,1) = corr(outlightZone_STM_Rw(iCell,:)',outlightZone_POST_Rw(iCell,:)','rows','complete','type','Pearson');
end

%% noLight 
load('neuronList_ori_180511.mat');
Txls = readtable('neuronList_ori_180206.xlsx');
T.compIdxControl = categorical(Txls.compIdxControl);

%%%% noRun %%%%
tPC_ctrl = ((T.taskType == 'noRun' & isundefined(T.compIdxControl)) | (T.taskType == 'noRw' & isundefined(T.compIdxControl)) | (T.sessionOrder == '1' & ~isundefined(T.compIdxControl))) & T.idxNeurontype == 'PN' & cellfun(@(x) max(max(x)), T.pethconvSpatial)>cri_peakFR; % 1st session
ntPC_ctrl = sum(double(tPC_ctrl));

a = T.path(tPC_ctrl);
for iCell = 1:ntPC_ctrl
    [filePath{iCell,1},~,~] = fileparts(a{iCell});
end
nSessions = unique(filePath);

ctrl_PRE = cell2mat(T.rateMap1D_PRE(tPC_ctrl));
ctrl_STM = cell2mat(T.rateMap1D_STM(tPC_ctrl));
ctrl_POST = cell2mat(T.rateMap1D_POST(tPC_ctrl));
nBin_ctrl = size(ctrl_PRE,2);

%normalized
ctrl_PRE = ctrl_PRE./repmat(max(ctrl_PRE,[],2),1,nBin_ctrl);
ctrl_STM = ctrl_STM./repmat(max(ctrl_STM,[],2),1,nBin_ctrl);
ctrl_POST = ctrl_POST./repmat(max(ctrl_POST,[],2),1,nBin_ctrl);

ctrl_PRE = ctrl_PRE(:,lightLoc_Run);
ctrl_STM = ctrl_STM(:,lightLoc_Run);
ctrl_POST = ctrl_POST(:,lightLoc_Run);
nBin_ctrlrun = size(ctrl_PRE,2);

[rCorr_noRun_preXstm, rCorr_noRun_preXpost, rCorr_noRun_stmXpost] = deal([]);
for iCell = 1:ntPC_ctrl
    rCorr_noRun_preXstm(iCell,1) = corr(ctrl_PRE(iCell,:)',ctrl_STM(iCell,:)','rows','complete','type','Pearson');
    rCorr_noRun_preXpost(iCell,1) = corr(ctrl_PRE(iCell,:)',ctrl_POST(iCell,:)','rows','complete','type','Pearson');
    rCorr_noRun_stmXpost(iCell,1) = corr(ctrl_STM(iCell,:)',ctrl_POST(iCell,:)','rows','complete','type','Pearson');
end

%%%% Reward zone %%%%
noRw_PRE = cell2mat(T.rateMap1D_PRE(tPC_ctrl));
noRw_STM = cell2mat(T.rateMap1D_STM(tPC_ctrl));
noRw_POST = cell2mat(T.rateMap1D_POST(tPC_ctrl));

%normalized
noRw_PRE = noRw_PRE./repmat(max(noRw_PRE,[],2),1,nBin_ctrl);
noRw_STM = noRw_STM./repmat(max(noRw_STM,[],2),1,nBin_ctrl);
noRw_POST = noRw_POST./repmat(max(noRw_POST,[],2),1,nBin_ctrl);

noRw_PRE = noRw_PRE(:,lightLoc_Rw);
noRw_STM = noRw_STM(:,lightLoc_Rw);
noRw_POST = noRw_POST(:,lightLoc_Rw);
nBin_ctrlrw = size(noRw_PRE,2);

[rCorr_noRw_preXstm, rCorr_noRw_preXpost, rCorr_noRw_stmXpost] = deal([]);
for iCell = 1:ntPC_ctrl
    rCorr_noRw_preXstm(iCell,1) = corr(noRw_PRE(iCell,:)',noRw_STM(iCell,:)','rows','complete','type','Pearson');
    rCorr_noRw_preXpost(iCell,1) = corr(noRw_PRE(iCell,:)',noRw_POST(iCell,:)','rows','complete','type','Pearson');
    rCorr_noRw_stmXpost(iCell,1) = corr(noRw_STM(iCell,:)',noRw_POST(iCell,:)','rows','complete','type','Pearson');
end

% nanmean & sem
m_rCorr_inlight_Run = [nanmean(rCorr_inRun_preXstm), nanmean(rCorr_inRun_preXpost), nanmean(rCorr_inRun_stmXpost)];
sem_rCorr_inlight_Run = [nanstd(rCorr_inRun_preXstm,0,1)/sqrt(sum(double(~isnan(rCorr_inRun_preXstm)))), nanstd(rCorr_inRun_preXpost,0,1)/sqrt(sum(double(~isnan(rCorr_inRun_preXpost)))), nanstd(rCorr_inRun_stmXpost,0,1)/sqrt(sum(double(~isnan(rCorr_inRun_stmXpost))))];

m_rCorr_outlight_Run = [nanmean(rCorr_outRun_preXstm), nanmean(rCorr_outRun_preXpost), nanmean(rCorr_outRun_stmXpost)];
sem_rCorr_outlight_Run = [nanstd(rCorr_outRun_preXstm,0,1)/sqrt(sum(double(~isnan(rCorr_outRun_preXstm)))), nanstd(rCorr_outRun_preXpost,0,1)/sqrt(sum(double(~isnan(rCorr_outRun_preXpost)))), nanstd(rCorr_outRun_stmXpost,0,1)/sqrt(sum(double(~isnan(rCorr_outRun_stmXpost))))];

m_rCorr_inlight_Rw = [nanmean(rCorr_inRw_preXstm), nanmean(rCorr_inRw_preXpost), nanmean(rCorr_inRw_stmXpost)];
sem_rCorr_inlight_Rw = [nanstd(rCorr_inRw_preXstm,0,1)/sqrt(sum(double(~isnan(rCorr_inRw_preXstm)))), nanstd(rCorr_inRw_preXpost,0,1)/sqrt(sum(double(~isnan(rCorr_inRw_preXpost)))), nanstd(rCorr_inRw_stmXpost,0,1)/sqrt(sum(double(~isnan(rCorr_inRw_stmXpost))))];

m_rCorr_outlight_Rw = [nanmean(rCorr_outRw_preXstm), nanmean(rCorr_outRw_preXpost), nanmean(rCorr_outRw_stmXpost)];
sem_rCorr_outlight_Rw = [nanstd(rCorr_outRw_preXstm,0,1)/sqrt(sum(double(~isnan(rCorr_outRw_preXstm)))), nanstd(rCorr_outRw_preXpost,0,1)/sqrt(sum(double(~isnan(rCorr_outRw_preXpost)))), nanstd(rCorr_outRw_stmXpost,0,1)/sqrt(sum(double(~isnan(rCorr_outRw_stmXpost))))];

m_rCorr_noRun = [nanmean(rCorr_noRun_preXstm), nanmean(rCorr_noRun_preXpost), nanmean(rCorr_noRun_stmXpost)];
sem_rCorr_noRun = [nanstd(rCorr_noRun_preXstm,0,1)/sqrt(sum(double(~isnan(rCorr_noRun_preXstm)))), nanstd(rCorr_noRun_preXpost,0,1)/sqrt(sum(double(~isnan(rCorr_noRun_preXpost)))), nanstd(rCorr_noRun_stmXpost,0,1)/sqrt(sum(double(~isnan(rCorr_noRun_stmXpost))))];

m_rCorr_noRw = [nanmean(rCorr_noRw_preXstm), nanmean(rCorr_noRw_preXpost), nanmean(rCorr_noRw_stmXpost)];
sem_rCorr_noRw = [nanstd(rCorr_noRw_preXstm,0,1)/sqrt(sum(double(~isnan(rCorr_noRw_preXstm)))), nanstd(rCorr_noRw_preXpost,0,1)/sqrt(sum(double(~isnan(rCorr_noRw_preXpost)))), nanstd(rCorr_noRw_stmXpost,0,1)/sqrt(sum(double(~isnan(rCorr_noRw_stmXpost))))];

% Run session
[p_totalRun(1), table, stats] = kruskalwallis([rCorr_inRun_preXstm(~isnan(rCorr_inRun_preXstm)); rCorr_outRun_preXstm(~isnan(rCorr_outRun_preXstm)); rCorr_noRun_preXstm(~isnan(rCorr_noRun_preXstm))],[ones(sum(double(~isnan(rCorr_inRun_preXstm))),1); 2*ones(sum(double(~isnan(rCorr_outRun_preXstm))),1); 3*ones(sum(double(~isnan(rCorr_noRun_preXstm))),1)],'off');
result_Run = multcompare(stats,'ctype','lsd','Display','off');
p_Run(:,1) = result_Run(:,end);
chiSq_Run(1) = table{2,5};

[p_totalRun(2), table, stats] = kruskalwallis([rCorr_inRun_preXpost(~isnan(rCorr_inRun_preXpost)); rCorr_outRun_preXpost(~isnan(rCorr_outRun_preXpost)); rCorr_noRun_preXpost(~isnan(rCorr_noRun_preXpost))],[ones(sum(double(~isnan(rCorr_inRun_preXpost))),1); 2*ones(sum(double(~isnan(rCorr_outRun_preXpost))),1); 3*ones(sum(double(~isnan(rCorr_noRun_preXpost))),1)],'off');
result_Run = multcompare(stats,'ctype','lsd','Display','off');
p_Run(:,2) = result_Run(:,end);
chiSq_Run(2) = table{2,5};

[p_totalRun(3), table, stats] = kruskalwallis([rCorr_inRun_stmXpost(~isnan(rCorr_inRun_stmXpost)); rCorr_outRun_stmXpost(~isnan(rCorr_outRun_stmXpost)); rCorr_noRun_stmXpost(~isnan(rCorr_noRun_stmXpost))],[ones(sum(double(~isnan(rCorr_inRun_stmXpost))),1); 2*ones(sum(double(~isnan(rCorr_outRun_stmXpost))),1); 3*ones(sum(double(~isnan(rCorr_noRun_stmXpost))),1)],'off');
result_Run = multcompare(stats,'ctype','lsd','Display','off');
p_Run(:,3) = result_Run(:,end);
chiSq_Run(3) = table{2,5};

% Rw session
[p_totalRw(1), table, stats] = kruskalwallis([rCorr_inRw_preXstm(~isnan(rCorr_inRw_preXstm)); rCorr_outRw_preXstm(~isnan(rCorr_outRw_preXstm)); rCorr_noRw_preXstm(~isnan(rCorr_noRw_preXstm))],[ones(sum(double(~isnan(rCorr_inRw_preXstm))),1); 2*ones(sum(double(~isnan(rCorr_outRw_preXstm))),1); 3*ones(sum(double(~isnan(rCorr_noRw_preXstm))),1)],'off');
result_Rw = multcompare(stats,'ctype','lsd','Display','off');
p_Rw(:,1) = result_Rw(:,end);
chiSq_Rw(1) = table{2,5};

[p_totalRw(2), table, stats] = kruskalwallis([rCorr_inRw_preXpost(~isnan(rCorr_inRw_preXpost)); rCorr_outRw_preXpost(~isnan(rCorr_outRw_preXpost)); rCorr_noRw_preXpost(~isnan(rCorr_noRw_preXpost))],[ones(sum(double(~isnan(rCorr_inRw_preXpost))),1); 2*ones(sum(double(~isnan(rCorr_outRw_preXpost))),1); 3*ones(sum(double(~isnan(rCorr_noRw_preXpost))),1)],'off');
result_Rw = multcompare(stats,'ctype','lsd','Display','off');
p_Rw(:,2) = result_Rw(:,end);
chiSq_Rw(2) = table{2,5};

[p_totalRw(3), table, stats] = kruskalwallis([rCorr_inRw_stmXpost(~isnan(rCorr_inRw_stmXpost)); rCorr_outRw_stmXpost(~isnan(rCorr_outRw_stmXpost)); rCorr_noRw_stmXpost(~isnan(rCorr_noRw_stmXpost))],[ones(sum(double(~isnan(rCorr_inRw_stmXpost))),1); 2*ones(sum(double(~isnan(rCorr_outRw_stmXpost))),1); 3*ones(sum(double(~isnan(rCorr_noRw_stmXpost))),1)],'off');
result_Rw = multcompare(stats,'ctype','lsd','Display','off');
p_Rw(:,3) = result_Rw(:,end);
chiSq_Rw(3) = table{2,5};

%%
barWidth = 0.18;
eBarLength = 0.3;
eBarWidth = 0.8;
eBarColor = colorBlack;
nCol = 3;
nRow = 5;

xScatterRunIn = (rand(ntPC_DRun,1)-0.5)*barWidth*2.2;
xScatterRunOut = (rand(ntPC_DRun,1)-0.5)*barWidth*2.2;
xScatterRwIn = (rand(ntPC_DRw,1)-0.5)*barWidth*2.2;
xScatterRwOut = (rand(ntPC_DRw,1)-0.5)*barWidth*2.2;
xScatterNoRun = (rand(ntPC_ctrl,1)-0.5)*barWidth*2.2;
xScatterNoRw = (rand(ntPC_ctrl,1)-0.5)*barWidth*2.2;

fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});

hPVCorr(1) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
bar([1,5,9],m_rCorr_inlight_Run,barWidth,'faceColor',colorLLightBlue);
hold on;
errorbarJun([1,5,9],m_rCorr_inlight_Run,sem_rCorr_inlight_Run,0.3,1.0,colorBlack);
hold on;
bar([2,6,10],m_rCorr_outlight_Run,barWidth,'faceColor',colorLightGray)
hold on;
errorbarJun([2,6,10],m_rCorr_outlight_Run,sem_rCorr_outlight_Run,0.3,1.0,colorBlack);
hold on;
bar([3,7,11],m_rCorr_noRun,barWidth,'faceColor',colorDarkGray)
hold on;
errorbarJun([3,7,11],m_rCorr_noRun,sem_rCorr_noRun,0.3,1.0,colorBlack);
hold on;

plot(1+xScatterRunIn, rCorr_inRun_preXstm, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(2+xScatterRunOut, rCorr_outRun_preXstm, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(3+xScatterNoRun, rCorr_noRun_preXstm, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;

plot(5+xScatterRunIn, rCorr_inRun_preXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(6+xScatterRunOut, rCorr_outRun_preXpost,'.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(7+xScatterNoRun, rCorr_noRun_preXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;

plot(9+xScatterRunIn, rCorr_inRun_stmXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(10+xScatterRunOut, rCorr_outRun_stmXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(11+xScatterNoRun, rCorr_noRun_stmXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);

title('Run','fontSize',fontM);
ylabel('Spatial correlation (r)','fontSize',fontM);

text(0.5, -1.3,['p12 = ',num2str(p_Run(1,1),3)],'fontSize',fontM,'color',colorBlack);
text(0.5, -1.5,['p13 = ',num2str(p_Run(2,1),3)],'fontSize',fontM,'color',colorBlack);
text(0.5, -1.7,['p23 = ',num2str(p_Run(3,1),3)],'fontSize',fontM,'color',colorBlack);

text(5.5, -1.3,[num2str(p_Run(1,2),3)],'fontSize',fontM,'color',colorBlack);
text(5.5, -1.5,[num2str(p_Run(2,2),3)],'fontSize',fontM,'color',colorBlack);
text(5.5, -1.7,[num2str(p_Rw(3,2),3)],'fontSize',fontM,'color',colorBlack);

text(9.5, -1.3,[num2str(p_Run(1,3),3)],'fontSize',fontM,'color',colorBlack);
text(9.5, -1.5,[num2str(p_Run(2,3),3)],'fontSize',fontM,'color',colorBlack);
text(9.5, -1.7,[num2str(p_Run(3,3),3)],'fontSize',fontM,'color',colorBlack);

text(0.5, -2.3,['pAll = ',num2str(p_totalRun(1),3)],'fontSize',fontM,'color',colorBlack);
text(5.5, -2.3,[num2str(p_totalRun(2),3)],'fontSize',fontM,'color',colorBlack);
text(9.5, -2.3,[num2str(p_totalRun(3),3)],'fontSize',fontM,'color',colorBlack);

text(0.5, -2.5,['chi = ',num2str(chiSq_Run(1),3)],'fontSize',fontM,'color',colorBlack);
text(5.5, -2.5,[num2str(chiSq_Run(2),3)],'fontSize',fontM,'color',colorBlack);
text(9.5, -2.5,[num2str(chiSq_Run(3),3)],'fontSize',fontM,'color',colorBlack);

text(6, 1.30, ['Light sessions (n = ', num2str(ntPC_DRun), ')'],'fontSize',fontM);
text(6, 1.15, ['Control sessions (n = ', num2str(ntPC_ctrl), ')'],'fontSize',fontM);

hPVCorr(2) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,2,1,[0.15 0.1 0.85 0.85],midInterval),wideInterval));
bar([1,5,9],m_rCorr_inlight_Rw,barWidth,'faceColor',colorLLightBlue);
hold on;
errorbarJun([1,5,9],m_rCorr_inlight_Rw,sem_rCorr_inlight_Rw,0.3,1.0,colorBlack);
hold on;
bar([2,6,10],m_rCorr_outlight_Rw,barWidth,'faceColor',colorLightGray)
hold on;
errorbarJun([2,6,10],m_rCorr_outlight_Rw,sem_rCorr_outlight_Rw,0.3,1.0,colorBlack);
hold on;
bar([3,7,11],m_rCorr_noRw,barWidth,'faceColor',colorDarkGray)
hold on;
errorbarJun([3,7,11],m_rCorr_noRw,sem_rCorr_noRw,0.3,1.0,colorBlack);
hold on;

plot(1+xScatterRwIn, rCorr_inRw_preXstm, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(2+xScatterRwOut, rCorr_outRw_preXstm, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(3+xScatterNoRw, rCorr_noRw_preXstm, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;

plot(5+xScatterRwIn, rCorr_inRw_preXpost,'.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(6+xScatterRwOut, rCorr_outRw_preXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(7+xScatterNoRw, rCorr_noRw_preXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;

plot(9+xScatterRwIn, rCorr_inRw_stmXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(10+xScatterRwOut, rCorr_outRw_stmXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
hold on;
plot(11+xScatterNoRw, rCorr_noRw_stmXpost, '.','markerSize',dotS,'markerFaceColor',colorWhite,'markerEdgeColor',colorGray);
title('Rw','fontSize',fontM);
ylabel('Spatial correlation (r)','fontSize',fontM);

text(0.5, -1.3,['p12 = ',num2str(p_Rw(1,1),3)],'fontSize',fontM,'color',colorBlack);
text(0.5, -1.5,['p13 = ',num2str(p_Rw(2,1),3)],'fontSize',fontM,'color',colorBlack);
text(0.5, -1.7,['p23 = ',num2str(p_Rw(3,1),3)],'fontSize',fontM,'color',colorBlack);

text(5.5, -1.3,[num2str(p_Rw(1,2),3)],'fontSize',fontM,'color',colorBlack);
text(5.5, -1.5,[num2str(p_Rw(2,2),3)],'fontSize',fontM,'color',colorBlack);
text(5.5, -1.7,[num2str(p_Rw(3,2),3)],'fontSize',fontM,'color',colorBlack);

text(9.5, -1.3,[num2str(p_Rw(1,3),3)],'fontSize',fontM,'color',colorBlack);
text(9.5, -1.5,[num2str(p_Rw(2,3),3)],'fontSize',fontM,'color',colorBlack);
text(9.5, -1.7,[num2str(p_Rw(3,3),3)],'fontSize',fontM,'color',colorBlack);

text(0.5, -2.3,['pAll = ',num2str(p_totalRw(1),3)],'fontSize',fontM,'color',colorBlack);
text(5.5, -2.3,[num2str(p_totalRw(2),3)],'fontSize',fontM,'color',colorBlack);
text(9.5, -2.3,[num2str(p_totalRw(3),3)],'fontSize',fontM,'color',colorBlack);

text(0.5, -2.5,['chi = ',num2str(chiSq_Rw(1),3)],'fontSize',fontM,'color',colorBlack);
text(5.5, -2.5,[num2str(chiSq_Rw(2),3)],'fontSize',fontM,'color',colorBlack);
text(9.5, -2.5,[num2str(chiSq_Rw(3),3)],'fontSize',fontM,'color',colorBlack);

text(6, 1.30, ['Light sessions (n = ', num2str(ntPC_DRw), ')'],'fontSize',fontM);
text(6, 1.15, ['Control sessions (n = ', num2str(ntPC_ctrl), ')'],'fontSize',fontM);

set(hPVCorr(1),'TickDir','out','Box','off','XLim',[0,12],'YLim',[-0.5 1.4],'XTick',[2, 6, 10],'XTickLabel',[{'PRExSTIM','PRExPOST','STIMxPOST'}],'fontSize',fontM);
set(hPVCorr(2),'TickDir','out','Box','off','XLim',[0,12],'YLim',[-0.5 1.4],'XTick',[2, 6, 10],'XTickLabel',[{'PRExSTIM','PRExPOST','STIMxPOST'}],'fontSize',fontM);
set(hPVCorr,'TickLength',[0.03, 0.03]);

% print('-painters','-r300','-dtiff',['f_plosBio_fig6_SpatialCorr_',datestr(now,formatOut),'_',num2str(freq),'.tif']);
% print('-painters','-r300','-depsc',['f_plosBio_fig6_SpatialCorr_',datestr(now,formatOut),'_',num2str(freq),'.ai']);
% close;