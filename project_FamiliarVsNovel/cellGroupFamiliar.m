clearvars;
rtDir = 'E:\Dropbox\Lab_mwjung\P4_FamiliarNovel';
cd(rtDir);

%% Loading cell information
% load('neuronList_ori_171018.mat');
% Txls = readtable('neuronList_ori_171018.xlsx');
% Txls.taskType = categorical(Txls.taskType);
load('E:\Dropbox\Lab_mwjung\P4_FamiliarNovel\neuronList_familiar_190203.mat');
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

dirParent = 'E:\Dropbox\Lab_mwjung\P4_FamiliarNovel\example_familiar';
% rmdir(dirParent,'s');

% fileName = T.path(PN);
% cellID = T.cellID(PN);
% path = strcat(dirParent,'\PN');
% plot_Track_multi_Familiar(fileName,cellID,path);

% fileName = T.path(PN_ca3a);
% cellID = T.cellID(PN_ca3a);
% path = strcat(dirParent,'\PN_ca3a');
% plot_Track_multi_Familiar(fileName,cellID,path);

% fileName = T.path(PN_ca3bc);
% cellID = T.cellID(PN_ca3bc);
% path = strcat(dirParent,'\PN_ca3bc');
% plot_Track_multi_Familiar(fileName,cellID,path);

% fileName = T.path(PN_PF);
% cellID = T.cellID(PN_PF);
% path = strcat(dirParent,'\PN_PF');
% plot_Track_multi_Familiar(fileName,cellID,path);

% fileName = T.path(PN_nonPF);
% cellID = T.cellID(PN_nonPF);
% path = strcat(dirParent,'\PN_nonPF');
% plot_Track_multi_Familiar(fileName,cellID,path);

fileName = T.path(IN);
cellID = T.cellID(IN);
mkdir(dirParent,'\IN');
path = strcat(dirParent,'\IN');
plot_Track_multi_Familiar(fileName,cellID,path);

% fileName = T.path(UNC);
% cellID = T.cellID(UNC);
% path = strcat(dirParent,'\UNC');
% plot_Track_multi_Familiar(fileName,cellID,path);