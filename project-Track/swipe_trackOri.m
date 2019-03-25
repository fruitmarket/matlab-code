%% Directory setup
rtPath = 'D:\Dropbox\SNL\P2_Track';
startingDir = {'D:\Projects\Track_151029-5_Rbp8';
               'D:\Projects\Track_160221-1_Rbp16';
               'D:\Projects\Track_160417-1_Rbp32ori';
               'D:\Projects\Track_160417-2_Rbp34ori';
               'D:\Projects\Track_160422-14_Rbp36ori';
               'D:\Projects\Track_160726-1_Rbp48ori';
               'D:\Projects\Track_160726-2_Rbp50ori';
               'D:\Projects\Track_160824-2_Rbp58ori';
               'D:\Projects\Track_160824-5_Rbp60ori';
               'D:\Projects\Track_161130-3_Rbp64ori';
               'D:\Projects\Track_161130-5_Rbp66ori';
               'D:\Projects\Track_161130-7_Rbp68ori';
               'D:\Projects\Track_170119-1_Rbp70ori';
               'D:\Projects\Track_170109-2_Rbp72ori';
               'D:\Projects\Track_170305-1_Rbp76ori';
               'D:\Projects\Track_170305-2_Rbp78ori'};
           % 20170907 modifided
           % 'D:\Projects\Track_151029-4_Rbp6' excluded because of virus expression
           % 'D:\Projects\Track_151213-2_Rbp14' excluded because of optic fiber location
           % 'D:\Projects\Track_161130-5_Rbp66ori' excluded because of almost no expression
           % 'D:\Projects\Track_170115-4_Rbp74ori' excluede because of no expression
nDir = size(startingDir,1);
[matFile, tFile, cscFile] = deal([]);
typeName = input('Enter file type (e, t, c, m): ', 's');

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
        case 'e' || 'c' %% Event file
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
%             analysis_stmzoneSpike;
%             analysis_laserSpikeChange;
%             analysis_LRatioID;
%             analysis_findPeakLoci;
%             analysis_spatialRaster_mapCorr;
%             analysis_baseVsLightTrack8hz;
% #### code not using ####
%             laserFreqCheck;
%             mapCorr; % PreStm, PrePost, StmPost
%             mapCorrEvOd; % For Even lap, odd lap of Pre-stm
        case 'c'
            analysis_cscPETH_8hz;
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