clearvars;
cd('D:\Dropbox\SNL\P2_Track');

T = readtable('cellList_30-Jan-2017.xlsx');
T.taskType = categorical(T.taskType);

%% Session compare

compareID = ~isnan(T.cellID); % find non-nan index
nComp = max(T.cellID(compareID));
% parentDir = 'D:\Dropbox\#team_hippocampus Team Folder\project_Track\samples_v8\group';
% for iCell = 1:nComp
%    fileName = T.path(T.cellID == iCell);
%    mkdir(parentDir, ['comp_',num2str(iCell)]);
%    plot_Track_multi_v3(fileName,[parentDir,'\comp_',num2str(iCell)]);   
% end
% cd(parentDir);
% compPlace = ~isnan(T.cellID) & (T.placefieldTrack == 1);
% list_compPlace = T.cellID(compPlace);
% 
% compPlaceinStm = ~isnan(T.cellID) & (T.placefieldStmZone == 1);
% list_compPlaceStm = T.cellID(compPlaceinStm);

%% 
% pc_DRun = ((T.taskType == 'DRun') & (T.placefieldTrack == 1));
% parentDir = 'D:\Dropbox\#team_hippocampus Team Folder\project_Track\samples_v8\pc_DRun';
% fileName = T.path(pc_DRun);
% plot_Track_multi_v3(fileName,parentDir);

% pc_DRw = ((T.taskType == 'DRw') & (T.placefieldTrack == 1));
% parentDir = 'D:\Dropbox\#team_hippocampus Team Folder\project_Track\samples_v8\pc_DRw';
% fileName = T.path(pc_DRw);
% plot_Track_multi_v3(fileName,parentDir);

%%
% pcStm_DRun = ((T.taskType == 'DRun') & (T.placefieldTrack == 1) & (T.placefieldStmZone == 1));
% parentDir = 'D:\Dropbox\#team_hippocampus Team Folder\project_Track\samples_v8\pcStm_DRun';
% fileName = T.path(pcStm_DRun);
% plot_Track_multi_v3(fileName,parentDir);
% 
% pcStm_DRw = ((T.taskType == 'DRw') & (T.placefieldTrack == 1) & (T.placefieldStmZone == 1));
% parentDir = 'D:\Dropbox\#team_hippocampus Team Folder\project_Track\samples_v8\pcStm_DRw';
% fileName = T.path(pcStm_DRw);
% plot_Track_multi_v3(fileName,parentDir);

%% non-place cell
npc_DRun = ((T.taskType == 'DRun') & (T.placefieldTrack == 0));
parentDir = 'D:\Dropbox\#team_hippocampus Team Folder\project_Track\samples_v8\npc_DRun';
fileName = T.path(npc_DRun);
plot_Track_multi_v3(fileName,parentDir);

npc_DRw = ((T.taskType == 'DRw') & (T.placefieldTrack == 0));
parentDir = 'D:\Dropbox\#team_hippocampus Team Folder\project_Track\samples_v8\npc_DRw';
fileName = T.path(npc_DRw);
plot_Track_multi_v3(fileName,parentDir);

cd('D:\Dropbox\SNL\P2_Track');