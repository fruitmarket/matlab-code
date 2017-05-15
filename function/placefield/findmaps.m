function [fr_map, visit_map, visit_dur, flags] = findmaps(time, position, spkdata, field_ratio)
%%%%%%%%%%%%%%%%%%%%
% Purpose: Generate maps (firing rate map, visit map, visit duration, flags(portion of bad detection)
% 1st author: Jeong-wook Ghim
% Edited: Joonyeup Lee (2015. 4. 20.)
% time [unit: msec]
% spkdata [unit: msec]
%%%%%%%%%%%%%%%%%%%%

%%
% time: msec unit.
spk = histc(spkdata, time); % 'spkdata', 'time': [unit: msec]

pos_prod = prod(position,2);
position(pos_prod==0,:) = 0;
[dt, newVTflag] = VTRecBreakProcess(time); %dt: [unit: msec]

if newVTflag 
    original_resol = field_ratio;
else
    original_resol = [640 480];
end
% original_resol = [720 480];
position(position(:,2) > 480,:) = 0; % y-position limit
position(position(:,1) > original_resol(1),:) = 0; % x-position limit
nzPosiIdex = find(position(:,1));

%% Generating field
firing_map = zeros(original_resol);
num_visit = zeros(original_resol);
visit_time = zeros(original_resol);

for iPosi = 1:length(nzPosiIdex)
    firing_map(position(nzPosiIdex(iPosi),1),position(nzPosiIdex(iPosi),2)) = firing_map(position(nzPosiIdex(iPosi),1),position(nzPosiIdex(iPosi),2)) + spk(nzPosiIdex(iPosi));
    num_visit(position(nzPosiIdex(iPosi),1),position(nzPosiIdex(iPosi),2)) = num_visit(position(nzPosiIdex(iPosi),1),position(nzPosiIdex(iPosi),2)) + 1;
    visit_time(position(nzPosiIdex(iPosi),1),position(nzPosiIdex(iPosi),2)) = visit_time(position(nzPosiIdex(iPosi),1),position(nzPosiIdex(iPosi),2)) + dt(nzPosiIdex(iPosi));
end
nz_num_visit = find(num_visit);
map_resol = original_resol/field_ratio;
% new_map_resol = original_resol./map_resol;

%% Reshaping Field
re_firing_map = zeros(field_ratio);
re_num_visit = zeros(field_ratio);
re_visit_time = zeros(field_ratio);
map_ratio = [720 480]/field_ratio;

for xpt = 1:field_ratio(1) % Generating 72x48 map
    for ypt = 1:field_ratio(2)
%         re_firing_map(xpt,ypt) = sum(sum(firing_map(map_ratio(1)*(xpt-1)+1:map_ratio(1)*(xpt-1)+map_ratio(1),map_ratio(2)*(ypt-1)+1:map_ratio(2)*(ypt-1)+map_ratio(2))));
%         re_num_visit(xpt,ypt) = sum(sum(num_visit(map_ratio(1)*(xpt-1)+1:map_ratio(1)*(xpt-1)+map_ratio(1), map_ratio(2)*(ypt-1)+1:map_ratio(2)*(ypt-1)+map_ratio(2))));
%         re_visit_time(xpt,ypt) = sum(sum(visit_time(map_ratio(1)*(xpt-1)+1:map_ratio(1)*(xpt-1)+map_ratio(1), map_ratio(2)*(ypt-1)+1:map_ratio(2)*(ypt-1)+map_ratio(2))));
        
        re_firing_map(xpt,ypt) = sum(sum(firing_map(map_ratio*(xpt-1)+1:map_ratio*(xpt-1)+map_ratio,map_ratio*(ypt-1)+1:map_ratio*(ypt-1)+map_ratio)));
        re_num_visit(xpt,ypt) = sum(sum(num_visit(map_ratio*(xpt-1)+1:map_ratio*(xpt-1)+map_ratio, map_ratio*(ypt-1)+1:map_ratio*(ypt-1)+map_ratio)));
        re_visit_time(xpt,ypt) = sum(sum(visit_time(map_ratio*(xpt-1)+1:map_ratio*(xpt-1)+map_ratio, map_ratio*(ypt-1)+1:map_ratio*(ypt-1)+map_ratio)));
    end
end

%% Passing values
fr_map = re_firing_map;
visit_map = re_num_visit/30; % devide by video tracking rate (30hz)
visit_dur = re_visit_time/10^3; % [change unit from msec to sec] 
flags = [length(nzPosiIdex) length(position)]; % Percentage of good recording
end