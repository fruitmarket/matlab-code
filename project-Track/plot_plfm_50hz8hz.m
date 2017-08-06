function plot_plfm_50hz8hz
load('D:\Dropbox\SNL\P2_Track\myParameters.mat');
load Events.mat
mList = mLoad;
nFile = length(mList);
yLim50hz = 240;
yLim8hz = 30;
dur8hz = 147; % for files before 7/3 use 147 um, because of internal program delay.
for iFile = 1:nFile
    [cellPath, cellName, ~] = fileparts(mList{iFile});
    cd(cellPath);
    load(mList{iFile});
    
%% Text information
    nCol = 2;
    nRow = 4;
    fHandle = figure('PaperUnits','centimeters','PaperPosition',[0 0 25 15]); % A4: 210 x 297 mm
    
%% waveform
    yLimWaveform = [min(spkwv(:)), max(spkwv(:))];
    for iCh = 1:4
        hWaveform(iCh) = axes('Position',axpt(4,2,iCh,1,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),midInterval));
        plot(spkwv(iCh,:), 'LineWidth', lineL, 'Color','k');
        if iCh == 4
            line([24 32], [yLimWaveform(2)-50 yLimWaveform(2)-50], 'Color','k', 'LineWidth', lineM);
            line([24 24],[yLimWaveform(2)-50 yLimWaveform(2)], 'Color','k', 'LineWidth',lineM);
        end
    end
    set(hWaveform, 'Visible', 'off','XLim',[1 32], 'YLim',yLimWaveform*1.05);

%% Text information
    hText = axes('Position',axpt(2,1,1,1,axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],midInterval),midInterval));
    text(0,1,['mean FR: ',num2str(meanFR,3),' Hz'],'fontSize',fontL);
    text(0,0.8,['half with: ',num2str(hfvwth,3),' ms'],'fontSize',fontL);
    text(0,0.6,['pv ratio: ',num2str(spkpvr,3)],'fontSize',fontL);
    set(hText,'visible','off');
    
%% Plot (Raster)
    hRaster = axes('Position',axpt(3,2,1,1,axpt(nCol,nRow,1:2,2:4,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
    hPower = patch([-20 100 100 -20],[80 80 160 160],colorGray);
    hold on;
    hLight50hz(1) = patch([0 10 10 0],[0 0 yLim50hz yLim50hz],colorLightBlue);
    hold on;
    hLight50hz(2) = patch([20 30 30 20],[0 0 yLim50hz yLim50hz],colorLightBlue);
    hold on;
    hLight50hz(3) = patch([40 50 50 40],[0 0 yLim50hz yLim50hz],colorLightBlue);
    hold on;
    plot(xpt50hzL1st{1},ypt50hzL1st{1},'LineStyle','none','Marker','.','MarkerSize',markerL,'Color',colorBlack);
    set(hPower,'LineStyle','none');
    set(hLight50hz,'LineStyle','none');
    set(hRaster,'Box','off','TickDir','out','XLim',[-20,100],'XTick',-20:20:100,'YLim',[0,yLim50hz],'YTick',0:80:yLim50hz);
    text(80,40,'1 mW','fontSize',fontL);
    text(80,120,'5 mW','fontSize',fontL);
    text(80,200,'10 mW','fontSize',fontL);
    ylabel('Cycle','fontSize',fontL)
    xlabel('Time (ms)','fontSize',fontL)

%% Plot (Raster 8hz)
    hRaster8hz = axes('Position',axpt(3,2,1:2,2,axpt(nCol,nRow,1:2,2:4,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
    hPower = patch([-500 2000 2000 -500],[10 10 20 20],colorGray);
    for iLight = 1:8
        hLight8hz1(iLight) = patch([(dur8hz*iLight-dur8hz) (dur8hz*iLight-dur8hz)+10 (dur8hz*iLight-dur8hz)+10 (dur8hz*iLight-dur8hz)],[0 0 yLim8hz yLim8hz],colorLightBlue);
        hold on;
        hLight8hz2(iLight) = patch([(dur8hz*iLight-dur8hz)+20 (dur8hz*iLight-dur8hz)+30 (dur8hz*iLight-dur8hz)+30 (dur8hz*iLight-dur8hz)+20],[0 0 yLim8hz yLim8hz],colorLightBlue);
        hold on;
        hLight8hz3(iLight) = patch([(dur8hz*iLight-dur8hz)+40 (dur8hz*iLight-dur8hz)+50 (dur8hz*iLight-dur8hz)+50 (dur8hz*iLight-dur8hz)+40],[0 0 yLim8hz yLim8hz],colorLightBlue);
        hold on;
    end
    plot(xpt8hz{1},ypt8hz{1},'LineStyle','none','Marker','.','MarkerSize',markerL,'Color',colorBlack);
    set(hRaster8hz,'Box','off','TickDir','out','XLim',[-500 2000], 'XTick',[0:dur8hz:1000,1500,2000],'YLim',[0, yLim8hz],'YTick',0:10:30);
    set(hPower,'LineStyle','none');
    set(hLight8hz1, 'LineStyle','none');
    set(hLight8hz2, 'LineStyle','none');
    set(hLight8hz3, 'LineStyle','none');
    text(1700,5,'1 mW','fontSize',fontL);
    text(1700,15,'5 mW','fontSize',fontL);
    text(1700,25,'10 mW','fontSize',fontL);
    ylabel('Cycle','fontSize',fontL);
    xlabel('Time (ms)','fontSize',fontL);
    
%% Plot (Fidelity)
    hFidel = axes('Position',axpt(3,2,2,1,axpt(nCol,nRow,1:2,2:4,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
    plot([1,2,3],[spkFidel_1,spkFidel_2,spkFidel_3],'-o','color',colorBlack,'markerFaceColor',colorGray);
    
    set(hFidel,'Box','off','TickDir','out','XLim',[0,4],'XTick',[1,2,3],'XTickLabel',{'1st','2nd','3rd'},'YLIm',[0,100]);
    ylabel('Fidelity (%)','fontSize',fontL)
%% Plot (Spike number)
    hSpike = axes('Position',axpt(3,2,3,1,axpt(nCol,nRow,1:2,2:4,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
    plot([1,2,3],[spkLight_1,spkLight_2,spkLight_3],'-o','color',colorBlack,'markerFaceColor',colorGray);
    
    set(hSpike,'Box','off','TickDir','out','XLim',[0,4],'XTick',[1,2,3],'XTickLabel',{'1st','2nd','3rd'});
    ylabel('Spike number','fontSize',fontL);
    
    print('-painters','-r300','-dtiff',[cellName,'.tif']);
%     print('-painters','-r300','-dtiff',['cellID_',num2str(cellID{iFile)),'.tif']);
    close;
end