function cscNum = selectCSC()
% function [cscNum] = selectCSC()
% Select a csc file for analysis (largest number of neurons recorded TT)
%
%

[~, tList] = tLoad;
[~,tName,~] = cellfun(@fileparts,tList,'UniformOutput',false);
temp_tetNum = cellfun(@(x) str2double(x(3)),tName);
tetNum = [unique(temp_tetNum)', histc(temp_tetNum,unique(temp_tetNum))'];
[~,tetIdx] = max(tetNum(:,2));
cscNum = tetNum(tetIdx,1);
end