clc; clearvars; close all;
%% Raw trace
rng(12)
noiselfp = rand(1,4001);
LFP_6to10 = filt_LFP(noiselfp,[6,10],2000);
LFP_16to20 = filt_LFP(noiselfp,[16,20],2000);
LFP_6to10_16to20 = [LFP_6to10 LFP_16to20];
% f1 = figure('name', 'Sample raw data');
% plot(linspace(0,4,8002),LFP_6to10_16to20)

%% Moving window method
window = 1000; % the length of 500 ms of signal, which we will use for our window
noverlap = 800;  % the amount of overlap from one window to the next. increments: 200 samples (=100ms)
F = [1:40]; % the frequencies we compute the spectral data with
Fs = 2000; % our sampling frequency
[S F T] = spectrogram(LFP_6to10_16to20,window,noverlap,F,Fs);

f2 = figure('name','Sliding window Fourier analysis');
tf_image = imagesc(abs(S)); % absolute value abs(S) will give us the signal power
set(tf_image, 'XData',[0 4], 'YData',[1 40]);
f2a = get(f2,'CurrentAxes');
set(f2a,'XLim',[0,4],'YLim',[1.5 40.5]);

%% Wavelet method
F = [2:2:40];
coefsi = cwt(LFP_6to10_16to20,centfrq('cmor1-1.5')*Fs./F,'cmor1-1.5'); % default
% coefsi = cwt(LFP_6to10_16to20,'bump',Fs);
% coefsi = cwt(LFP_6to10_16to20,centfrq('morl')*Fs./F,'morl');
% freq = scal2frq(Fs,'amor',1/Fs);
% coefsi = cwt(LFP_6to10_16to20,'amor',Fs);
% coefsi = cwt(LFP_6to10_16to20,'morse',Fs);

f3 = figure('name','Morlet wavelet analysis');
wm_image = imagesc(abs(coefsi));
set(wm_image, 'XData',[0 4], 'YData',[1 40]);
f3a = get(f3,'CurrentAxes');
set(f3a,'XLim',[0,4],'YLim',[1.5 40.5],'YDir','reverse');

% %% Hilbert transform
% % Hilbert transform is most useful if the data is already filtered.
% LFP_6to10_post = filt_LFP(LFP_6to10_16to20,6,10,2000); % filter data [6 10] Hz
% h_LFP6to10_post = hilbert(LFP_6to10_post); % hilbert transform
% amp_LFP6to10_post = abs(h_LFP6to10_post); % amplitude
% f4 = figure('name','Hilbert transform');
% subplot(2,1,1);
% plot(linspace(0,4,8002),LFP_6to10_post);
% hold on;
% plot(linspace(0,4,8002),amp_LFP6to10_post,'r:','LineWidth',2); % amplitude part
% subplot(2,1,2);
% plot(linspace(0,4,8002),LFP_6to10_post,'b');
% hold on;
% phs = atan2(imag(h_LFP6to10_post),real(h_LFP6to10_post));
% plotyy(linspace(0,4,8002),LFP_6to10_post,linspace(0,4,8002),phs); % plotyy allows us to overlay two plots with different axes
% 
% %% Coherence (Magnitude squared coherence, ~= phase synchrony)
% % magnitude squared coherence begins with a computation of the cross-spectral density: we square the real component of one signal,
% % the imaginary component of the other, and add them together. We then normalize the cross-spectral density by the spectral density
% % of each respoective signal.
% % Frequency band is not important (no filtering required)
% % Based on Fourier transform --> temporal resolution issues (between frequency and temporal resolution)
% % windowing & multi-taper methods can be applied to coherence methods to improve the accuracy of the Fourier transform.
% 
% LFPtime = [0:0.0005:2];
% LFP2Hz8Hz_A = sin(2*pi*2*LFPtime)+0.5*sin(2*pi*8*LFPtime); % signal 1
% LFP2Hz8HZ_B = sin(2*pi*2*LFPtime)+0.5*cos(2*pi*8*LFPtime); % signal 2
% f5 = figure('name','Coherence','numberTitle','off');
% subplot(2,1,1);
% hCor(1) = plot(LFPtime,LFP2Hz8Hz_A);
% hold on;
% hCor(2) = plot(LFPtime,LFP2Hz8HZ_B,'r');
% 
% [Cxy, F] = mscohere(LFP2Hz8Hz_A,LFP2Hz8HZ_B,length(LFP2Hz8Hz_A),0,[],2000); % Use default value for the NFFT variable. It is same to NFFT = 2^(nextpowe2(length(LFP2Hz8Hz_A)));
% subplot(2,1,2);
% hCor(3) = plot(F(1:40),Cxy(1:40)); % plot first 40 output terms (1 to 20Hz);
% set(gca,'YLim',[-2,2],'YTick',[-2,0,2]);
% 
% %% Phase synchrony (filter the two signals and then compute the moment-to-moment phase differences between them).
% % 1. Apply bandpass filter over the signal
% % 2. Apply Hilber transformation (to generate new time series of instantaneous phase or amplitude)
% % 3. Subtracting the two time series of instantaneous phase yield a new time series of phase differences. 
% % The consistency across phases can be computed at each point using a sliding window (the length of which should
% % be at least larger than one cycle of the frequency).
% %
% % In general, the more that the elements making-up a signal are capable of behaving independently from one-another,
% % the more coherence between signals will vary with signal amplitude.
% f_LFP2Hz8Hz_A = filt_LFP(LFP2Hz8Hz_A,6,10); %filter [6, 10] Hz
% f_LFP2Hz8Hz_B = filt_LFP(LFP2Hz8HZ_B,6,10);
% f6 = figure('name','synchronization score');
% subplot(2,1,1);
% plot(linspace(0,2,4001),f_LFP2Hz8Hz_A);
% hold on;
% plot(linspace(0,2,4001),f_LFP2Hz8Hz_B,'r');
% 
% LFP_mat_A = [LFPtime', f_LFP2Hz8Hz_A']; % inputs should be column vector
% LFP_mat_B = [LFPtime', f_LFP2Hz8Hz_B'];
% [synchAB angleAB] = LFPsynch(LFP_mat_A,LFP_mat_B,0.25,0.01); % window: 250 ms, time step 10 ms
% subplot(2,1,2);
% plot(synchAB(:,1), synchAB(:,2)) % Note that the function removes scorec computed from a time window that falls-off the egde of signal time, so we lack values prior to 0.25 and after 1.75 sec.
% set(gca,'YLim',[-1.5 1.5]); % we can attribute the lower scores at the end of filter artifacts at the edge of the signal