function plot_expCount()
cd('D:\Dropbox\SNL\P2_Track\analysis_expressCount\ChETA')
load expChETA_170501.mat

cd('D:\Dropbox\SNL\P2_Track');
load myParameters.mat

nCol = 5;
nRow = 6;

fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1},'Name','ChETA expression');

hArea = axes('Position',axpt(nCol,nRow,1:2,1:2,[0.1 0.1 0.85 0.85],wideInterval));
plot(1,eYFPmeanMice,'o','MarkerSize',markerM,'MarkerFaceColor','none','MarkerEdgeColor',colorBlack);
% scatter(1,eYFPmeanMice,markerL,'MarkerFaceColor','none','MarkerEdgeColor',colorBlack)
hold on
errorbar(1.3,eYFPmeanTotal,eYFPstdTotal/sqrt(length(eYFPmeanMice)),'Color',colorBlack,'MarkerSize',markerM);
hold on;
plot(1.3,eYFPmeanTotal,'o','MarkerSize',markerM,'MarkerFaceColor',colorLightBlue,'MarkerEdgeColor',colorBlack);
text(1,7,['n = ',num2str(length(eYFPmeanMice))]);
ylabel('ChETA+ GCs %','fontSize',fontM);

set(hArea,'Box','off','TickDir','out','fontSize',fontM,'XLim',[0,2],'XTick',[],'YLim',[0,8],'YTick',0:1:10);

formatOut = 'yymmdd';
% print('-painters','-r300','-dtiff',['plot_expChETA_',datestr(now,formatOut),'.tif']);
print('-painters','-r300','-depsc',['plot_expChETA_',datestr(now,formatOut),'.ai']);
close;
end