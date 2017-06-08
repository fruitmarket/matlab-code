clearvars;
rtPath = 'D:\Dropbox\SNL\P2_Track';
startingDir = {'D:\Projects\Track_160824-2_Rbp58freq';
               'D:\Projects\Track_160824-5_Rbp60freq';
               'D:\Projects\Track_161130-3_Rbp64freq';
               'D:\Projects\Track_161130-5_Rbp66freq';
               'D:\Projects\Track_161130-7_Rbp68freq';
               'D:\Projects\Track_170119-1_Rbp70freq';
               'D:\Projects\Track_170109-2_Rbp72freq';
               'D:\Projects\Track_170115-4_Rbp74freq'};
matFile = [];
nDir = size(startingDir,1);
for iDir = 1:nDir
    tempmatFile = FindFiles('tt*.mat','StartingDirectory',startingDir{iDir},'CheckSubdirs',1);
    matFile = [matFile; tempmatFile];
end
nFile = length(matFile);

T = table();
for iFile = 31:nFile % 1hz2hz8hz20hz50hz starts from 31
    load(matFile{iFile});

    path = matFile(iFile);
    fileSeg = strsplit(matFile{iFile},{'\','_'});
    mouseLine = categorical(cellstr(fileSeg{5}));
    
    spkwv = {spkwv};
       
    temT = table(mouseLine,path,...
        pLR_Plfm1hz, pLR_Plfm2hz, pLR_Plfm8hz, pLR_Plfm20hz,pLR_Plfm50hz,...
        latency1hz1st, latency1hz2nd, latency2hz1st, latency2hz2nd, latency8hz1st, latency8hz2nd, latency20hz1st, latency20hz2nd, latency50hz1st, latency50hz2nd,...
        lightProb1hz,lightProb2hz,lightProb8hz,lightProb20hz,lightProb50hz,...
        evoSpike1hz,evoSpike2hz,evoSpike8hz,evoSpike20hz,evoSpike50hz,...
        evoSpk1hz,detoSpk1hz,evoSpk2hz,detoSpk2hz,evoSpk8hz,detoSpk8hz,evoSpk20hz,detoSpk20hz,evoSpk50hz,detoSpk50hz,... % analysis_freq_detoSpike
        spkwv,spkwth,spkpvr,hfvwth,total_mFR);
                
    T = [T; temT];
    fclose('all');
end
cd(rtPath);
formatOut = 'yymmdd';
save(['neuronList_freq_',datestr(now,formatOut),'.mat'],'T');
writetable(T,['neuronList_freq_',datestr(now,formatOut),'.xlsx']);
disp('##### Done! #####');