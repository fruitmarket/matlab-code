[xlsFile] = FindFiles('*.xls');
nFile = length(xlsFile);
mice = zeros(nFile,1);


for iFile = 1:nFile
    [filePath, fileName, ext] = fileparts(xlsFile{iFile});
    
    disp(['### Analyzing ', xlsFile{iFile}, '...']);
    cd(filePath);
    
    slide = zeros(1,3);
    rawData = readtable([fileName,ext]);
    
    for iSlide = 1:4;
        slide(iSlide) = (rawData.Area(4*iSlide-2,1)+rawData.Area(4*iSlide,1)) / (rawData.Area(4*iSlide-3,1)+rawData.Area(4*iSlide-1,1));
    end
    mice(iFile) = mean(slide);
end

idx = logical([0,1,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1]');

areaMean = mean(mice(idx));
areaSEM = std(mice(idx))/sqrt(size(mice(idx),1));

% save('AreaCamk2a.mat',...
%     'areaMean','areaSEM');