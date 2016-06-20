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

% four group color
colorPink = [183, 28, 28]./255;
colorPurple = [74, 20, 140]./255;
colorBlue3 = [13, 71, 161]./255;
colorOrange = [27, 94, 32]./255;

tightInterval = [0.02 0.02];
wideInterval = [0.09 0.09];

nCol = 4;
nRowSub = 8; % for the left column
nRowMain = 5; % for the main figure

markerS = 2.2;
markerM = 4.4;
markerL = 6.6;

%%
load('cellList_DRw_10.mat','T');
tDRw = T;

load('cellList_DRun_10.mat','T');
tDRun = T;

load('cellList_Nolight_10.mat','T');
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

xpt_corrPnDRw = [ones(npnDRw,1);ones(npnDRw,1)*2; ones(npnDRw,1)*3; ones(npnDRw,1)*4];
xpt_corrPnDRun = [ones(npnDRun,1);ones(npnDRun,1)*2;ones(npnDRun,1)*3;ones(npnDRun,1)*4];
xpt_corrPnNolight = [ones(npnNolight,1);ones(npnNolight,1)*2;ones(npnNolight,1)*3;ones(npnNolight,1)*4];

xpt_corrInDRw = [ones(ninDRw,1); ones(ninDRw,1)*2; ones(ninDRw,1)*3; ones(ninDRw,1)*4];
xpt_corrInDRun = [ones(ninDRun,1); ones(ninDRun,1)*2; ones(ninDRun,1)*3; ones(ninDRun,1)*4];
xpt_corrInNolight = [ones(ninNolight,1); ones(ninNolight,1)*2; ones(ninNolight,1)*3; ones(ninNolight,1)*4];

% z-transformation
[ypt_ZcorrPnDRw, ~] = fisherZ(ypt_corrPnDRw);
[ypt_ZcorrPnDRun, ~] = fisherZ(ypt_corrPnDRun);
[ypt_ZcorrPnNolight, ~] = fisherZ(ypt_corrPnNolight);
[ypt_ZcorrInDRw, ~] = fisherZ(ypt_corrInDRw);
[ypt_ZcorrInDRun, ~] = fisherZ(ypt_corrInDRun);
[ypt_ZcorrInNolight, ~] = fisherZ(ypt_corrInNolight);

[~, ~, statsPnDRw] = anovan(ypt_ZcorrPnDRw,{xpt_corrPnDRw},'display','off');
[~, ~, statsPnDRun] = anovan(ypt_ZcorrPnDRun,{xpt_corrPnDRun},'display','off');
[~, ~, statsPnNolight] = anovan(ypt_ZcorrPnNolight,{xpt_corrPnNolight},'display','off');
[~, ~, statsInDRw] = anovan(ypt_ZcorrInDRw,{xpt_corrInDRw},'display','off');
[~, ~, statsInDRun] = anovan(ypt_ZcorrInDRun,{xpt_corrInDRun},'display','off');
[~, ~, statsInNolight] = anovan(ypt_ZcorrInNolight,{xpt_corrInNolight},'display','off');

mulPnDRw = multcompare(statsPnDRw,'display','off');
mulPnDRun = multcompare(statsPnDRun,'display','off');
mulPnNolight = multcompare(statsPnNolight,'display','off');
mulInDRw = multcompare(statsInDRw,'display','off');
mulInDRun = multcompare(statsInDRun,'display','off');
mulInNolight = multcompare(statsInNolight,'display','off');

%%
figure(1)
hCell(1) = axes('Position',axpt(2,2,1,1,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
    plot(tDRw.burstIdx,tDRw.fr_task,'o','MarkerSize',markerM,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
    hold on;
    line([-0.1, 1], [10, 10],'LineStyle','--','Color',colorGray,'LineWidth',1);
    set(hCell(1),'XLim',[-0.1, 1],'YLim',[-1, ylimFr]);
    xlabel('Burst Index (% ISI < (mean ISI)/4)');
    ylabel('Firing rate (Hz)');
    title('Stimulation during Reward');

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
    print(gcf,'-dtiff','-r300','fig1_DRw_10')

%%
figure(2)
hCell(1) = axes('Position',axpt(2,2,1,1,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
    plot(tDRun.burstIdx,tDRun.fr_task,'o','MarkerSize',markerM,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
    hold on;
    line([-0.1, 1], [10, 10],'LineStyle','--','Color',colorGray,'LineWidth',1);
    set(hCell(1),'XLim',[-0.1, 1],'YLim',[-1, ylimFr]);
    xlabel('Burst Index (% ISI < (mean ISI)/4)');
    ylabel('Firing rate (Hz)');
    title('Stimulation during Run');

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
    print(gcf,'-dtiff','-r300','fig1_DRun_10')

%%
figure(3)
hCell(1) = axes('Position',axpt(2,2,1,1,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
    plot(tNolight.burstIdx,tNolight.fr_task,'o','MarkerSize',markerM,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
    hold on;
    line([-0.1, 1], [10, 10],'LineStyle','--','Color',colorGray,'LineWidth',1);
    set(hCell(1),'XLim',[-0.1, 1],'YLim',[-1, ylimFr]);
    xlabel('Burst Index (% ISI < (mean ISI)/4)');
    ylabel('Firing rate (Hz)');
    title('No Stimulation');    

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
    print(gcf,'-dtiff','-r300','fig1_Nolight_10')
