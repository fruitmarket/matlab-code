clearvars;
rtPath = 'D:\Dropbox\SNL\P2_Track';
startingDir = {'D:\Projects\Track_151029-4_Rbp6';'D:\Projects\Track_151029-5_Rbp8';'D:\Projects\Track_151213-2_Rbp14';'D:\Projects\Track_160221-1_Rbp16'};

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
        'statDir_Plfm','testLatencyPlfm','baseLatencyPlfm','pLatencyPlfm','statDir_Track','testLatencyTrack','baseLatencyTrack','pLatencyTrack',...                   % From tagstatTrack
        'pLR_Plfm','pLR_Track',...           % From tagstatTrack
        'lightSpk','lightPreSpk','lightPostSpk','psdPreSpk','psdPostSpk','lighttagSpk','lighttagPreSpk','lighttagPostSpk','intraLightDir','interLightDir','tagLightDir','lighttagSpk5mw','lighttagSpk8mw','lighttagSpk10mw',...         % From pethLight
        'peakMap','r_Corrbfxaft','r_Corrbfxdr','r_Corrdrxaft','r_Corrhfxhf','r_CorrEvOd','p_Corrbfxaft','p_Corrbfxdr','p_Corrdrxaft','p_Corrhfxhf','p_CorrEvOd');                             % mapCorr & EvOd
    fileSeg = strsplit(matFile{iFile},{'\','_'});
    mouseLine = categorical(cellstr(fileSeg{5}));
    taskType = categorical(cellstr(fileSeg{9}));
    taskProb = categorical(cellstr(fileSeg{10}));
       
    temT = table(mouseLine,taskType,matFile(iFile),taskProb,meanFR_base,meanFR_task,meanFR_pre,meanFR_stm,meanFR_post,burstIdx,{spkwv},spkwth,hfvwth,...
        statDir_Plfm,testLatencyPlfm,baseLatencyPlfm,pLatencyPlfm,statDir_Track,testLatencyTrack,baseLatencyTrack,pLatencyTrack,...                    % From tagstatTrack
        pLR_Plfm,pLR_Track,...                     % From tagstatTrack
        lightSpk,lightPreSpk,lightPostSpk,psdPreSpk,psdPostSpk,lighttagSpk,lighttagPreSpk,lighttagPostSpk,intraLightDir,interLightDir,tagLightDir,lighttagSpk5mw,lighttagSpk8mw,lighttagSpk10mw,...
        peakMap,r_Corrbfxaft,r_Corrbfxdr,r_Corrdrxaft,r_Corrhfxhf,r_CorrEvOd,p_Corrbfxaft,p_Corrbfxdr,p_Corrdrxaft,p_Corrhfxhf,p_CorrEvOd,...
        'VariableNames',{'mouseLine','taskType','Path','taskProb','meanFR_base','meanFR_task','meanFR_pre','meanFR_stm','meanFR_post','burstIdx','spkwv','spkwth','hfwth',...
        'statDir_Plfm','testLatencyPlfm','baseLatencyPlfm','pLatencyPlfm','statDir_Track','testLatencyTrack','baseLatencyTrack','pLatencyTrack',...                   % From tagstatTrack
        'pLR_Plfm','pLR_Track',...           % From tagstatTrack
        'lightSpk','lightPreSpk','lightPostSpk','psdPreSpk','psdPostSpk','lighttagSpk','lighttagPreSpk','lighttagPostSpk','intraLightDir','interLightDir','tagLightDir','lighttagSpk5mw','lighttagSpk8mw','lighttagSpk10mw',...
        'peakMap','r_Corrbfxaft','r_Corrbfxdr','r_Corrdrxaft','r_Corrhfxhf','r_CorrEvOd','p_Corrbfxaft','p_Corrbfxdr','p_Corrdrxaft','p_Corrhfxhf','p_CorrEvOd'});
    
    T = [T; temT];
end

cd(rtPath);
save('cellList_v3.mat','T');