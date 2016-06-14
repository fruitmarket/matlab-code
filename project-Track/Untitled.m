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

%%%%%%%%%%%%%%%

load('cellList_DRw.mat');
% load('cellList_DRun.mat');
thr_ptag = 0.05;
thr_pModu = 0.05;
thr_moduRatio = 0.01;
thr_tagRatio = 0.01;
thr_Fr = 0.01;

cellCut = T.fr_task>thr_Fr;

ylimFr = 50;
xlimBurst = 15;

% fHandle = figure('PaperUnits','centimeters','PaperPosition',[0.1 0.5 18.3 13.725]);
figure(1)
hCell(1) = axes('Position',axpt(2,2,1,1,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
    plot(T.burstIdx,T.fr_task,'o','MarkerSize',markerM,'MarkerEdgeColor','k','MarkerFaceColor',colorGray);
    hold on;
    line([0.4, 0.4], [-1, ylimFr],'LineStyle','--','Color',colorGray,'LineWidth',1);
    line([-0.1, xlimBurst], [15, 15],'LineStyle','--','Color',colorGray,'LineWidth',1);
    set(hCell(1),'XLim',[-0.1, 1],'YLim',[-1, ylimFr]);
    xlabel('Burst Index (% ISI < (mean ISI)/4)');
    ylabel('Firing rate (Hz)');
    

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
    print(gcf,'-dtiff','-r300','Cell classification')

% (T.taskType == 'DRw') && T.T.fr_task > 0.05 && T.p_modu<0.05 && T.moduRaio>0.01

%%
cutTag = T.p_tag < thr_ptag;
cutModu = T.p_modu < thr_pModu;

cutted_ratio = (T.tagRatio > 0.2) | (T.moduRatio > 0.2);
nRest = sum(double(~cutted_ratio));

cutted_tagstat = (T.p_tag < 0.05) | (T.p_modu < 0.05);

lightCell = cutted_ratio & cutted_tagstat;
nlightCell = sum(double(lightCell));

nolightCell = cutted_ratio & ~cutted_tagstat;
nnolightCell = sum(double(nolightCell));

nTotal = nRest + nlightCell + nnolightCell;
lightPie = [nRest, nlightCell, nnolightCell];

% PN & IN
cutted_PN = (T.fr_task < 15) & (T.burstIdx > 0.4);
nPN = sum(double(cutted_PN));

cutted_IN = (T.fr_task > 15);
nIN = sum(double(cutted_IN));

lightPN = lightCell & cutted_PN;
nlightPN = sum(double(lightPN));

lightIN = lightCell & cutted_IN;
nlightIN = sum(double(lightIN));

pnPie = [nlightPN, (nPN-nlightPN)];
inPie = [nlightIN, (nIN-nlightIN)];

% label_pie1 = ;
% label_pie2 = ;
label_pie1 = strcat({'Low FR neurons (<0.01 Hz): n=';'Light responsed neurons: n=';'Not responsed neurons: n='},...
    {num2str(nRest); num2str(nlightCell); num2str(nnolightCell)});
label_pie2 = strcat({'Light responsed PN: n=';'Not responsed PN: n='},...
    {num2str(nlightPN); num2str(nPN-nlightPN)});
label_pie3 = strcat({'Light responsed IN: n=';'Not responsed IN: n='},...
    {num2str(nlightIN); num2str(nIN-nlightIN)});

figure(2)
hPie(1) = axes('Position',axpt(3,1,1,1,[],wideInterval));
    hold on;
    pie(lightPie,[1,1,1],label_pie1);

hPie(2) = axes('Position',axpt(3,1,2,1,[],wideInterval));
    hold on;
    pie(pnPie,[1,1],label_pie2);
    
hPie(3) = axes('Position',axpt(3,1,3,1,[],wideInterval));
    hold on;
    pie(inPie,[1,1],label_pie3);

    set(hPie,'Box','off','Visible','off');


    
    