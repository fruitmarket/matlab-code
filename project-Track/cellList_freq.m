clearvars;
rtPath = 'D:\Dropbox\SNL\P2_Track';
startingDir = {'D:\Projects\Track_160824-2_Rbp58freq';
               'D:\Projects\Track_160824-5_Rbp60freq';
               'D:\Projects\Track_161130-3_Rbp64freq';
               'D:\Projects\Track_161130-7_Rbp68freq';
               'D:\Projects\Track_170119-1_Rbp70freq';
               'D:\Projects\Track_170109-2_Rbp72freq'; 
               'D:\Projects\Track_170305-1_Rbp76freq_8mw';
               'D:\Projects\Track_170305-2_Rbp78freq_8mw'};
                % 'D:\Projects\Track_161130-5_Rbp66freq';
                % 'D:\Projects\Track_170115-4_Rbp74freq';
formatOut = 'yymmdd';
matFile = [];
nDir = size(startingDir,1);
for iDir = 1:nDir
    tempmatFile = FindFiles('tt*.mat','StartingDirectory',startingDir{iDir},'CheckSubdirs',1);
    matFile = [matFile; tempmatFile];
end
nFile = length(matFile);
%% matfile output
[T, Txls] = deal(table());

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
    
    xpt2hz_ori = {xpt2hz_ori};
    ypt2hz_ori = {ypt2hz_ori};
    pethtime2hz_ori = {pethtime2hz_ori};
    peth2hz_ori = {peth2hz_ori};
    peth2hzConv_ori = {peth2hzConv_ori};
    peth2hzConvZ_ori = {peth2hzConvZ_ori};
    
    xpt8hz_ori = {xpt8hz_ori};
    ypt8hz_ori = {ypt8hz_ori};
    pethtime8hz_ori = {pethtime8hz_ori};
    peth8hz_ori = {peth8hz_ori};
    peth8hzConv_ori = {peth8hzConv_ori};
    peth8hzConvZ_ori = {peth8hzConvZ_ori};
       
    temT = table(mouseLine,path,cellID,...
        pLR_Plfm1hz, pLR_Plfm2hz, pLR_Plfm8hz, pLR_Plfm20hz,pLR_Plfm50hz,...
        statDir1hz,statDir2hz,statDir8hz,statDir20hz,statDir50hz,...
        latency1hz1st, latency1hz2nd, latency2hz1st, latency2hz2nd, latency8hz1st, latency8hz2nd, latency20hz1st, latency20hz2nd, latency50hz1st, latency50hz2nd,...
        lightProb1hz_dr,lightProb2hz_dr,lightProb8hz_dr,lightProb20hz_dr,lightProb50hz_dr,...
        evoSpike1hz_dr,evoSpike2hz_dr,evoSpike8hz_dr,evoSpike20hz_dr,evoSpike50hz_dr,...
        lightProb1hz_idr,lightProb2hz_idr,lightProb8hz_idr,lightProb20hz_idr,lightProb50hz_idr,...
        evoSpike1hz_idr,evoSpike2hz_idr,evoSpike8hz_idr,evoSpike20hz_idr,evoSpike50hz_idr,...
        evoDetoSpk1hz,detoProb1hz,evoDetoSpk2hz,detoProb2hz,evoDetoSpk8hz,detoProb8hz,evoDetoSpk20hz,detoProb20hz,evoDetoSpk50hz,detoProb50hz,... % analysis_freq_detoSpike
        xptLight, yptLight, pethtimeLight, pethLight, pethConvLight, pethConvZLight, nLight, lightSpk,meanFR,... % analysis_freq_pethLight
        xpt2hz_ori, ypt2hz_ori, pethtime2hz_ori, peth2hz_ori, peth2hzConv_ori, peth2hzConvZ_ori,...
        xpt8hz_ori, ypt8hz_ori, pethtime8hz_ori, peth8hz_ori, peth8hzConv_ori, peth8hzConvZ_ori,...
        spkwv,spkwth,spkpvr,hfvwth);
    T = [T; temT];
    
%% Excel output
    temp_Txls = table(mouseLine, path, cellID);
    Txls = [Txls; temp_Txls];

    fclose('all');
end
cd(rtPath);
save(['neuronList_freq_',datestr(now,formatOut),'.mat'],'T');
writetable(Txls,['neuronList_freq_',datestr(now,formatOut),'.xlsx']);

disp('##### Done! #####');
clearvars;