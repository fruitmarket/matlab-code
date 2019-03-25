function plot_Track_multi_Novel(fileList, cellID, saveDir)
% Draw & Save figures about track project
% TT*.mat files in the each folders will be loaded and plotted
% Author: Joonyeup Lee
% Version 3.0 (12/14/2016)

load('E:\Dropbox\Lab_mwjung\P2_Track\myParameters.mat');
% rtDir = 'E:\Dropbox\SNL\P2_Track';

fontM = 7;
lineColor = {[225,138,128]/255,...
             [197 202 233]/255,...
             [63 81 181]/255,...
             [23 35 126]/255,...
             [213,0,0]/255};
lineSpikeM = 0.8;
         
matFile = fileList;
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
    sensorOn = sensor(61:90,6);
    sensorOff = sensor(61:90,9);
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
    lightLoc = [floor(20*pi*5/6) ceil(20*pi*8/6)];
    
%% Cell information   
%     fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{3});
    fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{3},'visible','off');
    
    hText = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1:4,1:2,[0.03 0.1 0.85 0.89],tightInterval),wideInterval));
    text(0,0.9,matFile{iFile}, 'FontSize',fontS, 'Interpreter','none','FontWeight','bold');
    text(0,0.75,['Mean FR (PlfmPRE): ',num2str(meanFR_PlfmPre,2), ' Hz'], 'FontSize',fontS);
    text(0,0.65,['Mean FR (task): ',num2str(meanFR_Task,2), ' Hz'], 'FontSize',fontS);
    text(0,0.55,['Mean FR (PlfmPOST): ',num2str(meanFR_PlfmPost,2), ' Hz'], 'FontSize',fontS);
    text(0,0.45,['Spike width: ',num2str(spkwth,3),' us'], 'FontSize',fontS);
    text(0,0.35,['Half-valley width: ',num2str(hfvwth,3),' us'], 'FontSize',fontS);
    text(0,0.25,['Peak valley ratio: ',num2str(spkpvr,3)], 'FontSize',fontS);
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
    
%% Spike probability
%     hTextSpkProb = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1,2,[0.05 0.10 0.85 0.87],tightInterval),wideInterval));
    hTextSpkProb = axes('Position',axpt(1,3,1,1:2,axpt(nCol,nRow,8:10,1:2,[0.1 0.10 0.85 0.85],tightInterval),wideInterval));
    text(0,0.9,'Spike probability (%)','fontSize',fontM,'fontWeight','bold');
    text(0.1,0.7,['Track light spike Prob. : ',num2str(round(lightProbTrack*10)/10)],'fontSize',fontS);
    set(hTextSpkProb,'Box','off','visible','off');

%% Spatial raster plot
    hSRaster = axes('Position',axpt(1,3,1,1,axpt(nCol,nRow,1:4,1:3,[0.1 0.12 0.80 0.70],tightInterval),wideInterval));
        plot([xptSpatial{1};xptSpatial{2};xptSpatial{3};xptSpatial{4};xptSpatial{5}],[yptSpatial{1};yptSpatial{2};yptSpatial{3};yptSpatial{4};yptSpatial{5}],'lineWidth',lineSpikeM,'Color','k');
        pLight = patch([lightLoc(1) lightLoc(2) lightLoc(2) lightLoc(1)],[61 61 90 90],colorLLightBlue,'LineStyle','none');
        ylabel('Trial','FontSize',fontS);
        title(['Spatial Raster & PETH'],'FontSize',fontM,'FontWeight','bold');
    hSPsth = axes('Position',axpt(1,3,1,2,axpt(nCol,nRow,1:4,1:3,[0.1 0.12 0.80 0.70],tightInterval),wideInterval));
        ylimpethSpatial = ceil(max(pethconvSpatial(pethconvSpatial<inf))*1.1+0.0001);
        pRw(1) = patch([rewardLoc1(1), rewardLoc1(2), rewardLoc1(2), rewardLoc1(1)],[0, 0, ylimpethSpatial, ylimpethSpatial],colorLightRed);
        hold on;
        pRw(2) = patch([rewardLoc2(1), rewardLoc2(2), rewardLoc2(2), rewardLoc2(1)],[0, 0, ylimpethSpatial, ylimpethSpatial],colorLightRed);
        hold on;
        for iType = 1:5
            plot(pethSpatial(1:124),pethconvSpatial(iType,:),'LineStyle','-','LineWidth',lineM,'Color',lineColor{iType})
        end
        peakFR_track = round(max(peakFR1D_track)*10)/10;
        text(115,ylimpethSpatial*0.8,[num2str(peakFR_track),' Hz'],'fontSize',fontS);
        ylabel('Rate (Hz)','FontSize',fontS);
        uistack(pLight,'bottom');
        
    hMap = axes('Position',axpt(1,3,1,3,axpt(nCol,nRow,1:4,1:3,[0.1 0.11 0.80 0.70],tightInterval),wideInterval));
        modi_pethconvSpatial = [pethconvSpatial;nan(1,124)];
        hField = pcolor(modi_pethconvSpatial);
        caxis([min(modi_pethconvSpatial(:)) max(modi_pethconvSpatial(:))]);
        set(hField,'lineStyle','none');
        xlabel('Location (cm)','fontSize',fontS);
        set(hMap,'Box','off','TickDir','out','fontSize',fontS,'XLim',[0,124],'XTick',[0:40:120],'XTickLabel',{0,40,80,'120 (cm)'},'YTick',[1.5:5.5],'YTickLabel',{'BasePRE','PRE','STIM','POST','BasePOST'});

    set(hSRaster,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS,'XLim',[0 124],'XTick',[],'YLim',[0, 150],'YTick',0:30:150);
    set(hSPsth,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS,'XLim',[0, 124],'XTick',[0:10:120],'YLim',[0, ylimpethSpatial],'YTick',[0,ylimpethSpatial]);
    set(pRw,'LineStyle','none','FaceAlpha',0.2);

%% Response check
    testRangeChETA = 8; % ChETA light response test range (ex. 10ms)   
    winBlue = [0, 20];
% Raster
    hTrackLEach(1) = axes('Position',axpt(2,3,1,1,axpt(nCol,nRow,6:10,1:3,[0.11 0.12 0.8 0.7],tightInterval),wideInterval));
        plot(xptTrackLight{1},yptTrackLight{1},'lineWidth',lineSpikeM,'Color','k');
        ylabel('Trials','FontSize',fontS);
        title('Each light onset','FontSize',fontS,'FontWeight','bold');
% Psth
    hTrackLEach(2) = axes('Position',axpt(2,3,1,2,axpt(nCol,nRow,6:10,1:3,[0.11 0.12 0.8 0.7],tightInterval),wideInterval));
        yLimBarBlue = ceil(max(pethTrackLight(:))*1.05+0.0001);
        pLight = patch([0 10 10 0],[0, 0, yLimBarBlue, yLimBarBlue],colorLLightBlue,'LineStyle','none');
        hold on;
        hBar = bar(pethtimeTrackLight, pethTrackLight, 'histc');
        text(sum(winBlue)*0.3,yLimBarBlue*0.9,['latency = ', num2str(latencyTrack1st,3)],'FontSize',fontS,'interpreter','none');
        xlabel('Time (ms)','FontSize',fontS);
        ylabel('Rate (Hz)', 'FontSize',fontS);
    set(hBar, 'FaceColor','k', 'EdgeAlpha',0);
    set(hTrackLEach(1),'XLim',winBlue,'XTick',[],'YLim',[0 nLight], 'YTick', [0 nLight], 'YTickLabel', {0, nLight},'FontSize',fontS);
    set(hTrackLEach(2), 'XLim', winBlue, 'XTick', [winBlue(1) 10 winBlue(2)],'YLim', [0 yLimBarBlue], 'YTick', [0 yLimBarBlue], 'YTickLabel', {[], yLimBarBlue},'FontSize',fontS);
    set(hTrackLEach,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS);
    
    hTrackLabel = axes('Position',axpt(2,3,1:2,3,axpt(nCol,nRow,6:10,1:3,[0.11 0.12 0.8 0.7],tightInterval),wideInterval));
        text(0,0.4,'-: Base-PRE','FontSize',fontM,'color',lineColor{1});
        text(0,0.1,'-: Base-POST','FontSize',fontM,'color',lineColor{5});
        text(0.3,0.4,'-: Novel-PRE','FontSize',fontM,'color',lineColor{2});
        text(0.3,0.1,'-: Novel-STIM','FontSize',fontM,'color',lineColor{3});
        text(0.3,0.-0.2,'-: Novel-POST','FontSize',fontM,'color',lineColor{4});
    set(hTrackLabel,'visible','off');
    
%% Burst onset
    winBlue = [min(pethtime1stBStm) max(pethtime1stBStm)];
% Raster
    hTrackLBurst(1) = axes('Position',axpt(2,3,2,1,axpt(nCol,nRow,6:10,1:3,[0.15 0.12 0.80 0.7],tightInterval),wideInterval));
        plot(xpt1stBStm{1},ypt1stBStm{1},'lineWidth',lineSpikeM,'Color','k');
        ylabel('# of Burst', 'FontSize',fontS);
        title('Each burst onset','FontSize',fontS,'FontWeight','bold');
% Psth
    hTrackLBurst(2) = axes('Position',axpt(2,3,2,2,axpt(nCol,nRow,6:10,1:3,[0.15 0.12 0.80 0.7],tightInterval),wideInterval));
        yLimBarBlue = ceil(max(peth1stBStm(:))*1.05+0.0001);
        for iTrain = 1:nTrain
            pLight = patch([20*(iTrain-1) 20*(iTrain-1)+10 20*(iTrain-1)+10 20*(iTrain-1)],[0, 0, yLimBarBlue, yLimBarBlue],colorLLightBlue,'LineStyle','none');
            hold on;    
        end
        hBar = bar(pethtime1stBStm, peth1stBStm, 'histc');
        xlabel('Time (ms)','FontSize',fontS);
        ylabel('Rate (Hz)','FontSize',fontS);
    set(hBar, 'FaceColor','k', 'EdgeAlpha',0);
    set(hTrackLBurst(1),'XLim',winBlue,'XTick',[],'YLim',[0 nBurst], 'YTick', [0 nBurst]);    
    set(hTrackLBurst(2), 'XLim', winBlue, 'XTick', [winBlue(1),0:20:60, winBlue(2)],'YLim', [0 yLimBarBlue], 'YTick', [0 yLimBarBlue], 'YTickLabel', {[], yLimBarBlue});
    set(hTrackLBurst,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS);
    
%% Light raster (Temporal)
    hTRaster = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,1:4,4:5,[0.1 0.05 0.80 0.70],tightInterval),wideInterval));
        plot([xpt1stLPre{1};xpt1stLStm{1};xpt1stLPost{1}],[ypt1stLPre{1};30+ypt1stLStm{1};60+ypt1stLPost{1}],'lineWidth',lineSpikeM,'Color','k');
        hold on;
        pLight = patch(xpt_lightT,ypt_lightT,colorLLightBlue,'lineStyle','none');
        ylabel('Trial','FontSize',fontS);
        title(['Temporal Raster & PETH aligned on light onset'],'FontSize',fontM,'FontWeight','bold');    
    hTPsth = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,1:4,4:5,[0.1 0.03 0.80 0.70],tightInterval),wideInterval));
        ylimpethTempo = ceil(max([pethConv1stLPre,pethConv1stLStm,pethConv1stLPost])*1.1+0.0001);
        plot(pethtime1stLStm,pethConv1stLPre,'LineStyle','-','LineWidth',lineM,'Color',lineColor{2});
        hold on;
        plot(pethtime1stLStm,pethConv1stLStm,'LineStyle','-','LineWidth',lineM,'Color',lineColor{3});
        hold on;
        plot(pethtime1stLStm,pethConv1stLPost,'LineStyle','-','LineWidth',lineM,'Color',lineColor{4});
        xlabel('Time (ms)','FontSize',fontS);
        ylabel('Rate (Hz)','FontSize',fontS);
    uistack(pLight,'bottom');
    
    set(hTRaster,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS,'XLim',[-1000 4000],'XTick',[],'YLim',[0, 90],'YTick',0:30:90,'YTickLabel',[30:30:120]);
    set(hTPsth,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS,'XLim',[-1000, 4000],'XTick',[-5000:1000:5000],'YLim',[0, ylimpethTempo],'YTick',[0,ylimpethTempo]);
    
%% Zone spike analysis
    yLimTotal = max(sum_totalSpike)*1.2+0.01;
    yLimInzone = max(sum_inzoneSpike)*1.2+0.01;
    yLimOutzone = max(sum_outzoneSpike)*1.2+0.01;
    hSpike(1) = axes('Position',axpt(3,2,1,1,axpt(nCol,nRow,6:10,4:5,[0.12 0.05 0.80 0.70],tightInterval),wideInterval));
        plot([1,2,3,4,5],sum_totalSpike,'-o','color',colorBlack,'MarkerEdgeColor',colorBlack,'MarkerFaceColor',colorGray,'MarkerSize',markerS);
        if p_ttestFr(1,3) < 0.05
            line([2.1,2.9],[yLimTotal yLimTotal]/1.2*1.05,'lineStyle','-','lineWidth',lineM,'color',colorBlack);
            text(2.5,yLimTotal/1.2*1.05,'*','fontSize',fontM,'color',colorRed);
        end
        if p_ttestFr(2,3) < 0.05
            line([2,4],[yLimTotal yLimTotal]/1.2*1.1,'lineStyle','-','lineWidth',lineM,'color',colorBlack);
            text(3,yLimTotal/1.2*1.1,'*','fontSize',fontM,'color',colorRed);
        end
        if p_ttestFr(3,3) < 0.05
            line([3.1,3.9],[yLimTotal yLimTotal]/1.2*1.05,'lineStyle','-','lineWidth',lineM,'color',colorBlack);
            text(3.5,yLimTotal/1.2*1.05,'*','fontSize',fontM,'color',colorRed);
        end
        title('Total spike','fontSize',fontS);
        ylabel('Spike number','fontSize',fontS);
    hSpike(2) = axes('Position',axpt(3,2,2,1,axpt(nCol,nRow,6:10,4:5,[0.12 0.05 0.80 0.70],tightInterval),wideInterval));
        plot([1,2,3,4,5],sum_inzoneSpike,'-o','color',colorBlack,'MarkerEdgeColor',colorBlack,'MarkerFaceColor',colorGray,'MarkerSize',markerS);
        if p_ttestFr(1,1) < 0.05
            line([2.1,2.9],[yLimInzone yLimInzone]/1.2*1.05,'lineStyle','-','lineWidth',lineM,'color',colorBlack);
            text(2.5,yLimInzone/1.2*1.05,'*','fontSize',fontM,'color',colorRed);
        end
        if p_ttestFr(2,1) < 0.05
            line([2,4],[yLimInzone yLimInzone]/1.2*1.1,'lineStyle','-','lineWidth',lineM,'color',colorBlack);
            text(3,yLimInzone/1.2*1.1,'*','fontSize',fontM,'color',colorRed);
        end
        if p_ttestFr(3,1) < 0.05
            line([3.1,3.9],[yLimInzone yLimInzone]/1.2*1.05,'lineStyle','-','lineWidth',lineM,'color',colorBlack);
            text(3.5,yLimInzone/1.2*1.05,'*','fontSize',fontM,'color',colorRed);
        end
        title('In-zone spike','fontSize',fontS);
    hSpike(3) = axes('Position',axpt(3,2,3,1,axpt(nCol,nRow,6:10,4:5,[0.12 0.05 0.80 0.70],tightInterval),wideInterval));
        plot([1,2,3,4,5],sum_outzoneSpike,'-o','color',colorBlack,'MarkerEdgeColor',colorBlack,'MarkerFaceColor',colorGray,'MarkerSize',markerS);
        if p_ttestFr(1,2) < 0.05
            line([2.1,2.9],[yLimOutzone yLimOutzone]/1.2*1.05,'lineStyle','-','lineWidth',lineM,'color',colorBlack);
            text(2.5,yLimOutzone/1.2*1.05,'*','fontSize',fontM,'color',colorRed);
        end
        if p_ttestFr(2,2) < 0.05
            line([2,4],[yLimOutzone yLimOutzone]/1.2*1.1,'lineStyle','-','lineWidth',lineM,'color',colorBlack);
            text(3,yLimOutzone/1.2*1.1,'*','fontSize',fontM,'color',colorRed);
        end
        if p_ttestFr(3,2) < 0.05
            line([3.1,3.9],[yLimOutzone yLimOutzone]/1.2*1.05,'lineStyle','-','lineWidth',lineM,'color',colorBlack);
            text(3.5,yLimOutzone/1.2*1.05,'*','fontSize',fontM,'color',colorRed);
        end
        title('Out-zone spike','fontSize',fontS);
    set(hSpike,'Box','off','TickDir','out','XLim',[0,6],'XTick',1:5,'XTickLabel',{'B"';'B';'ST';'P';'P"'},'fontSize',fontS-1);
    set(hSpike(1),'YLim',[0 yLimTotal]);
    set(hSpike(2),'YLim',[0 yLimInzone]);
    set(hSpike(3),'YLim',[0 yLimOutzone]);

%% spatial information analysis
    yLimInfoSpike = max(infoSpike)*1.2;
    yLimInfoSecond = max(infoSecond)*1.2;
    hInfo(1) = axes('Position',axpt(2,2,1,2,axpt(nCol,nRow,6:10,4:5,[0.10 0.02 0.8 0.70],tightInterval),wideInterval));
        bar([1,2,3,4,5,6],infoSpike,0.6,'faceColor',colorGray,'edgeColor',colorBlack);
        ylabel('bits/spike','fontSize',fontS);
        title('Information per spike','fontSize',fontS);
    hInfo(2) = axes('Position',axpt(2,2,2,2,axpt(nCol,nRow,6:10,4:5,[0.10 0.02 0.8 0.70],tightInterval),wideInterval));
        bar([1,2,3,4,5,6],infoSecond,0.6,'faceColor',colorGray,'edgeColor',colorBlack);
        ylabel('bits/second','fontSize',fontS);
        title('Information per second','fontSize',fontS);
    set(hInfo,'Box','off','TickDir','out','XLim',[0,7],'XTick',1:6,'XTickLabel',{'B"';'B';'ST';'P';'P"';'Av'},'fontSize',fontS-1);
    set(hInfo(1),'YLim',[0, yLimInfoSpike]);
    set(hInfo(2),'YLim',[0, yLimInfoSecond]);
    
%% Place field cross-correlation
    hSCorr = axes('Position',axpt(1,4,1,1:3,axpt(nCol,nRow,1:4,8:9,[0.1 0.10 0.85 0.70],tightInterval),wideInterval));
        plot(rCorrConvMov1D','color',colorBlack,'lineWidth',1)
        hold on;
        pLight = patch([61,90,90,61],[-0.98, -0.98, -0.90, -0.90],colorLightBlue,'LineStyle','none');
        grid on;
        xlabel('Smoothed lap','fontSize',fontS);
        ylabel('r','fontSize',fontS);
        title('Smoothed crossCorr','fontSize',fontM,'fontWeight','bold');
    set(hSCorr,'Box','off','TickDir','out','XLim',[1,150],'XTick',[1,31,61,91,121,150],'YLim',[-1.2,1.2],'YTick',[-1:0.25:1],'fontSize',fontS);

%% Response check: Lap onset
%     winBlue = [min(pethtime1stLStm) max(pethtime1stLStm)];
%     temp_ibi = diff(lightTime);
%     ibi = [0; temp_ibi(temp_ibi>50)];
%     idx_lightLap = [1; (find(diff(lightTime)>1000)+1)];
%     nBurst_lap = [diff(idx_lightLap)/4; (length(lightTime)-idx_lightLap(end)+1)/4];
% % Raster
%     hTrackLLap(1) = axes('Position',axpt(2,8,1,1:2,axpt(nCol,nRow,7:10,2:5,[0.1 0.13 0.82 0.75],tightInterval),wideInterval));
%     plot(xpt1stLStm{1},ypt1stLStm{1},'LineStyle','none','Marker','.','MarkerSize',markerS,'Color','k');
%     set(hTrackLLap(1),'XLim',winBlue,'XTick',[],'YLim',[0 30], 'YTick', [0 30]);
%     ylabel('Trials','FontSize',fontS);
%     title('Track STIM (50hz)','FontSize',fontM,'FontWeight','bold');    
% % Psth
%     hTrackLLap(2) = axes('Position',axpt(2,8,1,3:4,axpt(nCol,nRow,7:10,2:5,[0.1 0.13 0.82 0.75],tightInterval),wideInterval));
%     yLimBarBlue = ceil(max(peth1stLStm(:))*1.05+0.0001);
% %     for iLap = 1:30
% %         for iBurst = 1:nBurst
% %             for iTrain = 1:nTrain
% %                 patch([20*(iTrain-1)+ibi(iBurst) 20*(iTrain-1)+ibi(iBurst)+10 20*(iTrain-1)+ibi(iBurst)+10 20*(iTrain-1)+ibi(iBurst)],[iLap-1, iLap-1, iLap, iLap],colorLLightBlue,'LineStyle','none');
% %                 hold on;
% %             end
% %         end
% %     end
%     hold on;
%     hBar = bar(pethtime1stLStm, peth1stLStm, 'histc');
%     set(hBar, 'FaceColor','k', 'EdgeAlpha',0);
%     set(hTrackLLap(2), 'XLim', winBlue, 'XTick', [winBlue(1),winBlue(2)],'XTickLabel',{winBlue(1);winBlue(2)},'YLim', [0 yLimBarBlue], 'YTick', [0 yLimBarBlue]);
%     ylabel('Rate (Hz)','FontSize',fontS);
%     xlabel('Time (ms)','FontSize',fontS);
% 
%     set(hTrackLLap,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS);
%     align_ylabel(hTrackLLap)

%% LFP analysis (Plfm 2hz)
%     lightPlfm2hz = lightTime.Plfm2hz(201:400);
%     lapPlfm2hzIdx = 1:10:200; % find start light of each lap
%     nLabLightPlfm2hz = 10;
%     lightOnPlfm2hz = lightPlfm2hz(lapPlfm2hzIdx);
%     
%     winPlfm2hz = [-300, 5200]; % unit: msec
%     sFreq = 2000; % 2000 samples / sec
%     win_csc2hz = winPlfm2hz/1000*sFreq;
%     xLimCSC = [-300 1100];
%     xpt_csc2hz = winPlfm2hz(1):0.5:winPlfm2hz(2);
% 
%     for iCycle = 1:20
%         cscIdxPlfm2hz = find(cscTime{1}>lightOnPlfm2hz(iCycle),1,'first');
%         cscPlfm2hz(:,iCycle) = cscSample((cscIdxPlfm2hz+win_csc2hz(1)):cscIdxPlfm2hz+win_csc2hz(2));
%     end
%     m_cscPlfm2hz = mean(cscPlfm2hz,2);
%     yLimCSC_Plfm2hz = [min(m_cscPlfm2hz(find(xpt_csc2hz==xLimCSC(1)):find(xpt_csc2hz==xLimCSC(2)))), max(m_cscPlfm2hz(find(xpt_csc2hz==xLimCSC(1)):find(xpt_csc2hz==xLimCSC(2))))]*1.1;

%% LFP analysis (Track 50hz)
%     lightTrack50hz = lightTime.Track50hz;
%     lapTrack50hzIdx = [1;(find(diff(lightTrack50hz)>1000)+1)]; % find start light of each lap
%     nLabLightTrack50hz = min(diff(lapTrack50hzIdx));
%     lightOnTrack50hz = lightTrack50hz(lapTrack50hzIdx);
%     
%     winTrack50hz = [-500,3000];
%     win_csc50hz = winTrack50hz/1000*sFreq;
%     xpt_csc50hz = winTrack50hz(1):0.5:winTrack50hz(2);
%     for iCycle = 1:30
%         cscIdxTrack50hz = find(cscTime{1}>lightOnTrack50hz(iCycle),1,'first');
%         cscTrack50hz(:,iCycle) = cscSample((cscIdxTrack50hz+win_csc50hz(1)):cscIdxTrack50hz+win_csc50hz(2));
%     end
%     m_cscTrack50hz = mean(cscTrack50hz,2);
%     yLimCSC_Track50hz = [min(m_cscTrack50hz(find(xpt_csc50hz==xLimCSC(1)):find(xpt_csc50hz==xLimCSC(2)))), max(m_cscTrack50hz(find(xpt_csc50hz==xLimCSC(1)):find(xpt_csc50hz==xLimCSC(2))))]*1.1;
%     
%     hLFP(1) = axes('Position',axpt(6,6,1:6,1:2,axpt(nCol,nRow,1:nCol,10:11,[0.10 0.05 0.85 0.85],tightInterval),wideInterval));
%     for iLight = 1:nLabLightPlfm2hz
%         hLpatch(1) = patch([500*(iLight-1), 500*(iLight-1)+10, 500*(iLight-1)+10, 500*(iLight-1)],[yLimCSC_Plfm2hz(1)*0.8, yLimCSC_Plfm2hz(1)*0.8, yLimCSC_Plfm2hz(2), yLimCSC_Plfm2hz(2)],colorBlue,'EdgeColor','none');
%         hold on;
%     end
%     plot(xpt_csc2hz,m_cscPlfm2hz,'color',colorBlack,'lineWidth',1);
%     line([xLimCSC(2)*0.97 xLimCSC(2)*0.97+20],[yLimCSC_Plfm2hz(2)*0.7, yLimCSC_Plfm2hz(2)*0.7],'color',colorBlack);
%     line([xLimCSC(2)*0.97 xLimCSC(2)*0.97],[yLimCSC_Plfm2hz(2)*0.7, yLimCSC_Plfm2hz(2)*0.7+0.2],'color',colorBlack);
%     ylabel('LFP (Plfm2hz)','fontSize',fontM);
%     text(xLimCSC(1), yLimCSC_Plfm2hz(2),'LFP (Plfm 2hz)','fontSize',fontM);
%     text(xLimCSC(2)*0.91,yLimCSC_Plfm2hz(2)*0.7+0.1,'0.2 uVolt','fontSize',fontS);
%     text(xLimCSC(2)*0.97,yLimCSC_Plfm2hz(2)*0.60,'20 ms','fontSize',fontS);
%         
%     hLFP(2) = axes('Position',axpt(6,6,1:6,5:6,axpt(nCol,nRow,1:nCol,10:11,[0.10 0.05 0.85 0.85],tightInterval),wideInterval));
%     for iLight = 1:nLabLightTrack50hz
%         hLpatch(2) = patch([125*(iLight-1), 125*(iLight-1)+10, 125*(iLight-1)+10, 125*(iLight-1)],[yLimCSC_Track50hz(1)*0.8, yLimCSC_Track50hz(1)*0.8, yLimCSC_Track50hz(2), yLimCSC_Track50hz(2)],colorBlue,'EdgeColor','none');
%         hold on;
%     end
%     plot(xpt_csc50hz,m_cscTrack50hz,'color',colorBlack,'lineWidth',1);
%     line([xLimCSC(2)*0.97 xLimCSC(2)*0.97+20],[yLimCSC_Track50hz(2)*0.7, yLimCSC_Track50hz(2)*0.7],'color',colorBlack);
%     line([xLimCSC(2)*0.97 xLimCSC(2)*0.97],[yLimCSC_Track50hz(2)*0.7, yLimCSC_Track50hz(2)*0.7+0.2],'color',colorBlack);
%     ylabel('LFP (Track50hz)','fontSize',fontM);
%     text(xLimCSC(1), yLimCSC_Track50hz(2),'LFP (Track 50hz)','fontSize',fontM);
%     
%     set(hLFP(1),'Xlim',xLimCSC,'XTick',[],'YLim',yLimCSC_Plfm2hz,'fontSize',fontM);
%     set(hLFP(2),'Xlim',xLimCSC,'XTick',[],'YLim',yLimCSC_Track50hz,'fontSize',fontM);

%% LFP analysis (Plfm 50hz)
%     if isfield(lightTime,'Plfm50hz') && ~isempty(lightTime.Plfm50hz) && exist('xptPlfm50hz','var')
%         lightPlfm50hz = lightTime.Plfm50hz;
%         lapPlfm50hzIdx = [1;(find(diff(lightPlfm50hz)>1000)+1)]; % find start light of each lap
%         nLabLightPlfm50hz = min(diff(lapPlfm50hzIdx));
%         lightOnPlfm50hz = lightPlfm50hz(lapPlfm50hzIdx);
% 
%         for iCycle = 1:30
%             cscIdxPlfm50hz = find(cscTime{1}>lightOnPlfm50hz(iCycle),1,'first');
%             cscPlfm50hz(:,iCycle) = cscSample((cscIdxPlfm50hz+win_csc50hz(1)):cscIdxPlfm50hz+win_csc50hz(2));
%         end
%         m_cscPlfm50hz = mean(cscPlfm50hz,2);
%         yLimCSC_Plfm50hz = [min(m_cscPlfm50hz(find(xpt_csc50hz==xLimCSC(1)):find(xpt_csc50hz==xLimCSC(2)))), max(m_cscPlfm50hz(find(xpt_csc50hz==xLimCSC(1)):find(xpt_csc50hz==xLimCSC(2))))]*1.1;
%         xpt_csc50hz = winTrack50hz(1):0.5:winTrack50hz(2);
% 
%         hLFP(3) = axes('Position',axpt(6,6,1:6,3:4,axpt(nCol,nRow,1:nCol,10:11,[0.10 0.05 0.85 0.85],tightInterval),wideInterval));
%         for iLight = 1:nLabLightPlfm50hz
%             hLpatch(3) = patch([125*(iLight-1), 125*(iLight-1)+10, 125*(iLight-1)+10, 125*(iLight-1)],[yLimCSC_Plfm50hz(1)*0.8 yLimCSC_Plfm50hz(1)*0.8 yLimCSC_Plfm50hz(2), yLimCSC_Plfm50hz(2)],colorBlue,'EdgeColor','none');
%             hold on;
%         end
%         plot(xpt_csc50hz,m_cscPlfm50hz,'color',colorBlack,'lineWidth',1);
%         line([xLimCSC(2)*0.97 xLimCSC(2)*0.97+20],[yLimCSC_Plfm50hz(2)*0.7, yLimCSC_Plfm50hz(2)*0.7],'color',colorBlack);
%         line([xLimCSC(2)*0.97 xLimCSC(2)*0.97],[yLimCSC_Plfm50hz(2)*0.7, yLimCSC_Plfm50hz(2)*0.7+0.2],'color',colorBlack);
%         ylabel('LFP (Plfm50hz)','fontSize',fontM);
%         text(xLimCSC(1), yLimCSC_Plfm50hz(2),'LFP (Plfm 50hz)','fontSize',fontM);
%         set(hLFP(3),'Xlim',xLimCSC,'XTick',[],'YLim',yLimCSC_Plfm50hz,'fontSize',fontM);
%     end
%     set(hLFP,'Box','off','TickDir','out');

%% Spectrogram (aligned on sensor onset)
%     load(['CSC','.mat']);
%     hSpectro(1) = axes('Position',axpt(6,6,1:5,1:2,axpt(nCol,nRow,1:3,10:11,[0.1 0.04 0.8 0.80],tightInterval),wideInterval));
%         hSpec(1) = pcolor(timeSensor,freqSensor,psdSensor_pre/(max(psdSensor_stm(:))));
%         text(0.3, 25,'Pre','fontSize',fontM,'Color',[1,1,1])
%         title(['Spectrogram on sensor: ',num2str(iSensor1)],'fontSize',fontL,'FontWeight','bold');
%     hSpectro(2) = axes('Position',axpt(6,6,1:5,3:4,axpt(nCol,nRow,1:3,10:11,[0.1 0.04 0.8 0.80],tightInterval),wideInterval));
%         hSpec(2) = pcolor(timeSensor,freqSensor,psdSensor_stm/(max(psdSensor_stm(:))));
%         text(0.3, 25,'Stm','fontSize',fontM,'Color',[1,1,1])
%         ylabel('Freq (Hz)','fontSize',fontM);
%     hSpectro(3) = axes('Position',axpt(6,6,1:5,5:6,axpt(nCol,nRow,1:3,10:11,[0.1 0.04 0.8 0.80],tightInterval),wideInterval));
%         hSpec(3) = pcolor(timeSensor,freqSensor,psdSensor_post/(max(psdSensor_stm(:))));
%         text(0.3, 25,'Post','fontSize',fontM,'Color',[1,1,1])
%         xlabel('Time (ms)','fontSize',fontM);
%         cBar = colorbar;
%     set(hSpec,'EdgeColor','none');
%     set(hSpectro(1:3),'Box','off','TickDir','out','YLim',[0,30],'YTick',[0:30:90],'XLim',[0.25,1.75],'XTick',1,'XTickLabel',[],'FontSize',fontM);
%     set(hSpectro(3),'Box','off','TickDir','out','YLim',[0,30],'YTick',[0:30:90],'XTick',[0.25,1,1.75],'XTickLabel',{'-750','0','750'},'FontSize',fontM);
%     set(cBar,'Position',axpt(12,6,11,1:2,axpt(nCol,nRow,1:3,10:11,[0.10 0.04 0.80 0.85],tightInterval)));    
% % Spectrogram (aligned on light onset)
%     hSpectroPlfmLight(1) = axes('Position',axpt(6,6,1:5,1:2,axpt(nCol,nRow,4:6,10:11,[0.10 0.04 0.80 0.80],tightInterval),wideInterval));
%         hPlfmLight(1) = pcolor(timeLightPlfm2hz5mw,freqLightPlfm2hz5mw,psdLightPlfm2hz5mw/max(psdLightPlfm2hz8mw(:)));
%         text(0.3,25,'5 mW','fontSize',fontM,'Color',[1,1,1]);
%         title('Spectrogram on Platform','fontSize',fontL,'FontWeight','bold')        
%     hSpectroPlfmLight(2) = axes('Position',axpt(6,6,1:5,3:4,axpt(nCol,nRow,4:6,10:11,[0.10 0.04 0.80 0.80],tightInterval),wideInterval));
%         hPlfmLight(2) = pcolor(timeLightPlfm2hz8mw,freqLightPlfm2hz8mw,psdLightPlfm2hz8mw/max(psdLightPlfm2hz8mw(:)));
%         text(0.3,25,'8 mW','fontSize',fontM,'Color',[1,1,1]);
%     hSpectroPlfmLight(3) = axes('Position',axpt(6,6,1:5,5:6,axpt(nCol,nRow,4:6,10:11,[0.10 0.04 0.80 0.80],tightInterval),wideInterval));
%         hPlfmLight(3) = pcolor(timeLightPlfm2hz10mw,freqLightPlfm2hz10mw,psdLightPlfm2hz10mw/max(psdLightPlfm2hz8mw(:)));
%         text(0.3, 25,'10 mW','fontSize',fontM,'Color',[1,1,1]);
%         xlabel('Time (ms)','fontSize',fontM);
%     set(hPlfmLight,'EdgeColor','none');
%     set(hSpectroPlfmLight(1:3),'Box','off','TickDir','out','YLim',[0,30],'YTick',[],'XLim',[0.25,1.75],'XTick',1,'XTickLabel',[],'FontSize',fontM);
%     set(hSpectroPlfmLight(3),'YTick',[0:30:90],'YTickLabel',[],'XTick',[0.25,1,1.75],'XTickLabel',{'-750','0','750'},'FontSize',fontM);
% 
% % Powerspectrum
%     yLim = [0, max([rPwSensorTheta_pre,rPwSensorTheta_stm,rPwSensorTheta_post,rPwSensorLGamma_pre,rPwSensorLGamma_stm,rPwSensorLGamma_post,rPwSensorHGamma_pre,rPwSensorHGamma_stm,rPwSensorHGamma_post])*1.2];
%     hSpectrum(1) = axes('Position',axpt(8,6,2:3,2:6,axpt(nCol,nRow,7:10,10:11,[0.10 0.05 0.90 0.80],tightInterval),wideInterval));
%         hSpecTheta(1) = bar(1,rPwSensorTheta_pre,width,'FaceColor',colorDarkGray,'EdgeColor','none');
%         hold on;
%         hSpecTheta(2) = bar(2,rPwSensorTheta_stm,width,'FaceColor',colorLightBlue,'EdgeColor','none');
%         hold on;
%         hSpecTheta(3) = bar(3,rPwSensorTheta_post,width,'FaceColor',colorBlack,'EdgeColor','none');
%         text(1,yLim(2)*0.95,'Theta','fontSize',fontM);
%         ylabel('Relative Power','fontSize',fontM);
%     hSpectrum(2) = axes('Position',axpt(8,6,4:5,2:6,axpt(nCol,nRow,7:10,10:11,[0.10 0.05 0.90 0.80],tightInterval),wideInterval));
%         hSpecTheta(1) = bar(1,rPwSensorLGamma_pre,width,'FaceColor',colorDarkGray,'EdgeColor','none');
%         hold on;
%         hSpecTheta(2) = bar(2,rPwSensorLGamma_stm,width,'FaceColor',colorLightBlue,'EdgeColor','none');
%         hold on;
%         hSpecTheta(3) = bar(3,rPwSensorLGamma_post,width,'FaceColor',colorBlack,'EdgeColor','none');
%         text(0.5,yLim(2)*0.95,'L-Gam','fontSize',fontM);
%         title('Relative PowerSpec on the track','fontSize',fontL,'fontWeight','bold')    
%     hSpectrum(3) = axes('Position',axpt(8,6,6:7,2:6,axpt(nCol,nRow,7:10,10:11,[0.10 0.05 0.90 0.80],tightInterval),wideInterval));
%         hSpecTheta(1) = bar(1,rPwSensorHGamma_pre,width,'FaceColor',colorDarkGray,'EdgeColor','none');
%         hold on;
%         hSpecTheta(2) = bar(2,rPwSensorHGamma_stm,width,'FaceColor',colorLightBlue,'EdgeColor','none');
%         hold on;
%         hSpecTheta(3) = bar(3,rPwSensorHGamma_post,width,'FaceColor',colorBlack,'EdgeColor','none');
%         text(0.5,yLim(2)*0.95,'H-Gam','fontSize',fontM);
%         
%     set(hSpectrum,'Box','off','TickDir','out','YLim',yLim,'YTick',[],'XLim',[0,4],'XTick',[1,2,3],'XTickLabel',{'Pr','St','  Po'},'fontSize',fontM,'LineWidth',lineM)
%     set(hSpectrum(1),'Box','off','TickDir','out','YLim',yLim,'YTick',[yLim(1),yLim(2)],'YTickLabel',{'0';sprintf('%.2E',yLim(2))},'XLim',[0,4],'XTick',[1,2,3],'XTickLabel',{'Pr','St','  Po'},'fontSize',fontM)

%% Cell ID
    hID = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,10,1,[0.11 0.18 0.80 0.80],tightInterval),wideInterval));
    text(0.6, 1, ['Cell ID: ',num2str(cellID(iFile))],'FontSize',fontM,'fontWeight','bold');
    set(hID,'visible','off');
    
    cd(saveDir);
    print('-painters','-r300',['cellID_',num2str(cellID(iFile)),'.tif'],'-dtiff');
%     print(-painters','-r300',[cellFigName{1},'.ai'],'-depsc');
    close;
end
fclose('all');
end