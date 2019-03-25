function plot_Track_sin_Familiar
% Draw & Save figures about track project
% TT*.mat files in the each folders will be loaded and plotted
% Author: Joonyeup Lee
% Version 3.0 (12/12/2018)

load('E:\Dropbox\Lab_mwjung\P2_Track\myParameters.mat');
rtDir = 'E:\Dropbox\Lab_mwjung\P2_Track';

lineSpikeM = 0.8;
matFile = mLoad;
nFile = length(matFile);

for iFile = 1:nFile
    [cellDir, cellName, ~] = fileparts(matFile{iFile});
    cellDirSplit = regexp(cellDir,'\','split');
    cellFigName = strcat(cellDirSplit(end-2),'_',cellDirSplit(end),'_',cellName);
    cscTetrode = str2double(cellName(3)); % find a tetrode for csc analysis
    
    cd(cellDir);
    load(matFile{iFile});
    load('Events.mat');
    
    nCol = 10;
    nRow = 11;
    
%% Lap light time
    sensorOn = sensor(31:60,6);
    sensorOff = sensor(31:60,9);
    temp_lightT = [0; sensorOff-sensorOn];
    xpt_lightT = repmat(temp_lightT',2,1);
    xpt_lightT = xpt_lightT(:);
    xpt_lightT(1) = [];
    xpt_lightT = [xpt_lightT;0];
    
    ypt_lightT = repmat([30:60],2,1);
    ypt_lightT = ypt_lightT(:);
    
    rewardLoc1 = [20*pi*3/6 20*pi*4/6];
    rewardLoc2 = [20*pi*9/6 20*pi*10/6];
    
    iSensor1 = 6; % Light on sensor
    lightLoc = [20*pi*5/6 20*pi*8/6];
    
    testRangeChETA = 8; % ChETA light response test range (ex. 10ms)  
    
%% Cell information   
    fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{3});
    hText = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1:4,1:2,[0.03 0.1 0.85 0.89],tightInterval),wideInterval));
    text(0,0.9,matFile{iFile}, 'FontSize',fontS, 'Interpreter','none','FontWeight','bold');
    text(0,0.75,['Mean firing rate (basePRE): ',num2str(meanFR_PlfmPre,3), ' Hz'], 'FontSize',fontS);
    text(0,0.65,['Mean firing rate (task): ',num2str(meanFR_Task,3), ' Hz'], 'FontSize',fontS);
    text(0,0.55,['Spike width: ',num2str(spkwth,3),' us'], 'FontSize',fontS);
    text(0,0.45,['Half-valley width: ',num2str(hfvwth,3),' us'], 'FontSize',fontS);
    text(0,0.35,['Peak valley ratio: ',num2str(spkpvr,3)], 'FontSize',fontS);
    set(hText,'Visible','off');
    
%% Waveform
    yLimWaveform = [min(spkwv(:)), max(spkwv(:))];
    for iCh = 1:4
        hWaveform(iCh) = axes('Position',axpt(4,1,iCh,1,axpt(nCol,nRow,3:5,2,[0.06 0.4 0.85 0.60],tightInterval),midInterval));
        plot(spkwv(iCh,:), 'LineWidth', lineL, 'Color','k');
        if iCh == 4
            line([24 32], [yLimWaveform(2)-50 yLimWaveform(2)-50], 'Color','k', 'LineWidth', lineM);
            line([24 24],[yLimWaveform(2)-50 yLimWaveform(2)], 'Color','k', 'LineWidth',lineM);
        end
    end
    set(hWaveform, 'Visible', 'off','XLim',[1 32], 'YLim',yLimWaveform*1.05);
    
%% Platform light intensity plot
    hIntensity = axes('Position',axpt(1,3,1,1:2,axpt(nCol,nRow,5,1:2,[0.15 0.10 0.85 0.85],tightInterval),wideInterval));
    text(0, 0.9,'Platform laser Pw (%)','fontSize',fontM,'fontWeight','bold');
    text(0.3, 0.7,['5 mW: ',num2str(round(lightProbPlfm5mw*10)/10)],'fontSize',fontS);
    text(0.3, 0.5,['8 mW: ',num2str(round(lightProbPlfm8mw*10)/10)],'fontSize',fontS);
    text(0.3, 0.3,['10 mW: ',num2str(round(lightProbPlfm10mw*10)/10)],'fontSize',fontS);
    set(hIntensity,'Box','off','visible','off');
   
%% Spike probability
    hTextSpkProb = axes('Position',axpt(1,3,1,1:2,axpt(nCol,nRow,8:10,1:2,[0.1 0.10 0.85 0.85],tightInterval),wideInterval));
    text(0,0.9,'Spike probability (%)','fontSize',fontM,'fontWeight','bold');
    text(0.1,0.7,['Plfm 2Hz spike Prob. : ',num2str(round(lightProbPlfm_2hz*10)/10)],'fontSize',fontS);
    text(0.1,0.5,['Plfm 50Hz spike Prob. : ',num2str(round(lightProbPlfm_50hz*10)/10)],'fontSize',fontS);
    text(0.1,0.3,['Track 50Hz spike Prob. : ',num2str(round(lightProbTrack_50hz*10)/10)],'fontSize',fontS);
    set(hTextSpkProb,'Box','off','visible','off');

%% Spatial raster plot
    hSRaster = axes('Position',axpt(1,3,1,1,axpt(nCol,nRow,1:4,1:3,[0.1 0.12 0.80 0.70],tightInterval),wideInterval));
        plot([xptSpatial{1};xptSpatial{2};xptSpatial{3}],[yptSpatial{1};yptSpatial{2};yptSpatial{3}],'lineWidth',lineSpikeM,'Color','k');
        pLight = patch([lightLoc(1) lightLoc(2) lightLoc(2) lightLoc(1)],[31 31 60 60],colorLLightBlue,'LineStyle','none');
        ylabel('Trial','FontSize',fontS);
        title('Spatial Raster & PETH at S01','FontSize',fontM,'FontWeight','bold');
    hSPsth = axes('Position',axpt(1,3,1,2,axpt(nCol,nRow,1:4,1:3,[0.1 0.12 0.80 0.70],tightInterval),wideInterval));
        ylimpethSpatial = ceil(max(pethconvSpatial(pethconvSpatial<inf))*1.1+0.0001);
        pRw(1) = patch([rewardLoc1(1), rewardLoc1(2), rewardLoc1(2), rewardLoc1(1)],[0, 0, ylimpethSpatial, ylimpethSpatial],colorLightRed);
        hold on;
        pRw(2) = patch([rewardLoc2(1), rewardLoc2(2), rewardLoc2(2), rewardLoc2(1)],[0, 0, ylimpethSpatial, ylimpethSpatial],colorLightRed);
        hold on;
        for iType = 1:3
            plot(pethSpatial(1:124),pethconvSpatial(iType,:),'LineStyle','-','LineWidth',lineM,'Color',lineColor{iType})
        end
        peakFR_track = round(max(peakFR1D_track)*10)/10;
        text(115,ylimpethSpatial*0.8,[num2str(peakFR_track),' Hz'],'fontSize',fontS);
        ylabel('Rate (Hz)','FontSize',fontS);
%         xlabel('Position (cm)','FontSize',fontS);
        uistack(pLight,'bottom');

    hMap = axes('Position',axpt(1,3,1,3,axpt(nCol,nRow,1:4,1:3,[0.1 0.11 0.80 0.70],tightInterval),wideInterval));
        modi_pethconvSpatial = [pethconvSpatial;nan(1,124)];
        hField = pcolor(modi_pethconvSpatial);
        caxis([min(modi_pethconvSpatial(:)) max(modi_pethconvSpatial(:))]);
    set(hField,'lineStyle','none');
    xlabel('Location (cm)','fontSize',fontS);
    set(hMap,'Box','off','TickDir','out','fontSize',fontS,'XLim',[0,124],'XTick',[0:40:120],'XTickLabel',{0,40,80,'120 (cm)'},'YTick',[1.5,2.5,3.5],'YTickLabel',{'PRE','STIM','POST'});

    align_ylabel([hSRaster,hSPsth],-0.3,0);
    set(hSRaster,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS,'XLim',[0 124],'XTick',[],'YLim',[0, 90],'YTick',0:30:90);
    set(hSPsth,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS,'XLim',[0, 124],'XTick',[0:10:120],'YLim',[0, ylimpethSpatial],'YTick',[0,ylimpethSpatial]);
    set(pRw,'LineStyle','none','FaceAlpha',0.2);
    
%% Response check: Track
    nBlue = length(lightTime.Track);
    winBlue = [min(pethtimeTrackLight) max(pethtimeTrackLight)];
    hTrackBlue(1) = axes('Position',axpt(2,3,1,1,axpt(nCol,nRow,6:10,1:3,[0.11 0.12 0.8 0.7],tightInterval),wideInterval));
        plot(xptTrackLight{1},yptTrackLight{1},'lineWidth',lineSpikeM,'Color','k');
        ylabel('Light','FontSize',fontS);
        title('Each light onset','FontSize',fontM,'FontWeight','bold');
    set(hTrackBlue(1),'XLim',winBlue,'XTick',[],'YLim',[0 nBlue], 'YTick', [0 nBlue], 'YTickLabel', {0, nBlue});
% Psth
    hTrackBlue(2) = axes('Position',axpt(2,3,1,2,axpt(nCol,nRow,6:10,1:3,[0.11 0.12 0.8 0.7],tightInterval),wideInterval));
        yLimBarBlue = ceil(max(pethTrackLight(:))*1.05+0.0001);
        patch([0 10 10 0],[0, 0, yLimBarBlue, yLimBarBlue],colorLLightBlue,'LineStyle','none');
        hold on;
        hBarBlue = bar(pethtimeTrackLight, pethTrackLight, 'histc');
        text(sum(winBlue)*0.6,yLimBarBlue*0.9,['latency = ', num2str(latencyTrack1st,3)],'FontSize',fontS,'interpreter','none');
        ylabel('Rate (Hz)','FontSize',fontS);
        xlabel('Time (ms)','FontSize',fontS);
    set(hBarBlue, 'FaceColor','k', 'EdgeAlpha',0);
    set(hTrackBlue(2), 'XLim', winBlue, 'XTick', [winBlue(1),winBlue(2)],'XTickLabel',{winBlue(1);winBlue(2)},'YLim', [0 yLimBarBlue], 'YTick', [0 yLimBarBlue], 'YTickLabel', {[], yLimBarBlue});
    set(hTrackBlue,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS);
    align_ylabel(hTrackBlue,0,0)

%% Burst onset
    winBlue = [min(pethtime1stBStm) max(pethtime1stBStm)];
% Raster
    hTrackLBurst(1) = axes('Position',axpt(2,3,2,1,axpt(nCol,nRow,6:10,1:3,[0.15 0.12 0.80 0.7],tightInterval),wideInterval));
        plot(xpt1stBStm{1},ypt1stBStm{1},'lineWidth',lineSpikeM,'Color','k');
        ylabel('# of Burst', 'FontSize',fontS);
        title('Each burst onset','FontSize',fontM,'FontWeight','bold');
    set(hTrackLBurst(1),'XLim',winBlue,'XTick',[],'YLim',[0 nBurst_Track], 'YTick', [0 nBurst_Track]);
    hTrackLBurst(2) = axes('Position',axpt(2,3,2,2,axpt(nCol,nRow,6:10,1:3,[0.15 0.12 0.80 0.7],tightInterval),wideInterval));
        yLimBarBlue = ceil(max(peth1stBStm(:))*1.05+0.0001);
        for iTrain = 1:nTrain_Track
            pLight = patch([20*(iTrain-1) 20*(iTrain-1)+10 20*(iTrain-1)+10 20*(iTrain-1)],[0, 0, yLimBarBlue, yLimBarBlue],colorLLightBlue,'LineStyle','none');
            hold on;
        end
        hBar = bar(pethtime1stBStm, peth1stBStm, 'histc');
        xlabel('Time (ms)','FontSize',fontS);
        ylabel('Rate (Hz)','FontSize',fontS);
    set(hBar, 'FaceColor','k', 'EdgeAlpha',0);
    set(hTrackLBurst(2), 'XLim', winBlue, 'XTick', [winBlue(1),0:20:60, winBlue(2)],'YLim', [0 yLimBarBlue], 'YTick', [0 yLimBarBlue], 'YTickLabel', {[], yLimBarBlue});
    set(hTrackLBurst,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS);
    align_ylabel(hTrackLBurst,0,0)

%% light raster (Temporal)
    hLightLap(1) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,1:4,4:5,[0.1 0.05 0.80 0.70],tightInterval),wideInterval));
        plot([xpt1stLPre{1};xpt1stLStm{1};xpt1stLPost{1}],[ypt1stLPre{1};ypt1stLStm{1}+30;ypt1stLPost{1}+60],'lineWidth',lineSpikeM,'color','k');
        hold on;
        pLight = patch(xpt_lightT,ypt_lightT,colorLLightBlue,'LineStyle','none');
        ylabel('Trial','FontSize',fontS);
        title('Raster & PETH aligned on Light onset','fontSize',fontM,'fontWeight','bold');
    hLightLap(2) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,1:4,4:5,[0.1 0.03 0.80 0.70],tightInterval),wideInterval));
        ylimpeth = ceil(max([pethConv1stLPre,pethConv1stLStm,pethConv1stLPost])*1.1+0.0001);
        hold on;
        plot(pethtime1stLPre,pethConv1stLPre,'LineStyle','-','LineWidth',lineM,'Color',colorGray);
        plot(pethtime1stLStm,pethConv1stLStm,'LineStyle','-','LineWidth',lineM,'Color',colorBlue);
        plot(pethtime1stLPost,pethConv1stLPost,'LineStyle','-','LineWidth',lineM,'Color',colorBlack);
        xlabel('Time (ms)','FontSize',fontS);
        ylabel('Rate (Hz)','FontSize',fontS);
        uistack(pLight,'bottom');

    set(hLightLap,'TickDir','out','Box','off','XLim',[-500, 2000],'XTick',[-500:500:2000]);
    set(hLightLap(1),'YLim',[0,90],'YTick',[0:30:90],'fontSize',fontS);
    set(hLightLap(2),'YLim',[0,ylimpeth],'YTick',[0, ylimpeth],'fontSize',fontS);
    
%% Zone spike analysis
    yLimTotal = max(sum_totalSpike)*1.2+0.01;
    yLimInzone = max(sum_inzoneSpike)*1.2+0.01;
    yLimOutzone = max(sum_outzoneSpike)*1.2+0.01;
    hSpike(1) = axes('Position',axpt(3,2,1,1,axpt(nCol,nRow,6:10,4:5,[0.12 0.05 0.80 0.70],tightInterval),wideInterval));
        plot([1,2,3],sum_totalSpike,'-o','color',colorBlack,'MarkerEdgeColor',colorBlack,'MarkerFaceColor',colorGray,'MarkerSize',markerM);
        if p_ttestFr(1,3) < 0.05
            line([1.1,1.9],[yLimTotal yLimTotal]/1.2*1.05,'lineStyle','-','lineWidth',lineM,'color',colorBlack);
            text(1.5,yLimTotal/1.2*1.05,'*','fontSize',fontM,'color',colorRed);
        end
        if p_ttestFr(2,3) < 0.05
            line([1,3],[yLimTotal yLimTotal]/1.2*1.1,'lineStyle','-','lineWidth',lineM,'color',colorBlack);
            text(2,yLimTotal/1.2*1.1,'*','fontSize',fontM,'color',colorRed);
        end
        if p_ttestFr(3,3) < 0.05
            line([2.1,2.9],[yLimTotal yLimTotal]/1.2*1.05,'lineStyle','-','lineWidth',lineM,'color',colorBlack);
            text(2.5,yLimTotal/1.2*1.05,'*','fontSize',fontM,'color',colorRed);
        end
        title('Total','fontSize',fontS);
        ylabel('Spike number','fontSize',fontS);
    hSpike(2) = axes('Position',axpt(3,2,2,1,axpt(nCol,nRow,6:10,4:5,[0.12 0.05 0.80 0.70],tightInterval),wideInterval));
        plot([1,2,3],sum_inzoneSpike,'-o','color',colorBlack,'MarkerEdgeColor',colorBlack,'MarkerFaceColor',colorGray,'MarkerSize',markerM);
        if p_ttestFr(1,1) < 0.05
            line([1.1,1.9],[yLimInzone yLimInzone]/1.2*1.05,'lineStyle','-','lineWidth',lineM,'color',colorBlack);
            text(1.5,yLimInzone/1.2*1.05,'*','fontSize',fontM,'color',colorRed);
        end
        if p_ttestFr(2,1) < 0.05
            line([1,3],[yLimInzone yLimInzone]/1.2*1.1,'lineStyle','-','lineWidth',lineM,'color',colorBlack);
            text(2,yLimInzone/1.2*1.1,'*','fontSize',fontM,'color',colorRed);
        end
        if p_ttestFr(3,1) < 0.05
            line([2.1,2.9],[yLimInzone yLimInzone]/1.2*1.05,'lineStyle','-','lineWidth',lineM,'color',colorBlack);
            text(2.5,yLimInzone/1.2*1.05,'*','fontSize',fontM,'color',colorRed);
        end
        title('Light-zone','fontSize',fontS);
    hSpike(3) = axes('Position',axpt(3,2,3,1,axpt(nCol,nRow,6:10,4:5,[0.12 0.05 0.80 0.70],tightInterval),wideInterval));
        plot([1,2,3],sum_outzoneSpike,'-o','color',colorBlack,'MarkerEdgeColor',colorBlack,'MarkerFaceColor',colorGray,'MarkerSize',markerM);
        if p_ttestFr(1,2) < 0.05
            line([1.1,1.9],[yLimOutzone yLimOutzone]/1.2*1.05,'lineStyle','-','lineWidth',lineM,'color',colorBlack);
            text(1.5,yLimOutzone/1.2*1.05,'*','fontSize',fontM,'color',colorRed);
        end
        if p_ttestFr(2,2) < 0.05
            line([1,3],[yLimOutzone yLimOutzone]/1.2*1.1,'lineStyle','-','lineWidth',lineM,'color',colorBlack);
            text(2,yLimOutzone/1.2*1.1,'*','fontSize',fontM,'color',colorRed);
        end
        if p_ttestFr(3,2) < 0.05
            line([2.1,2.9],[yLimOutzone yLimOutzone]/1.2*1.05,'lineStyle','-','lineWidth',lineM,'color',colorBlack);
            text(2.5,yLimOutzone/1.2*1.05,'*','fontSize',fontM,'color',colorRed);
        end
        title('Unlight-zone','fontSize',fontS);
    set(hSpike,'Box','off','TickDir','out','XLim',[0,4],'XTick',1:3,'XTickLabel',{'PR';'ST';'PO'},'fontSize',fontS);
    set(hSpike(1),'YLim',[0 yLimTotal]);
    set(hSpike(2),'YLim',[0 yLimInzone]);
    set(hSpike(3),'YLim',[0 yLimOutzone]);

%% spatial information analysis
    yLimInfoSpike = max(infoSpike)*1.2;
    yLimInfoSecond = max(infoSecond)*1.2;
    hInfo(1) = axes('Position',axpt(2,2,1,2,axpt(nCol,nRow,6:10,4:5,[0.12 0.02 0.8 0.70],tightInterval),wideInterval));
        bar([1,2,3,4],infoSpike,0.6,'faceColor',colorGray,'edgeColor',colorBlack);
        ylabel('bits/spike','fontSize',fontS);
        title('Information per spike','fontSize',fontS);
    hInfo(2) = axes('Position',axpt(2,2,2,2,axpt(nCol,nRow,6:10,4:5,[0.12 0.02 0.8 0.70],tightInterval),wideInterval));
        bar([1,2,3,4],infoSecond,0.6,'faceColor',colorGray,'edgeColor',colorBlack);
        ylabel('bits/sec','fontSize',fontS);
        title('Information per second','fontSize',fontS);
    set(hInfo,'Box','off','TickDir','out','XLim',[0,5],'XTick',1:4,'XTickLabel',{'PR';'ST';'PO';'Total'},'fontSize',fontS);
    set(hInfo(1),'YLim',[0, yLimInfoSpike]);
    set(hInfo(2),'YLim',[0, yLimInfoSecond]);

%% Place field cross-correlation
    hSCorr = axes('Position',axpt(1,4,1,1:3,axpt(nCol,nRow,1:4,8:9,[0.1 0.10 0.80 0.70],tightInterval),wideInterval));
        plot(rCorrConvMov1D','color',colorBlack,'lineWidth',1)
        hold on;
        patch([31,60,60,31],[-0.98, -0.98, -0.90, -0.90],colorLightBlue,'LineStyle','none')
        grid on;
        xlabel('Smoothed lap','fontSize',fontS);
        ylabel('r','fontSize',fontS);
        title('Smoothed crossCorr','fontSize',fontM,'fontWeight','bold');
    set(hSCorr,'Box','off','TickDir','out','XLim',[1,90],'XTick',[1,21,31,61,71,90],'YLim',[0,1.2],'YTick',[0:0.2:1],'fontSize',fontS);

%% Response check: Platform
    nBlue = length(lightTime.Plfm2hz)/3;
    winBlue = [-25, 200];
% Raster
    hPlfmBlue(1) = axes('Position',axpt(3,8,1,1:2,axpt(nCol,nRow,6:10,8:10,[0.07 0.1 0.85 0.70],tightInterval),wideInterval));
        plot(xptPlfm2hz{1},yptPlfm2hz{1},'lineWidth',lineSpikeM,'Color','k');
        set(hPlfmBlue(1),'XLim',winBlue,'XTick',[],'YLim',[0 nBlue], 'YTick', [0 nBlue], 'YTickLabel', {0, nBlue});
        ylabel('# of Light','FontSize',fontS);
        title('Plfm (2Hz)','FontSize',fontM,'FontWeight','bold');
% Psth
    hPlfmBlue(2) = axes('Position',axpt(3,8,1,3:4,axpt(nCol,nRow,6:10,8:10,[0.07 0.1 0.85 0.70],tightInterval),wideInterval));
        yLimBarBlue = ceil(max(pethPlfm2hz(:))*1.05+0.0001);
        patch([0 10 10 0],[0, 0, yLimBarBlue, yLimBarBlue],colorLLightBlue,'LineStyle','none');
        hold on;
        hBarBlue = bar(pethtimePlfm2hz, pethPlfm2hz, 'histc');
        text(sum(winBlue)*0.3,yLimBarBlue*0.9,['latency = ', num2str(latencyPlfm2hz1st,3)],'FontSize',fontS,'interpreter','none');
        set(hBarBlue, 'FaceColor','k', 'EdgeAlpha',0);
        set(hPlfmBlue(2), 'XLim', winBlue, 'XTick', [winBlue(1) 0 winBlue(2)],'XTickLabel',{winBlue(1);0;num2str(winBlue(2))},'YLim', [0 yLimBarBlue], 'YTick', [0 yLimBarBlue], 'YTickLabel', {[], yLimBarBlue});
        xlabel('Time (ms)','FontSize',fontS);
        ylabel('Rate (Hz)', 'FontSize',fontS);
% Hazard function
    hPlfmBlue(3) = axes('Position',axpt(3,8,1,7:8,axpt(nCol,nRow,6:10,8:11,[0.07 0.15 0.85 0.9],tightInterval),wideInterval));
        ylimH = min([ceil(max([H1_Plfm2hz;H2_Plfm2hz])*1100+0.0001)/1000 1]);
        winHTag = [0 testRangeChETA];
        stairs(timeLR_Plfm2hz, H2_Plfm2hz, 'LineStyle',':','LineWidth',lineL,'Color','k');
        stairs(timeLR_Plfm2hz, H1_Plfm2hz,'LineStyle','-','LineWidth',lineL,'Color',colorBlue);
        text(diff(winHTag)*0.1,ylimH*0.9,['p = ',num2str(pLR_Plfm2hz,3)],'FontSize',fontS,'Interpreter','none');
        text(diff(winHTag)*0.1,ylimH*0.7,['calib: ',num2str(calibPlfm2hz,3),' ms'],'FontSize',fontS,'Interpreter','none');
        set(hPlfmBlue(3),'XLim',winHTag,'XTick',winHTag,'YLim',[0 ylimH], 'YTick', [0 ylimH], 'YTickLabel', {[], ylimH});
        xlabel('Time (ms)','FontSize',fontS);
        ylabel('H(t)','FontSize',fontS);
        title('LR test (2Hz)','FontSize',fontM,'FontWeight','bold');
        set(hPlfmBlue,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS);
    align_ylabel(hPlfmBlue,0,0)

%% Response check: Plfm50hz
        nBlue = length(lightTime.Plfm50hz);
        winBlue = [min(pethtimePlfm50hz) max(pethtimePlfm50hz)];
% Raster
    hPlfmBlue(1) = axes('Position',axpt(3,8,2,1:2,axpt(nCol,nRow,6:10,8:10,[0.12 0.1 0.80 0.70],tightInterval),wideInterval));
        plot(xptPlfm50hz{1},yptPlfm50hz{1},'LineWidth',lineSpikeM,'Color','k');
        set(hPlfmBlue(1),'XLim',winBlue,'XTick',[],'YLim',[0 nBlue], 'YTick', [0 nBlue], 'YTickLabel', {0, nBlue});
%         ylabel('# of Light','FontSize',fontS);
        title('Plfm (50Hz)','FontSize',fontM,'FontWeight','bold');
    hPlfmBlue(2) = axes('Position',axpt(3,8,2,3:4,axpt(nCol,nRow,6:10,8:10,[0.12 0.1 0.80 0.70],tightInterval),wideInterval));
        yLimBarBlue = ceil(max(pethPlfm50hz(:))*1.05+0.0001);
        patch([0 10 10 0],[0, 0, yLimBarBlue, yLimBarBlue],colorLLightBlue,'LineStyle','none');
        hold on;
        hBarBlue = bar(pethtimePlfm50hz, pethPlfm50hz, 'histc');
        if statDir_Plfm50hz == 1
            text(sum(winBlue)*0.3,yLimBarBlue*0.9,['latency = ', num2str(latencyPlfm50hz1st,3)],'FontSize',fontS,'interpreter','none');
        else
        end
        set(hBarBlue, 'FaceColor','k', 'EdgeAlpha',0);
        set(hPlfmBlue(2), 'XLim', winBlue, 'XTick', [winBlue(1) winBlue(2)],'XTickLabel',{winBlue(1);winBlue(2)},'YLim', [0 yLimBarBlue], 'YTick', [0 yLimBarBlue], 'YTickLabel', {[], yLimBarBlue});
        xlabel('Time (ms)','FontSize',fontS);
%         ylabel('Rate (Hz)', 'FontSize',fontM);
    hPlfmBlue(3) = axes('Position',axpt(3,8,2,7:8,axpt(nCol,nRow,6:10,8:11,[0.12 0.15 0.80 0.9],tightInterval),wideInterval));
        ylimH = min([ceil(max([H1_Plfm50hz;H2_Plfm50hz])*1100+0.0001)/1000 1]);
        winHTag = [0 testRangeChETA];
        stairs(timeLR_Plfm50hz, H2_Plfm50hz, 'LineStyle',':','LineWidth',lineL,'Color','k');
        stairs(timeLR_Plfm50hz, H1_Plfm50hz,'LineStyle','-','LineWidth',lineL,'Color',colorBlue);
        text(diff(winHTag)*0.1,ylimH*0.9,['p = ',num2str(pLR_Plfm50hz,3)],'FontSize',fontS,'Interpreter','none');
        text(diff(winHTag)*0.1,ylimH*0.7,['calib: ',num2str(calibPlfm50hz,3),' ms'],'FontSize',fontS,'Interpreter','none');
        set(hPlfmBlue(3),'XLim',winHTag,'XTick',winHTag,'YLim',[0 ylimH], 'YTick', [0 ylimH], 'YTickLabel', {[], ylimH});
        xlabel('Time (ms)','FontSize',fontS);
%         ylabel('H(t)','FontSize',fontM);
        title('LR test (50Hz)','FontSize',fontM,'FontWeight','bold');
        set(hPlfmBlue,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS);
    align_ylabel(hPlfmBlue,0,0)

% Plfm 50hz Burst onset
        winBurstPlfm = [min(pethtimePlfm1stBStm) max(pethtimePlfm1stBStm)];
    hPlfmBurst(1) = axes('Position',axpt(3,8,3,1:2,axpt(nCol,nRow,6:10,8:10,[0.14 0.1 0.80 0.70],tightInterval),wideInterval));
        plot(xptPlfm1stBStm{1},yptPlfm1stBStm{1},'LineWidth',lineSpikeM,'Color','k');
        set(hPlfmBurst(1),'XLim',winBlue,'XTick',[],'YLim',[0 nBurst_Plfm], 'YTick', [0 nBurst_Plfm]);
%         ylabel('# of Burst','FontSize',fontS);
        title('Plfm Burst Onset','FontSize',fontM,'FontWeight','bold');
    hPlfmBurst(2) = axes('Position',axpt(3,8,3,3:4,axpt(nCol,nRow,6:10,8:10,[0.14 0.1 0.80 0.70],tightInterval),wideInterval));
        yLimBarBlue = ceil(max(peth1stPlfmBStm(:))*1.05+0.0001);
        for iTrain = 1:nTrain_Plfm
            pLight = patch([20*(iTrain-1) 20*(iTrain-1)+10 20*(iTrain-1)+10 20*(iTrain-1)],[0, 0, yLimBarBlue, yLimBarBlue],colorLLightBlue,'LineStyle','none');
            hold on;    
        end
        hBarBlue = bar(pethtimePlfm1stBStm, peth1stPlfmBStm, 'histc');
        xlabel('Time (ms)','FontSize',fontS);
        set(hBarBlue, 'FaceColor','k', 'EdgeAlpha',0);
        set(hPlfmBurst(2), 'XLim', winBurstPlfm, 'XTick', [winBurstPlfm(1) winBurstPlfm(2)],'XTickLabel',{winBurstPlfm(1);0;winBurstPlfm(2)},'YLim', [0 yLimBarBlue], 'YTick', [0 yLimBarBlue], 'YTickLabel', {[], yLimBarBlue});
        set(hPlfmBurst,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS);

%% Cell ID
    hID = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,10,1,[0.11 0.18 0.80 0.80],tightInterval),wideInterval));
    text(0.6, 1, ['Cell ID: ',num2str(iFile)],'FontSize',fontM,'fontWeight','bold');
    set(hID,'visible','off');
    
    print('-painters','-r300',[cellFigName{1},'.tif'],'-dtiff');
%     print(-painters','-r300',[cellFigName{1},'.ai'],'-depsc');
    close;
end
fclose('all');
end