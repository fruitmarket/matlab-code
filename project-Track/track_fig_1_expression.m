function track_fig_1_expression()
cd('D:\Dropbox\SNL\P2_Track\analysis_expressCount\ChETA')
load expChETA_170501.mat

cd('D:\Dropbox\SNL\P2_Track');
load myParameters.mat

nCol = 4;
nRow = 1;

fHandle = figure('PaperUnits','centimeters','PaperPosition',[0 0 3 6]*2);

hArea = axes('Position',axpt(nCol,nRow,2:3,1,[0.20 0.1 0.85 0.80],wideInterval));
plot(1,eYFPmeanMice,'o','MarkerSize',markerM,'MarkerFaceColor','none','MarkerEdgeColor',colorBlack);
% scatter(1,eYFPmeanMice,markerL,'MarkerFaceColor','none','MarkerEdgeColor',colorBlack)
hold on
errorbarJun(1.6,eYFPmeanTotal,eYFPstdTotal/sqrt(length(eYFPmeanMice)),0.2,0.8,colorBlack);
hold on;
plot(1.6,eYFPmeanTotal,'o','MarkerSize',markerM,'MarkerFaceColor',colorBlack,'MarkerEdgeColor',colorBlack);
% text(1,6.5,['n = ',num2str(length(eYFPmeanMice))]);
ylabel('ChETA+ GCs %','fontSize',fontL);

set(hArea,'Box','off','TickDir','out','fontSize',fontM,'XLim',[0,2],'XTick',[],'YLim',[0,7],'YTick',0:1:7,'fontSize',fontL);

formatOut = 'yymmdd';
% print('-painters','-r300','-dtiff',['fig1_expChETA_',datestr(now,formatOut),'.tif']);
print('-painters','-r300','-depsc',['fig1_expChETA_',datestr(now,formatOut),'.ai']);
close;
end