clearvars;

cd('D:\Dropbox\SNL\P2_Track'); % win version
% cd('/Users/Jun/Dropbox/SNL/P2_Track'); % mac version
Txls = readtable('neuronList_ori_171018.xlsx');
load('neuronList_ori_171018.mat');
load 'D:\Dropbox\SNL\P2_Track\myParameters.mat';
Txls.latencyIndex = categorical(Txls.latencyIndex);
formatOut = 'yymmdd';

DRunPN = T.taskType == 'DRun' & T.idxNeurontype == 'PN';

% inzone
m_lapFrInPRE = cellfun(@(x) x(1),T.m_lapFrInzone); % PRE lap firing rate inzone
m_lapFrInSTM = cellfun(@(x) x(2),T.m_lapFrInzone); % PRE lap firing rate inzone
m_lapFrInPOST = cellfun(@(x) x(3),T.m_lapFrInzone); % PRE lap firing rate inzone

idx_pPRExSTM = cellfun(@(x) x(1,1)<0.05, T.p_ttestFR);  % Find mean firing rate p-value

% threshold condition
idx_inc = m_lapFrInPRE < m_lapFrInSTM;
idx_dec = m_lapFrInPRE > m_lapFrInSTM; % STM block decreased neurons (inactivation)
min_lapFrInPRE = min(m_lapFrInPRE(DRunPN & idx_dec & idx_pPRExSTM));
idx_Fr = m_lapFrInPRE>min_lapFrInPRE; % min firing rate that can be detected by inactivation

% fr_Inzone = [m_lapFrInPRE(DRunPN & index_Fr), m_lapFrInSTM(DRunPN & index_Fr), m_lapFrInPOST(DRunPN & index_Fr)];
fr_Inzone = [m_lapFrInPRE(DRunPN & idx_Fr), m_lapFrInSTM(DRunPN & idx_Fr), m_lapFrInPOST(DRunPN & idx_Fr)]./repmat(m_lapFrInPRE(DRunPN & idx_Fr),1,3);
nInzone = size(fr_Inzone,1);
m_frInZone = mean(fr_Inzone,1);
sem_frInZone = std(fr_Inzone,0,1)/sqrt(nInzone);

% population change
popul_inzone_inc_8hz = sum(double(DRunPN & idx_Fr & idx_inc & idx_pPRExSTM));
popul_inzone_dec_8hz = sum(double(DRunPN & idx_Fr & idx_dec & idx_pPRExSTM));
popul_inzone_no_8hz = sum(double(DRunPN & idx_Fr & ~idx_pPRExSTM));

fr_Inzone_act = [m_lapFrInPRE(DRunPN & idx_Fr & idx_inc & idx_pPRExSTM), m_lapFrInSTM(DRunPN & idx_Fr & idx_inc & idx_pPRExSTM), m_lapFrInPOST(DRunPN & idx_Fr & idx_inc & idx_pPRExSTM)]./repmat(m_lapFrInPRE(DRunPN & idx_Fr & idx_inc & idx_pPRExSTM),1,3); 
fr_Inzone_ina = [m_lapFrInPRE(DRunPN & idx_Fr & idx_dec & idx_pPRExSTM), m_lapFrInSTM(DRunPN & idx_Fr & idx_dec & idx_pPRExSTM), m_lapFrInPOST(DRunPN & idx_Fr & idx_dec & idx_pPRExSTM)]./repmat(m_lapFrInPRE(DRunPN & idx_Fr & idx_dec & idx_pPRExSTM),1,3);
fr_Inzone_no = [m_lapFrInPRE(DRunPN & idx_Fr & ~idx_pPRExSTM), m_lapFrInSTM(DRunPN & idx_Fr & ~idx_pPRExSTM), m_lapFrInPOST(DRunPN & idx_Fr & ~idx_pPRExSTM)]./repmat(m_lapFrInPRE(DRunPN & idx_Fr & ~idx_pPRExSTM),1,3);

nInzone_act = length(fr_Inzone_act);
nInzone_ina = length(fr_Inzone_ina);
nInzone_no = length(fr_Inzone_no);

% outzone
m_lapFrOutPRE = cellfun(@(x) x(1),T.m_lapFrOutzone); % PRE lap firing rate inzone
m_lapFrOutSTM = cellfun(@(x) x(2),T.m_lapFrOutzone); % PRE lap firing rate inzone
m_lapFrOutPOST = cellfun(@(x) x(3),T.m_lapFrOutzone); % PRE lap firing rate inzone

idx_pPRExSTM = cellfun(@(x) x(1,2)<0.05, T.p_ttestFR);  % Find mean firing rate p-value

% threshold condition
idx_inc = m_lapFrOutPRE < m_lapFrOutSTM;
idx_dec = m_lapFrOutPRE > m_lapFrOutSTM; % STM block decreased neurons (inactivation)
min_lapFrOutPRE = min(m_lapFrOutPRE(DRunPN & idx_dec & idx_pPRExSTM));
idx_Fr = m_lapFrOutPRE>min_lapFrOutPRE; % min firing rate that can be detected by inactivation

% fr_Outzone = [m_lapFrOutPRE(DRunPN & index_Fr), m_lapFrOutSTM(DRunPN & index_Fr), m_lapFrOutPOST(DRunPN & index_Fr)];
fr_Outzone = [m_lapFrOutPRE(DRunPN & idx_Fr), m_lapFrOutSTM(DRunPN & idx_Fr), m_lapFrOutPOST(DRunPN & idx_Fr)]./repmat(m_lapFrOutPRE(DRunPN & idx_Fr),1,3);
nOutzone = size(fr_Outzone,1);
m_frOutZone = mean(fr_Outzone,1);
sem_frOutZone = std(fr_Outzone,0,1)/sqrt(nOutzone);

popul_outzone_inc_8hz = sum(double(DRunPN & idx_Fr & idx_inc & idx_pPRExSTM));
popul_outzone_dec_8hz = sum(double(DRunPN & idx_Fr & idx_dec & idx_pPRExSTM));
popul_outzone_no_8hz = sum(double(DRunPN & idx_Fr & ~idx_pPRExSTM));

fr_Outzone_act = [m_lapFrOutPRE(DRunPN & idx_Fr & idx_inc & idx_pPRExSTM), m_lapFrOutSTM(DRunPN & idx_Fr & idx_inc & idx_pPRExSTM), m_lapFrOutPOST(DRunPN & idx_Fr & idx_inc & idx_pPRExSTM)]./repmat(m_lapFrOutPRE(DRunPN & idx_Fr & idx_inc & idx_pPRExSTM),1,3); 
fr_Outzone_ina = [m_lapFrOutPRE(DRunPN & idx_Fr & idx_dec & idx_pPRExSTM), m_lapFrOutSTM(DRunPN & idx_Fr & idx_dec & idx_pPRExSTM), m_lapFrOutPOST(DRunPN & idx_Fr & idx_dec & idx_pPRExSTM)]./repmat(m_lapFrOutPRE(DRunPN & idx_Fr & idx_dec & idx_pPRExSTM),1,3);
fr_Outzone_no = [m_lapFrOutPRE(DRunPN & idx_Fr & ~idx_pPRExSTM), m_lapFrOutSTM(DRunPN & idx_Fr & ~idx_pPRExSTM), m_lapFrOutPOST(DRunPN & idx_Fr & ~idx_pPRExSTM)]./repmat(m_lapFrOutPRE(DRunPN & idx_Fr & ~idx_pPRExSTM),1,3);

nOutzone_act = length(fr_Outzone_act);
nOutzone_ina = length(fr_Outzone_ina);
nOutzone_no = length(fr_Outzone_no);

group = {'PRE','STM','POST'};
[p_anova8hzIn,tbl_anova8hzIn,~] = anova1([fr_Inzone(:,1),fr_Inzone(:,2),fr_Inzone(:,3)],group,'off');
[p_anova8hzOut,tbl_anova8hzOut,~] = anova1([fr_Outzone(:,1),fr_Outzone(:,2),fr_Outzone(:,3)],group,'off');

a = [popul_inzone_inc_8hz, popul_inzone_dec_8hz, popul_inzone_no_8hz, sum([popul_inzone_inc_8hz, popul_inzone_dec_8hz, popul_inzone_no_8hz])]
b = [popul_inzone_inc_8hz, popul_inzone_dec_8hz, popul_inzone_no_8hz]/sum(a(1:3))*100
c = [popul_outzone_inc_8hz, popul_outzone_dec_8hz, popul_outzone_no_8hz, sum([popul_outzone_inc_8hz, popul_outzone_dec_8hz, popul_outzone_no_8hz])]
d = [popul_outzone_inc_8hz, popul_outzone_dec_8hz, popul_outzone_no_8hz]/sum(c(1:3))*100
%%
nCol = 2;
nRow = 2;

barWidth = 0.7;
xBar = [1,3,5];
% xScatter8hzIn = (rand(nInzone,1)-0.5)*0.85*barWidth;
% xScatter8hzOut = (rand(nOutzone,1)-0.5)*0.85*barWidth;

xScatter8hzIn_act = (rand(nInzone_act,1)-0.5)*0.85*barWidth;
xScatter8hzIn_ina = (rand(nInzone_ina,1)-0.5)*0.85*barWidth;
xScatter8hzIn_no = (rand(nInzone_no,1)-0.5)*0.85*barWidth;

xScatter8hzOut_act = (rand(nOutzone_act,1)-0.5)*0.85*barWidth;
xScatter8hzOut_ina = (rand(nOutzone_ina,1)-0.5)*0.85*barWidth;
xScatter8hzOut_no = (rand(nOutzone_no,1)-0.5)*0.85*barWidth;

eBarWidth = 1;
yLim = [10 10 3 10];
% fHandle = figure('PaperUnits','centimeters','PaperPosition',[0 0 8.5 8]); % original size
fHandle = figure('PaperUnits','centimeters','PaperPosition',[0 0 8.5 14]); % for journal figure

%% 8 Hz
% hPlot(1) = axes('Position',axpt(2,2,1,1,[0.1 0.1 0.85 0.85],wideInterval));
hPlot(1) = axes('Position',axpt(3,2,1:2,1,[0.1 0.1 0.85 0.85],wideInterval));
bar(xBar,m_frInZone,'BarWidth',0.6,'LineStyle','-','edgeColor',colorBlack,'FaceColor',colorDarkGray,'lineWidth',1);
hold on;
line([0 6],[1, 1],'lineStyle',':','color',colorRed);
hold on;
for iBlock = 1:3
    plot((2*iBlock-1)+xScatter8hzIn_no,fr_Inzone_no(:,iBlock),'LineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorGray,'markerEdgeColor',colorBlack);
    hold on;
    plot((2*iBlock-1)+xScatter8hzIn_act,fr_Inzone_act(:,iBlock),'LineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorRed,'markerEdgeColor',colorBlack);
    hold on;
    plot((2*iBlock-1)+xScatter8hzIn_ina,fr_Inzone_ina(:,iBlock),'LineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorBlue,'markerEdgeColor',colorBlack);
    hold on;
end

for iLine = 1:nInzone_no
    plot([1+xScatter8hzIn_no(iLine),3+xScatter8hzIn_no(iLine),5+xScatter8hzIn_no(iLine)],[fr_Inzone_no(iLine,1), fr_Inzone_no(iLine,2), fr_Inzone_no(iLine,3)],'lineStyle','-','color',colorGray);
    hold on;
end

for iLine = 1:nInzone_act
    plot([1+xScatter8hzIn_act(iLine),3+xScatter8hzIn_act(iLine),5+xScatter8hzIn_act(iLine)],[fr_Inzone_act(iLine,1), fr_Inzone_act(iLine,2), fr_Inzone_act(iLine,3)],'lineStyle','-','color',colorLightRed);
    hold on;
end

for iLine = 1:nInzone_ina
    plot([1+xScatter8hzIn_ina(iLine),3+xScatter8hzIn_ina(iLine),5+xScatter8hzIn_ina(iLine)],[fr_Inzone_ina(iLine,1), fr_Inzone_ina(iLine,2), fr_Inzone_ina(iLine,3)],'lineStyle','-','color',colorLightBlue);
    hold on;
end

errorbarJun(xBar,m_frInZone,sem_frInZone,0.4,eBarWidth,colorBlack);
text(1,yLim(1)*0.9,['FR threshold: ',num2str(min_lapFrInPRE,3),' Hz'],'color',colorRed,'fontSize',fontM);
text(5, yLim(1)*0.8,['n = ',num2str(nInzone)],'fontSize',fontM);
ylabel('Normalized firing rate (Hz)','fontSize',fontM);
title('In-zone (DRunPN)','fontSize',fontM,'fontWeight','bold');

% % 8hz Out-zone
% hPlot(2) = axes('Position',axpt(2,2,2,1,[0.1 0.1 0.85 0.85],wideInterval));
% bar(xBar,m_frOutZone,'BarWidth',0.6,'LineStyle','-','edgeColor',colorBlack,'FaceColor',colorDarkGray,'lineWidth',1);
% hold on;
% line([0 6],[1, 1],'lineStyle',':','color',colorRed);
% hold on;
% plot(1+xScatter8hzOut,fr_Outzone(:,1),'LineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorGray,'markerEdgeColor',colorBlack);
% hold on;
% plot(3+xScatter8hzOut,fr_Outzone(:,2),'LineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorGray,'markerEdgeColor',colorBlack);
% hold on;
% plot(5+xScatter8hzOut,fr_Outzone(:,3),'LineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorGray,'markerEdgeColor',colorBlack);
% hold on;
% for iLine = 1:nOutzone
%     plot([1+xScatter8hzOut(iLine),3+xScatter8hzOut(iLine),5+xScatter8hzOut(iLine)],[fr_Outzone(iLine,1), fr_Outzone(iLine,2), fr_Outzone(iLine,3)],'lineStyle','-','color',colorGray);
%     hold on;
% end
% errorbarJun(xBar,m_frOutZone,sem_frOutZone,0.4,eBarWidth,colorBlack);
% text(1,yLim(2)*0.9,['FR threshold: ',num2str(min_lapFrOutPRE,3),' Hz'],'color',colorRed,'fontSize',fontS);
% text(5, yLim(2)*0.8,['n = ',num2str(nOutzone)],'fontSize',fontS);
% ylabel('Normalized firing rate (Hz)','fontSize',fontS);
% title('Out-zone (DRunPN)','fontSize',fontS,'fontWeight','bold');

%% 50 Hz
Txls = readtable('neuronList_ori50hz_171014.xlsx');
load('neuronList_ori50hz_171014.mat');
Txls.latencyIndex = categorical(Txls.latencyIndex);

DRunPN = T.taskType == 'DRun' & T.idxNeurontype == 'PN';

% inzone
m_lapFrInPRE = cellfun(@(x) x(1),T.m_lapFrInzone); % PRE lap firing rate inzone
m_lapFrInSTM = cellfun(@(x) x(2),T.m_lapFrInzone); % PRE lap firing rate inzone
m_lapFrInPOST = cellfun(@(x) x(3),T.m_lapFrInzone); % PRE lap firing rate inzone

idx_pPRExSTM = cellfun(@(x) x(1,1)<0.05, T.p_ttestFR);  % Find mean firing rate p-value

% threshold condition
idx_inc = m_lapFrInPRE < m_lapFrInSTM;
idx_dec = m_lapFrInPRE > m_lapFrInSTM; % STM block decreased neurons (inactivation)
min_lapFrInPRE = min(m_lapFrInPRE(DRunPN & idx_dec & idx_pPRExSTM));
idx_Fr = m_lapFrInPRE>min_lapFrInPRE; % min firing rate that can be detected by inactivation

% fr_Inzone = [m_lapFrInPRE(DRunPN & index_Fr), m_lapFrInSTM(DRunPN & index_Fr), m_lapFrInPOST(DRunPN & index_Fr)];
fr_Inzone = [m_lapFrInPRE(DRunPN & idx_Fr), m_lapFrInSTM(DRunPN & idx_Fr), m_lapFrInPOST(DRunPN & idx_Fr)]./repmat(m_lapFrInPRE(DRunPN & idx_Fr),1,3);
nInzone = size(fr_Inzone,1);
m_frInZone = mean(fr_Inzone,1);
sem_frInZone = std(fr_Inzone,0,1)/sqrt(nInzone);

% population change
popul_inzone_inc_50hz = sum(double(DRunPN & idx_Fr & idx_inc & idx_pPRExSTM));
popul_inzone_dec_50hz = sum(double(DRunPN & idx_Fr & idx_dec & idx_pPRExSTM));
popul_inzone_no_50hz = sum(double(DRunPN & idx_Fr & ~idx_pPRExSTM));

fr_Inzone_act = [m_lapFrInPRE(DRunPN & idx_Fr & idx_inc & idx_pPRExSTM), m_lapFrInSTM(DRunPN & idx_Fr & idx_inc & idx_pPRExSTM), m_lapFrInPOST(DRunPN & idx_Fr & idx_inc & idx_pPRExSTM)]./repmat(m_lapFrInPRE(DRunPN & idx_Fr & idx_inc & idx_pPRExSTM),1,3); 
fr_Inzone_ina = [m_lapFrInPRE(DRunPN & idx_Fr & idx_dec & idx_pPRExSTM), m_lapFrInSTM(DRunPN & idx_Fr & idx_dec & idx_pPRExSTM), m_lapFrInPOST(DRunPN & idx_Fr & idx_dec & idx_pPRExSTM)]./repmat(m_lapFrInPRE(DRunPN & idx_Fr & idx_dec & idx_pPRExSTM),1,3);
fr_Inzone_no = [m_lapFrInPRE(DRunPN & idx_Fr & ~idx_pPRExSTM), m_lapFrInSTM(DRunPN & idx_Fr & ~idx_pPRExSTM), m_lapFrInPOST(DRunPN & idx_Fr & ~idx_pPRExSTM)]./repmat(m_lapFrInPRE(DRunPN & idx_Fr & ~idx_pPRExSTM),1,3);

nInzone_act = length(fr_Inzone_act);
nInzone_ina = length(fr_Inzone_ina);
nInzone_no = length(fr_Inzone_no);

% outzone
m_lapFrOutPRE = cellfun(@(x) x(1),T.m_lapFrOutzone); % PRE lap firing rate inzone
m_lapFrOutSTM = cellfun(@(x) x(2),T.m_lapFrOutzone); % PRE lap firing rate inzone
m_lapFrOutPOST = cellfun(@(x) x(3),T.m_lapFrOutzone); % PRE lap firing rate inzone

idx_pPRExSTM = cellfun(@(x) x(1,2)<0.05, T.p_ttestFR);  % Find mean firing rate p-value

% threshold condition
idx_inc = m_lapFrOutPRE < m_lapFrOutSTM;
idx_dec = m_lapFrOutPRE > m_lapFrOutSTM; % STM block decreased neurons (inactivation)
min_lapFrOutPRE = min(m_lapFrOutPRE(DRunPN & idx_dec & idx_pPRExSTM));
idx_Fr = m_lapFrOutPRE>min_lapFrOutPRE; % min firing rate that can be detected by inactivation

% fr_Outzone = [m_lapFrOutPRE(DRunPN & index_Fr), m_lapFrOutSTM(DRunPN & index_Fr), m_lapFrOutPOST(DRunPN & index_Fr)];
fr_Outzone = [m_lapFrOutPRE(DRunPN & idx_Fr), m_lapFrOutSTM(DRunPN & idx_Fr), m_lapFrOutPOST(DRunPN & idx_Fr)]./repmat(m_lapFrOutPRE(DRunPN & idx_Fr),1,3);
nOutzone = size(fr_Outzone,1);
m_frOutZone = mean(fr_Outzone,1);
sem_frOutZone = std(fr_Outzone,0,1)/sqrt(nOutzone);

% population change
popul_outzone_inc_50hz = sum(double(DRunPN & idx_Fr & idx_inc & idx_pPRExSTM));
popul_outzone_dec_50hz = sum(double(DRunPN & idx_Fr & idx_dec & idx_pPRExSTM));
popul_outzone_no_50hz = sum(double(DRunPN & idx_Fr & ~idx_pPRExSTM));

fr_Outzone_act = [m_lapFrOutPRE(DRunPN & idx_Fr & idx_inc & idx_pPRExSTM), m_lapFrOutSTM(DRunPN & idx_Fr & idx_inc & idx_pPRExSTM), m_lapFrOutPOST(DRunPN & idx_Fr & idx_inc & idx_pPRExSTM)]./repmat(m_lapFrOutPRE(DRunPN & idx_Fr & idx_inc & idx_pPRExSTM),1,3); 
fr_Outzone_ina = [m_lapFrOutPRE(DRunPN & idx_Fr & idx_dec & idx_pPRExSTM), m_lapFrOutSTM(DRunPN & idx_Fr & idx_dec & idx_pPRExSTM), m_lapFrOutPOST(DRunPN & idx_Fr & idx_dec & idx_pPRExSTM)]./repmat(m_lapFrOutPRE(DRunPN & idx_Fr & idx_dec & idx_pPRExSTM),1,3);
fr_Outzone_no = [m_lapFrOutPRE(DRunPN & idx_Fr & ~idx_pPRExSTM), m_lapFrOutSTM(DRunPN & idx_Fr & ~idx_pPRExSTM), m_lapFrOutPOST(DRunPN & idx_Fr & ~idx_pPRExSTM)]./repmat(m_lapFrOutPRE(DRunPN & idx_Fr & ~idx_pPRExSTM),1,3);

nOutzone_act = length(fr_Outzone_act);
nOutzone_ina = length(fr_Outzone_ina);
nOutzone_no = length(fr_Outzone_no);

group = {'PRE','STM','POST'};
[p, tbl_p_kw50hzIn, stats] = kruskalwallis([fr_Inzone(:,1),fr_Inzone(:,2),fr_Inzone(:,3)],group,'off');
result_inSpk = multcompare(stats,'Alpha',0.05,'Display','off');
p_ttest(:,1) = result_inSpk(:,end); % p-value of in-zone
[p_kw50hzOut,tbl_p_kw50hzOut,~] = kruskalwallis([fr_Outzone(:,1),fr_Outzone(:,2),fr_Outzone(:,3)],group,'off');

xScatter50hzIn_act = (rand(nInzone_act,1)-0.5)*0.85*barWidth;
xScatter50hzIn_ina = (rand(nInzone_ina,1)-0.5)*0.85*barWidth;
xScatter50hzIn_no = (rand(nInzone_no,1)-0.5)*0.85*barWidth;

xScatter50hzOut_act = (rand(nOutzone_act,1)-0.5)*0.85*barWidth;
xScatter50hzOut_ina = (rand(nOutzone_ina,1)-0.5)*0.85*barWidth;
xScatter50hzOut_no = (rand(nOutzone_no,1)-0.5)*0.85*barWidth;

e = [popul_inzone_inc_50hz, popul_inzone_dec_50hz, popul_inzone_no_50hz, sum([popul_inzone_inc_50hz, popul_inzone_dec_50hz, popul_inzone_no_50hz])]
f = [popul_inzone_inc_50hz, popul_inzone_dec_50hz, popul_inzone_no_50hz]/sum(e(1:3))*100
g = [popul_outzone_inc_50hz, popul_outzone_dec_50hz, popul_outzone_no_50hz, sum([popul_outzone_inc_50hz, popul_outzone_dec_50hz, popul_outzone_no_50hz])]
h = [popul_outzone_inc_50hz, popul_outzone_dec_50hz, popul_outzone_no_50hz]/sum(g(1:3))*100
%%
% hPlot(3) = axes('Position',axpt(2,2,1,2,[0.1 0.1 0.85 0.85],wideInterval));
hPlot(2) = axes('Position',axpt(3,2,1:2,2,[0.1 0.1 0.85 0.85],wideInterval));
bar(xBar,m_frInZone,'BarWidth',0.6,'LineStyle','-','edgeColor',colorBlack,'FaceColor',colorDarkGray,'lineWidth',1);
hold on;
line([0 6],[1, 1],'lineStyle',':','color',colorRed);
hold on;
for iBlock = 1:3
    plot((2*iBlock-1)+xScatter50hzIn_no,fr_Inzone_no(:,iBlock),'LineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorGray,'markerEdgeColor',colorBlack);
    hold on;
    plot((2*iBlock-1)+xScatter50hzIn_act,fr_Inzone_act(:,iBlock),'LineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorRed,'markerEdgeColor',colorBlack);
    hold on;
    plot((2*iBlock-1)+xScatter50hzIn_ina,fr_Inzone_ina(:,iBlock),'LineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorBlue,'markerEdgeColor',colorBlack);
    hold on;
end

for iLine = 1:nInzone_no
    plot([1+xScatter50hzIn_no(iLine),3+xScatter50hzIn_no(iLine),5+xScatter50hzIn_no(iLine)],[fr_Inzone_no(iLine,1), fr_Inzone_no(iLine,2), fr_Inzone_no(iLine,3)],'lineStyle','-','color',colorGray);
    hold on;
end

for iLine = 1:nInzone_act
    plot([1+xScatter50hzIn_act(iLine),3+xScatter50hzIn_act(iLine),5+xScatter50hzIn_act(iLine)],[fr_Inzone_act(iLine,1), fr_Inzone_act(iLine,2), fr_Inzone_act(iLine,3)],'lineStyle','-','color',colorLightRed);
    hold on;
end

for iLine = 1:nInzone_ina
    plot([1+xScatter50hzIn_ina(iLine),3+xScatter50hzIn_ina(iLine),5+xScatter50hzIn_ina(iLine)],[fr_Inzone_ina(iLine,1), fr_Inzone_ina(iLine,2), fr_Inzone_ina(iLine,3)],'lineStyle','-','color',colorLightBlue);
    hold on;
end

errorbarJun(xBar,m_frInZone,sem_frInZone,0.4,eBarWidth,colorBlack);
text(2,yLim(3)*0.8,['p = ',num2str(round(p_ttest(1)*1000)/1000)],'fontSize',fontM);
text(1,yLim(3)*0.9,['FR threshold: ',num2str(min_lapFrInPRE,3),' Hz'],'color',colorRed,'fontSize',fontM);
text(5, yLim(3)*0.8,['n = ',num2str(nInzone)],'fontSize',fontM);
ylabel('Normalized firing rate (Hz)','fontSize',fontM);
title('In-zone (DRunPN)','fontSize',fontM,'fontWeight','bold');

% % 50hz Out-zone
% hPlot(4) = axes('Position',axpt(2,2,2,2,[0.1 0.1 0.85 0.85],wideInterval));
% bar(xBar,m_frOutZone,'BarWidth',0.6,'LineStyle','-','edgeColor',colorBlack,'FaceColor',colorDarkGray,'lineWidth',1);
% hold on;
% line([0 6],[1, 1],'lineStyle',':','color',colorRed);
% hold on;
% plot(1+xScatter50hzOut,fr_Outzone(:,1),'LineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorGray,'markerEdgeColor',colorBlack);
% hold on;
% plot(3+xScatter50hzOut,fr_Outzone(:,2),'LineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorGray,'markerEdgeColor',colorBlack);
% hold on;
% plot(5+xScatter50hzOut,fr_Outzone(:,3),'LineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorGray,'markerEdgeColor',colorBlack);
% hold on;
% for iLine = 1:nOutzone
%     plot([1+xScatter50hzOut(iLine),3+xScatter50hzOut(iLine),5+xScatter50hzOut(iLine)],[fr_Outzone(iLine,1), fr_Outzone(iLine,2), fr_Outzone(iLine,3)],'lineStyle','-','color',colorGray);
%     hold on;
% end
% errorbarJun(xBar,m_frOutZone,sem_frOutZone,0.4,eBarWidth,colorBlack);
% text(1,yLim(4)*0.9,['FR threshold: ',num2str(min_lapFrOutPRE,3),' Hz'],'color',colorRed,'fontSize',fontS);
% text(5, yLim(4)*0.8,['n = ',num2str(nOutzone)],'fontSize',fontS);
% ylabel('Normalized firing rate (Hz)','fontSize',fontS);
% title('Out-zone (DRunPN)','fontSize',fontS,'fontWeight','bold');

set(hPlot,'Box','off','TickDir','out','XLim',[0,6],'XTick',[1,3,5],'XTickLabel',{'PRE','STM','POST'},'fontSize',fontM);
set(hPlot(1),'YLim',[0,yLim(1)],'YTick',[0:yLim(1)]);
% set(hPlot(2),'YLim',[0,yLim(2)]);
set(hPlot(2),'YLim',[0,yLim(3)],'YTick',[0:yLim(3)]);
% set(hPlot(4),'YLim',[0,yLim(4)]);

print('-painters','-r300','-dtiff',['final_figXX_InOutZone_DRun_v2_norm_jn_',datestr(now,formatOut),'.tif']);
print('-painters','-r300','-depsc',['final_figXX_InOutZone_DRun_v2_norm_jn_',datestr(now,formatOut),'.ai']);
close;