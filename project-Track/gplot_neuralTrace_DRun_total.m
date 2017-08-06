% Latency of neurons which are activated on the platform. (Blue)
% Among neurons which are activated on the platform, latency of neurons
% which are also activated on the platform

% common part
clearvars;
rtDir = 'D:\Dropbox\SNL\P2_Track';
cd(rtDir);

load myParameters.mat;
load('neuronList_ori_170701.mat');
Txls = readtable('neuronList_ori_170701.xlsx');
Txls.taskType = categorical(Txls.taskType);
formatOut = 'yymmdd';

% total population (DRunPN / DRunIN / DRwPN / DRwIN) with light responsiveness (light activated)
DRun_PN = T.taskType == 'DRun' & T.idxNeurontype == 'PN';
DRun_IN = T.taskType == 'DRun' & T.idxNeurontype == 'IN';
DRun_UNC = T.taskType == 'DRun' & T.idxNeurontype == 'UNC';

DRun_PN_light = DRun_PN & T.pLR_Track<alpha;
DRun_PN_act = DRun_PN & T.pLR_Track<alpha & T.statDir_Track == 1;
DRun_PN_ina = DRun_PN & T.pLR_Track<alpha & T.statDir_Track == -1;
DRun_PN_no = DRun_PN & T.pLR_Track>=alpha;

winSize = [ones(1,4)*5, ones(1,9)*10, ones(1,14)*15];
mvWinSize = [1:4,1:9,1:14];
nCycle = length(winSize);
baseLine = [-22, -3]; %% first 2ms and last 2ms are dropped becaused of smoothing

% [m_neuDist_DRunPN_total_PRE, ~, ~, ~, ~, ~] = analysis_neuralTrace(T.xptPsdPreD(DRun_PN),5,1,baseLine);    
% [m_neuDist_DRunPN_light_PRE, ~, ~, ~, ~, ~] = analysis_neuralTrace(T.xptPsdPreD(DRun_PN_light),5,1,baseLine);    
% [m_neuDist_DRunPN_act_PRE, ~, ~, ~, ~, ~] = analysis_neuralTrace(T.xptPsdPreD(DRun_PN_act),5,1,baseLine);
% [m_neuDist_DRunPN_ina_PRE, ~, ~, ~, ~, ~] = analysis_neuralTrace(T.xptPsdPreD(DRun_PN_ina),5,1,baseLine);
% [m_neuDist_DRunPN_no_PRE, ~, ~, ~, ~, ~] = analysis_neuralTrace(T.xptPsdPreD(DRun_PN_no),5,1,baseLine);

[m_neuDist_DRunPN_total_STM, ~, tracePCA_DRunPN_total, ~, scorePCA_DRunPN_total, latentPCA_DRunPN_total] = analysis_neuralTrace(T.xptTrack8hz(DRun_PN),5,1,baseLine);    
[m_neuDist_DRunPN_light_STM, ~, tracePCA_DRunPN_light, ~, scorePCA_DRunPN_light, latentPCA_DRunPN_light] = analysis_neuralTrace(T.xptTrack8hz(DRun_PN_light),5,1,baseLine);    
[m_neuDist_DRunPN_act_STM, ~, tracePCA_DRunPN_act, ~, scorePCA_DRunPN_act, latentPCA_DRunPN_act] = analysis_neuralTrace(T.xptTrack8hz(DRun_PN_act),5,1,baseLine);
[m_neuDist_DRunPN_ina_STM, ~, tracePCA_DRunPN_ina, ~, scorePCA_DRunPN_ina, latentPCA_DRunPN_ina] = analysis_neuralTrace(T.xptTrack8hz(DRun_PN_ina),5,1,baseLine);
[m_neuDist_DRunPN_no_STM, ~, tracePCA_DRunPN_no, ~, scorePCA_DRunPN_no, latentPCA_DRunPN_no] = analysis_neuralTrace(T.xptTrack8hz(DRun_PN_no),5,1,baseLine);

[m_neuDist_DRunPN_total_POST, ~, ~, ~, ~, ~] = analysis_neuralTrace(T.xptPsdPostD(DRun_PN),5,1,baseLine);    
[m_neuDist_DRunPN_light_POST, ~, ~, ~, ~, ~] = analysis_neuralTrace(T.xptPsdPostD(DRun_PN_light),5,1,baseLine);    
[m_neuDist_DRunPN_act_POST, ~, ~, ~, ~, ~] = analysis_neuralTrace(T.xptPsdPostD(DRun_PN_act),5,1,baseLine);
[m_neuDist_DRunPN_ina_POST, ~, ~, ~, ~, ~] = analysis_neuralTrace(T.xptPsdPostD(DRun_PN_ina),5,1,baseLine);
[m_neuDist_DRunPN_no_POST, ~, ~, ~, ~, ~] = analysis_neuralTrace(T.xptPsdPostD(DRun_PN_no),5,1,baseLine);
%%
nCol = 2;
nRow = 2;
xpt = -20:99;

fHandle(1) = figure('PaperUnits','centimeters','PaperPosition',paperSize{1},'Name','DRun_total');

hLatent(1) = axes('Position',axpt(nCol,nRow,1,1,[0.10 0.10 0.85 0.85],wideInterval));
plot(cumsum(latentPCA_DRunPN_act),'-o','color',colorBlack,'MarkerFaceColor',colorGray);
xlabel('number of components','fontSize',fontL);
ylabel('Representation (%)','fontSize',fontL);

hTrace(1) = axes('Position',axpt(nCol,nRow,2,1,[0.10, 0.10, 0.85, 0.85],wideInterval));
plot(scorePCA_DRunPN_total(:,1),scorePCA_DRunPN_total(:,2),'-o','color',colorBlack,'MarkerFaceColor',colorGray,'LineWidth',lineL);
hold on;
plot(scorePCA_DRunPN_light(:,1),scorePCA_DRunPN_light(:,2),'-o','color',colorBlack,'LineWidth',lineL,'MarkerFaceColor',colorGreen,'markerEdgeColor',colorBlack);
hold on;
plot(scorePCA_DRunPN_light(1,1),scorePCA_DRunPN_light(1,2),'-o','color',colorBlack,'LineWidth',lineL,'MarkerFaceColor',colorLightGreen,'markerEdgeColor',colorBlack);
hold on;
plot(scorePCA_DRunPN_light(end,1),scorePCA_DRunPN_light(end,2),'-o','color',colorBlack,'LineWidth',lineL,'MarkerFaceColor',colorDarkGreen,'markerEdgeColor',colorBlack);
hold on;
plot(scorePCA_DRunPN_act(:,1),scorePCA_DRunPN_act(:,2),'-o','color',colorBlack,'LineWidth',lineL,'MarkerFaceColor',colorBlue,'markerEdgeColor',colorBlack);
hold on;
plot(scorePCA_DRunPN_act(1,1),scorePCA_DRunPN_act(1,2),'-o','color',colorBlack,'LineWidth',lineL,'MarkerFaceColor',colorLightBlue,'markerEdgeColor',colorBlack);
hold on;
plot(scorePCA_DRunPN_act(end,1),scorePCA_DRunPN_act(end,2),'-o','color',colorBlack,'LineWidth',lineL,'MarkerFaceColor',colorDarkBlue,'markerEdgeColor',colorBlack);
hold on;
plot(scorePCA_DRunPN_ina(:,1),scorePCA_DRunPN_ina(:,2),'-o','color',colorBlack,'LineWidth',lineL,'MarkerFaceColor',colorRed,'markerEdgeColor',colorBlack);
hold on;
plot(scorePCA_DRunPN_ina(1,1),scorePCA_DRunPN_ina(1,2),'-o','color',colorBlack,'LineWidth',lineL,'MarkerFaceColor',colorLightRed,'markerEdgeColor',colorBlack);
hold on;
plot(scorePCA_DRunPN_ina(end,1),scorePCA_DRunPN_ina(end,2),'-o','color',colorBlack,'LineWidth',lineL,'MarkerFaceColor',colorDarkRed,'markerEdgeColor',colorBlack);
hold on;
xlabel('PC1','fontSize',fontL);
ylabel('PC2','fontSize',fontL);

hTrace(2) = axes('Position',axpt(nCol,nRow,1,2,[0.10, 0.10, 0.85, 0.85],wideInterval));
plot(scorePCA_DRunPN_total(:,1),scorePCA_DRunPN_total(:,2),'-o','color',colorBlack,'MarkerFaceColor',colorGray,'LineWidth',lineL);
hold on;
plot(scorePCA_DRunPN_light(:,1),scorePCA_DRunPN_light(:,2),'-o','color',colorBlack,'LineWidth',lineL,'MarkerFaceColor',colorGreen,'markerEdgeColor',colorBlack);
hold on;
plot(scorePCA_DRunPN_light(1,1),scorePCA_DRunPN_light(1,2),'-o','color',colorBlack,'LineWidth',lineL,'MarkerFaceColor',colorLightGreen,'markerEdgeColor',colorBlack);
hold on;
plot(scorePCA_DRunPN_light(end,1),scorePCA_DRunPN_light(end,2),'-o','color',colorBlack,'LineWidth',lineL,'MarkerFaceColor',colorDarkGreen,'markerEdgeColor',colorBlack);
hold on;
plot(scorePCA_DRunPN_act(:,1),scorePCA_DRunPN_act(:,2),'-o','color',colorBlack,'LineWidth',lineL,'MarkerFaceColor',colorBlue,'markerEdgeColor',colorBlack);
hold on;
plot(scorePCA_DRunPN_act(1,1),scorePCA_DRunPN_act(1,2),'-o','color',colorBlack,'LineWidth',lineL,'MarkerFaceColor',colorLightBlue,'markerEdgeColor',colorBlack);
hold on;
plot(scorePCA_DRunPN_act(end,1),scorePCA_DRunPN_act(end,2),'-o','color',colorBlack,'LineWidth',lineL,'MarkerFaceColor',colorDarkBlue,'markerEdgeColor',colorBlack);
hold on;
plot(scorePCA_DRunPN_ina(:,1),scorePCA_DRunPN_ina(:,2),'-o','color',colorBlack,'LineWidth',lineL,'MarkerFaceColor',colorRed,'markerEdgeColor',colorBlack);
hold on;
plot(scorePCA_DRunPN_ina(1,1),scorePCA_DRunPN_ina(1,2),'-o','color',colorBlack,'LineWidth',lineL,'MarkerFaceColor',colorLightRed,'markerEdgeColor',colorBlack);
hold on;
plot(scorePCA_DRunPN_ina(end,1),scorePCA_DRunPN_ina(end,2),'-o','color',colorBlack,'LineWidth',lineL,'MarkerFaceColor',colorDarkRed,'markerEdgeColor',colorBlack);
hold on;
xlabel('PC2','fontSize',fontL);
ylabel('PC3','fontSize',fontL);

hTrace(3) = axes('Position',axpt(nCol,nRow,2,2,[0.10, 0.10, 0.85, 0.85],wideInterval));
plot(scorePCA_DRunPN_total(:,1),scorePCA_DRunPN_total(:,2),'-o','color',colorBlack,'MarkerFaceColor',colorGray,'LineWidth',lineL);
hold on;
plot(scorePCA_DRunPN_light(:,1),scorePCA_DRunPN_light(:,2),'-o','color',colorBlack,'LineWidth',lineL,'MarkerFaceColor',colorGreen,'markerEdgeColor',colorBlack);
hold on;
plot(scorePCA_DRunPN_light(1,1),scorePCA_DRunPN_light(1,2),'-o','color',colorBlack,'LineWidth',lineL,'MarkerFaceColor',colorLightGreen,'markerEdgeColor',colorBlack);
hold on;
plot(scorePCA_DRunPN_light(end,1),scorePCA_DRunPN_light(end,2),'-o','color',colorBlack,'LineWidth',lineL,'MarkerFaceColor',colorDarkGreen,'markerEdgeColor',colorBlack);
hold on;
plot(scorePCA_DRunPN_act(:,1),scorePCA_DRunPN_act(:,2),'-o','color',colorBlack,'LineWidth',lineL,'MarkerFaceColor',colorBlue,'markerEdgeColor',colorBlack);
hold on;
plot(scorePCA_DRunPN_act(1,1),scorePCA_DRunPN_act(1,2),'-o','color',colorBlack,'LineWidth',lineL,'MarkerFaceColor',colorLightBlue,'markerEdgeColor',colorBlack);
hold on;
plot(scorePCA_DRunPN_act(end,1),scorePCA_DRunPN_act(end,2),'-o','color',colorBlack,'LineWidth',lineL,'MarkerFaceColor',colorDarkBlue,'markerEdgeColor',colorBlack);
hold on;
plot(scorePCA_DRunPN_ina(:,1),scorePCA_DRunPN_ina(:,2),'-o','color',colorBlack,'LineWidth',lineL,'MarkerFaceColor',colorRed,'markerEdgeColor',colorBlack);
hold on;
plot(scorePCA_DRunPN_ina(1,1),scorePCA_DRunPN_ina(1,2),'-o','color',colorBlack,'LineWidth',lineL,'MarkerFaceColor',colorLightRed,'markerEdgeColor',colorBlack);
hold on;
plot(scorePCA_DRunPN_ina(end,1),scorePCA_DRunPN_ina(end,2),'-o','color',colorBlack,'LineWidth',lineL,'MarkerFaceColor',colorDarkRed,'markerEdgeColor',colorBlack);
hold on;
xlabel('PC3','fontSize',fontL);
ylabel('PC1','fontSize',fontL);

set(hLatent,'Box','off','TickDir','out','YLim',[0,110]);
set(hTrace,'Box','off','TickDir','out');
% print('-painters','-r300',[datestr(now,formatOut),'_plot_neuralTrace_DRunPN_PCA_score.tif'],'-dtiff');

%%
fHandle(2) = figure('PaperUnits','centimeters','PaperPosition',paperSize{2},'Name','DRun_NeuDist');
nCol = 3;
nRow = 1;
hNeuDist(1) = axes('Position',axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval));
plot(xpt,m_neuDist_DRunPN_total_PRE,'-o','color',colorLightGray,'MarkerFaceColor',colorDarkGray,'MarkerSize',markerL,'LineWidth',lineL);
hold on;
plot(xpt,m_neuDist_DRunPN_light_PRE,'-o','color',colorLightGreen,'MarkerFaceColor',colorDarkGreen,'MarkerSize',markerL,'LineWidth',lineL);
hold on;
plot(xpt,m_neuDist_DRunPN_act_PRE,'-o','color',colorLightBlue,'MarkerFaceColor',colorDarkBlue,'MarkerSize',markerL,'LineWidth',lineL);
hold on;
plot(xpt,m_neuDist_DRunPN_ina_PRE,'-o','color',colorLightRed,'MarkerFaceColor',colorDarkRed,'MarkerSize',markerL,'LineWidth',lineL);
hold on;
plot(xpt,m_neuDist_DRunPN_no_PRE,'-o','color',colorGray,'MarkerFaceColor',colorBlack,'MarkerSize',markerL,'LineWidth',lineL);
title('Neural Distance [PRE]','fontSize',fontL);

hNeuDist(2) = axes('Position',axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],wideInterval));
plot(xpt,m_neuDist_DRunPN_total_STM,'-o','color',colorLightGray,'MarkerFaceColor',colorDarkGray,'MarkerSize',markerL,'LineWidth',lineL);
hold on;
plot(xpt,m_neuDist_DRunPN_light_STM,'-o','color',colorLightGreen,'MarkerFaceColor',colorDarkGreen,'MarkerSize',markerL,'LineWidth',lineL);
hold on;
plot(xpt,m_neuDist_DRunPN_act_STM,'-o','color',colorLightBlue,'MarkerFaceColor',colorDarkBlue,'MarkerSize',markerL,'LineWidth',lineL);
hold on;
plot(xpt,m_neuDist_DRunPN_ina_STM,'-o','color',colorLightRed,'MarkerFaceColor',colorDarkRed,'MarkerSize',markerL,'LineWidth',lineL);
hold on;
plot(xpt,m_neuDist_DRunPN_no_STM,'-o','color',colorGray,'MarkerFaceColor',colorBlack,'MarkerSize',markerL,'LineWidth',lineL);

text(40,max(m_neuDist_DRunPN_act_STM)*0.9,['Total (n = ',num2str(sum(double(DRun_PN))), ')'],'color',colorDarkGray,'fontSize',fontL);
text(40,max(m_neuDist_DRunPN_act_STM)*0.85,['Light resp. (n = ',num2str(sum(double(DRun_PN_light))), ')'],'color',colorGreen,'fontSize',fontL);
text(40,max(m_neuDist_DRunPN_act_STM)*0.80,['Light act. (n = ',num2str(sum(double(DRun_PN_act))), ')'],'color',colorBlue,'fontSize',fontL);
text(40,max(m_neuDist_DRunPN_act_STM)*0.75,['Light ina. (n = ',num2str(sum(double(DRun_PN_ina))), ')'],'color',colorRed,'fontSize',fontL);
text(40,max(m_neuDist_DRunPN_act_STM)*0.70,['No resp. (n = ',num2str(sum(double(DRun_PN_no))), ')'],'color',colorBlack,'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontXL);
ylabel('Neural distance','fontSize',fontXL);
title('Neural Distance [STM]','fontSize',fontL);

hNeuDist(3) = axes('Position',axpt(nCol,nRow,3,1,[0.1 0.1 0.85 0.85],wideInterval));
plot(xpt,m_neuDist_DRunPN_total_POST,'-o','color',colorLightGray,'MarkerFaceColor',colorDarkGray,'MarkerSize',markerL,'LineWidth',lineL);
hold on;
plot(xpt,m_neuDist_DRunPN_light_POST,'-o','color',colorLightGreen,'MarkerFaceColor',colorDarkGreen,'MarkerSize',markerL,'LineWidth',lineL);
hold on;
plot(xpt,m_neuDist_DRunPN_act_POST,'-o','color',colorLightBlue,'MarkerFaceColor',colorDarkBlue,'MarkerSize',markerL,'LineWidth',lineL);
hold on;
plot(xpt,m_neuDist_DRunPN_ina_POST,'-o','color',colorLightRed,'MarkerFaceColor',colorDarkRed,'MarkerSize',markerL,'LineWidth',lineL);
hold on;
plot(xpt,m_neuDist_DRunPN_no_POST,'-o','color',colorGray,'MarkerFaceColor',colorBlack,'MarkerSize',markerL,'LineWidth',lineL);
title('Neural Distance [POST]','fontSize',fontL);

set(hNeuDist,'Box','off','TickDir','out','XLim',[-20,100],'YLim',[0,4],'fontSize',fontXL);
print('-painters','-r300',[datestr(now,formatOut),'_plot_neuralTrace_DRunPN_NeuDist_score.tif'],'-dtiff');
close('all')