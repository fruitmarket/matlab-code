% The file plot light evoked spike probability of two sessions (DRun & DRw)
% criFR: pn/in criteria
% 

% common part
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

Txls = readtable('neuronList_02-Mar-2017.xlsx');
load('neuronList_ori_05-Mar-2017.mat');

criPeakFR = 7;
criMeanFR = 3;
alpha = 0.005;
figName = 'plot_sessionEvokedSpikeProb.tif';
T.taskType = categorical(T.taskType);
compareID = ~isnan(Txls.compCellID);

DRunTN = (T.taskType == 'DRun') & (cellfun(@max, T.peakFR1D_track) > criMeanFR) & compareID;
DRwTN = (T.taskType == 'DRw') & (cellfun(@max, T.peakFR1D_track) > criMeanFR) & compareID;
noRunTN = (T.taskType == 'noRun') & (cellfun(@max, T.peakFR1D_track) > criMeanFR) & compareID;
noRwTN = (T.taskType == 'noRw') & (cellfun(@max, T.peakFR1D_track) > criMeanFR) & compareID;

DRunPN = (T.taskType == 'DRun') & (cellfun(@max, T.peakFR1D_track) > criMeanFR) & compareID & T.meanFR_task<=criPeakFR;
DRwPN = (T.taskType == 'DRw') & (cellfun(@max, T.peakFR1D_track) > criMeanFR) & compareID & T.meanFR_task<=criPeakFR;

DRunIN = (T.taskType == 'DRun') & (cellfun(@max, T.peakFR1D_track) > criMeanFR) & compareID & T.meanFR_task>criPeakFR;
DRwIN = (T.taskType == 'DRw') & (cellfun(@max, T.peakFR1D_track) > criMeanFR) & compareID & T.meanFR_task>criPeakFR;

commonIdxTN = intersect(Txls.compCellID(DRunTN),Txls.compCellID(DRwTN));
nCellTN = length(commonIdxTN);
[DRunSpkProb_track, DRunSpkProb_plfm, DRwSpkProb_track, DRwSpkProb_plfm] = deal(zeros(nCellTN,1));

commonIdxPN = intersect(Txls.compCellID(DRunPN),Txls.compCellID(DRwPN));
nCellPN = length(commonIdxPN);
[DRunSpkProb_trackPN, DRunSpkProb_plfmPN, DRwSpkProb_trackPN, DRwSpkProb_plfmPN] = deal(zeros(nCellPN,1));

commonIdxIN = intersect(Txls.compCellID(DRunIN),Txls.compCellID(DRwIN));
nCellIN = length(commonIdxIN);
[DRunSpkProb_trackIN, DRunSpkProb_plfmIN, DRwSpkProb_trackIN, DRwSpkProb_plfmIN] = deal(zeros(nCellIN,1));

% Total neuron
for iCell = 1:nCellTN
    DRunSpkProb_track(iCell) = T.lightProbTrack_8hz(Txls.compCellID == commonIdxTN(iCell) & T.taskType == 'DRun');
    DRunSpkProb_plfm(iCell) = T.lightProbPlfm_2hz(Txls.compCellID == commonIdxTN(iCell) & T.taskType == 'DRun');
    DRwSpkProb_track(iCell) = T.lightProbTrack_8hz(Txls.compCellID == commonIdxTN(iCell) & T.taskType == 'DRw');
    DRwSpkProb_plfm(iCell) = T.lightProbPlfm_2hz(Txls.compCellID == commonIdxTN(iCell) & T.taskType == 'DRw');
end

% PN only
for iCell = 1:nCellPN
    DRunSpkProb_trackPN(iCell) = T.lightProbTrack_8hz(Txls.compCellID == commonIdxPN(iCell) & T.taskType == 'DRun');
    DRunSpkProb_plfmPN(iCell) = T.lightProbPlfm_2hz(Txls.compCellID == commonIdxPN(iCell) & T.taskType == 'DRun');
    DRwSpkProb_trackPN(iCell) = T.lightProbTrack_8hz(Txls.compCellID == commonIdxPN(iCell) & T.taskType == 'DRw');
    DRwSpkProb_plfmPN(iCell) = T.lightProbPlfm_2hz(Txls.compCellID == commonIdxPN(iCell) & T.taskType == 'DRw');
end

% IN only
for iCell = 1:nCellIN
    DRunSpkProb_trackIN(iCell) = T.lightProbTrack_8hz(Txls.compCellID == commonIdxIN(iCell) & T.taskType == 'DRun');
    DRunSpkProb_plfmIN(iCell) = T.lightProbPlfm_2hz(Txls.compCellID == commonIdxIN(iCell) & T.taskType == 'DRun');
    DRwSpkProb_trackIN(iCell) = T.lightProbTrack_8hz(Txls.compCellID == commonIdxIN(iCell) & T.taskType == 'DRw');
    DRwSpkProb_plfmIN(iCell) = T.lightProbPlfm_2hz(Txls.compCellID == commonIdxIN(iCell) & T.taskType == 'DRw');
end

%%
nCol = 2;
nRow = 3;
fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{2},'Name','Evoked spikes between sessions');
hSpkProb = axes('Position',axpt(nCol,nRow,1,1:3,[0.1 0.1 0.85 0.85],wideInterval));
plot([1-0.05,2-0.05,3-0.05,4-0.05],[DRunSpkProb_trackPN,DRunSpkProb_plfmPN,DRwSpkProb_trackPN,DRwSpkProb_plfmPN],'-o','color',colorGray,'lineWidth',1.5,'MarkerFaceColor',colorBlue,'MarkerEdgeColor',colorBlack);
hold on;
plot([1+0.05,2+0.05,3+0.05,4+0.05],[DRunSpkProb_trackIN,DRunSpkProb_plfmIN,DRwSpkProb_trackIN,DRwSpkProb_plfmIN],'-o','color',colorGray,'lineWidth',1.5,'MarkerFaceColor',colorRed,'MarkerEdgeColor',colorBlack);
text(4.5, 80, ['PN (n = ', num2str(nCellPN),')'],'fontSize',fontL,'color',colorBlue);
text(4.5, 75, ['IN (n = ', num2str(nCellIN),')'],'fontSize',fontL,'color',colorRed);
ylabel('Spike P, %','fontSize',fontXL);
title('Evoked spike probability','fontSize',fontL,'fontWeight','bold');

set(hSpkProb,'Box','off','TickDir','out','XLim',[0,5],'XTick',[1:4],'XTickLabel',{'DRunTrack'; 'DRunPlfm'; 'DRwTrack'; 'DRwPlfm'},'YLim',[-5,100])
print('-painters','-r300',figName,'-dtiff');