function align_ylabel(axHandles,xRatio,yRatio)
nAx = size(axHandles);
hYLabel = zeros(nAx(1),nAx(2));
hPos = cell(nAx(1),nAx(2));

for iAx = 1:nAx(1)
    for jAx = 1:nAx(2)
        hYLabel(iAx,jAx) = get(axHandles(iAx,jAx),'YLabel');
        set(hYLabel(iAx,jAx), 'Units','pixel');
        hPos{iAx,jAx} = get(hYLabel(iAx,jAx),'Position');
    end
end

% meanXPos = mean(cellfun(@(x) x(1), hPos)); % original
meanXPos = min(cellfun(@(x) x(1),hPos));
meanYPos = mean(cellfun(@(x) x(2), hPos));

for iAx = 1:nAx(1)
    for jAx = 1:nAx(2)
        hPos{iAx,jAx}(1) = meanXPos;
        hPos{iAx,jAx}(2) = meanYPos;
%         set(hYLabel(iAx,jAx),'Position',hPos{iAx,jAx}+[0, meanYPos*1.5, 0]);
        set(hYLabel(iAx,jAx),'Position',hPos{iAx,jAx}+[meanXPos*xRatio, meanYPos*yRatio, 0]);
%         set(hYLabel(iAx,jAx),'Position',hPos{iAx,jAx});
    end
end