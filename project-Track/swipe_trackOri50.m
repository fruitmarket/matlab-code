%% Directory setup
rtPath = 'D:\Dropbox\SNL\P2_Track';
startingDir = {'D:\Projects\Track_170119-1_Rbp70ori50';
               'D:\Projects\Track_170109-2_Rbp72ori50';
               'D:\Projects\Track_170305-1_Rbp76ori50';
               'D:\Projects\Track_170305-2_Rbp78ori50'};

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
            event2mat_trackori50;
        case 't'
%             pethSensor;
%             pethLight50hz;
%             waveform;
%             heatMap;
%             tagstat_trackOri50hz; % newest version
%             mapCorr; % PreStm, PrePost, StmPost
%             mapCorrEvOd; % For Even lap, odd lap of Pre-stm
%             sensorMeanFR;
%             analysis_burst6ms;
%             analysis_wvformCrosscor50hz;
            analysis_spatialRaster50hz;
%             analysis_plfm_laserIntTest;
%             laserFreqCheck50hz;
%             analysis_detoSpike50hz;
%             analysis_stmzoneSpike;
%             analysis_laserSpikeChange50hz;
%             analysis_track_peth1stLight50hz;
%             analysis_LRatioID;
%             analysis_findPeakLoci;
%             analysis_lap1stlight50hz;
%             analysis_spatialRaster50hz_pvCorr;
        case 'm'
            analysis_indexTrack50hz
%             plot_Track_sin_v50hz;
            plot_Track_sin_v50hz_lightraster;
    end
    fclose('all');
    close all;
end

cd(rtPath);
clearvars;
clc;
disp('### swipe Done! ###');