clearvars;
cd('D:\Dropbox\SNL\P2_Track');

T = readtable('neuronList_12-Feb-2017.xlsx');
T.taskType = categorical(T.taskType);
alpha = 0.005;
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

%% pc_DRun or DRw
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

%% pcStm_DRun or DRw
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

%% non-place cell
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
% cellID = T.cellID(sig_DRun);
% plot_Track_multi_v3(fileName, cellID, fd_sigDRun);
% 
% nosig_DRun = (T.taskType == 'DRun') & ((T.pLR_Plfm2hz>alpha) & (T.pLR_Track>alpha));
% fd_nosigDRun = [folder, 'light_nosigDRun'];
% fileName = T.path(nosig_DRun);
% cellID = T.cellID(nosig_DRun);
% plot_Track_multi_v3(fileName, cellID, fd_nosigDRun);
% 
% sig_DRw = (T.taskType == 'DRw') & ((T.pLR_Plfm2hz<=alpha) | (T.pLR_Track<=alpha));
% fd_sigDRw = [folder, 'light_sigDRw'];
% fileName = T.path(sig_DRw);
% cellID = T.cellID(sig_DRw);
% plot_Track_multi_v3(fileName, cellID, fd_sigDRw);
% 
% nosig_DRw = (T.taskType == 'DRw') & ((T.pLR_Plfm2hz>alpha) & (T.pLR_Track>alpha));
% fd_nosigDRw = [folder, 'light_nosigDRw'];
% fileName = T.path(nosig_DRw);
% cellID = T.cellID(nosig_DRw);
% plot_Track_multi_v3(fileName, cellID, fd_nosigDRw);
% cd('D:\Dropbox\SNL\P2_Track');

%% Task Type
total_DRun = T.taskType == 'DRun';
fd_totalDRun = [folder, 'v9_DRun'];
fileName = T.path(total_DRun);
cellID = T.cellID(total_DRun);
plot_Track_multi_v3(fileName, cellID, fd_totalDRun);

total_noRun = T.taskType == 'noRun';
fd_totalnoRun = [folder, 'v9_noRun'];
fileName = T.path(total_noRun);
cellID = T.cellID(total_noRun);
plot_Track_multi_v3(fileName, cellID, fd_totalnoRun);

total_DRw = T.taskType == 'DRw';
fd_totalDRw = [folder, 'v9_DRw'];
fileName = T.path(total_DRw);
cellID = T.cellID(total_DRw);
plot_Track_multi_v3(fileName, cellID, fd_totalDRw);

total_noRw = T.taskType == 'noRw';
fd_totalnoRw = [folder, 'v9_noRw'];
fileName = T.path(total_noRw);
cellID = T.cellID(total_noRw);
plot_Track_multi_v3(fileName, cellID, fd_totalnoRw);
cd('D:\Dropbox\SNL\P2_Track');