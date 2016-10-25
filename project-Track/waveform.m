function waveform()
%%%%%%%%%%%%%%%%%%% spikewave();
% Purpose: The function extract information about waveforms of the cell
% 1st author: DK
% 2nd edit: Jun
% Last modified: 4. 20. 2015
%%%%%%%%%%%%%%%%%%%
%% Load t files
[ttfile, nCell]= tfilecollector();

for icell = 1:nCell
    [cellPath,cellname,~] = fileparts(ttfile{icell});
    ttname = strsplit(cellname,'_');
    cd(cellPath);
    fileParts = strsplit(cellPath,'\');
    
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
    [vlamp,vlidx] = min(spkwv(maintt,pkidx:end));
    vlidx = pkidx + vlidx - 1;
    spkwth = 1000*(vlidx - pkidx)/32; % unit: us
    spkpvr = pkamp/-vlamp;
    hfvl = vlamp/2;
    hfvlfst = find(spkwv(maintt,pkidx:vlidx)<=hfvl,1,'first')+pkidx-1;
    hfvllst = find(spkwv(maintt,vlidx:end)<=hfvl,1,'last')+vlidx-1;
    hfvl1 = (hfvlfst-1) + (spkwv(maintt,hfvlfst-1)-hfvl)/(spkwv(maintt,hfvlfst-1)-spkwv(maintt,hfvlfst));
    if hfvllst<32
        hfvl2 = hfvllst + (hfvl-spkwv(maintt,hfvllst))/(spkwv(maintt,hfvllst+1)-spkwv(maintt,hfvllst));
        hfvwth = 1000*(hfvl2-hfvl1)/32;    
    else
        hfvwth = 1000*(vlidx-hfvl1)*2/32;
    end
    
%% Save file    
    save([cellname,'.mat'],'spkwv','spkwth','spkpvr','hfvwth','-append');
end
disp('Waveform calculation is done!');