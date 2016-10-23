clearvars;
load total_data_DG;

%%%%%% Mice number
%%% DMSO: 10-18 / CNO: 1-9 
% CNO (Expressed): 1,2,3,4,5,9,19,20,22,23,24,25
% CNO (Total):1~9,19~25

% DMSO (Expressed): 10,12,14,16,17,18,26~30
% DMSO (Total): 10~18, 26,30

idxCNO = [1:5,9,19,20,22,23,24,25];
idxDMSO = [10,12,14,16,17,18,26:30];

nCNO = length(idxCNO);
nDMSO = length(idxDMSO);

fields = fieldnames(raw);

for iField = 1:numel(fields)
    raw.CNO.(fields{iField}) = raw.(fields{iField})(:,idxCNO);
    raw.DMSO.(fields{iField}) = raw.(fields{iField})(:,idxDMSO);
    
    day.CNO.(fields{iField}) = day.(fields{iField})(:,idxCNO);
    day.DMSO.(fields{iField}) = day.(fields{iField})(:,idxDMSO);
end

% Calculating Mean & SEM
nDay = size(raw.CNO.latency,1)/4;

for iField = 1:numel(fields)
    day.CNO.MS.(fields{iField}) = [mean(day.CNO.(fields{iField}),2), std(day.CNO.(fields{iField}),1,2)/sqrt(nCNO)];
    day.DMSO.MS.(fields{iField}) = [mean(day.DMSO.(fields{iField}),2), std(day.DMSO.(fields{iField}),1,2)/sqrt(nDMSO)];
end

% Calculating Regression
for iDay = 1:nDay
    time(4*iDay-3:4*iDay,1) = iDay;
end

timeCNO = repmat(time,nCNO,1);
timeDMSO = repmat(time,nDMSO,1);
timeTotal = repmat(time,(nCNO+nDMSO),1);
G = [zeros(4*nCNO*nDay,1); ones(4*nDMSO*nDay,1)];

[~,latencyPval,~,~] = aoctool(timeTotal,[raw.CNO.latency(:);raw.DMSO.latency(:)],G);
DGstats.latencyPval = cell2mat(latencyPval(4,6));
DGstats.df = cell2mat(latencyPval(4,2));
DGstats.E = cell2mat(latencyPval(5,2));
DGstats.F = cell2mat(latencyPval(4,5));

[~,disttotalPval,~,~] = aoctool(timeTotal,[raw.CNO.disttotal(:);raw.DMSO.disttotal(:)],G);
DGstats.disttotalPval = cell2mat(disttotalPval(4,6));
DGstats.df = cell2mat(disttotalPval(4,2));
DGstats.E = cell2mat(disttotalPval(5,2));
DGstats.F = cell2mat(disttotalPval(4,5));

% Statisc with raw data (trial based)
DGstats.rawregLatencyCNO = fitlm(timeCNO,raw.CNO.latency(:),'linear','RobustOpts','off');
DGstats.rawregLatencyDMSO = fitlm(timeDMSO,raw.DMSO.latency(:),'linear','RobustOpts','off');
DGstats.rawregDisttotalCNO = fitlm(timeCNO,raw.CNO.disttotal(:),'linear','RobustOpts','off');
DGstats.rawregDisttotalDMSO = fitlm(timeDMSO,raw.DMSO.disttotal(:),'linear','RobustOpts','off');
[~,DGstats.rawttestlatencyPval] = ttest2(reshape(raw.CNO.latency(end-11:end-8,:),1,[]),reshape(raw.DMSO.latency(end-11:end-8,:),1,[]),'Vartype','unequal'); % ttest on day 7 (latency)
[~,DGstats.rawttestdisttotalPval] = ttest2(reshape(raw.CNO.disttotal(end-11:end-8,:),1,[]),reshape(raw.DMSO.disttotal(end-11:end-8,:),1,[]),'Vartype','unequal'); % ttest on day 7 (distotal)

% Statics with mean data (day mean based)
DGstats.meanregLatencyCNO = fitlm(repmat((1:nDay)',nCNO,1),day.CNO.latency(:),'linear','RobustOpts','off');
DGstats.meanregLatencyDMSO = fitlm(repmat((1:nDay)',nDMSO,1),day.DMSO.latency(:),'linear','RobustOpts','off');
DGstats.meanregDisttotalCNO = fitlm(repmat((1:nDay)',nCNO,1),day.CNO.disttotal(:),'linear','RobustOpts','off');
DGstats.meanregDisttotalDMSO = fitlm(repmat((1:nDay)',nDMSO,1),day.DMSO.disttotal(:),'linear','RobustOpts','off');
[~,DGstats.meanttestlatencyPval] = ttest2(day.CNO.latency(end,:),day.DMSO.latency(end,:),'Vartype','unequal');
[~,DGstats.meanttestdisttotalPval] = ttest2(day.CNO.disttotal(end,:),day.DMSO.disttotal(end,:),'Vartype','unequal');

% Save variables
DG_raw = raw;
DG_day = day;
DG_fields = fields;
DG_nDay = nDay;

save('MWM_Learning_DG.mat','DG_raw','DG_day','DG_fields','DG_nDay','DGstats');