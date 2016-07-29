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

load('newT.mat')
tDRw = T;

% load()
% tNoRw = T;


pnDRw = tDRw.fr_task > 0.01 & tDRw.fr_task < 10;
npnDRw = sum(double(pnDRw));
inDRw = tDRw.fr_task > 10;
ninDRw = sum(double(inDRw));

intraPnAc = tDRw.lightPreSpk(pnDRw) < tDRw.lightSpk(pnDRw);
intraPnIn = tDRw.lightPreSpk(pnDRw) > tDRw.lightSpk(pnDRw);
intraPnNo = tDRw.lightPreSpk(pnDRw) == tDRw.lightSpk(pnDRw);

npnintraAc = sum(double(intraPnAc));
npnintraIn = sum(double(intraPnIn));
npnintraNo = sum(double(intraPnNo));

interPnAc = tDRw.psdPreSpk(pnDRw) < tDRw.lightSpk(pnDRw);
interPnIn = tDRw.psdPreSpk(pnDRw) > tDRw.lightSpk(pnDRw);
interPnNo = tDRw.psdPreSpk(pnDRw) == tDRw.lightSpk(pnDRw);

npninterAc = sum(double(interPnAc));
npninterIn = sum(double(interPnIn));
npninterNo = sum(double(interPnNo));

intraInAc = tDRw.lightPreSpk(inDRw) < tDRw.lightSpk(inDRw);
intraInIn = tDRw.lightPreSpk(inDRw) > tDRw.lightSpk(inDRw);
intraInNo = tDRw.lightPreSpk(inDRw) == tDRw.lightSpk(inDRw);

ninintraAc = sum(double(intraInAc));
ninintraIn = sum(double(intraInIn));
ninintraNo = sum(double(intraInNo));

interInAc = tDRw.psdPreSpk(inDRw) < tDRw.lightSpk(inDRw);
interInIn = tDRw.psdPreSpk(inDRw) > tDRw.lightSpk(inDRw);
interInNo = tDRw.psdPreSpk(inDRw) == tDRw.lightSpk(inDRw);

nininterAc = sum(double(interInAc));
nininterIn = sum(double(interInIn));
nininterNo = sum(double(interInNo));

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
ypt_pnintraAc = [tDRw.lightPreSpk(intraPnAc); tDRw.lightSpk(intraPnAc)];
ypt_pnintraIn = [tDRw.lightPreSpk(intraPnIn); tDRw.lightSpk(intraPnIn)];
ypt_pnintraNo = [tDRw.lightPreSpk(intraPnNo); tDRw.lightSpk(intraPnNo)];

%% Pyramidal neuron & inter
xpt_pninterAc = [ones(npninterAc,1); ones(npninterAc,1)*2];
xpt_pninterIn = [ones(npninterIn,1); ones(npninterIn,1)*2];
xpt_pninterNo = [ones(npninterNo,1); ones(npninterNo,1)*2];

ypt_pnpsdlighttotal = [tDRw.psdPreSpk(pnDRw); tDRw.lightSpk(pnDRw)];
ypt_pninterAc = [tDRw.psdPreSpk(interPnAc); tDRw.lightSpk(interPnAc)];
ypt_pninterIn = [tDRw.psdPreSpk(interPnIn); tDRw.lightSpk(interPnIn)];
ypt_pninterNo = [tDRw.psdPreSpk(interPnNo); tDRw.lightSpk(interPnNo)];

xpt_pn = {xpt_pnDRw; xpt_pnintraAc; xpt_pnintraIn; xpt_pnintraNo; 
          xpt_pnDRw; xpt_pninterAc; xpt_pninterIn; xpt_pninterNo};
ypt_pn = {ypt_pnlighttotal; ypt_pnintraAc; ypt_pnintraIn; ypt_pnintraNo;
          ypt_pnpsdlighttotal; ypt_pninterAc; ypt_pninterIn; ypt_pninterNo};
    
%% Interneuron & intra
xpt_inDRw = [ones(ninDRw,1); ones(ninDRw,1)*2];
xpt_inintraAc = [ones(ninintraAc,1); ones(ninintraAc,1)*2];
xpt_inintraIn = [ones(ninintraIn,1); ones(ninintraIn,1)*2];
xpt_inintraNo = [ones(ninintraNo,1); ones(ninintraNo,1)*2];

ypt_inlighttotal = [tDRw.lightPreSpk(inDRw); tDRw.lightSpk(inDRw)];
ypt_inintraAc = [tDRw.lightPreSpk(intraInAc); tDRw.lightSpk(intraInAc)];
ypt_inintraIn = [tDRw.lightPreSpk(intraInIn); tDRw.lightSpk(intraInIn)];
ypt_inintraNo = [tDRw.lightPreSpk(intraInNo); tDRw.lightSpk(intraInNo)];

%% Interneuron & inter
xpt_ininterAc = [ones(nininterAc,1); ones(nininterAc,1)*2];
xpt_ininterIn = [ones(nininterIn,1); ones(nininterIn,1)*2];
xpt_ininterNo = [ones(nininterNo,1); ones(nininterNo,1)*2];

ypt_pnpsdlighttotal = [tDRw.psdPreSpk(inDRw); tDRw.lightSpk(inDRw)];
ypt_ininterAc = [tDRw.psdPreSpk(interInAc); tDRw.lightSpk(interInAc)];
ypt_ininterIn = [tDRw.psdPreSpk(interInIn); tDRw.lightSpk(interInIn)];
ypt_ininterNo = [tDRw.psdPreSpk(interInNo); tDRw.lightSpk(interInNo)];

xpt_in = {xpt_inDRw; xpt_inintraAc; xpt_inintraIn; xpt_inintraNo;
          xpt_inDRw; xpt_ininterAc; xpt_ininterIn; xpt_ininterNo};
ypt_in = {ypt_inlighttotal; ypt_inintraAc; ypt_inintraIn; ypt_inintraNo;
          ypt_pnpsdlighttotal; ypt_ininterAc; ypt_ininterIn; ypt_ininterNo};

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
end

for iFigure = 5:8
    hPnLight(iFigure) = axes('Position',axpt(nCol,nRow,iFigure-4,3,fullAxis,wideInterval));
    hold on;
    MyScatterBarPlot(ypt_pn{iFigure},xpt_pn{iFigure},0.5,{colorGray,colorBlue},[]);
    title(ttl{iFigure},'FontSize',fontM);
end

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

