clearvars; close all;

rtDir = 'E:\Dropbox\Lab_mwjung\P4_FamiliarNovel';
load('E:\Dropbox\Lab_mwjung\P2_Track\myParameters.mat');
formatOut = 'yymmdd';
load('E:\Dropbox\Lab_mwjung\P4_FamiliarNovel\neuronList_novel_190301.mat');
PN = T.neuronType == 'PN';
IN = T.neuronType == 'IN';

tt_ca3bc = ((T.mouseID == 'rbp005' & (T.tetrode == 'TT1' | T.tetrode == 'TT5')) | (T.mouseID == 'rbp006' & T.tetrode == 'TT2') | (T.mouseID == 'rbp010' & T.tetrode == 'TT6')); % | (T.mouseID == 'rbp015' & T.tetrode == 'TT7')
PN_ca3bc = PN & tt_ca3bc;
PN_ca3a = PN & ~tt_ca3bc;

% PN_act = PN & T.idxmFrIn == 1;
% PN_inh = PN & T.idxmFrIn == -1;
% PN_non = PN & T.idxmFrIn == 0;
% IN_inh = IN & T.idxmFrIn == -1;

PN_act = PN & T.idxmSpkIn == 1;
PN_inh = PN & T.idxmSpkIn == -1;
PN_non = PN & T.idxmSpkIn == 0;
IN_inh = IN & T.idxmSpkIn == -1;

n_pn_act = sum(double(PN_act));
n_pn_inh = sum(double(PN_inh));
n_pn_non = sum(double(PN_non));
n_in_inh = sum(double(IN_inh));

m_inPRE = cellfun(@(x) x(2), T.m_lapFrInzone);
m_inSTIM = cellfun(@(x) x(3), T.m_lapFrInzone);
m_inPOST = cellfun(@(x) x(4), T.m_lapFrInzone);

m_outPRE = cellfun(@(x) x(2), T.m_lapFrOutzone);
m_outSTIM = cellfun(@(x) x(3), T.m_lapFrOutzone);
m_outPOST = cellfun(@(x) x(4), T.m_lapFrOutzone);

m_totPRE = cellfun(@(x) x(2), T.m_lapFrTotalzone);
m_totSTIM = cellfun(@(x) x(3), T.m_lapFrTotalzone);
m_totPOST = cellfun(@(x) x(4), T.m_lapFrTotalzone);

%%
pn_in_act = [m_inPRE(PN_act), m_inSTIM(PN_act), m_inPOST(PN_act)];
pn_in_inh = [m_inPRE(PN_inh), m_inSTIM(PN_inh), m_inPOST(PN_inh)];
pn_in_non = [m_inPRE(PN_non), m_inSTIM(PN_non), m_inPOST(PN_non)];

pn_out_act = [m_outPRE(PN_act), m_outSTIM(PN_act), m_outPOST(PN_act)];
pn_out_inh = [m_outPRE(PN_inh), m_outSTIM(PN_inh), m_outPOST(PN_inh)];
pn_out_non = [m_outPRE(PN_non), m_outSTIM(PN_non), m_outPOST(PN_non)];

pn_tot_act = [m_totPRE(PN_act), m_totSTIM(PN_act), m_totPOST(PN_act)];
pn_tot_inh = [m_totPRE(PN_inh), m_totSTIM(PN_inh), m_totPOST(PN_inh)];
pn_tot_non = [m_totPRE(PN_non), m_totSTIM(PN_non), m_totPOST(PN_non)];

in_in_inh = [m_inPRE(IN_inh), m_inSTIM(IN_inh), m_inPOST(IN_inh)];
in_out_inh = [m_outPRE(IN_inh), m_outSTIM(IN_inh), m_outPOST(IN_inh)];
in_tot_inh = [m_totPRE(IN_inh), m_totSTIM(IN_inh), m_totPOST(IN_inh)];

mean_pn_in = mean([pn_in_act; pn_in_inh; pn_in_non]);
sem_pn_in = std([pn_in_act; pn_in_inh; pn_in_non])/sqrt(size([pn_in_act; pn_in_inh; pn_in_non],1));

mean_pn_out = mean([pn_out_act; pn_out_inh; pn_out_non]);
sem_pn_out = std([pn_out_act; pn_out_inh; pn_out_non])/sqrt(size([pn_out_act; pn_out_inh; pn_out_non],1));

mean_pn_tot = mean([pn_tot_act; pn_tot_inh; pn_tot_non]);
sem_pn_tot = std([pn_tot_act; pn_tot_inh; pn_tot_non])/sqrt(size([pn_tot_act; pn_tot_inh; pn_tot_non],1));

mean_in_in = mean(in_in_inh);
sem_in_in =  std(in_in_inh)/sqrt(n_in_inh);

mean_in_out = mean(in_out_inh);
sem_in_out =  std(in_out_inh)/sqrt(n_in_inh);

mean_in_tot = mean(in_tot_inh);
sem_in_tot =  std(in_tot_inh)/sqrt(n_in_inh);

%% statistic
group = {'PRE','STIM','POST'};
p_pn_in = kruskalwallis([pn_in_act; pn_in_inh; pn_in_non],group,'off');
p_pn_out = kruskalwallis([pn_out_act; pn_out_inh; pn_out_non],group,'off');
p_pn_tot = kruskalwallis([pn_tot_act; pn_tot_inh; pn_tot_non],group,'off');
p_in_in = kruskalwallis(in_in_inh,group,'off');
p_in_out = kruskalwallis(in_out_inh,group,'off');
p_in_tot = kruskalwallis(in_tot_inh,group,'off');

%% Graph
nCol = 3;
nRow = 3;

lineWidth = 1.2;
barWidth = 0.7;
eBarWidth = 1;
eBarLength = 0.8;
spaceFig = [];
midInterval = [0.07 0.07];

fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});
xptBar = [1,3,5];
xptScatter_pn_act = (rand(n_pn_act,1)-0.5)*0.85*barWidth;
xptScatter_pn_inh = (rand(n_pn_inh,1)-0.5)*0.85*barWidth;
xptScatter_pn_non = (rand(n_pn_non,1)-0.5)*0.85*barWidth;
xptScatter_in_inh = (rand(n_in_inh,1)-0.5)*0.85*barWidth;

hBar(1) = axes('Position',axpt(nCol,nRow,1,1,[],wideInterval));
bar(xptBar,mean_pn_in,'barWidth',barWidth,'lineStyle','-','edgeColor',colorBlack,'faceColor',colorDarkGray,'lineWidth',lineWidth);
hold on;
errorbarJun(xptBar,mean_pn_in,sem_pn_in,eBarLength,eBarWidth,colorBlack);
hold on;
for iBlock = 1:3
    plot((2*iBlock-1)+xptScatter_pn_act,pn_in_act(:,iBlock),'lineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorRed,'markerEdgeColor',colorBlack);
    hold on;
    plot((2*iBlock-1)+xptScatter_pn_inh,pn_in_inh(:,iBlock),'lineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorBlue,'markerEdgeColor',colorBlack);
    hold on;
    plot((2*iBlock-1)+xptScatter_pn_non,pn_in_non(:,iBlock),'lineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorGray,'markerEdgeColor',colorBlack);
    hold on;
end
for iLine = 1:n_pn_act
    plot([1+xptScatter_pn_act(iLine),3+xptScatter_pn_act(iLine),5+xptScatter_pn_act(iLine)],[pn_in_act(iLine,1),pn_in_act(iLine,2),pn_in_act(iLine,3)],'lineStyle','-','color',colorLightRed);
    hold on;
end
for iLine = 1:n_pn_inh
    plot([1+xptScatter_pn_inh(iLine),3+xptScatter_pn_inh(iLine),5+xptScatter_pn_inh(iLine)],[pn_in_inh(iLine,1),pn_in_inh(iLine,2),pn_in_inh(iLine,3)],'lineStyle','-','color',colorLightBlue);
    hold on;
end
for iLine = 1:n_pn_non
    plot([1+xptScatter_pn_non(iLine),3+xptScatter_pn_non(iLine),5+xptScatter_pn_non(iLine)],[pn_in_non(iLine,1),pn_in_non(iLine,2),pn_in_non(iLine,3)],'lineStyle','-','color',colorLightGray);
    hold on;
end
text(0.5,24,['n_all = ',num2str(size([pn_in_act; pn_in_inh; pn_in_non],1))],'interpreter','none','fontSize',fontM);
text(0.5,22,['n (act/inh/non) = ',num2str(n_pn_act),'/',num2str(n_pn_inh),'/',num2str(n_pn_non)],'interpreter','none','fontSize',fontM);
ylabel('Firing rate (Hz)','fontSize',fontM);
title('In-zone','fontSize',fontM);

hBar(2) = axes('Position',axpt(nCol,nRow,2,1,[],wideInterval));
bar(xptBar,mean_pn_out,'barWidth',barWidth,'lineStyle','-','edgeColor',colorBlack,'faceColor',colorDarkGray,'lineWidth',lineWidth);
hold on;
errorbarJun(xptBar,mean_pn_out,sem_pn_out,eBarLength,eBarWidth,colorBlack);
hold on;
for iBlock = 1:3
    plot((2*iBlock-1)+xptScatter_pn_act,pn_out_act(:,iBlock),'lineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorRed,'markerEdgeColor',colorBlack);
    hold on;
    plot((2*iBlock-1)+xptScatter_pn_inh,pn_out_inh(:,iBlock),'lineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorBlue,'markerEdgeColor',colorBlack);
    hold on;
    plot((2*iBlock-1)+xptScatter_pn_non,pn_out_non(:,iBlock),'lineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorGray,'markerEdgeColor',colorBlack);
    hold on;
end
for iLine = 1:n_pn_act
    plot([1+xptScatter_pn_act(iLine),3+xptScatter_pn_act(iLine),5+xptScatter_pn_act(iLine)],[pn_out_act(iLine,1),pn_out_act(iLine,2),pn_out_act(iLine,3)],'lineStyle','-','color',colorLightRed);
    hold on;
end
for iLine = 1:n_pn_inh
    plot([1+xptScatter_pn_inh(iLine),3+xptScatter_pn_inh(iLine),5+xptScatter_pn_inh(iLine)],[pn_out_inh(iLine,1),pn_out_inh(iLine,2),pn_out_inh(iLine,3)],'lineStyle','-','color',colorLightBlue);
    hold on;
end
for iLine = 1:n_pn_non
    plot([1+xptScatter_pn_non(iLine),3+xptScatter_pn_non(iLine),5+xptScatter_pn_non(iLine)],[pn_out_non(iLine,1),pn_out_non(iLine,2),pn_out_non(iLine,3)],'lineStyle','-','color',colorLightGray);
    hold on;
end
ylabel('Firing rate (Hz)','fontSize',fontM);
title('Out-zone','fontSize',fontM);

hBar(3) = axes('Position',axpt(nCol,nRow,3,1,[],wideInterval));
bar(xptBar,mean_pn_tot,'barWidth',barWidth,'lineStyle','-','edgeColor',colorBlack,'faceColor',colorDarkGray,'lineWidth',lineWidth);
hold on;
errorbarJun(xptBar,mean_pn_tot,sem_pn_tot,eBarLength,eBarWidth,colorBlack);
hold on;
for iBlock = 1:3
    plot((2*iBlock-1)+xptScatter_pn_act,pn_tot_act(:,iBlock),'lineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorRed,'markerEdgeColor',colorBlack);
    hold on;
    plot((2*iBlock-1)+xptScatter_pn_inh,pn_tot_inh(:,iBlock),'lineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorBlue,'markerEdgeColor',colorBlack);
    hold on;
    plot((2*iBlock-1)+xptScatter_pn_non,pn_tot_non(:,iBlock),'lineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorGray,'markerEdgeColor',colorBlack);
    hold on;
end
for iLine = 1:n_pn_act
    plot([1+xptScatter_pn_act(iLine),3+xptScatter_pn_act(iLine),5+xptScatter_pn_act(iLine)],[pn_tot_act(iLine,1),pn_tot_act(iLine,2),pn_tot_act(iLine,3)],'lineStyle','-','color',colorLightRed);
    hold on;
end
for iLine = 1:n_pn_inh
    plot([1+xptScatter_pn_inh(iLine),3+xptScatter_pn_inh(iLine),5+xptScatter_pn_inh(iLine)],[pn_tot_inh(iLine,1),pn_tot_inh(iLine,2),pn_tot_inh(iLine,3)],'lineStyle','-','color',colorLightBlue);
    hold on;
end
for iLine = 1:n_pn_non
    plot([1+xptScatter_pn_non(iLine),3+xptScatter_pn_non(iLine),5+xptScatter_pn_non(iLine)],[pn_tot_non(iLine,1),pn_tot_non(iLine,2),pn_tot_non(iLine,3)],'lineStyle','-','color',colorLightGray);
    hold on;
end
ylabel('Firing rate (Hz)','fontSize',fontM);
title('Entire maze','fontSize',fontM);

hBar(4) = axes('Position',axpt(nCol,nRow,1,2,[],wideInterval));
bar(xptBar,mean_pn_in,'barWidth',barWidth,'lineStyle','-','edgeColor',colorBlack,'faceColor',colorDarkGray,'lineWidth',lineWidth);
hold on;
errorbarJun(xptBar,mean_pn_in,sem_pn_in,eBarLength,eBarWidth,colorBlack);
text(3,1.8,['p = ',num2str(p_pn_in)],'fontSize',fontM);
ylabel('Firing rate (Hz)','fontSize',fontM);

hBar(5) = axes('Position',axpt(nCol,nRow,2,2,[],wideInterval));
bar(xptBar,mean_pn_out,'barWidth',barWidth,'lineStyle','-','edgeColor',colorBlack,'faceColor',colorDarkGray,'lineWidth',lineWidth);
hold on;
errorbarJun(xptBar,mean_pn_out,sem_pn_out,eBarLength,eBarWidth,colorBlack);
text(3,1.8,['p = ',num2str(p_pn_out)],'fontSize',fontM);
ylabel('Firing rate (Hz)','fontSize',fontM);

hBar(6) = axes('Position',axpt(nCol,nRow,3,2,[],wideInterval));
bar(xptBar,mean_pn_tot,'barWidth',barWidth,'lineStyle','-','edgeColor',colorBlack,'faceColor',colorDarkGray,'lineWidth',lineWidth);
hold on;
errorbarJun(xptBar,mean_pn_tot,sem_pn_tot,eBarLength,eBarWidth,colorBlack);
text(3,1.8,['p = ',num2str(p_pn_tot)],'fontSize',fontM);
ylabel('Firing rate (Hz)','fontSize',fontM);

hBar(7) = axes('Position',axpt(nCol,nRow,1,3,[],wideInterval));
bar(xptBar,mean_in_in,'barWidth',barWidth,'lineStyle','-','edgeColor',colorBlack,'faceColor',colorDarkGray,'lineWidth',lineWidth);
hold on;
errorbarJun(xptBar,mean_in_in,sem_in_in,eBarLength,eBarWidth,colorBlack);
hold on;
for iBlock = 1:3
    plot((2*iBlock-1)+xptScatter_in_inh,in_in_inh(:,iBlock),'lineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorBlue,'markerEdgeColor',colorBlack);
    hold on;
end
for iLine = 1:n_in_inh
    plot([1+xptScatter_in_inh(iLine),3+xptScatter_in_inh(iLine),5+xptScatter_in_inh(iLine)],[in_in_inh(iLine,1),in_in_inh(iLine,2),in_in_inh(iLine,3)],'lineStyle','-','color',colorLightBlue);
    hold on;
end
text(3,55,['p = ',num2str(p_in_in)],'fontSize',fontM);
ylabel('Firing rate (Hz)','fontSize',fontM);

hBar(8) = axes('Position',axpt(nCol,nRow,2,3,[],wideInterval));
bar(xptBar,mean_in_out,'barWidth',barWidth,'lineStyle','-','edgeColor',colorBlack,'faceColor',colorDarkGray,'lineWidth',lineWidth);
hold on;
errorbarJun(xptBar,mean_in_out,sem_in_out,eBarLength,eBarWidth,colorBlack);
hold on;
for iBlock = 1:3
    plot((2*iBlock-1)+xptScatter_in_inh,in_in_inh(:,iBlock),'lineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorBlue,'markerEdgeColor',colorBlack);
    hold on;
end

for iLine = 1:n_in_inh
    plot([1+xptScatter_in_inh(iLine),3+xptScatter_in_inh(iLine),5+xptScatter_in_inh(iLine)],[in_in_inh(iLine,1),in_in_inh(iLine,2),in_in_inh(iLine,3)],'lineStyle','-','color',colorLightBlue);
    hold on;
end
text(3,55,['p = ',num2str(p_in_out)],'fontSize',fontM);
ylabel('Firing rate (Hz)','fontSize',fontM);

hBar(9) = axes('Position',axpt(nCol,nRow,3,3,[],wideInterval));
bar(xptBar,mean_in_tot,'barWidth',barWidth,'lineStyle','-','edgeColor',colorBlack,'faceColor',colorDarkGray,'lineWidth',lineWidth);
hold on;
errorbarJun(xptBar,mean_in_tot,sem_in_tot,eBarLength,eBarWidth,colorBlack);
hold on;
for iBlock = 1:3
    plot((2*iBlock-1)+xptScatter_in_inh,in_in_inh(:,iBlock),'lineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorBlue,'markerEdgeColor',colorBlack);
    hold on;
end
for iLine = 1:n_in_inh
    plot([1+xptScatter_in_inh(iLine),3+xptScatter_in_inh(iLine),5+xptScatter_in_inh(iLine)],[in_in_inh(iLine,1),in_in_inh(iLine,2),in_in_inh(iLine,3)],'lineStyle','-','color',colorLightBlue);
    hold on;
end
text(3,55,['p = ',num2str(p_in_tot)],'fontSize',fontM);
ylabel('Firing rate (Hz)','fontSize',fontM);

set(hBar,'Box','off','TickDir','out','XLim',[0, 6],'XTick',[1,3,5],'XTickLabel',{'PRE','STIM','POST'},'fontSize',fontM);
set(hBar(1),'YLim',[0,25],'YTick',0:5:25);
set(hBar(2:3),'YLim',[0,10],'YTick',0:2:10);
set(hBar(4:6),'YLim',[0,2],'YTick',0:0.5:2);
set(hBar(7:9),'YLim',[0,60],'YTick',0:10:60);

print('-painters','-r300','-dtiff',['plot_firingRate_novel_',datestr(now,formatOut),'.tif']);