clearvars;
rtDir = 'D:\Dropbox\SNL\P2_Track';
cd(rtDir);

alpha = 0.01;
areaDRun = [5/6 4/3]*pi*20; % 6-9 o'clock
areaDRw = [3/2 5/3]*pi*20; % 10-11 o'clock
areaRw1 = [1/2 2/3]*pi*20; % 4-5 o'clock
areaRw2 = [3/2 5/3]*pi*20; % 10-11 o'clock
errorPosi = 5;
correctY = 0.5;
lightBand = 3;

%% Loading cell information
% load('neuronList_ori_171018.mat');
% Txls = readtable('neuronList_ori_171018.xlsx');
% Txls.taskType = categorical(Txls.taskType);
load('neuronList_ori_180128_bin5sd2.mat');
formatOut = 'yymmdd';

%% separation of place cells from non place cell
% place cell
% dirParent = 'D:\Dropbox\SNL\P2_Track\analysis_placefield\total_PF';
% rmdir(dirParent,'s');
% 
% group = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
% fileName = T.path(group);
% cellID = T.cellID(group);
% % mkdir(dirParent,'DRun');
% path = 'C:\Users\Jun\Desktop\pcDRun';
% plot_Track_multi_v3(fileName,cellID,path);

% group = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
% fileName = T.path(group);
% cellID = T.cellID(group);
% % mkdir(dirParent,'DRw');
% path = 'C:\Users\Jun\Desktop\pcDRw';
% plot_Track_multi_v3(fileName,cellID,path);
% 
% group = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
% fileName = T.path(group);
% cellID = T.cellID(group);
% mkdir(dirParent,'noRun');
% path = strcat(dirParent,'\noRun');
% plot_Track_multi_v3(fileName,cellID,path);
% 
% group = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
% fileName = T.path(group);
% cellID = T.cellID(group);
% mkdir(dirParent,'noRw');
% path = strcat(dirParent,'\noRw');
% plot_Track_multi_v3(fileName,cellID,path);

% non place cell
% dirParent = 'D:\Dropbox\SNL\P2_Track\analysis_placefield\total_nPF';
% rmdir(dirParent,'s');
% 
% group = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum);
% fileName = T.path(group);
% cellID = T.cellID(group);
% mkdir(dirParent,'DRun');
% path = strcat(dirParent,'\DRun');
% plot_Track_multi_v3(fileName,cellID,path);
% 
% group = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum);
% fileName = T.path(group);
% cellID = T.cellID(group);
% mkdir(dirParent,'DRw');
% path = strcat(dirParent,'\DRw');
% plot_Track_multi_v3(fileName,cellID,path);
% 
% group = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum);
% fileName = T.path(group);
% cellID = T.cellID(group);
% mkdir(dirParent,'noRun');
% path = strcat(dirParent,'\noRun');
% plot_Track_multi_v3(fileName,cellID,path);
% 
% group = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum);
% fileName = T.path(group);
% cellID = T.cellID(group);
% mkdir(dirParent,'noRw');
% path = strcat(dirParent,'\noRw');
% plot_Track_multi_v3(fileName,cellID,path);

% interneuron
% dirParent = 'D:\Dropbox\SNL\P2_Track\analysis_placefield\total_IN';
% rmdir(dirParent,'s');
% 
% group = T.taskType == 'DRun' & T.idxNeurontype == 'IN';
% fileName = T.path(group);
% cellID = T.cellID(group);
% mkdir(dirParent,'DRun');
% path = strcat(dirParent,'\DRun');
% plot_Track_multi_v3(fileName,cellID,path);
% 
% group = T.taskType == 'DRw' & T.idxNeurontype == 'IN';
% fileName = T.path(group);
% cellID = T.cellID(group);
% mkdir(dirParent,'DRw');
% path = strcat(dirParent,'\DRw');
% plot_Track_multi_v3(fileName,cellID,path);
% 
% group = T.taskType == 'noRun' & T.idxNeurontype == 'IN';
% fileName = T.path(group);
% cellID = T.cellID(group);
% mkdir(dirParent,'noRun');
% path = strcat(dirParent,'\noRun');
% plot_Track_multi_v3(fileName,cellID,path);
% 
% group = T.taskType == 'noRw' & T.idxNeurontype == 'IN';
% fileName = T.path(group);
% cellID = T.cellID(group);
% mkdir(dirParent,'noRw');
% path = strcat(dirParent,'\noRw');
% plot_Track_multi_v3(fileName,cellID,path);

% unclassified
% dirParent = 'D:\Dropbox\SNL\P2_Track\analysis_placefield\total_UNC';
% rmdir(dirParent,'s');
% 
% group = T.taskType == 'DRun' & T.idxNeurontype == 'UNC';
% fileName = T.path(group);
% cellID = T.cellID(group);
% mkdir(dirParent,'DRun');
% path = strcat(dirParent,'\DRun');
% plot_Track_multi_v3(fileName,cellID,path);
% 
% group = T.taskType == 'DRw' & T.idxNeurontype == 'UNC';
% fileName = T.path(group);
% cellID = T.cellID(group);
% mkdir(dirParent,'DRw');
% path = strcat(dirParent,'\DRw');
% plot_Track_multi_v3(fileName,cellID,path);
% 
% group = T.taskType == 'noRun' & T.idxNeurontype == 'UNC';
% fileName = T.path(group);
% cellID = T.cellID(group);
% mkdir(dirParent,'noRun');
% path = strcat(dirParent,'\noRun');
% plot_Track_multi_v3(fileName,cellID,path);
% 
% group = T.taskType == 'noRw' & T.idxNeurontype == 'UNC';
% fileName = T.path(group);
% cellID = T.cellID(group);
% mkdir(dirParent,'noRw');
% path = strcat(dirParent,'\noRw');
% plot_Track_multi_v3(fileName,cellID,path);
%% analysis with place field (whether the field is in the stm zone or not)
% ##############################################################
% ############### stimulation (DRun or DRw) ####################
% ##############################################################

% dirParent = 'D:\Dropbox\SNL\P2_Track\analysis_placefield\analysis_PF';
% rmdir(dirParent,'s');
% 
% DRunPN_PF_inField_act = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == 1;
% fileName = T.path(DRunPN_PF_inField_act);
% cellID = T.cellID(DRunPN_PF_inField_act);
% mkdir(dirParent,'DRun_inZone_act');
% path = strcat(dirParent,'\DRun_inZone_act');
% plot_Track_multi_v3(fileName, cellID, path);
% 
% DRunPN_PF_inField_ina = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == -1;
% fileName = T.path(DRunPN_PF_inField_ina);
% cellID = T.cellID(DRunPN_PF_inField_ina);
% mkdir(dirParent,'DRun_inZone_ina');
% path = strcat(dirParent,'\DRun_inZone_ina');
% plot_Track_multi_v3(fileName, cellID, path);
% 
% DRunPN_PF_inField_no = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOut & ~T.idxpLR_Track;
% fileName = T.path(DRunPN_PF_inField_no);
% cellID = T.cellID(DRunPN_PF_inField_no);
% mkdir(dirParent,'DRun_inZone_no');
% path = strcat(dirParent,'\DRun_inZone_no');
% plot_Track_multi_v3(fileName, cellID, path);
% 
% DRunPN_PF_outField_act = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == 1;
% fileName = T.path(DRunPN_PF_outField_act);
% cellID = T.cellID(DRunPN_PF_outField_act);
% mkdir(dirParent,'DRun_outZone_act');
% path = strcat(dirParent,'\DRun_outZone_act');
% plot_Track_multi_v3(fileName, cellID, path);
% 
% DRunPN_PF_outField_ina = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == -1;
% fileName = T.path(DRunPN_PF_outField_ina);
% cellID = T.cellID(DRunPN_PF_outField_ina);
% mkdir(dirParent,'DRun_outZone_ina');
% path = strcat(dirParent,'\DRun_outZone_ina');
% plot_Track_multi_v3(fileName, cellID, path);
% 
% DRunPN_PF_outField_no = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOut & ~T.idxpLR_Track;
% fileName = T.path(DRunPN_PF_outField_no);
% cellID = T.cellID(DRunPN_PF_outField_no);
% mkdir(dirParent,'DRun_outZone_no');
% path = strcat(dirParent,'\DRun_outZone_no');
% plot_Track_multi_v3(fileName, cellID, path);
% 
% 
% DRwPN_PF_inField_act = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == 1;
% fileName = T.path(DRwPN_PF_inField_act);
% cellID = T.cellID(DRwPN_PF_inField_act);
% mkdir(dirParent,'DRw_inZone_act');
% path = strcat(dirParent,'\DRw_inZone_act');
% plot_Track_multi_v3(fileName, cellID, path);
% 
% DRwPN_PF_inField_ina = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == -1;
% fileName = T.path(DRwPN_PF_inField_ina);
% cellID = T.cellID(DRwPN_PF_inField_ina);
% mkdir(dirParent,'DRw_inZone_ina');
% path = strcat(dirParent,'\DRw_inZone_ina');
% plot_Track_multi_v3(fileName, cellID, path);
% 
% DRwPN_PF_inField_no = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOut & ~T.idxpLR_Track;
% fileName = T.path(DRwPN_PF_inField_no);
% cellID = T.cellID(DRwPN_PF_inField_no);
% mkdir(dirParent,'DRw_inZone_no');
% path = strcat(dirParent,'\DRw_inZone_no');
% plot_Track_multi_v3(fileName, cellID, path);
% 
% DRwPN_PF_outField_act = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == 1;
% fileName = T.path(DRwPN_PF_outField_act);
% cellID = T.cellID(DRwPN_PF_outField_act);
% mkdir(dirParent,'DRw_outZone_act');
% path = strcat(dirParent,'\DRw_outZone_act');
% plot_Track_multi_v3(fileName, cellID, path);
% 
% DRwPN_PF_outField_ina = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == -1;
% fileName = T.path(DRwPN_PF_outField_ina);
% cellID = T.cellID(DRwPN_PF_outField_ina);
% mkdir(dirParent,'DRw_outZone_ina');
% path = strcat(dirParent,'\DRw_outZone_ina');
% plot_Track_multi_v3(fileName, cellID, path);
% 
% DRwPN_PF_outField_no = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOut & ~T.idxpLR_Track;
% fileName = T.path(DRwPN_PF_outField_no);
% cellID = T.cellID(DRwPN_PF_outField_no);
% mkdir(dirParent,'DRw_outZone_no');
% path = strcat(dirParent,'\DRw_outZone_no');
% plot_Track_multi_v3(fileName, cellID, path);
% 
% % disp('ok');
% % % ##############################################################
% % % ############## No stimulation (noRun or noRw) ################
% % % ##############################################################
% noRunPN_PF_inField_act = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == 1;
% fileName = T.path(noRunPN_PF_inField_act);
% cellID = T.cellID(noRunPN_PF_inField_act);
% mkdir(dirParent,'noRun_inZone_act');
% path = strcat(dirParent,'\noRun_inZone_act');
% plot_Track_multi_v3(fileName, cellID, path);
% 
% noRunPN_PF_inField_ina = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == -1;
% fileName = T.path(noRunPN_PF_inField_ina);
% cellID = T.cellID(noRunPN_PF_inField_ina);
% mkdir(dirParent,'noRun_inZone_ina');
% path = strcat(dirParent,'\noRun_inZone_ina');
% plot_Track_multi_v3(fileName, cellID, path);
% 
% noRunPN_PF_inField_no = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOut & ~T.idxpLR_Track;
% fileName = T.path(noRunPN_PF_inField_no);
% cellID = T.cellID(noRunPN_PF_inField_no);
% mkdir(dirParent,'noRun_inZone_no');
% path = strcat(dirParent,'\noRun_inZone_no');
% plot_Track_multi_v3(fileName, cellID, path);
% 
% noRunPN_PF_outField_act = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == 1;
% fileName = T.path(noRunPN_PF_outField_act);
% cellID = T.cellID(noRunPN_PF_outField_act);
% mkdir(dirParent,'noRun_outZone_act');
% path = strcat(dirParent,'\noRun_outZone_act');
% plot_Track_multi_v3(fileName, cellID, path);
% 
% noRunPN_PF_outField_ina = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == -1;
% fileName = T.path(noRunPN_PF_outField_ina);
% cellID = T.cellID(noRunPN_PF_outField_ina);
% mkdir(dirParent,'noRun_outZone_ina');
% path = strcat(dirParent,'\noRun_outZone_ina');
% plot_Track_multi_v3(fileName, cellID, path);
% 
% noRunPN_PF_outField_no = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOut & ~T.idxpLR_Track;
% fileName = T.path(noRunPN_PF_outField_no);
% cellID = T.cellID(noRunPN_PF_outField_no);
% mkdir(dirParent,'noRun_outZone_no');
% path = strcat(dirParent,'\noRun_outZone_no');
% plot_Track_multi_v3(fileName, cellID, path);
% 
% noRwPN_PF_inField_act = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == 1;
% fileName = T.path(noRwPN_PF_inField_act);
% cellID = T.cellID(noRwPN_PF_inField_act);
% mkdir(dirParent,'noRw_inZone_act');
% path = strcat(dirParent,'\noRw_inZone_act');
% plot_Track_multi_v3(fileName, cellID, path);
% 
% noRwPN_PF_inField_ina = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == -1;
% fileName = T.path(noRwPN_PF_inField_ina);
% cellID = T.cellID(noRwPN_PF_inField_ina);
% mkdir(dirParent,'noRw_inZone_ina');
% path = strcat(dirParent,'\noRw_inZone_ina');
% plot_Track_multi_v3(fileName, cellID, path);
% 
% noRwPN_PF_inField_no = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOut & ~T.idxpLR_Track;
% fileName = T.path(noRwPN_PF_inField_no);
% cellID = T.cellID(noRwPN_PF_inField_no);
% mkdir(dirParent,'noRw_inZone_no');
% path = strcat(dirParent,'\noRw_inZone_no');
% plot_Track_multi_v3(fileName, cellID, path);
% 
% noRwPN_PF_outField_act = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == 1;
% fileName = T.path(noRwPN_PF_outField_act);
% cellID = T.cellID(noRwPN_PF_outField_act);
% mkdir(dirParent,'noRw_outZone_act');
% path = strcat(dirParent,'\noRw_outZone_act');
% plot_Track_multi_v3(fileName, cellID, path);
% 
% noRwPN_PF_outField_ina = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == -1;
% fileName = T.path(noRwPN_PF_outField_ina);
% cellID = T.cellID(noRwPN_PF_outField_ina);
% mkdir(dirParent,'noRw_outZone_ina');
% path = strcat(dirParent,'\noRw_outZone_ina');
% plot_Track_multi_v3(fileName, cellID, path);
% 
% noRwPN_PF_outField_no = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOut & ~T.idxpLR_Track;
% fileName = T.path(noRwPN_PF_outField_no);
% cellID = T.cellID(noRwPN_PF_outField_no);
% mkdir(dirParent,'noRw_outZone_no');
% path = strcat(dirParent,'\noRw_outZone_no');
% plot_Track_multi_v3(fileName, cellID, path);


% % ##############################################################
% % ############## non place field (DRun & DRw) ##################
% % ##############################################################
% dirParent = 'D:\Dropbox\SNL\P2_Track\analysis_placefield\analysis_nPF';
% rmdir(dirParent,'s');
% DRunPN_nPF_inField_act = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == 1;
% fileName = T.path(DRunPN_nPF_inField_act);
% cellID = T.cellID(DRunPN_nPF_inField_act);
% mkdir(dirParent,'DRun_inZone_act');
% path = strcat(dirParent,'\DRun_inZone_act');
% plot_Track_multi_v3(fileName, cellID, path);

% DRunPN_nPF_inField_ina = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == -1;
% fileName = T.path(DRunPN_nPF_inField_ina);
% cellID = T.cellID(DRunPN_nPF_inField_ina);
% mkdir(dirParent,'DRun_inZone_ina');
% path = strcat(dirParent,'\DRun_inZone_ina');
% plot_Track_multi_v3(fileName, cellID, path);

% DRunPN_nPF_inField_no = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxZoneInOut & ~T.idxpLR_Track;
% fileName = T.path(DRunPN_nPF_inField_no);
% cellID = T.cellID(DRunPN_nPF_inField_no);
% mkdir(dirParent,'DRun_inZone_no');
% path = strcat(dirParent,'\DRun_inZone_no');
% plot_Track_multi_v3(fileName, cellID, path);

% DRunPN_nPF_outField_act = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & ~T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == 1;
% fileName = T.path(DRunPN_nPF_outField_act);
% cellID = T.cellID(DRunPN_nPF_outField_act);
% mkdir(dirParent,'DRun_outZone_act');
% path = strcat(dirParent,'\DRun_outZone_act');
% plot_Track_multi_v3(fileName, cellID, path);

% DRunPN_nPF_outField_ina = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & ~T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == -1;
% fileName = T.path(DRunPN_nPF_outField_ina);
% cellID = T.cellID(DRunPN_nPF_outField_ina);
% mkdir(dirParent,'DRun_outZone_ina');
% path = strcat(dirParent,'\DRun_outZone_ina');
% plot_Track_multi_v3(fileName, cellID, path);

% DRunPN_nPF_outField_no = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & ~T.idxZoneInOut & ~T.idxpLR_Track;
% fileName = T.path(DRunPN_nPF_outField_no);
% cellID = T.cellID(DRunPN_nPF_outField_no);
% mkdir(dirParent,'DRun_outZone_no');
% path = strcat(dirParent,'\DRun_outZone_no');
% plot_Track_multi_v3(fileName, cellID, path);


% DRwPN_nPF_inField_act = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == 1;
% fileName = T.path(DRwPN_nPF_inField_act);
% cellID = T.cellID(DRwPN_nPF_inField_act);
% mkdir(dirParent,'DRw_inZone_act');
% path = strcat(dirParent,'\DRw_inZone_act');
% plot_Track_multi_v3(fileName, cellID, path);

% DRwPN_nPF_inField_ina = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == -1;
% fileName = T.path(DRwPN_nPF_inField_ina);
% cellID = T.cellID(DRwPN_nPF_inField_ina);
% mkdir(dirParent,'DRw_inZone_ina');
% path = strcat(dirParent,'\DRw_inZone_ina');
% plot_Track_multi_v3(fileName, cellID, path);

% DRwPN_nPF_inField_no = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxZoneInOut & ~T.idxpLR_Track;
% fileName = T.path(DRwPN_nPF_inField_no);
% cellID = T.cellID(DRwPN_nPF_inField_no);
% mkdir(dirParent,'DRw_inZone_no');
% path = strcat(dirParent,'\DRw_inZone_no');
% plot_Track_multi_v3(fileName, cellID, path);

% DRwPN_nPF_outField_act = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & ~T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == 1;
% fileName = T.path(DRwPN_nPF_outField_act);
% cellID = T.cellID(DRwPN_nPF_outField_act);
% mkdir(dirParent,'DRw_outZone_act');
% path = strcat(dirParent,'\DRw_outZone_act');
% plot_Track_multi_v3(fileName, cellID, path);

% DRwPN_nPF_outField_ina = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & ~T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == -1;
% fileName = T.path(DRwPN_nPF_outField_ina);
% cellID = T.cellID(DRwPN_nPF_outField_ina);
% mkdir(dirParent,'DRw_outZone_ina');
% path = strcat(dirParent,'\DRw_outZone_ina');
% plot_Track_multi_v3(fileName, cellID, path);

% DRwPN_nPF_outField_no = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & ~T.idxZoneInOut & ~T.idxpLR_Track;
% fileName = T.path(DRwPN_nPF_outField_no);
% cellID = T.cellID(DRwPN_nPF_outField_no);
% mkdir(dirParent,'DRw_outZone_no');
% path = strcat(dirParent,'\DRw_outZone_no');
% plot_Track_multi_v3(fileName, cellID, path);

% % ##############################################################
% % ############ non place field (noRun & noRw) ##################
% % ##############################################################
% noRunPN_PF_inField_act = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == 1;
% fileName = T.path(noRunPN_PF_inField_act);
% cellID = T.cellID(noRunPN_PF_inField_act);
% mkdir(dirParent,'noRun_inZone_act');
% path = strcat(dirParent,'\noRun_inZone_act');
% plot_Track_multi_v3(fileName, cellID, path);

% noRunPN_PF_inField_ina = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == -1;
% fileName = T.path(noRunPN_PF_inField_ina);
% cellID = T.cellID(noRunPN_PF_inField_ina);
% mkdir(dirParent,'noRun_inZone_ina');
% path = strcat(dirParent,'\noRun_inZone_ina');
% plot_Track_multi_v3(fileName, cellID, path);

% noRunPN_PF_inField_no = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxZoneInOut & ~T.idxpLR_Track;
% fileName = T.path(noRunPN_PF_inField_no);
% cellID = T.cellID(noRunPN_PF_inField_no);
% mkdir(dirParent,'noRun_inZone_no');
% path = strcat(dirParent,'\noRun_inZone_no');
% plot_Track_multi_v3(fileName, cellID, path);

% noRunPN_PF_outField_act = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & ~T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == 1;
% fileName = T.path(noRunPN_PF_outField_act);
% cellID = T.cellID(noRunPN_PF_outField_act);
% mkdir(dirParent,'noRun_outZone_act');
% path = strcat(dirParent,'\noRun_outZone_act');
% plot_Track_multi_v3(fileName, cellID, path);

% noRunPN_PF_outField_ina = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & ~T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == -1;
% fileName = T.path(noRunPN_PF_outField_ina);
% cellID = T.cellID(noRunPN_PF_outField_ina);
% mkdir(dirParent,'noRun_outZone_ina');
% path = strcat(dirParent,'\noRun_outZone_ina');
% plot_Track_multi_v3(fileName, cellID, path);

% noRunPN_PF_outField_no = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & ~T.idxZoneInOut & ~T.idxpLR_Track;
% fileName = T.path(noRunPN_PF_outField_no);
% cellID = T.cellID(noRunPN_PF_outField_no);
% mkdir(dirParent,'noRun_outZone_no');
% path = strcat(dirParent,'\noRun_outZone_no');
% plot_Track_multi_v3(fileName, cellID, path);


% noRwPN_PF_inField_act = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == 1;
% fileName = T.path(noRwPN_PF_inField_act);
% cellID = T.cellID(noRwPN_PF_inField_act);
% mkdir(dirParent,'noRw_inZone_act');
% path = strcat(dirParent,'\noRw_inZone_act');
% plot_Track_multi_v3(fileName, cellID, path);

% noRwPN_PF_inField_ina = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == -1;
% fileName = T.path(noRwPN_PF_inField_ina);
% cellID = T.cellID(noRwPN_PF_inField_ina);
% mkdir(dirParent,'noRw_inZone_ina');
% path = strcat(dirParent,'\noRw_inZone_ina');
% plot_Track_multi_v3(fileName, cellID, path);

% noRwPN_PF_inField_no = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxZoneInOut & ~T.idxpLR_Track;
% fileName = T.path(noRwPN_PF_inField_no);
% cellID = T.cellID(noRwPN_PF_inField_no);
% mkdir(dirParent,'noRw_inZone_no');
% path = strcat(dirParent,'\noRw_inZone_no');
% plot_Track_multi_v3(fileName, cellID, path);

% noRwPN_PF_outField_act = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & ~T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == 1;
% fileName = T.path(noRwPN_PF_outField_act);
% cellID = T.cellID(noRwPN_PF_outField_act);
% mkdir(dirParent,'noRw_outZone_act');
% path = strcat(dirParent,'\noRw_outZone_act');
% plot_Track_multi_v3(fileName, cellID, path);

% noRwPN_PF_outField_ina = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & ~T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == -1;
% fileName = T.path(noRwPN_PF_outField_ina);
% cellID = T.cellID(noRwPN_PF_outField_ina);
% mkdir(dirParent,'noRw_outZone_ina');
% path = strcat(dirParent,'\noRw_outZone_ina');
% plot_Track_multi_v3(fileName, cellID, path);

% noRwPN_PF_outField_no = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & ~T.idxZoneInOut & ~T.idxpLR_Track;
% fileName = T.path(noRwPN_PF_outField_no);
% cellID = T.cellID(noRwPN_PF_outField_no);
% mkdir(dirParent,'noRw_outZone_no');
% path = strcat(dirParent,'\noRw_outZone_no');
% plot_Track_multi_v3(fileName, cellID, path);

%% All neurons separated by sessions (DRun, DRw, noRun, noRw)
% DRunPN = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
% DRwPN = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;

noRunPN = T.taskType == 'noRun';
noRwPN = T.taskType == 'noRw';

% fileName = T.path(DRunPN);
% cellID = T.cellID(DRunPN);
% plot_Track_multi_v3(fileName, cellID, 'C:\Users\Jun\Desktop\test');

% fileName = T.path(DRunIN);
% cellID = Txls.cellID(DRunIN);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_totalDRun\IN');

% fileName = T.path(DRwPN);
% cellID = Txls.cellID(DRwPN);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\example_DRwPC');

% fileName = T.path(DRwIN);
% cellID = Txls.cellID(DRwIN);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_totalDRw\IN');

% fileName = T.path(noRunPN);
% nFile = length(fileName);
% for iFile = 1:nFile
%     [cellPath,~,~] = fileparts(fileName{iFile});
%     filePath{iFile,1} = cellPath;
% end
% filePath = unique(filePath);
% nPath = length(filePath);
% 
% for iPath = 1:nPath
%     cd(filePath{iPath});
%     delete('*.tif');
%     delete('*.tiff');
%     plot_Track_sin_v3;
% end
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\example_noRunPC');

% fileName = T.path(noRunIN);
% cellID = Txls.cellID(noRunIN);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_totalnoRun\IN');

fileName = T.path(noRwPN);
nFile = length(fileName);
for iFile = 1:nFile
    [cellPath,~,~] = fileparts(fileName{iFile});
    filePath{iFile,1} = cellPath;
end
filePath = unique(filePath);
nPath = length(filePath);

for iPath = 1:nPath
    cd(filePath{iPath});
    delete('*.tif');
    delete('*.tiff');
    plot_Track_sin_v3;
end
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\example_noRwPC');

% fileName = T.path(noRwIN);
% cellID = Txls.cellID(noRwIN);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_totalnoRw\IN');
%% Session compare
% compareID = ~isnan(T.compCellID); % find non-nan index
% nComp = max(T.compCellID(compareID));
% parentDir = 'D:\Dropbox\#team_hippocampus Team Folder\project_Track\samples_v9\group';
% for iCell = 1:nComp
%    fileName = T.path(T.compCellID == iCell);
%    cellID = T.cellID(T.compCellID == iCell);
%    mkdir(parentDir, ['comp_',num2str(iCell)]);
%    plot_Track_multi_v3(fileName,cellID,[parentDir,'\comp_',num2str(iCell)]);   
% end
% cd(parentDir);
% compPlace = ~isnan(T.compCellID) & (T.placefieldTrack == 1);
% list_compPlace = T.cellID(compPlace);
% 
% compPlaceinStm = ~isnan(T.compCellID) & (T.placefieldStmZone == 1);
% list_compPlaceStm = T.cellID(compPlaceinStm);
% cd('D:\Dropbox\SNL\P2_Track');

%% Light response
% DRunPN = (T.taskType == 'DRun') & T.pLR_Track<alpha;
% fd_sigDRun = [folder, 'light_sigDRun'];
% fileName = T.path(DRunPN);
% cellID = Txls.cellID(DRunPN);
% plot_Track_multi_v3(fileName, cellID, fd_sigDRun);
% 
% nosig_DRun = (T.taskType == 'DRun') & ((T.pLR_Plfm2hz>alpha) & (T.pLR_Track>alpha));
% fd_nosigDRun = [folder, 'light_nosigDRun'];
% fileName = T.path(nosig_DRun);
% cellID = Txls.cellID(nosig_DRun);
% plot_Track_multi_v3(fileName, cellID, fd_nosigDRun);
% 
% sig_DRw = (T.taskType == 'DRw') & ((T.pLR_Plfm2hz<=alpha) | (T.pLR_Track<=alpha));
% fd_sigDRw = [folder, 'light_sigDRw'];
% fileName = T.path(sig_DRw);
% cellID = Txls.cellID(sig_DRw);
% plot_Track_multi_v3(fileName, cellID, fd_sigDRw);
% 
% nosig_DRw = (T.taskType == 'DRw') & ((T.pLR_Plfm2hz>alpha) & (T.pLR_Track>alpha));
% fd_nosigDRw = [folder, 'light_nosigDRw'];
% fileName = T.path(nosig_DRw);
% cellID = Txls.cellID(nosig_DRw);
% plot_Track_multi_v3(fileName, cellID, fd_nosigDRw);
% cd('D:\Dropbox\SNL\P2_Track');

%% platform 2hz, 8hz stimulation population
% total_2hz8hz = ~isnan(T.pLR_Plfm8hz);
% fd_total2hz8hz = [folder,'plfm_2hz8hz'];
% fileName = T.path(total_2hz8hz);
% cellID = T.cellID(total_2hz8hz);
% plot_Track_multi_v3(fileName, cellID, fd_total2hz8hz);
% cd('D:\Dropbox\SNL\P2_Track');

%% Rapid light response population
%%%%%%%%%%%%%%%%%%%% DRun %%%%%%%%%%%%%%%%%%%%
% rapid_DRunTrack = (T.taskType == 'DRun') & T.meanFR_task<cri_Peak & (T.latencyTrack1st<10) & (T.pLR_Track<alpha);
% fd_neuronRapid = [folder,'rapid_track_DRun'];
% fileName = T.path(rapid_DRunTrack);
% cellID = Txls.cellID(rapid_DRunTrack);
% plot_Track_multi_v3(fileName, cellID, fd_neuronRapid);
% cd('D:\Dropbox\SNL\P2_Track');

%%%%%%%%%%%%%%%%%%%% DRw %%%%%%%%%%%%%%%%%%%%
% rapid_DRwTrack = (T.taskType == 'DRw') & T.meanFR_task<cri_Peak & (T.latencyTrack1st<10) & (T.pLR_Track<alpha);
% fd_neuronRapid = [folder,'rapid_track_DRw'];
% fileName = T.path(rapid_DRwTrack);
% cellID = Txls.cellID(rapid_DRwTrack);
% plot_Track_multi_v3(fileName, cellID, fd_neuronRapid);
% cd('D:\Dropbox\SNL\P2_Track');

%% Task Type
% total_DRun = T.taskType == 'DRun';
% fd_totalDRun = [folder, 'v9_DRun'];
% fileName = T.path(total_DRun);
% cellID = T.cellID(total_DRun);
% plot_Track_multi_v3(fileName, cellID, fd_totalDRun);
% 
% total_noRun = T.taskType == 'noRun';
% fd_totalnoRun = [folder, 'v9_noRun'];
% fileName = T.path(total_noRun);
% cellID = T.cellID(total_noRun);
% plot_Track_multi_v3(fileName, cellID, fd_totalnoRun);
% 
% total_DRw = T.taskType == 'DRw';
% fd_totalDRw = [folder, 'v9_DRw'];
% fileName = T.path(total_DRw);
% cellID = T.cellID(total_DRw);
% plot_Track_multi_v3(fileName, cellID, fd_totalDRw);
% 
% total_noRw = T.taskType == 'noRw';
% fd_totalnoRw = [folder, 'v9_noRw'];
% fileName = T.path(total_noRw);
% cellID = T.cellID(total_noRw);
% plot_Track_multi_v3(fileName, cellID, fd_totalnoRw);
% cd('D:\Dropbox\SNL\P2_Track');

%% ##### State dependent light modulation population #####
% Only 2hz on platform
% total_DRun2hz = (T.taskType == 'DRun') & isnan(T.pLR_Plfm8hz) & ((T.pLR_Plfm2hz<alpha & T.statDir_Plfm2hz == 1) | (T.pLR_Track<alpha & T.statDir_Track == 1));
% fd_DRun2hz = [folder, 'stateDependency2hz_DRun'];
% fileName = T.path(total_DRun2hz);
% cellID = Txls.cellID(total_DRun2hz);
% plot_Track_multi_v3(fileName, cellID, fd_DRun2hz);

% total_DRw2hz = (T.taskType == 'DRw') & isnan(T.pLR_Plfm8hz) & ((T.pLR_Plfm2hz<alpha & T.statDir_Plfm2hz == 1) | (T.pLR_Track<alpha & T.statDir_Track == 1));
% fd_DRw2hz = [folder, 'stateDependency2hz_DRw'];
% fileName = T.path(total_DRw2hz);
% cellID = Txls.cellID(total_DRw2hz);
% plot_Track_multi_v3(fileName, cellID, fd_DRw2hz);

% 2hz and 8hz on platform
% total_DRun2hz8hz = (T.taskType == 'DRun') & ~isnan(T.pLR_Plfm8hz) & ((T.pLR_Plfm2hz<alpha & T.statDir_Plfm2hz == 1) | (T.pLR_Track<alpha & T.statDir_Track == 1));
% fd_DRun2hz8hz = [folder, 'stateDependency2hz8hz_DRun'];
% fileName = T.path(total_DRun2hz8hz);
% cellID = Txls.cellID(total_DRun2hz8hz);
% plot_Track_multi_v3(fileName, cellID, fd_DRun2hz8hz);

% total_DRw2hz8hz = (T.taskType == 'DRw') & ~isnan(T.pLR_Plfm8hz) & ((T.pLR_Plfm2hz<alpha & T.statDir_Plfm2hz == 1) | (T.pLR_Track<alpha & T.statDir_Track == 1));
% fd_DRw2hz8hz = [folder, 'stateDependency2hz8hz_DRw'];
% fileName = T.path(total_DRw2hz8hz);
% cellID = Txls.cellID(total_DRw2hz8hz);
% plot_Track_multi_v3(fileName, cellID, fd_DRw2hz8hz);

% DRun and DRw recorded population
% idDRun = Txls.compCellID(Txls.taskType == 'DRun' & (T.pLR_Track<alpha | T.pLR_Plfm2hz<alpha));
% idDRun = idDRun(~isnan(idDRun));
% idDRw = Txls.compCellID(Txls.taskType == 'DRw' & (T.pLR_Track<alpha | T.pLR_Plfm2hz<alpha));
% idDRw = idDRw(~isnan(idDRw));
% coRecNeuron = intersect(idDRun,idDRw);
% nCoRec = length(coRecNeuron);
% parentDir = 'D:\Dropbox\#team_hippocampus Team Folder\project_Track\samples_v9\stateDependency_DRunDRw';
% for iCell = 1:nCoRec
%    fileName = Txls.path(Txls.compCellID == coRecNeuron(iCell));
%    cellID = Txls.cellID(Txls.compCellID == coRecNeuron(iCell));
%    mkdir(parentDir, ['coRec_',num2str(coRecNeuron(iCell))]);
%    plot_Track_multi_v3(fileName,cellID,[parentDir,'\coRec_',num2str(coRecNeuron(iCell))]);   
% end
% cd('D:\Dropbox\SNL\P2_Track');

%% population bias calibration (based on sensor mean_fr)
% DRun sessions
% DRunTN = (T.taskType == 'DRun') & condiTN;
% DRunPN = DRunTN & condiPN;
% DRunIN = DRunTN & condiIN;
% 
% trackInac_DRunPN = DRunPN & (T.pLR_Track < alpha) & (T.statDir_Track == -1);
% mfr_zone = T.sensorMeanFR_DRun(trackInac_DRunPN);
% mean_mfr_zone = min(cellfun(@(x) mean(x(31:60)),mfr_zone));
% 
% populPass_DRun = DRunPN & ((cellfun(@(x) min(mean(x(31:60))),T.sensorMeanFR_DRun)) > mean_mfr_zone) & (T.pLR_Track<=alpha);
% populAct_DRun = populPass_DRun & (T.statDir_Track == 1);
% populIna_DRun = populPass_DRun & (T.statDir_Track == -1);
% populNorsp_DRun = DRunPN & ((cellfun(@(x) min(mean(x(31:60))),T.sensorMeanFR_DRun)) > mean_mfr_zone) & (T.pLR_Track>alpha);
% 
% fd_passAct = [folder, 'passAct_DRun'];
% fileName = T.path(populAct_DRun);
% cellID = Txls.cellID(populAct_DRun);
% plot_Track_multi_v3(fileName, cellID, fd_passAct);
% 
% fd_passIna = [folder, 'passIna_DRun'];
% fileName = T.path(populIna_DRun);
% cellID = Txls.cellID(populIna_DRun);
% plot_Track_multi_v3(fileName, cellID, fd_passIna);
% 
% fd_passNorsp = [folder, 'passNorsp_DRun'];
% fileName = T.path(populNorsp_DRun);
% cellID = Txls.cellID(populNorsp_DRun);
% plot_Track_multi_v3(fileName, cellID, fd_passNorsp);
% 
% % DRw sessions
% DRwTN = (T.taskType == 'DRw') & condiTN;
% DRwPN = DRwTN & condiPN;
% DRwIN = DRwTN & condiIN;
% 
% trackInac_DRwPN = DRwPN & (T.pLR_Track < alpha) & (T.statDir_Track == -1);
% mfr_zone = T.sensorMeanFR_DRw(trackInac_DRwPN);
% mean_mfr_zone = min(cellfun(@(x) mean(x(31:60)),mfr_zone));
% 
% populPass_DRw = DRwPN & ((cellfun(@(x) min(mean(x(31:60))),T.sensorMeanFR_DRw)) > mean_mfr_zone) & (T.pLR_Track<=alpha);
% populAct_DRw = populPass_DRw & (T.statDir_Track == 1);
% populIna_DRw = populPass_DRw & (T.statDir_Track == -1);
% populNorsp_DRw = DRwPN & ((cellfun(@(x) min(mean(x(31:60))),T.sensorMeanFR_DRw)) > mean_mfr_zone) & (T.pLR_Track>alpha);
% 
% fd_passAct = [folder, 'passAct_DRw'];
% fileName = T.path(populAct_DRw);
% cellID = Txls.cellID(populAct_DRw);
% plot_Track_multi_v3(fileName, cellID, fd_passAct);
% 
% fd_passIna = [folder, 'passIna_DRw'];
% fileName = T.path(populIna_DRw);
% cellID = Txls.cellID(populIna_DRw);
% plot_Track_multi_v3(fileName, cellID, fd_passIna);
% 
% fd_passNorsp = [folder, 'passNorsp_DRw'];
% fileName = T.path(populNorsp_DRw);
% cellID = Txls.cellID(populNorsp_DRw);
% plot_Track_multi_v3(fileName, cellID, fd_passNorsp);
% 
% cd(rtDir);

%% population bias calibration (based on sensor mean_fr) with latency
% DRun sessions
% DRunTN = (T.taskType == 'DRw') & condiTN;
% DRunPN = DRunTN & condiPN;
% DRunIN = DRunTN & condiIN;
% 
% trackInac_DRunPN = DRunPN & (T.pLR_Track < alpha) & (T.statDir_Track == -1);
% mfr_zone = T.sensorMeanFR_DRw(trackInac_DRunPN);
% mean_mfr_zone = min(cellfun(@(x) mean(x(31:60)),mfr_zone));
% 
% populPass_DRun = DRunPN & ((cellfun(@(x) min(mean(x(31:60))),T.sensorMeanFR_DRun)) > mean_mfr_zone);
% populAct_DRunR = populPass_DRun & (T.pLR_Track<alpha) & (T.statDir_Track == 1) & T.latencyTrack1st<10;
% populAct_DRunD = populPass_DRun & (T.pLR_Track<alpha) & (T.statDir_Track == 1) & T.latencyTrack1st>=10;
% 
% fd_passActR = [folder, 'passAct_DRun_rapid'];
% fileName = T.path(populAct_DRunR);
% cellID = Txls.cellID(populAct_DRunR);
% % plot_Track_multi_v3(fileName, cellID, fd_passActR);
% 
% fd_passActD = [folder, 'passAct_DRun_delay'];
% fileName = T.path(populAct_DRunD);
% cellID = Txls.cellID(populAct_DRunD);
% % plot_Track_multi_v3(fileName, cellID, fd_passActD);
% 
% 
% populNopass_DRun = DRunPN & ~((cellfun(@(x) min(mean(x(31:60))),T.sensorMeanFR_DRw)) > mean_mfr_zone);
% populNopassAct_DRunR = populNopass_DRun & (T.pLR_Track < alpha) & (T.statDir_Track == 1) & T.latencyTrack1st<10;
% populNopassAct_DRunD = populNopass_DRun & (T.pLR_Track < alpha) & (T.statDir_Track == 1) & T.latencyTrack1st>=10;
% 
% fd_nopassActR = [folder, 'nopassAct_DRw_rapid'];
% fileName = T.path(populNopassAct_DRunR);
% cellID = Txls.cellID(populNopassAct_DRunR);
% plot_Track_multi_v3(fileName, cellID, fd_nopassActR);
% 
% fd_nopassActD = [folder, 'nopassAct_DRw_delay'];
% fileName = T.path(populNopassAct_DRunD);
% cellID = Txls.cellID(populNopassAct_DRunD);
% plot_Track_multi_v3(fileName, cellID, fd_nopassActD);
% 
% cd(rtDir);

%% First session analysis
% load('neuronList_1stSess_170517.mat');
% Txls1ss = readtable('neuronList_1stSess_170517.xlsx');
% Txls1ss.taskType = categorical(Txls1ss.taskType);
% folder = 'D:\Dropbox\#team_hippocampus Team Folder\project_Track\samples_v9\examples\1st session analysis\';
% 
% condiTN_1sess = (cellfun(@max, T1ss.peakFR1D_track) > cMaxPeakFR) & ~(cellfun(@(x) any(isnan(x)),T1ss.peakloci_total));
% condiPN_1sess = T1ss.spkpvr>cSpkpvr & T1ss.meanFR_task<cMeanFR;
% condiIN_1sess = ~condiPN_1sess;
% 
% DRunTN_1sess = (T1ss.taskType == 'DRun') & condiTN_1sess;
% DRunPN_1sess = DRunTN_1sess & condiPN_1sess;
% DRunIN_1sess = DRunTN_1sess & condiIN_1sess;
% DRwTN_1sess = (T1ss.taskType == 'DRw') & condiTN_1sess;
% DRwPN_1sess = DRwTN_1sess & condiPN_1sess;
% DRwIN_1sess = DRwTN_1sess & condiIN_1sess;
% 
% sig_DRun = DRunPN_1sess & ((T1ss.pLR_Plfm2hz<=alpha) | (T1ss.pLR_Track<=alpha));
% fd_sigDRun = [folder, '1sess_light_sigDRun'];
% fileName = T1ss.path(sig_DRun);
% cellID = Txls1ss.cellID(sig_DRun);
% plot_Track_multi_v3(fileName, cellID, fd_sigDRun);
% 
% nosig_DRun = DRunPN_1sess & ((T1ss.pLR_Plfm2hz>alpha) & (T1ss.pLR_Track>alpha));
% fd_nosigDRun = [folder, '1sess_light_nosigDRun'];
% fileName = T1ss.path(nosig_DRun);
% cellID = Txls1ss.cellID(nosig_DRun);
% plot_Track_multi_v3(fileName, cellID, fd_nosigDRun);
% 
% sig_DRw = DRwPN_1sess & ((T1ss.pLR_Plfm2hz<=alpha) | (T1ss.pLR_Track<=alpha));
% fd_sigDRw = [folder, '1sess_light_sigDRw'];
% fileName = T1ss.path(sig_DRw);
% cellID = Txls1ss.cellID(sig_DRw);
% plot_Track_multi_v3(fileName, cellID, fd_sigDRw);
% 
% nosig_DRw = DRwPN_1sess & ((T1ss.pLR_Plfm2hz>alpha) & (T1ss.pLR_Track>alpha));
% fd_nosigDRw = [folder, '1sess_light_nosigDRw'];
% fileName = T1ss.path(nosig_DRw);
% cellID = Txls1ss.cellID(nosig_DRw);
% plot_Track_multi_v3(fileName, cellID, fd_nosigDRw);
% cd('D:\Dropbox\SNL\P2_Track');

%% 50hz sessions
% load('neuronList_ori50hz_170612.mat');
% condiTN = (cellfun(@max, T.peakFR1D_track) > cMaxPeakFR) & ~(cellfun(@(x) any(isnan(x)),T.peakloci_total));
% condiPN = T.spkpvr>cSpkpvr & T.meanFR_task<cMeanFR;
% condiIN = ~condiPN;
% alpha = 0.01;
% fd_parent = 'D:\Dropbox\SNL\P2_Track\analysis_50hz\';
% fd_child = {'DRunPN';
%             'DRunIN';
%             'DRwPN';
%             'DRwIN';};
%         
% DRunPN = (T.taskType == 'DRun') & condiPN;
% fileName = T.path(DRunPN);
% cellID = T.cellID(DRunPN);
% plot_Track_multi_v50hz(fileName, cellID, [fd_parent,fd_child{1}]);
% 
% DRwPN = (T.taskType == 'DRw') & condiPN;
% fileName = T.path(DRwPN);
% cellID = T.cellID(DRwPN);
% plot_Track_multi_v50hz(fileName, cellID, [fd_parent,fd_child{2}]);
% 
% DRunIN = (T.taskType == 'DRun') & condiIN;
% fileName = T.path(DRunIN);
% cellID = T.cellID(DRunIN);
% plot_Track_multi_v50hz(fileName, cellID, [fd_parent,fd_child{3}]);
% 
% DRwIN = (T.taskType == 'DRw') & condiIN;
% fileName = T.path(DRwIN);
% cellID = T.cellID(DRwIN);
% plot_Track_multi_v50hz(fileName, cellID, [fd_parent,fd_child{4}]);