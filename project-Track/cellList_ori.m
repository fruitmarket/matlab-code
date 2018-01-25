clearvars;
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
    tetLocation = strsplit(dateSession{4},'_');
    tetLocation = categorical(cellstr(tetLocation{2}));
    fileSeg = strsplit(matFile{iFile},{'\','_'});
    cellID = iFile;
%     mouseLine = categorical(cellstr(fileSeg{5}));
    taskType = categorical(cellstr(fileSeg{9}));
    taskProb = categorical(cellstr(fileSeg{10}));
    spkwv = {spkwv};
    sensorMeanFR_Run = {sensorMeanFR_Run};
    sensorMeanFR_Rw = {sensorMeanFR_Rw};

    m_spont_wv = {m_spont_wv};
    m_evoked_wv = {m_evoked_wv};
    
    peakFR2D_track = {peakFR2D_track}; % pre/stm/post
    peakFR1D_track = {peakFR1D_track}; % pre/stm/post
    
    pethtimePlfm2hz = {pethtimePlfm2hz};
    pethPlfm2hz = {pethPlfm2hz};
    pethPlfm2hzConv = {pethPlfm2hzConv};
    pethPlfm2hzConvZ = {pethPlfm2hzConvZ};
    
    xptPlfm8hz = {xptPlfm8hz};
    yptPlfm8hz = {yptPlfm8hz};
    pethtimePlfm8hz = {pethtimePlfm8hz};
    pethPlfm8hz = {pethPlfm8hz};
    pethPlfm8hzConv = {pethPlfm8hzConv};
    pethPlfm8hzConvZ = {pethPlfm8hzConvZ};
    
    pethtimeTrack8hz = {pethtimeTrackLight};
    pethTrack8hz = {pethTrackLight};
    pethTrack8hzConv = {pethTrackLightConv};
    pethTrack8hzConvZ = {pethTrackLightConvZ};
    
    rateMap1D_PRE = {rateMap1D_PRE};
    rateMap1D_STM = {rateMap1D_STM};
    rateMap1D_POST = {rateMap1D_POST};
    
    pethtimePsdPre = {pethtimePsdPre};
    pethPsdPre = {pethPsdPre};
    
    pethtimePsdStm = {pethtimePsdStm};
    pethPsdStm = {pethPsdStm};
    
    pethtimePsdPost = {pethtimePsdPost};
    pethPsdPost = {pethPsdPost};
    
    spikeTime_psdPreD = {spikeTime_psdPreD};
    yptPsdPreD = {yptPsdPreD};
    pethtimePsdPreD = {pethtimePsdPreD};
    pethPsdPreD = {pethPsdPreD};
    spikePsdPreD = {spikePsdPreD};
    
    spikeTime_psdStmD = {spikeTime_psdStmD};
%     yptPsdStmD = {yptPsdStmD};
    pethtimePsdStmD = {pethtimePsdStmD};
    pethPsdStmD = {pethPsdStmD};
    spikePsdStmD = {spikePsdStmD};
    
    xptPsdPre67 = {xptPsdPre67};
    yptPsdPre67 = {yptPsdPre67};
    pethtimePsdPre67 = {pethtimePsdPre67};
    pethPsdPre67 = {pethPsdPre67};
    pethPsdPre67Conv = {pethPsdPre67Conv};
    pethPsdPre67ConvZ = {pethPsdPre67ConvZ};
    xptPsdPre78 = {xptPsdPre78};
    yptPsdPre78 = {yptPsdPre78};
    pethtimePsdPre78 = {pethtimePsdPre78};
    pethPsdPre78 = {pethPsdPre78};
    pethPsdPre78Conv = {pethPsdPre78Conv};
    pethPsdPre78ConvZ = {pethPsdPre78ConvZ};
    xptPsdPre89 = {xptPsdPre89};
    yptPsdPre89 = {yptPsdPre89};
    pethtimePsdPre89 = {pethtimePsdPre89};
    pethPsdPre89 = {pethPsdPre89};
    pethPsdPre89Conv = {pethPsdPre89Conv};
    pethPsdPre89ConvZ = {pethPsdPre89ConvZ};
    
    xptLight67 = {xptLight67};
    yptLight67 = {yptLight67};
    pethtimeLight67 = {pethtimeLight67};
    pethLight67 = {pethLight67};
    pethLight67Conv = {pethLight67Conv};
    pethLight67ConvZ = {pethLight67ConvZ};
    pethtimeLight78 = {pethtimeLight78};
    xptLight78 = {xptLight78};
    yptLight78 = {yptLight78};
    pethLight78 = {pethLight78};
    pethLight78Conv = {pethLight78Conv};
    pethLight78ConvZ = {pethLight78ConvZ};
    pethtimeLight89 = {pethtimeLight89};
    xptLight89 = {xptLight89};
    yptLight89 = {yptLight89};
    pethLight89 = {pethLight89};
    pethLight89Conv = {pethLight89Conv};
    pethLight89ConvZ = {pethLight89ConvZ};
    
    xptPsdPost67 = {xptPsdPost67};
    yptPsdPost67 = {yptPsdPost67};
    pethtimePsdPost67 = {pethtimePsdPost67};
    pethPsdPost67 = {pethPsdPost67};
    pethPsdPost67Conv = {pethPsdPost67Conv};
    pethPsdPost67ConvZ = {pethPsdPost67ConvZ};
    pethtimePsdPost78 = {pethtimePsdPost78};
    xptPsdPost78 = {xptPsdPost78};
    yptPsdPost78 = {yptPsdPost78};
    pethPsdPost78 = {pethPsdPost78};
    pethPsdPost78Conv = {pethPsdPost78Conv};
    pethPsdPost78ConvZ = {pethPsdPost78ConvZ};
    xptPsdPost89 = {xptPsdPost89};
    yptPsdPost89 = {yptPsdPost89};
    pethtimePsdPost89 = {pethtimePsdPost89};
    pethPsdPost89 = {pethPsdPost89};
    pethPsdPost89Conv = {pethPsdPost89Conv};
    pethPsdPost89ConvZ = {pethPsdPost89ConvZ};
    
    spikeTime_psdPostD = {spikeTime_psdPostD};
    yptPsdPostD = {yptPsdPostD};
    pethtimePsdPostD = {pethtimePsdPostD};
    pethPsdPostD = {pethPsdPostD};
    spikePsdPostD = {spikePsdPostD};
    
    m_deto_spkPlfm8hz = {m_deto_spkPlfm8hz};
    m_deto_spkTrack8hz = {m_deto_spkTrack8hz};
    evoSpkTrack8hz = {evoSpkTrack8hz};
    evoSpkPlfm8hz = {evoSpkPlfm8hz};
    
% analysis_spatialRaster50hz_pvCorr
    rateMap1D_PRE1 = {rateMap1D_PRE1};
    rateMap1D_PRE2 = {rateMap1D_PRE2};
    rateMap1D_POST1 = {rateMap1D_POST1};
    rateMap1D_POST2 = {rateMap1D_POST2};
    rateMapRaw_PRE = {rateMapRaw_PRE};
    rateMapRaw_STIM = {rateMapRaw_STIM};
    rateMapRaw_POST = {rateMapRaw_POST};
    rateMapRaw10_PRE = {rateMapRaw10_PRE};
    rateMapRaw10_STIM = {rateMapRaw10_STIM};
    rateMapRaw10_POST = {rateMapRaw10_POST};
    rateMapRaw_eachLap = {rateMapRaw_eachLap};
    rCorrRawLap_basePRE = {rCorrRawLap_basePRE};
    rCorrRawLap_baseSTIM = {rCorrRawLap_baseSTIM};
    rCorrRawLap_basePOST = {rCorrRawLap_basePOST};
    
    rateMapConv10_PRE = {rateMapConv10_PRE};
    rateMapConv10_STIM = {rateMapConv10_STIM};
    rateMapConv10_POST = {rateMapConv10_POST};
    rateMapConv_eachLap = {rateMapConv_eachLap};
    rCorrConvLap_basePRE = {rCorrConvLap_basePRE};
    rCorrConvLap_baseSTIM = {rCorrConvLap_baseSTIM};
    rCorrConvLap_basePOST = {rCorrConvLap_basePOST};
    
    inzoneSpike = {inzoneSpike};
    sum_inzoneSpike = {sum_inzoneSpike};
    m_inzoneSpike = {m_inzoneSpike};
    sem_inzoneSpike = {sem_inzoneSpike};
    timeIn_inzone = {timeIn_inzone};
    totalSpike = {totalSpike};
    sum_totalSpike = {sum_totalSpike};
    outzoneSpike = {outzoneSpike};
    sum_outzoneSpike = {sum_outzoneSpike};
    m_outzoneSpike = {m_outzoneSpike};
    sem_outzoneSpike = {sem_outzoneSpike};
    m_lapFrInzone = {m_lapFrInzone};
    m_lapFrOutzone = {m_lapFrOutzone};
    m_lapFrTotalzone = {m_lapFrTotalzone};
    p_ttestFR = {p_ttest};
    
    peakloci_total = {peakloci_total};
    pethconvSpatial = {pethconvSpatial};
    normTrackFR_total = {normTrackFR_total};
    
    idxNeurontype = categorical({idxNeurontype});
    idxOverLap = categorical({idxOverLap});

    temT = table(path,cellID,taskType,tetLocation,meanFR_base,meanFR_task,meanFR_pre,meanFR_stm,meanFR_post,burstIdx,...    % event2mat, pethSensor (droped preTime, stmTime, postTime)
        lightSpk,lightPreSpk,lightPostSpk,psdPreSpk,psdPostSpk,lightSpkPlfm2hz,lightSpkPlfm2hz_pre,lightSpkPlfm2hz_post,... % pethLight
        spkwv,spkwth,hfvwth,spkpvr,...  % waveform
        peakFR2D_track,peakFR2D_plfm,...    % heatMap
        peakFR1D_track,... % analysis_spatialRaster
        sensorMeanFR_Run,sensorMeanFR_Rw,... % sensorMeanFR
        pLR_Plfm2hz, statDir_Plfm2hz, latencyPlfm2hz1st, latencyPlfm2hz2nd,...
        pLR_Plfm8hz, statDir_Plfm8hz, latencyPlfm8hz1st, latencyPlfm8hz2nd,...
        pLR_Track, statDir_Track, latencyTrack1st, latencyTrack2nd,...
        pLR_TrackN,statDir_TrackN, latencyTrack1stN, latencyTrack2ndN,... % analysis_respstatTrack
        pLR_Track_pre,pLR_Track_post,...    % tagststTrack_poster
        rCorr1D_preXpre, rCorr1D_preXstm, rCorr1D_preXpost, rCorr1D_stmXpost, fCorr1D_preXpre, fCorr1D_preXstm, fCorr1D_preXpost, fCorr1D_stmXpost, rCorrRaw1D_preXstm, rCorrRaw1D_preXpost, rCorrRaw1D_stmXpost,... % analysis_pvCorr
        rateMap1D_PRE1,rateMap1D_PRE2,rateMap1D_POST1,rateMap1D_POST2,...
        rateMapRaw_PRE,rateMapRaw_STIM,rateMapRaw_POST,...
        rateMapRaw10_PRE, rateMapRaw10_STIM, rateMapRaw10_POST, rateMapRaw_eachLap,rCorrRawLap_basePRE,rCorrRawLap_baseSTIM,rCorrRawLap_basePOST,rCorrMoving1D_total,... % analysis_spatialRaster50hz_pvCorr
        rateMapConv10_PRE, rateMapConv10_STIM, rateMapConv10_POST, rateMapConv_eachLap,rCorrConvLap_basePRE,rCorrConvLap_baseSTIM,rCorrConvLap_basePOST,...
        lightProbPlfm5mw,lightProbPlfm8mw,lightProbPlfm10mw,... % analysis_plfm_laserIntTest
        evoSpike5mw,evoSpike8mw,evoSpike10mw,...
        lightPlfmSpk2hz8mw, lightPlfmSpk8hz, lightTrackSpk2hz8mw, lightTrackSpk8hz,... % laserFreqCheck
        lightProbTrack_2hz,lightProbTrack_8hz,lightProbPlfm_2hz,lightProbPlfm_8hz,...
        infoSpikePRE,infoSpikeSTM,infoSpikePOST,infoSpikeTotal,...
        infoSecondPRE,infoSecondSTM,infoSecondPOST,infoSecondTotal,...
        xptPlfm2hz,yptPlfm2hz,pethtimePlfm2hz,pethPlfm2hz,pethPlfm2hzConv,pethPlfm2hzConvZ,...
        xptPlfm8hz,yptPlfm8hz,pethtimePlfm8hz,pethPlfm8hz,pethPlfm8hzConv,pethPlfm8hzConvZ,...
        xptTrackLight,yptTrackLight,pethtimeTrackLight,pethTrackLight,pethTrackLightConv,pethTrackLightConvZ,...
        xptPsdPre, yptPsdPre, pethtimePsdPre, pethPsdPre,...
        xptPsdStm, yptPsdStm, pethtimePsdStm, pethPsdStm,...    
        xptPsdPost,yptPsdPost,pethtimePsdPost,pethPsdPost,...
        spikeTime_psdPreD, spikeTime_psdStmD, spikeTime_psdPostD,...
        xptPsdPreD,yptPsdPreD,pethtimePsdPreD,pethPsdPreD,xptPsdStmD,yptPsdStmD,pethtimePsdStmD,pethPsdStmD,xptPsdPostD,yptPsdPostD,pethtimePsdPostD,pethPsdPostD,...
        xptPsdPre67, yptPsdPre67, pethtimePsdPre67, pethPsdPre67, pethPsdPre67Conv, pethPsdPre67ConvZ, xptPsdPre78, yptPsdPre78, pethtimePsdPre78, pethPsdPre78, pethPsdPre78Conv, pethPsdPre78ConvZ, xptPsdPre89, yptPsdPre89, pethtimePsdPre89, pethPsdPre89, pethPsdPre89Conv, pethPsdPre89ConvZ,...
        xptLight67, yptLight67, pethtimeLight67, pethLight67, pethLight67Conv, pethLight67ConvZ, xptLight78, yptLight78, pethtimeLight78, pethLight78, pethLight78Conv, pethLight78ConvZ, xptLight89, yptLight89, pethtimeLight89, pethLight89, pethLight89Conv, pethLight89ConvZ,...
        xptPsdPost67, yptPsdPost67, pethtimePsdPost67, pethPsdPost67, pethPsdPost67Conv, pethPsdPost67ConvZ, xptPsdPost78, yptPsdPost78, pethtimePsdPost78, pethPsdPost78, pethPsdPost78Conv, pethPsdPost78ConvZ, xptPsdPost89, yptPsdPost89, pethtimePsdPost89, pethPsdPost89, pethPsdPost89Conv, pethPsdPost89ConvZ,...
        pethconvSpatial,...
        rateMap1D_PRE,rateMap1D_STM,rateMap1D_POST,...
        spikePsdPreD,spikePsdStmD,spikePsdPostD,...
        r_wv,m_spont_wv,m_evoked_wv,...
        inzoneSpike,sum_inzoneSpike,m_inzoneSpike,sem_inzoneSpike,timeIn_inzone,totalSpike,sum_totalSpike,outzoneSpike,sum_outzoneSpike,m_outzoneSpike,sem_outzoneSpike,m_lapFrInzone,m_lapFrOutzone,m_lapFrTotalzone,p_ttestFR,...
        peakloci_total,normTrackFR_total,... % analysis_findPeakLoci
        m_deto_spkPlfm8hz,m_deto_spkTrack8hz,evoSpkTrack8hz,evoSpkPlfm8hz,...%analysis_detoSpike8hz
        evoSpike_preEarly, evoSpike_preLate, evoSpike_stmEarly, evoSpike_stmLate, evoSpike_postEarly, evoSpike_postLate,...
        evoXptTrackLight,evoXptPsdPre,evoXptPsdPost,...
        idx_evoSpikeDir,...
        LRatio,ID,...
        idxNeurontype,idxPeakFR,idxPlaceField,idxTotalSpikeNum,idxpLR_Track,idxpLR_Plfm8hz,idxmFrIn,idxmFrOut,idxmFrTotal,idxZoneInOut,idxZoneInOutPRE,overLapLength);
    T = [T; temT];
    
    temp_Txls = table(path,cellID,taskType,tetLocation,...
        pLR_Plfm2hz, statDir_Plfm2hz, latencyPlfm2hz1st, latencyPlfm2hz2nd,...
        pLR_Plfm8hz, statDir_Plfm8hz, latencyPlfm8hz1st, latencyPlfm8hz2nd,...
        pLR_Track, statDir_Track, latencyTrack1st, latencyTrack2nd,...
        pLR_TrackN,statDir_TrackN, latencyTrack1stN, latencyTrack2ndN,...
        idxNeurontype,idxPeakFR,idxPlaceField,idxTotalSpikeNum,idxpLR_Track,idxZoneInOut);
    Txls = [Txls; temp_Txls];
    
    fclose('all');
end
cd(rtPath);
formatOut = 'yymmdd';
save(['neuronList_ori_',datestr(now,formatOut),'.mat'],'T');
% writetable(Txls,['neuronList_ori_',datestr(now,formatOut),'.xlsx']);