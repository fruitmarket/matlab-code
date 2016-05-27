clearvars;

matFile = FindFiles('tt*.mat','CheckSubdirs',1);
nFile = length(matFile);
T = table();

for iFile = 1:nFile
    load(matFile{iFile},'fr_base','fr_task','spkwv','spkwth','hfvwth');
    fileSeg = strsplit(matFile{iFile},{'\','_'});
    valueSetLine = {'Rbp6'};
    valueSetType = {'DRun','DRw','nolight'};
    mouseLine = categorical(cellstr(fileSeg{5}));
    taskType = categorical(cellstr(fileSeg{9}));
       
    temT = table(mouseLine,taskType,{matFile(iFile)},fr_base,fr_task,{spkwv},spkwth,hfvwth,...
        'VariableNames',{'mouseLine','taskType','Path','fr_base','fr_task','spkwv','spkwth','hfwth'});
    
    T = [T; temT];
    
end


