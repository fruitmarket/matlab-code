clearvars;
rtPath = 'D:\Dropbox\SNL\P2_Track';
startingDir = {'D:\Projects\Track_151029-4_Rbp6';'D:\Projects\Track_151029-5_Rbp8';'D:\Projects\Track_151213-2_Rbp14';'D:\Projects\Track_160221-1_Rbp16';'D:\Projects\Track_160417-2_Rbp34ori';'D:\Projects\Track_160422-14_Rbp36ori'};

matFile = [];
nDir = size(startingDir,1);
for iDir = 1:nDir
    tempmatFile = FindFiles('tt*.mat','StartingDirectory',startingDir{iDir},'CheckSubdirs',1);
    matFile = [matFile; tempmatFile];    
end
nFile = length(matFile);

T = table();
for iFile = 1:nFile
    load(matFile{iFile},'meanFR_base','meanFR_task','meanFR_pre','meanFR_stm','meanFR_post','burstIdx','spkwv','spkwth','hfvwth',...
        'pLR_Plfm2hz','pLR_Track','statDir_Plfm2hz','statDir_Track','latencyPlfm2hz','latencyTrack','pLR_Track_pre','pLR_Track_post',...           % From tagstatTrack
        'lightSpk','lightPreSpk','lightPostSpk','xptPsdPre','yptPsdPre','xptPsdPost','yptPsdPost','psdPreSpk','psdPostSpk','lightSpkPlfm2hz','lightSpkPlfm2hz_pre','lightSpkPlfm2hz_post','lightPlfmSpk5mw','lightPlfmSpk8mw','lightPlfmSpk10mw',...         % From pethLight
        'peakMap','peakBase');
%         'statDir_Plfm','testLatencyPlfm','baseLatencyPlfm','pLatencyPlfm','statDir_Track','testLatencyTrack','baseLatencyTrack','pLatencyTrack',...                   % From tagstatTrack
%         'r_Corrbfxaft','r_Corrbfxdr','r_Corrdrxaft','r_Corrhfxhf','r_CorrEvOd','p_Corrbfxaft','p_Corrbfxdr','p_Corrdrxaft','p_Corrhfxhf','p_CorrEvOd');                             % mapCorr & EvOd
    fileSeg = strsplit(matFile{iFile},{'\','_'});
    mouseLine = categorical(cellstr(fileSeg{5}));
    taskType = categorical(cellstr(fileSeg{9}));
    taskProb = categorical(cellstr(fileSeg{10}));
       
    temT = table(mouseLine,taskType,matFile(iFile),taskProb,meanFR_base,meanFR_task,meanFR_pre,meanFR_stm,meanFR_post,burstIdx,{spkwv},spkwth,hfvwth,...
        pLR_Plfm2hz,pLR_Track,statDir_Plfm2hz,statDir_Track,latencyPlfm2hz,latencyTrack,pLR_Track_pre,pLR_Track_post,...                     % From tagstatTrack
        lightSpk,lightPreSpk,lightPostSpk,xptPsdPre,yptPsdPre,xptPsdPost,yptPsdPost,psdPreSpk,psdPostSpk,lightSpkPlfm2hz,lightSpkPlfm2hz_pre,lightSpkPlfm2hz_post,lightPlfmSpk5mw,lightPlfmSpk8mw,lightPlfmSpk10mw,...
        peakMap,peakBase,...%         statDir_Plfm,testLatencyPlfm,baseLatencyPlfm,pLatencyPlfm,statDir_Track,testLatencyTrack,baseLatencyTrack,pLatencyTrack,...                    % From tagstatTrack
        'VariableNames',{'mouseLine','taskType','Path','taskProb','meanFR_base','meanFR_task','meanFR_pre','meanFR_stm','meanFR_post','burstIdx','spkwv','spkwth','hfwth',...%         'statDir_Plfm','testLatencyPlfm','baseLatencyPlfm','pLatencyPlfm','statDir_Track','testLatencyTrack','baseLatencyTrack','pLatencyTrack',...                   % From tagstatTrack
        'pLR_Plfm2hz','pLR_Track','statDir_Plfm2hz','statDir_Track','latencyPlfm2hz','latencyTrack','pLR_Track_pre','pLR_Track_post',...           % From tagstatTrack
        'lightSpk','lightPreSpk','lightPostSpk','xptPsdPre','yptPsdPre','xptPsdPost','yptPsdPost','psdPreSpk','psdPostSpk','lightSpkPlfm2hz','lightSpkPlfm2hz_pre','lightSpkPlfm2hz_post','lightPlfmSpk5mw','lightPlfmSpk8mw','lightPlfmSpk10mw',...
        'peakMap','peakBase'});
    %,'r_Corrbfxaft','r_Corrbfxdr','r_Corrdrxaft','r_Corrhfxhf','r_CorrEvOd','p_Corrbfxaft','p_Corrbfxdr','p_Corrdrxaft','p_Corrhfxhf','p_CorrEvOd'});
    
    T = [T; temT];
end

cd(rtPath);
save('cellList_v4.mat','T');