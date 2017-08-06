% plot_crossCorr_ver1

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


%% DRun correlation
% n
corrN_DRunPF = [length(T.rCorr1D_preXstm(~isnan(T.rCorr1D_preXstm(DRun_PF_In)))), length(T.rCorr1D_preXstm(~isnan(T.rCorr1D_preXstm(DRun_PF_Out)))), length(T.rCorr1D_preXstm(~isnan(T.rCorr1D_preXstm(DRun_PF_InOut)))), length(T.rCorr1D_preXstm(~isnan(T.rCorr1D_preXstm(DRun_PF_None))))];
corrN_noRunPF = [length(T.rCorr1D_preXstm(~isnan(T.rCorr1D_preXstm(noRun_PF_In)))), length(T.rCorr1D_preXstm(~isnan(T.rCorr1D_preXstm(noRun_PF_Out)))), length(T.rCorr1D_preXstm(~isnan(T.rCorr1D_preXstm(noRun_PF_InOut)))), length(T.rCorr1D_preXstm(~isnan(T.rCorr1D_preXstm(noRun_PF_None))))];

% mean-correlation
corrM_preXstm_DRunPF = [nanmean(T.rCorr1D_preXstm(DRun_PF_In)), nanmean(T.rCorr1D_preXstm(DRun_PF_Out)), nanmean(T.rCorr1D_preXstm(DRun_PF_InOut)), nanmean(T.rCorr1D_preXstm(DRun_PF_None))];
corrM_preXpost_DRunPF = [nanmean(T.rCorr1D_preXpost(DRun_PF_In)), nanmean(T.rCorr1D_preXpost(DRun_PF_Out)), nanmean(T.rCorr1D_preXpost(DRun_PF_InOut)), nanmean(T.rCorr1D_preXpost(DRun_PF_None))];
corrM_stmXpost_DRunPF = [nanmean(T.rCorr1D_stmXpost(DRun_PF_In)), nanmean(T.rCorr1D_stmXpost(DRun_PF_Out)), nanmean(T.rCorr1D_stmXpost(DRun_PF_InOut)), nanmean(T.rCorr1D_stmXpost(DRun_PF_None))];
corr_preXstm_noRunPF = [nanmean(T.rCorr1D_preXstm(noRun_PF_In)), nanmean(T.rCorr1D_preXstm(noRun_PF_Out)), nanmean(T.rCorr1D_preXstm(noRun_PF_InOut)), nanmean(T.rCorr1D_preXstm(noRun_PF_None))];
corr_preXpost_noRunPF = [nanmean(T.rCorr1D_preXpost(noRun_PF_In)), nanmean(T.rCorr1D_preXpost(noRun_PF_Out)), nanmean(T.rCorr1D_preXpost(noRun_PF_InOut)), nanmean(T.rCorr1D_preXpost(noRun_PF_None))];
corr_stmXpost_noRunPF = [nanmean(T.rCorr1D_stmXpost(noRun_PF_In)), nanmean(T.rCorr1D_stmXpost(noRun_PF_Out)), nanmean(T.rCorr1D_stmXpost(noRun_PF_InOut)), nanmean(T.rCorr1D_stmXpost(noRun_PF_None))];

% SEM
corrSem_preXstm_DRunPF = [nanmean(T.rCorr1D_preXstm(DRun_PF_In)), nanmean(T.rCorr1D_preXstm(DRun_PF_Out)), nanmean(T.rCorr1D_preXstm(DRun_PF_InOut)), nanmean(T.rCorr1D_preXstm(DRun_PF_None))];
corrSem_preXpost_DRunPF = [nanmean(T.rCorr1D_preXpost(DRun_PF_In)), nanmean(T.rCorr1D_preXpost(DRun_PF_Out)), nanmean(T.rCorr1D_preXpost(DRun_PF_InOut)), nanmean(T.rCorr1D_preXpost(DRun_PF_None))];
corrSem_stmXpost_DRunPF = [nanmean(T.rCorr1D_stmXpost(DRun_PF_In)), nanmean(T.rCorr1D_stmXpost(DRun_PF_Out)), nanmean(T.rCorr1D_stmXpost(DRun_PF_InOut)), nanmean(T.rCorr1D_stmXpost(DRun_PF_None))];
corrSem_preXstm_noRunPF = [nanmean(T.rCorr1D_preXstm(noRun_PF_In)), nanmean(T.rCorr1D_preXstm(noRun_PF_Out)), nanmean(T.rCorr1D_preXstm(noRun_PF_InOut)), nanmean(T.rCorr1D_preXstm(noRun_PF_None))];
corrSem_preXpost_noRunPF = [nanmean(T.rCorr1D_preXpost(noRun_PF_In)), nanmean(T.rCorr1D_preXpost(noRun_PF_Out)), nanmean(T.rCorr1D_preXpost(noRun_PF_InOut)), nanmean(T.rCorr1D_preXpost(noRun_PF_None))];
corrSem_stmXpost_noRunPF = [nanmean(T.rCorr1D_stmXpost(noRun_PF_In)), nanmean(T.rCorr1D_stmXpost(noRun_PF_Out)), nanmean(T.rCorr1D_stmXpost(noRun_PF_InOut)), nanmean(T.rCorr1D_stmXpost(noRun_PF_None))];


%% DRw correlation
% n
corrN_DRwPF = [length(T.rCorr1D_preXstm(~isnan(T.rCorr1D_preXstm(DRw_PF_In)))), length(T.rCorr1D_preXstm(~isnan(T.rCorr1D_preXstm(DRw_PF_Out)))), length(T.rCorr1D_preXstm(~isnan(T.rCorr1D_preXstm(DRw_PF_InOut)))), length(T.rCorr1D_preXstm(~isnan(T.rCorr1D_preXstm(DRw_PF_None))))];
corrN_noRwPF = [length(T.rCorr1D_preXstm(~isnan(T.rCorr1D_preXstm(noRw_PF_In)))), length(T.rCorr1D_preXstm(~isnan(T.rCorr1D_preXstm(noRw_PF_Out)))), length(T.rCorr1D_preXstm(~isnan(T.rCorr1D_preXstm(noRw_PF_InOut)))), length(T.rCorr1D_preXstm(~isnan(T.rCorr1D_preXstm(noRw_PF_None))))];

% mean-correlation
corrM_preXstm_DRwPF = [nanmean(T.rCorr1D_preXstm(DRw_PF_In)), nanmean(T.rCorr1D_preXstm(DRw_PF_Out)), nanmean(T.rCorr1D_preXstm(DRw_PF_InOut)), nanmean(T.rCorr1D_preXstm(DRw_PF_None))];
corrM_preXpost_DRwPF = [nanmean(T.rCorr1D_preXpost(DRw_PF_In)), nanmean(T.rCorr1D_preXpost(DRw_PF_Out)), nanmean(T.rCorr1D_preXpost(DRw_PF_InOut)), nanmean(T.rCorr1D_preXpost(DRw_PF_None))];
corrM_stmXpost_DRwPF = [nanmean(T.rCorr1D_stmXpost(DRw_PF_In)), nanmean(T.rCorr1D_stmXpost(DRw_PF_Out)), nanmean(T.rCorr1D_stmXpost(DRw_PF_InOut)), nanmean(T.rCorr1D_stmXpost(DRw_PF_None))];
corr_preXstm_noRwPF = [nanmean(T.rCorr1D_preXstm(noRw_PF_In)), nanmean(T.rCorr1D_preXstm(noRw_PF_Out)), nanmean(T.rCorr1D_preXstm(noRw_PF_InOut)), nanmean(T.rCorr1D_preXstm(noRw_PF_None))];
corr_preXpost_noRwPF = [nanmean(T.rCorr1D_preXpost(noRw_PF_In)), nanmean(T.rCorr1D_preXpost(noRw_PF_Out)), nanmean(T.rCorr1D_preXpost(noRw_PF_InOut)), nanmean(T.rCorr1D_preXpost(noRw_PF_None))];
corr_stmXpost_noRwPF = [nanmean(T.rCorr1D_stmXpost(noRw_PF_In)), nanmean(T.rCorr1D_stmXpost(noRw_PF_Out)), nanmean(T.rCorr1D_stmXpost(noRw_PF_InOut)), nanmean(T.rCorr1D_stmXpost(noRw_PF_None))];

% SEM
corrSem_preXstm_DRwPF = [nanmean(T.rCorr1D_preXstm(DRw_PF_In)), nanmean(T.rCorr1D_preXstm(DRw_PF_Out)), nanmean(T.rCorr1D_preXstm(DRw_PF_InOut)), nanmean(T.rCorr1D_preXstm(DRw_PF_None))];
corrSem_preXpost_DRwPF = [nanmean(T.rCorr1D_preXpost(DRw_PF_In)), nanmean(T.rCorr1D_preXpost(DRw_PF_Out)), nanmean(T.rCorr1D_preXpost(DRw_PF_InOut)), nanmean(T.rCorr1D_preXpost(DRw_PF_None))];
corrSem_stmXpost_DRwPF = [nanmean(T.rCorr1D_stmXpost(DRw_PF_In)), nanmean(T.rCorr1D_stmXpost(DRw_PF_Out)), nanmean(T.rCorr1D_stmXpost(DRw_PF_InOut)), nanmean(T.rCorr1D_stmXpost(DRw_PF_None))];
corrSem_preXstm_noRwPF = [nanmean(T.rCorr1D_preXstm(noRw_PF_In)), nanmean(T.rCorr1D_preXstm(noRw_PF_Out)), nanmean(T.rCorr1D_preXstm(noRw_PF_InOut)), nanmean(T.rCorr1D_preXstm(noRw_PF_None))];
corrSem_preXpost_noRwPF = [nanmean(T.rCorr1D_preXpost(noRw_PF_In)), nanmean(T.rCorr1D_preXpost(noRw_PF_Out)), nanmean(T.rCorr1D_preXpost(noRw_PF_InOut)), nanmean(T.rCorr1D_preXpost(noRw_PF_None))];
corrSem_stmXpost_noRwPF = [nanmean(T.rCorr1D_stmXpost(noRw_PF_In)), nanmean(T.rCorr1D_stmXpost(noRw_PF_Out)), nanmean(T.rCorr1D_stmXpost(noRw_PF_InOut)), nanmean(T.rCorr1D_stmXpost(noRw_PF_None))];



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