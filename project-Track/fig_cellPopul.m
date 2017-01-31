alpha = 0.005;

% Load table
cd('D:\Dropbox\#team_hippocampus Team Folder\project_Track');
load(['cellList_ori','.mat']);

% rtDir_total = 'D:\Dropbox\#team_hippocampus Team Folder\project_Track\samples_v8\v8_DRw_total';

rtDir_total = 'D:\Dropbox\#team_hippocampus Team Folder\project_Track\samples_v8\v8_noRun_total';

% rtDir_sig = 'D:\Dropbox\#team_hippocampus Team Folder\project_Track\samples_v8\v8_DRun_sig';
% rtDir_nosig = 'D:\Dropbox\#team_hippocampus Team Folder\project_Track\samples_v8\v8_DRun_noSig';

%%
popul = (T.taskType == 'noRun');
% total_DRun = T.taskType == 'DRun' & T.peakFR_track>1;
nTotal_popul = sum(double(popul));

%% Single cell figure separation
figList_DRun_total = T.path(popul);
plot_Track_multi_v3(figList_DRun_total,rtDir_total);

% figList_DRunlightPN_sig = T.path((total_DRun & T.pLR_Plfm2hz < alpha) | (total_DRun & T.pLR_Track < alpha));
% plot_Track_multi_v3(figList_DRunlightPN_sig,rtDir_sig);

% figList_DRunlightPN_nosig = T.path((total_DRun & ~(T.pLR_Plfm2hz < alpha)) & (total_DRun & ~(T.pLR_Track < alpha)));
% plot_Track_multi_v3(figList_DRunlightPN_nosig,rtDir_nosig);

cd('D:\Dropbox\#team_hippocampus Team Folder\project_Track');