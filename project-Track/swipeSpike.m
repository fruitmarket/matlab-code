%% Directory setup
rtPath = 'D:\Dropbox\SNL\P2_Track';
startingDir = {'D:\Projects\Track_151029-4_Rbp6';'D:\Projects\Track_151029-5_Rbp8';'D:\Projects\Track_151213-2_Rbp14';'D:\Projects\Track_160221-1_Rbp16'};

matFile = [];
nDir = size(startingDir,1);
for iDir = 1:nDir
    tempmatFile = FindFiles('tt*.mat','StartingDirectory',startingDir{iDir},'CheckSubdirs',1);
    matFile = [matFile; tempmatFile];    
%     tempEventFile = FindFiles('Events.nev','StartingDirectory',startingDir{iDir},'CheckSubdirs',1); % Modifying event files
%     matFile = [matFile;tempEventFile];
end
nFile = length(matFile);

for ifile = 1:nFile
    [cellpath, ~, ~] = fileparts(matFile{ifile});
    filePath{ifile,1} = cellpath;
end

filePath = unique(filePath);
nPath = length(filePath);

%% Swiping contents
for iPath = 1:nPath
    cd(filePath{iPath});
    
%     event2mat_track;
%     pethSensor;
%     pethLight(0,5);
%     waveform;
%     heatMap;
%     pearson_field_correlation_baseComp_Track;
%     tagstatTrack;
      tagstatTrack_v3;
%     mapCorr;
%     mapCorrEvOd;
%     trackPlot_v3
%     laserIntCheck;
    close all;
end

cd(rtPath);
disp('### Done! ###');