function spikewave()
%%%%%%%%%%%%%%%%%%% spikewave();
% Purpose: The function extract information about waveforms of the cell
% 1st author: DK
% 2nd author: Jun
% Last modified: 4. 20. 2015
%%%%%%%%%%%%%%%%%%%
%% Load t files
[ttfile, ncell]= tfilecollector();

for icell = 1:ncell
    [cellpath,cellname,~] = fileparts(ttfile{icell});
    ttname = strsplit(cellname,'_');
    cd(cellpath);
    
    %% Input range
    nttfile = fopen([ttname{1},'.ntt']);
    volts = fgetl(nttfile);
    while ~strncmp(volts,'-ADBitVolts',11)
        volts = fgetl(nttfile);
    end
    volttemp = strsplit(volts,' ');
    bitvolt = zeros(1,4);
    for ich = 1:4
        bitvolt(ich) = str2num(volttemp{ich+1});
    end
    
    %% Waveform
    load([ttname{1},'.clusters'],'-mat','MClust_Clusters');
    spk_idx = FindInCluster(MClust_Clusters{str2num(ttname{2})});
    [~,wv] = LoadTT_NeuralynxNT([ttname{1},'.ntt']);
    cellwv = wv(spk_idx,:,:);
    spkwv = zeros(4,32);
    for itt = 1:4
        spkwv(itt,:) = squeeze(mean(cellwv(:,itt,:)));
    end
    spkwv = (10^6)*diag(bitvolt)*spkwv; % Unit: uV
    
    %% Waveform feature
    [~,maintt] = max(max(spkwv'));
    [pkamp,pkidx] = max(spkwv(maintt,:));
    [vlamp,vlidx] = min(spkwv(maintt,:));
    spkwth = 1000*(vlidx - pkidx)/32; % unit: us
    spkpvr = pkamp/-vlamp; % peak vally ratio
    
%% Save file    
    save([cellname,'.mat'],...
        'spkwv','spkwth','spkpvr',...
        '-append');
end