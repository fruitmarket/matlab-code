% Latency of neurons which are activated on the platform. (Blue)
% Among neurons which are activated on the platform, latency of neurons which are also activated on the track

% common part
clearvars;

cd('D:\Dropbox\SNL\P2_Track'); % win version
% cd('/Users/Jun/Dropbox/SNL/P2_Track'); % mac version
Txls = readtable('neuronList_ori_171018.xlsx');
load('neuronList_ori_171018.mat');
load myParameters.mat;
Txls.latencyIndex = categorical(Txls.latencyIndex);
formatOut = 'yymmdd';
alpha = 0.01;

% DRunPN = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
DRunPN = T.taskType == 'DRun' & T.idxNeurontype == 'PN';
DRunIN = T.taskType == 'DRun' & T.idxNeurontype == 'IN';
DRun_UNC = T.taskType == 'DRun' & T.idxNeurontype == 'UNC';

PN_act = DRunPN & T.idxpLR_Track & T.statDir_TrackN == 1;
PN_ina = DRunPN & T.idxpLR_Track & T.statDir_TrackN == -1;
PN_no = DRunPN & ~T.idxpLR_Track;

IN_act = DRunIN & T.idxpLR_Track & T.statDir_TrackN == 1;
IN_ina = DRunIN & T.idxpLR_Track & T.statDir_TrackN == -1;
IN_no = DRunIN & ~T.idxpLR_Track;

% Bais corrected (minimum firing rate thresold is applied)
mfr_zone = T.sensorMeanFR_DRun(PN_ina);
mean_mfr_zone = min(cellfun(@(x) mean(x(1:30)),mfr_zone));
% mfr_zone = T.sum_inzoneSpike(PN_ina);
% m_minspk_zone = min(cellfun(@(x) x(1), mfr_zone));

populPassDRun = ((cellfun(@(x) min(mean(x(31:60))),T.sensorMeanFR_DRun)) >= mean_mfr_zone); % neurons that passed threshold fr
populPassActDRun = DRunPN & T.idxpLR_Track & (T.statDir_TrackN == 1) & populPassDRun;
populPassInaDRun = DRunPN & T.idxpLR_Track & (T.statDir_TrackN == -1) & populPassDRun;
populPassNorespDRun = DRunPN & ~T.idxpLR_Track & populPassDRun;

populNopassDRun = ~populPassDRun;
populNopassActDRun = DRunPN & T.idxpLR_Track & (T.statDir_TrackN == 1) & populNopassDRun;
populNopassInaDRun = DRunPN & T.idxpLR_Track & (T.statDir_TrackN == -1) & populNopassDRun;
populNopassNorespDRun = DRunPN & ~T.idxpLR_Track & populNopassDRun;

nOriDRun = [sum(double(PN_act)), sum(double(PN_ina)), sum(double(PN_no))]/sum([sum(double(PN_act)), sum(double(PN_ina)), sum(double(PN_no))])*100;
nPassDRun = [sum(double(populPassActDRun)), sum(double(populPassInaDRun)), sum(double(populPassNorespDRun))]/sum([sum(double(populPassActDRun)), sum(double(populPassInaDRun)), sum(double(populPassNorespDRun))])*100;
nNopassDRun = [sum(double(populNopassActDRun)), sum(double(populNopassInaDRun)), sum(double(populNopassNorespDRun))];

%% DRw session
% DRwPN = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
DRwPN = T.taskType == 'DRw' & T.idxNeurontype == 'PN';
DRwIN = T.taskType == 'DRw' & T.idxNeurontype == 'IN';
DRw_UNC = T.taskType == 'DRw' & T.idxNeurontype == 'UNC';

PN_act = DRwPN & T.idxpLR_Track & T.statDir_TrackN == 1;
PN_ina = DRwPN & T.idxpLR_Track & T.statDir_TrackN == -1;
PN_no = DRwPN & ~T.idxpLR_Track;

IN_act = DRwIN & T.idxpLR_Track & T.statDir_TrackN == 1;
IN_ina = DRwIN & T.idxpLR_Track & T.statDir_TrackN == -1;
IN_no = DRwIN & ~T.idxpLR_Track;

% Bais corrected (minimum firing rate thresold is applied)
mfr_zone = T.sensorMeanFR_DRw(PN_ina);
mean_mfr_zone = min(cellfun(@(x) mean(x(1:30)),mfr_zone));
% mfr_zone = T.sum_inzoneSpike(PN_ina);
% m_minspk_zone = min(cellfun(@(x) x(1), mfr_zone));

populPassDRw = ((cellfun(@(x) min(mean(x(31:60))),T.sensorMeanFR_DRw)) >= mean_mfr_zone); % neurons that passed threshold fr
populPassActDRw = DRwPN & T.idxpLR_Track & (T.statDir_TrackN == 1) & populPassDRw;
populPassInaDRw = DRwPN & T.idxpLR_Track & (T.statDir_TrackN == -1) & populPassDRw;
populPassNorespDRw = DRwPN & ~T.idxpLR_Track & populPassDRw;

populNopassDRw = ~populPassDRw;
populNopassActDRw = DRwPN & T.idxpLR_Track & (T.statDir_TrackN == 1) & populNopassDRw;
populNopassInaDRw = DRwPN & T.idxpLR_Track & (T.statDir_TrackN == -1) & populNopassDRw;
populNopassNorespDRw = DRwPN & ~T.idxpLR_Track & populNopassDRw;

nOriDRw = [sum(double(PN_act)), sum(double(PN_ina)), sum(double(PN_no))]/sum([sum(double(PN_act)), sum(double(PN_ina)), sum(double(PN_no))])*100;
nPassDRw = [sum(double(populPassActDRw)), sum(double(populPassInaDRw)), sum(double(populPassNorespDRw))]/sum([sum(double(populPassActDRw)), sum(double(populPassInaDRw)), sum(double(populPassNorespDRw))])*100;
nNopassDRw = [sum(double(populNopassActDRw)), sum(double(populNopassInaDRw)), sum(double(populNopassNorespDRw))];

%% plot
xptBefore = [1,4,7];
xptAfter = [2,5,8];

fHandle = figure('PaperUnits','centimeters','PaperPosition',[0 0 9 4]);
hBar(1) = axes('Position',axpt(2,1,1,1,[0.1 0.1 0.85 0.80],wideInterval));
bar(xptBefore, nOriDRun, 0.2, 'faceColor', colorGray);
hold on;
bar(xptAfter, nPassDRun, 0.2, 'faceColor', colorBlack);
text(1,93,['Before correction'],'fontSize',fontS,'color',colorDarkGray);
text(1,88,['After correction'],'fontSize',fontS,'color',colorBlack);
ylabel('Proportion (%)','fontSize',fontS);

hBar(2) = axes('Position',axpt(2,1,2,1,[0.1 0.1 0.85 0.80],wideInterval));
bar(xptBefore, nOriDRw, 0.2, 'faceColor', colorGray);
hold on;
bar(xptAfter, nPassDRw, 0.2, 'faceColor', colorBlack);
ylabel('Proportion (%)','fontSize',fontS);

set(hBar,'Box','off','TickDir','out','XLim',[0,9],'XTick',[1.5 4.5 7.5],'XTickLabel',{'Activated';'Inactivated';'No respond'},'fontSize',fontS);
set(hBar,'YLim',[0,100],'YTick',[0:10:100]);
print('-painters','-dtiff','-r300',['final_fig3_biasCorrection_',datestr(now,formatOut),'.tif']);
print('-painters','-depsc','-r300',['final_fig3_biasCorrection_',datestr(now,formatOut),'.ai']);
close;