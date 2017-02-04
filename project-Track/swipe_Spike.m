%% Directory setup
rtPath = 'D:\Dropbox\SNL\P2_Track';
startingDir = {'D:\Projects\Track_151029-4_Rbp6';'D:\Projects\Track_151029-5_Rbp8';'D:\Projects\Track_151213-2_Rbp14';'D:\Projects\Track_160221-1_Rbp16';...
               'D:\Projects\Track_160417-2_Rbp34ori';'D:\Projects\Track_160422-14_Rbp36ori';'D:\Projects\Track_160726-1_Rbp48ori';'D:\Projects\Track_160726-2_Rbp50ori'};

matFile = [];
tFile = [];
nDir = size(startingDir,1);
for iDir = 1:nDir
%% Mat file
    tempmatFile = FindFiles('tt*.mat','StartingDirectory',startingDir{iDir},'CheckSubdirs',1);
    matFile = [matFile; tempmatFile];
%% t-file
%       temptFile = FindFiles('TT*.t','StartingDirectory',startingDir{iDir},'CheckSubdirs',1);
%       tFile = [tFile;temptFile];
%% Event file
%     tempEventFile = FindFiles('Events.nev','StartingDirectory',startingDir{iDir},'CheckSubdirs',1); % Modifying event files
%     matFile = [matFile;tempEventFile];
end

nFile = length(matFile);
for ifile = 1:nFile
    [cellpath, ~, ~] = fileparts(matFile{ifile});
    filePath{ifile,1} = cellpath;
end

% nFile = length(tFile);
% for ifile = 1:nFile
%     [cellpath, ~, ~] = fileparts(tFile{ifile});
%     filePath{ifile,1} = cellpath;
% end

filePath = unique(filePath);
nPath = length(filePath);

%% Swiping contents
for iPath = 1:nPath
    curPath = iPath;
    cd(filePath{iPath});    
    
%     event2mat_trackori;
%     pethSensor;
%     pethLight;
%     waveform;
%     heatMap;
%     tagstatTrack_Poster; % newest version
%     mapCorr; % PreStm, PrePost, StmPost
%     mapCorrEvOd; % For Even lap, odd lap of Pre-stm
%     sensorMeanFR;
%     analysis_burst6ms;
    analysis_wvformCrosscor
%     laserIntPlfm;
%     laserFreqCheck;
%     laserSpikeProb;
%     detoSpike;
%     plot_Track_sin_v3;
    
    fclose('all');
    close all;
end

cd(rtPath);
disp('### Done! ###');