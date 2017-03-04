clearvars;
rtPath = 'D:\Dropbox\SNL\P2_Track';
startingDir = {'D:\Projects\Track_151029-4_Rbp6';'D:\Projects\Track_151029-5_Rbp8';'D:\Projects\Track_151213-2_Rbp14';'D:\Projects\Track_160221-1_Rbp16';'D:\Projects\Track_160417-2_Rbp34ori';'D:\Projects\Track_160422-14_Rbp36ori';...
               'D:\Projects\Track_160726-1_Rbp48ori';'D:\Projects\Track_160726-2_Rbp50ori'};
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
    deto_spkPlfm2hz = {deto_spkPlfm2hz};
    deto_spkPlfm8hz = {deto_spkPlfm8hz};
    m_spont_wv = {m_spont_wv};
    m_evoked_wv = {m_evoked_wv};
    peakFR2D_track = {peakFR2D_track}; % pre/stm/post
    peakFR1D_track = {peakFR1D_track}; % pre/stm/post
    
    temT = table(path,mouseLine,taskType,tetLocation,meanFR_base,meanFR_task,meanFR_pre,meanFR_stm,meanFR_post,burstIdx,...    % pethSensor
        lightSpk,lightPreSpk,lightPostSpk,psdPreSpk,psdPostSpk,lightSpkPlfm2hz,lightSpkPlfm2hz_pre,lightSpkPlfm2hz_post,... % pethLight
        spkwv,spkwth,hfvwth,spkpvr,...  % waveform
        peakFR2D_track,peakFR2D_plfm,...    % heatMap
        peakFR1D_track,... % analysis_spatialRaster
        sensorMeanFR_DRun,sensorMeanFR_DRw,... % sensorMeanFR
        pLR_Plfm2hz,statDir_Plfm2hz,latencyPlfm2hz,pLR_Plfm8hz,statDir_Plfm8hz,latencyPlfm8hz,pLR_Track,statDir_Track,latencyTrack,...  % tagstatTrack_poster
        pLR_Track_pre,pLR_Track_post,...    % tagststTrack_poster
        rCorr1D_preXstm, pCorr1D_preXstm, rCorr1D_preXpost, pCorr1D_preXpost, rCorr1D_stmXpost, pCorr1D_stmXpost,...% analysis_CrossCorr1D // r_CorrPrePre,p_CorrPrePre,r_CorrPreStm,p_CorrPreStm,r_CorrPrePost,p_CorrPrePost,r_CorrStmPost,p_CorrStmPost,... % mapCorr
        lightPlfmSpk5mw,lightPlfmSpk8mw,lightPlfmSpk10mw,... % laserIntPlfm
        lightPlfmSpk2hz8mw, lightPlfmSpk8hz, lightTrackSpk2hz8mw, lightTrackSpk8hz,... % laserFreqCheck
        deto_spkPlfm2hz, deto_spkPlfm8hz,...% detoSpike
        lightProbTrack_2hz,lightProbTrack_8hz,lightProbPlfm_2hz,lightProbPlfm_8hz,...
        r_wv,m_spont_wv,m_evoked_wv); % laserSpikeProb
                
    T = [T; temT];
    fclose('all');
end
cd(rtPath);
save(['neuronList_ori_',datestr(date),'.mat'],'T');
writetable(T,['neuronList_',datestr(date),'.xlsx']);
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
%     spkwv = {spkwv};
%     sensorMeanFR_DRun = {sensorMeanFR_DRun};
%     sensorMeanFR_DRw = {sensorMeanFR_DRw};
%     deto_spkPlfm2hz = {deto_spkPlfm2hz};
%     deto_spkPlfm8hz = {deto_spkPlfm8hz};
%     m_spont_wv = {m_spont_wv};
%     m_evoked_wv = {m_evoked_wv};
%     peakFR2D_track = {peakFR2D_track}; % pre/stm/post
%     peakFR1D_track = {peakFR1D_track}; % pre/stm/post
%     
%     temT = table(path,mouseLine,taskType,tetLocation,meanFR_base,meanFR_task,meanFR_pre,meanFR_stm,meanFR_post,burstIdx,...    % pethSensor
%         lightSpk,lightPreSpk,lightPostSpk,psdPreSpk,psdPostSpk,lightSpkPlfm2hz,lightSpkPlfm2hz_pre,lightSpkPlfm2hz_post,... % pethLight
%         spkwv,spkwth,hfvwth,spkpvr,...  % waveform
%         peakFR2D_track,peakFR2D_plfm,...    % heatMap
%         peakFR1D_track,... % analysis_spatialRaster
%         sensorMeanFR_DRun,sensorMeanFR_DRw,... % sensorMeanFR
%         pLR_Plfm2hz,statDir_Plfm2hz,latencyPlfm2hz,pLR_Plfm8hz,statDir_Plfm8hz,latencyPlfm8hz,pLR_Track,statDir_Track,latencyTrack,...  % tagstatTrack_poster
%         pLR_Track_pre,pLR_Track_post,...    % tagststTrack_poster
%         rCorr1D_preXstm, pCorr1D_preXstm, rCorr1D_preXpost, pCorr1D_preXpost, rCorr1D_stmXpost, pCorr1D_stmXpost,...% analysis_CrossCorr1D // r_CorrPrePre,p_CorrPrePre,r_CorrPreStm,p_CorrPreStm,r_CorrPrePost,p_CorrPrePost,r_CorrStmPost,p_CorrStmPost,... % mapCorr
%         lightPlfmSpk5mw,lightPlfmSpk8mw,lightPlfmSpk10mw,... % laserIntPlfm
%         lightPlfmSpk2hz8mw, lightPlfmSpk8hz, lightTrackSpk2hz8mw, lightTrackSpk8hz,... % laserFreqCheck
%         deto_spkPlfm2hz, deto_spkPlfm8hz,...% detoSpike
%         lightProbTrack_2hz,lightProbTrack_8hz,lightProbPlfm_2hz,lightProbPlfm_8hz,...
%         r_wv,m_spont_wv,m_evoked_wv); % laserSpikeProb
%                 
%     T = [T; temT];
%     fclose('all');
% end
% cd(rtPath);
% writetable(T,['neuronList_',datestr(date),'.xlsx']);