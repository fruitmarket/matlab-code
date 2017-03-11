function heatMap()
%%%%%%%%%%%%%%%%%%%%%%
% Purpose: The function generates ratemap, infor, field info, flags.
%
% 1st Author: Joonyeup Lee
% 1st written: 2015. 4. 21
% Last modified:
%%%%%%%%%%%%%%%%%%%%%%

%% Parameters
% alpha_v = 0.05; % changing alpha will affect visualing field map.
% fr_threshold = 3;
% fieldsize_cutoff = 10;
field_ratio = [72 48];

%% Loading data
[tData, tList] = tLoad; % tData: msec
[vtTime, vtPosition, vtList] = vtLoad; % vtTime: msec
nCell = length(tList);
load('Events.mat','baseTime','preTime','stmTime','postTime','plfmTime','sensor');

win.base = find(baseTime(1,1)<=vtTime{1} & vtTime{1}<=baseTime(2,1));
win.pre = find(preTime(1,1)<=vtTime{1} & vtTime{1}<=preTime(2,1));
win.stm = find(stmTime(1,1)<=vtTime{1} & vtTime{1}<=stmTime(2,1));
win.post = find(postTime(1,1)<=vtTime{1} & vtTime{1}<=postTime(2,1));
win.twohz = find(plfmTime.twohz(1,1) < vtTime{1} & vtTime{1} <= plfmTime.twohz(2,1));

t_base = vtTime{1}(win.base);
p_base = vtPosition{1}(win.base,:);
t_pre = vtTime{1}(win.pre);
p_pre = vtPosition{1}(win.pre,:);
t_stm = vtTime{1}(win.stm);
p_stm = vtPosition{1}(win.stm,:);
t_post = vtTime{1}(win.post);
p_post = vtPosition{1}(win.post,:);
t_two = vtTime{1}(win.twohz);
p_two = vtPosition{1}(win.twohz,:);

stmIdx = [];
for iStm = 31:60
    stmIdx_temp = find(sensor.S10(iStm)<=vtTime{1} & vtTime{1}<=sensor.S11(iStm));
    stmIdx = [stmIdx;stmIdx_temp];
end
stmPosition = vtPosition{1}(stmIdx,:);

for iCell = 1:nCell
    disp(['### Heat map analysis: ',tList{iCell},'...']);
    [~,cellName,~] = fileparts(tList{iCell});
    
    spkdata = tData{iCell}; %unit: msec
    
%% Field map analysis
    [base_fr_map, base_visit_map,base_visit_dur,~] = findmaps(t_base,p_base,spkdata,field_ratio);
%     if isempty(base_visit_map)
%         base_meanrate = 0;
%     else
        base_meanrate = sum(base_fr_map(:))/sum(base_visit_dur(:));
%     end
    [pre_fr_map, pre_visit_map, pre_visit_dur, pre_flags] = findmaps(t_pre, p_pre, spkdata, field_ratio);
    pre_meanrate = sum(pre_fr_map(:))/sum(pre_visit_dur(:));

    [stm_fr_map, stm_visit_map, stm_visit_dur, stm_flags] = findmaps(t_stm, p_stm, spkdata, field_ratio);
    stm_meanrate = sum(stm_fr_map(:))/sum(stm_visit_dur(:));

    [post_fr_map, post_visit_map, post_visit_dur, post_flags] = findmaps(t_post, p_post, spkdata, field_ratio);
    post_meanrate = sum(post_fr_map(:))/sum(post_visit_dur(:));

    [twohz_fr_map, twohz_visit_map, twohz_visit_dur, twohz_flags] = findmaps(t_two, p_two, spkdata, field_ratio);
    twohz_meanrate = sum(twohz_fr_map(:))/sum(twohz_visit_dur(:));

%% Raw ratemap calculation
base_ratemap = base_fr_map./base_visit_dur;
pre_ratemap = pre_fr_map./pre_visit_dur;
stm_ratemap = stm_fr_map./stm_visit_dur;
post_ratemap = post_fr_map./post_visit_dur;
twohz_ratemap = twohz_fr_map./twohz_visit_dur;
    
%% field map smoothing by comput_rate72x48
%     if find(base_fr_map)
%         [base_ratemap, ~, ~] = compute_rate72x48(base_visit_dur,base_fr_map,alpha_v,base_meanrate,fr_threshold,fieldsize_cutoff);
%     else
%         base_ratemap = 0;
%     end
%     if find(pre_fr_map)
%         [pre_ratemap,pre_infos,pre_field_info] = compute_rate72x48(pre_visit_dur,pre_fr_map,alpha_v,pre_meanrate,fr_threshold,fieldsize_cutoff);
%     else
%         pre_ratemap = zeros(72,48);
%         [pre_infos,pre_field_info] = deal(NaN);
%     end
%     if find(stm_fr_map)
%         [stm_ratemap,stm_infos,stm_field_info] = compute_rate72x48(stm_visit_dur,stm_fr_map,alpha_v,stm_meanrate,fr_threshold,fieldsize_cutoff);
%     else
%         stm_ratemap = zeros(72,48);
%         [stm_infos,stm_field_info] = deal(NaN);
%     end
%     if find(post_fr_map)
%         [post_ratemap,post_infos,post_field_info] = compute_rate72x48(post_visit_dur,post_fr_map,alpha_v,post_meanrate,fr_threshold,fieldsize_cutoff);
%     else
%         post_ratemap = zeros(72,48);
%         [post_infos, post_field_info] = deal(NaN);
%     end
%     if find(twohz_fr_map)
%         [twohz_ratemap, ~, ~] = compute_rate72x48(twohz_visit_dur,twohz_fr_map,alpha_v,twohz_meanrate,fr_threshold,fieldsize_cutoff);
%     else
%         twohz_ratemap = 0;
%     end

%%
    % Remove off track points
    base_ratemap(base_visit_map == 0) = NaN;
    pre_ratemap(pre_visit_map == 0) = NaN;
    stm_ratemap(stm_visit_map == 0) = NaN;
    post_ratemap(post_visit_map == 0) = NaN;
    twohz_ratemap(twohz_visit_map == 0) = NaN;
    
    % Position correction (the map should be same as real position data. Compare row data with pcolor(ratemap))
    base_ratemap = flipud(base_ratemap');
    pre_ratemap = flipud(pre_ratemap');
    stm_ratemap = flipud(stm_ratemap');
    post_ratemap = flipud(post_ratemap');
    twohz_ratemap = flipud(twohz_ratemap');
    
    totalmap = [pre_ratemap,stm_ratemap,post_ratemap];
    
    peakFR2D_track = [max(pre_ratemap(:));max(stm_ratemap(:));max(post_ratemap(:))];
    peakFR2D_plfm = max(base_ratemap(:));
    peakFR2D_two = max(twohz_ratemap(:));
    
    save([cellName,'.mat'],'pre_ratemap','stm_ratemap','post_ratemap','totalmap','base_ratemap','twohz_ratemap','peakFR2D_track','peakFR2D_plfm','peakFR2D_two','-append');

%     save ([cellName, '.mat'],...
%         'pre_ratemap','pre_infos','pre_field_info','pre_flags',...
%         'stm_ratemap', 'stm_infos', 'stm_field_info','stm_flags',...
%         'post_ratemap', 'post_infos', 'post_field_info','post_flags',...
%         'peakFR_track','peakFR_plfm','totalmap','-append');
end
disp('### Analyzing Field map is done!');
end  