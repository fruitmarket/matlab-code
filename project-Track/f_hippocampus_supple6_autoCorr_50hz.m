clearvars;
cd('E:\Dropbox\SNL\P2_Track');
load('E:\Dropbox\SNL\P2_Track\myParameters.mat');
formatOut = 'yymmdd';

markerS = 1.5;
dotS = 4;
colorGray = [100 100 100]./255;
colorLightGray = [200 200 200]./255;
colorDarkGray = [170 170 170]./255;

load('neuronList_ori50hz_180927.mat');
idx_pPRExSTIM = cellfun(@(x) x(1,1)<0.05, T.p_ttestFR);

m_lapFrInPRE = cellfun(@(x) x(1), T.m_lapFrInzone);
m_lapFrInSTIM = cellfun(@(x) x(2), T.m_lapFrInzone);
idx_inc = m_lapFrInPRE < m_lapFrInSTIM;
idx_dec = m_lapFrInPRE > m_lapFrInSTIM;

%% Run session
RunPN = T.taskType == 'DRun' & T.idxNeurontype == 'PN';
nRunPN = sum(double(RunPN));

Run_act = RunPN & idx_inc & idx_pPRExSTIM;
nRun_act = sum(double(Run_act));
Run_ina = RunPN & idx_dec & idx_pPRExSTIM;
nRun_ina = sum(double(Run_ina));
Run_no = RunPN & ~idx_pPRExSTIM;
nRun_no = sum(double(Run_no));

xptAcorrPRE_Run = T.xpt_acorr_PRE(RunPN);
xptAcorrSTIM_Run = T.xpt_acorr_STIM(RunPN);
xptAcorrPPOST_Run = T.xpt_acorr_POST(RunPN);
xpt = xptAcorrPRE_Run{1}';

temp_histAcorrPRE = cell2mat(cellfun(@(x) x',T.histAcorr_PRE,'UniformOutput',0));
temp_histAcorrSTIM = cell2mat(cellfun(@(x) x',T.histAcorr_STIM,'UniformOutput',0));
temp_histAcorrPOST = cell2mat(cellfun(@(x) x',T.histAcorr_POST,'UniformOutput',0));

histAcorrPRE_Run = temp_histAcorrPRE(RunPN,:);
histAcorrSTIM_Run = temp_histAcorrSTIM(RunPN,:);
histAcorrPOST_Run = temp_histAcorrPOST(RunPN,:);

m_histAcorrPRE_Run = nanmean(histAcorrPRE_Run);
m_histAcorrSTIM_Run = nanmean(histAcorrSTIM_Run);
m_histAcorrPOST_Run = nanmean(histAcorrPOST_Run);

sem_histAcorrPRE_Run = nanstd(histAcorrPRE_Run,0,1)/sqrt(nRunPN);
sem_histAcorrSTIM_Run = nanstd(histAcorrSTIM_Run,0,1)/sqrt(nRunPN);
sem_histAcorrPOST_Run = nanstd(histAcorrPOST_Run,0,1)/sqrt(nRunPN);

% activated
histAcorrSTIM_Run_act = temp_histAcorrSTIM(Run_act,:);
histAcorrSTIM_Run_ina = temp_histAcorrSTIM(Run_ina,:);
histAcorrSTIM_Run_no = temp_histAcorrSTIM(Run_no,:);

m_histAcorrSTIM_Run_act = nanmean(histAcorrSTIM_Run_act);
m_histAcorrSTIM_Run_ina = nanmean(histAcorrSTIM_Run_ina);
m_histAcorrSTIM_Run_no = nanmean(histAcorrSTIM_Run_no);

sem_histAcorrSTIM_Run_act = nanstd(histAcorrSTIM_Run_act,0,1)/sqrt(nRun_act);
sem_histAcorrSTIM_Run_ina = nanstd(histAcorrSTIM_Run_ina,0,1)/sqrt(nRun_ina);
sem_histAcorrSTIM_Run_no = nanstd(histAcorrSTIM_Run_no,0,1)/sqrt(nRun_no);

%% Reward session
RwPN = T.taskType == 'DRw' & T.idxNeurontype == 'PN';
nRwPN = sum(double(RwPN));

Rw_act = RwPN & idx_inc & idx_pPRExSTIM;
nRw_act = sum(double(Rw_act));
Rw_ina = RwPN & idx_dec & idx_pPRExSTIM;
nRw_ina = sum(double(Rw_ina));
Rw_no = RwPN & ~idx_pPRExSTIM;
nRw_no = sum(double(Rw_no));

xptAcorrPRE_Rw = T.xpt_acorr_PRE(RwPN);
xptAcorrSTIM_Rw = T.xpt_acorr_STIM(RwPN);
xptAcorrPPOST_Rw = T.xpt_acorr_POST(RwPN);

temp_histAcorrPRE = cell2mat(cellfun(@(x) x',T.histAcorr_PRE,'UniformOutput',0));
temp_histAcorrSTIM = cell2mat(cellfun(@(x) x',T.histAcorr_STIM,'UniformOutput',0));
temp_histAcorrPOST = cell2mat(cellfun(@(x) x',T.histAcorr_POST,'UniformOutput',0));

histAcorrPRE_Rw = temp_histAcorrPRE(RwPN,:);
histAcorrSTIM_Rw = temp_histAcorrSTIM(RwPN,:);
histAcorrPOST_Rw = temp_histAcorrPOST(RwPN,:);

m_histAcorrPRE_Rw = nanmean(histAcorrPRE_Rw);
m_histAcorrSTIM_Rw = nanmean(histAcorrSTIM_Rw);
m_histAcorrPOST_Rw = nanmean(histAcorrPOST_Rw);

sem_histAcorrPRE_Rw = nanstd(histAcorrPRE_Rw,0,1)/sqrt(nRwPN);
sem_histAcorrSTIM_Rw = nanstd(histAcorrSTIM_Rw,0,1)/sqrt(nRwPN);
sem_histAcorrPOST_Rw = nanstd(histAcorrPOST_Rw,0,1)/sqrt(nRwPN);

% activated
histAcorrSTIM_Rw_act = temp_histAcorrSTIM(Rw_act,:);
histAcorrSTIM_Rw_ina = temp_histAcorrSTIM(Rw_ina,:);
histAcorrSTIM_Rw_no = temp_histAcorrSTIM(Rw_no,:);

m_histAcorrSTIM_Rw_act = nanmean(histAcorrSTIM_Rw_act);
m_histAcorrSTIM_Rw_ina = nanmean(histAcorrSTIM_Rw_ina);
m_histAcorrSTIM_Rw_no = nanmean(histAcorrSTIM_Rw_no);

sem_histAcorrSTIM_Rw_act = nanstd(histAcorrSTIM_Rw_act,0,1)/sqrt(nRw_act);
sem_histAcorrSTIM_Rw_ina = nanstd(histAcorrSTIM_Rw_ina,0,1)/sqrt(nRw_ina);
sem_histAcorrSTIM_Rw_no = nanstd(histAcorrSTIM_Rw_no,0,1)/sqrt(nRw_no);

%% figure
fontM = 8;
nCol = 8;
nRow = 9;
figSize = [0.1 0.05 0.75 0.85];
figSizeIn = [0.12 0.1 0.70 0.80];
midInterval = [0.05 0.07];
spaceSize = [];
fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});

hACorrRun(1) = axes('Position',axpt(nCol,nRow,1:3,1:2,figSize,midInterval));
    patch([xpt,flip(xpt)],[m_histAcorrPRE_Run-sem_histAcorrPRE_Run,flip(m_histAcorrPRE_Run+sem_histAcorrPRE_Run)],colorLightGray,'lineStyle','none');
    hold on;
    plot(xpt,m_histAcorrPRE_Run,'lineStyle','-','color',colorBlack,'lineWidth',0.8);
    text(800,40,['n = ',num2str(nRunPN)],'fontSize',fontM);
    ylabel('Rate (Hz)','fontSize',fontM);
    xlabel('Time (ms)','fontSize',fontM);
    title('Run sessions','fontSize',fontL);
    
hACorrRun(2) = axes('Position',axpt(nCol,nRow,1:3,3:4,figSize,midInterval));
    patch([xpt,flip(xpt)],[m_histAcorrSTIM_Run-sem_histAcorrSTIM_Run,flip(m_histAcorrSTIM_Run+sem_histAcorrSTIM_Run)],colorLightGray,'lineStyle','none');
    hold on;
    plot(xpt,m_histAcorrSTIM_Run,'lineStyle','-','color',colorBlack,'lineWidth',0.8);
    
    ylabel('Rate (Hz)','fontSize',fontM);
    xlabel('Time (ms)','fontSize',fontM);
    
hACorrRun(3) = axes('Position',axpt(nCol,nRow,1:3,5:6,figSize,midInterval));
    patch([xpt,flip(xpt)],[m_histAcorrPOST_Run-sem_histAcorrPOST_Run,flip(m_histAcorrPOST_Run+sem_histAcorrPOST_Run)],colorLightGray,'lineStyle','none');
    hold on;
    plot(xpt,m_histAcorrPOST_Run,'lineStyle','-','color',colorBlack,'lineWidth',0.8);
    
    ylabel('Rate (Hz)','fontSize',fontM);
    xlabel('Time (ms)','fontSize',fontM);
    
set(hACorrRun,'Box','off','TickDir','out','fontSize',fontM,'XLim',[0,1000],'YLim',[0,45],'YTick',[0:10:40],'fontSize',fontM);

hInsetRun(1) = axes('Position',axpt(3,3,2:3,1,axpt(nCol,nRow,2:3,3:4,figSizeIn,wideInterval),wideInterval));
    patch([xpt,flip(xpt)],[m_histAcorrSTIM_Run_act-sem_histAcorrSTIM_Run_act,flip(m_histAcorrSTIM_Run_act+sem_histAcorrSTIM_Run_act)],colorLightGray,'lineStyle','none');
    hold on;
    plot(xpt,m_histAcorrSTIM_Run_act,'lineStyle','-','color',colorBlack,'lineWidth',0.8);
    text(500,28,['Activated / n = ',num2str(nRun_act)],'fontSize',fontM);
%     ylabel('Rate','fontSize',fontM);

hInsetRun(2) = axes('Position',axpt(3,3,2:3,2,axpt(nCol,nRow,2:3,3:4,figSizeIn,wideInterval),wideInterval));
    patch([xpt,flip(xpt)],[m_histAcorrSTIM_Run_ina-sem_histAcorrSTIM_Run_ina,flip(m_histAcorrSTIM_Run_ina+sem_histAcorrSTIM_Run_ina)],colorLightGray,'lineStyle','none');
    hold on;
    plot(xpt,m_histAcorrSTIM_Run_ina,'lineStyle','-','color',colorBlack,'lineWidth',0.8);
    text(500,45,['Inactivated / n = ',num2str(nRun_ina)],'fontSize',fontM);
%     ylabel('Rate','fontSize',fontM);
    
hInsetRun(3) = axes('Position',axpt(3,3,2:3,3,axpt(nCol,nRow,2:3,3:4,figSizeIn,wideInterval),wideInterval));
    patch([xpt,flip(xpt)],[m_histAcorrSTIM_Run_no-sem_histAcorrSTIM_Run_no,flip(m_histAcorrSTIM_Run_no+sem_histAcorrSTIM_Run_no)],colorLightGray,'lineStyle','none');
    hold on;
    plot(xpt,m_histAcorrSTIM_Run_no,'lineStyle','-','color',colorBlack,'lineWidth',0.8);
    text(500,45,['No response / n = ',num2str(nRun_no)],'fontSize',fontM);
%     ylabel('Rate','fontSize',fontM);
%     xlabel('Time (ms)','fontSize',fontM);

set(hInsetRun,'Box','off','TickDir','out','fontSize',fontM,'XLim',[0,1000],'XTick',0:500:1000,'fontSize',fontS+2);
set(hInsetRun(1:2),'XTickLabel',[]);
set(hInsetRun(1),'YLim',[0,30],'YTick',[0,30]);
set(hInsetRun(2:3),'YLim',[0,50],'YTick',[0,50]);

%%
hACorrRw(1) = axes('Position',axpt(nCol,nRow,5:7,1:2,figSize,midInterval));
    patch([xpt,flip(xpt)],[m_histAcorrPRE_Rw-sem_histAcorrPRE_Rw,flip(m_histAcorrPRE_Rw+sem_histAcorrPRE_Rw)],colorLightGray,'lineStyle','none');
    hold on;
    plot(xpt,m_histAcorrPRE_Rw,'lineStyle','-','color',colorBlack,'lineWidth',0.8);
    text(800,40,['n = ',num2str(nRwPN)],'fontSize',fontM);
    ylabel('Rate (Hz)','fontSize',fontM);
    xlabel('Time (ms)','fontSize',fontM);
    title('Rw sessions','fontSize',fontL);
    
hACorrRw(2) = axes('Position',axpt(nCol,nRow,5:7,3:4,figSize,midInterval));
    patch([xpt,flip(xpt)],[m_histAcorrSTIM_Rw-sem_histAcorrSTIM_Rw,flip(m_histAcorrSTIM_Rw+sem_histAcorrSTIM_Rw)],colorLightGray,'lineStyle','none');
    hold on;
    plot(xpt,m_histAcorrSTIM_Rw,'lineStyle','-','color',colorBlack,'lineWidth',0.8);
    
    ylabel('Rate (Hz)','fontSize',fontM);
    xlabel('Time (ms)','fontSize',fontM);
    
hACorrRw(3) = axes('Position',axpt(nCol,nRow,5:7,5:6,figSize,midInterval));
    patch([xpt,flip(xpt)],[m_histAcorrPOST_Rw-sem_histAcorrPOST_Rw,flip(m_histAcorrPOST_Rw+sem_histAcorrPOST_Rw)],colorLightGray,'lineStyle','none');
    hold on;
    plot(xpt,m_histAcorrPOST_Rw,'lineStyle','-','color',colorBlack,'lineWidth',0.8);
    
    ylabel('Rate (Hz)','fontSize',fontM);
    xlabel('Time (ms)','fontSize',fontM);
    
set(hACorrRw,'Box','off','TickDir','out','fontSize',fontM,'XLim',[0,1000],'YLim',[0,45],'YTick',[0:10:40],'fontSize',fontM);

hInsetRw(1) = axes('Position',axpt(3,3,2:3,1,axpt(nCol,nRow,6:7,3:4,figSizeIn,wideInterval),wideInterval));
    patch([xpt,flip(xpt)],[m_histAcorrSTIM_Rw_act-sem_histAcorrSTIM_Rw_act,flip(m_histAcorrSTIM_Rw_act+sem_histAcorrSTIM_Rw_act)],colorLightGray,'lineStyle','none');
    hold on;
    plot(xpt,m_histAcorrSTIM_Rw_act,'lineStyle','-','color',colorBlack,'lineWidth',0.8);
    text(500,28,['Activated / n = ',num2str(nRw_act)],'fontSize',fontM);

hInsetRw(2) = axes('Position',axpt(3,3,2:3,2,axpt(nCol,nRow,6:7,3:4,figSizeIn,wideInterval),wideInterval));
    patch([xpt,flip(xpt)],[m_histAcorrSTIM_Rw_ina-sem_histAcorrSTIM_Rw_ina,flip(m_histAcorrSTIM_Rw_ina+sem_histAcorrSTIM_Rw_ina)],colorLightGray,'lineStyle','none');
    hold on;
    plot(xpt,m_histAcorrSTIM_Rw_ina,'lineStyle','-','color',colorBlack,'lineWidth',0.8);
    text(500,45,['Inactivated / n = ',num2str(nRw_ina)],'fontSize',fontM);
    
hInsetRw(3) = axes('Position',axpt(3,3,2:3,3,axpt(nCol,nRow,6:7,3:4,figSizeIn,wideInterval),wideInterval));
    patch([xpt,flip(xpt)],[m_histAcorrSTIM_Rw_no-sem_histAcorrSTIM_Rw_no,flip(m_histAcorrSTIM_Rw_no+sem_histAcorrSTIM_Rw_no)],colorLightGray,'lineStyle','none');
    hold on;
    plot(xpt,m_histAcorrSTIM_Rw_no,'lineStyle','-','color',colorBlack,'lineWidth',0.8);
    text(500,45,['No response / n = ',num2str(nRw_no)],'fontSize',fontM);

set(hInsetRw,'Box','off','TickDir','out','fontSize',fontM,'XLim',[0,1000],'XTick',0:500:1000,'fontSize',fontS+2);
set(hInsetRw(1:2),'XTickLabel',[]);
set(hInsetRw(1),'YLim',[0,30],'YTick',[0,30]);
set(hInsetRw(2:3),'YLim',[0,50],'YTick',[0,50]);

print('-painters','-r300','-dtiff',['f_hippocampus_sup_autoCor','.tif']);
print('-painters','-r300','-depsc',['f_hippocampus_sup_autoCor','.ai']);
close;