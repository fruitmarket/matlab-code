% common part
clearvars;

cd('D:\Dropbox\SNL\P2_Track');
load('neuronList_1stSess_170517.mat');
load myParameters.mat;
T = T1ss;

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

figName = {'gplot_CrossCor_1Dmap_1sess.tif';
            'gplot_CrossCor1Dmap_1sess.tif'};
       
% Separate light activated inactviated population
DRunPNact = DRunPN & (T.pLR_Track<alpha & T.statDir_Track == 1);
DRunPNina = DRunPN & (T.pLR_Track<alpha & T.statDir_Track == -1);
DRunINact = DRunIN & (T.pLR_Track<alpha & T.statDir_Track == 1);
DRunINina = DRunIN & (T.pLR_Track<alpha & T.statDir_Track == -1);

DRwPNact = DRwPN & (T.pLR_Track<alpha & T.statDir_Track == 1);
DRwPNina = DRwPN & (T.pLR_Track<alpha & T.statDir_Track == -1);
DRwINact = DRwIN & (T.pLR_Track<alpha & T.statDir_Track == 1);
DRwINina = DRwIN & (T.pLR_Track<alpha & T.statDir_Track == -1);

nDRunPNact = sum(double(DRunPNact));
nDRunPNina = sum(double(DRunPNina));
nDRunINact = sum(double(DRunINact));
nDRunINina = sum(double(DRunINina));

nDRwPNact = sum(double(DRwPNact));
nDRwPNina = sum(double(DRwPNina));
nDRwINact = sum(double(DRwINact));
nDRwINina = sum(double(DRwINina));

% corr of total neurons
corr_DRunPN = [T.rCorr1D_preXstm(DRunPN); T.rCorr1D_preXpost(DRunPN); T.rCorr1D_stmXpost(DRunPN)];
corr_DRunIN = [T.rCorr1D_preXstm(DRunIN); T.rCorr1D_preXpost(DRunIN); T.rCorr1D_stmXpost(DRunIN)];
corr_DRwPN = [T.rCorr1D_preXstm(DRwPN); T.rCorr1D_preXpost(DRwPN); T.rCorr1D_stmXpost(DRwPN)];
corr_DRwIN = [T.rCorr1D_preXstm(DRwIN); T.rCorr1D_preXpost(DRwIN); T.rCorr1D_stmXpost(DRwIN)];
corr_noRunPN = [T.rCorr1D_preXstm(noRunPN); T.rCorr1D_preXpost(noRunPN); T.rCorr1D_stmXpost(noRunPN)];
corr_noRunIN = [T.rCorr1D_preXstm(noRunIN); T.rCorr1D_preXpost(noRunIN); T.rCorr1D_stmXpost(noRunIN)];
corr_noRwPN = [T.rCorr1D_preXstm(noRwPN); T.rCorr1D_preXpost(noRwPN); T.rCorr1D_stmXpost(noRwPN)];
corr_noRwIN = [T.rCorr1D_preXstm(noRwIN); T.rCorr1D_preXpost(noRwIN); T.rCorr1D_stmXpost(noRwIN)];

xpt_DRunPN = [ones(sum(double(DRunPN)),1); ones(sum(double(DRunPN)),1)*2; ones(sum(double(DRunPN)),1)*3];
xpt_DRunIN = [ones(sum(double(DRunIN)),1); ones(sum(double(DRunIN)),1)*2; ones(sum(double(DRunIN)),1)*3];
xpt_DRwPN = [ones(sum(double(DRwPN)),1); ones(sum(double(DRwPN)),1)*2; ones(sum(double(DRwPN)),1)*3];
xpt_DRwIN = [ones(sum(double(DRwIN)),1); ones(sum(double(DRwIN)),1)*2; ones(sum(double(DRwIN)),1)*3];
xpt_noRunPN = [ones(sum(double(noRunPN)),1); ones(sum(double(noRunPN)),1)*2; ones(sum(double(noRunPN)),1)*3];
xpt_noRunIN = [ones(sum(double(noRunIN)),1); ones(sum(double(noRunIN)),1)*2; ones(sum(double(noRunIN)),1)*3];
xpt_noRwPN = [ones(sum(double(noRwPN)),1); ones(sum(double(noRwPN)),1)*2; ones(sum(double(noRwPN)),1)*3];
xpt_noRwIN = [ones(sum(double(noRwIN)),1); ones(sum(double(noRwIN)),1)*2; ones(sum(double(noRwIN)),1)*3];

% corr of light responsive neurons
corr_DRunPNact = [T.rCorr1D_preXstm(DRunPNact); T.rCorr1D_preXpost(DRunPNact); T.rCorr1D_stmXpost(DRunPNact)];
corr_DRunPNina = [T.rCorr1D_preXstm(DRunPNina); T.rCorr1D_preXpost(DRunPNina); T.rCorr1D_stmXpost(DRunPNina)];
corr_DRunINact = [T.rCorr1D_preXstm(DRunINact); T.rCorr1D_preXpost(DRunINact); T.rCorr1D_stmXpost(DRunINact)];
corr_DRunINina = [T.rCorr1D_preXstm(DRunINina); T.rCorr1D_preXpost(DRunINina); T.rCorr1D_stmXpost(DRunINina)];

corr_DRwPNact = [T.rCorr1D_preXstm(DRwPNact); T.rCorr1D_preXpost(DRwPNact); T.rCorr1D_stmXpost(DRwPNact)];
corr_DRwPNina = [T.rCorr1D_preXstm(DRwPNina); T.rCorr1D_preXpost(DRwPNina); T.rCorr1D_stmXpost(DRwPNina)];
corr_DRwINact = [T.rCorr1D_preXstm(DRwINact); T.rCorr1D_preXpost(DRwINact); T.rCorr1D_stmXpost(DRwINact)];
corr_DRwINina = [T.rCorr1D_preXstm(DRwINina); T.rCorr1D_preXpost(DRwINina); T.rCorr1D_stmXpost(DRwINina)];

xpt_DRunPNact = [ones(nDRunPNact,1);ones(nDRunPNact,1)*2;ones(nDRunPNact,1)*3];
xpt_DRunPNina = [ones(nDRunPNina,1);ones(nDRunPNina,1)*2;ones(nDRunPNina,1)*3];
xpt_DRunINact = [ones(nDRunINact,1);ones(nDRunINact,1)*2;ones(nDRunINact,1)*3];
xpt_DRunINina = [ones(nDRunINina,1);ones(nDRunINina,1)*2;ones(nDRunINina,1)*3];

xpt_DRwPNact = [ones(nDRwPNact,1);ones(nDRwPNact,1)*2;ones(nDRwPNact,1)*3];
xpt_DRwPNina = [ones(nDRwPNina,1);ones(nDRwPNina,1)*2;ones(nDRwPNina,1)*3];
xpt_DRwINact = [ones(nDRwINact,1);ones(nDRwINact,1)*2;ones(nDRwINact,1)*3];
xpt_DRwINina = [ones(nDRwINina,1);ones(nDRwINina,1)*2;ones(nDRwINina,1)*3];

%%
nCol = 2;
nRow = 2;
fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{2},'Name','Light responsive population');

hTotalCorr(1) = axes('Position',axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval));
plot([1,2,3],[T.rCorr1D_preXstm(DRunPN), T.rCorr1D_preXpost(DRunPN), T.rCorr1D_stmXpost(DRunPN)],'lineStyle','-','lineWidth',0.5,'color',colorGray);
hold on;
MyScatterBarPlot(corr_DRunPN,xpt_DRunPN,0.35,{colorPurple,colorGreen,colorBlue,colorBlack},[]);
title('Stimulation during running zone [total PN]','fontSize',fontM,'fontWeight','bold');
text(3.5,0.5,['n = ',num2str(sum(double(DRunPN)))],'fontSize',fontM);

hTotalCorr(2) = axes('Position',axpt(nCol,nRow,1,2,[0.1 0.1 0.85 0.85],wideInterval));
plot([1,2,3],[T.rCorr1D_preXstm(DRunIN), T.rCorr1D_preXpost(DRunIN), T.rCorr1D_stmXpost(DRunIN)],'lineStyle','-','lineWidth',0.5,'color',colorGray);
hold on;
MyScatterBarPlot(corr_DRunIN,xpt_DRunIN,0.35,{colorPurple,colorGreen,colorBlue,colorBlack},[]);
title('Stimulation during running zone [total IN]','fontSize',fontM,'fontWeight','bold');
text(3.5,0.5,['n = ',num2str(sum(double(DRunIN)))],'fontSize',fontM);

hTotalCorr(3) = axes('Position',axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],wideInterval));
plot([1,2,3],[T.rCorr1D_preXstm(DRwPN), T.rCorr1D_preXpost(DRwPN), T.rCorr1D_stmXpost(DRwPN)],'lineStyle','-','lineWidth',0.5,'color',colorGray);
hold on;
MyScatterBarPlot(corr_DRwPN,xpt_DRwPN,0.35,{colorPurple,colorGreen,colorBlue,colorBlack},[]);
title('Stimulation during reward zone [total PN]','fontSize',fontM,'fontWeight','bold');
text(3.5,0.5,['n = ',num2str(sum(double(DRwPN)))],'fontSize',fontM);

hTotalCorr(4) = axes('Position',axpt(nCol,nRow,2,2,[0.1 0.1 0.85 0.85],wideInterval));
plot([1,2,3],[T.rCorr1D_preXstm(DRwIN), T.rCorr1D_preXpost(DRwIN), T.rCorr1D_stmXpost(DRwIN)],'lineStyle','-','lineWidth',0.5,'color',colorGray);
hold on;
MyScatterBarPlot(corr_DRwIN,xpt_DRwIN,0.35,{colorPurple,colorGreen,colorBlue,colorBlack},[]);
title('Stimulation during reward zone [total IN]','fontSize',fontM,'fontWeight','bold');
text(3.5,0.5,['n = ',num2str(sum(double(DRwIN)))],'fontSize',fontM);

set(hTotalCorr,'TickDir','out','Box','off','XLim',[0.5,3.5],'YLim',[-0.4 1.2],'XTick',[1,2,3],'XTickLabel',[{'preXstm','preXpost','stmXpost' }],'fontSize',fontM);
print('-painters','-r300',figName{1},'-dtiff');

%% Plot
nCol = 4;
nRow = 2;
fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{2},'Name','Light responsive population');

hCorr(1) = axes('Position',axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval));
plot([1,2,3],[T.rCorr1D_preXstm(DRunPNact), T.rCorr1D_preXpost(DRunPNact), T.rCorr1D_stmXpost(DRunPNact)],'lineStyle','-','lineWidth',0.5,'color',colorGray);
hold on;
MyScatterBarPlot(corr_DRunPNact,xpt_DRunPNact,0.35,{colorPurple,colorGreen,colorBlue,colorBlack},[]);
title('Stimulation during running zone [light activated PN]','fontSize',fontM,'fontWeight','bold');
text(3.5, 0.5,['n = ',num2str(nDRunPNact)],'fontSize',fontM);

% hCorr(2) = axes('Position',axpt(nCol,nRow,1,2,[0.1 0.1 0.85 0.85],wideInterval));
% plot([1,2,3],[T.rCorr1D_preXstm(DRunPNina), T.rCorr1D_preXpost(DRunPNina), T.rCorr1D_stmXpost(DRunPNina)],'lineStyle','-','lineWidth',0.5,'color',colorGray);
% hold on;
% MyScatterBarPlot(corr_DRunPNina,xpt_DRunPNina,0.35,{colorPurple,colorGreen,colorBlue,colorBlack},[]);
% title('Stimulation during running zone [light inactivated PN]','fontSize',fontM,'fontWeight','bold');
% text(3.5, 0.5,['n = ',num2str(nDRunPNina)],'fontSize',fontM);

hCorr(2) = axes('Position',axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],wideInterval));
plot([1,2,3],[T.rCorr1D_preXstm(DRunINact), T.rCorr1D_preXpost(DRunINact), T.rCorr1D_stmXpost(DRunINact)],'lineStyle','-','lineWidth',0.5,'color',colorGray);
hold on;
MyScatterBarPlot(corr_DRunINact,xpt_DRunINact,0.35,{colorPurple,colorGreen,colorBlue,colorBlack},[]);
title('Stimulation during running zone [light activated IN]','fontSize',fontM,'fontWeight','bold');
text(3.5, 0.5,['n = ',num2str(nDRunINact)],'fontSize',fontM);

% hCorr(4) = axes('Position',axpt(nCol,nRow,2,2,[0.1 0.1 0.85 0.85],wideInterval));
% plot([1,2,3],[T.rCorr1D_preXstm(DRunINina), T.rCorr1D_preXpost(DRunINina), T.rCorr1D_stmXpost(DRunINina)],'lineStyle','-','lineWidth',0.5,'color',colorGray);
% hold on;
% MyScatterBarPlot(corr_DRunINina,xpt_DRunINina,0.35,{colorPurple,colorGreen,colorBlue,colorBlack},[]);
% title('Stimulation during running zone [light inactivated IN]','fontSize',fontM,'fontWeight','bold');
% text(3.5, 0.5,['n = ',num2str(nDRunINina)],'fontSize',fontM);

hCorr(3) = axes('Position',axpt(nCol,nRow,3,1,[0.1 0.1 0.85 0.85],wideInterval));
plot([1,2,3],[T.rCorr1D_preXstm(DRwPNact), T.rCorr1D_preXpost(DRwPNact), T.rCorr1D_stmXpost(DRwPNact)],'lineStyle','-','lineWidth',0.5,'color',colorGray);
hold on;
MyScatterBarPlot(corr_DRwPNact,xpt_DRwPNact,0.35,{colorPurple,colorGreen,colorBlue,colorBlack},[]);
title('Stimulation during reward zone [light activated PN]','fontSize',fontM,'fontWeight','bold');
text(3.5, 0.5,['n = ',num2str(nDRwPNact)],'fontSize',fontM);

hCorr(4) = axes('Position',axpt(nCol,nRow,3,2,[0.1 0.1 0.85 0.85],wideInterval));
plot([1,2,3],[T.rCorr1D_preXstm(DRwPNina), T.rCorr1D_preXpost(DRwPNina), T.rCorr1D_stmXpost(DRwPNina)],'lineStyle','-','lineWidth',0.5,'color',colorGray);
hold on;
MyScatterBarPlot(corr_DRwPNina,xpt_DRwPNina,0.35,{colorPurple,colorGreen,colorBlue,colorBlack},[]);
title('Stimulation during reward zone [light inactivated PN]','fontSize',fontM,'fontWeight','bold');
text(3.5, 0.5,['n = ',num2str(nDRwPNina)],'fontSize',fontM);

hCorr(5) = axes('Position',axpt(nCol,nRow,4,1,[0.1 0.1 0.85 0.85],wideInterval));
plot([1,2,3],[T.rCorr1D_preXstm(DRwINact), T.rCorr1D_preXpost(DRwINact), T.rCorr1D_stmXpost(DRwINact)],'lineStyle','-','lineWidth',0.5,'color',colorGray);
hold on;
MyScatterBarPlot(corr_DRwINact,xpt_DRwINact,0.35,{colorPurple,colorGreen,colorBlue,colorBlack},[]);
title('Stimulation during reward zone [light activated IN]','fontSize',fontM,'fontWeight','bold');
text(3.5, 0.5,['n = ',num2str(nDRwINact)],'fontSize',fontM);

hCorr(6) = axes('Position',axpt(nCol,nRow,4,2,[0.1 0.1 0.85 0.85],wideInterval));
plot([1,2,3],[T.rCorr1D_preXstm(DRwINina), T.rCorr1D_preXpost(DRwINina), T.rCorr1D_stmXpost(DRwINina)],'lineStyle','-','lineWidth',0.5,'color',colorGray);
hold on;
MyScatterBarPlot(corr_DRwINina,xpt_DRwINina,0.35,{colorPurple,colorGreen,colorBlue,colorBlack},[]);
title('Stimulation during reward zone [light inactivated IN]','fontSize',fontM,'fontWeight','bold');
text(3.5, 0.5,['n = ',num2str(nDRwINina)],'fontSize',fontM);

set(hCorr,'TickDir','out','Box','off','XLim',[0.5,3.5],'YLim',[-0.4 1.2],'XTick',[1,2,3],'XTickLabel',[{'preXstm','preXpost','stmXpost' }],'fontSize',fontM);
print('-painters','-r300',figName{2},'-dtiff');
% close('all')