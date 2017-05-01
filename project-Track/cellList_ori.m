clearvars;
rtPath = 'D:\Dropbox\SNL\P2_Track';
startingDir = {'D:\Projects\Track_151029-4_Rbp6';
               'D:\Projects\Track_151029-5_Rbp8';
               'D:\Projects\Track_151213-2_Rbp14';
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
               'D:\Projects\Track_161130-7_Rbp68ori'};
% startingDir = {'D:\Projects\Track_160417-1_Rbp32ori'};
matFile = [];
nDir = size(startingDir,1);
for iDir = 1:nDir
    tempmatFile = FindFiles('tt*.mat','StartingDirectory',startingDir{iDir},'CheckSubdirs',1);
    matFile = [matFile; tempmatFile];    
end
nFile = length(matFile);

T = table();
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
        lightPlfmSpk5mw,lightPlfmSpk8mw,lightPlfmSpk10mw,... % laserIntPlfm
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

    T = [T; temT];
    fclose('all');
end
cd(rtPath);
formatOut = 'yymmdd';
save(['neuronList_ori_',datestr(now,formatOut),'.mat'],'T');
% writetable(T,['neuronList_',datestr(date),'.xlsx']);

%% excel file format
T = table();
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
    peakFR2D_track = {peakFR2D_track}; % pre/stm/post
    peakFR1D_track = {peakFR1D_track}; % pre/stm/post
    m_deto_spkPlfm8hz = {m_deto_spkPlfm8hz};
    m_deto_spkTrack8hz = {m_deto_spkTrack8hz}; 

    temT = table(path,mouseLine,taskType,tetLocation,meanFR_base,meanFR_task,meanFR_pre,meanFR_stm,meanFR_post,burstIdx,...    % pethSensor
        lightSpk,lightPreSpk,lightPostSpk,psdPreSpk,psdPostSpk,lightSpkPlfm2hz,lightSpkPlfm2hz_pre,lightSpkPlfm2hz_post,... % pethLight
        spkwth,hfvwth,spkpvr,...  % waveform
        peakFR2D_track,peakFR2D_plfm,...    % heatMap
        peakFR1D_track,... % analysis_spatialRaster
        pLR_Plfm2hz, statDir_Plfm2hz, latencyPlfm2hz1st, latencyPlfm2hz2nd,...
        pLR_Plfm8hz,statDir_Plfm8hz, latencyPlfm8hz1st, latencyPlfm8hz2nd,...
        pLR_Track, statDir_Track, latencyTrack1st, latencyTrack2nd,...  % tagstatTrack_poster
        pLR_Track_pre,pLR_Track_post,...    % tagststTrack_poster
        rCorr1D_preXstm, pCorr1D_preXstm, rCorr1D_preXpost, pCorr1D_preXpost, rCorr1D_stmXpost, pCorr1D_stmXpost,...% analysis_CrossCorr1D // r_CorrPrePre,p_CorrPrePre,r_CorrPreStm,p_CorrPreStm,r_CorrPrePost,p_CorrPrePost,r_CorrStmPost,p_CorrStmPost,... % mapCorr
        r_wv); % laserSpikeProb

    T = [T; temT];
    fclose('all');
end
cd(rtPath);
writetable(T,['neuronList_ori_',datestr(now,formatOut),'.xlsx']);

% table_PN & IN
% cri_Peak = 7;
% cri_spkpvr = 1.46;
% popul_IN = T.meanFR_task>cri_Peak & T.spkpvr<cri_spkpvr;
% T_in = T(popul_IN,:);
% T_pn = T(~popul_IN,:);
% writetable(T_in,['interneuronList_',datestr(date),'xlsx']);
% writetable(T_pn,['pyramidalList_',datestr(date),'xlsx']);