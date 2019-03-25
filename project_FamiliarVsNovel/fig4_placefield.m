rtDir = 'E:\Dropbox\Lab_mwjung\P4_FamiliarNovel';
cd(rtDir);
load('E:\Dropbox\Lab_mwjung\P2_Track\myParameters.mat');
formatOut = 'yymmdd';
fontM = 8;
markerS = 0.5;
% saveDir = 'E:\Dropbox\Lab_mwjung\P4_FamiliarNovel\example_fig5';
% load('E:\Dropbox\Lab_mwjung\P4_FamiliarNovel\neuronList_novel_190301.mat');
% cellID = [18 65 40, 14, 17, 21];

saveDir = 'E:\Dropbox\Lab_mwjung\P4_FamiliarNovel\example_supple4';
load('E:\Dropbox\Lab_mwjung\P4_FamiliarNovel\neuronList_familiar_190301.mat');
cellID = [122 102 58 38 39 43];

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

%% Lap light time
sensorOn = sensor(31:60,6);
sensorOff = sensor(31:60,9);
lightLoc = [floor(20*pi*5/6) ceil(20*pi*8/6)];
rewardLoc1 = [floor(20*pi*3/6) ceil(20*pi*4/6)]+[2, -2];
rewardLoc2 = [floor(20*pi*9/6) ceil(20*pi*10/6)]+[2, -2];

temp_lightT = [0; sensorOff-sensorOn];
xpt_lightT = repmat(temp_lightT',2,1);
xpt_lightT = xpt_lightT(:);
xpt_lightT(1) = [];
xpt_lightT = [xpt_lightT;0];

ypt_lightT = repmat([30:60],2,1);
ypt_lightT = ypt_lightT(:);

rewardLoc1 = [20*pi*3/6 20*pi*4/6]+[2, -2];
rewardLoc2 = [20*pi*9/6 20*pi*10/6]+[2, -2];

    %%
    nCol = 5;
    nRow = 6;
    fHandle = figure('PaperUnits','centimeters','PaperPosition',[0 0 5 6]);
    figSize = [0.10 0.10 0.80 0.80];
    
    hPlot(1) = axes('Position',axpt(13,3,1:11,1,[0.2 0.17 0.85 0.80],[0.01 0.1]));
        plot([xpt1stLPre{1};xpt1stLStm{1};xpt1stLPost{1}],[30+ypt1stLPre{1};60+ypt1stLStm{1};90+ypt1stLPost{1}],'Marker','.','MarkerSize',markerS,'color',colorBlack,'markerFaceColor',colorBlack,'markerEdgeColor',colorBlack);
        pLight = patch(xpt_lightT,30+ypt_lightT,colorLLightBlue,'lineStyle','none');
        ylabel('Lap','FontSize',fontM);
        xlabel('Time (sec)','fontSize',fontM);
        uistack(pLight,'bottom');
        
    hPlot(2) = axes('Position',axpt(13,3,1:11,2,[0.2 0.07 0.85 0.80],[0.01 0.1]));
        plot([xptSpatial{2};xptSpatial{3};xptSpatial{4}],[yptSpatial{2};yptSpatial{3};yptSpatial{4}],'Marker','.','MarkerSize',markerS,'color',colorBlack,'markerFaceColor',colorBlack,'markerEdgeColor',colorBlack);
        pLight = patch([lightLoc(1) lightLoc(2) lightLoc(2) lightLoc(1)],[61 61 90 90], colorLLightBlue,'lineStyle','none');
        hold on;
        pRw(1) = patch([rewardLoc1(1), rewardLoc1(2), rewardLoc1(2), rewardLoc1(1)],[30, 30, 120, 120],colorLightRed);
        hold on;
        pRw(2) = patch([rewardLoc2(1), rewardLoc2(2), rewardLoc2(2), rewardLoc2(1)],[30, 30, 120, 120],colorLightRed);
        text(95, 130,[num2str(round(max(peakFR1D_track)*10)/10) ' Hz'],'fontSize',fontM);
        ylabel('Lap','FontSize',fontM);
        uistack(pLight,'bottom');
        uistack(pRw,'bottom');
        
    hPlot(3) = axes('Position',axpt(13,3,1:11,3,[0.2 0.14 0.85 0.80],[0.01 0.10]));
        modi_pethconvSpatial = [pethconvSpatial(2:4,:);nan(1,124)];
        hMap = pcolor(modi_pethconvSpatial);
        caxis([min(modi_pethconvSpatial(:)) max(modi_pethconvSpatial(:))])
        set(hMap,'lineStyle','none');
        xlabel('Location (cm)','fontSize',fontM);

    set(hPlot(1),'Box','off','TickDir','out','fontSize',fontM,'XLim',[-500 3000],'XTick',[-500, 0,1000, 2000, 3000],'XTickLabel',[-0.5 0, 1, 2, 3],'YLim',[30,120],'YTick',[30:30:120],'YTickLabel',[0 30 60 90]);
    set(hPlot(2),'Box','off','TickDir','out','fontSize',fontM,'XLim',[0,124],'XTick',[],'YLim',[30,120],'YTick',[30:30:120],'YTickLabel',[0 30 60 90]);
    set(hPlot(3),'Box','off','TickDir','out','fontSize',fontM,'XLim',[0,124],'XTick',[0:40:120],'XTickLabel',[0,40,80,120],'YTick',[1.5,2.5,3.5],'YTickLabel',{'PRE';'STIM';'POST'});

%     set(hPlot,'TickLength',[0.03, 0.03]);
    set(pLight,'LineStyle','none');
    set(pRw,'LineStyle','none','FaceAlpha',0.2);
    
    cd(saveDir);
%     print('-painters','-r300','-dtiff',[datestr(now,formatOut),'_cellID_',num2str(cellID(iCell)),'.tif']);
    print('-painters','-r300','-depsc',[datestr(now,formatOut),'_cellID_',num2str(cellID(iCell)),'.ai']);
    close;
end