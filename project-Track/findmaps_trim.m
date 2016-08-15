
function [fr_map, visit_map, visit_dur, flags] = findmaps_trim(time, position, spkdata, field_ratio)
%%%%%%%%%%%%%%%%%%%%
% Purpose: Generate maps (firing rate map, visit map, visit duration, flags(portion of bad detection)
% 1st author: Jeong-wook Ghim
% Edited: Joonyeup Lee (2015. 4. 20.)

%%%%%%%%%%%%%%%%%%%%

%%
% time: msec unit.
mapThreshold = 7;
spk = histc(spkdata*10, time*10); % spk: 100 usec unit

pos_prod = prod(position,2);
position(pos_prod==0,:) = 0;

[dt, newVTflag] = VTRecBreakProcess(time*10);
if newVTflag 
    original_resol = [720 480];
else
    original_resol = [640 480];
end

position(position(:,1) > original_resol(1),:) = 0; % x-position limit
position(position(:,2) > 480,:) = 0; % y-position limit
nz_position_idx = find(position(:,1));
%% Generating field
firing_map = zeros(original_resol);
num_visit = zeros(original_resol);
visit_time = zeros(original_resol);

for iposition = 1:length(nz_position_idx)
    firing_map(position(nz_position_idx(iposition),1),position(nz_position_idx(iposition),2)) = ...
        firing_map(position(nz_position_idx(iposition),1),position(nz_position_idx(iposition),2)) +...
        spk(nz_position_idx(iposition));
    num_visit(position(nz_position_idx(iposition),1),position(nz_position_idx(iposition),2)) = ...
        num_visit(position(nz_position_idx(iposition),1),position(nz_position_idx(iposition),2)) + 1;
    visit_time(position(nz_position_idx(iposition),1),position(nz_position_idx(iposition),2)) =...
        visit_time(position(nz_position_idx(iposition),1),position(nz_position_idx(iposition),2)) +...
        dt(nz_position_idx(iposition));
end
% nz_num_visit = find(num_visit);
% map_resol = original_resol/field_ratio;
% new_map_resol = original_resol./map_resol;

%% Reshaping Field
re_firing_map = zeros(field_ratio);
re_num_visit = zeros(field_ratio);
re_visit_time = zeros(field_ratio);
map_ratio = [720 480]./field_ratio;

for xpt = 1:field_ratio(1) % Generating 72x48 map
    for ypt = 1:field_ratio(2)
        re_firing_map(xpt,ypt) = sum(sum(firing_map(map_ratio(1)*(xpt-1)+1:map_ratio(1)*(xpt-1)+map_ratio(1),...
            map_ratio(2)*(ypt-1)+1:map_ratio(2)*(ypt-1)+map_ratio(2))));
        re_num_visit(xpt,ypt) = sum(sum(num_visit(map_ratio(1)*(xpt-1)+1:map_ratio(1)*(xpt-1)+map_ratio(1),...
            map_ratio(2)*(ypt-1)+1:map_ratio(2)*(ypt-1)+map_ratio(2))));
        re_visit_time(xpt,ypt) = sum(sum(visit_time(map_ratio(1)*(xpt-1)+1:map_ratio(1)*(xpt-1)+map_ratio(1),...
            map_ratio(2)*(ypt-1)+1:map_ratio(2)*(ypt-1)+map_ratio(2))));
    end
end

%% Passing values
fr_map = re_firing_map;
visit_map = re_num_visit;

% Trim the field.
visit_map(visit_map<mapThreshold) = 0;
for irow = 2:size(visit_map,1)-1
    for icol = 2:size(visit_map,2)-1
        if sum(sum(visit_map(irow-1:irow+1,icol-1:icol+1)==0))>=7; % if the array is surrounded by zeros, then make that array zero
            visit_map(irow,icol) = 0;
        end
    end
end

visit_dur = re_visit_time/10^4; % [unit: sec] At line 18, already divided by 10^2 
flags = [length(nz_position_idx) length(position)]; % Percentage of good recording
end