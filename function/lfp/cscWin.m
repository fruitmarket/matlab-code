function cscAligned = cscWin(cscData, cscTime, event, window)
%
% Align cscRaw data to event
% Inout
%   cscData: raw csc array
%   cscTime: csc time
%   event: event time
%   window: time window of interest, [timeStart timeEnd]
% Output
%   cscAlign: event aligned csc

idx = cellfun(@(x) find(x-cscTime<0,1,'first'),num2cell(event));
idx2 = num2cell(idx+[window(1):window(2)],2);
cscAligned = cellfun(@(x) cscData(x)',idx2,'UniformOutput',0);