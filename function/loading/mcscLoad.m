function mcscList = mcscLoad(mFile)
%mLoad loads T*.mat files
%
%   mcscList: lists of CSC*.mat files
%
%   Author: Joonyeup Lee
%   Version 1.0 (2017/4/6)
switch nargin
    case 0
        mcscList = FindFiles('CSC*.mat','CheckSubdirs',1); 
    case 1 % ex: mLoad({})
        if ~iscell(mFile) 
            disp('Input argument is wrong. It should be cell array.');
            return;
        elseif isempty(mFile)
            mcscList = FindFiles('CSC*.mat','CheckSubdirs',1);
        else
            nFolder = length(mFile);
            mcscList = cell(0,1);
            for iFolder = 1:nFolder
                if exist(mFile{iFolder},'file')
                    mcscList = [mcscList;FindFiles('CSC*.mat','StartingDirectory',fileparts(mFile{iFolder}),'CheckSubdirs',1)];
                elseif strcmp(mFile{iFolder}(end-3:end),'.mat')
                    mcscList = [mcscList;mFile{iFolder}];
                end
            end
        end
end
if isempty(mcscList)
    disp('Mat file does not exist!');
    return;
end