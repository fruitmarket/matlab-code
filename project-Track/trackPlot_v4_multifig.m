function trackPlot_v4_multifig(fileList,saveDir)
% Plot properties
lineColor = {[144, 164, 174]./255,... % Before stimulation
    [33 150 243]./ 255,... % During stimulation
    [38, 50, 56]./255}; % After stimulation

lineWth = [1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75];
fontS = 4; fontM = 6; fontL = 8; % font size large
lineS = 0.2; lineM = 0.5; lineL = 1; % line width large

colorBlue = [33 150 243] ./ 255;
colorLightBlue = [100 181 246] ./ 255;
% colorLightBlue = [223 239 252] ./ 255;
colorLightLightBlue = [187, 222, 251]./255;
colorRed = [237 50 52] ./ 255;
colorLightRed = [242 138 130] ./ 255;
colorGray = [189 189 189] ./ 255;
colorLightGray = [238, 238, 238] ./255;
colorDarkGray = [117, 117, 117] ./255;
colorYellow = [255 243 3] ./ 255;
colorLightYellow = [255 249 196] ./ 255;
colorBlack = [0, 0, 0];
colorBar3 = [colorGray;colorBlue;colorGray];
markerS = 2.2; markerM = 4.4; markerL = 6.6; markerXL = 8.8;
tightInterval = [0.02 0.02]; wideInterval = [0.07 0.07];

nCol = 20;
nRow = 10;

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
    fHandle = figure('PaperUnits','centimeters','PaperPosition',[0 0 18.3 13.725]);
    hText = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,0:5,1:2,[],tightInterval),wideInterval));
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
        hWaveform(iCh) = axes('Position',axpt(4,1,iCh,1,axpt(nCol,nRow,0:3,3,[],tightInterval),wideInterval));
        plot(spkwv(iCh,:), 'LineWidth', lineL, 'Color','k');
        if iCh == 4
            line([24 32], [yLimWaveform(2)-50 yLimWaveform(2)-50], 'Color','k', 'LineWidth', lineM);
            line([24 24],[yLimWaveform(2)-50 yLimWaveform(2)], 'Color','k', 'LineWidth',lineM);
        end
    end
    set(hWaveform, 'Visible', 'off','XLim',[1 32], 'YLim',yLimWaveform*1.05);
    
% Platform light intensity plot
    yLimlightBase = max([lighttagSpk5mw; lighttagSpk8mw; lighttagSpk10mw])*1.1;
    if yLimlightBase < 10
        yLimlightBase = 20;
    end
    hIntensity = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,7:9,2:3,[],tightInterval),wideInterval));
    hold on;
    plot([1,2,3],[lighttagSpk5mw,lighttagSpk8mw,lighttagSpk10mw],'-o','Color',colorGray,'MarkerFaceColor',colorBlue,'MarkerEdgeColor','k','MarkerSize',markerM);
    hold on;
    ylabel('Spike counts','FontSize',fontM);
    xlabel('Power (mW)','FontSize',fontM);
    title('Platform laser intensity','FontSize',fontM,'FontWeight','bold');
    set(hIntensity,'XLim',[0,4],'YLim',[-10,yLimlightBase],'Box','off','TickDir','out','XTick',[1:3],'XTickLabel',{'5','8','10'},'FontSize',fontM);
    
% Response check: Platform
      % Activation or Inactivation?
    if isfield(lightTime,'Tag') && exist('xptTagBlue','var');
        lightDuration = 10;
        lightDurationColor = colorLightBlue;
        testRangeChETA = 20; % ChETA light response test range (ex. 20ms)       
    end
    if isfield(lightTime,'Tag') && exist('xptTagBlue','var') && ~isempty(xptTagBlue)
        nBlue = length(lightTime.Tag);
        winBlue = [min(pethtimeTagBlue) max(pethtimeTagBlue)];
    % Raster
        hTagBlue(1) = axes('Position',axpt(1,8,1,1:2,axpt(nCol,nRow,1:4,5:7,[],tightInterval),wideInterval));
        rectangle('Position', [0 0, 10, nBlue/3], 'LineStyle', 'none', 'FaceColor', colorLightLightBlue);
        hold on;
        rectangle('Position', [0 nBlue/3+1, 10, nBlue*2/3], 'LineStyle', 'none', 'FaceColor', colorLightBlue);
        hold on;
        rectangle('Position', [0 nBlue*2/3, 10, nBlue], 'LineStyle', 'none', 'FaceColor', colorBlue);
        hold on;
        plot(xptTagBlue{1},yptTagBlue{1},'LineStyle','none','Marker','.','MarkerSize',markerS,'Color','k');
        set(hTagBlue(1),'XLim',winBlue,'XTick',[],'YLim',[0 nBlue], 'YTick', [0 nBlue], 'YTickLabel', {[], nBlue});
        ylabel('Trials','FontSize',fontS);
        title('Platform light response (2Hz)','FontSize',fontM,'FontWeight','bold');
    % Psth
        hTagBlue(2) = axes('Position',axpt(1,8,1,3:4,axpt(nCol,nRow,1:4,5:7,[],tightInterval),wideInterval));
        hold on;
        yLimBarBlue = ceil(max(pethTagBlue(:))*1.05+0.0001);
        bar(5, 1000, 'BarWidth', 10, 'LineStyle','none', 'FaceColor', colorLightLightBlue);
        rectangle('Position', [0 yLimBarBlue*0.925, 10, yLimBarBlue*0.075], 'LineStyle', 'none', 'FaceColor', colorBlue);
        hBarBlue = bar(pethtimeTagBlue, pethTagBlue, 'histc');
        text(sum(winBlue)*0.3,yLimBarBlue*0.9,['latency = ', num2str(testLatencyTag_first,3)],'FontSize',fontS,'interpreter','none');
%         text(sum(winBlue)*0.85,yLimBarBlue*0.9,['p_lat = ',num2str(pLatencyTag_first,3)],'FontSize',fontS,'interpreter','none');
        set(hBarBlue, 'FaceColor','k', 'EdgeAlpha',0);
        set(hTagBlue(2), 'XLim', winBlue, 'XTick', [winBlue(1) 0 winBlue(2)],'XTickLabel',{winBlue(1);0;num2str(winBlue(2))},...
            'YLim', [0 yLimBarBlue], 'YTick', [0 yLimBarBlue], 'YTickLabel', {[], yLimBarBlue});
        xlabel('Time (ms)','FontSize',fontS);
        ylabel('Rate (Hz)', 'FontSize', fontS);
    % Hazard function
        hTagBlue(3) = axes('Position',axpt(1,8,1,7:8,axpt(nCol,nRow,1:4,5:7,[],tightInterval),wideInterval));
        hold on;
        ylimH = min([ceil(max([H1_tag;H2_tag])*1100+0.0001)/1000 1]);
        winHTag = [0 testRangeChETA];
        stairs(timeLR_tag, H2_tag, 'LineStyle',':','LineWidth',lineL,'Color','k');
        stairs(timeLR_tag, H1_tag,'LineStyle','-','LineWidth',lineL,'Color',colorBlue);
        text(winHTag(2)*0.1,ylimH*0.9,['p = ',num2str(pLR_tag,3),' (log-rank)'],'FontSize',fontS,'Interpreter','none');
        set(hTagBlue(3),'XLim',winHTag,'XTick',winHTag,'YLim',[0 ylimH], 'YTick', [0 ylimH], 'YTickLabel', {[], ylimH});
        xlabel('Time (ms)','FontSize',fontS);
        ylabel('H(t)','FontSize',fontS);
        title('Log-rank test','FontSize',fontM,'FontWeight','bold');
        set(hTagBlue,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS);
        align_ylabel(hTagBlue)
    end
    
    % Response check: Track
    if isfield(lightTime,'Modu') && exist('xptModuBlue','var') && ~isempty(xptModuBlue)
        nBlue = length(lightTime.Modu);
        winBlue = [min(pethtimeModuBlue) max(pethtimeModuBlue)];
    % Raster
        hModuBlue(1) = axes('Position',axpt(1,8,1,1:2,axpt(nCol,nRow,6:9,5:7,[],tightInterval),wideInterval));
        plot(xptModuBlue{1},yptModuBlue{1},'LineStyle','none','Marker','.','MarkerSize',markerS,'Color','k');
        set(hModuBlue(1),'XLim',winBlue,'XTick',[],'YLim',[0 nBlue], 'YTick', [0 nBlue], 'YTickLabel', {[], nBlue});
        ylabel('Trials','FontSize',fontS);
        title('Track light response (8Hz)','FontSize',fontM,'FontWeight','bold');    
    % Psth
        hModuBlue(2) = axes('Position',axpt(1,8,1,3:4,axpt(nCol,nRow,6:9,5:7,[],tightInterval),wideInterval));
        hold on;
        yLimBarBlue = ceil(max(pethModuBlue(:))*1.05+0.0001);
        if ~isempty(strfind(cellDir,'DRun')) | ~isempty(strfind(cellDir,'DRw'))
            bar(5, 1000, 'BarWidth', 10,'LineStyle', 'none', 'FaceColor', colorLightLightBlue);
            rectangle('Position', [0, yLimBarBlue*0.925, 10, yLimBarBlue*0.075], 'LineStyle', 'none', 'FaceColor', colorBlue);
        else
            bar(5, 1000, 'BarWidth', 10,'LineStyle', 'none', 'FaceColor', colorLightGray);
            rectangle('Position', [0, yLimBarBlue*0.925, 10, yLimBarBlue*0.075], 'LineStyle', 'none', 'FaceColor', colorGray);
        end
        hBarBlue = bar(pethtimeModuBlue, pethModuBlue, 'histc');
        text(sum(winBlue)*0.3,yLimBarBlue*0.9,['latency = ', num2str(testLatencyModu_first,3)],'FontSize',fontS,'interpreter','none');
%         text(sum(winBlue)*0.85,yLimBarBlue*0.9,['p_lat = ',num2str(pLatencyModu_first,3)],'FontSize',fontS,'interpreter','none');
        set(hBarBlue, 'FaceColor','k', 'EdgeAlpha',0);
        set(hModuBlue(2), 'XLim', winBlue, 'XTick', [winBlue(1), 0, winBlue(2)],'XTickLabel',{winBlue(1);0;num2str(winBlue(2))},...
            'YLim', [0 yLimBarBlue], 'YTick', [0 yLimBarBlue], 'YTickLabel', {[], yLimBarBlue});
        ylabel('Rate (Hz)','FontSize',fontS);
        xlabel('Time (ms)','FontSize',fontS);
    % Hazard function    
        hModuBlue(3) = axes('Position',axpt(1,8,1,7:8,axpt(nCol,nRow,6:9,5:7,[],tightInterval),wideInterval));
        hold on;
        ylimH = min([ceil(max([H1_modu;H2_modu])*1100+0.0001)/1000 1]);
        winHModu = [0 testRangeChETA];
        stairs(timeLR_modu, H2_modu, 'LineStyle',':','LineWidth',lineL,'Color','k');
        stairs(timeLR_modu, H1_modu,'LineStyle','-','LineWidth',lineL,'Color',colorBlue);
        text(winHModu(2)*0.1,ylimH*0.9,['p = ',num2str(pLR_modu,3),' (log-rank)'],'FontSize',fontS,'Interpreter','none');
        set(hModuBlue(3),'XLim',winHModu,'XTick',winHModu,'XTickLabel',{winHModu(1);num2str(winHModu(2))},...
            'YLim',[0 ylimH], 'YTick', [0 ylimH], 'YTickLabel', {[], ylimH});
        xlabel('Time (ms)','FontSize',fontS);
        ylabel('H(t)','FontSize',fontS);
        title('Log-rank test','FontSize',fontM,'FontWeight','bold');
        set(hModuBlue,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS);
        align_ylabel(hModuBlue)     
    end
    
% Track raster plot
    if ~isempty(strfind(cellDir,'DRun')) % DRun session
        iSensor = 6;
        hRaster = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,7:9,9:10,[],tightInterval),wideInterval));
        hold on;
        plot([xpt.(fields{iSensor}){1} xpt.(fields{iSensor}){2}, xpt.(fields{iSensor}){3}],[ypt.(fields{iSensor}){1}, ypt.(fields{iSensor}){2}, ypt.(fields{iSensor}){3}],...
            'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');
        rec = rectangle('Position',[-0.99 31 2 30], 'LineStyle','none','FaceColor',lightDurationColor);
        ylabel('Trial','FontSize',fontS);
        title(['Raster & PETH at ',fields{iSensor}],'FontSize',fontM,'FontWeight','bold');
            
        hPsth = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,7:9,9:10,[],tightInterval),wideInterval));
        ylimpeth = ceil(max(pethconv.(fields{iSensor})(:))*1.1+0.0001);
        hold on;
        for iType = 1:3
            plot(pethtime.(fields{iSensor}),pethconv.(fields{iSensor})(iType,:),'LineStyle','-','LineWidth',lineM,'Color',lineColor{iType})
        end
    end
    if ~isempty(strfind(cellDir,'DRw')) % Rw session
        iSensor = 10;
        hRaster = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,7:9,9:10,[],tightInterval),wideInterval));
        hold on;
        plot([xpt.(fields{iSensor}){1} xpt.(fields{iSensor}){2}, xpt.(fields{iSensor}){3}],[ypt.(fields{iSensor}){1}, ypt.(fields{iSensor}){2}, ypt.(fields{iSensor}){3}],...
            'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');
        rec = rectangle('Position',[-0.99 31 2 30], 'LineStyle','none','FaceColor',lightDurationColor);
        ylabel('Trial','FontSize',fontS);
        title(['Raster & PETH at ',fields{iSensor}],'FontSize',fontM,'FontWeight','bold');
            
        hPsth = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,7:9,9:10,[],tightInterval),wideInterval));
        ylimpeth = ceil(max(pethconv.(fields{iSensor})(:))*1.1+0.0001);
        hold on;
        for iType = 1:3
            plot(pethtime.(fields{iSensor}),pethconv.(fields{iSensor})(iType,:),'LineStyle','-','LineWidth',lineM,'Color',lineColor{iType})
        end
    end
    if ~isempty(strfind(cellDir,'noRun')) % noRun session
        iSensor = 6;
        hRaster = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,7:9,9:10,[],tightInterval),wideInterval));
        hold on;
        plot([xpt.(fields{iSensor}){1} xpt.(fields{iSensor}){2}, xpt.(fields{iSensor}){3}],[ypt.(fields{iSensor}){1}, ypt.(fields{iSensor}){2}, ypt.(fields{iSensor}){3}],...
            'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');
        rec = rectangle('Position',[-0.99 31 2 30], 'LineStyle','none','FaceColor',lightDurationColor);
        ylabel('Trial','FontSize',fontS);
        title(['Raster & PETH at ',fields{iSensor}],'FontSize',fontM,'FontWeight','bold');
            
        hPsth = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,7:9,9:10,[],tightInterval),wideInterval));
        ylimpeth = ceil(max(pethconv.(fields{iSensor})(:))*1.1+0.0001);
        hold on;
        for iType = 1:3
            plot(pethtime.(fields{iSensor}),pethconv.(fields{iSensor})(iType,:),'LineStyle','-','LineWidth',lineM,'Color',lineColor{iType})
        end
    end
    if ~isempty(strfind(cellDir,'noRw')) % noRw session
        iSensor = 10;
        hRaster = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,7:9,9:10,[],tightInterval),wideInterval));
        hold on;
        plot([xpt.(fields{iSensor}){1} xpt.(fields{iSensor}){2}, xpt.(fields{iSensor}){3}],[ypt.(fields{iSensor}){1}, ypt.(fields{iSensor}){2}, ypt.(fields{iSensor}){3}],...
            'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');
        rec = rectangle('Position',[-0.99 31 2 30], 'LineStyle','none','FaceColor',lightDurationColor);
        ylabel('Trial','FontSize',fontS);
        title(['Raster & PETH at ',fields{iSensor}],'FontSize',fontM,'FontWeight','bold');
            
        hPsth = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,7:9,9:10,[],tightInterval),wideInterval));
        ylimpeth = ceil(max(pethconv.(fields{iSensor})(:))*1.1+0.0001);
        hold on;
        for iType = 1:3
            plot(pethtime.(fields{iSensor}),pethconv.(fields{iSensor})(iType,:),'LineStyle','-','LineWidth',lineL,'Color',lineColor{iType})
        end
    end
    ylabel('Rate (Hz)','FontSize',fontS);
    uistack(rec,'bottom');
    set(hRaster,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS,'XLim',[-1 1],'XTick',[],'YLim',[0, 90],'YTick',[0:30:90]);
    set(hPsth,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS,'XLim',[-1, 1],'XTick',[-1:0.2:1],'YLim',[0 ylimpeth]);
    
    % Heat map
    pre_ratemap(pre_ratemap==0) = NaN;
    peak_pre = max(max(pre_ratemap))*sfreq(1);
    stm_ratemap(stm_ratemap==0) = NaN;
    peak_stm = max(max(stm_ratemap))*sfreq(1);
    post_ratemap(post_ratemap==0) = NaN;
    peak_post = max(max(post_ratemap))*sfreq(1);
    
    totalmap = [pre_ratemap(1:45,23:67),stm_ratemap(1:45,23:67),post_ratemap(1:45,23:67)];
    hMap = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,0:5,9:10,[]),wideInterval));
    hold on;
    hField = pcolor(totalmap);
    
% Arc property
    if ~isempty(strfind(cellDir,'DRun')) | ~isempty(strfind(cellDir,'noRun'));
        arc = linspace(pi,pi/2*3,170); % s6-s9
    else ~isempty(strfind(cellDir,'DRw')) | ~isempty(strfind(cellDir,'noRw'));
        arc = linspace(pi/6*5, pi/6*4,170);
    end

    if ~isempty(lightTime.Modu)
        hold on;
        arc_r = 20;
        x = arc_r*cos(arc)+67;
        y = arc_r*sin(arc)+27;
        if exist('xptModuBlue','var') & (~isempty(strfind(cellDir,'DRw')) | ~isempty(strfind(cellDir,'DRun')));
            plot(x,y,'LineWidth',4,'color',colorBlue);
        elseif exist('xptModuBlue','var') & (~isempty(strfind(cellDir,'noRw')) | ~isempty(strfind(cellDir,'noRun')));
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
    text(44,56.5,'Track heat map','FontSize',fontM,'FontWeight','bold');
    
    cd(saveDir)
    print(gcf,'-dtiff','-r300',[cellFigName{1},'.tiff']);
    close;
end
end