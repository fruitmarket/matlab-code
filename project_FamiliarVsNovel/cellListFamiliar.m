clearvars;
rtPath = 'E:\Dropbox\Lab_mwjung\P4_FamiliarNovel';
startingDir = {'E:\Data\Track_rbp003_170905-10\familiar';
               'E:\Data\Track_rbp004_171127-1\familiar';
               'E:\Data\Track_rbp005_171127-3\familiar'; % CA3a 
               'E:\Data\Track_rbp006_171127-5\familiar';
               'E:\Data\Track_rbp013_180423-7\familiar';
               'E:\Data\Track_rbp014_180423-13\familiar';
               'E:\Data\Track_rbp015_180424-5\familiar'};
%                'E:\Data\Track_rbp011_180406-2\familiar';
matFile = [];
nDir = size(startingDir,1);
for iDir = 1:nDir
    tempmatFile = FindFiles('tt*.mat','StartingDirectory',startingDir{iDir},'CheckSubdirs',1);
    matFile = [matFile; tempmatFile];    
end
nFile = length(matFile);

[T, Txls] = deal(table());
for iFile = 1:nFile
    load(matFile{iFile});

    path = matFile(iFile);
    dateSession = strsplit(matFile{iFile},{'\'});
    tetLocation = strsplit(dateSession{5},'_');
    tetLocation = categorical(cellstr(tetLocation{2}));
    fileSeg = strsplit(matFile{iFile},{'\','_'});
    cellID = iFile;
    mouseID = categorical(cellstr(fileSeg{4}));
    taskType = categorical(cellstr(fileSeg{9}));
    neuronType = categorical(cellstr({neuronType}));
    tetrode = categorical(cellstr(fileSeg{11}));

    spkwv = {spkwv};
    
    
% pethSensor_novel
% meanFR_PlfmPre, meanFR_PlfmPost, meanFR_BasePre, meanFR_BasePost, meanFR_Pre, meanFR_Stim, meanFR_Post, meanFR_Task
% sensorMeanFR_Run, burstIdx

% analysis_pethLight_Track
% xptTrackLight, yptTrackLight, pethtimeTrackLight, pethTrackLight, lightSpk
% xptPsdPre, yptPsdPre, pethtimePsdPre, pethPsdPre,
% xptPsdPost, yptPsdPost, pethtimePsdPost, pethPsdPost
% xpt1stBStm, ypt1stBStm, pethtime1stBStm, peth1stBStm
% xpt1stBPre, ypt1stBPre, pethtime1stBPre, peth1stPBPre
% xpt1stBPost, ypt1stBPost, pethtime1stBPost, peth1stBPost
% xpt1stLStm, ypt1stLStm, pethtime1stLStm, peth1stLStm
% xpt1stLPre, ypt1stLPre, pethtime1stLPre, peth1stLPre
% xpt1stLPost, ypt1stLPost, pethtime1stLPost, peth1stLPost
% lightProbTrack

% analysis_waveform
% spkwv, spkwth, spkpvr, hfvwth

% analysis_wvformCrosscor50hz
% r_wv, m_spont_wv, m_evoked_wv

% analysis_burst6ms
% burstIdx_6ms

% analysis_LRatioID
% LRatio, ID

% analysis_lightstat_novel
% pLR_Track, calibTrack, statDir_Track, latencyTrack1st, latencyTrack2nd, pLR_Track_pre, pLR_Track_post

% analysis_spatial_raster_mapCorr_info
% xptSpatial, yptSpatial, pethSpatial, pethRawSpatial, peakFR1D_track
% rCorrRawMov1D, rCorrConvMovMov1D, rCorrRawMov1D_inzone, rCorrConvMov1D_Inzone, rCorrRawMov1D_Outzone, rCorrConvMov1D_Outzone
% infoSpike, infoSecond

% analysis_stmzoneSpike_novel
% sum_totalSpike, inzoneSpike, sum_inzoneSpike, m_inzoneSpike, sem_inzoneSpike, outzoneSpike, sum_outzoneSpike, m_outzoneSpike,
% sem_outzoneSpike, totalSpike, sum_totalSpike, lapFrInzone, lapFrOutzone, lapFrTotal, m_lapFrInzone, m_lapFrOutzone, m_lapFrTotalzone, p_ttestFr,
% inzoneSpike_half, outzoneSpike_half

% analysis_findPeakLoci_novel
% peakloci_total, peakloci_basePre, peakloci_pre, peakloci_stm, peakloci_post, peakloci_basePost

    sensorMeanFR_Run = {sensorMeanFR_Run};
    sensorMeanFR_Rw = {sensorMeanFR_Rw};

    m_spont_wv = {m_spont_wv};
    m_evoked_wv = {m_evoked_wv};
    
    peakFR1D_track = {peakFR1D_track}; % pre/stm/post
    
    rateMap1D_PRE = {rateMap1D_PRE};
    rateMap1D_STM = {rateMap1D_STM};
    rateMap1D_POST = {rateMap1D_POST};
         
    inzoneSpike = {inzoneSpike};
    sum_inzoneSpike = {sum_inzoneSpike};
    m_inzoneSpike = {m_inzoneSpike};
    sem_inzoneSpike = {sem_inzoneSpike};
    outzoneSpike = {outzoneSpike};
    sum_outzoneSpike = {sum_outzoneSpike};
    m_outzoneSpike = {m_outzoneSpike};
    sem_outzoneSpike = {sem_outzoneSpike};
    totalSpike = {totalSpike};
    sum_totalSpike = {sum_totalSpike};
    m_totalSpike = {m_totalSpike};
    sem_totalSpike = {sem_totalSpike};
    
    m_lapFrInzone = {m_lapFrInzone};
    m_lapFrOutzone = {m_lapFrOutzone};
    m_lapFrTotalzone = {m_lapFrTotalzone};
    inzoneSpike_half = {inzoneSpike_half};
    outzoneSpike_half = {outzoneSpike_half};
    lapFrInzone = {lapFrInzone};
    lapFrOutzone = {lapFrOutzone};
    p_ttestFr = {p_ttestFr};
    
% analysis_pethLight_Track
    xpt1stBStm = {xpt1stBStm};
    ypt1stBStm = {ypt1stBStm};
    pethtime1stBPre = {pethtime1stBPre};
    pethtime1stBStm = {pethtime1stBStm};
    pethtime1stBPost = {pethtime1stBPost};
    peth1stBPre = {peth1stBPre};
    peth1stBStm = {peth1stBStm};
    peth1stBPost = {peth1stBPost};

% analysis_pethLight_Plfm
    xptPlfm1stBStm = {xptPlfm1stBStm};
    yptPlfm1stBStm = {yptPlfm1stBStm};
    pethtimePlfm1stBStm = {pethtimePlfm1stBStm};
    peth1stPlfmBStm = {peth1stPlfmBStm};
    
% analysis_spatialRaster50hz_pvCorr
    xptSpatial = {xptSpatial};
    rCorrConvMov1D = {rCorrConvMov1D};
    peakloci_Total = {peakloci_total};
    peakloci_PRE = {peakloci_pre};
    peakloci_STIM = {peakloci_stm};
    peakloci_POST = {peakloci_post};
    fieldArea_total = {fieldArea_total};
    pethconvSpatial = {pethconvSpatial};
    
    idxOverLap = {idxOverLap};
    idxZoneInOut = {idxZoneInOut};
    
    temT = table(path, cellID, mouseID, tetLocation, tetrode, neuronType, meanFR_PlfmPre, meanFR_PlfmPost, meanFR_Pre, meanFR_Stim, meanFR_Post, meanFR_Task, sensorMeanFR_Run, burstIdx,...    % pethSensor
        xptTrackLight, yptTrackLight, lightSpk, lightProbTrack, xptPsdPre, xptPsdPost,... % analysis_pethLight_Track
        spkwv,spkwth,hfvwth,spkpvr,...  % waveform
        r_wv, m_spont_wv, m_evoked_wv,... % analysis_wvformCrosscor50hz
        LRatio, ID,... % analysis_LRatioID
        pLR_Track, calibTrack, statDir_Track, latencyTrack1st, latencyTrack2nd, pLR_Track_pre, pLR_Track_post,... % analysis_lightstat_novel        
        xptSpatial, pethconvSpatial, peakFR1D_track,... % analysis_spatial_raster_mapCorr_info
        rCorrConvMov1D,... % analysis_spatialRaster50hz_pvCorr
        rateMap1D_PRE,rateMap1D_STM,rateMap1D_POST,...
        inzoneSpike,sum_inzoneSpike, m_inzoneSpike, sem_inzoneSpike, totalSpike, sum_totalSpike, m_totalSpike, sem_totalSpike, outzoneSpike, sum_outzoneSpike, m_outzoneSpike, sem_outzoneSpike,m_lapFrInzone,m_lapFrOutzone,m_lapFrTotalzone,p_ttestFr,inzoneSpike_half,outzoneSpike_half,lapFrInzone,lapFrOutzone,... % analysis_stmzoneSpike_novel
        xpt1stBStm, ypt1stBStm, pethtime1stBPre, pethtime1stBStm, pethtime1stBPost, peth1stBPre, peth1stBStm, peth1stBPost,...
        xptPlfm1stBStm, yptPlfm1stBStm, pethtimePlfm1stBStm, peth1stPlfmBStm,...    
        peakloci_Total, peakloci_PRE, peakloci_STIM, peakloci_POST, fieldArea_total,... % analysis_findPeakLoci_novel
        idxPeakFR, idxPlaceField, idxOverLap, overLapLength, idxTotalSpikeNum, idxZoneInOut, idxpLR_Track, idxmFrIn, idxmFrOut, idxmFrTotal, idxmSpkIn, idxmSpkOut, idxmSpkTotal);
    T = [T; temT];
    
    temp_Txls = table(path, cellID, mouseID, fileSeg(6), taskType, tetLocation,...
        neuronType,idxPeakFR,idxPlaceField,idxTotalSpikeNum,idxpLR_Track,idxZoneInOut);
    Txls = [Txls; temp_Txls];
    fclose('all');
end
cd(rtPath);
formatOut = 'yymmdd';
save(['neuronList_familiar_',datestr(now,formatOut),'.mat'],'T');
% writetable(Txls,['neuronList_novel_',datestr(date,formatOut),'.xlsx']);
clearvars;
disp('### neuron list file is generated! ###');