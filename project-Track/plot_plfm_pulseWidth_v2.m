function plot_plfm_pulseWidth_v2()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Draw plot for 1, 3, 5, 10 ms pulse test
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load('D:\Dropbox\SNL\P2_Track\myParameters.mat');

matFile = mLoad;
nFile = length(matFile);

nCol = 2;
nRow = 5;

winLight = [-25 90];

for iFile = 1:nFile
    [cellDir, cellName, ~] = fileparts(matFile{iFile});
    cellDirSplit = regexp(cellDir,'\','split');
    cellFigName = strcat(cellDirSplit(end-1),'_',cellDirSplit(end),'_',cellName);
    
    cd(cellDir);
    load(matFile{iFile});
    load('Events.mat');
    
%     fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});
    fHandle = figure('PaperUnits','centimeters','PaperPosition',[0, 0, 13, 20]);

% File name
    hCell = axes('Position',axpt(1,1,1,1,axpt(1,20,1,1,[0.05 0.1 0.85 0.85],tightInterval),wideInterval));
    hold on;
    text(0,0.5,matFile{iFile}, 'FontSize',fontM, 'Interpreter','none','FontWeight','bold');
    set(hCell,'visible','off');

% Waveform
    yLimWaveform = [min(spkwv(:)), max(spkwv(:))];
    for iCh = 1:4
        hWaveform(iCh) = axes('Position',axpt(4,2,iCh,1,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.80],wideInterval),wideInterval));
        plot(spkwv(iCh,:), 'LineWidth', lineL, 'Color','k');
        if iCh == 4
            line([24 32], [yLimWaveform(2)-50 yLimWaveform(2)-50], 'Color','k', 'LineWidth', lineM);
            line([24 24],[yLimWaveform(2)-50 yLimWaveform(2)], 'Color','k', 'LineWidth',lineM);
        end
    end
    set(hWaveform, 'Visible', 'off','XLim',[1 32], 'YLim',yLimWaveform*1.05);
    
    hTextWf = axes('Position',axpt(4,2,4,1:2,axpt(nCol,nRow,1,1,[0.3 0.1 0.85 0.85],wideInterval),wideInterval));
        text(0,0.7,['Spike width: ',num2str(spkwth,3),' us'], 'FontSize',fontM);
        text(0,0.5,['Half-valley width: ',num2str(hfvwth,3),' us'], 'FontSize',fontM);
        text(0,0.3,['Peak valley ratio: ',num2str(spkpvr,3)], 'FontSize',fontM);
        set(hTextWf,'visible','off');
    
% Raster & PSTH (1 ms pulse)
    hLight1ms(1) = axes('Position',axpt(1,6,1,1:3,axpt(nCol,nRow,1,2,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
        plot(xpt1ms{1},ypt1ms{1},'LineStyle','none','Marker','.','MarkerSize',markerS,'Color','k');
        ylabel('Light Trials','FontSize',fontS);
        title('Platform light response (1ms)','FontSize',fontM,'FontWeight','bold');
    
    hLight1ms(2) = axes('Position',axpt(1,6,1,4:6,axpt(nCol,nRow,1,2,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
        yLimBar = ceil(max(peth1ms(:))*1.05+0.0001);
        patch([0 1 1 0],[0 0 yLimBar yLimBar],colorLightBlue,'LineStyle','none');
        hold on;
        hBar1 = bar(pethtime1ms, peth1ms, 'histc');
        xlabel('Time (ms)','FontSize',fontS);
        ylabel('Rate (Hz)','FontSize',fontS);
    
    hLight1ms(3) = axes('Position',axpt(1,6,1,1:6,axpt(nCol,nRow,2,2,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
        text(0.1, 0.9, ['Mean firing rate (1 ms): ',num2str(meanFR_1ms,3), ' Hz'],'FontSize',fontM);
        text(0.1, 0.5, ['p-value: ',num2str(p_spike(1),3)],'FontSize',fontM);
    
    set(hBar1,'FaceColor','k','EdgeAlpha',0);
    set(hLight1ms(1),'XLim',winLight,'XTick',[],'YLim',[0 nLight1ms],'YTick',[0 nLight1ms],'YTickLabel',{[],nLight1ms});
    set(hLight1ms(2), 'XLim', winLight, 'XTick', [winLight(1) 0 winLight(2)],'XTickLabel',{winLight(1);0;num2str(winLight(2))},'YLim', [0 yLimBar], 'YTick', [0 yLimBar], 'YTickLabel', {[], yLimBar});
    set(hLight1ms(3),'visible','off');
    set(hLight1ms,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS);
   
% Raster & PSTH (3 ms pulse)
    hLight3ms(1) = axes('Position',axpt(1,6,1,1:3,axpt(nCol,nRow,1,3,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
        plot(xpt3ms{1},ypt3ms{1},'LineStyle','none','Marker','.','MarkerSize',markerS,'Color','k');
        ylabel('Light Trials','FontSize',fontS);
        title('Platform light response (3ms)','FontSize',fontM,'FontWeight','bold');
    
    hLight3ms(2) = axes('Position',axpt(1,6,1,4:6,axpt(nCol,nRow,1,3,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
        yLimBar = ceil(max(peth3ms(:))*1.05+0.0001);
        patch([0 3 3 0],[0 0 yLimBar yLimBar],colorLightBlue,'LineStyle','none');
        hold on;
        hBar1 = bar(pethtime3ms, peth3ms, 'histc');
        xlabel('Time (ms)','FontSize',fontS);
        ylabel('Rate (Hz)','FontSize',fontS);
    
    hLight3ms(3) = axes('Position',axpt(1,7,1,1:6,axpt(nCol,nRow,2,3,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
        text(0.1, 0.9, ['Mean firing rate (3 ms): ',num2str(meanFR_3ms,3), ' Hz'],'FontSize',fontM);
        text(0.1, 0.5, ['p-value: ',num2str(p_spike(2),3)],'FontSize',fontM);

    set(hBar1,'FaceColor','k','EdgeAlpha',0);
    set(hLight3ms(1),'XLim',winLight,'XTick',[],'YLim',[0 nLight3ms],'YTick',[0 nLight3ms],'YTickLabel',{[],nLight3ms});
    set(hLight3ms(2), 'XLim', winLight, 'XTick', [winLight(1) 0 winLight(2)],'XTickLabel',{winLight(1);0;num2str(winLight(2))},'YLim', [0 yLimBar], 'YTick', [0 yLimBar], 'YTickLabel', {[], yLimBar});
    set(hLight3ms(3),'visible','off');
    set(hLight3ms,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS);

    
% Raster & PSTH (5 ms pulse)
    hLight5ms(1) = axes('Position',axpt(1,6,1,1:3,axpt(nCol,nRow,1,4,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
        plot(xpt5ms{1},ypt5ms{1},'LineStyle','none','Marker','.','MarkerSize',markerS,'Color','k');
        ylabel('Light Trials','FontSize',fontS);
        title('Platform light response (5ms)','FontSize',fontM,'FontWeight','bold');
    
    hLight5ms(2) = axes('Position',axpt(1,6,1,4:6,axpt(nCol,nRow,1,4,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
        yLimBar = ceil(max(peth5ms(:))*1.05+0.0001);
        patch([0 5 5 0],[0 0 yLimBar yLimBar],colorLightBlue,'LineStyle','none');
        hold on;
        hBar1 = bar(pethtime5ms, peth5ms, 'histc');
        xlabel('Time (ms)','FontSize',fontS);
        ylabel('Rate (Hz)','FontSize',fontS);

    hLight5ms(3) = axes('Position',axpt(1,6,1,1:6,axpt(nCol,nRow,2,4,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
        text(0.1, 0.9, ['Mean firing rate (5 ms): ',num2str(meanFR_5ms,3), ' Hz'],'FontSize',fontM);
        text(0.1, 0.5, ['p-value: ',num2str(p_spike(3),3)],'FontSize',fontM);
    
    set(hBar1,'FaceColor','k','EdgeAlpha',0);
    set(hLight5ms(1),'XLim',winLight,'XTick',[],'YLim',[0 nLight5ms],'YTick',[0 nLight5ms],'YTickLabel',{[],nLight5ms});
    set(hLight5ms(2), 'XLim', winLight, 'XTick', [winLight(1) 0 winLight(2)],'XTickLabel',{winLight(1);0;num2str(winLight(2))},'YLim', [0 yLimBar], 'YTick', [0 yLimBar], 'YTickLabel', {[], yLimBar});
    set(hLight5ms(3),'visible','off');
    set(hLight5ms,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS);
    
% Raster & PSTH (10 ms pulse)
    hLight10ms(1) = axes('Position',axpt(1,6,1,1:3,axpt(nCol,nRow,1,5,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
        plot(xpt10ms{1},ypt10ms{1},'LineStyle','none','Marker','.','MarkerSize',markerS,'Color','k');
        ylabel('Light Trials','FontSize',fontS);
        title('Platform light response (10ms)','FontSize',fontM,'FontWeight','bold');
    
    hLight10ms(2) = axes('Position',axpt(1,6,1,4:6,axpt(nCol,nRow,1,5,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
        yLimBar = ceil(max(peth10ms(:))*1.05+0.0001);
        patch([0 10 10 0],[0 0 yLimBar yLimBar],colorLightBlue,'LineStyle','none');
        hold on;
        hBar1 = bar(pethtime10ms, peth10ms, 'histc');
        xlabel('Time (ms)','FontSize',fontS);
        ylabel('Rate (Hz)','FontSize',fontS);
    
    hLight10ms(3) = axes('Position',axpt(1,6,1,1:6,axpt(nCol,nRow,2,5,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
        text(0.1, 0.9, ['Mean firing rate (10 ms): ',num2str(meanFR_10ms,3), ' Hz'],'FontSize',fontM);
        text(0.1, 0.5, ['p-value: ',num2str(p_spike(4),3)],'FontSize',fontM);
    
    set(hBar1,'FaceColor','k','EdgeAlpha',0);
    set(hLight10ms(1),'XLim',winLight,'XTick',[],'YLim',[0 nLight10ms],'YTick',[0 nLight10ms],'YTickLabel',{[],nLight10ms});
    set(hLight10ms(2), 'XLim', winLight, 'XTick', [winLight(1) 0 winLight(2)],'XTickLabel',{winLight(1);0;num2str(winLight(2))},'YLim', [0 yLimBar], 'YTick', [0 yLimBar], 'YTickLabel', {[], yLimBar});
    set(hLight10ms(3),'visible','off');
    set(hLight10ms,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS);

    print('-painters','-r300',[cellName,'.tiff'],'-dtiff');
    close all;
    fclose('all');
end
end