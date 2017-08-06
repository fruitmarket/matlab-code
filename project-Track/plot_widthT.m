function plot_widthT()
load('D:\Dropbox\SNL\P2_Track\myParameters.mat');

matFile = mLoad;
nFile = length(matFile);

nCol = 2;
nRow = 5;

for iFile = 1:nFile
    [cellDir, cellName, ~] = fileparts(matFile{iFile});
    cellDirSplit = regexp(cellDir,'\','split');
    cellFigName = strcat(cellDirSplit(end-1),'_',cellDirSplit(end),'_',cellName);
    
    cd(cellDir);
    load(matFile{iFile});
    load('Events.mat');
    
    fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});

% File name
    hCell = axes('Position',axpt(1,1,1,1,axpt(1,20,1,1,[0.05 0.1 0.85 0.85],tightInterval),wideInterval));
    hold on;
    text(0,0.5,matFile{iFile}, 'FontSize',fontM, 'Interpreter','none','FontWeight','bold');
    set(hCell,'visible','off');

% Waveform
    yLimWaveform = [min(spkwv(:)), max(spkwv(:))];
    for iCh = 1:4
        hWaveform(iCh) = axes('Position',axpt(4,2,iCh,1,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.80],tightInterval),wideInterval));
        plot(spkwv(iCh,:), 'LineWidth', lineL, 'Color','k');
        if iCh == 4
            line([24 32], [yLimWaveform(2)-50 yLimWaveform(2)-50], 'Color','k', 'LineWidth', lineM);
            line([24 24],[yLimWaveform(2)-50 yLimWaveform(2)], 'Color','k', 'LineWidth',lineM);
        end
    end
    set(hWaveform, 'Visible', 'off','XLim',[1 32], 'YLim',yLimWaveform*1.05);
    
    hTextWf = axes('Position',axpt(4,2,4,1:2,axpt(nCol,nRow,1,1,[0.3 0.1 0.85 0.85],tightInterval),wideInterval));
    hold on;
    text(0,0.7,['Spike width: ',num2str(spkwth,3),' us'], 'FontSize',fontM);
    text(0,0.5,['Half-valley width: ',num2str(hfvwth,3),' us'], 'FontSize',fontM);
    text(0,0.3,['Peak valley ratio: ',num2str(spkpvr,3)], 'FontSize',fontM);
    set(hTextWf,'visible','off');
    
% Raster & PSTH (10 ms pulse)
    winLight10 = [-50 200];
    hLight10(1) = axes('Position',axpt(1,7,1,1:3,axpt(nCol,nRow,1,2,[0.1 0.1 0.85 0.85],wideInterval),wideInterval));
    hold on;
    plot(xpt10ms{1},ypt10ms{1},'LineStyle','none','Marker','.','MarkerSize',markerS,'Color','k');
    set(hLight10(1),'XLim',winLight10,'XTick',[],'YLim',[0 nlight10ms],'YTick',[0 nlight10ms],'YTickLabel',{[],nlight10ms});
    ylabel('Light Trials','FontSize',fontS);
    title('Platform light response (10ms)','FontSize',fontM,'FontWeight','bold');
    
    hLight10(2) = axes('Position',axpt(1,7,1,4:6,axpt(nCol,nRow,1,2,[0.1 0.1 0.85 0.85],wideInterval),wideInterval));
    hold on;
    yLimBar10 = ceil(max(peth10ms(:))*1.05+0.0001);
    bar(5,300,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
    rectangle('Position',[0 yLimBar10*0.925, 10, yLimBar10*0.075], 'LineStyle','none','FaceColor',colorBlue);
    hBar10 = bar(pethtime10ms, peth10ms, 'histc');
    
    set(hBar10,'FaceColor','k','EdgeAlpha',0);
    set(hLight10(2), 'XLim', winLight10, 'XTick', [winLight10(1) 0 winLight10(2)],'XTickLabel',{winLight10(1);0;num2str(winLight10(2))},'YLim', [0 yLimBar10], 'YTick', [0 yLimBar10], 'YTickLabel', {[], yLimBar10});
    set(hLight10,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS);
    xlabel('Time (ms)','FontSize',fontS);
    ylabel('Rate (Hz)','FontSize',fontS);
    align_ylabel(hLight10);
    
% Raster & PSTH (50 ms pulse)
    winLight50 = [-50 200];
    hLight50(1) = axes('Position',axpt(1,7,1,1:3,axpt(nCol,nRow,1,3,[0.1 0.1 0.85 0.85],wideInterval),wideInterval));
    hold on;
    plot(xpt50ms{1},ypt50ms{1},'LineStyle','none','Marker','.','MarkerSize',markerS,'Color','k');
    set(hLight50(1),'XLim',winLight50,'XTick',[],'YLim',[0 nlight50ms],'YTick',[0 nlight50ms],'YTickLabel',{[],nlight50ms});
    ylabel('Light Trials','FontSize',fontS);
    title('Platform light response (50ms)','FontSize',fontM,'FontWeight','bold');
    
    hLight50(2) = axes('Position',axpt(1,7,1,4:6,axpt(nCol,nRow,1,3,[0.1 0.1 0.85 0.85],wideInterval),wideInterval));
    hold on;
    yLimBar50 = ceil(max(peth50ms(:))*1.05+0.0001);
    bar(25,300,'BarWidth',50,'LineStyle','none','FaceColor',colorLLightBlue);
    rectangle('Position',[0 yLimBar50*0.925, 50, yLimBar50*0.075], 'LineStyle','none','FaceColor',colorBlue);
    hBar50 = bar(pethtime50ms, peth50ms, 'histc');
    
    set(hBar50,'FaceColor','k','EdgeAlpha',0);
    xlabelCell = {-50,0:10:50,winLight50(2)};
    set(hLight50(2), 'XLim', winLight50, 'XTick', [winLight50(1), 0:10:50, winLight50(2)],'XTickLabel',xlabelCell,'YLim', [0 yLimBar50], 'YTick', [0 yLimBar50], 'YTickLabel', {[], yLimBar50});
    set(hLight50,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS);
    xlabel('Time (ms)','FontSize',fontS);
    ylabel('Rate (Hz)','FontSize',fontS);
    align_ylabel(hLight50);
  
% Raster & psth (20 ms pulse)
    if exist('time20','var')
        winLight20 = [-50 200];
        hLight20(1) = axes('Position',axpt(1,7,1,1:3,axpt(nCol,nRow,1,4,[0.1 0.1 0.85 0.85],wideInterval),wideInterval));
        hold on;
        plot(xpt20ms{1},ypt20ms{1},'LineStyle','none','Marker','.','MarkerSize',markerS,'Color','k');
        set(hLight20(1),'XLim',winLight20,'XTick',[],'YLim',[0 nlight20ms],'YTick',[0 nlight20ms],'YTickLabel',{[],nlight20ms});
        ylabel('Light Trials','FontSize',fontS);
        title('Platform light response (20ms)','FontSize',fontM,'FontWeight','bold');

        hLight20(2) = axes('Position',axpt(1,7,1,4:6,axpt(nCol,nRow,1,4,[0.1 0.1 0.85 0.85],wideInterval),wideInterval));
        hold on;
        yLimBar20 = ceil(max(peth20ms(:))*1.05+0.0001);
        bar(10,300,'BarWidth',20,'LineStyle','none','FaceColor',colorLLightBlue);
        rectangle('Position',[0 yLimBar20*0.925, 20, yLimBar20*0.075], 'LineStyle','none','FaceColor',colorBlue);
        hBar20 = bar(pethtime20ms, peth20ms, 'histc');

        set(hBar20,'FaceColor','k','EdgeAlpha',0);
        xlabelCell = {-50,0:10:50,winLight20(2)};
        set(hLight20(2), 'XLim', winLight20, 'XTick', [winLight20(1), 0:10:50, winLight20(2)],'XTickLabel',xlabelCell,'YLim', [0 yLimBar20], 'YTick', [0 yLimBar20], 'YTickLabel', {[], yLimBar20});
        set(hLight20,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS);
        xlabel('Time (ms)','FontSize',fontS);
        ylabel('Rate (Hz)','FontSize',fontS);
        align_ylabel(hLight20);
    end

% Information
    hText10 = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,2,2:5,[0.1 0.1 0.85 0.85],wideInterval),wideInterval));
    hold on;
    text(0.1,0.9,['Mean firing rate (10 ms): ',num2str(meanFR10,3), ' Hz'], 'FontSize',fontM);
    text(0.1,0.7,['Mean firing rate (50 ms): ',num2str(meanFR50,3), ' Hz'], 'FontSize',fontM);
    if exist('time20','var')
        text(0.1,0.4,['Mean firing rate (20 ms): ',num2str(meanFR20,3), ' Hz'], 'FontSize',fontM);
    end
    set(hText10,'visible','off');
        
    print('-painters','-r300',[cellName,'.tiff'],'-dtiff');
    close all;
    fclose('all');
end
end