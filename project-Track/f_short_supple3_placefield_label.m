rtDir = 'D:\Dropbox\SNL\P2_Track';
cd(rtDir);

load myParameters.mat;
load neuronList_ori50hz_171014.mat
formatOut = 'yymmdd';

fontM = 7;
markerS = 1.4;

% inzone
m_lapFrInPRE = cellfun(@(x) x(1),T.m_lapFrInzone); % PRE lap firing rate inzone
m_lapFrInSTM = cellfun(@(x) x(2),T.m_lapFrInzone); % PRE lap firing rate inzone
m_lapFrInPOST = cellfun(@(x) x(3),T.m_lapFrInzone); % PRE lap firing rate inzone
idx_pPRExSTM = cellfun(@(x) x(1,1)<0.05, T.p_ttestFR);  % Find mean firing rate p-value

% threshold condition
idx_inc = m_lapFrInPRE < m_lapFrInSTM;
idx_dec = m_lapFrInPRE > m_lapFrInSTM; % STM block decreased neurons (inactivation)
min_lapFrRun = min(m_lapFrInPRE(T.taskType == 'DRun' & T.idxNeurontype == 'PN' & idx_dec & idx_pPRExSTM));
min_lapFrRw = min(m_lapFrInPRE(T.taskType == 'DRw' & T.idxNeurontype == 'PN' & idx_dec & idx_pPRExSTM));
idx_FrRun = m_lapFrInPRE>min_lapFrRun; % min firing rate that can be detected by inactivation
idx_FrRw = m_lapFrInPRE>min_lapFrRw; % min firing rate that can be detected by inactivation

% cellID = T.cellID(T.taskType == 'DRun' & T.idxNeurontype == 'PN' & idx_FrRun & idx_pPRExSTM & idx_inc);
% saveDir = 'D:\Dropbox\SNL\P2_Track\example_short_supple_PC\RunAct';
% cellID = T.cellID(T.taskType == 'DRun' & T.idxNeurontype == 'PN' & idx_FrRun & idx_pPRExSTM & idx_dec);
% saveDir = 'D:\Dropbox\SNL\P2_Track\example_short_supple_PC\RunIna';
% cellID = T.cellID(T.taskType == 'DRun' & T.idxNeurontype == 'PN' & idx_FrRun & ~idx_pPRExSTM);
% saveDir = 'D:\Dropbox\SNL\P2_Track\example_short_supple_PC\RunNo';

% cellID = T.cellID(T.taskType == 'DRw' & T.idxNeurontype == 'PN' & idx_FrRw & idx_pPRExSTM & idx_inc);
% saveDir = 'D:\Dropbox\SNL\P2_Track\example_short_supple_PC\RwAct';
% cellID = T.cellID(T.taskType == 'DRw' & T.idxNeurontype == 'PN' & idx_FrRw & idx_pPRExSTM & idx_dec);
% saveDir = 'D:\Dropbox\SNL\P2_Track\example_short_supple_PC\RwIna';
% cellID = T.cellID(T.taskType == 'DRw' & T.idxNeurontype == 'PN' & idx_FrRw & ~idx_pPRExSTM);
% saveDir = 'D:\Dropbox\SNL\P2_Track\example_short_supple_PC\RwNo';

% cellID = [66, 129];
% nCell = length(cellID);
% saveDir = 'D:\Dropbox\SNL\P2_Track\example_short_supple_PC\FullLabel';
% plot_Track_multi_v50hz(T.path(cellID), T.cellID(cellID), saveDir);
% cellID = 5;
% load 'D:\Dropbox\SNL\P2_Track\neuronList_ori_control_171014.mat';  %% for control
% cellID = 2; %% for control
nCell = length(cellID); %% for control
saveDir = 'D:\Dropbox\SNL\P2_Track\example_short_supple_PC\FieldChange'; %% for control

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
    nCol = 5;
    nRow = 6;
    fHandle = figure('PaperUnits','centimeters','PaperPosition',[0 0 5 5.5]);
    figSize = [0.10 0.10 0.80 0.80];
    
    hPlot(1) = axes('Position',axpt(13,3,1:11,1,[0.2 0.12 0.85 0.85],[0.01 0.1]));
        plot([xpt1stLPre{1},xpt1stLStm{1},xpt1stLPost{1}],[ypt1stLPre{1},30+ypt1stLStm{1},60+ypt1stLPost{1}],'Marker','.','MarkerSize',markerS,'markerFaceColor',colorBlack,'markerEdgeColor','k','LineStyle','none');
        pLight = patch(xpt_lightT,ypt_lightT,colorLLightBlue);
%         rec = rectangle('Position',[0 31 lightDur 30], 'LineStyle','none','FaceColor',colorLLightBlue);
        ylabel('Trial','FontSize',fontM);
%         xlabel('Time (sec)','FontSize',fontM);
        uistack(pLight,'bottom');
%         text(300,-70,'Time (sec)','fontSize',fontM);
%     hPlot(2) = axes('Position',axpt(13,3,1:11,2,[0.2 0.04 0.85 0.85],[0.01 0.20]));    
    hPlot(2) = axes('Position',axpt(13,3,1:11,2,[0.2 0.04 0.85 0.85],[0.01 0.1]));
%         plot([xptSpatial{:}],[yptSpatial{:}],'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');
        plot([xptSpatial{:}],[yptSpatial{:}],'Marker','.','MarkerSize',markerS,'markerFaceColor',colorBlack,'markerEdgeColor','k','LineStyle','none');
        rec = rectangle('Position',[lightLoc(1), 31, lightLoc(2)-lightLoc(1), 30], 'LineStyle','none','FaceColor',colorLLightBlue);
        hold on;
%         pRw(1) = patch([rewardLoc(1)+2, rewardLoc(1)+6, rewardLoc(1)+6, rewardLoc(1)+2],[0, 0, 90, 90],colorLightRed);
        pRw(1) = patch([rewardLoc1(1), rewardLoc1(2), rewardLoc1(2), rewardLoc1(1)],[0, 0, 90, 90],colorLightRed);
        hold on;
%         pRw(2) = patch([rewardLoc(2)+2.5, rewardLoc(2)+6.5, rewardLoc(2)+6.5, rewardLoc(2)+2.5],[0, 0, 90, 90],colorLightRed);
        pRw(2) = patch([rewardLoc2(1), rewardLoc2(2), rewardLoc2(2), rewardLoc2(1)],[0, 0, 90, 90],colorLightRed);
        text(95, 105,[num2str(round(max(peakFR1D_track)*10)/10) ' Hz'],'fontSize',fontM);
        ylabel('Trial','FontSize',fontM);
        uistack(rec,'bottom');
        uistack(pRw,'bottom');
    hPlot(3) = axes('Position',axpt(13,3,1:11,3,[0.2 0.1 0.85 0.85],[0.01 0.10]));
        modi_pethconvSpatial = [pethconvSpatial;nan(1,124)];
        hMap = pcolor(modi_pethconvSpatial);
        caxis([min(modi_pethconvSpatial(:)) max(modi_pethconvSpatial(:))])
        set(hMap,'lineStyle','none');
%         text(30,-1.3,'Location (cm)','fontSize',fontM);
%         xlabel('Location (cm)','fontSize',fontM);

    set(hPlot(1),'Box','off','TickDir','out','fontSize',fontM,'XLim',[-500 3000],'XTick',[-500, 0,1000, 2000, 3000],'XTickLabel',{-0.5 0, 1, 2, '3 (s)'},'YLim',[0,90],'YTick',[0:30:90]);
    set(hPlot(2),'Box','off','TickDir','out','fontSize',fontM,'XLim',[0,124],'XTick',[],'YLim',[0, 90],'YTick',[0:30:90]);
    set(hPlot(3),'Box','off','TickDir','out','fontSize',fontM,'XLim',[0,124],'XTick',[0:40:120],'XTickLabel',{0,40,80,'120 (cm)'},'YTick',[1.5,2.5,3.5],'YTickLabel',{'PRE','STIM','POST'});

    set(hPlot,'TickLength',[0.03, 0.03]);
    set(pLight,'LineStyle','none');
    set(pRw,'LineStyle','none','FaceAlpha',0.2);
    
    cd(saveDir);
    print('-painters','-r300','-dtiff',[datestr(now,formatOut),'_cellID_',num2str(cellID(iCell)),'.tif']);
    print('-painters','-r300','-depsc',[datestr(now,formatOut),'_cellID_',num2str(cellID(iCell)),'.ai']);
    close;
end