function [mean_csc, peakLoc, mean_peak, sem_peak, pGeneral, pPosthoc, var_peak] = cscTrace(aligned_csc,nPeak)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% aligned_csc: input, filtered, z-scored, aligned lfp trace (format: cell)
% nPeak: # of peak
% 
% var_peak: used for session data comparisons
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
temp_csc = cell2mat(aligned_csc);
mean_csc = [mean(temp_csc(1:30,:),1); mean(temp_csc(31:60,:),1); mean(temp_csc(61:90,:),1)];

[~,temp_peakloc_th] = cellfun(@(x) findpeaks(x,'NPeaks',nPeak), aligned_csc,'UniformOutput',0);
peakLoc = cell2mat(temp_peakloc_th);
group = {'PRE','STIM','POST'};
pGeneral = zeros(1,3);
[var_peak, mean_peak, sem_peak, pPosthoc] = deal(zeros(3,3));

for iPeak = 1:nPeak
    mean_peak(:,iPeak) = [mean(peakLoc(1:30,iPeak)*0.5); mean(peakLoc(31:60,iPeak)*0.5); mean(peakLoc(61:90,iPeak)*0.5)]; % multiplying 0.5 to unit change (from usec to msec)
    sem_peak(:,iPeak) = [std(peakLoc(1:30,iPeak)*0.5,0,1)/sqrt(30); std(peakLoc(31:60,iPeak)*0.5,0,1)/sqrt(30); std(peakLoc(61:90,iPeak)*0.5,0,1)/sqrt(30)];
    [pGeneral(iPeak),~,stat] = kruskalwallis([peakLoc(1:30,iPeak), peakLoc(31:60,iPeak), peakLoc(61:90,iPeak)],group,'off');
    temp_pLSD = multcompare(stat,'display','off','cType','lsd');
    pPosthoc(:,iPeak) = temp_pLSD(:,end);
    var_peak(:,iPeak) = [var(peakLoc(1:30,iPeak)*0.5,0,1); var(peakLoc(31:60,iPeak)*0.5,0,1); var(peakLoc(61:90,iPeak)*0.5,0,1)];
end
end