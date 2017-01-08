function plot_expCount()
cd('D:\Dropbox\#team_hippocampus Team Folder\project_Track\Histology\Results')
load eYFPexpression.mat

lineColor = {[144, 164, 174]./255,... % Before stimulation
    [33 150 243]./ 255,... % During stimulation
    [38, 50, 56]./255}; % After stimulation

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

markerS = 4; markerM = 6; markerL = 8; markerXL = 12*2;
tightInterval = [0.02 0.02]; midInterval = [0.09, 0.09]; wideInterval = [0.14 0.14];
width = 0.7;

nCol = 4;
nRow = 4;

fHandle = figure('PaperUnits','centimeters','PaperPosition',[0, 0, 18, 14]);

hArea = axes('Position',axpt(nCol,nRow,1,1:2,[0.1 0.1 0.85 0.85],wideInterval));
plot(1,eYFPmeanMice,'o','MarkerSize',markerL,'MarkerFaceColor','none','MarkerEdgeColor',colorBlack);
scatter(1,eYFPmeanMice,markerL,'MarkerFaceColor','none','MarkerEdgeColor',colorBlack)
hold on
errorbar(1.3,eYFPmeanTotal,eYFPstdTotal/sqrt(length(eYFPmeanMice)),'Color',colorBlack);
hold on;
plot(1.3,eYFPmeanTotal,'o','MarkerSize',markerL,'MarkerFaceColor',colorLightBlue,'MarkerEdgeColor',colorBlack);
text(1,7,['n = ',num2str(length(eYFPmeanMice))]);
ylabel('ChETA+ GCs %','fontSize',fontL);

set(hArea,'Box','off','TickDir','out','fontSize',fontM,'XLim',[0,2],'XTick',[],'YLim',[0,8],'YTick',0:1:10);
print(gcf,'-painters','-r300','plot_expression.tiff','-dtiff');

end