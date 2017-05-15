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

noRunTN = (T.taskType == 'noRun') & condiTN;
noRunPN = noRunTN & condiPN;
noRunIN = noRunTN & condiIN;

noRwTN = (T.taskType == 'noRw') & condiTN;
noRwPN = noRwTN & condiPN;
noRwIN = noRwTN & condiIN;

% Separate light activated inactviated population
DRunPNact = DRunPN & (T.pLR_Track<alpha & T.statDir_Track == 1);
DRunPNina = DRunPN & (T.pLR_Track<alpha & T.statDir_Track == -1);
DRunINact = DRunIN & (T.pLR_Track<alpha & T.statDir_Track == 1);
DRunINina = DRunIN & (T.pLR_Track<alpha & T.statDir_Track == -1);

DRwPNact = DRwPN & (T.pLR_Track<alpha & T.statDir_Track == 1);
DRwPNina = DRwPN & (T.pLR_Track<alpha & T.statDir_Track == -1);
DRwINact = DRwIN & (T.pLR_Track<alpha & T.statDir_Track == 1);
DRwINina = DRwIN & (T.pLR_Track<alpha & T.statDir_Track == -1);

nDRunPN = sum(double(DRunPN));

nDRunPNact = sum(double(DRunPNact));
nDRunPNina = sum(double(DRunPNina));
nDRunINact = sum(double(DRunINact));
nDRunINina = sum(double(DRunINina));

nDRwPNact = sum(double(DRwPNact));
nDRwPNina = sum(double(DRwPNina));
nDRwINact = sum(double(DRwINact));
nDRwINina = sum(double(DRwINina));

m_total_preXstm = nanmean(T.rCorr1D_preXstm(DRunPN));
m_total_preXpost = nanmean(T.rCorr1D_preXpost(DRunPN));
m_total_stmXpost = nanmean(T.rCorr1D_stmXpost(DRunPN));

m_act_preXstm = nanmean(T.rCorr1D_preXstm(DRunPNact));
m_act_preXpost = nanmean(T.rCorr1D_preXpost(DRunPNact));
m_act_stmXpost = nanmean(T.rCorr1D_stmXpost(DRunPNact));

m_ina_preXstm = nanmean(T.rCorr1D_preXstm(DRunPNina));
m_ina_preXpost = nanmean(T.rCorr1D_preXpost(DRunPNina));
m_ina_stmXpost = nanmean(T.rCorr1D_stmXpost(DRunPNina));

sem_total_preXstm = nanstd(T.rCorr1D_preXstm(DRunPN))/sqrt(nDRunPN);
sem_total_preXpost = nanstd(T.rCorr1D_preXpost(DRunPN))/sqrt(nDRunPN);
sem_total_stmXpost = nanstd(T.rCorr1D_stmXpost(DRunPN))/sqrt(nDRunPN);

sem_act_preXstm = nanstd(T.rCorr1D_preXstm(DRunPNact))/sqrt(nDRunPNact);
sem_act_preXpost = nanstd(T.rCorr1D_preXpost(DRunPNact))/sqrt(nDRunPNact);
sem_act_stmXpost = nanstd(T.rCorr1D_stmXpost(DRunPNact))/sqrt(nDRunPNact);

sem_ina_preXstm = nanstd(T.rCorr1D_preXstm(DRunPNina))/sqrt(nDRunPNina);
sem_ina_preXpost = nanstd(T.rCorr1D_preXpost(DRunPNina))/sqrt(nDRunPNina);
sem_ina_stmXpost = nanstd(T.rCorr1D_stmXpost(DRunPNina))/sqrt(nDRunPNina);

[~,p_PN_prestmXprepost] = ttest(T.rCorr1D_preXpost(DRunPN),T.rCorr1D_preXstm(DRunPN));
[~,p_PN_prestmXstmpost] = ttest(T.rCorr1D_preXpost(DRunPN),T.rCorr1D_stmXpost(DRunPN));

[~,p_PNact_prestmXprepost] = ttest(T.rCorr1D_preXpost(DRunPNact),T.rCorr1D_preXstm(DRunPNact));
[~,p_PNact_prestmXstmpost] = ttest(T.rCorr1D_preXpost(DRunPNact),T.rCorr1D_stmXpost(DRunPNact));

[~,p_PNina_prestmXprepost] = ttest(T.rCorr1D_preXpost(DRunPNina),T.rCorr1D_preXstm(DRunPNina));
[~,p_PNina_prestmXstmpost] = ttest(T.rCorr1D_preXpost(DRunPNina),T.rCorr1D_stmXpost(DRunPNina));

a = nanmean(T.rCorr1D_preXstm(noRunPN));
b = nanmean(T.rCorr1D_preXpost(noRunPN));
c = nanmean(T.rCorr1D_stmXpost(noRunPN));
%%
nCol = 2;
nRow = 2;
fHandle = figure('PaperUnits','centimeters','PaperPosition',[0,0,14,20]);
figSize = [0.15 0.15 0.80 0.80];
xpt = [1,3,5];
barLength = 0.4;

hPlot(1) = axes('Position',axpt(nCol,nRow,2,1,axpt(1,1,1,1,figSize,wideInterval),wideInterval));
hBar(1) = bar(xpt,[m_total_preXpost, m_total_preXstm, m_total_stmXpost],'barWidth',0.6,'histc');
hold on;
errorbarJun(xpt+1,[m_total_preXpost, m_total_preXstm, m_total_stmXpost], [sem_total_preXpost, sem_total_preXstm, sem_total_stmXpost],barLength,0.6,colorBlack);
line([2,4],[0.95, 0.95],'color',colorBlack,'lineWidth',lineL);
hold on;
line([2,6],[0.85, 0.85],'color',colorBlack,'lineWidth',lineL);
text(2.95,0.97,'*','color',colorRed,'fontSize',fontL);
text(3.85,0.87,'**','color',colorRed,'fontSize',fontL);
title('DRunPN_total','fontSize',fontL,'interpreter','none');

hPlot(2) = axes('Position',axpt(nCol,nRow,1,2,axpt(1,1,1,1,figSize,wideInterval),wideInterval));
hBar(2) = bar(xpt,[m_act_preXpost, m_act_preXstm, m_act_stmXpost],'barWidth',0.6,'histc');
hold on;
errorbarJun(xpt+1,[m_act_preXpost, m_act_preXstm, m_act_stmXpost], [sem_act_preXpost, sem_act_preXstm, sem_act_stmXpost],barLength,0.6,colorBlack);
line([2,4],[0.9, 0.9],'color',colorBlack,'lineWidth',lineL);
text(2.95,0.92,'*','color',colorRed,'fontSize',fontL);
title('DRunPN_Activated','fontSize',fontL,'interpreter','none');

hPlot(3) = axes('Position',axpt(nCol,nRow,2,2,axpt(1,1,1,1,figSize,wideInterval),wideInterval));
hBar(3) = bar(xpt,[m_ina_preXpost, m_ina_preXstm, m_ina_stmXpost],'barWidth',0.6,'histc');
hold on;
errorbarJun(xpt+1,[m_ina_preXpost, m_ina_preXstm, m_ina_stmXpost], [sem_ina_preXpost, sem_ina_preXstm, sem_ina_stmXpost],barLength,0.6,colorBlack);
title('DRunPN_inactivated','fontSize',fontL,'interpreter','none');

set(hPlot,'Box','off','TickDir','out','XLim',[0,8],'XTick',[2,4,6],'XTickLabel',{'preXpost','preXstm','stmXpost'},'YLim',[0,1],'YTick',[0:0.2:1],'fontSize',fontL);
set(hBar,'FaceColor',colorLightGray);

formatOut = 'yymmdd';
% print('-painters','-r300','-dtiff',['fig4_fieldCrossCorr_',datestr(now,formatOut),'.tif']);
print('-painters','-r300','-depsc',['fig4_fieldCrossCorr_',datestr(now,formatOut),'.ai']);
% close('all')