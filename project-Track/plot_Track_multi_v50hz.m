function plot_Track_multi_v50hz(fileList, cellID, saveDir)
% function trackPlot_v4_multifig_v3()
% Plot properties
load('D:\Dropbox\SNL\P2_Track\myParameters.mat');
fontM = 7;
paperSize = {[0 0 21.0 29.7]; % A4_portrait
             [0 0 29.7 21.0]; % A4_landscape
             [0 0 15.7 21.0]; % A4_half landscape
             [0 0 21.6 27.9]}; % Letter

matFile = fileList;
nFile = length(matFile);

for iFile = 1:nFile
    [cellDir, cellName, ~] = fileparts(matFile{iFile});
    cellDirSplit = regexp(cellDir,'\','split');
    cellFigName = strcat(cellDirSplit(end-1),'_',cellDirSplit(end),'_',cellName);
    cscTetrode = str2double(cellName(3)); % find a tetrode for csc analysis
    
    cd(cellDir);

%     [cscTime, total_cscSample, cscList] = cscLoad;
%     cscSample = total_cscSample{cscTetrode};

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
    fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{3});
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
    if ~isnan(lightProbPlfm_50hz)
        text(0.3,0.45,['Plfm 50Hz spike Prob. : ',num2str(round(lightProbPlfm_50hz*10)/10)],'fontSize',fontS);
    end
    text(0.3,0.25,['Track 50Hz spike Prob. : ',num2str(round(lightProbTrack_50hz*10)/10)],'fontSize',fontS);
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
    patch([31,60,60,31],[-0.98, -0.98, -0.90, -0.90],colorLightBlue,'LineStyle','none')
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
        winBlue = [-25, 200];
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

% Response check: Plfm50hz
    if isfield(lightTime,'Plfm50hz') && ~isempty(lightTime.Plfm50hz)
        lightDurationColor = {colorLLightBlue, colorLightGray};
        testRangeChETA = 8; % ChETA light response test range (ex. 10ms)       
    end
    if isfield(lightTime,'Plfm50hz') && ~isempty(lightTime.Plfm50hz)
        nBlue = length(lightTime.Plfm50hz);
        winBlue = [min(pethtimePlfm50hz) max(pethtimePlfm50hz)];
% Raster
        hPlfmBlue(1) = axes('Position',axpt(2,8,2,1:2,axpt(nCol,nRow,1:4,2:5,[0.15 0.13 0.85 0.75],tightInterval),wideInterval));
        plot(xptPlfm50hz{1},yptPlfm50hz{1},'LineStyle','none','Marker','.','MarkerSize',markerS,'Color','k');
        set(hPlfmBlue(1),'XLim',winBlue,'XTick',[],'YLim',[0 nBlue], 'YTick', [0 nBlue], 'YTickLabel', {0, nBlue});
%         ylabel('Trials','FontSize',fontM);
        title('Platform light response (50hz)','FontSize',fontM,'FontWeight','bold');
% Psth
        hPlfmBlue(2) = axes('Position',axpt(2,8,2,3:4,axpt(nCol,nRow,1:4,2:5,[0.15 0.13 0.85 0.75],tightInterval),wideInterval));
        hold on;
        yLimBarBlue = ceil(max(pethPlfm50hz(:))*1.05+0.0001);
        bar(5, 1000, 'BarWidth', 10, 'LineStyle','none', 'FaceColor', colorLLightBlue);
        rectangle('Position', [0 yLimBarBlue*0.925, 10, yLimBarBlue*0.075], 'LineStyle', 'none', 'FaceColor', colorBlue);
        hBarBlue = bar(pethtimePlfm50hz, pethPlfm50hz, 'histc');
        if statDir_Plfm50hz == 1
            text(sum(winBlue)*0.3,yLimBarBlue*0.9,['latency = ', num2str(latencyPlfm50hz1st,3)],'FontSize',fontS,'interpreter','none');
        else
        end
        set(hBarBlue, 'FaceColor','k', 'EdgeAlpha',0);
        set(hPlfmBlue(2), 'XLim', winBlue, 'XTick', [winBlue(1) winBlue(2)],'XTickLabel',{winBlue(1);winBlue(2)},'YLim', [0 yLimBarBlue], 'YTick', [0 yLimBarBlue], 'YTickLabel', {[], yLimBarBlue});
        xlabel('Time (ms)','FontSize',fontS);
%         ylabel('Rate (Hz)', 'FontSize',fontM);
% Hazard function
        hPlfmBlue(3) = axes('Position',axpt(2,8,2,7:8,axpt(nCol,nRow,1:4,2:5,[0.15 0.17 0.85 0.75],tightInterval),wideInterval));
        hold on;
        ylimH = min([ceil(max([H1_Plfm50hz;H2_Plfm50hz])*1100+0.0001)/1000 1]);
        winHTag = [0 testRangeChETA];
        stairs(timeLR_Plfm50hz, H2_Plfm50hz, 'LineStyle',':','LineWidth',lineL,'Color','k');
        stairs(timeLR_Plfm50hz, H1_Plfm50hz,'LineStyle','-','LineWidth',lineL,'Color',colorBlue);
        text(diff(winHTag)*0.1,ylimH*0.9,['p = ',num2str(pLR_Plfm50hz,3)],'FontSize',fontS,'Interpreter','none');
        text(diff(winHTag)*0.1,ylimH*0.7,['calib: ',num2str(calibPlfm50hz,3),' ms'],'FontSize',fontS,'Interpreter','none');
        set(hPlfmBlue(3),'XLim',winHTag,'XTick',winHTag,'YLim',[0 ylimH], 'YTick', [0 ylimH], 'YTickLabel', {[], ylimH});
        xlabel('Time (ms)','FontSize',fontS);
%         ylabel('H(t)','FontSize',fontM);
        title('LR test (platform 50hz)','FontSize',fontM,'FontWeight','bold');
        set(hPlfmBlue,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS);
    end
    align_ylabel(hPlfmBlue)    

% Track Response check: Track
    if isfield(lightTime,'Track50hz') && exist('xptTrackLight','var') && ~isempty(xptTrackLight)
        nBlue = length(lightTime.Track50hz);
        winBlue = [min(pethtimeTrackLight) max(pethtimeTrackLight)];
    % Raster
        hTrackBlue(1) = axes('Position',axpt(2,8,1,1:2,axpt(nCol,nRow,7:10,2:5,[0.1 0.13 0.82 0.75],tightInterval),wideInterval));
        plot(xptTrackLight{1},yptTrackLight{1},'LineStyle','none','Marker','.','MarkerSize',markerS,'Color','k');
        set(hTrackBlue(1),'XLim',winBlue,'XTick',[],'YLim',[0 nBlue], 'YTick', [0 nBlue], 'YTickLabel', {0, nBlue});
        ylabel('Trials','FontSize',fontM);
        title('Track light response (50hz)','FontSize',fontM,'FontWeight','bold');    
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
        text(sum(winBlue)*0.3,yLimBarBlue*0.9,['latency = ', num2str(latencyTrack1st,3)],'FontSize',fontS,'interpreter','none');
%         text(sum(winBlue)*0.85,yLimBarBlue*0.9,['p_lat = ',num2str(pLatencyModu_first,3)],'FontSize',fontS,'interpreter','none');
        set(hBarBlue, 'FaceColor','k', 'EdgeAlpha',0);
        set(hTrackBlue(2), 'XLim', winBlue, 'XTick', [winBlue(1),winBlue(2)],'XTickLabel',{winBlue(1);winBlue(2)},...
            'YLim', [0 yLimBarBlue], 'YTick', [0 yLimBarBlue], 'YTickLabel', {[], yLimBarBlue});
        ylabel('Rate (Hz)','FontSize',fontS);
        xlabel('Time (ms)','FontSize',fontS);
    % Hazard function    
        hTrackBlue(3) = axes('Position',axpt(2,8,1,7:8,axpt(nCol,nRow,7:10,2:5,[0.1 0.17 0.82 0.75],tightInterval),wideInterval));
        hold on;
        ylimH = min([ceil(max([H1_Track;H2_Track])*1100+0.0001)/1000 1]);
        winHModu = [0 testRangeChETA];
        stairs(timeLR_Track, H2_Track, 'LineStyle',':','LineWidth',lineL,'Color','k');
        stairs(timeLR_Track, H1_Track,'LineStyle','-','LineWidth',lineL,'Color',colorBlue);
        text(diff(winHModu)*0.1,ylimH*0.9,['p = ',num2str(pLR_Track,3)],'FontSize',fontS,'Interpreter','none');
        text(diff(winHModu)*0.1,ylimH*0.7,['calib: ',num2str(calibTrack,3),' ms'],'FontSize',fontS,'Interpreter','none');
        xlabel('Time (ms)','FontSize',fontS);
        ylabel('H(t)','FontSize',fontS);
        title('Log-rank test (Track)','FontSize',fontM,'FontWeight','bold');
        set(hTrackBlue(3),'XLim',winHModu,'XTick',winHModu,'XTickLabel',{winHModu(1);winHModu(2)},'YLim',[0 ylimH], 'YTick', [0 ylimH], 'YTickLabel', {[], ylimH});
        set(hTrackBlue,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS);
    end
    align_ylabel(hTrackBlue)

% New respstat
%         hTrackrespN = axes('Position',axpt(2,8,2,7:8,axpt(nCol,nRow,7:10,2:5,[0.1 0.17 0.82 0.75],tightInterval),wideInterval));
%         hold on;
%         ylimH = min([ceil(max([H1_TrackN;H2_TrackN])*1100+0.0001)/1000 1]);
%         winHModu = [0 testRangeChETA];
%         stairs(timeLR_TrackN, H2_TrackN, 'LineStyle',':','LineWidth',lineL,'Color','k');
%         stairs(timeLR_TrackN, H1_TrackN,'LineStyle','-','LineWidth',lineL,'Color',colorBlue);
%         text(diff(winHModu)*0.1,ylimH*0.9,['p = ',num2str(pLR_TrackN,3)],'FontSize',fontS,'Interpreter','none');
%         text(diff(winHModu)*0.1,ylimH*0.7,['calib: ',num2str(calibTrackN,3),' ms'],'FontSize',fontS,'Interpreter','none');
%         xlabel('Time (ms)','FontSize',fontS);
%         
% %         ylabel('H(t)','FontSize',fontS);
%         title('New LR test (Track)','FontSize',fontS,'FontWeight','bold');
%         set(hTrackrespN,'XLim',winHModu,'XTick',winHModu,'XTickLabel',{winHModu(1);num2str(winHModu(2))},'YLim',[0 ylimH], 'YTick', [0 ylimH], 'YTickLabel', {[], ylimH});
%         set(hTrackrespN,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS);
    
% detonate spike plot
    hDetoSpk = axes('Position',axpt(4,8,3:4,1:4,axpt(nCol,nRow,7:10, 2:5,[0.16 0.13 0.80 0.75],tightInterval),wideInterval));
    plot(m_deto_spkTrack50hz*100,'-o','color',colorBlack,'MarkerFaceColor',colorBlue,'MarkerSize',markerM);
    xlabel('Light pulse','fontSize',fontS);
    ylabel('Spike probability, P (%)','fontSize',fontS);
    title('Detonate spike (Track 50hz)','fontSize',fontM,'fontWeight','bold');
    set(hDetoSpk,'Box','off','TickDir','out','XLim',[0,length(m_deto_spkTrack50hz)+1],'YLim',[0, max(m_deto_spkTrack50hz*100)*1.1+5],'fontSize',fontS);
    
    
% Heat map   
    totalmap = [pre_ratemap(1:90,40:130),stm_ratemap(1:90,40:130),post_ratemap(1:90,40:130)];
    hMap = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1:5,7:8,[0.07 0.22 0.80 0.75]),tightInterval));
    hold on;
    hField = pcolor(totalmap);
    
% Arc property
    if ~isempty(strfind(cellDir,'DRun')) | ~isempty(strfind(cellDir,'noRun'));
        arc = linspace(pi,pi/2*3,170); % s6-s9
    else ~isempty(strfind(cellDir,'DRw')) | ~isempty(strfind(cellDir,'noRw'));
        arc = linspace(pi/6*5, pi/6*4,170);
    end
    
    if ~isempty(lightTime.Track50hz)
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
    
     hPlfmMap(1) = axes('Position',axpt(1,4,1,1:2,axpt(nCol,nRow,5,6:7,[0.12 0.15 0.85 0.75],tightInterval),wideInterval));
     hFieldBase = pcolor(base_ratemap(30:70,50:110));
     text(45,38,[num2str(floor(peakFR2D_plfm*10)/10),' Hz'],'fontSize',fontS);
     text(33,10,'baseline','fontSize',fontS);
     
     hPlfmMap(2) = axes('Position',axpt(1,4,1,3:4,axpt(nCol,nRow,5,6:7,[0.12 0.15 0.85 0.75],tightInterval),wideInterval));
     hFieldTwo = pcolor(twohz_ratemap(30:70,50:110));
     text(45,38,[num2str(floor(peakFR2D_two*10)/10),' Hz'],'fontSize',fontS);
     text(34,10,'2hz stm','fontSize',fontS);

     set(hFieldBase,'linestyle','none');
     set(hFieldTwo,'linestyle','none');
     set(hPlfmMap,'Box','off','visible','off','XLim',[0, 75],'YLim',[0,50]);
    
% Track light response raster plot (aligned on pseudo light - light - pseudo light)
    hTrackLight(1) = axes('Position',axpt(1,8,1,5:6,axpt(nCol,nRow,7:10,5:7,[0.10 0.11 0.85 0.85],tightInterval),wideInterval));
        plot([xptPsdPre{1}, xptTrackLight{1}, xptPsdPost{1}],[yptPsdPre{1}, (length(psdlightPre)+yptTrackLight{1}), (sum([length(psdlightPre),length(lightTime.Track50hz)])+yptPsdPost{1})],'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');
        if ~isempty(strfind(cellDir,'DRun')) | ~isempty(strfind(cellDir,'DRw'))
            rec = rectangle('Position',[0.5 length(psdlightPre)+1, 10, length(lightTime.Track50hz)], 'LineStyle','none','FaceColor',lightDurationColor{1});
        end
        if ~isempty(strfind(cellDir,'noRun')) | ~isempty(strfind(cellDir,'noRw'))
            rec = rectangle('Position',[0.5 length(psdlightPre)+1, 10, length(lightTime.Track50hz)], 'LineStyle','none','FaceColor',lightDurationColor{2});
        end
        if pLR_Track_pre < 0.005
            text(105, sum([length(psdlightPre),length(lightTime.Track50hz),length(psdlightPost)])/8, '*','Color',colorRed,'fontSize',fontM);
        end
        if pLR_Track < 0.005
            text(105, sum([length(psdlightPre),length(lightTime.Track50hz),length(psdlightPost)])*3/8, '*','Color',colorRed,'fontSize',fontM);
        end
        if pLR_Track_post < 0.005
            text(105, sum([length(psdlightPre),length(lightTime.Track50hz),length(psdlightPost)])*6/8, '*','Color',colorRed,'fontSize',fontM);
        end
        uistack(rec,'bottom');
        ylabel('Light trial','FontSize',fontS);
        title('Track light response (Psd-L-Psd)','FontSize',fontM,'FontWeight','bold');  
    hTrackLight(2) = axes('Position',axpt(1,8,1,7:8,axpt(nCol,nRow,7:10,5:7,[0.10 0.11 0.85 0.85],tightInterval),wideInterval));
        ylimpeth = ceil(max([pethPsdPreConv,pethTrackLightConv,pethPsdPostConv])*1.1+0.0001);
        hold on;
        plot(pethtimePsdPre,pethPsdPreConv,'LineStyle','-','LineWidth',lineM,'Color',colorGray);
        plot(pethtimeTrackLight,pethTrackLightConv,'LineStyle','-','LineWidth',lineM,'Color',colorBlue);
        plot(pethtimePsdPost,pethPsdPostConv,'LineStyle','-','LineWidth',lineM,'Color',colorBlack);
        ylabel('Rate (Hz)','FontSize',fontS);
        xlabel('Time (ms)','FontSize',fontS);
        align_ylabel(hTrackLight);
    set(hTrackLight(1),'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS,'XLim',[0 20],'XTick',[],'YLim',[0, sum([length(psdlightPre),length(lightTime.Track50hz),length(psdlightPost)])],'YTick',[0,length(psdlightPre),sum([length(psdlightPre),length(lightTime.Track50hz)]),sum([length(psdlightPre),length(lightTime.Track50hz),length(psdlightPost)])]);
    set(hTrackLight(2),'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS,'XLim',[0, 20],'XTick',[0, 20],'YLim',[0, max(ylimpeth)]);
    
if ~isempty(strfind(cellDir,'DRun')) | ~isempty(strfind(cellDir,'noRun'))
    iSensor1 = 6; % Light on sensor
    lightDur = 1; % Putative light duration
    lightLoc = [20*pi*5/6 20*pi*8/6];
end
if ~isempty(strfind(cellDir,'DRw')) | ~isempty(strfind(cellDir,'noRw'))
    iSensor1 = 10; % Light on sensor
    lightDur = 4; % Putative light duration
    lightLoc = [20*pi*9/6 20*pi*10/6];
end
rewardLoc1 = [20*pi*3/6 20*pi*4/6];
rewardLoc2 = [20*pi*9/6 20*pi*10/6];

% Spatial raster plot
    if ~isempty(strfind(cellDir,'DRun')) | ~isempty(strfind(cellDir,'DRw')) % Light session
        hSRaster(1) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,1:4,8:9,[0.10 0.10 0.85 0.75],tightInterval),wideInterval));
        plot([xptSpatial{:}],[yptSpatial{:}],'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');
        pLight = patch([lightLoc(1) lightLoc(2) lightLoc(2) lightLoc(1)],[31 31 60 60],lightDurationColor{1},'LineStyle','none');
        ylabel('Trial','FontSize',fontS);
        title(['Spatial Raster & PETH at ',fields{iSensor1}],'FontSize',fontM,'FontWeight','bold');
        hSPsth(1) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,1:4,8:9,[0.10 0.10 0.85 0.75],tightInterval),wideInterval));
        ylimpethSpatial = ceil(max(pethconvSpatial(pethconvSpatial<inf))*1.1+0.0001);
        pRw(1) = patch([rewardLoc1(1), rewardLoc1(2), rewardLoc1(2), rewardLoc1(1)],[0, 0, ylimpethSpatial, ylimpethSpatial],colorLightRed);
        hold on;
        pRw(2) = patch([rewardLoc2(1), rewardLoc2(2), rewardLoc2(2), rewardLoc2(1)],[0, 0, ylimpethSpatial, ylimpethSpatial],colorLightRed);
        hold on;
        for iType = 1:3
            plot(pethSpatial(1:124),pethconvSpatial(iType,:),'LineStyle','-','LineWidth',lineM,'Color',lineColor{iType})
        end
        ylabel('Rate (Hz)','FontSize',fontS);
        xlabel('Position (cm)','FontSize',fontS);
        uistack(pLight,'bottom');
% Temporal raster plot
        hTRaster(1) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,7:10,8:9,[0.10 0.10 0.85 0.75],tightInterval),wideInterval));
        plot([xpt.(fields{iSensor1}){:}],[ypt.(fields{iSensor1}){:}],'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');
        pLight = patch(xpt_lightT,ypt_lightT,colorLLightBlue);
        ylabel('Trial','FontSize',fontS);
        title(['Temporal Raster & PETH at ',fields{iSensor1}],'FontSize',fontM,'FontWeight','bold');
        hTPsth(1) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,7:10,8:9,[0.10 0.10 0.85 0.75],tightInterval),wideInterval));
        ylimpeth1 = ceil(max(pethconv.(fields{iSensor1})(:))*1.1+0.0001);
        hold on;
        for iType = 1:3
            plot(pethtime.(fields{iSensor1}),pethconv.(fields{iSensor1})(iType,:),'LineStyle','-','LineWidth',lineM,'Color',lineColor{iType})
        end
        ylabel('Rate (Hz)','FontSize',fontS);
        xlabel('Time (sec)','FontSize',fontS);
    end

    if ~isempty(strfind(cellDir,'noRun')) | ~isempty(strfind(cellDir,'noRw')) % No light session
% Spatial rastser plot
        hSRaster(1) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,1:4,8:9,[0.1 0.10 0.85 0.75],tightInterval),wideInterval));
        hold on;
        plot([xptSpatial{:}],[yptSpatial{:}],'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');
        pLight = patch([abso_light(1) abso_light(2) abso_light(2) abso_light(1)],[31 31 60 60],lightDurationColor{1},'LineStyle','none');
%         rec = rectangle('Position',[lightLoc(1), 31, lightLoc(2)-lightLoc(1), 30], 'LineStyle','none','FaceColor',lightDurationColor{2});
        ylabel('Trial','FontSize',fontS);
        title(['Spatial Raster & PETH at ',fields{iSensor1}],'FontSize',fontS,'FontWeight','bold');
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
        text(115,ylimpethSpatial*0.8,[num2str(peakFR_track),' Hz'],'fontSize',fontS);
        ylabel('Rate (Hz)','FontSize',fontS);
        xlabel('Position (cm)','FontSize',fontS);
        uistack(pLight,'bottom');  
% Temporal raster plot
        hTRaster(1) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,7:10,8:9,[0.1 0.10 0.85 0.75],tightInterval),wideInterval));
        hold on;
        plot([xpt.(fields{iSensor1}){:}],[ypt.(fields{iSensor1}){:}],'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');
        pLight = patch(xpt_lightT,ypt_lightT,colorLightGray);
        ylabel('Trial','FontSize',fontS);
        title(['Temporal Raster & PETH at ',fields{iSensor1}],'FontSize',fontS,'FontWeight','bold');
        hTPsth(1) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,7:10,8:9,[0.1 0.10 0.85 0.75],tightInterval),wideInterval));
        ylimpeth1 = ceil(max(pethconv.(fields{iSensor1})(:))*1.1+0.0001);
        hold on;
        for iType = 1:3
            plot(pethtime.(fields{iSensor1}),pethconv.(fields{iSensor1})(iType,:),'LineStyle','-','LineWidth',lineM,'Color',lineColor{iType})
        end
        uistack(rec,'bottom');
    end
    align_ylabel([hSRaster,hSPsth]);
    align_ylabel([hTRaster,hTPsth]);
    set(hSRaster,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS,'XLim',[0 124],'XTick',[],'YLim',[0, 90],'YTick',[0:30:90]);
    set(hTRaster,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS,'XLim',[-5 5],'XTick',[],'YLim',[0, 90],'YTick',[0:30:90]);
    set(hSPsth,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS,'XLim',[0, 124],'XTick',[0:10:120],'YLim',[0 ylimpethSpatial]);
    set(hTPsth,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS,'XLim',[-5, 5],'XTick',[-5:5],'YLim',[0 ylimpeth1]);
    set(pRw,'LineStyle','none','FaceAlpha',0.2);
    set(pLight,'LineStyle','none');
    
    hLine = axes('Position',axpt(1,2,1,1:2,axpt(nCol,nRow,5:6,8,[0.1 0.10 0.85 0.75],tightInterval),wideInterval));
        text(0.2,1.00,'-: Pre','FontSize',fontM,'Color',colorGray,'fontWeight','Bold');    
        text(0.2,0.75,'-: Stm','FontSize',fontM,'Color',colorBlue,'fontWeight','Bold');
        text(0.2,0.50,'-: Post','FontSize',fontM,'Color',colorBlack,'fontWeight','Bold');
        text(0.1,0.25,' : Reward','FontSize',fontM,'Color',colorLightRed,'fontWeight','Bold');
    set(hLine,'Box','off','visible','off');

    
%% light raster
    hLight = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1:nCol,10:nRow,[0.10 0.05 0.85 0.85],tightInterval),wideInterval));
    plot([xptPre1st{1},xptLight1st{1},xptPost1st{1}],[yptPre1st{1},yptLight1st{1}+30,yptPost1st{1}+60],'marker','.','markerSize',markerS,'LineStyle','none','color','k');
    hold on;
    for iPulse = 1:minPulseTrack50hz
        pminLight(iPulse) = patch([20*iPulse-20 20*iPulse-10 20*iPulse-10 20*iPulse-20],[31 31 60 60],colorLLightBlue,'lineStyle','none');
        hold on;
    end
    set(hLight,'TickDir','out','Box','off','XLim',[-500, 2000],'YLim',[0,90],'XTick',[-500:500:2000],'YTick',[0:30:90],'fontSize',fontS);
    text(500,95,['min light pulse: ',num2str(minPulseTrack50hz)],'fontSize',fontS);
    xlabel('Time (ms)','fontSize',fontS);
    
% Cell ID
    hID = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,10,1,[0.11 0.18 0.80 0.80],tightInterval),wideInterval));
    text(1, 1, ['Cell ID: ',num2str(cellID(iFile))],'FontSize',fontM,'fontWeight','bold');
    set(hID,'visible','off');
    
    cd(saveDir);
    print('-painters','-r300',['cellID_',num2str(cellID(iFile)),'.tif'],'-dtiff');
%     print('-painters','-r300',[cellFigName{1},'_cellID-',num2str(cellID(iFile)),'.tif'],'-dtiff');
%     print('-painters','-r300',[cellFigName{1},'.ai'],'-depsc');
    close;
end
% fclose('all');
end