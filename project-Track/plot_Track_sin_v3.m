function plot_Track_sin_v3
% Draw & Save figures about track project
% TT*.mat files in the each folders will be loaded and plotted
% Author: Joonyeup Lee
% Version 3.0 (12/14/2016)

% Plot properties
lineColor = {[144, 164, 174]./255,... % Before stimulation
    [33 150 243]./ 255,... % During stimulation
    [38, 50, 56]./255}; % After stimulation

lineWth = [1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75];
fontS = 4; fontM = 5; fontL = 7; % font size large
lineS = 0.2; lineM = 0.5; lineL = 1; % line width large

colorBlue = [33 150 243] ./ 255;
colorLightBlue = [100 181 246] ./ 255;
colorLLightBlue = [187, 222, 251]./255;
colorRed = [237 50 52] ./ 255;
colorLightRed = [242 138 130] ./ 255;
colorGray = [189 189 189] ./ 255;
colorLightGray = [238, 238, 238] ./255;
colorDarkGray = [117, 117, 117] ./255;
colorYellow = [255 243 3] ./ 255;
colorLightYellow = [255 249 196] ./ 255;
colorBlack = [0, 0, 0];

markerS = 2.2; markerM = 4.4; markerL = 6.6; markerXL = 8.8;
tightInterval = [0.02 0.02]; wideInterval = [0.07 0.07];
width = 0.7;

paperSizeX = [18.3, 8.00];
matFile = mLoad;
nFile = length(matFile);

for iFile = 1:nFile
    [cellDir, cellName, ~] = fileparts(matFile{iFile});
    cellDirSplit = regexp(cellDir,'\','split');
    cellFigName = strcat(cellDirSplit(end-1),'_',cellDirSplit(end),'_',cellName);
    sfreq = [30 60];
    
    % Arc property
    if ~isempty(strfind(cellDir,'DRun'));
        arc = linspace(pi,pi/2*3,170); % s6-s9
    else ~isempty(strfind(cellDir,'DRw'));
        arc = linspace(pi/6*5, pi/6*4,170);
    end
    
    cd(cellDir);
    load(matFile{iFile});
    load('Events.mat');
    
% Cell information
    fHandle = figure('PaperUnits','centimeters','PaperPosition',[0 0 paperSizeX(2) 13.725]);
    if paperSizeX == 8.00
        nCol = 20;
        nRow = 11;
    else
        nCol = 10;
        nRow = 11;
    end
    hText = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,0:4,1:2,[0.12 0.1 0.85 0.89],tightInterval),wideInterval));
    hold on;
    text(0,0.9,matFile{iFile}, 'FontSize',fontM, 'Interpreter','none','FontWeight','bold');
    text(0,0.7,['Mean firing rate (baseline): ',num2str(meanFR_base,3), ' Hz'], 'FontSize',fontM);
    text(0,0.55,['Mean firing rate (task): ',num2str(meanFR_task,3), ' Hz'], 'FontSize',fontM);
    text(0,0.4,['Spike width: ',num2str(spkwth,3),' us'], 'FontSize',fontM);
    text(0,0.25,['Half-valley width: ',num2str(hfvwth,3),' us'], 'FontSize',fontM);
    text(0,0.1,['Peak valley ratio: ',num2str(spkpvr,3)], 'FontSize',fontM);
    set(hText,'Visible','off');
    
% Waveform
    yLimWaveform = [min(spkwv(:)), max(spkwv(:))];
    for iCh = 1:4
        hWaveform(iCh) = axes('Position',axpt(4,1,iCh,1,axpt(nCol,nRow,4:6,2,[0.07 0.1 0.85 0.90],tightInterval),wideInterval));
        plot(spkwv(iCh,:), 'LineWidth', lineL, 'Color','k');
        if iCh == 4
            line([24 32], [yLimWaveform(2)-50 yLimWaveform(2)-50], 'Color','k', 'LineWidth', lineM);
            line([24 24],[yLimWaveform(2)-50 yLimWaveform(2)], 'Color','k', 'LineWidth',lineM);
        end
    end
    set(hWaveform, 'Visible', 'off','XLim',[1 32], 'YLim',yLimWaveform*1.05);
    
% Platform light intensity plot
    yLimlightBase = max([lightPlfmSpk5mw; lightPlfmSpk8mw; lightPlfmSpk10mw])*1.1;
    if yLimlightBase < 10
        yLimlightBase = 20;
    end
    hIntensity = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,8:9,2,[0.07 0.07 0.90 0.95],tightInterval),wideInterval));
    hold on;
    plot([1,2,3],[lightPlfmSpk5mw,lightPlfmSpk8mw,lightPlfmSpk10mw],'-o','Color',colorGray,'MarkerFaceColor',colorBlue,'MarkerEdgeColor','k','MarkerSize',markerM);
    hold on;
    ylabel('Spike counts','FontSize',fontM);
    xlabel('Power (mW)','FontSize',fontM);
    title('Platform laser intensity','FontSize',fontM,'FontWeight','bold');
    set(hIntensity,'XLim',[0,4],'YLim',[-10,yLimlightBase],'Box','off','TickDir','out','XTick',[1:3],'XTickLabel',{'5','8','10'},'FontSize',fontM);
    
% Response check: Platform
      % Activation or Inactivation?
    if isfield(lightTime,'Plfm2hz') && exist('xptPlfm2hz','var');
        lightDuration = 10;
        lightDurationColor = {colorLLightBlue, colorLightGray};
        testRangeChETA = 10; % ChETA light response test range (ex. 10ms)       
    end
    if isfield(lightTime,'Plfm2hz') && exist('xptPlfm2hz','var') && ~isempty(xptPlfm2hz)
        nBlue = length(lightTime.Plfm2hz);
        winBlue = [min(pethtimePlfm2hz) max(pethtimePlfm2hz)];
    % Raster
        hTagBlue(1) = axes('Position',axpt(1,8,1,1:2,axpt(nCol,nRow,1:4,4:6,[0.1 0.12 0.9 0.92],tightInterval),wideInterval));
        plot(xptPlfm2hz{1},yptPlfm2hz{1},'LineStyle','none','Marker','.','MarkerSize',markerS,'Color','k');
        set(hTagBlue(1),'XLim',winBlue,'XTick',[],'YLim',[0 nBlue], 'YTick', [0 nBlue], 'YTickLabel', {0, nBlue});
        ylabel('Trials','FontSize',fontS);
        title('Platform light response (2Hz)','FontSize',fontM,'FontWeight','bold');
    % Psth
        hTagBlue(2) = axes('Position',axpt(1,8,1,3:4,axpt(nCol,nRow,1:4,4:6,[0.1 0.12 0.9 0.92],tightInterval),wideInterval));
        hold on;
        yLimBarBlue = ceil(max(pethPlfm2hz(:))*1.05+0.0001);
        bar(5, 1000, 'BarWidth', 10, 'LineStyle','none', 'FaceColor', colorLLightBlue);
        rectangle('Position', [0 yLimBarBlue*0.925, 10, yLimBarBlue*0.075], 'LineStyle', 'none', 'FaceColor', colorBlue);
        hBarBlue = bar(pethtimePlfm2hz, pethPlfm2hz, 'histc');
        if statDir_Plfm2hz == 1
            text(sum(winBlue)*0.3,yLimBarBlue*0.9,['latency = ', num2str(latencyPlfm2hz,3)],'FontSize',fontS,'interpreter','none');
        else
        end
        %         text(sum(winBlue)*0.85,yLimBarBlue*0.9,['p_lat = ',num2str(pLatencyPlfm,3)],'FontSize',fontS,'interpreter','none');
        set(hBarBlue, 'FaceColor','k', 'EdgeAlpha',0);
        set(hTagBlue(2), 'XLim', winBlue, 'XTick', [winBlue(1) 0 winBlue(2)],'XTickLabel',{winBlue(1);0;num2str(winBlue(2))},...
            'YLim', [0 yLimBarBlue], 'YTick', [0 yLimBarBlue], 'YTickLabel', {[], yLimBarBlue});
        xlabel('Time (ms)','FontSize',fontS);
        ylabel('Rate (Hz)', 'FontSize', fontS);
    % Hazard function
        hTagBlue(3) = axes('Position',axpt(1,8,1,7:8,axpt(nCol,nRow,1:2,4:6,[0.1 0.13 0.9 0.92],tightInterval),wideInterval));
        hold on;
        ylimH = min([ceil(max([H1_Plfm2hz;H2_Plfm2hz])*1100+0.0001)/1000 1]);
        winHTag = [0 testRangeChETA];
        stairs(timeLR_Plfm2hz, H2_Plfm2hz, 'LineStyle',':','LineWidth',lineL,'Color','k');
        stairs(timeLR_Plfm2hz, H1_Plfm2hz,'LineStyle','-','LineWidth',lineL,'Color',colorBlue);
        text(diff(winHTag)*0.1,ylimH*0.9,['p = ',num2str(pLR_Plfm2hz,3)],'FontSize',fontS,'Interpreter','none');
        text(diff(winHTag)*0.1,ylimH*0.7,['calib: ',num2str(calibPlfm2hz,3),' ms'],'FontSize',fontS,'Interpreter','none');
        set(hTagBlue(3),'XLim',winHTag,'XTick',winHTag,'YLim',[0 ylimH], 'YTick', [0 ylimH], 'YTickLabel', {[], ylimH});
        xlabel('Time (ms)','FontSize',fontS);
        ylabel('H(t)','FontSize',fontS);
        title('Log-rank test (Platform)','FontSize',fontM,'FontWeight','bold');
        set(hTagBlue,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS);
        align_ylabel(hTagBlue)
    end
    
    % Response check: Track
    if isfield(lightTime,'Track8hz') && exist('xptTrackLight','var') && ~isempty(xptTrackLight)
        nBlue = length(lightTime.Track8hz);
        winBlue = [min(pethtimeTrackLight) max(pethtimeTrackLight)];
    % Raster
        hModuBlue(1) = axes('Position',axpt(1,8,1,1:2,axpt(nCol,nRow,6:9,4:6,[0.1 0.12 0.9 0.92],tightInterval),wideInterval));
        plot(xptTrackLight{1},yptTrackLight{1},'LineStyle','none','Marker','.','MarkerSize',markerS,'Color','k');
        set(hModuBlue(1),'XLim',winBlue,'XTick',[],'YLim',[0 nBlue], 'YTick', [0 nBlue], 'YTickLabel', {0, nBlue});
        ylabel('Trials','FontSize',fontS);
        title('Track light response (8Hz)','FontSize',fontM,'FontWeight','bold');    
    % Psth
        hModuBlue(2) = axes('Position',axpt(1,8,1,3:4,axpt(nCol,nRow,6:9,4:6,[0.1 0.12 0.9 0.92],tightInterval),wideInterval));
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
            text(sum(winBlue)*0.3,yLimBarBlue*0.9,['latency = ', num2str(latencyTrack,3)],'FontSize',fontS,'interpreter','none');
%         text(sum(winBlue)*0.85,yLimBarBlue*0.9,['p_lat = ',num2str(pLatencyModu_first,3)],'FontSize',fontS,'interpreter','none');
        else
        end
        set(hBarBlue, 'FaceColor','k', 'EdgeAlpha',0);
        set(hModuBlue(2), 'XLim', winBlue, 'XTick', [winBlue(1), 0, winBlue(2)],'XTickLabel',{winBlue(1);0;num2str(winBlue(2))},...
            'YLim', [0 yLimBarBlue], 'YTick', [0 yLimBarBlue], 'YTickLabel', {[], yLimBarBlue});
        ylabel('Rate (Hz)','FontSize',fontS);
        xlabel('Time (ms)','FontSize',fontS);
    % Hazard function    
        hModuBlue(3) = axes('Position',axpt(1,8,1,7:8,axpt(nCol,nRow,4:5,4:6,[0.07 0.13 0.9 0.92],tightInterval),wideInterval));
        hold on;
        ylimH = min([ceil(max([H1_Track;H2_Track])*1100+0.0001)/1000 1]);
        winHModu = [0 testRangeChETA];
        stairs(timeLR_Track, H2_Track, 'LineStyle',':','LineWidth',lineL,'Color','k');
        stairs(timeLR_Track, H1_Track,'LineStyle','-','LineWidth',lineL,'Color',colorBlue);
        text(diff(winHModu)*0.1,ylimH*0.9,['p = ',num2str(pLR_Track,3)],'FontSize',fontS,'Interpreter','none');
        text(diff(winHModu)*0.1,ylimH*0.7,['calib: ',num2str(calibTrack,3),' ms'],'FontSize',fontS,'Interpreter','none');
        xlabel('Time (ms)','FontSize',fontS);
%         ylabel('H(t)','FontSize',fontS);
        title('Log-rank test (Track)','FontSize',fontM,'FontWeight','bold');
        set(hModuBlue(3),'XLim',winHModu,'XTick',winHModu,'XTickLabel',{winHModu(1);num2str(winHModu(2))},'YLim',[0 ylimH], 'YTick', [0 ylimH], 'YTickLabel', {[], ylimH});
        set(hModuBlue,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS);
        align_ylabel(hModuBlue)     
    end
        
    % Heat map
    pre_ratemap(pre_ratemap==0) = NaN;
    peak_pre = max(max(pre_ratemap))*sfreq(1);
    stm_ratemap(stm_ratemap==0) = NaN;
    peak_stm = max(max(stm_ratemap))*sfreq(1);
    post_ratemap(post_ratemap==0) = NaN;
    peak_post = max(max(post_ratemap))*sfreq(1);
    
    totalmap = [pre_ratemap(1:45,23:67),stm_ratemap(1:45,23:67),post_ratemap(1:45,23:67)];
    hMap = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,0:5,7:8,[0.12 0.17 0.80 0.75]),wideInterval));
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
        arc_r = 20;
        x = arc_r*cos(arc)+67;
        y = arc_r*sin(arc)+23;
        if exist('xptTrackLight','var') & (~isempty(strfind(cellDir,'DRw')) | ~isempty(strfind(cellDir,'DRun')));
            plot(x,y,'LineWidth',4,'color',colorBlue);
        elseif exist('xptTrackLight','var') & (~isempty(strfind(cellDir,'noRw')) | ~isempty(strfind(cellDir,'noRun')));
            plot(x,y,'LineWidth',4,'color',colorGray);                
        else exist('xptModuYel','var');
            plot(x,y,'LineWidth',4,'color',colorYellow);
        end
    else
    end;
    set(hField,'linestyle','none');
    set(hMap,'XLim',[0,135],'YLim',[0,45],'visible','off');
    text(125,40,[num2str(ceil(max(max(totalmap*sfreq(1))))), ' Hz'],'color','k','FontSize',fontM)
    text(14,0,'Pre-stm','color','k','FontSize',fontM);
    text(62,0,'Stm','color','k','FontSize',fontM)
    text(104,0,'Post-stm','color','k','FontSize',fontM)
    text(44,45,'Track heat map','FontSize',fontM,'FontWeight','bold');
    
% Track light response raster plot (aligned on pseudo light - light - pseudo light)
    hTrackLightRaster = axes('Position',axpt(1,8,1,5:6,axpt(nCol,nRow,7:9,4:7,[0.1 0.180 0.9 0.80],tightInterval),wideInterval));
        plot([xptPsdPre{1}, xptTrackLight{1}, xptPsdPost{1}],[yptPsdPre{1}, (length(psdlightPre)+yptTrackLight{1}), (sum([length(psdlightPre),length(lightTime.Track8hz)])+yptPsdPost{1})],'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');
        if ~isempty(strfind(cellDir,'DRun')) | ~isempty(strfind(cellDir,'DRw'))
            rec = rectangle('Position',[0.5 length(psdlightPre)+1, 10, length(lightTime.Track8hz)], 'LineStyle','none','FaceColor',lightDurationColor{1});
        end
        if ~isempty(strfind(cellDir,'noRun')) | ~isempty(strfind(cellDir,'noRw'))
            rec = rectangle('Position',[0.5 length(psdlightPre)+1, 10, length(lightTime.Track8hz)], 'LineStyle','none','FaceColor',lightDurationColor{2});
        end
        if pLR_Track_pre < 0.005
            text(105, sum([length(psdlightPre),length(lightTime.Track8hz),length(psdlightPost)])/8, '*','Color',colorRed,'fontSize',fontL);
        end
        if pLR_Track < 0.005
            text(105, sum([length(psdlightPre),length(lightTime.Track8hz),length(psdlightPost)])*3/8, '*','Color',colorRed,'fontSize',fontL);
        end
        if pLR_Track_post < 0.005
            text(105, sum([length(psdlightPre),length(lightTime.Track8hz),length(psdlightPost)])*6/8, '*','Color',colorRed,'fontSize',fontL);
        end
        uistack(rec,'bottom');
        ylabel('Light trial','FontSize',fontS);
        title('Track light response (Psd-L-Psd)','FontSize',fontM,'FontWeight','bold');
   
    hTrackLightPsth = axes('Position',axpt(1,8,1,7:8,axpt(nCol,nRow,7:9,4:7,[0.1 0.19 0.9 0.80],tightInterval),wideInterval));
        ylimpeth = ceil(max([pethPsdPreConv,pethTrackLightConv,pethPsdPostConv])*1.1+0.0001);
        hold on;
        plot(pethtimePsdPre,pethPsdPreConv,'LineStyle','-','LineWidth',lineM,'Color',colorGray);
        plot(pethtimeTrackLight,pethTrackLightConv,'LineStyle','-','LineWidth',lineM,'Color',colorBlue);
        plot(pethtimePsdPost,pethPsdPostConv,'LineStyle','-','LineWidth',lineM,'Color',colorBlack);
        ylabel('Rate (Hz)','FontSize',fontS);
    set(hTrackLightRaster,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS,'XLim',[-25 100],'XTick',[],'YLim',[0, sum([length(psdlightPre),length(lightTime.Track8hz),length(psdlightPost)])],'YTick',[0,length(psdlightPre),sum([length(psdlightPre),length(lightTime.Track8hz)]),sum([length(psdlightPre),length(lightTime.Track8hz),length(psdlightPost)])]);
    set(hTrackLightPsth,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS,'XLim',[-25, 100],'XTick',[-25,0,10,30,50,100],'YLim',[0, max(ylimpeth)]);

% Spectrogram (aligned on sensor onset)
    load(['CSC','.mat']);
    if ~isempty(strfind(cellDir,'DRun')) | ~isempty(strfind(cellDir,'noRun'))
        iSensor = 6;
    end
    if ~isempty(strfind(cellDir,'DRw')) | ~isempty(strfind(cellDir,'noRw'))
        iSensor = 10;
    end
    hSpectro(1) = axes('Position',axpt(9,6,1:2,1:3,axpt(nCol,nRow,1:5,8:10,[0.08 0.05 0.90 0.83],tightInterval),wideInterval));
        hSpec(1) = pcolor(timeSensor,freqSensor,psdSensor_pre);
        text(0.6, 55,'Pre-','fontSize',fontM,'Color',[1,1,1,])
        ylabel('Frequency (Hz)','fontSize',fontS);
    hSpectro(2) = axes('Position',axpt(9,6,3:4,1:3,axpt(nCol,nRow,1:5,8:10,[0.08 0.05 0.90 0.83],tightInterval),wideInterval));
        hSpec(2) = pcolor(timeSensor,freqSensor,psdSensor_stm);
        text(0.7, 55,'Stm','fontSize',fontM,'Color',[1,1,1,])
        title(['Spectrogram aligned on sensor: ',num2str(iSensor)],'fontSize',fontM,'FontWeight','bold');
    hSpectro(3) = axes('Position',axpt(9,6,5:6,1:3,axpt(nCol,nRow,1:5,8:10,[0.08 0.05 0.90 0.83],tightInterval),wideInterval));
        hSpec(3) = pcolor(timeSensor,freqSensor,psdSensor_post);
        text(0.5, 55,'Post-','fontSize',fontM,'Color',[1,1,1,])
        cBar = colorbar;
    set(hSpec,'EdgeColor','none');
    set(hSpectro(1:3),'Box','off','TickDir','out','YLim',[0,60],'YTick',[],'XLim',[0.25,1.75],'XTick',1,'XTickLabel',{'0'},'FontSize',fontS);
    set(hSpectro(1),'Box','off','TickDir','out','YLim',[0,60],'YTick',[0:30:90],'XTick',[0.25,1,1.75],'XTickLabel',{'-0.75','0','0.75'},'FontSize',fontS);
    set(cBar,'Position',axpt(9,6,7,1:3,axpt(nCol,nRow,1:5,8:10,[0.08 0.05 0.90 0.83],tightInterval)));

% Spectrogram (aligned on light onset)
%     hSpectroLight(1) = axes('Position',axpt(9,6,1:3,2:5,axpt(nCol,nRow,1:5,9:10,[0.08 0.01 0.90 0.80],tightInterval),wideInterval));
%         hLight(1) = pcolor(timeLightPlfm2hz,freqLightPlfm2hz,psdLightPlfm2hz);
%         text(0.45,55,'Pre','fontSize',fontM,'Color',[1,1,1]);
%         text(1.1,55,'Post','fontSize',fontM,'Color',[1,1,1]);
%         ylabel('Frequency (Hz)','fontSize',fontS);
%         title('Platform','fontSize',fontS)
%         line([1,1],[0,60],'LineStyle',':','Color',[1,1,1],'LineWIdth',0.5);
%     hSpectroLight(2) = axes('Position',axpt(9,6,4:6,2:5,axpt(nCol,nRow,1:5,9:10,[0.08 0.01 0.90 0.80],tightInterval),wideInterval));
%         hLight(2) = pcolor(timeLightTrack,freqLightTrack,psdLightTrack);
%         cBar = colorbar;
%         text(0.45,55,'Pre','fontSize',fontM,'Color',[1,1,1]);
%         text(1.1,55,'Post','fontSize',fontM,'Color',[1,1,1]);
%         line([1,1],[0,60],'LineStyle',':','Color',[1,1,1],'LineWIdth',0.5);
%         title('Track','fontSize',fontS)
%     set(hLight,'EdgeColor','none');
%     set(hSpectroLight(1:2),'Box','off','TickDir','out','YLim',[0,60],'YTick',[],'XLim',[0.25,1.75],'XTick',1,'XTickLabel',{'0'},'FontSize',fontS);
%     set(hSpectroLight(1),'YTick',[0:30:90],'XTick',[0.25,1,1.75],'XTickLabel',{'-0.75 s','0','0.75 s'},'FontSize',fontS);
%     set(cBar,'Position',axpt(9,6,7,2:5,axpt(nCol,nRow,1:5,9:10,[0.08 0.01 0.90 0.80],tightInterval)));

% Track raster plot
    if ~isempty(strfind(cellDir,'DRun')) | ~isempty(strfind(cellDir,'DRw')) % DRun session
        hRaster = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,7:9,7:8,[0.1 0.07 0.9 0.80],tightInterval),wideInterval));
        hold on;
        plot([xpt.(fields{iSensor}){1} xpt.(fields{iSensor}){2}, xpt.(fields{iSensor}){3}],[ypt.(fields{iSensor}){1}, ypt.(fields{iSensor}){2}, ypt.(fields{iSensor}){3}],'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');
        rec = rectangle('Position',[0 31 1 30], 'LineStyle','none','FaceColor',lightDurationColor{1});
        ylabel('Trial','FontSize',fontS);
        title(['Raster & PETH at ',fields{iSensor}],'FontSize',fontM,'FontWeight','bold');
            
        hPsth = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,7:9,7:8,[0.1 0.07 0.9 0.80],tightInterval),wideInterval));
        ylimpeth = ceil(max(pethconv.(fields{iSensor})(:))*1.1+0.0001);
        hold on;
        for iType = 1:3
            plot(pethtime.(fields{iSensor}),pethconv.(fields{iSensor})(iType,:),'LineStyle','-','LineWidth',lineM,'Color',lineColor{iType})
        end
    end

    if ~isempty(strfind(cellDir,'noRun')) | ~isempty(strfind(cellDir,'noRw')) % noRun session
        hRaster = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,7:9,7:8,[0.1 0.07 0.9 0.80],tightInterval),wideInterval));
        hold on;
        plot([xpt.(fields{iSensor}){1} xpt.(fields{iSensor}){2}, xpt.(fields{iSensor}){3}],[ypt.(fields{iSensor}){1}, ypt.(fields{iSensor}){2}, ypt.(fields{iSensor}){3}],...
            'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');
        rec = rectangle('Position',[0 31 1 30], 'LineStyle','none','FaceColor',lightDurationColor{2});
        ylabel('Trial','FontSize',fontS);
        title(['Raster & PETH at ',fields{iSensor}],'FontSize',fontM,'FontWeight','bold');
            
        hPsth = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,7:9,7:8,[0.1 0.07 0.9 0.80],tightInterval),wideInterval));
        ylimpeth = ceil(max(pethconv.(fields{iSensor})(:))*1.1+0.0001);
        hold on;
        for iType = 1:3
            plot(pethtime.(fields{iSensor}),pethconv.(fields{iSensor})(iType,:),'LineStyle','-','LineWidth',lineM,'Color',lineColor{iType})
        end
    end
    ylabel('Rate (Hz)','FontSize',fontS);
    xlabel('Time (sec)','FontSize',fontS);
    uistack(rec,'bottom');
    set(hRaster,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS,'XLim',[-1 1],'XTick',[],'YLim',[0, 90],'YTick',[0:30:90]);
    set(hPsth,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS,'XLim',[-1, 1],'XTick',[-1:0.5:1],'YLim',[0 ylimpeth]);

% Powerspectrum
    yLim = [0, max([rPwSensorTheta_pre,rPwSensorTheta_stm,rPwSensorTheta_post,rPwSensorLGamma_pre,rPwSensorLGamma_stm,rPwSensorLGamma_post,rPwSensorHGamma_pre,rPwSensorHGamma_stm,rPwSensorHGamma_post])*1.5];
    hSpectrum(1) = axes('Position',axpt(9,6,3:4,4:6,axpt(nCol,nRow,5:10,8:10,[0.13 0.05 0.90 0.83],tightInterval),wideInterval));
        hSpecTheta(1) = bar(1,rPwSensorTheta_pre,width,'FaceColor',colorDarkGray,'EdgeColor','none');
        hold on;
        hSpecTheta(2) = bar(2,rPwSensorTheta_stm,width,'FaceColor',colorLightBlue,'EdgeColor','none');
        hold on;
        hSpecTheta(3) = bar(3,rPwSensorTheta_post,width,'FaceColor',colorBlack,'EdgeColor','none');
        text(1,yLim(2)*0.9,'Theta','fontSize',fontS);
        ylabel('Relative Power','fontSize',fontS);
    
    hSpectrum(2) = axes('Position',axpt(9,6,5:6,4:6,axpt(nCol,nRow,5:10,8:10,[0.1 0.05 0.90 0.83],tightInterval),wideInterval));
        hSpecTheta(1) = bar(1,rPwSensorLGamma_pre,width,'FaceColor',colorDarkGray,'EdgeColor','none');
        hold on;
        hSpecTheta(2) = bar(2,rPwSensorLGamma_stm,width,'FaceColor',colorLightBlue,'EdgeColor','none');
        hold on;
        hSpecTheta(3) = bar(3,rPwSensorLGamma_post,width,'FaceColor',colorBlack,'EdgeColor','none');
        text(0.5,yLim(2)*0.9,'LGamma','fontSize',fontS);
        title('Relative power on the track','fontSize',fontM,'fontWeight','Bold')
    
    hSpectrum(3) = axes('Position',axpt(9,6,7:8,4:6,axpt(nCol,nRow,5:10,8:10,[0.07 0.05 0.90 0.83],tightInterval),wideInterval));
        hSpecTheta(1) = bar(1,rPwSensorHGamma_pre,width,'FaceColor',colorDarkGray,'EdgeColor','none');
        hold on;
        hSpecTheta(2) = bar(2,rPwSensorHGamma_stm,width,'FaceColor',colorLightBlue,'EdgeColor','none');
        hold on;
        hSpecTheta(3) = bar(3,rPwSensorHGamma_post,width,'FaceColor',colorBlack,'EdgeColor','none');
        text(0.5,yLim(2)*0.9,'HGamma','fontSize',fontS);
        
    set(hSpectrum,'Box','off','TickDir','out','YLim',yLim,'YTick',[],'XLim',[0,4],'XTick',[1,2,3],'XTickLabel',{'Pr','St','  Po'},'fontSize',fontS,'LineWidth',lineM)
    set(hSpectrum(1),'Box','off','TickDir','out','YLim',yLim,'YTick',yLim(1):0.05:yLim(2),'XLim',[0,4],'XTick',[1,2,3],'XTickLabel',{'Pr','St','  Po'},'fontSize',fontS)

    % Cell ID
    hID = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,8,11,[0.15 0.05 0.85 0.85],tightInterval),wideInterval));
    text(0.9, 0.1, ['Cell ID: ',num2str(iFile)],'FontSize',fontM);
    set(hID,'visible','off');
    
%     print(gcf,'-dtiff','-r300',[cellFigName{1},'.tiff']);
    print(gcf,'-painters','-r300',[cellFigName{1},'.tiff'],'-dtiff');
%     print(gcf,'-painters','-r300',[cellFigName{1},'.ai'],'-depsc');
    close;
end
fclose('all');
end