clearvars;

rtDir = 'E:\Dropbox\SNL\P4_FamiliarNovel';
load('E:\Dropbox\SNL\P2_Track\myParameters.mat');
formatOut = 'yymmdd';
load('E:\Dropbox\SNL\P4_FamiliarNovel\behaviorList_familiar_190107.mat');

%% each lap analysis
eachLap = round(cell2mat(T.m_timeLap)/1000*100)/100;
nSess = size(eachLap,1);

m_eachLap = mean(eachLap);
sem_eachLap = std(eachLap,0,1)/sqrt(nSess);
group = {'PRE','STIM','POST'};
[p_KW_eachLap_main,~,stats] = kruskalwallis(eachLap,group,'off');
result = multcompare(stats,'ctype','lsd','display','off');
p_KW_eachLap_detail = result(:,end);

%% total block analysis
timeLap = T.timeLap;
nBlock = 3;
timeBlock = zeros(nSess,3);
for iBlock = 1:nBlock
    timeBlock(:,iBlock) = cellfun(@(x) sum(x(30*(iBlock-1)+1:30*iBlock)), timeLap);
end

timeBlock = round(timeBlock/(1000*60)*100)/100;
m_eachBlock = mean(timeBlock);
sem_eachBlock = std(timeBlock,0,1)/sqrt(nSess);
[p_KW_eachBlock_main,~,stats] = kruskalwallis(timeBlock,group,'off');
result = multcompare(stats,'ctype','lsd','display','off');
p_KW_eachBlock_detail = result(:,end);

%%
fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});

nCol = 2;
nRow = 2;

barWidth = 0.7;
eBarWidth = 0.7;
xptBar = 1:3;
xptScatter = (rand(nSess,1)-0.5)*0.7*barWidth;

hPlot = axes('Position',axpt(nCol,nRow,1,1,[],wideInterval));
hBar = bar(xptBar,m_eachBlock,'barWidth',barWidth,'lineStyle','-','edgeColor',colorBlack,'faceColor',colorDarkGray,'lineWidth',1);
hold on;
for iBlock = 1:3
    plot(iBlock+xptScatter,timeBlock(:,iBlock),'lineStyle','none','marker','o','markerSize',markerS,'markerFaceColor',colorLightGray,'markerEdgeColor',colorBlack);
    hold on;
end
for iSess = 1:nSess
    plot(xptBar+xptScatter(iSess),timeBlock(iSess,:),'lineStyle','-','color',colorGray);
    hold on;
end
errorbarJun(xptBar,m_eachBlock,sem_eachBlock,0.4,eBarWidth,colorBlack);

text(3,18,['n = ',num2str(nSess)],'fontSize',fontM);
text(1,-4,'p-value','fontSize',fontM);
for iPval = 1:3
    text(iPval,-6, num2str(p_KW_eachBlock_detail(iPval),3),'fontSize',fontS);
end
ylabel('Time (min)','fontSize',fontM);
set(hPlot,'Box','off','TIckDir','out','XLim',[0,4],'XTick',1:3,'XTickLabel',{'PRE','STIM','POST'},'YLim',[0, 20],'YTick',[0:5:20],'fontSize',fontM);

cd(rtDir);
print('-painters','-r300','-dtiff',['plot_familiar_behavior_',datestr(now,formatOut),'.tif']);
close all;