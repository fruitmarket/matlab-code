clearvars;
load total_data_CA1;

%%%%%% Mice number
% CNO (Expressed): 2,5,6,7,8,9,19,22,23,24,26,29,30,38,39
% CNO (Total): 1~9,19,20,22~24,26~30,36~39

% DMSO (Expressed): 10,11,12,13,14,15,16,17,18,21,25,31,32,33,34
% DMSO (Total): 10~18,21,25, 31~35

% Group separation (CNO vs. DMSO)
idxCNO = [2,5:9,19,22:24,26,29,30,38,39];
idxDMSO = [10:18,21,25,31:34];

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
nDay = size(raw.CNO.latency,1)/4; % use day 1 to day 10
% nDay = size(raw.CNO.latency,1)/4-1; % use day 1 to day 9

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

for iDay = 1:nDay-1
    time2(4*iDay-3:4*iDay,1) = iDay;
end
timeCNO2 = repmat(time2,nCNO,1);
timeDMSO2 = repmat(time2,nDMSO,1);
timeTotal2 = repmat(time2,(nCNO+nDMSO),1);
G2 = [zeros(4*nCNO*9,1); ones(4*nDMSO*9,1)];

% use from day1 to day 9
% raw.CNO.latency = raw.CNO.latency(1:end-4,:);
% raw.DMSO.latency = raw.DMSO.latency(1:end-4,:);
% raw.CNO.disttotal = raw.CNO.disttotal(1:end-4,:);
% raw.DMSO.disttotal = raw.DMSO.disttotal(1:end-4,:);

% from day 1 to day 10
% [~,latencyPval,~,~] = aoctool(timeTotal,[raw.CNO.latency(:);raw.DMSO.latency(:)],G);
% CA1stats.latencyPval = cell2mat(latencyPval(4,6));
% CA1stats.latencydf = cell2mat(latencyPval(4,2));
% CA1stats.latencyE = cell2mat(latencyPval(5,2));
% CA1stats.latencyF = cell2mat(latencyPval(4,5));
% 
% from day 1 to day 10
% [~,disttotalPval,~,~] = aoctool(timeTotal,[raw.CNO.disttotal(:);raw.DMSO.disttotal(:)],G);
% CA1stats.disttotalPval = cell2mat(disttotalPval(4,6));
% CA1stats.disttotaldf = cell2mat(disttotalPval(4,2));
% CA1stats.disttotalE = cell2mat(disttotalPval(5,2));
% CA1stats.disttotalF = cell2mat(disttotalPval(4,5));

% from day 1 to day 9
[~,latencyPval,~,~] = aoctool(timeTotal2,[reshape(raw.CNO.latency(1:end-4,:),1,[])';reshape(raw.DMSO.latency(1:end-4,:),1,[])'],G2);
CA1stats.latencyPval = cell2mat(latencyPval(4,6));
CA1stats.latencydf = cell2mat(latencyPval(4,2));
CA1stats.latencyE = cell2mat(latencyPval(5,2));
CA1stats.latencyF = cell2mat(latencyPval(4,5));

% from day 1 to day 9
[~,disttotalPval,~,~] = aoctool(timeTotal2,[reshape(raw.CNO.disttotal(1:end-4,:),1,[])';reshape(raw.DMSO.disttotal(1:end-4,:),1,[])'],G2);
CA1stats.disttotalPval = cell2mat(disttotalPval(4,6));
CA1stats.disttotaldf = cell2mat(disttotalPval(4,2));
CA1stats.disttotalE = cell2mat(disttotalPval(5,2));
CA1stats.disttotalF = cell2mat(disttotalPval(4,5));

% from day 1 to day 10
% [~,meanlatencyPval,~,~] = aoctool(repmat([1:nDay]',(nCNO+nDMSO),1),[day.CNO.latency(:);day.DMSO.latency(:)],[zeros(nCNO*nDay,1);ones(nDMSO*nDay,1)]);
% from day 1 to day 9
[~,meanlatencyPval,~,~] = aoctool(repmat([1:9]',(nCNO+nDMSO),1),[reshape(day.CNO.latency(1:9,:),1,[]),reshape(day.DMSO.latency(1:9,:),1,[])],[zeros(nCNO*9,1);ones(nDMSO*9,1)]);


% Statics with raw data (trial based)
% CA1stats.rawregLatencyCNO = fitlm(timeCNO,raw.CNO.latency(:),'linear','RobustOpts','off');
% CA1stats.rawregLatencyDMSO = fitlm(timeDMSO,raw.DMSO.latency(:),'linear','RobustOpts','off');
% CA1stats.rawregDisttotalCNO = fitlm(timeCNO,raw.CNO.disttotal(:),'linear','RobustOpts','off');
% CA1stats.rawregDisttotalDMSO = fitlm(timeDMSO,raw.DMSO.disttotal(:),'linear','RobustOpts','off');
% [~,CA1stats.rawttestlatencyPval] = ttest2(reshape(raw.CNO.latency(end-3:end,:),1,[]),reshape(raw.DMSO.latency(end-3:end,:),1,[]),'Vartype','unequal'); % last day ttest (latency)
% [~,CA1stats.rawttestdisttotalPval] = ttest2(reshape(raw.CNO.disttotal(end-3:end,:),1,[]),reshape(raw.DMSO.disttotal(end-3:end,:),1,[]),'Vartype','unequal'); % last day ttest (distotal)

% Statics with raw data (trial based, from day 1 to day 9)
CA1stats.rawregLatencyCNO = fitlm(timeCNO2,reshape(raw.CNO.latency(1:end-4,:),1,[]),'linear','RobustOpts','off');
CA1stats.rawregLatencyDMSO = fitlm(timeDMSO2,reshape(raw.DMSO.latency(1:end-4,:),1,[]),'linear','RobustOpts','off');
CA1stats.rawregDisttotalCNO = fitlm(timeCNO2,reshape(raw.CNO.disttotal(1:end-4,:),1,[]),'linear','RobustOpts','off');
CA1stats.rawregDisttotalDMSO = fitlm(timeDMSO2,reshape(raw.DMSO.disttotal(1:end-4,:),1,[]),'linear','RobustOpts','off');
[~,CA1stats.rawttestlatencyPval] = ttest2(reshape(raw.CNO.latency(end-7:end-4,:),1,[]),reshape(raw.DMSO.latency(end-7:end-4,:),1,[]),'Vartype','unequal'); % last day ttest (latency)
[~,CA1stats.rawttestdisttotalPval] = ttest2(reshape(raw.CNO.disttotal(end-7:end-4,:),1,[]),reshape(raw.DMSO.disttotal(end-7:end-4,:),1,[]),'Vartype','unequal'); % last day ttest (distotal)

% Statics with mean data (day mean based) from day 1 to day 9
CA1stats.meanregLatencyCNO = fitlm(repmat((1:9)',nCNO,1),reshape(day.CNO.latency(1:9,:),1,[]),'linear','RobustOpts','off');
CA1stats.meanregLatencyDMSO = fitlm(repmat((1:9)',nDMSO,1),reshape(day.DMSO.latency(1:9,:),1,[]),'linear','RobustOpts','off');
CA1stats.meanregDisttotalCNO = fitlm(repmat((1:9)',nCNO,1),reshape(day.CNO.disttotal(1:9,:),1,[]),'linear','RobustOpts','off');
CA1stats.meanregDisttotalDMSO = fitlm(repmat((1:9)',nDMSO,1),reshape(day.DMSO.disttotal(1:9,:),1,[]),'linear','RobustOpts','off');
[~,CA1stats.meanttestlatencyPval] = ttest2(day.CNO.latency(end-1,:),day.DMSO.latency(end-1,:),'Vartype','unequal');
[~,CA1stats.meanttestdisttotalPval] = ttest2(day.CNO.disttotal(end-1,:),day.DMSO.disttotal(end-1,:),'Vartype','unequal');

% Statics with mean data (day mean based) from day 1 to day 10
% CA1stats.meanregLatencyCNO = fitlm(repmat((1:nDay)',nCNO,1),reshape(day.CNO.latency(1:nDay,:),1,[]),'linear','RobustOpts','off');
% CA1stats.meanregLatencyDMSO = fitlm(repmat((1:nDay)',nCNO,1),reshape(day.DMSO.latency(1:nDay,:),1,[]),'linear','RobustOpts','off');
% CA1stats.meanregDisttotalCNO = fitlm(repmat((1:nDay)',nCNO,1),reshape(day.CNO.disttotal(1:nDay,:),1,[]),'linear','RobustOpts','off');
% CA1stats.meanregDisttotalDMSO = fitlm(repmat((1:nDay)',nDMSO,1),reshape(day.DMSO.disttotal(1:nDay,:),1,[]),'linear','RobustOpts','off');
% [~,CA1stats.meanttestlatencyPval] = ttest2(day.CNO.latency(end,:),day.DMSO.latency(end,:),'Vartype','unequal');
% [~,CA1stats.meanttestdisttotalPval] = ttest2(day.CNO.disttotal(end,:),day.DMSO.disttotal(end,:),'Vartype','unequal');

% Save variables
CA1_raw = raw;
CA1_day = day;
CA1_fields = fields;
CA1_nDay = nDay;

save('MWM_Learning_CA1.mat','CA1_raw','CA1_day','CA1_fields','CA1_nDay','CA1stats');