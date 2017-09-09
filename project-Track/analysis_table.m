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
load myParameters.mat;
load('neuronList_ori_170819.mat');
formatOut = 'yymmdd';

%%
DRunPN_PF_inField_act = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == 1;
DRunPN_PF_inField_ina = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == -1;
DRunPN_PF_inField_no = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOut & ~T.idxpLR_Track;
DRunPN_PF_outField_act = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == 1;
DRunPN_PF_outField_ina = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == -1;
DRunPN_PF_outField_no = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOut & ~T.idxpLR_Track;
DRunPN_nPF_act = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxpLR_Track & T.statDir_TrackN == 1;
DRunPN_nPF_ina = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxpLR_Track & T.statDir_TrackN == -1;
DRunPN_nPF_no = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & ~T.idxpLR_Track;
DRunIN_act = T.taskType == 'DRun' & T.idxNeurontype == 'IN' & T.idxpLR_Track & T.statDir_TrackN == 1;
DRunIN_ina = T.taskType == 'DRun' & T.idxNeurontype == 'IN' & T.idxpLR_Track & T.statDir_TrackN == -1;
DRunIN_no = T.taskType == 'DRun' & T.idxNeurontype == 'IN' & ~T.idxpLR_Track;
DRunUNC_act = T.taskType == 'DRun' & T.idxNeurontype == 'UNC' & T.idxpLR_Track & T.statDir_TrackN == 1;
DRunUNC_ina = T.taskType == 'DRun' & T.idxNeurontype == 'UNC' & T.idxpLR_Track & T.statDir_TrackN == 1;
DRunUNC_no = T.taskType == 'DRun' & T.idxNeurontype == 'UNC' & ~T.idxpLR_Track;
table(1,:) = [sum(double(DRunPN_PF_inField_act)), sum(double(DRunPN_PF_inField_ina)), sum(double(DRunPN_PF_inField_no)), sum(double(DRunPN_PF_outField_act)), sum(double(DRunPN_PF_outField_ina)), sum(double(DRunPN_PF_outField_no)), sum(double(DRunPN_nPF_act)), sum(double(DRunPN_nPF_ina)), sum(double(DRunPN_nPF_no)), sum(double(DRunIN_act)), sum(double(DRunIN_ina)), sum(double(DRunIN_no)), sum(double(DRunUNC_act)), sum(double(DRunUNC_ina)), sum(double(DRunUNC_no))];

noRunPN_PF_inField_act = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == 1;
noRunPN_PF_inField_ina = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == -1;
noRunPN_PF_inField_no = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOut & ~T.idxpLR_Track;
noRunPN_PF_outField_act = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == 1;
noRunPN_PF_outField_ina = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == -1;
noRunPN_PF_outField_no = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOut & ~T.idxpLR_Track;
noRunPN_nPF_act = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxpLR_Track & T.statDir_TrackN == 1;
noRunPN_nPF_ina = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxpLR_Track & T.statDir_TrackN == -1;
noRunPN_nPF_no = T.taskType == 'noRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & ~T.idxpLR_Track;
noRunIN_act = T.taskType == 'noRun' & T.idxNeurontype == 'IN' & T.idxpLR_Track & T.statDir_TrackN == 1;
noRunIN_ina = T.taskType == 'noRun' & T.idxNeurontype == 'IN' & T.idxpLR_Track & T.statDir_TrackN == -1;
noRunIN_no = T.taskType == 'noRun' & T.idxNeurontype == 'IN' & ~T.idxpLR_Track;
noRunUNC_act = T.taskType == 'noRun' & T.idxNeurontype == 'UNC' & T.idxpLR_Track & T.statDir_TrackN == 1;
noRunUNC_ina = T.taskType == 'noRun' & T.idxNeurontype == 'UNC' & T.idxpLR_Track & T.statDir_TrackN == 1;
noRunUNC_no = T.taskType == 'noRun' & T.idxNeurontype == 'UNC' & ~T.idxpLR_Track;
table(2,:) = [sum(double(noRunPN_PF_inField_act)), sum(double(noRunPN_PF_inField_ina)), sum(double(noRunPN_PF_inField_no)), sum(double(noRunPN_PF_outField_act)), sum(double(noRunPN_PF_outField_ina)), sum(double(noRunPN_PF_outField_no)), sum(double(noRunPN_nPF_act)), sum(double(noRunPN_nPF_ina)), sum(double(noRunPN_nPF_no)), sum(double(noRunIN_act)), sum(double(noRunIN_ina)), sum(double(noRunIN_no)), sum(double(noRunUNC_act)), sum(double(noRunUNC_ina)), sum(double(noRunUNC_no))];

DRwPN_PF_inField_act = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == 1;
DRwPN_PF_inField_ina = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == -1;
DRwPN_PF_inField_no = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOut & ~T.idxpLR_Track;
DRwPN_PF_outField_act = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == 1;
DRwPN_PF_outField_ina = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == -1;
DRwPN_PF_outField_no = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOut & ~T.idxpLR_Track;
DRwPN_nPF_act = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxpLR_Track & T.statDir_TrackN == 1;
DRwPN_nPF_ina = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxpLR_Track & T.statDir_TrackN == -1;
DRwPN_nPF_no = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & ~T.idxpLR_Track;
DRwIN_act = T.taskType == 'DRw' & T.idxNeurontype == 'IN' & T.idxpLR_Track & T.statDir_TrackN == 1;
DRwIN_ina = T.taskType == 'DRw' & T.idxNeurontype == 'IN' & T.idxpLR_Track & T.statDir_TrackN == -1;
DRwIN_no = T.taskType == 'DRw' & T.idxNeurontype == 'IN' & ~T.idxpLR_Track;
DRwUNC_act = T.taskType == 'DRw' & T.idxNeurontype == 'UNC' & T.idxpLR_Track & T.statDir_TrackN == 1;
DRwUNC_ina = T.taskType == 'DRw' & T.idxNeurontype == 'UNC' & T.idxpLR_Track & T.statDir_TrackN == 1;
DRwUNC_no = T.taskType == 'DRw' & T.idxNeurontype == 'UNC' & ~T.idxpLR_Track;
table(3,:) = [sum(double(DRwPN_PF_inField_act)), sum(double(DRwPN_PF_inField_ina)), sum(double(DRwPN_PF_inField_no)), sum(double(DRwPN_PF_outField_act)), sum(double(DRwPN_PF_outField_ina)), sum(double(DRwPN_PF_outField_no)), sum(double(DRwPN_nPF_act)), sum(double(DRwPN_nPF_ina)), sum(double(DRwPN_nPF_no)), sum(double(DRwIN_act)), sum(double(DRwIN_ina)), sum(double(DRwIN_no)), sum(double(DRwUNC_act)), sum(double(DRwUNC_ina)), sum(double(DRwUNC_no))];

noRwPN_PF_inField_act = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == 1;
noRwPN_PF_inField_ina = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == -1;
noRwPN_PF_inField_no = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOut & ~T.idxpLR_Track;
noRwPN_PF_outField_act = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == 1;
noRwPN_PF_outField_ina = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == -1;
noRwPN_PF_outField_no = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOut & ~T.idxpLR_Track;
noRwPN_nPF_act = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxpLR_Track & T.statDir_TrackN == 1;
noRwPN_nPF_ina = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxpLR_Track & T.statDir_TrackN == -1;
noRwPN_nPF_no = T.taskType == 'noRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & ~T.idxpLR_Track;
noRwIN_act = T.taskType == 'noRw' & T.idxNeurontype == 'IN' & T.idxpLR_Track & T.statDir_TrackN == 1;
noRwIN_ina = T.taskType == 'noRw' & T.idxNeurontype == 'IN' & T.idxpLR_Track & T.statDir_TrackN == -1;
noRwIN_no = T.taskType == 'noRw' & T.idxNeurontype == 'IN' & ~T.idxpLR_Track;
noRwUNC_act = T.taskType == 'noRw' & T.idxNeurontype == 'UNC' & T.idxpLR_Track & T.statDir_TrackN == 1;
noRwUNC_ina = T.taskType == 'noRw' & T.idxNeurontype == 'UNC' & T.idxpLR_Track & T.statDir_TrackN == 1;
noRwUNC_no = T.taskType == 'noRw' & T.idxNeurontype == 'UNC' & ~T.idxpLR_Track;
table(4,:) = [sum(double(noRwPN_PF_inField_act)), sum(double(noRwPN_PF_inField_ina)), sum(double(noRwPN_PF_inField_no)), sum(double(noRwPN_PF_outField_act)), sum(double(noRwPN_PF_outField_ina)), sum(double(noRwPN_PF_outField_no)), sum(double(noRwPN_nPF_act)), sum(double(noRwPN_nPF_ina)), sum(double(noRwPN_nPF_no)), sum(double(noRwIN_act)), sum(double(noRwIN_ina)), sum(double(noRwIN_no)), sum(double(noRwUNC_act)), sum(double(noRwUNC_ina)), sum(double(noRwUNC_no))];

%% control
load('neuronList_ori_control_170721.mat');

contDRunPN_PF_inField_act = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == 1;
contDRunPN_PF_inField_ina = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == -1;
contDRunPN_PF_inField_no = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOut & ~T.idxpLR_Track;
contDRunPN_PF_outField_act = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == 1;
contDRunPN_PF_outField_ina = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == -1;
contDRunPN_PF_outField_no = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOut & ~T.idxpLR_Track;
contDRunPN_nPF_act = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxpLR_Track & T.statDir_TrackN == 1;
contDRunPN_nPF_ina = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxpLR_Track & T.statDir_TrackN == -1;
contDRunPN_nPF_no = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & ~T.idxpLR_Track;
contDRunIN_act = T.taskType == 'DRun' & T.idxNeurontype == 'IN' & T.idxpLR_Track & T.statDir_TrackN == 1;
contDRunIN_ina = T.taskType == 'DRun' & T.idxNeurontype == 'IN' & T.idxpLR_Track & T.statDir_TrackN == -1;
contDRunIN_no = T.taskType == 'DRun' & T.idxNeurontype == 'IN' & ~T.idxpLR_Track;
contDRunUNC_act = T.taskType == 'DRun' & T.idxNeurontype == 'UNC' & T.idxpLR_Track & T.statDir_TrackN == 1;
contDRunUNC_ina = T.taskType == 'DRun' & T.idxNeurontype == 'UNC' & T.idxpLR_Track & T.statDir_TrackN == 1;
contDRunUNC_no = T.taskType == 'DRun' & T.idxNeurontype == 'UNC' & ~T.idxpLR_Track;
table(5,:) = [sum(double(contDRunPN_PF_inField_act)), sum(double(contDRunPN_PF_inField_ina)), sum(double(contDRunPN_PF_inField_no)), sum(double(contDRunPN_PF_outField_act)), sum(double(contDRunPN_PF_outField_ina)), sum(double(contDRunPN_PF_outField_no)), sum(double(contDRunPN_nPF_act)), sum(double(contDRunPN_nPF_ina)), sum(double(contDRunPN_nPF_no)), sum(double(contDRunIN_act)), sum(double(contDRunIN_ina)), sum(double(contDRunIN_no)), sum(double(contDRunUNC_act)), sum(double(contDRunUNC_ina)), sum(double(contDRunUNC_no))];

contDRwPN_PF_inField_act = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == 1;
contDRwPN_PF_inField_ina = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == -1;
contDRwPN_PF_inField_no = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOut & ~T.idxpLR_Track;
contDRwPN_PF_outField_act = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == 1;
contDRwPN_PF_outField_ina = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOut & T.idxpLR_Track & T.statDir_TrackN == -1;
contDRwPN_PF_outField_no = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOut & ~T.idxpLR_Track;
contDRwPN_nPF_act = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxpLR_Track & T.statDir_TrackN == 1;
contDRwPN_nPF_ina = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxpLR_Track & T.statDir_TrackN == -1;
contDRwPN_nPF_no = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & ~T.idxpLR_Track;
contDRwIN_act = T.taskType == 'DRw' & T.idxNeurontype == 'IN' & T.idxpLR_Track & T.statDir_TrackN == 1;
contDRwIN_ina = T.taskType == 'DRw' & T.idxNeurontype == 'IN' & T.idxpLR_Track & T.statDir_TrackN == -1;
contDRwIN_no = T.taskType == 'DRw' & T.idxNeurontype == 'IN' & ~T.idxpLR_Track;
contDRwUNC_act = T.taskType == 'DRw' & T.idxNeurontype == 'UNC' & T.idxpLR_Track & T.statDir_TrackN == 1;
contDRwUNC_ina = T.taskType == 'DRw' & T.idxNeurontype == 'UNC' & T.idxpLR_Track & T.statDir_TrackN == 1;
contDRwUNC_no = T.taskType == 'DRw' & T.idxNeurontype == 'UNC' & ~T.idxpLR_Track;
table(6,:) = [sum(double(contDRwPN_PF_inField_act)), sum(double(contDRwPN_PF_inField_ina)), sum(double(contDRwPN_PF_inField_no)), sum(double(contDRwPN_PF_outField_act)), sum(double(contDRwPN_PF_outField_ina)), sum(double(contDRwPN_PF_outField_no)), sum(double(contDRwPN_nPF_act)), sum(double(contDRwPN_nPF_ina)), sum(double(contDRwPN_nPF_no)), sum(double(contDRwIN_act)), sum(double(contDRwIN_ina)), sum(double(contDRwIN_no)), sum(double(contDRwUNC_act)), sum(double(contDRwUNC_ina)), sum(double(contDRwUNC_no))];

%% Plot variables
xptPF_light = [1,5,9,14,18,22];
xptPF_nolight = [2,6,10,15,19,23];
xptPF_eYFP = [3,7,11,16,20,24];

xptNPF_light = [1,5,9];
xptNPF_nolight = [2,6,10];
xptNPF_eYFP = [3,7,11];

xptPN_light = [1,5,9,14,18,22,27,31,35];
xptPN_nolight = [2,6,10,15,19,23,28,32,36];
xptPN_eYFP = [3,7,11,16,20,24,29,33,37];

xptIN_light = [1,5,9];
xptIN_nolight = [2,6,10];
xptIN_eYFP = [3,7,11];

xptUNC_light = [1,5,9];
xptUNC_nolight = [2,6,10]; 
xptUNC_eYFP = [3,7,11];

yptText = 100;
tablePF_in = [table(1,1:3)/sum(table(1,1:3)); table(2,1:3)/sum(table(2,1:3)); table(5,1:3)/sum(table(5,1:3)); table(3,1:3)/sum(table(3,1:3)); table(4,1:3)/sum(table(4,1:3)); table(6,1:3)/sum(table(6,1:3))]*100;
tablePF_out = [table(1,4:6)/sum(table(1,4:6)); table(2,4:6)/sum(table(2,4:6)); table(5,4:6)/sum(table(5,4:6)); table(3,4:6)/sum(table(3,4:6)); table(4,4:6)/sum(table(4,4:6)); table(6,4:6)/sum(table(6,4:6))]*100;
tableNPF = [table(1,7:9)/sum(table(1,7:9)); table(2,7:9)/sum(table(2,7:9)); table(5,7:9)/sum(table(5,7:9)); table(3,7:9)/sum(table(3,7:9)); table(4,7:9)/sum(table(4,7:9)); table(6,7:9)/sum(table(6,7:9))]*100;
tablePN = [(table(1,1)+table(1,4)+table(1,7))/sum(table(1,1:9)) (table(1,2)+table(1,5)+table(1,8))/sum(table(1,1:9)) (table(1,3)+table(1,6)+table(1,9))/sum(table(1,1:9)); (table(2,1)+table(2,4)+table(2,7))/sum(table(2,1:9)) (table(2,2)+table(2,5)+table(2,8))/sum(table(2,1:9)) (table(2,3)+table(2,6)+table(2,9))/sum(table(2,1:9)); (table(5,1)+table(5,4)+table(5,7))/sum(table(5,1:9)) (table(5,2)+table(5,5)+table(5,8))/sum(table(5,1:9)) (table(5,3)+table(5,6)+table(5,9))/sum(table(5,1:9));...
           (table(3,1)+table(3,4)+table(3,7))/sum(table(3,1:9)) (table(3,2)+table(3,5)+table(3,8))/sum(table(3,1:9)) (table(3,3)+table(3,6)+table(3,9))/sum(table(3,1:9)); (table(4,1)+table(4,4)+table(4,7))/sum(table(4,1:9)) (table(4,2)+table(4,5)+table(4,8))/sum(table(4,1:9)) (table(4,3)+table(4,6)+table(4,9))/sum(table(4,1:9)); (table(6,1)+table(6,4)+table(6,7))/sum(table(6,1:9)) (table(6,2)+table(6,5)+table(6,8))/sum(table(6,1:9)) (table(6,3)+table(6,6)+table(6,9))/sum(table(6,1:9))]*100;
tableIN = [table(1,10:12)/sum(table(1,10:12)); table(2,10:12)/sum(table(2,10:12)); table(5,10:12)/sum(table(5,10:12)); table(3,10:12)/sum(table(3,10:12)); table(4,10:12)/sum(table(4,10:12)); table(6,10:12)/sum(table(6,10:12))]*100;
tableUNC = [table(1,13:15)/sum(table(1,13:15)); table(2,13:15)/sum(table(2,13:15)); table(5,13:15)/sum(table(5,13:15)); table(3,13:15)/sum(table(3,13:15)); table(4,13:15)/sum(table(4,13:15)); table(6,13:15)/sum(table(6,13:15))]*100;

%% DRun Plot
fHandle = figure('PaperUnits','centimeters','PaperPosition',[0 0 30 40]);
hBar(1) = axes('Position',axpt(1,5,1,1,[0.1 0.1 0.85 0.85],midInterval));
bar(xptPF_light, [tablePF_in(1,:), tablePF_out(1,:)], 0.2, 'faceColor', colorBlue);
hold on;
bar(xptPF_nolight, [tablePF_in(2,:), tablePF_out(2,:)], 0.2, 'faceColor', colorGray);
hold on;
bar(xptPF_eYFP, [tablePF_in(3,:), tablePF_out(3,:)], 0.2, 'faceColor', colorDarkGray);
set(hBar(1),'XLim',[0,25],'XTick',xptPF_nolight,'XTickLabel',{'In_Act';'In_Ina';'In_No';'Out_Act';'Out_Ina';'Out_No'});
text(1,85,'Blue: DRun','fontSize',fontXL,'color',colorBlue,'fontWeight','bold');
text(1,75,'Gray: noRun','fontSize',fontXL,'color',colorGray,'fontWeight','bold');
text(1,65,'Black: eYFP','fontSize',fontXL,'color',colorDarkGray,'fontWeight','bold');
for iText = 1:6
    text(xptPF_light(iText)-0.2, yptText, num2str(table(1,iText)),'fontSize',fontL);
    text(xptPF_nolight(iText)-0.2, yptText, num2str(table(2,iText)),'fontSize',fontL);
    text(xptPF_eYFP(iText)-0.2, yptText, num2str(table(5,iText)),'fontSize',fontL);
end
ylabel('proportion (%)','fontSize',fontL);
title('Place field','fontSize',fontXL);

hBar(2) = axes('Position',axpt(1,5,1,2,[0.1 0.1 0.85 0.85],midInterval));
bar(xptNPF_light, tableNPF(1,:), 0.2, 'faceColor', colorBlue);
hold on;
bar(xptNPF_nolight, tableNPF(2,:), 0.2, 'faceColor', colorGray);
hold on;
bar(xptNPF_eYFP, tableNPF(3,:), 0.2, 'faceColor', colorDarkGray);
for iText = 1:3
    text(xptNPF_light(iText)-0.2, yptText, num2str(table(1,iText+6)),'fontSize',fontL);
    text(xptNPF_nolight(iText)-0.2, yptText, num2str(table(2,iText+6)),'fontSize',fontL);
    text(xptNPF_eYFP(iText)-0.2, yptText, num2str(table(5,iText+6)),'fontSize',fontL);
end
set(hBar(2),'XLim',[0,12],'XTick',xptNPF_nolight,'XTickLabel',{'Act';'Ina';'No'});
ylabel('proportion (%)','fontSize',fontL);
title('Non place field','fontSize',fontXL);

hBar(3) = axes('Position',axpt(1,5,1,3,[0.1 0.1 0.85 0.85],midInterval));
bar(xptNPF_light, tablePN(1,:), 0.2, 'faceColor', colorBlue);
hold on;
bar(xptNPF_nolight, tablePN(2,:), 0.2, 'faceColor', colorGray);
hold on;
bar(xptNPF_eYFP, tablePN(3,:), 0.2, 'faceColor', colorDarkGray);
text(1, yptText, num2str((table(1,1)+table(1,4)+table(1,7))),'fontSize',fontL);
text(2, yptText, num2str((table(2,1)+table(2,4)+table(2,7))),'fontSize',fontL);
text(3, yptText, num2str((table(5,1)+table(5,4)+table(5,7))),'fontSize',fontL);
text(5, yptText, num2str((table(1,2)+table(1,5)+table(1,8))),'fontSize',fontL);
text(6, yptText, num2str((table(2,2)+table(2,5)+table(2,8))),'fontSize',fontL);
text(7, yptText, num2str((table(5,2)+table(5,5)+table(5,8))),'fontSize',fontL);
text(9, yptText, num2str((table(1,3)+table(1,6)+table(1,9))),'fontSize',fontL);
text(10, yptText, num2str((table(2,3)+table(2,6)+table(2,9))),'fontSize',fontL);
text(11, yptText, num2str((table(5,3)+table(5,6)+table(5,9))),'fontSize',fontL);
set(hBar(3),'XLim',[0,12],'XTick',xptNPF_nolight,'XTickLabel',{'Act';'Ina';'No'});
ylabel('proportion (%)','fontSize',fontL);
title('Pyramidal neuron','fontSize',fontXL);

hBar(4) = axes('Position',axpt(1,5,1,4,[0.1 0.1 0.85 0.85],midInterval));
bar(xptIN_light, tableIN(1,:), 0.2, 'faceColor', colorBlue);
hold on;
bar(xptIN_nolight, tableIN(2,:), 0.2, 'faceColor', colorGray);
hold on;
bar(xptIN_eYFP, tableIN(3,:), 0.2, 'faceColor', colorDarkGray);
for iText = 1:3
    text(xptIN_light(iText)-0.2, yptText, num2str(table(1,iText+9)),'fontSize',fontL);
    text(xptIN_nolight(iText)-0.2, yptText, num2str(table(2,iText+9)),'fontSize',fontL);
    text(xptIN_eYFP(iText)-0.2, yptText, num2str(table(5,iText+9)),'fontSize',fontL);
end
set(hBar(4),'XLim',[0,12],'XTick',xptIN_nolight,'XTickLabel',{'Act';'Ina';'No'});
ylabel('proportion (%)','fontSize',fontL);
title('Interneuron','fontSize',fontXL);

hBar(5) = axes('Position',axpt(1,5,1,5,[0.1 0.1 0.85 0.85],midInterval));
bar(xptUNC_light, tableUNC(1,:), 0.2, 'faceColor', colorBlue);
hold on;
bar(xptUNC_nolight, tableUNC(2,:), 0.2, 'faceColor', colorGray);
hold on;
bar(xptUNC_eYFP, tableUNC(3,:), 0.2, 'faceColor', colorDarkGray);
for iText = 1:3
    text(xptUNC_light(iText)-0.2, yptText, num2str(table(1,iText+12)),'fontSize',fontL);
    text(xptUNC_nolight(iText)-0.2, yptText, num2str(table(2,iText+12)),'fontSize',fontL);
    text(xptUNC_eYFP(iText)-0.2, yptText, num2str(table(5,iText+12)),'fontSize',fontL);
end
set(hBar(5),'XLim',[0,12],'XTick',xptUNC_nolight,'XTickLabel',{'Act';'Ina';'No'});
ylabel('proportion (%)','fontSize',fontL);
title('Unclassfied neuron','fontSize',fontXL);

set(hBar,'Box','off','TickDir','out','YLim',[0 110],'YTick',0:10:100);
print('-painters','-dtiff','-r300',[datestr(now,formatOut),'_plot_Run_table.tif']);

%% DRw
fHandle = figure('PaperUnits','centimeters','PaperPosition',[0 0 30 40]);
hBar(1) = axes('Position',axpt(1,5,1,1,[0.1 0.1 0.85 0.85],midInterval));
bar(xptPF_light, [tablePF_in(4,:), tablePF_out(4,:)], 0.2, 'faceColor', colorBlue);
hold on;
bar(xptPF_nolight, [tablePF_in(5,:), tablePF_out(5,:)], 0.2, 'faceColor', colorGray);
hold on;
bar(xptPF_eYFP, [tablePF_in(6,:), tablePF_out(6,:)], 0.2, 'faceColor', colorDarkGray);
for iText = 1:6
    text(xptPF_light(iText)-0.2, yptText, num2str(table(3,iText)),'fontSize',fontL);
    text(xptPF_nolight(iText)-0.2, yptText, num2str(table(4,iText)),'fontSize',fontL);
    text(xptPF_eYFP(iText)-0.2, yptText, num2str(table(6,iText)),'fontSize',fontL);
end
set(hBar(1),'XLim',[0,25],'XTick',xptPF_nolight,'XTickLabel',{'In_Act';'In_Ina';'In_No';'Out_Act';'Out_Ina';'Out_No'});
text(1,85,'Blue: DRw','fontSize',fontXL,'color',colorBlue,'fontWeight','bold');
text(1,75,'Gray: noRw','fontSize',fontXL,'color',colorGray,'fontWeight','bold');
text(1,65,'Black: eYFP','fontSize',fontXL,'color',colorDarkGray,'fontWeight','bold');
ylabel('proportion (%)','fontSize',fontL);
title('Place field','fontSize',fontXL);

hBar(2) = axes('Position',axpt(1,5,1,2,[0.1 0.1 0.85 0.85],midInterval));
bar(xptNPF_light, tableNPF(4,:), 0.2, 'faceColor', colorBlue);
hold on;
bar(xptNPF_nolight, tableNPF(5,:), 0.2, 'faceColor', colorGray);
hold on;
bar(xptNPF_eYFP, tableNPF(6,:), 0.2, 'faceColor', colorDarkGray);
for iText = 1:3
    text(xptNPF_light(iText)-0.2, yptText, num2str(table(3,iText+6)),'fontSize',fontL);
    text(xptNPF_nolight(iText)-0.2, yptText, num2str(table(4,iText+6)),'fontSize',fontL);
    text(xptNPF_eYFP(iText)-0.2, yptText, num2str(table(6,iText+6)),'fontSize',fontL);
end
set(hBar(2),'XLim',[0,12],'XTick',xptNPF_nolight,'XTickLabel',{'Act';'Ina';'No'});
ylabel('proportion (%)','fontSize',fontL);
title('Non place field','fontSize',fontXL);

hBar(3) = axes('Position',axpt(1,5,1,3,[0.1 0.1 0.85 0.85],midInterval));
bar(xptNPF_light, tablePN(4,:), 0.2, 'faceColor', colorBlue);
hold on;
bar(xptNPF_nolight, tablePN(5,:), 0.2, 'faceColor', colorGray);
hold on;
bar(xptNPF_eYFP, tablePN(6,:), 0.2, 'faceColor', colorDarkGray);
text(1, yptText, num2str((table(3,1)+table(3,4)+table(3,7))),'fontSize',fontL);
text(2, yptText, num2str((table(4,1)+table(4,4)+table(4,7))),'fontSize',fontL);
text(3, yptText, num2str((table(6,1)+table(6,4)+table(6,7))),'fontSize',fontL);
text(5, yptText, num2str((table(3,2)+table(3,5)+table(3,8))),'fontSize',fontL);
text(6, yptText, num2str((table(4,2)+table(4,5)+table(4,8))),'fontSize',fontL);
text(7, yptText, num2str((table(6,2)+table(6,5)+table(6,8))),'fontSize',fontL);
text(9, yptText, num2str((table(3,3)+table(3,6)+table(3,9))),'fontSize',fontL);
text(10, yptText, num2str((table(4,3)+table(4,6)+table(4,9))),'fontSize',fontL);
text(11, yptText, num2str((table(6,3)+table(6,6)+table(6,9))),'fontSize',fontL);
set(hBar(3),'XLim',[0,12],'XTick',xptNPF_nolight,'XTickLabel',{'Act';'Ina';'No'});
ylabel('proportion (%)','fontSize',fontL);
title('Pyramidal neuron','fontSize',fontXL);

hBar(4) = axes('Position',axpt(1,5,1,4,[0.1 0.1 0.85 0.85],midInterval));
bar(xptIN_light, tableIN(4,:), 0.2, 'faceColor', colorBlue);
hold on;
bar(xptIN_nolight, tableIN(5,:), 0.2, 'faceColor', colorGray);
hold on;
bar(xptIN_eYFP, tableIN(6,:), 0.2, 'faceColor', colorDarkGray);

text(xptIN_light(iText)-0.2, yptText, num2str(table(3,iText+9)),'fontSize',fontL);
text(xptIN_nolight(iText)-0.2, yptText, num2str(table(4,iText+9)),'fontSize',fontL);
text(xptIN_eYFP(iText)-0.2, yptText, num2str(table(6,iText+9)),'fontSize',fontL);

set(hBar(4),'XLim',[0,12],'XTick',xptIN_nolight,'XTickLabel',{'Act';'Ina';'No'});
ylabel('proportion (%)','fontSize',fontL);
title('Interneuron','fontSize',fontXL);

hBar(5) = axes('Position',axpt(1,5,1,5,[0.1 0.1 0.85 0.85],midInterval));
bar(xptUNC_light, tableUNC(4,:), 0.2, 'faceColor', colorBlue);
hold on;
bar(xptUNC_nolight, tableUNC(5,:), 0.2, 'faceColor', colorGray);
hold on;
bar(xptUNC_eYFP, tableUNC(6,:), 0.2, 'faceColor', colorDarkGray);
for iText = 1:3
    text(xptUNC_light(iText)-0.2, yptText, num2str(table(3,iText+12)),'fontSize',fontL);
    text(xptUNC_nolight(iText)-0.2, yptText, num2str(table(4,iText+12)),'fontSize',fontL);
    text(xptUNC_eYFP(iText)-0.2, yptText, num2str(table(6,iText+12)),'fontSize',fontL);
end
set(hBar(5),'XLim',[0,12],'XTick',xptUNC_nolight,'XTickLabel',{'Act';'Ina';'No'});
ylabel('proportion (%)','fontSize',fontL);
title('Unclassfied neuron','fontSize',fontXL);

set(hBar,'Box','off','TickDir','out','YLim',[0 110],'YTick',0:10:100);
% print('-painters','-dtiff','-r300',[datestr(now,formatOut),'_plot_Rw_table.tif']);
% close all;