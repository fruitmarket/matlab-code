function f_fig1_cellCount()
cd('D:\Dropbox\SNL\P2_Track\analysis_expressCount\ChETA')
% load expChETA_170914.mat
load expChETA_171101.mat

cd('D:\Dropbox\SNL\P2_Track');
load('D:\Dropbox\SNL\P2_Track\myParameters.mat');

nCol = 2;
nRow = 4;

fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1},'Name','ChETA expression');

hArea = axes('Position',axpt(4,1,1,1,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
plot(0.5,eYFPmeanMice,'o','MarkerSize',markerS,'MarkerFaceColor','none','MarkerEdgeColor',colorBlack);
% scatter(1,eYFPmeanMice,markerL,'MarkerFaceColor','none','MarkerEdgeColor',colorBlack)
hold on;
errorbarJun(0.8,eYFPmeanTotal,eYFPstdTotal/sqrt(length(eYFPmeanMice)),0.2,0.8,colorBlack);
hold on
plot(0.8,eYFPmeanTotal,'o','MarkerSize',markerS,'MarkerFaceColor',colorBlack,'MarkerEdgeColor',colorBlack);

text(0.8,7,['n = ',num2str(length(eYFPmeanMice))],'fontSize',fontS);
ylabel('ChETA+ GCs %','fontSize',fontS);

set(hArea,'Box','off','TickDir','out','fontSize',fontS,'XLim',[0,1.2],'XTick',[],'YLim',[0,8],'YTick',0:1:10);

formatOut = 'yymmdd';
print('-painters','-r300','-dtiff',['final_fig1_plot_expChETA_',datestr(now,formatOut),'.tif']);
print('-painters','-r300','-depsc',['final_fig1_plot_expChETA_',datestr(now,formatOut),'.ai']);
close;
end