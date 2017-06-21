function analysis_indexTrack

matFile = mLoad;
nFile = length(matFile);

cMeanFR = 9;
cPeakFR = 0.5;
cSpkpvr = 1.2;
cPixelLength = 5;

alpha = 0.01;

for iFile = 1:nFile
    disp(['### analyzing peak location:',matFile{iFile},'...']);
    [cellDir, cellName, ~] = fileparts(matFile{iFile});
    cd(cellDir);
    load(matFile{iFile},'meanFR_task','spkpvr','peakFR1D_track','pethconvSpatial');
    
%% condi1: meanFR
    if meanFR_task < cMeanFR
        idxPN = true;
    else
        idxPN = false;
    end

%% condi2: waveform pvr
    if spkpvr > cSpkpvr
        idxSpkpvr = true;
    else
        idxSpkpvr = true;
    end
    
%% condi3 peakFR
    if peakFR1D_track > cPeakFR
        idxPeakFR = true; % enough spikes
    else
        idxPeakFR = false; % not enough spikes for place field
    end
    
%% condi4 find the biggest place field size (if the field is smaller than 5, consider no place fields)
    peakFR = max(pethconvSpatial(:));
    tempValue = regionprops(pethconvSpatial>peakFR*0.6,'PIxelIdxList','Area');
    [~,idx] = max([tempValue.Area]); % find longest place field
    if length(pethconvSpatial(tempValue(idx).PixelIdxList)) > cPixelLength
        idxPlaceField = true;
    else
        idxPlaceField = false;
    end    
    
    save([cellName,'.mat'],'idxPN','idxSpkpvr','idxPeakFR','idxPlaceField','-append');
end
disp('### analysis: index calculation completed! ###')