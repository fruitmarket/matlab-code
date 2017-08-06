% 
clearvars;
rtDir = 'D:\Dropbox\SNL\P2_Track';
cd(rtDir);

load myParameters.mat;
load('neuronList_ori_170626.mat');
Txls = readtable('neuronList_ori_170626.xlsx');
Txls.taskType = categorical(Txls.taskType);
formatOut = 'yymmdd';
%% DRun
DRun_PN = T.taskType == 'DRun' & T.idxNeurontype == 'PN';
DRun_IN = T.taskType == 'DRun' & T.idxNeurontype == 'IN';
DRun_UNC = T.taskType == 'DRun' & T.idxNeurontype == 'UNC';

DRun_PF = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField;
DRun_noPF = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField);

DRun_PN_PF_Resp = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxpLR_Track;
DRun_PN_PF_noResp = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & ~T.idxpLR_Track;
DRun_PN_noPF_Resp = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField) & T.idxpLR_Track;
DRun_PN_noPF_noResp = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField) & ~T.idxpLR_Track;

DRun_IN_Resp = T.taskType == 'DRun' & T.idxNeurontype == 'IN' & T.idxpLR_Track;
DRun_IN_noResp = T.taskType == 'DRun' & T.idxNeurontype == 'IN' & ~T.idxpLR_Track;

DRun_UNC_Resp = T.taskType == 'DRun' & T.idxNeurontype == 'UNC' & T.idxpLR_Track;
DRun_UNC_noResp = T.taskType == 'DRun' & T.idxNeurontype == 'UNC' & ~T.idxpLR_Track;

nDRun_PN_PF_Resp = sum(double(DRun_PN_PF_Resp));
nDRun_PN_PF_noResp = sum(double(DRun_PN_PF_noResp));

corr_DRun_PN_PF_Resp = [T.rCorr1D_preXstm(DRun_PN_PF_Resp); T.rCorr1D_preXpost(DRun_PN_PF_Resp); T.rCorr1D_stmXpost(DRun_PN_PF_Resp)];
corr_DRun_PN_PF_noResp = [T.rCorr1D_preXstm(DRun_PN_PF_noResp); T.rCorr1D_preXpost(DRun_PN_PF_noResp); T.rCorr1D_stmXpost(DRun_PN_PF_noResp)];

xpt_DRun_PN_PF_Resp = [ones(nDRun_PN_PF_Resp,1); ones(nDRun_PN_PF_Resp,1)*2; ones(nDRun_PN_PF_Resp,1)*3];
xpt_DRun_PN_PF_noResp = [ones(nDRun_PN_PF_noResp,1); ones(nDRun_PN_PF_noResp,1)*2; ones(nDRun_PN_PF_noResp,1)*3];

% MyScatterBarPlot(corr
% sum(double(DRun_PN))
% sum(double(DRun_IN))
% sum(double(DRun_UNC))
% sum(double(DRun_PF))
% sum(double(DRun_noPF))
% sum(double(DRun_PN_PF_Resp))
% sum(double(DRun_PN_PF_noResp))
% sum(double(DRun_PN_noPF_Resp))
% sum(double(DRun_PN_noPF_noResp))
% 
% sum(double(DRun_IN_Resp))
% sum(double(DRun_IN_noResp))
% 
% sum(double(DRun_UNC_Resp))
% sum(double(DRun_UNC_noResp))

%% noRun
noRun_PN = T.taskType == 'noRun' & T.idxNeurontype == 'PN';
noRun_IN = T.taskType == 'noRun' & T.idxNeurontype == 'IN';
noRun_UNC = T.taskType == 'noRun' & T.idxNeurontype == 'UNC';

noRun_PN_PF = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField;
noRun_PN_noPF = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField);

noRun_PN_PF_Resp = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxpLR_Track;
noRun_PN_PF_noResp = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & ~T.idxpLR_Track;
noRun_PN_noPF_Resp = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField) & T.idxpLR_Track;
noRun_PN_noPF_noResp = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField) & ~T.idxpLR_Track;

noRun_IN_Resp = T.taskType == 'noRun' & T.idxNeurontype == 'IN' & T.idxpLR_Track;
noRun_IN_noResp = T.taskType == 'noRun' & T.idxNeurontype == 'IN' & ~T.idxpLR_Track;

noRun_UNC_Resp = T.taskType == 'noRun' & T.idxNeurontype == 'UNC' & T.idxpLR_Track;
noRun_UNC_noResp = T.taskType == 'noRun' & T.idxNeurontype == 'UNC' & ~T.idxpLR_Track;

nnoRun_PN_PF = sum(double(noRun_PN_PF));

corr_noRun_PN_PF_Resp = [T.rCorr1D_preXstm(noRun_PN_PF); T.rCorr1D_preXpost(noRun_PN_PF); T.rCorr1D_stmXpost(noRun_PN_PF)];

xpt_noRun_PN_PF_Resp = [ones(nnoRun_PN_PF,1); ones(nnoRun_PN_PF,1)*2; ones(nnoRun_PN_PF,1)*3];


% sum(double(noRun_PN))
% sum(double(noRun_IN))
% sum(double(noRun_UNC))
% sum(double(noRun_PF))
% sum(double(noRun_noPF))
% sum(double(noRun_PN_PF_Resp))
% sum(double(noRun_PN_PF_noResp))
% sum(double(noRun_PN_noPF_Resp))
% sum(double(noRun_PN_noPF_noResp))
% 
% sum(double(noRun_IN_Resp))
% sum(double(noRun_IN_noResp))
% 
% sum(double(noRun_UNC_Resp))
% sum(double(noRun_UNC_noResp))

%% DRw
DRw_PN = T.taskType == 'DRw' & T.idxNeurontype == 'PN';
DRw_IN = T.taskType == 'DRw' & T.idxNeurontype == 'IN';
DRw_UNC = T.taskType == 'DRw' & T.idxNeurontype == 'UNC';

DRw_PF = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField;
DRw_noPF = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField);

DRw_PN_PF_Resp = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxpLR_Track;
DRw_PN_PF_noResp = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & ~T.idxpLR_Track;
DRw_PN_noPF_Resp = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField) & T.idxpLR_Track;
DRw_PN_noPF_noResp = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField) & ~T.idxpLR_Track;

DRw_IN_Resp = T.taskType == 'DRw' & T.idxNeurontype == 'IN' & T.idxpLR_Track;
DRw_IN_noResp = T.taskType == 'DRw' & T.idxNeurontype == 'IN' & ~T.idxpLR_Track;

DRw_UNC_Resp = T.taskType == 'DRw' & T.idxNeurontype == 'UNC' & T.idxpLR_Track;
DRw_UNC_noResp = T.taskType == 'DRw' & T.idxNeurontype == 'UNC' & ~T.idxpLR_Track;

nDRw_PN_PF_Resp = sum(double(DRw_PN_PF_Resp));
nDRw_PN_PF_noResp = sum(double(DRw_PN_PF_noResp));

corr_DRw_PN_PF_Resp = [T.rCorr1D_preXstm(DRw_PN_PF_Resp); T.rCorr1D_preXpost(DRw_PN_PF_Resp); T.rCorr1D_stmXpost(DRw_PN_PF_Resp)];
corr_DRw_PN_PF_noResp = [T.rCorr1D_preXstm(DRw_PN_PF_noResp); T.rCorr1D_preXpost(DRw_PN_PF_noResp); T.rCorr1D_stmXpost(DRw_PN_PF_noResp)];

xpt_DRw_PN_PF_Resp = [ones(nDRw_PN_PF_Resp,1); ones(nDRw_PN_PF_Resp,1)*2; ones(nDRw_PN_PF_Resp,1)*3];
xpt_DRw_PN_PF_noResp = [ones(nDRw_PN_PF_noResp,1); ones(nDRw_PN_PF_noResp,1)*2; ones(nDRw_PN_PF_noResp,1)*3];

% sum(double(DRw_PN))
% sum(double(DRw_IN))
% sum(double(DRw_UNC))
% sum(double(DRw_PF))
% sum(double(DRw_noPF))
% sum(double(DRw_PN_PF_Resp))
% sum(double(DRw_PN_PF_noResp))
% sum(double(DRw_PN_noPF_Resp))
% sum(double(DRw_PN_noPF_noResp))
% 
% sum(double(DRw_IN_Resp))
% sum(double(DRw_IN_noResp))
% 
% sum(double(DRw_UNC_Resp))
% sum(double(DRw_UNC_noResp))

%%
noRw_PN = T.taskType == 'noRw' & T.idxNeurontype == 'PN';
noRw_IN = T.taskType == 'noRw' & T.idxNeurontype == 'IN';
noRw_UNC = T.taskType == 'noRw' & T.idxNeurontype == 'UNC';

noRw_PN_PF = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField;
noRw_PN_noPF = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField);

noRw_PN_PF_Resp = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxpLR_Track;
noRw_PN_PF_noResp = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & ~T.idxpLR_Track;
noRw_PN_noPF_Resp = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField) & T.idxpLR_Track;
noRw_PN_noPF_noResp = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField) & ~T.idxpLR_Track;

noRw_IN_Resp = T.taskType == 'noRw' & T.idxNeurontype == 'IN' & T.idxpLR_Track;
noRw_IN_noResp = T.taskType == 'noRw' & T.idxNeurontype == 'IN' & ~T.idxpLR_Track;

noRw_UNC_Resp = T.taskType == 'noRw' & T.idxNeurontype == 'UNC' & T.idxpLR_Track;
noRw_UNC_noResp = T.taskType == 'noRw' & T.idxNeurontype == 'UNC' & ~T.idxpLR_Track;

nnoRw_PN_PF = sum(double(noRw_PN_PF));

corr_noRw_PN_PF_Resp = [T.rCorr1D_preXstm(noRw_PN_PF); T.rCorr1D_preXpost(noRw_PN_PF); T.rCorr1D_stmXpost(noRw_PN_PF)];

xpt_noRw_PN_PF_Resp = [ones(nnoRw_PN_PF,1); ones(nnoRw_PN_PF,1)*2; ones(nnoRw_PN_PF,1)*3];
% sum(double(noRw_PN))
% sum(double(noRw_IN))
% sum(double(noRw_UNC))
% sum(double(noRw_PF))
% sum(double(noRw_noPF))
% sum(double(noRw_PN_PF_Resp))
% sum(double(noRw_PN_PF_noResp))
% sum(double(noRw_PN_noPF_Resp))
% sum(double(noRw_PN_noPF_noResp))
% 
% sum(double(noRw_IN_Resp))
% sum(double(noRw_IN_noResp))
% 
% sum(double(noRw_UNC_Resp))
% sum(double(noRw_UNC_noResp))

%% plot
fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});
nCol = 3;
nRow = 2;
hCorrDRun(1) = axes('Position',axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval));
plot([1,2,3],[T.rCorr1D_preXstm(DRun_PN_PF_Resp), T.rCorr1D_preXpost(DRun_PN_PF_Resp), T.rCorr1D_stmXpost(DRun_PN_PF_Resp)],'lineStyle','-','lineWidth',0.5,'color',colorGray);
hold on;
MyScatterBarPlot(corr_DRun_PN_PF_Resp,xpt_DRun_PN_PF_Resp,0.35,{colorPurple, colorGreen, colorBlue, colorBlack},[]);
title(['DRun_PN_PF_Resp (n = ',num2str(nDRun_PN_PF_Resp),')'],'fontSize',fontM,'interpreter','none','fontWeight','bold');

hCorrDRun(2) = axes('Position',axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],wideInterval));
plot([1,2,3],[T.rCorr1D_preXstm(DRun_PN_PF_noResp), T.rCorr1D_preXpost(DRun_PN_PF_noResp), T.rCorr1D_stmXpost(DRun_PN_PF_noResp)],'lineStyle','-','lineWidth',0.5,'color',colorGray);
hold on;
MyScatterBarPlot(corr_DRun_PN_PF_noResp,xpt_DRun_PN_PF_noResp,0.35,{colorPurple, colorGreen, colorBlue, colorBlack},[]);
title(['DRun_PN_PF_noResp (n = ',num2str(nDRun_PN_PF_noResp),')'],'fontSize',fontM,'interpreter','none','fontWeight','bold');

hCorrDRun(3) = axes('Position',axpt(nCol,nRow,3,1,[0.1 0.1 0.85 0.85],wideInterval));
plot([1,2,3],[T.rCorr1D_preXstm(noRun_PN_PF), T.rCorr1D_preXpost(noRun_PN_PF), T.rCorr1D_stmXpost(noRun_PN_PF)],'lineStyle','-','lineWidth',0.5,'color',colorGray);
hold on;
MyScatterBarPlot(corr_noRun_PN_PF_Resp,xpt_noRun_PN_PF_Resp,0.35,{colorPurple, colorGreen, colorBlue, colorBlack},[]);
title(['noRun_PN_PF (n = ',num2str(nnoRun_PN_PF),')'],'fontSize',fontM,'interpreter','none','fontWeight','bold');

% DRw
hCorrDRw(1) = axes('Position',axpt(nCol,nRow,1,2,[0.1 0.1 0.85 0.85],wideInterval));
plot([1,2,3],[T.rCorr1D_preXstm(DRw_PN_PF_Resp), T.rCorr1D_preXpost(DRw_PN_PF_Resp), T.rCorr1D_stmXpost(DRw_PN_PF_Resp)],'lineStyle','-','lineWidth',0.5,'color',colorGray);
hold on;
MyScatterBarPlot(corr_DRw_PN_PF_Resp,xpt_DRw_PN_PF_Resp,0.35,{colorPurple, colorGreen, colorBlue, colorBlack},[]);
title(['DRw_PN_PF_Resp (n = ',num2str(nDRw_PN_PF_Resp),')'],'fontSize',fontM,'interpreter','none','fontWeight','bold');

hCorrDRw(2) = axes('Position',axpt(nCol,nRow,2,2,[0.1 0.1 0.85 0.85],wideInterval));
plot([1,2,3],[T.rCorr1D_preXstm(DRw_PN_PF_noResp), T.rCorr1D_preXpost(DRw_PN_PF_noResp), T.rCorr1D_stmXpost(DRw_PN_PF_noResp)],'lineStyle','-','lineWidth',0.5,'color',colorGray);
hold on;
MyScatterBarPlot(corr_DRw_PN_PF_noResp,xpt_DRw_PN_PF_noResp,0.35,{colorPurple, colorGreen, colorBlue, colorBlack},[]);
title(['DRw_PN_PF_noResp (n = ',num2str(nDRw_PN_PF_noResp),')'],'fontSize',fontM,'interpreter','none','fontWeight','bold');

hCorrDRw(3) = axes('Position',axpt(nCol,nRow,3,2,[0.1 0.1 0.85 0.85],wideInterval));
plot([1,2,3],[T.rCorr1D_preXstm(noRw_PN_PF), T.rCorr1D_preXpost(noRw_PN_PF), T.rCorr1D_stmXpost(noRw_PN_PF)],'lineStyle','-','lineWidth',0.5,'color',colorGray);
hold on;
MyScatterBarPlot(corr_noRw_PN_PF_Resp,xpt_noRw_PN_PF_Resp,0.35,{colorPurple, colorGreen, colorBlue, colorBlack},[]);
title(['noRw_PN_PF (n = ',num2str(nnoRw_PN_PF),')'],'fontSize',fontM,'interpreter','none','fontWeight','bold');

set(hCorrDRun,'TickDir','out','Box','off','XLim',[0.5,3.5],'YLim',[-0.4 1.2],'XTick',[1,2,3],'XTickLabel',{'preXstm','preXpost','stmXpost'},'fontSize',fontM);
set(hCorrDRw,'TickDir','out','Box','off','XLim',[0.5,3.5],'YLim',[-0.4 1.2],'XTick',[1,2,3],'XTickLabel',{'preXstm','preXpost','stmXpost'},'fontSize',fontM);
print('-painters','-r300','-dtiff',[datestr(now,formatOut),'_plot_cCorrTotal.tif']);