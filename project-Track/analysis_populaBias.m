cd('D:\Dropbox\SNL\P2_Track');
load('neuronList_ori_170516.mat');
Txls = readtable('neuronList_ori_170516.xlsx');
% load myParameters.mat


cMeanFR = 9;
cMaxPeakFR = 1;
cSpkpvr = 1.1;
alpha = 0.01;
areaDRun = [5/6 4/3]*pi*20; % 6-9 o'clock
areaDRw = [3/2 5/3]*pi*20; % 10-11 o'clock
areaRw1 = [1/2 2/3]*pi*20; % 4-5 o'clock
areaRw2 = [3/2 5/3]*pi*20; % 10-11 o'clock
errorPosi = 5;
correctY = 0.5;
lightBand = 3;

condiTN = (cellfun(@max, T.peakFR1D_track) > cMaxPeakFR) & ~(cellfun(@(x) any(isnan(x)),T.peakloci_total));
condiPN = T.spkpvr>cSpkpvr & T.meanFR_task<cMeanFR;
condiIN = ~condiPN;

%% DRun sessions
DRunTN = (T.taskType == 'DRun') & condiTN;
DRunPN = DRunTN & condiPN;
DRunIN = DRunTN & condiIN;

%% find inactivated population
trackInac_DRunPN = DRunPN & (T.pLR_Track < alpha) & (T.statDir_Track == -1);
mfr_zone = T.sensorMeanFR_DRun(trackInac_DRunPN);

%% find lowest mean FR & mean FR at zone & lowest peak FR
mean_mfr_zone = min(cellfun(@(x) mean(x(31:60)),mfr_zone));

%% mean based neural population (act, inact, noresp)
populPass = DRunPN & ((cellfun(@(x) min(mean(x(31:60))),T.sensorMeanFR_DRun)) >= mean_mfr_zone) & (T.pLR_Track < alpha);
populAct = populPass & (T.statDir_Track == 1);
populIna = populPass & (T.statDir_Track == -1);
populNorsp = DRunPN & ((cellfun(@(x) min(mean(x(31:60))),T.sensorMeanFR_DRun)) >= mean_mfr_zone) & (T.pLR_Track >= alpha);

npopulPass = sum(double(populPass));
npopulAct = sum(double(populAct));
npopulIna = sum(double(populIna));
npopulNorsp = sum(double(populNorsp));

% folder = 'D:\Dropbox\#team_hippocampus Team Folder\project_Track\samples_v9\';
% fd_passAct = [folder, 'passAct_DRun'];
% fileName = T.path(populAct);
% cellID = Txls.cellID(populAct);
% plot_Track_multi_v3(fileName, cellID, fd_passAct);
% 
% folder = 'D:\Dropbox\#team_hippocampus Team Folder\project_Track\samples_v9\';
% fd_passIna = [folder, 'passIna_DRun'];
% fileName = T.path(populIna);
% cellID = Txls.cellID(populIna);
% plot_Track_multi_v3(fileName, cellID, fd_passIna);

% folder = 'D:\Dropbox\#team_hippocampus Team Folder\project_Track\samples_v9\';
% fd_passNorsp = [folder, 'passNorsp_DRun'];
% fileName = T.path(populNorsp);
% cellID = Txls.cellID(populNorsp);
% plot_Track_multi_v3(fileName, cellID, fd_passNorsp);

cd('D:\Dropbox\SNL\P2_Track');