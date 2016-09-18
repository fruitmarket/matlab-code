function xlsLoad_mwm

xlsfile = FindFiles('*.xls');
nfile = length(xlsfile);

%% Raw data collection
for ifile =1:nfile
    [filepath, filename, ext] = fileparts(xlsfile{ifile});
    
    disp(['### Analyzing ', xlsfile{ifile}, '...']);
    cd(filepath);
    
    all_info = readtable([filename, ext]);
    
    latency(:,ifile) = all_info.LatencyToTarget_Seconds_;     % 63
    distance(:,ifile) = all_info.DistanceToTarget;
    meandistance(:,ifile) = all_info.MeanDistanceToTarget;    % 68
    totaldistance(:,ifile) = all_info.TotalDistance;          % 97
    speed(:,ifile) = all_info.MeanSpeedInZone_Total;          % 160   
end

idx = find(latency>60);
if ~isempty(idx)
    latency(idx) = 60;
end
clear all_info

%% Daily mean data collection
ntrial = size(latency,1);
ndate = ntrial/4;
nmice = size(latency,2);

daily_latency = zeros(length(nmice));
daily_meandistance = zeros(length(nmice));
daily_totaldistance = zeros(length(nmice));
daily_speed = zeros(length(nmice));

for idate = 1:ndate
    for imice = 1:nmice
    daily_latency(idate,imice) = mean(latency(4*idate-3:4*idate,imice));
    daily_distance(idate,imice) = mean(distance(4*idate-3:4*idate,imice));
    daily_meandistance(idate,imice) = mean(meandistance(4*idate-3:4*idate,imice));
    daily_totaldistance(idate,imice) = mean(totaldistance(4*idate-3:4*idate,imice));
    daily_speed(idate,imice) = mean(speed(4*idate-3:4*idate,imice));
    end
end

%% Save data
raw.latency = latency;
raw.dist2target = distance;
raw.meandist2target = meandistance;
raw.disttotal = totaldistance;
raw.speed = speed;

day.latency = daily_latency;
day.dist2target = daily_distance;
day.meandist2target = daily_meandistance;
day.disttotal = daily_totaldistance;
day.speed = daily_speed;

if regexp(filename,'Rbp4');
    save(['total_data_DG','.mat'],...
        'raw','day');
elseif regexp(filename,'Grik4');
    save(['total_data_CA3','.mat'],...
        'raw','day');
else regexp(filename,'Camk2a');
    save(['total_data_CA1','.mat'],...
        'raw','day');
end

end