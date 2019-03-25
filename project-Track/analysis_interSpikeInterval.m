function analysis_interSpikeInterval

[tData, tList] = tLoad;
nCell = length(tList);

for iCell = 1:nCell
    disp(['### Analyzing ',tList{iCell},'...']);
    [cellPath,cellName,~] = fileparts(tList{iCell});
    cd(cellPath);
    
    load('Events.mat');
    spikeData = tData{iCell};
    
    isi = cell(3,1);
    isi{1} = diff(spikeData(sensor.S1(1)<=spikeData & spikeData<sensor.S12(30)))';
    isi{2} = diff(spikeData(sensor.S1(31)<=spikeData & spikeData<sensor.S12(60)))';
    isi{3} = diff(spikeData(sensor.S1(61)<=spikeData & spikeData<sensor.S12(90)))';
    
    idx_empty1 = cellfun('isempty',isi);
    isi(idx_empty1) = {[0]};
    
    binS = 0:1:40; % 1 ms, 40 bins
    binL = 0:1:1000; % 1ms, 1000 bins
    
    temp_histS = (cellfun(@(x) histc(x,binS),isi,'UniformOutput',0));
    temp_sum = cellfun(@sum,temp_histS);
    
    isi_histS = cell(3,1);
    
    for iBlock = 1:3
        if temp_sum(iBlock) == 0
           isi_histS{iBlock,1} = NaN;
        else
            isi_histS{iBlock,1} = temp_histS{iBlock}/nansum([temp_histS{:}]);
        end            
    end
%     idx_empty2 = cellfun('isempty',temp_histS);
%     temp_histS(idx_empty2) = {NaN};
    
%     isi_histS = gdivide(temp_histS,nansum([temp_histS{:}]));
%     temp_histS(~idxEmpty,:) = temp_histS2;
%     temp_histS(idxEmpty,:) = NaN(1,41);
    disp('ok');
%     isi_histS = gdivide(temp_histS,sum([temp_histS{:}]));
    
%     temp_histL = cellfun(@(x) histc(x,binL),isi,'UniformOutput',0);
%     isi_histL = gdivide(temp_histS,sum([temp_histS{:}]));
    
%     save([cellName,'.mat'],'isi_histS','isi_histL','-append');
end
disp('### Ananlysis: inter-spike interval is done! ###');