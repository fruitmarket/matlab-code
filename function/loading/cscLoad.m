function [cscTime, cscSample, cscList] = cscLoad(cscFile)
% vtLoad searches vt files and load time and position data
%
%   vtTime: cell array of timestamp
%   vtPosition: cell array of position
%   Units in milisecond
%   vtList: shows list of VT1.nvt files
%
% Author: Junyeop Lee (cited Dohoung Kim's code)
% 

if nargin == 0;
    cscList = FindFiles('CSC*.ncs','CheckSubdirs',1);
else
    if ~iscell(cscFile)
        disp('Input argument is wrong. It should be cell array.');
        return;
    elseif isempty(cscFile)
        cscList = FindFiles('CSC*.ncs','CheckSubdirs',1);
    else
        nFolder = length(cscFile);
        cscList = cell(0,1);
        for iFolder = 1:nFolder
            if exist(cscFile{iFolder},'dir')
                cscList = [cscList; FindFiles('CSC*.ncs','StartingDirectory',fileparts(cscFile{iFolder}),'CheckSubdirs',1)];
            elseif exist(cscFile{iFolder},'file') == 2
                [filePath, fileName, ext] = fileparts(cscFile{iFolder});
                if strcmp(ext,'.csc')
                    cscList = [cscList; cscFile{iFolder}];
                end
            end
        end
    end
end
if isempty(cscList)
    disp('csc file does not exist!');
    [cscTime, cscSample, cscList] = deal([]);
    return;
end
cscList = unique(cscList);
nCSC = length(cscList);

cscTime = cell(nCSC,1);
cscSample = cell(nCSC,1);

for iCSC = 1:nCSC
    [timestamp, sample] = csc2mat(cscList{iCSC});
    cscTime{iCSC} = timestamp/1000; % cscTime unit: msec
    cscSample{iCSC} = sample;
end
end
