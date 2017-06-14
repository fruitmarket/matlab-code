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
    cellID = (iFile-30)';
    
    spkwv = {spkwv};
    xptLight = {xptLight};
    yptLight = {yptLight};
    pethtimeLight = {pethtimeLight};
    pethLight = {pethLight};
    pethConvLight = {pethConvLight};
    pethConvZLight = {pethConvZLight};
       
    temT = table(mouseLine,path,cellID,...
        pLR_Plfm1hz, pLR_Plfm2hz, pLR_Plfm8hz, pLR_Plfm20hz,pLR_Plfm50hz,...
        statDir1hz,statDir2hz,statDir8hz,statDir20hz,statDir50hz,...
        latency1hz1st, latency1hz2nd, latency2hz1st, latency2hz2nd, latency8hz1st, latency8hz2nd, latency20hz1st, latency20hz2nd, latency50hz1st, latency50hz2nd,...
        lightProb1hz_dr,lightProb2hz_dr,lightProb8hz_dr,lightProb20hz_dr,lightProb50hz_dr,...
        evoSpike1hz_dr,evoSpike2hz_dr,evoSpike8hz_dr,evoSpike20hz_dr,evoSpike50hz_dr,...
        lightProb1hz_idr,lightProb2hz_idr,lightProb8hz_idr,lightProb20hz_idr,lightProb50hz_idr,...
        evoSpike1hz_idr,evoSpike2hz_idr,evoSpike8hz_idr,evoSpike20hz_idr,evoSpike50hz_idr,...
        evoDetoSpk1hz,detoProb1hz,evoDetoSpk2hz,detoSpk2hz,evoDetoSpk8hz,detoProb8hz,evoDetoSpk20hz,detoProb20hz,evoDetoSpk50hz,detoProb50hz,... % analysis_freq_detoSpike
        xptLight, yptLight, pethtimeLight, pethLight, pethConvLight, pethConvZLight, nLight, lightSpk,meanFR,... % analysis_freq_pethLight
        spkwv,spkwth,spkpvr,hfvwth);
                
    T = [T; temT];
    fclose('all');
end
cd(rtPath);
formatOut = 'yymmdd';
save(['neuronList_freq_',datestr(now,formatOut),'.mat'],'T');
writetable(T,['neuronList_freq_',datestr(now,formatOut),'.xlsx']);
disp('##### Done! #####');
clearvars;