clearvars;
rtPath = 'E:\Dropbox\SNL\P2_Track';
startingDir = {'E:\Data\Track_rbp001_170905-2\plfmBurst';
               'E:\Data\Track_rbp004_171127-1\plfmBurst';
               'E:\Data\Track_rbp005_171127-3\plfmBurst';
               'E:\Data\Track_rbp006_171127-5\plfmBurst'};

nDir = size(startingDir,1);
[matFile, tFile, cscFile] = deal([]);
typeName = input('Enter file type (e, m, t, c): ', 's');

for iDir = 1:nDir
    switch typeName
        case 'm'  % Mat file
            tempmatFile = FindFiles('tt*.mat','StartingDirectory',startingDir{iDir},'CheckSubdirs',1);
            matFile = [matFile; tempmatFile];
            nFile = length(matFile);
            for ifile = 1:nFile
                [cellPath, ~, ~] = fileparts(matFile{ifile});
                filePath{ifile,1} = cellPath;
            end
        case 't' % t-file
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
        case 'c' %% CSC file
            tempFile = FindFiles('CSC*.ncs','StartingDirectory',startingDir{iDir},'CheckSubdirs',1);
            cscFile = [cscFile;tempFile];
            nFile = length(cscFile);
            for ifile = 1:nFile
                [cellPath, ~, ~] = fileparts(cscFile{ifile});
                filePath{ifile,1} = cellPath;
            end
    end
end

filePath = unique(filePath);
nPath = length(filePath);

for iPath = 1:nPath % 1hz,2hz,8hz,20hz,50hz from
    curPath = iPath;
    cd(filePath{iPath});
    switch typeName
        case 'e'
            event2mat_plfmburst;
        case 't'
            analysis_plfmBurst;
            analysis_LRatioID;
            analysis_waveform;
        case 'm'            
            plot_plfmBurst;
    end
    fclose('all');
    close all;
end

clc;
cd(rtPath);
disp('### swipe_plfmBurst is Done! ###');
clearvars;