function waveform_correlation
%waveform_correlation

% Variable nspv, nssom, and wssom will be used.
load('C:\Users\Lapis\OneDrive\project\workingmemory_interneuron\data\celllist_neuron.mat');

stat_nspv = wvform_load(nspv);
stat_wspv = wvform_load(wspv);
stat_nssom = wvform_load(nssom);
stat_wssom = wvform_load(wssom);

save('waveform_correlation_20160526.mat', 'stat_nspv', 'stat_wspv', 'stat_nssom', 'stat_wssom');

function stats = wvform_load(mFile)
lightwin = [0 20]; % ms
sponwin = [-400 0]; % ms

preext1 = '.mat';
preext2 = '_\d.mat';
curext1 = '.clusters';
curext2 = '.ntt';
curext3 = '.t';

predir = 'C:\\Users\\Lapis\\OneDrive\\project\\workingmemory_interneuron\\data\\';
curdir = 'D:\\Cheetah_data\\workingmemory_interneuron\\';
mFile = cellfun(@(x) regexprep(x,predir,curdir),mFile,'UniformOutput',false);

tFile = cellfun(@(x) regexprep(x,preext1,curext3), mFile, 'UniformOutput',false);
cFile = cellfun(@(x) regexprep(x,preext2,curext1), mFile, 'UniformOutput',false);
ntFile = cellfun(@(x) regexprep(x,preext2,curext2), mFile, 'UniformOutput',false);
eFile = cellfun(@(x) [fileparts(x),'\Events.mat'], mFile, 'UniformOutput',false);

spdata = LoadSpikes(tFile,'tsflag','ts');

nC = length(mFile);
r = zeros(nC,1);
[m_spont_wv, m_evoked_wv] = deal(cell(1, 4));
for iTT = 1:4
    m_spont_wv{iTT} = zeros(nC, 32);
    m_evoked_wv{iTT} = zeros(nC, 32);
end


for iC = 1:nC
    % Load waveform of single cluster
    [cellpath,cellname,~] = fileparts(mFile{iC});
    ttname = regexp(cellname,'_','split');
    
    load(cFile{iC}, '-mat', 'MClust_Clusters');
    spk_idx = FindInCluster(MClust_Clusters{str2num(ttname{2})});
    [~,wv] = LoadTT_NeuralynxNT(ntFile{iC});
    
    cellwv = wv(spk_idx,:,:);
    
    % Get input range
    nttfile = fopen(ntFile{iC});
    
    volts = fgetl(nttfile);
    while ~strncmp(volts,'-ADBitVolts',11)
        volts = fgetl(nttfile);
    end
    volttemp = strsplit(volts,' ');
    bitvolt = zeros(1,4);
    for ich = 1:4
        bitvolt(ich) = str2num(volttemp{ich+1});
    end
    
    fclose(nttfile);
    
    % Find highest peak channel
    load([cellpath,'\',ttname{1},'_Peak.fd'],'-mat', 'FeatureData');
    [~,maintt] = max(mean(FeatureData(spk_idx,:)));
    
    % Load spike time
    cellspk = Data(spdata{iC})/10;
    nspk = length(cellspk);
    
    % Load light time
    load(eFile{iC}, 'lighttime');
    lighttime = lighttime / 1000;
    nT = length(lighttime);
    
    % Find spike within the range of light stimulation
    spont_idx = zeros(nspk,1);
    evoked_idx = zeros(nspk,1);
    for iT = 1:nT
        [~,spont_temp] = histc(cellspk, lighttime(iT)+sponwin);
        [~,evoked_temp] = histc(cellspk,lighttime(iT)+lightwin);
        spont_idx(spont_temp==1) = 1;
        evoked_idx(find(evoked_temp==1, 1, 'first')) = 1;
    end
    
    % Get mean waveform
    spont_wv = cellwv(logical(spont_idx),:,:);
    evoked_wv = cellwv(logical(evoked_idx),:,:);
    
    for iTT = 1:4
        m_spont_wv{iTT}(iC,:) = (10^6)*bitvolt(iTT)*squeeze(mean(spont_wv(:,iTT,:)));
        m_evoked_wv{iTT}(iC,:) = (10^6)*bitvolt(iTT)*squeeze(mean(evoked_wv(:,iTT,:)));
    end
    
    rtemp = corrcoef(m_spont_wv{maintt}(iC,:)',m_evoked_wv{maintt}(iC,:)');  
    r(iC) = rtemp(1,2);
end

stats = table(r, m_spont_wv{1}, m_spont_wv{2}, m_spont_wv{3}, m_spont_wv{4}, ...
    m_evoked_wv{1}, m_evoked_wv{2}, m_evoked_wv{3}, m_evoked_wv{4}, ...
    'VariableNames', {'r', 's1', 's2', 's3', 's4', 'e1', 'e2', 'e3', 'e4'});