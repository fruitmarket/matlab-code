function analysis_spectrumSpace
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% analysis_spectrumSpace
% The function calculates spectrogram for both time domain and space domain
% wavelet toolbox is required
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% variables
winSpace = [0,124];
nBin = 125;
binSize = 1; % 1cm
Fs = 2000;
F = 1:2:200;
load('Events.mat','sensor');

nLap = length(sensor.S1);
timeTask = [sensor.S1(1), sensor.S12(end)];

[vtTime, vtPosition, ~] = vtLoad;
vtTime = vtTime{1};
vtTimeTask = vtTime(timeTask(1)<=vtTime & vtTime<=timeTask(2));
[linearDist, theta, ~, eventPosition, refIndex, ~] = track2linear(vtPosition{1}(:,1), vtPosition{1}(:,2), vtTime, sensor.S1, timeTask,  winSpace, binSize);

[timestamp, sample, cscList] = cscLoad;
timestamp = timestamp{1};
cscTimeTask = timestamp(timeTask(1)<=timestamp & timestamp<=timeTask(2));

if isempty(cscList); return; end
nCSC = length(cscList);

% eliminate abnormal position data (wrong diode detection)
speedTime = filloutliers(diff(linearDist)./diff(vtTimeTask)*1000,'center');
speedTime(end+1) = speedTime(end);
refIndex_OnOff = [refIndex, [refIndex(2:end)-1;size(speedTime,1)]];

speedSpace = zeros(nLap,nBin);
for iLap = 1:nLap
    for iBin = 1:nBin
        [~,~,binCounts] = histcounts(theta(refIndex_OnOff(iLap,1):refIndex_OnOff(iLap,2)),125);
        speedSpace(iLap,iBin) = mean(speedTime(binCounts == iBin));
    end
end

% find index for new lap start
[~,~,idxTask] = histcounts(cscTimeTask,length(vtTimeTask));
[newTimeTask, newPositionTrack] = deal(zeros(length(idxTask),1));
for iIndex = 1:length(idxTask)
    newTimeTask(iIndex,1) = vtTimeTask(idxTask(iIndex));
    newPositionTrack(iIndex,1) = linearDist(idxTask(iIndex));
end
idxLapOnOff = zeros(nLap,2);
for iLap = 1:nLap
    idxLapOnOff(iLap,1) = find(newPositionTrack-eventPosition(iLap)>=0,1,'first');
end
idxLapOnOff = [idxLapOnOff(:,1), [idxLapOnOff(2:end,1)-1;length(newPositionTrack)]];

for iCSC = 1:nCSC
    disp(['### CSC analysis: ',cscList{iCSC}]);
    [~, cscName, ~] = fileparts(cscList{iCSC});
    
    cscRaw_Task = sample{iCSC}(timeTask(1)<=timestamp & timestamp<=timeTask(2));

% Time to space binning
    idx_binSpace = cell(90,1);
    for iLap = 1:nLap
        [~, ~, temp_idx] = histcounts(newPositionTrack(idxLapOnOff(iLap,1):idxLapOnOff(iLap,2)),125);
        idx_binSpace{iLap,1} = temp_idx;
    end

    %% Wavelet analysis
    coef = cell(90,1);
    temp_wvLetSpace = cell(90,1);
    temp_wv = zeros(size(F,2),nBin);

    for iLap = 1:nLap
        coef{iLap,1} = cwt(cscRaw_Task(idxLapOnOff(iLap,1):idxLapOnOff(iLap,2)),centfrq('cmor1-1')*Fs./F,'cmor1-1');
    end
    wvLetTime = cellfun(@abs,coef,'UniformOutput',false);

    for iLap = 1:nLap
        for iBin = 1:nBin
            temp_wv(:,iBin) = nanmean(wvLetTime{iLap,1}(:,idx_binSpace{iLap,1} == iBin),2);
            temp_wv2(:,iBin) = nansum(wvLetTime{iLap,1}(:,idx_binSpace{iLap,1} == iBin),2);
        end
        temp_wvLetSpace{iLap,1} = temp_wv;
        temp_wvLetSpace2{iLap,1} = temp_wv2;
    end
    wvLetSpace = reshape(cell2mat(temp_wvLetSpace'),[size(F,2),nBin,nLap]); % before reshape, transpose the original data, becuase matlab calculate column-wize
    wvLetSpace2 = reshape(cell2mat(temp_wvLetSpace2'),[size(F,2),nBin,nLap]);

% z-score transform
    norm_wvLetSpace = wvLetSpace/sum(nanmean(nanmean(wvLetSpace,2),3));
    normSpec_PRE = nanmean(norm_wvLetSpace(:,:,1:30),3);
    normSpec_STIM = nanmean(norm_wvLetSpace(:,:,31:60),3);
    normSpec_POST = nanmean(norm_wvLetSpace(:,:,61:90),3);
    
    save([cscName,'.mat'],'wvLetTime','wvLetSpace')
end
