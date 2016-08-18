% clearvars;
clf; close all;

cutoff = 0;

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

tDRun = T;
tnoRun = T;

tDRun(~(tDRun.taskType == 'DRun'),:) = [];
tnoRun(~(tnoRun.taskType == 'noRun'),:) = [];

pnDRun = tDRun.fr_task >0  & tDRun.fr_task < 10;
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
pnnoRun = tnoRun.fr_task > 0 & tnoRun.fr_task < 10;
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

% Between block
ypt_corrPnBtAcMean = [mean(tDRun.r_CorrEvOd(pnDRun&interAc_DRun)), mean(tnoRun.r_CorrEvOd(pnnoRun&interAc_noRun));
                  mean(tDRun.r_Corrbfxdr(pnDRun&interAc_DRun)), mean(tnoRun.r_Corrbfxdr(pnnoRun&interAc_noRun));
                  mean(tDRun.r_Corrdrxaft(pnDRun&interAc_DRun)), mean(tnoRun.r_Corrdrxaft(pnnoRun&interAc_noRun));
                  mean(tDRun.r_Corrbfxaft(pnDRun&interAc_DRun)), mean(tnoRun.r_Corrbfxaft(pnnoRun&interAc_noRun))];
              
ypt_corrPnBtInMean = [mean(tDRun.r_CorrEvOd(pnDRun&interIn_DRun)), mean(tnoRun.r_Corrbfxdr(pnnoRun&interIn_noRun)); 
                  mean(tDRun.r_Corrbfxdr(pnDRun&interIn_DRun)), mean(tnoRun.r_Corrbfxdr(pnnoRun&interIn_noRun));
                  mean(tDRun.r_Corrdrxaft(pnDRun&interIn_DRun)), mean(tnoRun.r_Corrbfxdr(pnnoRun&interIn_noRun));
                  mean(tDRun.r_Corrbfxaft(pnDRun&interIn_DRun)), mean(tnoRun.r_Corrbfxaft(pnnoRun&interIn_noRun))];
              
ypt_corrPnBtNoMean = [mean(tDRun.r_CorrEvOd(pnDRun&interNo_DRun)), mean(tnoRun.r_CorrEvOd(pnnoRun&interNo_noRun)); 
                  mean(tDRun.r_Corrbfxdr(pnDRun&interNo_DRun)), mean(tnoRun.r_Corrbfxdr(pnnoRun&interNo_noRun));
                  mean(tDRun.r_Corrdrxaft(pnDRun&interNo_DRun)), mean(tnoRun.r_Corrdrxaft(pnnoRun&interNo_noRun));
                  mean(tDRun.r_Corrbfxaft(pnDRun&interNo_DRun)), mean(tnoRun.r_Corrbfxaft(pnnoRun&interNo_noRun))];
% Inblock (intra: In)
ypt_corrPnInAcMean = [mean(tDRun.r_CorrEvOd(pnDRun&intraAc_DRun)), mean(tnoRun.r_CorrEvOd(pnnoRun&intraAc_noRun));
                  mean(tDRun.r_Corrbfxdr(pnDRun&intraAc_DRun)), mean(tnoRun.r_Corrbfxdr(pnnoRun&intraAc_noRun));
                  mean(tDRun.r_Corrdrxaft(pnDRun&intraAc_DRun)), mean(tnoRun.r_Corrdrxaft(pnnoRun&intraAc_noRun));
                  mean(tDRun.r_Corrbfxaft(pnDRun&intraAc_DRun)), mean(tnoRun.r_Corrbfxaft(pnnoRun&intraAc_noRun))];
              
ypt_corrPnInInMean = [mean(tDRun.r_CorrEvOd(pnDRun&intraIn_DRun)), mean(tnoRun.r_CorrEvOd(pnnoRun&intraIn_noRun)); 
                  mean(tDRun.r_Corrbfxdr(pnDRun&intraIn_DRun)), mean(tnoRun.r_Corrbfxdr(pnnoRun&intraIn_noRun));
                  mean(tDRun.r_Corrdrxaft(pnDRun&intraIn_DRun)), mean(tnoRun.r_Corrdrxaft(pnnoRun&intraIn_noRun));
                  mean(tDRun.r_Corrbfxaft(pnDRun&intraIn_DRun)), mean(tnoRun.r_Corrbfxaft(pnnoRun&intraIn_noRun))];
              
ypt_corrPnInNoMean = [mean(tDRun.r_CorrEvOd(pnDRun&intraNo_DRun)), mean(tnoRun.r_CorrEvOd(pnnoRun&intraNo_noRun)); 
                  mean(tDRun.r_Corrbfxdr(pnDRun&intraNo_DRun)), mean(tnoRun.r_Corrbfxdr(pnnoRun&intraNo_noRun));
                  mean(tDRun.r_Corrdrxaft(pnDRun&intraNo_DRun)), mean(tnoRun.r_Corrdrxaft(pnnoRun&intraNo_noRun));
                  mean(tDRun.r_Corrbfxaft(pnDRun&intraNo_DRun)), mean(tnoRun.r_Corrbfxaft(pnnoRun&intraNo_noRun))];
% Tag (tag)
ypt_corrPnTagAcMean = [mean(tDRun.r_CorrEvOd(pnDRun&tagAc_DRun)), mean(tnoRun.r_CorrEvOd(pnnoRun&tagAc_noRun));
                  mean(tDRun.r_Corrbfxdr(pnDRun&tagAc_DRun)), mean(tnoRun.r_Corrbfxdr(pnnoRun&tagAc_noRun));
                  mean(tDRun.r_Corrdrxaft(pnDRun&tagAc_DRun)), mean(tnoRun.r_Corrdrxaft(pnnoRun&tagAc_noRun));
                  mean(tDRun.r_Corrbfxaft(pnDRun&tagAc_DRun)), mean(tnoRun.r_Corrbfxaft(pnnoRun&tagAc_noRun))];
              
ypt_corrPnTagInMean = [mean(tDRun.r_CorrEvOd(pnDRun&tagIn_DRun)), mean(tnoRun.r_CorrEvOd(pnnoRun&tagIn_noRun)); 
                  mean(tDRun.r_Corrbfxdr(pnDRun&tagIn_DRun)), mean(tnoRun.r_Corrbfxdr(pnnoRun&tagIn_noRun));...
                  mean(tDRun.r_Corrdrxaft(pnDRun&tagIn_DRun)), mean(tnoRun.r_Corrdrxaft(pnnoRun&tagIn_noRun));
                  mean(tDRun.r_Corrbfxaft(pnDRun&tagIn_DRun)), mean(tnoRun.r_Corrbfxaft(pnnoRun&tagIn_noRun))];
              
ypt_corrPnTagNoMean = [mean(tDRun.r_CorrEvOd(pnDRun&tagNo_DRun)), mean(tnoRun.r_CorrEvOd(pnnoRun&tagNo_noRun)); 
                  mean(tDRun.r_Corrbfxdr(pnDRun&tagNo_DRun)), mean(tnoRun.r_Corrbfxdr(pnnoRun&tagNo_noRun));
                  mean(tDRun.r_Corrdrxaft(pnDRun&tagNo_DRun)), mean(tnoRun.r_Corrdrxaft(pnnoRun&tagNo_noRun));
                  mean(tDRun.r_Corrbfxaft(pnDRun&tagNo_DRun)), mean(tnoRun.r_Corrbfxaft(pnnoRun&tagNo_noRun))];
              
ypt_corrPnBtAcStd = [std(tDRun.r_CorrEvOd(pnDRun&interAc_DRun))/nPnBtAc_DRun, std(tnoRun.r_CorrEvOd(pnnoRun&interAc_noRun))/nPnBtAc_noRun;
                  std(tDRun.r_Corrbfxdr(pnDRun&interAc_DRun))/nPnBtAc_DRun, std(tnoRun.r_Corrbfxdr(pnnoRun&interAc_noRun))/nPnBtAc_noRun;
                  std(tDRun.r_Corrdrxaft(pnDRun&interAc_DRun))/nPnBtAc_DRun, std(tnoRun.r_Corrdrxaft(pnnoRun&interAc_noRun))/nPnBtAc_noRun;
                  std(tDRun.r_Corrbfxaft(pnDRun&interAc_DRun))/nPnBtAc_DRun, std(tnoRun.r_Corrbfxaft(pnnoRun&interAc_noRun))/nPnBtAc_noRun];
              
ypt_corrPnBtInStd = [std(tDRun.r_CorrEvOd(pnDRun&interIn_DRun))/nPnBtIn_DRun, std(tnoRun.r_Corrbfxdr(pnnoRun&interIn_noRun))/nPnBtIn_noRun; 
                  std(tDRun.r_Corrbfxdr(pnDRun&interIn_DRun))/nPnBtIn_DRun, std(tnoRun.r_Corrbfxdr(pnnoRun&interIn_noRun))/nPnBtIn_noRun;
                  std(tDRun.r_Corrdrxaft(pnDRun&interIn_DRun))/nPnBtIn_DRun, std(tnoRun.r_Corrbfxdr(pnnoRun&interIn_noRun))/nPnBtIn_noRun;
                  std(tDRun.r_Corrbfxaft(pnDRun&interIn_DRun))/nPnBtIn_DRun, std(tnoRun.r_Corrbfxaft(pnnoRun&interIn_noRun))/nPnBtIn_noRun];
              
ypt_corrPnBtNoStd = [std(tDRun.r_CorrEvOd(pnDRun&interNo_DRun))/nPnBtNo_DRun, std(tnoRun.r_CorrEvOd(pnnoRun&interNo_noRun))/nPnBtNo_noRun; 
                  std(tDRun.r_Corrbfxdr(pnDRun&interNo_DRun))/nPnBtNo_DRun, std(tnoRun.r_Corrbfxdr(pnnoRun&interNo_noRun))/nPnBtNo_noRun;
                  std(tDRun.r_Corrdrxaft(pnDRun&interNo_DRun))/nPnBtNo_DRun, std(tnoRun.r_Corrdrxaft(pnnoRun&interNo_noRun))/nPnBtNo_noRun;
                  std(tDRun.r_Corrbfxaft(pnDRun&interNo_DRun))/nPnBtNo_DRun, std(tnoRun.r_Corrbfxaft(pnnoRun&interNo_noRun))/nPnBtNo_noRun];
              
ypt_corrPnInAcStd = [std(tDRun.r_CorrEvOd(pnDRun&intraAc_DRun))/nPnInAc_DRun, std(tnoRun.r_CorrEvOd(pnnoRun&intraAc_noRun))/nPnInAc_noRun;
                  std(tDRun.r_Corrbfxdr(pnDRun&intraAc_DRun))/nPnInAc_DRun, std(tnoRun.r_Corrbfxdr(pnnoRun&intraAc_noRun))/nPnInAc_noRun;
                  std(tDRun.r_Corrdrxaft(pnDRun&intraAc_DRun))/nPnInAc_DRun, std(tnoRun.r_Corrdrxaft(pnnoRun&intraAc_noRun))/nPnInAc_noRun;
                  std(tDRun.r_Corrbfxaft(pnDRun&intraAc_DRun))/nPnInAc_DRun, std(tnoRun.r_Corrbfxaft(pnnoRun&intraAc_noRun))/nPnInAc_noRun];
              
ypt_corrPnInInStd = [std(tDRun.r_CorrEvOd(pnDRun&intraIn_DRun))/nPnInIn_DRun, std(tnoRun.r_CorrEvOd(pnnoRun&intraIn_noRun))/nPnInIn_noRun; 
                  std(tDRun.r_Corrbfxdr(pnDRun&intraIn_DRun))/nPnInIn_DRun, std(tnoRun.r_Corrbfxdr(pnnoRun&intraIn_noRun))/nPnInIn_noRun;
                  std(tDRun.r_Corrdrxaft(pnDRun&intraIn_DRun))/nPnInIn_DRun, std(tnoRun.r_Corrdrxaft(pnnoRun&intraIn_noRun))/nPnInIn_noRun;
                  std(tDRun.r_Corrbfxaft(pnDRun&intraIn_DRun))/nPnInIn_DRun, std(tnoRun.r_Corrbfxaft(pnnoRun&intraIn_noRun))/nPnInIn_noRun];
              
ypt_corrPnInNoStd = [std(tDRun.r_CorrEvOd(pnDRun&intraNo_DRun))/nPnInNo_DRun, std(tnoRun.r_CorrEvOd(pnnoRun&intraNo_noRun))/nPnInNo_noRun; 
                  std(tDRun.r_Corrbfxdr(pnDRun&intraNo_DRun))/nPnInNo_DRun, std(tnoRun.r_Corrbfxdr(pnnoRun&intraNo_noRun))/nPnInNo_noRun;
                  std(tDRun.r_Corrdrxaft(pnDRun&intraNo_DRun))/nPnInNo_DRun, std(tnoRun.r_Corrdrxaft(pnnoRun&intraNo_noRun))/nPnInNo_noRun;
                  std(tDRun.r_Corrbfxaft(pnDRun&intraNo_DRun))/nPnInNo_DRun, std(tnoRun.r_Corrbfxaft(pnnoRun&intraNo_noRun))/nPnInNo_noRun];
% Tag (tag)
ypt_corrPnTagAcStd = [std(tDRun.r_CorrEvOd(pnDRun&tagAc_DRun))/nPnTagAc_DRun, std(tnoRun.r_CorrEvOd(pnnoRun&tagAc_noRun))/nPnTagAc_noRun;
                  std(tDRun.r_Corrbfxdr(pnDRun&tagAc_DRun))/nPnTagAc_DRun, std(tnoRun.r_Corrbfxdr(pnnoRun&tagAc_noRun))/nPnTagAc_noRun;
                  std(tDRun.r_Corrdrxaft(pnDRun&tagAc_DRun))/nPnTagAc_DRun, std(tnoRun.r_Corrdrxaft(pnnoRun&tagAc_noRun))/nPnTagAc_noRun;
                  std(tDRun.r_Corrbfxaft(pnDRun&tagAc_DRun))/nPnTagAc_DRun, std(tnoRun.r_Corrbfxaft(pnnoRun&tagAc_noRun))/nPnTagAc_noRun];
              
ypt_corrPnTagInStd = [std(tDRun.r_CorrEvOd(pnDRun&tagIn_DRun))/nPnTagIn_DRun, std(tnoRun.r_CorrEvOd(pnnoRun&tagIn_noRun))/nPnTagIn_noRun; 
                  std(tDRun.r_Corrbfxdr(pnDRun&tagIn_DRun))/nPnTagIn_DRun, std(tnoRun.r_Corrbfxdr(pnnoRun&tagIn_noRun))/nPnTagIn_noRun;
                  std(tDRun.r_Corrdrxaft(pnDRun&tagIn_DRun))/nPnTagIn_DRun, std(tnoRun.r_Corrdrxaft(pnnoRun&tagIn_noRun))/nPnTagIn_noRun;
                  std(tDRun.r_Corrbfxaft(pnDRun&tagIn_DRun))/nPnTagIn_DRun, std(tnoRun.r_Corrbfxaft(pnnoRun&tagIn_noRun))/nPnTagIn_noRun];
              
ypt_corrPnTagNoStd = [std(tDRun.r_CorrEvOd(pnDRun&tagNo_DRun))/nPnTagNo_DRun, std(tnoRun.r_CorrEvOd(pnnoRun&tagNo_noRun))/nPnTagNo_noRun; 
                  std(tDRun.r_Corrbfxdr(pnDRun&tagNo_DRun))/nPnTagNo_DRun, std(tnoRun.r_Corrbfxdr(pnnoRun&tagNo_noRun))/nPnTagNo_noRun;
                  std(tDRun.r_Corrdrxaft(pnDRun&tagNo_DRun))/nPnTagNo_DRun, std(tnoRun.r_Corrdrxaft(pnnoRun&tagNo_noRun))/nPnTagNo_noRun;
                  std(tDRun.r_Corrbfxaft(pnDRun&tagNo_DRun))/nPnTagNo_DRun, std(tnoRun.r_Corrbfxaft(pnnoRun&tagNo_noRun))/nPnTagNo_noRun];

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
text(5,0.9,['Light-on (n = ',num2str(nPnBtAc_DRun),')'],'FontSize',fontM);
text(5,0.8,['Light-off (n = ',num2str(nPnBtAc_noRun),')'],'FontSize',fontM);

hBarBt(2) = axes('Position',axpt(3,2,2,1,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
myBarFour(ypt_corrPnBtInMean(:,1),ypt_corrPnBtInMean(:,2),ypt_corrPnBtInStd(:,1),ypt_corrPnBtInStd(:,2))
ylabel('Place field correlation (r)');
title('PN & Bewteen block Activation','FontSize',fontL);
text(5,0.9,['n = ',num2str(nPnBtIn_DRun)],'FontSize',fontM);
text(5,0.8,['n = ',num2str(nPnBtIn_noRun)],'FontSize',fontM);

hBarBt(3) = axes('Position',axpt(3,2,3,1,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
myBarFour(ypt_corrPnBtNoMean(:,1),ypt_corrPnBtNoMean(:,2),ypt_corrPnBtNoStd(:,1),ypt_corrPnBtNoStd(:,2))
ylabel('Place field correlation (r)');
title('PN & Bewteen block No change','FontSize',fontL);
text(5,0.9,['n = ',num2str(nPnBtNo_DRun)],'FontSize',fontM);
text(5,0.8,['n = ',num2str(nPnBtNo_noRun)],'FontSize',fontM);
set(hBarBt,'YLim',[0,1],'FontSize',fontM);
print(gcf,'-dtiff','-r300',['PFcorrelation_Bt_Run_',num2str(cutoff)]);
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
text(5,0.9,['Light-on (n = ',num2str(nPnInAc_DRun),')'],'FontSize',fontM);
text(5,0.8,['Light-off (n = ',num2str(nPnInAc_noRun),')'],'FontSize',fontM);

hBarIn(2) = axes('Position',axpt(3,2,2,1,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
myBarFour(ypt_corrPnInInMean(:,1),ypt_corrPnInInMean(:,2),ypt_corrPnBtInStd(:,1),ypt_corrPnBtInStd(:,2))
ylabel('Place field correlation (r)');
title('PN & In block Inactivation','FontSize',fontL);
text(5,0.9,['n = ',num2str(nPnInIn_DRun)],'FontSize',fontM);
text(5,0.8,['n = ',num2str(nPnInIn_noRun)],'FontSize',fontM);

hBarIn(3) = axes('Position',axpt(3,2,3,1,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
myBarFour(ypt_corrPnInNoMean(:,1),ypt_corrPnInNoMean(:,2),ypt_corrPnInNoStd(:,1),ypt_corrPnInNoStd(:,2))
ylabel('Place field correlation (r)');
title('PN & In block No change','FontSize',fontL);
text(5,0.9,['n = ',num2str(nPnInNo_DRun)],'FontSize',fontM);
text(5,0.8,['n = ',num2str(nPnInNo_noRun)],'FontSize',fontM);
set(hBarIn,'YLim',[0,1],'FontSize',fontM);
print(gcf,'-dtiff','-r300',['PFcorrelation_In_Run_',num2str(cutoff)]);
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
text(5,0.9,['Light-on (n = ',num2str(nPnTagAc_DRun),')'],'FontSize',fontM);
text(5,0.8,['Light-off (n = ',num2str(nPnTagAc_noRun),')'],'FontSize',fontM);

hBarNo(2) = axes('Position',axpt(3,2,2,1,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
myBarFour(ypt_corrPnTagInMean(:,1),ypt_corrPnTagInMean(:,2),ypt_corrPnTagInStd(:,1),ypt_corrPnTagInStd(:,2))
ylabel('Place field correlation (r)');
title('PN & Tag Inactivation','FontSize',fontL);
text(5,0.9,['n = ',num2str(nPnTagIn_DRun)],'FontSize',fontM);
text(5,0.8,['n = ',num2str(nPnTagIn_noRun)],'FontSize',fontM);

hBarNo(3) = axes('Position',axpt(3,2,3,1,[0.1 0.1 0.85 0.85],wideInterval));
hold on;
myBarFour(ypt_corrPnTagNoMean(:,1),ypt_corrPnTagNoMean(:,2),ypt_corrPnTagNoStd(:,1),ypt_corrPnTagNoStd(:,2))
ylabel('Place field correlation (r)');
title('PN & Tag no change','FontSize',fontL);
text(5,0.9,['n = ',num2str(nPnTagNo_DRun)],'FontSize',fontM);
text(5,0.8,['n = ',num2str(nPnTagNo_noRun)],'FontSize',fontM);
set(hBarNo,'YLim',[0,1],'FontSize',fontM);
print(gcf,'-dtiff','-r300',['PFcorrelation_No_Run_',num2str(cutoff)]);