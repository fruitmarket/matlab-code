function burstIdx()
% Calculate burst index based on each neuron's ISI.
%
%   Requirement: tLoad
%   Burst is calculated based on Hyunjung's paper. Proportion of ISI lower
%   than one-quarter of mean ISI.
%
%   Author: Joonyeup Lee
%   Version 1.0 (6. 8. 2016)

[tData, tList] = tLoad;
nCell = length(tList);

for iCell = 1:nCell
    [cellPath, cellName, ~] = fileparts(tList{iCell});
    disp(['### Analyzing ',tList{iCell},' ...']);
    cd(cellPath);
    
    load('Events.mat','taskTime');
    spkData = tData{iCell};
    
    spkIdx = (taskTime(1) < spkData & spkData < taskTime(2));
    spkISI = diff(spkData(spkIdx));
    burstIdx = length(find(spkISI<mean(spkISI)/4))/length(spkISI);
    
    save([cellName, '.mat'],'burstIdx','-append');
end

disp('### Burst index calculation is done!');
end