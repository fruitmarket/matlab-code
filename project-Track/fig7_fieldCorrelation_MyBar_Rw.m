% clearvars;
clf; close all;

cutoff = 100;

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

markerS = 2.2;
markerM = 4.4;
markerL = 6.6;

%
load(['cellList_new_',num2str(cutoff),'.mat']);
T((T.taskType == 'nolight'),:) = [];
T(~(T.taskProb == '100'),:) = [];

tDRw = T;
tnoRw = T;

tDRw(~(tDRw.taskType == 'DRw'),:) = [];
tnoRw(~(tnoRw.taskType == 'noRw'),:) = [];

pnDRw = tDRw.fr_task >0  & tDRw.fr_task < 10;
% npnDRw = sum(double(pn));
inDRw = tDRw.fr_task > 10;
% ninDRw = sum(double(inDRw));

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


% no light during run
pnnoRw = tnoRw.fr_task > 0 & tnoRw.fr_task < 10;
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

% Between block
ypt_corrPnBtAcMean = [mean(tDRw.r_CorrEvOd(pnDRw&interAc_DRw)), mean(tnoRw.r_CorrEvOd(pnnoRw&interAc_noRw));
                  mean(tDRw.r_Corrbfxdr(pnDRw&interAc_DRw)), mean(tnoRw.r_Corrbfxdr(pnnoRw&interAc_noRw));
                  mean(tDRw.r_Corrdrxaft(pnDRw&interAc_DRw)), mean(tnoRw.r_Corrdrxaft(pnnoRw&interAc_noRw));
                  mean(tDRw.r_Corrbfxaft(pnDRw&interAc_DRw)), mean(tnoRw.r_Corrbfxaft(pnnoRw&interAc_noRw))];
              
ypt_corrPnBtInMean = [mean(tDRw.r_CorrEvOd(pnDRw&interIn_DRw)), mean(tnoRw.r_Corrbfxdr(pnnoRw&interIn_noRw)); 
                  mean(tDRw.r_Corrbfxdr(pnDRw&interIn_DRw)), mean(tnoRw.r_Corrbfxdr(pnnoRw&interIn_noRw));
                  mean(tDRw.r_Corrdrxaft(pnDRw&interIn_DRw)), mean(tnoRw.r_Corrbfxdr(pnnoRw&interIn_noRw));
                  mean(tDRw.r_Corrbfxaft(pnDRw&interIn_DRw)), mean(tnoRw.r_Corrbfxaft(pnnoRw&interIn_noRw))];
              
ypt_corrPnBtNoMean = [mean(tDRw.r_CorrEvOd(pnDRw&interNo_DRw)), mean(tnoRw.r_CorrEvOd(pnnoRw&interNo_noRw)); 
                  mean(tDRw.r_Corrbfxdr(pnDRw&interNo_DRw)), mean(tnoRw.r_Corrbfxdr(pnnoRw&interNo_noRw));
                  mean(tDRw.r_Corrdrxaft(pnDRw&interNo_DRw)), mean(tnoRw.r_Corrdrxaft(pnnoRw&interNo_noRw));
                  mean(tDRw.r_Corrbfxaft(pnDRw&interNo_DRw)), mean(tnoRw.r_Corrbfxaft(pnnoRw&interNo_noRw))];
% Inblock (intra: In)
ypt_corrPnInAcMean = [mean(tDRw.r_CorrEvOd(pnDRw&intraAc_DRw)), mean(tnoRw.r_CorrEvOd(pnnoRw&intraAc_noRw));
                  mean(tDRw.r_Corrbfxdr(pnDRw&intraAc_DRw)), mean(tnoRw.r_Corrbfxdr(pnnoRw&intraAc_noRw));
                  mean(tDRw.r_Corrdrxaft(pnDRw&intraAc_DRw)), mean(tnoRw.r_Corrdrxaft(pnnoRw&intraAc_noRw));
                  mean(tDRw.r_Corrbfxaft(pnDRw&intraAc_DRw)), mean(tnoRw.r_Corrbfxaft(pnnoRw&intraAc_noRw))];
              
ypt_corrPnInInMean = [mean(tDRw.r_CorrEvOd(pnDRw&intraIn_DR)), mean(tnoRw.r_CorrEvOd(pnnoRw&intraIn_noRw)); 
                  mean(tDRw.r_Corrbfxdr(pnDRw&intraIn_DR)), mean(tnoRw.r_Corrbfxdr(pnnoRw&intraIn_noRw));
                  mean(tDRw.r_Corrdrxaft(pnDRw&intraIn_DR)), mean(tnoRw.r_Corrdrxaft(pnnoRw&intraIn_noRw));
                  mean(tDRw.r_Corrbfxaft(pnDRw&intraIn_DR)), mean(tnoRw.r_Corrbfxaft(pnnoRw&intraIn_noRw))];
              
ypt_corrPnInNoMean = [mean(tDRw.r_CorrEvOd(pnDRw&intraNo_DR)), mean(tnoRw.r_CorrEvOd(pnnoRw&intraNo_noRw)); 
                  mean(tDRw.r_Corrbfxdr(pnDRw&intraNo_DR)), mean(tnoRw.r_Corrbfxdr(pnnoRw&intraNo_noRw));
                  mean(tDRw.r_Corrdrxaft(pnDRw&intraNo_DR)), mean(tnoRw.r_Corrdrxaft(pnnoRw&intraNo_noRw));
                  mean(tDRw.r_Corrbfxaft(pnDRw&intraNo_DR)), mean(tnoRw.r_Corrbfxaft(pnnoRw&intraNo_noRw))];
% Tag (tag)
ypt_corrPnTagAcMean = [mean(tDRw.r_CorrEvOd(pnDRw&tagAc_DRw)), mean(tnoRw.r_CorrEvOd(pnnoRw&tagAc_noRw));
                  mean(tDRw.r_Corrbfxdr(pnDRw&tagAc_DRw)), mean(tnoRw.r_Corrbfxdr(pnnoRw&tagAc_noRw));
                  mean(tDRw.r_Corrdrxaft(pnDRw&tagAc_DRw)), mean(tnoRw.r_Corrdrxaft(pnnoRw&tagAc_noRw));
                  mean(tDRw.r_Corrbfxaft(pnDRw&tagAc_DRw)), mean(tnoRw.r_Corrbfxaft(pnnoRw&tagAc_noRw))];
              
ypt_corrPnTagInMean = [mean(tDRw.r_CorrEvOd(pnDRw&tagIn_DRw)), mean(tnoRw.r_CorrEvOd(pnnoRw&tagIn_noRw)); 
                  mean(tDRw.r_Corrbfxdr(pnDRw&tagIn_DRw)), mean(tnoRw.r_Corrbfxdr(pnnoRw&tagIn_noRw));...
                  mean(tDRw.r_Corrdrxaft(pnDRw&tagIn_DRw)), mean(tnoRw.r_Corrdrxaft(pnnoRw&tagIn_noRw));
                  mean(tDRw.r_Corrbfxaft(pnDRw&tagIn_DRw)), mean(tnoRw.r_Corrbfxaft(pnnoRw&tagIn_noRw))];
              
ypt_corrPnTagNoMean = [mean(tDRw.r_CorrEvOd(pnDRw&tagNo_DRw)), mean(tnoRw.r_CorrEvOd(pnnoRw&tagNo_noRw)); 
                  mean(tDRw.r_Corrbfxdr(pnDRw&tagNo_DRw)), mean(tnoRw.r_Corrbfxdr(pnnoRw&tagNo_noRw));
                  mean(tDRw.r_Corrdrxaft(pnDRw&tagNo_DRw)), mean(tnoRw.r_Corrdrxaft(pnnoRw&tagNo_noRw));
                  mean(tDRw.r_Corrbfxaft(pnDRw&tagNo_DRw)), mean(tnoRw.r_Corrbfxaft(pnnoRw&tagNo_noRw))];
              
ypt_corrPnBtAcStd = [std(tDRw.r_CorrEvOd(pnDRw&interAc_DRw))/nPnBtAc_DRw, std(tnoRw.r_CorrEvOd(pnnoRw&interAc_noRw))/nPnBtAc_noRw;
                  std(tDRw.r_Corrbfxdr(pnDRw&interAc_DRw))/nPnBtAc_DRw, std(tnoRw.r_Corrbfxdr(pnnoRw&interAc_noRw))/nPnBtAc_noRw;
                  std(tDRw.r_Corrdrxaft(pnDRw&interAc_DRw))/nPnBtAc_DRw, std(tnoRw.r_Corrdrxaft(pnnoRw&interAc_noRw))/nPnBtAc_noRw;
                  std(tDRw.r_Corrbfxaft(pnDRw&interAc_DRw))/nPnBtAc_DRw, std(tnoRw.r_Corrbfxaft(pnnoRw&interAc_noRw))/nPnBtAc_noRw];
              
ypt_corrPnBtInStd = [std(tDRw.r_CorrEvOd(pnDRw&interIn_DRw))/nPnBtIn_DRw, std(tnoRw.r_Corrbfxdr(pnnoRw&interIn_noRw))/nPnBtIn_noRw; 
                  std(tDRw.r_Corrbfxdr(pnDRw&interIn_DRw))/nPnBtIn_DRw, std(tnoRw.r_Corrbfxdr(pnnoRw&interIn_noRw))/nPnBtIn_noRw;
                  std(tDRw.r_Corrdrxaft(pnDRw&interIn_DRw))/nPnBtIn_DRw, std(tnoRw.r_Corrbfxdr(pnnoRw&interIn_noRw))/nPnBtIn_noRw;
                  std(tDRw.r_Corrbfxaft(pnDRw&interIn_DRw))/nPnBtIn_DRw, std(tnoRw.r_Corrbfxaft(pnnoRw&interIn_noRw))/nPnBtIn_noRw];
              
ypt_corrPnBtNoStd = [std(tDRw.r_CorrEvOd(pnDRw&interNo_DRw))/nPnBtNo_DRw, std(tnoRw.r_CorrEvOd(pnnoRw&interNo_noRw))/nPnBtNo_noRw; 
                  std(tDRw.r_Corrbfxdr(pnDRw&interNo_DRw))/nPnBtNo_DRw, std(tnoRw.r_Corrbfxdr(pnnoRw&interNo_noRw))/nPnBtNo_noRw;
                  std(tDRw.r_Corrdrxaft(pnDRw&interNo_DRw))/nPnBtNo_DRw, std(tnoRw.r_Corrdrxaft(pnnoRw&interNo_noRw))/nPnBtNo_noRw;
                  std(tDRw.r_Corrbfxaft(pnDRw&interNo_DRw))/nPnBtNo_DRw, std(tnoRw.r_Corrbfxaft(pnnoRw&interNo_noRw))/nPnBtNo_noRw];
              
ypt_corrPnInAcStd = [std(tDRw.r_CorrEvOd(pnDRw&intraAc_DRw))/nPnInAc_DRw, std(tnoRw.r_CorrEvOd(pnnoRw&intraAc_noRw))/nPnInAc_noRw;
                  std(tDRw.r_Corrbfxdr(pnDRw&intraAc_DRw))/nPnInAc_DRw, std(tnoRw.r_Corrbfxdr(pnnoRw&intraAc_noRw))/nPnInAc_noRw;
                  std(tDRw.r_Corrdrxaft(pnDRw&intraAc_DRw))/nPnInAc_DRw, std(tnoRw.r_Corrdrxaft(pnnoRw&intraAc_noRw))/nPnInAc_noRw;
                  std(tDRw.r_Corrbfxaft(pnDRw&intraAc_DRw))/nPnInAc_DRw, std(tnoRw.r_Corrbfxaft(pnnoRw&intraAc_noRw))/nPnInAc_noRw];
              
ypt_corrPnInInStd = [std(tDRw.r_CorrEvOd(pnDRw&intraIn_DR))/nPnInIn_DRw, std(tnoRw.r_CorrEvOd(pnnoRw&intraIn_noRw))/nPnInIn_noRw; 
                  std(tDRw.r_Corrbfxdr(pnDRw&intraIn_DR))/nPnInIn_DRw, std(tnoRw.r_Corrbfxdr(pnnoRw&intraIn_noRw))/nPnInIn_noRw;
                  std(tDRw.r_Corrdrxaft(pnDRw&intraIn_DR))/nPnInIn_DRw, std(tnoRw.r_Corrdrxaft(pnnoRw&intraIn_noRw))/nPnInIn_noRw;
                  std(tDRw.r_Corrbfxaft(pnDRw&intraIn_DR))/nPnInIn_DRw, std(tnoRw.r_Corrbfxaft(pnnoRw&intraIn_noRw))/nPnInIn_noRw];
              
ypt_corrPnInNoStd = [std(tDRw.r_CorrEvOd(pnDRw&intraNo_DR))/nPnInNo_DRw, std(tnoRw.r_CorrEvOd(pnnoRw&intraNo_noRw))/nPnInNo_noRw; 
                  std(tDRw.r_Corrbfxdr(pnDRw&intraNo_DR))/nPnInNo_DRw, std(tnoRw.r_Corrbfxdr(pnnoRw&intraNo_noRw))/nPnInNo_noRw;
                  std(tDRw.r_Corrdrxaft(pnDRw&intraNo_DR))/nPnInNo_DRw, std(tnoRw.r_Corrdrxaft(pnnoRw&intraNo_noRw))/nPnInNo_noRw;
                  std(tDRw.r_Corrbfxaft(pnDRw&intraNo_DR))/nPnInNo_DRw, std(tnoRw.r_Corrbfxaft(pnnoRw&intraNo_noRw))/nPnInNo_noRw];
% Tag (tag)
ypt_corrPnTagAcStd = [std(tDRw.r_CorrEvOd(pnDRw&tagAc_DRw))/nPnTagAc_DRw, std(tnoRw.r_CorrEvOd(pnnoRw&tagAc_noRw))/nPnTagAc_noRw;
                  std(tDRw.r_Corrbfxdr(pnDRw&tagAc_DRw))/nPnTagAc_DRw, std(tnoRw.r_Corrbfxdr(pnnoRw&tagAc_noRw))/nPnTagAc_noRw;
                  std(tDRw.r_Corrdrxaft(pnDRw&tagAc_DRw))/nPnTagAc_DRw, std(tnoRw.r_Corrdrxaft(pnnoRw&tagAc_noRw))/nPnTagAc_noRw;
                  std(tDRw.r_Corrbfxaft(pnDRw&tagAc_DRw))/nPnTagAc_DRw, std(tnoRw.r_Corrbfxaft(pnnoRw&tagAc_noRw))/nPnTagAc_noRw];
              
ypt_corrPnTagInStd = [std(tDRw.r_CorrEvOd(pnDRw&tagIn_DRw))/nPnTagIn_DRw, std(tnoRw.r_CorrEvOd(pnnoRw&tagIn_noRw))/nPnTagIn_noRw; 
                  std(tDRw.r_Corrbfxdr(pnDRw&tagIn_DRw))/nPnTagIn_DRw, std(tnoRw.r_Corrbfxdr(pnnoRw&tagIn_noRw))/nPnTagIn_noRw;
                  std(tDRw.r_Corrdrxaft(pnDRw&tagIn_DRw))/nPnTagIn_DRw, std(tnoRw.r_Corrdrxaft(pnnoRw&tagIn_noRw))/nPnTagIn_noRw;
                  std(tDRw.r_Corrbfxaft(pnDRw&tagIn_DRw))/nPnTagIn_DRw, std(tnoRw.r_Corrbfxaft(pnnoRw&tagIn_noRw))/nPnTagIn_noRw];
              
ypt_corrPnTagNoStd = [std(tDRw.r_CorrEvOd(pnDRw&tagNo_DRw))/nPnTagNo_DRw, std(tnoRw.r_CorrEvOd(pnnoRw&tagNo_noRw))/nPnTagNo_noRw; 
                  std(tDRw.r_Corrbfxdr(pnDRw&tagNo_DRw))/nPnTagNo_DRw, std(tnoRw.r_Corrbfxdr(pnnoRw&tagNo_noRw))/nPnTagNo_noRw;
                  std(tDRw.r_Corrdrxaft(pnDRw&tagNo_DRw))/nPnTagNo_DRw, std(tnoRw.r_Corrdrxaft(pnnoRw&tagNo_noRw))/nPnTagNo_noRw;
                  std(tDRw.r_Corrbfxaft(pnDRw&tagNo_DRw))/nPnTagNo_DRw, std(tnoRw.r_Corrbfxaft(pnnoRw&tagNo_noRw))/nPnTagNo_noRw];

%%
figure(1)
hBarBt(1) = axes('Position',axpt(3,2,1,1,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
myBarFour(ypt_corrPnBtAcMean(:,1),ypt_corrPnBtAcMean(:,2),ypt_corrPnBtAcStd(:,1),ypt_corrPnBtAcStd(:,2))
hold on;
rectangle('Position',[5,0.92,0.7,0.02],'FaceColor','none');
hold on;
rectangle('Position',[5,0.82,0.7,0.02],'FaceColor',[189, 189, 189]./255);
ylabel('Place field correlation (r)');
title('PN & Bewteen block Inactivation','FontSize',fontL);
text(5,0.9,['Light-on (n = ',num2str(nPnBtAc_DRw),')'],'FontSize',fontM);
text(5,0.8,['Light-off (n = ',num2str(nPnBtAc_noRw),')'],'FontSize',fontM);

hBarBt(2) = axes('Position',axpt(3,2,2,1,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
myBarFour(ypt_corrPnBtInMean(:,1),ypt_corrPnBtInMean(:,2),ypt_corrPnBtInStd(:,1),ypt_corrPnBtInStd(:,2))
ylabel('Place field correlation (r)');
title('PN & Bewteen block Activation','FontSize',fontL);
text(5,0.9,['n = ',num2str(nPnBtIn_DRw)],'FontSize',fontM);
text(5,0.8,['n = ',num2str(nPnBtIn_noRw)],'FontSize',fontM);

hBarBt(3) = axes('Position',axpt(3,2,3,1,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
myBarFour(ypt_corrPnBtNoMean(:,1),ypt_corrPnBtNoMean(:,2),ypt_corrPnBtNoStd(:,1),ypt_corrPnBtNoStd(:,2))
ylabel('Place field correlation (r)');
title('PN & Bewteen block No change','FontSize',fontL);
text(5,0.9,['n = ',num2str(nPnBtNo_DRw)],'FontSize',fontM);
text(5,0.8,['n = ',num2str(nPnBtNo_noRw)],'FontSize',fontM);
set(hBarBt,'YLim',[0,1],'FontSize',fontM);
print(gcf,'-dtiff','-r300',['PFcorrelation_Bt_Rw_',num2str(cutoff)]);
%%
figure(2)
hBarIn(1) = axes('Position',axpt(3,2,1,1,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
myBarFour(ypt_corrPnInAcMean(:,1),ypt_corrPnInAcMean(:,2),ypt_corrPnInAcStd(:,1),ypt_corrPnInAcStd(:,2))
hold on;
rectangle('Position',[5,0.92,0.7,0.02],'FaceColor','none');
hold on;
rectangle('Position',[5,0.82,0.7,0.02],'FaceColor',[189, 189, 189]./255);
ylabel('Place field correlation (r)');
title('PN & In block Activation','FontSize',fontL);
text(5,0.9,['Light-on (n = ',num2str(nPnInAc_DRw),')'],'FontSize',fontM);
text(5,0.8,['Light-off (n = ',num2str(nPnInAc_noRw),')'],'FontSize',fontM);

hBarIn(2) = axes('Position',axpt(3,2,2,1,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
myBarFour(ypt_corrPnInInMean(:,1),ypt_corrPnInInMean(:,2),ypt_corrPnBtInStd(:,1),ypt_corrPnBtInStd(:,2))
ylabel('Place field correlation (r)');
title('PN & In block Inactivation','FontSize',fontL);
text(5,0.9,['n = ',num2str(nPnInIn_DRw)],'FontSize',fontM);
text(5,0.8,['n = ',num2str(nPnInIn_noRw)],'FontSize',fontM);

hBarIn(3) = axes('Position',axpt(3,2,3,1,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
myBarFour(ypt_corrPnInNoMean(:,1),ypt_corrPnInNoMean(:,2),ypt_corrPnInNoStd(:,1),ypt_corrPnInNoStd(:,2))
ylabel('Place field correlation (r)');
title('PN & In block No change','FontSize',fontL);
text(5,0.9,['n = ',num2str(nPnInNo_DRw)],'FontSize',fontM);
text(5,0.8,['n = ',num2str(nPnInNo_noRw)],'FontSize',fontM);
set(hBarIn,'YLim',[0,1],'FontSize',fontM);
print(gcf,'-dtiff','-r300',['PFcorrelation_In_Rw_',num2str(cutoff)]);
%%
figure(3)
hBarNo(1) = axes('Position',axpt(3,2,1,1,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
myBarFour(ypt_corrPnTagAcMean(:,1),ypt_corrPnTagAcMean(:,2),ypt_corrPnTagAcStd(:,1),ypt_corrPnTagAcStd(:,2))
hold on;
rectangle('Position',[5,0.92,0.7,0.02],'FaceColor','none');
hold on;
rectangle('Position',[5,0.82,0.7,0.02],'FaceColor',[189, 189, 189]./255);
ylabel('Place field correlation (r)');
title('PN & Tag Activation','FontSize',fontL);
text(5,0.9,['Light-on (n = ',num2str(nPnTagAc_DRw),')'],'FontSize',fontM);
text(5,0.8,['Light-off (n = ',num2str(nPnTagAc_noRw),')'],'FontSize',fontM);

hBarNo(2) = axes('Position',axpt(3,2,2,1,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
myBarFour(ypt_corrPnTagInMean(:,1),ypt_corrPnTagInMean(:,2),ypt_corrPnTagInStd(:,1),ypt_corrPnTagInStd(:,2))
ylabel('Place field correlation (r)');
title('PN & Tag Inactivation','FontSize',fontL);
text(5,0.9,['n = ',num2str(nPnTagIn_DRw)],'FontSize',fontM);
text(5,0.8,['n = ',num2str(nPnTagIn_noRw)],'FontSize',fontM);

hBarNo(3) = axes('Position',axpt(3,2,3,1,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
myBarFour(ypt_corrPnTagNoMean(:,1),ypt_corrPnTagNoMean(:,2),ypt_corrPnTagNoStd(:,1),ypt_corrPnTagNoStd(:,2))
ylabel('Place field correlation (r)');
title('PN & Tag no change','FontSize',fontL);
text(5,0.9,['n = ',num2str(nPnTagNo_DRw)],'FontSize',fontM);
text(5,0.8,['n = ',num2str(nPnTagNo_noRw)],'FontSize',fontM);
set(hBarNo,'YLim',[0,1],'FontSize',fontM);
print(gcf,'-dtiff','-r300',['PFcorrelation_No_Rw_',num2str(cutoff)]);