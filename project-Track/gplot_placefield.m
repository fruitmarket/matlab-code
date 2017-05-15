% Latency of neurons which are activated on the platform. (Blue)
% Among neurons which are activated on the platform, latency of neurons which are also activated on the track
clearvars;
lineColor = {[144, 164, 174]./255,... % Before stimulation
    [33 150 243]./ 255,... % During stimulation
    [38, 50, 56]./255}; % After stimulation

lineWth = [1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75];
fontS = 4; fontM = 6; fontL = 8; fontXL = 10;% font size large
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
colorYellow = [255, 216, 53]/255;
colorLightYellow = [255, 249, 196]/255;
colorPurple = [123, 31, 162]/255;
colorBlack = [0, 0, 0];
colorWhite = [1, 1, 1];
markerSS = 1.95; markerS = 4; markerM = 4.4; markerL = 6.6; markerXL = 8.8;
tightInterval = [0.02 0.02]; midInterval = [0.09, 0.09]; wideInterval = [0.14 0.14];
width = 0.7;

paperSize = {[0 0 21.0 29.7]; % A4_portrait
             [0 0 29.7 21.0]; % A4_landscape
             [0 0 15.7 21.0]; % A4_half landscape
             [0 0 21.6 27.9]}; % Letter

cMeanFR = 9;
cMaxPeakFR = 1;
cSpkpvr = 1.1;
alpha = 0.01;
areaDRun = [5/6 4/3]*pi*20;
areaDRw = [3/2 5/3]*pi*20;
areaRw1 = [1/2 2/3]*pi*20;
areaRw2 = [3/2 5/3]*pi*20;
errorPosi = 5;
correctY = 0.5;
lightBand = 3;

cd('D:\Dropbox\SNL\P2_Track');
load('neuronList_ori_170421.mat');

condiTN = (cellfun(@max, T.peakFR1D_track) > cMaxPeakFR) & ~(cellfun(@(x) any(isnan(x)),T.peakloci_total));
condiPN = T.spkpvr>cSpkpvr & T.meanFR_task<cMeanFR;
condiIN = ~condiPN;

%% DRun sessions
DRunTN = (T.taskType == 'DRun') & condiTN;
DRunPN = DRunTN & condiPN;
DRunIN = DRunTN & condiIN;

% DRunPN
nCell_DRunPN = sum(double(DRunPN));
normTrackFR_DRunPN = T.normTrackFR_total(DRunPN);
temp_peakloci_DRunPN = T.peakloci_total(DRunPN);
lightResp_track_DRunPN = double(T.pLR_Track(DRunPN)<alpha);
lightAct_track_DRunPN = double(T.pLR_Track(DRunPN)<alpha & T.statDir_Track(DRunPN)==1);
lightIna_track_DRunPN = double(T.pLR_Track(DRunPN)<alpha & T.statDir_Track(DRunPN)==-1);
lightResp_plfm_DRunPN = double(T.pLR_Plfm2hz(DRunPN)<alpha);

normTrackFR_DRunPN(:,2) = num2cell(cellfun(@(x) x(1),temp_peakloci_DRunPN)); % position of peak firing rate
normTrackFR_DRunPN(:,3) = num2cell(lightResp_track_DRunPN); % Resp population
normTrackFR_DRunPN(:,4) = num2cell(lightAct_track_DRunPN); % Act population
normTrackFR_DRunPN(:,5) = num2cell(lightIna_track_DRunPN); % Ina population

normTrackFR_DRunPN = sortrows(normTrackFR_DRunPN,-2);
normTrackFR_DRunPN = cell2mat(normTrackFR_DRunPN);
lightResp_idx_DRunPN = find(normTrackFR_DRunPN(:,126));
lightAct_idx_DRunPN = find(normTrackFR_DRunPN(:,127));
lightIna_idx_DRunPN = find(normTrackFR_DRunPN(:,128));
lightResp_plfm_idx_DRunPN = find(lightResp_plfm_DRunPN);

% DRunIN
nCell_DRunIN = sum(double(DRunIN));
normTrackFR_DRunIN = T.normTrackFR_total(DRunIN);
temp_peakloci_DRunIN = T.peakloci_total(DRunIN);
lightResp_track_DRunIN = double(T.pLR_Track(DRunIN)<alpha);
lightAct_track_DRunIN = double(T.pLR_Track(DRunIN)<alpha & T.statDir_Track(DRunIN)==1);
lightIna_track_DRunIN = double(T.pLR_Track(DRunIN)<alpha & T.statDir_Track(DRunIN)==-1);
lightResp_plfm_DRunIN = double(T.pLR_Plfm2hz(DRunIN)<alpha);

normTrackFR_DRunIN(:,2) = num2cell(cellfun(@(x) x(1),temp_peakloci_DRunIN));
normTrackFR_DRunIN(:,3) = num2cell(lightResp_track_DRunIN); % Resp population
normTrackFR_DRunIN(:,4) = num2cell(lightAct_track_DRunIN); % Act population
normTrackFR_DRunIN(:,5) = num2cell(lightIna_track_DRunIN); % Ina population

normTrackFR_DRunIN = sortrows(normTrackFR_DRunIN,-2);
normTrackFR_DRunIN = cell2mat(normTrackFR_DRunIN);
lightResp_idx_DRunIN = find(normTrackFR_DRunIN(:,126));
lightAct_idx_DRunIN = find(normTrackFR_DRunIN(:,127));
lightIna_idx_DRunIN = find(normTrackFR_DRunIN(:,128));
lightResp_plfm_idx_DRunIN = find(lightResp_plfm_DRunIN);


%% DRw sessions
DRwTN = (T.taskType == 'DRw') & (cellfun(@max, T.peakFR1D_track) > cMaxPeakFR) & ~(cellfun(@(x) any(isnan(x)),T.peakloci_total));
DRwPN = DRwTN & condiPN;
DRwIN = DRwTN & condiIN;

nCell_DRwPN = sum(double(DRwPN));
normTrackFR_DRwPN = T.normTrackFR_total(DRwPN);
temp_peakloci_DRwPN = T.peakloci_total(DRwPN);
lightResp_track_DRwPN = double(T.pLR_Track(DRwPN)<alpha);
lightAct_track_DRwPN = double(T.pLR_Track(DRwPN)<alpha & T.statDir_Track(DRwPN)==1);
lightIna_track_DRwPN = double(T.pLR_Track(DRwPN)<alpha & T.statDir_Track(DRwPN)==-1);
lightResp_plfm_DRwPN = double(T.pLR_Plfm2hz(DRwPN)<alpha);

normTrackFR_DRwPN(:,2) = num2cell(cellfun(@(x) x(1),temp_peakloci_DRwPN));
normTrackFR_DRwPN(:,3) = num2cell(lightResp_track_DRwPN);
normTrackFR_DRwPN(:,4) = num2cell(lightAct_track_DRwPN); % Act population
normTrackFR_DRwPN(:,5) = num2cell(lightIna_track_DRwPN); % Ina population

normTrackFR_DRwPN = sortrows(normTrackFR_DRwPN,-2);
normTrackFR_DRwPN = cell2mat(normTrackFR_DRwPN);
lightResp_idx_DRwPN = find(normTrackFR_DRwPN(:,126));
lightAct_idx_DRwPN = find(normTrackFR_DRwPN(:,127));
lightIna_idx_DRwPN = find(normTrackFR_DRwPN(:,128));
lightResp_plfm_idx_DRwPN = find(lightResp_plfm_DRwPN);

% DRwIN
nCell_DRwIN = sum(double(DRwIN));
normTrackFR_DRwIN = T.normTrackFR_total(DRwIN);
temp_peakloci_DRwIN = T.peakloci_total(DRwIN);
lightResp_track_DRwIN = double(T.pLR_Track(DRwIN)<alpha);
lightAct_track_DRwIN = double(T.pLR_Track(DRwIN)<alpha & T.statDir_Track(DRwIN)==1);
lightIna_track_DRwIN = double(T.pLR_Track(DRwIN)<alpha & T.statDir_Track(DRwIN)==-1);
lightResp_plfm_DRwIN = double(T.pLR_Plfm2hz(DRwIN)<alpha);

normTrackFR_DRwIN(:,2) = num2cell(cellfun(@(x) x(1),temp_peakloci_DRwIN));
normTrackFR_DRwIN(:,3) = num2cell(lightResp_track_DRwIN);
normTrackFR_DRwIN(:,4) = num2cell(lightAct_track_DRwIN); % Act population
normTrackFR_DRwIN(:,5) = num2cell(lightIna_track_DRwIN); % Ina population

normTrackFR_DRwIN = sortrows(normTrackFR_DRwIN,-2);
normTrackFR_DRwIN = cell2mat(normTrackFR_DRwIN);
lightResp_idx_DRwIN = find(normTrackFR_DRwIN(:,126));
lightAct_idx_DRwIN = find(normTrackFR_DRwIN(:,127));
lightIna_idx_DRwIN = find(normTrackFR_DRwIN(:,128));
lightResp_plfm_idx_DRwIN = find(lightResp_plfm_DRwIN);

%% plot
nCol = 4;
nRow = 9;
barH = 1;

fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});
% Figure PN
hHeatmap(1) = axes('Position',axpt(nCol,nRow,1:2,1:7,[0.1 0.1 0.8 0.85],wideInterval));
hField(1) = pcolor(normTrackFR_DRunPN(:,1:124));
hold on;
hLine(1) = line([areaRw1(1)-errorPosi, areaRw1(1)-errorPosi],[0 nCell_DRunPN]);
hold on;
hLine(2) = line([areaRw1(2)-errorPosi, areaRw1(2)-errorPosi],[0 nCell_DRunPN]);
hold on;
hLine(3) = line([areaRw2(1)-errorPosi, areaRw2(1)-errorPosi],[0 nCell_DRunPN]);
hold on;
hLine(4) = line([areaRw2(2)-errorPosi, areaRw2(2)-errorPosi],[0 nCell_DRunPN]);

for iMark = 1:length(lightResp_idx_DRunPN)
    fill([126, 127, 127, 126],[lightResp_idx_DRunPN(iMark)-1, lightResp_idx_DRunPN(iMark)-1, lightResp_idx_DRunPN(iMark), lightResp_idx_DRunPN(iMark)],colorGreen,'EdgeColor','none');
end
for iMark = 1:length(lightAct_idx_DRunPN)
    fill([128, 129, 129, 128],[lightAct_idx_DRunPN(iMark)-1, lightAct_idx_DRunPN(iMark)-1, lightAct_idx_DRunPN(iMark), lightAct_idx_DRunPN(iMark)],colorBlue,'EdgeColor','none');
end
for iMark = 1:length(lightIna_idx_DRunPN)
    fill([130, 131, 131, 130],[lightIna_idx_DRunPN(iMark)-1, lightIna_idx_DRunPN(iMark)-1, lightIna_idx_DRunPN(iMark), lightIna_idx_DRunPN(iMark)],colorRed,'EdgeColor','none');
end
for iMark = 1:length(lightResp_plfm_idx_DRunPN)
    fill([132 133 133 132],[lightResp_plfm_idx_DRunPN(iMark)-1, lightResp_plfm_idx_DRunPN(iMark)-1, lightResp_plfm_idx_DRunPN(iMark), lightResp_plfm_idx_DRunPN(iMark)],colorBlack,'EdgeColor','none');
end

xlabel('Position (cm)','fontSize',fontL);
ylabel('Cell ID','fontSize',fontL);
text(0,-20,['Green: Light Resp (n = ',num2str(length(lightResp_idx_DRunPN)),')'],'color',colorGreen,'fontSize',fontL);
text(65,-20,['Blue: Light Act (n = ',num2str(length(lightAct_idx_DRunPN)),')'],'color',colorBlue,'fontSize',fontL);
text(0,-25,['Red: Light Ina (n = ',num2str(length(lightIna_idx_DRunPN)),')'],'color',colorRed,'fontSize',fontL);
text(65,-25,['Yellow: Light Resp (Plfm 2hz) (n = ',num2str(length(lightResp_plfm_idx_DRunPN)),')'],'color',colorBlack,'fontSize',fontL);
text(28,250,'Reward','color',colorWhite,'fontSize',fontL);
text(92,250,'Reward','color',colorWhite,'fontSize',fontL);
title('DRun sessions (PN)','fontSize',fontXL,'fontWeight','bold');


hHeatmap(2) = axes('Position',axpt(nCol,nRow,3:4,1:7,[0.1 0.1 0.8 0.85],wideInterval));
hField(2) = pcolor(normTrackFR_DRwPN(:,1:124));
hold on;
hLine(5) = line([areaRw1(1)-errorPosi, areaRw1(1)-errorPosi],[0 nCell_DRwPN]);
hold on;
hLine(6) = line([areaRw1(2)-errorPosi, areaRw1(2)-errorPosi],[0 nCell_DRwPN]);
hold on;
hLine(7) = line([areaRw2(1)-errorPosi, areaRw2(1)-errorPosi],[0 nCell_DRwPN]);
hold on;
hLine(8) = line([areaRw2(2)-errorPosi, areaRw2(2)-errorPosi],[0 nCell_DRwPN]);

for iMark = 1:length(lightResp_idx_DRwPN)
    fill([126, 127, 127, 126],[lightResp_idx_DRwPN(iMark)-1, lightResp_idx_DRwPN(iMark)-1, lightResp_idx_DRwPN(iMark), lightResp_idx_DRwPN(iMark)],colorGreen,'EdgeColor','none');
end
for iMark = 1:length(lightAct_idx_DRwPN)
    fill([128, 129, 129, 128],[lightAct_idx_DRwPN(iMark)-1, lightAct_idx_DRwPN(iMark)-1, lightAct_idx_DRwPN(iMark), lightAct_idx_DRwPN(iMark)],colorBlue,'EdgeColor','none');
end
for iMark = 1:length(lightIna_idx_DRwPN)
    fill([130, 131, 131, 130],[lightIna_idx_DRwPN(iMark)-1, lightIna_idx_DRwPN(iMark)-1, lightIna_idx_DRwPN(iMark), lightIna_idx_DRwPN(iMark)],colorRed,'EdgeColor','none');
end
for iMark = 1:length(lightResp_plfm_idx_DRwPN)
    fill([132 133 133 132],[lightResp_plfm_idx_DRwPN(iMark)-1, lightResp_plfm_idx_DRwPN(iMark)-1, lightResp_plfm_idx_DRwPN(iMark), lightResp_plfm_idx_DRwPN(iMark)],colorBlack,'EdgeColor','none');
end

xlabel('Position (cm)','fontSize',fontL);
ylabel('Cell ID','fontSize',fontL);
text(0,-20,['Green: Light Resp (n = ',num2str(length(lightResp_idx_DRwPN)),')'],'color',colorGreen,'fontSize',fontL);
text(65,-20,['Blue: Light Act (n = ',num2str(length(lightAct_idx_DRwPN)),')'],'color',colorBlue,'fontSize',fontL);
text(0,-25,['Red: Light Ina (n = ',num2str(length(lightIna_idx_DRwPN)),')'],'color',colorRed,'fontSize',fontL);
text(65,-25,['Yellow: Light Resp (Plfm 2hz) (n = ',num2str(length(lightResp_plfm_idx_DRwPN)),')'],'color',colorBlack,'fontSize',fontL);
title('DRw sessions (PN)','fontSize',fontXL,'fontWeight','bold');


% figure IN
hHeatmap(3) = axes('Position',axpt(nCol,nRow,1:2,8:9,[0.1 0.1 0.8 0.85],wideInterval));
hField(3) = pcolor(normTrackFR_DRunIN(:,1:124));
hold on;
hLine(9) = line([areaRw1(1)-errorPosi, areaRw1(1)-errorPosi],[0 nCell_DRunIN]);
hold on;
hLine(10) = line([areaRw1(2)-errorPosi, areaRw1(2)-errorPosi],[0 nCell_DRunIN]);
hold on;
hLine(11) = line([areaRw2(1)-errorPosi, areaRw2(1)-errorPosi],[0 nCell_DRunIN]);
hold on;
hLine(12) = line([areaRw2(2)-errorPosi, areaRw2(2)-errorPosi],[0 nCell_DRunIN]);
hold on;
pPatch(1) = patch([areaDRun(1)-errorPosi, areaDRun(2)+errorPosi, areaDRun(2)+errorPosi, areaDRun(1)-errorPosi],[-lightBand, -lightBand, barH, barH],colorBlue);

for iMark = 1:length(lightResp_idx_DRunIN)
    fill([126, 127, 127, 126],[lightResp_idx_DRunIN(iMark)-1, lightResp_idx_DRunIN(iMark)-1, lightResp_idx_DRunIN(iMark), lightResp_idx_DRunIN(iMark)],colorGreen,'EdgeColor','none');
end
for iMark = 1:length(lightAct_idx_DRunIN)
    fill([128, 129, 129, 128],[lightAct_idx_DRunIN(iMark)-1, lightAct_idx_DRunIN(iMark)-1, lightAct_idx_DRunIN(iMark), lightAct_idx_DRunIN(iMark)],colorBlue,'EdgeColor','none');
end
for iMark = 1:length(lightIna_idx_DRunIN)
    fill([130, 131, 131, 130],[lightIna_idx_DRunIN(iMark)-1, lightIna_idx_DRunIN(iMark)-1, lightIna_idx_DRunIN(iMark), lightIna_idx_DRunIN(iMark)],colorRed,'EdgeColor','none');
end
for iMark = 1:length(lightResp_plfm_idx_DRunIN)
    fill([132 133 133 132],[lightResp_plfm_idx_DRunIN(iMark)-1, lightResp_plfm_idx_DRunIN(iMark)-1, lightResp_plfm_idx_DRunIN(iMark), lightResp_plfm_idx_DRunIN(iMark)],colorBlack,'EdgeColor','none');
end

xlabel('Position (cm)','fontSize',fontL);
ylabel('Cell ID','fontSize',fontL);
text(0,-20,['Green: Light Resp (n = ',num2str(length(lightResp_idx_DRunIN)),')'],'color',colorGreen,'fontSize',fontL);
text(65,-20,['Blue: Light Act (n = ',num2str(length(lightAct_idx_DRunIN)),')'],'color',colorBlue,'fontSize',fontL);
text(0,-25,['Red: Light Ina (n = ',num2str(length(lightIna_idx_DRunIN)),')'],'color',colorRed,'fontSize',fontL);
text(65,-25,['Yellow: Light Resp (Plfm 2hz) (n = ',num2str(length(lightResp_plfm_idx_DRunIN)),')'],'color',colorBlack,'fontSize',fontL);
title('DRun sessions (IN)','fontSize',fontXL,'fontWeight','bold');


hHeatmap(4) = axes('Position',axpt(nCol,nRow,3:4,8:9,[0.1 0.1 0.8 0.85],wideInterval));
hField(4) = pcolor(normTrackFR_DRwIN(:,1:124));
hold on;
hLine(13) = line([areaRw1(1)-errorPosi, areaRw1(1)-errorPosi],[0 nCell_DRwIN]);
hold on;
hLine(14) = line([areaRw1(2)-errorPosi, areaRw1(2)-errorPosi],[0 nCell_DRwIN]);
hold on;
hLine(15) = line([areaRw2(1)-errorPosi, areaRw2(1)-errorPosi],[0 nCell_DRwIN]);
hold on;
hLine(16) = line([areaRw2(2)-errorPosi, areaRw2(2)-errorPosi],[0 nCell_DRwIN]);
hold on;
pPatch(2) = patch([areaDRw(1)-errorPosi, areaDRw(2)+errorPosi, areaDRw(2)+errorPosi, areaDRw(1)-errorPosi],[-lightBand, -lightBand, barH, barH],colorBlue);
xlabel('Position (cm)','fontSize',fontL);
ylabel('Cell ID','fontSize',fontL);

for iMark = 1:length(lightResp_idx_DRwIN)
    fill([126, 127, 127, 126],[lightResp_idx_DRwIN(iMark)-1, lightResp_idx_DRwIN(iMark)-1, lightResp_idx_DRwIN(iMark), lightResp_idx_DRwIN(iMark)],colorGreen,'EdgeColor','none');
end
for iMark = 1:length(lightAct_idx_DRwIN)
    fill([128, 129, 129, 128],[lightAct_idx_DRwIN(iMark)-1, lightAct_idx_DRwIN(iMark)-1, lightAct_idx_DRwIN(iMark), lightAct_idx_DRwIN(iMark)],colorBlue,'EdgeColor','none');
end
for iMark = 1:length(lightIna_idx_DRwIN)
    fill([130, 131, 131, 130],[lightIna_idx_DRwIN(iMark)-1, lightIna_idx_DRwIN(iMark)-1, lightIna_idx_DRwIN(iMark), lightIna_idx_DRwIN(iMark)],colorRed,'EdgeColor','none');
end
for iMark = 1:length(lightResp_plfm_idx_DRwIN)
    fill([132 133 133 132],[lightResp_plfm_idx_DRwIN(iMark)-1, lightResp_plfm_idx_DRwIN(iMark)-1, lightResp_plfm_idx_DRwIN(iMark), lightResp_plfm_idx_DRwIN(iMark)],colorBlack,'EdgeColor','none');
end

text(0,-15,['Green: Light Resp (n = ',num2str(length(lightResp_idx_DRwIN)),')'],'color',colorGreen,'fontSize',fontL);
text(65,-15,['Blue: Light Act (n = ',num2str(length(lightAct_idx_DRwIN)),')'],'color',colorBlue,'fontSize',fontL);
text(0,-18,['Red: Light Ina (n = ',num2str(length(lightIna_idx_DRwIN)),')'],'color',colorRed,'fontSize',fontL);
text(65,-18,['Yellow: Light Resp (Plfm 2hz) (n = ',num2str(length(lightResp_plfm_idx_DRwIN)),')'],'color',colorBlack,'fontSize',fontL);
title('DRw sessions (IN)','fontSize',fontXL,'fontWeight','bold');


set(hField,'linestyle','none');
set(hHeatmap,'Box','off','TickDir','out','XLim',[1,134],'XTick',0:10:120)
set(hHeatmap(1),'YLim',[1,nCell_DRunPN],'YTick',[1, nCell_DRunPN],'YTickLabel',[1, nCell_DRunPN],'fontSize',fontL);
set(hHeatmap(2),'YLim',[1,nCell_DRwPN],'YTick',[1, nCell_DRwPN],'YTickLabel',[1, nCell_DRwPN],'fontSize',fontL);
set(hHeatmap(3),'YLim',[-2,nCell_DRunIN],'YTick',[1, nCell_DRunIN],'YTickLabel',[1, nCell_DRunIN],'fontSize',fontL);
set(hHeatmap(4),'YLim',[-2,nCell_DRwIN],'YTick',[1, nCell_DRwIN],'YTickLabel',[1, nCell_DRwIN],'fontSize',fontL);
set(pPatch,'LineStyle','none','FaceAlpha',1);
set(hLine(1:8),'lineStyle','--','color',colorWhite,'lineWidth',lineL);
set(hLine(9:16),'lineStyle','--','color',colorBlack,'lineWidth',lineL);

formatOut = 'yymmdd';
print('-painters','-r300','-dtiff',['gplot_placeField_',datestr(now,formatOut),'.tif']);