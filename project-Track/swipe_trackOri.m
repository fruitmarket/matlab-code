%% Directory setup
rtPath = 'D:\Dropbox\SNL\P2_Track';
startingDir = {'D:\Projects\Track_151029-4_Rbp6';
               'D:\Projects\Track_151029-5_Rbp8';
               'D:\Projects\Track_151213-2_Rbp14';
               'D:\Projects\Track_160221-1_Rbp16';
               'D:\Projects\Track_160417-1_Rbp32ori';
               'D:\Projects\Track_160417-2_Rbp34ori';
               'D:\Projects\Track_160422-14_Rbp36ori';
               'D:\Projects\Track_160726-1_Rbp48ori';
               'D:\Projects\Track_160726-2_Rbp50ori';
               'D:\Projects\Track_160824-2_Rbp58ori';
               'D:\Projects\Track_160824-5_Rbp60ori';
               'D:\Projects\Track_161130-3_Rbp64ori';
               'D:\Projects\Track_161130-5_Rbp66ori';
               'D:\Projects\Track_161130-7_Rbp68ori';
               'D:\Projects\Track_170119-1_Rbp70ori';
               'D:\Projects\Track_170109-2_Rbp72ori';
               'D:\Projects\Track_170115-4_Rbp74ori'};
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

%     event2mat_trackori;
    
%     pethSensor;
%     pethLight;
%     waveform;
%     heatMap;
%     tagstat_trackOri; % newest version
%     mapCorr; % PreStm, PrePost, StmPost
%     mapCorrEvOd; % For Even lap, odd lap of Pre-stm
%     sensorMeanFR;
%     analysis_burst6ms;
%     analysis_wvformCrosscor;
%     analysis_spatialRaster;
%     analysis_CrossCorr1D;
%     analysis_plfm_laserIntTest;
%     laserFreqCheck;
%     analysis_detoSpike8hz;
%     analysis_stmzoneSpike;
    analysis_laserSpikeChange;
%     analysis_findPeakLoci;
%     plot_Track_sin_v3;

    fclose('all');
    close all;
end

cd(rtPath);
disp('### Done! ###');
clearvars;