function analysis_behaviorTrack

[~, tList] = tLoad;
nCell = length(tList);

for iCell = 1:nCell
    disp(['### Analyzing ',tList{iCell},'...']);
    [cellPath,~,~] = fileparts(tList{iCell});
    cd(cellPath);
    
% Load Events variables
    load('Events.mat');
    switch size(sensor,1)
%%
        case 90
            timeLap = [diff(sensor(:,1)); sensor(90,12)-sensor(90,1)];
            m_timeLap = [mean(timeLap(1:30)), mean(timeLap(31:60)), mean(timeLap(61:90))];
            group = {'PRE', 'STIM', 'POST'};
            [p_KW_Behav_main, ~, stats] = kruskalwallis([timeLap(1:30), timeLap(31:60), timeLap(61:90)],group,'off');
            result = multcompare(stats,'ctype','lsd','Display','off');
            p_KW_Behav_detail = result(:,end);
        
        % zone1: sensor12~3 / 3~6 / 6~9 / 9~12 
            timeInZone(:,1) = [sensor(1,3)-sensor(1,1); sensor(2:end,3)-sensor(1:end-1,12)];
            timeInZone(:,2) = sensor(:,6)-sensor(:,3);
            timeInZone(:,3) = sensor(:,9)-sensor(:,6);
            timeInZone(:,4) = sensor(:,12)-sensor(:,9);
            sum_timeZone = zeros(3,4);
            sum_timeZone(:,1) = [sum(timeInZone(1:30,1)); sum(timeInZone(31:60,1)); sum(timeInZone(61:90,1))];
            sum_timeZone(:,2) = [sum(timeInZone(1:30,2)); sum(timeInZone(31:60,2)); sum(timeInZone(61:90,2))];
            sum_timeZone(:,3) = [sum(timeInZone(1:30,3)); sum(timeInZone(31:60,3)); sum(timeInZone(61:90,3))];
            sum_timeZone(:,4) = [sum(timeInZone(1:30,4)); sum(timeInZone(31:60,4)); sum(timeInZone(61:90,4))];
            
%%
        case 150
            timeLap = [diff(sensor(1:30,1)); sensor(30,12)-sensor(30,1); diff(sensor(31:120,1)); sensor(120,12)-sensor(120,1); diff(sensor(121:end,1)); sensor(150,12)-sensor(150,1)];
            m_timeLap = [mean(timeLap(1:30)), mean(timeLap(31:60)), mean(timeLap(61:90)), mean(timeLap(91:120)), mean(timeLap(121:150))];
            
            group = {'basePRE', 'PRE', 'STIM', 'POST', 'basePOST'};
            [p_KW_Behav_main, ~, stats] = kruskalwallis([timeLap(1:30), timeLap(31:60), timeLap(61:90), timeLap(91:120), timeLap(121:150)],group,'off');
            result = multcompare(stats,'ctype','lsd','Display','off');
            p_KW_Behav_detail = result(:,end);
            timeInZone(:,1) = ([sensor(1,3)-sensor(1,1); sensor(2:30,3)-sensor(1:29,12);...
                          sensor(31,3)-sensor(31,1); sensor(32:120,3)-sensor(31:119,12);...
                          sensor(121,3)-sensor(121,1); sensor(122:end,3)-sensor(121:end-1,12)]);
            timeInZone(:,2) = (sensor(:,6)-sensor(:,3));
            timeInZone(:,3) = (sensor(:,9)-sensor(:,6));
            timeInZone(:,4) = (sensor(:,12)-sensor(:,9));
            sum_timeZone = zeros(5,4);
            sum_timeZone(:,1) = [sum(timeInZone(1:30,1)); sum(timeInZone(31:60,1)); sum(timeInZone(61:90,1)); sum(timeInZone(91:120,1)); sum(timeInZone(120:end,1))];
            sum_timeZone(:,2) = [sum(timeInZone(1:30,2)); sum(timeInZone(31:60,2)); sum(timeInZone(61:90,2)); sum(timeInZone(91:120,2)); sum(timeInZone(120:end,2))];
            sum_timeZone(:,3) = [sum(timeInZone(1:30,3)); sum(timeInZone(31:60,3)); sum(timeInZone(61:90,3)); sum(timeInZone(91:120,3)); sum(timeInZone(120:end,3))];
            sum_timeZone(:,4) = [sum(timeInZone(1:30,4)); sum(timeInZone(31:60,4)); sum(timeInZone(61:90,4)); sum(timeInZone(91:120,4)); sum(timeInZone(120:end,4))];
    end
    timeInZone = timeInZone/1000; % change unit to sec
    sum_timeZone = sum_timeZone/1000; % change unit to sec
    save(['Events.mat'],'timeLap','m_timeLap','p_KW_Behav_main','p_KW_Behav_detail','sum_timeZone','timeInZone','-append');
end
disp('### Analysis: BehaviorTrack is done! ###');