function x = meanFiringRate(time1, time2, spikeData)
%%%%%%
% Purpose: calculate mean firing rate of specific time period
% time1, time2 should be either vectors or array (msec unit)
% spikeData should be in millisecond unit
%
% Author: Joonyeup Lee
% Version: 1.0 (12/26/2016)
%%%%%%

narginchk(3, 3);
nTime = length(time1);
meanFR = zeros(nTime,1);

if length(time1) ~= length(time2)
    disp('Different time array! Time array should be same size.');
else
    for iTime = 1:nTime
        meanFR(iTime,1) = sum(histc(spikeData,[time1(iTime), time2(iTime)]))/(diff([time1(iTime),time2(iTime)])/1000);
    end
    x = meanFR;
end
end