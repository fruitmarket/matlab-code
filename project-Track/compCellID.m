clearvars;
cd('D:\Dropbox\SNL\P2_Track');

T = readtable('cellList_30-Jan-2017.xlsx');
compareID = ~isnan(T.cellID); % find non-nan index
parentDir = 'D:\Dropbox\#team_hippocampus Team Folder\project_Track\samples_v8\group';
nComp = max(T.cellID(compareID));

compPlace = ~isnan(T.cellID) & (T.placefieldTrack == 1);
list_compPlace = T.cellID(compPlace);

compPlaceinStm = ~isnan(T.cellID) & (T.placefieldStmZone == 1);
list_compPlaceStm = T.cellID(compPlaceinStm);

% for iCell = 1:nComp
%    fileName = T.path(T.cellID == iCell);
%    mkdir(parentDir, ['comp_',num2str(iCell)]);
%    plot_Track_multi_v3(fileName,[parentDir,'\comp_',num2str(iCell)]);   
% end
% cd(parentDir);