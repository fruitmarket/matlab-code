function heatMap()
%%%%%%%%%%%%%%%%%%%%%%
% Purpose: The function generates ratemap, infor, field info, flags.
%
% 1st Author: Joonyeup Lee
% 1st written: 2015. 4. 21
% Last modified:
%%%%%%%%%%%%%%%%%%%%%%

%% Parameters
alpha_v = 0.0001;
fr_threshold = 3;
fieldsize_cutoff = 10;
field_ratio = [72 48];

%% Loading data
[tData, tList] = tLoad; % tData: msec
[vtTime, vtPosition, ~] = vtLoad; % vtTime: msec
nCell = length(tList);

for iCell = 1:nCell
    disp(['### Analyzing heat map: ',tList{iCell}, '...']);
    [cellPath,cellName,~] = fileparts(tList{iCell});
    
    spkdata = tData{iCell}; %unit: msec
%     load('Events.mat','baseTime','preTime','stmTime','postTime','plfm2z');
    load('Events.mat','baseTime','preTime','stmTime','postTime');

    win.base = find(baseTime(1,1)<=vtTime{1} & vtTime{1}<=baseTime(2,1));
    win.pre = find(preTime(1,1)<=vtTime{1} & vtTime{1}<=preTime(2,1));
    win.stm = find(stmTime(1,1)<=vtTime{1} & vtTime{1}<=stmTime(2,1));
    win.post = find(postTime(1,1)<=vtTime{1} & vtTime{1}<=postTime(2,1));
%     win.plfm2hz = find(plfm2hz(1,1)<vtTime{1} & vtTime{1}<=plfm2z(2,1));
    
    t_base = vtTime{1}(win.base);
    p_base = vtPosition{1}(win.base,:);
    t_pre = vtTime{1}(win.pre);
    p_pre = vtPosition{1}(win.pre,:);
    t_stm = vtTime{1}(win.stm);
    p_stm = vtPosition{1}(win.stm,:);
    t_post = vtTime{1}(win.post);
    p_post = vtPosition{1}(win.post,:);
%     t_plfm2hz = vtTime{1}(win.plfm2hz);
%     p_plfm2hz = vtPosition{1}(win.plfm2hz);
    
%% Field map analysis
    [base_fr_map, base_visit_map,~,~] = findmaps(t_base,p_base,spkdata,field_ratio);
    if isempty(base_visit_map)
        base_meanrate = 0;
    else
        base_meanrate = sum(base_fr_map)/sum(base_visit_map);
    end
    [pre_fr_map, pre_visit_map, pre_visit_dur, pre_flags] = findmaps(t_pre, p_pre, spkdata, field_ratio);
    if isempty(pre_visit_map)
        pre_meanrate = 0;
    else
        pre_meanrate = sum(sum(pre_fr_map))/sum(sum(pre_visit_map));
    end
        
    [stm_fr_map, stm_visit_map, stm_visit_dur, stm_flags] = findmaps(t_stm, p_stm, spkdata, field_ratio);
    if isempty(stm_visit_map);
        stm_meanrate = 0;
    else
        stm_meanrate = sum(sum(stm_fr_map))/sum(sum(stm_visit_map));
    end
    
    [post_fr_map, post_visit_map, post_visit_dur, post_flags] = findmaps(t_post, p_post, spkdata, field_ratio);
    if isempty(post_visit_map)
        post_meanrate = 0;
    else
        post_meanrate = sum(sum(post_fr_map))/sum(sum(post_visit_map));
    end
    
%% Temporal field map analysis
    [base_ratemap, ~, ~] = compute_rate72x48(base_visit_map,base_fr_map,alpha_v,base_meanrate,fr_threshold,fieldsize_cutoff);
    [pre_ratemap,pre_infos,pre_field_info] = compute_rate72x48(pre_visit_map,pre_fr_map,alpha_v,pre_meanrate,fr_threshold,fieldsize_cutoff);
    [stm_ratemap,stm_infos,stm_field_info] = compute_rate72x48(stm_visit_map,stm_fr_map,alpha_v,stm_meanrate,fr_threshold,fieldsize_cutoff);
    [post_ratemap,post_infos,post_field_info] = compute_rate72x48(post_visit_map,post_fr_map,alpha_v,post_meanrate,fr_threshold,fieldsize_cutoff);
    
    base_ratemap = flipud(base_ratemap');
    pre_ratemap = flipud(pre_ratemap');
    stm_ratemap = flipud(stm_ratemap');
    post_ratemap = flipud(post_ratemap');
    
    peakFR_track = max(max([pre_ratemap,stm_ratemap,post_ratemap]))*30; % Sampleing frequency: 30Hz
    peakFR_plfm = max(max(base_ratemap))*30;
    
    save ([cellName, '.mat'],...
        'pre_ratemap','pre_infos','pre_field_info','pre_flags',...
        'stm_ratemap', 'stm_infos', 'stm_field_info','stm_flags',...
        'post_ratemap', 'post_infos', 'post_field_info','post_flags',...
        'peakFR_track','peakFR_plfm','-append');
end

disp('### Analyzing Field map is done!');
end  