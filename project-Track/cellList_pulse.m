clearvars;
rtPath = 'D:\Dropbox\SNL\P2_Track';
startingDir = {'D:\Projects\Track_160726-1_Rbp48pulse';
               'D:\Projects\Track_160726-2_Rbp50pulse';
               'D:\Projects\Track_160824-2_Rbp58pulse';
               'D:\Projects\Track_160824-5_Rbp60pulse';
               'D:\Projects\Track_161130-3_Rbp64pulse';
               'D:\Projects\Track_161130-5_Rbp66pulse';
               'D:\Projects\Track_161130-7_Rbp68pulse';
               'D:\Projects\Track_170119-1_Rbp70pulse';
               'D:\Projects\Track_170109-2_Rbp72pulse';
               'D:\Projects\Track_170115-4_Rbp74pulse'};

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
    
    xpt10ms = {xpt10ms};
    ypt10ms = {ypt10ms};
    pethtime10ms = {pethtime10ms};
    peth10ms = {peth10ms};
    pethConv10ms = {pethConv10ms};
    pethConvZ10ms = {pethConvZ10ms};
    
    xpt20ms = {xpt20ms};
    ypt20ms = {ypt20ms};
    pethtime20ms = {pethtime20ms};
    peth20ms = {peth20ms};
    pethConv20ms = {pethConv20ms};
    pethConvZ20ms = {pethConvZ20ms};
    
    xpt50ms = {xpt50ms};
    ypt50ms = {ypt50ms};
    pethtime50ms = {pethtime50ms};
    peth50ms = {peth50ms};
    pethConv50ms = {pethConv50ms};
    pethConvZ50ms = {pethConvZ50ms};
    
    spkwv = {spkwv};
    
    temT = table(mouseLine,path,...
        meanFR10,meanFR20,meanFR50,...
        xpt10ms,ypt10ms,pethtime10ms,peth10ms,pethConv10ms,pethConvZ10ms,nlight10ms,lightspk10ms,...
        xpt20ms,ypt20ms,pethtime20ms,peth20ms,pethConv20ms,pethConvZ20ms,nlight20ms,lightspk20ms,...
        xpt50ms,ypt50ms,pethtime50ms,peth50ms,pethConv50ms,pethConvZ50ms,nlight50ms,lightspk50ms,...
        pLR_Plfm2hz,statDir_Plfm2hz,latencyPlfm2hz,...  % tagstatTrack_poster
        spkwv,spkwth,spkpvr,hfvwth);
                
    T = [T; temT];
    fclose('all');
end
cd(rtPath);

formatOut = 'yymmdd';
save(['neuronList_pulse_',datestr(now,formatOut),'.mat'],'T');