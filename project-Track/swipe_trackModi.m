%% Directory setup
rtPath = 'D:\Dropbox\SNL\P2_Track';
startingDir = {'D:\Projects\Track_160417-2_Rbp34';'D:\Projects\Track_160422-14_Rbp36'};

fFile = [];
nDir = size(startingDir,1);
for iDir = 1:nDir
    tempfFile = FindFiles('tt*.t','StartingDirectory',startingDir{iDir},'CheckSubdirs',1);
    fFile = [fFile; tempfFile];    
%     tempEventFile = FindFiles('Events.nev','StartingDirectory',startingDir{iDir},'CheckSubdirs',1); % Modifying event files
%     matFile = [matFile;tempEventFile];
end
nFile = length(fFile);

for ifile = 1:nFile
    [cellpath, ~, ~] = fileparts(fFile{ifile});
    filePath{ifile,1} = cellpath;
end

filePath = unique(filePath);
nPath = length(filePath);

%% Swiping contents
for iPath = 1:nPath
    cd(filePath{iPath});
    
%     event2mat_track_v2;
%     pethSensor;
%     pethLight;
%     waveform;
%     heatMap;
%     pearson_field_correlation_baseComp_Track;
%     tagstatTrack;
%     tagstatTrack_v3_movWin;
%     mapCorr;
%     mapCorrEvOd;
%     trackPlot_v3
%     laserIntCheck;
    laserFreqCheck;
    close all;
end

cd(rtPath);
disp('### Done! ###');
