function idxTarget = time2idxTime(cscTime, vtTime, timePeriod)
% time interchanger

% output
% idxTarget: column vector, index for time based on vtTime.

% inputs
% cscTime, vtTime should be arrays.
% timePeriod: [start end] of time of interest

% joonyeup Lee (Jul/17/2018)

[~, ~, idxTime] = histcounts(cscTime, length(vtTime));

idxPeriod = timePeriod(1) <= cscTime & cscTime <= timePeriod(2);
idxTarget = idxTime(idxPeriod);
end