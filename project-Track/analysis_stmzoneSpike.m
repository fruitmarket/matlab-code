function analysis_stmzoneSpike()

% Load files
[tData, tList] = tLoad;
nCell = length(tList);
load('Events.mat','sensor','preTime','stmTime','postTime');

% align spike time to position time
for iCell = 1:nCell
    disp(['### inzone total spike: ',tList{iCell},'...']);
    [cellPath,cellName,~] = fileparts(tList{iCell});
    cd(cellPath);
    if ~isempty(regexp(cellPath,'DRun','once')) | ~isempty(regexp(cellPath,'noRun','once'))
        sensorOn = sensor.S6;
        sensorOff = sensor.S9;
    else
        sensorOn = sensor.S10;
        sensorOff = sensor.S11;
    end
    spikeData = tData{iCell};

% Total spike
    spikeTimeTotal = spikePeriod(spikeData,sensor.S1,[sensor.S1(2:end);sensor.S12(end)]); 
    totalSpike = cellfun(@length, spikeTimeTotal);
    sum_totalSpike(1,1) = sum(totalSpike(1:30));
    sum_totalSpike(2,1) = sum(totalSpike(31:60));
    sum_totalSpike(3,1) = sum(totalSpike(61:90));
    
% Inzone spike    
    spikeTime = spikePeriod(spikeData, sensorOn, sensorOff);
    inzoneSpike = cellfun(@length,spikeTime);
    
    sum_inzoneSpike(1,1) = sum(inzoneSpike(1:30));
    sum_inzoneSpike(2,1) = sum(inzoneSpike(31:60));
    sum_inzoneSpike(3,1) = sum(inzoneSpike(61:90));
      
    m_inzoneSpike(1,1) = mean(inzoneSpike(1:30));
    m_inzoneSpike(2,1) = mean(inzoneSpike(31:60));
    m_inzoneSpike(3,1) = mean(inzoneSpike(61:90));
    
    std_inzoneSpike(1,1) = std(inzoneSpike(1:30));
    std_inzoneSpike(2,1) = std(inzoneSpike(31:60));
    std_inzoneSpike(3,1) = std(inzoneSpike(61:90));

% Outzone spike
    outzoneSpike(1:30,1) = totalSpike(1:30,1)-inzoneSpike(1:30,1);
    outzoneSpike(31:60,1) = totalSpike(31:60,1)-inzoneSpike(31:60,1);
    outzoneSpike(61:90,1) = totalSpike(61:90,1)-inzoneSpike(61:90,1);
    
    sum_outzoneSpike(1,1) = sum(outzoneSpike(1:30));
    sum_outzoneSpike(2,1) = sum(outzoneSpike(31:60));
    sum_outzoneSpike(3,1) = sum(outzoneSpike(61:90));
    
    m_outzoneSpike(1,1) = mean(outzoneSpike(1:30));
    m_outzoneSpike(2,1) = mean(outzoneSpike(31:60));
    m_outzoneSpike(3,1) = mean(outzoneSpike(61:90));
    
    std_outzoneSpike(1,1) = std(outzoneSpike(1:30));
    std_outzoneSpike(2,1) = std(outzoneSpike(31:60));
    std_outzoneSpike(3,1) = std(outzoneSpike(61:90));
% Statistics
    group = {'PRE','STM','POST'};
% Inzone
    [~, ~, stats_ttest_inSpk] = anova1([inzoneSpike(1:30),inzoneSpike(31:60),inzoneSpike(61:90)],group,'off');
    result_inSpk = multcompare(stats_ttest_inSpk,'Alpha',0.05,'CType','bonferroni','Display','off');
    p_ttest(:,1) = result_inSpk(:,end); % p-value of in-zone
% Outzome
    [~, ~, stats_ttest_outSpk] = anova1([outzoneSpike(1:30),outzoneSpike(31:60),outzoneSpike(61:90)],group,'off');
    result_outSpk = multcompare(stats_ttest_outSpk,'Alpha',0.05,'CType','bonferroni','Display','off');
    p_ttest(:,2) = result_outSpk(:,end); % p-value of out-zone
% Total
    [~, ~, stats_ttest_tSpk] = anova1([totalSpike(1:30),totalSpike(31:60),totalSpike(61:90)],group,'off');
    result_tSpk = multcompare(stats_ttest_tSpk,'Alpha',0.05,'CType','bonferroni','Display','off');
    p_ttest(:,3) = result_tSpk(:,end); % p-value of total-zone
    
% stay time in stm zone
    temp_dTime = sensorOff-sensorOn;
    diffTime = [mean(temp_dTime(1:30)), mean(temp_dTime(31:60)), mean(temp_dTime(61:90))]/mean(temp_dTime(1:30)); % normalized by PRE time
    timeIn_inzone = round(diffTime*100)/100;
    
    save([cellName,'.mat'],...
        'inzoneSpike','sum_inzoneSpike','m_inzoneSpike','std_inzoneSpike',...
        'outzoneSpike','sum_outzoneSpike','m_outzoneSpike','std_outzoneSpike',...
        'totalSpike','sum_totalSpike','p_ttest','timeIn_inzone','-append');
end
disp('### Calculating inzone total spike is done!')