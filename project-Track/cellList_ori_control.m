clearvars;
rtPath = 'D:\Dropbox\SNL\P2_Track';
startingDir = {'D:\Projects\Track_160510-7_Rbp42ori';
               'D:\Projects\Track_160510-4_Rbp46ori';
               'D:\Projects\Track_160726_1_Rbp56ori'};

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
%     mouseLine = categorical(cellstr(fileSeg{5}));
    taskType = categorical(cellstr(fileSeg{9}));
    taskProb = categorical(cellstr(fileSeg{10}));
    spkwv = {spkwv};
    sensorMeanFR_DRun = {sensorMeanFR_DRun};
    sensorMeanFR_DRw = {sensorMeanFR_DRw};

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
    
    xptPlfm8hz = {xptPlfm8hz};
    yptPlfm8hz = {yptPlfm8hz};
    pethtimePlfm8hz = {pethtimePlfm8hz};
    pethPlfm8hz = {pethPlfm8hz};
    pethPlfm8hzConv = {pethPlfm8hzConv};
    pethPlfm8hzConvZ = {pethPlfm8hzConvZ};
    
    xptTrack8hz = xptTrackLight;
    yptTrack8hz = {yptTrackLight};
    pethtimeTrack8hz = {pethtimeTrackLight};
    pethTrack8hz = {pethTrackLight};
    pethTrack8hzConv = {pethTrackLightConv};
    pethTrack8hzConvZ = {pethTrackLightConvZ};
    
    yptPsdPre = {yptPsdPre};
    pethtimePsdPre = {pethtimePsdPre};
    pethPsdPre = {pethPsdPre};
    
    yptPsdPost = {yptPsdPost};
    pethtimePsdPost = {pethtimePsdPost};
    pethPsdPost = {pethPsdPost};
    
    yptPsdPreD = {yptPsdPreD};
    pethtimePsdPreD = {pethtimePsdPreD};
    pethPsdPreD = {pethPsdPreD};
    spikePsdPreD = {spikePsdPreD};
    
    yptPsdStmD = {yptPsdStmD};
    pethtimePsdStmD = {pethtimePsdStmD};
    pethPsdStmD = {pethPsdStmD};
    spikePsdStmD = {spikePsdStmD};
    
    yptPsdPostD = {yptPsdPostD};
    pethtimePsdPostD = {pethtimePsdPostD};
    pethPsdPostD = {pethPsdPostD};
    spikePsdPostD = {spikePsdPostD};
    
    m_deto_spkPlfm8hz = {m_deto_spkPlfm8hz};
    m_deto_spkTrack8hz = {m_deto_spkTrack8hz};
    evoSpkTrack8hz = {evoSpkTrack8hz};
    evoSpkPlfm8hz = {evoSpkPlfm8hz};
    
    inzoneSpike = {inzoneSpike};
    inzoneSpikeNum = {inzoneSpikeNum};
    m_stmzoneSpike = {m_stmzoneSpike};
    std_stmzoneSpike = {std_stmzoneSpike};
    timeIn_stmZone = {timeIn_stmZone};
    totalSpike = {totalSpike};
    totalSpikeNum = {totalSpikeNum};
    outzoneSpike = {outzoneSpike};
    outzoneSpikeNum = {outzoneSpikeNum};
    p_ttest = {p_ttest};
    
    peakloci_total = {peakloci_total};
    pethconvSpatial = {pethconvSpatial};
    normTrackFR_total = {normTrackFR_total};
    
    idxNeurontype = categorical({idxNeurontype});
    
    temT = table(path,cellID,taskType,tetLocation,meanFR_base,meanFR_task,meanFR_pre,meanFR_stm,meanFR_post,burstIdx,...    % pethSensor
        lightSpk,lightPreSpk,lightPostSpk,psdPreSpk,psdPostSpk,lightSpkPlfm2hz,lightSpkPlfm2hz_pre,lightSpkPlfm2hz_post,... % pethLight
        spkwv,spkwth,hfvwth,spkpvr,...  % waveform
        peakFR2D_track,peakFR2D_plfm,...    % heatMap
        peakFR1D_track,... % analysis_spatialRaster
        sensorMeanFR_DRun,sensorMeanFR_DRw,... % sensorMeanFR
        pLR_Plfm2hz, statDir_Plfm2hz, latencyPlfm2hz1st, latencyPlfm2hz2nd,...
        pLR_Plfm8hz, statDir_Plfm8hz, latencyPlfm8hz1st, latencyPlfm8hz2nd,...
        pLR_Track, statDir_Track, latencyTrack1st, latencyTrack2nd,...
        pLR_TrackN,statDir_TrackN, latencyTrack1stN, latencyTrack2ndN,... % analysis_respstatTrack
        pLR_Track_pre,pLR_Track_post,...    % tagststTrack_poster
        lightProbPlfm5mw,lightProbPlfm8mw,lightProbPlfm10mw,... % analysis_plfm_laserIntTest
        evoSpike5mw,evoSpike8mw,evoSpike10mw,...
        lightPlfmSpk2hz8mw, lightPlfmSpk8hz, lightTrackSpk2hz8mw, lightTrackSpk8hz,... % laserFreqCheck
        lightProbTrack_2hz,lightProbTrack_8hz,lightProbPlfm_2hz,lightProbPlfm_8hz,...
        rCorr1D_preXstm, pCorr1D_preXstm, rCorr1D_preXpost, pCorr1D_preXpost, rCorr1D_stmXpost, pCorr1D_stmXpost, rCorr1D_preXpre, pCorr1D_preXpre,...% analysis_CrossCorr1D // r_CorrPrePre,p_CorrPrePre,r_CorrPreStm,p_CorrPreStm,r_CorrPrePost,p_CorrPrePost,r_CorrStmPost,p_CorrStmPost,...
        infoSpikePRE,infoSpikeSTM,infoSpikePOST,infoSpikeTotal,...
        infoSecondPRE,infoSecondSTM,infoSecondPOST,infoSecondTotal,...
        xptPlfm2hz,yptPlfm2hz,pethtimePlfm2hz,pethPlfm2hz,pethPlfm2hzConv,pethPlfm2hzConvZ,...
        xptPlfm8hz,yptPlfm8hz,pethtimePlfm8hz,pethPlfm8hz,pethPlfm8hzConv,pethPlfm8hzConvZ,...
        xptTrack8hz,yptTrack8hz,pethtimeTrack8hz,pethTrack8hz,pethTrack8hzConv,pethTrack8hzConvZ,...
        xptPsdPre, yptPsdPre, pethtimePsdPre, pethPsdPre,...
        xptPsdStm, yptPsdStm, pethtimePsdStm, pethPsdStm,...    
        xptPsdPost,yptPsdPost,pethtimePsdPost,pethPsdPost,...
        xptPsdPreD,yptPsdPreD,pethtimePsdPreD,pethPsdPreD,xptPsdStmD,yptPsdStmD,pethtimePsdStmD,pethPsdStmD,xptPsdPostD,yptPsdPostD,pethtimePsdPostD,pethPsdPostD,...
        spikePsdPreD,spikePsdStmD,spikePsdPostD,...
        r_wv,m_spont_wv,m_evoked_wv,...
        inzoneSpike,inzoneSpikeNum,m_stmzoneSpike,std_stmzoneSpike,timeIn_stmZone,totalSpike,totalSpikeNum,outzoneSpike,outzoneSpikeNum,p_ttest,...
        peakloci_total,normTrackFR_total,... % analysis_findPeakLoci
        m_deto_spkPlfm8hz,m_deto_spkTrack8hz,evoSpkTrack8hz,evoSpkPlfm8hz,...%analysis_detoSpike8hz
        evoSpike_preEarly, evoSpike_preLate, evoSpike_stmEarly, evoSpike_stmLate, evoSpike_postEarly, evoSpike_postLate,...
        evoXptTrackLight,evoXptPsdPre,evoXptPsdPost,...
        LRatio,ID,...
        idxNeurontype,idxPeakFR,idxPlaceField,idxTotalSpikeNum,idxpLR_Track,idxSpikeIn,idxSpikeOut,idxSpikeTotal,idxZoneInOut);
    T = [T; temT];
    
    temp_Txls = table(path,cellID,taskType,tetLocation,...
        pLR_Plfm2hz, statDir_Plfm2hz, latencyPlfm2hz1st, latencyPlfm2hz2nd,...
        pLR_Plfm8hz, statDir_Plfm8hz, latencyPlfm8hz1st, latencyPlfm8hz2nd,...
        pLR_Track, statDir_Track, latencyTrack1st, latencyTrack2nd,...
        pLR_TrackN,statDir_TrackN, latencyTrack1stN, latencyTrack2ndN,...
        idxNeurontype,idxPeakFR,idxPlaceField,idxpLR_Track,idxZoneInOut);
    Txls = [Txls; temp_Txls];
    
    fclose('all');
end
cd(rtPath);
formatOut = 'yymmdd';
save(['neuronList_ori_control_',datestr(now,formatOut),'.mat'],'T');
writetable(Txls,['neuronList_ori_control_',datestr(now,formatOut),'.xlsx']);