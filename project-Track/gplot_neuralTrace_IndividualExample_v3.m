function gplot_neuralTrace_IndividualExample_v3
% Latency of neurons which are activated on the platform. (Blue)
% Among neurons which are activated on the platform, latency of neurons
% which are also activated on the platform

% common part
clearvars;
rtDir = 'D:\Dropbox\SNL\P2_Track';
cd(rtDir);

load('D:\Dropbox\SNL\P2_Track\myParameters.mat');
load('neuronList_ori_171016.mat');
Txls = readtable('neuronList_ori_171016.xlsx');
Txls.taskType = categorical(Txls.taskType);
formatOut = 'yymmdd';

% total population (DRunPN / DRunIN / DRwPN / DRwIN) with light responsiveness (light activated)
DRun_PN = T.taskType == 'DRun' & T.idxNeurontype == 'PN';
DRun_IN = T.taskType == 'DRun' & T.idxNeurontype == 'IN';
DRun_UNC = T.taskType == 'DRun' & T.idxNeurontype == 'UNC';
alpha = 0.01;

DRun_PN_light = DRun_PN & T.pLR_Track<alpha;
DRun_PN_act = DRun_PN & T.pLR_Track<alpha & T.statDir_Track == 1;
DRun_PN_ina = DRun_PN & T.pLR_Track<alpha & T.statDir_Track == -1;
DRun_PN_no = DRun_PN & T.pLR_Track>=alpha;

%% nCell
nPN_light = sum(double(DRun_PN_light));
nPN_act = sum(double(DRun_PN_act));
nPN_ina = sum(double(DRun_PN_ina));
nPN_no = sum(double(DRun_PN_no));

%% PETH
pethTime = T.pethtimePsdPreD(DRun_PN_light);
xptPETH = pethTime{1};

peth_DRunPN_PRE_light = cell2mat(T.pethPsdPreD(DRun_PN_light));
peth_DRunPN_PRE_act = cell2mat(T.pethPsdPreD(DRun_PN_act));
peth_DRunPN_PRE_ina = cell2mat(T.pethPsdPreD(DRun_PN_ina));
peth_DRunPN_PRE_no = cell2mat(T.pethPsdPreD(DRun_PN_no));

peth_DRunPN_STM_light = cell2mat(T.pethPsdStmD(DRun_PN_light));
peth_DRunPN_STM_act = cell2mat(T.pethPsdStmD(DRun_PN_act));
peth_DRunPN_STM_ina = cell2mat(T.pethPsdStmD(DRun_PN_ina));
peth_DRunPN_STM_no = cell2mat(T.pethPsdStmD(DRun_PN_no));

peth_DRunPN_POST_light = cell2mat(T.pethPsdPostD(DRun_PN_light));
peth_DRunPN_POST_act = cell2mat(T.pethPsdPostD(DRun_PN_act));
peth_DRunPN_POST_ina = cell2mat(T.pethPsdPostD(DRun_PN_ina));
peth_DRunPN_POST_no = cell2mat(T.pethPsdPostD(DRun_PN_no));

%% mean
m_DRunPN_PRE_light = mean(peth_DRunPN_PRE_light,1);
m_DRunPN_PRE_act = mean(peth_DRunPN_PRE_act,1);
m_DRunPN_PRE_ina = mean(peth_DRunPN_PRE_ina,1);
m_DRunPN_PRE_no = mean(peth_DRunPN_PRE_no,1);

m_DRunPN_PRE_light90 = mean(peth_DRunPN_PRE_light,1)*0.9;
m_DRunPN_PRE_act90 = mean(peth_DRunPN_PRE_act,1)*0.9;
m_DRunPN_PRE_ina90 = mean(peth_DRunPN_PRE_ina,1)*0.9;
m_DRunPN_PRE_no90 = mean(peth_DRunPN_PRE_no,1)*0.9;

m_DRunPN_PRE_light110 = mean(peth_DRunPN_PRE_light,1)*1.1;
m_DRunPN_PRE_act110 = mean(peth_DRunPN_PRE_act,1)*1.1;
m_DRunPN_PRE_ina110 = mean(peth_DRunPN_PRE_ina,1)*1.1;
m_DRunPN_PRE_no110 = mean(peth_DRunPN_PRE_no,1)*1.1;

m_DRunPN_STM_light = mean(peth_DRunPN_STM_light,1);
m_DRunPN_STM_act = mean(peth_DRunPN_STM_act,1);
m_DRunPN_STM_ina = mean(peth_DRunPN_STM_ina,1);
m_DRunPN_STM_no = mean(peth_DRunPN_STM_no,1);

m_DRunPN_POST_light = mean(peth_DRunPN_POST_light,1);
m_DRunPN_POST_act = mean(peth_DRunPN_POST_act,1);
m_DRunPN_POST_ina = mean(peth_DRunPN_POST_ina,1);
m_DRunPN_POST_no = mean(peth_DRunPN_POST_no,1);

m_DRunPN_POST_light90 = mean(peth_DRunPN_POST_light,1)*0.9;
m_DRunPN_POST_act90 = mean(peth_DRunPN_POST_act,1)*0.9;
m_DRunPN_POST_ina90 = mean(peth_DRunPN_POST_ina,1)*0.9;
m_DRunPN_POST_no90 = mean(peth_DRunPN_POST_no,1)*0.9;

m_DRunPN_POST_light110 = mean(peth_DRunPN_POST_light,1)*1.1;
m_DRunPN_POST_act110 = mean(peth_DRunPN_POST_act,1)*1.1;
m_DRunPN_POST_ina110 = mean(peth_DRunPN_POST_ina,1)*1.1;
m_DRunPN_POST_no110 = mean(peth_DRunPN_POST_no,1)*1.1;

%% SEM
sem_DRunPN_PRE_light = std(peth_DRunPN_PRE_light,0,1)/sqrt(nPN_light);
sem_DRunPN_PRE_act = std(peth_DRunPN_PRE_act,0,1)/sqrt(nPN_act);
sem_DRunPN_PRE_ina = std(peth_DRunPN_PRE_ina,0,1)/sqrt(nPN_ina);
sem_DRunPN_PRE_no = std(peth_DRunPN_PRE_no,0,1)/sqrt(nPN_no);

sem_DRunPN_STM_light = std(peth_DRunPN_STM_light,0,1)/sqrt(nPN_light);
sem_DRunPN_STM_act = std(peth_DRunPN_STM_act,0,1)/sqrt(nPN_act);
sem_DRunPN_STM_ina = std(peth_DRunPN_STM_ina,0,1)/sqrt(nPN_ina);
sem_DRunPN_STM_no = std(peth_DRunPN_STM_no,0,1)/sqrt(nPN_no);

sem_DRunPN_POST_light = std(peth_DRunPN_POST_light,0,1)/sqrt(nPN_light);
sem_DRunPN_POST_act = std(peth_DRunPN_POST_act,0,1)/sqrt(nPN_act);
sem_DRunPN_POST_ina = std(peth_DRunPN_POST_ina,0,1)/sqrt(nPN_ina);
sem_DRunPN_POST_no = std(peth_DRunPN_POST_no,0,1)/sqrt(nPN_no);

%% t-test
nBin = size(peth_DRunPN_PRE_light,2);
[p_light1, p_act1, p_ina1, p_no1, p_light2, p_act2, p_ina2, p_no2] = deal(zeros(nBin,1));
for iBin = 1:nBin
    [~, p_light1(iBin,1)] = ttest2(peth_DRunPN_PRE_light(:,iBin),peth_DRunPN_STM_light(:,iBin));
    [~, p_act1(iBin,1)] = ttest2(peth_DRunPN_PRE_act(:,iBin),peth_DRunPN_STM_act(:,iBin));
    [~, p_ina1(iBin,1)] = ttest2(peth_DRunPN_PRE_ina(:,iBin),peth_DRunPN_STM_ina(:,iBin));
    [~, p_no1(iBin,1)] = ttest2(peth_DRunPN_PRE_no(:,iBin),peth_DRunPN_STM_no(:,iBin));
    [~, p_light2(iBin,1)] = ttest2(peth_DRunPN_POST_light(:,iBin),peth_DRunPN_STM_light(:,iBin));
    [~, p_act2(iBin,1)] = ttest2(peth_DRunPN_POST_act(:,iBin),peth_DRunPN_STM_act(:,iBin));
    [~, p_ina2(iBin,1)] = ttest2(peth_DRunPN_POST_ina(:,iBin),peth_DRunPN_STM_ina(:,iBin));
    [~, p_no2(iBin,1)] = ttest2(peth_DRunPN_POST_no(:,iBin),peth_DRunPN_STM_no(:,iBin));
end

loci_p_light1 = find(p_light1<0.05)-22.5; % shift to - 22ms
loci_p_act1 = find(p_act1<0.05)-22.5; 
loci_p_ina1 = find(p_ina1<0.05)-22.5;
loci_p_no1 = find(p_no1<0.05)-22.5;

loci_p_light2 = find(p_light2<0.05)-22.5; % shift to - 22ms
loci_p_act2 = find(p_act2<0.05)-22.5; 
loci_p_ina2 = find(p_ina2<0.05)-22.5;
loci_p_no2 = find(p_no2<0.05)-22.5;

%%
fHandle(1) = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});
nCol = 2;
nRow = 4;
xpt = -22:101;
temp_xptFill = repmat(xpt,2,1);
temp2_xptFill = temp_xptFill(:);
xptFill = [temp2_xptFill;flip(temp2_xptFill)];

tempY_lower = repmat(m_DRunPN_PRE_light90(1:124),2,1);
tempY_lower = tempY_lower(:);
tempY_upper = repmat(m_DRunPN_PRE_light110(1:124),2,1);
tempY_upper = tempY_upper(:);
yptFill_PRE_light = [tempY_lower; tempY_upper];

tempY_lower = repmat(m_DRunPN_PRE_act90(1:124),2,1);
tempY_lower = tempY_lower(:);
tempY_upper = repmat(m_DRunPN_PRE_act110(1:124),2,1);
tempY_upper = tempY_upper(:);
yptFill_PRE_act = [tempY_lower; tempY_upper];

tempY_lower = repmat(m_DRunPN_PRE_ina90(1:124),2,1);
tempY_lower = tempY_lower(:);
tempY_upper = repmat(m_DRunPN_PRE_ina110(1:124),2,1);
tempY_upper = tempY_upper(:);
yptFill_PRE_ina = [tempY_lower; tempY_upper];

tempY_lower = repmat(m_DRunPN_PRE_no90(1:124),2,1);
tempY_lower = tempY_lower(:);
tempY_upper = repmat(m_DRunPN_PRE_no110(1:124),2,1);
tempY_upper = tempY_upper(:);
yptFill_PRE_no = [tempY_lower; tempY_upper];

tempY_lower = repmat(m_DRunPN_POST_light90(1:124),2,1);
tempY_lower = tempY_lower(:);
tempY_upper = repmat(m_DRunPN_POST_light110(1:124),2,1);
tempY_upper = tempY_upper(:);
yptFill_POST_light = [tempY_lower; tempY_upper];

tempY_lower = repmat(m_DRunPN_POST_act90(1:124),2,1);
tempY_lower = tempY_lower(:);
tempY_upper = repmat(m_DRunPN_POST_act110(1:124),2,1);
tempY_upper = tempY_upper(:);
yptFill_POST_act = [tempY_lower; tempY_upper];

tempY_lower = repmat(m_DRunPN_POST_ina90(1:124),2,1);
tempY_lower = tempY_lower(:);
tempY_upper = repmat(m_DRunPN_POST_ina110(1:124),2,1);
tempY_upper = tempY_upper(:);
yptFill_POST_ina = [tempY_lower; tempY_upper];

tempY_lower = repmat(m_DRunPN_POST_no90(1:124),2,1);
tempY_lower = tempY_lower(:);
tempY_upper = repmat(m_DRunPN_POST_no110(1:124),2,1);
tempY_upper = tempY_upper(:);
yptFill_POST_no = [tempY_lower; tempY_upper];

hPETH_light(1) = axes('Position',axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval));
% fill(xptFill,yptFill_PRE_light,colorDarkGray,'LineStyle','none','FaceAlpha',0.2);
% stairs(xpt, m_DRunPN_PRE_light90(1:124),'LineStyle',':','color',colorRed);
% [xx, yy] = stairs(xpt,m_DRunPN_PRE_light90(1:124));
% patch([xx],[yy],colorGray);
hold on;
stairs(xpt, m_DRunPN_PRE_light(1:124),'color',colorBlack,'lineWidth',1.2);
hold on;
stairs(xpt, m_DRunPN_STM_light(1:124),'color',colorBlue,'lineWidth',1.2);
hold on;
line(loci_p_light1,28*ones(length(loci_p_light1)),'lineStyle','none','marker','*','markerSize',markerM,'markerEdgeColor',colorRed);
text(80,26,['n = ',num2str(nPN_light)],'fontSize',fontL);
title('PRE vs STM, DRunPN_light','fontSize',fontL,'interpreter','none');
xlabel('Time (ms)','fontSize',fontL);
ylabel('spikes/bin','fontSize',fontL);

hPETH_light(2) = axes('Position',axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
stairs(xpt, m_DRunPN_POST_light(1:124),'color',colorBlack,'lineWidth',1.2);
hold on;
stairs(xpt, m_DRunPN_STM_light(1:124),'color',colorBlue,'lineWidth',1.2);
hold on;
line(loci_p_light2,28*ones(length(loci_p_light2)),'lineStyle','none','marker','*','markerSize',markerM,'markerEdgeColor',colorRed);
title('STM vs POST, DRunPN_light','fontSize',fontL,'interpreter','none');
xlabel('Time (ms)','fontSize',fontL);
ylabel('spikes/bin','fontSize',fontL);

% act
hPETH_act(1) = axes('Position',axpt(nCol,nRow,1,2,[0.1 0.1 0.85 0.85],wideInterval));
stairs(xpt, m_DRunPN_PRE_act110(1:124),'LineStyle','-','color',colorRed);
hold on;
stairs(xpt, m_DRunPN_PRE_act(1:124),'color',colorBlack,'lineWidth',1.2);
hold on;
stairs(xpt, m_DRunPN_STM_act(1:124),'color',colorBlue,'lineWidth',1.2);
hold on;
line(loci_p_act1,26*ones(length(loci_p_act1)),'lineStyle','none','marker','*','markerSize',markerM,'markerEdgeColor',colorRed);
text(80,28,['n = ',num2str(nPN_act)],'fontSize',fontL);
text(80,22,'Black: PRE','color',colorBlack,'fontSize',fontL);
text(80,20,'Blue: STM','color',colorBlue,'fontSize',fontL);
text(80,18,'Red: 110% of PRE','color',colorRed,'fontSize',fontL);
title('PRE vs STM, DRunPN_act','fontSize',fontL,'interpreter','none');
xlabel('Time (ms)','fontSize',fontL);
ylabel('spikes/bin','fontSize',fontL);

hPETH_act(2) = axes('Position',axpt(nCol,nRow,2,2,[0.1 0.1 0.85 0.85],wideInterval));
stairs(xpt, m_DRunPN_POST_act110(1:124),'LineStyle','-','color',colorRed);
hold on;
stairs(xpt, m_DRunPN_POST_act(1:124),'color',colorBlack,'lineWidth',1.2);
hold on;
stairs(xpt, m_DRunPN_STM_act(1:124),'color',colorBlue,'lineWidth',1.2);
hold on;
line(loci_p_act2,28*ones(length(loci_p_act2)),'lineStyle','none','marker','*','markerSize',markerM,'markerEdgeColor',colorRed);
title('STM vs POST, DRunPN_act','fontSize',fontL,'interpreter','none');
xlabel('Time (ms)','fontSize',fontL);
ylabel('spikes/bin','fontSize',fontL);

% ina
hPETH_ina(1) = axes('Position',axpt(nCol,nRow,1,3,[0.1 0.1 0.85 0.85],wideInterval));
stairs(xpt, m_DRunPN_PRE_ina90(1:124),'LineStyle','-','color',colorRed);
hold on;
stairs(xpt, m_DRunPN_PRE_ina(1:124),'color',colorBlack,'lineWidth',1.2);
hold on;
stairs(xpt, m_DRunPN_STM_ina(1:124),'color',colorBlue,'lineWidth',1.2);
hold on;
line(loci_p_ina1,26*ones(length(loci_p_ina1)),'lineStyle','none','marker','*','markerSize',markerM,'markerEdgeColor',colorRed);
text(80,28,['n = ',num2str(nPN_ina)],'fontSize',fontL);
text(80,26,'Black: PRE','color',colorBlack,'fontSize',fontL);
text(80,24,'Blue: STM','color',colorBlue,'fontSize',fontL);
text(80,22,'Red: 90% of PRE','color',colorRed,'fontSize',fontL);
title('PRE vs STM, DRunPN_ina','fontSize',fontL,'interpreter','none');
xlabel('Time (ms)','fontSize',fontL);
ylabel('spikes/bin','fontSize',fontL);

hPETH_ina(2) = axes('Position',axpt(nCol,nRow,2,3,[0.1 0.1 0.85 0.85],wideInterval));
stairs(xpt, m_DRunPN_POST_ina90(1:124),'LineStyle','-','color',colorRed);
hold on;
stairs(xpt, m_DRunPN_POST_ina(1:124),'color',colorBlack,'lineWidth',1.2);
hold on;
stairs(xpt, m_DRunPN_STM_ina(1:124),'color',colorBlue,'lineWidth',1.2);
hold on;
line(loci_p_ina2,28*ones(length(loci_p_ina2)),'lineStyle','none','marker','*','markerSize',markerM,'markerEdgeColor',colorRed);
title('STM vs POST, DRunPN_ina','fontSize',fontL,'interpreter','none');
xlabel('Time (ms)','fontSize',fontL);
ylabel('spikes/bin','fontSize',fontL);

% no
hPETH_no(1) = axes('Position',axpt(nCol,nRow,1,4,[0.1 0.1 0.85 0.85],wideInterval));
stairs(xpt, m_DRunPN_PRE_no(1:124),'color',colorBlack,'lineWidth',1.2);
hold on;
stairs(xpt, m_DRunPN_STM_no(1:124),'color',colorBlue,'lineWidth',1.2);
hold on;
line(loci_p_no1,26*ones(length(loci_p_no1)),'lineStyle','none','marker','*','markerSize',markerM,'markerEdgeColor',colorRed);
text(80,28,['n = ',num2str(nPN_no)],'fontSize',fontL);
title('PRE vs STM, DRunPN_no','fontSize',fontL,'interpreter','none');
xlabel('Time (ms)','fontSize',fontL);
ylabel('spikes/bin','fontSize',fontL);

hPETH_no(2) = axes('Position',axpt(nCol,nRow,2,4,[0.1 0.1 0.85 0.85],wideInterval));
stairs(xpt, m_DRunPN_POST_no(1:124),'color',colorBlack,'lineWidth',1.2);
hold on;
stairs(xpt, m_DRunPN_STM_no(1:124),'color',colorBlue,'lineWidth',1.2);
hold on;
line(loci_p_no2,28*ones(length(loci_p_no2)),'lineStyle','none','marker','*','markerSize',markerM,'markerEdgeColor',colorRed);
title('STM vs POST, DRunPN_no','fontSize',fontL,'interpreter','none');
xlabel('Time (ms)','fontSize',fontL);
ylabel('spikes/bin','fontSize',fontL);

set(hPETH_light,'Box','off','TickDir','out','XLim',[-20,100],'XTick',[-20,0,10,20,30,40,100],'YLim',[0 30],'fontSize',fontL);
set(hPETH_act,'Box','off','TickDir','out','XLim',[-20,100],'XTick',[-20,0,10,20,30,40,100],'YLim',[0 30],'fontSize',fontL);
set(hPETH_ina,'Box','off','TickDir','out','XLim',[-20,100],'XTick',[-20,0,10,20,30,40,100],'YLim',[0 30],'fontSize',fontL);
set(hPETH_no,'Box','off','TickDir','out','XLim',[-20,100],'XTick',[-20,0,10,20,30,40,100],'YLim',[0 30],'fontSize',fontL);

print('-painters','-r300','-dtiff',[datestr(now,formatOut),'_neuralTrace_v3','.tif']);
