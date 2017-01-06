clearvars;

xlsList = FindFiles('*.xls');
nFile = length(xlsList);
T = table();

cellCount = zeros(nFile,1);

for iFile = 1:nFile
    [filePath, fileName, ext] = fileparts(xlsList{iFile});
    disp(['### Analyzing ', xlsList{iFile}, '...']);
    cd(filePath);
    
    xlsTable = readtable([fileName, ext]);
    fileSeg = strsplit(fileName,{'_'});
    
    mouseID = categorical(cellstr(fileSeg{1}));
    sliceID = categorical(cellstr(fileSeg{2}));
    nSlice = length(xlsTable.eYFP(~isnan(xlsTable.eYFP)));
    num_eYFP = xlsTable.eYFP(1);
    num_DAPI = xlsTable.TotalGC(1);
    density = xlsTable.Density(1);
    eYFPratio = xlsTable.Expression(1);
        
    tempT = table(mouseID, sliceID, nSlice, num_eYFP, num_DAPI, density, eYFPratio);
    T = [T; tempT];
    fclose('all');
end

mice = unique(T.mouseID);
nMice = length(mice);
eYFPmeanMice = zeros(nMice,1);

for iMice = 1:nMice
    eYFPmeanMice(iMice,1) = mean(T.eYFPratio(T.mouseID == mice(iMice)));   
end
eYFPmeanTotal = mean(eYFPmeanMice);
eYFPstdTotal = std(eYFPmeanMice);

save('eYFPexpression','T','eYFPmeanMice','eYFPmeanTotal','eYFPstdTotal');