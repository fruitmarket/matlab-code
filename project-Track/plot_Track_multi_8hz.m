function plot_Track_multi_v3(fileList, cellID, saveDir)
% function trackPlot_v4_multifig_v3()
% Plot properties
load('D:\Dropbox\SNL\P2_Track\myParameters.mat');
fontM = 7;
paperSize = {[0 0 21.0 29.7]; % A4_portrait
             [0 0 29.7 21.0]; % A4_landscape
             [0 0 15.7 21.0]; % A4_half landscape
             [0 0 21.6 27.9]}; % Letter

abso_reward2Posi = [3/6 4/6]*20*pi;
abso_reward4Posi = [9/6 10/6]*20*pi;

% matFile = mLoad;
matFile = fileList;
nFile = length(matFile);

for iFile = 1:nFile
    [cellDir, cellName, ~] = fileparts(matFile{iFile});
    cellDirSplit = regexp(cellDir,'\','split');
    cellFigName = strcat(cellDirSplit(end-1),'_',cellDirSplit(end),'_',cellName);
    cscTetrode = str2double(cellName(3)); % find a tetrode for csc analysis
    
    cd(cellDir);

    [cscTime, total_cscSample, ~] = cscLoad;
    cscSample = total_cscSample{cscTetrode};

    load(matFile{iFile});
    load('Events.mat');

%% Lap light time
    if(regexp(cellDir,'Run'))
        sensorOn = sensor.S6(31:60);
        sensorOff = sensor.S9(31:60);
    else
        sensorOn = sensor.S10(31:60);
        sensorOff = sensor.S11(31:60);
    end
    temp_lightT = [0; sensorOff-sensorOn];
    xpt_lightT = repmat(temp_lightT',2,1);
    xpt_lightT = xpt_lightT(:);
    xpt_lightT(1) = [];
    xpt_lightT = [xpt_lightT;0];

    ypt_lightT = repmat([30:60],2,1);
    ypt_lightT = ypt_lightT(:);

%%
    nCol = 10;
    nRow = 11;
% Cell information    
    fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{3},'visible','off');
    hText = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1:4,1:2,[0.05 0.1 0.85 0.89],tightInterval),wideInterval));
    hold on;
    text(0,0.9,matFile{iFile}, 'FontSize',fontM, 'Interpreter','none','FontWeight','bold');
    text(0,0.8,['Mean firing rate (baseline): ',num2str(meanFR_base,3), ' Hz'], 'FontSize',fontS);
    text(0,0.7,['Mean firing rate (task): ',num2str(meanFR_task,3), ' Hz'], 'FontSize',fontS);
    text(0,0.6,['Spike width: ',num2str(spkwth,3),' us'], 'FontSize',fontS);
    text(0,0.5,['Half-valley width: ',num2str(hfvwth,3),' us'], 'FontSize',fontS);
    text(0,0.4,['Peak valley ratio: ',num2str(spkpvr,3)], 'FontSize',fontS);
    set(hText,'Visible','off');
    
% Waveform
    yLimWaveform = [min(spkwv(:)), max(spkwv(:))];
    for iCh = 1:4
        hWaveform(iCh) = axes('Position',axpt(4,1,iCh,1,axpt(nCol,nRow,3:5,2,[0.05 0.4 0.85 0.60],tightInterval),wideInterval));
        plot(spkwv(iCh,:), 'LineWidth', lineL, 'Color','k');
        if iCh == 4
            line([24 32], [yLimWaveform(2)-50 yLimWaveform(2)-50], 'Color','k', 'LineWidth', lineM);
            line([24 24],[yLimWaveform(2)-50 yLimWaveform(2)], 'Color','k', 'LineWidth',lineM);
        end
    end
    set(hWaveform, 'Visible', 'off','XLim',[1 32], 'YLim',yLimWaveform*1.05);
    
% Platform light intensity plot
    hIntensity = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,5,1:2,[0.13 0.105 0.85 0.85],tightInterval),wideInterval));
    text(0, 0.9,'Platform laser Pw (%)','fontSize',fontM,'fontWeight','bold');
    text(0.3, 0.7,['5 mW: ',num2str(round(lightProbPlfm5mw*10)/10)],'fontSize',fontS);
    text(0.3, 0.5,['8 mW: ',num2str(round(lightProbPlfm8mw*10)/10)],'fontSize',fontS);
    text(0.3, 0.3,['10 mW: ',num2str(round(lightProbPlfm10mw*10)/10)],'fontSize',fontS);
    set(hIntensity,'Box','off','visible','off');
    
% Cross-correlation
    hCrosscorr = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,5,1:2,[0.13 0.12 0.85 0.85],tightInterval),wideInterval));
    text(0, 0.9,'1D PF crossCorr','fontSize',fontM,'fontWeight','bold');
    text(0.3, 0.7,['PRE x PRE:',num2str(round(rCorr1D_preXpre*100)/100)],'fontSize',fontS);
    text(0.3, 0.5,['PRE x STM:',num2str(round(rCorr1D_preXstm*100)/100)],'fontSize',fontS);
    text(0.3, 0.3,['PRE x POST:',num2str(round(rCorr1D_preXpost*100)/100)],'fontSize',fontS);
    text(0.3, 0.1,['STM x POST:',num2str(round(rCorr1D_stmXpost*100)/100)],'fontSize',fontS);
    set(hCrosscorr,'Box','off','visible','off');
    
% Light response spike probability
    hTextSpkProb = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1,2,[0.05 0.10 0.85 0.87],tightInterval),wideInterval));
    text(0.1,0.9,'Spike probability (%)','fontSize',fontM,'fontWeight','bold');
    text(0.3,0.65,['Plfm 2Hz spike Prob. : ',num2str(round(lightProbPlfm_2hz*10)/10)],'fontSize',fontS);
    if ~isnan(lightProbPlfm_8hz)
        text(0.3,0.45,['Plfm 8Hz spike Prob. : ',num2str(round(lightProbPlfm_8hz*10)/10)],'fontSize',fontS);
    end
    text(0.3,0.25,['Track 8Hz spike Prob. : ',num2str(round(lightProbTrack_8hz*10)/10)],'fontSize',fontS);
    set(hTextSpkProb,'Box','off','visible','off');

% Light response spike probability 
    hStmzoneSpike = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,3,2,[0.1 0.10 0.85 0.87],tightInterval),wideInterval));
    text(0.1,0.9,'In-zone spike # (total)','fontSize',fontM,'fontWeight','bold');
    text(0.3,0.7,['Pre: ',num2str(sum_inzoneSpike(1))],'fontSize',fontS);
    text(0.3,0.5,['Stm: ',num2str(sum_inzoneSpike(2))],'fontSize',fontS);
    text(0.3,0.3,['Post: ',num2str(sum_inzoneSpike(3))],'fontSize',fontS);
    set(hStmzoneSpike,'Box','off','visible','off');

% Smoothing correlation 
    hSCorr = axes('Position',axpt(1,5,1,2:4,axpt(nCol,nRow,8:10,1:2,[0.1 0.10 0.85 0.87],tightInterval),wideInterval));
    plot(rCorrConvMov1D','color',colorBlack,'lineWidth',1)
    hold on;
    patch([21,61,61,21],[0.05,0.05,0.1,0.1],colorLightBlue,'LineStyle','none')
    grid on;
    xlabel('Smoothed lap','fontSize',fontS);
    ylabel('r','fontSize',fontS);
    title('Smoothed crossCorr','fontSize',fontM,'fontWeight','bold');
    set(hSCorr,'Box','off','TickDir','out','XLim',[0,90],'XTick',[0,30,60,90],'YLim',[-1,1],'YTick',[-1:0.5:1],'fontSize',fontS);  

% Response check: Platform
      % Activation or Inactivation?
    if isfield(lightTime,'Plfm2hz') && exist('xptPlfm2hz','var');
        lightDurationColor = {colorLLightBlue, colorLightGray};
        testRangeChETA = 8; % ChETA light response test range (ex. 10ms)       
    end
    if isfield(lightTime,'Plfm2hz') && exist('xptPlfm2hz','var') && ~isempty(xptPlfm2hz)
        nBlue = length(lightTime.Plfm2hz)/3;
        winBlue = [min(pethtimePlfm2hz) max(pethtimePlfm2hz)];
% Raster
        hPlfmBlue(1) = axes('Position',axpt(2,8,1,1:2,axpt(nCol,nRow,1:4,2:5,[0.1 0.13 0.85 0.75],tightInterval),wideInterval));
        plot(xptPlfm2hz{1},yptPlfm2hz{1},'LineStyle','none','Marker','.','MarkerSize',markerS,'Color','k');
        set(hPlfmBlue(1),'XLim',winBlue,'XTick',[],'YLim',[0 nBlue], 'YTick', [0 nBlue], 'YTickLabel', {0, nBlue});
        ylabel('Trials','FontSize',fontS);
        title('Platform light response (2Hz)','FontSize',fontM,'FontWeight','bold');
% Psth
        hPlfmBlue(2) = axes('Position',axpt(2,8,1,3:4,axpt(nCol,nRow,1:4,2:5,[0.1 0.13 0.85 0.75],tightInterval),wideInterval));
        hold on;
        yLimBarBlue = ceil(max(pethPlfm2hz(:))*1.05+0.0001);
        bar(5, 1000, 'BarWidth', 10, 'LineStyle','none', 'FaceColor', colorLLightBlue);
        rectangle('Position', [0 yLimBarBlue*0.925, 10, yLimBarBlue*0.075], 'LineStyle', 'none', 'FaceColor', colorBlue);
        hBarBlue = bar(pethtimePlfm2hz, pethPlfm2hz, 'histc');
        text(sum(winBlue)*0.3,yLimBarBlue*0.9,['latency = ', num2str(latencyPlfm2hz1st,3)],'FontSize',fontS,'interpreter','none');

        set(hBarBlue, 'FaceColor','k', 'EdgeAlpha',0);
        set(hPlfmBlue(2), 'XLim', winBlue, 'XTick', [winBlue(1) 0 winBlue(2)],'XTickLabel',{winBlue(1);0;num2str(winBlue(2))},'YLim', [0 yLimBarBlue], 'YTick', [0 yLimBarBlue], 'YTickLabel', {[], yLimBarBlue});
        xlabel('Time (ms)','FontSize',fontS);
        ylabel('Rate (Hz)', 'FontSize',fontS);
% Hazard function
        hPlfmBlue(3) = axes('Position',axpt(2,8,1,7:8,axpt(nCol,nRow,1:4,2:5,[0.1 0.17 0.85 0.75],tightInterval),wideInterval));
        hold on;
        ylimH = min([ceil(max([H1_Plfm2hz;H2_Plfm2hz])*1100+0.0001)/1000 1]);
        winHTag = [0 testRangeChETA];
        stairs(timeLR_Plfm2hz, H2_Plfm2hz, 'LineStyle',':','LineWidth',lineL,'Color','k');
        stairs(timeLR_Plfm2hz, H1_Plfm2hz,'LineStyle','-','LineWidth',lineL,'Color',colorBlue);
        text(diff(winHTag)*0.1,ylimH*0.9,['p = ',num2str(pLR_Plfm2hz,3)],'FontSize',fontS,'Interpreter','none');
        text(diff(winHTag)*0.1,ylimH*0.7,['calib: ',num2str(calibPlfm2hz,3),' ms'],'FontSize',fontS,'Interpreter','none');
        set(hPlfmBlue(3),'XLim',winHTag,'XTick',winHTag,'YLim',[0 ylimH], 'YTick', [0 ylimH], 'YTickLabel', {[], ylimH});
        xlabel('Time (ms)','FontSize',fontS);
        ylabel('H(t)','FontSize',fontS);
        title('LR test (Platform)','FontSize',fontM,'FontWeight','bold');
        set(hPlfmBlue,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS);
    end
    align_ylabel(hPlfmBlue)

% Response check: Plfm8hz
    if isfield(lightTime,'Plfm8hz') && ~isempty(lightTime.Plfm8hz)
        lightDurationColor = {colorLLightBlue, colorLightGray};
        testRangeChETA = 8; % ChETA light response test range (ex. 10ms)       
    end
    if isfield(lightTime,'Plfm8hz') && ~isempty(lightTime.Plfm8hz)
        nBlue = length(lightTime.Plfm8hz);
        winBlue = [min(pethtimePlfm8hz) max(pethtimePlfm8hz)];
% Raster
        hPlfmBlue(1) = axes('Position',axpt(2,8,2,1:2,axpt(nCol,nRow,1:4,2:5,[0.15 0.13 0.85 0.75],tightInterval),wideInterval));
        plot(xptPlfm8hz{1},yptPlfm8hz{1},'LineStyle','none','Marker','.','MarkerSize',markerS,'Color','k');
        set(hPlfmBlue(1),'XLim',winBlue,'XTick',[],'YLim',[0 nBlue], 'YTick', [0 nBlue], 'YTickLabel', {0, nBlue});
        title('Platform light response (8Hz)','FontSize',fontM,'FontWeight','bold');
% Psth
        hPlfmBlue(2) = axes('Position',axpt(2,8,2,3:4,axpt(nCol,nRow,1:4,2:5,[0.15 0.13 0.85 0.75],tightInterval),wideInterval));
        hold on;
        yLimBarBlue = ceil(max(pethPlfm8hz(:))*1.05+0.0001);
        bar(5, 1000, 'BarWidth', 10, 'LineStyle','none', 'FaceColor', colorLLightBlue);
        rectangle('Position', [0 yLimBarBlue*0.925, 10, yLimBarBlue*0.075], 'LineStyle', 'none', 'FaceColor', colorBlue);
        hBarBlue = bar(pethtimePlfm8hz, pethPlfm8hz, 'histc');
        if statDir_Plfm8hz == 1
            text(sum(winBlue)*0.3,yLimBarBlue*0.9,['latency = ', num2str(latencyPlfm8hz1st,3)],'FontSize',fontS,'interpreter','none');
        else
        end
        set(hBarBlue, 'FaceColor','k', 'EdgeAlpha',0);
        set(hPlfmBlue(2), 'XLim', winBlue, 'XTick', [winBlue(1) 0 winBlue(2)],'XTickLabel',{winBlue(1);0;num2str(winBlue(2))},'YLim', [0 yLimBarBlue], 'YTick', [0 yLimBarBlue], 'YTickLabel', {[], yLimBarBlue});
        xlabel('Time (ms)','FontSize',fontS);
% Hazard function
        hPlfmBlue(3) = axes('Position',axpt(2,8,2,7:8,axpt(nCol,nRow,1:4,2:5,[0.15 0.17 0.85 0.75],tightInterval),wideInterval));
        hold on;
        ylimH = min([ceil(max([H1_Plfm8hz;H2_Plfm8hz])*1100+0.0001)/1000 1]);
        winHTag = [0 testRangeChETA];
        stairs(timeLR_Plfm8hz, H2_Plfm8hz, 'LineStyle',':','LineWidth',lineL,'Color','k');
        stairs(timeLR_Plfm8hz, H1_Plfm8hz,'LineStyle','-','LineWidth',lineL,'Color',colorBlue);
        text(diff(winHTag)*0.1,ylimH*0.9,['p = ',num2str(pLR_Plfm8hz,3)],'FontSize',fontS,'Interpreter','none');
        text(diff(winHTag)*0.1,ylimH*0.7,['calib: ',num2str(calibPlfm8hz,3),' ms'],'FontSize',fontS,'Interpreter','none');
        set(hPlfmBlue(3),'XLim',winHTag,'XTick',winHTag,'YLim',[0 ylimH], 'YTick', [0 ylimH], 'YTickLabel', {[], ylimH});
        xlabel('Time (ms)','FontSize',fontS);
%         ylabel('H(t)','FontSize',fontS);
        title('LR test (platform 8Hz)','FontSize',fontM,'FontWeight','bold');
        set(hPlfmBlue,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS);
    end
    
% Response check: Track
    if isfield(lightTime,'Track8hz') && exist('xptTrackLight','var') && ~isempty(xptTrackLight)
        nBlue = length(lightTime.Track8hz);
%         winBlue = [min(pethtimeTrackLight) max(pethtimeTrackLight)];
        winBlue = [-25 100];
    % Raster
        hTrackBlue(1) = axes('Position',axpt(2,8,1,1:2,axpt(nCol,nRow,7:10,2:5,[0.1 0.13 0.82 0.75],tightInterval),wideInterval));
        plot(xptTrackLight{1},yptTrackLight{1},'LineStyle','none','Marker','.','MarkerSize',markerS,'Color','k');
        set(hTrackBlue(1),'XLim',winBlue,'XTick',[],'YLim',[0 nBlue], 'YTick', [0 nBlue], 'YTickLabel', {0, nBlue});
        ylabel('Trials','FontSize',fontS);
        title('Track light response (8Hz)','FontSize',fontM,'FontWeight','bold');    
    % Psth
        hTrackBlue(2) = axes('Position',axpt(2,8,1,3:4,axpt(nCol,nRow,7:10,2:5,[0.1 0.13 0.82 0.75],tightInterval),wideInterval));
        hold on;
        yLimBarBlue = ceil(max(pethTrackLight(:))*1.05+0.0001);
        if ~isempty(strfind(cellDir,'DRun')) | ~isempty(strfind(cellDir,'DRw'))
            bar(5, 1000, 'BarWidth', 10,'LineStyle', 'none', 'FaceColor', colorLLightBlue);
            rectangle('Position', [0, yLimBarBlue*0.925, 10, yLimBarBlue*0.075], 'LineStyle', 'none', 'FaceColor', colorBlue);
        else
            bar(5, 1000, 'BarWidth', 10,'LineStyle', 'none', 'FaceColor', colorLightGray);
            rectangle('Position', [0, yLimBarBlue*0.925, 10, yLimBarBlue*0.075], 'LineStyle', 'none', 'FaceColor', colorGray);
        end
        hBarBlue = bar(pethtimeTrackLight, pethTrackLight, 'histc');
        if statDir_Track == 1;
            text(sum(winBlue)*0.3,yLimBarBlue*0.9,['latency = ', num2str(latencyTrack1st,3)],'FontSize',fontS,'interpreter','none');
%         text(sum(winBlue)*0.3,yLimBarBlue*0.9,['latency = ', num2str(latencyTrack1st,3)],'FontSize',fontS,'interpreter','none');
        else
        end
        set(hBarBlue, 'FaceColor','k', 'EdgeAlpha',0);
        set(hTrackBlue(2), 'XLim', winBlue, 'XTick', [winBlue(1), 0, winBlue(2)],'XTickLabel',{winBlue(1); 0; num2str(winBlue(2))},...
            'YLim', [0 yLimBarBlue], 'YTick', [0 yLimBarBlue], 'YTickLabel', {[], yLimBarBlue});
        ylabel('Rate (Hz)','FontSize',fontS);
        xlabel('Time (ms)','FontSize',fontS);
    % Hazard function    
        hTrackBlue(3) = axes('Position',axpt(2,8,1,7:8,axpt(nCol,nRow,7:10,2:5,[0.1 0.17 0.82 0.75],tightInterval),wideInterval));
        ylimH = min([ceil(max([H1_Track;H2_Track])*1100+0.0001)/1000 1]);
        winHModu = [0 testRangeChETA];
        stairs(timeLR_Track, H2_Track, 'LineStyle',':','LineWidth',lineL,'Color','k');
        stairs(timeLR_Track, H1_Track,'LineStyle','-','LineWidth',lineL,'Color',colorBlue);
        text(diff(winHModu)*0.1,ylimH*0.9,['p = ',num2str(pLR_Track,3)],'FontSize',fontS,'Interpreter','none');
        text(diff(winHModu)*0.1,ylimH*0.7,['calib: ',num2str(calibTrack,3),' ms'],'FontSize',fontS,'Interpreter','none');
        xlabel('Time (ms)','FontSize',fontS);
        ylabel('H(t)','FontSize',fontS);
        title('LR test (Track)','FontSize',fontM,'FontWeight','bold');
        set(hTrackBlue(3),'XLim',winHModu,'XTick',winHModu,'XTickLabel',{winHModu(1);num2str(winHModu(2))},'YLim',[0 ylimH], 'YTick', [0 ylimH], 'YTickLabel', {[], ylimH});
        set(hTrackBlue,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS);
    end
    align_ylabel(hTrackBlue)

% New respstat
        hTrackrespN = axes('Position',axpt(2,8,2,7:8,axpt(nCol,nRow,7:10,2:5,[0.1 0.17 0.82 0.75],tightInterval),wideInterval));
        hold on;
        ylimH = min([ceil(max([H1_TrackN;H2_TrackN])*1100+0.0001)/1000 1]);
        winHModu = [0 testRangeChETA];
        stairs(timeLR_TrackN, H2_TrackN, 'LineStyle',':','LineWidth',lineL,'Color','k');
        stairs(timeLR_TrackN, H1_TrackN,'LineStyle','-','LineWidth',lineL,'Color',colorBlue);
        text(diff(winHModu)*0.1,ylimH*0.9,['p = ',num2str(pLR_TrackN,3)],'FontSize',fontS,'Interpreter','none');
        text(diff(winHModu)*0.1,ylimH*0.7,['calib: ',num2str(calibTrackN,3),' ms'],'FontSize',fontS,'Interpreter','none');
        xlabel('Time (ms)','FontSize',fontS);
%         ylabel('H(t)','FontSize',fontS);
        title('New LR test (Track)','FontSize',fontM,'FontWeight','bold');
        set(hTrackrespN,'XLim',winHModu,'XTick',winHModu,'XTickLabel',{winHModu(1);num2str(winHModu(2))},'YLim',[0 ylimH], 'YTick', [0 ylimH], 'YTickLabel', {[], ylimH});
        set(hTrackrespN,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS);
        
% detonate spike plot
    hDetoSpk = axes('Position',axpt(4,8,3:4,1:4,axpt(nCol,nRow,7:10, 2:5,[0.16 0.13 0.80 0.75],tightInterval),wideInterval));
    plot(m_deto_spkTrack8hz*100,'-o','color',colorBlack,'MarkerFaceColor',colorBlue,'MarkerSize',markerM);
    xlabel('Light pulse','fontSize',fontS);
    ylabel('Spike probability, P (%)','fontSize',fontS);
    title('Detonate spike (Track 8hz)','fontSize',fontM,'fontWeight','bold');
    set(hDetoSpk,'Box','off','TickDir','out','XLim',[0,length(m_deto_spkTrack8hz)+1],'YLim',[0, max(m_deto_spkTrack8hz*100)*1.1+5],'fontSize',fontS);

% % Light response spike probability
%     hTextSpkProb = axes('Position',axpt(2,8,2,6:7,axpt(nCol,nRow,7:10,2:5,[0.1 0.15 0.80 0.75],tightInterval),wideInterval));
%     text(0.2,0.9,'Spike probability (%)','fontSize',fontM,'fontWeight','bold');
%     text(0.4,0.7,['Plfm 2Hz spike Prob. (%): ',num2str(round(lightProbPlfm_2hz*10)/10)],'fontSize',fontS);
%     if ~isnan(lightProbPlfm_8hz)
%         text(0.4,0.55,['Plfm 8Hz spike Prob. (%): ',num2str(round(lightProbPlfm_8hz*10)/10)],'fontSize',fontS);
%     end
%     text(0.4,0.4,['Track 8Hz spike Prob. (%): ',num2str(round(lightProbTrack_8hz*10)/10)],'fontSize',fontS);
%     set(hTextSpkProb,'Box','off','visible','off');
% 
% % Light response spike probability 
%     hStmzoneSpike = axes('Position',axpt(2,8,2,7:8,axpt(nCol,nRow,7:10,2:5,[0.1 0.15 0.80 0.75],tightInterval),wideInterval));
%     text(0.2,0.7,'Stm zone spike number','fontSize',fontM,'fontWeight','bold');
%     text(0.4,0.5,['Pre: ',num2str(stmzoneSpike(1))],'fontSize',fontS);
%     text(0.4,0.35,['Stm: ',num2str(stmzoneSpike(2))],'fontSize',fontS);
%     text(0.4,0.2,['Post: ',num2str(stmzoneSpike(3))],'fontSize',fontS);
%     set(hStmzoneSpike,'Box','off','visible','off');
    
%% Heat map   
    totalmap = [pre_ratemap(1:90,40:130),stm_ratemap(1:90,40:130),post_ratemap(1:90,40:130)];
    hMap = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1:5,7:8,[0.03 0.22 0.80 0.75]),tightInterval));
    hold on;
    hField = pcolor(totalmap);
    
% Arc property
    if ~isempty(strfind(cellDir,'DRun')) | ~isempty(strfind(cellDir,'noRun'));
        arc = linspace(pi,pi/2*3,170); % s6-s9
    else ~isempty(strfind(cellDir,'DRw')) | ~isempty(strfind(cellDir,'noRw'));
        arc = linspace(pi/6*5, pi/6*4,170);
    end
    if ~isempty(lightTime.Track8hz)
        hold on;
        arc_r = 40;
        x = arc_r*cos(arc)+135;
        y = arc_r*sin(arc)+45;
        if exist('xptTrackLight','var') & (~isempty(strfind(cellDir,'DRw')) | ~isempty(strfind(cellDir,'DRun')));
            plot(x,y,'LineWidth',4,'color',colorBlue);
        else exist('xptTrackLight','var') & (~isempty(strfind(cellDir,'noRw')) | ~isempty(strfind(cellDir,'noRun')));
            plot(x,y,'LineWidth',4,'color',colorGray);                
        end
    else
    end
    set(hField,'linestyle','none');
    set(hMap,'XLim',[0 270],'YLim',[0, 90],'visible','off');
    text(250,85,[num2str(floor(max(peakFR2D_SMtrack*10))/10), ' Hz'],'color','k','FontSize',fontS)
    text(28,3,'Pre-stm','color','k','FontSize',fontS);
    text(125,3,'Stm','color','k','FontSize',fontS)
    text(208,3,'Post-stm','color','k','FontSize',fontS)
    text(95,90,'Track heat map','FontSize',fontM,'FontWeight','bold');
    
     hPlfmMap(1) = axes('Position',axpt(1,4,1,1:2,axpt(nCol,nRow,5,6:7,[0.1 0.15 0.85 0.75],tightInterval),wideInterval));
     hFieldBase = pcolor(base_ratemap(30:70,50:110));
     text(45,38,[num2str(floor(peakFR2D_plfm*10)/10),' Hz'],'fontSize',fontS);
     text(33,10,'baseline','fontSize',fontS);
     
     hPlfmMap(2) = axes('Position',axpt(1,4,1,3:4,axpt(nCol,nRow,5,6:7,[0.1 0.15 0.85 0.75],tightInterval),wideInterval));
     hFieldTwo = pcolor(twohz_ratemap(30:70,50:110));
     text(45,38,[num2str(floor(peakFR2D_two*10)/10),' Hz'],'fontSize',fontS);
     text(34,10,'2hz stm','fontSize',fontS);

     set(hFieldBase,'linestyle','none');
     set(hFieldTwo,'linestyle','none');
     set(hPlfmMap,'Box','off','visible','off','XLim',[0, 75],'YLim',[0,50]);
    
% Track light response raster plot (aligned on pseudo light - light - pseudo light)
    hTrackLight(1) = axes('Position',axpt(1,8,1,5:6,axpt(nCol,nRow,7:10,5:7,[0.10 0.11 0.85 0.85],tightInterval),wideInterval));
        plot([xptPsdPre{1}, xptPsdStm{1}, xptPsdPost{1}],[yptPsdPre{1}, (length(psdlightPre)+yptPsdStm{1}), (sum([length(psdlightPre),length(lightTime.Track8hz)])+yptPsdPost{1})],'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');
        if ~isempty(strfind(cellDir,'DRun')) | ~isempty(strfind(cellDir,'DRw'))
            rec = rectangle('Position',[0.5 length(psdlightPre)+1, 10, length(lightTime.Track8hz)], 'LineStyle','none','FaceColor',lightDurationColor{1});
        end
        if ~isempty(strfind(cellDir,'noRun')) | ~isempty(strfind(cellDir,'noRw'))
            rec = rectangle('Position',[0.5 length(psdlightPre)+1, 10, length(lightTime.Track8hz)], 'LineStyle','none','FaceColor',lightDurationColor{2});
        end
        uistack(rec,'bottom');
        ylabel('Light trial','FontSize',fontS);
        title('Track light response (Psd-L-Psd)','FontSize',fontM,'FontWeight','bold');  
    hTrackLight(2) = axes('Position',axpt(1,8,1,7:8,axpt(nCol,nRow,7:10,5:7,[0.10 0.11 0.85 0.85],tightInterval),wideInterval));
        ylimpeth = ceil(max([pethPsdPreConv,pethPsdStmConv,pethPsdPostConv])*1.1+0.0001);
        hold on;
        plot(pethtimePsdPre,pethPsdPreConv,'LineStyle','-','LineWidth',lineM,'Color',colorGray);
        plot(pethtimePsdStm,pethPsdStmConv,'LineStyle','-','LineWidth',lineM,'Color',colorBlue);
        plot(pethtimePsdPost,pethPsdPostConv,'LineStyle','-','LineWidth',lineM,'Color',colorBlack);
        ylabel('Rate (Hz)','FontSize',fontS);
        xlabel('Time (ms)','FontSize',fontS);
        align_ylabel(hTrackLight);
    set(hTrackLight(1),'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS,'XLim',[0 125],'XTick',[],'YLim',[0, sum([length(psdlightPre),length(lightTime.Track8hz),length(psdlightPost)])],'YTick',[0,length(psdlightPre),sum([length(psdlightPre),length(lightTime.Track8hz)]),sum([length(psdlightPre),length(lightTime.Track8hz),length(psdlightPost)])]);
    set(hTrackLight(2),'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS,'XLim',[0,125],'XTick',[0,10,30,50,100,125],'YLim',[0, max(ylimpeth)]);
    
    if ~isempty(strfind(cellDir,'DRun')) | ~isempty(strfind(cellDir,'noRun'))
        iSensor = 6; % Light on sensor
        lightLoc = [20*pi*5/6 20*pi*8/6];
    end
    if ~isempty(strfind(cellDir,'DRw')) | ~isempty(strfind(cellDir,'noRw'))
        iSensor = 10; % Light on sensor
        lightLoc = [20*pi*9/6 20*pi*10/6];
    end
    rewardLoc1 = [20*pi*3/6 20*pi*4/6];
    rewardLoc2 = [20*pi*9/6 20*pi*10/6];

% Spatial raster plot
    if ~isempty(strfind(cellDir,'DRun')) | ~isempty(strfind(cellDir,'DRw')) % Light session
        hSRaster(1) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,1:4,8:9,[0.10 0.10 0.85 0.75],tightInterval),wideInterval));
        plot([xptSpatial{:}],[yptSpatial{:}],'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');
        pLight = patch([lightLoc(1) lightLoc(2) lightLoc(2) lightLoc(1)],[31 31 60 60], colorLLightBlue,'lineStyle','none');
        ylabel('Trial','FontSize',fontS);
        title('Spatial Raster & PETH','FontSize',fontM,'FontWeight','bold');
        
        hSPsth(1) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,1:4,8:9,[0.10 0.10 0.85 0.75],tightInterval),wideInterval));
        ylimpethSpatial = ceil(max(pethconvSpatial(pethconvSpatial<inf))*1.1+0.0001);
        pRw(1) = patch([rewardLoc1(1), rewardLoc1(2), rewardLoc1(2), rewardLoc1(1)],[0, 0, ylimpethSpatial, ylimpethSpatial],colorLightRed);
        hold on;
        pRw(2) = patch([rewardLoc2(1), rewardLoc2(2), rewardLoc2(2), rewardLoc2(1)],[0, 0, ylimpethSpatial, ylimpethSpatial],colorLightRed);
        hold on;
        for iType = 1:3
            plot(pethSpatial(1:124),pethconvSpatial(iType,:),'LineStyle','-','LineWidth',lineM,'Color',lineColor{iType})
        end
        peakFR_track = round(max(peakFR1D_track)*10)/10;
        text(125,ylimpethSpatial*0.8,[num2str(peakFR_track),' Hz'],'fontSize',fontS);
        ylabel('Rate (Hz)','FontSize',fontS);
        xlabel('Position (cm)','FontSize',fontS);
        uistack(pLight,'bottom');
% Temporal raster plot
        hTRaster(1) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,7:10,8:9,[0.10 0.10 0.85 0.75],tightInterval),wideInterval));
        plot([xpt1stLPre{1},xpt1stLStm{1},xpt1stLPost{1}],[ypt1stLPre{1},30+ypt1stLStm{1},60+ypt1stLPost{1}],'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');
        pLight = patch(xpt_lightT,ypt_lightT,colorLLightBlue);
        ylabel('Trial','FontSize',fontS);
        title(['Temporal Raster & PETH at ',fields{iSensor}],'FontSize',fontM,'FontWeight','bold');
        hTPsth(1) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,7:10,8:9,[0.10 0.10 0.85 0.75],tightInterval),wideInterval));
        ylimpethTempo = ceil(max([pethConv1stLPre,pethConv1stLStm,pethConv1stLPost])*1.1+0.0001);
        plot(pethtime1stLStm,pethConv1stLPre,'LineStyle','-','LineWidth',lineM,'Color',lineColor{1});
        hold on;
        plot(pethtime1stLStm,pethConv1stLStm,'LineStyle','-','LineWidth',lineM,'Color',lineColor{2});
        hold on;
        plot(pethtime1stLStm,pethConv1stLPost,'LineStyle','-','LineWidth',lineM,'Color',lineColor{3});

        ylabel('Rate (Hz)','FontSize',fontS);
        xlabel('Time (ms)','FontSize',fontS);
        uistack(pLight,'bottom');
    end

    if ~isempty(strfind(cellDir,'noRun')) | ~isempty(strfind(cellDir,'noRw')) % No light session
% Spatial rastser plot
        hSRaster(1) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,1:4,8:9,[0.1 0.10 0.85 0.75],tightInterval),wideInterval));
        hold on;
        plot([xptSpatial{:}],[yptSpatial{:}],'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');
        pLight = patch([lightLoc(1) lightLoc(2) lightLoc(2) lightLoc(1)],[31 31 60 60], colorLightGray,'lineStyle','none');
        ylabel('Trial','FontSize',fontS);
        title('Spatial Raster & PETH','FontSize',fontM,'FontWeight','bold');
        hSPsth(1) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,1:4,8:9,[0.10 0.10 0.85 0.75],tightInterval),wideInterval));
        ylimpethSpatial = ceil(max(pethconvSpatial(pethconvSpatial<inf))*1.1+0.0001);
        pRw(1) = patch([rewardLoc1(1), rewardLoc1(2), rewardLoc1(2), rewardLoc1(1)],[0, 0, ylimpethSpatial, ylimpethSpatial],colorLightRed);
        hold on;
        pRw(2) = patch([rewardLoc2(1), rewardLoc2(2), rewardLoc2(2), rewardLoc2(1)],[0, 0, ylimpethSpatial, ylimpethSpatial],colorLightRed);
        hold on;
        for iType = 1:3
            plot(pethSpatial(1:124),pethconvSpatial(iType,:),'LineStyle','-','LineWidth',lineM,'Color',lineColor{iType})
        end
        peakFR_track = round(max(peakFR1D_track)*10)/10;
        text(125,ylimpethSpatial*0.8,[num2str(peakFR_track),' Hz'],'fontSize',fontS);
        ylabel('Rate (Hz)','FontSize',fontS);
        xlabel('Position (cm)','FontSize',fontS);
        uistack(pLight,'bottom');  
% Temporal raster plot
        hTRaster(1) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,7:10,8:9,[0.1 0.10 0.85 0.75],tightInterval),wideInterval));
        plot([xpt1stLPre{1},xpt1stLStm{1},xpt1stLPost{1}],[ypt1stLPre{1},30+ypt1stLStm{1},60+ypt1stLPost{1}],'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');
        pLight = patch(xpt_lightT,ypt_lightT,colorLLightBlue);
        ylabel('Trial','FontSize',fontS);
        title(['Temporal Raster & PETH aligned on light onset'],'FontSize',fontM,'FontWeight','bold');
        hTPsth(1) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,7:10,8:9,[0.10 0.10 0.85 0.75],tightInterval),wideInterval));
        ylimpethTempo = ceil(max([pethConv1stLPre,pethConv1stLStm,pethConv1stLPost])*1.1+0.0001);
        plot(pethtime1stLStm,pethConv1stLPre,'LineStyle','-','LineWidth',lineM,'Color',lineColor{1});
        hold on;
        plot(pethtime1stLStm,pethConv1stLStm,'LineStyle','-','LineWidth',lineM,'Color',lineColor{2});
        hold on;
        plot(pethtime1stLStm,pethConv1stLPost,'LineStyle','-','LineWidth',lineM,'Color',lineColor{3});
%         plot([xpt.(fields{iSensor1}){:}],[ypt.(fields{iSensor1}){:}],'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');
%         rec = rectangle('Position',[0 31 lightDur 30], 'LineStyle','none','FaceColor',lightDurationColor{2});
%         ylabel('Trial','FontSize',fontS);
%         title(['Temporal Raster & PETH at ',fields{iSensor1}],'FontSize',fontS,'FontWeight','bold');
%         hTPsth(1) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,7:10,8:9,[0.1 0.10 0.85 0.75],tightInterval),wideInterval));
%         ylimpeth1 = ceil(max(pethconv.(fields{iSensor1})(:))*1.1+0.0001);
%         hold on;
%         for iType = 1:3
%             plot(pethtime.(fields{iSensor1}),pethconv.(fields{iSensor1})(iType,:),'LineStyle','-','LineWidth',lineM,'Color',lineColor{iType})
%         end
        ylabel('Rate (Hz)','FontSize',fontS);
        xlabel('Time (ms)','FontSize',fontS);
        uistack(pLight,'bottom');
    end
    align_ylabel([hSRaster,hSPsth]);
    align_ylabel([hTRaster,hTPsth]);
    set(hSRaster,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS,'XLim',[0 124],'XTick',[],'YLim',[0, 90],'YTick',0:30:90);
    set(hTRaster,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS,'XLim',[-1000 5000],'XTick',[],'YLim',[0, 90],'YTick',0:30:90);
    set(hSPsth,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS,'XLim',[0, 124],'XTick',[0:10:120],'YLim',[0, ylimpethSpatial],'YTick',[0,ylimpethSpatial]);
    set(hTPsth,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS,'XLim',[-1000, 5000],'XTick',[-5000:1000:5000],'YLim',[0, ylimpethTempo],'YTick',[0,ylimpethTempo]);
    set(pRw,'LineStyle','none','FaceAlpha',0.2);
    set(pLight,'LineStyle','none');
    
    hLine = axes('Position',axpt(1,2,1,1:2,axpt(nCol,nRow,5:6,8,[0.1 0.10 0.85 0.75],tightInterval),wideInterval));
        text(0.2,1.00,'-: Pre','FontSize',fontM,'Color',colorGray,'fontWeight','Bold');    
        text(0.2,0.75,'-: Stm','FontSize',fontM,'Color',colorBlue,'fontWeight','Bold');
        text(0.2,0.50,'-: Post','FontSize',fontM,'Color',colorBlack,'fontWeight','Bold');
        text(0.1,0.25,' : Reward','FontSize',fontM,'Color',colorLightRed,'fontWeight','Bold');
    set(hLine,'Box','off','visible','off');

% Zone spike analysis
    yLimTotal = max([sum_totalSpike(1), sum_totalSpike(2), sum_totalSpike(3)])*1.2+0.01;
    yLimInzone = max([sum_inzoneSpike(1), sum_inzoneSpike(2), sum_inzoneSpike(3)])*1.2+0.01;
    yLimOutzone = max([sum_outzoneSpike(1), sum_outzoneSpike(2), sum_outzoneSpike(3)])*1.2+0.01;
    hSpike(1) = axes('Position',axpt(6,2,1:2,1,axpt(nCol,nRow,1:5,10:11,[0.10 0.08 0.85 0.85],midInterval),midInterval));
        plot([1,2,3],[sum_totalSpike(1), sum_totalSpike(2), sum_totalSpike(3)],'-o','color',colorBlack,'MarkerEdgeColor',colorBlack,'MarkerFaceColor',colorGray,'MarkerSize',markerM);
        if p_ttest(1,3) < 0.05
            line([1.1,1.9],[yLimTotal yLimTotal]/1.2*1.05,'lineStyle','-','lineWidth',lineM,'color',colorBlack);
            text(1.4,yLimTotal/1.2*1.05,'*','fontSize',fontM,'color',colorRed);
        end
        if p_ttest(2,3) < 0.05
            line([1,3],[yLimTotal yLimTotal]/1.2*1.1,'lineStyle','-','lineWidth',lineM,'color',colorBlack);
            text(1.9,yLimTotal/1.2*1.1,'*','fontSize',fontM,'color',colorRed);
        end
        if p_ttest(3,3) < 0.05
            line([2.1,2.9],[yLimTotal yLimTotal]/1.2*1.05,'lineStyle','-','lineWidth',lineM,'color',colorBlack);
            text(2.4,yLimTotal/1.2*1.05,'*','fontSize',fontM,'color',colorRed);
        end
        title('Total spike','fontSize',fontS);
        ylabel('Spike number','fontSize',fontS);
    hSpike(2) = axes('Position',axpt(6,2,3:4,1,axpt(nCol,nRow,1:5,10:11,[0.10 0.08 0.85 0.85],midInterval),midInterval));
        plot([1,2,3],[sum_inzoneSpike(1), sum_inzoneSpike(2), sum_inzoneSpike(3)],'-o','color',colorBlack,'MarkerEdgeColor',colorBlack,'MarkerFaceColor',colorGray,'MarkerSize',markerM);
        if p_ttest(1,1) < 0.05
            line([1.1,1.9],[yLimInzone yLimInzone]/1.2*1.05,'lineStyle','-','lineWidth',lineM,'color',colorBlack);
            text(1.4,yLimInzone/1.2*1.05,'*','fontSize',fontM,'color',colorRed);
        end
        if p_ttest(2,1) < 0.05
            line([1,3],[yLimInzone yLimInzone]/1.2*1.1,'lineStyle','-','lineWidth',lineM,'color',colorBlack);
            text(1.9,yLimInzone/1.2*1.1,'*','fontSize',fontM,'color',colorRed);
        end
        if p_ttest(3,1) < 0.05
            line([2.1,2.9],[yLimInzone yLimInzone]/1.2*1.05,'lineStyle','-','lineWidth',lineM,'color',colorBlack);
            text(2.4,yLimInzone/1.2*1.05,'*','fontSize',fontM,'color',colorRed);
        end
        title('In-zone spike','fontSize',fontS);
    hSpike(3) = axes('Position',axpt(6,2,5:6,1,axpt(nCol,nRow,1:5,10:11,[0.10 0.08 0.85 0.85],midInterval),midInterval));
        plot([1,2,3],[sum_outzoneSpike(1), sum_outzoneSpike(2), sum_outzoneSpike(3)],'-o','color',colorBlack,'MarkerEdgeColor',colorBlack,'MarkerFaceColor',colorGray,'MarkerSize',markerM);
        if p_ttest(1,2) < 0.05
            line([1.1,1.9],[yLimOutzone yLimOutzone]/1.2*1.05,'lineStyle','-','lineWidth',lineM,'color',colorBlack);
            text(1.4,yLimOutzone/1.2*1.05,'*','fontSize',fontM,'color',colorRed);
        end
        if p_ttest(2,2) < 0.05
            line([1,3],[yLimOutzone yLimOutzone]/1.2*1.1,'lineStyle','-','lineWidth',lineM,'color',colorBlack);
            text(1.9,yLimOutzone/1.2*1.1,'*','fontSize',fontM,'color',colorRed);
        end
        if p_ttest(3,2) < 0.05
            line([2.1,2.9],[yLimOutzone yLimOutzone]/1.2*1.05,'lineStyle','-','lineWidth',lineM,'color',colorBlack);
            text(2.4,yLimOutzone/1.2*1.05,'*','fontSize',fontM,'color',colorRed);
        end
        title('Out-zone spike','fontSize',fontS);
    set(hSpike,'Box','off','TickDir','out','XLim',[0,4],'XTick',1:3,'XTickLabel',{'PRE';'STM';'POST'},'fontSize',fontS);
    set(hSpike(1),'YLim',[0 yLimTotal]);
    set(hSpike(2),'YLim',[0 yLimInzone]);
    set(hSpike(3),'YLim',[0 yLimOutzone]);

% spatial information analysis
if ~isnan(infoSpikeTotal)
    yLimInfoSpike = max([infoSpikePRE, infoSpikeSTM, infoSpikePOST, infoSpikeTotal])*1.2;
    yLimInfoSecond = max([infoSecondPRE, infoSecondSTM, infoSecondPOST, infoSecondTotal])*1.2;
    hInfo(1) = axes('Position',axpt(6,2,1:3,2,axpt(nCol,nRow,1:5,10:11,[0.10 0.05 0.85 0.85],midInterval),wideInterval));
    bar([1,2,3,4],[infoSpikePRE, infoSpikeSTM, infoSpikePOST, infoSpikeTotal],0.6,'faceColor',colorGray,'edgeColor',colorBlack);
    ylabel('bits/spike','fontSize',fontS);
    title('Information per spike','fontSize',fontS);
    hInfo(2) = axes('Position',axpt(6,2,4:6,2,axpt(nCol,nRow,1:5,10:11,[0.10 0.05 0.85 0.85],midInterval),wideInterval));
    bar([1,2,3,4],[infoSecondPRE, infoSecondSTM, infoSecondPOST, infoSecondTotal],0.6,'faceColor',colorGray,'edgeColor',colorBlack);
    ylabel('bits/second','fontSize',fontS);
    title('Information per second','fontSize',fontS);
    
    set(hInfo,'Box','off','TickDir','out','XLim',[0,5],'XTick',1:4,'XTickLabel',{'PRE';'STM';'POST';'Total'},'fontSize',fontS);
    set(hInfo(1),'YLim',[0, yLimInfoSpike]);
    set(hInfo(2),'YLim',[0, yLimInfoSecond]);
end

% LFP analysis (Plfm 2hz)
    lightPlfm2hz = lightTime.Plfm2hz(201:400);
    lapPlfm2hzIdx = 1:10:200; % find start light of each lap
    nLabLightPlfm2hz = 10;
    lightOnPlfm2hz = lightPlfm2hz(lapPlfm2hzIdx);
    
    winPlfm2hz = [-300, 5200]; % unit: msec
    sFreq = 2000; % 2000 samples / sec
    win_csc2hz = winPlfm2hz/1000*sFreq;
    xLimCSC = [-300 1100];
    xpt_csc2hz = winPlfm2hz(1):0.5:winPlfm2hz(2);

    for iCycle = 1:20
        cscIdxPlfm2hz = find(cscTime{1}>lightOnPlfm2hz(iCycle),1,'first');
        cscPlfm2hz(:,iCycle) = cscSample((cscIdxPlfm2hz+win_csc2hz(1)):cscIdxPlfm2hz+win_csc2hz(2));
    end
    m_cscPlfm2hz = mean(cscPlfm2hz,2);
    yLimCSC_Plfm2hz = [min(m_cscPlfm2hz(find(xpt_csc2hz==xLimCSC(1)):find(xpt_csc2hz==xLimCSC(2)))), max(m_cscPlfm2hz(find(xpt_csc2hz==xLimCSC(1)):find(xpt_csc2hz==xLimCSC(2))))]*1.1;

% LFP analysis (Track 8hz)
    lightTrack8hz = lightTime.Track8hz;
    lapTrack8hzIdx = [1;(find(diff(lightTrack8hz)>1000)+1)]; % find start light of each lap
    nLabLightTrack8hz = min(diff(lapTrack8hzIdx));
    lightOnTrack8hz = lightTrack8hz(lapTrack8hzIdx);
    
    winTrack8hz = [-500,3000];
    win_csc8hz = winTrack8hz/1000*sFreq;
    xpt_csc8hz = winTrack8hz(1):0.5:winTrack8hz(2);
    for iCycle = 1:30
        cscIdxTrack8hz = find(cscTime{1}>lightOnTrack8hz(iCycle),1,'first');
        cscTrack8hz(:,iCycle) = cscSample((cscIdxTrack8hz+win_csc8hz(1)):cscIdxTrack8hz+win_csc8hz(2));
    end
    m_cscTrack8hz = mean(cscTrack8hz,2);
    yLimCSC_Track8hz = [min(m_cscTrack8hz(find(xpt_csc8hz==xLimCSC(1)):find(xpt_csc8hz==xLimCSC(2)))), max(m_cscTrack8hz(find(xpt_csc8hz==xLimCSC(1)):find(xpt_csc8hz==xLimCSC(2))))]*1.1;
    
    hLFP(1) = axes('Position',axpt(6,6,1:6,1:2,axpt(nCol,nRow,6:nCol,10:11,[0.10 0.05 0.85 0.85],tightInterval),wideInterval));
    for iLight = 1:nLabLightPlfm2hz
        hLpatch(1) = patch([500*(iLight-1), 500*(iLight-1)+10, 500*(iLight-1)+10, 500*(iLight-1)],[yLimCSC_Plfm2hz(1)*0.8, yLimCSC_Plfm2hz(1)*0.8, yLimCSC_Plfm2hz(2), yLimCSC_Plfm2hz(2)],colorLightBlue,'EdgeColor','none');
        hold on;
    end
    plot(xpt_csc2hz,m_cscPlfm2hz,'color',colorBlack,'lineWidth',0.8);
    line([xLimCSC(2)*0.97 xLimCSC(2)*0.97+20],[yLimCSC_Plfm2hz(2)*0.7, yLimCSC_Plfm2hz(2)*0.7],'color',colorBlack);
    line([xLimCSC(2)*0.97 xLimCSC(2)*0.97],[yLimCSC_Plfm2hz(2)*0.7, yLimCSC_Plfm2hz(2)*0.7+0.2],'color',colorBlack);
    ylabel('LFP (Plfm2hz)','fontSize',fontS);
    text(xLimCSC(1), yLimCSC_Plfm2hz(2),'LFP (Plfm 2hz)','fontSize',fontS);
    text(xLimCSC(2)*0.91,yLimCSC_Plfm2hz(2)*0.7+0.1,'0.2 mVolt','fontSize',fontS);
    text(xLimCSC(2)*0.97,yLimCSC_Plfm2hz(2)*0.60,'20 ms','fontSize',fontS);
        
    hLFP(2) = axes('Position',axpt(6,6,1:6,5:6,axpt(nCol,nRow,6:nCol,10:11,[0.10 0.05 0.85 0.85],tightInterval),wideInterval));
    for iLight = 1:nLabLightTrack8hz
        hLpatch(2) = patch([125*(iLight-1), 125*(iLight-1)+10, 125*(iLight-1)+10, 125*(iLight-1)],[yLimCSC_Track8hz(1)*0.8, yLimCSC_Track8hz(1)*0.8, yLimCSC_Track8hz(2), yLimCSC_Track8hz(2)],colorLightBlue,'EdgeColor','none');
        hold on;
    end
    plot(xpt_csc8hz,m_cscTrack8hz,'color',colorBlack,'lineWidth',0.8);
    line([xLimCSC(2)*0.97 xLimCSC(2)*0.97+20],[yLimCSC_Track8hz(2)*0.7, yLimCSC_Track8hz(2)*0.7],'color',colorBlack);
    line([xLimCSC(2)*0.97 xLimCSC(2)*0.97],[yLimCSC_Track8hz(2)*0.7, yLimCSC_Track8hz(2)*0.7+0.2],'color',colorBlack);
    ylabel('LFP (Track8hz)','fontSize',fontS);
    text(xLimCSC(1), yLimCSC_Track8hz(2),'LFP (Track 8hz)','fontSize',fontS);
    
    set(hLFP(1),'Xlim',xLimCSC,'XTick',[],'YLim',yLimCSC_Plfm2hz,'fontSize',fontS);
    set(hLFP(2),'Xlim',xLimCSC,'XTick',[],'YLim',yLimCSC_Track8hz,'fontSize',fontS);

% LFP analysis (Plfm 8hz)
    if isfield(lightTime,'Plfm8hz') && ~isempty(lightTime.Plfm8hz) && exist('xptPlfm8hz','var')
        lightPlfm8hz = lightTime.Plfm8hz;
        lapPlfm8hzIdx = [1;(find(diff(lightPlfm8hz)>1000)+1)]; % find start light of each lap
        nLabLightPlfm8hz = min(diff(lapPlfm8hzIdx));
        lightOnPlfm8hz = lightPlfm8hz(lapPlfm8hzIdx);

        for iCycle = 1:30
            cscIdxPlfm8hz = find(cscTime{1}>lightOnPlfm8hz(iCycle),1,'first');
            cscPlfm8hz(:,iCycle) = cscSample((cscIdxPlfm8hz+win_csc8hz(1)):cscIdxPlfm8hz+win_csc8hz(2));
        end
        m_cscPlfm8hz = mean(cscPlfm8hz,2);
        yLimCSC_Plfm8hz = [min(m_cscPlfm8hz(find(xpt_csc8hz==xLimCSC(1)):find(xpt_csc8hz==xLimCSC(2)))), max(m_cscPlfm8hz(find(xpt_csc8hz==xLimCSC(1)):find(xpt_csc8hz==xLimCSC(2))))]*1.1;
        xpt_csc8hz = winTrack8hz(1):0.5:winTrack8hz(2);

        hLFP(3) = axes('Position',axpt(6,6,1:6,3:4,axpt(nCol,nRow,6:nCol,10:11,[0.10 0.05 0.85 0.85],tightInterval),wideInterval));
        for iLight = 1:nLabLightPlfm8hz
            hLpatch(3) = patch([125*(iLight-1), 125*(iLight-1)+10, 125*(iLight-1)+10, 125*(iLight-1)],[yLimCSC_Plfm8hz(1)*0.8 yLimCSC_Plfm8hz(1)*0.8 yLimCSC_Plfm8hz(2), yLimCSC_Plfm8hz(2)],colorLightBlue,'EdgeColor','none');
            hold on;
        end
        plot(xpt_csc8hz,m_cscPlfm8hz,'color',colorBlack,'lineWidth',0.8);
        line([xLimCSC(2)*0.97 xLimCSC(2)*0.97+20],[yLimCSC_Plfm8hz(2)*0.7, yLimCSC_Plfm8hz(2)*0.7],'color',colorBlack);
        line([xLimCSC(2)*0.97 xLimCSC(2)*0.97],[yLimCSC_Plfm8hz(2)*0.7, yLimCSC_Plfm8hz(2)*0.7+0.2],'color',colorBlack);
        ylabel('LFP (Plfm8hz)','fontSize',fontS);
        text(xLimCSC(1), yLimCSC_Plfm8hz(2),'LFP (Plfm 8hz)','fontSize',fontS);
        set(hLFP(3),'Xlim',xLimCSC,'XTick',[],'YLim',yLimCSC_Plfm8hz,'fontSize',fontS);
    end
    set(hLFP,'Box','off','TickDir','out','visible','off');
    
% % Spectrogram (aligned on sensor onset)
%     load(['CSC','.mat']);
%     hSpectro(1) = axes('Position',axpt(6,6,1:5,1:2,axpt(nCol,nRow,1:3,10:11,[0.1 0.04 0.8 0.80],tightInterval),wideInterval));
%         hSpec(1) = pcolor(timeSensor,freqSensor,psdSensor_pre/(max(psdSensor_stm(:))));
%         text(0.3, 25,'Pre','fontSize',fontS,'Color',[1,1,1])
%         title(['Spectrogram on sensor: ',num2str(iSensor1)],'fontSize',fontM,'FontWeight','bold');
%     hSpectro(2) = axes('Position',axpt(6,6,1:5,3:4,axpt(nCol,nRow,1:3,10:11,[0.1 0.04 0.8 0.80],tightInterval),wideInterval));
%         hSpec(2) = pcolor(timeSensor,freqSensor,psdSensor_stm/(max(psdSensor_stm(:))));
%         text(0.3, 25,'Stm','fontSize',fontS,'Color',[1,1,1])
%         ylabel('Freq (Hz)','fontSize',fontS);
%     hSpectro(3) = axes('Position',axpt(6,6,1:5,5:6,axpt(nCol,nRow,1:3,10:11,[0.1 0.04 0.8 0.80],tightInterval),wideInterval));
%         hSpec(3) = pcolor(timeSensor,freqSensor,psdSensor_post/(max(psdSensor_stm(:))));
%         text(0.3, 25,'Post','fontSize',fontS,'Color',[1,1,1])
%         xlabel('Time (ms)','fontSize',fontS);
%         cBar = colorbar;
%     set(hSpec,'EdgeColor','none');
%     set(hSpectro(1:3),'Box','off','TickDir','out','YLim',[0,30],'YTick',[0:30:90],'XLim',[0.25,1.75],'XTick',1,'XTickLabel',[],'FontSize',fontS);
%     set(hSpectro(3),'Box','off','TickDir','out','YLim',[0,30],'YTick',[0:30:90],'XTick',[0.25,1,1.75],'XTickLabel',{'-750','0','750'},'FontSize',fontS);
%     set(cBar,'Position',axpt(12,6,11,1:2,axpt(nCol,nRow,1:3,10:11,[0.10 0.04 0.80 0.85],tightInterval)));
% % Spectrogram (aligned on light onset)
%     hSpectroPlfmLight(1) = axes('Position',axpt(6,6,1:5,1:2,axpt(nCol,nRow,4:6,10:11,[0.10 0.04 0.80 0.80],tightInterval),wideInterval));
%         hPlfmLight(1) = pcolor(timeLightPlfm2hz5mw,freqLightPlfm2hz5mw,psdLightPlfm2hz5mw/max(psdLightPlfm2hz8mw(:)));
%         text(0.3,25,'5 mW','fontSize',fontS,'Color',[1,1,1]);
%         title('Spectrogram on Platform','fontSize',fontM,'FontWeight','bold')        
%     hSpectroPlfmLight(2) = axes('Position',axpt(6,6,1:5,3:4,axpt(nCol,nRow,4:6,10:11,[0.10 0.04 0.80 0.80],tightInterval),wideInterval));
%         hPlfmLight(2) = pcolor(timeLightPlfm2hz8mw,freqLightPlfm2hz8mw,psdLightPlfm2hz8mw/max(psdLightPlfm2hz8mw(:)));
%         text(0.3,25,'8 mW','fontSize',fontS,'Color',[1,1,1]);
%     hSpectroPlfmLight(3) = axes('Position',axpt(6,6,1:5,5:6,axpt(nCol,nRow,4:6,10:11,[0.10 0.04 0.80 0.80],tightInterval),wideInterval));
%         hPlfmLight(3) = pcolor(timeLightPlfm2hz10mw,freqLightPlfm2hz10mw,psdLightPlfm2hz10mw/max(psdLightPlfm2hz8mw(:)));
%         text(0.3, 25,'10 mW','fontSize',fontS,'Color',[1,1,1]);
%         xlabel('Time (ms)','fontSize',fontS);
%     set(hPlfmLight,'EdgeColor','none');
%     set(hSpectroPlfmLight(1:3),'Box','off','TickDir','out','YLim',[0,30],'YTick',[],'XLim',[0.25,1.75],'XTick',1,'XTickLabel',[],'FontSize',fontS);
%     set(hSpectroPlfmLight(3),'YTick',[0:30:90],'YTickLabel',[],'XTick',[0.25,1,1.75],'XTickLabel',{'-750','0','750'},'FontSize',fontS);
% 
% % Powerspectrum
%     yLim = [0, max([rPwSensorTheta_pre,rPwSensorTheta_stm,rPwSensorTheta_post,rPwSensorLGamma_pre,rPwSensorLGamma_stm,rPwSensorLGamma_post,rPwSensorHGamma_pre,rPwSensorHGamma_stm,rPwSensorHGamma_post])*1.2];
%     hSpectrum(1) = axes('Position',axpt(8,6,2:3,2:6,axpt(nCol,nRow,7:10,10:11,[0.10 0.05 0.90 0.80],tightInterval),wideInterval));
%         hSpecTheta(1) = bar(1,rPwSensorTheta_pre,width,'FaceColor',colorDarkGray,'EdgeColor','none');
%         hold on;
%         hSpecTheta(2) = bar(2,rPwSensorTheta_stm,width,'FaceColor',colorLightBlue,'EdgeColor','none');
%         hold on;
%         hSpecTheta(3) = bar(3,rPwSensorTheta_post,width,'FaceColor',colorBlack,'EdgeColor','none');
%         text(1,yLim(2)*0.95,'Theta','fontSize',fontS);
%         ylabel('Relative Power','fontSize',fontS);
%     hSpectrum(2) = axes('Position',axpt(8,6,4:5,2:6,axpt(nCol,nRow,7:10,10:11,[0.10 0.05 0.90 0.80],tightInterval),wideInterval));
%         hSpecTheta(1) = bar(1,rPwSensorLGamma_pre,width,'FaceColor',colorDarkGray,'EdgeColor','none');
%         hold on;
%         hSpecTheta(2) = bar(2,rPwSensorLGamma_stm,width,'FaceColor',colorLightBlue,'EdgeColor','none');
%         hold on;
%         hSpecTheta(3) = bar(3,rPwSensorLGamma_post,width,'FaceColor',colorBlack,'EdgeColor','none');
%         text(0.5,yLim(2)*0.95,'L-Gam','fontSize',fontS);
%         title('Relative PowerSpec on the track','fontSize',fontM,'fontWeight','bold')    
%     hSpectrum(3) = axes('Position',axpt(8,6,6:7,2:6,axpt(nCol,nRow,7:10,10:11,[0.10 0.05 0.90 0.80],tightInterval),wideInterval));
%         hSpecTheta(1) = bar(1,rPwSensorHGamma_pre,width,'FaceColor',colorDarkGray,'EdgeColor','none');
%         hold on;
%         hSpecTheta(2) = bar(2,rPwSensorHGamma_stm,width,'FaceColor',colorLightBlue,'EdgeColor','none');
%         hold on;
%         hSpecTheta(3) = bar(3,rPwSensorHGamma_post,width,'FaceColor',colorBlack,'EdgeColor','none');
%         text(0.5,yLim(2)*0.95,'H-Gam','fontSize',fontS);
%         
%     set(hSpectrum,'Box','off','TickDir','out','YLim',yLim,'YTick',[],'XLim',[0,4],'XTick',[1,2,3],'XTickLabel',{'Pr','St','  Po'},'fontSize',fontS,'LineWidth',lineM)
%     set(hSpectrum(1),'Box','off','TickDir','out','YLim',yLim,'YTick',[yLim(1),yLim(2)],'YTickLabel',{'0';sprintf('%.2E',yLim(2))},'XLim',[0,4],'XTick',[1,2,3],'XTickLabel',{'Pr','St','  Po'},'fontSize',fontS)

% Cell ID
    hID = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,10,1,[0.11 0.18 0.80 0.80],tightInterval),wideInterval));
    text(0.5, 1, ['Cell ID: ',num2str(cellID(iFile))],'FontSize',fontM,'fontWeight','bold');
    set(hID,'visible','off');
    
    cd(saveDir);
    print('-painters','-r300',['cellID_',num2str(cellID(iFile)),'.tif'],'-dtiff');
%     print('-painters','-r300',[cellFigName{1},'_cellID_',num2str(cellID(iFile)),'.tif'],'-dtiff');
%     print('-painters','-r300',[cellFigName{1},'.ai'],'-depsc');
    close;
end
% fclose('all');
end