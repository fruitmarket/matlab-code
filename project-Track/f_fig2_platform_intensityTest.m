function f_fig2_platform_intensityTest
%%
rtDir = 'D:\Dropbox\SNL\P2_Track';
cd(rtDir);

load('myParameters.mat');
% load('neuronList_ori_170823.mat');
load('neuronList_ori_170908.mat');

%%%%%
DRunPn = T.taskType == 'DRun' & T.idxNeurontype == 'PN';
DRunIn = T.taskType == 'DRun' & T.idxNeurontype == 'IN';
DRunUNC = T.taskType == 'DRun' & T.idxNeurontype == 'UNC';

DRwPn = T.taskType == 'DRw' & T.idxNeurontype == 'PN';
DRwIn = T.taskType == 'DRw' & T.idxNeurontype == 'IN';
DRwUNC = T.taskType == 'DRw' & T.idxNeurontype == 'UNC';

%%%
alpha = 0.01;
plfmLight = T.pLR_Plfm2hz<alpha;

% none/either/both : Activated on Platform or Track?
DRunPn_evoked = DRunPn & plfmLight;
DRunIn_evoked = DRunIn & plfmLight;
DRwPn_evoked = DRwPn & plfmLight;
DRwIn_evoked = DRwIn & plfmLight;

nDRunPN = length(T.lightProbPlfm5mw(DRunPn_evoked));
lightPlfm5mw_DRunPn = T.lightProbPlfm5mw(DRunPn_evoked);
lightPlfm8mw_DRunPn = T.lightProbPlfm8mw(DRunPn_evoked);
lightPlfm10mw_DRunPn = T.lightProbPlfm10mw(DRunPn_evoked);
m_DRunPN_5mw = mean(lightPlfm5mw_DRunPn);
m_DRunPN_8mw = mean(lightPlfm8mw_DRunPn);
m_DRunPN_10mw = mean(lightPlfm10mw_DRunPn);
sem_DRunPN_5mw = std(lightPlfm5mw_DRunPn)/sqrt(nDRunPN);
sem_DRunPN_8mw = std(lightPlfm8mw_DRunPn)/sqrt(nDRunPN);
sem_DRunPN_10mw = std(lightPlfm10mw_DRunPn)/sqrt(nDRunPN);

nDRunIN = length(T.lightProbPlfm5mw(DRunIn_evoked));
lightPlfm5mw_DRunIn = T.lightProbPlfm5mw(DRunIn_evoked);
lightPlfm8mw_DRunIn = T.lightProbPlfm8mw(DRunIn_evoked);
lightPlfm10mw_DRunIn = T.lightProbPlfm10mw(DRunIn_evoked);
m_DRunIN_5mw = mean(lightPlfm5mw_DRunIn);
m_DRunIN_8mw = mean(lightPlfm8mw_DRunIn);
m_DRunIN_10mw = mean(lightPlfm10mw_DRunIn);
sem_DRunIN_5mw = std(lightPlfm5mw_DRunIn)/sqrt(nDRunIN);
sem_DRunIN_8mw = std(lightPlfm8mw_DRunIn)/sqrt(nDRunIN);
sem_DRunIN_10mw = std(lightPlfm10mw_DRunIn)/sqrt(nDRunIN);

nDRwPN = length(T.lightProbPlfm5mw(DRwPn_evoked));
lightPlfm5mw_DRwPn = T.lightProbPlfm5mw(DRwPn_evoked);
lightPlfm8mw_DRwPn = T.lightProbPlfm8mw(DRwPn_evoked);
lightPlfm10mw_DRwPn = T.lightProbPlfm10mw(DRwPn_evoked);
m_DRwPN_5mw = mean(lightPlfm5mw_DRwPn);
m_DRwPN_8mw = mean(lightPlfm8mw_DRwPn);
m_DRwPN_10mw = mean(lightPlfm10mw_DRwPn);
sem_DRwPN_5mw = std(lightPlfm5mw_DRwPn)/sqrt(nDRwPN);
sem_DRwPN_8mw = std(lightPlfm8mw_DRwPn)/sqrt(nDRwPN);
sem_DRwPN_10mw = std(lightPlfm10mw_DRwPn)/sqrt(nDRwPN);

nDRwIN = length(T.lightProbPlfm5mw(DRwIn_evoked));
lightPlfm5mw_DRwIn = T.lightProbPlfm5mw(DRwIn_evoked);
lightPlfm8mw_DRwIn = T.lightProbPlfm8mw(DRwIn_evoked);
lightPlfm10mw_DRwIn = T.lightProbPlfm10mw(DRwIn_evoked);
m_DRwIN_5mw = mean(lightPlfm5mw_DRwIn);
m_DRwIN_8mw = mean(lightPlfm8mw_DRwIn);
m_DRwIN_10mw = mean(lightPlfm10mw_DRwIn);
sem_DRwIN_5mw = std(lightPlfm5mw_DRwIn)/sqrt(nDRwIN);
sem_DRwIN_8mw = std(lightPlfm8mw_DRwIn)/sqrt(nDRwIN);
sem_DRwIN_10mw = std(lightPlfm10mw_DRwIn)/sqrt(nDRwIN);

%% Figure (DRun)
nCol = 4;
nRow = 2;

fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{2});

hInten(1) = axes('Position',axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval));
plot([1,2,3],[lightPlfm5mw_DRunPn, lightPlfm8mw_DRunPn, lightPlfm10mw_DRunPn],'-o','color',colorDarkGray,'markerSize',markerL,'markerEdgeColor',colorDarkGray,'markerFaceColor',colorLightGray);
hold on;
plot([1,2,3],[m_DRunPN_5mw, m_DRunPN_8mw, m_DRunPN_10mw],'o','color',colorBlack,'markerSize',markerL,'markerEdgeColor',colorBlack,'markerFaceColor',colorBlack);
hold on;
errorbarJun([1,2,3],[m_DRunPN_5mw, m_DRunPN_8mw, m_DRunPN_10mw],[sem_DRunPN_5mw, sem_DRunPN_8mw, sem_DRunPN_10mw],0.3,0.8,colorBlack);
text(3.5, 50,['n = ',num2str(length(lightPlfm5mw_DRunPn))],'fontSize',fontM);
ylabel('Spike fidelity (%)','fontSize',fontL);
xlabel('Laser power (mW)','fontSize',fontL);
title('DRun PN','fontSize',fontL);

hInten(2) = axes('Position',axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85], wideInterval));
plot([1,2,3],[lightPlfm5mw_DRunIn, lightPlfm8mw_DRunIn, lightPlfm10mw_DRunIn],'-o','color',colorDarkGray,'markerSize',markerL,'markerEdgeColor',colorDarkGray,'markerFaceColor',colorLightGray);
hold on;
plot([1,2,3],[m_DRunIN_5mw, m_DRunIN_8mw, m_DRunIN_10mw],'o','color',colorBlack,'markerSize',markerL,'markerEdgeColor',colorBlack,'markerFaceColor',colorBlack);
hold on;
errorbar([1,2,3],[m_DRunIN_5mw, m_DRunIN_8mw, m_DRunIN_10mw],[sem_DRunIN_5mw, sem_DRunIN_8mw, sem_DRunIN_10mw],'o','color',colorBlack,'markerSize',markerL);
text(3.5, 50,['n = ',num2str(length(lightPlfm5mw_DRunIn))],'fontSize',fontM);
ylabel('Spike fidelity (%)','fontSize',fontL);
xlabel('Laser power (mW)','fontSize',fontL);
title('DRun IN','fontSize',fontL);

hInten(3) = axes('Position',axpt(nCol,nRow,3,1,[0.1 0.1 0.85 0.85], wideInterval));
plot([1,2,3],[lightPlfm5mw_DRwPn, lightPlfm8mw_DRwPn, lightPlfm10mw_DRwPn],'-o','color',colorDarkGray,'markerSize',markerL,'markerEdgeColor',colorDarkGray,'markerFaceColor',colorLightGray);
hold on;
plot([1,2,3],[m_DRwPN_5mw, m_DRwPN_8mw, m_DRwPN_10mw],'o','color',colorBlack,'markerSize',markerL,'markerEdgeColor',colorBlack,'markerFaceColor',colorBlack);
hold on;
errorbar([1,2,3],[m_DRwPN_5mw, m_DRwPN_8mw, m_DRwPN_10mw],[sem_DRwPN_5mw, sem_DRwPN_8mw, sem_DRwPN_10mw],'o','color',colorBlack,'markerSize',markerL);
text(3.5, 50,['n = ',num2str(length(lightPlfm5mw_DRwPn))],'fontSize',fontM);
ylabel('Spike fidelity (%)','fontSize',fontL);
xlabel('Laser power (mW)','fontSize',fontL);
title('DRw PN','fontSize',fontL);

hInten(4) = axes('Position',axpt(nCol,nRow,4,1,[0.1 0.1 0.85 0.85], wideInterval));
plot([1,2,3],[lightPlfm5mw_DRwIn, lightPlfm8mw_DRwIn, lightPlfm10mw_DRwIn],'-o','color',colorDarkGray,'markerSize',markerL,'markerEdgeColor',colorDarkGray,'markerFaceColor',colorLightGray);
hold on;
plot([1,2,3],[m_DRwIN_5mw, m_DRwIN_8mw, m_DRwIN_10mw],'o','color',colorBlack,'markerSize',markerL,'markerEdgeColor',colorBlack,'markerFaceColor',colorBlack);
hold on;
errorbar([1,2,3],[m_DRwIN_5mw, m_DRwIN_8mw, m_DRwIN_10mw],[sem_DRwIN_5mw, sem_DRwIN_8mw, sem_DRwIN_10mw],'o','color',colorBlack,'markerSize',markerL);
text(3.5, 50,['n = ',num2str(length(lightPlfm5mw_DRwIn))],'fontSize',fontM);
ylabel('Spike fidelity (%)','fontSize',fontL);
xlabel('Laser power (mW)','fontSize',fontL);
title('DRw IN','fontSize',fontL);

set(hInten,'Box','off','TickDir','out','XLim',[0,4],'XTick',[1:3],'XTickLabel',{'5mW','8mW','10mW'},'fontSize',fontL);
set(hInten(1),'YLim',[-1,50]);

formatOut = 'yymmdd';
% print('-painters','-r300','-dtiff',['final_fig2_platform_intensity_',datestr(now,formatOut),'.tif']);
% print('-painters','-r300','-depsc',[datestr(now,formatOut),'_fig1_intensityTest','.ai']);
close;
