clearvars;
rtPath = 'D:\Dropbox\SNL\P2_Track';
startingDir = {'D:\Projects\Track_160824-2_Rbp58freq';
               'D:\Projects\Track_160824-5_Rbp60freq';
               'D:\Projects\Track_161130-3_Rbp64freq';
               'D:\Projects\Track_161130-7_Rbp68freq';
               'D:\Projects\Track_170119-1_Rbp70freq';
               'D:\Projects\Track_170109-2_Rbp72freq';
               'D:\Projects\Track_170305-1_Rbp76freq_8mw';
               'D:\Projects\Track_170305-2_Rbp78freq_8mw'};
               % 'D:\Projects\Track_161130-5_Rbp66freq';
               % 'D:\Projects\Track_170115-4_Rbp74freq';

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
            for ifile = 31:nFile
                [cellPath, ~, ~] = fileparts(tFile{ifile});
                filePath{ifile-30,1} = cellPath;
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
            event2mat_freq;
        case 't'
            analysis_freq_rasterLight; % calculate raster for each frequency
            analysis_freq_pethLight; % calculate based on all lights
            analysis_meanFRfreqTest;
            analysis_freq_evokeProb;
            analysis_respstatFreqTest_v2;
            analysis_freq_detoSpike;
            analysis_baseVsLight;
            waveform;
%             analysis_cscFreqTest;
        case 'm'            
%             plot_cscLightStm;
            plot_freqDependency_single;
    end
    fclose('all');
    close all;
end
clc;
cd(rtPath);
disp('### Done! ###');
clearvars;