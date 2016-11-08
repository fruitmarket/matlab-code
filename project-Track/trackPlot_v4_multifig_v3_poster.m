function trackPlot_v4_multifig_v3_poster()
% function trackPlot_v4_multifig_v3()
% Plot properties
lineColor = {[144, 164, 174]./255,... % Before stimulation
    [33 150 243]./ 255,... % During stimulation
    [38, 50, 56]./255}; % After stimulation

lineWth = [1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75];
fontS = 4; fontM = 5; fontL = 8; % font size large
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
% matFile = fileList;
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
%     fHandle = figure('PaperUnits','centimeters','PaperPosition',[0 0 18.3 13.725]);
    fHandle = figure('PaperUnits','centimeters','PaperPosition',[0 0 paperSizeX(1) 13.725]);
    if paperSizeX == 8.00
        nCol = 18;
        nRow = 11;
    else
        nCol = 13;
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
    
    % Response check: Track
    if isfield(lightTime,'Modu') && exist('xptModuBlue','var') && ~isempty(xptModuBlue)
        nBlue = length(lightTime.Modu);
        winBlue = [min(pethtimeModuBlue) max(pethtimeModuBlue)];
        testRangeChETA = 10; % ChETA light response test range (ex. 10ms)
        lightDurationColor = {colorLLightBlue, colorLightGray};

    % Raster
        hModuBlue(1) = axes('Position',axpt(1,8,1,1:3,axpt(nCol,nRow,2:4,3:6,[],wideInterval),wideInterval));
        plot(xptModuBlue{1},yptModuBlue{1},'LineStyle','none','Marker','.','MarkerSize',markerS,'Color','k');
        set(hModuBlue(1),'XLim',winBlue,'XTick',[],'YLim',[0 nBlue], 'YTick', [0 nBlue], 'YTickLabel', {[], nBlue});
        ylabel('Trials','FontSize',fontL);
        title('Track light response (8Hz)','FontSize',fontL,'FontWeight','bold');    
    % Psth
        hModuBlue(2) = axes('Position',axpt(1,8,1,4:6,axpt(nCol,nRow,2:4,3:6,[],wideInterval),wideInterval));
        hold on;
        yLimBarBlue = ceil(max(pethModuBlue(:))*1.05+0.0001);
        if ~isempty(strfind(cellDir,'DRun')) | ~isempty(strfind(cellDir,'DRw'))
            bar(5, 1000, 'BarWidth', 10,'LineStyle', 'none', 'FaceColor', colorLLightBlue);
            rectangle('Position', [0, yLimBarBlue*0.925, 10, yLimBarBlue*0.075], 'LineStyle', 'none', 'FaceColor', colorBlue);
        else
            bar(5, 1000, 'BarWidth', 10,'LineStyle', 'none', 'FaceColor', colorLightGray);
            rectangle('Position', [0, yLimBarBlue*0.925, 10, yLimBarBlue*0.075], 'LineStyle', 'none', 'FaceColor', colorGray);
        end
        hBarBlue = bar(pethtimeModuBlue, pethModuBlue, 'histc');
        if statDir_Track == 1;
            text(sum(winBlue)*0.3,yLimBarBlue*0.9,['latency = ', num2str(testLatencyTrack,3)],'FontSize',fontL,'interpreter','none');
%         text(sum(winBlue)*0.85,yLimBarBlue*0.9,['p_lat = ',num2str(pLatencyModu_first,3)],'FontSize',fontL,'interpreter','none');
        else
        end
        set(hBarBlue, 'FaceColor','k', 'EdgeAlpha',0);
        set(hModuBlue(2), 'XLim', winBlue, 'XTick', [winBlue(1), 0, winBlue(2)],'XTickLabel',{winBlue(1);0;num2str(winBlue(2))},...
            'YLim', [0 yLimBarBlue], 'YTick', [0 yLimBarBlue], 'YTickLabel', {[], yLimBarBlue});
        ylabel('Rate (Hz)','FontSize',fontL);
        xlabel('Time (ms)','FontSize',fontL);
    % Hazard function    
        hModuBlue(3) = axes('Position',axpt(1,8,1,8:10,axpt(nCol,nRow,2:4,3:6,[],wideInterval),wideInterval));
        hold on;
        ylimH = min([ceil(max([H1_Track;H2_Track])*1100+0.0001)/1000 1]);
        winHModu = [0 testRangeChETA];
        stairs(timeLR_Track, H2_Track, 'LineStyle','-','LineWidth',lineL,'Color','k');
        stairs(timeLR_Track, H1_Track,'LineStyle','-','LineWidth',lineL,'Color',colorBlue);
        text(diff(winHModu)*0.1+calibTrack,ylimH*0.9,['p = ',num2str(pLR_Track,3)],'FontSize',fontL,'Interpreter','none');
        xlabel('Time (ms)','FontSize',fontL);
        ylabel('H(t)','FontSize',fontL);
        title('Log-rank test (Track)','FontSize',fontM,'FontWeight','bold');
        set(hModuBlue(3),'XLim',winHModu,'XTick',winHModu,'XTickLabel',{winHModu(1);num2str(winHModu(2))},'YLim',[0 ylimH], 'YTick', [0 ylimH], 'YTickLabel', {[], ylimH});
        set(hModuBlue,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontL);
        align_ylabel(hModuBlue)     
    end

    
% Track light response raster plot (aligned on pseudo light - light - pseudo light)
    hTrackLightRaster(1) = axes('Position',axpt(1,8,1,1:3,axpt(nCol,nRow,7:9,3:6,[],wideInterval),wideInterval));
        plot([xptPsdPre{1}, xptModuBlue{1}, xptPsdPost{1}],[yptPsdPre{1}, (length(psdlightPre)+yptModuBlue{1}), (sum([length(psdlightPre),length(lightTime.Modu)])+yptPsdPost{1})],'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');
        if ~isempty(strfind(cellDir,'DRun')) | ~isempty(strfind(cellDir,'DRw'))
            rec = rectangle('Position',[0.5 length(psdlightPre)+1, 10, length(lightTime.Modu)], 'LineStyle','none','FaceColor',lightDurationColor{1});
        end
        if ~isempty(strfind(cellDir,'noRun')) | ~isempty(strfind(cellDir,'noRw'))
            rec = rectangle('Position',[0.5 length(psdlightPre)+1, 10, length(lightTime.Modu)], 'LineStyle','none','FaceColor',lightDurationColor{2});
        end
        if pLR_Track_pre < 0.05
            text(105, sum([length(psdlightPre),length(lightTime.Modu),length(psdlightPost)])/8, '*','Color',colorRed,'fontSize',fontL);
        end
        if pLR_Track < 0.05
            text(105, sum([length(psdlightPre),length(lightTime.Modu),length(psdlightPost)])*3/8, '*','Color',colorRed,'fontSize',fontL);
        end
        if pLR_Track_post < 0.05
            text(105, sum([length(psdlightPre),length(lightTime.Modu),length(psdlightPost)])*6/8, '*','Color',colorRed,'fontSize',fontL);
        end
        uistack(rec,'bottom');
        ylabel('Trial','FontSize',fontL);
        title('Track light response (Psd-L-Psd)','FontSize',fontM,'FontWeight','bold');
   
    hTrackLightRaster(2) = axes('Position',axpt(1,8,1,4:6,axpt(nCol,nRow,7:9,3:6,[],wideInterval),wideInterval));
        ylimpeth = ceil(max([pethPsdPreConv,pethModuConv,pethPsdPostConv])*1.1+0.0001);
        hold on;
        plot(pethtimePsdPre,pethPsdPreConv,'LineStyle','-','LineWidth',lineM,'Color',colorGray);
        plot(pethtimeModuBlue,pethModuConv,'LineStyle','-','LineWidth',lineM,'Color',colorBlue);
        plot(pethtimePsdPost,pethPsdPostConv,'LineStyle','-','LineWidth',lineM,'Color',colorBlack);
        ylabel('Rate (Hz)','FontSize',fontL);
        align_ylabel(hTrackLightRaster);
    set(hTrackLightRaster(1),'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontL,'XLim',[-25 100],'XTick',[],'YLim',[0, sum([length(psdlightPre),length(lightTime.Modu),length(psdlightPost)])],'YTick',[length(psdlightPre),sum([length(psdlightPre),length(lightTime.Modu)]),sum([length(psdlightPre),length(lightTime.Modu),length(psdlightPost)])]);
    set(hTrackLightRaster(2),'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontL,'XLim',[-25, 100],'XTick',[-25,0,10,30,50,100],'YLim',[0, max(ylimpeth)]);

% Track raster plot
    if ~isempty(strfind(cellDir,'DRun')) | ~isempty(strfind(cellDir,'DRw')) % DRun session
        iSensor = 10;
        hRaster(1) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,7:9,7:8,[0.1 0.07 0.9 0.80],tightInterval),wideInterval));
        hold on;
        plot([xpt.(fields{iSensor}){1} xpt.(fields{iSensor}){2}, xpt.(fields{iSensor}){3}],[ypt.(fields{iSensor}){1}, ypt.(fields{iSensor}){2}, ypt.(fields{iSensor}){3}],...
            'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');
        rec = rectangle('Position',[-0.99 31 2 30], 'LineStyle','none','FaceColor',lightDurationColor{1});
        ylabel('Trial','FontSize',fontL);
        title(['Raster & PETH at ',fields{iSensor}],'FontSize',fontM,'FontWeight','bold');
            
        hRaster(2) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,7:9,7:8,[0.1 0.07 0.9 0.80],tightInterval),wideInterval));
        ylimpeth = ceil(max(pethconv.(fields{iSensor})(:))*1.1+0.0001);
        hold on;
        for iType = 1:3
            plot(pethtime.(fields{iSensor}),pethconv.(fields{iSensor})(iType,:),'LineStyle','-','LineWidth',lineM,'Color',lineColor{iType})
        end
    end  
    ylabel('Rate (Hz)','FontSize',fontS);
    uistack(rec,'bottom');
 
    set(hRaster,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontL,'XLim',[-1 1],'XTick',[],'YLim',[0, 90],'YTick',[0:30:90]);
    set(hRaster,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontL,'XLim',[-1, 1],'XTick',[-1:0.5:1],'YLim',[0 ylimpeth]);
    
% Cell ID
    hID = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,8,11,[0.15 0.05 0.85 0.85],tightInterval),wideInterval));
    text(0.9, 0.1, ['Cell ID: ',num2str(iFile)],'FontSize',fontM);
    set(hID,'visible','off');

%     cd(saveDir)
    
%     print(gcf,'-dtiff','-r300',[cellFigName{1},'.tiff']);
    print(gcf,'-painters','-r300','Fig_LightResponse.ai','-depsc');
end
end