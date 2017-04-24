function pcInfo1D = analysis_pcInfo1D(spikeBins)
%analysisi_pcInfo1D  
% analysis_pcInfo1D calculates firing rate of each bin (in field), field
% location, peak firing of each field, peak locations, center locations,
% and field sizes.
%
% Input: binned firing rate (ex. pethconvSpatial)
%   * Input should be a 1 * n row.
% Output: a structure which contains
%
%   1. normalized firing rate
%   2. in field firing rate
%   3. location of place fields
%   4. peak firing rate
%   5. peak location
%   6. center location
%   7. field sizes

fieldThrRatio = 0.2;
fieldThrSize = 3;

    binaryVec(1,:) = spikeBins > max(spikeBins)*fieldThrRatio; % higher than 20% of peak firing rate
    [labeledVec, nRegions] = bwlabel(binaryVec); % Label each region with a label - an 'ID' number
    fieldSize = regionprops(labeledVec, spikeBins,'Area','PixelValues'); % Measure lengths of each region and the indexes
    field_pre = cell(nRegions,1);
    if (nRegions ~= 0)
        for iField = 1:nRegions
            if fieldSize(iField).Area > fieldThrSize % Area (length) is greater than 3, so store the value
                field_pre{iField,1} = fieldSize(iField).PixelValues; % firing rate in place field
                s_temp_lociIdx = find(labeledVec == iField);
                field_pre{iField,2} = s_temp_lociIdx;
                [field_pre{iField,3}, center_lociIdx] = max(field_pre{iField,1}); % peak firing rate
                field_pre{iField,4} = s_temp_lociIdx(center_lociIdx);
                field_pre{iField,5} = mean(field_pre{iField,2}); % place field center
                field_pre{iField,6} = length(field_pre{iField,1}); % place field size
            end
        end
        emptyIdx = cellfun(@isempty, field_pre(:,1));
        field_pre(emptyIdx,:) = [];
        field_pre = sortrows(field_pre,-3); % sort the cell based on peak firing rate

        pcInfo1D.normTrackfr = spikeBins/max(spikeBins);
        pcInfo1D.fr = field_pre(:,1);
        pcInfo1D.area = field_pre(:,2);
        pcInfo1D.peakfr = cell2mat(field_pre(:,3));
        pcInfo1D.peakloci = cell2mat(field_pre(:,4));
        pcInfo1D.centerloci = cell2mat(field_pre(:,5));
        pcInfo1D.size = cell2mat(field_pre(:,6));
    else
        pcInfo1D.normTrackfr = spikeBins/max(spikeBins);
        pcInfo1D.area = {NaN};
        pcInfo1D.peakfr = NaN;
        pcInfo1D.peakloci = NaN;
        pcInfo1D.centerloci = NaN;
        pcInfo1D.size = NaN;
    end
end