function fig6_lightSeparation_Rw_modi(intra_inter,intra_tag)
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

tDRw = T;
tnoRw = T;

tDRw(~(tDRw.taskType == 'DRw'),:) = [];
tnoRw(~(tnoRw.taskType == 'noRw'),:) = [];

pnDRw = tDRw.fr_task > 0.01 & tDRw.fr_task < 10;
% npnDRw = sum(double(pn));
inDRw = tDRw.fr_task > 10;
% ninDRw = sum(double(inDRw));

intraAc_DRw = tDRw.intraLightDir==1;
intraIn_DRw = tDRw.intraLightDir==-1;
intraNo_DRw = tDRw.intraLightDir==0;

interAc_DRw = tDRw.interLightDir==1;
interIn_DRw = tDRw.interLightDir==-1;
interNo_DRw = tDRw.interLightDir==0;

tagAc_DRw = tDRw.tagLightDir==1;
tagIn_DRw = tDRw.tagLightDir==-1;
tagNo_DRw = tDRw.tagLightDir==0;

nPnAcAc_DRw = sum(double(pnDRw&intraAc_DRw&interAc_DRw));
nPnAcIn_DRw = sum(double(pnDRw&intraAc_DRw&interIn_DRw));
nPnAcNo_DRw = sum(double(pnDRw&intraAc_DRw&interNo_DRw));
nPnInAc_DRw = sum(double(pnDRw&intraIn_DRw&interAc_DRw));
nPnInIn_DRw = sum(double(pnDRw&intraIn_DRw&interIn_DRw));
nPnInNo_DRw = sum(double(pnDRw&intraIn_DRw&interNo_DRw));
nPnNoAc_DRw = sum(double(pnDRw&intraNo_DRw&interAc_DRw));
nPnNoIn_DRw = sum(double(pnDRw&intraNo_DRw&interIn_DRw));
nPnNoNo_DRw = sum(double(pnDRw&intraNo_DRw&interNo_DRw));

nTagPnAcAc_DRw = sum(double(pnDRw&intraAc_DRw&tagAc_DRw));
nTagPnAcIn_DRw = sum(double(pnDRw&intraAc_DRw&tagIn_DRw));
nTagPnAcNo_DRw = sum(double(pnDRw&intraAc_DRw&tagNo_DRw));
nTagPnInAc_DRw = sum(double(pnDRw&intraIn_DRw&tagAc_DRw));
nTagPnInIn_DRw = sum(double(pnDRw&intraIn_DRw&tagIn_DRw));
nTagPnInNo_DRw = sum(double(pnDRw&intraIn_DRw&tagNo_DRw));
nTagPnNoAc_DRw = sum(double(pnDRw&intraNo_DRw&tagAc_DRw));
nTagPnNoIn_DRw = sum(double(pnDRw&intraNo_DRw&tagIn_DRw));
nTagPnNoNo_DRw = sum(double(pnDRw&intraNo_DRw&tagNo_DRw));

% no light during run
pnnoRw = tnoRw.fr_task > 0.01 & tnoRw.fr_task < 10;
% npnDRw = sum(double(pn));
innoRw = tnoRw.fr_task > 10;
% ninDRw = sum(double(inDRw));

intraAc_noRw = tnoRw.intraLightDir==1;
intraIn_noRw = tnoRw.intraLightDir==-1;
intraNo_noRw = tnoRw.intraLightDir==0;

interAc_noRw = tnoRw.interLightDir==1;
interIn_noRw = tnoRw.interLightDir==-1;
interNo_noRw = tnoRw.interLightDir==0;

tagAc_noRw = tnoRw.tagLightDir==1;
tagIn_noRw = tnoRw.tagLightDir==-1;
tagNo_noRw = tnoRw.tagLightDir==0;

nPnAcAc_noRw = sum(double(pnnoRw&intraAc_noRw&interAc_noRw));
nPnAcIn_noRw = sum(double(pnnoRw&intraAc_noRw&interIn_noRw));
nPnAcNo_noRw = sum(double(pnnoRw&intraAc_noRw&interNo_noRw));
nPnInAc_noRw = sum(double(pnnoRw&intraIn_noRw&interAc_noRw));
nPnInIn_noRw = sum(double(pnnoRw&intraIn_noRw&interIn_noRw));
nPnInNo_noRw = sum(double(pnnoRw&intraIn_noRw&interNo_noRw));
nPnNoAc_noRw = sum(double(pnnoRw&intraNo_noRw&interAc_noRw));
nPnNoIn_noRw = sum(double(pnnoRw&intraNo_noRw&interIn_noRw));
nPnNoNo_noRw = sum(double(pnnoRw&intraNo_noRw&interNo_noRw));

nTagPnAcAc_noRw = sum(double(pnnoRw&intraAc_noRw&tagAc_noRw));
nTagPnAcIn_noRw = sum(double(pnnoRw&intraAc_noRw&tagIn_noRw));
nTagPnAcNo_noRw = sum(double(pnnoRw&intraAc_noRw&tagNo_noRw));
nTagPnInAc_noRw = sum(double(pnnoRw&intraIn_noRw&tagAc_noRw));
nTagPnInIn_noRw = sum(double(pnnoRw&intraIn_noRw&tagIn_noRw));
nTagPnInNo_noRw = sum(double(pnnoRw&intraIn_noRw&tagNo_noRw));
nTagPnNoAc_noRw = sum(double(pnnoRw&intraNo_noRw&tagAc_noRw));
nTagPnNoIn_noRw = sum(double(pnnoRw&intraNo_noRw&tagIn_noRw));
nTagPnNoNo_noRw = sum(double(pnnoRw&intraNo_noRw&tagNo_noRw));

% No light (noDRun)
xpt_corrPnAcAc = [ones(nPnAcAc_DRw,1);ones(nPnAcAc_DRw,1)*2;ones(nPnAcAc_DRw,1)*3;ones(nPnAcAc_DRw,1)*4;...
                    ones(nPnAcAc_noRw,1)*5;ones(nPnAcAc_noRw,1)*6;ones(nPnAcAc_noRw,1)*7;ones(nPnAcAc_noRw,1)*8];
xpt_corrPnAcIn = [ones(nPnAcIn_DRw,1);ones(nPnAcIn_DRw,1)*2;ones(nPnAcIn_DRw,1)*3;ones(nPnAcIn_DRw,1)*4;...
                    ones(nPnAcIn_noRw,1)*5;ones(nPnAcIn_noRw,1)*6;ones(nPnAcIn_noRw,1)*7;ones(nPnAcIn_noRw,1)*8];
xpt_corrPnAcNo = [ones(nPnAcNo_DRw,1);ones(nPnAcNo_DRw,1)*2;ones(nPnAcNo_DRw,1)*3;ones(nPnAcNo_DRw,1)*4;...
                    ones(nPnAcNo_noRw,1)*5;ones(nPnAcNo_noRw,1)*6;ones(nPnAcNo_noRw,1)*7;ones(nPnAcNo_noRw,1)*8];
xpt_corrPnInAc = [ones(nPnInAc_DRw,1);ones(nPnInAc_DRw,1)*2;ones(nPnInAc_DRw,1)*3;ones(nPnInAc_DRw,1)*4;...
                    ones(nPnInAc_noRw,1)*5;ones(nPnInAc_noRw,1)*6;ones(nPnInAc_noRw,1)*7;ones(nPnInAc_noRw,1)*8];
xpt_corrPnInIn = [ones(nPnInIn_DRw,1);ones(nPnInIn_DRw,1)*2;ones(nPnInIn_DRw,1)*3;ones(nPnInIn_DRw,1)*4;...
                    ones(nPnInIn_noRw,1)*5;ones(nPnInIn_noRw,1)*6;ones(nPnInIn_noRw,1)*7;ones(nPnInIn_noRw,1)*8];
xpt_corrPnInNo = [ones(nPnInNo_DRw,1);ones(nPnInNo_DRw,1)*2;ones(nPnInNo_DRw,1)*3;ones(nPnInNo_DRw,1)*4;...
                    ones(nPnInNo_noRw,1)*5;ones(nPnInNo_noRw,1)*6;ones(nPnInNo_noRw,1)*7;ones(nPnInNo_noRw,1)*8];
xpt_corrPnNoAc = [ones(nPnNoAc_DRw,1);ones(nPnNoAc_DRw,1)*2;ones(nPnNoAc_DRw,1)*3;ones(nPnNoAc_DRw,1)*4;...
                    ones(nPnNoAc_noRw,1)*5;ones(nPnNoAc_noRw,1)*6;ones(nPnNoAc_noRw,1)*7;ones(nPnNoAc_noRw,1)*8];
xpt_corrPnNoIn = [ones(nPnNoIn_DRw,1);ones(nPnNoIn_DRw,1)*2;ones(nPnNoIn_DRw,1)*3;ones(nPnNoIn_DRw,1)*4;...
                    ones(nPnNoIn_noRw,1)*5;ones(nPnNoIn_noRw,1)*6;ones(nPnNoIn_noRw,1)*7;ones(nPnNoIn_noRw,1)*8];
xpt_corrPnNoNo = [ones(nPnNoNo_DRw,1);ones(nPnNoNo_DRw,1)*2;ones(nPnNoNo_DRw,1)*3;ones(nPnNoNo_DRw,1)*4;...
                    ones(nPnNoNo_noRw,1)*5;ones(nPnNoNo_noRw,1)*6;ones(nPnNoNo_noRw,1)*7;ones(nPnNoNo_noRw,1)*8];

xpt_corrTagPnAcAc = [ones(nTagPnAcAc_DRw,1);ones(nTagPnAcAc_DRw,1)*2;ones(nTagPnAcAc_DRw,1)*3;ones(nTagPnAcAc_DRw,1)*4;...
                        ones(nTagPnAcAc_noRw,1)*5;ones(nTagPnAcAc_noRw,1)*6;ones(nTagPnAcAc_noRw,1)*7;ones(nTagPnAcAc_noRw,1)*8];
xpt_corrTagPnAcIn = [ones(nTagPnAcIn_DRw,1);ones(nTagPnAcIn_DRw,1)*2;ones(nTagPnAcIn_DRw,1)*3;ones(nTagPnAcIn_DRw,1)*4;...
                        ones(nTagPnAcIn_noRw,1)*5;ones(nTagPnAcIn_noRw,1)*6;ones(nTagPnAcIn_noRw,1)*7;ones(nTagPnAcIn_noRw,1)*8];
xpt_corrTagPnAcNo = [ones(nTagPnAcNo_DRw,1);ones(nTagPnAcNo_DRw,1)*2;ones(nTagPnAcNo_DRw,1)*3;ones(nTagPnAcNo_DRw,1)*4;...
                        ones(nTagPnAcNo_noRw,1)*5;ones(nTagPnAcNo_noRw,1)*6;ones(nTagPnAcNo_noRw,1)*7;ones(nTagPnAcNo_noRw,1)*8];
xpt_corrTagPnInAc = [ones(nTagPnInAc_DRw,1);ones(nTagPnInAc_DRw,1)*2;ones(nTagPnInAc_DRw,1)*3;ones(nTagPnInAc_DRw,1)*4;...
                        ones(nTagPnInAc_noRw,1)*5;ones(nTagPnInAc_noRw,1)*6;ones(nTagPnInAc_noRw,1)*7;ones(nTagPnInAc_noRw,1)*8];
xpt_corrTagPnInIn = [ones(nTagPnInIn_DRw,1);ones(nTagPnInIn_DRw,1)*2;ones(nTagPnInIn_DRw,1)*3;ones(nTagPnInIn_DRw,1)*4;...
                        ones(nTagPnInIn_noRw,1)*5;ones(nTagPnInIn_noRw,1)*6;ones(nTagPnInIn_noRw,1)*7;ones(nTagPnInIn_noRw,1)*8];
xpt_corrTagPnInNo = [ones(nTagPnInNo_DRw,1);ones(nTagPnInNo_DRw,1)*2;ones(nTagPnInNo_DRw,1)*3;ones(nTagPnInNo_DRw,1)*4;...
                        ones(nTagPnInNo_noRw,1)*5;ones(nTagPnInNo_noRw,1)*6;ones(nTagPnInNo_noRw,1)*7;ones(nTagPnInNo_noRw,1)*8];
xpt_corrTagPnNoAc = [ones(nTagPnNoAc_DRw,1);ones(nTagPnNoAc_DRw,1)*2;ones(nTagPnNoAc_DRw,1)*3;ones(nTagPnNoAc_DRw,1)*4;...
                        ones(nTagPnNoAc_noRw,1)*5;ones(nTagPnNoAc_noRw,1)*6;ones(nTagPnNoAc_noRw,1)*7;ones(nTagPnNoAc_noRw,1)*8];
xpt_corrTagPnNoIn = [ones(nTagPnNoIn_DRw,1);ones(nTagPnNoIn_DRw,1)*2;ones(nTagPnNoIn_DRw,1)*3;ones(nTagPnNoIn_DRw,1)*4;...
                        ones(nTagPnNoIn_noRw,1)*5;ones(nTagPnNoIn_noRw,1)*6;ones(nTagPnNoIn_noRw,1)*7;ones(nTagPnNoIn_noRw,1)*8];
xpt_corrTagPnNoNo = [ones(nTagPnNoNo_DRw,1);ones(nTagPnNoNo_DRw,1)*2;ones(nTagPnNoNo_DRw,1)*3;ones(nTagPnNoNo_DRw,1)*4;...
                        ones(nTagPnNoNo_noRw,1)*5;ones(nTagPnNoNo_noRw,1)*6;ones(nTagPnNoNo_noRw,1)*7;ones(nTagPnNoNo_noRw,1)*8];

% Population separation track(intra) vs track(inter)
subTbl_trXtr_DRw = [sum(double(pnDRw&intraAc_DRw&interAc_DRw)), sum(double(pnDRw&intraAc_DRw&interIn_DRw)), sum(double(pnDRw&intraAc_DRw&interNo_DRw));
            sum(double(pnDRw&intraIn_DRw&interAc_DRw)), sum(double(pnDRw&intraIn_DRw&interIn_DRw)), sum(double(pnDRw&intraIn_DRw&interNo_DRw));
            sum(double(pnDRw&intraNo_DRw&interAc_DRw)), sum(double(pnDRw&intraNo_DRw&interIn_DRw)), sum(double(pnDRw&intraNo_DRw&interNo_DRw))];
subTbl_trXtr_noRw = [sum(double(pnnoRw&intraAc_noRw&interAc_noRw)), sum(double(pnnoRw&intraAc_noRw&interIn_noRw)), sum(double(pnnoRw&intraAc_noRw&interNo_noRw));
            sum(double(pnnoRw&intraIn_noRw&interAc_noRw)), sum(double(pnnoRw&intraIn_noRw&interIn_noRw)), sum(double(pnnoRw&intraIn_noRw&interNo_noRw));
            sum(double(pnnoRw&intraNo_noRw&interAc_noRw)), sum(double(pnnoRw&intraNo_noRw&interIn_noRw)), sum(double(pnnoRw&intraNo_noRw&interNo_noRw))];

% Population separation track vs tag
subTbl_trXtg_DRw = [sum(double(pnDRw&intraAc_DRw&tagAc_DRw)), sum(double(pnDRw&intraAc_DRw&tagIn_DRw)), sum(double(pnDRw&intraAc_DRw&tagNo_DRw));
            sum(double(pnDRw&intraIn_DRw&tagAc_DRw)), sum(double(pnDRw&intraIn_DRw&tagIn_DRw)), sum(double(pnDRw&intraIn_DRw&tagNo_DRw));
            sum(double(pnDRw&intraNo_DRw&tagAc_DRw)), sum(double(pnDRw&intraNo_DRw&tagIn_DRw)), sum(double(pnDRw&intraNo_DRw&tagNo_DRw))];
subTbl_trXtg_noRw = [sum(double(pnnoRw&intraAc_noRw&tagAc_noRw)), sum(double(pnnoRw&intraAc_noRw&tagIn_noRw)), sum(double(pnnoRw&intraAc_noRw&tagNo_noRw));
            sum(double(pnnoRw&intraIn_noRw&tagAc_noRw)), sum(double(pnnoRw&intraIn_noRw&tagIn_noRw)), sum(double(pnnoRw&intraIn_noRw&tagNo_noRw));
            sum(double(pnnoRw&intraNo_noRw&tagAc_noRw)), sum(double(pnnoRw&intraNo_noRw&tagIn_noRw)), sum(double(pnnoRw&intraNo_noRw&tagNo_noRw))];

% Even - Odd correlation
% ypt_corrPnAcAc = [tDRw.r_CorrEvOd(pnDRw&intraAc_DRw&interAc_DRw); tDRw.r_Corrbfxdr(pnDRw&intraAc_DRw&interAc_DRw); tDRw.r_Corrbfxaft(pnDRw&intraAc_DRw&interAc_DRw); tDRw.r_Corrdrxaft(pnDRw&intraAc_DRw&interAc_DRw);...
%                  tnoRw.r_CorrEvOd(pnnoRw&intraAc_noRw&interAc_noRw); tnoRw.r_Corrbfxdr(pnnoRw&intraAc_noRw&interAc_noRw); tnoRw.r_Corrbfxaft(pnnoRw&intraAc_noRw&interAc_noRw); tnoRw.r_Corrdrxaft(pnnoRw&intraAc_noRw&interAc_noRw)];
% ypt_corrPnAcIn = [tDRw.r_CorrEvOd(pnDRw&intraAc_DRw&interIn_DRw); tDRw.r_Corrbfxdr(pnDRw&intraAc_DRw&interIn_DRw); tDRw.r_Corrbfxaft(pnDRw&intraAc_DRw&interIn_DRw); tDRw.r_Corrdrxaft(pnDRw&intraAc_DRw&interIn_DRw);...
%                  tnoRw.r_CorrEvOd(pnnoRw&intraAc_noRw&interIn_noRw); tnoRw.r_Corrbfxdr(pnnoRw&intraAc_noRw&interIn_noRw); tnoRw.r_Corrbfxaft(pnnoRw&intraAc_noRw&interIn_noRw); tnoRw.r_Corrdrxaft(pnnoRw&intraAc_noRw&interIn_noRw)];
% ypt_corrPnAcNo = [tDRw.r_CorrEvOd(pnDRw&intraAc_DRw&interNo_DRw); tDRw.r_Corrbfxdr(pnDRw&intraAc_DRw&interNo_DRw); tDRw.r_Corrbfxaft(pnDRw&intraAc_DRw&interNo_DRw); tDRw.r_Corrdrxaft(pnDRw&intraAc_DRw&interNo_DRw);...
%                  tnoRw.r_CorrEvOd(pnnoRw&intraAc_noRw&interNo_noRw); tnoRw.r_Corrbfxdr(pnnoRw&intraAc_noRw&interNo_noRw); tnoRw.r_Corrbfxaft(pnnoRw&intraAc_noRw&interNo_noRw); tnoRw.r_Corrdrxaft(pnnoRw&intraAc_noRw&interNo_noRw)];
% ypt_corrPnInAc = [tDRw.r_CorrEvOd(pnDRw&intraIn_DRw&interAc_DRw); tDRw.r_Corrbfxdr(pnDRw&intraIn_DRw&interAc_DRw); tDRw.r_Corrbfxaft(pnDRw&intraIn_DRw&interAc_DRw); tDRw.r_Corrdrxaft(pnDRw&intraIn_DRw&interAc_DRw);...
%                  tnoRw.r_CorrEvOd(pnnoRw&intraIn_noRw&interAc_noRw); tnoRw.r_Corrbfxdr(pnnoRw&intraIn_noRw&interAc_noRw); tnoRw.r_Corrbfxaft(pnnoRw&intraIn_noRw&interAc_noRw); tnoRw.r_Corrdrxaft(pnnoRw&intraIn_noRw&interAc_noRw)];
% ypt_corrPnInIn = [tDRw.r_CorrEvOd(pnDRw&intraIn_DRw&interIn_DRw); tDRw.r_Corrbfxdr(pnDRw&intraIn_DRw&interIn_DRw); tDRw.r_Corrbfxaft(pnDRw&intraIn_DRw&interIn_DRw); tDRw.r_Corrdrxaft(pnDRw&intraIn_DRw&interIn_DRw);...
%                  tnoRw.r_CorrEvOd(pnnoRw&intraIn_noRw&interIn_noRw); tnoRw.r_Corrbfxdr(pnnoRw&intraIn_noRw&interIn_noRw); tnoRw.r_Corrbfxaft(pnnoRw&intraIn_noRw&interIn_noRw); tnoRw.r_Corrdrxaft(pnnoRw&intraIn_noRw&interIn_noRw)];
% ypt_corrPnInNo = [tDRw.r_CorrEvOd(pnDRw&intraIn_DRw&interNo_DRw); tDRw.r_Corrbfxdr(pnDRw&intraIn_DRw&interNo_DRw); tDRw.r_Corrbfxaft(pnDRw&intraIn_DRw&interNo_DRw); tDRw.r_Corrdrxaft(pnDRw&intraIn_DRw&interNo_DRw);...
%                  tnoRw.r_CorrEvOd(pnnoRw&intraIn_noRw&interNo_noRw); tnoRw.r_Corrbfxdr(pnnoRw&intraIn_noRw&interNo_noRw); tnoRw.r_Corrbfxaft(pnnoRw&intraIn_noRw&interNo_noRw); tnoRw.r_Corrdrxaft(pnnoRw&intraIn_noRw&interNo_noRw)];
% ypt_corrPnNoAc = [tDRw.r_CorrEvOd(pnDRw&intraNo_DRw&interAc_DRw); tDRw.r_Corrbfxdr(pnDRw&intraNo_DRw&interAc_DRw); tDRw.r_Corrbfxaft(pnDRw&intraNo_DRw&interAc_DRw); tDRw.r_Corrdrxaft(pnDRw&intraNo_DRw&interAc_DRw);...
%                  tnoRw.r_CorrEvOd(pnnoRw&intraNo_noRw&interAc_noRw); tnoRw.r_Corrbfxdr(pnnoRw&intraNo_noRw&interAc_noRw); tnoRw.r_Corrbfxaft(pnnoRw&intraNo_noRw&interAc_noRw); tnoRw.r_Corrdrxaft(pnnoRw&intraNo_noRw&interAc_noRw)];
% ypt_corrPnNoIn = [tDRw.r_CorrEvOd(pnDRw&intraNo_DRw&interIn_DRw); tDRw.r_Corrbfxdr(pnDRw&intraNo_DRw&interIn_DRw); tDRw.r_Corrbfxaft(pnDRw&intraNo_DRw&interIn_DRw); tDRw.r_Corrdrxaft(pnDRw&intraNo_DRw&interIn_DRw);...
%                  tnoRw.r_CorrEvOd(pnnoRw&intraNo_noRw&interIn_noRw); tnoRw.r_Corrbfxdr(pnnoRw&intraNo_noRw&interIn_noRw); tnoRw.r_Corrbfxaft(pnnoRw&intraNo_noRw&interIn_noRw); tnoRw.r_Corrdrxaft(pnnoRw&intraNo_noRw&interIn_noRw)];
% ypt_corrPnNoNo = [tDRw.r_CorrEvOd(pnDRw&intraNo_DRw&interNo_DRw); tDRw.r_Corrbfxdr(pnDRw&intraNo_DRw&interNo_DRw); tDRw.r_Corrbfxaft(pnDRw&intraNo_DRw&interNo_DRw); tDRw.r_Corrdrxaft(pnDRw&intraNo_DRw&interNo_DRw);...
%                  tnoRw.r_CorrEvOd(pnnoRw&intraNo_noRw&interNo_noRw); tnoRw.r_Corrbfxdr(pnnoRw&intraNo_noRw&interNo_noRw); tnoRw.r_Corrbfxaft(pnnoRw&intraNo_noRw&interNo_noRw); tnoRw.r_Corrdrxaft(pnnoRw&intraNo_noRw&interNo_noRw)];
% 
% ypt_corrTagPnAcAc = [tDRw.r_CorrEvOd(pnDRw&intraAc_DRw&tagAc_DRw); tDRw.r_Corrbfxdr(pnDRw&intraAc_DRw&tagAc_DRw); tDRw.r_Corrbfxaft(pnDRw&intraAc_DRw&tagAc_DRw); tDRw.r_Corrdrxaft(pnDRw&intraAc_DRw&tagAc_DRw);...
%                     tnoRw.r_CorrEvOd(pnnoRw&intraAc_noRw&tagAc_noRw); tnoRw.r_Corrbfxdr(pnnoRw&intraAc_noRw&tagAc_noRw); tnoRw.r_Corrbfxaft(pnnoRw&intraAc_noRw&tagAc_noRw); tnoRw.r_Corrdrxaft(pnnoRw&intraAc_noRw&tagAc_noRw)];
% ypt_corrTagPnAcIn = [tDRw.r_CorrEvOd(pnDRw&intraAc_DRw&tagIn_DRw); tDRw.r_Corrbfxdr(pnDRw&intraAc_DRw&tagIn_DRw); tDRw.r_Corrbfxaft(pnDRw&intraAc_DRw&tagIn_DRw); tDRw.r_Corrdrxaft(pnDRw&intraAc_DRw&tagIn_DRw);...
%                     tnoRw.r_CorrEvOd(pnnoRw&intraAc_noRw&tagIn_noRw); tnoRw.r_Corrbfxdr(pnnoRw&intraAc_noRw&tagIn_noRw); tnoRw.r_Corrbfxaft(pnnoRw&intraAc_noRw&tagIn_noRw); tnoRw.r_Corrdrxaft(pnnoRw&intraAc_noRw&tagIn_noRw)];
% ypt_corrTagPnAcNo = [tDRw.r_CorrEvOd(pnDRw&intraAc_DRw&tagNo_DRw); tDRw.r_Corrbfxdr(pnDRw&intraAc_DRw&tagNo_DRw); tDRw.r_Corrbfxaft(pnDRw&intraAc_DRw&tagNo_DRw); tDRw.r_Corrdrxaft(pnDRw&intraAc_DRw&tagNo_DRw);...
%                     tnoRw.r_CorrEvOd(pnnoRw&intraAc_noRw&tagNo_noRw); tnoRw.r_Corrbfxdr(pnnoRw&intraAc_noRw&tagNo_noRw); tnoRw.r_Corrbfxaft(pnnoRw&intraAc_noRw&tagNo_noRw); tnoRw.r_Corrdrxaft(pnnoRw&intraAc_noRw&tagNo_noRw)];
% ypt_corrTagPnInAc = [tDRw.r_CorrEvOd(pnDRw&intraIn_DRw&tagAc_DRw); tDRw.r_Corrbfxdr(pnDRw&intraIn_DRw&tagAc_DRw); tDRw.r_Corrbfxaft(pnDRw&intraIn_DRw&tagAc_DRw); tDRw.r_Corrdrxaft(pnDRw&intraIn_DRw&tagAc_DRw);...
%                     tnoRw.r_CorrEvOd(pnnoRw&intraIn_noRw&tagAc_noRw); tnoRw.r_Corrbfxdr(pnnoRw&intraIn_noRw&tagAc_noRw); tnoRw.r_Corrbfxaft(pnnoRw&intraIn_noRw&tagAc_noRw); tnoRw.r_Corrdrxaft(pnnoRw&intraIn_noRw&tagAc_noRw)];
% ypt_corrTagPnInIn = [tDRw.r_CorrEvOd(pnDRw&intraIn_DRw&tagIn_DRw); tDRw.r_Corrbfxdr(pnDRw&intraIn_DRw&tagIn_DRw); tDRw.r_Corrbfxaft(pnDRw&intraIn_DRw&tagIn_DRw); tDRw.r_Corrdrxaft(pnDRw&intraIn_DRw&tagIn_DRw);...
%                     tnoRw.r_CorrEvOd(pnnoRw&intraIn_noRw&tagIn_noRw); tnoRw.r_Corrbfxdr(pnnoRw&intraIn_noRw&tagIn_noRw); tnoRw.r_Corrbfxaft(pnnoRw&intraIn_noRw&tagIn_noRw); tnoRw.r_Corrdrxaft(pnnoRw&intraIn_noRw&tagIn_noRw)];
% ypt_corrTagPnInNo = [tDRw.r_CorrEvOd(pnDRw&intraIn_DRw&tagNo_DRw); tDRw.r_Corrbfxdr(pnDRw&intraIn_DRw&tagNo_DRw); tDRw.r_Corrbfxaft(pnDRw&intraIn_DRw&tagNo_DRw); tDRw.r_Corrdrxaft(pnDRw&intraIn_DRw&tagNo_DRw);...
%                     tnoRw.r_CorrEvOd(pnnoRw&intraIn_noRw&tagNo_noRw); tnoRw.r_Corrbfxdr(pnnoRw&intraIn_noRw&tagNo_noRw); tnoRw.r_Corrbfxaft(pnnoRw&intraIn_noRw&tagNo_noRw); tnoRw.r_Corrdrxaft(pnnoRw&intraIn_noRw&tagNo_noRw)];
% ypt_corrTagPnNoAc = [tDRw.r_CorrEvOd(pnDRw&intraNo_DRw&tagAc_DRw); tDRw.r_Corrbfxdr(pnDRw&intraNo_DRw&tagAc_DRw); tDRw.r_Corrbfxaft(pnDRw&intraNo_DRw&tagAc_DRw); tDRw.r_Corrdrxaft(pnDRw&intraNo_DRw&tagAc_DRw);...
%                     tnoRw.r_CorrEvOd(pnnoRw&intraNo_noRw&tagAc_noRw); tnoRw.r_Corrbfxdr(pnnoRw&intraNo_noRw&tagAc_noRw); tnoRw.r_Corrbfxaft(pnnoRw&intraNo_noRw&tagAc_noRw); tnoRw.r_Corrdrxaft(pnnoRw&intraNo_noRw&tagAc_noRw)];
% ypt_corrTagPnNoIn = [tDRw.r_CorrEvOd(pnDRw&intraNo_DRw&tagIn_DRw); tDRw.r_Corrbfxdr(pnDRw&intraNo_DRw&tagIn_DRw); tDRw.r_Corrbfxaft(pnDRw&intraNo_DRw&tagIn_DRw); tDRw.r_Corrdrxaft(pnDRw&intraNo_DRw&tagIn_DRw);...
%                     tnoRw.r_CorrEvOd(pnnoRw&intraNo_noRw&tagIn_noRw); tnoRw.r_Corrbfxdr(pnnoRw&intraNo_noRw&tagIn_noRw); tnoRw.r_Corrbfxaft(pnnoRw&intraNo_noRw&tagIn_noRw); tnoRw.r_Corrdrxaft(pnnoRw&intraNo_noRw&tagIn_noRw)];
% ypt_corrTagPnNoNo = [tDRw.r_CorrEvOd(pnDRw&intraNo_DRw&tagNo_DRw); tDRw.r_Corrbfxdr(pnDRw&intraNo_DRw&tagNo_DRw); tDRw.r_Corrbfxaft(pnDRw&intraNo_DRw&tagNo_DRw); tDRw.r_Corrdrxaft(pnDRw&intraNo_DRw&tagNo_DRw);...
%                     tnoRw.r_CorrEvOd(pnnoRw&intraNo_noRw&tagNo_noRw); tnoRw.r_Corrbfxdr(pnnoRw&intraNo_noRw&tagNo_noRw); tnoRw.r_Corrbfxaft(pnnoRw&intraNo_noRw&tagNo_noRw); tnoRw.r_Corrdrxaft(pnnoRw&intraNo_noRw&tagNo_noRw)];

% hf-hf correlation
ypt_corrPnAcAc = [tDRw.r_Corrhfxhf(pnDRw&intraAc_DRw&interAc_DRw); tDRw.r_Corrbfxdr(pnDRw&intraAc_DRw&interAc_DRw); tDRw.r_Corrbfxaft(pnDRw&intraAc_DRw&interAc_DRw); tDRw.r_Corrdrxaft(pnDRw&intraAc_DRw&interAc_DRw);...
                    tnoRw.r_Corrhfxhf(pnnoRw&intraAc_noRw&interAc_noRw); tnoRw.r_Corrbfxdr(pnnoRw&intraAc_noRw&interAc_noRw); tnoRw.r_Corrbfxaft(pnnoRw&intraAc_noRw&interAc_noRw); tnoRw.r_Corrdrxaft(pnnoRw&intraAc_noRw&interAc_noRw)];
ypt_corrPnAcIn = [tDRw.r_Corrhfxhf(pnDRw&intraAc_DRw&interIn_DRw); tDRw.r_Corrbfxdr(pnDRw&intraAc_DRw&interIn_DRw); tDRw.r_Corrbfxaft(pnDRw&intraAc_DRw&interIn_DRw); tDRw.r_Corrdrxaft(pnDRw&intraAc_DRw&interIn_DRw);...
                    tnoRw.r_Corrhfxhf(pnnoRw&intraAc_noRw&interIn_noRw); tnoRw.r_Corrbfxdr(pnnoRw&intraAc_noRw&interIn_noRw); tnoRw.r_Corrbfxaft(pnnoRw&intraAc_noRw&interIn_noRw); tnoRw.r_Corrdrxaft(pnnoRw&intraAc_noRw&interIn_noRw)];
ypt_corrPnAcNo = [tDRw.r_Corrhfxhf(pnDRw&intraAc_DRw&interNo_DRw); tDRw.r_Corrbfxdr(pnDRw&intraAc_DRw&interNo_DRw); tDRw.r_Corrbfxaft(pnDRw&intraAc_DRw&interNo_DRw); tDRw.r_Corrdrxaft(pnDRw&intraAc_DRw&interNo_DRw);...
                    tnoRw.r_Corrhfxhf(pnnoRw&intraAc_noRw&interNo_noRw); tnoRw.r_Corrbfxdr(pnnoRw&intraAc_noRw&interNo_noRw); tnoRw.r_Corrbfxaft(pnnoRw&intraAc_noRw&interNo_noRw); tnoRw.r_Corrdrxaft(pnnoRw&intraAc_noRw&interNo_noRw)];
ypt_corrPnInAc = [tDRw.r_Corrhfxhf(pnDRw&intraIn_DRw&interAc_DRw); tDRw.r_Corrbfxdr(pnDRw&intraIn_DRw&interAc_DRw); tDRw.r_Corrbfxaft(pnDRw&intraIn_DRw&interAc_DRw); tDRw.r_Corrdrxaft(pnDRw&intraIn_DRw&interAc_DRw);...
                    tnoRw.r_Corrhfxhf(pnnoRw&intraIn_noRw&interAc_noRw); tnoRw.r_Corrbfxdr(pnnoRw&intraIn_noRw&interAc_noRw); tnoRw.r_Corrbfxaft(pnnoRw&intraIn_noRw&interAc_noRw); tnoRw.r_Corrdrxaft(pnnoRw&intraIn_noRw&interAc_noRw)];
ypt_corrPnInIn = [tDRw.r_Corrhfxhf(pnDRw&intraIn_DRw&interIn_DRw); tDRw.r_Corrbfxdr(pnDRw&intraIn_DRw&interIn_DRw); tDRw.r_Corrbfxaft(pnDRw&intraIn_DRw&interIn_DRw); tDRw.r_Corrdrxaft(pnDRw&intraIn_DRw&interIn_DRw);...
                    tnoRw.r_Corrhfxhf(pnnoRw&intraIn_noRw&interIn_noRw); tnoRw.r_Corrbfxdr(pnnoRw&intraIn_noRw&interIn_noRw); tnoRw.r_Corrbfxaft(pnnoRw&intraIn_noRw&interIn_noRw); tnoRw.r_Corrdrxaft(pnnoRw&intraIn_noRw&interIn_noRw)];
ypt_corrPnInNo = [tDRw.r_Corrhfxhf(pnDRw&intraIn_DRw&interNo_DRw); tDRw.r_Corrbfxdr(pnDRw&intraIn_DRw&interNo_DRw); tDRw.r_Corrbfxaft(pnDRw&intraIn_DRw&interNo_DRw); tDRw.r_Corrdrxaft(pnDRw&intraIn_DRw&interNo_DRw);...
                    tnoRw.r_Corrhfxhf(pnnoRw&intraIn_noRw&interNo_noRw); tnoRw.r_Corrbfxdr(pnnoRw&intraIn_noRw&interNo_noRw); tnoRw.r_Corrbfxaft(pnnoRw&intraIn_noRw&interNo_noRw); tnoRw.r_Corrdrxaft(pnnoRw&intraIn_noRw&interNo_noRw)];
ypt_corrPnNoAc = [tDRw.r_Corrhfxhf(pnDRw&intraNo_DRw&interAc_DRw); tDRw.r_Corrbfxdr(pnDRw&intraNo_DRw&interAc_DRw); tDRw.r_Corrbfxaft(pnDRw&intraNo_DRw&interAc_DRw); tDRw.r_Corrdrxaft(pnDRw&intraNo_DRw&interAc_DRw);...
                    tnoRw.r_Corrhfxhf(pnnoRw&intraNo_noRw&interAc_noRw); tnoRw.r_Corrbfxdr(pnnoRw&intraNo_noRw&interAc_noRw); tnoRw.r_Corrbfxaft(pnnoRw&intraNo_noRw&interAc_noRw); tnoRw.r_Corrdrxaft(pnnoRw&intraNo_noRw&interAc_noRw)];
ypt_corrPnNoIn = [tDRw.r_Corrhfxhf(pnDRw&intraNo_DRw&interIn_DRw); tDRw.r_Corrbfxdr(pnDRw&intraNo_DRw&interIn_DRw); tDRw.r_Corrbfxaft(pnDRw&intraNo_DRw&interIn_DRw); tDRw.r_Corrdrxaft(pnDRw&intraNo_DRw&interIn_DRw);...
                    tnoRw.r_Corrhfxhf(pnnoRw&intraNo_noRw&interIn_noRw); tnoRw.r_Corrbfxdr(pnnoRw&intraNo_noRw&interIn_noRw); tnoRw.r_Corrbfxaft(pnnoRw&intraNo_noRw&interIn_noRw); tnoRw.r_Corrdrxaft(pnnoRw&intraNo_noRw&interIn_noRw)];
ypt_corrPnNoNo = [tDRw.r_Corrhfxhf(pnDRw&intraNo_DRw&interNo_DRw); tDRw.r_Corrbfxdr(pnDRw&intraNo_DRw&interNo_DRw); tDRw.r_Corrbfxaft(pnDRw&intraNo_DRw&interNo_DRw); tDRw.r_Corrdrxaft(pnDRw&intraNo_DRw&interNo_DRw);...
                    tnoRw.r_Corrhfxhf(pnnoRw&intraNo_noRw&interNo_noRw); tnoRw.r_Corrbfxdr(pnnoRw&intraNo_noRw&interNo_noRw); tnoRw.r_Corrbfxaft(pnnoRw&intraNo_noRw&interNo_noRw); tnoRw.r_Corrdrxaft(pnnoRw&intraNo_noRw&interNo_noRw)];

ypt_corrTagPnAcAc = [tDRw.r_Corrhfxhf(pnDRw&intraAc_DRw&tagAc_DRw); tDRw.r_Corrbfxdr(pnDRw&intraAc_DRw&tagAc_DRw); tDRw.r_Corrbfxaft(pnDRw&intraAc_DRw&tagAc_DRw); tDRw.r_Corrdrxaft(pnDRw&intraAc_DRw&tagAc_DRw);...
                    tnoRw.r_Corrhfxhf(pnnoRw&intraAc_noRw&tagAc_noRw); tnoRw.r_Corrbfxdr(pnnoRw&intraAc_noRw&tagAc_noRw); tnoRw.r_Corrbfxaft(pnnoRw&intraAc_noRw&tagAc_noRw); tnoRw.r_Corrdrxaft(pnnoRw&intraAc_noRw&tagAc_noRw)];
ypt_corrTagPnAcIn = [tDRw.r_Corrhfxhf(pnDRw&intraAc_DRw&tagIn_DRw); tDRw.r_Corrbfxdr(pnDRw&intraAc_DRw&tagIn_DRw); tDRw.r_Corrbfxaft(pnDRw&intraAc_DRw&tagIn_DRw); tDRw.r_Corrdrxaft(pnDRw&intraAc_DRw&tagIn_DRw);...
                    tnoRw.r_Corrhfxhf(pnnoRw&intraAc_noRw&tagIn_noRw); tnoRw.r_Corrbfxdr(pnnoRw&intraAc_noRw&tagIn_noRw); tnoRw.r_Corrbfxaft(pnnoRw&intraAc_noRw&tagIn_noRw); tnoRw.r_Corrdrxaft(pnnoRw&intraAc_noRw&tagIn_noRw)];
ypt_corrTagPnAcNo = [tDRw.r_Corrhfxhf(pnDRw&intraAc_DRw&tagNo_DRw); tDRw.r_Corrbfxdr(pnDRw&intraAc_DRw&tagNo_DRw); tDRw.r_Corrbfxaft(pnDRw&intraAc_DRw&tagNo_DRw); tDRw.r_Corrdrxaft(pnDRw&intraAc_DRw&tagNo_DRw);...
                    tnoRw.r_Corrhfxhf(pnnoRw&intraAc_noRw&tagNo_noRw); tnoRw.r_Corrbfxdr(pnnoRw&intraAc_noRw&tagNo_noRw); tnoRw.r_Corrbfxaft(pnnoRw&intraAc_noRw&tagNo_noRw); tnoRw.r_Corrdrxaft(pnnoRw&intraAc_noRw&tagNo_noRw)];
ypt_corrTagPnInAc = [tDRw.r_Corrhfxhf(pnDRw&intraIn_DRw&tagAc_DRw); tDRw.r_Corrbfxdr(pnDRw&intraIn_DRw&tagAc_DRw); tDRw.r_Corrbfxaft(pnDRw&intraIn_DRw&tagAc_DRw); tDRw.r_Corrdrxaft(pnDRw&intraIn_DRw&tagAc_DRw);...
                    tnoRw.r_Corrhfxhf(pnnoRw&intraIn_noRw&tagAc_noRw); tnoRw.r_Corrbfxdr(pnnoRw&intraIn_noRw&tagAc_noRw); tnoRw.r_Corrbfxaft(pnnoRw&intraIn_noRw&tagAc_noRw); tnoRw.r_Corrdrxaft(pnnoRw&intraIn_noRw&tagAc_noRw)];
ypt_corrTagPnInIn = [tDRw.r_Corrhfxhf(pnDRw&intraIn_DRw&tagIn_DRw); tDRw.r_Corrbfxdr(pnDRw&intraIn_DRw&tagIn_DRw); tDRw.r_Corrbfxaft(pnDRw&intraIn_DRw&tagIn_DRw); tDRw.r_Corrdrxaft(pnDRw&intraIn_DRw&tagIn_DRw);...
                    tnoRw.r_Corrhfxhf(pnnoRw&intraIn_noRw&tagIn_noRw); tnoRw.r_Corrbfxdr(pnnoRw&intraIn_noRw&tagIn_noRw); tnoRw.r_Corrbfxaft(pnnoRw&intraIn_noRw&tagIn_noRw); tnoRw.r_Corrdrxaft(pnnoRw&intraIn_noRw&tagIn_noRw)];
ypt_corrTagPnInNo = [tDRw.r_Corrhfxhf(pnDRw&intraIn_DRw&tagNo_DRw); tDRw.r_Corrbfxdr(pnDRw&intraIn_DRw&tagNo_DRw); tDRw.r_Corrbfxaft(pnDRw&intraIn_DRw&tagNo_DRw); tDRw.r_Corrdrxaft(pnDRw&intraIn_DRw&tagNo_DRw);...
                    tnoRw.r_Corrhfxhf(pnnoRw&intraIn_noRw&tagNo_noRw); tnoRw.r_Corrbfxdr(pnnoRw&intraIn_noRw&tagNo_noRw); tnoRw.r_Corrbfxaft(pnnoRw&intraIn_noRw&tagNo_noRw); tnoRw.r_Corrdrxaft(pnnoRw&intraIn_noRw&tagNo_noRw)];
ypt_corrTagPnNoAc = [tDRw.r_Corrhfxhf(pnDRw&intraNo_DRw&tagAc_DRw); tDRw.r_Corrbfxdr(pnDRw&intraNo_DRw&tagAc_DRw); tDRw.r_Corrbfxaft(pnDRw&intraNo_DRw&tagAc_DRw); tDRw.r_Corrdrxaft(pnDRw&intraNo_DRw&tagAc_DRw);...
                    tnoRw.r_Corrhfxhf(pnnoRw&intraNo_noRw&tagAc_noRw); tnoRw.r_Corrbfxdr(pnnoRw&intraNo_noRw&tagAc_noRw); tnoRw.r_Corrbfxaft(pnnoRw&intraNo_noRw&tagAc_noRw); tnoRw.r_Corrdrxaft(pnnoRw&intraNo_noRw&tagAc_noRw)];
ypt_corrTagPnNoIn = [tDRw.r_Corrhfxhf(pnDRw&intraNo_DRw&tagIn_DRw); tDRw.r_Corrbfxdr(pnDRw&intraNo_DRw&tagIn_DRw); tDRw.r_Corrbfxaft(pnDRw&intraNo_DRw&tagIn_DRw); tDRw.r_Corrdrxaft(pnDRw&intraNo_DRw&tagIn_DRw);...
                    tnoRw.r_Corrhfxhf(pnnoRw&intraNo_noRw&tagIn_noRw); tnoRw.r_Corrbfxdr(pnnoRw&intraNo_noRw&tagIn_noRw); tnoRw.r_Corrbfxaft(pnnoRw&intraNo_noRw&tagIn_noRw); tnoRw.r_Corrdrxaft(pnnoRw&intraNo_noRw&tagIn_noRw)];
ypt_corrTagPnNoNo = [tDRw.r_Corrhfxhf(pnDRw&intraNo_DRw&tagNo_DRw); tDRw.r_Corrbfxdr(pnDRw&intraNo_DRw&tagNo_DRw); tDRw.r_Corrbfxaft(pnDRw&intraNo_DRw&tagNo_DRw); tDRw.r_Corrdrxaft(pnDRw&intraNo_DRw&tagNo_DRw);...
                    tnoRw.r_Corrhfxhf(pnnoRw&intraNo_noRw&tagNo_noRw); tnoRw.r_Corrbfxdr(pnnoRw&intraNo_noRw&tagNo_noRw); tnoRw.r_Corrbfxaft(pnnoRw&intraNo_noRw&tagNo_noRw); tnoRw.r_Corrdrxaft(pnnoRw&intraNo_noRw&tagNo_noRw)];

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
text(2.5,-0.8,['n = ',num2str(nPnAcAc_DRw)]);
text(6.5,-0.8,['n = ',num2str(nPnAcAc_noRw)]);

hCorr(2) = axes('Position',axpt(3,3,2,1,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrPnAcIn,xpt_corrPnAcIn,0.35,{colorPink,colorPurple,colorBlue3,colorOrange,colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & interAc','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nPnAcIn_DRw)]);
text(6.5,-0.8,['n = ',num2str(nPnAcIn_noRw)]);

hCorr(3) = axes('Position',axpt(3,3,3,1,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrPnAcNo,xpt_corrPnAcNo,0.35,{colorPink,colorPurple,colorBlue3,colorOrange,colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & interAc','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nPnAcNo_DRw)]);
text(6.5,-0.8,['n = ',num2str(nPnAcNo_noRw)]);

hCorr(4) = axes('Position',axpt(3,3,1,2,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrPnInAc,xpt_corrPnInAc,0.35,{colorPink,colorPurple,colorBlue3,colorOrange,colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & interAc','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nPnInAc_DRw)]);
text(6.5,-0.8,['n = ',num2str(nPnInAc_noRw)]);

hCorr(5) = axes('Position',axpt(3,3,2,2,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrPnInIn,xpt_corrPnInIn,0.35,{colorPink,colorPurple,colorBlue3,colorOrange,colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & interAc','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nPnInIn_DRw)]);
text(6.5,-0.8,['n = ',num2str(nPnInIn_noRw)]);

hCorr(6) = axes('Position',axpt(3,3,3,2,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrPnInNo,xpt_corrPnInNo,0.35,{colorPink,colorPurple,colorBlue3,colorOrange,colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & interAc','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nPnInNo_DRw)]);
text(6.5,-0.8,['n = ',num2str(nPnInNo_noRw)]);

hCorr(7) = axes('Position',axpt(3,3,1,3,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrPnNoAc,xpt_corrPnNoAc,0.35,{colorPink,colorPurple,colorBlue3,colorOrange,colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & interAc','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nPnNoAc_DRw)]);
text(6.5,-0.8,['n = ',num2str(nPnNoAc_noRw)]);

hCorr(8) = axes('Position',axpt(3,3,2,3,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrPnNoIn,xpt_corrPnNoIn,0.35,{colorPink,colorPurple,colorBlue3,colorOrange,colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & interAc','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nPnNoIn_DRw)]);
text(6.5,-0.8,['n = ',num2str(nPnNoIn_noRw)]);

hCorr(9) = axes('Position',axpt(3,3,3,3,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrPnNoNo,xpt_corrPnNoNo,0.35,{colorPink,colorPurple,colorBlue3,colorOrange,colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & interAc','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nPnNoNo_DRw)]);
text(6.5,-0.8,['n = ',num2str(nPnNoNo_noRw)]);

set(hCorr,'YLim',[-1.2 1.2],'XLim',[0, 9],'XTick',[1,2,3,4,5,6,7,8],'XTickLabel',{'h x h','b x d', 'b x a', 'd x a','h x h','b x d', 'b x a', 'd x a'},'FontSize',fontM);
% set(hCorr,'YLim',[-1.2 1.2],'XLim',[0, 9],'XTick',[1,2,3,4,5,6,7,8],'XTickLabel',{'hf-hf(EO)','bf-du', 'bf-af', 'du-af','hf-hf','bf-du', 'bf-af', 'du-af'},'FontSize',fontM);
print(gcf,'-depsc','-r300',['PN_Rw_intra_inter_',num2str(intra_inter)]);

% In-block vs tag comparison
figure(2)
hCorrTag(1) = axes('Position',axpt(3,3,1,1,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrTagPnAcAc,xpt_corrTagPnAcAc,0.35,{colorPink,colorPurple,colorBlue3,colorOrange,colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & tagAc','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nTagPnAcAc_DRw)]);
text(6.5,-0.8,['n = ',num2str(nTagPnAcAc_noRw)]);

hCorrTag(2) = axes('Position',axpt(3,3,2,1,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrTagPnAcIn,xpt_corrTagPnAcIn,0.35,{colorPink,colorPurple,colorBlue3,colorOrange,colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & tagAc','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nTagPnAcIn_DRw)]);
text(6.5,-0.8,['n = ',num2str(nTagPnAcIn_noRw)]);

hCorrTag(3) = axes('Position',axpt(3,3,3,1,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrTagPnAcNo,xpt_corrTagPnAcNo,0.35,{colorPink,colorPurple,colorBlue3,colorOrange,colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & tagAc','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nTagPnAcNo_DRw)]);
text(6.5,-0.8,['n = ',num2str(nTagPnAcNo_noRw)]);

hCorrTag(4) = axes('Position',axpt(3,3,1,2,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrTagPnInAc,xpt_corrTagPnInAc,0.35,{colorPink,colorPurple,colorBlue3,colorOrange,colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & tagAc','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nTagPnInAc_DRw)]);
text(6.5,-0.8,['n = ',num2str(nTagPnInAc_noRw)]);

hCorrTag(5) = axes('Position',axpt(3,3,2,2,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrTagPnInIn,xpt_corrTagPnInIn,0.35,{colorPink,colorPurple,colorBlue3,colorOrange,colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & tagAc','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nTagPnInIn_DRw)]);
text(6.5,-0.8,['n = ',num2str(nTagPnInIn_noRw)]);

hCorrTag(6) = axes('Position',axpt(3,3,3,2,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrTagPnInNo,xpt_corrTagPnInNo,0.35,{colorPink,colorPurple,colorBlue3,colorOrange,colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & tagAc','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nTagPnInNo_DRw)]);
text(6.5,-0.8,['n = ',num2str(nTagPnInNo_noRw)]);

hCorrTag(7) = axes('Position',axpt(3,3,1,3,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrTagPnNoAc,xpt_corrTagPnNoAc,0.35,{colorPink,colorPurple,colorBlue3,colorOrange,colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & tagAc','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nTagPnNoAc_DRw)]);
text(6.5,-0.8,['n = ',num2str(nTagPnNoAc_noRw)]);

hCorrTag(8) = axes('Position',axpt(3,3,2,3,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrTagPnNoIn,xpt_corrTagPnNoIn,0.35,{colorPink,colorPurple,colorBlue3,colorOrange,colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & tagAc','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nTagPnNoIn_DRw)]);
text(6.5,-0.8,['n = ',num2str(nTagPnNoIn_noRw)]);

hCorrTag(9) = axes('Position',axpt(3,3,3,3,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrTagPnNoNo,xpt_corrTagPnNoNo,0.35,{colorPink,colorPurple,colorBlue3,colorOrange,colorPink,colorPurple,colorBlue3,colorOrange},[]);
title('PN & intraAc & tagAc','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nTagPnNoNo_DRw)]);
text(6.5,-0.8,['n = ',num2str(nTagPnNoNo_noRw)]);

set(hCorrTag,'YLim',[-1.2 1.2],'XLim',[0, 9],'XTick',[1,2,3,4,5,6,7,8],'XTickLabel',{'h x h','b x d', 'b x a', 'd x a','h x h','b x d', 'b x a', 'd x a'},'FontSize',fontM);
% set(hCorrTag,'YLim',[-1.2 1.2],'XLim',[0, 9],'XTick',[1,2,3,4,5,6,7,8],'XTickLabel',{'hf-hf(EO)','bf-du', 'bf-af', 'du-af','hf-hf','bf-du', 'bf-af', 'du-af'},'FontSize',fontM);
print(gcf,'-depsc','-r300',['PN_Rw_intra_tag_',num2str(intra_tag)]);