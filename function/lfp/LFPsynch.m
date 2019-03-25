function [synchscore anglescore] = LFPsynch(sig1, sig2, window_time, steptime)
% [synchscore anglescore times] = LFPsynch(sig1, sig2, window_time, steptime)
%
% computes a synchronization index,
% INPUTS:
% sig1 is a 2 x n LFP matrix of the FILTERED signal [time_in_sec data]
% sig2 is a 2 x n LFP matrix of a different FILTERED signal [time_in_sec data]
% window_time (units = s) is the total time window around each timestamp over which
% to compute the synchronization index. It should be AT LEAST one cycle
% of the frequency being investigated (default is 2 cycle lengths) steptime (s) is the step for the sliding window (default is 10 ms)
%
% equation for synchronization index is the same used in Cohen 2008 (J.Neuro methods 168, 494-499)
% nei 2/13
%

if nargin < 4
steptime = 0.01;
if nargin < 3
window_time = []; % we will correct this in a moment
end
end
if window_time > 100
    error('time units are in seconds, >100 s is not permited')
end
timestep = nanmean(diff(sig1(:,1)));
ms10step = round(steptime/timestep);
sig1hil = hilbert(sig1(:,2));
sig1phase = atan2(imag(sig1hil), (real(sig1hil)));
sig2hil = hilbert(sig2(:,2));
sig2phase = atan2(imag(sig2hil), (real(sig2hil)));
clear sig1hil sig2hil % we don't need these anymore

if isempty(window_time)
    window_length = 2 * floor((2*pi)/nanmedian(diff(sig2phase))); %default to 2 cycle lengths
else
    window_length = round(window_time/timestep);
end
anglediff = circ_dist(sig1phase, sig2phase);
exanglediff = exp(1i*anglediff);

B_t = buffer(sig1(:,1), window_length, window_length - ms10step); %we vectorize the sliding window algorithm to make it fast and efficient
B_ead = buffer(exanglediff, window_length, window_length - ms10step);
timevec = nanmean(B_t(:,floor(window_length/ms10step):end-1)); % we remove the final sample to keep the time-step consistent
EADvec = nanmean(B_ead(:,floor(window_length/ms10step):end-1));
if ~issorted(timevec) % occasionally, the recording system stalls or fails to apply the correct timestamps to the data.
    [a b] = sort(timevec); %since we don't know if it is just a problem with the timestamps, or the data itself, we eliminate those bins entirely
    badsamps = find(diff(b) ~= 1);
    sampnums = setdiff(1:length(timevec), badsamps+1);
else
    sampnums = 1:length(timevec);
end
synchscore = [timevec(sampnums)' abs(EADvec(sampnums))'];
anglescore = [timevec(sampnums)' angle(EADvec(sampnums))'];