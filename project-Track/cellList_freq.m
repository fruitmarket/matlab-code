clearvars;
rtPath = 'D:\Dropbox\SNL\P2_Track';
startingDir = {'D:\Projects\Track_160824-2_Rbp58freq';
               'D:\Projects\Track_160824-5_Rbp60freq'
               'D:\Projects\Track_161130-3_Rbp64freq';
               'D:\Projects\Track_161130-5_Rbp66freq';
               'D:\Projects\Track_161130-7_Rbp68freq'};
matFile = [];
nDir = size(startingDir,1);
for iDir = 1:nDir
    tempmatFile = FindFiles('tt*.mat','StartingDirectory',startingDir{iDir},'CheckSubdirs',1);
    matFile = [matFile; tempmatFile];
end
nFile = length(matFile);

T = table();
for iFile = 31:nFile
    load(matFile{iFile});

    path = matFile(iFile);
    fileSeg = strsplit(matFile{iFile},{'\','_'});
    mouseLine = categorical(cellstr(fileSeg{5}));
       
    temT = table(mouseLine,path,...
        pLR_Plfm1hz,...
        pLR_Plfm2hz,statDir_Plfm2hz,latencyPlfm2hz,...
        pLR_Plfm8hz,statDir_Plfm8hz,latencyPlfm8hz,...  % tagstatTrack_
        pLR_Plfm20hz,pLR_Plfm50hz,...
        lightProb1hz,lightProb2hz,lightProb8hz,lightProb20hz,lightProb50hz,...
        total_mFR);
                
    T = [T; temT];
    fclose('all');
end
cd(rtPath);
formatOut = 'yymmdd';
save(['neuronList_freq_',datestr(now,formatOut),'.mat'],'T');
writetable(T,['neuronList_freq_',datestr(now,formatOut),'.xlsx']);