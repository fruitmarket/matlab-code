function analysis_indexTrackBurst

matFile = mLoad;
nFile = length(matFile);

cMeanFRLow = 0.1;
cMeanFRPeak = 9;
cPeakFR = 5;
cSpkpvr = 1.2;
cPixelLength = 5;
% cOverLapLength = 5;
alpha = 0.01;

for iFile = 1:nFile
    disp(['### analyzing Index:',matFile{iFile},'...']);
    [cellDir, cellName, ~] = fileparts(matFile{iFile});
    cd(cellDir);
    load(matFile{iFile},'meanFR_Task','spkpvr','peakFR1D_track','pethconvSpatial','pLR_Track','pLR_Plfm50hz','totalSpike','sum_totalSpike','m_inzoneSpike','m_outzoneSpike','m_totalSpike','p_ttestSpk','p_ttestFr','m_lapFrInzone','m_lapFrOutzone','m_lapFrTotalzone');
    
%% condi1: meanFR
    if cMeanFRLow < meanFR_Task & meanFR_Task < cMeanFRPeak & spkpvr > cSpkpvr
        neuronType = 'PN';
    elseif meanFR_Task >= cMeanFRPeak & spkpvr <= cSpkpvr
        neuronType = 'IN';
    else
        neuronType = 'UNC';
    end
   
%% place field condition 1 (peakFR)
    if max(peakFR1D_track)>cPeakFR
        idxPeakFR = true; % not enough peak firing rate for place field
    else
        idxPeakFR = false; % 
    end
    
%% place field condition 2 (Total spike number at track > 100)
    if sum(sum_totalSpike) > 100
        idxTotalSpikeNum = true;
    else
        idxTotalSpikeNum = false;
    end
    
%% place field condition 3 & 4 [find the biggest place field size (if the field is smaller than 5, consider no place fields)]
% a continuous region of at least 4 bins (4cm)in which the firing rate
% was above 60% of the peak rate in the maze, containing at least one bin above 80% of the peak rate in the maze.
% block-wise calculation --> if there is a place field in at least one block(PRE, STM, POST) consider there is a place field.
    nBlock = size(pethconvSpatial,1);
    peakFR = max(pethconvSpatial,[],2);
    idxField = false(nBlock,1);
    for iBlock = 1:nBlock
        tempPeth = pethconvSpatial(iBlock,:);
        tempValue = regionprops(tempPeth>peakFR(iBlock)*0.6,'PixelIdxList','Area');
        [~,idxBlock] = max([tempValue.Area]);
        if length(tempPeth(tempValue(idxBlock).PixelIdxList))>=cPixelLength & sum(tempPeth(tempValue(idxBlock).PixelIdxList)>=peakFR(iBlock)*0.8) >= 1
            idxField(iBlock) = true;
        else
            idxField(iBlock) = false;
        end
    end
    if sum(double(idxField))>0
        idxPlaceField = true;
    else
        idxPlaceField = false;
    end

%% Is place field in the stimulation zone? Yes:1 No:0
% block-wize comparison. If at least one block has a place field in a stimulation zone, count it as 1.
    lightLoc = [floor(20*pi*5/6) ceil(20*pi*8/6)];
    stmZone = [lightLoc(1):lightLoc(2)];
    cOverLapLength = length(stmZone)*0.5;
    
    for iBlock = 1:nBlock
        tempPeth = pethconvSpatial(iBlock,:);
        tempValue = regionprops(tempPeth>peakFR(iBlock)*0.6,'PixelIdxList','Area');
        idxArea = [tempValue.Area]>cPixelLength;
        pixelBlock = {tempValue.PixelIdxList};
        fieldPixel = pixelBlock(idxArea)';
        nLoci = size(pixelBlock(idxArea)',1);
        overLap = {};
        center = [];
        
        if nLoci == 0
            idxZoneInOut(iBlock,1) = false;
            overLapLength = 0;
            idxOverLap{iBlock,1} = 'Nofield';
        else
            for iLoci = 1:nLoci
                overLap{iLoci,1} = intersect(stmZone,fieldPixel{iLoci}); % length of place field and stm-zone
                center(iLoci,1) = mean(fieldPixel{iLoci});
            end
            if sum(double(lightLoc(1)<=center & center<=lightLoc(2)))
                idxOverLap{iBlock,1} = 'Inzone';
            else
                idxOverLap{iBlock,1} = 'Outzone';
            end
            if iBlock == 1
                overLapLength = cellfun(@length,overLap);
                if length(overLapLength) ~= 1
                    overLapLength = max(overLapLength);
                end
            end
            if sum(double(~cellfun(@isempty,overLap)))>0 % overlap between simulation zone & place field
                idxZoneInOut(iBlock,1) = true;
            else
                idxZoneInOut(iBlock,1) = false;
            end
        end
    end
    
%% light modulation
    if pLR_Track < alpha
        idxpLR_Track = true;
    else
        idxpLR_Track = false;
    end
    
%% p-value of spike t-test
    if p_ttestFr(1,1)<0.05 & (m_lapFrInzone(2) > m_lapFrInzone(1)) % significant spike change in inzone
        idxmFrIn = 1;
    elseif p_ttestFr(1,1)<0.05 & (m_lapFrInzone(2) < m_lapFrInzone(1))
        idxmFrIn = -1;
    else
        idxmFrIn = 0;
    end
    if p_ttestFr(1,2)<0.05 & (m_lapFrOutzone(2) > m_lapFrOutzone(1))
        idxmFrOut = 1;
    elseif p_ttestFr(1,2)<0.05 & (m_lapFrOutzone(2) < m_lapFrOutzone(1))
        idxmFrOut = -1;
    else
        idxmFrOut = 0;
    end
    
    if p_ttestFr(1,3)<0.05 & (m_lapFrTotalzone(2) > m_lapFrTotalzone(1))
        idxmFrTotal = 1;
    elseif p_ttestFr(1,3)<0.05 & (m_lapFrTotalzone(2) < m_lapFrTotalzone(1))
        idxmFrTotal = -1;
    else
        idxmFrTotal = 0;
    end

%% spike number t-test
    if p_ttestSpk(1,1)<0.05 & (m_inzoneSpike(2) > m_inzoneSpike(1)) % significant spike change in inzone
        idxmSpkIn = 1;
    elseif p_ttestFr(1,1)<0.05 & (m_inzoneSpike(2) < m_inzoneSpike(1))
        idxmSpkIn = -1;
    else
        idxmSpkIn = 0;
    end
    if p_ttestSpk(1,2)<0.05 & (m_outzoneSpike(2) > m_outzoneSpike(1))
        idxmSpkOut = 1;
    elseif p_ttestSpk(1,2)<0.05 & (m_outzoneSpike(2) < m_outzoneSpike(1))
        idxmSpkOut = -1;
    else
        idxmSpkOut = 0;
    end
    
    if p_ttestSpk(1,3)<0.05 & (m_totalSpike(2) > m_totalSpike(1))
        idxmSpkTotal = 1;
    elseif p_ttestFr(1,3)<0.05 & (m_totalSpike(2) < m_totalSpike(1))
        idxmSpkTotal = -1;
    else
        idxmSpkTotal = 0;
    end
    
    save([cellName,'.mat'],'neuronType','idxPeakFR','idxPlaceField','idxTotalSpikeNum','idxpLR_Track','idxmFrIn','idxmFrOut','idxmFrTotal',...
                            'idxmSpkIn','idxmSpkOut','idxmSpkTotal','idxOverLap','idxZoneInOut','overLapLength','-append');
end
disp('### analysis: index calculation completed! ###')