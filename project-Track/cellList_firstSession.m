%% Directory setup
rtPath = 'D:\Dropbox\SNL\P2_Track';
startingDir = {'D:\Projects\Track_151029-4_Rbp6\160422_DV2.17_2_DRun_100_T278';
               'D:\Projects\Track_151029-5_Rbp8\160428_DV2.12_2_DRw_100_T3578';
               'D:\Projects\Track_151213-2_Rbp14\160518_DV1.97_2_DRw_100_T67';
               'D:\Projects\Track_160221-1_Rbp16\160620_DV1.95_1_DRw_100_T457';
               'D:\Projects\Track_160417-1_Rbp32ori\160829_DV1.90_1_DRw_T12478';
               'D:\Projects\Track_160417-2_Rbp34ori\160825_DV1.80_2_DRw_100_T4';
               'D:\Projects\Track_160422-14_Rbp36ori\160919_DV1.75_1_DRw_100_T1678';
               'D:\Projects\Track_160726-1_Rbp48ori\161201_DV2.15_2_DRw_100_T246';
               'D:\Projects\Track_160726-2_Rbp50ori\161201_DV2.00_1_DRw_100_T346';
               'D:\Projects\Track_160824-2_Rbp58ori\170113_DV1.90_2_DRw_T4_Ori';
               'D:\Projects\Track_160824-5_Rbp60ori\170113_DV1.85_2_DRun_T347_Ori';
               'D:\Projects\Track_161130-3_Rbp64ori\170223_DV1.85_1_DRw_T26_Ori';
               'D:\Projects\Track_161130-5_Rbp66ori\170222_DV1.85_1_DRw_T36_Ori';
               'D:\Projects\Track_161130-7_Rbp68ori\170223_DV1.85_1_DRw_T27_Ori';
               'D:\Projects\Track_170119-1_Rbp70ori\170415_DV1.55_1_DRun_T1246_Ori';
               'D:\Projects\Track_170109-2_Rbp72ori\170420_DV1.65_1_DRw_T2_Ori';
               'D:\Projects\Track_170115-4_Rbp74ori\170420_DV1.60_1_DRun_T235_Ori'};
           
matFile = [];
nDir = size(startingDir,1);
for iDir = 1:nDir
    tempmatFile = FindFiles('tt*.mat','StartingDirectory',startingDir{iDir},'CheckSubdirs',1);
    matFile = [matFile; tempmatFile];
end

nFile = length(matFile);
T1ss = table();
for iFile = 1:nFile
    load(matFile{iFile});

    path = matFile(iFile);
    dateSession = strsplit(matFile{iFile},{'\'});
    tetLocation = strsplit(dateSession{4},'_');
    tetLocation = categorical(cellstr(tetLocation{2}));
    fileSeg = strsplit(matFile{iFile},{'\','_'});
    mouseLine = categorical(cellstr(fileSeg{5}));
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
    
    xptTrack8hz = {xptTrackLight};
    yptTrack8hz = {yptTrackLight};
    pethtimeTrack8hz = {pethtimeTrackLight};
    pethTrack8hz = {pethTrackLight};
    pethTrack8hzConv = {pethTrackLightConv};
    pethTrack8hzConvZ = {pethTrackLightConvZ};
    
    m_deto_spkPlfm8hz = {m_deto_spkPlfm8hz};
    m_deto_spkTrack8hz = {m_deto_spkTrack8hz};
    
    stmzoneSpike = {stmzoneSpike};
    
    peakloci_total = {peakloci_total};
    pethconvSpatial = {pethconvSpatial};
    normTrackFR_total = {normTrackFR_total};
    
    temT = table(path,mouseLine,taskType,tetLocation,meanFR_base,meanFR_task,meanFR_pre,meanFR_stm,meanFR_post,burstIdx,...    % pethSensor
        lightSpk,lightPreSpk,lightPostSpk,psdPreSpk,psdPostSpk,lightSpkPlfm2hz,lightSpkPlfm2hz_pre,lightSpkPlfm2hz_post,... % pethLight
        spkwv,spkwth,hfvwth,spkpvr,...  % waveform
        peakFR2D_track,peakFR2D_plfm,...    % heatMap
        peakFR1D_track,... % analysis_spatialRaster
        sensorMeanFR_DRun,sensorMeanFR_DRw,... % sensorMeanFR
        xptTrackLight, xptPsdPre, xptPsdPost,...
        pLR_Plfm2hz, statDir_Plfm2hz, latencyPlfm2hz1st, latencyPlfm2hz2nd,...
        pLR_Plfm8hz, statDir_Plfm8hz, latencyPlfm8hz1st, latencyPlfm8hz2nd,...
        pLR_Track, statDir_Track, latencyTrack1st, latencyTrack2nd,...  % tagstatTrack_poster
        pLR_Track_pre,pLR_Track_post,...    % tagststTrack_poster
        rCorr1D_preXstm, pCorr1D_preXstm, rCorr1D_preXpost, pCorr1D_preXpost, rCorr1D_stmXpost, pCorr1D_stmXpost,...% analysis_CrossCorr1D // r_CorrPrePre,p_CorrPrePre,r_CorrPreStm,p_CorrPreStm,r_CorrPrePost,p_CorrPrePost,r_CorrStmPost,p_CorrStmPost,... % mapCorr
        lightProbPlfm5mw,lightProbPlfm8mw,lightProbPlfm10mw,... % laserIntPlfm
        lightPlfmSpk2hz8mw, lightPlfmSpk8hz, lightTrackSpk2hz8mw, lightTrackSpk8hz,... % laserFreqCheck
        lightProbTrack_2hz,lightProbTrack_8hz,lightProbPlfm_2hz,lightProbPlfm_8hz,...
        xptPlfm2hz,yptPlfm2hz,pethtimePlfm2hz,pethPlfm2hz,pethPlfm2hzConv,pethPlfm2hzConvZ,...
        xptPlfm8hz,yptPlfm8hz,pethtimePlfm8hz,pethPlfm8hz,pethPlfm8hzConv,pethPlfm8hzConvZ,...
        xptTrack8hz,yptTrack8hz,pethtimeTrack8hz,pethTrack8hz,pethTrack8hzConv,pethTrack8hzConvZ,...
        r_wv,m_spont_wv,m_evoked_wv,...
        stmzoneSpike,...
        peakloci_total,normTrackFR_total,... % analysis_findPeakLoci
        m_deto_spkPlfm8hz,m_deto_spkTrack8hz,...
        evoSpike_preEarly, evoSpike_preLate, evoSpike_stmEarly, evoSpike_stmLate, evoSpike_postEarly, evoSpike_postLate,...
        evoXptTrackLight,evoXptPsdPre,evoXptPsdPost);

    T1ss = [T1ss; temT];
    fclose('all');
end
cd(rtPath);
formatOut = 'yymmdd';
save(['neuronList_1stSess_',datestr(now,formatOut),'.mat'],'T1ss');
writetable(T1ss,['neuronList_1stSess_',datestr(now,formatOut),'.xlsx']);