clearvars;

cd('D:\Dropbox\SNL\P2_Track'); % win version
% cd('/Users/Jun/Dropbox/SNL/P2_Track'); % mac version
Txls = readtable('neuronList_ori_171018.xlsx');
load('neuronList_ori_171018.mat');
load 'D:\Dropbox\SNL\P2_Track\myParameters.mat';
Txls.latencyIndex = categorical(Txls.latencyIndex);
formatOut = 'yymmdd';

RunPN = T.taskType == 'DRun' & T.idxNeurontype == 'PN';

% inzone
m_lapFrInPRE = cellfun(@(x) x(1),T.m_lapFrInzone); % PRE lap firing rate inzone
m_lapFrInSTM = cellfun(@(x) x(2),T.m_lapFrInzone); % PRE lap firing rate inzone
m_lapFrInPOST = cellfun(@(x) x(3),T.m_lapFrInzone); % PRE lap firing rate inzone

idx_pPRExSTM = cellfun(@(x) x(1,1)<0.05, T.p_ttestFR);  % Find mean firing rate p-value

% threshold condition
idx_inc = m_lapFrInPRE < m_lapFrInSTM;
idx_dec = m_lapFrInPRE > m_lapFrInSTM; % STM block decreased neurons (inactivation)
min_lapFrInPRE = min(m_lapFrInPRE(RunPN & idx_dec & idx_pPRExSTM));
idx_Fr = m_lapFrInPRE>min_lapFrInPRE; % min firing rate that can be detected by inactivation

% fr_Inzone = [m_lapFrInPRE(RunPN & idx_Fr), m_lapFrInSTM(RunPN & idx_Fr), m_lapFrInPOST(RunPN & idx_Fr)];
fr_Inzone = [m_lapFrInPRE(RunPN & idx_Fr), m_lapFrInSTM(RunPN & idx_Fr), m_lapFrInPOST(RunPN & idx_Fr)]./repmat(m_lapFrInPRE(RunPN & idx_Fr),1,3);
nInzone = size(fr_Inzone,1);
m_frInZone = mean(fr_Inzone,1);
sem_frInZone = std(fr_Inzone,0,1)/sqrt(nInzone);

% population change
% popul_inzone_inc_8hz = sum(double(RunPN & idx_Fr & idx_inc & idx_pPRExSTM));
% popul_inzone_dec_8hz = sum(double(RunPN & idx_Fr & idx_dec & idx_pPRExSTM));
% popul_inzone_no_8hz = sum(double(RunPN & idx_Fr & ~idx_pPRExSTM));

% fr_Inzone_act = [m_lapFrInPRE(RunPN & idx_Fr & idx_inc & idx_pPRExSTM), m_lapFrInSTM(RunPN & idx_Fr & idx_inc & idx_pPRExSTM), m_lapFrInPOST(RunPN & idx_Fr & idx_inc & idx_pPRExSTM)]; 
% fr_Inzone_ina = [m_lapFrInPRE(RunPN & idx_Fr & idx_dec & idx_pPRExSTM), m_lapFrInSTM(RunPN & idx_Fr & idx_dec & idx_pPRExSTM), m_lapFrInPOST(RunPN & idx_Fr & idx_dec & idx_pPRExSTM)];
% fr_Inzone_no = [m_lapFrInPRE(RunPN & idx_Fr & ~idx_pPRExSTM), m_lapFrInSTM(RunPN & idx_Fr & ~idx_pPRExSTM), m_lapFrInPOST(RunPN & idx_Fr & ~idx_pPRExSTM)];
fr_Inzone_act = [m_lapFrInPRE(RunPN & idx_Fr & idx_inc & idx_pPRExSTM), m_lapFrInSTM(RunPN & idx_Fr & idx_inc & idx_pPRExSTM), m_lapFrInPOST(RunPN & idx_Fr & idx_inc & idx_pPRExSTM)]./repmat(m_lapFrInPRE(RunPN & idx_Fr & idx_inc & idx_pPRExSTM),1,3); 
fr_Inzone_ina = [m_lapFrInPRE(RunPN & idx_Fr & idx_dec & idx_pPRExSTM), m_lapFrInSTM(RunPN & idx_Fr & idx_dec & idx_pPRExSTM), m_lapFrInPOST(RunPN & idx_Fr & idx_dec & idx_pPRExSTM)]./repmat(m_lapFrInPRE(RunPN & idx_Fr & idx_dec & idx_pPRExSTM),1,3);
fr_Inzone_no = [m_lapFrInPRE(RunPN & idx_Fr & ~idx_pPRExSTM), m_lapFrInSTM(RunPN & idx_Fr & ~idx_pPRExSTM), m_lapFrInPOST(RunPN & idx_Fr & ~idx_pPRExSTM)]./repmat(m_lapFrInPRE(RunPN & idx_Fr & ~idx_pPRExSTM),1,3);


nInzone_act = length(fr_Inzone_act);
nInzone_ina = length(fr_Inzone_ina);
nInzone_no = length(fr_Inzone_no);

group = {'PRE','STIM','POST'};
[p_anova8hzIn,tbl_anova8hzIn,~] = anova1([fr_Inzone(:,1),fr_Inzone(:,2),fr_Inzone(:,3)],group,'off');

%%
nCol = 5;
nRow = 2;

wideInterval = wideInterval;
barWidth = 0.7;
xBar = [1,3,5];

xScatter8hzIn_act = (rand(nInzone_act,1)-0.5)*0.85*barWidth;
xScatter8hzIn_ina = (rand(nInzone_ina,1)-0.5)*0.85*barWidth;
xScatter8hzIn_no = (rand(nInzone_no,1)-0.5)*0.85*barWidth;

eBarWidth = 1;

fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1}); % for journal figure
yLim = [15 15];

%% 8 Hz
hPlot(1) = axes('Position',axpt(nCol,nRow,1:2,1,[0.1 0.1 0.85 0.85],wideInterval));
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
% text(1,yLim(1)*0.9,['FR threshold: ',num2str(min_lapFrInPRE,3),' Hz'],'color',colorRed,'fontSize',fontM);
text(5, yLim(1)*0.8,['n = ',num2str(nInzone)],'fontSize',fontM);
ylabel('Normalized firing rate','fontSize',fontM);
% title('In-zone (DRunPN)','fontSize',fontM,'fontWeight','bold');

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% Rw %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%
RwPN = T.taskType == 'DRw' & T.idxNeurontype == 'PN';

% inzone
m_lapFrInPRE = cellfun(@(x) x(1),T.m_lapFrInzone); % PRE lap firing rate inzone
m_lapFrInSTM = cellfun(@(x) x(2),T.m_lapFrInzone); % PRE lap firing rate inzone
m_lapFrInPOST = cellfun(@(x) x(3),T.m_lapFrInzone); % PRE lap firing rate inzone

idx_pPRExSTM = cellfun(@(x) x(1,1)<0.05, T.p_ttestFR);  % Find mean firing rate p-value

% threshold condition
idx_inc = m_lapFrInPRE < m_lapFrInSTM;
idx_dec = m_lapFrInPRE > m_lapFrInSTM; % STM block decreased neurons (inactivation)
min_lapFrInPRE = min(m_lapFrInPRE(RwPN & idx_dec & idx_pPRExSTM));
idx_Fr = m_lapFrInPRE>min_lapFrInPRE; % min firing rate that can be detected by inactivation

% fr_Inzone = [m_lapFrInPRE(RwPN & idx_Fr), m_lapFrInSTM(RwPN & idx_Fr), m_lapFrInPOST(RwPN & idx_Fr)];
fr_Inzone = [m_lapFrInPRE(RwPN & idx_Fr), m_lapFrInSTM(RwPN & idx_Fr), m_lapFrInPOST(RwPN & idx_Fr)]./repmat(m_lapFrInPRE(RwPN & idx_Fr),1,3);
nInzone = size(fr_Inzone,1);
m_frInZone = mean(fr_Inzone,1);
sem_frInZone = std(fr_Inzone,0,1)/sqrt(nInzone);

% population change
% popul_inzone_inc_8hz = sum(double(RwPN & idx_Fr & idx_inc & idx_pPRExSTM));
% popul_inzone_dec_8hz = sum(double(RwPN & idx_Fr & idx_dec & idx_pPRExSTM));
% popul_inzone_no_8hz = sum(double(RwPN & idx_Fr & ~idx_pPRExSTM));

% fr_Inzone_act = [m_lapFrInPRE(RwPN & idx_Fr & idx_inc & idx_pPRExSTM), m_lapFrInSTM(RwPN & idx_Fr & idx_inc & idx_pPRExSTM), m_lapFrInPOST(RwPN & idx_Fr & idx_inc & idx_pPRExSTM)]; 
% fr_Inzone_ina = [m_lapFrInPRE(RwPN & idx_Fr & idx_dec & idx_pPRExSTM), m_lapFrInSTM(RwPN & idx_Fr & idx_dec & idx_pPRExSTM), m_lapFrInPOST(RwPN & idx_Fr & idx_dec & idx_pPRExSTM)];
% fr_Inzone_no = [m_lapFrInPRE(RwPN & idx_Fr & ~idx_pPRExSTM), m_lapFrInSTM(RwPN & idx_Fr & ~idx_pPRExSTM), m_lapFrInPOST(RwPN & idx_Fr & ~idx_pPRExSTM)];
fr_Inzone_act = [m_lapFrInPRE(RwPN & idx_Fr & idx_inc & idx_pPRExSTM), m_lapFrInSTM(RwPN & idx_Fr & idx_inc & idx_pPRExSTM), m_lapFrInPOST(RwPN & idx_Fr & idx_inc & idx_pPRExSTM)]./repmat(m_lapFrInPRE(RwPN & idx_Fr & idx_inc & idx_pPRExSTM),1,3); 
fr_Inzone_ina = [m_lapFrInPRE(RwPN & idx_Fr & idx_dec & idx_pPRExSTM), m_lapFrInSTM(RwPN & idx_Fr & idx_dec & idx_pPRExSTM), m_lapFrInPOST(RwPN & idx_Fr & idx_dec & idx_pPRExSTM)]./repmat(m_lapFrInPRE(RwPN & idx_Fr & idx_dec & idx_pPRExSTM),1,3);
fr_Inzone_no = [m_lapFrInPRE(RwPN & idx_Fr & ~idx_pPRExSTM), m_lapFrInSTM(RwPN & idx_Fr & ~idx_pPRExSTM), m_lapFrInPOST(RwPN & idx_Fr & ~idx_pPRExSTM)]./repmat(m_lapFrInPRE(RwPN & idx_Fr & ~idx_pPRExSTM),1,3);


nInzone_act = length(fr_Inzone_act);
nInzone_ina = length(fr_Inzone_ina);
nInzone_no = length(fr_Inzone_no);

[p_anova8hzIn,tbl_anova8hzIn,~] = anova1([fr_Inzone(:,1),fr_Inzone(:,2),fr_Inzone(:,3)],group,'off');

%%
xScatter8hzIn_act = (rand(nInzone_act,1)-0.5)*0.85*barWidth;
xScatter8hzIn_ina = (rand(nInzone_ina,1)-0.5)*0.85*barWidth;
xScatter8hzIn_no = (rand(nInzone_no,1)-0.5)*0.85*barWidth;

%% 8 Hz

hPlot(2) = axes('Position',axpt(nCol,nRow,3:4,1,[0.1 0.1 0.85 0.85],wideInterval));
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
% text(1,yLim(1)*0.9,['FR threshold: ',num2str(min_lapFrInPRE,3),' Hz'],'color',colorRed,'fontSize',fontM);
text(5, yLim(2)*0.8,['n = ',num2str(nInzone)],'fontSize',fontM);
ylabel('Normalized firing rate','fontSize',fontM);
% title('In-zone (DRwPN)','fontSize',fontM,'fontWeight','bold');

set(hPlot(1),'YLim',[0,yLim(1)],'YTick',[0:5:yLim(1)]);
set(hPlot(2),'YLim',[0 yLim(2)],'YTick',[0:5:yLim(2)]);
set(hPlot,'TickDir','out','Box','off','TickLength',[0.03 0.03],'fontSize',fontM,'XTickLabel',group,'XLim',[0,6]);

print('-painters','-r300','-dtiff',['f_short_supple5_InOutZone_',datestr(now,formatOut),'.tif']);
print('-painters','-r300','-depsc',['f_short_supple5_InOutZone_',datestr(now,formatOut),'.ai']);
close;