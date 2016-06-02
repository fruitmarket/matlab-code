function [mean_fr] = mean_firing(spkdata, session)
%%%%%%%%%%
% [base_meanfr; pre_meanfr; stm_meanfr; post_meanfr; task_meanfr] = mean_firing(spkdata, [bastime; pretime; stmtime; posttime; tasktime])
% Purpose: Calculate mean firing rate
% session: [StartTime EndTiem; Starttime EndTime; ...] unit: usec
% 1st author: Jun
% 1st written: 4. 21. 2015
% Last modified: 11. 5. 2015
%%%%%%%%%%
mean_fr = zeros(size(session,1),1);
for isession = 1:size(session,1)
    mean_fr(isession,1) = sum(histc(spkdata/10^4,session(isession,:)/10^6))/(diff(session(isession,:))/10^6);
end