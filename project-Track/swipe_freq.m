clearvars;
rtPath = 'D:\Dropbox\SNL\P2_Track';
startingDir = {'D:\Projects\Track_160824-2_Rbp58freq';
               'D:\Projects\Track_160824-5_Rbp60freq';
               'D:\Projects\Track_161130-3_Rbp64freq';
               'D:\Projects\Track_161130-5_Rbp66freq';
               'D:\Projects\Track_161130-7_Rbp68freq';
               'D:\Projects\Track_170119-1_Rbp70freq';
               'D:\Projects\Track_170109-2_Rbp72freq';
               'D:\Projects\Track_170115-4_Rbp74freq'};
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

for iPath = 4:nPath
    curPath = iPath;
    cd(filePath{iPath});
    
%     event2mat_freq;

    analysis_freq_rasterLight;
    analysis_meanFRfreqTest;
    analysis_freq_evokeProb;
    analysis_respstatFreqTest_v2;
    
%     analysis_cscFreqTest;
%     plot_cscLightStm;
    
    fclose('all');
    close all;
end
cd(rtPath);
disp('### Done! ###');
