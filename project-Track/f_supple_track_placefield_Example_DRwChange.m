rtDir = 'D:\Dropbox\SNL\P2_Track';
cd(rtDir);
%%%%%%%%%%%%%%%%%%%%%%
%%%%%% version 1 %%%%%
%%%%%%%%%%%%%%%%%%%%%%

load myParameters.mat;
load neuronList_ori_171018.mat
formatOut = 'yymmdd';

% cellID = [117 186 240 712 806 807]; % for DRw sessions 170928 (inAct, inIn, inNo / outAct, outIn, outNo)
cellID = [117, 186, 240, 712, 776, 806]; % + 776 / list_171018
nCell = length(cellID);

for iCell = 1:nCell
    matFile{iCell,1} = cell2mat(T.path(T.cellID == cellID(iCell)));
end

wideInterval = wideInterval + 0.1;
for iCell = 1:nCell
    [cellDir, cellName, ~] = fileparts(matFile{iCell});
    cellDirSplit = regexp(cellDir,'\','split');
    cellFigName = strcat(cellDirSplit(end-1),'_',cellDirSplit(end),'_',cellName);

    cd(cellDir);
    load(matFile{iCell});
    load Events.mat;

    cd(rtDir);

    %%
    nCol = 6;
    nRow = 7;
    fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});
    figSize = [0.10 0.1 0.80 0.80];
    lightDur = 3000;
    
    hPlot(1) = axes('Position',axpt(1,3,1,1,axpt(nCol,nRow,1,1,figSize,tightInterval),wideInterval));
        plot([xpt1stLPre{1},xpt1stLStm{1},xpt1stLPost{1}],[ypt1stLPre{1},30+ypt1stLStm{1},60+ypt1stLPost{1}],'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');
        rec = rectangle('Position',[0 31 lightDur 30], 'LineStyle','none','FaceColor',colorLLightBlue);
        ylabel('Trial','FontSize',fontS);
        xlabel('Time (ms)','FontSize',fontS);
        uistack(rec,'bottom');
        
    hPlot(2) = axes('Position',axpt(1,3,1,2,axpt(nCol,nRow,1,1,[0.1 0.088 0.8 0.8],tightInterval),wideInterval));
        plot([xptSpatial{:}],[yptSpatial{:}],'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');
        rec = rectangle('Position',[lightLoc(1), 31, lightLoc(2)-lightLoc(1), 30], 'LineStyle','none','FaceColor',colorLLightBlue);
        hold on;
        pRw(1) = patch([rewardLoc(1)+2, rewardLoc(1)+6, rewardLoc(1)+6, rewardLoc(1)+2],[0, 0, 90, 90],colorLightRed);
        hold on;
        pRw(2) = patch([rewardLoc(2)+2.5, rewardLoc(2)+6.5, rewardLoc(2)+6.5, rewardLoc(2)+2.5],[0, 0, 90, 90],colorLightRed);
        text(125, 90,[num2str(max(peakFR1D_track)),' Hz'],'fontSize',fontS);
        ylabel('Trial','FontSize',fontS);
        uistack(rec,'bottom');
        uistack(pRw,'bottom');
    hPlot(3) = axes('Position',axpt(1,3,1,3,axpt(nCol,nRow,1,1,figSize,tightInterval),wideInterval));
        modi_pethconvSpatial = [pethconvSpatial;nan(1,124)];
        hMap = pcolor(modi_pethconvSpatial);
        caxis([min(modi_pethconvSpatial(:)) max(modi_pethconvSpatial(:))])
        set(hMap,'lineStyle','none');
        xlabel('Distance (cm)','fontSize',fontS);
%     hPlot(4) = axes('Position',axpt(1,3,1,4,axpt(nCol,nRow,1,1,figSize,tightInterval),wideInterval));
%         ylimpethSpatial = ceil(max(pethconvSpatial(pethconvSpatial<inf))*1.1+0.0001);

%         for iType = 1:3
%             plot(pethSpatial(1:124),pethconvSpatial(iType,:),'LineStyle','-','LineWidth',lineM,'Color',lineColor{iType})
%         end
%         ylabel('Rate (Hz)','FontSize',fontS);
%         xlabel('Position (cm)','FontSize',fontS);
%         uistack(rec,'bottom');

    set(hPlot(1),'Box','off','TickDir','out','fontSize',fontS,'XLim',[-100 3000],'XTick',[0,500,3000],'YLim',[0,90],'YTick',[0:30:90]);
    set(hPlot(2),'Box','off','TickDir','out','fontSize',fontS,'XLim',[0,124],'XTick',[],'YLim',[0, 90],'YTick',[0:30:90]);
    set(hPlot(3),'Box','off','TickDir','out','fontSize',fontS,'XLim',[0,124],'XTick',[0:20:120],'YTick',[1.5,2.5,3.5],'YTickLabel',{'PRE','STM','POST'});
%     set(hPlot(4),'XLim',[0,124],'XTick',[0:20:120],'YLim',[0, ylimpethSpatial]);
    set(pRw,'LineStyle','none','FaceAlpha',0.2);
    
    cd('D:\Dropbox\SNL\P2_Track\example_track_PF_change_DRw');
    print('-painters','-r300','-dtiff',[datestr(now,formatOut),'_placeCellExample_',num2str(iCell),'.tif']);
    print('-painters','-r300','-depsc',[datestr(now,formatOut),'_placeCellExample_',num2str(iCell),'.ai']);
    close;
end