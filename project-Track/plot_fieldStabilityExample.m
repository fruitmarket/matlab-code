clearvars;
cd('D:\Dropbox\SNL\P2_Track');
Txls = readtable('neuronList_ori_170814.xlsx');
Txls.latencyIndex = categorical(Txls.latencyIndex);
load('neuronList_ori_170814.mat');
load myParameters.mat;

formatOut = 'yymmdd';
cFieldChange = 0.6;  %r-correlation: 0.6 = f-correlation: 0.6931
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%  DRw session %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
actPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == 1;
directPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == 1 & Txls.latencyIndex == 'direct';
indirectPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == 1 & Txls.latencyIndex == 'indirect';
doublePC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == 1 & Txls.latencyIndex == 'double';
inaPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == -1;
norespPC_DRw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxpLR_Track;

ntPC_DRw = sum(double(tPC_DRw));
nactPC_DRw = sum(double(actPC_DRw));
ninaPC_DRw = sum(double(inaPC_DRw));
nnorespPC_DRw = sum(double(norespPC_DRw));

ch_tPC_DRw = tPC_DRw & T.rCorr1D_preXpre>0.6 & (T.rCorr1D_preXstm<0.6 | T.rCorr1D_preXpost<0.6 | T.rCorr1D_stmXpost<0.6);
ch_actPC_DRw = actPC_DRw & T.rCorr1D_preXpre>0.6 & (T.rCorr1D_preXstm<0.6 | T.rCorr1D_preXpost<0.6 | T.rCorr1D_stmXpost<0.6);
ch_inaPC_DRw = inaPC_DRw & T.rCorr1D_preXpre>0.6 & (T.rCorr1D_preXstm<0.6 | T.rCorr1D_preXpost<0.6 | T.rCorr1D_stmXpost<0.6);
ch_norespPC_DRw = norespPC_DRw & T.rCorr1D_preXpre>0.6 & (T.rCorr1D_preXstm<0.6 | T.rCorr1D_preXpost<0.6 | T.rCorr1D_stmXpost<0.6);

unst_ch_tPC_DRw = tPC_DRw & T.rCorr1D_preXpre<=0.6 & (T.rCorr1D_preXstm<0.6 | T.rCorr1D_preXpost<0.6 | T.rCorr1D_stmXpost<0.6);
unst_ch_actPC_DRw = actPC_DRw & T.rCorr1D_preXpre<=0.6 & (T.rCorr1D_preXstm<0.6 | T.rCorr1D_preXpost<0.6 | T.rCorr1D_stmXpost<0.6);
unst_ch_inaPC_DRw = inaPC_DRw & T.rCorr1D_preXpre<=0.6 & (T.rCorr1D_preXstm<0.6 | T.rCorr1D_preXpost<0.6 | T.rCorr1D_stmXpost<0.6);
unst_ch_norespPC_DRw = norespPC_DRw & T.rCorr1D_preXpre<=0.6 & (T.rCorr1D_preXstm<0.6 | T.rCorr1D_preXpost<0.6 | T.rCorr1D_stmXpost<0.6);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% noRw session %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
actPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == 1;
inaPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == -1;
norespPC_noRw = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxpLR_Track;

ntPC_noRw = sum(double(tPC_noRw));
nactPC_noRw = sum(double(actPC_noRw));
ninaPC_noRw = sum(double(inaPC_noRw));
nnorespPC_noRw = sum(double(norespPC_noRw));

ch_tPC_noRw = tPC_noRw & T.rCorr1D_preXpre>0.6 & (T.rCorr1D_preXstm<0.6 | T.rCorr1D_preXpost<0.6 | T.rCorr1D_stmXpost<0.6);
ch_actPC_noRw = actPC_noRw & T.rCorr1D_preXpre>0.6 & (T.rCorr1D_preXstm<0.6 | T.rCorr1D_preXpost<0.6 | T.rCorr1D_stmXpost<0.6);
ch_inaPC_noRw = inaPC_noRw & T.rCorr1D_preXpre>0.6 & (T.rCorr1D_preXstm<0.6 | T.rCorr1D_preXpost<0.6 | T.rCorr1D_stmXpost<0.6);
ch_norespPC_noRw = norespPC_noRw & T.rCorr1D_preXpre>0.6 & (T.rCorr1D_preXstm<0.6 | T.rCorr1D_preXpost<0.6 | T.rCorr1D_stmXpost<0.6);

unst_ch_tPC_noRw = tPC_noRw & T.rCorr1D_preXpre<=0.6 & (T.rCorr1D_preXstm<0.6 | T.rCorr1D_preXpost<0.6 | T.rCorr1D_stmXpost<0.6);
unst_ch_actPC_noRw = actPC_noRw & T.rCorr1D_preXpre<=0.6 & (T.rCorr1D_preXstm<0.6 | T.rCorr1D_preXpost<0.6 | T.rCorr1D_stmXpost<0.6);
unst_ch_inaPC_noRw = inaPC_noRw & T.rCorr1D_preXpre<=0.6 & (T.rCorr1D_preXstm<0.6 | T.rCorr1D_preXpost<0.6 | T.rCorr1D_stmXpost<0.6);
unst_ch_norespPC_noRw = norespPC_noRw & T.rCorr1D_preXpre<=0.6 & (T.rCorr1D_preXstm<0.6 | T.rCorr1D_preXpost<0.6 | T.rCorr1D_stmXpost<0.6);
%% Plot
fileList = T.path(ch_tPC_DRw);
cellID = T.cellID(ch_tPC_DRw);
delete('D:\Dropbox\SNL\P2_Track\analysis_stability\DRw\*.tif')
plot_Track_multi_v3(fileList,cellID,'D:\Dropbox\SNL\P2_Track\analysis_stability\DRw')

fileList = T.path(unst_ch_tPC_DRw);
cellID = T.cellID(unst_ch_tPC_DRw);
delete('D:\Dropbox\SNL\P2_Track\analysis_stability\unst_DRw\*.tif')
plot_Track_multi_v3(fileList,cellID,'D:\Dropbox\SNL\P2_Track\analysis_stability\unst_DRw')

fileList = T.path(ch_tPC_noRw);
cellID = T.cellID(ch_tPC_noRw);
delete('D:\Dropbox\SNL\P2_Track\analysis_stability\noRw\*.tif')
plot_Track_multi_v3(fileList,cellID,'D:\Dropbox\SNL\P2_Track\analysis_stability\noRw')

fileList = T.path(unst_ch_tPC_noRw);
cellID = T.cellID(unst_ch_tPC_noRw);
delete('D:\Dropbox\SNL\P2_Track\analysis_stability\unst_noRw\*.tif')
plot_Track_multi_v3(fileList,cellID,'D:\Dropbox\SNL\P2_Track\analysis_stability\unst_noRw')