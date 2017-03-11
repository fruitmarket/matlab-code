cd('D:\Dropbox\SNL\P2_Track');
Txls = readtable('neuronList_03-Mar-2017.xlsx');
load('neuronList_ori_05-Mar-2017.mat');

cri_meanFR = 7;
cri_peakFR = 0;
alpha = 0.01;

% TN: track neuron
DRunTN = (T.taskType == 'DRun') & (cellfun(@max, T.peakFR1D_track) > cri_peakFR);
DRwTN = (T.taskType == 'DRw') & (cellfun(@max, T.peakFR1D_track) > cri_peakFR);
noRunTN = (T.taskType == 'noRun') & (cellfun(@max, T.peakFR1D_track) > cri_peakFR);
noRwTN = (T.taskType == 'noRw') & (cellfun(@max, T.peakFR1D_track) > cri_peakFR);

% Platform total population with light responsiveness (light activated)
DRunPN_plfmAct = sum(double(DRunTN & T.meanFR_task <= cri_meanFR & T.pLR_Plfm2hz<alpha & T.statDir_Plfm2hz == 1));
DRunIN_plfmAct = sum(double(DRunTN & T.meanFR_task > cri_meanFR & T.pLR_Plfm2hz<alpha & T.statDir_Plfm2hz == 1));
DRwPN_plfmAct = sum(double(DRwTN & T.meanFR_task <= cri_meanFR & T.pLR_Plfm2hz<alpha & T.statDir_Plfm2hz == 1));
DRwIN_plfmAct = sum(double(DRwTN & T.meanFR_task > cri_meanFR & T.pLR_Plfm2hz<alpha & T.statDir_Plfm2hz == 1));

DRunPN_plfmIna = sum(double(DRunTN & T.meanFR_task <= cri_meanFR & T.pLR_Plfm2hz<alpha & T.statDir_Plfm2hz == -1));
DRunIN_plfmIna = sum(double(DRunTN & T.meanFR_task > cri_meanFR & T.pLR_Plfm2hz<alpha & T.statDir_Plfm2hz == -1));
DRwPN_plfmIna = sum(double(DRwTN & T.meanFR_task <= cri_meanFR & T.pLR_Plfm2hz<alpha & T.statDir_Plfm2hz == -1));
DRwIN_plfmIna = sum(double(DRwTN & T.meanFR_task > cri_meanFR & T.pLR_Plfm2hz<alpha & T.statDir_Plfm2hz == -1));

% Track total population
DRunPN_trackAct = sum(double(DRunTN & T.meanFR_task <= cri_meanFR & T.pLR_Track<alpha & T.statDir_Track == 1));
DRunIN_trackAct = sum(double(DRunTN & T.meanFR_task > cri_meanFR & T.pLR_Track<alpha & T.statDir_Track == 1));
DRwPN_trackAct = sum(double(DRwTN & T.meanFR_task <= cri_meanFR & T.pLR_Track<alpha & T.statDir_Track == 1));
DRwIN_trackAct = sum(double(DRwTN & T.meanFR_task > cri_meanFR & T.pLR_Track<alpha & T.statDir_Track == 1));

DRunPN_trackIna = sum(double(DRunTN & T.meanFR_task <= cri_meanFR & T.pLR_Track<alpha & T.statDir_Track == -1));
DRunIN_trackIna = sum(double(DRunTN & T.meanFR_task > cri_meanFR & T.pLR_Track<alpha & T.statDir_Track == -1));
DRwPN_t
rackIna = sum(double(DRwTN & T.meanFR_task <= cri_meanFR & T.pLR_Track<alpha & T.statDir_Track == -1));
DRwIN_trackIna = sum(double(DRwTN & T.meanFR_task > cri_meanFR & T.pLR_Track<alpha & T.statDir_Track == -1));


latTrack_DRunPN = T.latencyTrack(DRunPN_plfmAct & T.pLR_Track<alpha & T.statDir_Track==1);
latTrack_DRunIN = T.latencyTrack(DRunIN_plfmAct & T.pLR_Track<alpha & T.statDir_Track==1);

latTrack_DRwPN = T.latencyTrack(DRwPN_plfmAct & T.pLR_Track<alpha & T.statDir_Track==1);
latTrack_DRwIN = T.latencyTrack(DRwIN_plfmAct & T.pLR_Track<alpha & T.statDir_Track==1);
