clearvars;
rtDir = 'D:\Dropbox\SNL\P2_Track';
cd(rtDir);

alpha = 0.01;
areaDRw = [5/6 4/3]*pi*20; % 6-9 o'clock
areaDRw = [3/2 5/3]*pi*20; % 10-11 o'clock
areaRw1 = [1/2 2/3]*pi*20; % 4-5 o'clock
areaRw2 = [3/2 5/3]*pi*20; % 10-11 o'clock
errorPosi = 5;
correctY = 0.5;
lightBand = 3;

%% Loading cell information
load('D:\Dropbox\SNL\P2_Track\myParameters.mat');
% load('neuronList_ori_control_171014.mat');
% Tcon = T;
load('neuronList_ori_171015.mat');

formatOut = 'yymmdd';

% light
l_PF_inField_act = sum(double((T.taskType == 'DRw') & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOutPRE & T.idxmFrIn == 1));
l_PF_inField_ina = sum(double((T.taskType == 'DRw') & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOutPRE & T.idxmFrIn == -1));
l_PF_inField_no = sum(double((T.taskType == 'DRw') & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOutPRE & T.idxmFrIn == 0));
% nolight
nol_PF_inField_act = sum(double((T.taskType == 'noRun') & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOutPRE & T.idxmFrIn == 1));
nol_PF_inField_ina = sum(double((T.taskType == 'noRun') & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOutPRE & T.idxmFrIn == -1));
nol_PF_inField_no = sum(double((T.taskType == 'noRun') & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOutPRE & T.idxmFrIn == 0));
% control
% con_PF_inField_act = sum(double((Tcon.taskType == 'DRw') & Tcon.idxNeurontype == 'PN' & Tcon.idxPeakFR & Tcon.idxPlaceField & Tcon.idxTotalSpikeNum & Tcon.idxZoneInOutSTM & Tcon.idxmFrIn == 1));
% con_PF_inField_ina = sum(double((Tcon.taskType == 'DRw') & Tcon.idxNeurontype == 'PN' & Tcon.idxPeakFR & Tcon.idxPlaceField & Tcon.idxTotalSpikeNum & Tcon.idxZoneInOutSTM & Tcon.idxmFrIn == -1));
% con_PF_inField_no = sum(double((Tcon.taskType == 'DRw') & Tcon.idxNeurontype == 'PN' & Tcon.idxPeakFR & Tcon.idxPlaceField & Tcon.idxTotalSpikeNum & Tcon.idxZoneInOutSTM & Tcon.idxmFrIn == 0));

l_PF_outField_act = sum(double(T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOutPRE & T.idxmFrIn == 1));
l_PF_outField_ina = sum(double((T.taskType == 'DRw') & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOutPRE & T.idxmFrIn == -1));
l_PF_outField_no = sum(double((T.taskType == 'DRw') & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOutPRE & T.idxmFrIn == 0));
nol_PF_outField_act = sum(double((T.taskType == 'noRun') & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOutPRE & T.idxmFrIn == 1));
nol_PF_outField_ina = sum(double((T.taskType == 'noRun') & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOutPRE & T.idxmFrIn == -1));
nol_PF_outField_no = sum(double((T.taskType == 'noRun') & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOutPRE & T.idxmFrIn == 0));
% con_PF_outField_act = sum(double((Tcon.taskType == 'DRw') & Tcon.idxNeurontype == 'PN' & Tcon.idxPeakFR & Tcon.idxPlaceField & Tcon.idxTotalSpikeNum & ~Tcon.idxZoneInOutSTM & Tcon.idxmFrOut == 1));
% con_PF_outField_ina = sum(double((Tcon.taskType == 'DRw') & Tcon.idxNeurontype == 'PN' & Tcon.idxPeakFR & Tcon.idxPlaceField & Tcon.idxTotalSpikeNum & ~Tcon.idxZoneInOutSTM & Tcon.idxmFrOut == -1));
% con_PF_outField_no = sum(double((Tcon.taskType == 'DRw') & Tcon.idxNeurontype == 'PN' & Tcon.idxPeakFR & Tcon.idxPlaceField & Tcon.idxTotalSpikeNum & ~Tcon.idxZoneInOutSTM & Tcon.idxmFrOut == 0));

l_NPF_act = sum(double((T.taskType == 'DRw') & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxmFrIn == 1));
l_NPF_ina = sum(double((T.taskType == 'DRw') & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxmFrIn == -1));
l_NPF_no = sum(double((T.taskType == 'DRw') & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxmFrIn == 0));
nol_NPF_act = sum(double((T.taskType == 'noRun') & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxmFrIn == 1));
nol_NPF_ina = sum(double((T.taskType == 'noRun') & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxmFrIn == -1));
nol_NPF_no = sum(double((T.taskType == 'noRun') & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxmFrIn == 0));
% con_NPF_act = sum(double((Tcon.taskType == 'DRw') & Tcon.idxNeurontype == 'PN' & ~(Tcon.idxPeakFR & Tcon.idxPlaceField & Tcon.idxTotalSpikeNum) & Tcon.idxmFrTotal == 1));
% con_NPF_ina = sum(double((Tcon.taskType == 'DRw') & Tcon.idxNeurontype == 'PN' & ~(Tcon.idxPeakFR & Tcon.idxPlaceField & Tcon.idxTotalSpikeNum) & Tcon.idxmFrTotal == -1));
% con_NPF_no = sum(double((Tcon.taskType == 'DRw') & Tcon.idxNeurontype == 'PN' & ~(Tcon.idxPeakFR & Tcon.idxPlaceField & Tcon.idxTotalSpikeNum) & Tcon.idxmFrTotal == 0));

lightPF_in = [l_PF_inField_act, l_PF_inField_ina, l_PF_inField_no]/sum([l_PF_inField_act, l_PF_inField_ina, l_PF_inField_no])*100;
nolightPF_in = [nol_PF_inField_act, nol_PF_inField_ina, nol_PF_inField_no]/sum([nol_PF_inField_act, nol_PF_inField_ina, nol_PF_inField_no])*100;
% conPF_in = [con_PF_inField_act, con_PF_inField_ina, con_PF_inField_no]/sum([con_PF_inField_act, con_PF_inField_ina, con_PF_inField_no])*100;

% lightPF_diff = [l_PF_outField_act, l_PF_outField_ina, l_PF_outField_no];
% nolightPF_diff = [nol_PF_outField_act, nol_PF_outField_ina, nol_PF_outField_no];
lightPF_diff = [l_PF_outField_act, l_PF_outField_ina, l_PF_outField_no] + [l_NPF_act, l_NPF_ina, l_NPF_no];
nolightPF_diff = [nol_PF_outField_act, nol_PF_outField_ina, nol_PF_outField_no] + [nol_NPF_act, nol_NPF_ina, nol_NPF_no];
% conPF_diff = [con_PF_outField_act, con_PF_outField_ina, con_PF_outField_no] + [con_NPF_act, con_NPF_ina, con_NPF_no];

ratio_lightPF_diff = lightPF_diff/sum(lightPF_diff)*100;
ratio_nolightPF_diff = nolightPF_diff/sum(nolightPF_diff)*100;
% ratio_conPF_diff = conPF_diff/sum(conPF_diff)*100;

%%
l_PN_act = sum(double((T.taskType == 'DRw') & T.idxNeurontype == 'PN' & T.idxmFrTotal == 1));
l_PN_ina = sum(double((T.taskType == 'DRw') & T.idxNeurontype == 'PN' & T.idxmFrTotal == -1));
l_PN_no = sum(double((T.taskType == 'DRw') & T.idxNeurontype == 'PN' & T.idxmFrTotal == 0));
nol_PN_act = sum(double((T.taskType == 'noRun') & T.idxNeurontype == 'PN' & T.idxmFrTotal == 1));
nol_PN_ina = sum(double((T.taskType == 'noRun') & T.idxNeurontype == 'PN' & T.idxmFrTotal == -1));
nol_PN_no = sum(double((T.taskType == 'noRun') & T.idxNeurontype == 'PN' & T.idxmFrTotal == 0));
% con_PN_act = sum(double((Tcon.taskType == 'DRw') & Tcon.idxNeurontype == 'PN' & Tcon.idxmFrTotal == 1));
% con_PN_ina = sum(double((Tcon.taskType == 'DRw') & Tcon.idxNeurontype == 'PN' & Tcon.idxmFrTotal == -1));
% con_PN_no = sum(double((Tcon.taskType == 'DRw') & Tcon.idxNeurontype == 'PN' & Tcon.idxmFrTotal == 0));
l_PN = [l_PN_act, l_PN_ina, l_PN_no]/sum([l_PN_act, l_PN_ina, l_PN_no])*100;
nol_PN = [nol_PN_act, nol_PN_ina, nol_PN_no]/sum([nol_PN_act, nol_PN_ina, nol_PN_no])*100;
% con_PN = [con_PN_act, con_PN_ina, con_PN_no]/sum([con_PN_act, con_PN_ina, con_PN_no])*100;

l_IN_act = sum(double((T.taskType == 'DRw') & T.idxNeurontype == 'IN' & T.idxmFrTotal == 1));
l_IN_ina = sum(double((T.taskType == 'DRw') & T.idxNeurontype == 'IN' & T.idxmFrTotal == -1));
l_IN_no = sum(double((T.taskType == 'DRw') & T.idxNeurontype == 'IN' & T.idxmFrTotal == 0));
nol_IN_act = sum(double((T.taskType == 'noRun') & T.idxNeurontype == 'IN' & T.idxmFrTotal == 1));
nol_IN_ina = sum(double((T.taskType == 'noRun') & T.idxNeurontype == 'IN' & T.idxmFrTotal == -1));
nol_IN_no = sum(double((T.taskType == 'noRun') & T.idxNeurontype == 'IN' & T.idxmFrTotal == 0));
% con_IN_act = sum(double((Tcon.taskType == 'DRw') & Tcon.idxNeurontype == 'IN' & Tcon.idxmFrTotal == 1));
% con_IN_ina = sum(double((Tcon.taskType == 'DRw') & Tcon.idxNeurontype == 'IN' & Tcon.idxmFrTotal == -1));
% con_IN_no = sum(double((Tcon.taskType == 'DRw') & Tcon.idxNeurontype == 'IN' & Tcon.idxmFrTotal == 0));
l_IN = [l_IN_act, l_IN_ina, l_IN_no]/sum([l_IN_act, l_IN_ina, l_IN_no])*100;
nol_IN = [nol_IN_act, nol_IN_ina, nol_IN_no]/sum([nol_IN_act, nol_IN_ina, nol_IN_no])*100;
% con_IN = [con_IN_act, con_IN_ina, con_IN_no]/sum([con_IN_act, con_IN_ina, con_IN_no])*100;

l_UNC_act = sum(double((T.taskType == 'DRw') & T.idxNeurontype == 'UNC' & T.idxmFrTotal == 1));
l_UNC_ina = sum(double((T.taskType == 'DRw') & T.idxNeurontype == 'UNC' & T.idxmFrTotal == -1));
l_UNC_no = sum(double((T.taskType == 'DRw') & T.idxNeurontype == 'UNC' & T.idxmFrTotal == 0));
nol_UNC_act = sum(double((T.taskType == 'noRun') & T.idxNeurontype == 'UNC' & T.idxmFrTotal == 1));
nol_UNC_ina = sum(double((T.taskType == 'noRun') & T.idxNeurontype == 'UNC' & T.idxmFrTotal == -1));
nol_UNC_no = sum(double((T.taskType == 'noRun') & T.idxNeurontype == 'UNC' & T.idxmFrTotal == 0));
% con_UNC_act = sum(double((Tcon.taskType == 'DRw') & Tcon.idxNeurontype == 'UNC' & Tcon.idxmFrTotal == 1));
% con_UNC_ina = sum(double((Tcon.taskType == 'DRw') & Tcon.idxNeurontype == 'UNC' & Tcon.idxmFrTotal == -1));
% con_UNC_no = sum(double((Tcon.taskType == 'DRw') & Tcon.idxNeurontype == 'UNC' & Tcon.idxmFrTotal == 0));
l_UNC = [l_UNC_act, l_UNC_ina, l_UNC_no]/sum([l_UNC_act, l_UNC_ina, l_UNC_no])*100;
nol_UNC = [nol_UNC_act, nol_UNC_ina, nol_UNC_no]/sum([nol_UNC_act, nol_UNC_ina, nol_UNC_no])*100;
% con_UNC = [con_UNC_act, con_UNC_ina, con_UNC_no]/sum([con_UNC_act, con_UNC_ina, con_UNC_no])*100;

%% examples
a = (T.taskType == 'DRw') & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOutPRE & T.idxmFrIn == 1;
b = (T.taskType == 'DRw') & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOutPRE & T.idxmFrIn == -1;
c = (T.taskType == 'DRw') & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOutPRE & T.idxmFrIn == 0;

d = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOutPRE & T.idxmFrIn == 1;
e = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOutPRE & T.idxmFrIn == -1;
f = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOutPRE & T.idxmFrIn == 0;

% g = (T.taskType == 'DRw') & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxmFrTotal == 1;
% h = (T.taskType == 'DRw') & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxmFrTotal == -1;
% i = (T.taskType == 'DRw') & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxmFrTotal == 0;

plot_Track_multi_v3(T.path(a),T.cellID(a),'D:\Dropbox\SNL\P2_Track\example_InOutField\InAct');
plot_Track_multi_v3(T.path(b),T.cellID(b),'D:\Dropbox\SNL\P2_Track\example_InOutField\InIna');
plot_Track_multi_v3(T.path(c),T.cellID(c),'D:\Dropbox\SNL\P2_Track\example_InOutField\InNoresp');
plot_Track_multi_v3(T.path(d),T.cellID(d),'D:\Dropbox\SNL\P2_Track\example_InOutField\OutAct');
plot_Track_multi_v3(T.path(e),T.cellID(e),'D:\Dropbox\SNL\P2_Track\example_InOutField\OutIna');
% plot_Track_multi_v3(T.path(f),T.cellID(f),'D:\Dropbox\SNL\P2_Track\example_InOutField\OutNoresp');

%% Plot
% xptLight = [1,5,9];
% xptNolight = [2,6,10];
% xptCont = [3,7,11];
xptLight = [1,4,7];
xptNolight = [2,5,8];
yptText = 100;

nCol = 2;
nRow = 4;

fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});
hBar(1) = axes('Position',axpt(2,1,1,1,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval),wideInterval));
bar(xptLight, lightPF_in, 0.2, 'faceColor', colorBlue);
hold on;
bar(xptNolight, nolightPF_in, 0.2, 'faceColor', colorGray);
hold on;
% bar(xptCont, conPF_in, 0.2, 'faceColor', colorDarkGray);
set(hBar(1),'XLim',[0,9],'XTick',[1.5 4.5 7.5],'XTickLabel',{'Increased';'Decreased';'No change'},'fontSize',fontS);
text(1,85,'Blue: Light','fontSize',fontS,'color',colorBlue,'fontWeight','bold');
text(1,75,'Gray: no light','fontSize',fontS,'color',colorGray,'fontWeight','bold');
% text(1,65,'Black: eYFP','fontSize',fontS,'color',colorDarkGray,'fontWeight','bold');
text(1-0.5, yptText, num2str(l_PF_inField_act),'fontSize',fontS);
text(2-0.5, yptText, num2str(nol_PF_inField_act),'fontSize',fontS);
% text(3, yptText, num2str(con_PF_inField_act),'fontSize',fontS);
text(4-0.5, yptText, num2str(l_PF_inField_ina),'fontSize',fontS);
text(5-0.5, yptText, num2str(nol_PF_inField_ina),'fontSize',fontS);
% text(7, yptText, num2str(con_PF_inField_ina),'fontSize',fontS);
text(7-0.5, yptText, num2str(l_PF_inField_no),'fontSize',fontS);
text(8-0.5, yptText, num2str(nol_PF_inField_no),'fontSize',fontS);
% text(11, yptText, num2str(con_PF_inField_no),'fontSize',fontS);
ylabel('Proportion (%)','fontSize',fontS);
title('In-field stimulation','fontSize',fontS);

hBar(2) = axes('Position',axpt(2,1,2,1,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval),wideInterval));
bar(xptLight, ratio_lightPF_diff, 0.2, 'faceColor', colorBlue);
hold on;
bar(xptNolight, ratio_nolightPF_diff, 0.2, 'faceColor', colorGray);
hold on;
% bar(xptCont, ratio_conPF_diff, 0.2, 'faceColor', colorDarkGray);
text(1-0.5, yptText, num2str(lightPF_diff(1)),'fontSize',fontS);
text(2-0.5, yptText, num2str(nolightPF_diff(1)),'fontSize',fontS);
% text(3, yptText, num2str(conPF_diff(1)),'fontSize',fontS);
text(4-0.5, yptText, num2str(lightPF_diff(2)),'fontSize',fontS);
text(5-0.5, yptText, num2str(nolightPF_diff(2)),'fontSize',fontS);
% text(7, yptText, num2str(conPF_diff(2)),'fontSize',fontS);
text(7-0.5, yptText, num2str(lightPF_diff(3)),'fontSize',fontS);
text(8-0.5, yptText, num2str(nolightPF_diff(3)),'fontSize',fontS);
% text(11, yptText, num2str(conPF_diff(3)),'fontSize',fontS);
set(hBar(2),'XLim',[0,9],'XTick',[1.5 4.5 7.5],'XTickLabel',{'Increased';'Decreased';'No change'},'fontSize',fontS);
ylabel('Proportion (%)','fontSize',fontS);
title('Out-field / non-field stimulation','fontSize',fontS);

% hBar(3) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1,2,[0.1 0.1 0.85 0.85],wideInterval),wideInterval));
% bar(xptLight, l_PN, 0.2, 'faceColor', colorBlue);
% hold on;
% bar(xptNolight, nol_PN, 0.2, 'faceColor', colorGray);
% hold on;
% bar(xptCont, con_PN, 0.2, 'faceColor', colorDarkGray);
% text(1, yptText, num2str(l_PN_act),'fontSize',fontS);
% text(2, yptText, num2str(nol_PN_act),'fontSize',fontS);
% text(3, yptText, num2str(con_PN_act),'fontSize',fontS);
% text(5, yptText, num2str(l_PN_ina),'fontSize',fontS);
% text(6, yptText, num2str(nol_PN_ina),'fontSize',fontS);
% text(7, yptText, num2str(con_PN_ina),'fontSize',fontS);
% text(9, yptText, num2str(l_PN_no),'fontSize',fontS);
% text(10, yptText, num2str(nol_PN_no),'fontSize',fontS);
% text(11, yptText, num2str(con_PN_no),'fontSize',fontS);
% set(hBar(3),'XLim',[0,12],'XTick',xptNolight,'XTickLabel',{'Act';'Ina';'No'});
% ylabel('proportion (%)','fontSize',fontS);
% title('Pyramidal neuron','fontSize',fontS);
% 
% hBar(4) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,2,2,[0.1 0.1 0.85 0.85],wideInterval),wideInterval));
% bar(xptLight, l_IN, 0.2, 'faceColor', colorBlue);
% hold on;
% bar(xptNolight, nol_IN, 0.2, 'faceColor', colorGray);
% hold on;
% bar(xptCont, con_IN, 0.2, 'faceColor', colorDarkGray);
% text(1, yptText, num2str(l_IN_act),'fontSize',fontS);
% text(2, yptText, num2str(nol_IN_act),'fontSize',fontS);
% text(3, yptText, num2str(con_IN_act),'fontSize',fontS);
% text(5, yptText, num2str(l_IN_ina),'fontSize',fontS);
% text(6, yptText, num2str(nol_IN_ina),'fontSize',fontS);
% text(7, yptText, num2str(con_IN_ina),'fontSize',fontS);
% text(9, yptText, num2str(l_IN_no),'fontSize',fontS);
% text(10, yptText, num2str(nol_IN_no),'fontSize',fontS);
% text(11, yptText, num2str(con_IN_no),'fontSize',fontS);
% set(hBar(4),'XLim',[0,12],'XTick',xptNolight,'XTickLabel',{'Act';'Ina';'No'});
% ylabel('proportion (%)','fontSize',fontS);
% title('Interneuron','fontSize',fontS);
% 
% hBar(5) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,3,2,[0.1 0.1 0.85 0.85],wideInterval),wideInterval));
% bar(xptLight, l_UNC, 0.2, 'faceColor', colorBlue);
% hold on;
% bar(xptNolight, nol_UNC, 0.2, 'faceColor', colorGray);
% hold on;
% bar(xptCont, con_UNC, 0.2, 'faceColor', colorDarkGray);
% text(1, yptText, num2str(l_UNC_act),'fontSize',fontS);
% text(2, yptText, num2str(nol_UNC_act),'fontSize',fontS);
% text(3, yptText, num2str(con_UNC_act),'fontSize',fontS);
% text(5, yptText, num2str(l_UNC_ina),'fontSize',fontS);
% text(6, yptText, num2str(nol_UNC_ina),'fontSize',fontS);
% text(7, yptText, num2str(con_UNC_ina),'fontSize',fontS);
% text(9, yptText, num2str(l_UNC_no),'fontSize',fontS);
% text(10, yptText, num2str(nol_UNC_no),'fontSize',fontS);
% text(11, yptText, num2str(con_UNC_no),'fontSize',fontS);
% set(hBar(5),'XLim',[0,12],'XTick',xptCont,'XTickLabel',{'Act';'Ina';'No'});
% ylabel('proportion (%)','fontSize',fontS);
% title('Unclassfied neuron','fontSize',fontS);

set(hBar,'Box','off','TickDir','out','YLim',[0 110],'YTick',0:20:100);
print('-painters','-depsc','-r300',['final_fig6_InOutRw_',datestr(now,formatOut),'.ai']);
print('-painters','-dtiff','-r300',['final_fig6_InOutRw_',datestr(now,formatOut),'.tif']);
close;