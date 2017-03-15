% Calculate cross correlation of rapid light activated population
%
%
% common part
lineColor = {[144, 164, 174]./255,... % Before stimulation
    [33 150 243]./ 255,... % During stimulation
    [38, 50, 56]./255}; % After stimulation

lineWth = [1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75];
fontS = 4; fontM = 6; fontL = 8; % font size large
lineS = 0.2; lineM = 0.5; lineL = 1; % line width large

colorBlue = [33, 150, 243]/255;
colorLightBlue = [100, 181, 246]/255;
colorLLightBlue = [187, 222, 251]/255;
colorRed = [237, 50, 52]/255;
colorLightRed = [242, 138, 130]/255;
colorGray = [189, 189, 189]/255;
colorGreen = [46, 125, 50]/255;
colorLightGray = [238, 238, 238]/255;
colorDarkGray = [117, 117, 117]/255;
colorYellow = [255, 243, 3]/255;
colorLightYellow = [255, 249, 196]/255;
colorPurple = [123, 31, 162]/255;
colorBlack = [0, 0, 0];

markerS = 2.2; markerM = 4.4; markerL = 6.6; markerXL = 8.8;
tightInterval = [0.02 0.02]; midInterval = [0.09, 0.09]; wideInterval = [0.14 0.14];
width = 0.7;

paperSize = {[0 0 21.0 29.7]; % A4_portrait
             [0 0 29.7 21.0]; % A4_landscape
             [0 0 15.7 21.0]; % A4_half landscape
             [0 0 21.6 27.9]}; % Letter

cd('D:\Dropbox\SNL\P2_Track');
Txls = readtable('neuronList_03-Mar-2017.xlsx');
load('neuronList_ori_14-Mar-2017.mat');

criPeak = 0;
criFR = 7;
alpha = 0.01;

condi_lightRact = T.pLR_Track<alpha & T.latencyTrack<10 & T.statDir_Track==1; % direct activated
condi_lightDact = T.pLR_Track<alpha & T.latencyTrack>10 & T.statDir_Track==1; % direct activated
condi_lightina = T.pLR_Track<alpha & T.latencyTrack<10 & T.statDir_Track==-1; % direct activated
% TN: track neuron
DRunTN = (T.taskType == 'DRun') & (cellfun(@max, T.peakFR1D_track) > criPeak);
DRwTN = (T.taskType == 'DRw') & (cellfun(@max, T.peakFR1D_track) > criPeak);

% light activated total population (DRunPN / DRunIN / DRwPN / DRwIN)

DRunPN = DRunTN & T.meanFR_task <= criFR;
DRunIN = DRunTN & T.meanFR_task > criFR;
DRwPN = DRwTN & T.meanFR_task <= criFR;
DRwIN = DRwTN & T.meanFR_task > criFR;

% direct activated
temp_stmspk_DRunPN_lightRact = T.stmzoneSpike(DRunPN & condi_lightRact);
temp_stmspk_DRunIN_lightRact = T.stmzoneSpike(DRunIN & condi_lightRact);
temp_stmspk_DRwPN_lightRact = T.stmzoneSpike(DRwPN & condi_lightRact);
temp_stmspk_DRwIN_lightRact = T.stmzoneSpike(DRwIN & condi_lightRact);

% delayed activated
temp_stmspk_DRunPN_lightDact = T.stmzoneSpike(DRunPN & condi_lightDact);
temp_stmspk_DRunIN_lightDact = T.stmzoneSpike(DRunIN & condi_lightDact);
temp_stmspk_DRwPN_lightDact = T.stmzoneSpike(DRwPN & condi_lightDact);
temp_stmspk_DRwIN_lightDact = T.stmzoneSpike(DRwIN & condi_lightDact);

% inactivated
temp_stmspk_DRunPN_lightina = T.stmzoneSpike(DRunPN & condi_lightina);
temp_stmspk_DRunIN_lightina = T.stmzoneSpike(DRunIN & condi_lightina);
temp_stmspk_DRwPN_lightina = T.stmzoneSpike(DRwPN & condi_lightina);
temp_stmspk_DRwIN_lightina = T.stmzoneSpike(DRwIN & condi_lightina);

temp_stmspk_DRunPN = T.stmzoneSpike(DRunPN);
temp_stmspk_DRunIN = T.stmzoneSpike(DRunIN);
temp_stmspk_DRwPN = T.stmzoneSpike(DRwPN);
temp_stmspk_DRwIN = T.stmzoneSpike(DRwIN);

%
nDRunPN_lightRact = size(temp_stmspk_DRunPN_lightRact,1);
nDRunIN_lightRact = size(temp_stmspk_DRunIN_lightRact,1);
nDRwPN_lightRact = size(temp_stmspk_DRwPN_lightRact,1);
nDRwIN_lightRact = size(temp_stmspk_DRwIN_lightRact,1);

nDRunPN_lightDact = size(temp_stmspk_DRunPN_lightDact,1);
nDRunIN_lightDact = size(temp_stmspk_DRunIN_lightDact,1);
nDRwPN_lightDact = size(temp_stmspk_DRwPN_lightDact,1);
nDRwIN_lightDact = size(temp_stmspk_DRwIN_lightDact,1);

nDRunPN_lightina = size(temp_stmspk_DRunPN_lightina,1);
nDRunIN_lightina = size(temp_stmspk_DRunIN_lightina,1);
nDRwPN_lightina = size(temp_stmspk_DRwPN_lightina,1);
nDRwIN_lightina = size(temp_stmspk_DRwIN_lightina,1);

nDRunPN = sum(double(DRunPN));
nDRunIN = sum(double(DRunIN));
nDRwPN = sum(double(DRwPN));
nDRwIN = sum(double(DRwIN));

%
stmspk_DRunPN_lightRact = reshape(cell2mat(temp_stmspk_DRunPN_lightRact),[3,nDRunPN_lightRact])';
stmspk_DRunIN_lightRact = reshape(cell2mat(temp_stmspk_DRunIN_lightRact),[3,nDRunIN_lightRact])';
stmspk_DRwPN_lightRact = reshape(cell2mat(temp_stmspk_DRwPN_lightRact),[3,nDRwPN_lightRact])';
stmspk_DRwIN_lightRact = reshape(cell2mat(temp_stmspk_DRwIN_lightRact),[3,nDRwIN_lightRact])';

stmspk_DRunPN_lightDact = reshape(cell2mat(temp_stmspk_DRunPN_lightDact),[3,nDRunPN_lightDact])';
stmspk_DRunIN_lightDact = reshape(cell2mat(temp_stmspk_DRunIN_lightDact),[3,nDRunIN_lightDact])';
stmspk_DRwPN_lightDact = reshape(cell2mat(temp_stmspk_DRwPN_lightDact),[3,nDRwPN_lightDact])';
stmspk_DRwIN_lightDact = reshape(cell2mat(temp_stmspk_DRwIN_lightDact),[3,nDRwIN_lightDact])';

stmspk_DRunPN_lightina = reshape(cell2mat(temp_stmspk_DRunPN_lightina),[3,nDRunPN_lightina])';
stmspk_DRunIN_lightina = reshape(cell2mat(temp_stmspk_DRunIN_lightina),[3,nDRunIN_lightina])';
stmspk_DRwPN_lightina = reshape(cell2mat(temp_stmspk_DRwPN_lightina),[3,nDRwPN_lightina])';
stmspk_DRwIN_lightina = reshape(cell2mat(temp_stmspk_DRwIN_lightina),[3,nDRwIN_lightina])';

stmspk_DRunPN = reshape(cell2mat(temp_stmspk_DRunPN),[3,nDRunPN])';
stmspk_DRunIN = reshape(cell2mat(temp_stmspk_DRunIN),[3,nDRunIN])';
stmspk_DRwPN = reshape(cell2mat(temp_stmspk_DRwPN),[3,nDRwPN])';
stmspk_DRwIN = reshape(cell2mat(temp_stmspk_DRwIN),[3,nDRwIN])';

%%
nCol = 4;
nRow = 3;

fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{2},'Name','stmzoneSpike light response');

hStmspkDRun(1) = axes('Position',axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval));
plot([1,2,3],stmspk_DRunPN_lightRact,'-o','color',colorBlack,'MarkerFaceColor',colorBlue);
text(3.5,max(stmspk_DRunPN_lightRact(:))*0.8,['n = ',num2str(nDRunPN_lightRact)],'fontSize',fontL);
title('DRunPN rapid activated','fontSize',fontL,'fontWeight','bold');

hStmspkDRun(2) = axes('Position',axpt(nCol,nRow,1,2,[0.1 0.1 0.85 0.85],wideInterval));
plot([1,2,3],stmspk_DRunPN_lightDact,'-o','color',colorBlack,'MarkerFaceColor',colorBlue);
text(3.5,max(stmspk_DRunPN_lightDact(:))*0.8,['n = ',num2str(nDRunPN_lightDact)],'fontSize',fontL);
title('DRunPN slow activated','fontSize',fontL,'fontWeight','bold');

hStmspkDRun(3) = axes('Position',axpt(nCol,nRow,1,3,[0.1 0.1 0.85 0.85],wideInterval));
plot([1,2,3],stmspk_DRunPN_lightina,'-o','color',colorBlack,'MarkerFaceColor',colorBlue);
text(3.5,max(stmspk_DRunPN_lightina(:))*0.8,['n = ',num2str(nDRunPN_lightina)],'fontSize',fontL);
title('DRunPN inactivated','fontSize',fontL,'fontWeight','bold');

hStmspkDRun(4) = axes('Position',axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],wideInterval));
plot([1,2,3],stmspk_DRunIN_lightRact,'-o','color',colorBlack,'MarkerFaceColor',colorBlue);
text(3.5,max(stmspk_DRunIN_lightRact(:))*0.8,['n = ',num2str(nDRunIN_lightRact)],'fontSize',fontL);
title('DRunIN rapid activated','fontSize',fontL,'fontWeight','bold');

% hStmspkDRun(5) = axes('Position',axpt(nCol,nRow,2,2,[0.1 0.1 0.85 0.85],wideInterval));
% plot([1,2,3],stmspk_DRunIN_lightDact,'-o','color',colorBlack,'MarkerFaceColor',colorBlue);
% title('DRunIN rapid activated','fontSize',fontL,'fontWeight','bold');

hStmspkDRun(5) = axes('Position',axpt(nCol,nRow,2,3,[0.1 0.1 0.85 0.85],wideInterval));
plot([1,2,3],stmspk_DRunIN_lightina,'-o','color',colorBlack,'MarkerFaceColor',colorBlue);
text(3.5,max(stmspk_DRunIN_lightina(:))*0.8,['n = ',num2str(nDRunIN_lightina)],'fontSize',fontL);
title('DRunIN inactivated','fontSize',fontL,'fontWeight','bold');

set(hStmspkDRun,'TickDir','out','Box','off','XLim',[0,4],'XTick',[1,2,3],'XTickLabel',{'Pre','Stm','Post'});

hStmspkDRw(1) = axes('Position',axpt(nCol,nRow,3,1,[0.1 0.1 0.85 0.85],wideInterval));
plot([1,2,3],stmspk_DRwPN_lightRact,'-o','color',colorBlack,'MarkerFaceColor',colorBlue);
text(3.5,max(stmspk_DRwPN_lightRact(:))*0.8,['n = ',num2str(nDRwPN_lightRact)],'fontSize',fontL);
title('DRwPN rapid activated','fontSize',fontL,'fontWeight','bold');

hStmspkDRw(2) = axes('Position',axpt(nCol,nRow,3,2,[0.1 0.1 0.85 0.85],wideInterval));
plot([1,2,3],stmspk_DRwPN_lightDact,'-o','color',colorBlack,'MarkerFaceColor',colorBlue);
text(3.5,max(stmspk_DRwPN_lightDact(:))*0.8,['n = ',num2str(nDRwPN_lightDact)],'fontSize',fontL);
title('DRwPN slow activated','fontSize',fontL,'fontWeight','bold');

hStmspkDRw(3) = axes('Position',axpt(nCol,nRow,3,3,[0.1 0.1 0.85 0.85],wideInterval));
plot([1,2,3],stmspk_DRwPN_lightina,'-o','color',colorBlack,'MarkerFaceColor',colorBlue);
text(3.5,max(stmspk_DRwPN_lightina(:))*0.8,['n = ',num2str(nDRwPN_lightina)],'fontSize',fontL);
title('DRwPN inactivated','fontSize',fontL,'fontWeight','bold');

hStmspkDRw(4) = axes('Position',axpt(nCol,nRow,4,1,[0.1 0.1 0.85 0.85],wideInterval));
plot([1,2,3],stmspk_DRwIN_lightRact,'-o','color',colorBlack,'MarkerFaceColor',colorBlue);
text(3.5,max(stmspk_DRwIN_lightRact(:))*0.8,['n = ',num2str(nDRwIN_lightRact)],'fontSize',fontL);
title('DRwIN rapid activated','fontSize',fontL,'fontWeight','bold');

% hStmspkDRw(5) = axes('Position',axpt(nCol,nRow,2,2,[0.1 0.1 0.85 0.85],wideInterval));
% plot([1,2,3],stmspk_DRwIN_lightDact,'-o','color',colorBlack,'MarkerFaceColor',colorBlue);
% title('DRunIN rapid activated','fontSize',fontL,'fontWeight','bold');

hStmspkDRw(5) = axes('Position',axpt(nCol,nRow,4,3,[0.1 0.1 0.85 0.85],wideInterval));
plot([1,2,3],stmspk_DRwIN_lightina,'-o','color',colorBlack,'MarkerFaceColor',colorBlue);
text(3.5,max(stmspk_DRwIN_lightina(:))*0.8,['n = ',num2str(nDRwIN_lightina)],'fontSize',fontL);
title('DRwIN inactivated','fontSize',fontL,'fontWeight','bold');

set(hStmspkDRw,'TickDir','out','Box','off','XLim',[0,4],'XTick',[1,2,3],'XTickLabel',{'Pre','Stm','Post'});
print('-painters','-r300','plot_stmzoneSpike_lightRes.tif','-dtiff');


fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{2},'Name','stmzoneSpike total');

nCol = 4;
nRow = 1;

hStmspkTotal(1) = axes('Position',axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval));
plot([1,2,3],stmspk_DRunPN,'-o','color',colorBlack,'MarkerFaceColor',colorGray);
hold on;
plot([1,2,3],stmspk_DRunPN_lightRact,'-o','color',colorBlack,'MarkerFaceColor',colorBlue,'MarkerSize',markerM);
hold on;
plot([1,2,3],stmspk_DRunPN_lightDact,'-o','color',colorBlack,'MarkerFaceColor',colorBlue,'MarkerSize',markerM);
hold on;
plot([1,2,3],stmspk_DRunPN_lightina,'-o','color',colorBlack,'MarkerFaceColor',colorBlue,'MarkerSize',markerM);
text(3.5,max(stmspk_DRunPN(:))*0.8,['n = ',num2str(nDRunPN)],'fontSize',fontL);
title('DRunPN total','fontSize',fontL,'fontWeight','bold');

hStmspkTotal(2) = axes('Position',axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],wideInterval));
plot([1,2,3],stmspk_DRunIN,'-o','color',colorBlack,'MarkerFaceColor',colorGray);
hold on;
plot([1,2,3],stmspk_DRunIN_lightRact,'-o','color',colorBlack,'MarkerFaceColor',colorBlue,'MarkerSize',markerM);
hold on;
plot([1,2,3],stmspk_DRunIN_lightina,'-o','color',colorBlack,'MarkerFaceColor',colorBlue,'MarkerSize',markerM);
text(3.5,max(stmspk_DRunIN(:))*0.8,['n = ',num2str(nDRunIN)],'fontSize',fontL);
title('DRunIN total','fontSize',fontL,'fontWeight','bold');

hStmspkTotal(3) = axes('Position',axpt(nCol,nRow,3,1,[0.1 0.1 0.85 0.85],wideInterval));
plot([1,2,3],stmspk_DRwPN,'-o','color',colorBlack,'MarkerFaceColor',colorGray);
hold on;
plot([1,2,3],stmspk_DRwPN_lightRact,'-o','color',colorBlack,'MarkerFaceColor',colorBlue,'MarkerSize',markerM);
hold on;
plot([1,2,3],stmspk_DRwPN_lightDact,'-o','color',colorBlack,'MarkerFaceColor',colorBlue,'MarkerSize',markerM);
hold on;
plot([1,2,3],stmspk_DRwPN_lightina,'-o','color',colorBlack,'MarkerFaceColor',colorBlue,'MarkerSize',markerM);
text(3.5,max(stmspk_DRwPN(:))*0.8,['n = ',num2str(nDRwPN)],'fontSize',fontL);
title('DRwPN total','fontSize',fontL,'fontWeight','bold');

hStmspkTotal(4) = axes('Position',axpt(nCol,nRow,4,1,[0.1 0.1 0.85 0.85],wideInterval));
plot([1,2,3],stmspk_DRwIN,'-o','color',colorBlack,'MarkerFaceColor',colorGray);
hold on;
plot([1,2,3],stmspk_DRwIN_lightRact,'-o','color',colorBlack,'MarkerFaceColor',colorBlue,'MarkerSize',markerM);
hold on;
plot([1,2,3],stmspk_DRwIN_lightina,'-o','color',colorBlack,'MarkerFaceColor',colorBlue,'MarkerSize',markerM);
text(3.5,max(stmspk_DRwIN(:))*0.8,['n = ',num2str(nDRwIN)],'fontSize',fontL);
title('DRwIN total','fontSize',fontL,'fontWeight','bold');

set(hStmspkTotal,'TickDir','out','Box','off','XLim',[0,4],'XTick',[1,2,3],'XTickLabel',{'Pre','Stm','Post'});
print('-painters','-r300','plot_stmzoneSpike_total.tif','-dtiff');
