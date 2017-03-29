% Latency of neurons which are activated on the platform. (Blue)
% Among neurons which are activated on the platform, latency of neurons
% which are also activated on the platform

% common part
clearvars;
lineColor = {[144, 164, 174]./255,... % Before stimulation
    [33 150 243]./ 255,... % During stimulation
    [38, 50, 56]./255}; % After stimulation

lineWth = [1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75];
fontS = 4; fontM = 6; fontL = 8; % font size large
lineS = 0.2; lineM = 0.5; lineL = 1; % line width large

colorBlue = [33, 150, 243]/255;
colorLightBlue = [100, 181, 246]/255;
colorLLightBlue = [187, 222, 251]/255;
colorRed = [237, 50, 52]/255;
colorLightRed = [242, 138, 130]/255;
colorGray = [189, 189, 189]/255;
colorGreen = [46, 125, 50]/255;
colorLightGray = [238, 238, 238]/255;
colorDarkGray = [117, 117, 117]/255;
colorYellow = [255, 243, 3]/255;
colorLightYellow = [255, 249, 196]/255;
colorPurple = [123, 31, 162]/255;
colorBlack = [0, 0, 0];

markerS = 2.2; markerM = 4.4; markerL = 6.6; markerXL = 8.8;
tightInterval = [0.02 0.02]; midInterval = [0.09, 0.09]; wideInterval = [0.14 0.14];
width = 0.7;

paperSize = {[0 0 21.0 29.7]; % A4_portrait
             [0 0 29.7 21.0]; % A4_landscape
             [0 0 15.7 21.0]; % A4_half landscape
             [0 0 21.6 27.9]}; % Letter

cd('D:\Dropbox\SNL\P2_Track');
% Txls = readtable('neuronList_24-Mar-2017.xlsx');
load('neuronList_ori_25-Mar-2017.mat');

cri_meanFR = 7;
cri_peakFR = 0;
alpha = 0.01;

% TN: track neuron
DRwTN = (T.taskType == 'DRw') & (cellfun(@max, T.peakFR1D_track) > cri_peakFR);

% total population (DRwPN / DRwIN / DRwPN / DRwIN) with light responsiveness (light activated)
DRwPN_act = DRwTN & T.meanFR_task<=cri_meanFR & T.pLR_Track<alpha & T.statDir_Track == 1;
DRwPN_ina = DRwTN & T.meanFR_task<=cri_meanFR & T.pLR_Track<alpha & T.statDir_Track == -1;
DRwPN_no = DRwTN & T.meanFR_task<=cri_meanFR & T.pLR_Track>=alpha;

DRwIN_act = DRwTN & T.meanFR_task>cri_meanFR & T.pLR_Track<alpha & T.statDir_Track == 1;
DRwIN_ina = DRwTN & T.meanFR_task>cri_meanFR & T.pLR_Track<alpha & T.statDir_Track == -1;
DRwIN_no = DRwTN & T.meanFR_task>cri_meanFR & T.pLR_Track>=alpha;

winSize = [ones(1,4)*5, ones(1,9)*10, ones(1,14)*15];
mvWinSize = [1:4,1:9,1:14];
nCycle = length(winSize);
baseLine = [-20, 0];
for iCycle = 1:nCycle

[neuDist_DRwPN_act, tracePCA_DRwPN_act, latentPCA_DRwPN_act] = analysis_neuralTrace(T.xptTrackLight(DRwPN_act),winSize(iCycle),mvWinSize(iCycle),baseLine);
[neuDist_DRwPN_ina, tracePCA_DRwPN_ina, latentPCA_DRwPN_ina] = analysis_neuralTrace(T.xptTrackLight(DRwPN_ina),winSize(iCycle),mvWinSize(iCycle),baseLine);
% [neuDist_DRwPN_no, tracePCA_DRwPN_no, latentPCA_DRwPN_no] = analysis_neuralTrace(T.xptTrackLight(DRwPN_no),10,5);

%%
nCol = 3;
nRow = 4;

fHandle(1) = figure('PaperUnits','centimeters','PaperPosition',paperSize{1},'Name','DRwPN');

hLatent(1) = axes('Position',axpt(nCol,nRow,1,1,[0.10 0.10 0.85 0.85],wideInterval));
plot(cumsum(latentPCA_DRwPN_act),'-o','color',colorBlack,'MarkerFaceColor',colorGray);
xlabel('number of components','fontSize',fontL);
ylabel('Representation (%)','fontSize',fontL);

hTrace(1) = axes('Position',axpt(nCol,nRow,2,1,[0.10, 0.10, 0.85, 0.85],wideInterval));
plot(tracePCA_DRwPN_act(:,1),tracePCA_DRwPN_act(:,2),'-o','color',colorBlack,'MarkerFaceColor',colorGray,'LineWidth',lineL);
hold on;
plot(tracePCA_DRwPN_act(1,1),tracePCA_DRwPN_act(1,2),'o','LineWidth',lineL,'MarkerFaceColor',colorBlue,'markerEdgeColor',colorBlack);
hold on;
plot(tracePCA_DRwPN_act(end,1),tracePCA_DRwPN_act(end,2),'o','LineWidth',lineL,'MarkerFaceColor',colorRed,'markerEdgeColor',colorBlack);
xlabel('PC1','fontSize',fontL);
ylabel('PC2','fontSize',fontL);

hTrace(2) = axes('Position',axpt(nCol,nRow,1,2,[0.10, 0.10, 0.85, 0.85],wideInterval));
plot(tracePCA_DRwPN_act(:,2),tracePCA_DRwPN_act(:,3),'-o','color',colorBlack,'MarkerFaceColor',colorGray,'LineWidth',lineL);
hold on;
plot(tracePCA_DRwPN_act(1,2),tracePCA_DRwPN_act(1,3),'o','LineWidth',lineL,'MarkerFaceColor',colorBlue,'markerEdgeColor',colorBlack);
hold on;
plot(tracePCA_DRwPN_act(end,2),tracePCA_DRwPN_act(end,3),'o','LineWidth',lineL,'MarkerFaceColor',colorRed,'markerEdgeColor',colorBlack);
xlabel('PC2','fontSize',fontL);
ylabel('PC3','fontSize',fontL);

hTrace(3) = axes('Position',axpt(nCol,nRow,2,2,[0.10, 0.10, 0.85, 0.85],wideInterval));
plot(tracePCA_DRwPN_act(:,3),tracePCA_DRwPN_act(:,1),'-o','color',colorBlack,'MarkerFaceColor',colorGray,'LineWidth',lineL);
hold on;
plot(tracePCA_DRwPN_act(1,3),tracePCA_DRwPN_act(1,1),'o','LineWidth',lineL,'MarkerFaceColor',colorBlue,'markerEdgeColor',colorBlack);
hold on;
plot(tracePCA_DRwPN_act(end,3),tracePCA_DRwPN_act(end,1),'o','LineWidth',lineL,'MarkerFaceColor',colorRed,'markerEdgeColor',colorBlack);
xlabel('PC3','fontSize',fontL);
ylabel('PC1','fontSize',fontL);

hNeuDist(1) =  axes('Position',axpt(nCol,nRow,3,1,[0.10, 0.10, 0.85, 0.85],wideInterval));
plot(neuDist_DRwPN_act,'-o','color',colorBlack,'MarkerFaceColor',colorGray,'LineWidth',lineL);
xlabel('Time moving step (ms)','fontSize',fontL);
ylabel('Neural Distance','fontSize',fontL);
%%
hLatent(2) = axes('Position',axpt(nCol,nRow,1,3,[0.10 0.10 0.85 0.85],wideInterval));
plot(cumsum(latentPCA_DRwPN_ina),'-o','color',colorBlack,'MarkerFaceColor',colorGray);
xlabel('number of components','fontSize',fontL);
ylabel('Representation (%)','fontSize',fontL);

hTrace(4) = axes('Position',axpt(nCol,nRow,2,3,[0.10, 0.10, 0.85, 0.85],wideInterval));
plot(tracePCA_DRwPN_ina(:,1),tracePCA_DRwPN_ina(:,2),'-o','color',colorBlack,'MarkerFaceColor',colorGray,'LineWidth',lineL);
hold on;
plot(tracePCA_DRwPN_ina(1,1),tracePCA_DRwPN_ina(1,2),'o','LineWidth',lineL,'MarkerFaceColor',colorBlue,'markerEdgeColor',colorBlack);
hold on;
plot(tracePCA_DRwPN_ina(end,1),tracePCA_DRwPN_ina(end,2),'o','LineWidth',lineL,'MarkerFaceColor',colorRed,'markerEdgeColor',colorBlack);
xlabel('PC1','fontSize',fontL);
ylabel('PC2','fontSize',fontL);

hTrace(5) = axes('Position',axpt(nCol,nRow,1,4,[0.10, 0.10, 0.85, 0.85],wideInterval));
plot(tracePCA_DRwPN_ina(:,2),tracePCA_DRwPN_ina(:,3),'-o','color',colorBlack,'MarkerFaceColor',colorGray,'LineWidth',lineL);
hold on;
plot(tracePCA_DRwPN_ina(1,2),tracePCA_DRwPN_ina(1,3),'o','LineWidth',lineL,'MarkerFaceColor',colorBlue,'markerEdgeColor',colorBlack);
hold on;
plot(tracePCA_DRwPN_ina(end,2),tracePCA_DRwPN_ina(end,3),'o','LineWidth',lineL,'MarkerFaceColor',colorRed,'markerEdgeColor',colorBlack);
xlabel('PC2','fontSize',fontL);
ylabel('PC3','fontSize',fontL);

hTrace(6) = axes('Position',axpt(nCol,nRow,2,4,[0.10, 0.10, 0.85, 0.85],wideInterval));
plot(tracePCA_DRwPN_ina(:,3),tracePCA_DRwPN_ina(:,1),'-o','color',colorBlack,'MarkerFaceColor',colorGray,'LineWidth',lineL);
hold on;
plot(tracePCA_DRwPN_ina(1,3),tracePCA_DRwPN_ina(1,1),'o','LineWidth',lineL,'MarkerFaceColor',colorBlue,'markerEdgeColor',colorBlack);
hold on;
plot(tracePCA_DRwPN_ina(end,3),tracePCA_DRwPN_ina(end,1),'o','LineWidth',lineL,'MarkerFaceColor',colorRed,'markerEdgeColor',colorBlack);
xlabel('PC3','fontSize',fontL);
ylabel('PC1','fontSize',fontL);

hNeuDist(2) =  axes('Position',axpt(nCol,nRow,3,3,[0.10, 0.10, 0.85, 0.85],wideInterval));
plot(neuDist_DRwPN_ina,'-o','color',colorBlack,'MarkerFaceColor',colorGray,'LineWidth',lineL);
xlabel('Time moving step (ms)','fontSize',fontL);
ylabel('Neural Distance','fontSize',fontL);

%%
% hLatent(3) = axes('Position',axpt(nCol,nRow,1,5,[0.10 0.10 0.85 0.85],wideInterval));
% plot(cumsum(latentPCA_DRwPN_no),'-o','color',colorBlack,'MarkerFaceColor',colorGray);
% xlabel('number of components','fontSize',fontL);
% ylabel('Representation (%)','fontSize',fontL);
% 
% hTrace(7) = axes('Position',axpt(nCol,nRow,2,5,[0.10, 0.10, 0.85, 0.85],wideInterval));
% plot(tracePCA_DRwPN_no(:,1),tracePCA_DRwPN_no(:,2),'-o','color',colorBlack,'MarkerFaceColor',colorGray,'LineWidth',lineL);
% hold on;
% plot(tracePCA_DRwPN_no(1,1),tracePCA_DRwPN_no(1,2),'o','LineWidth',lineL,'MarkerFaceColor',colorBlue,'markerEdgeColor',colorBlack);
% hold on;
% plot(tracePCA_DRwPN_no(end,1),tracePCA_DRwPN_no(end,2),'o','LineWidth',lineL,'MarkerFaceColor',colorRed,'markerEdgeColor',colorBlack);
% xlabel('PC1','fontSize',fontL);
% ylabel('PC2','fontSize',fontL);
% 
% hTrace(8) = axes('Position',axpt(nCol,nRow,1,6,[0.10, 0.10, 0.85, 0.85],wideInterval));
% plot(tracePCA_DRwPN_no(:,2),tracePCA_DRwPN_no(:,3),'-o','color',colorBlack,'MarkerFaceColor',colorGray,'LineWidth',lineL);
% hold on;
% plot(tracePCA_DRwPN_no(1,2),tracePCA_DRwPN_no(1,3),'o','LineWidth',lineL,'MarkerFaceColor',colorBlue,'markerEdgeColor',colorBlack);
% hold on;
% plot(tracePCA_DRwPN_no(end,2),tracePCA_DRwPN_no(end,3),'o','LineWidth',lineL,'MarkerFaceColor',colorRed,'markerEdgeColor',colorBlack);
% xlabel('PC2','fontSize',fontL);
% ylabel('PC3','fontSize',fontL);
% 
% hTrace(9) = axes('Position',axpt(nCol,nRow,2,6,[0.10, 0.10, 0.85, 0.85],wideInterval));
% plot(tracePCA_DRwPN_no(:,3),tracePCA_DRwPN_no(:,1),'-o','color',colorBlack,'MarkerFaceColor',colorGray,'LineWidth',lineL);
% hold on;
% plot(tracePCA_DRwPN_no(1,3),tracePCA_DRwPN_no(1,1),'o','LineWidth',lineL,'MarkerFaceColor',colorBlue,'markerEdgeColor',colorBlack);
% hold on;
% plot(tracePCA_DRwPN_no(end,3),tracePCA_DRwPN_no(end,1),'o','LineWidth',lineL,'MarkerFaceColor',colorRed,'markerEdgeColor',colorBlack);
% xlabel('PC3','fontSize',fontL);
% ylabel('PC1','fontSize',fontL);

set(hLatent,'Box','off','TickDir','out','YLim',[0,110]);
set(hTrace,'Box','off','TickDir','out');
set(hNeuDist,'Box','off','TickDir','out');
% print('-painters','-r300','plot_neuralTrace_DRwPN_5-2.tif','-dtiff');
% print('-painters','-r300','plot_neuralTrace_DRwPN_10-2.tif','-dtiff');
% print('-painters','-r300','plot_neuralTrace_DRwPN_10-5.tif','-dtiff');
% print('-painters','-r300','plot_neuralTrace_DRwPN_15-2.tif','-dtiff');
% print('-painters','-r300','plot_neuralTrace_DRwPN_15-5.tif','-dtiff');
% print('-painters','-r300','plot_neuralTrace_DRwPN_15-10.tif','-dtiff');

print('-painters','-r300',['plot_neuralTrace_DRwPN_',num2str(winSize(iCycle)),'-',num2str(mvWinSize(iCycle)),'.tif'],'-dtiff');
close('all')
end