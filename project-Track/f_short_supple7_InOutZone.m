clearvars;

cd('D:\Dropbox\SNL\P2_Track'); % win version
load 'D:\Dropbox\SNL\P2_Track\myParameters.mat';

load('neuronList_ori_171227.mat');
formatOut = 'yymmdd';
markerS = markerS-1;

RunPN = T.taskType == 'DRun' & T.idxNeurontype == 'PN';

% inzone
m_lapFrInPRE = cellfun(@(x) x(1),T.m_lapFrInzone); % PRE lap firing rate inzone
m_lapFrInSTM = cellfun(@(x) x(2),T.m_lapFrInzone); % PRE lap firing rate inzone
m_lapFrInPOST = cellfun(@(x) x(3),T.m_lapFrInzone); % PRE lap firing rate inzone
idx_pPRExSTM = cellfun(@(x) x(1,1)<0.05, T.p_ttestFR);  % Find mean firing rate p-value

% threshold condition
idx_inc = m_lapFrInPRE < m_lapFrInSTM;
idx_dec = m_lapFrInPRE > m_lapFrInSTM; % STM block decreased neurons (inactivation)
min_lapFrInPRE_Run = min(m_lapFrInPRE(RunPN & idx_dec & idx_pPRExSTM));
idx_Fr_Run = m_lapFrInPRE>=min_lapFrInPRE_Run; % min firing rate that can be detected by inactivation

fr_Inzone_Run = [m_lapFrInPRE(RunPN & idx_Fr_Run), m_lapFrInSTM(RunPN & idx_Fr_Run), m_lapFrInPOST(RunPN & idx_Fr_Run)];
nInzone_Run = size(fr_Inzone_Run,1);
m_frInZone_Run = mean(fr_Inzone_Run,1);
sem_frInZone_Run = std(fr_Inzone_Run,0,1)/sqrt(nInzone_Run);

fr_Inzone_act_Run = [m_lapFrInPRE(RunPN & idx_Fr_Run & idx_inc & idx_pPRExSTM), m_lapFrInSTM(RunPN & idx_Fr_Run & idx_inc & idx_pPRExSTM), m_lapFrInPOST(RunPN & idx_Fr_Run & idx_inc & idx_pPRExSTM)]; 
fr_Inzone_ina_Run = [m_lapFrInPRE(RunPN & idx_Fr_Run & idx_dec & idx_pPRExSTM), m_lapFrInSTM(RunPN & idx_Fr_Run & idx_dec & idx_pPRExSTM), m_lapFrInPOST(RunPN & idx_Fr_Run & idx_dec & idx_pPRExSTM)];
fr_Inzone_no_Run = [m_lapFrInPRE(RunPN & idx_Fr_Run & ~idx_pPRExSTM), m_lapFrInSTM(RunPN & idx_Fr_Run & ~idx_pPRExSTM), m_lapFrInPOST(RunPN & idx_Fr_Run & ~idx_pPRExSTM)];

% fr_Inzone = [m_lapFrInPRE(RunPN & idx_Fr), m_lapFrInSTM(RunPN & idx_Fr), m_lapFrInPOST(RunPN & idx_Fr)]./repmat(m_lapFrInPRE(RunPN & idx_Fr),1,3);
% fr_Inzone_act = [m_lapFrInPRE(RunPN & idx_Fr & idx_inc & idx_pPRExSTM), m_lapFrInSTM(RunPN & idx_Fr & idx_inc & idx_pPRExSTM), m_lapFrInPOST(RunPN & idx_Fr & idx_inc & idx_pPRExSTM)]./repmat(m_lapFrInPRE(RunPN & idx_Fr & idx_inc & idx_pPRExSTM),1,3); 
% fr_Inzone_ina = [m_lapFrInPRE(RunPN & idx_Fr & idx_dec & idx_pPRExSTM), m_lapFrInSTM(RunPN & idx_Fr & idx_dec & idx_pPRExSTM), m_lapFrInPOST(RunPN & idx_Fr & idx_dec & idx_pPRExSTM)]./repmat(m_lapFrInPRE(RunPN & idx_Fr & idx_dec & idx_pPRExSTM),1,3);
% fr_Inzone_no = [m_lapFrInPRE(RunPN & idx_Fr & ~idx_pPRExSTM), m_lapFrInSTM(RunPN & idx_Fr & ~idx_pPRExSTM), m_lapFrInPOST(RunPN & idx_Fr & ~idx_pPRExSTM)]./repmat(m_lapFrInPRE(RunPN & idx_Fr & ~idx_pPRExSTM),1,3);

nInzone_act_Run = length(fr_Inzone_act_Run);
nInzone_ina_Run = length(fr_Inzone_ina_Run);
nInzone_no_Run = length(fr_Inzone_no_Run);

% population change
% popul_inzone_inc_8hz = sum(double(RunPN & idx_Fr & idx_inc & idx_pPRExSTM));
% popul_inzone_dec_8hz = sum(double(RunPN & idx_Fr & idx_dec & idx_pPRExSTM));
% popul_inzone_no_8hz = sum(double(RunPN & idx_Fr & ~idx_pPRExSTM));

group = {'PRE','STIM','POST'};
[p_Run, tbl_Run, stats_Run] = friedman(fr_Inzone_Run,1,'off');
% [result_Run(1,1),~,stat] = signrank(fr_Inzone_Run(:,1),fr_Inzone_Run(:,2),'method','approximate');
% [result_Run(2,1),~,stat] = signrank(fr_Inzone_Run(:,1),fr_Inzone_Run(:,3),'method','approximate');
% [result_Run(3,1),~,stat] = signrank(fr_Inzone_Run(:,2),fr_Inzone_Run(:,3),'method','approximate');
% result_Run = result_Run*3;
% result_Run_signT(1,1) = signtest(fr_Inzone_Run(:,1),fr_Inzone_Run(:,2))*3;
% result_Run_signT(2,1) = signtest(fr_Inzone_Run(:,1),fr_Inzone_Run(:,3))*3;
% result_Run_signT(3,1) = signtest(fr_Inzone_Run(:,2),fr_Inzone_Run(:,3))*3;
% result_Run_tukey = multcompare(stats_Run,'display','off');
% result_Run_bonf = multcompare(stats_Run,'display','off','cType','bonferroni');
result_Run_lsd = multcompare(stats_Run,'display','off','cType','lsd');
result_Run = result_Run_lsd(:,end);
%%
nCol = 5;
nRow = 3;

barWidth = 0.7;
xBar = [1,3,5];
eBarWidth = 1;

fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1}); % for journal figure
yLim = [27 15];

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% Rw %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%
RwPN = T.taskType == 'DRw' & T.idxNeurontype == 'PN';

% threshold condition
min_lapFrInPRE_Rw = min(m_lapFrInPRE(RwPN & idx_dec & idx_pPRExSTM));
idx_Fr_Rw = m_lapFrInPRE>=min_lapFrInPRE_Rw; % min firing rate that can be detected by inactivation

fr_Inzone_Rw = [m_lapFrInPRE(RwPN & idx_Fr_Rw), m_lapFrInSTM(RwPN & idx_Fr_Rw), m_lapFrInPOST(RwPN & idx_Fr_Rw)];
nInzone_Rw = size(fr_Inzone_Rw,1);
m_frInZone_Rw = mean(fr_Inzone_Rw,1);
sem_frInZone_Rw = std(fr_Inzone_Rw,0,1)/sqrt(nInzone_Rw);

fr_Inzone_act_Rw = [m_lapFrInPRE(RwPN & idx_Fr_Rw & idx_inc & idx_pPRExSTM), m_lapFrInSTM(RwPN & idx_Fr_Rw & idx_inc & idx_pPRExSTM), m_lapFrInPOST(RwPN & idx_Fr_Rw & idx_inc & idx_pPRExSTM)]; 
fr_Inzone_ina_Rw = [m_lapFrInPRE(RwPN & idx_Fr_Rw & idx_dec & idx_pPRExSTM), m_lapFrInSTM(RwPN & idx_Fr_Rw & idx_dec & idx_pPRExSTM), m_lapFrInPOST(RwPN & idx_Fr_Rw & idx_dec & idx_pPRExSTM)];
fr_Inzone_no_Rw = [m_lapFrInPRE(RwPN & idx_Fr_Rw & ~idx_pPRExSTM), m_lapFrInSTM(RwPN & idx_Fr_Rw & ~idx_pPRExSTM), m_lapFrInPOST(RwPN & idx_Fr_Rw & ~idx_pPRExSTM)];
% fr_Inzone = [m_lapFrInPRE(RwPN & idx_Fr), m_lapFrInSTM(RwPN & idx_Fr), m_lapFrInPOST(RwPN & idx_Fr)]./repmat(m_lapFrInPRE(RwPN & idx_Fr),1,3);
% fr_Inzone_act = [m_lapFrInPRE(RwPN & idx_Fr & idx_inc & idx_pPRExSTM), m_lapFrInSTM(RwPN & idx_Fr & idx_inc & idx_pPRExSTM), m_lapFrInPOST(RwPN & idx_Fr & idx_inc & idx_pPRExSTM)]./repmat(m_lapFrInPRE(RwPN & idx_Fr & idx_inc & idx_pPRExSTM),1,3); 
% fr_Inzone_ina = [m_lapFrInPRE(RwPN & idx_Fr & idx_dec & idx_pPRExSTM), m_lapFrInSTM(RwPN & idx_Fr & idx_dec & idx_pPRExSTM), m_lapFrInPOST(RwPN & idx_Fr & idx_dec & idx_pPRExSTM)]./repmat(m_lapFrInPRE(RwPN & idx_Fr & idx_dec & idx_pPRExSTM),1,3);
% fr_Inzone_no = [m_lapFrInPRE(RwPN & idx_Fr & ~idx_pPRExSTM), m_lapFrInSTM(RwPN & idx_Fr & ~idx_pPRExSTM), m_lapFrInPOST(RwPN & idx_Fr & ~idx_pPRExSTM)]./repmat(m_lapFrInPRE(RwPN & idx_Fr & ~idx_pPRExSTM),1,3);

nInzone_act_Rw = length(fr_Inzone_act_Rw);
nInzone_ina_Rw = length(fr_Inzone_ina_Rw);
nInzone_no_Rw = length(fr_Inzone_no_Rw);

% population change
% popul_inzone_inc_8hz = sum(double(RwPN & idx_Fr & idx_inc & idx_pPRExSTM));
% popul_inzone_dec_8hz = sum(double(RwPN & idx_Fr & idx_dec & idx_pPRExSTM));
% popul_inzone_no_8hz = sum(double(RwPN & idx_Fr & ~idx_pPRExSTM));

[p_Rw, tbl_Rw, stats_Rw] = friedman(fr_Inzone_Rw,1,'off');
% [result_Rw(1,1),~,stat] = signrank(fr_Inzone_Rw(:,1),fr_Inzone_Rw(:,2),'method','approximate');
% [result_Rw(2,1),~,stat] = signrank(fr_Inzone_Rw(:,1),fr_Inzone_Rw(:,3),'method','approximate');
% [result_Rw(3,1),~,stat] = signrank(fr_Inzone_Rw(:,2),fr_Inzone_Rw(:,3),'method','approximate');
% result_Rw = result_Rw*3;
% result_Rw_signT(1,1) = signtest(fr_Inzone_Rw(:,1),fr_Inzone_Rw(:,2))*3;
% result_Rw_signT(2,1) = signtest(fr_Inzone_Rw(:,1),fr_Inzone_Rw(:,3))*3;
% result_Rw_signT(3,1) = signtest(fr_Inzone_Rw(:,2),fr_Inzone_Rw(:,3))*3;
% result_Rw_tukey = multcompare(stats_Rw,'display','off');
% result_Rw_bonf = multcompare(stats_Rw,'display','off','cType','bonferroni');
result_Rw_lsd = multcompare(stats_Rw,'display','off','cType','lsd');
result_Rw = result_Rw_lsd(:,end);
%% 8 Hz
xScatter8hzIn_act = (rand(nInzone_act_Run,1)-0.5)*0.85*barWidth;
xScatter8hzIn_ina = (rand(nInzone_ina_Run,1)-0.5)*0.85*barWidth;
xScatter8hzIn_no = (rand(nInzone_no_Run,1)-0.5)*0.85*barWidth;

hPlot(1) = axes('Position',axpt(nCol,nRow,1:2,1:2,[0.1 0.1 0.85 0.85],wideInterval));
bar(xBar,m_frInZone_Run,'BarWidth',0.6,'LineStyle','-','edgeColor',colorBlack,'FaceColor',colorDarkGray,'lineWidth',1);
hold on;
for iBlock = 1:3
    plot((2*iBlock-1)+xScatter8hzIn_no,fr_Inzone_no_Run(:,iBlock),'LineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorGray,'markerEdgeColor',colorBlack);
    hold on;
    plot((2*iBlock-1)+xScatter8hzIn_act,fr_Inzone_act_Run(:,iBlock),'LineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorRed,'markerEdgeColor',colorBlack);
    hold on;
    plot((2*iBlock-1)+xScatter8hzIn_ina,fr_Inzone_ina_Run(:,iBlock),'LineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorBlue,'markerEdgeColor',colorBlack);
    hold on;
end

for iLine = 1:nInzone_no_Run
    plot([1+xScatter8hzIn_no(iLine),3+xScatter8hzIn_no(iLine),5+xScatter8hzIn_no(iLine)],[fr_Inzone_no_Run(iLine,1), fr_Inzone_no_Run(iLine,2), fr_Inzone_no_Run(iLine,3)],'lineStyle','-','color',colorGray);
    hold on;
end

for iLine = 1:nInzone_act_Run
    plot([1+xScatter8hzIn_act(iLine),3+xScatter8hzIn_act(iLine),5+xScatter8hzIn_act(iLine)],[fr_Inzone_act_Run(iLine,1), fr_Inzone_act_Run(iLine,2), fr_Inzone_act_Run(iLine,3)],'lineStyle','-','color',colorLightRed);
    hold on;
end

for iLine = 1:nInzone_ina_Run
    plot([1+xScatter8hzIn_ina(iLine),3+xScatter8hzIn_ina(iLine),5+xScatter8hzIn_ina(iLine)],[fr_Inzone_ina_Run(iLine,1), fr_Inzone_ina_Run(iLine,2), fr_Inzone_ina_Run(iLine,3)],'lineStyle','-','color',colorLightBlue);
    hold on;
end

errorbarJun(xBar,m_frInZone_Run,sem_frInZone_Run,0.4,eBarWidth,colorBlack);
text(1,-4,['p_all = ',num2str(round(p_Run*10000)/10000)],'fontSize',fontM,'interpreter','none');
text(1,-6,['p_12 = ',num2str(round(result_Run(1,end)*10000)/10000)],'fontSize',fontM,'interpreter','none');
text(1,-8,['p_13 = ',num2str(round(result_Run(2,end)*10000)/10000)],'fontSize',fontM,'interpreter','none');
text(1,-10,['p_23 = ',num2str(round(result_Run(3,end)*10000)/10000)],'fontSize',fontM,'interpreter','none');
text(1,yLim(1)*0.9,['FR threshold: ',num2str(min_lapFrInPRE_Run,3),' Hz'],'color',colorRed,'fontSize',fontM);
text(5, yLim(1)*0.8,['n = ',num2str(nInzone_Run)],'fontSize',fontM);
ylabel('Firing rate (Hz)','fontSize',fontM);

xScatter8hzIn_act = (rand(nInzone_act_Rw,1)-0.5)*0.85*barWidth;
xScatter8hzIn_ina = (rand(nInzone_ina_Rw,1)-0.5)*0.85*barWidth;
xScatter8hzIn_no = (rand(nInzone_no_Rw,1)-0.5)*0.85*barWidth;

hPlot(2) = axes('Position',axpt(nCol,nRow,3:4,1:2,[0.1 0.1 0.85 0.85],wideInterval));
bar(xBar,m_frInZone_Rw,'BarWidth',0.6,'LineStyle','-','edgeColor',colorBlack,'FaceColor',colorDarkGray,'lineWidth',1);
hold on;
for iBlock = 1:3
    plot((2*iBlock-1)+xScatter8hzIn_no,fr_Inzone_no_Rw(:,iBlock),'LineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorGray,'markerEdgeColor',colorBlack);
    hold on;
    plot((2*iBlock-1)+xScatter8hzIn_act,fr_Inzone_act_Rw(:,iBlock),'LineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorRed,'markerEdgeColor',colorBlack);
    hold on;
    plot((2*iBlock-1)+xScatter8hzIn_ina,fr_Inzone_ina_Rw(:,iBlock),'LineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorBlue,'markerEdgeColor',colorBlack);
    hold on;
end

for iLine = 1:nInzone_no_Rw
    plot([1+xScatter8hzIn_no(iLine),3+xScatter8hzIn_no(iLine),5+xScatter8hzIn_no(iLine)],[fr_Inzone_no_Rw(iLine,1), fr_Inzone_no_Rw(iLine,2), fr_Inzone_no_Rw(iLine,3)],'lineStyle','-','color',colorGray);
    hold on;
end

for iLine = 1:nInzone_act_Rw
    plot([1+xScatter8hzIn_act(iLine),3+xScatter8hzIn_act(iLine),5+xScatter8hzIn_act(iLine)],[fr_Inzone_act_Rw(iLine,1), fr_Inzone_act_Rw(iLine,2), fr_Inzone_act_Rw(iLine,3)],'lineStyle','-','color',colorLightRed);
    hold on;
end

for iLine = 1:nInzone_ina_Rw
    plot([1+xScatter8hzIn_ina(iLine),3+xScatter8hzIn_ina(iLine),5+xScatter8hzIn_ina(iLine)],[fr_Inzone_ina_Rw(iLine,1), fr_Inzone_ina_Rw(iLine,2), fr_Inzone_ina_Rw(iLine,3)],'lineStyle','-','color',colorLightBlue);
    hold on;
end

errorbarJun(xBar,m_frInZone_Rw,sem_frInZone_Rw,0.4,eBarWidth,colorBlack);
text(1,-4,['p_all = ',num2str(round(p_Rw*10000)/10000)],'fontSize',fontM,'interpreter','none');
text(1,-6,['p_12 = ',num2str(round(result_Rw(1,end)*10000)/10000)],'fontSize',fontM,'interpreter','none');
text(1,-8,['p_13 = ',num2str(round(result_Rw(2,end)*10000)/10000)],'fontSize',fontM,'interpreter','none');
text(1,-10,['p_23 = ',num2str(round(result_Rw(3,end)*10000)/10000)],'fontSize',fontM,'interpreter','none');
text(1,yLim(2)*0.9,['FR threshold: ',num2str(min_lapFrInPRE_Rw,3),' Hz'],'color',colorRed,'fontSize',fontM);
text(5, yLim(2)*0.8,['n = ',num2str(nInzone_Rw)],'fontSize',fontM);
ylabel('Firing rate (Hz)','fontSize',fontM);

set(hPlot(1),'YLim',[0,yLim(1)],'YTick',[0:5:yLim(1)]);
set(hPlot(2),'YLim',[0 yLim(2)],'YTick',[0:5:yLim(2)]);

set(hPlot,'TickDir','out','Box','off','TickLength',[0.03 0.03],'fontSize',fontM,'XTickLabel',group,'XLim',[0,6]);

% print('-painters','-r300','-dtiff',['f_short_supple5_InOutZone_',datestr(now,formatOut),'.tif']);
% print('-painters','-r300','-depsc',['f_short_supple5_InOutZone_',datestr(now,formatOut),'.ai']);
% close;