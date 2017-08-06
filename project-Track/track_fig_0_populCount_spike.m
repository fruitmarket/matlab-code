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

DRun_PF_In = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & (T.idxSpikeIn & ~T.idxSpikeOut);
DRun_PF_Out = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & (~T.idxSpikeIn & T.idxSpikeOut);
DRun_PF_InOut = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & (T.idxSpikeIn & T.idxSpikeOut);
DRun_PF_None = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & ~(T.idxSpikeIn | T.idxSpikeOut);

DRun_noPF_In = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField) & (T.idxSpikeIn & ~T.idxSpikeOut);
DRun_noPF_Out = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField) & (~T.idxSpikeIn & T.idxSpikeOut);
DRun_noPF_InOut = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField) & (T.idxSpikeIn & T.idxSpikeOut);
DRun_noPF_None = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField) & ~(T.idxSpikeIn | T.idxSpikeOut);

DRun_IN_In = T.taskType == 'DRun' & T.idxNeurontype == 'IN' & (T.idxSpikeIn & ~T.idxSpikeOut);
DRun_IN_Out = T.taskType == 'DRun' & T.idxNeurontype == 'IN' & (~T.idxSpikeIn & T.idxSpikeOut);
DRun_IN_InOut = T.taskType == 'DRun' & T.idxNeurontype == 'IN' & (T.idxSpikeIn & T.idxSpikeOut);
DRun_IN_None = T.taskType == 'DRun' & T.idxNeurontype == 'IN' & ~(T.idxSpikeIn | T.idxSpikeOut);

DRun_UNC_In = T.taskType == 'DRun' & T.idxNeurontype == 'UNC' & (T.idxSpikeIn & ~T.idxSpikeOut);
DRun_UNC_Out = T.taskType == 'DRun' & T.idxNeurontype == 'UNC' & (~T.idxSpikeIn & T.idxSpikeOut);
DRun_UNC_InOut = T.taskType == 'DRun' & T.idxNeurontype == 'UNC' & (T.idxSpikeIn & T.idxSpikeOut);
DRun_UNC_None = T.taskType == 'DRun' & T.idxNeurontype == 'UNC' & ~(T.idxSpikeIn | T.idxSpikeOut);

% saving folder
% fileName = T.path(DRun_PF_In);
% cellID = T.cellID(DRun_PF_In);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\DRun\PF_In');
% 
% fileName = T.path(DRun_PF_Out);
% cellID = T.cellID(DRun_PF_Out);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\DRun\PF_Out');
% 
% fileName = T.path(DRun_PF_InOut);
% cellID = T.cellID(DRun_PF_InOut);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\DRun\PF_InOut');
% 
% fileName = T.path(DRun_PF_None);
% cellID = T.cellID(DRun_PF_None);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\DRun\PF_None');
% 
% fileName = T.path(DRun_noPF_In);
% cellID = T.cellID(DRun_noPF_In);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\DRun\noPF_In');
% 
% fileName = T.path(DRun_noPF_Out);
% cellID = T.cellID(DRun_noPF_Out);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\DRun\noPF_Out');
% 
% fileName = T.path(DRun_noPF_InOut);
% cellID = T.cellID(DRun_noPF_InOut);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\DRun\noPF_InOut');
% 
% fileName = T.path(DRun_noPF_None);
% cellID = T.cellID(DRun_noPF_None);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\DRun\noPF_None');
% 
% fileName = T.path(DRun_IN_In);
% cellID = T.cellID(DRun_IN_In);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\DRun\IN_In');
% 
% fileName = T.path(DRun_IN_Out);
% cellID = T.cellID(DRun_IN_Out);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\DRun\IN_Out');
% 
% fileName = T.path(DRun_IN_InOut);
% cellID = T.cellID(DRun_IN_InOut);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\DRun\IN_InOut');
% 
% fileName = T.path(DRun_IN_None);
% cellID = T.cellID(DRun_IN_None);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\DRun\IN_None');
% 
% fileName = T.path(DRun_UNC_In);
% cellID = T.cellID(DRun_UNC_In);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\DRun\UNC_In');
% 
% fileName = T.path(DRun_UNC_Out);
% cellID = T.cellID(DRun_UNC_Out);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\DRun\UNC_Out');
% 
% fileName = T.path(DRun_UNC_InOut);
% cellID = T.cellID(DRun_UNC_InOut);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\DRun\UNC_InOut');
% 
% fileName = T.path(DRun_UNC_None);
% cellID = T.cellID(DRun_UNC_None);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\DRun\UNC_None');

% num of neurons
nDRun_PF_In = sum(double(T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & (T.idxSpikeIn & ~T.idxSpikeOut)));
nDRun_PF_Out = sum(double(T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & (~T.idxSpikeIn & T.idxSpikeOut)));
nDRun_PF_InOut = sum(double(T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & (T.idxSpikeIn & T.idxSpikeOut)));
nDRun_PF_None = sum(double(T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & ~(T.idxSpikeIn | T.idxSpikeOut)));

nDRun_noPF_In = sum(double(T.taskType == 'DRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField) & (T.idxSpikeIn & ~T.idxSpikeOut)));
nDRun_noPF_Out = sum(double(T.taskType == 'DRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField) & (~T.idxSpikeIn & T.idxSpikeOut)));
nDRun_noPF_InOut = sum(double(T.taskType == 'DRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField) & (T.idxSpikeIn & T.idxSpikeOut)));
nDRun_noPF_None = sum(double(T.taskType == 'DRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField) & ~(T.idxSpikeIn | T.idxSpikeOut)));

nDRun_IN_In = sum(double(T.taskType == 'DRun' & T.idxNeurontype == 'IN' & (T.idxSpikeIn & ~T.idxSpikeOut)));
nDRun_IN_Out = sum(double(T.taskType == 'DRun' & T.idxNeurontype == 'IN' & (~T.idxSpikeIn & T.idxSpikeOut)));
nDRun_IN_InOut = sum(double(T.taskType == 'DRun' & T.idxNeurontype == 'IN' & (T.idxSpikeIn & T.idxSpikeOut)));
nDRun_IN_None = sum(double(T.taskType == 'DRun' & T.idxNeurontype == 'IN' & ~(T.idxSpikeIn | T.idxSpikeOut)));

nDRun_UNC_In = sum(double(T.taskType == 'DRun' & T.idxNeurontype == 'UNC' & (T.idxSpikeIn & ~T.idxSpikeOut)));
nDRun_UNC_Out = sum(double(T.taskType == 'DRun' & T.idxNeurontype == 'UNC' & (~T.idxSpikeIn & T.idxSpikeOut)));
nDRun_UNC_InOut = sum(double(T.taskType == 'DRun' & T.idxNeurontype == 'UNC' & (T.idxSpikeIn & T.idxSpikeOut)));
nDRun_UNC_None = sum(double(T.taskType == 'DRun' & T.idxNeurontype == 'UNC' & ~(T.idxSpikeIn | T.idxSpikeOut)));

% table
table_DRun(:,1) = [nDRun_PF_In, nDRun_PF_Out, nDRun_PF_InOut, nDRun_PF_None];
table_DRun(:,2) = [nDRun_noPF_In, nDRun_noPF_Out, nDRun_noPF_InOut, nDRun_noPF_None];
table_DRun(:,3) = [nDRun_IN_In, nDRun_IN_Out, nDRun_IN_InOut, nDRun_IN_None];
table_DRun(:,4) = [nDRun_UNC_In, nDRun_UNC_Out, nDRun_UNC_InOut, nDRun_UNC_None];

% correlation
corr_DRun_PF_In = [T.rCorr1D_preXstm(DRun_PF_In); T.rCorr1D_preXpost(DRun_PF_In); T.rCorr1D_stmXpost(DRun_PF_In)];
corr_nDRun_PF_Out = [T.rCorr1D_preXstm(DRun_PF_Out); T.rCorr1D_preXpost(DRun_PF_Out); T.rCorr1D_stmXpost(DRun_PF_Out)];
corr_nDRun_PF_InOut = [T.rCorr1D_preXstm(DRun_PF_InOut); T.rCorr1D_preXpost(DRun_PF_InOut); T.rCorr1D_stmXpost(DRun_PF_InOut)];
corr_nDRun_PF_None = [T.rCorr1D_preXstm(DRun_PF_None); T.rCorr1D_preXpost(DRun_PF_None); T.rCorr1D_stmXpost(DRun_PF_None)];

corr_DRun_noPF_In = [T.rCorr1D_preXstm(DRun_noPF_In); T.rCorr1D_preXpost(DRun_noPF_In); T.rCorr1D_stmXpost(DRun_noPF_In)];
corr_nDRun_noPF_Out = [T.rCorr1D_preXstm(DRun_noPF_Out); T.rCorr1D_preXpost(DRun_noPF_Out); T.rCorr1D_stmXpost(DRun_noPF_Out)];
corr_nDRun_noPF_InOut = [T.rCorr1D_preXstm(DRun_noPF_InOut); T.rCorr1D_preXpost(DRun_noPF_InOut); T.rCorr1D_stmXpost(DRun_noPF_InOut)];
corr_nDRun_noPF_None = [T.rCorr1D_preXstm(DRun_noPF_None); T.rCorr1D_preXpost(DRun_noPF_None); T.rCorr1D_stmXpost(DRun_noPF_None)];

corr_nDRun_IN_In = [T.rCorr1D_preXstm(DRun_IN_In); T.rCorr1D_preXpost(DRun_IN_In); T.rCorr1D_stmXpost(DRun_IN_In)];
corr_nDRun_IN_Out = [T.rCorr1D_preXstm(DRun_IN_Out); T.rCorr1D_preXpost(DRun_IN_Out); T.rCorr1D_stmXpost(DRun_IN_Out)];
corr_nDRun_IN_InOut = [T.rCorr1D_preXstm(DRun_IN_InOut); T.rCorr1D_preXpost(DRun_IN_InOut); T.rCorr1D_stmXpost(DRun_IN_InOut)];
corr_nDRun_IN_None = [T.rCorr1D_preXstm(DRun_IN_None); T.rCorr1D_preXpost(DRun_IN_None); T.rCorr1D_stmXpost(DRun_IN_None)];

corr_nDRun_UNC_In = [T.rCorr1D_preXstm(DRun_UNC_In); T.rCorr1D_preXpost(DRun_UNC_In); T.rCorr1D_stmXpost(DRun_UNC_In)];
corr_nDRun_UNC_Out = [T.rCorr1D_preXstm(DRun_UNC_Out); T.rCorr1D_preXpost(DRun_UNC_Out); T.rCorr1D_stmXpost(DRun_UNC_Out)];
corr_nDRun_UNC_InOut = [T.rCorr1D_preXstm(DRun_UNC_InOut); T.rCorr1D_preXpost(DRun_UNC_InOut); T.rCorr1D_stmXpost(DRun_UNC_InOut)];
corr_nDRun_UNC_None = [T.rCorr1D_preXstm(DRun_UNC_None); T.rCorr1D_preXpost(DRun_UNC_None); T.rCorr1D_stmXpost(DRun_UNC_None)];

% xpt
xpt_DRun_PF_In = [ones(nDRun_PF_In,1); ones(nDRun_PF_In,1)*2; ones(nDRun_PF_In,1)*3];
xpt_DRun_PF_Out = [ones(nDRun_PF_Out,1); ones(nDRun_PF_Out,1)*2; ones(nDRun_PF_Out,1)*3];
xpt_DRun_PF_InOut = [ones(nDRun_PF_InOut,1); ones(nDRun_PF_InOut,1)*2; ones(nDRun_PF_InOut,1)*3];
xpt_DRun_PF_None = [ones(nDRun_PF_None,1); ones(nDRun_PF_None,1)*2; ones(nDRun_PF_None,1)*3];

xpt_DRun_noPF_In = [ones(nDRun_noPF_In,1); ones(nDRun_noPF_In,1)*2; ones(nDRun_noPF_In,1)*3];
xpt_DRun_noPF_Out = [ones(nDRun_noPF_Out,1); ones(nDRun_noPF_Out,1)*2; ones(nDRun_noPF_Out,1)*3];
xpt_DRun_noPF_InOut = [ones(nDRun_noPF_InOut,1); ones(nDRun_noPF_InOut,1)*2; ones(nDRun_noPF_InOut,1)*3];
xpt_DRun_noPF_None = [ones(nDRun_noPF_None,1); ones(nDRun_noPF_None,1)*2; ones(nDRun_noPF_None,1)*3];

xpt_DRun_IN_In = [ones(nDRun_IN_In,1); ones(nDRun_IN_In,1)*2; ones(nDRun_IN_In,1)*3];
xpt_DRun_IN_Out = [ones(nDRun_IN_Out,1); ones(nDRun_IN_Out,1)*2; ones(nDRun_IN_Out,1)*3];
xpt_DRun_IN_InOut = [ones(nDRun_IN_InOut,1); ones(nDRun_IN_InOut,1)*2; ones(nDRun_IN_InOut,1)*3];
xpt_DRun_IN_None = [ones(nDRun_IN_None,1); ones(nDRun_IN_None,1)*2; ones(nDRun_IN_None,1)*3];

xpt_DRun_UNC_In = [ones(nDRun_UNC_In,1); ones(nDRun_UNC_In,1)*2; ones(nDRun_UNC_In,1)*3];
xpt_DRun_UNC_Out = [ones(nDRun_UNC_Out,1); ones(nDRun_UNC_Out,1)*2; ones(nDRun_UNC_Out,1)*3];
xpt_DRun_UNC_InOut = [ones(nDRun_UNC_InOut,1); ones(nDRun_UNC_InOut,1)*2; ones(nDRun_UNC_InOut,1)*3];
xpt_DRun_UNC_None = [ones(nDRun_UNC_None,1); ones(nDRun_UNC_None,1)*2; ones(nDRun_UNC_None,1)*3];

%% noRun
noRun_PN = T.taskType == 'noRun' & T.idxNeurontype == 'PN';
noRun_IN = T.taskType == 'noRun' & T.idxNeurontype == 'IN';
noRun_UNC = T.taskType == 'noRun' & T.idxNeurontype == 'UNC';

noRun_PF = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField;
noRun_noPF = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField);

noRun_PF_In = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & (T.idxSpikeIn & ~T.idxSpikeOut);
noRun_PF_Out = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & (~T.idxSpikeIn & T.idxSpikeOut);
noRun_PF_InOut = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & (T.idxSpikeIn & T.idxSpikeOut);
noRun_PF_None = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & ~(T.idxSpikeIn | T.idxSpikeOut);

noRun_noPF_In = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField) & (T.idxSpikeIn & ~T.idxSpikeOut);
noRun_noPF_Out = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField) & (~T.idxSpikeIn & T.idxSpikeOut);
noRun_noPF_InOut = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField) & (T.idxSpikeIn & T.idxSpikeOut);
noRun_noPF_None = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField) & ~(T.idxSpikeIn | T.idxSpikeOut);

noRun_IN_In = T.taskType == 'noRun' & T.idxNeurontype == 'IN' & (T.idxSpikeIn & ~T.idxSpikeOut);
noRun_IN_Out = T.taskType == 'noRun' & T.idxNeurontype == 'IN' & (~T.idxSpikeIn & T.idxSpikeOut);
noRun_IN_InOut = T.taskType == 'noRun' & T.idxNeurontype == 'IN' & (T.idxSpikeIn & T.idxSpikeOut);
noRun_IN_None = T.taskType == 'noRun' & T.idxNeurontype == 'IN' & ~(T.idxSpikeIn | T.idxSpikeOut);

noRun_UNC_In = T.taskType == 'noRun' & T.idxNeurontype == 'UNC' & (T.idxSpikeIn & ~T.idxSpikeOut);
noRun_UNC_Out = T.taskType == 'noRun' & T.idxNeurontype == 'UNC' & (~T.idxSpikeIn & T.idxSpikeOut);
noRun_UNC_InOut = T.taskType == 'noRun' & T.idxNeurontype == 'UNC' & (T.idxSpikeIn & T.idxSpikeOut);
noRun_UNC_None = T.taskType == 'noRun' & T.idxNeurontype == 'UNC' & ~(T.idxSpikeIn | T.idxSpikeOut);

% % saving folder
% fileName = T.path(noRun_PF_In);
% cellID = T.cellID(noRun_PF_In);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\noRun\PF_In');
% 
% fileName = T.path(noRun_PF_Out);
% cellID = T.cellID(noRun_PF_Out);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\noRun\PF_Out');
% 
% fileName = T.path(noRun_PF_InOut);
% cellID = T.cellID(noRun_PF_InOut);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\noRun\PF_InOut');
% 
% fileName = T.path(noRun_PF_None);
% cellID = T.cellID(noRun_PF_None);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\noRun\PF_None');
% 
% fileName = T.path(noRun_noPF_In);
% cellID = T.cellID(noRun_noPF_In);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\noRun\noPF_In');
% 
% fileName = T.path(noRun_noPF_Out);
% cellID = T.cellID(noRun_noPF_Out);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\noRun\noPF_Out');
% 
% fileName = T.path(noRun_noPF_InOut);
% cellID = T.cellID(noRun_noPF_InOut);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\noRun\noPF_InOut');
% 
% fileName = T.path(noRun_noPF_None);
% cellID = T.cellID(noRun_noPF_None);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\noRun\noPF_None');
% 
% fileName = T.path(noRun_IN_In);
% cellID = T.cellID(noRun_IN_In);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\noRun\IN_In');
% 
% fileName = T.path(noRun_IN_Out);
% cellID = T.cellID(noRun_IN_Out);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\noRun\IN_Out');
% 
% fileName = T.path(noRun_IN_InOut);
% cellID = T.cellID(noRun_IN_InOut);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\noRun\IN_InOut');
% 
% fileName = T.path(noRun_IN_None);
% cellID = T.cellID(noRun_IN_None);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\noRun\IN_None');
% 
% fileName = T.path(noRun_UNC_In);
% cellID = T.cellID(noRun_UNC_In);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\noRun\UNC_In');
% 
% fileName = T.path(noRun_UNC_Out);
% cellID = T.cellID(noRun_UNC_Out);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\noRun\UNC_Out');
% 
% fileName = T.path(noRun_UNC_InOut);
% cellID = T.cellID(noRun_UNC_InOut);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\noRun\UNC_InOut');
% 
% fileName = T.path(noRun_UNC_None);
% cellID = T.cellID(noRun_UNC_None);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\noRun\UNC_None');

% num of neurons
nnoRun_PF_In = sum(double(T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & (T.idxSpikeIn & ~T.idxSpikeOut)));
nnoRun_PF_Out = sum(double(T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & (~T.idxSpikeIn & T.idxSpikeOut)));
nnoRun_PF_InOut = sum(double(T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & (T.idxSpikeIn & T.idxSpikeOut)));
nnoRun_PF_None = sum(double(T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & ~(T.idxSpikeIn | T.idxSpikeOut)));

nnoRun_noPF_In = sum(double(T.taskType == 'noRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField) & (T.idxSpikeIn & ~T.idxSpikeOut)));
nnoRun_noPF_Out = sum(double(T.taskType == 'noRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField) & (~T.idxSpikeIn & T.idxSpikeOut)));
nnoRun_noPF_InOut = sum(double(T.taskType == 'noRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField) & (T.idxSpikeIn & T.idxSpikeOut)));
nnoRun_noPF_None = sum(double(T.taskType == 'noRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField) & ~(T.idxSpikeIn | T.idxSpikeOut)));

nnoRun_IN_In = sum(double(T.taskType == 'noRun' & T.idxNeurontype == 'IN' & (T.idxSpikeIn & ~T.idxSpikeOut)));
nnoRun_IN_Out = sum(double(T.taskType == 'noRun' & T.idxNeurontype == 'IN' & (~T.idxSpikeIn & T.idxSpikeOut)));
nnoRun_IN_InOut = sum(double(T.taskType == 'noRun' & T.idxNeurontype == 'IN' & (T.idxSpikeIn & T.idxSpikeOut)));
nnoRun_IN_None = sum(double(T.taskType == 'noRun' & T.idxNeurontype == 'IN' & ~(T.idxSpikeIn | T.idxSpikeOut)));

nnoRun_UNC_In = sum(double(T.taskType == 'noRun' & T.idxNeurontype == 'UNC' & (T.idxSpikeIn & ~T.idxSpikeOut)));
nnoRun_UNC_Out = sum(double(T.taskType == 'noRun' & T.idxNeurontype == 'UNC' & (~T.idxSpikeIn & T.idxSpikeOut)));
nnoRun_UNC_InOut = sum(double(T.taskType == 'noRun' & T.idxNeurontype == 'UNC' & (T.idxSpikeIn & T.idxSpikeOut)));
nnoRun_UNC_None = sum(double(T.taskType == 'noRun' & T.idxNeurontype == 'UNC' & ~(T.idxSpikeIn | T.idxSpikeOut)));

% table
table_noRun(:,1) = [nnoRun_PF_In, nnoRun_PF_Out, nnoRun_PF_InOut, nnoRun_PF_None];
table_noRun(:,2) = [nnoRun_noPF_In, nnoRun_noPF_Out, nnoRun_noPF_InOut, nnoRun_noPF_None];
table_noRun(:,3) = [nnoRun_IN_In, nnoRun_IN_Out, nnoRun_IN_InOut, nnoRun_IN_None];
table_noRun(:,4) = [nnoRun_UNC_In, nnoRun_UNC_Out, nnoRun_UNC_InOut, nnoRun_UNC_None];

% correlation
corr_noRun_PF_In = [T.rCorr1D_preXstm(noRun_PF_In); T.rCorr1D_preXpost(noRun_PF_In); T.rCorr1D_stmXpost(noRun_PF_In)];
corr_nnoRun_PF_Out = [T.rCorr1D_preXstm(noRun_PF_Out); T.rCorr1D_preXpost(noRun_PF_Out); T.rCorr1D_stmXpost(noRun_PF_Out)];
corr_nnoRun_PF_InOut = [T.rCorr1D_preXstm(noRun_PF_InOut); T.rCorr1D_preXpost(noRun_PF_InOut); T.rCorr1D_stmXpost(noRun_PF_InOut)];
corr_nnoRun_PF_None = [T.rCorr1D_preXstm(noRun_PF_None); T.rCorr1D_preXpost(noRun_PF_None); T.rCorr1D_stmXpost(noRun_PF_None)];

corr_noRun_noPF_In = [T.rCorr1D_preXstm(noRun_noPF_In); T.rCorr1D_preXpost(noRun_noPF_In); T.rCorr1D_stmXpost(noRun_noPF_In)];
corr_nnoRun_noPF_Out = [T.rCorr1D_preXstm(noRun_noPF_Out); T.rCorr1D_preXpost(noRun_noPF_Out); T.rCorr1D_stmXpost(noRun_noPF_Out)];
corr_nnoRun_noPF_InOut = [T.rCorr1D_preXstm(noRun_noPF_InOut); T.rCorr1D_preXpost(noRun_noPF_InOut); T.rCorr1D_stmXpost(noRun_noPF_InOut)];
corr_nnoRun_noPF_None = [T.rCorr1D_preXstm(noRun_noPF_None); T.rCorr1D_preXpost(noRun_noPF_None); T.rCorr1D_stmXpost(noRun_noPF_None)];

corr_nnoRun_IN_In = [T.rCorr1D_preXstm(noRun_IN_In); T.rCorr1D_preXpost(noRun_IN_In); T.rCorr1D_stmXpost(noRun_IN_In)];
corr_nnoRun_IN_Out = [T.rCorr1D_preXstm(noRun_IN_Out); T.rCorr1D_preXpost(noRun_IN_Out); T.rCorr1D_stmXpost(noRun_IN_Out)];
corr_nnoRun_IN_InOut = [T.rCorr1D_preXstm(noRun_IN_InOut); T.rCorr1D_preXpost(noRun_IN_InOut); T.rCorr1D_stmXpost(noRun_IN_InOut)];
corr_nnoRun_IN_None = [T.rCorr1D_preXstm(noRun_IN_None); T.rCorr1D_preXpost(noRun_IN_None); T.rCorr1D_stmXpost(noRun_IN_None)];

corr_nnoRun_UNC_In = [T.rCorr1D_preXstm(noRun_UNC_In); T.rCorr1D_preXpost(noRun_UNC_In); T.rCorr1D_stmXpost(noRun_UNC_In)];
corr_nnoRun_UNC_Out = [T.rCorr1D_preXstm(noRun_UNC_Out); T.rCorr1D_preXpost(noRun_UNC_Out); T.rCorr1D_stmXpost(noRun_UNC_Out)];
corr_nnoRun_UNC_InOut = [T.rCorr1D_preXstm(noRun_UNC_InOut); T.rCorr1D_preXpost(noRun_UNC_InOut); T.rCorr1D_stmXpost(noRun_UNC_InOut)];
corr_nnoRun_UNC_None = [T.rCorr1D_preXstm(noRun_UNC_None); T.rCorr1D_preXpost(noRun_UNC_None); T.rCorr1D_stmXpost(noRun_UNC_None)];

% xpt
xpt_noRun_PF_In = [ones(nnoRun_PF_In,1); ones(nnoRun_PF_In,1)*2; ones(nnoRun_PF_In,1)*3];
xpt_noRun_PF_Out = [ones(nnoRun_PF_Out,1); ones(nnoRun_PF_Out,1)*2; ones(nnoRun_PF_Out,1)*3];
xpt_noRun_PF_InOut = [ones(nnoRun_PF_InOut,1); ones(nnoRun_PF_InOut,1)*2; ones(nnoRun_PF_InOut,1)*3];
xpt_noRun_PF_None = [ones(nnoRun_PF_None,1); ones(nnoRun_PF_None,1)*2; ones(nnoRun_PF_None,1)*3];

xpt_noRun_noPF_In = [ones(nnoRun_noPF_In,1); ones(nnoRun_noPF_In,1)*2; ones(nnoRun_noPF_In,1)*3];
xpt_noRun_noPF_Out = [ones(nnoRun_noPF_Out,1); ones(nnoRun_noPF_Out,1)*2; ones(nnoRun_noPF_Out,1)*3];
xpt_noRun_noPF_InOut = [ones(nnoRun_noPF_InOut,1); ones(nnoRun_noPF_InOut,1)*2; ones(nnoRun_noPF_InOut,1)*3];
xpt_noRun_noPF_None = [ones(nnoRun_noPF_None,1); ones(nnoRun_noPF_None,1)*2; ones(nnoRun_noPF_None,1)*3];

xpt_noRun_IN_In = [ones(nnoRun_IN_In,1); ones(nnoRun_IN_In,1)*2; ones(nnoRun_IN_In,1)*3];
xpt_noRun_IN_Out = [ones(nnoRun_IN_Out,1); ones(nnoRun_IN_Out,1)*2; ones(nnoRun_IN_Out,1)*3];
xpt_noRun_IN_InOut = [ones(nnoRun_IN_InOut,1); ones(nnoRun_IN_InOut,1)*2; ones(nnoRun_IN_InOut,1)*3];
xpt_noRun_IN_None = [ones(nnoRun_IN_None,1); ones(nnoRun_IN_None,1)*2; ones(nnoRun_IN_None,1)*3];

xpt_noRun_UNC_In = [ones(nnoRun_PF_In,1); ones(nnoRun_PF_In,1)*2; ones(nnoRun_PF_In,1)*3];
xpt_noRun_UNC_Out = [ones(nnoRun_UNC_Out,1); ones(nnoRun_UNC_Out,1)*2; ones(nnoRun_UNC_Out,1)*3];
xpt_noRun_UNC_InOut = [ones(nnoRun_UNC_InOut,1); ones(nnoRun_UNC_InOut,1)*2; ones(nnoRun_UNC_InOut,1)*3];
xpt_noRun_UNC_None = [ones(nnoRun_UNC_None,1); ones(nnoRun_UNC_None,1)*2; ones(nnoRun_UNC_None,1)*3];

%% DRw
DRw_PN = T.taskType == 'DRw' & T.idxNeurontype == 'PN';
DRw_IN = T.taskType == 'DRw' & T.idxNeurontype == 'IN';
DRw_UNC = T.taskType == 'DRw' & T.idxNeurontype == 'UNC';

DRw_PF = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField;
DRw_noPF = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField);

DRw_PF_In = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & (T.idxSpikeIn & ~T.idxSpikeOut);
DRw_PF_Out = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & (~T.idxSpikeIn & T.idxSpikeOut);
DRw_PF_InOut = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & (T.idxSpikeIn & T.idxSpikeOut);
DRw_PF_None = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & ~(T.idxSpikeIn | T.idxSpikeOut);

DRw_noPF_In = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField) & (T.idxSpikeIn & ~T.idxSpikeOut);
DRw_noPF_Out = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField) & (~T.idxSpikeIn & T.idxSpikeOut);
DRw_noPF_InOut = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField) & (T.idxSpikeIn & T.idxSpikeOut);
DRw_noPF_None = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField) & ~(T.idxSpikeIn | T.idxSpikeOut);

DRw_IN_In = T.taskType == 'DRw' & T.idxNeurontype == 'IN' & (T.idxSpikeIn & ~T.idxSpikeOut);
DRw_IN_Out = T.taskType == 'DRw' & T.idxNeurontype == 'IN' & (~T.idxSpikeIn & T.idxSpikeOut);
DRw_IN_InOut = T.taskType == 'DRw' & T.idxNeurontype == 'IN' & (T.idxSpikeIn & T.idxSpikeOut);
DRw_IN_None = T.taskType == 'DRw' & T.idxNeurontype == 'IN' & ~(T.idxSpikeIn | T.idxSpikeOut);

DRw_UNC_In = T.taskType == 'DRw' & T.idxNeurontype == 'UNC' & (T.idxSpikeIn & ~T.idxSpikeOut);
DRw_UNC_Out = T.taskType == 'DRw' & T.idxNeurontype == 'UNC' & (~T.idxSpikeIn & T.idxSpikeOut);
DRw_UNC_InOut = T.taskType == 'DRw' & T.idxNeurontype == 'UNC' & (T.idxSpikeIn & T.idxSpikeOut);
DRw_UNC_None = T.taskType == 'DRw' & T.idxNeurontype == 'UNC' & ~(T.idxSpikeIn | T.idxSpikeOut);

% saving folder
% fileName = T.path(DRw_PF_In);
% cellID = T.cellID(DRw_PF_In);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\DRw\PF_In');
% 
% fileName = T.path(DRw_PF_Out);
% cellID = T.cellID(DRw_PF_Out);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\DRw\PF_Out');
% 
% fileName = T.path(DRw_PF_InOut);
% cellID = T.cellID(DRw_PF_InOut);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\DRw\PF_InOut');
% 
% fileName = T.path(DRw_PF_None);
% cellID = T.cellID(DRw_PF_None);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\DRw\PF_None');
% 
% fileName = T.path(DRw_noPF_In);
% cellID = T.cellID(DRw_noPF_In);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\DRw\noPF_In');
% 
% fileName = T.path(DRw_noPF_Out);
% cellID = T.cellID(DRw_noPF_Out);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\DRw\noPF_Out');
% 
% fileName = T.path(DRw_noPF_InOut);
% cellID = T.cellID(DRw_noPF_InOut);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\DRw\noPF_InOut');
% 
% fileName = T.path(DRw_noPF_None);
% cellID = T.cellID(DRw_noPF_None);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\DRw\noPF_None');
% 
% fileName = T.path(DRw_IN_In);
% cellID = T.cellID(DRw_IN_In);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\DRw\IN_In');
% 
% fileName = T.path(DRw_IN_Out);
% cellID = T.cellID(DRw_IN_Out);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\DRw\IN_Out');
% 
% fileName = T.path(DRw_IN_InOut);
% cellID = T.cellID(DRw_IN_InOut);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\DRw\IN_InOut');
% 
% fileName = T.path(DRw_IN_None);
% cellID = T.cellID(DRw_IN_None);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\DRw\IN_None');
% 
% fileName = T.path(DRw_UNC_In);
% cellID = T.cellID(DRw_UNC_In);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\DRw\UNC_In');
% 
% fileName = T.path(DRw_UNC_Out);
% cellID = T.cellID(DRw_UNC_Out);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\DRw\UNC_Out');
% 
% fileName = T.path(DRw_UNC_InOut);
% cellID = T.cellID(DRw_UNC_InOut);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\DRw\UNC_InOut');
% 
% fileName = T.path(DRw_UNC_None);
% cellID = T.cellID(DRw_UNC_None);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\DRw\UNC_None');

% num of neurons
nDRw_PF_In = sum(double(T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & (T.idxSpikeIn & ~T.idxSpikeOut)));
nDRw_PF_Out = sum(double(T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & (~T.idxSpikeIn & T.idxSpikeOut)));
nDRw_PF_InOut = sum(double(T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & (T.idxSpikeIn & T.idxSpikeOut)));
nDRw_PF_None = sum(double(T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & ~(T.idxSpikeIn | T.idxSpikeOut)));

nDRw_noPF_In = sum(double(T.taskType == 'DRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField) & (T.idxSpikeIn & ~T.idxSpikeOut)));
nDRw_noPF_Out = sum(double(T.taskType == 'DRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField) & (~T.idxSpikeIn & T.idxSpikeOut)));
nDRw_noPF_InOut = sum(double(T.taskType == 'DRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField) & (T.idxSpikeIn & T.idxSpikeOut)));
nDRw_noPF_None = sum(double(T.taskType == 'DRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField) & ~(T.idxSpikeIn | T.idxSpikeOut)));

nDRw_IN_In = sum(double(T.taskType == 'DRw' & T.idxNeurontype == 'IN' & (T.idxSpikeIn & ~T.idxSpikeOut)));
nDRw_IN_Out = sum(double(T.taskType == 'DRw' & T.idxNeurontype == 'IN' & (~T.idxSpikeIn & T.idxSpikeOut)));
nDRw_IN_InOut = sum(double(T.taskType == 'DRw' & T.idxNeurontype == 'IN' & (T.idxSpikeIn & T.idxSpikeOut)));
nDRw_IN_None = sum(double(T.taskType == 'DRw' & T.idxNeurontype == 'IN' & ~(T.idxSpikeIn | T.idxSpikeOut)));

nDRw_UNC_In = sum(double(T.taskType == 'DRw' & T.idxNeurontype == 'UNC' & (T.idxSpikeIn & ~T.idxSpikeOut)));
nDRw_UNC_Out = sum(double(T.taskType == 'DRw' & T.idxNeurontype == 'UNC' & (~T.idxSpikeIn & T.idxSpikeOut)));
nDRw_UNC_InOut = sum(double(T.taskType == 'DRw' & T.idxNeurontype == 'UNC' & (T.idxSpikeIn & T.idxSpikeOut)));
nDRw_UNC_None = sum(double(T.taskType == 'DRw' & T.idxNeurontype == 'UNC' & ~(T.idxSpikeIn | T.idxSpikeOut)));

% table
table_DRw(:,1) = [nDRw_PF_In, nDRw_PF_Out, nDRw_PF_InOut, nDRw_PF_None];
table_DRw(:,2) = [nDRw_noPF_In, nDRw_noPF_Out, nDRw_noPF_InOut, nDRw_noPF_None];
table_DRw(:,3) = [nDRw_IN_In, nDRw_IN_Out, nDRw_IN_InOut, nDRw_IN_None];
table_DRw(:,4) = [nDRw_UNC_In, nDRw_UNC_Out, nDRw_UNC_InOut, nDRw_UNC_None];

% correlation
corr_DRw_PF_In = [T.rCorr1D_preXstm(DRw_PF_In); T.rCorr1D_preXpost(DRw_PF_In); T.rCorr1D_stmXpost(DRw_PF_In)];
corr_nDRw_PF_Out = [T.rCorr1D_preXstm(DRw_PF_Out); T.rCorr1D_preXpost(DRw_PF_Out); T.rCorr1D_stmXpost(DRw_PF_Out)];
corr_nDRw_PF_InOut = [T.rCorr1D_preXstm(DRw_PF_InOut); T.rCorr1D_preXpost(DRw_PF_InOut); T.rCorr1D_stmXpost(DRw_PF_InOut)];
corr_nDRw_PF_None = [T.rCorr1D_preXstm(DRw_PF_None); T.rCorr1D_preXpost(DRw_PF_None); T.rCorr1D_stmXpost(DRw_PF_None)];

corr_DRw_noPF_In = [T.rCorr1D_preXstm(DRw_noPF_In); T.rCorr1D_preXpost(DRw_noPF_In); T.rCorr1D_stmXpost(DRw_noPF_In)];
corr_nDRw_noPF_Out = [T.rCorr1D_preXstm(DRw_noPF_Out); T.rCorr1D_preXpost(DRw_noPF_Out); T.rCorr1D_stmXpost(DRw_noPF_Out)];
corr_nDRw_noPF_InOut = [T.rCorr1D_preXstm(DRw_noPF_InOut); T.rCorr1D_preXpost(DRw_noPF_InOut); T.rCorr1D_stmXpost(DRw_noPF_InOut)];
corr_nDRw_noPF_None = [T.rCorr1D_preXstm(DRw_noPF_None); T.rCorr1D_preXpost(DRw_noPF_None); T.rCorr1D_stmXpost(DRw_noPF_None)];

corr_nDRw_IN_In = [T.rCorr1D_preXstm(DRw_IN_In); T.rCorr1D_preXpost(DRw_IN_In); T.rCorr1D_stmXpost(DRw_IN_In)];
corr_nDRw_IN_Out = [T.rCorr1D_preXstm(DRw_IN_Out); T.rCorr1D_preXpost(DRw_IN_Out); T.rCorr1D_stmXpost(DRw_IN_Out)];
corr_nDRw_IN_InOut = [T.rCorr1D_preXstm(DRw_IN_InOut); T.rCorr1D_preXpost(DRw_IN_InOut); T.rCorr1D_stmXpost(DRw_IN_InOut)];
corr_nDRw_IN_None = [T.rCorr1D_preXstm(DRw_IN_None); T.rCorr1D_preXpost(DRw_IN_None); T.rCorr1D_stmXpost(DRw_IN_None)];

corr_nDRw_UNC_In = [T.rCorr1D_preXstm(DRw_UNC_In); T.rCorr1D_preXpost(DRw_UNC_In); T.rCorr1D_stmXpost(DRw_UNC_In)];
corr_nDRw_UNC_Out = [T.rCorr1D_preXstm(DRw_UNC_Out); T.rCorr1D_preXpost(DRw_UNC_Out); T.rCorr1D_stmXpost(DRw_UNC_Out)];
corr_nDRw_UNC_InOut = [T.rCorr1D_preXstm(DRw_UNC_InOut); T.rCorr1D_preXpost(DRw_UNC_InOut); T.rCorr1D_stmXpost(DRw_UNC_InOut)];
corr_nDRw_UNC_None = [T.rCorr1D_preXstm(DRw_UNC_None); T.rCorr1D_preXpost(DRw_UNC_None); T.rCorr1D_stmXpost(DRw_UNC_None)];

% xpt
xpt_DRw_PF_In = [ones(nDRw_PF_In,1); ones(nDRw_PF_In,1)*2; ones(nDRw_PF_In,1)*3];
xpt_DRw_PF_Out = [ones(nDRw_PF_Out,1); ones(nDRw_PF_Out,1)*2; ones(nDRw_PF_Out,1)*3];
xpt_DRw_PF_InOut = [ones(nDRw_PF_InOut,1); ones(nDRw_PF_InOut,1)*2; ones(nDRw_PF_InOut,1)*3];
xpt_DRw_PF_None = [ones(nDRw_PF_None,1); ones(nDRw_PF_None,1)*2; ones(nDRw_PF_None,1)*3];

xpt_DRw_noPF_In = [ones(nDRw_noPF_In,1); ones(nDRw_noPF_In,1)*2; ones(nDRw_noPF_In,1)*3];
xpt_DRw_noPF_Out = [ones(nDRw_noPF_Out,1); ones(nDRw_noPF_Out,1)*2; ones(nDRw_noPF_Out,1)*3];
xpt_DRw_noPF_InOut = [ones(nDRw_noPF_InOut,1); ones(nDRw_noPF_InOut,1)*2; ones(nDRw_noPF_InOut,1)*3];
xpt_DRw_noPF_None = [ones(nDRw_noPF_None,1); ones(nDRw_noPF_None,1)*2; ones(nDRw_noPF_None,1)*3];

xpt_DRw_IN_In = [ones(nDRw_IN_In,1); ones(nDRw_IN_In,1)*2; ones(nDRw_IN_In,1)*3];
xpt_DRw_IN_Out = [ones(nDRw_IN_Out,1); ones(nDRw_IN_Out,1)*2; ones(nDRw_IN_Out,1)*3];
xpt_DRw_IN_InOut = [ones(nDRw_IN_InOut,1); ones(nDRw_IN_InOut,1)*2; ones(nDRw_IN_InOut,1)*3];
xpt_DRw_IN_None = [ones(nDRw_IN_None,1); ones(nDRw_IN_None,1)*2; ones(nDRw_IN_None,1)*3];

xpt_DRw_UNC_In = [ones(nDRw_PF_In,1); ones(nDRw_PF_In,1)*2; ones(nDRw_PF_In,1)*3];
xpt_DRw_UNC_Out = [ones(nDRw_UNC_Out,1); ones(nDRw_UNC_Out,1)*2; ones(nDRw_UNC_Out,1)*3];
xpt_DRw_UNC_InOut = [ones(nDRw_UNC_InOut,1); ones(nDRw_UNC_InOut,1)*2; ones(nDRw_UNC_InOut,1)*3];
xpt_DRw_UNC_None = [ones(nDRw_UNC_None,1); ones(nDRw_UNC_None,1)*2; ones(nDRw_UNC_None,1)*3];

%% noRw
noRw_PN = T.taskType == 'noRw' & T.idxNeurontype == 'PN';
noRw_IN = T.taskType == 'noRw' & T.idxNeurontype == 'IN';
noRw_UNC = T.taskType == 'noRw' & T.idxNeurontype == 'UNC';

noRw_PF = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField;
noRw_noPF = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField);

noRw_PF_In = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & (T.idxSpikeIn & ~T.idxSpikeOut);
noRw_PF_Out = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & (~T.idxSpikeIn & T.idxSpikeOut);
noRw_PF_InOut = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & (T.idxSpikeIn & T.idxSpikeOut);
noRw_PF_None = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & ~(T.idxSpikeIn | T.idxSpikeOut);

noRw_noPF_In = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField) & (T.idxSpikeIn & ~T.idxSpikeOut);
noRw_noPF_Out = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField) & (~T.idxSpikeIn & T.idxSpikeOut);
noRw_noPF_InOut = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField) & (T.idxSpikeIn & T.idxSpikeOut);
noRw_noPF_None = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField) & ~(T.idxSpikeIn | T.idxSpikeOut);

noRw_IN_In = T.taskType == 'noRw' & T.idxNeurontype == 'IN' & (T.idxSpikeIn & ~T.idxSpikeOut);
noRw_IN_Out = T.taskType == 'noRw' & T.idxNeurontype == 'IN' & (~T.idxSpikeIn & T.idxSpikeOut);
noRw_IN_InOut = T.taskType == 'noRw' & T.idxNeurontype == 'IN' & (T.idxSpikeIn & T.idxSpikeOut);
noRw_IN_None = T.taskType == 'noRw' & T.idxNeurontype == 'IN' & ~(T.idxSpikeIn | T.idxSpikeOut);

noRw_UNC_In = T.taskType == 'noRw' & T.idxNeurontype == 'UNC' & (T.idxSpikeIn & ~T.idxSpikeOut);
noRw_UNC_Out = T.taskType == 'noRw' & T.idxNeurontype == 'UNC' & (~T.idxSpikeIn & T.idxSpikeOut);
noRw_UNC_InOut = T.taskType == 'noRw' & T.idxNeurontype == 'UNC' & (T.idxSpikeIn & T.idxSpikeOut);
noRw_UNC_None = T.taskType == 'noRw' & T.idxNeurontype == 'UNC' & ~(T.idxSpikeIn | T.idxSpikeOut);

% saving folder
% fileName = T.path(noRw_PF_In);
% cellID = T.cellID(noRw_PF_In);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\noRw\PF_In');
% 
% fileName = T.path(noRw_PF_Out);
% cellID = T.cellID(noRw_PF_Out);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\noRw\PF_Out');
% 
% fileName = T.path(noRw_PF_InOut);
% cellID = T.cellID(noRw_PF_InOut);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\noRw\PF_InOut');
% 
% fileName = T.path(noRw_PF_None);
% cellID = T.cellID(noRw_PF_None);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\noRw\PF_None');
% 
% fileName = T.path(noRw_noPF_In);
% cellID = T.cellID(noRw_noPF_In);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\noRw\noPF_In');
% 
% fileName = T.path(noRw_noPF_Out);
% cellID = T.cellID(noRw_noPF_Out);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\noRw\noPF_Out');
% 
% fileName = T.path(noRw_noPF_InOut);
% cellID = T.cellID(noRw_noPF_InOut);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\noRw\noPF_InOut');
% 
% fileName = T.path(noRw_noPF_None);
% cellID = T.cellID(noRw_noPF_None);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\noRw\noPF_None');
% 
% fileName = T.path(noRw_IN_In);
% cellID = T.cellID(noRw_IN_In);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\noRw\IN_In');
% 
% fileName = T.path(noRw_IN_Out);
% cellID = T.cellID(noRw_IN_Out);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\noRw\IN_Out');
% 
% fileName = T.path(noRw_IN_InOut);
% cellID = T.cellID(noRw_IN_InOut);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\noRw\IN_InOut');
% 
% fileName = T.path(noRw_IN_None);
% cellID = T.cellID(noRw_IN_None);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\noRw\IN_None');
% 
% fileName = T.path(noRw_UNC_In);
% cellID = T.cellID(noRw_UNC_In);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\noRw\UNC_In');
% 
% fileName = T.path(noRw_UNC_Out);
% cellID = T.cellID(noRw_UNC_Out);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\noRw\UNC_Out');
% 
% fileName = T.path(noRw_UNC_InOut);
% cellID = T.cellID(noRw_UNC_InOut);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\noRw\UNC_InOut');
% 
% fileName = T.path(noRw_UNC_None);
% cellID = T.cellID(noRw_UNC_None);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_spikeCount\noRw\UNC_None');

% num of neurons
nnoRw_PF_In = sum(double(T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & (T.idxSpikeIn & ~T.idxSpikeOut)));
nnoRw_PF_Out = sum(double(T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & (~T.idxSpikeIn & T.idxSpikeOut)));
nnoRw_PF_InOut = sum(double(T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & (T.idxSpikeIn & T.idxSpikeOut)));
nnoRw_PF_None = sum(double(T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & ~(T.idxSpikeIn | T.idxSpikeOut)));

nnoRw_noPF_In = sum(double(T.taskType == 'noRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField) & (T.idxSpikeIn & ~T.idxSpikeOut)));
nnoRw_noPF_Out = sum(double(T.taskType == 'noRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField) & (~T.idxSpikeIn & T.idxSpikeOut)));
nnoRw_noPF_InOut = sum(double(T.taskType == 'noRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField) & (T.idxSpikeIn & T.idxSpikeOut)));
nnoRw_noPF_None = sum(double(T.taskType == 'noRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField) & ~(T.idxSpikeIn | T.idxSpikeOut)));

nnoRw_IN_In = sum(double(T.taskType == 'noRw' & T.idxNeurontype == 'IN' & (T.idxSpikeIn & ~T.idxSpikeOut)));
nnoRw_IN_Out = sum(double(T.taskType == 'noRw' & T.idxNeurontype == 'IN' & (~T.idxSpikeIn & T.idxSpikeOut)));
nnoRw_IN_InOut = sum(double(T.taskType == 'noRw' & T.idxNeurontype == 'IN' & (T.idxSpikeIn & T.idxSpikeOut)));
nnoRw_IN_None = sum(double(T.taskType == 'noRw' & T.idxNeurontype == 'IN' & ~(T.idxSpikeIn | T.idxSpikeOut)));

nnoRw_UNC_In = sum(double(T.taskType == 'noRw' & T.idxNeurontype == 'UNC' & (T.idxSpikeIn & ~T.idxSpikeOut)));
nnoRw_UNC_Out = sum(double(T.taskType == 'noRw' & T.idxNeurontype == 'UNC' & (~T.idxSpikeIn & T.idxSpikeOut)));
nnoRw_UNC_InOut = sum(double(T.taskType == 'noRw' & T.idxNeurontype == 'UNC' & (T.idxSpikeIn & T.idxSpikeOut)));
nnoRw_UNC_None = sum(double(T.taskType == 'noRw' & T.idxNeurontype == 'UNC' & ~(T.idxSpikeIn | T.idxSpikeOut)));

% table
table_noRw(:,1) = [nnoRw_PF_In, nnoRw_PF_Out, nnoRw_PF_InOut, nnoRw_PF_None];
table_noRw(:,2) = [nnoRw_noPF_In, nnoRw_noPF_Out, nnoRw_noPF_InOut, nnoRw_noPF_None];
table_noRw(:,3) = [nnoRw_IN_In, nnoRw_IN_Out, nnoRw_IN_InOut, nnoRw_IN_None];
table_noRw(:,4) = [nnoRw_UNC_In, nnoRw_UNC_Out, nnoRw_UNC_InOut, nnoRw_UNC_None];

% correlation
corr_noRw_PF_In = [T.rCorr1D_preXstm(noRw_PF_In); T.rCorr1D_preXpost(noRw_PF_In); T.rCorr1D_stmXpost(noRw_PF_In)];
corr_noRw_PF_Out = [T.rCorr1D_preXstm(noRw_PF_Out); T.rCorr1D_preXpost(noRw_PF_Out); T.rCorr1D_stmXpost(noRw_PF_Out)];
corr_noRw_PF_InOut = [T.rCorr1D_preXstm(noRw_PF_InOut); T.rCorr1D_preXpost(noRw_PF_InOut); T.rCorr1D_stmXpost(noRw_PF_InOut)];
corr_noRw_PF_None = [T.rCorr1D_preXstm(noRw_PF_None); T.rCorr1D_preXpost(noRw_PF_None); T.rCorr1D_stmXpost(noRw_PF_None)];

corr_noRw_noPF_In = [T.rCorr1D_preXstm(noRw_noPF_In); T.rCorr1D_preXpost(noRw_noPF_In); T.rCorr1D_stmXpost(noRw_noPF_In)];
corr_noRw_noPF_Out = [T.rCorr1D_preXstm(noRw_noPF_Out); T.rCorr1D_preXpost(noRw_noPF_Out); T.rCorr1D_stmXpost(noRw_noPF_Out)];
corr_noRw_noPF_InOut = [T.rCorr1D_preXstm(noRw_noPF_InOut); T.rCorr1D_preXpost(noRw_noPF_InOut); T.rCorr1D_stmXpost(noRw_noPF_InOut)];
corr_noRw_noPF_None = [T.rCorr1D_preXstm(noRw_noPF_None); T.rCorr1D_preXpost(noRw_noPF_None); T.rCorr1D_stmXpost(noRw_noPF_None)];

corr_noRw_IN_In = [T.rCorr1D_preXstm(noRw_IN_In); T.rCorr1D_preXpost(noRw_IN_In); T.rCorr1D_stmXpost(noRw_IN_In)];
corr_noRw_IN_Out = [T.rCorr1D_preXstm(noRw_IN_Out); T.rCorr1D_preXpost(noRw_IN_Out); T.rCorr1D_stmXpost(noRw_IN_Out)];
corr_noRw_IN_InOut = [T.rCorr1D_preXstm(noRw_IN_InOut); T.rCorr1D_preXpost(noRw_IN_InOut); T.rCorr1D_stmXpost(noRw_IN_InOut)];
corr_noRw_IN_None = [T.rCorr1D_preXstm(noRw_IN_None); T.rCorr1D_preXpost(noRw_IN_None); T.rCorr1D_stmXpost(noRw_IN_None)];

corr_noRw_UNC_In = [T.rCorr1D_preXstm(noRw_UNC_In); T.rCorr1D_preXpost(noRw_UNC_In); T.rCorr1D_stmXpost(noRw_UNC_In)];
corr_noRw_UNC_Out = [T.rCorr1D_preXstm(noRw_UNC_Out); T.rCorr1D_preXpost(noRw_UNC_Out); T.rCorr1D_stmXpost(noRw_UNC_Out)];
corr_noRw_UNC_InOut = [T.rCorr1D_preXstm(noRw_UNC_InOut); T.rCorr1D_preXpost(noRw_UNC_InOut); T.rCorr1D_stmXpost(noRw_UNC_InOut)];
corr_noRw_UNC_None = [T.rCorr1D_preXstm(noRw_UNC_None); T.rCorr1D_preXpost(noRw_UNC_None); T.rCorr1D_stmXpost(noRw_UNC_None)];

% xpt
xpt_noRw_PF_In = [ones(nnoRw_PF_In,1); ones(nnoRw_PF_In,1)*2; ones(nnoRw_PF_In,1)*3];
xpt_noRw_PF_Out = [ones(nnoRw_PF_Out,1); ones(nnoRw_PF_Out,1)*2; ones(nnoRw_PF_Out,1)*3];
xpt_noRw_PF_InOut = [ones(nnoRw_PF_InOut,1); ones(nnoRw_PF_InOut,1)*2; ones(nnoRw_PF_InOut,1)*3];
xpt_noRw_PF_None = [ones(nnoRw_PF_None,1); ones(nnoRw_PF_None,1)*2; ones(nnoRw_PF_None,1)*3];

xpt_noRw_noPF_In = [ones(nnoRw_noPF_In,1); ones(nnoRw_noPF_In,1)*2; ones(nnoRw_noPF_In,1)*3];
xpt_noRw_noPF_Out = [ones(nnoRw_noPF_Out,1); ones(nnoRw_noPF_Out,1)*2; ones(nnoRw_noPF_Out,1)*3];
xpt_noRw_noPF_InOut = [ones(nnoRw_noPF_InOut,1); ones(nnoRw_noPF_InOut,1)*2; ones(nnoRw_noPF_InOut,1)*3];
xpt_noRw_noPF_None = [ones(nnoRw_noPF_None,1); ones(nnoRw_noPF_None,1)*2; ones(nnoRw_noPF_None,1)*3];

xpt_noRw_IN_In = [ones(nnoRw_IN_In,1); ones(nnoRw_IN_In,1)*2; ones(nnoRw_IN_In,1)*3];
xpt_noRw_IN_Out = [ones(nnoRw_IN_Out,1); ones(nnoRw_IN_Out,1)*2; ones(nnoRw_IN_Out,1)*3];
xpt_noRw_IN_InOut = [ones(nnoRw_IN_InOut,1); ones(nnoRw_IN_InOut,1)*2; ones(nnoRw_IN_InOut,1)*3];
xpt_noRw_IN_None = [ones(nnoRw_IN_None,1); ones(nnoRw_IN_None,1)*2; ones(nnoRw_IN_None,1)*3];

xpt_noRw_UNC_In = [ones(nnoRw_PF_In,1); ones(nnoRw_PF_In,1)*2; ones(nnoRw_PF_In,1)*3];
xpt_noRw_UNC_Out = [ones(nnoRw_UNC_Out,1); ones(nnoRw_UNC_Out,1)*2; ones(nnoRw_UNC_Out,1)*3];
xpt_noRw_UNC_InOut = [ones(nnoRw_UNC_InOut,1); ones(nnoRw_UNC_InOut,1)*2; ones(nnoRw_UNC_InOut,1)*3];
xpt_noRw_UNC_None = [ones(nnoRw_UNC_None,1); ones(nnoRw_UNC_None,1)*2; ones(nnoRw_UNC_None,1)*3];

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