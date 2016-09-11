clf; clearvars;

lineWth = [1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75];
fontS = 4; fontM = 6; fontL = 8; % font size
lineS = 0.2; lineM = 0.5; lineL = 1; % line width
tightInterval = [0.02 0.02]; midInterval = [0.09, 0.09]; wideInterval = [0.14 0.14];
markerS = 2.2; markerM = 4.4; markerL = 6.6; markerXL = 8.8;
scatterS = 26; scatterM = 36; scatterL = 54;

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

%%
load('cellList','T');

ylimFr = 50;
xlimBurst = 15;

%% Correlation
% PN criteria
pnDRw = (T.fr_task > 0.01 & T.fr_task < 10);
% & (tDRw.burstIdx > 0.4);
npnDRw = sum(double(pnDRw));
inDRw = (T.fr_task > 10);
ninDRw = sum(double(inDRw));


%%
figure(1)
hCell(1) = axes('Position',axpt(2,2,1,1,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
    plot(T.burstIdx,T.fr_task,'o','MarkerSize',markerM,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
    hold on;
    line([-0.1, 1], [10, 10],'LineStyle','--','Color',colorGray,'LineWidth',1);
    set(hCell(1),'XLim',[-0.1, 1],'YLim',[-1, ylimFr]);
    xlabel('Burst Index (% ISI < (mean ISI)/4)');
    ylabel('Firing rate (Hz)');
    title('Stimulation during Reward');

hCell(2) = axes('Position',axpt(2,2,1,2,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
    plot(T.spkwth,T.fr_task,'o','MarkerSize',markerM,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
    set(hCell(2),'XLim',[50, 500],'YLim',[-1, 50]);
    xlabel('Spike width (ms)');
    ylabel('Firing rate (Hz)');
    
hCell(3) = axes('Position',axpt(2,2,2,1,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
    plot(T.hfwth,T.fr_task,'o','MarkerSize',markerM,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
    set(hCell(3),'XLim',[50, 650],'YLim',[-1, 50]);
    xlabel('Half valley width (ms)');
    ylabel('Firing rate (Hz)');
    
hCell(4) = axes('Position',axpt(2,2,2,2,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
    plot(T.burstIdx,T.hfwth,'o','MarkerSize',markerM,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
    set(hCell(4),'YLim',[0, 650]);
    xlabel('Burst Index (% ISI < (mean ISI)/4)');
    ylabel('Half valley width (ms)');
    
    set(hCell,'TickDir','out','Box','off');
    print(gcf,'-dtiff','-r300','fig1_totalPopulation')

%%
% figure(2)
% hCell(1) = axes('Position',axpt(2,2,1,1,[0.1 0.1 0.85 0.85],wideInterval));
% hold on;
%     plot(tDRun.burstIdx,tDRun.fr_task,'o','MarkerSize',markerM,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
%     hold on;
%     line([-0.1, 1], [10, 10],'LineStyle','--','Color',colorGray,'LineWidth',1);
%     set(hCell(1),'XLim',[-0.1, 1],'YLim',[-1, ylimFr]);
%     xlabel('Burst Index (% ISI < (mean ISI)/4)');
%     ylabel('Firing rate (Hz)');
%     title('Stimulation during Run');
% 
% hCell(2) = axes('Position',axpt(2,2,1,2,[0.1 0.1 0.85 0.85],wideInterval));
% hold on;
%     plot(tDRun.spkwth,tDRun.fr_task,'o','MarkerSize',markerM,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
%     set(hCell(2),'XLim',[50, 500],'YLim',[-1, 50]);
%     xlabel('Spike width (ms)');
%     ylabel('Firing rate (Hz)');
%     
% hCell(3) = axes('Position',axpt(2,2,2,1,[0.1 0.1 0.85 0.85],wideInterval));
% hold on;
%     plot(tDRun.hfwth,tDRun.fr_task,'o','MarkerSize',markerM,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
%     set(hCell(3),'XLim',[50, 650],'YLim',[-1, 50]);
%     xlabel('Half valley width (ms)');
%     ylabel('Firing rate (Hz)');
%     
% hCell(4) = axes('Position',axpt(2,2,2,2,[0.1 0.1 0.85 0.85],wideInterval));
% hold on;
%     plot(tDRun.burstIdx,tDRun.hfwth,'o','MarkerSize',markerM,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
%     set(hCell(4),'YLim',[0, 650]);
%     xlabel('Burst Index (% ISI < (mean ISI)/4)');
%     ylabel('Half valley width (ms)');
%     
%     set(hCell,'TickDir','out','Box','off');
%     print(gcf,'-dtiff','-r300','fig1_DRun_10')
% 
% %%
% figure(3)
% hCell(1) = axes('Position',axpt(2,2,1,1,[0.1 0.1 0.85 0.85],wideInterval));
% hold on;
%     plot(tNolight.burstIdx,tNolight.fr_task,'o','MarkerSize',markerM,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
%     hold on;
%     line([-0.1, 1], [10, 10],'LineStyle','--','Color',colorGray,'LineWidth',1);
%     set(hCell(1),'XLim',[-0.1, 1],'YLim',[-1, ylimFr]);
%     xlabel('Burst Index (% ISI < (mean ISI)/4)');
%     ylabel('Firing rate (Hz)');
%     title('No Stimulation');    
% 
% hCell(2) = axes('Position',axpt(2,2,1,2,[0.1 0.1 0.85 0.85],wideInterval));
% hold on;
%     plot(tNolight.spkwth,tNolight.fr_task,'o','MarkerSize',markerM,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
%     set(hCell(2),'XLim',[50, 500],'YLim',[-1, 50]);
%     xlabel('Spike width (ms)');
%     ylabel('Firing rate (Hz)');
%     
% hCell(3) = axes('Position',axpt(2,2,2,1,[0.1 0.1 0.85 0.85],wideInterval));
% hold on;
%     plot(tNolight.hfwth,tNolight.fr_task,'o','MarkerSize',markerM,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
%     set(hCell(3),'XLim',[50, 650],'YLim',[-1, 50]);
%     xlabel('Half valley width (ms)');
%     ylabel('Firing rate (Hz)');
%     
% hCell(4) = axes('Position',axpt(2,2,2,2,[0.1 0.1 0.85 0.85],wideInterval));
% hold on;
%     plot(tNolight.burstIdx,tNolight.hfwth,'o','MarkerSize',markerM,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
%     set(hCell(4),'YLim',[0, 650]);
%     xlabel('Burst Index (% ISI < (mean ISI)/4)');
%     ylabel('Half valley width (ms)');
%     
%     set(hCell,'TickDir','out','Box','off');
%     print(gcf,'-dtiff','-r300','fig1_Nolight_10')
