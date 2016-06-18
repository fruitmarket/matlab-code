clf; clearvars;

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
wideInterval = [0.09 0.09];

nCol = 4;
nRowSub = 8; % for the left column
nRowMain = 5; % for the main figure

markerS = 2.2;
markerM = 4.4;
markerL = 6.6;

%%
load('cellList_DRw.mat','T');
tDRw = T;

load('cellList_DRun.mat','T');
tDRun = T;

load('cellList_Nolight.mat','T');
tNolight = T;

ylimFr = 50;
xlimBurst = 15;

%% Correlation
% PN criteria
pnDRw = (tDRw.fr_task > 0.01 & tDRw.fr_task < 10);
% & (tDRw.burstIdx > 0.4);
npnDRw = sum(double(pnDRw));
inDRw = (tDRw.fr_task > 10);
ninDRw = sum(double(inDRw));

pnDRun = (tDRun.fr_task > 0.01 & tDRun.fr_task < 10);
% & (tDRun.burstIdx > 0.4);
npnDRun = sum(double(pnDRun));
inDRun = (tDRun.fr_task > 10);
ninDRun = sum(double(inDRun));

pnNolight = (tNolight.fr_task > 0.01 & tNolight.fr_task < 10);
% & (tNolight.burstIdx > 0.4);
npnNolight = sum(double(pnNolight));
inNolight = (tNolight.fr_task > 10);
ninNolight = sum(double(inNolight));

ypt_corrPnDRw = [tDRw.r_Corrhfxhf(pnDRw); tDRw.r_Corrbfxdr(pnDRw); tDRw.r_Corrbfxaft(pnDRw); tDRw.r_Corrdrxaft(pnDRw)];
ypt_corrPnDRun = [tDRun.r_Corrhfxhf(pnDRun); tDRun.r_Corrbfxdr(pnDRun); tDRun.r_Corrbfxaft(pnDRun); tDRun.r_Corrdrxaft(pnDRun)];
ypt_corrPnNolight = [tNolight.r_Corrhfxhf(pnNolight); tNolight.r_Corrbfxdr(pnNolight); tNolight.r_Corrbfxaft(pnNolight); tNolight.r_Corrdrxaft(pnNolight)];

ypt_corrInDRw = [tDRw.r_Corrhfxhf(inDRw); tDRw.r_Corrbfxdr(inDRw); tDRw.r_Corrbfxaft(inDRw); tDRw.r_Corrdrxaft(inDRw)];
ypt_corrInDRun = [tDRun.r_Corrhfxhf(inDRun); tDRun.r_Corrbfxdr(inDRun); tDRun.r_Corrbfxaft(inDRun); tDRun.r_Corrdrxaft(inDRun)];
ypt_corrInNolight = [tNolight.r_Corrhfxhf(inNolight); tNolight.r_Corrbfxdr(inNolight); tNolight.r_Corrbfxaft(inNolight); tNolight.r_Corrdrxaft(inNolight)];

xpt_corrPnDRw = [0.5+rand(1,npnDRw),3.5+rand(1,npnDRw),6.5+rand(1,npnDRw),9.5+rand(1,npnDRw)];
xpt_corrPnDRun = [0.5+rand(1,npnDRun),3.5+rand(1,npnDRun),6.5+rand(1,npnDRun),9.5+rand(1,npnDRun)];
xpt_corrPnNolight = [0.5+rand(1,npnNolight),3.5+rand(1,npnNolight),6.5+rand(1,npnNolight),9.5+rand(1,npnNolight)];

xpt_corrInDRw = [0.5+rand(1,ninDRw),3.5+rand(1,ninDRw),6.5+rand(1,ninDRw),9.5+rand(1,ninDRw)];
xpt_corrInDRun = [0.5+rand(1,ninDRun),3.5+rand(1,ninDRun),6.5+rand(1,ninDRun),9.5+rand(1,ninDRun)];
xpt_corrInNolight = [0.5+rand(1,ninNolight),3.5+rand(1,ninNolight),6.5+rand(1,ninNolight),9.5+rand(1,ninNolight)];


%% Pearson's correlation
% figure(4)
% hCorr(1) = axes('Position',axpt(3,2,1,1,[0.1 0.1 0.85 0.85], wideInterval));
% hold on;
% plot(xpt_corrPnDRw, ypt_corrPnDRw,'o');
% title('Stimulation during Reward zone (PN)');
% 
% hCorr(2) = axes('Position',axpt(3,2,2,1,[0.1 0.1 0.85 0.85], wideInterval));
% hold on;
% plot(xpt_corrPnDRun, ypt_corrPnDRun,'o');
% title('Stimulation during Running zone (PN)');
% 
% hCorr(3) = axes('Position',axpt(3,2,3,1,[0.1 0.1 0.85 0.85], wideInterval));
% hold on;
% plot(xpt_corrPnNolight, ypt_corrPnNolight,'o');
% title('No Stimulation (PN)');
% 
% hCorr(4) = axes('Position',axpt(3,2,1,2,[0.1 0.1 0.85 0.85], wideInterval));
% plot(xpt_corrInDRw, ypt_corrInDRw,'o');
% title('Stimulation during Reward zone (IN)');
% 
% hCorr(5) = axes('Position',axpt(3,2,2,2,[0.1 0.1 0.85 0.85], wideInterval));
% plot(xpt_corrInDRun, ypt_corrInDRun,'o');
% title('Stimulation during Running zone (IN)');
% 
% hCorr(6) = axes('Position',axpt(3,2,3,2,[0.1 0.1 0.85 0.85], wideInterval));
% plot(xpt_corrInNolight, ypt_corrInNolight,'o');
% title('No Stimulation (IN)');
% 
% set(hCorr,'TickDir','out','Box','off','XLim',[0,11],'YLim',[-1.2,1.2],'XTick',[1,4,7,10],'XTickLabel',[{'hf x hf','bf x dur', 'bf x aft','dur x aft'}]);


%% Fisher's transformation
% figure(5)
% hFisher(1) = axes('Position',axpt(3,2,1,1,[0.1 0.1 0.85 0.85], wideInterval));
% hold on;
% plot(xpt_corrPnDRw, fisherZ(ypt_corrPnDRw),'o');
% title('Stimulation during Reward zone (PN)');
% 
% hFisher(2) = axes('Position',axpt(3,2,2,1,[0.1 0.1 0.85 0.85], wideInterval));
% hold on;
% plot(xpt_corrPnDRun, fisherZ(ypt_corrPnDRun),'o');
% title('Stimulation during Running zone (PN)');
% 
% hFisher(3) = axes('Position',axpt(3,2,3,1,[0.1 0.1 0.85 0.85], wideInterval));
% hold on;
% plot(xpt_corrPnNolight, fisherZ(ypt_corrPnNolight),'o');
% title('No Stimulation (PN)');
% 
% hFisher(4) = axes('Position',axpt(3,2,1,2,[0.1 0.1 0.85 0.85], wideInterval));
% plot(xpt_corrInDRw, fisherZ(ypt_corrInDRw),'o');
% title('Stimulation during Reward zone (IN)');
% 
% hFisher(5) = axes('Position',axpt(3,2,2,2,[0.1 0.1 0.85 0.85], wideInterval));
% plot(xpt_corrInDRun, fisherZ(ypt_corrInDRun),'o');
% title('Stimulation during Running zone (IN)');
% 
% hFisher(6) = axes('Position',axpt(3,2,3,2,[0.1 0.1 0.85 0.85], wideInterval));
% plot(xpt_corrInNolight, fisherZ(ypt_corrInNolight),'o');
% title('No Stimulation (IN)');
% 
% set(hFisher,'TickDir','out','Box','off','XLim',[0,11],'XTick',[1,4,7,10],'XTickLabel',[{'hf x hf','bf x dur', 'bf x aft','dur x aft'}]);

%%
figure(1)
hCell(1) = axes('Position',axpt(2,2,1,1,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
    plot(tDRw.burstIdx,tDRw.fr_task,'o','MarkerSize',markerM,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
    hold on;
    line([0.4, 0.4], [-1, ylimFr],'LineStyle','--','Color',colorGray,'LineWidth',1);
    line([-0.1, xlimBurst], [10, 10],'LineStyle','--','Color',colorGray,'LineWidth',1);
    set(hCell(1),'XLim',[-0.1, 1],'YLim',[-1, ylimFr]);
    xlabel('Burst Index (% ISI < (mean ISI)/4)');
    ylabel('Firing rate (Hz)');
    

hCell(2) = axes('Position',axpt(2,2,1,2,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
    plot(tDRw.spkwth,tDRw.fr_task,'o','MarkerSize',markerM,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
    set(hCell(2),'XLim',[50, 500],'YLim',[-1, 50]);
    xlabel('Spike width (ms)');
    ylabel('Firing rate (Hz)');
    
hCell(3) = axes('Position',axpt(2,2,2,1,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
    plot(tDRw.hfwth,tDRw.fr_task,'o','MarkerSize',markerM,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
    set(hCell(3),'XLim',[50, 650],'YLim',[-1, 50]);
    xlabel('Half valley width (ms)');
    ylabel('Firing rate (Hz)');
    
hCell(4) = axes('Position',axpt(2,2,2,2,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
    plot(tDRw.burstIdx,tDRw.hfwth,'o','MarkerSize',markerM,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
    set(hCell(4),'YLim',[0, 650]);
    xlabel('Burst Index (% ISI < (mean ISI)/4)');
    ylabel('Half valley width (ms)');
    
    set(hCell,'TickDir','out','Box','off');
    print(gcf,'-dtiff','-r300','fig1_DRw')

%%
figure(2)
hCell(1) = axes('Position',axpt(2,2,1,1,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
    plot(tDRun.burstIdx,tDRun.fr_task,'o','MarkerSize',markerM,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
    hold on;
    line([0.4, 0.4], [-1, ylimFr],'LineStyle','--','Color',colorGray,'LineWidth',1);
    line([-0.1, xlimBurst], [10, 10],'LineStyle','--','Color',colorGray,'LineWidth',1);
    set(hCell(1),'XLim',[-0.1, 1],'YLim',[-1, ylimFr]);
    xlabel('Burst Index (% ISI < (mean ISI)/4)');
    ylabel('Firing rate (Hz)');
    

hCell(2) = axes('Position',axpt(2,2,1,2,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
    plot(tDRun.spkwth,tDRun.fr_task,'o','MarkerSize',markerM,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
    set(hCell(2),'XLim',[50, 500],'YLim',[-1, 50]);
    xlabel('Spike width (ms)');
    ylabel('Firing rate (Hz)');
    
hCell(3) = axes('Position',axpt(2,2,2,1,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
    plot(tDRun.hfwth,tDRun.fr_task,'o','MarkerSize',markerM,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
    set(hCell(3),'XLim',[50, 650],'YLim',[-1, 50]);
    xlabel('Half valley width (ms)');
    ylabel('Firing rate (Hz)');
    
hCell(4) = axes('Position',axpt(2,2,2,2,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
    plot(tDRun.burstIdx,tDRun.hfwth,'o','MarkerSize',markerM,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
    set(hCell(4),'YLim',[0, 650]);
    xlabel('Burst Index (% ISI < (mean ISI)/4)');
    ylabel('Half valley width (ms)');
    
    set(hCell,'TickDir','out','Box','off');
    print(gcf,'-dtiff','-r300','fig1_DRun')

%%
figure(3)
hCell(1) = axes('Position',axpt(2,2,1,1,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
    plot(tNolight.burstIdx,tNolight.fr_task,'o','MarkerSize',markerM,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
    hold on;
    line([0.4, 0.4], [-1, ylimFr],'LineStyle','--','Color',colorGray,'LineWidth',1);
    line([-0.1, xlimBurst], [10, 10],'LineStyle','--','Color',colorGray,'LineWidth',1);
    set(hCell(1),'XLim',[-0.1, 1],'YLim',[-1, ylimFr]);
    xlabel('Burst Index (% ISI < (mean ISI)/4)');
    ylabel('Firing rate (Hz)');
    

hCell(2) = axes('Position',axpt(2,2,1,2,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
    plot(tNolight.spkwth,tNolight.fr_task,'o','MarkerSize',markerM,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
    set(hCell(2),'XLim',[50, 500],'YLim',[-1, 50]);
    xlabel('Spike width (ms)');
    ylabel('Firing rate (Hz)');
    
hCell(3) = axes('Position',axpt(2,2,2,1,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
    plot(tNolight.hfwth,tNolight.fr_task,'o','MarkerSize',markerM,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
    set(hCell(3),'XLim',[50, 650],'YLim',[-1, 50]);
    xlabel('Half valley width (ms)');
    ylabel('Firing rate (Hz)');
    
hCell(4) = axes('Position',axpt(2,2,2,2,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
    plot(tNolight.burstIdx,tNolight.hfwth,'o','MarkerSize',markerM,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
    set(hCell(4),'YLim',[0, 650]);
    xlabel('Burst Index (% ISI < (mean ISI)/4)');
    ylabel('Half valley width (ms)');
    
    set(hCell,'TickDir','out','Box','off');
    print(gcf,'-dtiff','-r300','fig1_Nolight')
