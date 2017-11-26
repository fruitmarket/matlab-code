function analysis_indexTrack

matFile = mLoad;
nFile = length(matFile);

cMeanFRLow = 0.1;
cMeanFRPeak = 9;
cPeakFR = 4;
cSpkpvr = 1.2;
cPixelLength = 5;
% cOverLapLength = 5;
alpha = 0.01;

for iFile = 1:nFile
    disp(['### analyzing peak location:',matFile{iFile},'...']);
    [cellDir, cellName, ~] = fileparts(matFile{iFile});
    cd(cellDir);
%     clear('meanFR_task','spkpvr','peakFR1D_track','pethconvSpatial','totalSpike','pLR_TrackN','pLR_Plfm8hz','p_ttest','lightLoc','m_lapFrInzone','m_lapFrOutzone','m_lapFrTotalzone');
    load(matFile{iFile},'meanFR_task','spkpvr','peakFR1D_track','pethconvSpatial','totalSpike','pLR_TrackN','pLR_Plfm8hz','p_ttest','lightLoc','m_lapFrInzone','m_lapFrOutzone','m_lapFrTotalzone');
    
%% condi1: meanFR
    if cMeanFRLow < meanFR_task & meanFR_task < cMeanFRPeak & spkpvr > cSpkpvr
        idxNeurontype = 'PN';
    elseif meanFR_task >= cMeanFRPeak & spkpvr <= cSpkpvr
        idxNeurontype = 'IN';
    else
        idxNeurontype = 'UNC';
    end
   
%% condi2 peakFR
    if (peakFR1D_track(1) < cPeakFR) & (peakFR1D_track(2) < cPeakFR) & (peakFR1D_track(3) < cPeakFR)
        idxPeakFR = false; % not enough peak firing rate for place field
    else
        idxPeakFR = true; % 
    end
    
%% condi3 find the biggest place field size (if the field is smaller than 5, consider no place fields)
% a continuous region of at least 5 bins (5cm)in which the firing rate
% was above 60% of the peak rate in the maze, containing at least one bin above 80% of the peak rate in the maze.
% block-wise calculation --> if there is a place field in at least one block(PRE, STM, POST) consider there is a place field.
    
    peakFR = max(pethconvSpatial,[],2);
    pethPRE = pethconvSpatial(1,:);
    tempValuePRE = regionprops(pethPRE>peakFR(1)*0.6,'PixelIdxList','Area');
    [~,idxPRE] = max([tempValuePRE.Area]); % find longest place field
    if length(pethPRE(tempValuePRE(idxPRE).PixelIdxList)) > cPixelLength & sum(pethPRE(tempValuePRE(idxPRE).PixelIdxList) > peakFR(1)*0.8) >= 1
        idxFieldPRE = true;
    else
        idxFieldPRE = false;
    end
    
    pethSTM = pethconvSpatial(2,:);
    tempValueSTM = regionprops(pethSTM>peakFR(2)*0.6,'PixelIdxList','Area');
    [~,idxSTM] = max([tempValueSTM.Area]); % find longest place field
    if length(pethSTM(tempValueSTM(idxSTM).PixelIdxList)) > cPixelLength & sum(pethSTM(tempValueSTM(idxSTM).PixelIdxList) > peakFR(2)*0.8) >= 1
        idxFieldSTM = true;
    else
        idxFieldSTM = false;
    end
    
    pethPOST = pethconvSpatial(3,:);
    tempValuePOST = regionprops(pethPOST>peakFR(3)*0.6,'PixelIdxList','Area');
    [~,idxPOST] = max([tempValuePOST.Area]); % find longest place field
    if length(pethPOST(tempValuePOST(idxPOST).PixelIdxList)) > cPixelLength & sum(pethPOST(tempValuePOST(idxPOST).PixelIdxList) > peakFR(3)*0.8) >= 1
        idxFieldPOST = true;
    else
        idxFieldPOST = false;
    end
    
    if idxFieldPRE | idxFieldSTM | idxFieldPOST
        idxPlaceField = true;
    else
        idxPlaceField = false;
    end
%% Is place field in the stimulation zone? Yes:1 No:0
% block-wize comparison. If at least one block has a place field in a stimulation zone, count it as 1.
    stmZone = round(lightLoc(1):lightLoc(2));
    cOverLapLength = length(stmZone)*0.5;
    
    idxAreaPRE = [tempValuePRE.Area]>cPixelLength;
    pixelPRE = {tempValuePRE.PixelIdxList};
    fieldPixelPRE = pixelPRE(idxAreaPRE)';
    nLociPRE = size(pixelPRE(idxAreaPRE)',1);
    [overLapPRE, overLapSTM, overLapPOST] = deal({});
    
    if nLociPRE == 0
        idxZoneInOutPRE = false;
        overLapLength = 0;               %% calculate overlapping area between stm zone & place field
        idxOverLap = 'Nofield';
    else
        for iLoci = 1:nLociPRE
            overLapPRE{iLoci,1} = intersect(stmZone,fieldPixelPRE{iLoci});
        end
        if sum(double(~cellfun(@isempty,overLapPRE)))>0
            idxZoneInOutPRE = true;
        else
            idxZoneInOutPRE = false;
        end
        overLapLength = cellfun(@length,overLapPRE);
        if length(overLapLength) ~= 1
            overLapLength = max(overLapLength); % find biggest overlap length
        end
        if overLapLength > cOverLapLength
            idxOverLap = 'Inzone';
        elseif 0 < overLapLength & overLapLength <= cOverLapLength
            idxOverLap = 'UNC';
        else
            idxOverLap = 'Outzone';
        end
    end
    idxAreaSTM = [tempValueSTM.Area]>cPixelLength;
    pixelSTM = {tempValueSTM.PixelIdxList};
    fieldPixelSTM = pixelSTM(idxAreaSTM)';
    nLociSTM = size(pixelSTM(idxAreaSTM)',1);
    if nLociSTM == 0
        idxZoneInOutSTM = false;
    else
        for iLoci = 1:nLociSTM
            overLapSTM{iLoci,1} = intersect(stmZone,fieldPixelSTM{iLoci});
        end
        if sum(double(~cellfun(@isempty,overLapSTM)))>0
            idxZoneInOutSTM = true;
        else
            idxZoneInOutSTM = false;
        end
    end

    idxAreaPOST = [tempValuePOST.Area]>cPixelLength;
    pixelPOST = {tempValuePOST.PixelIdxList};
    fieldPixelPOST = pixelPOST(idxAreaPOST)';
    nLociPOST = size(pixelPOST(idxAreaPOST)',1);
    if nLociPOST == 0
        idxZoneInOutPOST = false;
    else
        for iLoci = 1:nLociPOST
            overLapPOST{iLoci,1} = intersect(stmZone,fieldPixelPOST{iLoci});
        end
        if sum(double(~cellfun(@isempty,overLapPOST)))>0
            idxZoneInOutPOST = true;
        else
            idxZoneInOutPOST = false;
        end
    end

    if idxZoneInOutPRE | idxZoneInOutSTM | idxZoneInOutPOST
        idxZoneInOut = true;
    else
        idxZoneInOut = false;
    end

%% Total spike number?
    if sum(totalSpike) > 200
        idxTotalSpikeNum = true;
    else
        idxTotalSpikeNum = false;
    end
    
%% light modulation
    if pLR_TrackN < alpha
        idxpLR_Track = true;
    else
        idxpLR_Track = false;
    end
    
%% light modulation (Platform)
    if pLR_Plfm8hz < alpha
        idxpLR_Plfm8hz = true;
    else
        idxpLR_Plfm8hz = false;
    end

%% p-value of spike t-test
    if p_ttest(1,1)<0.05 & (m_lapFrInzone(2) > m_lapFrInzone(1)) % significant spike change in inzone
        idxmFrIn = 1;
    elseif p_ttest(1,1)<0.05 & (m_lapFrInzone(2) < m_lapFrInzone(1))
        idxmFrIn = -1;
    else
        idxmFrIn = 0;
    end
    
    if p_ttest(1,2)<0.05 & (m_lapFrOutzone(2) > m_lapFrOutzone(1))
        idxmFrOut = 1;
    elseif p_ttest(1,2)<0.05 & (m_lapFrOutzone(2) < m_lapFrOutzone(1))
        idxmFrOut = -1;
    else
        idxmFrOut = 0;
    end
    
    if p_ttest(1,3)<0.05 & (m_lapFrTotalzone(2) > m_lapFrTotalzone(1))
        idxmFrTotal = 1;
    elseif p_ttest(1,3)<0.05 & (m_lapFrTotalzone(2) < m_lapFrTotalzone(1))
        idxmFrTotal = -1;
    else
        idxmFrTotal = 0;
    end

    save([cellName,'.mat'],'idxNeurontype','idxPeakFR','idxPlaceField','idxTotalSpikeNum','idxpLR_Track','idxpLR_Plfm8hz','idxmFrIn','idxmFrOut','idxmFrTotal','idxZoneInOut','idxZoneInOutPRE','idxZoneInOutSTM','overLapLength','-append');
end
disp('### analysis: index calculation completed! ###')