function spikeTime = spikePeriod(spikeData, timeStart, timeEnd)
% spikePeriod finds spikes between two different time points
% spikeData: rad data from MClust. Unit must be ms.
% timeStart, timeEnd: intereseted time point. Unit must be ms.
narginchk(3,3);

if isempty(timeStart) | isempty(timeEnd); spikeTime = []; return; end;
if length(timeStart) ~= length(timeEnd)
    error('Error: timeStart and timeEnd must be same size');
end

nPeriod = size(timeStart);
spikeTime = cell(nPeriod);
for iPeriod = 1:nPeriod
    spikeTime{iPeriod} = spikeData(timeStart(iPeriod) <= spikeData & spikeData <= timeEnd(iPeriod));
end