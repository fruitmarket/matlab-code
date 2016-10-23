clearvars;
load total_data_CA3;

%%%%%% Mice number
%%% DMSO: 1-4, 9-12 / CNO: 5-8, 13-17
% CNO (Expressed): 5,6,7,8,13,14,15,17,22:29 (from 22:29, not measured Oct,23)
% CNO (Total): 5:8,13:17,22:29

% DMSO (Expressed): 2,3,4,10,11,12,18,19,20,21,30,31,32,33
% DMSP (Total): 1:4,9:12,18:21,30:33

% Group separation (CNO vs. DMSO)
idxCNO = [5:8,13:15,17,22:29];
idxDMSO = [2:4,10:12,18:21,30:33];

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

% for day 1 to day 9
for iDay = 1:nDay-1
    time2(4*iDay-3:4*iDay,1) = iDay;
end
timeCNO2 = repmat(time2,nCNO,1);
timeDMSO2 = repmat(time2,nDMSO,1);
timeTotal2 = repmat(time2,(nCNO+nDMSO),1);
G2 = [zeros(4*nCNO*9,1); ones(4*nDMSO*9,1)];

% [~,latencyPval,~,~] = aoctool(timeTotal,[raw.CNO.latency(:);raw.DMSO.latency(:)],G);
% CA3stats.latencyPval = cell2mat(latencyPval(4,6));
% CA3stats.latencydf = cell2mat(latencyPval(4,2));
% CA3stats.latencyE = cell2mat(latencyPval(5,2));
% CA3stats.latencyF = cell2mat(latencyPval(4,5));
% 
% [~,disttotalPval,~,~] = aoctool(timeTotal,[raw.CNO.disttotal(:);raw.DMSO.disttotal(:)],G);
% CA3stats.disttotalPval = cell2mat(disttotalPval(4,6));
% CA3stats.disttotaldf = cell2mat(disttotalPval(4,2));
% CA3stats.disttotalE = cell2mat(disttotalPval(5,2));
% CA3stats.disttotalF = cell2mat(disttotalPval(4,5));

[~,latencyPval,~,~] = aoctool(timeTotal2,[reshape(raw.CNO.latency(1:end-4,:),1,[])';reshape(raw.DMSO.latency(1:end-4,:),1,[])'],G2);
CA3stats.latencyPval = cell2mat(latencyPval(4,6));
CA3stats.latencydf = cell2mat(latencyPval(4,2));
CA3stats.latencyE = cell2mat(latencyPval(5,2));
CA3stats.latencyF = cell2mat(latencyPval(4,5));

% from day 1 to day 9
[~,disttotalPval,~,~] = aoctool(timeTotal2,[reshape(raw.CNO.disttotal(1:end-4,:),1,[])';reshape(raw.DMSO.disttotal(1:end-4,:),1,[])'],G2);
CA3stats.disttotalPval = cell2mat(disttotalPval(4,6));
CA3stats.disttotaldf = cell2mat(disttotalPval(4,2));
CA3stats.disttotalE = cell2mat(disttotalPval(5,2));
CA3stats.disttotalF = cell2mat(disttotalPval(4,5));

% for day 1 to day 10
% [~,meanlatencyPval,~,~] = aoctool(repmat([1:nDay]',(nCNO+nDMSO),1),[day.CNO.latency(:);day.DMSO.latency(:)],[zeros(nCNO*nDay,1);ones(nDMSO*nDay,1)]);
% for day 1 to day 9
[~,meanlatencyPval,~,~] = aoctool(repmat([1:9]',(nCNO+nDMSO),1),[reshape(day.CNO.latency(1:9,:),1,[]),reshape(day.DMSO.latency(1:9,:),1,[])],[zeros(nCNO*9,1);ones(nDMSO*9,1)]);


% Statisc with raw data (trial based)
% CA3stats.rawregLatencyCNO = fitlm(timeCNO,raw.CNO.latency(:),'linear','RobustOpts','off');
% CA3stats.rawregLatencyDMSO = fitlm(timeDMSO,raw.DMSO.latency(:),'linear','RobustOpts','off');
% CA3stats.rawregDisttotalCNO = fitlm(timeCNO,raw.CNO.disttotal(:),'linear','RobustOpts','off');
% CA3stats.rawregDisttotalDMSO = fitlm(timeDMSO,raw.DMSO.disttotal(:),'linear','RobustOpts','off');
% [~,CA3stats.rawttestlatencyPval] = ttest2(reshape(raw.CNO.latency(end-3:end,:),1,[]),reshape(raw.DMSO.latency(end-3:end,:),1,[]),'Vartype','unequal');
% [~,CA3stats.rawttestdisttotalPval] = ttest2(reshape(raw.CNO.disttotal(end-3:end,:),1,[]),reshape(raw.DMSO.disttotal(end-3:end,:),1,[]),'Vartype','unequal');

% Statics with raw data (trial based, from day 1 to day 9)
CA3stats.rawregLatencyCNO = fitlm(timeCNO2,reshape(raw.CNO.latency(1:end-4,:),1,[]),'linear','RobustOpts','off');
CA3stats.rawregLatencyDMSO = fitlm(timeDMSO2,reshape(raw.DMSO.latency(1:end-4,:),1,[]),'linear','RobustOpts','off');
CA3stats.rawregDisttotalCNO = fitlm(timeCNO2,reshape(raw.CNO.disttotal(1:end-4,:),1,[]),'linear','RobustOpts','off');
CA3stats.rawregDisttotalDMSO = fitlm(timeDMSO2,reshape(raw.DMSO.disttotal(1:end-4,:),1,[]),'linear','RobustOpts','off');
[~,CA3stats.rawttestlatencyPval] = ttest2(reshape(raw.CNO.latency(end-7:end-4,:),1,[]),reshape(raw.DMSO.latency(end-7:end-4,:),1,[]),'Vartype','unequal'); % last day ttest (latency)
[~,CA3stats.rawttestdisttotalPval] = ttest2(reshape(raw.CNO.disttotal(end-7:end-4,:),1,[]),reshape(raw.DMSO.disttotal(end-7:end-4,:),1,[]),'Vartype','unequal'); % last day ttest (distotal)

% Statics with mean data (day mean based)
% CA3stats.meanregLatencyCNO = fitlm(repmat((1:nDay)',nCNO,1),reshape(day.CNO.latency(1:nDay,:),1,[]),'linear','RobustOpts','off');
% CA3stats.meanregLatencyDMSO = fitlm(repmat((1:nDay)',nDMSO,1),reshape(day.DMSO.latency(1:nDay,:),1,[]),'linear','RobustOpts','off');
% CA3stats.meanregDisttotalCNO = fitlm(repmat((1:nDay)',nCNO,1),reshape(day.CNO.disttotal(1:nDay,:),1,[]),'linear','RobustOpts','off');
% CA3stats.meanregDisttotalDMSO = fitlm(repmat((1:nDay)',nDMSO,1),reshape(day.DMSO.disttotal(1:nDay,:),1,[]),'linear','RobustOpts','off');
% [~,CA3stats.meanttestlatencyPval] = ttest2(day.CNO.latency(end,:),day.DMSO.latency(end,:),'Vartype','unequal');
% [~,CA3stats.meanttestdisttotalPval] = ttest2(day.CNO.disttotal(end,:),day.DMSO.disttotal(end,:),'Vartype','unequal');

% Statics with mean data (day mean based) from day 1 to day 9
CA3stats.meanregLatencyCNO = fitlm(repmat((1:9)',nCNO,1),reshape(day.CNO.latency(1:9,:),1,[]),'linear','RobustOpts','off');
CA3stats.meanregLatencyDMSO = fitlm(repmat((1:9)',nDMSO,1),reshape(day.DMSO.latency(1:9,:),1,[]),'linear','RobustOpts','off');
CA3stats.meanregDisttotalCNO = fitlm(repmat((1:9)',nCNO,1),reshape(day.CNO.disttotal(1:9,:),1,[]),'linear','RobustOpts','off');
CA3stats.meanregDisttotalDMSO = fitlm(repmat((1:9)',nDMSO,1),reshape(day.DMSO.disttotal(1:9,:),1,[]),'linear','RobustOpts','off');
[~,CA3stats.meanttestlatencyPval] = ttest2(day.CNO.latency(end-1,:),day.DMSO.latency(end-1,:),'Vartype','unequal');
[~,CA3stats.meanttestdisttotalPval] = ttest2(day.CNO.disttotal(end-1,:),day.DMSO.disttotal(end-1,:),'Vartype','unequal');

% Save variables
CA3_raw = raw;
CA3_day = day;
CA3_fields = fields;
CA3_nDay = nDay;

save('MWM_Learning_CA3.mat','CA3_raw','CA3_day','CA3_fields','CA3_nDay','CA3stats');