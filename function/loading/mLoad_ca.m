function mList = mLoad_ca(mFile)
%mLoad loads T*.mat files
%
%   mList: lists of neuron_*.mat files
%   Load Ca-imaging results
%
%   Author: Dohoung Kim
%   Version 1.0 (2016/1/13)
switch nargin
    case 0
        mList = FindFiles('neuron*.mat','CheckSubdirs',1); 
    case 1 % ex: mLoad({})
        if ~iscell(mFile) 
            disp('Input argument is wrong. It should be cell array.');
            return;
        elseif isempty(mFile)
            mList = FindFiles('neuron*.mat','CheckSubdirs',1);
        else
            nFolder = length(mFile);
            mList = cell(0,1);
            for iFolder = 1:nFolder
                if exist(mFile{iFolder},'file')
                    mList = [mList;FindFiles('neuron*.mat','StartingDirectory',fileparts(mFile{iFolder}),'CheckSubdirs',1)];
                elseif strcmp(mFile{iFolder}(end-3:end),'.mat')
                    mList = [mList;mFile{iFolder}];
                end
            end
        end
end
if isempty(mList)
    disp('Mat file does not exist!');
    return;
end