rtDir = 'E:\Dropbox\SNL\P2_Track';
cd(rtDir);
load('E:\Dropbox\SNL\P2_Track\myParameters.mat');
load('E:\Dropbox\SNL\P2_Track\neuronList_ori_180511.mat');
% load('E:\Dropbox\SNL\P2_Track\neuronList_ori50hz_180511.mat');
formatOut = 'yymmdd';

markerS = 1.4;

cellID = [614 224]; % 8hz Rw: 703 / noRw: 224
% cellID = [5]; % 50hz Rw: 5

nCell = length(cellID);

for iCell = 1:nCell
    matFile{iCell,1} = cell2mat(T.path(T.cellID == cellID(iCell)));
end

wideInterval = wideInterval + 0.08;
tightInterval = tightInterval - 0.03;
for iCell = 1:nCell
    [cellDir, cellName, ~] = fileparts(matFile{iCell});
    cellDirSplit = regexp(cellDir,'\','split');
    cellFigName = strcat(cellDirSplit(end-1),'_',cellDirSplit(end),'_',cellName);

    cd(cellDir);
    load(matFile{iCell});
    load Events.mat;

    cd(rtDir);

%% Lap light time
if(regexp(cellDir,'Run'))
    sensorOn = sensor.S6(31:60);
    sensorOff = sensor.S9(31:60);
    lightLoc = [20*pi*5/6 20*pi*8/6];
else
    sensorOn = sensor.S10(31:60);
    sensorOff = sensor.S11(31:60);
    lightLoc = [20*pi*9/6 20*pi*10/6];
end
rewardLoc1 = [20*pi*3/6 20*pi*4/6]+[2, -2];
rewardLoc2 = [20*pi*9/6 20*pi*10/6]+[2, -2];

if(~isempty(regexp(cellDir,'DRun','Once')) || ~isempty(regexp(cellDir,'DRw','Once')))
    patchColor = colorLLightBlue;
else
    patchColor = colorLightGray;
end
temp_lightT = [0; sensorOff-sensorOn];
xpt_lightT = repmat(temp_lightT',2,1);
xpt_lightT = xpt_lightT(:);
xpt_lightT(1) = [];
xpt_lightT = [xpt_lightT;0];

ypt_lightT = repmat([30:60],2,1);
ypt_lightT = ypt_lightT(:);

    %%
    nCol = 5;
    nRow = 6;
    fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});
    figSize = [0.10 0.10 0.80 0.80];
    
    hPlot(1) = axes('Position',axpt(1,3,1,1,axpt(nCol,nRow,1,1,figSize,tightInterval),wideInterval));
        plot([xpt1stLPre{1},xpt1stLStm{1},xpt1stLPost{1}],[ypt1stLPre{1},30+ypt1stLStm{1},60+ypt1stLPost{1}],'Marker','.','MarkerSize',markerS,'markerFaceColor',colorBlack,'markerEdgeColor','k','LineStyle','none');
        pLight = patch(xpt_lightT,ypt_lightT,patchColor,'lineStyle','none');
        ylabel('Lap','FontSize',fontM);
        xlabel('Time (sec)','FontSize',fontM);
        uistack(pLight,'bottom');
        
    hPlot(2) = axes('Position',axpt(1,3,1,2,axpt(nCol,nRow,1,1,[0.1 0.092 0.8 0.8],tightInterval),wideInterval));
        plot([xptSpatial{:}],[yptSpatial{:}],'Marker','.','MarkerSize',markerS,'markerFaceColor',colorBlack,'markerEdgeColor','k','LineStyle','none');
        pLight = patch([lightLoc(1) lightLoc(2) lightLoc(2) lightLoc(1)],[31 31 60 60], patchColor,'lineStyle','none');
        hold on;
        pRw(1) = patch([rewardLoc1(1), rewardLoc1(2), rewardLoc1(2), rewardLoc1(1)],[0, 0, 90, 90],colorLightRed);
        hold on;
        pRw(2) = patch([rewardLoc2(1), rewardLoc2(2), rewardLoc2(2), rewardLoc2(1)],[0, 0, 90, 90],colorLightRed);
        text(110, 100,[num2str(round(max(peakFR1D_track)*10)/10) ' Hz'],'fontSize',fontM);
        ylabel('Lap','FontSize',fontM);
        uistack(pLight,'bottom');
        uistack(pRw,'bottom');
    hPlot(3) = axes('Position',axpt(1,3,1,3,axpt(nCol,nRow,1,1,[0.1 0.11 0.8 0.8],tightInterval),wideInterval));
        modi_pethconvSpatial = [pethconvSpatial;nan(1,124)];
        hMap = pcolor(modi_pethconvSpatial);
        caxis([min(modi_pethconvSpatial(:)) max(modi_pethconvSpatial(:))])
        set(hMap,'lineStyle','none');
        xlabel('Location (cm)','fontSize',fontM);

    set(hPlot(1),'Box','off','TickDir','out','fontSize',fontM,'XLim',[-500 3000],'XTick',[-500, 0,1000,2000,3000],'XTickLabel',[-0.5 0, 1, 2, 3],'YLim',[0,90],'YTick',[0:30:90]);
    set(hPlot(2),'Box','off','TickDir','out','fontSize',fontM,'XLim',[0,124],'XTick',[],'YLim',[0, 90],'YTick',[0:30:90]);
    set(hPlot(3),'Box','off','TickDir','out','fontSize',fontM,'XLim',[0,124],'XTick',[0:20:120],'YTick',[1.5,2.5,3.5],'YTickLabel',{'PRE','STIM','POST'});
    set(hPlot,'TickLength',[0.03, 0.03]);
    set(pLight,'LineStyle','none');
    set(pRw,'LineStyle','none','FaceAlpha',0.2);

    cd('E:\Dropbox\SNL\P2_Track\example_track_placefield_example_placefieldchange_PlosBiofig');
    print('-painters','-r300','-dtiff',[datestr(now,formatOut),'_placeCell_Example_',num2str(iCell),'.tif']);
    print('-painters','-r300','-depsc',[datestr(now,formatOut),'_placeCell_Example_',num2str(iCell),'.ai']);
    close;   
end