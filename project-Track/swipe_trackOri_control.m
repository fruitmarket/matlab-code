%% Directory setup
rtPath = 'D:\Dropbox\SNL\P2_Track';
startingDir = {'D:\Projects\Track_160510-7_Rbp42ori';
               'D:\Projects\Track_160726_1_Rbp56ori';
               'D:\Projects\Track_170509-1_Rbp90_cntr';
               'D:\Projects\Track_170509-7_Rbp92_cntr';
               'D:\Projects\Track_170509-8_Rbp94_cntr'};
%              'D:\Projects\Track_160510-4_Rbp46ori'; light stimulation is less than 30 tirals
%              'D:\Projects\Track_160808-4_Rbp62ori';
% startingDir = {'D:\Projects\Track_160417-1_Rbp32ori'};
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

for iPath = 1:nPath
    cd(filePath{iPath});
    switch typeName
        case 'e'
            event2mat_trackori;
        case 't'
%             pethSensor;
%             pethLight;
%             waveform;
%             heatMap;
%             tagstat_trackOri; % (long-rank test: original)
%             analysis_respstatTrack; % (log-rank test: PRE vs. STIM)
%             analysis_burst6ms;
%             analysis_wvformCrosscor;
%             analysis_spatialRaster;
%             analysis_lightPlaceSeparation; % sensor 6-7/7-8/8-9
%             analysis_plfm_laserIntTest;
%             analysis_track_peth1stLight;
%             analysis_detoSpike8hz;
            analysis_stmzoneSpike;
%             analysis_laserSpikeChange;
%             analysis_LRatioID;
%             analysis_findPeakLoci;
%             analysis_spatialRaster_pvCorr;
% #### code not using ####
%             laserFreqCheck;
%             mapCorr; % PreStm, PrePost, StmPost
%             mapCorrEvOd; % For Even lap, odd lap of Pre-stm
        case 'm'
            analysis_indexTrack;
%             plot_Track_sin_v3;            
    end
    fclose('all');
    close all;
end

cd(rtPath);
clc;
disp('### swipe Done! ###');
clearvars;