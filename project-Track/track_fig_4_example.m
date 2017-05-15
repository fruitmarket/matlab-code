rtDir = 'D:\Dropbox\SNL\P2_Track';
cd(rtDir);
load myParameters.mat;

cd('D:\Projects\Track_160221-1_Rbp16\160727_DV2.45_1_DRun_100_T78'); % example 6,
cellNum = 6;

matFile = mLoad;

[cellDir, cellName, ~] = fileparts(matFile{cellNum});
cellDirSplit = regexp(cellDir,'\','split');
cellFigName = strcat(cellDirSplit(end-1),'_',cellDirSplit(end),'_',cellName);

load(matFile{cellNum});
load Events.mat;

cd(rtDir);

%%
fHandle = figure('PaperUnits','centimeters','PaperPosition',[0, 0, 7, 10]);
figSize = [0.15 0.15 0.80 0.80];

hPlot(1) = axes('Position',axpt(1,3,1,1,axpt(1,1,1,1,figSize,wideInterval),wideInterval));
pethconvSpatial = flipud(pethconvSpatial);
modi_pethconvSpatial = [pethconvSpatial;nan(1,124)];
hMap = pcolor(modi_pethconvSpatial);
set(hMap,'lineStyle','none');
ylabel('Trial','fontSize',fontL);

hPlot(2) = axes('Position',axpt(1,3,1,2,axpt(1,1,1,1,figSize,wideInterval),wideInterval));
    plot([xptSpatial{:}],[yptSpatial{:}],'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');
    rec = rectangle('Position',[lightLoc(1), 31, lightLoc(2)-lightLoc(1), 30], 'LineStyle','none','FaceColor',colorLLightBlue);
    ylabel('Trial','FontSize',fontL);
%     title(['Spatial Raster & PETH at '],'FontSize',fontL,'FontWeight','bold');

hPlot(3) = axes('Position',axpt(1,3,1,3,axpt(1,1,1,1,figSize,wideInterval),wideInterval));
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
print('-painters','-r300','-depsc',['fig4_example_',datestr(now,formatOut),'.ai']);
% close;