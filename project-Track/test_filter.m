Filename = 'CSC1.ncs';
[Timestamp, ChanNum, Fs, NumValSamples, Samples] = Nlx2MatCSC(Filename, [1 1 1 1 1], 0, 1);
% theta = [4 12]; %[4 6 - 10 12] [6-10]
% delta =[2 4];% [1 2 - 4 6] [2-4]
% SWR = [100 250]; %[80 130 - 250 300] [100-250]
% Apass = 1dB
% Astop = 60 dB
nview = 8;

yout = filtfilt(SWR,1,Samples(:));
yout2 = reshape(yout,512,size(Samples,2));

yout_th = filtfilt(Theta,1,Samples(:));
yout2_th = reshape(yout_th,512,size(Samples,2));

yout_del = filtfilt(Delta,1,Samples(:));
yout2_del = reshape(yout_del,512,size(Samples,2));
% load LFPfilters.mat;
%%
yout_th2 = filtfilt(Theta,1,Samples(:));
yout2_th2 = reshape(yout_th2,512,size(Samples,2));

%%
legend_str = {'Raw LFP','Sharp Wave Ripple','Theta','Delta'};
for i=1:100
    idx = (nview*(i-1)+1):(nview*i);
    d1 = Samples(:,idx);
    d2 = yout2(:,idx);
    d3 = yout2_th(:,idx);
    d4 = yout2_del(:,idx);
    d5 = yout2_th2(:,idx);
    
    dd = [d1(:), d2(:), d3(:), d4(:)];
    subplot(2,1,1)
    plot(dd);
    legend(legend_str);
    xlim([0 512*nview]);
    set(gca,'TickDir','out','box','off');
    subplot(2,1,2)
    plot([d3(:), d5(:)]);
    legend({'FIR','IIR'});
    xlim([0 512*nview]);
    set(gca,'TickDir','out','box','off');
    pause;
end