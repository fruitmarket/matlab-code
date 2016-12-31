xlsList = FindFiles('*.xls');
nFile = length(xlsList);
cellCount = zeros(nFile,1);

for iFile = 1:nFile
    [filePath, fileName, ext] = fileparts(xlsList{iFile});
    disp(['### Analyzing ', xlsList{iFile}, '...']);
    cd(filePath);
    
    xlsTable = readtable([fileName, ext]);
    cellCount(iFile,1) = xlsTable.Type1;
end

sliceExp = mean(cellCount);

save('sliceExp.mat','sliceExp');