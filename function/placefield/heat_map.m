function heat_map()
%%%%%%%%%%%%%%%%%%%%%%
% Purpose: The function generates ratemap, infor, field info, flags.
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
[ttfile, nCell] = tfilecollector;
load ('VT1.mat');
ttdata = LoadSpikes(ttfile,'tsflag','ts','verbose',0);

%% 
for icell = 1:nCell
    [cellpath,cellname,~] = fileparts(ttfile{icell});
    disp(['### Analyzing ',ttfile{icell}, '...']);
    cd(cellpath);
    
    spkdata = Data(ttdata{icell})/10; %unit: msec
    
    load('Events.mat','baseTime','preTime','stmTime','postTime');
    
    %% Timewindow set
    win.base = find(baseTime(1,1)<=timestamp & timestamp<=baseTime(2,1));
    win.pre = find(preTime(1,1)<=timestamp & timestamp<=preTime(2,1));
    win.stm = find(stmTime(1,1)<=timestamp & timestamp<=stmTime(2,1));
    win.post = find(postTime(1,1)<=timestamp & timestamp<=postTime(2,1));
    
    %% Time & position set
    t_pre = timestamp(win.pre);
    p_pre = position(win.pre,:); % Position (x,y)
    
    t_stm = timestamp(win.stm);
    p_stm = position(win.stm,:);
    
    t_post = timestamp(win.post);
    p_post = position(win.post,:);
    
    %% Field map analysis
    [pre_fr_map, pre_visit_map, pre_visit_dur, pre_flags] = findmaps(t_pre, p_pre, spkdata, field_ratio);
    if isempty(find(pre_visit_map))
        pre_meanrate = 0;
    else
        pre_meanrate = sum(pre_fr_map)/sum(pre_visit_map);
    end
        
    [stm_fr_map, stm_visit_map, stm_visit_dur, stm_flags] = findmaps(t_stm, p_stm, spkdata, field_ratio);
    if isempty(find(stm_visit_map));
        stm_meanrate = 0;
    else
        stm_meanrate = sum(stm_fr_map)/sum(stm_visit_map);
    end
    
    [post_fr_map, post_visit_map, post_visit_dur, post_flags] = findmaps(t_post, p_post, spkdata, field_ratio);
    if isempty(find(post_visit_map))
        post_meanrate = 0;
    else
        post_meanrate = sum(post_fr_map)/sum(post_visit_map);
    end
    
    %% Temporal field map analysis
    whos pre_visit_map; % used for code checking
    [pre_ratemap, pre_infos, pre_field_info] = compute_rate72x48(pre_visit_map, pre_fr_map, alpha_v, pre_meanrate, fr_threshold, fieldsize_cutoff);
    [stm_ratemap, stm_infos, stm_field_info] = compute_rate72x48(stm_visit_map, stm_fr_map, alpha_v, stm_meanrate, fr_threshold, fieldsize_cutoff);
    [post_ratemap, post_infos, post_field_info] = compute_rate72x48(post_visit_map, post_fr_map, alpha_v, post_meanrate, fr_threshold, fieldsize_cutoff);

    pre_ratemap = flipud(pre_ratemap');
    stm_ratemap = flipud(stm_ratemap');
    post_ratemap = flipud(post_ratemap');
    
    save ([cellname, '.mat'],...
        'pre_ratemap','pre_infos','pre_field_info','pre_flags',...
        'stm_ratemap', 'stm_infos', 'stm_field_info','stm_flags',...
        'post_ratemap', 'post_infos', 'post_field_info','post_flags',...
        '-append');
end
disp('### Analyzing field map is done!');
end
    