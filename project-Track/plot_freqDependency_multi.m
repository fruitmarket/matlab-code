function plot_freqDependency_multi(matFile,cellID,saveDir)
load('D:\Dropbox\SNL\P2_Track\myParameters.mat');

winCri1hz = [0, 15500];
winCri2hz = [0, 8000];
winCri8hz = [0, 2500];
winCri20hz = [0 1000];
winCri50hz = [0 1000];
winCri_ori = [-5, 20];

win1hzPlot = [-500, 14500];
win2hzPlot = [-500, 7500];
win8hzPlot = [-250, 2000];
win20hzPlot = [-100 1000];
win50hzPlot = [-100 500];

binSize = 2;
resolution = 10;

nFile = length(matFile);

nTrial = 20;
nTrial_ori = 300;
posiTitle = [0, -0.4];

for iFile = 1:nFile
    [cellDir, cellName, ~] = fileparts(matFile{iFile});
    cellDirSplit = regexp(cellDir,'\','split');
    cellFigName = strcat(cellDirSplit(end-1),'_',cellDirSplit(end),'_',cellName);
    
    cd(cellDir);
    load(matFile{iFile});
    load('Events.mat');
    
    fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});
    nRow = 8;
    nCol = 6;

%% waveform
    yLimWaveform = [min(spkwv(:)), max(spkwv(:))];
    for iCh = 1:4
        hWaveform(iCh) = axes('Position',axpt(4,2,iCh,1,axpt(nCol,nRow,1:2,1,[0.1 0.1 0.85 0.85],midInterval),midInterval));
        plot(spkwv(iCh,:), 'LineWidth', lineL, 'Color','k');
        if iCh == 4
            line([24 32], [yLimWaveform(2)-50 yLimWaveform(2)-50], 'Color','k', 'LineWidth', lineM);
            line([24 24],[yLimWaveform(2)-50 yLimWaveform(2)], 'Color','k', 'LineWidth',lineM);
        end
    end
    set(hWaveform, 'Visible', 'off','XLim',[1 32], 'YLim',yLimWaveform*1.05);

%% text information
    hText = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,3:4,1,[0.1 0.1 0.85 0.85],midInterval),midInterval));
    text(0,1,['mean FR: ',num2str(meanFR,3),' Hz'],'fontSize',fontL);
    text(0,0.8,['half with: ',num2str(hfvwth,3),' ms'],'fontSize',fontL);
    text(0,0.6,['pv ratio: ',num2str(spkpvr,3)],'fontSize',fontL);
    set(hText,'visible','off');

%     hPvalue(1) = axes('Position',axpt(nCol,nRow,5,2,[0.1 0.1 0.85 0.85],midInterval));
%     text(0.1,0.5,['p-value: ',num2str(pLR_Plfm1hz,3)],'fontSize',fontL);
%     hPvalue(2) = axes('Position',axpt(nCol,nRow,5,3,[0.1 0.1 0.85 0.85],midInterval));
%     text(0.1,0.5,['p-value: ',num2str(pLR_Plfm2hz,3)],'fontSize',fontL);
%     hPvalue(3) = axes('Position',axpt(nCol,nRow,5,4,[0.1 0.1 0.85 0.85],midInterval));
%     text(0.1,0.5,['p-value: ',num2str(pLR_Plfm8hz,3)],'fontSize',fontL);
%     hPvalue(4) = axes('Position',axpt(nCol,nRow,5,5,[0.1 0.1 0.85 0.85],midInterval));
%     text(0.1,0.5,['p-value: ',num2str(pLR_Plfm20hz,3)],'fontSize',fontL);
%     hPvalue(5) = axes('Position',axpt(nCol,nRow,5,6,[0.1 0.1 0.85 0.85],midInterval));
%     text(0.1,0.5,['p-value: ',num2str(pLR_Plfm50hz,3)],'fontSize',fontL);
%     set(hPvalue,'visible','off');

%% Original 1Hz
    hLight1hzOri(1) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,1,2,[0.1 0.1 0.85 0.85],midInterval),midInterval));
    hLBar(1) = rectangle('Position',[0,0,10,nTrial_ori],'LineStyle','none','FaceColor',colorLLightBlue);
    hold on;
    hLBar(2) = rectangle('Position',[0,270,10,nTrial_ori/10],'LineStyle','none','FaceColor',colorBlue);
    hold on;
    plot(xpt1hz_ori{1},ypt1hz_ori{1},'LineStyle','none','Marker','.','MarkerSize',markerL,'Color','k');
    ylabel('Trials','FontSize',fontL);

    hLight1hzOri(2) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,1,2,[0.1 0.1 0.85 0.85],midInterval),midInterval));
    yLim1hzOri = ceil(max(peth1hzConv_ori*1.1)+0.001);
    plot(pethtime1hz_ori,peth1hzConv_ori,'LineStyle','-','LineWidth',lineM,'Color',colorBlack);

    xlabel('Time (ms)','FontSize',fontL);
    ylabel('Rate (Hz)', 'FontSize', fontL);
    align_ylabel(hLight1hzOri);

    set(hLight1hzOri(1),'XLim',winCri_ori,'XTick',[],'YLim',[0, nTrial_ori],'YTick',[0, nTrial_ori],'YTickLabel',{0, nTrial_ori});
    set(hLight1hzOri(2), 'XLim', winCri_ori, 'XTick', [0,winCri_ori(2)],'YLim', [0 yLim1hzOri], 'YTick', [0 yLim1hzOri], 'YTickLabel', {[], yLim1hzOri});
    set(hLight1hzOri,'Box','off','TickDir','out','fontSize',fontL);            

%% Original 2Hz
    hLight2hzOri(1) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,1,3,[0.1 0.1 0.85 0.85],midInterval),midInterval));
    hLBar(1) = rectangle('Position',[0,0,10,nTrial_ori],'LineStyle','none','FaceColor',colorLLightBlue);
    hold on;
    hLBar(2) = rectangle('Position',[0,270,10,nTrial_ori/10],'LineStyle','none','FaceColor',colorBlue);
    hold on;
    plot(xpt2hz_ori{1},ypt2hz_ori{1},'LineStyle','none','Marker','.','MarkerSize',markerL,'Color','k');
    ylabel('Trials','FontSize',fontL);

    hLight2hzOri(2) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,1,3,[0.1 0.1 0.85 0.85],midInterval),midInterval));
    yLim2hzOri = ceil(max(peth2hzConv_ori*1.1)+0.001);
    plot(pethtime2hz_ori,peth2hzConv_ori,'LineStyle','-','LineWidth',lineM,'Color',colorBlack);

    xlabel('Time (ms)','FontSize',fontL);
    ylabel('Rate (Hz)', 'FontSize', fontL);
    align_ylabel(hLight2hzOri);

    set(hLight2hzOri(1),'XLim',winCri_ori,'XTick',[],'YLim',[0, nTrial_ori],'YTick',[0, nTrial_ori],'YTickLabel',{0, nTrial_ori});
    set(hLight2hzOri(2), 'XLim', winCri_ori, 'XTick', [0,winCri_ori(2)],'YLim', [0 yLim2hzOri], 'YTick', [0 yLim2hzOri], 'YTickLabel', {[], yLim2hzOri});
    set(hLight2hzOri,'Box','off','TickDir','out','fontSize',fontL);

%% Original 8Hz
    hLight8hzOri(1) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,1,4,[0.1 0.1 0.85 0.85],midInterval),midInterval));
    hLBar(1) = rectangle('Position',[0,0,10,nTrial_ori],'LineStyle','none','FaceColor',colorLLightBlue);
    hold on;
    hLBar(2) = rectangle('Position',[0,270,10,nTrial_ori/10],'LineStyle','none','FaceColor',colorBlue);
    hold on;
    plot(xpt8hz_ori{1},ypt8hz_ori{1},'LineStyle','none','Marker','.','MarkerSize',markerL,'Color','k');
    ylabel('Trials','FontSize',fontL);

    hLight8hzOri(2) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,1,4,[0.1 0.1 0.85 0.85],midInterval),midInterval));
    yLim8hzOri = ceil(max(peth8hzConv_ori*1.1)+0.001);
    plot(pethtime8hz_ori,peth8hzConv_ori,'LineStyle','-','LineWidth',lineM,'Color',colorBlack);

    xlabel('Time (ms)','FontSize',fontL);
    ylabel('Rate (Hz)','FontSize',fontL);
    align_ylabel(hLight8hzOri);

    set(hLight8hzOri(1),'XLim',winCri_ori,'XTick',[],'YLim',[0, nTrial_ori],'YTick',[0, nTrial_ori],'YTickLabel',{0, nTrial_ori});
    set(hLight8hzOri(2), 'XLim', winCri_ori, 'XTick', [0,winCri_ori(2)],'YLim', [0 yLim8hzOri], 'YTick', [0 yLim8hzOri], 'YTickLabel', {[], yLim8hzOri});
    set(hLight8hzOri,'Box','off','TickDir','out','fontSize',fontL);

%% Original 20Hz
    hLight20hzOri(1) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,1,5,[0.1 0.1 0.85 0.85],midInterval),midInterval));
    hLBar(1) = rectangle('Position',[0,0,10,nTrial_ori],'LineStyle','none','FaceColor',colorLLightBlue);
    hold on;
    hLBar(2) = rectangle('Position',[0,270,10,nTrial_ori/10],'LineStyle','none','FaceColor',colorBlue);
    hold on;
    plot(xpt20hz_ori{1},ypt20hz_ori{1},'LineStyle','none','Marker','.','MarkerSize',markerL,'Color','k');
    ylabel('Trials','FontSize',fontL);

    hLight20hzOri(2) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,1,5,[0.1 0.1 0.85 0.85],midInterval),midInterval));
    yLim20hzOri = ceil(max(peth20hzConv_ori*1.1)+0.001);
    plot(pethtime20hz_ori,peth20hzConv_ori,'LineStyle','-','LineWidth',lineM,'Color',colorBlack);

    xlabel('Time (ms)','FontSize',fontL);
    ylabel('Rate (Hz)','FontSize',fontL);
    align_ylabel(hLight20hzOri);

    set(hLight20hzOri(1),'XLim',winCri_ori,'XTick',[],'YLim',[0, nTrial_ori],'YTick',[0, nTrial_ori],'YTickLabel',{0, nTrial_ori});
    set(hLight20hzOri(2), 'XLim', winCri_ori, 'XTick', [0,10,winCri_ori(2)],'YLim', [0 yLim20hzOri], 'YTick', [0 yLim20hzOri], 'YTickLabel', {[], yLim20hzOri});
    set(hLight20hzOri,'Box','off','TickDir','out','fontSize',fontL);

%% Original 50Hz
    hLight50hzOri(1) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,1,6,[0.1 0.1 0.85 0.85],midInterval),midInterval));
    hLBar(1) = rectangle('Position',[0,0,10,nTrial_ori],'LineStyle','none','FaceColor',colorLLightBlue);
    hold on;
    hLBar(2) = rectangle('Position',[0,270,10,nTrial_ori/10],'LineStyle','none','FaceColor',colorBlue);
    hold on;
    plot(xpt50hz_ori{1},ypt50hz_ori{1},'LineStyle','none','Marker','.','MarkerSize',markerL,'Color','k');
    ylabel('Trials','FontSize',fontL);

    hLight50hzOri(2) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,1,6,[0.1 0.1 0.85 0.85],midInterval),midInterval));
    yLim50hzOri = ceil(max(peth50hzConv_ori*1.1)+0.001);
    plot(pethtime50hz_ori,peth50hzConv_ori,'LineStyle','-','LineWidth',lineM,'Color',colorBlack);

    xlabel('Time (ms)','FontSize',fontL);
    ylabel('Rate (Hz)','FontSize',fontL);
    align_ylabel(hLight50hzOri);

    set(hLight50hzOri(1),'XLim',winCri_ori,'XTick',[],'YLim',[0, nTrial_ori],'YTick',[0, nTrial_ori],'YTickLabel',{0, nTrial_ori});
    set(hLight50hzOri(2), 'XLim', winCri_ori, 'XTick', [0,10,winCri_ori(2)],'YLim', [0 yLim50hzOri], 'YTick', [0 yLim50hzOri], 'YTickLabel', {[], yLim50hzOri});
    set(hLight50hzOri,'Box','off','TickDir','out','fontSize',fontL);
%% Each light (1hz)
    hFreq1hz(1) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,2:4,2,[0.1 0.1 0.85 0.85],midInterval),midInterval));
    for iLight = 1:15
        hLBar(1) = rectangle('Position',[1000*iLight-1000, 0, 10, nTrial_ori],'LineStyle','none','FaceColor',colorLLightBlue);
        hold on;
        hLBar(2) = rectangle('Position',[1000*iLight-1000, 18, 10, nTrial_ori/10],'LineStyle','none','FaceColor',colorBlue);
        hold on;
    end
    plot(xpt1hz{1},ypt1hz{1},'LineStyle','none','Marker','.','MarkerSize',markerL,'Color','k');

    hFreq1hz(2) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,2:4,2,[0.1 0.1 0.85 0.85],midInterval),midInterval));
    yLim1hz = ceil(max(peth1hzConv)*1.1+0.001);
    plot(pethtime1hz, peth1hzConv,'LineStyle','-','LineWidth',lineM,'Color',colorBlack);
    xlabel('Time (ms)','FontSize',fontL);

    set(hFreq1hz(1),'XLim',win1hzPlot,'XTick',[],'YLim',[0, nTrial],'YTick',[0, nTrial],'YTickLabel',{0, nTrial});
    set(hFreq1hz(2), 'XLim', win1hzPlot, 'XTick', [0:3000:win1hzPlot(2)],'YLim', [0 yLim1hz], 'YTick', [0 yLim1hz], 'YTickLabel', {[], yLim1hz});
    set(hFreq1hz,'Box','off','TickDir','out','fontSize',fontL);

%% Each light (2hz)
    hFreq2hz(1) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,2:4,3,[0.1 0.1 0.85 0.85],midInterval),midInterval));
    for iLight = 1:15
        hLBar(1) = rectangle('Position',[500*iLight-500, 0, 10, nTrial_ori],'LineStyle','none','FaceColor',colorLLightBlue);
        hold on;
        hLBar(2) = rectangle('Position',[500*iLight-500, 18, 10, nTrial_ori/10],'LineStyle','none','FaceColor',colorBlue);
        hold on;
    end
    plot(xpt2hz{1},ypt2hz{1},'LineStyle','none','Marker','.','MarkerSize',markerL,'Color','k');

    hFreq2hz(2) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,2:4,3,[0.1 0.1 0.85 0.85],midInterval),midInterval));
    yLim2hz = ceil(max(peth2hzConv)*1.1+0.001);
    plot(pethtime2hz, peth2hzConv,'LineStyle','-','LineWidth',lineM,'Color',colorBlack);
    xlabel('Time (ms)','FontSize',fontL);

    set(hFreq2hz(1),'XLim',win2hzPlot,'XTick',[],'YLim',[0, nTrial],'YTick',[0, nTrial],'YTickLabel',{0, nTrial});
    set(hFreq2hz(2), 'XLim', win2hzPlot, 'XTick', [0:2000:win2hzPlot(2)],'YLim', [0 yLim2hz], 'YTick', [0 yLim2hz], 'YTickLabel', {[], yLim2hz});
    set(hFreq2hz,'Box','off','TickDir','out','fontSize',fontL);

%% Each light (8Hz)
    hFreq8hz(1) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,2:4,4,[0.1 0.1 0.85 0.85],midInterval),midInterval));
    for iLight = 1:15
        hold on;
        hLBar(1) = rectangle('Position',[125*iLight-125, 0, 10, 20],'LineStyle','none','FaceColor',colorLLightBlue);
        hold on;
        hLBar(2) = rectangle('Position',[125*iLight-125, 18, 10, 2],'LineStyle','none','FaceColor',colorBlue);
    end
    plot(xpt8hz{1},ypt8hz{1},'LineStyle','none','Marker','.','MarkerSize',markerL,'Color','k');

    hFreq8hz(2) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,2:4,4,[0.1 0.1 0.85 0.85],midInterval),midInterval));
    yLim8hz = ceil(max(peth8hzConv)*1.1+0.001);
    plot(pethtime8hz,peth8hzConv,'LineStyle','-','LineWidth',lineM,'Color',colorBlack);
    xlabel('Time (ms)','FontSize',fontL);

    set(hFreq8hz(1),'XLim',win8hzPlot,'XTick',[],'YLim',[0, nTrial],'YTick',[0, nTrial],'YTickLabel',{0, nTrial});
    set(hFreq8hz(2), 'XLim', win8hzPlot, 'XTick', [0:500:win8hzPlot(2)],'YLim',[0, yLim8hz],'YTick',[0 yLim8hz],'YTickLabel',{[], yLim8hz});
    set(hFreq8hz,'Box','off','TickDir','out','fontSize',fontL);

%% Each light (20Hz)
    hFreq20hz(1) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,2:4,5,[0.1 0.1 0.85 0.85],midInterval),midInterval));
    for iLight = 1:15
        hold on;
        hLBar(1) = rectangle('Position',[50*iLight-50, 0, 10, 20],'LineStyle','none','FaceColor',colorLLightBlue);
        hold on;
        hLBar(2) = rectangle('Position',[50*iLight-50, 18, 10, 2],'LineStyle','none','FaceColor',colorBlue);
    end
    plot(xpt20hz{1},ypt20hz{1},'LineStyle','none','Marker','.','MarkerSize',markerL,'Color','k');

    hFreq20hz(2) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,2:4,5,[0.1 0.1 0.85 0.85],midInterval),midInterval));
    yLim20hz = ceil(max(peth20hzConv)*1.1+0.001);
    plot(pethtime20hz,peth20hzConv,'LineStyle','-','LineWidth',lineM,'Color',colorBlack);
    xlabel('Time (ms)','FontSize',fontL);

    set(hFreq20hz(1),'XLim',win20hzPlot,'XTick',[],'YLim',[0, nTrial],'YTick',[0, nTrial],'YTickLabel',{0, nTrial});
    set(hFreq20hz(2), 'XLim', win20hzPlot, 'XTick', [0:500:win20hzPlot(2)],'YLim',[0, yLim20hz],'YTick',[0 yLim20hz],'YTickLabel',{[], yLim20hz});
    set(hFreq20hz,'Box','off','TickDir','out','fontSize',fontL);

%% Each light (50Hz)
    hFreq50hz(1) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,2:4,6,[0.1 0.1 0.85 0.85],midInterval),midInterval));
    for iLight = 1:15
        hold on;
        hLBar(1) = rectangle('Position',[20*iLight-20, 0, 10, 20],'LineStyle','none','FaceColor',colorLLightBlue);
        hold on;
        hLBar(2) = rectangle('Position',[20*iLight-20, 18, 10, 2],'LineStyle','none','FaceColor',colorBlue);
    end
    plot(xpt50hz{1},ypt50hz{1},'LineStyle','none','Marker','.','MarkerSize',markerL,'Color','k');

    hFreq50hz(2) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,2:4,6,[0.1 0.1 0.85 0.85],midInterval),midInterval));
    yLim50hz = ceil(max(peth50hzConv)*1.1+0.001);
    plot(pethtime50hz,peth50hzConv,'LineStyle','-','LineWidth',lineM,'Color',colorBlack);
    xlabel('Time (ms)','FontSize',fontL);

    set(hFreq50hz(1),'XLim',win50hzPlot,'XTick',[],'YLim',[0, nTrial],'YTick',[0, nTrial],'YTickLabel',{0, nTrial});
    set(hFreq50hz(2), 'XLim', win50hzPlot, 'XTick', [0:500:win50hzPlot(2)],'YLim',[0, yLim50hz],'YTick',[0 yLim50hz],'YTickLabel',{[], yLim50hz});
    set(hFreq50hz,'Box','off','TickDir','out','fontSize',fontL);

%% Light probability
    hFrequency = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,5:6,1:2,[0.1 0.1 0.85 0.85],midInterval),midInterval));
%     plot([1,2,3,4,5],[lightProb1hz_dr,lightProb2hz_dr,lightProb8hz_dr,lightProb20hz_dr,lightProb50hz_dr],'o','MarkerEdgeColor','k','MarkerSize',markerL);
    plot([1,2,3,4,5],[lightProb1hz,lightProb2hz,lightProb8hz,lightProb20hz,lightProb50hz],'o','MarkerEdgeColor','k','MarkerSize',markerL);
    
    set(hFrequency,'Box','off','TickDir','out','fontSize',fontL);
    set(hFrequency,'XLim',[0,6],'XTick',1:5,'XTickLabel',{'1'; '2'; '8'; '20'; '50'},'YLim',[0,60]);
    ylabel('Spike P, %','fontSize',fontL);
    xlabel('Frequency (Hz)','fontSize',fontL);
    
    
%% 8 Hz PSTH
    hPETH = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,5:6,4,[0.1 0.1 0.85 0.85],midInterval),midInterval));
%     barPETH = bar(pethtimeLight, pethLight
    pLight = patch([0 10 10 0],[0 0 max(pethLight8hz)*1.2 max(pethLight8hz)*1.2],colorLLightBlue);
    hold on;
    hbar = bar(pethtimeLight8hz, pethLight8hz, 'histc');
    set(hbar, 'FaceColor','k','EdgeAlpha',0);
    if max(pethLight8hz) ~= 0
        text(30,max(pethLight8hz)*0.9,['latency: ',num2str(latency,3),' ms'],'fontSize',fontM);
        set(hPETH, 'TickDir','out','Box','off','XLim',[-20 70],'YLim',[0, max(pethLight8hz)*1.2],'fontSize',fontM); 
    else
        text(30,0.8,['latency: ',num2str(latency,3),' ms'],'fontSize',fontM);
        set(hPETH, 'TickDir','out','Box','off','XLim',[-20 70],'YLim',[0, 1],'fontSize',fontM); 
    end
    set(pLight,'LineStyle','none');
    
    hPLatency = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,5:6,5,[0.1 0.1 0.85 0.85],midInterval),midInterval));
    text(0.5,2,['p-010: ',num2str(p_latency(1),3),' ms'],'fontSize',fontM);
    text(0.5,1,['p-020: ',num2str(p_latency(2),3),' ms'],'fontSize',fontM);
    set(hPLatency,'visible','off','fontSize',fontM,'XLim',[0,4],'YLim',[0,3]);
    
    cd(saveDir);
%     print('-painters','-r300','-dtiff',[cellFigName{1},'.tif']);
    print('-painters','-r300','-dtiff',['cellID_',num2str(cellID(iFile)),'.tif']);
    close;
end

function spikeTime = spikeWin(spikeData, eventTime, win)
% spikeWin makes raw spikeData to eventTime aligned data
%   spikeData: raw data from MClust. Unit must be ms.
%   eventTime: each output cell will be eventTime aligned spike data. unit must be ms
%   win: spike within windows will be included. unit must be ms.
narginchk(3,3);

if isempty(eventTime); spikeTime =[]; return; end;
nEvent = size(eventTime);
spikeTime = cell(nEvent);
for iEvent = 1:nEvent(1)
    for jEvent = 1:nEvent(2)
        timeIndex = [];
        if isnan(eventTime(iEvent,jEvent)); continue; end;
        [~,timeIndex] = histc(spikeData,eventTime(iEvent,jEvent)+win);
        if isempty(timeIndex); continue; end;
        spikeTime{iEvent,jEvent} = spikeData(logical(timeIndex))-eventTime(iEvent,jEvent);
    end
end
function [xpt,ypt,spikeBin,spikeHist,spikeConv,spikeConvZ] = rasterPETH(spikeTime, trialIndex, win, binSize, resolution, dot)
% raterPSTH converts spike time into raster plot
%   spikeTime: cell array. Each cell contains vector array of spike times per each trial unit is ms.
%   trialIndex: number of raws should be same as number of trials (length of spikeTime)
%   win: window range of xpt. should be 2 numbers. unit is msec.
%   resolution: sigma for convolution = binsize * resolution.
%   dot: 1-dot, 0-line
%   unit of xpt will be msec.
narginchk(5,6);
if isempty(spikeTime) || isempty(trialIndex) || length(spikeTime) ~= size(trialIndex,1) || length(win) ~= 2
    xpt = []; ypt = []; spikeBin = []; spikeHist = []; spikeConv = []; spikeConvZ = [];
    return;
end;

spikeBin = win(1):binSize:win(2); % unit: msec
nSpikeBin = length(spikeBin);

nTrial = length(spikeTime);
nCue = size(trialIndex,2);
trialResult = sum(trialIndex);
resultSum = [0 cumsum(trialResult)];

yTemp = [0:nTrial-1; 1:nTrial; NaN(1,nTrial)]; % template for ypt
xpt = cell(1,nCue);
ypt = cell(1,nCue);
spikeHist = zeros(nCue,nSpikeBin);
spikeConv = zeros(nCue,nSpikeBin);

for iCue = 1:nCue
    % raster
    nSpikePerTrial = cellfun(@length,spikeTime(trialIndex(:,iCue)));
    nSpikeTotal = sum(nSpikePerTrial);
    if nSpikeTotal == 0; continue; end;
    
    spikeTemp = cell2mat(spikeTime(trialIndex(:,iCue)))';
    
    xptTemp = [spikeTemp;spikeTemp;NaN(1,nSpikeTotal)];
    if (nargin == 6) && (dot==1)
        xpt{iCue} = xptTemp(2,:);
    else
        xpt{iCue} = xptTemp(:);
    end
    
    yptTemp = [];
    for iy = 1:trialResult(iCue)
        yptTemp = [yptTemp repmat(yTemp(:,resultSum(iCue)+iy),1,nSpikePerTrial(iy))];
    end
    if (nargin == 6) && (dot==1)
        ypt{iCue} = yptTemp(2,:);
    else
        ypt{iCue} = yptTemp(:);
    end
    
    % psth
    spkhist_temp = histc(spikeTemp,spikeBin)/(binSize/10^3*trialResult(iCue));
    spkconv_temp = conv(spkhist_temp,fspecial('Gaussian',[1 5*resolution],resolution),'same');
    spikeHist(iCue,:) = spkhist_temp;
    spikeConv(iCue,:) = spkconv_temp;
end

totalHist = histc(cell2mat(spikeTime),spikeBin)/(binSize/10^3*nTrial);
fireMean = mean(totalHist);
fireStd = std(totalHist);
spikeConvZ = (spikeConv-fireMean)/fireStd;    