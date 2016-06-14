function pearson_field_correlation_baseComp()
%%%%%%%%%%%%%%%%%%%%%%
% Purpose: The function calculate place field correlation based on Pearson's correlation. 
% 1st Author: Joonyeup Lee
% 1st written: 2015. 10. 4.
% Last modified: 2016. 3. 31.
% window must be 2x2 vector, each session start time (1,1) & (2,1) and end time (1,2) & (2,2).
% Pre: first time period, post: 2nd time period

%%%%%%%%%%%%%%%%%%%%%%

%% Parameters
alpha_v = 0.005;
fr_threshold = 3;
fieldsize_cutoff = 10;
field_ratio = [72 48];

%% Loading data
[ttfile, nCell] = tfilecollector;
load ('VT1.mat');
ttdata = LoadSpikes(ttfile,'tsflag','ts','verbose',0);

for icell = 1:nCell
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

visitmapComp.stm1 = visit_map.p4(:);
visitmapComp.stm2 = visit_map.p5(:);
visitmapComp.stm3 = visit_map.p6(:);
visitmapComp.post1 = visit_map.p7(:);
visitmapComp.post2 = visit_map.p8(:);
visitmapComp.post3 = visit_map.p9(:);

for iComp = 1:numel(compFields)
    compPearson_r(iComp) = corr(base_ratemap(base_visit_map(:)&visitmapComp.(compFields{iComp})), ratemapComp.(compFields{iComp})(base_visit_map(:)&visitmapComp.(compFields{iComp})),'type','Pearson');
end

    save ([cellname, '.mat'],...
        'pearson_r','compPearson_r','-append');
end
disp('### Pearson correlation analysis done! ###');
% clear all;