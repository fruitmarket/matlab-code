clearvars;
rtPath = 'D:\Dropbox\SNL\P2_Track';
startingDir = {'D:\Projects\Track_170119-1_Rbp70ori50';
               'D:\Projects\Track_170109-2_Rbp72ori50'};

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
    
    stmzoneSpike = {stmzoneSpike};
    m_stmzoneSpike = {m_stmzoneSpike};
    std_stmzoneSpike = {std_stmzoneSpike};
    
    peakloci_total = {peakloci_total};
    pethconvSpatial = {pethconvSpatial};
    normTrackFR_total = {normTrackFR_total};
    
    temT = table(path,cellID,taskType,tetLocation,meanFR_base,meanFR_task,meanFR_pre,meanFR_stm,meanFR_post,burstIdx,...    % pethSensor
        lightSpk,lightPreSpk,lightPostSpk,psdPreSpk,psdPostSpk,lightSpkPlfm2hz,lightSpkPlfm2hz_pre,lightSpkPlfm2hz_post,... % pethLight
        spkwv,spkwth,hfvwth,spkpvr,...  % waveform
        peakFR2D_track,peakFR2D_plfm,...    % heatMap
        peakFR1D_track,... % analysis_spatialRaster
        sensorMeanFR_DRun,sensorMeanFR_DRw,... % sensorMeanFR
        xptTrackLight, xptPsdPre, xptPsdPost,...
        pLR_Plfm2hz, statDir_Plfm2hz, latencyPlfm2hz1st, latencyPlfm2hz2nd,...
        pLR_Plfm50hz, statDir_Plfm50hz, latencyPlfm50hz1st, latencyPlfm50hz2nd,...
        pLR_Track, statDir_Track, latencyTrack1st, latencyTrack2nd,...  % tagstatTrack_poster
        pLR_Track_pre,pLR_Track_post,...    % tagststTrack_poster
        rCorr1D_preXstm, pCorr1D_preXstm, rCorr1D_preXpost, pCorr1D_preXpost, rCorr1D_stmXpost, pCorr1D_stmXpost,...% analysis_CrossCorr1D // r_CorrPrePre,p_CorrPrePre,r_CorrPreStm,p_CorrPreStm,r_CorrPrePost,p_CorrPrePost,r_CorrStmPost,p_CorrStmPost,... % mapCorr
        lightProbPlfm5mw,lightProbPlfm8mw,lightProbPlfm10mw,... % analysis_plfm_laserIntTest
        evoSpike5mw,evoSpike8mw,evoSpike10mw,...
        lightPlfmSpk2hz8mw, lightPlfmSpk50hz, lightTrackSpk2hz8mw, lightTrackSpk50hz,... % laserFreqCheck
        lightProbTrack_2hz,lightProbTrack_50hz,lightProbPlfm_2hz,lightProbPlfm_50hz,...
        xptPlfm2hz,yptPlfm2hz,pethtimePlfm2hz,pethPlfm2hz,pethPlfm2hzConv,pethPlfm2hzConvZ,...
        xptPlfm50hz,yptPlfm50hz,pethtimePlfm50hz,pethPlfm50hz,pethPlfm50hzConv,pethPlfm50hzConvZ,...
        xptTrack50hz,yptTrack50hz,pethtimeTrack50hz,pethTrack50hz,pethTrack50hzConv,pethTrack50hzConvZ,...
        r_wv,m_spont_wv,m_evoked_wv,...
        stmzoneSpike,m_stmzoneSpike,std_stmzoneSpike,...
        peakloci_total,normTrackFR_total,... % analysis_findPeakLoci
        m_deto_spkPlfm50hz,m_deto_spkTrack50hz,evoSpkTrack50hz,evoSpkPlfm50hz); %analysis_detoSpike50hz

    T = [T; temT];
    fclose('all');
end
cd(rtPath);
formatOut = 'yymmdd';
save(['neuronList_ori50hz_',datestr(now,formatOut),'.mat'],'T');
% writetable(T,['neuronList_',datestr(date),'.xlsx']);

%% excel file format (simple)
T = table();
for iFile = 1:nFile
    load(matFile{iFile});
    
    cellID = iFile;
    temT = table(path,cellID,taskType,tetLocation);

    T = [T; temT];
    fclose('all');
end
cd(rtPath);
writetable(T,['neuronList_ori50hz_',datestr(now,formatOut),'.xlsx']);

%% excel file format
% T = table();
% for iFile = 1:nFile
%     load(matFile{iFile});
% 
%     path = matFile(iFile);
%     dateSession = strsplit(matFile{iFile},{'\'});
%     tetLocation = strsplit(dateSession{4},'_');
%     tetLocation = categorical(cellstr(tetLocation{2}));
%     fileSeg = strsplit(matFile{iFile},{'\','_'});
%     mouseLine = categorical(cellstr(fileSeg{5}));
%     taskType = categorical(cellstr(fileSeg{9}));
%     taskProb = categorical(cellstr(fileSeg{10}));
%     peakFR2D_track = {peakFR2D_track}; % pre/stm/post
%     peakFR1D_track = {peakFR1D_track}; % pre/stm/post
%     m_deto_spkPlfm50hz = {m_deto_spkPlfm50hz};
%     m_deto_spkTrack50hz = {m_deto_spkTrack50hz}; 
% 
%     temT = table(path,mouseLine,taskType,tetLocation,meanFR_base,meanFR_task,meanFR_pre,meanFR_stm,meanFR_post,burstIdx,...    % pethSensor
%         lightSpk,lightPreSpk,lightPostSpk,psdPreSpk,psdPostSpk,lightSpkPlfm2hz,lightSpkPlfm2hz_pre,lightSpkPlfm2hz_post,... % pethLight
%         spkwth,hfvwth,spkpvr,...  % waveform
%         peakFR2D_track,peakFR2D_plfm,...    % heatMap
%         peakFR1D_track,... % analysis_spatialRaster
%         pLR_Plfm2hz, statDir_Plfm2hz, latencyPlfm2hz1st, latencyPlfm2hz2nd,...
%         pLR_Plfm50hz,statDir_Plfm50hz, latencyPlfm50hz1st, latencyPlfm50hz2nd,...
%         pLR_Track, statDir_Track, latencyTrack1st, latencyTrack2nd,...  % tagstatTrack_poster
%         pLR_Track_pre,pLR_Track_post,...    % tagststTrack_poster
%         rCorr1D_preXstm, pCorr1D_preXstm, rCorr1D_preXpost, pCorr1D_preXpost, rCorr1D_stmXpost, pCorr1D_stmXpost,...% analysis_CrossCorr1D // r_CorrPrePre,p_CorrPrePre,r_CorrPreStm,p_CorrPreStm,r_CorrPrePost,p_CorrPrePost,r_CorrStmPost,p_CorrStmPost,... % mapCorr
%         r_wv); % laserSpikeProb
% 
%     T = [T; temT];
%     fclose('all');
% end
% cd(rtPath);
% writetable(T,['neuronList_ori_',datestr(now,formatOut),'.xlsx']);