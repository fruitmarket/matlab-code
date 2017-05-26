cd('D:\Dropbox\SNL\P2_Track');
load Info_LFP.mat
load myParameters.mat

fHandle(1) = figure('PaperUnits','centimeters','PaperPosition',[0, 0, 29.7*3, 21*2]);
nCol = 1;
nRow = 4;
iCycle = sortrows(randi(30,2,1));
hPlfmCSC(1) = axes('Position',axpt(nCol,nRow,1,1,axpt(1,1,1,1,[0.10 0.10 0.85 0.85],midInterval),midInterval));
for iLight = 1:nLabLight_act
    hLpatch = patch([125*(iLight-1), 125*(iLight-1)+10,125*(iLight-1)+10,125*(iLight-1)],[0, 0, 30, 30],colorLightBlue,'EdgeColor','none');
    hold on;
end
plot(xpt_act{1},ypt_act{1},'LineStyle','none','Marker','o','MarkerSize',markerS,'Color',colorBlack,'MarkerFaceColor',colorBlack);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Cycle','fontSize',fontL);

for iPlot = 1:length(iCycle)
    hPlfmCSC(iPlot+1) = axes('Position',axpt(nCol,nRow,1,iPlot+1,axpt(1,1,1,1,[0.10 0.10 0.85 0.85],midInterval),midInterval));
    for iLight = 1:nLabLight_act
        hLpatch = patch([125*(iLight-1), 125*(iLight-1)+10,125*(iLight-1)+10,125*(iLight-1)],[yLim_act(1), yLim_act(1), yLim_act(2), yLim_act(2)],colorLightBlue,'EdgeColor','none');
        hold on;
    end
    plot(xpt,cscPlfm8hz_act(iCycle(iPlot),:),'color',colorBlack,'lineWidth',0.8);
    text(-900,yLim_act(2)*2,['raw LFP trace ',num2str(iCycle(iPlot)),'th light cycle'],'fontSize',fontL);
end
hPlfmCSC(4) = axes('Position',axpt(nCol,nRow,1,4,axpt(1,1,1,1,[0.10 0.10 0.85 0.85],midInterval),midInterval));
for iLight = 1:nLabLight_act
    hLpatch = patch([125*(iLight-1), 125*(iLight-1)+10,125*(iLight-1)+10,125*(iLight-1)],[yLim_act(1), yLim_act(1), yLim_act(2), yLim_act(2)],colorLightBlue,'EdgeColor','none');
    hold on;
end
plot(xpt,m_cscPlfm8hz_act,'color',colorBlack,'lineWidth',0.8);
text(-900,yLim_act(2)*0.8,'Average LFP trace','fontSize',fontL);

set(hPlfmCSC,'Box','off','TickDir','out','fontSize',fontM,'XLim',[-1000,2000],'XTick',[-1000,0,2000],'fontSize',fontL);
set(hPlfmCSC(1),'YLim',[0,30],'YTick',[0:5:30]);
formatOut = 'yymmdd';
print('-painters','-r300','-dtiff',['plot_rawLFP_act',datestr(now,formatOut),'.tif']);
% print('-painters','-r300','-depsc',['plot_rasterExample_',datestr(now,formatOut),'.ai']);
close;

%% figure 2
fHandle(2) = figure('PaperUnits','centimeters','PaperPosition',[0, 0, 29.7*3, 21*2]);
nCol = 1;
nRow = 4;
hPlfmCSC(1) = axes('Position',axpt(nCol,nRow,1,1,axpt(1,1,1,1,[0.10 0.10 0.85 0.85],midInterval),midInterval));
for iLight = 1:nLabLight_actDelay
    hLpatch = patch([125*(iLight-1), 125*(iLight-1)+10,125*(iLight-1)+10,125*(iLight-1)],[0, 0, 30, 30],colorLightBlue,'EdgeColor','none');
    hold on;
end
plot(xpt_actDelay{1},ypt_actDelay{1},'LineStyle','none','Marker','o','MarkerSize',markerS,'Color',colorBlack,'MarkerFaceColor',colorBlack);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Cycle','fontSize',fontL);
for iPlot = 1:length(iCycle)
    hPlfmCSC(iPlot+1) = axes('Position',axpt(nCol,nRow,1,iPlot+1,axpt(1,1,1,1,[0.10 0.10 0.85 0.85],midInterval),midInterval));
    for iLight = 1:nLabLight_actDelay
        hLpatch = patch([125*(iLight-1), 125*(iLight-1)+10,125*(iLight-1)+10,125*(iLight-1)],[yLim_actDelay(1), yLim_actDelay(1), yLim_actDelay(2), yLim_actDelay(2)],colorLightBlue,'EdgeColor','none');
        hold on;
    end
    plot(xpt,cscPlfm8hz_actDelay(iCycle(iPlot),:),'color',colorBlack,'lineWidth',0.8);
    text(-900,yLim_actDelay(2)*2,['raw LFP trace ',num2str(iCycle(iPlot)),'th light cycle'],'fontSize',fontL);
end
hPlfmCSC(4) = axes('Position',axpt(nCol,nRow,1,4,axpt(1,1,1,1,[0.10 0.10 0.85 0.85],midInterval),midInterval));
for iLight = 1:nLabLight_ina
    hLpatch = patch([125*(iLight-1), 125*(iLight-1)+10,125*(iLight-1)+10,125*(iLight-1)],[yLim_actDelay(1), yLim_actDelay(1), yLim_actDelay(2), yLim_actDelay(2)],colorLightBlue,'EdgeColor','none');
    hold on;
end
plot(xpt,m_cscPlfm8hz_actDelay,'color',colorBlack,'lineWidth',0.8);
text(-900,yLim_actDelay(2)*0.8,'Average LFP trace','fontSize',fontL);

set(hPlfmCSC,'Box','off','TickDir','out','fontSize',fontM,'XLim',[-1000,2000],'XTick',[-1000,0,2000],'fontSize',fontL);
set(hPlfmCSC(1),'YLim',[0,30],'YTick',[0:5:30]);
print('-painters','-r300','-dtiff',['plot_rawLFP_actDelay_',datestr(now,formatOut),'.tif']);
close;

%% figure 3
fHandle(3) = figure('PaperUnits','centimeters','PaperPosition',[0, 0, 29.7*3, 21*2]);
nCol = 1;
nRow = 4;
hPlfmCSC(1) = axes('Position',axpt(nCol,nRow,1,1,axpt(1,1,1,1,[0.10 0.10 0.85 0.85],midInterval),midInterval));
for iLight = 1:nLabLight_no
    hLpatch = patch([125*(iLight-1), 125*(iLight-1)+10,125*(iLight-1)+10,125*(iLight-1)],[0, 0, 30, 30],colorLightBlue,'EdgeColor','none');
    hold on;
end
plot(xpt_ina{1},ypt_ina{1},'LineStyle','none','Marker','o','MarkerSize',markerS,'Color',colorBlack,'MarkerFaceColor',colorBlack);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Cycle','fontSize',fontL);
for iPlot = 1:length(iCycle)
    hPlfmCSC(iPlot+1) = axes('Position',axpt(nCol,nRow,1,iPlot+1,axpt(1,1,1,1,[0.10 0.10 0.85 0.85],midInterval),midInterval));
    for iLight = 1:nLabLight_ina
        hLpatch = patch([125*(iLight-1), 125*(iLight-1)+10,125*(iLight-1)+10,125*(iLight-1)],[yLim_ina(1), yLim_ina(1), yLim_ina(2), yLim_ina(2)],colorLightBlue,'EdgeColor','none');
        hold on;
    end
    plot(xpt,cscPlfm8hz_ina(iCycle(iPlot),:),'color',colorBlack,'lineWidth',0.8);
    text(-900,yLim_ina(2)*2,['raw LFP trace ',num2str(iCycle(iPlot)),'th light cycle'],'fontSize',fontL);
end
hPlfmCSC(4) = axes('Position',axpt(nCol,nRow,1,4,axpt(1,1,1,1,[0.10 0.10 0.85 0.85],midInterval),midInterval));
for iLight = 1:nLabLight_ina
    hLpatch = patch([125*(iLight-1), 125*(iLight-1)+10,125*(iLight-1)+10,125*(iLight-1)],[yLim_ina(1), yLim_ina(1), yLim_ina(2), yLim_ina(2)],colorLightBlue,'EdgeColor','none');
    hold on;
end
plot(xpt,m_cscPlfm8hz_ina,'color',colorBlack,'lineWidth',0.8);
text(-900,yLim_ina(2)*0.8,'Average LFP trace','fontSize',fontL);

set(hPlfmCSC,'Box','off','TickDir','out','fontSize',fontM,'XLim',[-1000,2000],'XTick',[-1000,0,2000],'fontSize',fontL);
set(hPlfmCSC(1),'YLim',[0,30],'YTick',[0:5:30]);
print('-painters','-r300','-dtiff',['plot_rawLFP_ina_',datestr(now,formatOut),'.tif']);
close;

%% figure 4
fHandle(4) = figure('PaperUnits','centimeters','PaperPosition',[0, 0, 29.7*3, 21*2]);
nCol = 1;
nRow = 4;
hPlfmCSC(1) = axes('Position',axpt(nCol,nRow,1,1,axpt(1,1,1,1,[0.10 0.10 0.85 0.85],midInterval),midInterval));
for iLight = 1:nLabLight_act
    hLpatch = patch([125*(iLight-1), 125*(iLight-1)+10,125*(iLight-1)+10,125*(iLight-1)],[0, 0, 30, 30],colorLightBlue,'EdgeColor','none');
    hold on;
end
plot(xpt_no{1},ypt_no{1},'LineStyle','none','Marker','o','MarkerSize',markerS,'Color',colorBlack,'MarkerFaceColor',colorBlack);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Cycle','fontSize',fontL);
for iPlot = 1:length(iCycle)
    hPlfmCSC(iPlot+1) = axes('Position',axpt(nCol,nRow,1,iPlot+1,axpt(1,1,1,1,[0.10 0.10 0.85 0.85],midInterval),midInterval));
    for iLight = 1:nLabLight_no
        hLpatch = patch([125*(iLight-1), 125*(iLight-1)+10,125*(iLight-1)+10,125*(iLight-1)],[yLim_no(1), yLim_no(1), yLim_no(2), yLim_no(2)],colorLightBlue,'EdgeColor','none');
        hold on;
    end
    plot(xpt,cscPlfm8hz_no(iCycle(iPlot),:),'color',colorBlack,'lineWidth',0.8);
    text(-900,yLim_no(2)*2,['raw LFP trace ',num2str(iCycle(iPlot)),'th light cycle'],'fontSize',fontL);
end
hPlfmCSC(4) = axes('Position',axpt(nCol,nRow,1,4,axpt(1,1,1,1,[0.10 0.10 0.85 0.85],midInterval),midInterval));
for iLight = 1:nLabLight_no
    hLpatch = patch([125*(iLight-1), 125*(iLight-1)+10,125*(iLight-1)+10,125*(iLight-1)],[yLim_no(1), yLim_no(1), yLim_no(2), yLim_no(2)],colorLightBlue,'EdgeColor','none');
    hold on;
end
plot(xpt,m_cscPlfm8hz_no,'color',colorBlack,'lineWidth',0.8);
text(-900,yLim_no(2)*0.8,'Average LFP trace','fontSize',fontL);

set(hPlfmCSC,'Box','off','TickDir','out','fontSize',fontM,'XLim',[-1000,2000],'XTick',[-1000,0,2000],'fontSize',fontL);
set(hPlfmCSC(1),'YLim',[0,30],'YTick',[0:5:30]);
print('-painters','-r300','-dtiff',['plot_rawLFP_no_',datestr(now,formatOut),'.tif']);
close;
