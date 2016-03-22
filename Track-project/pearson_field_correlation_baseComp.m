function [pearson_r] = pearson_field_correlation()
%%%%%%%%%%%%%%%%%%%%%%
% Purpose: The function calculate place field correlation based on Pearson's correlation. 
% 1st Author: Joonyeup Lee
% 1st written: 2015. 10. 4.
% Last modified: 2015. 10. 29.
% window must be 2x2 vector, each session start time (1,1) & (2,1) and end time (1,2) & (2,2).
% Pre: first time period, post: 2nd time period

%%%%%%%%%%%%%%%%%%%%%%

%% Parameters
alpha_v = 0.005;
fr_threshold = 3;
fieldsize_cutoff = 10;
field_ratio = [72 48];

%% Loading data
[ttfile, ncell] = tfilecollector;
load ('VT1.mat');
ttdata = LoadSpikes(ttfile,'tsflag','ts','verbose',0);

for icell = 1:1
    [cellpath,cellname,~] = fileparts(ttfile{icell});
    disp(['### Analyzing ',ttfile{icell},'...']);
    cd(cellpath);
    
    spkData = Data(ttdata{icell})/10; % unit: msec 
    load('Events.mat','sensor','fields','nSensor','nTrial');
    
    pearson_r = zeros(nTrial/10,nTrial/10);
    
    for iBlock = 1:nTrial/10
        window(iBlock,:) = [sensor.(fields{1})(10*iBlock-9), sensor.(fields{end})(10*iBlock)];
    end
    
    % Distinguishing blocks
    pFields = {'p1','p2','p3','p4','p5','p6','p7','p8','p9'};
    for iBlock = 1:numel(pFields)
        blockTime.(pFields{iBlock}) = timestamp(window(iBlock,1)<= timestamp & timestamp<=window(iBlock,2));
        blockPosition.(pFields{iBlock}) = position(window(iBlock,1)<= timestamp & timestamp<=window(iBlock,2),:);
    end
    
    % Field map & Visit map
    for iBlock = 1:numel(pFields) 
        [fr_map.(pFields{iBlock}), visit_map.(pFields{iBlock}), ~, ~] = findmaps(blockTime.(pFields{iBlock}), blockPosition.(pFields{iBlock}), spkData, field_ratio);
        if isempty(find(visit_map.(pFields{iBlock})))
            meanrate.(pFields{iBlock}) = 0;
        else
            meanrate.(pFields{iBlock}) = sum(sum(fr_map.(pFields{iBlock})))/sum(sum(visit_map.(pFields{iBlock})));
        end
    end
    
    %  Ratemap
    for iBlock = 1:numel(pFields)
        [ratemap.(pFields{iBlock}), ~, ~] = compute_rate72x48(visit_map.(pFields{iBlock}), fr_map.(pFields{iBlock}), alpha_v, meanrate.(pFields{iBlock}),...
        fr_threshold, fieldsize_cutoff);
    end
    
    % Pearson's correlation
    for iRow = 1:numel(pFields)
        for iCol = 1:numel(pFields)
            pearson_r(iRow,iCol) = corr(ratemap.(pFields{iRow})(visit_map.(pFields{iRow})&visit_map.(pFields{iCol})),ratemap.(pFields{iCol})(visit_map.(pFields{iRow})&visit_map.(pFields{iCol})),'type','Pearson');
        end
    end

%% Correlation compare [Base Compare to Stimulation 30 laps and Last 30 laps respectively]
compPearson_r = zeros(1,6);
baseWindow = zeros(7,2);
compFields = {'stm1','stm2','stm3','post1','post2','post3'};

baseWindow(1,:) = [sensor.(fields{1})(1), sensor.(fields{end})(30)];

% Time and Position of base (first 30 laps)
baseblockTime = timestamp(baseWindow(1,1)<=timestamp & timestamp<=baseWindow(1,2));
baseblockPosition = position(baseWindow(1,1) <= timestamp & timestamp<baseWindow(1,2),:);

[base_fr_map, base_visit_map, ~, ~] = findmaps_trim(baseblockTime,baseblockPosition,spkData,field_ratio);
if isempty(find(base_visit_map))
    base_meanrate = 0;
else
    base_meanrate = sum(sum(base_fr_map))/sum(sum(base_visit_map));
end

[base_ratemap, ~, ~] = compute_rate72x48(base_visit_map, base_fr_map, alpha_v, base_meanrate,fr_threshold,fieldsize_cutoff);

% Pearson's correlation
ratemapComp.stm1 = ratemap.p4;
ratemapComp.stm2 = ratemap.p5;
ratemapComp.stm3 = ratemap.p6;
ratemapComp.post1 = ratemap.p7;
ratemapComp.post2 = ratemap.p8;
ratemapComp.post3 = ratemap.p9;

visitmapComp.stm1 = visit_map.p4;
visitmapComp.stm2 = visit_map.p5;
visitmapComp.stm3 = visit_map.p6;
visitmapComp.post1 = visit_map.p7;
visitmapComp.post2 = visit_map.p8;
visitmapComp.post3 = visit_map.p9;

for iComp = 1:numel(compFields)
    compPearson_r(iComp) = corr(base_ratemap(base_visit_map&visitmapComp.(compFields{iComp})), ratemapComp.(compFields{iComp})(base_visit_map&visitmapComp.(compFields{iComp})),'type','Pearson');
end

    
%     for iRow = 1:nTrial/10
%        for iColumn = 1:nTirla/10
%             window = ([sensorTime(10*iRow-9,1),sensorTime(10*iColumn-9,1);sensorTime(10*iRow,8),sensorTime(10*iColumn,8)]);
%             
% 
%         % Timewindow set
%             session.pre = find(window(1,1)<=timestamp/1000 & timestamp/1000<=window(2,1)); % window(1,1): 1st session start, window(1,2): 1st session end
%             session.post = find(window(1,2)<=timestamp/1000 & timestamp/1000<=window(2,2)); % window(2,1): 2nd session start, window(2,2): 2nd session end
%         
%         % Time & position set
%             time.pre = timestamp(session.pre);
%             posi.pre = position(session.pre,:); % Position (x,y)
%     
%             time.post = timestamp(session.post);
%             posi.post = position(session.post,:);    
%     
%        % Field map analysis
%             [pre_fr_map, pre_visit_map, ~, ~] = findmaps(time.pre, posi.pre, spkData, field_ratio);
%             if isempty(find(pre_visit_map))
%                 pre_meanrate = 0;
%             else
%                 pre_meanrate = sum(sum(pre_fr_map))/sum(sum(pre_visit_map));
%             end
%             
%             [post_fr_map, post_visit_map, ~, ~] = findmaps(time.post, posi.post, spkData, field_ratio);
%             if isempty(find(post_visit_map))
%                 post_meanrate = 0;
%             else
%                 post_meanrate = sum(sum(post_fr_map))/sum(sum(post_visit_map));
%             end
%     
%       %% Temporal field map analysis
% %     whos pre_visit_map; % used for code checking        
%         [pre_ratemap, ~, ~] = compute_rate72x48(pre_visit_map, pre_fr_map, alpha_v, pre_meanrate,...
%             fr_threshold, fieldsize_cutoff);
%         [post_ratemap, ~, ~] = compute_rate72x48(post_visit_map, post_fr_map, alpha_v, post_meanrate,...
%             fr_threshold, fieldsize_cutoff);
%             
%         pearson_r(iRow,iColumn) = corr(pre_ratemap(pre_visit_map & post_visit_map),post_ratemap(pre_visit_map & post_visit_map),'type','Pearson');
%        end
%     end
    save ([cellname, '.mat'],...
        'pearson_r','-append');
end
disp('### Pearson correlation analysis done! ###');
% clear all;