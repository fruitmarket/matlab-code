function fLFP = filt_LFP(rawTrace, limits, sF)
% rawTrace: original trace
% lower_limit, upper_limit: band pass limits
% sF: sampling frequency

if nargin<3
    sF = 2000;
end
if isempty(sF) % if input variable ¡®sF¡¯ is entered as an empty vector, this provides a default 
    sF = 2000;
end
Nyquist_freq = sF/2; 
lowcut = limits(1)/Nyquist_freq; 
highcut = limits(2)/Nyquist_freq; 
filter_order = 3; % may need to be changed depending on the bandpass limits 
passband = [lowcut highcut]; 
[Bc, Ac] = butter(filter_order, passband); 
fLFP = filtfilt(Bc, Ac, rawTrace);