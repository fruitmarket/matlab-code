%% Directory setup
rtPath = 'E:\Dropbox\Lab_mwjung\P4_FamiliarNovel';
startingDir = {'E:\Data\Track_rbp003_170905-10\familiar';
               'E:\Data\Track_rbp004_171127-1\familiar';
               'E:\Data\Track_rbp005_171127-3\familiar'; % CA3a 
               'E:\Data\Track_rbp006_171127-5\familiar';
               'E:\Data\Track_rbp013_180423-7\familiar';
               'E:\Data\Track_rbp014_180423-13\familiar';
               'E:\Data\Track_rbp015_180424-5\familiar'};
%                'E:\Data\Track_rbp011_180406-2\familiar';

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
%             event2mat_trackFamiliar;
            analysis_behaviorTrack;
        case 't'
%             analysis_pethSensor_familiar;
%             analysis_pethLight_Track;
%             analysis_pethLight_Plfm;
%             analysis_waveform;
%             analysis_wvformCrosscor50hz;
%             analysis_burst6ms;
%             analysis_LRatioID;
%             analysis_lightstat_familiar; % 
%             analysis_spatial_RasterCorrStat_familiar;
%             analysis_plfm_laserIntTest;
%             analysis_laserSpikeChange_familiar;
%             analysis_findPeakLoci;
            analysis_burstFacilitation_familiar
% code not using
%             analysis_detoSpikeBurst;
%             analysis_spatialRaster_mapCorr;
%             heatMap;
%             laserFreqCheck50hz;
%             analysis_lap1stlight50hz; % overlap with 'analysis_track_peth1stLight50hzBurst'
%             analysis_spatialRaster50hz_pvCorr; % same as analysis_spatialRaster_pvCorr
%             analysis_track_peth1stLight50hzBurst; % same as analysis_spatialRaster50hz
        case 'm'
            analysis_indexTrackBurst;
%             plot_Track_sin_Familiar;
    end
    fclose('all');
    close all;
end

cd(rtPath);
clearvars;
clc;
disp('### swipe Done! ###');