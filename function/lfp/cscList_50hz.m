clearvars;
rtPath = 'E:\Dropbox\SNL\P2_Track';
startingDir = {'D:\Projects\Track_170119-1_Rbp70ori50';
               'D:\Projects\Track_170109-2_Rbp72ori50';
               'D:\Projects\Track_170305-1_Rbp76ori50';
               'D:\Projects\Track_170305-2_Rbp78ori50'};

% startingDir = {'D:\Projects\Track_160417-1_Rbp32ori'};
matFile = [];
nDir = size(startingDir,1);
for iDir = 1:nDir
    tempmatFile = FindFiles('csc.mat','StartingDirectory',startingDir{iDir},'CheckSubdirs',1);
    matFile = [matFile; tempmatFile];    
end
nFile = length(matFile);

T = deal(table());
for iFile = 1:nFile
    load(matFile{iFile});

    path = matFile(iFile);
    dateSession = strsplit(matFile{iFile},{'\'});
    tetLocation = strsplit(dateSession{4},'_');
    tetLocation = categorical(cellstr(tetLocation{2}));
    fileSeg = strsplit(matFile{iFile},{'\','_'});
    cscID = iFile;    
    mouseLine = categorical(cellstr(fileSeg{5}));
    taskType = categorical(cellstr(fileSeg{9}));

%%
    m_coef_on = {m_coef_on};
    m_coef_off = {m_coef_off};
    m_power_1sec_on = {m_power_1sec_on};
    sem_power_1sec_on = {sem_power_1sec_on};
    m_power_1sec_off = {m_power_1sec_off};
    sem_power_1sec_off = {sem_power_1sec_off};
%%
    rCscSOn_raw = {rCscSOn_raw};
    rCscSOn_th = {rCscSOn_th};
    rCscSOn_sg = {rCscSOn_sg};
    rCscSOn_fg = {rCscSOn_fg};
    rCscSOn_ri = {rCscSOn_ri};
    
    meanCscSOn_raw = {meanCscSOn_raw};
    meanCscSOn_th = {meanCscSOn_th};
    meanCscSOn_sg = {meanCscSOn_sg};
    meanCscSOn_fg = {meanCscSOn_fg};
    meanCscSOn_ri = {meanCscSOn_ri};
    
    peakLocOn_th_afterOn = {peakLocOn_th_afterOn};
    peakAmpOn_th_afterOn = {peakAmpOn_th_afterOn};
    peakLocOn_th_beforeOn = {peakLocOn_th_beforeOn};
    peakAmpOn_th_beforeOn = {peakAmpOn_th_beforeOn};
    
    peakLocOn_sg_afterOn = {peakLocOn_sg_afterOn};
    peakAmpOn_sg_afterOn = {peakAmpOn_sg_afterOn};
    peakLocOn_sg_beforeOn = {peakLocOn_sg_beforeOn};
    peakAmpOn_sg_beforeOn = {peakAmpOn_sg_beforeOn};
    
    peakLocOn_fg_afterOn = {peakLocOn_fg_afterOn};
    peakAmpOn_fg_afterOn = {peakAmpOn_fg_afterOn};
    peakLocOn_fg_beforeOn = {peakLocOn_fg_beforeOn};
    peakAmpOn_fg_beforeOn = {peakAmpOn_fg_beforeOn};
    
    peakLocOn_ri_afterOn = {peakLocOn_ri_afterOn};
    peakAmpOn_ri_afterOn = {peakAmpOn_ri_afterOn};
    peakLocOn_ri_beforeOn = {peakLocOn_ri_beforeOn};
    peakAmpOn_ri_beforeOn = {peakAmpOn_ri_beforeOn};
    
    rCscSOff_raw = {rCscSOff_raw};
    rCscSOff_th = {rCscSOff_th};
    rCscSOff_sg = {rCscSOff_sg};
    rCscSOff_fg = {rCscSOff_fg};
    rCscSOff_ri = {rCscSOff_ri};
    
    meanCscSOff_raw = {meanCscSOff_raw};
    meanCscSOff_th = {meanCscSOff_th};
    meanCscSOff_sg = {meanCscSOff_sg};
    meanCscSOff_fg = {meanCscSOff_fg};
    meanCscSOff_ri = {meanCscSOff_ri};
    
    peakLocOff_th_afterOn = {peakLocOff_th_afterOn};
    peakAmpOff_th_afterOn = {peakAmpOff_th_afterOn};
    peakLocOff_th_beforeOn = {peakLocOff_th_beforeOn};
    peakAmpOff_th_beforeOn = {peakAmpOff_th_beforeOn};
    
    peakLocOff_sg_afterOn = {peakLocOff_sg_afterOn};
    peakAmpOff_sg_afterOn = {peakAmpOff_sg_afterOn};
    peakLocOff_sg_beforeOn = {peakLocOff_sg_beforeOn};
    peakAmpOff_sg_beforeOn = {peakAmpOff_sg_beforeOn};
    
    peakLocOff_fg_afterOn = {peakLocOff_fg_afterOn};
    peakAmpOff_fg_afterOn = {peakAmpOff_fg_afterOn};
    peakLocOff_fg_beforeOn = {peakLocOff_fg_beforeOn};
    peakAmpOff_fg_beforeOn = {peakAmpOff_fg_beforeOn};
    
    peakLocOff_ri_afterOn = {peakLocOff_ri_afterOn};
    peakAmpOff_ri_afterOn = {peakAmpOff_ri_afterOn};
    peakLocOff_ri_beforeOn = {peakLocOff_ri_beforeOn};
    peakAmpOff_ri_beforeOn = {peakAmpOff_ri_beforeOn};
     
    temT = table(path,cscID,taskType,tetLocation,...
        m_coef_on, m_coef_off, m_power_1sec_on, sem_power_1sec_on, m_power_1sec_off, sem_power_1sec_off,...
        meanCscSOn_raw, meanCscSOn_th, meanCscSOn_sg, meanCscSOn_fg, meanCscSOn_ri,...
        peakLocOn_th_afterOn, peakAmpOn_th_afterOn, peakLocOn_th_beforeOn, peakAmpOn_th_beforeOn,...
        peakLocOn_sg_afterOn, peakAmpOn_sg_afterOn, peakLocOn_sg_beforeOn, peakAmpOn_sg_beforeOn,...
        peakLocOn_fg_afterOn, peakAmpOn_fg_afterOn, peakLocOn_fg_beforeOn, peakAmpOn_fg_beforeOn,...
        peakLocOn_ri_afterOn, peakAmpOn_ri_afterOn, peakLocOn_ri_beforeOn, peakAmpOn_ri_beforeOn,...
        meanCscSOff_raw, meanCscSOff_th, meanCscSOff_sg, meanCscSOff_fg, meanCscSOff_ri,...
        peakLocOff_th_afterOn, peakAmpOff_th_afterOn, peakLocOff_th_beforeOn, peakAmpOff_th_beforeOn,...
        peakLocOff_sg_afterOn, peakAmpOff_sg_afterOn, peakLocOff_sg_beforeOn, peakAmpOff_sg_beforeOn,...
        peakLocOff_fg_afterOn, peakAmpOff_fg_afterOn, peakLocOff_fg_beforeOn, peakAmpOff_fg_beforeOn,...
        peakLocOff_ri_afterOn, peakAmpOff_ri_afterOn, peakLocOff_ri_beforeOn, peakAmpOff_ri_beforeOn);
    T = [T; temT];
    
%     temp_Txls = table(path, cellID, mouseLine, fileSeg(6), taskType, tetLocation,...
%         idxNeurontype,idxPeakFR,idxPlaceField,idxTotalSpikeNum,idxpLR_Track,idxZoneInOut);
%     Txls = [Txls; temp_Txls];
    fclose('all');
end
cd(rtPath);
formatOut = 'yymmdd';
save(['cscList_ori50hz_',datestr(now,formatOut),'.mat'],'T');
% writetable(Txls,['neuronList_ori50hz_',datestr(date,formatOut),'.xlsx']);
clearvars;
disp('### CSC list file is generated! ###');