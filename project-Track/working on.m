function lightDirection()
% Decide light directionality (activation / inactivation)

% Author: Jun
% Date: 

startingDir = {'D:\Projects\Track_151029-4_Rbp6';'D:\Projects\Track_151029-5_Rbp8';'D:\Projects\Track_151213-2_Rbp14'};
matFile = [];
nDir = size(startingDir,1);

% Get mat-files from the mice of interests
for iDir = 1:nDir
    tempmatFile = FindFiles('tt*.mat','StartingDirectory','startingDir{Dir}','CheckSubdirs',1);
    matFile = [matFile; tempmatFile];
end
nFile = length(matFile);

% Get cell pathes of each mat-files
for iFile = 1:nFile
    [cellpath, ~, ~] = fileparts(matFile{iFile});
    cellPath{iFile,1} = cellpath;
end

% Get each folder path
cellPath = unique(cellPath);
nPath = length(cellPath);

for iPath = 1:nPath
    cd(cellPath{iPath});
    
    cellFile = FindFiles('tt*.mat','CheckSubdirs',0);
    nCell = length(cellFile);
    
    for iCell = 1:nCell
        [~, matName, ~] = fileparts(cellFile{iCell});
        load(cellFile{iCell});
        
        if exist('xptModuBlue','var')
            moduBase1 = length(find(xptModuBlue{1}>-5 & xptModuBlue{1}<5));
            moduTest = length(find(xptModuBlue{1}>5 & xptModuBlue{1}<15));
            moduBase2 = length(find(xptModuBlue{1}>15 & xptModuBlue{1}<25));
            
            if (moduTest > moduBase1) && (moduTest > moduBase2)
                modulDir = 1; % Light activated
            elseif (moduTest < moduBase1) && (moduTest < moduBase2)
                moduDiraction = 0; % Light inhibited
            else
            moduDiraction = 2; % Random
            end
        save([matName,'.mat'],'moduDiraction','-append');
        else
        end

        tagBase1 = length(find(xptTagBlue{1}>-5 & xptTagBlue{1}<5));
        tagTest = length(find(xptTagBlue{1}>5 & xptTagBlue{1}<15));
        tagBase2 = length(find(xptTagBlue{1}>15 & xptTagBlue{1}<25));

        if (tagTest > tagBase1) && (tagTest > tagBase2)
            tagDiraction = 1;
        elseif (tagTest < tagBase1) && (tagTest < tagBase2)
            tagDiraction = 0;
        else
            tagDiraction = 2;
        end       
        save([matName,'.mat'],'tagDiraction','-append');
    end
end
    
