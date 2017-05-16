clearvars;
cd('D:\Dropbox\SNL\P2_Track');

Txls = readtable('neuronList_ori_170516.xlsx');
Txls.taskType = categorical(Txls.taskType);

load('neuronList_ori_170516.mat');
alpha = 0.01;
cri_Peak = 9;
folder = 'D:\Dropbox\#team_hippocampus Team Folder\project_Track\samples_v9\';
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
sig_DRun = (T.taskType == 'DRun') & ((T.pLR_Plfm2hz<=alpha) | (T.pLR_Track<=alpha));
fd_sigDRun = [folder, 'light_sigDRun'];
fileName = T.path(sig_DRun);
cellID = Txls.cellID(sig_DRun);
plot_Track_multi_v3(fileName, cellID, fd_sigDRun);

nosig_DRun = (T.taskType == 'DRun') & ((T.pLR_Plfm2hz>alpha) & (T.pLR_Track>alpha));
fd_nosigDRun = [folder, 'light_nosigDRun'];
fileName = T.path(nosig_DRun);
cellID = Txls.cellID(nosig_DRun);
plot_Track_multi_v3(fileName, cellID, fd_nosigDRun);

sig_DRw = (T.taskType == 'DRw') & ((T.pLR_Plfm2hz<=alpha) | (T.pLR_Track<=alpha));
fd_sigDRw = [folder, 'light_sigDRw'];
fileName = T.path(sig_DRw);
cellID = Txls.cellID(sig_DRw);
plot_Track_multi_v3(fileName, cellID, fd_sigDRw);

nosig_DRw = (T.taskType == 'DRw') & ((T.pLR_Plfm2hz>alpha) & (T.pLR_Track>alpha));
fd_nosigDRw = [folder, 'light_nosigDRw'];
fileName = T.path(nosig_DRw);
cellID = Txls.cellID(nosig_DRw);
plot_Track_multi_v3(fileName, cellID, fd_nosigDRw);
cd('D:\Dropbox\SNL\P2_Track');

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
