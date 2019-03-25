function mList = mLoad_csc(mFile)
%mLoad loads csc.mat files
%
%   mList: lists of csc.mat files
%
switch nargin
    case 0
        mList = FindFiles('csc.mat','CheckSubdirs',1); 
    case 1 % ex: mLoad({})
        if ~iscell(mFile) 
            disp('Input argument is wrong. It should be cell array.');
            return;
        elseif isempty(mFile)
            mList = FindFiles('csc.mat','CheckSubdirs',1);
        else
            nFolder = length(mFile);
            mList = cell(0,1);
            for iFolder = 1:nFolder
                if exist(mFile{iFolder},'file')
                    mList = [mList;FindFiles('csc.mat','StartingDirectory',fileparts(mFile{iFolder}),'CheckSubdirs',1)];
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