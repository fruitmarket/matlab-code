% startingDir = {'D:\Projects\Track_151029-4_Rbp6';'D:\Projects\Track_151029-5_Rbp8';'D:\Projects\Track_151213-2_Rbp14'};
startingDir = {'D:\Projects\Track_151029-5_Rbp8'};

matFile = [];
nDir = size(startingDir,1);
for iDir = 1:nDir
    tempmatFile = FindFiles('tt*.mat','StartingDirectory',startingDir{iDir},'CheckSubdirs',1);
    matFile = [matFile; tempmatFile];    
end
nCell = length(matFile);

for iCell = 1:nCell
    [cellpath, ~, ~] = fileparts(matFile{iCell});
    cellPath{iCell,1} = cellpath;
end

cellPath = unique(cellPath);
nPath = length(cellPath);

for iPath = 1:nPath
    cd(cellPath{iPath});
    allstep;
end
