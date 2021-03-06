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
%% Loading cell information
load('neuronList_ori_control_171014.mat');
Txls = readtable('neuronList_ori_control_171014.xlsx');
Txls.taskType = categorical(Txls.taskType);
formatOut = 'yymmdd';

% DRun
DRunPN = T.taskType == 'DRun' & T.idxNeurontype == 'PN';
DRunIN = T.taskType == 'DRun' & T.idxNeurontype == 'IN';
DRunUNC = T.taskType == 'DRun' & T.idxNeurontype == 'UNC';

%% separation of place cells from non place cell
group = T.taskType == 'DRun' & T.idxNeurontype == 'PN';
fileName = T.path(group);
cellID = Txls.cellID(group);
plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\example_eYFPDRunPC');

group = T.taskType == 'DRw' & T.idxNeurontype == 'PN';
fileName = T.path(group);
cellID = Txls.cellID(group);
plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\example_eYFPDRwPC');


% % non place cell
% dirParent = 'D:\Dropbox\SNL\P2_Track\analysis_eYFP\placefield\total_nPF';
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


%% analysis with place field (whether the field is in the stm zone or not)
% DRunPN_PF_inField_act = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == 1;
% fileName = T.path(DRunPN_PF_inField_act);
% cellID = T.cellID(DRunPN_PF_inField_act);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_eYFP\PF\DRun_inZone_act');
% 
% DRunPN_PF_inField_ina = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == -1;
% fileName = T.path(DRunPN_PF_inField_ina);
% cellID = T.cellID(DRunPN_PF_inField_ina);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_eYFP\PF\DRun_inZone_ina');
% 
% DRunPN_PF_inField_no = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxZoneInOut & ~T.idxpLR_Track;
% fileName = T.path(DRunPN_PF_inField_no);
% cellID = T.cellID(DRunPN_PF_inField_no);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_eYFP\PF\DRun_inZone_no');
% 
% DRunPN_PF_outField_act = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & ~T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == 1;
% fileName = T.path(DRunPN_PF_outField_act);
% cellID = T.cellID(DRunPN_PF_outField_act);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_eYFP\PF\DRun_outZone_act');
% 
% DRunPN_PF_outField_ina = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & ~T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == -1;
% fileName = T.path(DRunPN_PF_outField_ina);
% cellID = T.cellID(DRunPN_PF_outField_ina);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_eYFP\PF\DRun_outZone_act');
% 
% DRunPN_PF_outField_no = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & ~T.idxZoneInOut & ~T.idxpLR_Track;
% fileName = T.path(DRunPN_PF_outField_no);
% cellID = T.cellID(DRunPN_PF_outField_no);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_eYFP\PF\DRun_outZone_act');
% 
% DRwPN_PF_inField_act = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == 1;
% fileName = T.path(DRwPN_PF_inField_act);
% cellID = T.cellID(DRwPN_PF_inField_act);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_eYFP\PF\DRw_inZone_act');
% 
% DRwPN_PF_inField_ina = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == -1;
% fileName = T.path(DRwPN_PF_inField_ina);
% cellID = T.cellID(DRwPN_PF_inField_ina);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_eYFP\PF\DRw_inZone_act');
% 
% DRwPN_PF_inField_no = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxZoneInOut & ~T.idxpLR_Track;
% fileName = T.path(DRwPN_PF_inField_no);
% cellID = T.cellID(DRwPN_PF_inField_no);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_eYFP\PF\DRw_inZone_act');
% 
% DRwPN_PF_outField_act = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & ~T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == 1;
% fileName = T.path(DRwPN_PF_outField_act);
% cellID = T.cellID(DRwPN_PF_outField_act);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_eYFP\PF\DRw_outZone_act');
% 
% DRwPN_PF_outField_ina = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & ~T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == -1;
% fileName = T.path(DRwPN_PF_outField_ina);
% cellID = T.cellID(DRwPN_PF_outField_ina);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_eYFP\PF\DRw_outZone_act');
% 
% DRwPN_PF_outField_no = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & ~T.idxZoneInOut & ~T.idxpLR_Track;
% fileName = T.path(DRwPN_PF_outField_no);
% cellID = T.cellID(DRwPN_PF_outField_no);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_eYFP\PF\DRw_outZone_act');

% No stimulation (DRun or DRw)
% noRunPN_PF_inField_act = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == 1;
% fileName = T.path(noRunPN_PF_inField_act);
% cellID = T.cellID(noRunPN_PF_inField_act);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_eYFP\PF\noRun_inZone_act');
% 
% noRunPN_PF_inField_ina = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == -1;
% fileName = T.path(noRunPN_PF_inField_ina);
% cellID = T.cellID(noRunPN_PF_inField_ina);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_eYFP\PF\noRun_inZone_ina');
% 
% noRunPN_PF_inField_no = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxZoneInOut & ~T.idxpLR_Track;
% fileName = T.path(noRunPN_PF_inField_no);
% cellID = T.cellID(noRunPN_PF_inField_no);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_eYFP\PF\noRun_inZone_no');
% 
% noRunPN_PF_outField_act = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & ~T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == 1;
% fileName = T.path(noRunPN_PF_outField_act);
% cellID = T.cellID(noRunPN_PF_outField_act);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_eYFP\PF\noRun_outZone_act');
% 
% noRunPN_PF_outField_ina = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & ~T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == -1;
% fileName = T.path(noRunPN_PF_outField_ina);
% cellID = T.cellID(noRunPN_PF_outField_ina);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_eYFP\PF\noRun_outZone_act');
% 
% noRunPN_PF_outField_no = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & ~T.idxZoneInOut & ~T.idxpLR_Track;
% fileName = T.path(noRunPN_PF_outField_no);
% cellID = T.cellID(noRunPN_PF_outField_no);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_eYFP\PF\noRun_outZone_act');
% 
% 
% noRwPN_PF_inField_act = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == 1;
% fileName = T.path(noRwPN_PF_inField_act);
% cellID = T.cellID(noRwPN_PF_inField_act);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_eYFP\PF\noRw_inZone_act');
% 
% noRwPN_PF_inField_ina = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == -1;
% fileName = T.path(noRwPN_PF_inField_ina);
% cellID = T.cellID(noRwPN_PF_inField_ina);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_eYFP\PF\noRw_inZone_act');
% 
% noRwPN_PF_inField_no = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxZoneInOut & ~T.idxpLR_Track;
% fileName = T.path(noRwPN_PF_inField_no);
% cellID = T.cellID(noRwPN_PF_inField_no);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_eYFP\PF\noRw_inZone_act');
% 
% noRwPN_PF_outField_act = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & ~T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == 1;
% fileName = T.path(noRwPN_PF_outField_act);
% cellID = T.cellID(noRwPN_PF_outField_act);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_eYFP\PF\noRw_outZone_act');
% 
% noRwPN_PF_outField_ina = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & ~T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == -1;
% fileName = T.path(noRwPN_PF_outField_ina);
% cellID = T.cellID(noRwPN_PF_outField_ina);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_eYFP\PF\noRw_outZone_act');
% 
% noRwPN_PF_outField_no = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & ~T.idxZoneInOut & ~T.idxpLR_Track;
% fileName = T.path(noRwPN_PF_outField_no);
% cellID = T.cellID(noRwPN_PF_outField_no);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_eYFP\PF\noRw_outZone_act');
%%
% fileName = T.path(T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField);
% cellID = T.cellID(T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_placefield\analysis_PF\DRun');
% 
% fileName = T.path(T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField);
% cellID = T.cellID(T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_placefield\analysis_PF\noRun');
% 
% fileName = T.path(T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField);
% cellID = T.cellID(T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_placefield\analysis_PF\DRw');
% 
% fileName = T.path(T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField);
% cellID = T.cellID(T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_placefield\analysis_PF\noRw');
% 
% % nonPF
% fileName = T.path(T.taskType == 'DRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField));
% cellID = T.cellID(T.taskType == 'DRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField));
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_placefield\analysis_nPF\DRun');
% 
% fileName = T.path(T.taskType == 'noRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField));
% cellID = T.cellID(T.taskType == 'noRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField));
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_placefield\analysis_nPF\noRun');
% 
% fileName = T.path(T.taskType == 'DRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField));
% cellID = T.cellID(T.taskType == 'DRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField));
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_placefield\analysis_nPF\DRw');
% 
% fileName = T.path(T.taskType == 'noRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField));
% cellID = T.cellID(T.taskType == 'noRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField));
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_placefield\analysis_nPF\noRw');
%% All neurons separated by sessions (DRun, DRw, noRun, noRw)
% fileName = T.path(DRunPN);
% cellID = Txls.cellID(DRunPN);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_eYFP\total_DRun\PN');
% fileName = T.path(DRunIN);
% cellID = Txls.cellID(DRunIN);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_eYFP\total_DRun\IN');
% fileName = T.path(DRunUNC);
% cellID = Txls.cellID(DRunUNC);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_eYFP\total_DRun\UNC');
% 
% fileName = T.path(DRwPN);
% cellID = Txls.cellID(DRwPN);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_eYFP\total_DRw\PN');
% fileName = T.path(DRwIN);
% cellID = Txls.cellID(DRwIN);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_eYFP\total_DRw\IN');
% fileName = T.path(DRwUNC);
% cellID = Txls.cellID(DRwUNC);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_eYFP\total_DRw\UNC');
% 
% fileName = T.path(noRunPN);
% cellID = Txls.cellID(noRunPN);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_eYFP\total_noRun\PN');
% fileName = T.path(noRunIN);
% cellID = Txls.cellID(noRunIN);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_eYFP\total_noRun\IN');
% fileName = T.path(noRunUNC);
% cellID = Txls.cellID(noRunUNC);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_eYFP\total_noRun\UNC');
% 
% fileName = T.path(noRwPN);
% cellID = Txls.cellID(noRwPN);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_eYFP\total_noRw\PN');
% fileName = T.path(noRwIN);
% cellID = Txls.cellID(noRwIN);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_eYFP\total_noRw\IN');
% fileName = T.path(noRwUNC);
% cellID = Txls.cellID(noRwUNC);
% plot_Track_multi_v3(fileName, cellID, 'D:\Dropbox\SNL\P2_Track\analysis_eYFP\total_noRw\UNC');

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

%% Place field analysis
%%%%%%%%%%%%%%%%%%%% pc_DRun or DRw %%%%%%%%%%%%%%%%%%%%
% pc_DRun = ((T.taskType == 'DRun') & (T.placefieldTrack == 1));
% parentDir = [folder, 'pc_DRun'];
% fileName = T.path(pc_DRun);
% cellID = T.cellID(pc_DRun);
% plot_Track_multi_v3(fileName, cellID, parentDir);
% % 
% pc_DRw = ((T.taskType == 'DRw') & (T.placefieldTrack == 1));
% parentDir = [folder, 'pc_DRw'];
% fileName = T.path(pc_DRw);
% cellID = T.cellID(pc_DRw);
% plot_Track_multi_v3(fileName, cellID, parentDir);
% cd('D:\Dropbox\SNL\P2_Track');

%%%%%%%%%%%%%%%%%%%% pcStm_DRun or DRw %%%%%%%%%%%%%%%%%%%%
% pcStm_DRun = ((T.taskType == 'DRun') & (T.placefieldTrack == 1) & (T.placefieldStmZone == 1));
% parentDir = [folder, 'pcStm_DRun'];
% fileName = T.path(pcStm_DRun);
% cellID = T.cellID(pcStm_DRun);
% plot_Track_multi_v3(fileName, cellID, parentDir);
% 
% pcStm_DRw = ((T.taskType == 'DRw') & (T.placefieldTrack == 1) & (T.placefieldStmZone == 1));
% parentDir = [folder, 'pcStm_DRw'];
% fileName = T.path(pcStm_DRw);
% cellID = T.cellID(pcStm_DRw);
% plot_Track_multi_v3(fileName, cellID, parentDir);
% cd('D:\Dropbox\SNL\P2_Track');

%%%%%%%%%%%%%%%%%%%% non-place cell %%%%%%%%%%%%%%%%%%%%
% npc_DRun = ((T.taskType == 'DRun') & (T.placefieldTrack == 0));
% parentDir = [folder, 'npc_DRun'];
% fileName = T.path(npc_DRun);
% cellID = T.cellID(npc_DRun);
% plot_Track_multi_v3(fileName, cellID, parentDir);
% 
% npc_DRw = ((T.taskType == 'DRw') & (T.placefieldTrack == 0));
% parentDir = [folder, 'npc_DRw'];
% fileName = T.path(npc_DRw);
% cellID = T.cellID(npc_DRw);
% plot_Track_multi_v3(fileName, cellID, parentDir);
% cd('D:\Dropbox\SNL\P2_Track');

%% Light response
% sig_DRun = (T.taskType == 'DRun') & ((T.pLR_Plfm2hz<=alpha) | (T.pLR_Track<=alpha));
% fd_sigDRun = [folder, 'light_sigDRun'];
% fileName = T.path(sig_DRun);
% cellID = Txls.cellID(sig_DRun);
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