clearvars;
rtPath = 'D:\Dropbox\SNL\P2_Track';
startingDir = {'D:\Projects\Track_170119-1_Rbp70ori50';
               'D:\Projects\Track_170109-2_Rbp72ori50';
               'D:\Projects\Track_170305-1_Rbp76ori50';
               'D:\Projects\Track_170305-2_Rbp78ori50'};

% startingDir = {'D:\Projects\Track_160417-1_Rbp32ori'};
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
    mouseLine = categorical(cellstr(fileSeg{5}));
    taskType = categorical(cellstr(fileSeg{9}));
    taskProb = categorical(cellstr(fileSeg{10}));
    spkwv = {spkwv};
    sensorMeanFR_Run = {sensorMeanFR_Run};
    sensorMeanFR_Rw = {sensorMeanFR_Rw};

    m_spont_wv = {m_spont_wv};
    m_evoked_wv = {m_evoked_wv};
    
    peakFR2D_track = {peakFR2D_track}; % pre/stm/post
    peakFR1D_track = {peakFR1D_track}; % pre/stm/post
    
    xptPlfm2hz = {xptPlfm2hz};
    yptPlfm2hz = {yptPlfm2hz};
    pethtimePlfm2hz = {pethtimePlfm2hz};
    pethPlfm2hz = {pethPlfm2hz};
    pethPlfm2hzConv = {pethPlfm2hzConv};
    pethPlfm2hzConvZ = {pethPlfm2hzConvZ};
    
    rateMap1D_PRE = {rateMap1D_PRE};
    rateMap1D_STM = {rateMap1D_STM};
    rateMap1D_POST = {rateMap1D_POST};
    
    xptPlfm50hz = {xptPlfm50hz};
    yptPlfm50hz = {yptPlfm50hz};
    pethtimePlfm50hz = {pethtimePlfm50hz};
    pethPlfm50hz = {pethPlfm50hz};
    pethPlfm50hzConv = {pethPlfm50hzConv};
    pethPlfm50hzConvZ = {pethPlfm50hzConvZ};
    
    xptTrack50hz = {xptTrackLight};
    yptTrack50hz = {yptTrackLight};
    pethtimeTrack50hz = {pethtimeTrackLight};
    pethTrack50hz = {pethTrackLight};
    pethTrack50hzConv = {pethTrackLightConv};
    pethTrack50hzConvZ = {pethTrackLightConvZ};
    
    m_deto_spkPlfm50hz = {m_deto_spkPlfm50hz};
    m_deto_spkTrack50hz = {m_deto_spkTrack50hz};
    evoSpkTrack50hz = {evoSpkTrack50hz};
    evoSpkPlfm50hz = {evoSpkPlfm50hz};
    
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
    inzoneSpike_half = {inzoneSpike_half};
    outzoneSpike_half = {outzoneSpike_half};
    lapFrInzone = {lapFrInzone};
    lapFrOutzone = {lapFrOutzone};
    p_ttestFR = {p_ttest};
    
% analysis_spatialRaster50hz_pvCorr
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
    rCorrRawMov1D = {rCorrRawMov1D};
    rCorrConvMov1D = {rCorrConvMov1D};
    rCorrRawMov1D_Inzone = {rCorrRawMov1D_Inzone};
    rCorrConvMov1D_Inzone = {rCorrConvMov1D_Inzone};
    rCorrRawMov1D_Outzone = {rCorrRawMov1D_Outzone};
    rCorrConvMov1D_Outzone = {rCorrConvMov1D_Outzone};
    peakloci_total = {peakloci_total};
    peakloci_stm = {peakloci_stm};
    fieldArea_total = {fieldArea_total};
    pethconvSpatial = {pethconvSpatial};
    normTrackFR_total = {normTrackFR_total};
    
    idxNeurontype = categorical({idxNeurontype});
    
    temT = table(path,cellID,taskType,tetLocation,meanFR_base,meanFR_task,meanFR_pre,meanFR_stm,meanFR_post,burstIdx,...    % pethSensor
        lightSpk,lightPreSpk,lightPostSpk,psdPreSpk,psdPostSpk,lightSpkPlfm2hz,lightSpkPlfm2hz_pre,lightSpkPlfm2hz_post,... % pethLight
        spkwv,spkwth,hfvwth,spkpvr,...  % waveform
        peakFR2D_track,peakFR2D_plfm,...    % heatMap
        peakFR1D_track,... % analysis_spatialRaster
        sensorMeanFR_Run,sensorMeanFR_Rw,... % sensorMeanFR
        xptTrackLight, xptPsdPre, xptPsdPost,...
        pLR_Plfm2hz, statDir_Plfm2hz, latencyPlfm2hz1st, latencyPlfm2hz2nd,...
        pLR_Plfm50hz, statDir_Plfm50hz, latencyPlfm50hz1st, latencyPlfm50hz2nd,...
        pLR_Track, statDir_Track, latencyTrack1st, latencyTrack2nd,...  % tagstatTrack_poster
        pLR_Track_pre,pLR_Track_post,...    % tagststTrack_poster
        rCorr1D_preXpre, rCorr1D_preXstm, rCorr1D_preXpost, rCorr1D_stmXpost, fCorr1D_preXpre, fCorr1D_preXstm, fCorr1D_preXpost, fCorr1D_stmXpost,rCorrRaw1D_preXstm, rCorrRaw1D_preXpost, rCorrRaw1D_stmXpost,... % analysis_pvCorr
        rateMapRaw_PRE, rateMapRaw_STIM, rateMapRaw_POST,...
        rateMapRaw10_PRE, rateMapRaw10_STIM, rateMapRaw10_POST, rateMapRaw_eachLap,rCorrRawLap_basePRE,rCorrRawLap_baseSTIM,rCorrRawLap_basePOST,... % analysis_spatialRaster50hz_pvCorr
        rateMapConv10_PRE, rateMapConv10_STIM, rateMapConv10_POST, rateMapConv_eachLap,rCorrConvLap_basePRE,rCorrConvLap_baseSTIM,rCorrConvLap_basePOST,...
        rCorrRawMov1D,rCorrConvMov1D,rCorrRawMov1D_Inzone,rCorrConvMov1D_Inzone,rCorrRawMov1D_Outzone,rCorrConvMov1D_Outzone,...
        lightProbPlfm5mw,lightProbPlfm8mw,lightProbPlfm10mw,... % analysis_plfm_laserIntTest
        evoSpike5mw,evoSpike8mw,evoSpike10mw,...
        lightPlfmSpk2hz8mw, lightPlfmSpk50hz, lightTrackSpk2hz8mw, lightTrackSpk50hz,... % laserFreqCheck
        lightProbTrack_2hz,lightProbTrack_50hz,lightProbPlfm_2hz,lightProbPlfm_50hz,...
        xptPlfm2hz,yptPlfm2hz,pethtimePlfm2hz,pethPlfm2hz,pethPlfm2hzConv,pethPlfm2hzConvZ,...
        xptPlfm50hz,yptPlfm50hz,pethtimePlfm50hz,pethPlfm50hz,pethPlfm50hzConv,pethPlfm50hzConvZ,...
        xptTrack50hz,yptTrack50hz,pethtimeTrack50hz,pethTrack50hz,pethTrack50hzConv,pethTrack50hzConvZ,...
        pethconvSpatial,...
        rateMap1D_PRE,rateMap1D_STM,rateMap1D_POST,...    
        r_wv,m_spont_wv,m_evoked_wv,...
        inzoneSpike,sum_inzoneSpike,m_inzoneSpike,sem_inzoneSpike,timeIn_inzone,totalSpike,sum_totalSpike,outzoneSpike,sum_outzoneSpike,m_outzoneSpike,sem_outzoneSpike,m_lapFrInzone,m_lapFrOutzone,m_lapFrTotalzone,p_ttestFR,inzoneSpike_half,outzoneSpike_half,lapFrInzone,lapFrOutzone,...
        peakloci_total,peakloci_stm,normTrackFR_total,fieldArea_total,... % analysis_findPeakLoci
        m_deto_spkPlfm50hz,m_deto_spkTrack50hz,evoSpkTrack50hz,evoSpkPlfm50hz,... %analysis_detoSpike50hz
        LRatio,ID,...
        idxNeurontype,idxPeakFR,idxPlaceField,idxTotalSpikeNum,idxpLR_Track,idxpLR_Plfm50hz,idxmFrIn,idxmFrOut,idxmFrTotal,idxZoneInOut,overLapLengthSTM,idxOverLapLengthSTM);
    T = [T; temT];
    
    temp_Txls = table(path, cellID, mouseLine, fileSeg(6), taskType, tetLocation,...
        idxNeurontype,idxPeakFR,idxPlaceField,idxTotalSpikeNum,idxpLR_Track,idxZoneInOut);
    Txls = [Txls; temp_Txls];
    fclose('all');
end
cd(rtPath);
formatOut = 'yymmdd';
save(['neuronList_ori50hz_',datestr(now,formatOut),'.mat'],'T');
% writetable(Txls,['neuronList_ori50hz_',datestr(date,formatOut),'.xlsx']);
clearvars;
disp('### neuron list file is generated! ###');