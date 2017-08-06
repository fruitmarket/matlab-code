function analysis_stmzoneSpike()

% Load files
[tData, tList] = tLoad;
nCell = length(tList);
load('Events.mat','sensor','preTime','stmTime','postTime');

% align spike time to position time
for iCell = 1:nCell
    disp(['### StmZone total spike: ',tList{iCell},'...']);
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
    totalSpikeNum(1,1) = sum(totalSpike(1:30));
    totalSpikeNum(2,1) = sum(totalSpike(31:60));
    totalSpikeNum(3,1) = sum(totalSpike(61:90));
    
% STM zone spike    
    spikeTime = spikePeriod(spikeData, sensorOn, sensorOff);
    inzoneSpike = cellfun(@length,spikeTime);
    
    inzoneSpikeNum(1,1) = sum(inzoneSpike(1:30));
    inzoneSpikeNum(2,1) = sum(inzoneSpike(31:60));
    inzoneSpikeNum(3,1) = sum(inzoneSpike(61:90));
      
    m_stmzoneSpike(1,1) = mean(inzoneSpike(1:30));
    m_stmzoneSpike(2,1) = mean(inzoneSpike(31:60));
    m_stmzoneSpike(3,1) = mean(inzoneSpike(61:90));
    
    std_stmzoneSpike(1,1) = std(inzoneSpike(1:30));
    std_stmzoneSpike(2,1) = std(inzoneSpike(31:60));
    std_stmzoneSpike(3,1) = std(inzoneSpike(61:90));

% Outzone spike
    outzoneSpike(1:30,1) = totalSpike(1:30,1)-inzoneSpike(1:30,1);
    outzoneSpike(31:60,1) = totalSpike(31:60,1)-inzoneSpike(31:60,1);
    outzoneSpike(61:90,1) = totalSpike(61:90,1)-inzoneSpike(61:90,1);
    
    outzoneSpikeNum(1,1) = sum(outzoneSpike(1:30));
    outzoneSpikeNum(2,1) = sum(outzoneSpike(31:60));
    outzoneSpikeNum(3,1) = sum(outzoneSpike(61:90));
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
    timeIn_stmZone = round(diffTime*100)/100;
    
    save([cellName,'.mat'],'inzoneSpike','inzoneSpikeNum','m_stmzoneSpike','std_stmzoneSpike','timeIn_stmZone','totalSpike','totalSpikeNum','outzoneSpike','outzoneSpikeNum','p_ttest','-append');
end
disp('### Calculating stmzone total spike is done!')