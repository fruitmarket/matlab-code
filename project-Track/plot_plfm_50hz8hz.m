function plot_plfm_50hz8hz
clearvars;

currDir = cd;
rtDir = 'D:\Dropbox\SNL\P2_Track';
cd(rtDir);

load('myParameters.mat');
cd(currDir);

load Events.mat
mList = mLoad;
nFile = length(mList);
yLim = 240;

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
    hRaster = axes('Position',axpt(3,1,1,1,axpt(nCol,nRow,1:2,2:4,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
    hLight(1) = patch([0 10 10 0],[0 0 yLim yLim],colorLightBlue);
    hold on;
    hLight(2) = patch([20 30 30 20],[0 0 yLim yLim],colorLightBlue);
    hold on;
    hLight(3) = patch([40 50 50 40],[0 0 yLim yLim],colorLightBlue);
    hold on;
    plot(xpt{1},ypt{1},'LineStyle','none','Marker','.','MarkerSize',markerL,'Color',colorBlack);
    
    set(hLight,'LineStyle','none');
    set(hRaster,'Box','off','TickDir','out','XLim',[-20,100],'XTick',-20:20:100,'YLim',[0,yLim],'YTick',[0:50:yLim,yLim]);
    ylabel('Cycle','fontSize',fontL)
    xlabel('Time (ms)','fontSize',fontL)

%% Plot (Fidelity)
    hFidel = axes('Position',axpt(3,1,2,1,axpt(nCol,nRow,1:2,2:4,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
    plot([1,2,3],[spkFidel_1,spkFidel_2,spkFidel_3],'-o','color',colorBlack,'markerFaceColor',colorGray);
    
    set(hFidel,'Box','off','TickDir','out','XLim',[0,4],'XTick',[1,2,3],'XTickLabel',{'1st','2nd','3rd'},'YLIm',[0,100]);
    ylabel('Fidelity (%)','fontSize',fontL)
%% Plot (Spike number)
    hSpike = axes('Position',axpt(3,1,3,1,axpt(nCol,nRow,1:2,2:4,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
    plot([1,2,3],[spkLight_1,spkLight_2,spkLight_3],'-o','color',colorBlack,'markerFaceColor',colorGray);
    
    set(hSpike,'Box','off','TickDir','out','XLim',[0,4],'XTick',[1,2,3],'XTickLabel',{'1st','2nd','3rd'});
    ylabel('Spike number','fontSize',fontL);
    
    print('-painters','-r300','-dtiff',[cellName,'.tif']);
%     print('-painters','-r300','-dtiff',['cellID_',num2str(cellID{iFile)),'.tif']);
end