clf; clearvars;

fullAxis = [0.1 0.1 0.85 0.85];
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

markerS = 2.2;
markerM = 4.4;
markerL = 6.6;

nRow = 3;
nCol = 4;
%%

load('cellList_new.mat');
T((T.taskType == 'nolight'),:) = [];
T(~(T.taskProb == '100'),:) = [];

tDRw = T;

% load()
% tNoRw = T;

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

npnintraAc = sum(double(intraAc&pnDRw));
npnintraIn = sum(double(intraIn&pnDRw));
npnintraNo = sum(double(intraNo&pnDRw));

npninterAc = sum(double(interAc&pnDRw));
npninterIn = sum(double(interIn&pnDRw));
npninterNo = sum(double(interNo&pnDRw));

ninintraAc = sum(double(intraAc&inDRw));
ninintraIn = sum(double(intraIn&inDRw));
ninintraNo = sum(double(intraNo&inDRw));

nininterAc = sum(double(interAc&inDRw));
nininterIn = sum(double(interIn&inDRw));
nininterNo = sum(double(interNo&inDRw));

%% Population separation track(intra) vs track(inter)
subTbl_trXtr = [sum(double(pnDRw&intraAc&interAc)), sum(double(pnDRw&intraAc&interIn)), sum(double(pnDRw&intraAc&interNo));
            sum(double(pnDRw&intraIn&interAc)), sum(double(pnDRw&intraIn&interIn)), sum(double(pnDRw&intraIn&interNo));
            sum(double(pnDRw&intraNo&interAc)), sum(double(pnDRw&intraNo&interIn)), sum(double(pnDRw&intraNo&interNo))];

%% Population separation track vs tag
subTbl_trXtg = [sum(double(pnDRw&intraAc&tagAc)), sum(double(pnDRw&intraAc&tagIn)), sum(double(pnDRw&intraAc&tagNo));
            sum(double(pnDRw&intraIn&tagAc)), sum(double(pnDRw&intraIn&tagIn)), sum(double(pnDRw&intraIn&tagNo));
            sum(double(pnDRw&intraNo&tagAc)), sum(double(pnDRw&intraNo&tagIn)), sum(double(pnDRw&intraNo&tagNo))];
%% Pyramidal neuron & Intra session
% 1. total population distribution
% 2. light activated
% 3. light inhibited
% 4. no changes

xpt_pnDRw = [ones(npnDRw,1); ones(npnDRw,1)*2];
xpt_pnintraAc = [ones(npnintraAc,1); ones(npnintraAc,1)*2];
xpt_pnintraIn = [ones(npnintraIn,1); ones(npnintraIn,1)*2];
xpt_pnintraNo = [ones(npnintraNo,1); ones(npnintraNo,1)*2];

ypt_pnlighttotal = [tDRw.lightPreSpk(pnDRw); tDRw.lightSpk(pnDRw)];
ypt_pnintraAc = [tDRw.lightPreSpk(intraAc&pnDRw); tDRw.lightSpk(intraAc&pnDRw)];
ypt_pnintraIn = [tDRw.lightPreSpk(intraIn&pnDRw); tDRw.lightSpk(intraIn&pnDRw)];
ypt_pnintraNo = [tDRw.lightPreSpk(intraNo&pnDRw); tDRw.lightSpk(intraNo&pnDRw)];

%% Pyramidal neuron & inter
xpt_pninterAc = [ones(npninterAc,1); ones(npninterAc,1)*2];
xpt_pninterIn = [ones(npninterIn,1); ones(npninterIn,1)*2];
xpt_pninterNo = [ones(npninterNo,1); ones(npninterNo,1)*2];

ypt_pnpsdlighttotal = [tDRw.psdPreSpk(pnDRw); tDRw.lightSpk(pnDRw)];
ypt_pninterAc = [tDRw.psdPreSpk(interAc&pnDRw); tDRw.lightSpk(interAc&pnDRw)];
ypt_pninterIn = [tDRw.psdPreSpk(interIn&pnDRw); tDRw.lightSpk(interIn&pnDRw)];
ypt_pninterNo = [tDRw.psdPreSpk(interNo&pnDRw); tDRw.lightSpk(interNo&pnDRw)];

xpt_pn = {xpt_pnDRw; xpt_pnintraAc; xpt_pnintraIn; xpt_pnintraNo; 
          xpt_pnDRw; xpt_pninterAc; xpt_pninterIn; xpt_pninterNo};
ypt_pn = {ypt_pnlighttotal; ypt_pnintraAc; ypt_pnintraIn; ypt_pnintraNo;
          ypt_pnpsdlighttotal; ypt_pninterAc; ypt_pninterIn; ypt_pninterNo};
num_pn = {npnDRw;npnintraAc;npnintraIn;npnintraNo;npnDRw;npninterAc;npninterIn;npninterNo};    

%% Interneuron & intra
xpt_inDRw = [ones(ninDRw,1); ones(ninDRw,1)*2];
xpt_inintraAc = [ones(ninintraAc,1); ones(ninintraAc,1)*2];
xpt_inintraIn = [ones(ninintraIn,1); ones(ninintraIn,1)*2];
xpt_inintraNo = [ones(ninintraNo,1); ones(ninintraNo,1)*2];

ypt_inlighttotal = [tDRw.lightPreSpk(inDRw); tDRw.lightSpk(inDRw)];
ypt_inintraAc = [tDRw.lightPreSpk(intraAc&inDRw); tDRw.lightSpk(intraAc&inDRw)];
ypt_inintraIn = [tDRw.lightPreSpk(intraIn&inDRw); tDRw.lightSpk(intraIn&inDRw)];
ypt_inintraNo = [tDRw.lightPreSpk(intraNo&inDRw); tDRw.lightSpk(intraNo&inDRw)];

%% Interneuron & inter
xpt_ininterAc = [ones(nininterAc,1); ones(nininterAc,1)*2];
xpt_ininterIn = [ones(nininterIn,1); ones(nininterIn,1)*2];
xpt_ininterNo = [ones(nininterNo,1); ones(nininterNo,1)*2];

ypt_pnpsdlighttotal = [tDRw.psdPreSpk(inDRw); tDRw.lightSpk(inDRw)];
ypt_ininterAc = [tDRw.psdPreSpk(interAc&inDRw); tDRw.lightSpk(interAc&inDRw)];
ypt_ininterIn = [tDRw.psdPreSpk(interIn&inDRw); tDRw.lightSpk(interIn&inDRw)];
ypt_ininterNo = [tDRw.psdPreSpk(interNo&inDRw); tDRw.lightSpk(interNo&inDRw)];

xpt_in = {xpt_inDRw; xpt_inintraAc; xpt_inintraIn; xpt_inintraNo;
          xpt_inDRw; xpt_ininterAc; xpt_ininterIn; xpt_ininterNo};
ypt_in = {ypt_inlighttotal; ypt_inintraAc; ypt_inintraIn; ypt_inintraNo;
          ypt_pnpsdlighttotal; ypt_ininterAc; ypt_ininterIn; ypt_ininterNo};
num_in = {ninDRw;ninintraAc;ninintraIn;ninintraNo;ninDRw;nininterAc;nininterIn;nininterNo};
%%
ttl = {'In block (total)';'In block (Increase)';'In block (Decrease)';'In block (No change)';
       'Bwt block (total)';'Bwt block (Increase)';'Bwt block (Decrease)';'Bwt block (No change)'};
 
% Pre-stimulation / Stimulation comparision
figure(1)
for iFigure = 1:4
    hPnLight(iFigure) = axes('Position',axpt(nCol,nRow,iFigure,2,fullAxis,wideInterval));
    hold on;
    MyScatterBarPlot(ypt_pn{iFigure},xpt_pn{iFigure},0.5,{colorGray,colorBlue},[]);
    title(ttl{iFigure},'FontSize',fontM);
    text(2,max(ypt_pn{iFigure}-10),['n = ',num2str(num_pn{iFigure})]);
end

for iFigure = 5:8
    hPnLight(iFigure) = axes('Position',axpt(nCol,nRow,iFigure-4,3,fullAxis,wideInterval));
    hold on;
    MyScatterBarPlot(ypt_pn{iFigure},xpt_pn{iFigure},0.5,{colorGray,colorBlue},[]);
    title(ttl{iFigure},'FontSize',fontM);
    text(2,max(ypt_pn{iFigure}-10),['n = ',num2str(num_pn{iFigure})]);
end

set(hPnLight,'TickDir','out','Box','off'); 
print(gcf,'-dtiff','-r300','fig1_lightResponse');


figure(2)
% for iFigure = 1:4
%     hInLight(iFigure) = axes('Position',axpt(nCol,nRow,iFigure,4,fullAxis,wideInterval));
%     hold on;
%     MyScatterBarPlot(ypt_in{iFigure},xpt_in{iFigure},{colorGray,colorBlue},[]);
% end
% 
% for iFigure = 5:8
%     hInLight(iFigure) = axes('Position',axpt(nCol,nRow,iFigure-4,5,fullAxis,wideInterval));
%     hold on;
%     MyScatterBarPlot(ypt_in{iFIgure},xpt_in{iFigure},{colorGray,colorBlue},[]);
% end

