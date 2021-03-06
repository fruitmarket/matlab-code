function [cscTime, cscSample, cscList] = cscLoad(cscFile)
% cscLoad searches csc files and load time sample, and list of csc data
% [cscTime, cscSample, cscList] = cscLoad(cscFile)
%   outputIdx: depende on the value, it will return different types of data
%   (0: default, extract each csc files, 1: merge csc files to one file)
%   cscTime: 1D matrix array of time (unit: msec)
%   cscSample: matrix array of samples (unit: mVolt)
%   cscList: shows list of csc.ncs files
%
% Author: Joonyeup Lee (cited Dohoung Kim's code)
% Version 1.0 (Oct, 13, 2016)

if nargin == 0
    cscList = FindFiles('CSC*.ncs','CheckSubdirs',0);
else
    if ~iscell(cscFile)
        disp('Input argument is wrong. It should be cell array.');
        return;
    elseif isempty(cscFile)
        cscList = FindFiles('CSC*.ncs','CheckSubdirs',0);
    else
        nFolder = length(cscFile);
        cscList = cell(0,1);
        for iFolder = 1:nFolder
            if exist(cscFile{iFolder},'dir')
                cscList = [cscList; FindFiles('CSC*.ncs','StartingDirectory',fileparts(cscFile{iFolder}),'CheckSubdirs',0)];
            elseif exist(cscFile{iFolder},'file') == 2
                [filePath, fileName, ext] = fileparts(cscFile{iFolder});
                if strcmp(ext,'.ncs')
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
% cscSample = cell(nCSC,1);
outputIdx = 0;
switch outputIdx
    case 0 % extract each csc file
        [timestamp, cscSample] = deal(cell(nCSC,1));
        for iCSC = 1:nCSC
            [timestamp{iCSC},cscSample{iCSC}] = csc2mat(cscList{iCSC});
        end
        cscTime = cellfun(@(x) x/1000, timestamp,'UniformOutput',false); % cscTime unit: msec
    case 1 % merge all csc files to one matfile
        for iCSC = 1:nCSC
            [timestamp, cscSample(:,iCSC)] = csc2mat(cscList{iCSC});
            cscTime = timestamp/1000; % cscTime unit: msec
        end
        cscSample = mean(cscSample,2);
end