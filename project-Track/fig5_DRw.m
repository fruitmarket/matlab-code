clearvars;

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

load cellList_DRw_100.mat

tDRw = T;
idx_PN = tDRw.fr_task <= 10;
idx_IN = tDRw.fr_task > 10;
idx_pSalt = (tDRw.p_saltModu < 0.05 ) | (tDRw.p_saltTag < 0.05);
idx_stb = tDRw.r_Corrhfxhf > 0.9;

% Latency: 1st row:PN, 2nd row: IN
latency(1,1) = nanmean(tDRw.latency_modu(idx_PN & idx_pSalt));
latency(1,2) = nanstd(tDRw.latency_modu(idx_PN & idx_pSalt))/sum(double(idx_PN & idx_pSalt));
latency(2,1) = nanmean(tDRw.latency_modu(idx_IN & idx_pSalt));
latency(2,2) = nanstd(tDRw.latency_modu(idx_IN & idx_pSalt),1)/sum(double(idx_IN & idx_pSalt));

% Stability based on pSalt, hf x hf stability
idx_PNpSaltStb = idx_PN & idx_pSalt & idx_stb;
idx_PNpSaltUnstb = idx_PN & idx_pSalt & ~idx_stb;
idx_InpSaltStb = idx_IN & idx_pSalt & idx_stb;
idx_InpSaltUnstb = idx_IN & idx_pSalt & ~idx_stb;

nPnStb = sum(double(idx_PNpSaltStb));
nPnUnstb = sum(double(idx_PNpSaltUnstb));
nInStb = sum(double(idx_InpSaltStb));
nInUnstb = sum(double(idx_InpSaltUnstb));

xptPnStb = [ones(nPnStb,1);ones(nPnStb,1)*2;ones(nPnStb,1)*3;ones(nPnStb,1)*4];
xptPnUnstb = [ones(nPnUnstb,1);ones(nPnUnstb,1)*2;ones(nPnUnstb,1)*3;ones(nPnUnstb,1)*4];
% xptInStb = [ones(nInStb,1);ones(nInStb,1)*2;ones(nInStb,1)*3;ones(nInStb,1)*4];
xptInUnstb = [ones(nInUnstb,1);ones(nInUnstb,1)*2;ones(nInUnstb,1)*3;ones(nInUnstb,1)*4];

yptPnStb = [tDRw.r_Corrhfxhf(idx_PNpSaltStb);tDRw.r_Corrbfxdr(idx_PNpSaltStb);tDRw.r_Corrbfxaft(idx_PNpSaltStb);tDRw.r_Corrdrxaft(idx_PNpSaltStb)];
yptPnUnstb = [tDRw.r_Corrhfxhf(idx_PNpSaltUnstb);tDRw.r_Corrbfxdr(idx_PNpSaltUnstb);tDRw.r_Corrbfxaft(idx_PNpSaltUnstb);tDRw.r_Corrdrxaft(idx_PNpSaltUnstb)];
% yptInStb = [tDRw.r_Corrhfxhf(idx_InpSaltStb);tDRw.r_Corrbfxdr(idx_InpSaltStb);tDRw.r_Corrbfxaft(idx_InpSaltStb);tDRw.r_Corrdrxaft(idx_InpSaltStb)];
yptInUnstb = [tDRw.r_Corrhfxhf(idx_InpSaltUnstb);tDRw.r_Corrbfxdr(idx_InpSaltUnstb);tDRw.r_Corrbfxaft(idx_InpSaltUnstb);tDRw.r_Corrdrxaft(idx_InpSaltUnstb)];

% Z-transformation
[ypt_ZcorrPnStb, ~] = fisherZ(yptPnStb);
[ypt_ZcorrPnUnstb, ~] = fisherZ(yptPnUnstb);
% [ypt_ZcorrInStb, ~] = fisherZ(yptInStb);
[ypt_ZcorrInUnstb, ~] = fisherZ(yptInUnstb);

% multiway ANOVA
[~, ~, statsPnStb] = anovan(ypt_ZcorrPnStb,{xptPnStb},'display','off');
[~, ~, statsPnUnstb] = anovan(ypt_ZcorrPnUnstb,{xptPnUnstb},'display','off');
% [~, ~, statsInStb] = anovan(ypt_ZcorrInStb,{xptInStb},'display','off');
[~, ~, statsInUnstb] = anovan(ypt_ZcorrInUnstb,{xptInUnstb},'display','off');

% Multiple comparison
mulPnStb = multcompare(statsPnStb,'display','off');
mulPnUnstb = multcompare(statsPnUnstb,'display','off');
% mulPnUnstb = multcompare(statsInStb,'display','off');
mulInUnstb = multcompare(statsInUnstb,'display','off');

% Plot
hCorr(1) = axes('Position',axpt(2,2,1,1,[0.1 0.1 0.85 0.85], wideInterval));
hold on;
MyScatterBarPlot(yptPnStb,xptPnStb,0.35,{colorPink, colorPurple, colorBlue3, colorOrange},[]);
title('PN & pSalt < 0.05 & hfxhf > 0.9','FontSize',fontM);
text(4, -0.8,['n = ',num2str(nPnStb)]);

hCorr(2) = axes('Position',axpt(2,2,2,1,[0.1 0.1 0.85 0.85], wideInterval));
hold on;
MyScatterBarPlot(yptPnUnstb,xptPnUnstb,0.35,{colorPink, colorPurple, colorBlue3, colorOrange},[]);
title('PN & pSalt < 0.05 & hfxhf < 0.9','FontSize',fontM);
text(4, -0.8,['n = ',num2str(nPnUnstb)]);

% hCorr(3) = axes('Position',axpt(2,2,1,2,[0.1 0.1 0.85 0.85], wideInterval));
% hold on;
% MyScatterBarPlot(yptInStb,xptInStb,0.35,{colorPink, colorPurple, colorBlue3, colorOrange},[]);
% title('IN & pSalt < 0.05 & hfxhf > 0.9','FontSize',fontM);
% text(4, -0.8,['n = ',num2str(nInStb)]);

hCorr(3) = axes('Position',axpt(2,2,2,2,[0.1 0.1 0.85 0.85], wideInterval));
hold on;
MyScatterBarPlot(yptInUnstb,xptInUnstb,0.35,{colorPink, colorPurple, colorBlue3, colorOrange},[]);
title('IN & pSalt < 0.05 & hfxhf < 0.9','FontSize',fontM);
text(4, -0.8,['n = ',num2str(nInUnstb)]);

set(hCorr,'TickDir','out','Box','off','XLim',[0, 5],'YLim',[-1.2, 1.2],'XTick',[1,2,3,4],'XTickLabel',{'hf x hf','bf x dur', 'bf x aft','dur x aft'},'FontSize',fontM);
print(gcf, '-depsc','-r300','fig5_DRw_SaltCorr');
