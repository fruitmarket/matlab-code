clearvars;
rtDir = 'E:\Dropbox\Lab_mwjung\P4_FamiliarNovel';
cd(rtDir);

%% Loading cell information
% load('neuronList_ori_171018.mat');
% Txls = readtable('neuronList_ori_171018.xlsx');
% Txls.taskType = categorical(Txls.taskType);
% load('neuronList_novel_180708.mat');
load('E:\Dropbox\Lab_mwjung\P4_FamiliarNovel\neuronList_novel_190208.mat');
formatOut = 'yymmdd';

%% All neurons
condition_pf = T.idxPeakFR & T.idxTotalSpikeNum & T.idxPlaceField;
PN = T.neuronType == 'PN';
tt_ca3bc = ((T.mouseID == 'rbp005' & (T.tetrode == 'TT1' | T.tetrode == 'TT5')) | (T.mouseID == 'rbp006' & T.tetrode == 'TT2') | (T.mouseID == 'rbp010' & T.tetrode == 'TT6')); % | (T.mouseID == 'rbp015' & T.tetrode == 'TT7')
PN_ca3bc = PN & tt_ca3bc;
PN_ca3a = PN & ~tt_ca3bc;
PN_PF = T.neuronType == 'PN' & condition_pf;
PN_nonPF = T.neuronType == 'PN' & ~condition_pf;
IN = T.neuronType == 'IN';
UNC = T.neuronType == 'UNC';

cri_peakFR = 2;
dirParent = 'E:\Dropbox\Lab_mwjung\P4_FamiliarNovel';

% fileName = T.path(PN);
% cellID = T.cellID(PN);
% path = strcat(dirParent,'\PN');
% plot_Track_multi_Novel(fileName,cellID,path);

% fileName = T.path(PN_ca3a);
% cellID = T.cellID(PN_ca3a);
% path = strcat(dirParent,'\PN_ca3a');
% plot_Track_multi_Novel(fileName,cellID,path);
 
% fileName = T.path(PN_ca3bc);
% cellID = T.cellID(PN_ca3bc);
% path = strcat(dirParent,'\PN_ca3bc');
% plot_Track_multi_Novel(fileName,cellID,path);

% neuron_act = PN & T.idxmFrIn == 1;
% neuron_inh = PN & T.idxmFrIn == -1;
% neuron_non = PN & T.idxmFrIn == 0;

%% light response
% fileName = T.path(neuron_act);
% cellID = T.cellID(neuron_act);
% path = strcat(dirParent,'\example_novel\example_act');
% plot_Track_multi_Novel(fileName,cellID,path);
% 
% fileName = T.path(neuron_inh);
% cellID = T.cellID(neuron_inh);
% path = strcat(dirParent,'\example_novel\example_inh');
% plot_Track_multi_Novel(fileName,cellID,path);

%% PRE vs. POST
% PRE vs POST, significant changes in Inzone
% sigIn_inc = cellfun(@(x) x(2,1)<0.05, T.p_ttestFr) & cellfun(@(x) x(4)>x(2),T.m_lapFrInzone); % increased
% fileName = T.path(sigIn_inc);
% cellID = T.cellID(sigIn_inc);
% path = strcat(dirParent,'\example_novel\example_PrePostIn_inc');
% plot_Track_multi_Novel(fileName,cellID,path);

% sigIn_dec = cellfun(@(x) x(2,1)<0.05, T.p_ttestFr) & cellfun(@(x) x(4)<x(2),T.m_lapFrInzone); % decreased
% fileName = T.path(sigIn_dec);
% cellID = T.cellID(sigIn_dec);
% path = strcat(dirParent,'\example_novel\example_PrePostIn_dec');
% plot_Track_multi_Novel(fileName,cellID,path);

% PRE vs POST, significant chages in Outzone
% sigOut_inc = cellfun(@(x) x(2,2)<0.05, T.p_ttestFr) & cellfun(@(x) x(4)>x(2),T.m_lapFrOutzone); % increased
% fileName = T.path(sigOut_inc);
% cellID = T.cellID(sigOut_inc);
% path = strcat(dirParent,'\example_novel\example_PrePostOut_inc');
% plot_Track_multi_Novel(fileName,cellID,path);

% sigOut_dec = cellfun(@(x) x(2,2)<0.05, T.p_ttestFr) & cellfun(@(x) x(4)<x(2),T.m_lapFrOutzone); % decreased
% fileName = T.path(sigOut_dec);
% cellID = T.cellID(sigOut_dec);
% path = strcat(dirParent,'\example_novel\example_PrePostOut_dec');
% plot_Track_multi_Novel(fileName,cellID,path);

% PRE vs POST, significant chages in Total
% sigTot_inc = cellfun(@(x) x(2,3)<0.05, T.p_ttestFr) & cellfun(@(x) x(4)>x(2),T.m_lapFrTotalzone); % increased
% fileName = T.path(sigTot_inc);
% cellID = T.cellID(sigTot_inc);
% path = strcat(dirParent,'\example_novel\example_PrePostTot_inc');
% plot_Track_multi_Novel(fileName,cellID,path);

% sigTot_dec = cellfun(@(x) x(2,3)<0.05, T.p_ttestFr) & cellfun(@(x) x(4)<x(2),T.m_lapFrTotalzone); % increased
% fileName = T.path(sigTot_dec);
% cellID = T.cellID(sigTot_dec);
% path = strcat(dirParent,'\example_novel\example_PrePostTot_dec');
% plot_Track_multi_Novel(fileName,cellID,path);

%%
% fileName = T.path(neuron_non);
% cellID = T.cellID(neuron_non);
% path = strcat(dirParent,'\example_novel\example_non');
% plot_Track_multi_Novel(fileName,cellID,path);

% fileName = T.path(PN_PF);
% cellID = T.cellID(PN_PF);
% path = strcat(dirParent,'\PN_PF');
% plot_Track_multi_Novel(fileName,cellID,path);

% fileName = T.path(PN_nonPF);
% cellID = T.cellID(PN_nonPF);
% path = strcat(dirParent,'\PN_nonPF');
% plot_Track_multi_Novel(fileName,cellID,path);

fileName = T.path(IN);
cellID = T.cellID(IN);
mkdir(dirParent,'\IN');
path = strcat(dirParent,'\IN');
plot_Track_multi_Novel(fileName,cellID,path);

% fileName = T.path(UNC);
% cellID = T.cellID(UNC);
% path = strcat(dirParent,'\UNC');
% plot_Track_multi_Novel(fileName,cellID,path);

% PN_th_bc = PN_ca3bc & cellfun(@(x) max(max(x(2:4,:))), T.pethconvSpatial)>cri_peakFR;
% fileName = T.path(PN_th_bc);
% cellID = T.cellID(PN_th_bc);
% path = strcat(dirParent,'\example_novel_lowCorr');
% plot_Track_multi_Novel(fileName,cellID,path);
