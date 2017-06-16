clearvars;
rtPath = 'D:\Dropbox\SNL\P2_Track';
startingDir = {'D:\Projects\Track_170305-1_Rbp76_50hz8hz'};
[matFile, tFile, cscFile] = deal([]);
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
%% CSC file
%       tempFile = FindFiles('CSC*.ncs','StartingDirectory',startingDir{iDir},'CheckSubdirs',1);
%       cscFile = [cscFile;tempFile];
end

%% matFile
% nFile = length(matFile);
% for ifile = 1:nFile
%     [cellPath, ~, ~] = fileparts(matFile{ifile});
%     filePath{ifile,1} = cellPath;
% end

%% tFile
nFile = length(tFile);
for ifile = 1:nFile
    [cellPath, ~, ~] = fileparts(tFile{ifile});
    filePath{ifile,1} = cellPath;
end

%% cscFile
% nFile = length(cscFile);
% for ifile = 1:nFile
%     [cellPath, ~, ~] = fileparts(cscFile{ifile});
%     filePath{ifile,1} = cellPath;
% end

%%
filePath = unique(filePath);
nPath = length(filePath);

for iPath = 1:nPath
    curPath = iPath;
    cd(filePath{iPath});
    
%     event2mat_50hz8hz;
%     analysis_pethLight50hz8hz
%     waveform;

%     plot_plfm_50hz8hz
    
    fclose('all');
    close all;
end

cd(rtPath);
disp('### Done! ###');
clearvars;