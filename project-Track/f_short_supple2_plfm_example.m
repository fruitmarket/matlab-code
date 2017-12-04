clearvars;
load('D:\Dropbox\SNL\P2_Track\myParameters.mat');
winCri_ori = [-5, 20];
nTrial_ori = 300;
markerSS = 1;

formatOut = 'yymmdd';
saveDir = 'D:\Dropbox\SNL\P2_Track';

fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});
nCol = 4;
nRow = 6;

%%
load('D:\Projects\Track_170305-1_Rbp76freq_8mw\170710_DV2.20_2_1hz2hz8hz20hz50hz_T12_8mW\TT1_1.mat');
load('D:\Projects\Track_170305-1_Rbp76freq_8mw\170710_DV2.20_2_1hz2hz8hz20hz50hz_T12_8mW\Events.mat');

hLightBuild(1) = axes('Position',axpt(5,4,1,1:4,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),midInterval));
hLBar(1) = rectangle('Position',[0,0,10,nTrial_ori],'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
plot(xpt1hz_ori{1},ypt1hz_ori{1},'LineStyle','o','MarkerSize',markerSS,'markerFaceColor','k','markerEdgeColor','none');
ylabel('Light pulse #','FontSize',fontM);
title('1 Hz','fontSize',fontM);

hLightBuild(2) = axes('Position',axpt(5,4,2,1:4,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),midInterval));
hLBar(2) = rectangle('Position',[0,0,10,nTrial_ori],'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
plot(xpt2hz_ori{1},ypt2hz_ori{1},'LineStyle','o','MarkerSize',markerSS,'markerFaceColor','k','markerEdgeColor','none');
title('2 Hz','fontSize',fontM);

hLightBuild(3) = axes('Position',axpt(5,4,3,1:4,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),midInterval));
hLBar(3) = rectangle('Position',[0,0,10,nTrial_ori],'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
plot(xpt8hz_ori{1},ypt8hz_ori{1},'LineStyle','o','MarkerSize',markerSS,'markerFace','k','markerEdgeColor','none');
xlabel('Time (ms)','FontSize',fontM);
title('8 Hz','fontSize',fontM);

hLightBuild(4) = axes('Position',axpt(5,4,4,1:4,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),midInterval));
hLBar(4) = rectangle('Position',[0,0,10,nTrial_ori],'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
plot(xpt20hz_ori{1},ypt20hz_ori{1},'LineStyle','o','MarkerSize',markerSS,'markerFaceColor','k','markerEdgeColor','none');
title('20 Hz','fontSize',fontM);

hLightBuild(5) = axes('Position',axpt(5,4,5,1:4,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),midInterval));
hLBar(5) = rectangle('Position',[0,0,10,nTrial_ori],'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
plot(xpt50hz_ori{1},ypt50hz_ori{1},'LineStyle','o','MarkerSize',markerSS,'markerFaceColor','k','markerEdgeColor','none');
title('50 Hz','fontSize',fontM);

set(hLightBuild,'XLim',winCri_ori,'XTick',[],'YLim',[0, nTrial_ori],'YTick',[]);
set(hLightBuild(1),'YTick',[0:100:300]);
set(hLightBuild(3),'XTick',[0 20]);
set(hLightBuild,'Box','off','TickDir','out','fontSize',fontM);
set(hLightBuild,'TickLength',[0.03, 0.03]);

%% freq dependency
hPlot = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1,2,[0.1 0.1 0.85 0.85],midInterval),midInterval));
plot([1,2,3,4,5],[lightProb1hz, lightProb2hz, lightProb8hz, lightProb20hz, lightProb50hz],'-o','color',colorDarkGray,'markerSize',markerS,'markerEdgeColor',colorDarkGray,'markerFaceColor',colorGray);

ylabel('Spike probability (%)','fontSize',fontM);
xlabel('Frequency (Hz)','fontSize',fontM);
% title('Total activated neuron','fontSize',fontS);

set(hPlot,'TickDir','out','Box','off','TickLength',[0.03,0.03]);
set(hPlot,'XLim',[0,6],'XTick',[1:5],'XTickLabel',{'1';'2';'8';'20';'50'},'fontSize',fontM);
set(hPlot,'YLim',[-1,60]);
set(hPlot,'TickLength',[0.03, 0.03]);

print('-painters','-r300','-dtiff',['f_short_supple2_',datestr(now,formatOut),'.tif']);
print('-painters','-r300','-depsc',['f_short_supple2_',datestr(now,formatOut),'.ai']);
close;