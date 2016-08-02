function fig6_lightSeparation(intra_inter,intra_tag)
% clearvars;
clf; close all;

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

%
load('cellList_new.mat');
T((T.taskType == 'nolight'),:) = [];
T(~(T.taskProb == '100'),:) = [];

tDRw = T;

pnDRw = tDRw.fr_task > 0.01 & tDRw.fr_task < 10;
npnDRw = sum(double(pnDRw));
inDRw = tDRw.fr_task > 10;
ninDRw = sum(double(inDRw));

intraAc = tDRw.intraLightDir==1;
intraIn = tDRw.intraLightDir==-1;
intraNo = tDRw.intraLightDir==0;

interAc = tDRw.interLightDir==1;
interIn = tDRw.interLightDir==-1;
interNo = tDRw.interLightDir==0;

tagAc = tDRw.tagLightDir==1;
tagIn = tDRw.tagLightDir==-1;
tagNo = tDRw.tagLightDir==0;

nPnAcAc = sum(double(pnDRw&intraAc&interAc));
nPnAcIn = sum(double(pnDRw&intraAc&interIn));
nPnAcNo = sum(double(pnDRw&intraAc&interNo));
nPnInAc = sum(double(pnDRw&intraIn&interAc));
nPnInIn = sum(double(pnDRw&intraIn&interIn));
nPnInNo = sum(double(pnDRw&intraIn&interNo));
nPnNoAc = sum(double(pnDRw&intraNo&interAc));
nPnNoIn = sum(double(pnDRw&intraNo&interIn));
nPnNoNo = sum(double(pnDRw&intraNo&interNo));

nTagPnAcAc = sum(double(pnDRw&intraAc&tagAc));
nTagPnAcIn = sum(double(pnDRw&intraAc&tagIn));
nTagPnAcNo = sum(double(pnDRw&intraAc&tagNo));
nTagPnInAc = sum(double(pnDRw&intraIn&tagAc));
nTagPnInIn = sum(double(pnDRw&intraIn&tagIn));
nTagPnInNo = sum(double(pnDRw&intraIn&tagNo));
nTagPnNoAc = sum(double(pnDRw&intraNo&tagAc));
nTagPnNoIn = sum(double(pnDRw&intraNo&tagIn));
nTagPnNoNo = sum(double(pnDRw&intraNo&tagNo));

xpt_corrPnAcAc = [ones(nPnAcAc,1);ones(nPnAcAc,1)*2;ones(nPnAcAc,1)*3;ones(nPnAcAc,1)*4];
xpt_corrPnAcIn = [ones(nPnAcIn,1);ones(nPnAcIn,1)*2;ones(nPnAcIn,1)*3;ones(nPnAcIn,1)*4];
xpt_corrPnAcNo = [ones(nPnAcNo,1);ones(nPnAcNo,1)*2;ones(nPnAcNo,1)*3;ones(nPnAcNo,1)*4];
xpt_corrPnInAc = [ones(nPnInAc,1);ones(nPnInAc,1)*2;ones(nPnInAc,1)*3;ones(nPnInAc,1)*4];
xpt_corrPnInIn = [ones(nPnInIn,1);ones(nPnInIn,1)*2;ones(nPnInIn,1)*3;ones(nPnInIn,1)*4];
xpt_corrPnInNo = [ones(nPnInNo,1);ones(nPnInNo,1)*2;ones(nPnInNo,1)*3;ones(nPnInNo,1)*4];
xpt_corrPnNoAc = [ones(nPnNoAc,1);ones(nPnNoAc,1)*2;ones(nPnNoAc,1)*3;ones(nPnNoAc,1)*4];
xpt_corrPnNoIn = [ones(nPnNoIn,1);ones(nPnNoIn,1)*2;ones(nPnNoIn,1)*3;ones(nPnNoIn,1)*4];
xpt_corrPnNoNo = [ones(nPnNoNo,1);ones(nPnNoNo,1)*2;ones(nPnNoNo,1)*3;ones(nPnNoNo,1)*4];

xpt_corrTagPnAcAc = [ones(nTagPnAcAc,1);ones(nTagPnAcAc,1)*2;ones(nTagPnAcAc,1)*3;ones(nTagPnAcAc,1)*4];
xpt_corrTagPnAcIn = [ones(nTagPnAcIn,1);ones(nTagPnAcIn,1)*2;ones(nTagPnAcIn,1)*3;ones(nTagPnAcIn,1)*4];
xpt_corrTagPnAcNo = [ones(nTagPnAcNo,1);ones(nTagPnAcNo,1)*2;ones(nTagPnAcNo,1)*3;ones(nTagPnAcNo,1)*4];
xpt_corrTagPnInAc = [ones(nTagPnInAc,1);ones(nTagPnInAc,1)*2;ones(nTagPnInAc,1)*3;ones(nTagPnInAc,1)*4];
xpt_corrTagPnInIn = [ones(nTagPnInIn,1);ones(nTagPnInIn,1)*2;ones(nTagPnInIn,1)*3;ones(nTagPnInIn,1)*4];
xpt_corrTagPnInNo = [ones(nTagPnInNo,1);ones(nTagPnInNo,1)*2;ones(nTagPnInNo,1)*3;ones(nTagPnInNo,1)*4];
xpt_corrTagPnNoAc = [ones(nTagPnNoAc,1);ones(nTagPnNoAc,1)*2;ones(nTagPnNoAc,1)*3;ones(nTagPnNoAc,1)*4];
xpt_corrTagPnNoIn = [ones(nTagPnNoIn,1);ones(nTagPnNoIn,1)*2;ones(nTagPnNoIn,1)*3;ones(nTagPnNoIn,1)*4];
xpt_corrTagPnNoNo = [ones(nTagPnNoNo,1);ones(nTagPnNoNo,1)*2;ones(nTagPnNoNo,1)*3;ones(nTagPnNoNo,1)*4];

% Population separation track(intra) vs track(inter)
subTbl_trXtr = [sum(double(pnDRw&intraAc&interAc)), sum(double(pnDRw&intraAc&interIn)), sum(double(pnDRw&intraAc&interNo));
            sum(double(pnDRw&intraIn&interAc)), sum(double(pnDRw&intraIn&interIn)), sum(double(pnDRw&intraIn&interNo));
            sum(double(pnDRw&intraNo&interAc)), sum(double(pnDRw&intraNo&interIn)), sum(double(pnDRw&intraNo&interNo))];
% Population separation track vs tag
subTbl_trXtg = [sum(double(pnDRw&intraAc&tagAc)), sum(double(pnDRw&intraAc&tagIn)), sum(double(pnDRw&intraAc&tagNo));
            sum(double(pnDRw&intraIn&tagAc)), sum(double(pnDRw&intraIn&tagIn)), sum(double(pnDRw&intraIn&tagNo));
            sum(double(pnDRw&intraNo&tagAc)), sum(double(pnDRw&intraNo&tagIn)), sum(double(pnDRw&intraNo&tagNo))];
        
ypt_corrPnAcAc = [tDRw.r_Corrhfxhf(pnDRw&intraAc&interAc); tDRw.r_Corrbfxdr(pnDRw&intraAc&interAc); tDRw.r_Corrbfxaft(pnDRw&intraAc&interAc); tDRw.r_Corrdrxaft(pnDRw&intraAc&interAc)];
ypt_corrPnAcIn = [tDRw.r_Corrhfxhf(pnDRw&intraAc&interIn); tDRw.r_Corrbfxdr(pnDRw&intraAc&interIn); tDRw.r_Corrbfxaft(pnDRw&intraAc&interIn); tDRw.r_Corrdrxaft(pnDRw&intraAc&interIn)];
ypt_corrPnAcNo = [tDRw.r_Corrhfxhf(pnDRw&intraAc&interNo); tDRw.r_Corrbfxdr(pnDRw&intraAc&interNo); tDRw.r_Corrbfxaft(pnDRw&intraAc&interNo); tDRw.r_Corrdrxaft(pnDRw&intraAc&interNo)];
ypt_corrPnInAc = [tDRw.r_Corrhfxhf(pnDRw&intraIn&interAc); tDRw.r_Corrbfxdr(pnDRw&intraIn&interAc); tDRw.r_Corrbfxaft(pnDRw&intraIn&interAc); tDRw.r_Corrdrxaft(pnDRw&intraIn&interAc)];
ypt_corrPnInIn = [tDRw.r_Corrhfxhf(pnDRw&intraIn&interIn); tDRw.r_Corrbfxdr(pnDRw&intraIn&interIn); tDRw.r_Corrbfxaft(pnDRw&intraIn&interIn); tDRw.r_Corrdrxaft(pnDRw&intraIn&interIn)];
ypt_corrPnInNo = [tDRw.r_Corrhfxhf(pnDRw&intraIn&interNo); tDRw.r_Corrbfxdr(pnDRw&intraIn&interNo); tDRw.r_Corrbfxaft(pnDRw&intraIn&interNo); tDRw.r_Corrdrxaft(pnDRw&intraIn&interNo)];
ypt_corrPnNoAc = [tDRw.r_Corrhfxhf(pnDRw&intraNo&interAc); tDRw.r_Corrbfxdr(pnDRw&intraNo&interAc); tDRw.r_Corrbfxaft(pnDRw&intraNo&interAc); tDRw.r_Corrdrxaft(pnDRw&intraNo&interAc)];
ypt_corrPnNoIn = [tDRw.r_Corrhfxhf(pnDRw&intraNo&interIn); tDRw.r_Corrbfxdr(pnDRw&intraNo&interIn); tDRw.r_Corrbfxaft(pnDRw&intraNo&interIn); tDRw.r_Corrdrxaft(pnDRw&intraNo&interIn)];
ypt_corrPnNoNo = [tDRw.r_Corrhfxhf(pnDRw&intraNo&interNo); tDRw.r_Corrbfxdr(pnDRw&intraNo&interNo); tDRw.r_Corrbfxaft(pnDRw&intraNo&interNo); tDRw.r_Corrdrxaft(pnDRw&intraNo&interNo)];

ypt_corrTagPnAcAc = [tDRw.r_Corrhfxhf(pnDRw&intraAc&tagAc); tDRw.r_Corrbfxdr(pnDRw&intraAc&tagAc); tDRw.r_Corrbfxaft(pnDRw&intraAc&tagAc); tDRw.r_Corrdrxaft(pnDRw&intraAc&tagAc)];
ypt_corrTagPnAcIn = [tDRw.r_Corrhfxhf(pnDRw&intraAc&tagIn); tDRw.r_Corrbfxdr(pnDRw&intraAc&tagIn); tDRw.r_Corrbfxaft(pnDRw&intraAc&tagIn); tDRw.r_Corrdrxaft(pnDRw&intraAc&tagIn)];
ypt_corrTagPnAcNo = [tDRw.r_Corrhfxhf(pnDRw&intraAc&tagNo); tDRw.r_Corrbfxdr(pnDRw&intraAc&tagNo); tDRw.r_Corrbfxaft(pnDRw&intraAc&tagNo); tDRw.r_Corrdrxaft(pnDRw&intraAc&tagNo)];
ypt_corrTagPnInAc = [tDRw.r_Corrhfxhf(pnDRw&intraIn&tagAc); tDRw.r_Corrbfxdr(pnDRw&intraIn&tagAc); tDRw.r_Corrbfxaft(pnDRw&intraIn&tagAc); tDRw.r_Corrdrxaft(pnDRw&intraIn&tagAc)];
ypt_corrTagPnInIn = [tDRw.r_Corrhfxhf(pnDRw&intraIn&tagIn); tDRw.r_Corrbfxdr(pnDRw&intraIn&tagIn); tDRw.r_Corrbfxaft(pnDRw&intraIn&tagIn); tDRw.r_Corrdrxaft(pnDRw&intraIn&tagIn)];
ypt_corrTagPnInNo = [tDRw.r_Corrhfxhf(pnDRw&intraIn&tagNo); tDRw.r_Corrbfxdr(pnDRw&intraIn&tagNo); tDRw.r_Corrbfxaft(pnDRw&intraIn&tagNo); tDRw.r_Corrdrxaft(pnDRw&intraIn&tagNo)];
ypt_corrTagPnNoAc = [tDRw.r_Corrhfxhf(pnDRw&intraNo&tagAc); tDRw.r_Corrbfxdr(pnDRw&intraNo&tagAc); tDRw.r_Corrbfxaft(pnDRw&intraNo&tagAc); tDRw.r_Corrdrxaft(pnDRw&intraNo&tagAc)];
ypt_corrTagPnNoIn = [tDRw.r_Corrhfxhf(pnDRw&intraNo&tagIn); tDRw.r_Corrbfxdr(pnDRw&intraNo&tagIn); tDRw.r_Corrbfxaft(pnDRw&intraNo&tagIn); tDRw.r_Corrdrxaft(pnDRw&intraNo&tagIn)];
ypt_corrTagPnNoNo = [tDRw.r_Corrhfxhf(pnDRw&intraNo&tagNo); tDRw.r_Corrbfxdr(pnDRw&intraNo&tagNo); tDRw.r_Corrbfxaft(pnDRw&intraNo&tagNo); tDRw.r_Corrdrxaft(pnDRw&intraNo&tagNo)];

% z-transformation
[ypt_ZcorrPnAcAc, ~] = fisherZ(ypt_corrPnAcAc);
[ypt_ZcorrPnAcIn, ~] = fisherZ(ypt_corrPnAcIn);
[ypt_ZcorrPnAcNo, ~] = fisherZ(ypt_corrPnAcNo);
[ypt_ZcorrPnInAc, ~] = fisherZ(ypt_corrPnInAc);
[ypt_ZcorrPnInIn, ~] = fisherZ(ypt_corrPnInIn);
[ypt_ZcorrPnInNo, ~] = fisherZ(ypt_corrPnInNo);
[ypt_ZcorrPnNoAc, ~] = fisherZ(ypt_corrPnNoAc);
[ypt_ZcorrPnNoIn, ~] = fisherZ(ypt_corrPnNoIn);
[ypt_ZcorrPnNoNo, ~] = fisherZ(ypt_corrPnNoNo);

[ypt_ZcorrTagPnAcAc, ~] = fisherZ(ypt_corrTagPnAcAc);
[ypt_ZcorrTagPnAcIn, ~] = fisherZ(ypt_corrTagPnAcIn);
[ypt_ZcorrTagPnAcNo, ~] = fisherZ(ypt_corrTagPnAcNo);
[ypt_ZcorrTagPnInAc, ~] = fisherZ(ypt_corrTagPnInAc);
[ypt_ZcorrTagPnInIn, ~] = fisherZ(ypt_corrTagPnInIn);
[ypt_ZcorrTagPnInNo, ~] = fisherZ(ypt_corrTagPnInNo);
[ypt_ZcorrTagPnNoAc, ~] = fisherZ(ypt_corrTagPnNoAc);
[ypt_ZcorrTagPnNoIn, ~] = fisherZ(ypt_corrTagPnNoIn);
[ypt_ZcorrTagPnNoNo, ~] = fisherZ(ypt_corrTagPnNoNo);

% multiway ANOVA
[~, ~, statsPnAcAc] = anovan(ypt_ZcorrPnAcAc,{xpt_corrPnAcAc},'display','off');
[~, ~, statsPnAcIn] = anovan(ypt_ZcorrPnAcIn,{xpt_corrPnAcIn},'display','off');
[~, ~, statsPnAcNo] = anovan(ypt_ZcorrPnAcNo,{xpt_corrPnAcNo},'display','off');
[~, ~, statsPnInAc] = anovan(ypt_ZcorrPnInAc,{xpt_corrPnInAc},'display','off');
[~, ~, statsPnInIn] = anovan(ypt_ZcorrPnInIn,{xpt_corrPnInIn},'display','off');
[~, ~, statsPnInNo] = anovan(ypt_ZcorrPnInNo,{xpt_corrPnInNo},'display','off');
[~, ~, statsPnNoAc] = anovan(ypt_ZcorrPnNoAc,{xpt_corrPnNoAc},'display','off');
[~, ~, statsPnNoIn] = anovan(ypt_ZcorrPnNoIn,{xpt_corrPnNoIn},'display','off');
[~, ~, statsPnNoNo] = anovan(ypt_ZcorrPnNoNo,{xpt_corrPnNoNo},'display','off');

[~, ~, statsTagPnAcAc] = anovan(ypt_ZcorrTagPnAcAc,{xpt_corrTagPnAcAc},'display','off');
[~, ~, statsTagPnAcIn] = anovan(ypt_ZcorrTagPnAcIn,{xpt_corrTagPnAcIn},'display','off');
[~, ~, statsTagPnAcNo] = anovan(ypt_ZcorrTagPnAcNo,{xpt_corrTagPnAcNo},'display','off');
[~, ~, statsTagPnInAc] = anovan(ypt_ZcorrTagPnInAc,{xpt_corrTagPnInAc},'display','off');
[~, ~, statsTagPnInIn] = anovan(ypt_ZcorrTagPnInIn,{xpt_corrTagPnInIn},'display','off');
[~, ~, statsTagPnInNo] = anovan(ypt_ZcorrTagPnInNo,{xpt_corrTagPnInNo},'display','off');
[~, ~, statsTagPnNoAc] = anovan(ypt_ZcorrTagPnNoAc,{xpt_corrTagPnNoAc},'display','off');
[~, ~, statsTagPnNoIn] = anovan(ypt_ZcorrTagPnNoIn,{xpt_corrTagPnNoIn},'display','off');
[~, ~, statsTagPnNoNo] = anovan(ypt_ZcorrTagPnNoNo,{xpt_corrTagPnNoNo},'display','off');

% Multiple comparison
mulPnAcAc = multcompare(statsPnAcAc,'display','off');
mulPnAcIn = multcompare(statsPnAcIn,'display','off');
mulPnAcNo = multcompare(statsPnAcNo,'display','off');
mulPnInAc = multcompare(statsPnInAc,'display','off');
mulPnInIn = multcompare(statsPnInIn,'display','off');
mulPnInNo = multcompare(statsPnInNo,'display','off');
mulPnNoAc = multcompare(statsPnNoAc,'display','off');
mulPnNoIn = multcompare(statsPnNoIn,'display','off');
mulPnNoNo = multcompare(statsPnNoNo,'display','off');

mulTagPnAcAc = multcompare(statsTagPnAcAc,'display','off');
mulTagPnAcIn = multcompare(statsTagPnAcIn,'display','off');
mulTagPnAcNo = multcompare(statsTagPnAcNo,'display','off');
mulTagPnInAc = multcompare(statsTagPnInAc,'display','off');
mulTagPnInIn = multcompare(statsTagPnInIn,'display','off');
mulTagPnInNo = multcompare(statsTagPnInNo,'display','off');
mulTagPnNoAc = multcompare(statsTagPnNoAc,'display','off');
mulTagPnNoIn = multcompare(statsTagPnNoIn,'display','off');
mulTagPnNoNo = multcompare(statsTagPnNoNo,'display','off');

% In-block vs Between block comparison
figure(1)
hCorr(1) = axes('Position',axpt(3,3,1,1,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrPnAcAc,xpt_corrPnAcAc,0.35,{colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & interAc','FontSize',fontM);
text(3.5,-0.8,['n = ',num2str(nPnAcAc)]);

hCorr(2) = axes('Position',axpt(3,3,2,1,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrPnAcIn,xpt_corrPnAcIn,0.35,{colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & interAc','FontSize',fontM);
text(3.5,-0.8,['n = ',num2str(nPnAcIn)]);

hCorr(3) = axes('Position',axpt(3,3,3,1,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrPnAcNo,xpt_corrPnAcNo,0.35,{colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & interAc','FontSize',fontM);
text(3.5,-0.8,['n = ',num2str(nPnAcNo)]);

hCorr(4) = axes('Position',axpt(3,3,1,2,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrPnInAc,xpt_corrPnInAc,0.35,{colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & interAc','FontSize',fontM);
text(3.5,-0.8,['n = ',num2str(nPnInAc)]);

hCorr(5) = axes('Position',axpt(3,3,2,2,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrPnInIn,xpt_corrPnInIn,0.35,{colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & interAc','FontSize',fontM);
text(3.5,-0.8,['n = ',num2str(nPnInIn)]);

hCorr(6) = axes('Position',axpt(3,3,3,2,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrPnInNo,xpt_corrPnInNo,0.35,{colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & interAc','FontSize',fontM);
text(3.5,-0.8,['n = ',num2str(nPnInNo)]);

hCorr(7) = axes('Position',axpt(3,3,1,3,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrPnNoAc,xpt_corrPnNoAc,0.35,{colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & interAc','FontSize',fontM);
text(3.5,-0.8,['n = ',num2str(nPnNoAc)]);

hCorr(8) = axes('Position',axpt(3,3,2,3,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrPnNoIn,xpt_corrPnNoIn,0.35,{colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & interAc','FontSize',fontM);
text(3.5,-0.8,['n = ',num2str(nPnNoIn)]);

hCorr(9) = axes('Position',axpt(3,3,3,3,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrPnNoNo,xpt_corrPnNoNo,0.35,{colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & interAc','FontSize',fontM);
text(3.5,-0.8,['n = ',num2str(nPnNoNo)]);

set(hCorr,'YLim',[-1.2 1.2],'XTick',[1,2,3,4],'XTickLabel',{'hf x hf','bf x dur', 'bf x aft', 'dur x aft'},'FontSize',fontM);
print(gcf,'-depsc','-r300',['PN_intra_inter_',num2str(intra_inter)]);

% In-block vs tag comparison
figure(2)
hCorrTag(1) = axes('Position',axpt(3,3,1,1,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrTagPnAcAc,xpt_corrTagPnAcAc,0.35,{colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & tagAc','FontSize',fontM);
text(3.5,-0.8,['n = ',num2str(nTagPnAcAc)]);

hCorrTag(2) = axes('Position',axpt(3,3,2,1,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrTagPnAcIn,xpt_corrTagPnAcIn,0.35,{colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & tagAc','FontSize',fontM);
text(3.5,-0.8,['n = ',num2str(nTagPnAcIn)]);

hCorrTag(3) = axes('Position',axpt(3,3,3,1,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrTagPnAcNo,xpt_corrTagPnAcNo,0.35,{colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & tagAc','FontSize',fontM);
text(3.5,-0.8,['n = ',num2str(nTagPnAcNo)]);

hCorrTag(4) = axes('Position',axpt(3,3,1,2,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrTagPnInAc,xpt_corrTagPnInAc,0.35,{colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & tagAc','FontSize',fontM);
text(3.5,-0.8,['n = ',num2str(nTagPnInAc)]);

hCorrTag(5) = axes('Position',axpt(3,3,2,2,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrTagPnInIn,xpt_corrTagPnInIn,0.35,{colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & tagAc','FontSize',fontM);
text(3.5,-0.8,['n = ',num2str(nTagPnInIn)]);

hCorrTag(6) = axes('Position',axpt(3,3,3,2,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrTagPnInNo,xpt_corrTagPnInNo,0.35,{colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & tagAc','FontSize',fontM);
text(3.5,-0.8,['n = ',num2str(nTagPnInNo)]);

hCorrTag(7) = axes('Position',axpt(3,3,1,3,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrTagPnNoAc,xpt_corrTagPnNoAc,0.35,{colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & tagAc','FontSize',fontM);
text(3.5,-0.8,['n = ',num2str(nTagPnNoAc)]);

hCorrTag(8) = axes('Position',axpt(3,3,2,3,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrTagPnNoIn,xpt_corrTagPnNoIn,0.35,{colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & tagAc','FontSize',fontM);
text(3.5,-0.8,['n = ',num2str(nTagPnNoIn)]);

hCorrTag(9) = axes('Position',axpt(3,3,3,3,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrTagPnNoNo,xpt_corrTagPnNoNo,0.35,{colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & tagAc','FontSize',fontM);
text(3.5,-0.8,['n = ',num2str(nTagPnNoNo)]);

set(hCorrTag,'YLim',[-1.2 1.2],'XTick',[1,2,3,4],'XTickLabel',{'hf x hf','bf x dur', 'bf x aft', 'dur x aft'},'FontSize',fontM);
print(gcf,'-depsc','-r300',['PN_intra_tag_',num2str(intra_tag)]);