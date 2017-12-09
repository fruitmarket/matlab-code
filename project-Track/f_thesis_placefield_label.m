rtDir = 'D:\Dropbox\SNL\P2_Track';
cd(rtDir);

load('D:\Dropbox\SNL\P2_Track\myParameters.mat');
formatOut = 'yymmdd';
fontM = 8;
markerS = 1.4;

%% 8 Hz example
% load neuronList_ori_171018.mat;
% saveDir = 'D:\Dropbox\SNL\P2_Track\example_track_PF_DRun';
% cellID = [557 792 32 388 436 29];

% saveDir = 'D:\Dropbox\SNL\P2_Track\example_track_PF_DRw';
% cellID = [551 24 16 742 879 396];

%% 50 Hz example
% load neuronList_ori50hz_171014.mat
% saveDir = 'D:\Dropbox\SNL\P2_Track\example_track_PF_DRun50hz';
% cellID = [113 66 26 125 102 65]; % for DRun sessions
% saveDir = 'D:\Dropbox\SNL\P2_Track\example_track_PF_DRw50hz';
% cellID = [73 24 3 36 129 118]; % dor DRw sessions

%% permanent change (8 Hz)
% load neuronList_ori_171018.mat;
% saveDir = 'D:\Dropbox\SNL\P2_Track\example_track_PF_change_DRun';
% cellID = [173 420];
% saveDir = 'D:\Dropbox\SNL\P2_Track\example_track_PF_change_DRw';
% cellID = [712 806];

%% control change
load neuronList_ori_171018.mat;
% saveDir = 'D:\Dropbox\SNL\P2_Track\example_track_PF_change_noRun';
% cellID = 954;
% saveDir = 'D:\Dropbox\SNL\P2_Track\example_track_PF_change_noRw';
% cellID = 345;

%%
nCell = length(cellID); %% for control
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
if(regexp(cellDir,'Run'))
    sensorOn = sensor.S6(31:60);
    sensorOff = sensor.S9(31:60);
    lightLoc = [20*pi*5/6 20*pi*8/6];
else
    sensorOn = sensor.S10(31:60);
    sensorOff = sensor.S11(31:60);
    lightLoc = [20*pi*9/6 20*pi*10/6];
end
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
    fHandle = figure('PaperUnits','centimeters','PaperPosition',[0 0 5 4]);
    
    hPlot(1) = axes('Position',axpt(13,7,1:11,1:2,[0.2 0.12 0.85 0.85],[0.01 0.1]));
        plot([xpt1stLPre{1},xpt1stLStm{1},xpt1stLPost{1}],[ypt1stLPre{1},30+ypt1stLStm{1},60+ypt1stLPost{1}],'Marker','.','MarkerSize',markerS,'markerFaceColor',colorBlack,'markerEdgeColor','k','LineStyle','none');
%         pLight = patch(xpt_lightT,ypt_lightT,colorLLightBlue);
        pLight = patch(xpt_lightT,ypt_lightT,colorLightGray);
%         rec = rectangle('Position',[0 31 lightDur 30], 'LineStyle','none','FaceColor',colorLLightBlue);
        ylabel('Trial','FontSize',fontM);
%         xlabel('Time (sec)','FontSize',fontM);
        uistack(pLight,'bottom');
%         text(300,-70,'Time (sec)','fontSize',fontM);
%     hPlot(2) = axes('Position',axpt(13,3,1:11,2,[0.2 0.04 0.85 0.85],[0.01 0.20]));    
    hPlot(2) = axes('Position',axpt(13,7,1:11,3:4,[0.2 0.01 0.85 0.75],[0.01 0.10]));
%         plot([xptSpatial{:}],[yptSpatial{:}],'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');
        plot([xptSpatial{:}],[yptSpatial{:}],'Marker','.','MarkerSize',markerS,'markerFaceColor',colorBlack,'markerEdgeColor','k','LineStyle','none');
%         rec = rectangle('Position',[lightLoc(1), 31, lightLoc(2)-lightLoc(1), 30], 'LineStyle','none','FaceColor',colorLLightBlue);
        rec = rectangle('Position',[lightLoc(1), 31, lightLoc(2)-lightLoc(1), 30], 'LineStyle','none','FaceColor',colorLightGray);
        hold on;
%         pRw(1) = patch([rewardLoc(1)+2, rewardLoc(1)+6, rewardLoc(1)+6, rewardLoc(1)+2],[0, 0, 90, 90],colorLightRed);
        pRw(1) = patch([rewardLoc1(1), rewardLoc1(2), rewardLoc1(2), rewardLoc1(1)],[0, 0, 90, 90],colorLightRed);
        hold on;
%         pRw(2) = patch([rewardLoc(2)+2.5, rewardLoc(2)+6.5, rewardLoc(2)+6.5, rewardLoc(2)+2.5],[0, 0, 90, 90],colorLightRed);
        pRw(2) = patch([rewardLoc2(1), rewardLoc2(2), rewardLoc2(2), rewardLoc2(1)],[0, 0, 90, 90],colorLightRed);
        text(95, 107,[num2str(round(max(peakFR1D_track)*10)/10) ' Hz'],'fontSize',fontM);
        ylabel('Trial','FontSize',fontM);
        uistack(rec,'bottom');
        uistack(pRw,'bottom');
    hPlot(3) = axes('Position',axpt(13,7,1:11,5:6,[0.2 0.01 0.85 0.80],[0.01 0.10]));
        modi_pethconvSpatial = [pethconvSpatial;nan(1,124)];
        hMap = pcolor(modi_pethconvSpatial);
        caxis([min(modi_pethconvSpatial(:)) max(modi_pethconvSpatial(:))])
        set(hMap,'lineStyle','none');
%         text(30,-1.3,'Location (cm)','fontSize',fontM);
%         xlabel('Location (cm)','fontSize',fontM);

    set(hPlot(1),'Box','off','TickDir','out','fontSize',fontM,'XLim',[-500 3000],'XTick',[-500, 0,1000, 2000, 3000],'XTickLabel',{-0.5 0, 1, 2, '3 (s)'},'YLim',[0,90],'YTick',[0:30:90]);
    set(hPlot(2),'Box','off','TickDir','out','fontSize',fontM,'XLim',[0,124],'XTick',[],'YLim',[0, 90],'YTick',[0:30:90]);
    set(hPlot(3),'Box','off','TickDir','out','fontSize',fontM,'XLim',[0,124],'XTick',[0:40:120],'XTickLabel',{0,40,80,'120 (cm) '},'YTick',[1.5,2.5,3.5],'YTickLabel',{'PRE','STIM','POST'});

    set(hPlot,'TickLength',[0.03, 0.03]);
    set(pLight,'LineStyle','none');
    set(pRw,'LineStyle','none','FaceAlpha',0.2);

    cd(saveDir);
    print('-painters','-r300','-dtiff',[datestr(now,formatOut),'_cellID_',num2str(cellID(iCell)),'.tif']);
    print('-painters','-r300','-depsc',[datestr(now,formatOut),'_cellID_',num2str(cellID(iCell)),'.ai']);
    close;
end