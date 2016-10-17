%% Directory setup
rtPath = 'D:\Dropbox\SNL\P2_Track';
startingDir = {'D:\Projects\Track_151029-4_Rbp6';'D:\Projects\Track_151029-5_Rbp8';'D:\Projects\Track_151213-2_Rbp14';'D:\Projects\Track_160221-1_Rbp16'};

cscFile = [];
nDir = size(startingDir,1);
for iDir = 1:nDir
    tempmatFile = FindFiles('csc*.ncs','StartingDirectory',startingDir{iDir},'CheckSubdirs',1);
    cscFile = [cscFile; tempmatFile];    
%     tempEventFile = FindFiles('Events.nev','StartingDirectory',startingDir{iDir},'CheckSubdirs',1); % Modifying event files
%     matFile = [matFile;tempEventFile];
end
nFile = length(cscFile);

for ifile = 1:nFile
    [cellpath, ~, ~] = fileparts(cscFile{ifile});
    filePath{ifile,1} = cellpath;
end

filePath = unique(filePath);
nPath = length(filePath);

%% Swiping contents
for iPath = 1:nPath
    cd(filePath{iPath});
    
    spectroTrack;
    
end