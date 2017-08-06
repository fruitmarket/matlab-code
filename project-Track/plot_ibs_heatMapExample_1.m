rtDir = 'D:\Dropbox\SNL\P2_Track';
cd(rtDir);
load myParameters.mat;
load neuronList_ori_170626.mat

cellID = [435, 433, 653, 678, 882, 124];
nCell = length(cellID);

for iCell = 1:nCell
    matFile{iCell,1} = cell2mat(T.path(T.cellID == cellID(iCell)));
end
    
for iCell = 1:nCell
    [cellDir, cellName, ~] = fileparts(matFile{iCell});
    cellDirSplit = regexp(cellDir,'\','split');
    cellFigName = strcat(cellDirSplit(end-1),'_',cellDirSplit(end),'_',cellName);

    cd(cellDir);
    load(matFile{iCell});
    load Events.mat;

    cd(rtDir);

    %%
    nCol = 3;
    nRow = 2;
    fHandle = figure('PaperUnits','centimeters','PaperPosition',[0, 0, 40, 20]);
    figSize = [0.10 0.10 0.85 0.85];

    hPlot(1) = axes('Position',axpt(1,3,1,1,axpt(nCol,nRow,1,1,figSize,wideInterval),wideInterval));
%     pethconvSpatial = flipud(pethconvSpatial);
    modi_pethconvSpatial = [pethconvSpatial;nan(1,124)];
    hMap = pcolor(modi_pethconvSpatial);
    set(hMap,'lineStyle','none');
    ylabel('Trial','fontSize',fontL);

    hPlot(2) = axes('Position',axpt(1,3,1,2,axpt(nCol,nRow,1,1,figSize,wideInterval),wideInterval));
        plot([xptSpatial{:}],[yptSpatial{:}],'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');
        rec = rectangle('Position',[lightLoc(1), 31, lightLoc(2)-lightLoc(1), 30], 'LineStyle','none','FaceColor',colorLLightBlue);
        ylabel('Trial','FontSize',fontL);
    %     title(['Spatial Raster & PETH at '],'FontSize',fontL,'FontWeight','bold');

    hPlot(3) = axes('Position',axpt(1,3,1,3,axpt(nCol,nRow,1,1,figSize,wideInterval),wideInterval));
        ylimpethSpatial = ceil(max(pethconvSpatial(pethconvSpatial<inf))*1.1+0.0001);
        pRw(1) = patch([rewardLoc(1)+2, rewardLoc(1)+6, rewardLoc(1)+6, rewardLoc(1)+2],[0, 0, ylimpethSpatial, ylimpethSpatial],colorLightRed);
        hold on;
        pRw(2) = patch([rewardLoc(2)+2.5, rewardLoc(2)+6.5, rewardLoc(2)+6.5, rewardLoc(2)+2.5],[0, 0, ylimpethSpatial, ylimpethSpatial],colorLightRed);
        hold on;
        for iType = 1:3
            plot(pethSpatial(1:124),pethconvSpatial(iType,:),'LineStyle','-','LineWidth',lineM,'Color',lineColor{iType})
        end
        ylabel('Rate (Hz)','FontSize',fontL);
        xlabel('Position (cm)','FontSize',fontL);
        uistack(rec,'bottom');

    set(hPlot,'Box','off','TickDir','out','fontSize',fontL);
    set(hPlot(1),'XLim',[0,124],'XTick',[0:20:120],'YTick',[1.5,2.5,3.5],'YTickLabel',{'PRE','STM','POST'});
    set(hPlot(2),'XLim',[0,124],'XTick',[0:20:120],'YLim',[0, 90],'YTick',[0:30:90]);
    set(hPlot(3),'XLim',[0,124],'XTick',[0:20:120],'YLim',[0, ylimpethSpatial]);
    set(pRw,'LineStyle','none','FaceAlpha',0.2);

    formatOut = 'yymmdd';
    print('-painters','-r300','-depsc',[datestr(now,formatOut),'_FieldExample_',num2str(iCell),'.ai']);
    close;
end