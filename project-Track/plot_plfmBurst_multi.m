function plot_plfmBurst_multi(matFile,cellID,saveDir)

load('E:\Dropbox\SNL\P2_Track\myParameters.mat');
nFile = length(matFile);

nCol = 10;
nRow = 8;

for iFile = 1:nFile
    [cellDir, cellName, ~] = fileparts(matFile{iFile});
    cellDirSplit = regexp(cellDir,'\','split');
    cellFigName = strcat(cellDirSplit(end-1),'_',cellDirSplit(end),'_',cellName);
    
    cd(cellDir);
    load(matFile{iFile});
    load('Events.mat');
    
    fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});
% information
    hText = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1:4,1:2,[0.05 0.1 0.85 0.85],tightInterval),wideInterval));
        text(0,0.9,matFile{iFile}, 'FontSize',fontL, 'Interpreter','none','FontWeight','bold');
        text(0.1,0.8,['Mean firing rate (PRE): ',num2str(meanFR_PRE,3), ' Hz'], 'FontSize',fontL);
        text(0.1,0.7,['Mean firing rate (STIM): ',num2str(meanFR_STIM,3), ' Hz'], 'FontSize',fontL);
        text(0.1,0.6,['Mean firing rate (POST): ',num2str(meanFR_POST,3), ' Hz'], 'FontSize',fontL);
        text(0.1,0.5,['Spike width: ',num2str(spkwth,3),' us'], 'FontSize',fontL);
        text(0.1,0.4,['Half-valley width: ',num2str(hfvwth,3),' us'], 'FontSize',fontL);
        text(0.1,0.3,['Peak valley ratio: ',num2str(spkpvr,3)], 'FontSize',fontL);
    set(hText,'visible','off');

%% Waveform
    yLimWaveform = [min(spkwv(:)), max(spkwv(:))];
    for iCh = 1:4
        hWaveform(iCh) = axes('Position',axpt(4,1,iCh,1,axpt(nCol,nRow,4:6,2,[0.1 0.35 0.85 0.60],tightInterval),wideInterval));
        plot(spkwv(iCh,:), 'LineWidth', lineL, 'Color','k');
        if iCh == 4
            line([24 32], [yLimWaveform(2)-50 yLimWaveform(2)-50], 'Color','k', 'LineWidth', lineM);
            line([24 24],[yLimWaveform(2)-50 yLimWaveform(2)], 'Color','k', 'LineWidth',lineM);
        end
    end
    set(hWaveform, 'Visible', 'off','XLim',[1 32], 'YLim',yLimWaveform*1.05);
    
%% Raster & PSTH
    winBurst = [-50 120];
    yLim = [0 nBurst];
    hLight(1) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,1:5,3:5,[0.1 0.1 0.85 0.85],wideInterval),wideInterval));
    plot(xptLight{1},yptLight{1},'LineStyle','none','Marker','.','MarkerSize',markerS+1,'Color','k');
    for iLight = 1:nPulse
        hold on;
        pLight(iLight) = patch([20*iLight-20, 20*iLight-10, 20*iLight-10, 20*iLight-20],[0, 0, nBurst, nBurst],colorLLightBlue,'lineStyle','none');
    end
    ylabel('# of Burst Stimulation','FontSize',fontL);
    uistack(pLight,'bottom');
    
% PSTH
    hLight(2) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,1:5,3:5,[0.1 0.1 0.85 0.85],wideInterval),wideInterval));
    yLimBar = ceil(max(pethLight(:))*1.05+0.0001);
    for iLight = 1:nPulse
        hold on;
        pLight2(iLight) = patch([20*iLight-20, 20*iLight-10, 20*iLight-10, 20*iLight-20],[0, 0, nBurst, nBurst],colorLLightBlue,'lineStyle','none');
    end
    hBarLight = bar(pethtimeLight, pethLight, 'histc');
    set(hBarLight,'FaceColor','k','EdgeAlpha',0);
    
    set(hLight,'Box','off','TickDir','out','LineWidth',lineM,'FontSize',fontL,'TickLength',[0.03 0.03]);
    set(hLight(1),'XLim',winBurst,'XTick',[winBurst(1), 0:20:20*nPulse, winBurst(2)],'XTickLabel',[],'YLim',yLim,'YTick',0:10:50);
    set(hLight(2), 'XLim', winBurst, 'XTick',[winBurst(1), 0:20:20*nPulse, winBurst(2)],'YLim', [0 yLimBar]);
    
    ylabel('Rate (Hz)','FontSize',fontL);
    xlabel('Time (ms)','FontSize',fontL);
    align_ylabel(hLight);
%%
    hLightInfo = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,6:10,3:5,[0.05 0.1 0.85 0.85],wideInterval),wideInterval));
        text(0,0.9,['mean Inter-burst-interval: ',num2str(ibi_mean,3),' ms'],'FontSize',fontL, 'Interpreter','none');
        text(0,0.8,['std Inter-burst-interval: ',num2str(ibi_std,3),' ms'],'FontSize',fontL);
        text(0,0.7,['# of evoked burst trial (>2 spikes by light): ',num2str(n_evoBurst,3)], 'FontSize',fontL);
        text(0,0.6,['% of evoked burst: ',num2str(ratio_burst,3), '%'],'FontSize',fontL);
        text(0,0.5,['# of spike at each light: ',num2str(sum_re_evoSpike)],'FontSize',fontL);
    set(hLightInfo,'visible','off');
    
%%
    cd(saveDir);
    print('-painters','-r300','-dtiff',['cellID_',num2str(cellID(iFile)),'.tif']);
    close all;
    fclose('all');
end
end