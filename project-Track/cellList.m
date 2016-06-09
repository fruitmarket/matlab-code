clearvars;

startingDir = {'D:\Projects\Track_151029-4_Rbp6';'D:\Projects\Track_151029-5_Rbp8'};

matFile = [];
nDir = size(startingDir,1);
for iDir = 1:nDir
    tempmatFile = FindFiles('tt*.mat','StartingDirectory',startingDir{iDir},'CheckSubdirs',1);
    matFile = [matFile; tempmatFile];    
end
nFile = length(matFile);

T = table();
for iFile = 1:nFile
    load(matFile{iFile},'fr_base','fr_task','burstIdx','spkwv','spkwth','hfvwth');
    fileSeg = strsplit(matFile{iFile},{'\','_'});
    mouseLine = categorical(cellstr(fileSeg{5}));
    taskType = categorical(cellstr(fileSeg{9}));
    taskProb = categorical(cellstr(fileSeg{10}));
       
    temT = table(mouseLine,taskType,{matFile(iFile)},taskProb,fr_base,fr_task,burstIdx,{spkwv},spkwth,hfvwth,p_tag,p_Modu,...
        'VariableNames',{'mouseLine','taskType','Path','taskProb','fr_base','fr_task','burstIdx','spkwv','spkwth','hfwth','p_tag','p_Modu'});
    
    T = [T; temT];
    
end

save('cellList.mat','T');