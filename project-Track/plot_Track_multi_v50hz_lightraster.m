function plot_Track_multi_v50hz_lightraster(fileList, cellID, saveDir)
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

% light stimulation zone raster plot
    hLight = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1:10,3:5,[0.15 0.15 0.80 0.80],tightInterval),wideInterval));
    plot([xptPre1st{1},xptLight1st{1},xptPost1st{1}],[yptPre1st{1},yptLight1st{1}+30,yptPost1st{1}+60],'marker','.','markerSize',markerS,'LineStyle','none','color','k');
    hold on;
    for iPulse = 1:minPulseTrack50hz
        pminLight(iPulse) = patch([20*iPulse-20 20*iPulse-10 20*iPulse-10 20*iPulse-20],[31 31 60 60],colorLLightBlue,'lineStyle','none');
        hold on;
    end
%     for iPulse = 1:maxPulseTrack50hz
%         pmaxLight(iPulse) = patch([20*iPulse-20 20*iPulse-10 20*iPulse-10 20*iPulse-20],[45 45 60 60],colorLLightBlue,'lineStyle','none');
%         hold on;
%     end
%     line([-500, 5000],[30,30],'color',colorLightRed,'lineWidth',lineM);
    set(hLight,'TickDir','out','Box','off','XLim',[-500, 2000],'YLim',[0,90],'XTick',[-500:500:2000],'YTick',[0:30:90],'fontSize',fontM);
    text(500,95,['min light pulse: ',num2str(minPulseTrack50hz)],'fontSize',fontM);
    xlabel('Time (ms)','fontSize',fontM);

% Cell ID
    hID = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,10,1,[0.11 0.18 0.80 0.80],tightInterval),wideInterval));
    text(1, 1, ['Cell ID: ',num2str(cellID(iFile))],'FontSize',fontL,'fontWeight','bold');
    set(hID,'visible','off');
    
    cd(saveDir);
    print('-painters','-r300',['cellID_',num2str(cellID(iFile)),'_light_raster.tif'],'-dtiff');
%     print('-painters','-r300',[cellFigName{1},'_cellID-',num2str(cellID(iFile)),'.tif'],'-dtiff');
    close;
end
% fclose('all');
end