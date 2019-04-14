% visualizing spatial location of neurons
temp_xLim = double(ops.xrange);
xLim = temp_xLim-temp_xLim(1);
temp_yLim = double(ops.yrange);
yLim = temp_yLim-temp_yLim(1);

xLength = diff(xLim);
yLength = diff(yLim);

imgVcorr = ops.Vcorr;
imgRef = ops.refImg;

lociAll = cell2mat(cellfun(@(x) x.med,stat,'UniformOutput',0)');
lociAll = [lociAll(:,1)-temp_xLim(1), lociAll(:,2)-temp_yLim(1)];
lociNeuron = lociAll(logical(iscell(:,1)),:);

load('D:\Dropbox\Lab_Rothschild\myParameters_caImg.mat');

hHandle =  figure('PaperUnits','centimeters','PaperPosition',paperSize{2});
nCol = 2;
nRow = 1;

hReference = axes('Position',axpt(nCol,nRow,1,1,[],wideInterval));
    hRef = imagesc('XData',xLim,'YData',yLim,'CData',imgRef);
    for iCell = 1:nCell
        hold on
        plot(lociNeuron(iCell,2),lociNeuron(iCell,1),'o','markerSize',markerS,'color',colorBlack);
    end
    xlabel('Pixel','fontSize',fontM);
    ylabel('Pixel','fontSize',fontM);
    set(hReference,'Box','off','TickDir','out','XLim',xLim,'YLim',yLim,'fontSize',fontM,'XTick',[0:100:xLength,xLength],'YTick',[0:100:yLength,yLength]);
hCorrelation = axes('Position',axpt(nCol,nRow,2,1,[],wideInterval));
    hVcorr = imagesc('XData',xLim,'YData',yLim,'CData',imgVcorr);
    for iCell = 1:nCell
        hold on
        plot(lociNeuron(iCell,2),lociNeuron(iCell,1),'o','markerSize',markerS,'color',colorBlack);
        text(lociNeuron(iCell,2),lociNeuron(iCell,1),[num2str(iCell)],'fontSize',fontM);
    end
    xlabel('Pixel','fontSize',fontM);
    ylabel('Pixel','fontSize',fontM);
    set(hCorrelation,'Box','off','TickDir','out','XLim',xLim,'YLim',yLim,'fontSize',fontM,'XTick',[0:100:xLength,xLength],'YTick',[0:100:yLength,yLength]);
    