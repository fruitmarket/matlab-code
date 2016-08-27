function mapCorrEvOd()
%%%%%%%%%%%%%%%%%%%%%%
% Purpose: The function only calculate place field correlation of 1st block
% based on Pearson's correlation. Place fields are separated by even / odd
% laps. 
%
% 1st Author: Joonyeup Lee
% 1st written: Aug. 6. 2016.
% Last modified: Aug. 6. 2016.
%
%%%%%%%%%%%%%%%%%%%%%%

% Parameters
alpha_v = 0.0001;
fr_threshold = 3;
fieldsize_cutoff = 10;
field_ratio = [72 48];

% Loading data
[tData, tList] = tLoad; % tData: msec
[vtTime, vtPosition, vtList] = vtLoad; % vtTime: msec
nCell = length(tList);

for iCell = 1:nCell
    disp(['### Analyzing ' ,tList{iCell}, '...']);
    [cellPath, cellName, ~] = fileparts(tList{iCell});
    cd(cellPath)
    
    load('Events.mat','sensor');
    sensor1 = sensor.S1;
    even_ratemap = ones(72,48)*0;
    odd_ratemap = ones(72,48)*0;
    even_visit_map = ones(72,48)*0;
    odd_visit_map = ones(72,48)*0;
    
    nLap = 15;
    for iLap = 1:nLap
        evenLap = find(sensor1(iLap*2)<=vtTime{1} & vtTime{1}<sensor1(iLap*2+1));
        oddLap = find(sensor1(iLap*2-1)<=vtTime{1} & vtTime{1}<sensor1(iLap*2));
        
        t_even = vtTime{1}(evenLap);
        p_even = vtPosition{1}(evenLap,:);
        
        t_odd = vtTime{1}(oddLap);
        p_odd = vtPosition{1}(oddLap,:);
        
        [even_fr_map, temp_even_visit_map, ~, ~] = findmaps(t_even,p_even,tData{iCell},field_ratio);
        if isempty(temp_even_visit_map~=0)
            even_meanrate = 0;
        else
            even_meanrate = sum(even_fr_map)/sum(temp_even_visit_map);
        end
        
        [odd_fr_map, temp_odd_visit_map, ~, ~] = findmaps(t_odd,p_odd,tData{iCell},field_ratio);
        if isempty(temp_odd_visit_map~=0)
            odd_meanrate = 0;
        else
            odd_meanrate = sum(odd_fr_map)/sum(temp_odd_visit_map);
        end
        
        [temp_even_ratemap, ~, ~] = compute_rate72x48(temp_even_visit_map,even_fr_map,alpha_v,even_meanrate,fr_threshold,fieldsize_cutoff);
        [temp_odd_ratemap, ~, ~] = compute_rate72x48(temp_odd_visit_map,odd_fr_map,alpha_v,odd_meanrate,fr_threshold,fieldsize_cutoff);
        
        even_ratemap = even_ratemap + temp_even_ratemap;
        even_visit_map = even_visit_map + temp_even_visit_map;
        
        odd_ratemap = odd_ratemap + temp_odd_ratemap;
        odd_visit_map = odd_visit_map + temp_odd_visit_map;
    end
    
    % correlation
    [r_CorrEvOd, p_CorrEvOd] = corr(even_ratemap(even_visit_map(:)&odd_visit_map(:)), odd_ratemap(even_visit_map(:)&odd_visit_map(:)),'type','Pearson');
    
%     even_ratemap = flipud((even_ratemap/15)');
%     odd_ratemap = flipud((odd_ratemap/15)');
    
    save([cellName, '.mat'],'r_CorrEvOd','p_CorrEvOd','-append');        
end
disp('### fieldMap_EvenOdd is done!');
end



        