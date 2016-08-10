function fig6_firingRate()
% clearvars;
clf; close all;

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
colorDarkRed4 = [183, 28, 28]./255;
colorLightRed4 = [211, 47, 47]./255;

colorDarkOrange4 = [255, 111, 0]./255;
colorLightOrange4 = [255, 160, 0]./255;

colorDarkBlue4 = [13, 71, 161]./255;
colorLightBlue4 = [25, 118, 210]./255;

colorDarkGreen4 = [27, 94, 32]./255;
colorLightGreen4 = [56, 142, 60]./255;

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
load(['cellList_new_90','.mat']);
T((T.taskType == 'nolight'),:) = [];
T(~(T.taskProb == '100'),:) = [];
% T(~(T.taskType == 'DRun' | T.taskType == 'noRun'),:) = [];

tDRw = T;
tnoRw = T;

tDRw(~(tDRw.taskType == 'DRun'),:) = [];
tnoRw(~(tnoRw.taskType == 'noRun'),:) = [];

pnDRw = tDRw.fr_task > 0.01 & tDRw.fr_task < 10;
inDRw = tDRw.fr_task > 10;
pnnoRw = tnoRw.fr_task > 0.01 & tnoRw.fr_task < 10;
innoRw = tnoRw.fr_task > 10;

npnDRw = sum(double(pnDRw));
npnnoRw = sum(double(pnnoRw));

laserBase_pre = tDRw.lighttagPreSpk(pnDRw);
laserBase_stm = tDRw.lighttagSpk(pnDRw);
laserBase_post = tDRw.lighttagPostSpk(pnDRw);

nolaserBase_pre = tnoRw.lighttagPreSpk(pnnoRw);
nolaserBase_stm = tnoRw.lighttagSpk(pnnoRw);
nolaserBase_post = tnoRw.lighttagPostSpk(pnnoRw);

laserTrack_pre = tDRw.lightPreSpk(pnDRw);
laserTrack_stm = tDRw.lightSpk(pnDRw);
laserTrack_post = tDRw.lightPostSpk(pnDRw);

nolaserTrack_pre = tnoRw.lightPreSpk(pnnoRw);
nolaserTrack_stm = tnoRw.lightSpk(pnnoRw);
nolaserTrack_post = tnoRw.lightPostSpk(pnnoRw);

figure(1) % Baseline firing rate comparison
hBaseFR(1) = axes('Position',axpt(2,1,1,1,[0.1, 0.1, 0.85, 0.85],wideInterval));
rectangle('Position',[1.7,0,0.6,max([laserBase_pre; laserBase_stm; laserBase_post])+10],'FaceColor',colorLightBlue,'EdgeColor','none');
hold on;
for iCell = 1:npnDRw
    plot([1, 2, 3],[laserBase_pre(iCell), laserBase_stm(iCell), laserBase_post(iCell)],'-o','Color',colorGray,'MarkerFaceColor',colorGray);
    hold on;
    plot(2,laserBase_stm(iCell),'o','MarkerEdgeColor','k','MarkerFaceColor',colorBlue);
    hold on;
end
plot([1, 2, 3],[mean(laserBase_pre), mean(laserBase_stm), mean(laserBase_post)],'-o','MarkerFaceColor','k','Color','k','LineWidth',2);
text(3,max([laserBase_pre; laserBase_stm; laserBase_post])-10,['n = ',num2str(npnDRw)]);
ylabel('Spikes number');
title('Baseline response (track stimulation)','fontSize',fontM);

hBaseFR(2) = axes('Position',axpt(2,1,2,1,[0.1, 0.1, 0.85, 0.85],wideInterval));
rectangle('Position',[1.7,0,0.6,max([laserBase_pre; laserBase_stm; laserBase_post])+10],'FaceColor',colorLightBlue,'EdgeColor','none');
hold on;
for iCell = 1:npnnoRw
    plot([1,2,3],[nolaserBase_pre(iCell), nolaserBase_stm(iCell), nolaserBase_post(iCell)],'-o','Color',colorGray,'MarkerFaceColor',colorGray);
    hold on;
    plot(2,nolaserBase_stm(iCell),'o','MarkerEdgeColor','k','MarkerFaceColor',colorBlue);
    hold on;
end
plot([1,2,3],[mean(nolaserBase_pre), mean(nolaserBase_stm), mean(nolaserBase_post)],'-o','MarkerFaceColor','k','Color','k','LineWidth',2);
text(3,max([nolaserBase_pre; nolaserBase_stm; nolaserBase_post])-10,['n = ',num2str(npnnoRw)]);
title('Baseline response (track without stimulation)','fontSize',fontM);
set(hBaseFR, 'XLim',[0,4],'YLim',[-1, max([laserBase_pre; laserBase_stm; laserBase_post])+10],'XTick',[1,2,3],'XTickLabel',{'Pre-stm','Stm','Post-stm'});

figure(2) % Track firing rate comparison
hTrackFR(1) = axes('Position',axpt(2,2,1,1,[0.1 0.1 0.85 0.85],wideInterval));
rectangle('Position',[1.7,0,0.6,max([laserTrack_pre;laserTrack_stm;laserTrack_post])+10],'FaceColor',colorLightBlue,'EdgeColor','none');
hold on;
for iCell = 1:npnDRw
    plot([1,2,3],[laserTrack_pre(iCell), laserTrack_stm(iCell), laserTrack_post(iCell)],'-o','Color',colorGray,'MarkerFaceColor',colorGray);
    hold on;
    plot(2,laserTrack_stm(iCell),'o','MarkerEdgeColor','k','MarkerFaceColor',colorBlue);
    hold on;
end
plot([1,2,3],[mean(laserTrack_pre),mean(laserTrack_stm),mean(laserTrack_post)],'-o','MarkerFaceColor','k','Color','k','LineWidth',2);
text(3,max([laserTrack_pre; laserTrack_stm; laserTrack_post])-10,['n = ',num2str(npnDRw)]);
ylabel('Spikes number');
title('On-Track response (with stimulation)','fontSize',fontM);

hTrackFR(2) = axes('Position',axpt(2,2,2,1,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
rectangle('Position',[1.7,0,0.6,max([laserTrack_pre;laserTrack_stm;laserTrack_post])+10],'FaceColor',colorLightBlue,'EdgeColor','none');
for iCell = 1:npnnoRw
    plot([1, 2, 3],[nolaserTrack_pre(iCell), nolaserTrack_stm(iCell), nolaserTrack_post(iCell)],'-o','Color',colorGray,'MarkerFaceColor',colorGray);
    hold on;
    plot(2,nolaserTrack_stm(iCell),'o','MarkerEdgeColor','k','MarkerFaceColor',colorBlue);
    hold on;
end
plot([1,2,3],[mean(nolaserTrack_pre), mean(nolaserTrack_stm), mean(nolaserTrack_post)],'-o','MarkerFaceColor','k','Color','k','LineWidth',2);
text(3,max([laserTrack_pre; laserTrack_stm; laserTrack_post])-10,['n = ',num2str(npnnoRw)]);
title('On-Track response (without stimulation)','fontSize',fontM);
set(hTrackFR,'XLim',[0,4],'YLim',[-1, max([laserTrack_pre;laserTrack_stm;laserTrack_post])+10],'XTick',[1,2,3],'XTickLabel',{'Pre-stm','Stm','Post-stm'});


intraAc_DRw = tDRw.intraLightDir==1;
intraIn_DR = tDRw.intraLightDir==-1;
intraNo_DR = tDRw.intraLightDir==0;

interAc_DRw = tDRw.interLightDir==1;
interIn_DRw = tDRw.interLightDir==-1;
interNo_DRw = tDRw.interLightDir==0;

tagAc_DRw = tDRw.tagLightDir==1;
tagIn_DRw = tDRw.tagLightDir==-1;
tagNo_DRw = tDRw.tagLightDir==0;

% Between block
nPnBtAc_DRw = sum(double(pnDRw&interAc_DRw));
nPnBtIn_DRw = sum(double(pnDRw&interIn_DRw));
nPnBtNo_DRw = sum(double(pnDRw&interNo_DRw));

% Inblock
nPnInAc_DRw = sum(double(pnDRw&intraAc_DRw));
nPnInIn_DRw = sum(double(pnDRw&intraIn_DR));
nPnInNo_DRw = sum(double(pnDRw&intraNo_DR));

% Tag
nPnTagAc_DRw = sum(double(pnDRw&tagAc_DRw));
nPnTagIn_DRw = sum(double(pnDRw&tagIn_DRw));
nPnTagNo_DRw = sum(double(pnDRw&tagNo_DRw));


intraAc_noRw = tnoRw.intraLightDir==1;
intraIn_noRw = tnoRw.intraLightDir==-1;
intraNo_noRw = tnoRw.intraLightDir==0;

interAc_noRw = tnoRw.interLightDir==1;
interIn_noRw = tnoRw.interLightDir==-1;
interNo_noRw = tnoRw.interLightDir==0;

tagAc_noRw = tnoRw.tagLightDir==1;
tagIn_noRw = tnoRw.tagLightDir==-1;
tagNo_noRw = tnoRw.tagLightDir==0;

% No light - Between
nPnBtAc_noRw = sum(double(pnnoRw&interAc_noRw));
nPnBtIn_noRw = sum(double(pnnoRw&interIn_noRw));
nPnBtNo_noRw = sum(double(pnnoRw&interNo_noRw));

% No light - Inblock
nPnInAc_noRw = sum(double(pnnoRw&intraAc_noRw));
nPnInIn_noRw = sum(double(pnnoRw&intraIn_noRw));
nPnInNo_noRw = sum(double(pnnoRw&intraNo_noRw));

% No light - Tag
nPnTagAc_noRw = sum(double(pnnoRw&tagAc_noRw));
nPnTagIn_noRw = sum(double(pnnoRw&tagIn_noRw));
nPnTagNo_noRw = sum(double(pnnoRw&tagNo_noRw));


% Between block (Inter: Bt)
xpt_corrPnBtAc = [ones(nPnBtAc_DRw,1);ones(nPnBtAc_noRw,1)*2;
                  ones(nPnBtAc_DRw,1)*3;ones(nPnBtAc_noRw,1)*4;
                  ones(nPnBtAc_DRw,1)*5;ones(nPnBtAc_noRw,1)*6;
                  ones(nPnBtAc_DRw,1)*7;ones(nPnBtAc_noRw,1)*8];
xpt_corrPnBtIn = [ones(nPnBtIn_DRw,1);ones(nPnBtIn_noRw,1)*2;
                  ones(nPnBtIn_DRw,1)*3;ones(nPnBtIn_noRw,1)*4;
                  ones(nPnBtIn_DRw,1)*5;ones(nPnBtIn_noRw,1)*6;
                  ones(nPnBtIn_DRw,1)*7;ones(nPnBtIn_noRw,1)*8];
xpt_corrPnBtNo = [ones(nPnBtNo_DRw,1);ones(nPnBtNo_noRw,1)*2;
                  ones(nPnBtNo_DRw,1)*3;ones(nPnBtNo_noRw,1)*4;
                  ones(nPnBtNo_DRw,1)*5;ones(nPnBtNo_noRw,1)*6;
                  ones(nPnBtNo_DRw,1)*7;ones(nPnBtNo_noRw,1)*8];

% Intra (In)
xpt_corrPnInAc = [ones(nPnInAc_DRw,1);ones(nPnInAc_noRw,1)*2;
                  ones(nPnInAc_DRw,1)*3;ones(nPnInAc_noRw,1)*4;
                  ones(nPnInAc_DRw,1)*5;ones(nPnInAc_noRw,1)*6;
                  ones(nPnInAc_DRw,1)*7;ones(nPnInAc_noRw,1)*8];
xpt_corrPnInIn = [ones(nPnInIn_DRw,1);ones(nPnInIn_noRw,1)*2;
                  ones(nPnInIn_DRw,1)*3;ones(nPnInIn_noRw,1)*4;
                  ones(nPnInIn_DRw,1)*5;ones(nPnInIn_noRw,1)*6;
                  ones(nPnInIn_DRw,1)*7;ones(nPnInIn_noRw,1)*8];
xpt_corrPnInNo = [ones(nPnInNo_DRw,1);ones(nPnInNo_noRw,1)*2;
                  ones(nPnInNo_DRw,1)*3;ones(nPnInNo_noRw,1)*4;
                  ones(nPnInNo_DRw,1)*5;ones(nPnInNo_noRw,1)*6;
                  ones(nPnInNo_DRw,1)*7;ones(nPnInNo_noRw,1)*8];
                
% Tag
xpt_corrPnTagAc = [ones(nPnTagAc_DRw,1);ones(nPnTagAc_noRw,1)*2;
                   ones(nPnTagAc_DRw,1)*3;ones(nPnTagAc_noRw,1)*4;
                   ones(nPnTagAc_DRw,1)*5;ones(nPnTagAc_noRw,1)*6;
                   ones(nPnTagAc_DRw,1)*7;ones(nPnTagAc_noRw,1)*8];
xpt_corrPnTagIn = [ones(nPnTagIn_DRw,1);ones(nPnTagIn_noRw,1)*2;
                   ones(nPnTagIn_DRw,1)*3;ones(nPnTagIn_noRw,1)*4;
                   ones(nPnTagIn_DRw,1)*5;ones(nPnTagIn_noRw,1)*6;
                   ones(nPnTagIn_DRw,1)*7;ones(nPnTagIn_noRw,1)*8];
xpt_corrPnTagNo = [ones(nPnTagNo_DRw,1);ones(nPnTagNo_noRw,1)*2;
                   ones(nPnTagNo_DRw,1)*3;ones(nPnTagNo_noRw,1)*4;
                   ones(nPnTagNo_DRw,1)*5;ones(nPnTagNo_noRw,1)*6;
                   ones(nPnTagNo_DRw,1)*7;ones(nPnTagNo_noRw,1)*8];

% Between block (inter: Bt)
ypt_corrPnBtAc = [tDRw.r_CorrEvOd(pnDRw&interAc_DRw); tnoRw.r_CorrEvOd(pnnoRw&interAc_noRw);
                  tDRw.r_Corrbfxdr(pnDRw&interAc_DRw); tnoRw.r_Corrbfxdr(pnnoRw&interAc_noRw);
                  tDRw.r_Corrdrxaft(pnDRw&interAc_DRw); tnoRw.r_Corrdrxaft(pnnoRw&interAc_noRw);
                  tDRw.r_Corrbfxaft(pnDRw&interAc_DRw); tnoRw.r_Corrbfxaft(pnnoRw&interAc_noRw)];
              
ypt_corrPnBtIn = [tDRw.r_CorrEvOd(pnDRw&interIn_DRw); tnoRw.r_Corrbfxdr(pnnoRw&interIn_noRw); 
                  tDRw.r_Corrbfxdr(pnDRw&interIn_DRw); tnoRw.r_Corrbfxdr(pnnoRw&interIn_noRw);...
                  tDRw.r_Corrdrxaft(pnDRw&interIn_DRw); tnoRw.r_Corrbfxdr(pnnoRw&interIn_noRw);
                  tDRw.r_Corrbfxaft(pnDRw&interIn_DRw); tnoRw.r_Corrbfxaft(pnnoRw&interIn_noRw)];
              
ypt_corrPnBtNo = [tDRw.r_CorrEvOd(pnDRw&interNo_DRw); tnoRw.r_CorrEvOd(pnnoRw&interNo_noRw); 
                  tDRw.r_Corrbfxdr(pnDRw&interNo_DRw); tnoRw.r_Corrbfxdr(pnnoRw&interNo_noRw);
                  tDRw.r_Corrdrxaft(pnDRw&interNo_DRw); tnoRw.r_Corrdrxaft(pnnoRw&interNo_noRw);
                  tDRw.r_Corrbfxaft(pnDRw&interNo_DRw); tnoRw.r_Corrbfxaft(pnnoRw&interNo_noRw)];

[~, pPnBtAc_hfxhf, ~, statsPnBtAc_hfxhf] = ttest2(tDRw.r_CorrEvOd(pnDRw&interAc_DRw), tnoRw.r_CorrEvOd(pnnoRw&interAc_noRw));
[~, pPnBtAc_bfxdr, ~, statsPnBtAc_bfxdr] = ttest2(tDRw.r_Corrbfxdr(pnDRw&interAc_DRw), tnoRw.r_Corrbfxdr(pnnoRw&interAc_noRw));
[~, pPnBtAc_drxaft, ~, statsPnBtAc_drxaft] = ttest2(tDRw.r_Corrdrxaft(pnDRw&interAc_DRw), tnoRw.r_Corrdrxaft(pnnoRw&interAc_noRw));
[~, pPnBtAc_bfxaft, ~, statsPnBtAc_bfxaft] = ttest2(tDRw.r_Corrbfxaft(pnDRw&interAc_DRw), tnoRw.r_Corrbfxaft(pnnoRw&interAc_noRw));

[~, pPnBtIn_hfxhf, ~, statsPnBtIn_hfxhf] = ttest2(tDRw.r_CorrEvOd(pnDRw&interIn_DRw), tnoRw.r_Corrbfxdr(pnnoRw&interIn_noRw));
[~, pPnBtIn_bfxdr, ~, statsPnBtIn_bfxdr] = ttest2(tDRw.r_Corrbfxdr(pnDRw&interIn_DRw), tnoRw.r_Corrbfxdr(pnnoRw&interIn_noRw));
[~, pPnBtIn_drxaft, ~, statsPnBtIn_drxaft] = ttest2(tDRw.r_Corrdrxaft(pnDRw&interIn_DRw), tnoRw.r_Corrbfxdr(pnnoRw&interIn_noRw));
[~, pPnBtIn_bfxaft, ~, statsPnBtIn_bfxaft] = ttest2(tDRw.r_Corrbfxaft(pnDRw&interIn_DRw), tnoRw.r_Corrbfxaft(pnnoRw&interIn_noRw));

[~, pPnBtNo_hfxhf, ~, statsPnBtNo_hfxhf] = ttest2(tDRw.r_CorrEvOd(pnDRw&interNo_DRw), tnoRw.r_CorrEvOd(pnnoRw&interNo_noRw));
[~, pPnBtNo_bfxdr, ~, statsPnBtNo_bfxdr] = ttest2(tDRw.r_Corrbfxdr(pnDRw&interNo_DRw), tnoRw.r_Corrbfxdr(pnnoRw&interNo_noRw));
[~, pPnBtNo_drxaft, ~, statsPnBtNo_drxaft] = ttest2(tDRw.r_Corrdrxaft(pnDRw&interNo_DRw), tnoRw.r_Corrdrxaft(pnnoRw&interNo_noRw));
[~, pPnBtNo_bfxaft, ~, statsPnBtNo_bfxaft] = ttest2(tDRw.r_Corrbfxaft(pnDRw&interNo_DRw), tnoRw.r_Corrbfxaft(pnnoRw&interNo_noRw));

% Inblock (intra: In)
ypt_corrPnInAc = [tDRw.r_CorrEvOd(pnDRw&intraAc_DRw); tnoRw.r_CorrEvOd(pnnoRw&intraAc_noRw);
                  tDRw.r_Corrbfxdr(pnDRw&intraAc_DRw); tnoRw.r_Corrbfxdr(pnnoRw&intraAc_noRw);
                  tDRw.r_Corrdrxaft(pnDRw&intraAc_DRw); tnoRw.r_Corrdrxaft(pnnoRw&intraAc_noRw);
                  tDRw.r_Corrbfxaft(pnDRw&intraAc_DRw); tnoRw.r_Corrbfxaft(pnnoRw&intraAc_noRw)];
              
ypt_corrPnInIn = [tDRw.r_CorrEvOd(pnDRw&intraIn_DR); tnoRw.r_CorrEvOd(pnnoRw&intraIn_noRw); 
                  tDRw.r_Corrbfxdr(pnDRw&intraIn_DR); tnoRw.r_Corrbfxdr(pnnoRw&intraIn_noRw);...
                  tDRw.r_Corrdrxaft(pnDRw&intraIn_DR); tnoRw.r_Corrdrxaft(pnnoRw&intraIn_noRw);
                  tDRw.r_Corrbfxaft(pnDRw&intraIn_DR); tnoRw.r_Corrbfxaft(pnnoRw&intraIn_noRw)];
              
ypt_corrPnInNo = [tDRw.r_CorrEvOd(pnDRw&intraNo_DR); tnoRw.r_CorrEvOd(pnnoRw&intraNo_noRw); 
                  tDRw.r_Corrbfxdr(pnDRw&intraNo_DR); tnoRw.r_Corrbfxdr(pnnoRw&intraNo_noRw);
                  tDRw.r_Corrdrxaft(pnDRw&intraNo_DR); tnoRw.r_Corrdrxaft(pnnoRw&intraNo_noRw);
                  tDRw.r_Corrbfxaft(pnDRw&intraNo_DR); tnoRw.r_Corrbfxaft(pnnoRw&intraNo_noRw)];

[~, pPnInAc_hfxhf, ~, statsPnInAc_hfxhf] = ttest2(tDRw.r_CorrEvOd(pnDRw&intraAc_DRw), tnoRw.r_CorrEvOd(pnnoRw&interAc_noRw));
[~, pPnInAc_bfxdr, ~, statsPnInAc_bfxdr] = ttest2(tDRw.r_Corrbfxdr(pnDRw&intraAc_DRw), tnoRw.r_Corrbfxdr(pnnoRw&interAc_noRw));
[~, pPnInAc_drxaft, ~, statsPnInAc_drxaft] = ttest2(tDRw.r_Corrdrxaft(pnDRw&intraAc_DRw), tnoRw.r_Corrdrxaft(pnnoRw&interAc_noRw));
[~, pPnInAc_bfxaft, ~, statsPnInAc_bfxaft] = ttest2(tDRw.r_Corrbfxaft(pnDRw&intraAc_DRw), tnoRw.r_Corrbfxaft(pnnoRw&interAc_noRw));

[~, pPnInIn_hfxhf, ~, statsPnInIn_hfxhf] = ttest2(tDRw.r_CorrEvOd(pnDRw&intraIn_DR), tnoRw.r_CorrEvOd(pnnoRw&interIn_noRw));
[~, pPnInIn_bfxdr, ~, statsPnInIn_bfxdr] = ttest2(tDRw.r_Corrbfxdr(pnDRw&intraIn_DR), tnoRw.r_Corrbfxdr(pnnoRw&interIn_noRw));
[~, pPnInIn_drxaft, ~, statsPnInIn_drxaft] = ttest2(tDRw.r_Corrdrxaft(pnDRw&intraIn_DR), tnoRw.r_Corrdrxaft(pnnoRw&interIn_noRw));
[~, pPnInIn_bfxaft, ~, statsPnInIn_bfxaft] = ttest2(tDRw.r_Corrbfxaft(pnDRw&intraIn_DR), tnoRw.r_Corrbfxaft(pnnoRw&interIn_noRw));

[~, pPnInNo_hfxhf, ~, statsPnInNo_hfxhf] = ttest2(tDRw.r_CorrEvOd(pnDRw&intraNo_DR), tnoRw.r_CorrEvOd(pnnoRw&interNo_noRw));
[~, pPnInNo_bfxdr, ~, statsPnInNo_bfxdr] = ttest2(tDRw.r_Corrbfxdr(pnDRw&intraNo_DR), tnoRw.r_Corrbfxdr(pnnoRw&interNo_noRw));
[~, pPnInNo_drxaft, ~, statsPnInNo_drxaft] = ttest2(tDRw.r_Corrdrxaft(pnDRw&intraNo_DR), tnoRw.r_Corrdrxaft(pnnoRw&interNo_noRw));
[~, pPnInNo_bfxaft, ~, statsPnInNo_bfxaft] = ttest2(tDRw.r_Corrbfxaft(pnDRw&intraNo_DR), tnoRw.r_Corrbfxaft(pnnoRw&interNo_noRw));

% Tag (tag)
ypt_corrPnTagAc = [tDRw.r_CorrEvOd(pnDRw&tagAc_DRw); tnoRw.r_CorrEvOd(pnnoRw&tagAc_noRw);
                  tDRw.r_Corrbfxdr(pnDRw&tagAc_DRw); tnoRw.r_Corrbfxdr(pnnoRw&tagAc_noRw);
                  tDRw.r_Corrdrxaft(pnDRw&tagAc_DRw); tnoRw.r_Corrdrxaft(pnnoRw&tagAc_noRw);
                  tDRw.r_Corrbfxaft(pnDRw&tagAc_DRw); tnoRw.r_Corrbfxaft(pnnoRw&tagAc_noRw)];
              
ypt_corrPnTagIn = [tDRw.r_CorrEvOd(pnDRw&tagIn_DRw); tnoRw.r_CorrEvOd(pnnoRw&tagIn_noRw); 
                  tDRw.r_Corrbfxdr(pnDRw&tagIn_DRw); tnoRw.r_Corrbfxdr(pnnoRw&tagIn_noRw);...
                  tDRw.r_Corrdrxaft(pnDRw&tagIn_DRw); tnoRw.r_Corrdrxaft(pnnoRw&tagIn_noRw);
                  tDRw.r_Corrbfxaft(pnDRw&tagIn_DRw); tnoRw.r_Corrbfxaft(pnnoRw&tagIn_noRw)];
              
ypt_corrPnTagNo = [tDRw.r_CorrEvOd(pnDRw&tagNo_DRw); tnoRw.r_CorrEvOd(pnnoRw&tagNo_noRw); 
                  tDRw.r_Corrbfxdr(pnDRw&tagNo_DRw); tnoRw.r_Corrbfxdr(pnnoRw&tagNo_noRw);
                  tDRw.r_Corrdrxaft(pnDRw&tagNo_DRw); tnoRw.r_Corrdrxaft(pnnoRw&tagNo_noRw);
                  tDRw.r_Corrbfxaft(pnDRw&tagNo_DRw); tnoRw.r_Corrbfxaft(pnnoRw&tagNo_noRw)];
             
% t-test
[~, psPnTagAc_hfxhf, ~, statsPnTagAc_hfxhf] = ttest2(tDRw.r_CorrEvOd(pnDRw&tagAc_DRw), tnoRw.r_CorrEvOd(pnnoRw&tagAc_noRw));
[~, pPnTagAc_bfxdr, ~, statsPnTagAc_bfxdr] = ttest2(tDRw.r_Corrbfxdr(pnDRw&tagAc_DRw), tnoRw.r_Corrbfxdr(pnnoRw&tagAc_noRw));
[~, pPnTagAc_drxaft, ~, statsPnTagAc_drxaft] = ttest2(tDRw.r_Corrdrxaft(pnDRw&tagAc_DRw), tnoRw.r_Corrdrxaft(pnnoRw&tagAc_noRw));
[~, pPnTagAc_bfxaft, ~, statsPnTagAc_bfxaft] = ttest2(tDRw.r_Corrbfxaft(pnDRw&tagAc_DRw), tnoRw.r_Corrbfxaft(pnnoRw&tagAc_noRw));

[~, pPnTagIn_hfxhf, ~, statsPnTagIn_hfxhf] = ttest2(tDRw.r_CorrEvOd(pnDRw&tagIn_DRw), tnoRw.r_CorrEvOd(pnnoRw&tagIn_noRw));
[~, pPnTagIn_bfxdr, ~, statsPnTagIn_bfxdr] = ttest2(tDRw.r_Corrbfxdr(pnDRw&tagIn_DRw), tnoRw.r_Corrbfxdr(pnnoRw&tagIn_noRw));
[~, pPnTagIn_drxaft, ~, statsPnTagIn_drxaft] = ttest2(tDRw.r_Corrdrxaft(pnDRw&tagIn_DRw), tnoRw.r_Corrdrxaft(pnnoRw&tagIn_noRw));
[~, pPnTagIn_bfxaft, ~, statsPnTagIn_bfxaft] = ttest2(tDRw.r_Corrbfxaft(pnDRw&tagIn_DRw), tnoRw.r_Corrbfxaft(pnnoRw&tagIn_noRw));

[~, pPnTagNo_hfxhf, ~, statsPnTagNo_hfxhf] = ttest2(tDRw.r_CorrEvOd(pnDRw&tagNo_DRw), tnoRw.r_CorrEvOd(pnnoRw&tagNo_noRw));
[~, pPnTagNo_bfxdr, ~, statsPnTagNo_bfxdr] = ttest2(tDRw.r_Corrbfxdr(pnDRw&tagNo_DRw), tnoRw.r_Corrbfxdr(pnnoRw&tagNo_noRw));
[~, pPnTagNo_drxaft, ~, statsPnTagNo_drxaft] = ttest2(tDRw.r_Corrdrxaft(pnDRw&tagNo_DRw), tnoRw.r_Corrdrxaft(pnnoRw&tagNo_noRw));
[~, pPnTagNo_bfxaft, ~, statsPnTagNo_bfxaft] = ttest2(tDRw.r_Corrbfxaft(pnDRw&tagNo_DRw), tnoRw.r_Corrbfxaft(pnnoRw&tagNo_noRw));

 
figure(1)
hCorrBt(1) = axes('Position',axpt(3,1,1,1,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrPnBtAc,xpt_corrPnBtAc,0.35,{colorDarkRed4,colorLightRed4,colorDarkBlue4,colorLightBlue4,colorDarkOrange4,colorLightOrange4,colorDarkGreen4,colorLightGreen4},[]);
title('PN & Between block Activation','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nPnBtAc_DRw)]);
text(6.5,-0.8,['n = ',num2str(nPnBtAc_noRw)]);

hCorrBt(2) = axes('Position',axpt(3,1,2,1,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrPnBtIn,xpt_corrPnBtIn,0.35,{colorDarkRed4,colorLightRed4,colorDarkBlue4,colorLightBlue4,colorDarkOrange4,colorLightOrange4,colorDarkGreen4,colorLightGreen4},[]);
title('PN & Between block Inactivation','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nPnBtIn_DRw)]);
text(6.5,-0.8,['n = ',num2str(nPnBtIn_noRw)]);

hCorrBt(3) = axes('Position',axpt(3,1,3,1,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrPnBtNo,xpt_corrPnBtNo,0.35,{colorDarkRed4,colorLightRed4,colorDarkBlue4,colorLightBlue4,colorDarkOrange4,colorLightOrange4,colorDarkGreen4,colorLightGreen4},[]);
title('PN & Between block No-change','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nPnBtNo_DRw)]);
text(6.5,-0.8,['n = ',num2str(nPnBtNo_noRw)]);
set(hCorrBt,'YLim',[-1.2 1.2],'XLim',[0, 9],'XTick',[1.5,3.5,5.5,7.5],'XTickLabel',{'hf-hf(EO)','bf-du', 'bf-af', 'du-af'},'FontSize',fontM);
print(gcf,'-depsc','-r300',['PN_Rw_Bt_',num2str(cutoff),'_EvOd'])

figure(2)
hCorrIn(1) = axes('Position',axpt(3,1,1,1,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrPnInAc,xpt_corrPnInAc,0.35,{colorDarkRed4,colorLightRed4,colorDarkBlue4,colorLightBlue4,colorDarkOrange4,colorLightOrange4,colorDarkGreen4,colorLightGreen4},[]);
title('PN & Inblock Activation','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nPnInAc_DRw)]);
text(6.5,-0.8,['n = ',num2str(nPnInAc_noRw)]);

hCorrIn(2) = axes('Position',axpt(3,1,2,1,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrPnInIn,xpt_corrPnInIn,0.35,{colorDarkRed4,colorLightRed4,colorDarkBlue4,colorLightBlue4,colorDarkOrange4,colorLightOrange4,colorDarkGreen4,colorLightGreen4},[]);
title('PN & Inblock Inactivation','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nPnInIn_DRw)]);
text(6.5,-0.8,['n = ',num2str(nPnInIn_noRw)]);

hCorrIn(3) = axes('Position',axpt(3,1,3,1,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrPnInNo,xpt_corrPnInNo,0.35,{colorDarkRed4,colorLightRed4,colorDarkBlue4,colorLightBlue4,colorDarkOrange4,colorLightOrange4,colorDarkGreen4,colorLightGreen4},[]);
title('PN & Inblock No-change','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nPnInNo_DRw)]);
text(6.5,-0.8,['n = ',num2str(nPnInNo_noRw)]);

set(hCorrIn,'YLim',[-1.2 1.2],'XLim',[0, 9],'XTick',[1.5,3.5,5.5,7.5],'XTickLabel',{'hf-hf(EO)','bf-du', 'bf-af', 'du-af'},'FontSize',fontM);
print(gcf,'-depsc','-r300',['PN_Rw_In_',num2str(cutoff),'_EvOd'])

figure(3)
hCorrTag(1) = axes('Position',axpt(3,1,1,1,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrPnTagAc,xpt_corrPnTagAc,0.35,{colorDarkRed4,colorLightRed4,colorDarkBlue4,colorLightBlue4,colorDarkOrange4,colorLightOrange4,colorDarkGreen4,colorLightGreen4},[]);
title('PN & Baseline Activation','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nPnTagAc_DRw)]);
text(6.5,-0.8,['n = ',num2str(nPnTagAc_noRw)]);

hCorrTag(2) = axes('Position',axpt(3,1,2,1,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrPnTagIn,xpt_corrPnTagIn,0.35,{colorDarkRed4,colorLightRed4,colorDarkBlue4,colorLightBlue4,colorDarkOrange4,colorLightOrange4,colorDarkGreen4,colorLightGreen4},[]);
title('PN & Baseline inactivation','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nPnTagIn_DRw)]);
text(6.5,-0.8,['n = ',num2str(nPnTagIn_noRw)]);

hCorrTag(3) = axes('Position',axpt(3,1,3,1,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrPnTagNo,xpt_corrPnTagNo,0.35,{colorDarkRed4,colorLightRed4,colorDarkBlue4,colorLightBlue4,colorDarkOrange4,colorLightOrange4,colorDarkGreen4,colorLightGreen4},[]);
title('PN & Baseline no-change','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nPnTagNo_DRw)]);
text(6.5,-0.8,['n = ',num2str(nPnTagNo_noRw)]);

set(hCorrTag,'YLim',[-1.2 1.2],'XLim',[0, 9],'XTick',[1.5,3.5,5.5,7.5],'XTickLabel',{'hf-hf(EO)','bf-du', 'bf-af', 'du-af'},'FontSize',fontM);
print(gcf,'-depsc','-r300',['PN_Rw_Base_',num2str(cutoff),'_EvOd'])

close all;


% % Population separation track(intra) vs track(inter)
% subTbl_trXtr_DRun = [sum(double(pnDRun&intraAc_DRun&interAc_DRun)), sum(double(pnDRun&intraAc_DRun&interIn_DRun)), sum(double(pnDRun&intraAc_DRun&interNo_DRun));
%             sum(double(pnDRun&intraIn_DRun&interAc_DRun)), sum(double(pnDRun&intraIn_DRun&interIn_DRun)), sum(double(pnDRun&intraIn_DRun&interNo_DRun));
%             sum(double(pnDRun&intraNo_DRun&interAc_DRun)), sum(double(pnDRun&intraNo_DRun&interIn_DRun)), sum(double(pnDRun&intraNo_DRun&interNo_DRun))];
% subTbl_trXtr_noRun = [sum(double(pnnoRun&intraAc_noRun&interAc_noRun)), sum(double(pnnoRun&intraAc_noRun&interIn_noRun)), sum(double(pnnoRun&intraAc_noRun&interNo_noRun));
%             sum(double(pnnoRun&intraIn_noRun&interAc_noRun)), sum(double(pnnoRun&intraIn_noRun&interIn_noRun)), sum(double(pnnoRun&intraIn_noRun&interNo_noRun));
%             sum(double(pnnoRun&intraNo_noRun&interAc_noRun)), sum(double(pnnoRun&intraNo_noRun&interIn_noRun)), sum(double(pnnoRun&intraNo_noRun&interNo_noRun))];
% 
% % Population separation track vs tag
% subTbl_trXtg_DRun = [sum(double(pnDRun&intraAc_DRun&tagAc_DRun)), sum(double(pnDRun&intraAc_DRun&tagIn_DRun)), sum(double(pnDRun&intraAc_DRun&tagNo_DRun));
%             sum(double(pnDRun&intraIn_DRun&tagAc_DRun)), sum(double(pnDRun&intraIn_DRun&tagIn_DRun)), sum(double(pnDRun&intraIn_DRun&tagNo_DRun));
%             sum(double(pnDRun&intraNo_DRun&tagAc_DRun)), sum(double(pnDRun&intraNo_DRun&tagIn_DRun)), sum(double(pnDRun&intraNo_DRun&tagNo_DRun))];
% subTbl_trXtg_noRun = [sum(double(pnnoRun&intraAc_noRun&tagAc_noRun)), sum(double(pnnoRun&intraAc_noRun&tagIn_noRun)), sum(double(pnnoRun&intraAc_noRun&tagNo_noRun));
%             sum(double(pnnoRun&intraIn_noRun&tagAc_noRun)), sum(double(pnnoRun&intraIn_noRun&tagIn_noRun)), sum(double(pnnoRun&intraIn_noRun&tagNo_noRun));
%             sum(double(pnnoRun&intraNo_noRun&tagAc_noRun)), sum(double(pnnoRun&intraNo_noRun&tagIn_noRun)), sum(double(pnnoRun&intraNo_noRun&tagNo_noRun))];