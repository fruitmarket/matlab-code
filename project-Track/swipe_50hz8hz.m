clearvars;
rtPath = 'D:\Dropbox\SNL\P2_Track';
startingDir = {'D:\Projects\Track_170305-1_Rbp76_50hz8hz';...
               'D:\Projects\Track_170305-2_Rbp78_50hz8hz'};
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

for iPath = 1:nPath
    cd(filePath{iPath});
    switch typeName
        case 'e'
            event2mat_50hz8hz;     
        otherwise
            analysis_pethLight50hz8hz;
            waveform;
            plot_plfm_50hz8hz;
    end
    fclose('all');
    close all;
end

cd(rtPath);
disp('### Done! ###');
clearvars;