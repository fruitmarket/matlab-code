function lightspkratio()
% Calculate light induced spike ratio

startingDir = {'D:\Projects\Track_151029-4_Rbp6';'D:\Projects\Track_151029-5_Rbp8';'D:\Projects\Track_151213-2_Rbp14'};
% startingDir = {'D:\Projects\Track_151213-2_Rbp14'};

matFile = [];
nDir = size(startingDir,1);
for iDir = 1:nDir
    tempmatFile = FindFiles('tt*.mat','StartingDirectory',startingDir{iDir},'CheckSubdirs',1);
    matFile = [matFile; tempmatFile];
end
nFile = length(matFile);

for iFile = 1:nFile;
    [cellpath, ~, ~] = fileparts(matFile{iFile});
    cellPath{iFile,1} = cellpath;
end

cellPath = unique(cellPath);
nPath = length(cellPath);

for iPath = 1:nPath;
    cd(cellPath{iPath});
    load('Events.mat','lightTime');
    
    cellFile = FindFiles('tt*.mat','CheckSubdirs',0);
    nCell = length(cellFile);
        
    for iCell = 1:nCell
        [~, matName, ~] = fileparts(cellFile{iCell});
        load(cellFile{iCell});
        
        tagRatio = length(xptTagBlue{1})/length(lightTime.Tag);
        if ~exist('xptModuBlue')
            save([matName,'.mat'],'tagRatio','-append');
        else
            moduRatio = length(xptModuBlue{1})/length(lightTime.Modu);
            save([matName,'.mat'],'tagRatio','moduRatio','-append');
        end
    end
end

disp('### Light induced spike ratio calculation is done ! ###')
end