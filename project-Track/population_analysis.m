load cellList.mat
totalT = T;

% DRun & 100% 
% sessRun = (totalT.taskType == 'DRun') & (totalT.taskProb == '100');
% sessRun = (totalT.taskType == 'DRun') & (totalT.taskProb == '50');
% sessRun = (totalT.taskType == 'DRun') & (totalT.taskProb == '25');
sessRun = (totalT.taskType == 'DRun') & (totalT.taskProb == '10');
 
% DRw % 100%
% sessRw = (totalT.taskType == 'DRw') & (totalT.taskProb == '100');
% sessRw = (totalT.taskType == 'DRw') & (totalT.taskProb == '50');
% sessRw = (totalT.taskType == 'DRw') & (totalT.taskProb == '25');
sessRw = (totalT.taskType == 'DRw') & (totalT.taskProb == '10');

% Nolight & 100%
% sessNo = (totalT.taskType == 'nolight') & (totalT.taskProb == '100');
% sessNo = (totalT.taskType == 'nolight') & (totalT.taskProb == '50');
% sessNo = (totalT.taskType == 'nolight') & (totalT.taskProb == '25');
sessNo = (totalT.taskType == 'nolight') & (totalT.taskProb == '10');

%% DRun & 100 %
cellList = totalT.Path(sessRun);
nFile = length(cellList);

T = table();

for iFile = 1:nFile
    load(cellList{iFile},'fr_base','fr_task','burstIdx','spkwv','spkwth','hfvwth','p_tag','p_modu','p_saltTag','p_saltModu','tagRatio','moduRatio','ntagLightspk','nmoduLightspk',...
        'r_Corrbfxaft','r_Corrbfxdr','r_Corrdrxaft','r_Corrhfxhf','p_Corrbfxaft','p_Corrbfxdr','p_Corrdrxaft','p_Corrhfxhf');
    fileSeg = strsplit(cellList{iFile},{'\','_'});
    mouseLine = categorical(cellstr(fileSeg{5}));
    taskType = categorical(cellstr(fileSeg{9}));
    taskProb = categorical(cellstr(fileSeg{10}));
       
    temT = table(mouseLine,taskType,cellList(iFile),taskProb,fr_base,fr_task,burstIdx,{spkwv},spkwth,hfvwth,p_tag,p_modu,p_saltTag,p_saltModu,tagRatio,moduRatio,ntagLightspk,nmoduLightspk,...
        r_Corrbfxaft,r_Corrbfxdr,r_Corrdrxaft,r_Corrhfxhf,p_Corrbfxaft,p_Corrbfxdr,p_Corrdrxaft,p_Corrhfxhf,...
        'VariableNames',{'mouseLine','taskType','Path','taskProb','fr_base','fr_task','burstIdx','spkwv','spkwth','hfwth','p_tag','p_modu','p_saltTag','p_saltModu','tagRatio','moduRatio','ntagLightspk','nmoduLightspk',...
        'r_Corrbfxaft','r_Corrbfxdr','r_Corrdrxaft','r_Corrhfxhf','p_Corrbfxaft','p_Corrbfxdr','p_Corrdrxaft','p_Corrhfxhf'});
    
    T = [T; temT];
end

save(['cellList_DRun_10.mat'],'T');
clear T cellList nFile;

%% DRw & 100%
cellList = totalT.Path(sessRw);
nFile = length(cellList);

T = table();

for iFile = 1:nFile
    load(cellList{iFile},'fr_base','fr_task','burstIdx','spkwv','spkwth','hfvwth','p_tag','p_modu','p_saltTag','p_saltModu','tagRatio','moduRatio','ntagLightspk','nmoduLightspk',...
        'r_Corrbfxaft','r_Corrbfxdr','r_Corrdrxaft','r_Corrhfxhf','p_Corrbfxaft','p_Corrbfxdr','p_Corrdrxaft','p_Corrhfxhf');
    fileSeg = strsplit(cellList{iFile},{'\','_'});
    mouseLine = categorical(cellstr(fileSeg{5}));
    taskType = categorical(cellstr(fileSeg{9}));
    taskProb = categorical(cellstr(fileSeg{10}));
       
    temT = table(mouseLine,taskType,cellList(iFile),taskProb,fr_base,fr_task,burstIdx,{spkwv},spkwth,hfvwth,p_tag,p_modu,p_saltTag,p_saltModu,tagRatio,moduRatio,ntagLightspk,nmoduLightspk,...
        r_Corrbfxaft,r_Corrbfxdr,r_Corrdrxaft,r_Corrhfxhf,p_Corrbfxaft,p_Corrbfxdr,p_Corrdrxaft,p_Corrhfxhf,...
        'VariableNames',{'mouseLine','taskType','Path','taskProb','fr_base','fr_task','burstIdx','spkwv','spkwth','hfwth','p_tag','p_modu','p_saltTag','p_saltModu','tagRatio','moduRatio','ntagLightspk','nmoduLightspk',...
        'r_Corrbfxaft','r_Corrbfxdr','r_Corrdrxaft','r_Corrhfxhf','p_Corrbfxaft','p_Corrbfxdr','p_Corrdrxaft','p_Corrhfxhf'});
    
    T = [T; temT];
end

save(['cellList_DRw_10.mat'],'T');
clear T cellList nFile;

%% Nolight & 100 %
cellList = totalT.Path(sessNo);
nFile = length(cellList);

T = table();

for iFile = 1:nFile
    load(cellList{iFile},'fr_base','fr_task','burstIdx','spkwv','spkwth','hfvwth','p_tag','p_modu','p_saltTag','p_saltModu','tagRatio','moduRatio','ntagLightspk','nmoduLightspk',...
        'r_Corrbfxaft','r_Corrbfxdr','r_Corrdrxaft','r_Corrhfxhf','p_Corrbfxaft','p_Corrbfxdr','p_Corrdrxaft','p_Corrhfxhf');
    fileSeg = strsplit(cellList{iFile},{'\','_'});
    mouseLine = categorical(cellstr(fileSeg{5}));
    taskType = categorical(cellstr(fileSeg{9}));
    taskProb = categorical(cellstr(fileSeg{10}));
       
    temT = table(mouseLine,taskType,cellList(iFile),taskProb,fr_base,fr_task,burstIdx,{spkwv},spkwth,hfvwth,p_tag,p_modu,p_saltTag,p_saltModu,tagRatio,moduRatio,ntagLightspk,nmoduLightspk,...
        r_Corrbfxaft,r_Corrbfxdr,r_Corrdrxaft,r_Corrhfxhf,p_Corrbfxaft,p_Corrbfxdr,p_Corrdrxaft,p_Corrhfxhf,...
        'VariableNames',{'mouseLine','taskType','Path','taskProb','fr_base','fr_task','burstIdx','spkwv','spkwth','hfwth','p_tag','p_modu','p_saltTag','p_saltModu','tagRatio','moduRatio','ntagLightspk','nmoduLightspk',...
        'r_Corrbfxaft','r_Corrbfxdr','r_Corrdrxaft','r_Corrhfxhf','p_Corrbfxaft','p_Corrbfxdr','p_Corrdrxaft','p_Corrhfxhf'});
    
    T = [T; temT];
end
save(['cellList_Nolight_10.mat'],'T');
clear T cellList nFile;