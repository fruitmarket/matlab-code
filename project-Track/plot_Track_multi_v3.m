function plot_Track_multi_v3(fileList,saveDir)
% function trackPlot_v4_multifig_v3()
% Plot properties
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

lineColor = {colorGray;colorBlue;colorBlack}; % Pre, Stm, Post

markerS = 2.2; markerM = 4.4; markerL = 6.6; markerXL = 8.8;
tightInterval = [0.02 0.02]; wideInterval = [0.07 0.07];
width = 0.7;

paperSizeX = [18.3, 8.00];
% matFile = mLoad;
matFile = fileList;
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
    ylabel('Spike counts','FontSize',fontS);
    xlabel('Power (mW)','FontSize',fontS);
    title('Platform laser intensity','FontSize',fontM,'FontWeight','bold');
    set(hIntensity,'XLim',[0,4],'YLim',[-5,yLimlightBase],'Box','off','TickDir','out','XTick',[1:3],'XTickLabel',{'5','8','10'},'FontSize',fontS);
    
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
        hTagBlue(1) = axes('Position',axpt(1,8,1,1:2,axpt(nCol,nRow,1:4,4:6,[0.1 0.18 0.9 0.85],tightInterval),wideInterval));
        plot(xptPlfm2hz{1},yptPlfm2hz{1},'LineStyle','none','Marker','.','MarkerSize',markerS,'Color','k');
        set(hTagBlue(1),'XLim',winBlue,'XTick',[],'YLim',[0 nBlue], 'YTick', [0 nBlue], 'YTickLabel', {0, nBlue});
        ylabel('Trials','FontSize',fontS);
        title('Platform light response (2Hz)','FontSize',fontM,'FontWeight','bold');
    % Psth
        hTagBlue(2) = axes('Position',axpt(1,8,1,3:4,axpt(nCol,nRow,1:4,4:6,[0.1 0.18 0.9 0.85],tightInterval),wideInterval));
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
        align_ylabel(hTagBlue(1:2),0.8)
    % Hazard function
        hTagBlue(3) = axes('Position',axpt(1,8,1,7:8,axpt(nCol,nRow,1:2,4:6,[0.12 0.15 0.85 0.90],tightInterval),wideInterval));
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
    end
    
    % Response check: Track
    if isfield(lightTime,'Track8hz') && exist('xptTrackLight','var') && ~isempty(xptTrackLight)
        nBlue = length(lightTime.Track8hz);
        winBlue = [min(pethtimeTrackLight) max(pethtimeTrackLight)];
    % Raster
        hModuBlue(1) = axes('Position',axpt(1,8,1,1:2,axpt(nCol,nRow,6:9,4:6,[0.1 0.18 0.9 0.85],tightInterval),wideInterval));
        plot(xptTrackLight{1},yptTrackLight{1},'LineStyle','none','Marker','.','MarkerSize',markerS,'Color','k');
        set(hModuBlue(1),'XLim',winBlue,'XTick',[],'YLim',[0 nBlue], 'YTick', [0 nBlue], 'YTickLabel', {0, nBlue});
        ylabel('Trials','FontSize',fontS);
        title('Track light response (8Hz)','FontSize',fontM,'FontWeight','bold');    
    % Psth
        hModuBlue(2) = axes('Position',axpt(1,8,1,3:4,axpt(nCol,nRow,6:9,4:6,[0.1 0.18 0.9 0.85],tightInterval),wideInterval));
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
        hModuBlue(3) = axes('Position',axpt(1,8,1,7:8,axpt(nCol,nRow,4:5,4:6,[0.12 0.15 0.85 0.90],tightInterval),wideInterval));
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
        align_ylabel(hModuBlue,0.8)     
    end
        
% Heat map
    pre_ratemap(pre_ratemap==0) = NaN;
    peak_pre = max(max(pre_ratemap))*sfreq(1);
    stm_ratemap(stm_ratemap==0) = NaN;
    peak_stm = max(max(stm_ratemap))*sfreq(1);
    post_ratemap(post_ratemap==0) = NaN;
    peak_post = max(max(post_ratemap))*sfreq(1);
    
    totalmap = [pre_ratemap(1:45,23:67),stm_ratemap(1:45,23:67),post_ratemap(1:45,23:67)];
    hMap = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,0:5,7:8,[0.12 0.19 0.80 0.75]),wideInterval));
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
    text(14,3,'Pre-stm','color','k','FontSize',fontM);
    text(62,3,'Stm','color','k','FontSize',fontM)
    text(104,3,'Post-stm','color','k','FontSize',fontM)
    text(44,45,'Track heat map','FontSize',fontM,'FontWeight','bold');
    
% Track light response raster plot (aligned on pseudo light - light - pseudo light)
    hTrackLight(1) = axes('Position',axpt(1,8,1,5:6,axpt(nCol,nRow,7:9,4:7,[0.15 0.16 0.85 0.85],tightInterval),wideInterval));
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
    hTrackLight(2) = axes('Position',axpt(1,8,1,7:8,axpt(nCol,nRow,7:9,4:7,[0.15 0.16 0.85 0.85],tightInterval),wideInterval));
        ylimpeth = ceil(max([pethPsdPreConv,pethTrackLightConv,pethPsdPostConv])*1.1+0.0001);
        hold on;
        plot(pethtimePsdPre,pethPsdPreConv,'LineStyle','-','LineWidth',lineM,'Color',colorGray);
        plot(pethtimeTrackLight,pethTrackLightConv,'LineStyle','-','LineWidth',lineM,'Color',colorBlue);
        plot(pethtimePsdPost,pethPsdPostConv,'LineStyle','-','LineWidth',lineM,'Color',colorBlack);
        ylabel('Rate (Hz)','FontSize',fontS);
    hTrackLight(3) = axes('Position',axpt(1,8,1,8,axpt(nCol,nRow,7:9,4:7,[0.10 0.10 0.85 0.85],tightInterval),wideInterval));
        text(0.2,1,'-: Pre','FontSize',fontS,'Color',colorGray);    
        text(0.6,1,'-: Stm','FontSize',fontS,'Color',colorBlue);
        text(1.0,1,'-: Post','FontSize',fontS,'Color',colorBlack);
        align_ylabel(hTrackLight(1:2),0.7);
    set(hTrackLight(1),'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS,'XLim',[-25 100],'XTick',[],'YLim',[0, sum([length(psdlightPre),length(lightTime.Track8hz),length(psdlightPost)])],'YTick',[0,length(psdlightPre),sum([length(psdlightPre),length(lightTime.Track8hz)]),sum([length(psdlightPre),length(lightTime.Track8hz),length(psdlightPost)])]);
    set(hTrackLight(2),'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS,'XLim',[-25, 100],'XTick',[-25,0,10,30,50,100],'YLim',[0, max(ylimpeth)]);
    set(hTrackLight(3),'Box','off','visible','off');
    
if ~isempty(strfind(cellDir,'DRun')) | ~isempty(strfind(cellDir,'noRun'))
    iSensor1 = 6; % Light on sensor
    iSensor2 = 9; % Light off sensor
    lightDur = 1; % Putative light duration
end
if ~isempty(strfind(cellDir,'DRw')) | ~isempty(strfind(cellDir,'noRw'))
    iSensor1 = 10; % Light on sensor
    iSensor2 = 11; % Light off sensor
    lightDur = 4; % Putative light duration
end


% Spectrogram (aligned on sensor onset)
    load(['CSC','.mat']);
    hSpectro(1) = axes('Position',axpt(6,6,1:5,1:2,axpt(nCol,nRow,1:3,10:11,[0.08 0.05 0.8 0.85],tightInterval),wideInterval));
        hSpec(1) = pcolor(timeSensor,freqSensor,psdSensor_pre/(max(psdSensor_stm(:))));
        text(0.3, 25,'Pre','fontSize',fontM,'Color',[1,1,1])
        title(['Spectrogram on sensor: ',num2str(iSensor1)],'fontSize',fontM,'FontWeight','bold');
    hSpectro(2) = axes('Position',axpt(6,6,1:5,3:4,axpt(nCol,nRow,1:3,10:11,[0.08 0.05 0.8 0.85],tightInterval),wideInterval));
        hSpec(2) = pcolor(timeSensor,freqSensor,psdSensor_stm/(max(psdSensor_stm(:))));
        text(0.3, 25,'Stm','fontSize',fontM,'Color',[1,1,1])
        ylabel('Freq (Hz)','fontSize',fontS);
    hSpectro(3) = axes('Position',axpt(6,6,1:5,5:6,axpt(nCol,nRow,1:3,10:11,[0.08 0.05 0.8 0.85],tightInterval),wideInterval));
        hSpec(3) = pcolor(timeSensor,freqSensor,psdSensor_post/(max(psdSensor_stm(:))));
        text(0.3, 25,'Post','fontSize',fontM,'Color',[1,1,1])
        xlabel('Time (ms)','fontSize',fontS);
        cBar = colorbar;
    set(hSpec,'EdgeColor','none');
    set(hSpectro(1:3),'Box','off','TickDir','out','YLim',[0,30],'YTick',[0:30:90],'XLim',[0.25,1.75],'XTick',1,'XTickLabel',[],'FontSize',fontS);
    set(hSpectro(3),'Box','off','TickDir','out','YLim',[0,30],'YTick',[0:30:90],'XTick',[0.25,1,1.75],'XTickLabel',{'-750','0','750'},'FontSize',fontS);
    set(cBar,'Position',axpt(12,6,11,1:2,axpt(nCol,nRow,1:3,10:11,[0.08 0.05 0.80 0.85],tightInterval)));

% Spectrogram (aligned on light onset)
    hSpectroPlfmLight(1) = axes('Position',axpt(6,6,1:5,1:2,axpt(nCol,nRow,4:6,10:11,[0.11 0.05 0.80 0.85],tightInterval),wideInterval));
        hPlfmLight(1) = pcolor(timeLightPlfm2hz5mw,freqLightPlfm2hz5mw,psdLightPlfm2hz5mw/max(psdLightPlfm2hz8mw(:)));
        text(0.3,25,'5 mW','fontSize',fontM,'Color',[1,1,1]);
        title('Spectrogram on Platform','fontSize',fontS,'FontWeight','bold')
        
    hSpectroPlfmLight(2) = axes('Position',axpt(6,6,1:5,3:4,axpt(nCol,nRow,4:6,10:11,[0.11 0.05 0.80 0.85],tightInterval),wideInterval));
        hPlfmLight(2) = pcolor(timeLightPlfm2hz8mw,freqLightPlfm2hz8mw,psdLightPlfm2hz8mw/max(psdLightPlfm2hz8mw(:)));
        text(0.3,25,'8 mW','fontSize',fontM,'Color',[1,1,1]);
        
    hSpectroPlfmLight(3) = axes('Position',axpt(6,6,1:5,5:6,axpt(nCol,nRow,4:6,10:11,[0.11 0.05 0.80 0.85],tightInterval),wideInterval));
        hPlfmLight(3) = pcolor(timeLightPlfm2hz10mw,freqLightPlfm2hz10mw,psdLightPlfm2hz10mw/max(psdLightPlfm2hz8mw(:)));
        text(0.3, 25,'10 mW','fontSize',fontM,'Color',[1,1,1]);
        xlabel('Time (ms)','fontSize',fontS);
    set(hPlfmLight,'EdgeColor','none');
    set(hSpectroPlfmLight(1:3),'Box','off','TickDir','out','YLim',[0,30],'YTick',[],'XLim',[0.25,1.75],'XTick',1,'XTickLabel',[],'FontSize',fontS);
    set(hSpectroPlfmLight(3),'YTick',[0:30:90],'YTickLabel',[],'XTick',[0.25,1,1.75],'XTickLabel',{'-750','0','750'},'FontSize',fontS);

% Track raster plot
    if ~isempty(strfind(cellDir,'DRun')) | ~isempty(strfind(cellDir,'DRw')) % Light session
        % First sensor
        hRaster(1) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,1:5,8:9,[0.1 0.12 0.85 0.75],tightInterval),wideInterval));
        hold on;
        plot([xpt.(fields{iSensor1}){1} xpt.(fields{iSensor1}){2}, xpt.(fields{iSensor1}){3}],[ypt.(fields{iSensor1}){1}, ypt.(fields{iSensor1}){2}, ypt.(fields{iSensor1}){3}],'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');
        rec = rectangle('Position',[0 31 lightDur 30], 'LineStyle','none','FaceColor',lightDurationColor{1});
        ylabel('Trial','FontSize',fontS);
        title(['Raster & PETH at ',fields{iSensor1}],'FontSize',fontM,'FontWeight','bold');
        hPsth(1) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,1:5,8:9,[0.1 0.12 0.85 0.75],tightInterval),wideInterval));
        ylimpeth1 = ceil(max(pethconv.(fields{iSensor1})(:))*1.1+0.0001);
        hold on;
        for iType = 1:3
            plot(pethtime.(fields{iSensor1}),pethconv.(fields{iSensor1})(iType,:),'LineStyle','-','LineWidth',lineM,'Color',lineColor{iType})
        end
        ylabel('Rate (Hz)','FontSize',fontS);
        xlabel('Time (sec)','FontSize',fontS);
        uistack(rec,'bottom');
        
        % Second sensor
        hRaster(2) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,7:10,8:9,[0.1 0.12 0.85 0.75],tightInterval),wideInterval));
        hold on;
        plot([xpt.(fields{iSensor2}){1} xpt.(fields{iSensor2}){2}, xpt.(fields{iSensor2}){3}],[ypt.(fields{iSensor2}){1}, ypt.(fields{iSensor2}){2}, ypt.(fields{iSensor2}){3}],'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');
        rec = rectangle('Position',[0-lightDur 31 lightDur 30], 'LineStyle','none','FaceColor',lightDurationColor{1});
        ylabel('Trial','FontSize',fontS);
        title(['Raster & PETH at ',fields{iSensor2}],'FontSize',fontM,'FontWeight','bold');
        hPsth(2) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,7:10,8:9,[0.1 0.12 0.85 0.75],tightInterval),wideInterval));
        ylimpeth2 = ceil(max(pethconv.(fields{iSensor2})(:))*1.1+0.0001);
        hold on;
        for iType = 1:3
            plot(pethtime.(fields{iSensor2}),pethconv.(fields{iSensor2})(iType,:),'LineStyle','-','LineWidth',lineM,'Color',lineColor{iType})
        end
        ylabel('Rate (Hz)','FontSize',fontS);
        xlabel('Time (sec)','FontSize',fontS);
        uistack(rec,'bottom');
    end

    if ~isempty(strfind(cellDir,'noRun')) | ~isempty(strfind(cellDir,'noRw')) % No light session
        % First sensor
        hRaster(1) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,1:5,8:9,[0.1 0.12 0.85 0.75],tightInterval),wideInterval));
        hold on;
        plot([xpt.(fields{iSensor1}){1} xpt.(fields{iSensor1}){2}, xpt.(fields{iSensor1}){3}],[ypt.(fields{iSensor1}){1}, ypt.(fields{iSensor1}){2}, ypt.(fields{iSensor1}){3}],...
            'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');
        rec = rectangle('Position',[0 31 lightDur 30], 'LineStyle','none','FaceColor',lightDurationColor{2});
        ylabel('Trial','FontSize',fontS);
        title(['Raster & PETH at ',fields{iSensor1}],'FontSize',fontM,'FontWeight','bold');
        hPsth(1) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,1:5,8:9,[0.1 0.12 0.85 0.75],tightInterval),wideInterval));
        ylimpeth1 = ceil(max(pethconv.(fields{iSensor1})(:))*1.1+0.0001);
        hold on;
        for iType = 1:3
            plot(pethtime.(fields{iSensor1}),pethconv.(fields{iSensor1})(iType,:),'LineStyle','-','LineWidth',lineM,'Color',lineColor{iType})
        end
        ylabel('Rate (Hz)','FontSize',fontS);
        xlabel('Time (sec)','FontSize',fontS);
        uistack(rec,'bottom');
        
        % Second sensor
        hRaster(2) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,7:10,8:9,[0.1 0.12 0.85 0.75],tightInterval),wideInterval));
        hold on;
        plot([xpt.(fields{iSensor2}){1} xpt.(fields{iSensor2}){2}, xpt.(fields{iSensor2}){3}],[ypt.(fields{iSensor2}){1}, ypt.(fields{iSensor2}){2}, ypt.(fields{iSensor2}){3}],'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');
        rec = rectangle('Position',[0-lightDur 31 lightDur 30], 'LineStyle','none','FaceColor',lightDurationColor{2});
        ylabel('Trial','FontSize',fontS);
        title(['Raster & PETH at ',fields{iSensor2}],'FontSize',fontM,'FontWeight','bold');
        hPsth(2) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,7:10,8:9,[0.1 0.12 0.85 0.75],tightInterval),wideInterval));
        ylimpeth2 = ceil(max(pethconv.(fields{iSensor2})(:))*1.1+0.0001);
        hold on;
        for iType = 1:3
            plot(pethtime.(fields{iSensor2}),pethconv.(fields{iSensor2})(iType,:),'LineStyle','-','LineWidth',lineM,'Color',lineColor{iType})
        end
        ylabel('Rate (Hz)','FontSize',fontS);
        xlabel('Time (sec)','FontSize',fontS);
        uistack(rec,'bottom');
    end

    set(hRaster,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS,'XLim',[-5 5],'XTick',[],'YLim',[0, 90],'YTick',[0:30:90]);
    set(hPsth(1),'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS,'XLim',[-5, 5],'XTick',[-5:5],'YLim',[0 ylimpeth1]);
    set(hPsth(2),'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS,'XLim',[-5, 5],'XTick',[-5:5],'YLim',[0 ylimpeth2]);

% Powerspectrum
    yLim = [0, max([rPwSensorTheta_pre,rPwSensorTheta_stm,rPwSensorTheta_post,rPwSensorLGamma_pre,rPwSensorLGamma_stm,rPwSensorLGamma_post,rPwSensorHGamma_pre,rPwSensorHGamma_stm,rPwSensorHGamma_post])*1.2];
    hSpectrum(1) = axes('Position',axpt(9,6,3:4,4:6,axpt(nCol,nRow,7:10,9:11,[0.05 0.07 0.90 0.85],tightInterval),wideInterval));
        hSpecTheta(1) = bar(1,rPwSensorTheta_pre,width,'FaceColor',colorDarkGray,'EdgeColor','none');
        hold on;
        hSpecTheta(2) = bar(2,rPwSensorTheta_stm,width,'FaceColor',colorLightBlue,'EdgeColor','none');
        hold on;
        hSpecTheta(3) = bar(3,rPwSensorTheta_post,width,'FaceColor',colorBlack,'EdgeColor','none');
        text(1,yLim(2)*0.95,'Theta','fontSize',fontS);
        ylabel('Relative Power','fontSize',fontS);
    
    hSpectrum(2) = axes('Position',axpt(9,6,5:6,4:6,axpt(nCol,nRow,7:10,9:11,[0.05 0.07 0.90 0.85],tightInterval),wideInterval));
        hSpecTheta(1) = bar(1,rPwSensorLGamma_pre,width,'FaceColor',colorDarkGray,'EdgeColor','none');
        hold on;
        hSpecTheta(2) = bar(2,rPwSensorLGamma_stm,width,'FaceColor',colorLightBlue,'EdgeColor','none');
        hold on;
        hSpecTheta(3) = bar(3,rPwSensorLGamma_post,width,'FaceColor',colorBlack,'EdgeColor','none');
        text(0.5,yLim(2)*0.95,'L-Gam','fontSize',fontS);
%         title('Relative power on the track','fontSize',fontM,'fontWeight','bold')
    
    hSpectrum(3) = axes('Position',axpt(9,6,7:8,4:6,axpt(nCol,nRow,7:10,9:11,[0.05 0.07 0.90 0.85],tightInterval),wideInterval));
        hSpecTheta(1) = bar(1,rPwSensorHGamma_pre,width,'FaceColor',colorDarkGray,'EdgeColor','none');
        hold on;
        hSpecTheta(2) = bar(2,rPwSensorHGamma_stm,width,'FaceColor',colorLightBlue,'EdgeColor','none');
        hold on;
        hSpecTheta(3) = bar(3,rPwSensorHGamma_post,width,'FaceColor',colorBlack,'EdgeColor','none');
        text(0.5,yLim(2)*0.95,'H-Gam','fontSize',fontS);
        
    set(hSpectrum,'Box','off','TickDir','out','YLim',yLim,'YTick',[],'XLim',[0,4],'XTick',[1,2,3],'XTickLabel',{'Pr','St','  Po'},'fontSize',fontS,'LineWidth',lineM)
    set(hSpectrum(1),'Box','off','TickDir','out','YLim',yLim,'YTick',[yLim(1),yLim(2)],'YTickLabel',{'0';sprintf('%.2E',yLim(2))},'XLim',[0,4],'XTick',[1,2,3],'XTickLabel',{'Pr','St','  Po'},'fontSize',fontS)
%     set(hSpectrum(1),'Box','off','TickDir','out','YLim',yLim,'YTick',[yLim(1),yLim(2)],'YTickLabel',{'0';sprintf('%.2e|',yLim(2))},'XLim',[0,4],'XTick',[1,2,3],'XTickLabel',{'Pr','St','  Po'},'fontSize',fontS)
    align_ylabel(hSpectrum(1),0.7);

% Cell ID
    hID = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,8,11,[0.15 0.02 0.85 0.85],tightInterval),wideInterval));
    text(0.9, 0, ['Cell ID: ',num2str(iFile)],'FontSize',fontM,'fontWeight','bold');
    set(hID,'visible','off');
    
    cd(saveDir);
%     print(gcf,'-dtiff','-r300',[cellFigName{1},'.tiff']);
    print(gcf,'-painters','-r300',[cellFigName{1},'.tiff'],'-dtiff');
%     print(gcf,'-painters','-r300',[cellFigName{1},'.ai'],'-depsc');
    close;
end

fclose('all');
end
