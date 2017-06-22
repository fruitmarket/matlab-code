function analysis_indexTrack

matFile = mLoad;
nFile = length(matFile);

cMeanFR = 9;
cPeakFR = 0.5;
cSpkpvr = 1.2;
cPixelLength = 8;

alpha = 0.01;

for iFile = 1:nFile
    disp(['### analyzing peak location:',matFile{iFile},'...']);
    [cellDir, cellName, ~] = fileparts(matFile{iFile});
    cd(cellDir);
    load(matFile{iFile},'meanFR_task','spkpvr','peakFR1D_track','pethconvSpatial','pLR_TrackN');
    
%% condi1: meanFR
    if meanFR_task < cMeanFR & spkpvr > cSpkpvr
        idxNeurontype = 'PN';
    elseif meanFR_task >= cMeanFR & spkpvr <= cSpkpvr
        idxNeurontype = 'IN';
    else
        idxNeurontype = 'UNC';
    end
   
%% condi2 peakFR
    if (peakFR1D_track(1) < cPeakFR) & (peakFR1D_track(2) < cPeakFR) & (peakFR1D_track(3) < cPeakFR)
        idxPeakFR = false; % enough spikes
    else
        idxPeakFR = true; % not enough spikes for place field
    end
    
%% condi3 find the biggest place field size (if the field is smaller than 5, consider no place fields)
% a continuous region of at least 8 bins (8cm)in which the firing rate
% was above 60% of the peak rate in the maze, containing at least one bin above 80% of the peak rate in the mze.
    peakFR = max(pethconvSpatial(:));
    tempValue = regionprops(pethconvSpatial>peakFR*0.6,'PIxelIdxList','Area');
    [~,idx] = max([tempValue.Area]); % find longest place field
    if length(pethconvSpatial(tempValue(idx).PixelIdxList)) > cPixelLength & sum(pethconvSpatial(tempValue(idx).PixelIdxList) > peakFR*0.8) >= 1
        idxPlaceField = true;
    else
        idxPlaceField = false;
    end
    
%% light modulation
    if pLR_TrackN < alpha
        idxpLR_Track = true;
    else
        idxpLR_Track = false;
    end

    save([cellName,'.mat'],'idxNeurontype','idxPeakFR','idxPlaceField','idxpLR_Track','-append');
end
disp('### analysis: index calculation completed! ###')