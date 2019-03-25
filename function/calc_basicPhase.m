function result = calc_basicPhase(newSpikeData, eventTime, winSpk, ang_csc, cscTime, winCsc)
% calc_basicPhase calculate phasic properties by using filtered csc and spike data
% Output: A structure which contains 8 elements
% mean, median, vectorlength(r), variance, standard deviation, p-value (Rayleigh, Omnibut)
% The function requires 'cscWin' and 'circStat'
%
% Written by Joonyeup Lee
% Aug. 14. 2018

spikeTime = spikeWin(newSpikeData,eventTime,winSpk);
time = winCsc(1):winCsc(2);
nTrial = length(eventTime);
lap_idx_phase = cell(nTrial,1);
    for iTrial = 1:nTrial
        lapSpk = num2cell(spikeTime{iTrial});
        [~, idx_phase] = cellfun(@(x) min(abs(x-time)),lapSpk);

        lap_idx_phase{iTrial} = idx_phase;
    end
angBand = cscWin(ang_csc, cscTime, eventTime, winCsc);
phase = cellfun(@(x,y) x(y),angBand,lap_idx_phase,'UniformOutput',0);
temp_phase = cell2mat(phase);

result.phase = phase;
result.angle_mean = circ_mean(temp_phase);
result.angle_median = circ_median(temp_phase);
result.angle_r = circ_r(temp_phase);
result.angle_var = circ_var(temp_phase);
[~,result.angle_std] = circ_std(temp_phase,[],[]);
result.p_rayleigh = circ_rtest(temp_phase);
result.p_omnibus = circ_otest(temp_phase);
end