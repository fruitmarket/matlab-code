

lineColor = {[144, 164, 174]./255,... % Before stimulation
    [244, 67, 54]./255,... % During stimulation
    [38, 50, 56]./255}; % After stimulation

lineWth = [1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75];
fontS = 4; % font size small
fontM = 6; % font size middle
fontL = 8; % font size large
lineS = 0.2; % line width small
lineM = 0.5; % line width middle
lineL = 1; % line width large

colorBlue = [33 150 243] ./ 255;
colorLightBlue = [223 239 252] ./ 255;
colorRed = [237 50 52] ./ 255;
colorLightRed = [242 138 130] ./ 255;
colorGray = [189 189 189] ./ 255;
colorYellow = [255 243 3] ./ 255;
colorLightYellow = [255 249 196] ./ 255;

tightInterval = [0.02 0.02];
wideInterval = [0.07 0.07];

nCol = 4;
nRowSub = 8; % for the left column
nRowMain = 5; % for the main figure

markerS = 2.2;
markerM = 4.4;
markerL = 6.6;

%%%%%%%%%%%%%%%

load('cellList.mat');
cutPval = 0.05;
cutFr = 0.01;
cellCut = T.fr_task>cutFr;


T.burstIdx(cellCut);
T.spkwth(cellCut);
T. hfwth(cellCut);

hCell(1) = axes('Position',axpt(2,2,1,1,[],wideInterval));
hold on;
    plot(T.burstIdx(cellCut),T.fr_task(cellCut),'o','MarkerSize',markerS,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
    set(hCell(1),'XLim',[-0.1, 1],'YLim',[-1, 50]);
    xlabel('Burst Index (% ISI < (mean ISI)/4)');
    ylabel('Firing rate (Hz)');

hCell(2) = axes('Position',axpt(2,2,1,2,[],wideInterval));
hold on;
    plot(T.spkwth(cellCut),T.fr_task(cellCut),'o','MarkerSize',markerS,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
    set(hCell(2),'XLim',[50, 500],'YLim',[-1, 50]);
    xlabel('Spike width (ms)');
    ylabel('Firing rate (Hz)');
    
hCell(3) = axes('Position',axpt(2,2,2,1,[],wideInterval));
hold on;
    plot(T.hfwth(cellCut),T.fr_task(cellCut),'o','MarkerSize',markerS,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
    set(hCell(3),'XLim',[50, 650],'YLim',[-1, 50]);
    xlabel('Half valley width (ms)');
    ylabel('Firing rate (Hz)');
    
hCell(4) = axes('Position',axpt(2,2,2,2,[],wideInterval));
hold on;
    plot(T.burstIdx(cellCut),T.hfwth(cellCut),'o','MarkerSize',markerS,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
    set(hCell(4),'YLim',[0, 650]);
    xlabel('Burst Index (% ISI < (mean ISI)/4)');
    ylabel('Half valley width (ms)');
    
    set(hCell,'TickDir','out','Box','off');

(T.taskType == 'DRw') && T.T.fr_task > 0.05 && T.p_modu<0.05 && T.moduRaio>0.01


