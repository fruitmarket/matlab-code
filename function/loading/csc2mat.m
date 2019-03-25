function [timestamp, sample] = csc2mat(fileName)
% csc2mat convert ncs files to mat files
%
%   timestamp: timestamp (rearranged by recording sessions, usec unit)
%   sample: csc samples (mVolt unit)
%
%   Author: Junyeop Lee
%   Version 1.0 (Oct/12/2016)
%   Revised (Jul/17/2018)

% Import csc data
voltageConvFactor = 10^3; % 1 means output in volts, 1000 in mV, 10^6 in uV
[timestamps_ori, ~, ~, ~, sample, header] = Nlx2MatCSC(fileName, [1,1,1,1,1],1,1,[]);
% [timeStamps, channelNumbers, sampleFreq, numberofValidSamples, samples, header] = Nlx2MatCSC(fileName, [1,1,1,1,1],1,1,[]);
% numberofValidSamples: 512
% sampling frequency is 2000 Hz;
sample = sample(:);

% ADBitVolts correction
voltIdx = regexp(header,'-ADBitVolts');
voltTemp = strsplit(header{(~cellfun(@isempty,voltIdx))},' ');
bitVolt = str2double(voltTemp{2});

sample = sample(:)*bitVolt*voltageConvFactor; % unit: mVolt

idxRecStart = [1,find(diff(timestamps_ori)>256000)+1]';
nRec = length(idxRecStart);
timestamp = [];
for iRec = 1:nRec-1
    tempTime = timestamps_ori(idxRecStart(iRec))+[0:(512*(idxRecStart(iRec+1)-idxRecStart(iRec))-1)]*500;
    timestamp = [timestamp, tempTime];
end
tempTime = timestamps_ori(idxRecStart(end))+[0:512*(length(timestamps_ori)-idxRecStart(end)+1)-1]*500;
timestamp = [timestamp, tempTime]';
end