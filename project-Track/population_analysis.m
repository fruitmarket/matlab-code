load cellList.mat
totalT = T;

% DRun & 100% 
sessRun = (totalT.taskType == 'DRun') & (totalT.taskProb == '100');
% sessRun = (totalT.taskType == 'DRun') & (totalT.taskProb == '50');
% sessRun = (totalT.taskType == 'DRun') & (totalT.taskProb == '25');
% sessRun = (totalT.taskType == 'DRun') & (totalT.taskProb == '10');
 
% DRw % 100%
sessRw = (totalT.taskType == 'DRw') & (totalT.taskProb == '100');
 
% Nolight & 100%
sessNo = (totalT.taskType == 'nolight') & (totalT.taskProb == '100');

%% DRun & 100 %
cellList = totalT.Path(sessRun);
nFile = length(cellList);

T = table();

for iFile = 1:nFile
    load(cellList{iFile},'fr_base','fr_task','burstIdx','spkwv','spkwth','hfvwth','p_tag','p_modu','p_CorrInter','p_CorrIntra','r_CorrInter','r_CorrIntra','tagRatio','moduRatio');
    fileSeg = strsplit(cellList{iFile},{'\','_'});
    mouseLine = categorical(cellstr(fileSeg{5}));
    taskType = categorical(cellstr(fileSeg{9}));
    taskProb = categorical(cellstr(fileSeg{10}));
    
       
    temT = table(mouseLine,taskType,cellList(iFile),taskProb,fr_base,fr_task,burstIdx,{spkwv},spkwth,hfvwth,p_tag,p_modu,p_CorrInter,p_CorrIntra,r_CorrInter,r_CorrIntra,tagRatio,moduRatio,...
        'VariableNames',{'mouseLine','taskType','Path','taskProb','fr_base','fr_task','burstIdx','spkwv','spkwth','hfwth','p_tag','p_modu','p_CorrInter','p_CorrIntra','r_CorrInter','r_CorrIntra','tagRatio','moduRatio'});
    
    T = [T; temT];
end

save('cellList_DRun.mat','T');
clear T cellList nFile;

%% DRw & 100%
cellList = totalT.Path(sessRw);
nFile = length(cellList);

T = table();

for iFile = 1:nFile
    load(cellList{iFile},'fr_base','fr_task','burstIdx','spkwv','spkwth','hfvwth','p_tag','p_modu','p_CorrInter','p_CorrIntra','r_CorrInter','r_CorrIntra','tagRatio','moduRatio');
    fileSeg = strsplit(cellList{iFile},{'\','_'});
    mouseLine = categorical(cellstr(fileSeg{5}));
    taskType = categorical(cellstr(fileSeg{9}));
    taskProb = categorical(cellstr(fileSeg{10}));
    
       
    temT = table(mouseLine,taskType,cellList(iFile),taskProb,fr_base,fr_task,burstIdx,{spkwv},spkwth,hfvwth,p_tag,p_modu,p_CorrInter,p_CorrIntra,r_CorrInter,r_CorrIntra,tagRatio,moduRatio,...
        'VariableNames',{'mouseLine','taskType','Path','taskProb','fr_base','fr_task','burstIdx','spkwv','spkwth','hfwth','p_tag','p_modu','p_CorrInter','p_CorrIntra','r_CorrInter','r_CorrIntra','tagRatio','moduRatio'});
    
    T = [T; temT];
end
save('cellList_DRw.mat','T');
clear T cellList nFile;

%% Nolight & 100 %
cellList = totalT.Path(sessNo);
nFile = length(cellList);

T = table();

for iFile = 1:nFile
    load(cellList{iFile},'fr_base','fr_task','burstIdx','spkwv','spkwth','hfvwth','p_tag','p_modu','p_CorrInter','p_CorrIntra','r_CorrInter','r_CorrIntra','tagRatio','moduRatio');
    fileSeg = strsplit(cellList{iFile},{'\','_'});
    mouseLine = categorical(cellstr(fileSeg{5}));
    taskType = categorical(cellstr(fileSeg{9}));
    taskProb = categorical(cellstr(fileSeg{10}));
    
       
    temT = table(mouseLine,taskType,cellList(iFile),taskProb,fr_base,fr_task,burstIdx,{spkwv},spkwth,hfvwth,p_tag,p_modu,p_CorrInter,p_CorrIntra,r_CorrInter,r_CorrIntra,tagRatio,moduRatio,...
        'VariableNames',{'mouseLine','taskType','Path','taskProb','fr_base','fr_task','burstIdx','spkwv','spkwth','hfwth','p_tag','p_modu','p_CorrInter','p_CorrIntra','r_CorrInter','r_CorrIntra','tagRatio','moduRatio'});
    
    T = [T; temT];
end
save('cellList_Nolight.mat','T');
clear T cellList nFile;