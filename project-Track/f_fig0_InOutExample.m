clearvars;
rtDir = 'D:\Dropbox\SNL\P2_Track';
cd(rtDir);

%% Loading cell information
load('neuronList_ori_170922.mat');
Txls = readtable('neuronList_ori_170922.xlsx');
Txls.taskType = categorical(Txls.taskType);
formatOut = 'yymmdd';

%% analysis with place field (whether the field is in the stm zone or not)
% ##############################################################
% ############### stimulation (DRun or DRw) ####################
% ##############################################################

dirParent = 'D:\Dropbox\SNL\P2_Track\analysis_placefield\analysis_PF';
% rmdir(dirParent,'s');

DRunPN_PF_inField_act = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOut & T.idxSpikeIn == 1;
fileName = T.path(DRunPN_PF_inField_act);
cellID = T.cellID(DRunPN_PF_inField_act);
mkdir(dirParent,'DRun_inZone_act');
path = strcat(dirParent,'\DRun_inZone_act');
plot_Track_multi_v3(fileName, cellID, path);

DRunPN_PF_inField_ina = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOut & T.idxSpikeIn == -1;
fileName = T.path(DRunPN_PF_inField_ina);
cellID = T.cellID(DRunPN_PF_inField_ina);
mkdir(dirParent,'DRun_inZone_ina');
path = strcat(dirParent,'\DRun_inZone_ina');
plot_Track_multi_v3(fileName, cellID, path);

DRunPN_PF_inField_no = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOut & T.idxSpikeIn == 0;
fileName = T.path(DRunPN_PF_inField_no);
cellID = T.cellID(DRunPN_PF_inField_no);
mkdir(dirParent,'DRun_inZone_no');
path = strcat(dirParent,'\DRun_inZone_no');
plot_Track_multi_v3(fileName, cellID, path);

DRunPN_PF_outField_act = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOut & T.idxSpikeOut == 1;
fileName = T.path(DRunPN_PF_outField_act);
cellID = T.cellID(DRunPN_PF_outField_act);
mkdir(dirParent,'DRun_outZone_act');
path = strcat(dirParent,'\DRun_outZone_act');
plot_Track_multi_v3(fileName, cellID, path);

DRunPN_PF_outField_ina = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOut & T.idxSpikeOut == -1;
fileName = T.path(DRunPN_PF_outField_ina);
cellID = T.cellID(DRunPN_PF_outField_ina);
mkdir(dirParent,'DRun_outZone_ina');
path = strcat(dirParent,'\DRun_outZone_ina');
plot_Track_multi_v3(fileName, cellID, path);

DRunPN_PF_outField_no = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOut & T.idxSpikeOut == 0;
fileName = T.path(DRunPN_PF_outField_no);
cellID = T.cellID(DRunPN_PF_outField_no);
mkdir(dirParent,'DRun_outZone_no');
path = strcat(dirParent,'\DRun_outZone_no');
plot_Track_multi_v3(fileName, cellID, path);


DRwPN_PF_inField_act = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOut & T.idxSpikeIn == 1;
fileName = T.path(DRwPN_PF_inField_act);
cellID = T.cellID(DRwPN_PF_inField_act);
mkdir(dirParent,'DRw_inZone_act');
path = strcat(dirParent,'\DRw_inZone_act');
plot_Track_multi_v3(fileName, cellID, path);

DRwPN_PF_inField_ina = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOut & T.idxSpikeIn == -1;
fileName = T.path(DRwPN_PF_inField_ina);
cellID = T.cellID(DRwPN_PF_inField_ina);
mkdir(dirParent,'DRw_inZone_ina');
path = strcat(dirParent,'\DRw_inZone_ina');
plot_Track_multi_v3(fileName, cellID, path);

DRwPN_PF_inField_no = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOut & T.idxSpikeIn == 0;
fileName = T.path(DRwPN_PF_inField_no);
cellID = T.cellID(DRwPN_PF_inField_no);
mkdir(dirParent,'DRw_inZone_no');
path = strcat(dirParent,'\DRw_inZone_no');
plot_Track_multi_v3(fileName, cellID, path);

DRwPN_PF_outField_act = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOut & T.idxSpikeOut == 1;
fileName = T.path(DRwPN_PF_outField_act);
cellID = T.cellID(DRwPN_PF_outField_act);
mkdir(dirParent,'DRw_outZone_act');
path = strcat(dirParent,'\DRw_outZone_act');
plot_Track_multi_v3(fileName, cellID, path);

DRwPN_PF_outField_ina = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOut & T.idxSpikeOut == -1;
fileName = T.path(DRwPN_PF_outField_ina);
cellID = T.cellID(DRwPN_PF_outField_ina);
mkdir(dirParent,'DRw_outZone_ina');
path = strcat(dirParent,'\DRw_outZone_ina');
plot_Track_multi_v3(fileName, cellID, path);

DRwPN_PF_outField_no = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOut & T.idxSpikeOut == 0;
fileName = T.path(DRwPN_PF_outField_no);
cellID = T.cellID(DRwPN_PF_outField_no);
mkdir(dirParent,'DRw_outZone_no');
path = strcat(dirParent,'\DRw_outZone_no');
plot_Track_multi_v3(fileName, cellID, path);

% disp('ok');
% % ##############################################################
% % ############## No stimulation (noRun or noRw) ################
% % ##############################################################
noRunPN_PF_inField_act = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOut & T.idxSpikeIn == 1;
fileName = T.path(noRunPN_PF_inField_act);
cellID = T.cellID(noRunPN_PF_inField_act);
mkdir(dirParent,'noRun_inZone_act');
path = strcat(dirParent,'\noRun_inZone_act');
plot_Track_multi_v3(fileName, cellID, path);

noRunPN_PF_inField_ina = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOut & T.idxSpikeIn == -1;
fileName = T.path(noRunPN_PF_inField_ina);
cellID = T.cellID(noRunPN_PF_inField_ina);
mkdir(dirParent,'noRun_inZone_ina');
path = strcat(dirParent,'\noRun_inZone_ina');
plot_Track_multi_v3(fileName, cellID, path);

noRunPN_PF_inField_no = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOut & T.idxSpikeIn == 0;
fileName = T.path(noRunPN_PF_inField_no);
cellID = T.cellID(noRunPN_PF_inField_no);
mkdir(dirParent,'noRun_inZone_no');
path = strcat(dirParent,'\noRun_inZone_no');
plot_Track_multi_v3(fileName, cellID, path);

noRunPN_PF_outField_act = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOut & T.idxSpikeOut == 1;
fileName = T.path(noRunPN_PF_outField_act);
cellID = T.cellID(noRunPN_PF_outField_act);
mkdir(dirParent,'noRun_outZone_act');
path = strcat(dirParent,'\noRun_outZone_act');
plot_Track_multi_v3(fileName, cellID, path);

noRunPN_PF_outField_ina = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOut & T.idxSpikeOut == -1;
fileName = T.path(noRunPN_PF_outField_ina);
cellID = T.cellID(noRunPN_PF_outField_ina);
mkdir(dirParent,'noRun_outZone_ina');
path = strcat(dirParent,'\noRun_outZone_ina');
plot_Track_multi_v3(fileName, cellID, path);

noRunPN_PF_outField_no = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOut & T.idxSpikeOut == 0;
fileName = T.path(noRunPN_PF_outField_no);
cellID = T.cellID(noRunPN_PF_outField_no);
mkdir(dirParent,'noRun_outZone_no');
path = strcat(dirParent,'\noRun_outZone_no');
plot_Track_multi_v3(fileName, cellID, path);

noRwPN_PF_inField_act = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOut & T.idxSpikeIn == 1;
fileName = T.path(noRwPN_PF_inField_act);
cellID = T.cellID(noRwPN_PF_inField_act);
mkdir(dirParent,'noRw_inZone_act');
path = strcat(dirParent,'\noRw_inZone_act');
plot_Track_multi_v3(fileName, cellID, path);

noRwPN_PF_inField_ina = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOut & T.idxSpikeIn == -1;
fileName = T.path(noRwPN_PF_inField_ina);
cellID = T.cellID(noRwPN_PF_inField_ina);
mkdir(dirParent,'noRw_inZone_ina');
path = strcat(dirParent,'\noRw_inZone_ina');
plot_Track_multi_v3(fileName, cellID, path);

noRwPN_PF_inField_no = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOut & T.idxSpikeIn == 0;
fileName = T.path(noRwPN_PF_inField_no);
cellID = T.cellID(noRwPN_PF_inField_no);
mkdir(dirParent,'noRw_inZone_no');
path = strcat(dirParent,'\noRw_inZone_no');
plot_Track_multi_v3(fileName, cellID, path);

noRwPN_PF_outField_act = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOut & T.idxSpikeOut == 1;
fileName = T.path(noRwPN_PF_outField_act);
cellID = T.cellID(noRwPN_PF_outField_act);
mkdir(dirParent,'noRw_outZone_act');
path = strcat(dirParent,'\noRw_outZone_act');
plot_Track_multi_v3(fileName, cellID, path);

noRwPN_PF_outField_ina = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOut & T.idxSpikeOut == -1;
fileName = T.path(noRwPN_PF_outField_ina);
cellID = T.cellID(noRwPN_PF_outField_ina);
mkdir(dirParent,'noRw_outZone_ina');
path = strcat(dirParent,'\noRw_outZone_ina');
plot_Track_multi_v3(fileName, cellID, path);

noRwPN_PF_outField_no = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOut & T.idxSpikeOut == 0;
fileName = T.path(noRwPN_PF_outField_no);
cellID = T.cellID(noRwPN_PF_outField_no);
mkdir(dirParent,'noRw_outZone_no');
path = strcat(dirParent,'\noRw_outZone_no');
plot_Track_multi_v3(fileName, cellID, path);


% % ##############################################################
% % ############## non place field (DRun & DRw) ##################
% % ##############################################################
dirParent = 'D:\Dropbox\SNL\P2_Track\analysis_placefield\analysis_nPF';
rmdir(dirParent,'s');
DRunPN_nPF_inField_act = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxZoneInOut & T.idxSpikeIn == 1;
fileName = T.path(DRunPN_nPF_inField_act);
cellID = T.cellID(DRunPN_nPF_inField_act);
mkdir(dirParent,'DRun_inZone_act');
path = strcat(dirParent,'\DRun_inZone_act');
plot_Track_multi_v3(fileName, cellID, path);

DRunPN_nPF_inField_ina = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxZoneInOut & T.idxSpikeIn == -1;
fileName = T.path(DRunPN_nPF_inField_ina);
cellID = T.cellID(DRunPN_nPF_inField_ina);
mkdir(dirParent,'DRun_inZone_ina');
path = strcat(dirParent,'\DRun_inZone_ina');
plot_Track_multi_v3(fileName, cellID, path);

DRunPN_nPF_inField_no = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxZoneInOut & T.idxSpikeIn == 0;
fileName = T.path(DRunPN_nPF_inField_no);
cellID = T.cellID(DRunPN_nPF_inField_no);
mkdir(dirParent,'DRun_inZone_no');
path = strcat(dirParent,'\DRun_inZone_no');
plot_Track_multi_v3(fileName, cellID, path);

DRunPN_nPF_outField_act = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & ~T.idxZoneInOut & T.idxSpikeOut == 1;
fileName = T.path(DRunPN_nPF_outField_act);
cellID = T.cellID(DRunPN_nPF_outField_act);
mkdir(dirParent,'DRun_outZone_act');
path = strcat(dirParent,'\DRun_outZone_act');
plot_Track_multi_v3(fileName, cellID, path);

DRunPN_nPF_outField_ina = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & ~T.idxZoneInOut & T.idxSpikeOut == -1;
fileName = T.path(DRunPN_nPF_outField_ina);
cellID = T.cellID(DRunPN_nPF_outField_ina);
mkdir(dirParent,'DRun_outZone_ina');
path = strcat(dirParent,'\DRun_outZone_ina');
plot_Track_multi_v3(fileName, cellID, path);

DRunPN_nPF_outField_no = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & ~T.idxZoneInOut & T.idxSpikeOut == 0;
fileName = T.path(DRunPN_nPF_outField_no);
cellID = T.cellID(DRunPN_nPF_outField_no);
mkdir(dirParent,'DRun_outZone_no');
path = strcat(dirParent,'\DRun_outZone_no');
plot_Track_multi_v3(fileName, cellID, path);


DRwPN_nPF_inField_act = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxZoneInOut & T.idxSpikeIn == 1;
fileName = T.path(DRwPN_nPF_inField_act);
cellID = T.cellID(DRwPN_nPF_inField_act);
mkdir(dirParent,'DRw_inZone_act');
path = strcat(dirParent,'\DRw_inZone_act');
plot_Track_multi_v3(fileName, cellID, path);

DRwPN_nPF_inField_ina = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxZoneInOut & T.idxSpikeIn == -1;
fileName = T.path(DRwPN_nPF_inField_ina);
cellID = T.cellID(DRwPN_nPF_inField_ina);
mkdir(dirParent,'DRw_inZone_ina');
path = strcat(dirParent,'\DRw_inZone_ina');
plot_Track_multi_v3(fileName, cellID, path);

DRwPN_nPF_inField_no = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxZoneInOut & T.idxSpikeIn == 0;
fileName = T.path(DRwPN_nPF_inField_no);
cellID = T.cellID(DRwPN_nPF_inField_no);
mkdir(dirParent,'DRw_inZone_no');
path = strcat(dirParent,'\DRw_inZone_no');
plot_Track_multi_v3(fileName, cellID, path);

DRwPN_nPF_outField_act = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & ~T.idxZoneInOut & T.idxSpikeOut == 1;
fileName = T.path(DRwPN_nPF_outField_act);
cellID = T.cellID(DRwPN_nPF_outField_act);
mkdir(dirParent,'DRw_outZone_act');
path = strcat(dirParent,'\DRw_outZone_act');
plot_Track_multi_v3(fileName, cellID, path);

DRwPN_nPF_outField_ina = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & ~T.idxZoneInOut & T.idxSpikeOut == -1;
fileName = T.path(DRwPN_nPF_outField_ina);
cellID = T.cellID(DRwPN_nPF_outField_ina);
mkdir(dirParent,'DRw_outZone_ina');
path = strcat(dirParent,'\DRw_outZone_ina');
plot_Track_multi_v3(fileName, cellID, path);

DRwPN_nPF_outField_no = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & ~T.idxZoneInOut & T.idxSpikeOut == 0;
fileName = T.path(DRwPN_nPF_outField_no);
cellID = T.cellID(DRwPN_nPF_outField_no);
mkdir(dirParent,'DRw_outZone_no');
path = strcat(dirParent,'\DRw_outZone_no');
plot_Track_multi_v3(fileName, cellID, path);

% % ##############################################################
% % ############ non place field (noRun & noRw) ##################
% % ##############################################################
noRunPN_PF_inField_act = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxZoneInOut & T.idxSpikeIn == 1;
fileName = T.path(noRunPN_PF_inField_act);
cellID = T.cellID(noRunPN_PF_inField_act);
mkdir(dirParent,'noRun_inZone_act');
path = strcat(dirParent,'\noRun_inZone_act');
plot_Track_multi_v3(fileName, cellID, path);

noRunPN_PF_inField_ina = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxZoneInOut & T.idxSpikeIn == -1;
fileName = T.path(noRunPN_PF_inField_ina);
cellID = T.cellID(noRunPN_PF_inField_ina);
mkdir(dirParent,'noRun_inZone_ina');
path = strcat(dirParent,'\noRun_inZone_ina');
plot_Track_multi_v3(fileName, cellID, path);

noRunPN_PF_inField_no = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxZoneInOut & T.idxSpikeIn == 0;
fileName = T.path(noRunPN_PF_inField_no);
cellID = T.cellID(noRunPN_PF_inField_no);
mkdir(dirParent,'noRun_inZone_no');
path = strcat(dirParent,'\noRun_inZone_no');
plot_Track_multi_v3(fileName, cellID, path);

noRunPN_PF_outField_act = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & ~T.idxZoneInOut & T.idxSpikeOut == 1;
fileName = T.path(noRunPN_PF_outField_act);
cellID = T.cellID(noRunPN_PF_outField_act);
mkdir(dirParent,'noRun_outZone_act');
path = strcat(dirParent,'\noRun_outZone_act');
plot_Track_multi_v3(fileName, cellID, path);

noRunPN_PF_outField_ina = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & ~T.idxZoneInOut & T.idxSpikeOut == -1;
fileName = T.path(noRunPN_PF_outField_ina);
cellID = T.cellID(noRunPN_PF_outField_ina);
mkdir(dirParent,'noRun_outZone_ina');
path = strcat(dirParent,'\noRun_outZone_ina');
plot_Track_multi_v3(fileName, cellID, path);

noRunPN_PF_outField_no = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & ~T.idxZoneInOut & T.idxSpikeOut == 0;
fileName = T.path(noRunPN_PF_outField_no);
cellID = T.cellID(noRunPN_PF_outField_no);
mkdir(dirParent,'noRun_outZone_no');
path = strcat(dirParent,'\noRun_outZone_no');
plot_Track_multi_v3(fileName, cellID, path);


noRwPN_PF_inField_act = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxZoneInOut & T.idxSpikeIn == 1;
fileName = T.path(noRwPN_PF_inField_act);
cellID = T.cellID(noRwPN_PF_inField_act);
mkdir(dirParent,'noRw_inZone_act');
path = strcat(dirParent,'\noRw_inZone_act');
plot_Track_multi_v3(fileName, cellID, path);

noRwPN_PF_inField_ina = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxZoneInOut & T.idxSpikeIn == -1;
fileName = T.path(noRwPN_PF_inField_ina);
cellID = T.cellID(noRwPN_PF_inField_ina);
mkdir(dirParent,'noRw_inZone_ina');
path = strcat(dirParent,'\noRw_inZone_ina');
plot_Track_multi_v3(fileName, cellID, path);

noRwPN_PF_inField_no = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxZoneInOut & T.idxSpikeIn == 0;
fileName = T.path(noRwPN_PF_inField_no);
cellID = T.cellID(noRwPN_PF_inField_no);
mkdir(dirParent,'noRw_inZone_no');
path = strcat(dirParent,'\noRw_inZone_no');
plot_Track_multi_v3(fileName, cellID, path);

noRwPN_PF_outField_act = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & ~T.idxZoneInOut & T.idxSpikeOut == 1;
fileName = T.path(noRwPN_PF_outField_act);
cellID = T.cellID(noRwPN_PF_outField_act);
mkdir(dirParent,'noRw_outZone_act');
path = strcat(dirParent,'\noRw_outZone_act');
plot_Track_multi_v3(fileName, cellID, path);

noRwPN_PF_outField_ina = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & ~T.idxZoneInOut & T.idxSpikeOut == -1;
fileName = T.path(noRwPN_PF_outField_ina);
cellID = T.cellID(noRwPN_PF_outField_ina);
mkdir(dirParent,'noRw_outZone_ina');
path = strcat(dirParent,'\noRw_outZone_ina');
plot_Track_multi_v3(fileName, cellID, path);

noRwPN_PF_outField_no = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & ~T.idxZoneInOut & T.idxSpikeOut == 0;
fileName = T.path(noRwPN_PF_outField_no);
cellID = T.cellID(noRwPN_PF_outField_no);
mkdir(dirParent,'noRw_outZone_no');
path = strcat(dirParent,'\noRw_outZone_no');
plot_Track_multi_v3(fileName, cellID, path);