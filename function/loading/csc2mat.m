function [timestamp, sample] = csc2mat(fileName)
% csc2mat convert ncs files to mat files
%
%   timestamp: timestamp (rearranged by recording sessions, usec unit)
%   sample: csc samples (mVolt unit)
%
%   Author: Junyeop Lee
%   Version 1.0 (Oct/12/2016)

% Import csc data
voltageConvFactor = 10^3; % 1 means output in volts, 1000 in mV, 10^6 in uV
[timestamps_ori, ~, ~, ~, sample, header] = Nlx2MatCSC(fileName, [1,1,1,1,1],1,1,[]);
% [timeStamps, channelNumbers, sampleFreq, numberofValidSamples, samples, header] = Nlx2MatCSC(fileName, [1,1,1,1,1],1,1,[]);
% numberofValidSamples: 512
sample = sample(:);

% ADBitVolts correction
voltIdx = regexp(header,'-ADBitVolts');
voltTemp = strsplit(header{(~cellfun(@isempty,voltIdx))},' ');
bitVolt = str2double(voltTemp{2});

sample = sample(:)*bitVolt*voltageConvFactor; % unit: uVolt

% timestamps rearrange
dT = diff(timestamps_ori);
idx = find(dT > 256000);

switch length(idx)+1
    case 2
        disp('Check the recording note!');
    case 3 % three sessions
        subtime1 = timestamps_ori(1)+(0:(512*idx(1)-1))*500;
        subtime2 = timestamps_ori(idx(1)+1)+(0:(512*(idx(2)-idx(1))-1))*500;
        subtime3 = timestamps_ori(idx(2)+1)+(0:(512*(length(timestamps_ori)-idx(2))-1))*500;
        timestamp = [subtime1';subtime2';subtime3'];
    case 4 % four sessions
        subtime1 = timestamps_ori(1)+(0:(512*idx(1)-1))*500;
        subtime2 = timestamps_ori(idx(1)+1)+(0:(512*(idx(2)-idx(1))-1))*500;
        subtime3 = timestamps_ori(idx(2)+1)+(0:(512*(idx(3)-idx(2))-1))*500;
        subtime4 = timestamps_ori(idx(3)+1)+(0:(512*(length(timestamps_ori)-idx(3))-1))*500;
        timestamp = [subtime1';subtime2';subtime3';subtime4'];
end
end
