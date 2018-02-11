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
    if regexp(cellPath,'Run')
        sensorOn = sensor.S6;
        sensorOff = sensor.S9;
        sensorOut_1 = sensor.S3;
        sensorOut_2 = sensor.S12;
    else
        sensorOn = sensor.S10;
        sensorOff = sensor.S11;
        sensorOut_1 = sensor.S4;
        sensorOut_2 = sensor.S5;
    end
    spikeData = tData{iCell};

% Total spike
    spikeTimeTotal = spikePeriod(spikeData,sensor.S1,[sensor.S1(2:end);sensor.S12(end)]); 
    totalSpike = cellfun(@length, spikeTimeTotal);
    sum_totalSpike(1) = sum(totalSpike(1:30));
    sum_totalSpike(2) = sum(totalSpike(31:60));
    sum_totalSpike(3) = sum(totalSpike(61:90));
    
% Inzone spike    
    spikeTime = spikePeriod(spikeData, sensorOn, sensorOff);
    inzoneSpike = cellfun(@length,spikeTime);
    
    sum_inzoneSpike(1) = sum(inzoneSpike(1:30));
    sum_inzoneSpike(2) = sum(inzoneSpike(31:60));
    sum_inzoneSpike(3) = sum(inzoneSpike(61:90));
      
    m_inzoneSpike(1) = mean(inzoneSpike(1:30));
    m_inzoneSpike(2) = mean(inzoneSpike(31:60));
    m_inzoneSpike(3) = mean(inzoneSpike(61:90));
    
    sem_inzoneSpike(1) = std(inzoneSpike(1:30))/sqrt(30);
    sem_inzoneSpike(2) = std(inzoneSpike(31:60))/sqrt(30);
    sem_inzoneSpike(3) = std(inzoneSpike(61:90))/sqrt(30);

% Outzone spike
    outzoneSpike = totalSpike-inzoneSpike;
    
    sum_outzoneSpike(1) = sum(outzoneSpike(1:30));
    sum_outzoneSpike(2) = sum(outzoneSpike(31:60));
    sum_outzoneSpike(3) = sum(outzoneSpike(61:90));
    
    m_outzoneSpike(1) = mean(outzoneSpike(1:30));
    m_outzoneSpike(2) = mean(outzoneSpike(31:60));
    m_outzoneSpike(3) = mean(outzoneSpike(61:90));
    
    sem_outzoneSpike(1) = std(outzoneSpike(1:30))/sqrt(30);
    sem_outzoneSpike(2) = std(outzoneSpike(31:60))/sqrt(30);
    sem_outzoneSpike(3) = std(outzoneSpike(61:90))/sqrt(30);
    
% Firing rate calculation
    lapTimeTotal = zeros(90,1);
    for iLap = 1:89
        lapTimeTotal(iLap) = sensor.S1(iLap+1)-sensor.S1(iLap);
    end
    lapTimeTotal(90) = sensor.S12(90)-sensor.S1(90);
    lapTimeInzone = sensorOff-sensorOn;
    lapTimeOutzone = lapTimeTotal-lapTimeInzone;

    lapFrInzone = inzoneSpike./lapTimeInzone*1000; % unit change: ms --> Hz
    m_lapFrInzone(1) = mean(lapFrInzone(1:30));
    m_lapFrInzone(2) = mean(lapFrInzone(31:60));
    m_lapFrInzone(3) = mean(lapFrInzone(61:90));
    sem_lapFrInzone(1) = std(lapFrInzone(1:30))/sqrt(30);
    sem_lapFrInzone(2) = std(lapFrInzone(31:60))/sqrt(30);
    sem_lapFrInzone(3) = std(lapFrInzone(61:90))/sqrt(30);

    lapFrOutzone = outzoneSpike./lapTimeOutzone*1000;
    m_lapFrOutzone(1) = mean(lapFrOutzone(1:30));
    m_lapFrOutzone(2) = mean(lapFrOutzone(31:60));
    m_lapFrOutzone(3) = mean(lapFrOutzone(61:90));
    sem_lapFrOutzone(1) = std(lapFrOutzone(1:30))/sqrt(30);
    sem_lapFrOutzone(2) = std(lapFrOutzone(31:60))/sqrt(30);
    sem_lapFrOutzone(3) = std(lapFrOutzone(61:80))/sqrt(30);

    lapFrTotal = totalSpike./lapTimeTotal*1000;
    m_lapFrTotalzone(1) = mean(lapFrTotal(1:30));
    m_lapFrTotalzone(2) = mean(lapFrTotal(31:60));
    m_lapFrTotalzone(3) = mean(lapFrTotal(61:90));
    sem_lapFrTotalzone(1) = std(lapFrTotal(1:30))/sqrt(30);
    sem_lapFrTotalzone(2) = std(lapFrTotal(31:60))/sqrt(30);
    sem_lapFrTotalzone(3) = std(lapFrTotal(61:80))/sqrt(30);
% Statistics
    group = {'PRE','STM','POST'};
    p_ttest(1,1) = ranksum(lapFrInzone(1:30),lapFrInzone(31:60));
    p_ttest(2,1) = ranksum(lapFrInzone(1:30),lapFrInzone(61:90));
    p_ttest(3,1) = ranksum(lapFrInzone(31:60),lapFrInzone(61:90));
    
    p_ttest(1,2) = ranksum(lapFrOutzone(1:30),lapFrOutzone(31:60));
    p_ttest(2,2) = ranksum(lapFrOutzone(1:30),lapFrOutzone(61:90));
    p_ttest(3,2) = ranksum(lapFrOutzone(31:60),lapFrOutzone(61:90));
    
    p_ttest(1,3) = ranksum(lapFrTotal(1:30),lapFrTotal(31:60));
    p_ttest(2,3) = ranksum(lapFrTotal(1:30),lapFrTotal(61:90));
    p_ttest(3,3) = ranksum(lapFrTotal(31:60),lapFrTotal(61:90));

%     [~,~,stats_inFr] = friedman([lapFrInzone(1:30),lapFrInzone(31:60),lapFrInzone(61:90)],1,'off');
%     [~,~,stats_inFr] = kruskalwallis([lapFrInzone(1:30),lapFrInzone(31:60),lapFrInzone(61:90)],group,'off');
%     result_inFr = multcompare(stats_inFr,'Display','off');
%     p_ttest(:,1) = result_inFr(:,end); % p-value of in-zone

%     [~,~,stats_outFr] = friedman([lapFrOutzone(1:30),lapFrOutzone(31:60),lapFrOutzone(61:90)],1,'off');    
%     [~,~,stats_outFr] = kruskalwallis([lapFrOutzone(1:30),lapFrOutzone(31:60),lapFrOutzone(61:90)],group,'off');
%     result_outFr = multcompare(stats_outFr,'Display','off');
%     p_ttest(:,2) = result_outFr(:,end); % p-value of in-zone
    
%     [~,~,stats_totalFr] = friedman([lapFrOutzone(1:30),lapFrOutzone(31:60),lapFrOutzone(61:90)],1,'off');    
%     [~,~,stats_totalFr] = kruskalwallis([lapFrTotal(1:30),lapFrTotal(31:60),lapFrTotal(61:90)],group,'off');
%     result_totalFr = multcompare(stats_totalFr,'Display','off');
%     p_ttest(:,3) = result_totalFr(:,end); % p-value of in-zone

%% Control-zone spike (half-half maze)
    if regexp(cellPath,'Run')
        spikeTimeCtrl = spikePeriod(spikeData, (sensor.S4+sensor.S5)/2, (sensor.S10+sensor.S11)/2);
        inzoneSpike_half = cellfun(@length,spikeTimeCtrl);
        outzoneSpike_half = totalSpike - inzoneSpike_half;
    else
        spikeTimeCtrl = spikePeriod(spikeData, (sensor.S7+sensor.S8)/2, ([sensor.S1(2:end);sensor.S12(end)]+[sensor.S2(2:end);sensor.S12(end)])/2);
        inzoneSpike_half = cellfun(@length,spikeTimeCtrl);
        outzoneSpike_half = totalSpike - inzoneSpike_half;
    end

% stay time in stm zone
    temp_dTime = sensorOff-sensorOn;
    diffTime = [mean(temp_dTime(1:30)), mean(temp_dTime(31:60)), mean(temp_dTime(61:90))]/mean(temp_dTime(1:30)); % normalized by PRE time
    timeIn_inzone = round(diffTime*100)/100;
    
    save([cellName,'.mat'],...
        'inzoneSpike','sum_inzoneSpike','m_inzoneSpike','sem_inzoneSpike',...
        'outzoneSpike','sum_outzoneSpike','m_outzoneSpike','sem_outzoneSpike','totalSpike','sum_totalSpike',...
        'm_lapFrInzone','m_lapFrOutzone','m_lapFrTotalzone','inzoneSpike_half','outzoneSpike_half',...
        'lapFrInzone','lapFrOutzone','lapFrTotal',...
        'p_ttest','timeIn_inzone','-append');
end
disp('### Calculating inzone total spike is done!')