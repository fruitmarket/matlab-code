%% Directory setup
rtPath = 'D:\Dropbox\SNL\P2_Track';
% startingDir = {'D:\Projects\Track_151029-4_Rbp6';
%     'D:\Projects\Track_151029-5_Rbp8';
%     'D:\Projects\Track_151213-2_Rbp14';
%     'D:\Projects\Track_160221-1_Rbp16';
%     'D:\Projects\Track_160417-2_Rbp34ori';
%     'D:\Projects\Track_160422-14_Rbp36ori';
%     'D:\Projects\Track_160726-1_Rbp48ori';
%     'D:\Projects\Track_160726-2_Rbp50ori';
%     'D:\Projects\Track_160824-2_Rbp58ori';
%     'D:\Projects\Track_160824-5_Rbp60ori'};
startingDir = {'D:\Projects\Track_160824-5_Rbp60ori'};

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
for iPath = 2:nPath
    cd(filePath{iPath});
    delete('CSC*.mat');
%     event2mat_trackori;
    spectroTrack;
    powerTrack;
    fclose('all');
end
cd(rtPath);
cd(startingDir{1});
disp('### CSC analysis is completed! ###');
