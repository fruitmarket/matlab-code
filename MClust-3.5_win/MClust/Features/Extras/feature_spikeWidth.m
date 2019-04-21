function [SWData, SWNames, SWPars] = feature_SpikeWidth(V, ttChannelValidity, Params)

% MClust
%
% ADR April 1998
% Status: PROMOTED (Release version) 
% See documentation for copyright (owned by original authors) and warranties (none!).
% This code released as part of MClust 3.0.
% Version control M3.0.


sw = SpikeWidth(V);
[nSpikes, nCh, nSamp] = size(Data(V));
f = find(ttChannelValidity);

SWData = zeros(nSpikes, length(f));
SWNames = cell(length(f), 1);
SWPars = {};

for iCh = 1:length(f)
   SWData(:, iCh) = sw(:,f(iCh)) + rand(size(sw(:,f(iCh))))-0.5;
   SWNames{iCh} = ['spikeWidth: ' num2str(f(iCh))];
end