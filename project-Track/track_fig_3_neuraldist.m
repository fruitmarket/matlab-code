% Latency of neurons which are activated on the platform. (Blue)
% Among neurons which are activated on the platform, latency of neurons
% which are also activated on the platform

% common part
clearvars;

cd('D:\Dropbox\SNL\P2_Track');
load('neuronList_ori_170508.mat');
load myParameters.mat;

cMeanFR = 9;
cMaxPeakFR = 1;
cSpkpvr = 1.1;
alpha = 0.01;

condiTN = (cellfun(@max, T.peakFR1D_track) > cMaxPeakFR) & ~(cellfun(@(x) any(isnan(x)),T.peakloci_total));
condiPN = T.spkpvr>cSpkpvr & T.meanFR_task<cMeanFR;
condiIN = ~condiPN;

% TN: track neuron
DRunTN = (T.taskType == 'DRun') & condiTN;
DRunPN = DRunTN & condiPN;
DRunIN = DRunTN & condiIN;

DRwTN = (T.taskType == 'DRw') & condiTN;
DRwPN = DRwTN & condiPN;
DRwIN = DRwTN & condiIN;

% total population (DRunPN / DRunIN / DRwPN / DRwIN) with light responsiveness (light activated)
DRunPN_total = DRunPN;
DRunPN_light = DRunPN & T.pLR_Track<alpha;
DRunPN_act = DRunPN & T.pLR_Track<alpha & T.statDir_Track == 1;
DRunPN_ina = DRunPN & T.pLR_Track<alpha & T.statDir_Track == -1;
DRunPN_no = DRunPN & T.pLR_Track>=alpha;

winSize = [ones(1,4)*5, ones(1,9)*10, ones(1,14)*15];
mvWinSize = [1:4,1:9,1:14];
nCycle = length(winSize);
baseLine = [-20, 0];

[m_neuDist_DRunPN_total, ~, tracePCA_DRunPN_total, scorePCA_DRunPN_total, latentPCA_DRunPN_total] = analysis_neuralTrace(T.xptTrackLight(DRunPN_total),5,1,baseLine);    
[m_neuDist_DRunPN_light, ~, tracePCA_DRunPN_light, scorePCA_DRunPN_light, latentPCA_DRunPN_light] = analysis_neuralTrace(T.xptTrackLight(DRunPN_light),5,1,baseLine);    
[m_neuDist_DRunPN_act, ~, tracePCA_DRunPN_act, scorePCA_DRunPN_act, latentPCA_DRunPN_act] = analysis_neuralTrace(T.xptTrackLight(DRunPN_act),5,1,baseLine);
[m_neuDist_DRunPN_ina, ~, tracePCA_DRunPN_ina, scorePCA_DRunPN_ina, latentPCA_DRunPN_ina] = analysis_neuralTrace(T.xptTrackLight(DRunPN_ina),5,1,baseLine);
[m_neuDist_DRunPN_no, ~, tracePCA_DRunPN_no, scorePCA_DRunPN_no, latentPCA_DRunPN_no] = analysis_neuralTrace(T.xptTrackLight(DRunPN_no),5,1,baseLine);

%%
nCol = 2;
nRow = 2;

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
formatOut = 'yymmdd';
print('-painters','-r300','-dtiff',['fig3_pcaDist_',datestr(now,formatOut),'.tif']);
print('-painters','-r300','-depsc',['fig3_pcaDist_',datestr(now,formatOut),'.ai']);

%%
fHandle(2) = figure('PaperUnits','centimeters','PaperPosition',paperSize{1},'Name','DRun_NeuDist');
hNeuDist = axes('Position',axpt(1,1,1,1,[0.1 0.1 0.85 0.85],wideInterval));
plot(m_neuDist_DRunPN_total,'-o','color',colorLightGray,'MarkerFaceColor',colorDarkGray,'MarkerSize',markerL,'LineWidth',lineL);
hold on;
plot(m_neuDist_DRunPN_light,'-o','color',colorLightGreen,'MarkerFaceColor',colorDarkGreen,'MarkerSize',markerL,'LineWidth',lineL);
hold on;
plot(m_neuDist_DRunPN_act,'-o','color',colorLightBlue,'MarkerFaceColor',colorDarkBlue,'MarkerSize',markerL,'LineWidth',lineL);
hold on;
plot(m_neuDist_DRunPN_ina,'-o','color',colorLightRed,'MarkerFaceColor',colorDarkRed,'MarkerSize',markerL,'LineWidth',lineL);
hold on;
plot(m_neuDist_DRunPN_no,'-o','color',colorGray,'MarkerFaceColor',colorBlack,'MarkerSize',markerL,'LineWidth',lineL);

text(size(m_neuDist_DRunPN_act,1)*0.6,max(m_neuDist_DRunPN_act)*0.9,['Total (n = ',num2str(sum(double(DRunPN_total))), ')'],'color',colorDarkGray,'fontSize',fontL);
text(size(m_neuDist_DRunPN_act,1)*0.6,max(m_neuDist_DRunPN_act)*0.85,['Light resp. (n = ',num2str(sum(double(DRunPN_light))), ')'],'color',colorGreen,'fontSize',fontL);
text(size(m_neuDist_DRunPN_act,1)*0.6,max(m_neuDist_DRunPN_act)*0.80,['Light act. (n = ',num2str(sum(double(DRunPN_act))), ')'],'color',colorBlue,'fontSize',fontL);
text(size(m_neuDist_DRunPN_act,1)*0.6,max(m_neuDist_DRunPN_act)*0.75,['Light ina. (n = ',num2str(sum(double(DRunPN_ina))), ')'],'color',colorRed,'fontSize',fontL);
text(size(m_neuDist_DRunPN_act,1)*0.6,max(m_neuDist_DRunPN_act)*0.70,['No resp. (n = ',num2str(sum(double(DRunPN_no))), ')'],'color',colorBlack,'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontXL);
ylabel('Neural distance','fontSize',fontXL);
title('Neural Distance [DRun sessions]','fontSize',fontXL);
set(hNeuDist,'Box','off','TickDir','out','XLim',[0,size(m_neuDist_DRunPN_act,1)*1.01],'XTick',[0,20/1,30/1,40/1,size(m_neuDist_DRunPN_act,1)],'XTickLabel',[-20,0,10,20,100],'fontSize',fontXL);

print('-painters','-r300','-dtiff',['fig3_neuralDist_',datestr(now,formatOut),'.tif']);
print('-painters','-r300','-depsc',['fig3_neuralDist_',datestr(now,formatOut),'.ai']);
close('all')