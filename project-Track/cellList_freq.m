clearvars;
rtPath = 'D:\Dropbox\SNL\P2_Track';
startingDir = {'D:\Projects\Track_160824-2_Rbp58freq';'D:\Projects\Track_160824-5_Rbp60freq'};
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
       
    temT = table(mouseLine,path,...
        pLR_Plfm2hz,statDir_Plfm2hz,latencyPlfm2hz,pLR_Plfm8hz,statDir_Plfm8hz,latencyPlfm8hz,...  % tagstatTrack_poster
        lightProb1hz,lightProb2hz,lightProb8hz,lightProb20hz,lightProb50hz);
                
    T = [T; temT];
    fclose('all');
end
cd(rtPath);
save(['neuronList_freq_',datestr(date),'.mat'],'T');