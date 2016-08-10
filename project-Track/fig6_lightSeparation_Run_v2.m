function fig6_lightSeparation_Run_V2(cutoff)
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
load(['cellList_new_',num2str(cutoff),'.mat']);
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

% Between block
nPnBtAc_DRun = sum(double(pnDRun&interAc_DRun));
nPnBtIn_DRun = sum(double(pnDRun&interIn_DRun));
nPnBtNo_DRun = sum(double(pnDRun&interNo_DRun));

% Inblock
nPnInAc_DRun = sum(double(pnDRun&intraAc_DRun));
nPnInIn_DRun = sum(double(pnDRun&intraIn_DRun));
nPnInNo_DRun = sum(double(pnDRun&intraNo_DRun));

% Tag
nPnTagAc_DRun = sum(double(pnDRun&tagAc_DRun));
nPnTagIn_DRun = sum(double(pnDRun&tagIn_DRun));
nPnTagNo_DRun = sum(double(pnDRun&tagNo_DRun));


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

% No light - Between
nPnBtAc_noRun = sum(double(pnnoRun&interAc_noRun));
nPnBtIn_noRun = sum(double(pnnoRun&interIn_noRun));
nPnBtNo_noRun = sum(double(pnnoRun&interNo_noRun));

% No light - Inblock
nPnInAc_noRun = sum(double(pnnoRun&intraAc_noRun));
nPnInIn_noRun = sum(double(pnnoRun&intraIn_noRun));
nPnInNo_noRun = sum(double(pnnoRun&intraNo_noRun));

% No light - Tag
nPnTagAc_noRun = sum(double(pnnoRun&tagAc_noRun));
nPnTagIn_noRun = sum(double(pnnoRun&tagIn_noRun));
nPnTagNo_noRun = sum(double(pnnoRun&tagNo_noRun));


% Between block (Inter: Bt)
xpt_corrPnBtAc = [ones(nPnBtAc_DRun,1);ones(nPnBtAc_noRun,1)*2;
                  ones(nPnBtAc_DRun,1)*3;ones(nPnBtAc_noRun,1)*4;
                  ones(nPnBtAc_DRun,1)*5;ones(nPnBtAc_noRun,1)*6;
                  ones(nPnBtAc_DRun,1)*7;ones(nPnBtAc_noRun,1)*8];
xpt_corrPnBtIn = [ones(nPnBtIn_DRun,1);ones(nPnBtIn_noRun,1)*2;
                  ones(nPnBtIn_DRun,1)*3;ones(nPnBtIn_noRun,1)*4;
                  ones(nPnBtIn_DRun,1)*5;ones(nPnBtIn_noRun,1)*6;
                  ones(nPnBtIn_DRun,1)*7;ones(nPnBtIn_noRun,1)*8];
xpt_corrPnBtNo = [ones(nPnBtNo_DRun,1);ones(nPnBtNo_noRun,1)*2;
                  ones(nPnBtNo_DRun,1)*3;ones(nPnBtNo_noRun,1)*4;
                  ones(nPnBtNo_DRun,1)*5;ones(nPnBtNo_noRun,1)*6;
                  ones(nPnBtNo_DRun,1)*7;ones(nPnBtNo_noRun,1)*8];

% Intra (In)
xpt_corrPnInAc = [ones(nPnInAc_DRun,1);ones(nPnInAc_noRun,1)*2;
                  ones(nPnInAc_DRun,1)*3;ones(nPnInAc_noRun,1)*4;
                  ones(nPnInAc_DRun,1)*5;ones(nPnInAc_noRun,1)*6;
                  ones(nPnInAc_DRun,1)*7;ones(nPnInAc_noRun,1)*8];
xpt_corrPnInIn = [ones(nPnInIn_DRun,1);ones(nPnInIn_noRun,1)*2;
                  ones(nPnInIn_DRun,1)*3;ones(nPnInIn_noRun,1)*4;
                  ones(nPnInIn_DRun,1)*5;ones(nPnInIn_noRun,1)*6;
                  ones(nPnInIn_DRun,1)*7;ones(nPnInIn_noRun,1)*8];
xpt_corrPnInNo = [ones(nPnInNo_DRun,1);ones(nPnInNo_noRun,1)*2;
                  ones(nPnInNo_DRun,1)*3;ones(nPnInNo_noRun,1)*4;
                  ones(nPnInNo_DRun,1)*5;ones(nPnInNo_noRun,1)*6;
                  ones(nPnInNo_DRun,1)*7;ones(nPnInNo_noRun,1)*8];
                
% Tag
xpt_corrPnTagAc = [ones(nPnTagAc_DRun,1);ones(nPnTagAc_noRun,1)*2;
                   ones(nPnTagAc_DRun,1)*3;ones(nPnTagAc_noRun,1)*4;
                   ones(nPnTagAc_DRun,1)*5;ones(nPnTagAc_noRun,1)*6;
                   ones(nPnTagAc_DRun,1)*7;ones(nPnTagAc_noRun,1)*8];
xpt_corrPnTagIn = [ones(nPnTagIn_DRun,1);ones(nPnTagIn_noRun,1)*2;
                   ones(nPnTagIn_DRun,1)*3;ones(nPnTagIn_noRun,1)*4;
                   ones(nPnTagIn_DRun,1)*5;ones(nPnTagIn_noRun,1)*6;
                   ones(nPnTagIn_DRun,1)*7;ones(nPnTagIn_noRun,1)*8];
xpt_corrPnTagNo = [ones(nPnTagNo_DRun,1);ones(nPnTagNo_noRun,1)*2;
                   ones(nPnTagNo_DRun,1)*3;ones(nPnTagNo_noRun,1)*4;
                   ones(nPnTagNo_DRun,1)*5;ones(nPnTagNo_noRun,1)*6;
                   ones(nPnTagNo_DRun,1)*7;ones(nPnTagNo_noRun,1)*8];

% Between block (inter: Bt)
ypt_corrPnBtAc = [tDRun.r_CorrEvOd(pnDRun&interAc_DRun); tnoRun.r_CorrEvOd(pnnoRun&interAc_noRun);
                  tDRun.r_Corrbfxdr(pnDRun&interAc_DRun); tnoRun.r_Corrbfxdr(pnnoRun&interAc_noRun);
                  tDRun.r_Corrdrxaft(pnDRun&interAc_DRun); tnoRun.r_Corrdrxaft(pnnoRun&interAc_noRun);
                  tDRun.r_Corrbfxaft(pnDRun&interAc_DRun); tnoRun.r_Corrbfxaft(pnnoRun&interAc_noRun)];
              
ypt_corrPnBtIn = [tDRun.r_CorrEvOd(pnDRun&interIn_DRun); tnoRun.r_Corrbfxdr(pnnoRun&interIn_noRun); 
                  tDRun.r_Corrbfxdr(pnDRun&interIn_DRun); tnoRun.r_Corrbfxdr(pnnoRun&interIn_noRun);...
                  tDRun.r_Corrdrxaft(pnDRun&interIn_DRun); tnoRun.r_Corrbfxdr(pnnoRun&interIn_noRun);
                  tDRun.r_Corrbfxaft(pnDRun&interIn_DRun); tnoRun.r_Corrbfxaft(pnnoRun&interIn_noRun)];
              
ypt_corrPnBtNo = [tDRun.r_CorrEvOd(pnDRun&interNo_DRun); tnoRun.r_CorrEvOd(pnnoRun&interNo_noRun); 
                  tDRun.r_Corrbfxdr(pnDRun&interNo_DRun); tnoRun.r_Corrbfxdr(pnnoRun&interNo_noRun);
                  tDRun.r_Corrdrxaft(pnDRun&interNo_DRun); tnoRun.r_Corrdrxaft(pnnoRun&interNo_noRun);
                  tDRun.r_Corrbfxaft(pnDRun&interNo_DRun); tnoRun.r_Corrbfxaft(pnnoRun&interNo_noRun)];

[~, pPnBtAc_hfxhf, ~, statsPnBtAc_hfxhf] = ttest2(tDRun.r_CorrEvOd(pnDRun&interAc_DRun), tnoRun.r_CorrEvOd(pnnoRun&interAc_noRun));
[~, pPnBtAc_bfxdr, ~, statsPnBtAc_bfxdr] = ttest2(tDRun.r_Corrbfxdr(pnDRun&interAc_DRun), tnoRun.r_Corrbfxdr(pnnoRun&interAc_noRun));
[~, pPnBtAc_drxaft, ~, statsPnBtAc_drxaft] = ttest2(tDRun.r_Corrdrxaft(pnDRun&interAc_DRun), tnoRun.r_Corrdrxaft(pnnoRun&interAc_noRun));
[~, pPnBtAc_bfxaft, ~, statsPnBtAc_bfxaft] = ttest2(tDRun.r_Corrbfxaft(pnDRun&interAc_DRun), tnoRun.r_Corrbfxaft(pnnoRun&interAc_noRun));

[~, pPnBtIn_hfxhf, ~, statsPnBtIn_hfxhf] = ttest2(tDRun.r_CorrEvOd(pnDRun&interIn_DRun), tnoRun.r_Corrbfxdr(pnnoRun&interIn_noRun));
[~, pPnBtIn_bfxdr, ~, statsPnBtIn_bfxdr] = ttest2(tDRun.r_Corrbfxdr(pnDRun&interIn_DRun), tnoRun.r_Corrbfxdr(pnnoRun&interIn_noRun));
[~, pPnBtIn_drxaft, ~, statsPnBtIn_drxaft] = ttest2(tDRun.r_Corrdrxaft(pnDRun&interIn_DRun), tnoRun.r_Corrbfxdr(pnnoRun&interIn_noRun));
[~, pPnBtIn_bfxaft, ~, statsPnBtIn_bfxaft] = ttest2(tDRun.r_Corrbfxaft(pnDRun&interIn_DRun), tnoRun.r_Corrbfxaft(pnnoRun&interIn_noRun));

[~, pPnBtNo_hfxhf, ~, statsPnBtNo_hfxhf] = ttest2(tDRun.r_CorrEvOd(pnDRun&interNo_DRun), tnoRun.r_CorrEvOd(pnnoRun&interNo_noRun));
[~, pPnBtNo_bfxdr, ~, statsPnBtNo_bfxdr] = ttest2(tDRun.r_Corrbfxdr(pnDRun&interNo_DRun), tnoRun.r_Corrbfxdr(pnnoRun&interNo_noRun));
[~, pPnBtNo_drxaft, ~, statsPnBtNo_drxaft] = ttest2(tDRun.r_Corrdrxaft(pnDRun&interNo_DRun), tnoRun.r_Corrdrxaft(pnnoRun&interNo_noRun));
[~, pPnBtNo_bfxaft, ~, statsPnBtNo_bfxaft] = ttest2(tDRun.r_Corrbfxaft(pnDRun&interNo_DRun), tnoRun.r_Corrbfxaft(pnnoRun&interNo_noRun));

% Inblock (intra: In)
ypt_corrPnInAc = [tDRun.r_CorrEvOd(pnDRun&intraAc_DRun); tnoRun.r_CorrEvOd(pnnoRun&intraAc_noRun);
                  tDRun.r_Corrbfxdr(pnDRun&intraAc_DRun); tnoRun.r_Corrbfxdr(pnnoRun&intraAc_noRun);
                  tDRun.r_Corrdrxaft(pnDRun&intraAc_DRun); tnoRun.r_Corrdrxaft(pnnoRun&intraAc_noRun);
                  tDRun.r_Corrbfxaft(pnDRun&intraAc_DRun); tnoRun.r_Corrbfxaft(pnnoRun&intraAc_noRun)];
              
ypt_corrPnInIn = [tDRun.r_CorrEvOd(pnDRun&intraIn_DRun); tnoRun.r_CorrEvOd(pnnoRun&intraIn_noRun); 
                  tDRun.r_Corrbfxdr(pnDRun&intraIn_DRun); tnoRun.r_Corrbfxdr(pnnoRun&intraIn_noRun);...
                  tDRun.r_Corrdrxaft(pnDRun&intraIn_DRun); tnoRun.r_Corrdrxaft(pnnoRun&intraIn_noRun);
                  tDRun.r_Corrbfxaft(pnDRun&intraIn_DRun); tnoRun.r_Corrbfxaft(pnnoRun&intraIn_noRun)];
              
ypt_corrPnInNo = [tDRun.r_CorrEvOd(pnDRun&intraNo_DRun); tnoRun.r_CorrEvOd(pnnoRun&intraNo_noRun); 
                  tDRun.r_Corrbfxdr(pnDRun&intraNo_DRun); tnoRun.r_Corrbfxdr(pnnoRun&intraNo_noRun);
                  tDRun.r_Corrdrxaft(pnDRun&intraNo_DRun); tnoRun.r_Corrdrxaft(pnnoRun&intraNo_noRun);
                  tDRun.r_Corrbfxaft(pnDRun&intraNo_DRun); tnoRun.r_Corrbfxaft(pnnoRun&intraNo_noRun)];

[~, pPnInAc_hfxhf, ~, statsPnInAc_hfxhf] = ttest2(tDRun.r_CorrEvOd(pnDRun&intraAc_DRun), tnoRun.r_CorrEvOd(pnnoRun&interAc_noRun));
[~, pPnInAc_bfxdr, ~, statsPnInAc_bfxdr] = ttest2(tDRun.r_Corrbfxdr(pnDRun&intraAc_DRun), tnoRun.r_Corrbfxdr(pnnoRun&interAc_noRun));
[~, pPnInAc_drxaft, ~, statsPnInAc_drxaft] = ttest2(tDRun.r_Corrdrxaft(pnDRun&intraAc_DRun), tnoRun.r_Corrdrxaft(pnnoRun&interAc_noRun));
[~, pPnInAc_bfxaft, ~, statsPnInAc_bfxaft] = ttest2(tDRun.r_Corrbfxaft(pnDRun&intraAc_DRun), tnoRun.r_Corrbfxaft(pnnoRun&interAc_noRun));

[~, pPnInIn_hfxhf, ~, statsPnInIn_hfxhf] = ttest2(tDRun.r_CorrEvOd(pnDRun&intraIn_DRun), tnoRun.r_CorrEvOd(pnnoRun&interIn_noRun));
[~, pPnInIn_bfxdr, ~, statsPnInIn_bfxdr] = ttest2(tDRun.r_Corrbfxdr(pnDRun&intraIn_DRun), tnoRun.r_Corrbfxdr(pnnoRun&interIn_noRun));
[~, pPnInIn_drxaft, ~, statsPnInIn_drxaft] = ttest2(tDRun.r_Corrdrxaft(pnDRun&intraIn_DRun), tnoRun.r_Corrdrxaft(pnnoRun&interIn_noRun));
[~, pPnInIn_bfxaft, ~, statsPnInIn_bfxaft] = ttest2(tDRun.r_Corrbfxaft(pnDRun&intraIn_DRun), tnoRun.r_Corrbfxaft(pnnoRun&interIn_noRun));

[~, pPnInNo_hfxhf, ~, statsPnInNo_hfxhf] = ttest2(tDRun.r_CorrEvOd(pnDRun&intraNo_DRun), tnoRun.r_CorrEvOd(pnnoRun&interNo_noRun));
[~, pPnInNo_bfxdr, ~, statsPnInNo_bfxdr] = ttest2(tDRun.r_Corrbfxdr(pnDRun&intraNo_DRun), tnoRun.r_Corrbfxdr(pnnoRun&interNo_noRun));
[~, pPnInNo_drxaft, ~, statsPnInNo_drxaft] = ttest2(tDRun.r_Corrdrxaft(pnDRun&intraNo_DRun), tnoRun.r_Corrdrxaft(pnnoRun&interNo_noRun));
[~, pPnInNo_bfxaft, ~, statsPnInNo_bfxaft] = ttest2(tDRun.r_Corrbfxaft(pnDRun&intraNo_DRun), tnoRun.r_Corrbfxaft(pnnoRun&interNo_noRun));

% Tag (tag)
ypt_corrPnTagAc = [tDRun.r_CorrEvOd(pnDRun&tagAc_DRun); tnoRun.r_CorrEvOd(pnnoRun&tagAc_noRun);
                  tDRun.r_Corrbfxdr(pnDRun&tagAc_DRun); tnoRun.r_Corrbfxdr(pnnoRun&tagAc_noRun);
                  tDRun.r_Corrdrxaft(pnDRun&tagAc_DRun); tnoRun.r_Corrdrxaft(pnnoRun&tagAc_noRun);
                  tDRun.r_Corrbfxaft(pnDRun&tagAc_DRun); tnoRun.r_Corrbfxaft(pnnoRun&tagAc_noRun)];
              
ypt_corrPnTagIn = [tDRun.r_CorrEvOd(pnDRun&tagIn_DRun); tnoRun.r_CorrEvOd(pnnoRun&tagIn_noRun); 
                  tDRun.r_Corrbfxdr(pnDRun&tagIn_DRun); tnoRun.r_Corrbfxdr(pnnoRun&tagIn_noRun);...
                  tDRun.r_Corrdrxaft(pnDRun&tagIn_DRun); tnoRun.r_Corrdrxaft(pnnoRun&tagIn_noRun);
                  tDRun.r_Corrbfxaft(pnDRun&tagIn_DRun); tnoRun.r_Corrbfxaft(pnnoRun&tagIn_noRun)];
              
ypt_corrPnTagNo = [tDRun.r_CorrEvOd(pnDRun&tagNo_DRun); tnoRun.r_CorrEvOd(pnnoRun&tagNo_noRun); 
                  tDRun.r_Corrbfxdr(pnDRun&tagNo_DRun); tnoRun.r_Corrbfxdr(pnnoRun&tagNo_noRun);
                  tDRun.r_Corrdrxaft(pnDRun&tagNo_DRun); tnoRun.r_Corrdrxaft(pnnoRun&tagNo_noRun);
                  tDRun.r_Corrbfxaft(pnDRun&tagNo_DRun); tnoRun.r_Corrbfxaft(pnnoRun&tagNo_noRun)];
             
% t-test
[~, psPnTagAc_hfxhf, ~, statsPnTagAc_hfxhf] = ttest2(tDRun.r_CorrEvOd(pnDRun&tagAc_DRun), tnoRun.r_CorrEvOd(pnnoRun&tagAc_noRun));
[~, pPnTagAc_bfxdr, ~, statsPnTagAc_bfxdr] = ttest2(tDRun.r_Corrbfxdr(pnDRun&tagAc_DRun), tnoRun.r_Corrbfxdr(pnnoRun&tagAc_noRun));
[~, pPnTagAc_drxaft, ~, statsPnTagAc_drxaft] = ttest2(tDRun.r_Corrdrxaft(pnDRun&tagAc_DRun), tnoRun.r_Corrdrxaft(pnnoRun&tagAc_noRun));
[~, pPnTagAc_bfxaft, ~, statsPnTagAc_bfxaft] = ttest2(tDRun.r_Corrbfxaft(pnDRun&tagAc_DRun), tnoRun.r_Corrbfxaft(pnnoRun&tagAc_noRun));

[~, pPnTagIn_hfxhf, ~, statsPnTagIn_hfxhf] = ttest2(tDRun.r_CorrEvOd(pnDRun&tagIn_DRun), tnoRun.r_CorrEvOd(pnnoRun&tagIn_noRun));
[~, pPnTagIn_bfxdr, ~, statsPnTagIn_bfxdr] = ttest2(tDRun.r_Corrbfxdr(pnDRun&tagIn_DRun), tnoRun.r_Corrbfxdr(pnnoRun&tagIn_noRun));
[~, pPnTagIn_drxaft, ~, statsPnTagIn_drxaft] = ttest2(tDRun.r_Corrdrxaft(pnDRun&tagIn_DRun), tnoRun.r_Corrdrxaft(pnnoRun&tagIn_noRun));
[~, pPnTagIn_bfxaft, ~, statsPnTagIn_bfxaft] = ttest2(tDRun.r_Corrbfxaft(pnDRun&tagIn_DRun), tnoRun.r_Corrbfxaft(pnnoRun&tagIn_noRun));

[~, pPnTagNo_hfxhf, ~, statsPnTagNo_hfxhf] = ttest2(tDRun.r_CorrEvOd(pnDRun&tagNo_DRun), tnoRun.r_CorrEvOd(pnnoRun&tagNo_noRun));
[~, pPnTagNo_bfxdr, ~, statsPnTagNo_bfxdr] = ttest2(tDRun.r_Corrbfxdr(pnDRun&tagNo_DRun), tnoRun.r_Corrbfxdr(pnnoRun&tagNo_noRun));
[~, pPnTagNo_drxaft, ~, statsPnTagNo_drxaft] = ttest2(tDRun.r_Corrdrxaft(pnDRun&tagNo_DRun), tnoRun.r_Corrdrxaft(pnnoRun&tagNo_noRun));
[~, pPnTagNo_bfxaft, ~, statsPnTagNo_bfxaft] = ttest2(tDRun.r_Corrbfxaft(pnDRun&tagNo_DRun), tnoRun.r_Corrbfxaft(pnnoRun&tagNo_noRun));

 
figure(1)
hCorrBt(1) = axes('Position',axpt(3,1,1,1,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrPnBtAc,xpt_corrPnBtAc,0.35,{colorDarkRed4,colorLightRed4,colorDarkBlue4,colorLightBlue4,colorDarkOrange4,colorLightOrange4,colorDarkGreen4,colorLightGreen4},[]);
title('PN & Between block Activation','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nPnBtAc_DRun)]);
text(6.5,-0.8,['n = ',num2str(nPnBtAc_noRun)]);

hCorrBt(2) = axes('Position',axpt(3,1,2,1,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrPnBtIn,xpt_corrPnBtIn,0.35,{colorDarkRed4,colorLightRed4,colorDarkBlue4,colorLightBlue4,colorDarkOrange4,colorLightOrange4,colorDarkGreen4,colorLightGreen4},[]);
title('PN & Between block Inactivation','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nPnBtIn_DRun)]);
text(6.5,-0.8,['n = ',num2str(nPnBtIn_noRun)]);

hCorrBt(3) = axes('Position',axpt(3,1,3,1,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrPnBtNo,xpt_corrPnBtNo,0.35,{colorDarkRed4,colorLightRed4,colorDarkBlue4,colorLightBlue4,colorDarkOrange4,colorLightOrange4,colorDarkGreen4,colorLightGreen4},[]);
title('PN & Between block No-change','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nPnBtNo_DRun)]);
text(6.5,-0.8,['n = ',num2str(nPnBtNo_noRun)]);
set(hCorrBt,'YLim',[-1.2 1.2],'XLim',[0, 9],'XTick',[1.5,3.5,5.5,7.5],'XTickLabel',{'hf-hf(EO)','bf-du', 'bf-af', 'du-af'},'FontSize',fontM);
print(gcf,'-depsc','-r300',['PN_Run_Bt_',num2str(cutoff),'_EvOd'])

figure(2)
hCorrIn(1) = axes('Position',axpt(3,1,1,1,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrPnInAc,xpt_corrPnInAc,0.35,{colorDarkRed4,colorLightRed4,colorDarkBlue4,colorLightBlue4,colorDarkOrange4,colorLightOrange4,colorDarkGreen4,colorLightGreen4},[]);
title('PN & Inblock Activation','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nPnInAc_DRun)]);
text(6.5,-0.8,['n = ',num2str(nPnInAc_noRun)]);

hCorrIn(2) = axes('Position',axpt(3,1,2,1,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrPnInIn,xpt_corrPnInIn,0.35,{colorDarkRed4,colorLightRed4,colorDarkBlue4,colorLightBlue4,colorDarkOrange4,colorLightOrange4,colorDarkGreen4,colorLightGreen4},[]);
title('PN & Inblock Inactivation','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nPnInIn_DRun)]);
text(6.5,-0.8,['n = ',num2str(nPnInIn_noRun)]);

hCorrIn(3) = axes('Position',axpt(3,1,3,1,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrPnInNo,xpt_corrPnInNo,0.35,{colorDarkRed4,colorLightRed4,colorDarkBlue4,colorLightBlue4,colorDarkOrange4,colorLightOrange4,colorDarkGreen4,colorLightGreen4},[]);
title('PN & Inblock No-change','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nPnInNo_DRun)]);
text(6.5,-0.8,['n = ',num2str(nPnInNo_noRun)]);

set(hCorrIn,'YLim',[-1.2 1.2],'XLim',[0, 9],'XTick',[1.5,3.5,5.5,7.5],'XTickLabel',{'hf-hf(EO)','bf-du', 'bf-af', 'du-af'},'FontSize',fontM);
print(gcf,'-depsc','-r300',['PN_Run_In_',num2str(cutoff),'_EvOd'])

figure(3)
hCorrTag(1) = axes('Position',axpt(3,1,1,1,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrPnTagAc,xpt_corrPnTagAc,0.35,{colorDarkRed4,colorLightRed4,colorDarkBlue4,colorLightBlue4,colorDarkOrange4,colorLightOrange4,colorDarkGreen4,colorLightGreen4},[]);
title('PN & Baseline Activation','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nPnTagAc_DRun)]);
text(6.5,-0.8,['n = ',num2str(nPnTagAc_noRun)]);

hCorrTag(2) = axes('Position',axpt(3,1,2,1,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrPnTagIn,xpt_corrPnTagIn,0.35,{colorDarkRed4,colorLightRed4,colorDarkBlue4,colorLightBlue4,colorDarkOrange4,colorLightOrange4,colorDarkGreen4,colorLightGreen4},[]);
title('PN & Baseline inactivation','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nPnTagIn_DRun)]);
text(6.5,-0.8,['n = ',num2str(nPnTagIn_noRun)]);

hCorrTag(3) = axes('Position',axpt(3,1,3,1,[0.1, 0.1, 0.85, 0.85], wideInterval));
hold on;
MyScatterBarPlot(ypt_corrPnTagNo,xpt_corrPnTagNo,0.35,{colorDarkRed4,colorLightRed4,colorDarkBlue4,colorLightBlue4,colorDarkOrange4,colorLightOrange4,colorDarkGreen4,colorLightGreen4},[]);
title('PN & Baseline no-change','FontSize',fontL);
text(2.5,-0.8,['n = ',num2str(nPnTagNo_DRun)]);
text(6.5,-0.8,['n = ',num2str(nPnTagNo_noRun)]);

set(hCorrTag,'YLim',[-1.2 1.2],'XLim',[0, 9],'XTick',[1.5,3.5,5.5,7.5],'XTickLabel',{'hf-hf(EO)','bf-du', 'bf-af', 'du-af'},'FontSize',fontM);
print(gcf,'-depsc','-r300',['PN_Run_Base_',num2str(cutoff),'_EvOd'])

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