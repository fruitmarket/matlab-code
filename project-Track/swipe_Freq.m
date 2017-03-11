clearvars;
rtPath = 'D:\Dropbox\SNL\P2_Track';
startingDir = {'D:\Projects\Track_160824-2_Rbp58freq';
               'D:\Projects\Track_160824-5_Rbp60freq';
               'D:\Projects\Track_161130-3_Rbp64freq';
               'D:\Projects\Track_161130-5_Rbp66freq'};
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

% nFile = length(matFile);
% for ifile = 1:nFile
%     [cellpath, ~, ~] = fileparts(matFile{ifile});
%     filePath{ifile,1} = cellpath;
% end

nFile = length(tFile);
for ifile = 1:nFile
    [cellpath, ~, ~] = fileparts(tFile{ifile});
    filePath{ifile,1} = cellpath;
end

filePath = unique(filePath);
nPath = length(filePath);

for iPath = 1:nPath
    curPath = iPath;
    cd(filePath{iPath});
    
    event2mat_freq;
    tagstatTrack_freqTest;
    analysis_laserFreqTest;
    
    fclose('all');
    close all;
end
cd(rtPath);
disp('### Done! ###');