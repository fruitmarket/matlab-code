%% Directory setup
rtPath = 'D:\Dropbox\SNL\P2_Track';
% startingDir = {'D:\Projects\Track_160824-2_Rbp58pulse';
%                'D:\Projects\Track_160824-5_Rbp60pulse';
%                'D:\Projects\Track_161130-3_Rbp64pulse';
%                'D:\Projects\Track_161130-5_Rbp66pulse';
%                'D:\Projects\Track_161130-7_Rbp68pulse';
%                'D:\Projects\Track_170119-1_Rbp70pulse';
%                'D:\Projects\Track_170109-2_Rbp72pulse';
%                'D:\Projects\Track_170115-4_Rbp74pulse';
%                'D:\Projects\Track_170305-1_Rbp76pulse';
%                'D:\Projects\Track_170305-2_Rbp78pulse'};
startingDir = {'D:\Projects\Track_170305-1_Rbp76pulse';
                'D:\Projects\Track_170305-2_Rbp78pulse'};
nDir = size(startingDir,1);
[matFile, tFile, cscFile] = deal([]);
typeName = input('Enter file type (e, m, t, c): ', 's');

for iDir = 1:nDir
    switch typeName
        case 'm' %% Mat file
            tempmatFile = FindFiles('tt*.mat','StartingDirectory',startingDir{iDir},'CheckSubdirs',1);
            matFile = [matFile; tempmatFile];
            nFile = length(matFile);
            for ifile = 1:nFile
                [cellPath, ~, ~] = fileparts(matFile{ifile});
                filePath{ifile,1} = cellPath;
            end
        case 't' %% t-file
            temptFile = FindFiles('TT*.t','StartingDirectory',startingDir{iDir},'CheckSubdirs',1);
            tFile = [tFile;temptFile];
            nFile = length(tFile);
            for ifile = 1:nFile
                [cellPath, ~, ~] = fileparts(tFile{ifile});
                filePath{ifile,1} = cellPath;
            end
        case 'e' %% Event file
            tempEventFile = FindFiles('Events.nev','StartingDirectory',startingDir{iDir},'CheckSubdirs',1); % Modifying event files
            matFile = [matFile;tempEventFile];
            nFile = length(matFile);
            for ifile = 1:nFile
                [cellPath, ~, ~] = fileparts(matFile{ifile});
                filePath{ifile,1} = cellPath;
            end
    end
end

filePath = unique(filePath);
nPath = length(filePath);

%% Swiping contents
for iPath = 1:nPath
    cd(filePath{iPath});
    switch typeName
        case 'e'
            event2mat_pulse;
        otherwise
            analysis_laserWidthTest;
            analysis_respstatWidthTest;
            waveform;
%             plot_widthT;
    end
    fclose('all');
    close all;
end
clc;
cd(rtPath);
disp('### Done! ###');