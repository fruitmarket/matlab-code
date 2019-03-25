%% Directory setup
rtPath = 'D:\Dropbox\SNL\P2_Track';
startingDir = {'E:\Data\Track_rbp013_180406-2\180920_DV2.70_plfmPulseWidth_T8';
               'E:\Data\Track_rbp013_180406-2\180922_DV2.80_plfmPulseWidth_T48';
               'E:\Data\Track_rbp014_180415-10\180916_DV2.65_plfmPulseWidth_T468';
               'E:\Data\Track_rbp015_180423-7\180928_DV1.75_plfmPulseWidth_T78';
               'E:\Data\Track_rbp015_180423-7\181008_DV1.90_plfmPulseWidth_T5';
               'E:\Data\Track_rbp016_180423-13\180920_DV1.60_plfmPulseWidth_T7';
               'E:\Data\Track_rbp016_180423-13\180922_DV1.70_plfmPulseWidth_T14568';
               'E:\Data\Track_rbp016_180423-13\181008_DV1.85_plfmPulseWidth_T58'
               'E:\Data\Track_rbp017_180424-5\180921_DV1.65_plfmPulseWidth_T1678';
               'E:\Data\Track_rbp017_180424-5\180928_DV1.65_plfmPulseWidth_T146'};

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
            event2mat_pulse2;
        case 't'
            analysis_plfm_pulseWidth;
            analysis_plfm_baseVsLight_pulse2;
            analysis_waveform;
        case 'm'
            plot_plfm_pulseWidth_v2;
    end
    fclose('all');
    close all;
end
clc;
cd(rtPath);
disp('### Done! ###');