function fig6_lightSeparation_Run_modi(intra_inter,intra_tag)
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
load(['cellList_new_',num2str(intra_inter),'.mat']);
T((T.taskType == 'nolight'),:) = [];
T(~(T.taskProb == '100'),:) = [];
% T(~(T.taskType == 'DRun' | T.taskType == 'noRun'),:) = [];

tDRun = T;
tnoRun = T;

tDRun(~(tDRun.taskType == 'DRun'),:) = [];
tnoRun(~(tnoRun.taskType == 'noRun'),:) = [];

pnDRun = tDRun.fr_task > 0.01 & tDRun.fr_task < 10;
% npnDRw = sum(double(pn));
inDRun = tDRun.fr_task > 10;
% ninDRw = sum(double(inDRw));

intraAc_DRun = tDRun.intraLightDir==1;
intraIn_DRun = tDRun.intraLightDir==-1;
intraNo_DRun = tDRun.intraLightDir==0;

interAc_DRun = tDRun.interLightDir==1;
interIn_DRun = tDRun.interLightDir==-1;
interNo_DRun = tDRun.interLightDir==0;

tagAc_DRun = tDRun.tagLightDir==1;
tagIn_DRun = tDRun.tagLightDir==-1;
tagNo_DRun = tDRun.tagLightDir==0;

nPnAcAc_DRun = sum(double(pnDRun&intraAc_DRun&interAc_DRun));
nPnAcIn_DRun = sum(double(pnDRun&intraAc_DRun&interIn_DRun));
nPnAcNo_DRun = sum(double(pnDRun&intraAc_DRun&interNo_DRun));
nPnInAc_DRun = sum(double(pnDRun&intraIn_DRun&interAc_DRun));
nPnInIn_DRun = sum(double(pnDRun&intraIn_DRun&interIn_DRun));
nPnInNo_DRun = sum(double(pnDRun&intraIn_DRun&interNo_DRun));
nPnNoAc_DRun = sum(double(pnDRun&intraNo_DRun&interAc_DRun));
nPnNoIn_DRun = sum(double(pnDRun&intraNo_DRun&interIn_DRun));
nPnNoNo_DRun = sum(double(pnDRun&intraNo_DRun&interNo_DRun));

nTagPnAcAc_DRun = sum(double(pnDRun&intraAc_DRun&tagAc_DRun));
nTagPnAcIn_DRun = sum(double(pnDRun&intraAc_DRun&tagIn_DRun));
nTagPnAcNo_DRun = sum(double(pnDRun&intraAc_DRun&tagNo_DRun));
nTagPnInAc_DRun = sum(double(pnDRun&intraIn_DRun&tagAc_DRun));
nTagPnInIn_DRun = sum(double(pnDRun&intraIn_DRun&tagIn_DRun));
nTagPnInNo_DRun = sum(double(pnDRun&intraIn_DRun&tagNo_DRun));
nTagPnNoAc_DRun = sum(double(pnDRun&intraNo_DRun&tagAc_DRun));
nTagPnNoIn_DRun = sum(double(pnDRun&intraNo_DRun&tagIn_DRun));
nTagPnNoNo_DRun = sum(double(pnDRun&intraNo_DRun&tagNo_DRun));

% no light during run
pnnoRun = tnoRun.fr_task > 0.01 & tnoRun.fr_task < 10;
% npnDRw = sum(double(pn));
innoRun = tnoRun.fr_task > 10;
% ninDRw = sum(double(inDRw));

intraAc_noRun = tnoRun.intraLightDir==1;
intraIn_noRun = tnoRun.intraLightDir==-1;
intraNo_noRun = tnoRun.intraLightDir==0;

interAc_noRun = tnoRun.interLightDir==1;
interIn_noRun = tnoRun.interLightDir==-1;
interNo_noRun = tnoRun.interLightDir==0;

tagAc_noRun = tnoRun.tagLightDir==1;
tagIn_noRun = tnoRun.tagLightDir==-1;
tagNo_noRun = tnoRun.tagLightDir==0;

nPnAcAc_noRun = sum(double(pnnoRun&intraAc_noRun&interAc_noRun));
nPnAcIn_noRun = sum(double(pnnoRun&intraAc_noRun&interIn_noRun));
nPnAcNo_noRun = sum(double(pnnoRun&intraAc_noRun&interNo_noRun));
nPnInAc_noRun = sum(double(pnnoRun&intraIn_noRun&interAc_noRun));
nPnInIn_noRun = sum(double(pnnoRun&intraIn_noRun&interIn_noRun));
nPnInNo_noRun = sum(double(pnnoRun&intraIn_noRun&interNo_noRun));
nPnNoAc_noRun = sum(double(pnnoRun&intraNo_noRun&interAc_noRun));
nPnNoIn_noRun = sum(double(pnnoRun&intraNo_noRun&interIn_noRun));
nPnNoNo_noRun = sum(double(pnnoRun&intraNo_noRun&interNo_noRun));

nTagPnAcAc_noRun = sum(double(pnnoRun&intraAc_noRun&tagAc_noRun));
nTagPnAcIn_noRun = sum(double(pnnoRun&intraAc_noRun&tagIn_noRun));
nTagPnAcNo_noRun = sum(double(pnnoRun&intraAc_noRun&tagNo_noRun));
nTagPnInAc_noRun = sum(double(pnnoRun&intraIn_noRun&tagAc_noRun));
nTagPnInIn_noRun = sum(double(pnnoRun&intraIn_noRun&tagIn_noRun));
nTagPnInNo_noRun = sum(double(pnnoRun&intraIn_noRun&tagNo_noRun));
nTagPnNoAc_noRun = sum(double(pnnoRun&intraNo_noRun&tagAc_noRun));
nTagPnNoIn_noRun = sum(double(pnnoRun&intraNo_noRun&tagIn_noRun));
nTagPnNoNo_noRun = sum(double(pnnoRun&intraNo_noRun&tagNo_noRun));

% No light (noDRun)
xpt_corrPnAcAc = [ones(nPnAcAc_DRun,1);ones(nPnAcAc_DRun,1)*2;ones(nPnAcAc_DRun,1)*3;ones(nPnAcAc_DRun,1)*4;...
                    ones(nPnAcAc_noRun,1)*5;ones(nPnAcAc_noRun,1)*6;ones(nPnAcAc_noRun,1)*7;ones(nPnAcAc_noRun,1)*8];
xpt_corrPnAcIn = [ones(nPnAcIn_DRun,1);ones(nPnAcIn_DRun,1)*2;ones(nPnAcIn_DRun,1)*3;ones(nPnAcIn_DRun,1)*4;...
                    ones(nPnAcIn_noRun,1)*5;ones(nPnAcIn_noRun,1)*6;ones(nPnAcIn_noRun,1)*7;ones(nPnAcIn_noRun,1)*8];
xpt_corrPnAcNo = [ones(nPnAcNo_DRun,1);ones(nPnAcNo_DRun,1)*2;ones(nPnAcNo_DRun,1)*3;ones(nPnAcNo_DRun,1)*4;...
                    ones(nPnAcNo_noRun,1)*5;ones(nPnAcNo_noRun,1)*6;ones(nPnAcNo_noRun,1)*7;ones(nPnAcNo_noRun,1)*8];
xpt_corrPnInAc = [ones(nPnInAc_DRun,1);ones(nPnInAc_DRun,1)*2;ones(nPnInAc_DRun,1)*3;ones(nPnInAc_DRun,1)*4;...
                    ones(nPnInAc_noRun,1)*5;ones(nPnInAc_noRun,1)*6;ones(nPnInAc_noRun,1)*7;ones(nPnInAc_noRun,1)*8];
xpt_corrPnInIn = [ones(nPnInIn_DRun,1);ones(nPnInIn_DRun,1)*2;ones(nPnInIn_DRun,1)*3;ones(nPnInIn_DRun,1)*4;...
                    ones(nPnInIn_noRun,1)*5;ones(nPnInIn_noRun,1)*6;ones(nPnInIn_noRun,1)*7;ones(nPnInIn_noRun,1)*8];
xpt_corrPnInNo = [ones(nPnInNo_DRun,1);ones(nPnInNo_DRun,1)*2;ones(nPnInNo_DRun,1)*3;ones(nPnInNo_DRun,1)*4;...
                    ones(nPnInNo_noRun,1)*5;ones(nPnInNo_noRun,1)*6;ones(nPnInNo_noRun,1)*7;ones(nPnInNo_noRun,1)*8];
xpt_corrPnNoAc = [ones(nPnNoAc_DRun,1);ones(nPnNoAc_DRun,1)*2;ones(nPnNoAc_DRun,1)*3;ones(nPnNoAc_DRun,1)*4;...
                    ones(nPnNoAc_noRun,1)*5;ones(nPnNoAc_noRun,1)*6;ones(nPnNoAc_noRun,1)*7;ones(nPnNoAc_noRun,1)*8];
xpt_corrPnNoIn = [ones(nPnNoIn_DRun,1);ones(nPnNoIn_DRun,1)*2;ones(nPnNoIn_DRun,1)*3;ones(nPnNoIn_DRun,1)*4;...
                    ones(nPnNoIn_noRun,1)*5;ones(nPnNoIn_noRun,1)*6;ones(nPnNoIn_noRun,1)*7;ones(nPnNoIn_noRun,1)*8];
xpt_corrPnNoNo = [ones(nPnNoNo_DRun,1);ones(nPnNoNo_DRun,1)*2;ones(nPnNoNo_DRun,1)*3;ones(nPnNoNo_DRun,1)*4;...
                    ones(nPnNoNo_noRun,1)*5;ones(nPnNoNo_noRun,1)*6;ones(nPnNoNo_noRun,1)*7;ones(nPnNoNo_noRun,1)*8];

xpt_corrTagPnAcAc = [ones(nTagPnAcAc_DRun,1);ones(nTagPnAcAc_DRun,1)*2;ones(nTagPnAcAc_DRun,1)*3;ones(nTagPnAcAc_DRun,1)*4;...
                        ones(nTagPnAcAc_noRun,1)*5;ones(nTagPnAcAc_noRun,1)*6;ones(nTagPnAcAc_noRun,1)*7;ones(nTagPnAcAc_noRun,1)*8];
xpt_corrTagPnAcIn = [ones(nTagPnAcIn_DRun,1);ones(nTagPnAcIn_DRun,1)*2;ones(nTagPnAcIn_DRun,1)*3;ones(nTagPnAcIn_DRun,1)*4;...
                        ones(nTagPnAcIn_noRun,1)*5;ones(nTagPnAcIn_noRun,1)*6;ones(nTagPnAcIn_noRun,1)*7;ones(nTagPnAcIn_noRun,1)*8];
xpt_corrTagPnAcNo = [ones(nTagPnAcNo_DRun,1);ones(nTagPnAcNo_DRun,1)*2;ones(nTagPnAcNo_DRun,1)*3;ones(nTagPnAcNo_DRun,1)*4;...
                        ones(nTagPnAcNo_noRun,1)*5;ones(nTagPnAcNo_noRun,1)*6;ones(nTagPnAcNo_noRun,1)*7;ones(nTagPnAcNo_noRun,1)*8];
xpt_corrTagPnInAc = [ones(nTagPnInAc_DRun,1);ones(nTagPnInAc_DRun,1)*2;ones(nTagPnInAc_DRun,1)*3;ones(nTagPnInAc_DRun,1)*4;...
                        ones(nTagPnInAc_noRun,1)*5;ones(nTagPnInAc_noRun,1)*6;ones(nTagPnInAc_noRun,1)*7;ones(nTagPnInAc_noRun,1)*8];
xpt_corrTagPnInIn = [ones(nTagPnInIn_DRun,1);ones(nTagPnInIn_DRun,1)*2;ones(nTagPnInIn_DRun,1)*3;ones(nTagPnInIn_DRun,1)*4;...
                        ones(nTagPnInIn_noRun,1)*5;ones(nTagPnInIn_noRun,1)*6;ones(nTagPnInIn_noRun,1)*7;ones(nTagPnInIn_noRun,1)*8];
xpt_corrTagPnInNo = [ones(nTagPnInNo_DRun,1);ones(nTagPnInNo_DRun,1)*2;ones(nTagPnInNo_DRun,1)*3;ones(nTagPnInNo_DRun,1)*4;...
                        ones(nTagPnInNo_noRun,1)*5;ones(nTagPnInNo_noRun,1)*6;ones(nTagPnInNo_noRun,1)*7;ones(nTagPnInNo_noRun,1)*8];
xpt_corrTagPnNoAc = [ones(nTagPnNoAc_DRun,1);ones(nTagPnNoAc_DRun,1)*2;ones(nTagPnNoAc_DRun,1)*3;ones(nTagPnNoAc_DRun,1)*4;...
                        ones(nTagPnNoAc_noRun,1)*5;ones(nTagPnNoAc_noRun,1)*6;ones(nTagPnNoAc_noRun,1)*7;ones(nTagPnNoAc_noRun,1)*8];
xpt_corrTagPnNoIn = [ones(nTagPnNoIn_DRun,1);ones(nTagPnNoIn_DRun,1)*2;ones(nTagPnNoIn_DRun,1)*3;ones(nTagPnNoIn_DRun,1)*4;...
                        ones(nTagPnNoIn_noRun,1)*5;ones(nTagPnNoIn_noRun,1)*6;ones(nTagPnNoIn_noRun,1)*7;ones(nTagPnNoIn_noRun,1)*8];
xpt_corrTagPnNoNo = [ones(nTagPnNoNo_DRun,1);ones(nTagPnNoNo_DRun,1)*2;ones(nTagPnNoNo_DRun,1)*3;ones(nTagPnNoNo_DRun,1)*4;...
                        ones(nTagPnNoNo_noRun,1)*5;ones(nTagPnNoNo_noRun,1)*6;ones(nTagPnNoNo_noRun,1)*7;ones(nTagPnNoNo_noRun,1)*8];

% Population separation track(intra) vs track(inter)
subTbl_trXtr_DRun = [sum(double(pnDRun&intraAc_DRun&interAc_DRun)), sum(double(pnDRun&intraAc_DRun&interIn_DRun)), sum(double(pnDRun&intraAc_DRun&interNo_DRun));
            sum(double(pnDRun&intraIn_DRun&interAc_DRun)), sum(double(pnDRun&intraIn_DRun&interIn_DRun)), sum(double(pnDRun&intraIn_DRun&interNo_DRun));
            sum(double(pnDRun&intraNo_DRun&interAc_DRun)), sum(double(pnDRun&intraNo_DRun&interIn_DRun)), sum(double(pnDRun&intraNo_DRun&interNo_DRun))];
subTbl_trXtr_noRun = [sum(double(pnnoRun&intraAc_noRun&interAc_noRun)), sum(double(pnnoRun&intraAc_noRun&interIn_noRun)), sum(double(pnnoRun&intraAc_noRun&interNo_noRun));
            sum(double(pnnoRun&intraIn_noRun&interAc_noRun)), sum(double(pnnoRun&intraIn_noRun&interIn_noRun)), sum(double(pnnoRun&intraIn_noRun&interNo_noRun));
            sum(double(pnnoRun&intraNo_noRun&interAc_noRun)), sum(double(pnnoRun&intraNo_noRun&interIn_noRun)), sum(double(pnnoRun&intraNo_noRun&interNo_noRun))];

% Population separation track vs tag
subTbl_trXtg_DRun = [sum(double(pnDRun&intraAc_DRun&tagAc_DRun)), sum(double(pnDRun&intraAc_DRun&tagIn_DRun)), sum(double(pnDRun&intraAc_DRun&tagNo_DRun));
            sum(double(pnDRun&intraIn_DRun&tagAc_DRun)), sum(double(pnDRun&intraIn_DRun&tagIn_DRun)), sum(double(pnDRun&intraIn_DRun&tagNo_DRun));
            sum(double(pnDRun&intraNo_DRun&tagAc_DRun)), sum(double(pnDRun&intraNo_DRun&tagIn_DRun)), sum(double(pnDRun&intraNo_DRun&tagNo_DRun))];
subTbl_trXtg_noRun = [sum(double(pnnoRun&intraAc_noRun&tagAc_noRun)), sum(double(pnnoRun&intraAc_noRun&tagIn_noRun)), sum(double(pnnoRun&intraAc_noRun&tagNo_noRun));
            sum(double(pnnoRun&intraIn_noRun&tagAc_noRun)), sum(double(pnnoRun&intraIn_noRun&tagIn_noRun)), sum(double(pnnoRun&intraIn_noRun&tagNo_noRun));
            sum(double(pnnoRun&intraNo_noRun&tagAc_noRun)), sum(double(pnnoRun&intraNo_noRun&tagIn_noRun)), sum(double(pnnoRun&intraNo_noRun&tagNo_noRun))];

ypt_corrPnAcAc = [tDRun.r_Corrhfxhf(pnDRun&intraAc_DRun&interAc_DRun); tDRun.r_Corrbfxdr(pnDRun&intraAc_DRun&interAc_DRun); tDRun.r_Corrbfxaft(pnDRun&intraAc_DRun&interAc_DRun); tDRun.r_Corrdrxaft(pnDRun&intraAc_DRun&interAc_DRun);...
                    tnoRun.r_Corrhfxhf(pnnoRun&intraAc_noRun&interAc_noRun); tnoRun.r_Corrbfxdr(pnnoRun&intraAc_noRun&interAc_noRun); tnoRun.r_Corrbfxaft(pnnoRun&intraAc_noRun&interAc_noRun); tnoRun.r_Corrdrxaft(pnnoRun&intraAc_noRun&interAc_noRun)];
ypt_corrPnAcIn = [tDRun.r_Corrhfxhf(pnDRun&intraAc_DRun&interIn_DRun); tDRun.r_Corrbfxdr(pnDRun&intraAc_DRun&interIn_DRun); tDRun.r_Corrbfxaft(pnDRun&intraAc_DRun&interIn_DRun); tDRun.r_Corrdrxaft(pnDRun&intraAc_DRun&interIn_DRun);...
                    tnoRun.r_Corrhfxhf(pnnoRun&intraAc_noRun&interIn_noRun); tnoRun.r_Corrbfxdr(pnnoRun&intraAc_noRun&interIn_noRun); tnoRun.r_Corrbfxaft(pnnoRun&intraAc_noRun&interIn_noRun); tnoRun.r_Corrdrxaft(pnnoRun&intraAc_noRun&interIn_noRun)];
ypt_corrPnAcNo = [tDRun.r_Corrhfxhf(pnDRun&intraAc_DRun&interNo_DRun); tDRun.r_Corrbfxdr(pnDRun&intraAc_DRun&interNo_DRun); tDRun.r_Corrbfxaft(pnDRun&intraAc_DRun&interNo_DRun); tDRun.r_Corrdrxaft(pnDRun&intraAc_DRun&interNo_DRun);...
                    tnoRun.r_Corrhfxhf(pnnoRun&intraAc_noRun&interNo_noRun); tnoRun.r_Corrbfxdr(pnnoRun&intraAc_noRun&interNo_noRun); tnoRun.r_Corrbfxaft(pnnoRun&intraAc_noRun&interNo_noRun); tnoRun.r_Corrdrxaft(pnnoRun&intraAc_noRun&interNo_noRun)];
ypt_corrPnInAc = [tDRun.r_Corrhfxhf(pnDRun&intraIn_DRun&interAc_DRun); tDRun.r_Corrbfxdr(pnDRun&intraIn_DRun&interAc_DRun); tDRun.r_Corrbfxaft(pnDRun&intraIn_DRun&interAc_DRun); tDRun.r_Corrdrxaft(pnDRun&intraIn_DRun&interAc_DRun);...
                    tnoRun.r_Corrhfxhf(pnnoRun&intraIn_noRun&interAc_noRun); tnoRun.r_Corrbfxdr(pnnoRun&intraIn_noRun&interAc_noRun); tnoRun.r_Corrbfxaft(pnnoRun&intraIn_noRun&interAc_noRun); tnoRun.r_Corrdrxaft(pnnoRun&intraIn_noRun&interAc_noRun)];
ypt_corrPnInIn = [tDRun.r_Corrhfxhf(pnDRun&intraIn_DRun&interIn_DRun); tDRun.r_Corrbfxdr(pnDRun&intraIn_DRun&interIn_DRun); tDRun.r_Corrbfxaft(pnDRun&intraIn_DRun&interIn_DRun); tDRun.r_Corrdrxaft(pnDRun&intraIn_DRun&interIn_DRun);...
                    tnoRun.r_Corrhfxhf(pnnoRun&intraIn_noRun&interIn_noRun); tnoRun.r_Corrbfxdr(pnnoRun&intraIn_noRun&interIn_noRun); tnoRun.r_Corrbfxaft(pnnoRun&intraIn_noRun&interIn_noRun); tnoRun.r_Corrdrxaft(pnnoRun&intraIn_noRun&interIn_noRun)];
ypt_corrPnInNo = [tDRun.r_Corrhfxhf(pnDRun&intraIn_DRun&interNo_DRun); tDRun.r_Corrbfxdr(pnDRun&intraIn_DRun&interNo_DRun); tDRun.r_Corrbfxaft(pnDRun&intraIn_DRun&interNo_DRun); tDRun.r_Corrdrxaft(pnDRun&intraIn_DRun&interNo_DRun);...
                    tnoRun.r_Corrhfxhf(pnnoRun&intraIn_noRun&interNo_noRun); tnoRun.r_Corrbfxdr(pnnoRun&intraIn_noRun&interNo_noRun); tnoRun.r_Corrbfxaft(pnnoRun&intraIn_noRun&interNo_noRun); tnoRun.r_Corrdrxaft(pnnoRun&intraIn_noRun&interNo_noRun)];
ypt_corrPnNoAc = [tDRun.r_Corrhfxhf(pnDRun&intraNo_DRun&interAc_DRun); tDRun.r_Corrbfxdr(pnDRun&intraNo_DRun&interAc_DRun); tDRun.r_Corrbfxaft(pnDRun&intraNo_DRun&interAc_DRun); tDRun.r_Corrdrxaft(pnDRun&intraNo_DRun&interAc_DRun);...
                    tnoRun.r_Corrhfxhf(pnnoRun&intraNo_noRun&interAc_noRun); tnoRun.r_Corrbfxdr(pnnoRun&intraNo_noRun&interAc_noRun); tnoRun.r_Corrbfxaft(pnnoRun&intraNo_noRun&interAc_noRun); tnoRun.r_Corrdrxaft(pnnoRun&intraNo_noRun&interAc_noRun)];
ypt_corrPnNoIn = [tDRun.r_Corrhfxhf(pnDRun&intraNo_DRun&interIn_DRun); tDRun.r_Corrbfxdr(pnDRun&intraNo_DRun&interIn_DRun); tDRun.r_Corrbfxaft(pnDRun&intraNo_DRun&interIn_DRun); tDRun.r_Corrdrxaft(pnDRun&intraNo_DRun&interIn_DRun);...
                    tnoRun.r_Corrhfxhf(pnnoRun&intraNo_noRun&interIn_noRun); tnoRun.r_Corrbfxdr(pnnoRun&intraNo_noRun&interIn_noRun); tnoRun.r_Corrbfxaft(pnnoRun&intraNo_noRun&interIn_noRun); tnoRun.r_Corrdrxaft(pnnoRun&intraNo_noRun&interIn_noRun)];
ypt_corrPnNoNo = [tDRun.r_Corrhfxhf(pnDRun&intraNo_DRun&interNo_DRun); tDRun.r_Corrbfxdr(pnDRun&intraNo_DRun&interNo_DRun); tDRun.r_Corrbfxaft(pnDRun&intraNo_DRun&interNo_DRun); tDRun.r_Corrdrxaft(pnDRun&intraNo_DRun&interNo_DRun);...
                    tnoRun.r_Corrhfxhf(pnnoRun&intraNo_noRun&interNo_noRun); tnoRun.r_Corrbfxdr(pnnoRun&intraNo_noRun&interNo_noRun); tnoRun.r_Corrbfxaft(pnnoRun&intraNo_noRun&interNo_noRun); tnoRun.r_Corrdrxaft(pnnoRun&intraNo_noRun&interNo_noRun)];

ypt_corrTagPnAcAc = [tDRun.r_Corrhfxhf(pnDRun&intraAc_DRun&tagAc_DRun); tDRun.r_Corrbfxdr(pnDRun&intraAc_DRun&tagAc_DRun); tDRun.r_Corrbfxaft(pnDRun&intraAc_DRun&tagAc_DRun); tDRun.r_Corrdrxaft(pnDRun&intraAc_DRun&tagAc_DRun);...
                    tnoRun.r_Corrhfxhf(pnnoRun&intraAc_noRun&tagAc_noRun); tnoRun.r_Corrbfxdr(pnnoRun&intraAc_noRun&tagAc_noRun); tnoRun.r_Corrbfxaft(pnnoRun&intraAc_noRun&tagAc_noRun); tnoRun.r_Corrdrxaft(pnnoRun&intraAc_noRun&tagAc_noRun)];
ypt_corrTagPnAcIn = [tDRun.r_Corrhfxhf(pnDRun&intraAc_DRun&tagIn_DRun); tDRun.r_Corrbfxdr(pnDRun&intraAc_DRun&tagIn_DRun); tDRun.r_Corrbfxaft(pnDRun&intraAc_DRun&tagIn_DRun); tDRun.r_Corrdrxaft(pnDRun&intraAc_DRun&tagIn_DRun);...
                    tnoRun.r_Corrhfxhf(pnnoRun&intraAc_noRun&tagIn_noRun); tnoRun.r_Corrbfxdr(pnnoRun&intraAc_noRun&tagIn_noRun); tnoRun.r_Corrbfxaft(pnnoRun&intraAc_noRun&tagIn_noRun); tnoRun.r_Corrdrxaft(pnnoRun&intraAc_noRun&tagIn_noRun)];
ypt_corrTagPnAcNo = [tDRun.r_Corrhfxhf(pnDRun&intraAc_DRun&tagNo_DRun); tDRun.r_Corrbfxdr(pnDRun&intraAc_DRun&tagNo_DRun); tDRun.r_Corrbfxaft(pnDRun&intraAc_DRun&tagNo_DRun); tDRun.r_Corrdrxaft(pnDRun&intraAc_DRun&tagNo_DRun);...
                    tnoRun.r_Corrhfxhf(pnnoRun&intraAc_noRun&tagNo_noRun); tnoRun.r_Corrbfxdr(pnnoRun&intraAc_noRun&tagNo_noRun); tnoRun.r_Corrbfxaft(pnnoRun&intraAc_noRun&tagNo_noRun); tnoRun.r_Corrdrxaft(pnnoRun&intraAc_noRun&tagNo_noRun)];
ypt_corrTagPnInAc = [tDRun.r_Corrhfxhf(pnDRun&intraIn_DRun&tagAc_DRun); tDRun.r_Corrbfxdr(pnDRun&intraIn_DRun&tagAc_DRun); tDRun.r_Corrbfxaft(pnDRun&intraIn_DRun&tagAc_DRun); tDRun.r_Corrdrxaft(pnDRun&intraIn_DRun&tagAc_DRun);...
                    tnoRun.r_Corrhfxhf(pnnoRun&intraIn_noRun&tagAc_noRun); tnoRun.r_Corrbfxdr(pnnoRun&intraIn_noRun&tagAc_noRun); tnoRun.r_Corrbfxaft(pnnoRun&intraIn_noRun&tagAc_noRun); tnoRun.r_Corrdrxaft(pnnoRun&intraIn_noRun&tagAc_noRun)];
ypt_corrTagPnInIn = [tDRun.r_Corrhfxhf(pnDRun&intraIn_DRun&tagIn_DRun); tDRun.r_Corrbfxdr(pnDRun&intraIn_DRun&tagIn_DRun); tDRun.r_Corrbfxaft(pnDRun&intraIn_DRun&tagIn_DRun); tDRun.r_Corrdrxaft(pnDRun&intraIn_DRun&tagIn_DRun);...
                    tnoRun.r_Corrhfxhf(pnnoRun&intraIn_noRun&tagIn_noRun); tnoRun.r_Corrbfxdr(pnnoRun&intraIn_noRun&tagIn_noRun); tnoRun.r_Corrbfxaft(pnnoRun&intraIn_noRun&tagIn_noRun); tnoRun.r_Corrdrxaft(pnnoRun&intraIn_noRun&tagIn_noRun)];
ypt_corrTagPnInNo = [tDRun.r_Corrhfxhf(pnDRun&intraIn_DRun&tagNo_DRun); tDRun.r_Corrbfxdr(pnDRun&intraIn_DRun&tagNo_DRun); tDRun.r_Corrbfxaft(pnDRun&intraIn_DRun&tagNo_DRun); tDRun.r_Corrdrxaft(pnDRun&intraIn_DRun&tagNo_DRun);...
                    tnoRun.r_Corrhfxhf(pnnoRun&intraIn_noRun&tagNo_noRun); tnoRun.r_Corrbfxdr(pnnoRun&intraIn_noRun&tagNo_noRun); tnoRun.r_Corrbfxaft(pnnoRun&intraIn_noRun&tagNo_noRun); tnoRun.r_Corrdrxaft(pnnoRun&intraIn_noRun&tagNo_noRun)];
ypt_corrTagPnNoAc = [tDRun.r_Corrhfxhf(pnDRun&intraNo_DRun&tagAc_DRun); tDRun.r_Corrbfxdr(pnDRun&intraNo_DRun&tagAc_DRun); tDRun.r_Corrbfxaft(pnDRun&intraNo_DRun&tagAc_DRun); tDRun.r_Corrdrxaft(pnDRun&intraNo_DRun&tagAc_DRun);...
                    tnoRun.r_Corrhfxhf(pnnoRun&intraNo_noRun&tagAc_noRun); tnoRun.r_Corrbfxdr(pnnoRun&intraNo_noRun&tagAc_noRun); tnoRun.r_Corrbfxaft(pnnoRun&intraNo_noRun&tagAc_noRun); tnoRun.r_Corrdrxaft(pnnoRun&intraNo_noRun&tagAc_noRun)];
ypt_corrTagPnNoIn = [tDRun.r_Corrhfxhf(pnDRun&intraNo_DRun&tagIn_DRun); tDRun.r_Corrbfxdr(pnDRun&intraNo_DRun&tagIn_DRun); tDRun.r_Corrbfxaft(pnDRun&intraNo_DRun&tagIn_DRun); tDRun.r_Corrdrxaft(pnDRun&intraNo_DRun&tagIn_DRun);...
                    tnoRun.r_Corrhfxhf(pnnoRun&intraNo_noRun&tagIn_noRun); tnoRun.r_Corrbfxdr(pnnoRun&intraNo_noRun&tagIn_noRun); tnoRun.r_Corrbfxaft(pnnoRun&intraNo_noRun&tagIn_noRun); tnoRun.r_Corrdrxaft(pnnoRun&intraNo_noRun&tagIn_noRun)];
ypt_corrTagPnNoNo = [tDRun.r_Corrhfxhf(pnDRun&intraNo_DRun&tagNo_DRun); tDRun.r_Corrbfxdr(pnDRun&intraNo_DRun&tagNo_DRun); tDRun.r_Corrbfxaft(pnDRun&intraNo_DRun&tagNo_DRun); tDRun.r_Corrdrxaft(pnDRun&intraNo_DRun&tagNo_DRun);...
                    tnoRun.r_Corrhfxhf(pnnoRun&intraNo_noRun&tagNo_noRun); tnoRun.r_Corrbfxdr(pnnoRun&intraNo_noRun&tagNo_noRun); tnoRun.r_Corrbfxaft(pnnoRun&intraNo_noRun&tagNo_noRun); tnoRun.r_Corrdrxaft(pnnoRun&intraNo_noRun&tagNo_noRun)];

% z-transformation
% [ypt_ZcorrPnAcAc, ~] = fisherZ(ypt_corrPnAcAc);
% [ypt_ZcorrPnAcIn, ~] = fisherZ(ypt_corrPnAcIn);
% [ypt_ZcorrPnAcNo, ~] = fisherZ(ypt_corrPnAcNo);
% [ypt_ZcorrPnInAc, ~] = fisherZ(ypt_corrPnInAc);
% [ypt_ZcorrPnInIn, ~] = fisherZ(ypt_corrPnInIn);
% [ypt_ZcorrPnInNo, ~] = fisherZ(ypt_corrPnInNo);
% [ypt_ZcorrPnNoAc, ~] = fisherZ(ypt_corrPnNoAc);
% [ypt_ZcorrPnNoIn, ~] = fisherZ(ypt_corrPnNoIn);
% [ypt_ZcorrPnNoNo, ~] = fisherZ(ypt_corrPnNoNo);
% 
% [ypt_ZcorrTagPnAcAc, ~] = fisherZ(ypt_corrTagPnAcAc);
% [ypt_ZcorrTagPnAcIn, ~] = fisherZ(ypt_corrTagPnAcIn);
% [ypt_ZcorrTagPnAcNo, ~] = fisherZ(ypt_corrTagPnAcNo);
% [ypt_ZcorrTagPnInAc, ~] = fisherZ(ypt_corrTagPnInAc);
% [ypt_ZcorrTagPnInIn, ~] = fisherZ(ypt_corrTagPnInIn);
% [ypt_ZcorrTagPnInNo, ~] = fisherZ(ypt_corrTagPnInNo);
% [ypt_ZcorrTagPnNoAc, ~] = fisherZ(ypt_corrTagPnNoAc);
% [ypt_ZcorrTagPnNoIn, ~] = fisherZ(ypt_corrTagPnNoIn);
% [ypt_ZcorrTagPnNoNo, ~] = fisherZ(ypt_corrTagPnNoNo);

% multiway ANOVA
[~, ~, statsPnAcAc] = anovan(ypt_corrPnAcAc,{xpt_corrPnAcAc},'display','off');
[~, ~, statsPnAcIn] = anovan(ypt_corrPnAcIn,{xpt_corrPnAcIn},'display','off');
[~, ~, statsPnAcNo] = anovan(ypt_corrPnAcNo,{xpt_corrPnAcNo},'display','off');
[~, ~, statsPnInAc] = anovan(ypt_corrPnInAc,{xpt_corrPnInAc},'display','off');
[~, ~, statsPnInIn] = anovan(ypt_corrPnInIn,{xpt_corrPnInIn},'display','off');
[~, ~, statsPnInNo] = anovan(ypt_corrPnInNo,{xpt_corrPnInNo},'display','off');
[~, ~, statsPnNoAc] = anovan(ypt_corrPnNoAc,{xpt_corrPnNoAc},'display','off');
[~, ~, statsPnNoIn] = anovan(ypt_corrPnNoIn,{xpt_corrPnNoIn},'display','off');
[~, ~, statsPnNoNo] = anovan(ypt_corrPnNoNo,{xpt_corrPnNoNo},'display','off');

[~, ~, statsTagPnAcAc] = anovan(ypt_corrTagPnAcAc,{xpt_corrTagPnAcAc},'display','off');
[~, ~, statsTagPnAcIn] = anovan(ypt_corrTagPnAcIn,{xpt_corrTagPnAcIn},'display','off');
[~, ~, statsTagPnAcNo] = anovan(ypt_corrTagPnAcNo,{xpt_corrTagPnAcNo},'display','off');
[~, ~, statsTagPnInAc] = anovan(ypt_corrTagPnInAc,{xpt_corrTagPnInAc},'display','off');
[~, ~, statsTagPnInIn] = anovan(ypt_corrTagPnInIn,{xpt_corrTagPnInIn},'display','off');
[~, ~, statsTagPnInNo] = anovan(ypt_corrTagPnInNo,{xpt_corrTagPnInNo},'display','off');
[~, ~, statsTagPnNoAc] = anovan(ypt_corrTagPnNoAc,{xpt_corrTagPnNoAc},'display','off');
[~, ~, statsTagPnNoIn] = anovan(ypt_corrTagPnNoIn,{xpt_corrTagPnNoIn},'display','off');
[~, ~, statsTagPnNoNo] = anovan(ypt_corrTagPnNoNo,{xpt_corrTagPnNoNo},'display','off');

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
MyScatterBarPlot(ypt_corrPnAcAc,xpt_corrPnAcAc,0.35,{colorPink,colorPurple,colorBlue3,colorOrange,colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & interAc','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nPnAcAc_DRun)]);
text(6.5,-0.8,['n = ',num2str(nPnAcAc_noRun)]);

hCorr(2) = axes('Position',axpt(3,3,2,1,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrPnAcIn,xpt_corrPnAcIn,0.35,{colorPink,colorPurple,colorBlue3,colorOrange,colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & interAc','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nPnAcIn_DRun)]);
text(6.5,-0.8,['n = ',num2str(nPnAcIn_noRun)]);

hCorr(3) = axes('Position',axpt(3,3,3,1,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrPnAcNo,xpt_corrPnAcNo,0.35,{colorPink,colorPurple,colorBlue3,colorOrange,colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & interAc','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nPnAcNo_DRun)]);
text(6.5,-0.8,['n = ',num2str(nPnAcNo_noRun)]);

hCorr(4) = axes('Position',axpt(3,3,1,2,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrPnInAc,xpt_corrPnInAc,0.35,{colorPink,colorPurple,colorBlue3,colorOrange,colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & interAc','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nPnInAc_DRun)]);
text(6.5,-0.8,['n = ',num2str(nPnInAc_noRun)]);

hCorr(5) = axes('Position',axpt(3,3,2,2,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrPnInIn,xpt_corrPnInIn,0.35,{colorPink,colorPurple,colorBlue3,colorOrange,colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & interAc','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nPnInIn_DRun)]);
text(6.5,-0.8,['n = ',num2str(nPnInIn_noRun)]);

hCorr(6) = axes('Position',axpt(3,3,3,2,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrPnInNo,xpt_corrPnInNo,0.35,{colorPink,colorPurple,colorBlue3,colorOrange,colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & interAc','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nPnInNo_DRun)]);
text(6.5,-0.8,['n = ',num2str(nPnInNo_noRun)]);

hCorr(7) = axes('Position',axpt(3,3,1,3,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrPnNoAc,xpt_corrPnNoAc,0.35,{colorPink,colorPurple,colorBlue3,colorOrange,colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & interAc','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nPnNoAc_DRun)]);
text(6.5,-0.8,['n = ',num2str(nPnNoAc_noRun)]);

hCorr(8) = axes('Position',axpt(3,3,2,3,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrPnNoIn,xpt_corrPnNoIn,0.35,{colorPink,colorPurple,colorBlue3,colorOrange,colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & interAc','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nPnNoIn_DRun)]);
text(6.5,-0.8,['n = ',num2str(nPnNoIn_noRun)]);

hCorr(9) = axes('Position',axpt(3,3,3,3,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrPnNoNo,xpt_corrPnNoNo,0.35,{colorPink,colorPurple,colorBlue3,colorOrange,colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & interAc','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nPnNoNo_DRun)]);
text(6.5,-0.8,['n = ',num2str(nPnNoNo_noRun)]);

set(hCorr,'YLim',[-1.2 1.2],'XLim',[0, 9],'XTick',[1,2,3,4,5,6,7,8],'XTickLabel',{'hf x hf','bf x dur', 'bf x aft', 'dur x aft','hf x hf','bf x dur', 'bf x aft', 'dur x aft'},'FontSize',fontM);
print(gcf,'-depsc','-r300',['PN_Run_intra_inter2_',num2str(intra_inter)]);

% In-block vs tag comparison
figure(2)
hCorrTag(1) = axes('Position',axpt(3,3,1,1,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrTagPnAcAc,xpt_corrTagPnAcAc,0.35,{colorPink,colorPurple,colorBlue3,colorOrange,colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & tagAc','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nTagPnAcAc_DRun)]);
text(6.5,-0.8,['n = ',num2str(nTagPnAcAc_noRun)]);

hCorrTag(2) = axes('Position',axpt(3,3,2,1,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrTagPnAcIn,xpt_corrTagPnAcIn,0.35,{colorPink,colorPurple,colorBlue3,colorOrange,colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & tagAc','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nTagPnAcIn_DRun)]);
text(6.5,-0.8,['n = ',num2str(nTagPnAcIn_noRun)]);

hCorrTag(3) = axes('Position',axpt(3,3,3,1,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrTagPnAcNo,xpt_corrTagPnAcNo,0.35,{colorPink,colorPurple,colorBlue3,colorOrange,colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & tagAc','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nTagPnAcNo_DRun)]);
text(6.5,-0.8,['n = ',num2str(nTagPnAcNo_noRun)]);

hCorrTag(4) = axes('Position',axpt(3,3,1,2,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrTagPnInAc,xpt_corrTagPnInAc,0.35,{colorPink,colorPurple,colorBlue3,colorOrange,colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & tagAc','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nTagPnInAc_DRun)]);
text(6.5,-0.8,['n = ',num2str(nTagPnInAc_noRun)]);

hCorrTag(5) = axes('Position',axpt(3,3,2,2,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrTagPnInIn,xpt_corrTagPnInIn,0.35,{colorPink,colorPurple,colorBlue3,colorOrange,colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & tagAc','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nTagPnInIn_DRun)]);
text(6.5,-0.8,['n = ',num2str(nTagPnInIn_noRun)]);

hCorrTag(6) = axes('Position',axpt(3,3,3,2,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrTagPnInNo,xpt_corrTagPnInNo,0.35,{colorPink,colorPurple,colorBlue3,colorOrange,colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & tagAc','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nTagPnInNo_DRun)]);
text(6.5,-0.8,['n = ',num2str(nTagPnInNo_noRun)]);

hCorrTag(7) = axes('Position',axpt(3,3,1,3,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrTagPnNoAc,xpt_corrTagPnNoAc,0.35,{colorPink,colorPurple,colorBlue3,colorOrange,colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & tagAc','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nTagPnNoAc_DRun)]);
text(6.5,-0.8,['n = ',num2str(nTagPnNoAc_noRun)]);

hCorrTag(8) = axes('Position',axpt(3,3,2,3,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrTagPnNoIn,xpt_corrTagPnNoIn,0.35,{colorPink,colorPurple,colorBlue3,colorOrange,colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & tagAc','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nTagPnNoIn_DRun)]);
text(6.5,-0.8,['n = ',num2str(nTagPnNoIn_noRun)]);

hCorrTag(9) = axes('Position',axpt(3,3,3,3,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrTagPnNoNo,xpt_corrTagPnNoNo,0.35,{colorPink,colorPurple,colorBlue3,colorOrange,colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & tagAc','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nTagPnNoNo_DRun)]);
text(6.5,-0.8,['n = ',num2str(nTagPnNoNo_noRun)]);

set(hCorrTag,'YLim',[-1.2 1.2],'XTick',[1,2,3,4,5,6,7,8],'XTickLabel',{'hf x hf','bf x dur', 'bf x aft', 'dur x aft','hf x hf','bf x dur', 'bf x aft', 'dur x aft'},'FontSize',fontM);
print(gcf,'-depsc','-r300',['PN_Run_intra_tag_',num2str(intra_tag)]);