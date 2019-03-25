function plot_Track_multi_v3_lightconfirm(fileList, cellID, saveDir)
% function trackPlot_v4_multifig_v3()
% Plot properties
load('D:\Dropbox\SNL\P2_Track\myParameters.mat');

paperSize = {[0 0 21.0 29.7]; % A4_portrait
             [0 0 29.7 21.0]; % A4_landscape
             [0 0 15.7 21.0]; % A4_half landscape
             [0 0 21.6 27.9]}; % Letter

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
    
    nCol = 10;
    nRow = 11;
% Cell information    
    fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{3});
    hText = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1:4,1:2,[0.1 0.1 0.85 0.89],tightInterval),wideInterval));
    hold on;
    text(0,0.9,matFile{iFile}, 'FontSize',fontM, 'Interpreter','none','FontWeight','bold');
    text(0,0.8,['Mean firing rate (baseline): ',num2str(meanFR_base,3), ' Hz'], 'FontSize',fontM);
    text(0,0.7,['Mean firing rate (task): ',num2str(meanFR_task,3), ' Hz'], 'FontSize',fontM);
    text(0,0.6,['Spike width: ',num2str(spkwth,3),' us'], 'FontSize',fontM);
    text(0,0.5,['Half-valley width: ',num2str(hfvwth,3),' us'], 'FontSize',fontM);
    text(0,0.4,['Peak valley ratio: ',num2str(spkpvr,3)], 'FontSize',fontM);
    set(hText,'Visible','off');
    
% Waveform
    yLimWaveform = [min(spkwv(:)), max(spkwv(:))];
    for iCh = 1:4
        hWaveform(iCh) = axes('Position',axpt(4,1,iCh,1,axpt(nCol,nRow,3:5,2,[0.1 0.4 0.85 0.60],tightInterval),wideInterval));
        plot(spkwv(iCh,:), 'LineWidth', lineL, 'Color','k');
        if iCh == 4
            line([24 32], [yLimWaveform(2)-50 yLimWaveform(2)-50], 'Color','k', 'LineWidth', lineM);
            line([24 24],[yLimWaveform(2)-50 yLimWaveform(2)], 'Color','k', 'LineWidth',lineM);
        end
    end
    set(hWaveform, 'Visible', 'off','XLim',[1 32], 'YLim',yLimWaveform*1.05);
    
% Platform light intensity plot
    yLimlightBase = max([lightProbPlfm5mw; lightProbPlfm8mw; lightProbPlfm10mw])*1.1;
    if yLimlightBase < 10
        yLimlightBase = 20;
    end
    hIntensity = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,7,1,[0.15 0.25 0.80 0.70],tightInterval),wideInterval));
    hold on;
    plot([1,2,3],[lightProbPlfm5mw,lightProbPlfm8mw,lightProbPlfm10mw],'-o','Color',colorGray,'MarkerFaceColor',colorBlue,'MarkerEdgeColor','k','MarkerSize',markerM);
    hold on;
    ylabel('Spike counts','FontSize',fontM);
    xlabel('Power (mW)','FontSize',fontM);
    title('Plfm laser intensity','FontSize',fontL,'FontWeight','bold');
    set(hIntensity,'XLim',[0,4],'YLim',[-5,yLimlightBase],'Box','off','TickDir','out','XTick',[1:3],'XTickLabel',{'5','8','10'},'FontSize',fontM);

% Light response spike probability
    hTextSpkProb = axes('Position',axpt(1,4,1,1:2,axpt(nCol,nRow,8:10,1:2,[0.1 0.10 0.80 0.87],tightInterval),wideInterval));
    text(0.4,0.8,'Spike probability (%)','fontSize',fontL,'fontWeight','bold');
    text(0.5,0.6,['Plfm 2Hz spike Prob. (%): ',num2str(round(lightProbPlfm_2hz*10)/10)],'fontSize',fontM);
    if ~isnan(lightProbPlfm_8hz)
        text(0.5,0.4,['Plfm 8Hz spike Prob. (%): ',num2str(round(lightProbPlfm_8hz*10)/10)],'fontSize',fontM);
    end
    text(0.5,0.2,['Track 8Hz spike Prob. (%): ',num2str(round(lightProbTrack_8hz*10)/10)],'fontSize',fontM);
    set(hTextSpkProb,'Box','off','visible','off');

% Light response spike probability 
    hStmzoneSpike = axes('Position',axpt(1,5,1,3:4,axpt(nCol,nRow,8:10,1:2,[0.1 0.10 0.80 0.87],tightInterval),wideInterval));
    text(0.4,0.8,'Stm zone spike number','fontSize',fontL,'fontWeight','bold');
    text(0.5,0.6,['Pre: ',num2str(m_stmzoneSpike(1))],'fontSize',fontM);
    text(0.5,0.4,['Stm: ',num2str(m_stmzoneSpike(2))],'fontSize',fontM);
    text(0.5,0.2,['Post: ',num2str(m_stmzoneSpike(3))],'fontSize',fontM);
    set(hStmzoneSpike,'Box','off','visible','off');
    
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
        hPlfmBlue(1) = axes('Position',axpt(2,8,1,1:2,axpt(nCol,nRow,1:4,2:5,[0.1 0.15 0.85 0.75],tightInterval),wideInterval));
        plot(xptPlfm2hz{1},yptPlfm2hz{1},'LineStyle','none','Marker','.','MarkerSize',markerS,'Color','k');
        set(hPlfmBlue(1),'XLim',winBlue,'XTick',[],'YLim',[0 nBlue], 'YTick', [0 nBlue], 'YTickLabel', {0, nBlue});
        ylabel('Trials','FontSize',fontM);
        title('Platform light response (2Hz)','FontSize',fontL,'FontWeight','bold');
% Psth
        hPlfmBlue(2) = axes('Position',axpt(2,8,1,3:4,axpt(nCol,nRow,1:4,2:5,[0.1 0.15 0.85 0.75],tightInterval),wideInterval));
        hold on;
        yLimBarBlue = ceil(max(pethPlfm2hz(:))*1.05+0.0001);
        bar(5, 1000, 'BarWidth', 10, 'LineStyle','none', 'FaceColor', colorLLightBlue);
        rectangle('Position', [0 yLimBarBlue*0.925, 10, yLimBarBlue*0.075], 'LineStyle', 'none', 'FaceColor', colorBlue);
        hBar = bar(pethtimePlfm2hz, pethPlfm2hz, 'histc');
        text(sum(winBlue)*0.3,yLimBarBlue*0.9,['latency = ', num2str(latencyPlfm2hz1st,3)],'FontSize',fontM,'interpreter','none');

        set(hBar, 'FaceColor','k', 'EdgeAlpha',0);
        set(hPlfmBlue(2), 'XLim', winBlue, 'XTick', [winBlue(1) 0 winBlue(2)],'XTickLabel',{winBlue(1);0;num2str(winBlue(2))},'YLim', [0 yLimBarBlue], 'YTick', [0 yLimBarBlue], 'YTickLabel', {[], yLimBarBlue});
        xlabel('Time (ms)','FontSize',fontM);
        ylabel('Rate (Hz)', 'FontSize',fontM);
% Hazard function
        hPlfmBlue(3) = axes('Position',axpt(2,8,1,7:8,axpt(nCol,nRow,1:4,2:5,[0.1 0.17 0.85 0.75],tightInterval),wideInterval));
        hold on;
        ylimH = min([ceil(max([H1_Plfm2hz;H2_Plfm2hz])*1100+0.0001)/1000 1]);
        winHTag = [0 testRangeChETA];
        stairs(timeLR_Plfm2hz, H2_Plfm2hz, 'LineStyle',':','LineWidth',lineL,'Color','k');
        stairs(timeLR_Plfm2hz, H1_Plfm2hz,'LineStyle','-','LineWidth',lineL,'Color',colorBlue);
        text(diff(winHTag)*0.1,ylimH*0.9,['p = ',num2str(pLR_Plfm2hz,3)],'FontSize',fontM,'Interpreter','none');
        text(diff(winHTag)*0.1,ylimH*0.7,['calib: ',num2str(calibPlfm2hz,3),' ms'],'FontSize',fontM,'Interpreter','none');
        set(hPlfmBlue(3),'XLim',winHTag,'XTick',winHTag,'YLim',[0 ylimH], 'YTick', [0 ylimH], 'YTickLabel', {[], ylimH});
        xlabel('Time (ms)','FontSize',fontM);
        ylabel('H(t)','FontSize',fontM);
        title('LR test (Platform)','FontSize',fontL,'FontWeight','bold');
        set(hPlfmBlue,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontM);
    end

% Response check: Plfm8hz
    if isfield(lightTime,'Plfm8hz') && ~isempty(lightTime.Plfm8hz)
        lightDurationColor = {colorLLightBlue, colorLightGray};
        testRangeChETA = 8; % ChETA light response test range (ex. 10ms)       
    end
    if isfield(lightTime,'Plfm8hz') && ~isempty(lightTime.Plfm8hz)
        nBlue = length(lightTime.Plfm8hz);
        winBlue = [min(pethtimePlfm8hz) max(pethtimePlfm8hz)];
% Raster
        hPlfmBlue(1) = axes('Position',axpt(2,8,2,1:2,axpt(nCol,nRow,1:4,2:5,[0.15 0.15 0.85 0.75],tightInterval),wideInterval));
        plot(xptPlfm8hz{1},yptPlfm8hz{1},'LineStyle','none','Marker','.','MarkerSize',markerS,'Color','k');
        set(hPlfmBlue(1),'XLim',winBlue,'XTick',[],'YLim',[0 nBlue], 'YTick', [0 nBlue], 'YTickLabel', {0, nBlue});
        title('Platform light response (8Hz)','FontSize',fontL,'FontWeight','bold');
% Psth
        hPlfmBlue(2) = axes('Position',axpt(2,8,2,3:4,axpt(nCol,nRow,1:4,2:5,[0.15 0.15 0.85 0.75],tightInterval),wideInterval));
        hold on;
        yLimBarBlue = ceil(max(pethPlfm8hz(:))*1.05+0.0001);
        bar(5, 1000, 'BarWidth', 10, 'LineStyle','none', 'FaceColor', colorLLightBlue);
        rectangle('Position', [0 yLimBarBlue*0.925, 10, yLimBarBlue*0.075], 'LineStyle', 'none', 'FaceColor', colorBlue);
        hBar = bar(pethtimePlfm8hz, pethPlfm8hz, 'histc');
        if statDir_Plfm8hz == 1
            text(sum(winBlue)*0.3,yLimBarBlue*0.9,['latency = ', num2str(latencyPlfm8hz1st,3)],'FontSize',fontM,'interpreter','none');
        else
        end
        set(hBar, 'FaceColor','k', 'EdgeAlpha',0);
        set(hPlfmBlue(2), 'XLim', winBlue, 'XTick', [winBlue(1) 0 winBlue(2)],'XTickLabel',{winBlue(1);0;num2str(winBlue(2))},'YLim', [0 yLimBarBlue], 'YTick', [0 yLimBarBlue], 'YTickLabel', {[], yLimBarBlue});
        xlabel('Time (ms)','FontSize',fontM);
% Hazard function
        hPlfmBlue(3) = axes('Position',axpt(2,8,2,7:8,axpt(nCol,nRow,1:4,2:5,[0.15 0.17 0.85 0.75],tightInterval),wideInterval));
        hold on;
        ylimH = min([ceil(max([H1_Plfm8hz;H2_Plfm8hz])*1100+0.0001)/1000 1]);
        winHTag = [0 testRangeChETA];
        stairs(timeLR_Plfm8hz, H2_Plfm8hz, 'LineStyle',':','LineWidth',lineL,'Color','k');
        stairs(timeLR_Plfm8hz, H1_Plfm8hz,'LineStyle','-','LineWidth',lineL,'Color',colorBlue);
        text(diff(winHTag)*0.1,ylimH*0.9,['p = ',num2str(pLR_Plfm8hz,3)],'FontSize',fontM,'Interpreter','none');
        text(diff(winHTag)*0.1,ylimH*0.7,['calib: ',num2str(calibPlfm8hz,3),' ms'],'FontSize',fontM,'Interpreter','none');
        set(hPlfmBlue(3),'XLim',winHTag,'XTick',winHTag,'YLim',[0 ylimH], 'YTick', [0 ylimH], 'YTickLabel', {[], ylimH});
        xlabel('Time (ms)','FontSize',fontM);
%         ylabel('H(t)','FontSize',fontM);
        title('LR test (platform 8Hz)','FontSize',fontL,'FontWeight','bold');
        set(hPlfmBlue,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontM);
    end

% Response check: Track
    if isfield(lightTime,'Track8hz') && exist('xptTrackLight','var') && ~isempty(xptTrackLight)
        nBlue = length(lightTime.Track8hz);
        winBlue = [-25 100];
    % Raster
        hTrackBlue(1) = axes('Position',axpt(2,8,1,1:2,axpt(nCol,nRow,7:10,2:5,[0.1 0.15 0.82 0.75],tightInterval),wideInterval));
        plot(xptTrackLight{1},yptTrackLight{1},'LineStyle','none','Marker','.','MarkerSize',markerS,'Color','k');
        set(hTrackBlue(1),'XLim',winBlue,'XTick',[],'YLim',[0 nBlue], 'YTick', [0 nBlue], 'YTickLabel', {0, nBlue});
        ylabel('Trials','FontSize',fontM);
        title('Track light response (8Hz)','FontSize',fontL,'FontWeight','bold');    
    % Psth
        hTrackBlue(2) = axes('Position',axpt(2,8,1,3:4,axpt(nCol,nRow,7:10,2:5,[0.1 0.15 0.82 0.75],tightInterval),wideInterval));
        hold on;
        yLimBarBlue = ceil(max(pethTrackLight(:))*1.05+0.0001);
        if ~isempty(strfind(cellDir,'DRun')) | ~isempty(strfind(cellDir,'DRw'))
            bar(5, 1000, 'BarWidth', 10,'LineStyle', 'none', 'FaceColor', colorLLightBlue);
            rectangle('Position', [0, yLimBarBlue*0.925, 10, yLimBarBlue*0.075], 'LineStyle', 'none', 'FaceColor', colorBlue);
        else
            bar(5, 1000, 'BarWidth', 10,'LineStyle', 'none', 'FaceColor', colorLightGray);
            rectangle('Position', [0, yLimBarBlue*0.925, 10, yLimBarBlue*0.075], 'LineStyle', 'none', 'FaceColor', colorGray);
        end
        hBar = bar(pethtimeTrackLight, pethTrackLight, 'histc');
        text(sum(winBlue)*0.3,yLimBarBlue*0.9,['latency = ', num2str(latencyTrack1st,3)],'FontSize',fontM,'interpreter','none');
%         text(sum(winBlue)*0.85,yLimBarBlue*0.9,['p_lat = ',num2str(pLatencyModu_first,3)],'FontSize',fontM,'interpreter','none');
        set(hBar, 'FaceColor','k', 'EdgeAlpha',0);
        set(hTrackBlue(2), 'XLim', winBlue, 'XTick', [winBlue(1), 0, winBlue(2)],'XTickLabel',{winBlue(1); 0; num2str(winBlue(2))},...
            'YLim', [0 yLimBarBlue], 'YTick', [0 yLimBarBlue], 'YTickLabel', {[], yLimBarBlue});
        ylabel('Rate (Hz)','FontSize',fontM);
        xlabel('Time (ms)','FontSize',fontM);
    % Hazard function    
        hTrackBlue(3) = axes('Position',axpt(2,8,1,7:8,axpt(nCol,nRow,7:10,2:5,[0.1 0.17 0.82 0.75],tightInterval),wideInterval));
        hold on;
        ylimH = min([ceil(max([H1_Track;H2_Track])*1100+0.0001)/1000 1]);
        winHModu = [0 testRangeChETA];
        stairs(timeLR_Track, H2_Track, 'LineStyle',':','LineWidth',lineL,'Color','k');
        stairs(timeLR_Track, H1_Track,'LineStyle','-','LineWidth',lineL,'Color',colorBlue);
        text(diff(winHModu)*0.1,ylimH*0.9,['p = ',num2str(pLR_Track,3)],'FontSize',fontM,'Interpreter','none');
        text(diff(winHModu)*0.1,ylimH*0.7,['calib: ',num2str(calibTrack,3),' ms'],'FontSize',fontM,'Interpreter','none');
        xlabel('Time (ms)','FontSize',fontM);
        ylabel('H(t)','FontSize',fontM);
        title('LR test (Track)','FontSize',fontL,'FontWeight','bold');
        set(hTrackBlue(3),'XLim',winHModu,'XTick',winHModu,'XTickLabel',{winHModu(1);num2str(winHModu(2))},'YLim',[0 ylimH], 'YTick', [0 ylimH], 'YTickLabel', {[], ylimH});
        set(hTrackBlue,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontM);
    end
    align_ylabel(hTrackBlue)

% New respstat
        hTrackrespN = axes('Position',axpt(2,8,2,7:8,axpt(nCol,nRow,7:10,2:5,[0.1 0.17 0.82 0.75],tightInterval),wideInterval));
        hold on;
        ylimH = min([ceil(max([H1_TrackN;H2_TrackN])*1100+0.0001)/1000 1]);
        winHModu = [0 testRangeChETA];
        stairs(timeLR_TrackN, H2_TrackN, 'LineStyle',':','LineWidth',lineL,'Color','k');
        stairs(timeLR_TrackN, H1_TrackN,'LineStyle','-','LineWidth',lineL,'Color',colorBlue);
        text(diff(winHModu)*0.1,ylimH*0.9,['p = ',num2str(pLR_TrackN,3)],'FontSize',fontM,'Interpreter','none');
        text(diff(winHModu)*0.1,ylimH*0.7,['calib: ',num2str(calibTrackN,3),' ms'],'FontSize',fontM,'Interpreter','none');
        xlabel('Time (ms)','FontSize',fontM);
%         ylabel('H(t)','FontSize',fontM);
        title('New LR test (Track)','FontSize',fontL,'FontWeight','bold');
        set(hTrackrespN,'XLim',winHModu,'XTick',winHModu,'XTickLabel',{winHModu(1);num2str(winHModu(2))},'YLim',[0 ylimH], 'YTick', [0 ylimH], 'YTickLabel', {[], ylimH});
        set(hTrackrespN,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontM);
        
% detonate spike plot
    hDetoSpk = axes('Position',axpt(4,8,3:4,1:4,axpt(nCol,nRow,7:10, 2:5,[0.16 0.15 0.80 0.75],tightInterval),wideInterval));
    plot(m_deto_spkTrack8hz*100,'-o','color',colorBlack,'MarkerFaceColor',colorBlue,'MarkerSize',markerM);
    xlabel('Light pulse','fontSize',fontM);
    ylabel('Spike probability, P (%)','fontSize',fontM);
    title('Deto. spike (Track 8hz)','fontSize',fontL,'fontWeight','bold');
    set(hDetoSpk,'Box','off','TickDir','out','XLim',[0,length(m_deto_spkTrack8hz)+1],'YLim',[0, max(m_deto_spkTrack8hz*100)*1.1+5],'fontSize',fontM);

% % Light response spike probability
%     hTextSpkProb = axes('Position',axpt(2,8,2,6:7,axpt(nCol,nRow,7:10,2:5,[0.1 0.15 0.80 0.75],tightInterval),wideInterval));
%     text(0.2,0.9,'Spike probability (%)','fontSize',fontL,'fontWeight','bold');
%     text(0.4,0.7,['Plfm 2Hz spike Prob. (%): ',num2str(round(lightProbPlfm_2hz*10)/10)],'fontSize',fontM);
%     if ~isnan(lightProbPlfm_8hz)
%         text(0.4,0.55,['Plfm 8Hz spike Prob. (%): ',num2str(round(lightProbPlfm_8hz*10)/10)],'fontSize',fontM);
%     end
%     text(0.4,0.4,['Track 8Hz spike Prob. (%): ',num2str(round(lightProbTrack_8hz*10)/10)],'fontSize',fontM);
%     set(hTextSpkProb,'Box','off','visible','off');
% 
% % Light response spike probability 
%     hStmzoneSpike = axes('Position',axpt(2,8,2,7:8,axpt(nCol,nRow,7:10,2:5,[0.1 0.15 0.80 0.75],tightInterval),wideInterval));
%     text(0.2,0.7,'Stm zone spike number','fontSize',fontL,'fontWeight','bold');
%     text(0.4,0.5,['Pre: ',num2str(stmzoneSpike(1))],'fontSize',fontM);
%     text(0.4,0.35,['Stm: ',num2str(stmzoneSpike(2))],'fontSize',fontM);
%     text(0.4,0.2,['Post: ',num2str(stmzoneSpike(3))],'fontSize',fontM);
%     set(hStmzoneSpike,'Box','off','visible','off');
    
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
    text(250,85,[num2str(floor(max(peakFR2D_SMtrack*10))/10), ' Hz'],'color','k','FontSize',fontM)
    text(28,3,'Pre-stm','color','k','FontSize',fontM);
    text(125,3,'Stm','color','k','FontSize',fontM)
    text(208,3,'Post-stm','color','k','FontSize',fontM)
    text(95,90,'Track heat map','FontSize',fontL,'FontWeight','bold');
    
     hPlfmMap(1) = axes('Position',axpt(1,4,1,1:2,axpt(nCol,nRow,5,6:7,[0.12 0.15 0.85 0.75],tightInterval),wideInterval));
     hFieldBase = pcolor(base_ratemap(30:70,50:110));
     text(45,38,[num2str(floor(peakFR2D_plfm*10)/10),' Hz'],'fontSize',fontM);
     text(33,10,'baseline','fontSize',fontM);
     
     hPlfmMap(2) = axes('Position',axpt(1,4,1,3:4,axpt(nCol,nRow,5,6:7,[0.12 0.15 0.85 0.75],tightInterval),wideInterval));
     hFieldTwo = pcolor(twohz_ratemap(30:70,50:110));
     text(45,38,[num2str(floor(peakFR2D_two*10)/10),' Hz'],'fontSize',fontM);
     text(34,10,'2hz stm','fontSize',fontM);

     set(hFieldBase,'linestyle','none');
     set(hFieldTwo,'linestyle','none');
     set(hPlfmMap,'Box','off','visible','off','XLim',[0, 75],'YLim',[0,50]);
    
% Track light response raster plot (aligned on pseudo light - light - pseudo light)
    hLight67(1) = axes('Position',axpt(1,8,1,5:6,axpt(nCol,nRow,7:10,5:7,[0.10 0.11 0.85 0.85],tightInterval),wideInterval));
        plot([xptPsdPre{1}, xptPsdStm{1}, xptPsdPost{1}],[yptPsdPre{1}, (length(psdlightPre)+yptPsdStm{1}), (sum([length(psdlightPre),length(lightTime.Track8hz)])+yptPsdPost{1})],'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');
        if ~isempty(strfind(cellDir,'DRun')) | ~isempty(strfind(cellDir,'DRw'))
            rec = rectangle('Position',[0.5 length(psdlightPre)+1, 10, length(lightTime.Track8hz)], 'LineStyle','none','FaceColor',lightDurationColor{1});
        end
        if ~isempty(strfind(cellDir,'noRun')) | ~isempty(strfind(cellDir,'noRw'))
            rec = rectangle('Position',[0.5 length(psdlightPre)+1, 10, length(lightTime.Track8hz)], 'LineStyle','none','FaceColor',lightDurationColor{2});
        end
        uistack(rec,'bottom');
        ylabel('Light trial','FontSize',fontM);
        title('Track light response (Psd-L-Psd)','FontSize',fontL,'FontWeight','bold');  
    hLight67(2) = axes('Position',axpt(1,8,1,7:8,axpt(nCol,nRow,7:10,5:7,[0.10 0.11 0.85 0.85],tightInterval),wideInterval));
        ylimpeth = ceil(max([pethPsdPreConv,pethPsdStmConv,pethPsdPostConv])*1.1+0.0001);
        hold on;
        plot(pethtimePsdPre,pethPsdPreConv,'LineStyle','-','LineWidth',lineM,'Color',colorGray);
        plot(pethtimePsdStm,pethPsdStmConv,'LineStyle','-','LineWidth',lineM,'Color',colorBlue);
        plot(pethtimePsdPost,pethPsdPostConv,'LineStyle','-','LineWidth',lineM,'Color',colorBlack);
        ylabel('Rate (Hz)','FontSize',fontM);
        xlabel('Time (ms)','FontSize',fontM);
        align_ylabel(hLight67);
    set(hLight67(1),'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontM,'XLim',[0 125],'XTick',[],'YLim',[0, sum([length(psdlightPre),length(lightTime.Track8hz),length(psdlightPost)])],'YTick',[0,length(psdlightPre),sum([length(psdlightPre),length(lightTime.Track8hz)]),sum([length(psdlightPre),length(lightTime.Track8hz),length(psdlightPost)])]);
    set(hLight67(2),'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontM,'XLim',[0,125],'XTick',[0,10,30,50,100,125],'YLim',[0, max(ylimpeth)]);
    
if ~isempty(strfind(cellDir,'DRun')) | ~isempty(strfind(cellDir,'noRun'))
    iSensor1 = 6; % Light on sensor
    lightDur = 1000; % Putative light duration
end
if ~isempty(strfind(cellDir,'DRw')) | ~isempty(strfind(cellDir,'noRw'))
    iSensor1 = 10; % Light on sensor
    lightDur = 4000; % Putative light duration
end

% Spatial raster plot
    if ~isempty(strfind(cellDir,'DRun')) | ~isempty(strfind(cellDir,'DRw')) % Light session
        hSRaster(1) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,1:4,8:9,[0.10 0.10 0.85 0.75],tightInterval),wideInterval));
        plot([xptSpatial{:}],[yptSpatial{:}],'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');
        rec = rectangle('Position',[lightLoc(1), 31, lightLoc(2)-lightLoc(1), 30], 'LineStyle','none','FaceColor',lightDurationColor{1});
        ylabel('Trial','FontSize',fontM);
        title('Spatial Raster & PETH','FontSize',fontL,'FontWeight','bold');
        hSPsth(1) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,1:4,8:9,[0.10 0.10 0.85 0.75],tightInterval),wideInterval));
        ylimpethSpatial = ceil(max(pethconvSpatial(pethconvSpatial<inf))*1.1+0.0001);
        pRw(1) = patch([rewardLoc(1)+2, rewardLoc(1)+6, rewardLoc(1)+6, rewardLoc(1)+2],[0, 0, ylimpethSpatial, ylimpethSpatial],colorLightRed);
        hold on;
        pRw(2) = patch([rewardLoc(2)+2.5, rewardLoc(2)+6.5, rewardLoc(2)+6.5, rewardLoc(2)+2.5],[0, 0, ylimpethSpatial, ylimpethSpatial],colorLightRed);
        hold on;
        for iType = 1:3
            plot(pethSpatial(1:124),pethconvSpatial(iType,:),'LineStyle','-','LineWidth',lineM,'Color',lineColor{iType})
        end
        ylabel('Rate (Hz)','FontSize',fontM);
        xlabel('Position (cm)','FontSize',fontM);
        uistack(rec,'bottom');
% Temporal raster plot
        hTRaster(1) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,7:10,8:9,[0.10 0.10 0.85 0.75],tightInterval),wideInterval));
        plot([xpt1stLPre{1},xpt1stLStm{1},xpt1stLPost{1}],[ypt1stLPre{1},30+ypt1stLStm{1},60+ypt1stLPost{1}],'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');
        rec = rectangle('Position',[0 31 lightDur 30], 'LineStyle','none','FaceColor',lightDurationColor{1});
        ylabel('Trial','FontSize',fontM);
        title(['Temporal Raster & PETH aligned on light onset'],'FontSize',fontL,'FontWeight','bold');
        hTPsth(1) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,7:10,8:9,[0.10 0.10 0.85 0.75],tightInterval),wideInterval));
        ylimpethTempo = ceil(max([pethConv1stLPre,pethConv1stLStm,pethConv1stLPost])*1.1+0.0001);
        plot(pethtime1stLStm,pethConv1stLPre,'LineStyle','-','LineWidth',lineM,'Color',lineColor{1});
        hold on;
        plot(pethtime1stLStm,pethConv1stLStm,'LineStyle','-','LineWidth',lineM,'Color',lineColor{2});
        hold on;
        plot(pethtime1stLStm,pethConv1stLPost,'LineStyle','-','LineWidth',lineM,'Color',lineColor{3});
%         plot([xpt.(fields{iSensor1}){:}],[ypt.(fields{iSensor1}){:}],'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');
%         rec = rectangle('Position',[0 31 lightDur 30], 'LineStyle','none','FaceColor',lightDurationColor{1});
%         ylabel('Trial','FontSize',fontM);
%         title(['Temporal Raster & PETH at ',fields{iSensor1}],'FontSize',fontL,'FontWeight','bold');
%         hTPsth(1) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,7:10,8:9,[0.10 0.10 0.85 0.75],tightInterval),wideInterval));
%         ylimpeth1 = ceil(max(pethconv.(fields{iSensor1})(:))*1.1+0.0001);
%         hold on;
%         for iType = 1:3
%             plot(pethtime.(fields{iSensor1}),pethconv.(fields{iSensor1})(iType,:),'LineStyle','-','LineWidth',lineM,'Color',lineColor{iType})
%         end
        ylabel('Rate (Hz)','FontSize',fontM);
        xlabel('Time (ms)','FontSize',fontM);
        uistack(rec,'bottom');
    end

    if ~isempty(strfind(cellDir,'noRun')) | ~isempty(strfind(cellDir,'noRw')) % No light session
% Spatial rastser plot
        hSRaster(1) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,1:4,8:9,[0.1 0.10 0.85 0.75],wideInterval),wideInterval));
        hold on;
        plot([xptSpatial{:}],[yptSpatial{:}],'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');
        rec = rectangle('Position',[lightLoc(1), 31, lightLoc(2)-lightLoc(1), 30], 'LineStyle','none','FaceColor',lightDurationColor{2});
        ylabel('Trial','FontSize',fontM);
        title('Spatial Raster & PETH','FontSize',fontL,'FontWeight','bold');
        hSPsth(1) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,1:4,8:9,[0.10 0.10 0.85 0.75],tightInterval),wideInterval));
        ylimpethSpatial = ceil(max(pethconvSpatial(pethconvSpatial<inf))*1.1+0.0001);
        pRw(1) = patch([rewardLoc(1)+2, rewardLoc(1)+6, rewardLoc(1)+6, rewardLoc(1)+2],[0, 0, ylimpethSpatial, ylimpethSpatial],colorLightRed);
        hold on;
        pRw(2) = patch([rewardLoc(2)+2.5, rewardLoc(2)+6.5, rewardLoc(2)+6.5, rewardLoc(2)+2.5],[0, 0, ylimpethSpatial, ylimpethSpatial],colorLightRed);
        hold on;
        for iType = 1:3
            plot(pethSpatial(1:124),pethconvSpatial(iType,:),'LineStyle','-','LineWidth',lineM,'Color',lineColor{iType})
        end
        ylabel('Rate (Hz)','FontSize',fontM);
        xlabel('Position (cm)','FontSize',fontM);
        uistack(rec,'bottom');  
% Temporal raster plot
        hTRaster(1) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,7:10,8:9,[0.1 0.10 0.85 0.75],wideInterval),wideInterval));
        plot([xpt1stLPre{1},xpt1stLStm{1},xpt1stLPost{1}],[ypt1stLPre{1},30+ypt1stLStm{1},60+ypt1stLPost{1}],'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');
        rec = rectangle('Position',[0 31 lightDur 30], 'LineStyle','none','FaceColor',lightDurationColor{2});
        ylabel('Trial','FontSize',fontM);
        title(['Temporal Raster & PETH aligned on light onset'],'FontSize',fontL,'FontWeight','bold');
        hTPsth(1) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,7:10,8:9,[0.10 0.10 0.85 0.75],tightInterval),wideInterval));
        ylimpethTempo = ceil(max([pethConv1stLPre,pethConv1stLStm,pethConv1stLPost])*1.1+0.0001);
        plot(pethtime1stLStm,pethConv1stLPre,'LineStyle','-','LineWidth',lineM,'Color',lineColor{1});
        hold on;
        plot(pethtime1stLStm,pethConv1stLStm,'LineStyle','-','LineWidth',lineM,'Color',lineColor{2});
        hold on;
        plot(pethtime1stLStm,pethConv1stLPost,'LineStyle','-','LineWidth',lineM,'Color',lineColor{3});
%         plot([xpt.(fields{iSensor1}){:}],[ypt.(fields{iSensor1}){:}],'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');
%         rec = rectangle('Position',[0 31 lightDur 30], 'LineStyle','none','FaceColor',lightDurationColor{2});
%         ylabel('Trial','FontSize',fontM);
%         title(['Temporal Raster & PETH at ',fields{iSensor1}],'FontSize',fontM,'FontWeight','bold');
%         hTPsth(1) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,7:10,8:9,[0.1 0.10 0.85 0.75],tightInterval),wideInterval));
%         ylimpeth1 = ceil(max(pethconv.(fields{iSensor1})(:))*1.1+0.0001);
%         hold on;
%         for iType = 1:3
%             plot(pethtime.(fields{iSensor1}),pethconv.(fields{iSensor1})(iType,:),'LineStyle','-','LineWidth',lineM,'Color',lineColor{iType})
%         end
        ylabel('Rate (Hz)','FontSize',fontM);
        xlabel('Time (ms)','FontSize',fontM);
        uistack(rec,'bottom');
    end
    align_ylabel([hSRaster,hSPsth]);
    align_ylabel([hTRaster,hTPsth]);
    set(hSRaster,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontM,'XLim',[0 124],'XTick',[],'YLim',[0, 90],'YTick',0:30:90);
    set(hTRaster,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontM,'XLim',[-1000 5000],'XTick',[],'YLim',[0, 90],'YTick',0:30:90);
    set(hSPsth,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontM,'XLim',[0, 124],'XTick',[0:10:120],'YLim',[0, ylimpethSpatial],'YTick',[0,ylimpethSpatial]);
    set(hTPsth,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontM,'XLim',[-1000, 5000],'XTick',[-5000:1000:5000],'YLim',[0, ylimpethTempo],'YTick',[0,ylimpethTempo]);
    set(pRw,'LineStyle','none','FaceAlpha',0.2);
    
    hLine = axes('Position',axpt(1,2,1,1:2,axpt(nCol,nRow,5:6,8,[0.1 0.10 0.85 0.75],tightInterval),wideInterval));
        text(0.2,1.00,'-: Pre','FontSize',fontL,'Color',colorGray,'fontWeight','Bold');    
        text(0.2,0.75,'-: Stm','FontSize',fontL,'Color',colorBlue,'fontWeight','Bold');
        text(0.2,0.50,'-: Post','FontSize',fontL,'Color',colorBlack,'fontWeight','Bold');
        text(0.1,0.25,' : Reward','FontSize',fontL,'Color',colorLightRed,'fontWeight','Bold');
    set(hLine,'Box','off','visible','off');
    
%%
% Track light response raster plot (aligned on pseudo light - light - pseudo light)
if ~isempty(strfind(cellDir,'DRun'))
    hLight67(1) = axes('Position',axpt(3,2,1,1,axpt(nCol,nRow,1:10,10:11,[0.1 0.05 0.85 0.80],midInterval),midInterval));
        plot([xptPsdPre67{1}, xptLight67{1}, xptPsdPost67{1}],[yptPsdPre67{1}, (length(psdPrelight67)+yptLight67{1}), (sum([length(psdPrelight67),length(light67)])+yptPsdPost67{1})],'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');
        if ~isempty(strfind(cellDir,'DRun')) | ~isempty(strfind(cellDir,'DRw'))
            rec = rectangle('Position',[0.5 length(psdPrelight67)+1, 10, length(light67)], 'LineStyle','none','FaceColor',lightDurationColor{1});
        end
        uistack(rec,'bottom');
        ylabel('Light trial','FontSize',fontM);
        title('Track light response (Sensor6-7)','FontSize',fontL,'FontWeight','bold');
        set(hLight67(1),'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontM,'XLim',[-25 100],'XTick',[],'YLim',[0, sum([length(psdPrelight67),length(light67),length(psdPostlight67)])],'YTick',[0,length(psdPrelight67),sum([length(psdPrelight67),length(light67)]),sum([length(psdPrelight67),length(light67),length(psdPostlight67)])]);
%     hLight67(2) = axes('Position',axpt(3,2,1,2,axpt(nCol,nRow,1:10,10:11,[0.1 0.05 0.85 0.80],midInterval),midInterval));
%         ylimpeth = ceil(max([pethPsdPre67Conv,pethLight67Conv,pethPsdPost67Conv])*1.1+0.0001);
%         hold on;
%         plot(pethtimePsdPre67,pethPsdPre67Conv,'LineStyle','-','LineWidth',lineM,'Color',colorGray);
%         plot(pethtimeLight67,pethLight67Conv,'LineStyle','-','LineWidth',lineM,'Color',colorBlue);
%         plot(pethtimePsdPost67,pethPsdPost67Conv,'LineStyle','-','LineWidth',lineM,'Color',colorBlack);
%         ylabel('Rate (Hz)','FontSize',fontM);
%         xlabel('Time (ms)','FontSize',fontM);
%         align_ylabel(hLight67);
    set(hLight67(2),'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontM,'XLim',[-25 100],'XTick',[-25,0,10,30,50,100,125],'YLim',[0, max(ylimpeth)]);
    hLight67(2) = axes('Position',axpt(3,2,1,2,axpt(nCol,nRow,1:10,10:11,[0.1 0.05 0.85 0.80],midInterval),midInterval));
        yLimBarBlue = ceil(max([pethPsdPre67(:); pethLight67(:); pethPsdPost67(:)])*1.05+0.0001);
        bar(5, 1000, 'BarWidth', 10, 'LineStyle','none', 'FaceColor', colorLLightBlue);
        rectangle('Position', [0 yLimBarBlue*0.925, 10, yLimBarBlue*0.075], 'LineStyle', 'none', 'FaceColor', colorBlue);
        hBar(1) = bar(pethtimePsdPre67, pethPsdPre67,'histc');
        hold on;
        hBar(2) = bar(pethtimeLight67, pethLight67,'histc');
        hold on;
        hBar(3) = bar(pethtimePsdPost67, pethPsdPost67,'histc');
        set(hBar(1),'faceColor',colorDarkGray,'edgeColor','none');
        set(hBar(2),'faceColor',colorBlue,'edgeColor','none');
        set(hBar(3),'faceCOlor',colorBlack,'edgeColor','none');
        xlabel('Time (ms)','FontSize',fontM);
    set(hLight67(2), 'XLim', winBlue, 'XTick', [winBlue(1) 0 winBlue(2)],'XTickLabel',{winBlue(1);0;num2str(winBlue(2))},'YLim', [0 yLimBarBlue], 'YTick', [0 yLimBarBlue], 'YTickLabel', {[], yLimBarBlue});
    set(hLight67,'Box','off','TickDir','out','fontSize',fontM);

    hLight78(1) = axes('Position',axpt(3,2,2,1,axpt(nCol,nRow,1:10,10:11,[0.1 0.05 0.85 0.80],midInterval),midInterval));
        plot([xptPsdPre78{1}, xptLight78{1}, xptPsdPost78{1}],[yptPsdPre78{1}, (length(psdPrelight78)+yptLight78{1}), (sum([length(psdPrelight78),length(light78)])+yptPsdPost78{1})],'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');
        if ~isempty(strfind(cellDir,'DRun')) | ~isempty(strfind(cellDir,'DRw'))
            rec = rectangle('Position',[0.5 length(psdPrelight78)+1, 10, length(light78)], 'LineStyle','none','FaceColor',lightDurationColor{1});
        end
        uistack(rec,'bottom');
        ylabel('Light trial','FontSize',fontM);
        title('Track light response (Sensor7-8)','FontSize',fontL,'FontWeight','bold');
        set(hLight78(1),'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontM,'XLim',[-25 100],'XTick',[],'YLim',[0, sum([length(psdPrelight78),length(light78),length(psdPostlight78)])],'YTick',[0,length(psdPrelight78),sum([length(psdPrelight78),length(light78)]),sum([length(psdPrelight78),length(light78),length(psdPostlight78)])]);
%     hLight78(2) = axes('Position',axpt(3,2,2,2,axpt(nCol,nRow,1:10,10:11,[0.1 0.05 0.85 0.80],midInterval),midInterval));
%         ylimpeth = ceil(max([pethPsdPre78Conv,pethLight78Conv,pethPsdPost78Conv])*1.1+0.0001);
%         hold on;
%         plot(pethtimePsdPre78,pethPsdPre78Conv,'LineStyle','-','LineWidth',lineM,'Color',colorGray);
%         plot(pethtimeLight78,pethLight78Conv,'LineStyle','-','LineWidth',lineM,'Color',colorBlue);
%         plot(pethtimePsdPost78,pethPsdPost78Conv,'LineStyle','-','LineWidth',lineM,'Color',colorBlack);
%         ylabel('Rate (Hz)','FontSize',fontM);
%         xlabel('Time (ms)','FontSize',fontM);
%         align_ylabel(hLight78);
%     set(hLight78(2),'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontM,'XLim',[-25 100],'XTick',[-25,0,10,30,50,100,125],'YLim',[0, max(ylimpeth)]);
    hLight78(2) = axes('Position',axpt(3,2,2,2,axpt(nCol,nRow,1:10,10:11,[0.1 0.05 0.85 0.80],midInterval),midInterval));
        yLimBarBlue = ceil(max([pethPsdPre78(:); pethLight78(:); pethPsdPost78(:)])*1.05+0.0001);
        bar(5, 1000, 'BarWidth', 10, 'LineStyle','none', 'FaceColor', colorLLightBlue);
        rectangle('Position', [0 yLimBarBlue*0.925, 10, yLimBarBlue*0.075], 'LineStyle', 'none', 'FaceColor', colorBlue);
        hBar(1) = bar(pethtimePsdPre78, pethPsdPre78,'histc');
        hold on;
        hBar(2) = bar(pethtimeLight78, pethLight78,'histc');
        hold on;
        hBar(3) = bar(pethtimePsdPost78, pethPsdPost78,'histc');
        set(hBar(1),'faceColor',colorDarkGray,'edgeColor','none');
        set(hBar(2),'faceColor',colorBlue,'edgeColor','none');
        set(hBar(3),'faceColor',colorBlack,'edgeColor','none');
    set(hLight78(2), 'XLim', winBlue, 'XTick', [winBlue(1) 0 winBlue(2)],'XTickLabel',{winBlue(1);0;num2str(winBlue(2))},'YLim', [0 yLimBarBlue], 'YTick', [0 yLimBarBlue], 'YTickLabel', {[], yLimBarBlue});
    set(hLight78,'Box','off','TickDir','out','fontSize',fontM);
        xlabel('Time (ms)','FontSize',fontM);
    
    hLight89(1) = axes('Position',axpt(3,2,3,1,axpt(nCol,nRow,1:10,10:11,[0.1 0.05 0.85 0.80],midInterval),midInterval));
        plot([xptPsdPre89{1}, xptLight89{1}, xptPsdPost89{1}],[yptPsdPre89{1}, (length(psdPrelight89)+yptLight89{1}), (sum([length(psdPrelight89),length(light89)])+yptPsdPost89{1})],'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');
        if ~isempty(strfind(cellDir,'DRun')) | ~isempty(strfind(cellDir,'DRw'))
            rec = rectangle('Position',[0.5 length(psdPrelight89)+1, 10, length(light89)], 'LineStyle','none','FaceColor',lightDurationColor{1});
        end
        uistack(rec,'bottom');
        ylabel('Light trial','FontSize',fontM);
        title('Track light response (Sensor8-9)','FontSize',fontL,'FontWeight','bold');
    set(hLight89(1),'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontM,'XLim',[-25,100],'XTick',[],'YLim',[0, sum([length(psdPrelight89),length(light89),length(psdPostlight89)])],'YTick',[0,length(psdPrelight89),sum([length(psdPrelight89),length(light89)]),sum([length(psdPrelight89),length(light89),length(psdPostlight89)])]);
%     hLight89(2) = axes('Position',axpt(3,2,3,2,axpt(nCol,nRow,1:10,10:11,[0.1 0.05 0.85 0.80],midInterval),midInterval));
%         ylimpeth = ceil(max([pethPsdPre89Conv,pethLight89Conv,pethPsdPost89Conv])*1.1+0.0001);
%         hold on;
%         plot(pethtimePsdPre89,pethPsdPre89Conv,'LineStyle','-','LineWidth',lineM,'Color',colorGray);
%         plot(pethtimeLight89,pethLight89Conv,'LineStyle','-','LineWidth',lineM,'Color',colorBlue);
%         plot(pethtimePsdPost89,pethPsdPost89Conv,'LineStyle','-','LineWidth',lineM,'Color',colorBlack);
%         ylabel('Rate (Hz)','FontSize',fontM);
%         xlabel('Time (ms)','FontSize',fontM);
%         align_ylabel(hLight89);
%     set(hLight89(2),'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontM,'XLim',[-25,100],'XTick',[-25,0,10,30,50,100,125],'YLim',[0, max(ylimpeth)]);
    hLight89(2) = axes('Position',axpt(3,2,3,2,axpt(nCol,nRow,1:10,10:11,[0.1 0.05 0.85 0.80],midInterval),midInterval));
        yLimBarBlue = ceil(max([pethPsdPre89(:); pethLight89(:); pethPsdPost89(:)])*1.05+0.0001);
        bar(5, 1000, 'BarWidth', 10, 'LineStyle','none', 'FaceColor', colorLLightBlue);
        rectangle('Position', [0 yLimBarBlue*0.925, 10, yLimBarBlue*0.075], 'LineStyle', 'none', 'FaceColor', colorBlue);
        hBar(1) = bar(pethtimePsdPre89, pethPsdPre89,'histc');
        hold on;
        hBar(2) = bar(pethtimeLight89, pethLight89,'histc');
        hold on;
        hBar(3) = bar(pethtimePsdPost89, pethPsdPost89,'histc');
        set(hBar(1),'faceColor',colorDarkGray,'edgeColor','none');
        set(hBar(2),'faceColor',colorBlue,'edgeColor','none');
        set(hBar(3),'faceColor',colorBlack,'edgeColor','none');
        xlabel('Time (ms)','FontSize',fontM);
    set(hLight89(2), 'XLim', winBlue, 'XTick', [winBlue(1) 0 winBlue(2)],'XTickLabel',{winBlue(1);0;num2str(winBlue(2))},'YLim', [0 yLimBarBlue], 'YTick', [0 yLimBarBlue], 'YTickLabel', {[], yLimBarBlue});
    set(hLight89,'Box','off','TickDir','out','fontSize',fontM);
end

% Cell ID
    hID = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,10,1,[0.11 0.18 0.80 0.80],tightInterval),wideInterval));
    text(0.5, 1, ['Cell ID: ',num2str(cellID(iFile))],'FontSize',fontL,'fontWeight','bold');
    set(hID,'visible','off');
    
    cd(saveDir);
    print('-painters','-r300',['cellID_',num2str(cellID(iFile)),'.tif'],'-dtiff');
%     print('-painters','-r300',[cellFigName{1},'_cellID_',num2str(cellID(iFile)),'.tif'],'-dtiff');
%     print('-painters','-r300',[cellFigName{1},'.ai'],'-depsc');
    close;
end
% fclose('all');
end