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
    fileSeg = strsplit(matFile{iFile},{'\','_'});
    mouseLine = categorical(cellstr(fileSeg{5}));
    taskType = categorical(cellstr(fileSeg{9}));
    taskProb = categorical(cellstr(fileSeg{10}));
    spkwv = {spkwv};
       
    temT = table(mouseLine,taskType,path,taskProb,meanFR_base,meanFR_task,meanFR_pre,meanFR_stm,meanFR_post,burstIdx,...    % pethSensor
        lightSpk,lightPreSpk,lightPostSpk,psdPreSpk,psdPostSpk,lightSpkPlfm2hz,lightSpkPlfm2hz_pre,lightSpkPlfm2hz_post,... % pethLight
        spkwv,spkwth,hfvwth,spkpvr,...  % waveform
        peakFR_track,peakFR_plfm,...    % heatMap
        pLR_Plfm2hz,statDir_Plfm2hz,latencyPlfm2hz,pLR_Plfm8hz,statDir_Plfm8hz,latencyPlfm8hz,pLR_Track,statDir_Track,latencyTrack,...  % tagstatTrack_poster
        pLR_Track_pre,pLR_Track_post,...    % tagststTrack_poster
        lightPlfmSpk5mw,lightPlfmSpk8mw,lightPlfmSpk10mw); % laserIntPlfm
                
    T = [T; temT];
    fclose('all');
end

cd(rtPath);
formatOut = 'yymmdd';
save(['neuronList_modi_',datestr(now,formatOut),'.mat'],'T');