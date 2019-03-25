clearvars;
rtPath = 'E:\Dropbox\Lab_mwjung\P4_FamiliarNovel';
startingDir = {'E:\Data\Track_rbp003_170905-10\familiar';
               'E:\Data\Track_rbp004_171127-1\familiar';
               'E:\Data\Track_rbp005_171127-3\familiar'; % CA3a 
               'E:\Data\Track_rbp006_171127-5\familiar';
               'E:\Data\Track_rbp013_180423-7\familiar';
               'E:\Data\Track_rbp014_180423-13\familiar';
               'E:\Data\Track_rbp015_180424-5\familiar'};
%                'E:\Data\Track_rbp011_180406-2\familiar';

matFile = [];
nDir = size(startingDir,1);
for iDir = 1:nDir
    tempmatFile = FindFiles('Events.mat','StartingDirectory',startingDir{iDir},'CheckSubdirs',1);
    matFile = [matFile; tempmatFile];    
end
nFile = length(matFile);
T = table();
for iFile = 1:nFile
    load(matFile{iFile});

    behaviorID = iFile;
    path = matFile(iFile);
    dateSession = strsplit(matFile{iFile},{'\'});
    tetLocation = strsplit(dateSession{5},'_');
    tetLocation = categorical(cellstr(tetLocation{2}));
    fileSeg = strsplit(matFile{iFile},{'\','_'});
    
    % analysis_behaviorTrack
    timeLap = {timeLap};
    m_timeLap = {m_timeLap};
    p_KW_Behav_detail = {p_KW_Behav_detail};
    timeInZone = {timeInZone};
    sum_timeZone = {sum_timeZone};
    
    temp_T = table(path, behaviorID, timeLap, m_timeLap, p_KW_Behav_detail, p_KW_Behav_main, timeInZone, sum_timeZone);
    T = [T; temp_T];
    
    fclose('all');
end
cd(rtPath);
formatOut = 'yymmdd';
save(['behaviorList_familiar_',datestr(now,formatOut),'.mat'],'T');