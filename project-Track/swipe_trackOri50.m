%% Directory setup
rtPath = 'D:\Dropbox\SNL\P2_Track';
startingDir = {'D:\Projects\Track_170119-1_Rbp70ori50';
               'D:\Projects\Track_170109-2_Rbp72ori50'};
% startingDir = {'D:\Projects\Track_160417-1_Rbp32ori'};

matFile = [];
tFile = [];
nDir = size(startingDir,1);
for iDir = 1:nDir
%% Mat file
%     tempmatFile = FindFiles('tt*.mat','StartingDirectory',startingDir{iDir},'CheckSubdirs',1);
%     matFile = [matFile; tempmatFile];
%% t-file
      temptFile = FindFiles('TT*.t','StartingDirectory',startingDir{iDir},'CheckSubdirs',1);
      tFile = [tFile;temptFile];
%% Event file
%     tempEventFile = FindFiles('Events.nev','StartingDirectory',startingDir{iDir},'CheckSubdirs',1); % Modifying event files
%     matFile = [matFile;tempEventFile];
end

%% Mat file
% nFile = length(matFile);
% for ifile = 1:nFile
%     [cellpath, ~, ~] = fileparts(matFile{ifile});
%     filePath{ifile,1} = cellpath;
% end

%% t-file
nFile = length(tFile);
for ifile = 1:nFile
    [cellpath, ~, ~] = fileparts(tFile{ifile});
    filePath{ifile,1} = cellpath;
end

%% Swiping contents
filePath = unique(filePath);
nPath = length(filePath);

for iPath = 1:nPath
    curPath = iPath;
    cd(filePath{iPath});

%     event2mat_trackori50;
    
%     pethSensor;
%     pethLight50hz;
%     waveform;
%     heatMap;
%     tagstat_trackOri50hz; % newest version
%     mapCorr; % PreStm, PrePost, StmPost
%     mapCorrEvOd; % For Even lap, odd lap of Pre-stm
%     sensorMeanFR;
%     analysis_burst6ms;
%     analysis_wvformCrosscor50hz;
%     analysis_spatialRaster50hz;
%     analysis_CrossCorr1D;
%     analysis_plfm_laserIntTest;
%     laserFreqCheck50hz;
%     laserSpikeProb50hz;
%     analysis_detoSpike50hz;
%     analysis_stmzoneSpike;
%     analysis_laserSpikeChange; % Not sure whether the code is useful or not
%     analysis_findPeakLoci;

    plot_Track_sin_v50hz;

    fclose('all');
    close all;
end

cd(rtPath);
disp('### Done! ###');
clearvars;