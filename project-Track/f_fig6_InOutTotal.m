clearvars;
rtDir = 'D:\Dropbox\SNL\P2_Track';
cd(rtDir);

alpha = 0.01;
areaDRun = [5/6 4/3]*pi*20; % 6-9 o'clock
areaDRw = [3/2 5/3]*pi*20; % 10-11 o'clock
areaRw1 = [1/2 2/3]*pi*20; % 4-5 o'clock
areaRw2 = [3/2 5/3]*pi*20; % 10-11 o'clock
errorPosi = 5;
correctY = 0.5;
lightBand = 3;

%% Loading cell information
load myParameters.mat;
load('neuronList_ori_control_170823.mat');
Tcon = T;
load('neuronList_ori_170823.mat');

formatOut = 'yymmdd';

l_PF_inField_act = sum(double((T.taskType == 'DRun' | T.taskType == 'DRw') & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOut & T.idxSpikeIn == 1));
l_PF_inField_ina = sum(double((T.taskType == 'DRun' | T.taskType == 'DRw') & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOut & T.idxSpikeIn == -1));
l_PF_inField_no = sum(double((T.taskType == 'DRun' | T.taskType == 'DRw') & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOut & T.idxSpikeIn == 0));
nol_PF_inField_act = sum(double((T.taskType == 'noRun' | T.taskType == 'noRw') & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOut & T.idxSpikeIn == 1));
nol_PF_inField_ina = sum(double((T.taskType == 'noRun' | T.taskType == 'noRw') & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOut & T.idxSpikeIn == -1));
nol_PF_inField_no = sum(double((T.taskType == 'noRun' | T.taskType == 'noRw') & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxZoneInOut & T.idxSpikeIn == 0));
con_PF_inField_act = sum(double((Tcon.taskType == 'DRun' | Tcon.taskType == 'DRw') & Tcon.idxNeurontype == 'PN' & Tcon.idxPeakFR & Tcon.idxPlaceField & Tcon.idxTotalSpikeNum & Tcon.idxZoneInOut & Tcon.idxSpikeIn == 1));
con_PF_inField_ina = sum(double((Tcon.taskType == 'DRun' | Tcon.taskType == 'DRw') & Tcon.idxNeurontype == 'PN' & Tcon.idxPeakFR & Tcon.idxPlaceField & Tcon.idxTotalSpikeNum & Tcon.idxZoneInOut & Tcon.idxSpikeIn == -1));
con_PF_inField_no = sum(double((Tcon.taskType == 'DRun' | Tcon.taskType == 'DRw') & Tcon.idxNeurontype == 'PN' & Tcon.idxPeakFR & Tcon.idxPlaceField & Tcon.idxTotalSpikeNum & Tcon.idxZoneInOut & Tcon.idxSpikeIn == 0));
lightPF_in = [l_PF_inField_act, l_PF_inField_ina, l_PF_inField_no]/sum([l_PF_inField_act, l_PF_inField_ina, l_PF_inField_no])*100;
nolightPF_in = [nol_PF_inField_act, nol_PF_inField_ina, nol_PF_inField_no]/sum([nol_PF_inField_act, nol_PF_inField_ina, nol_PF_inField_no])*100;
contPF_in = [con_PF_inField_act, con_PF_inField_ina, con_PF_inField_no]/sum([con_PF_inField_act, con_PF_inField_ina, con_PF_inField_no])*100;

l_PF_outField_act = sum(double((T.taskType == 'DRun' | T.taskType == 'DRw') & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOut & T.idxSpikeOut == 1));
l_PF_outField_ina = sum(double((T.taskType == 'DRun' | T.taskType == 'DRw') & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOut & T.idxSpikeOut == -1));
l_PF_outField_no = sum(double((T.taskType == 'DRun' | T.taskType == 'DRw') & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOut & T.idxSpikeOut == 0));
nol_PF_outField_act = sum(double((T.taskType == 'noRun' | T.taskType == 'noRw') & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOut & T.idxSpikeOut == 1));
nol_PF_outField_ina = sum(double((T.taskType == 'noRun' | T.taskType == 'noRw') & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOut & T.idxSpikeOut == -1));
nol_PF_outField_no = sum(double((T.taskType == 'noRun' | T.taskType == 'noRw') & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxZoneInOut & T.idxSpikeOut == 0));
con_PF_outField_act = sum(double((Tcon.taskType == 'DRun' | Tcon.taskType == 'DRw') & Tcon.idxNeurontype == 'PN' & Tcon.idxPeakFR & Tcon.idxPlaceField & Tcon.idxTotalSpikeNum & ~Tcon.idxZoneInOut & Tcon.idxSpikeOut == 1));
con_PF_outField_ina = sum(double((Tcon.taskType == 'DRun' | Tcon.taskType == 'DRw') & Tcon.idxNeurontype == 'PN' & Tcon.idxPeakFR & Tcon.idxPlaceField & Tcon.idxTotalSpikeNum & ~Tcon.idxZoneInOut & Tcon.idxSpikeOut == -1));
con_PF_outField_no = sum(double((Tcon.taskType == 'DRun' | Tcon.taskType == 'DRw') & Tcon.idxNeurontype == 'PN' & Tcon.idxPeakFR & Tcon.idxPlaceField & Tcon.idxTotalSpikeNum & ~Tcon.idxZoneInOut & Tcon.idxSpikeOut == 0));
lightPF_out = [l_PF_outField_act, l_PF_outField_ina, l_PF_outField_no]/sum([l_PF_outField_act, l_PF_outField_ina, l_PF_outField_no])*100;
nolightPF_out = [nol_PF_outField_act, nol_PF_outField_ina, nol_PF_outField_no]/sum([nol_PF_outField_act, nol_PF_outField_ina, nol_PF_outField_no])*100;
conPF_out = [con_PF_outField_act, con_PF_outField_ina, con_PF_outField_no]/sum([con_PF_outField_act, con_PF_outField_ina, con_PF_outField_no])*100;

l_NPF_act = sum(double((T.taskType == 'DRun' | T.taskType == 'DRw') & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxSpikeTotal == 1));
l_NPF_ina = sum(double((T.taskType == 'DRun' | T.taskType == 'DRw') & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxSpikeTotal == -1));
l_NPF_no = sum(double((T.taskType == 'DRun' | T.taskType == 'DRw') & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxSpikeTotal == 0));
nol_NPF_act = sum(double((T.taskType == 'noRun' | T.taskType == 'noRw') & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxSpikeTotal == 1));
nol_NPF_ina = sum(double((T.taskType == 'noRun' | T.taskType == 'noRw') & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxSpikeTotal == -1));
nol_NPF_no = sum(double((T.taskType == 'noRun' | T.taskType == 'noRw') & T.idxNeurontype == 'PN' & ~(T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum) & T.idxSpikeTotal == 0));
con_NPF_act = sum(double((Tcon.taskType == 'DRun' | Tcon.taskType == 'DRw') & Tcon.idxNeurontype == 'PN' & ~(Tcon.idxPeakFR & Tcon.idxPlaceField & Tcon.idxTotalSpikeNum) & Tcon.idxSpikeTotal == 1));
con_NPF_ina = sum(double((Tcon.taskType == 'DRun' | Tcon.taskType == 'DRw') & Tcon.idxNeurontype == 'PN' & ~(Tcon.idxPeakFR & Tcon.idxPlaceField & Tcon.idxTotalSpikeNum) & Tcon.idxSpikeTotal == -1));
con_NPF_no = sum(double((Tcon.taskType == 'DRun' | Tcon.taskType == 'DRw') & Tcon.idxNeurontype == 'PN' & ~(Tcon.idxPeakFR & Tcon.idxPlaceField & Tcon.idxTotalSpikeNum) & Tcon.idxSpikeTotal == 0));
l_NPF = [l_NPF_act, l_NPF_ina, l_NPF_no]/sum([l_NPF_act, l_NPF_ina, l_NPF_no])*100;
nol_NPF = [nol_NPF_act, nol_NPF_ina, nol_NPF_no]/sum([nol_NPF_act, nol_NPF_ina, nol_NPF_no])*100;
con_NPF = [con_NPF_act, con_NPF_ina, con_NPF_no]/sum([con_NPF_act, con_NPF_ina, con_NPF_no])*100;

l_PN_act = sum(double((T.taskType == 'DRun' | T.taskType == 'DRw') & T.idxNeurontype == 'PN' & T.idxSpikeTotal == 1));
l_PN_ina = sum(double((T.taskType == 'DRun' | T.taskType == 'DRw') & T.idxNeurontype == 'PN' & T.idxSpikeTotal == -1));
l_PN_no = sum(double((T.taskType == 'DRun' | T.taskType == 'DRw') & T.idxNeurontype == 'PN' & T.idxSpikeTotal == 0));
nol_PN_act = sum(double((T.taskType == 'noRun' | T.taskType == 'noRw') & T.idxNeurontype == 'PN' & T.idxSpikeTotal == 1));
nol_PN_ina = sum(double((T.taskType == 'noRun' | T.taskType == 'noRw') & T.idxNeurontype == 'PN' & T.idxSpikeTotal == -1));
nol_PN_no = sum(double((T.taskType == 'noRun' | T.taskType == 'noRw') & T.idxNeurontype == 'PN' & T.idxSpikeTotal == 0));
con_PN_act = sum(double((Tcon.taskType == 'DRun' | Tcon.taskType == 'DRw') & Tcon.idxNeurontype == 'PN' & Tcon.idxSpikeTotal == 1));
con_PN_ina = sum(double((Tcon.taskType == 'DRun' | Tcon.taskType == 'DRw') & Tcon.idxNeurontype == 'PN' & Tcon.idxSpikeTotal == -1));
con_PN_no = sum(double((Tcon.taskType == 'DRun' | Tcon.taskType == 'DRw') & Tcon.idxNeurontype == 'PN' & Tcon.idxSpikeTotal == 0));
l_PN = [l_PN_act, l_PN_ina, l_PN_no]/sum([l_PN_act, l_PN_ina, l_PN_no])*100;
nol_PN = [nol_PN_act, nol_PN_ina, nol_PN_no]/sum([nol_PN_act, nol_PN_ina, nol_PN_no])*100;
con_PN = [con_PN_act, con_PN_ina, con_PN_no]/sum([con_PN_act, con_PN_ina, con_PN_no])*100;

l_IN_act = sum(double((T.taskType == 'DRun' | T.taskType == 'DRw') & T.idxNeurontype == 'IN' & T.idxSpikeTotal == 1));
l_IN_ina = sum(double((T.taskType == 'DRun' | T.taskType == 'DRw') & T.idxNeurontype == 'IN' & T.idxSpikeTotal == -1));
l_IN_no = sum(double((T.taskType == 'DRun' | T.taskType == 'DRw') & T.idxNeurontype == 'IN' & T.idxSpikeTotal == 0));
nol_IN_act = sum(double((T.taskType == 'noRun' | T.taskType == 'noRw') & T.idxNeurontype == 'IN' & T.idxSpikeTotal == 1));
nol_IN_ina = sum(double((T.taskType == 'noRun' | T.taskType == 'noRw') & T.idxNeurontype == 'IN' & T.idxSpikeTotal == -1));
nol_IN_no = sum(double((T.taskType == 'noRun' | T.taskType == 'noRw') & T.idxNeurontype == 'IN' & T.idxSpikeTotal == 0));
con_IN_act = sum(double((Tcon.taskType == 'DRun' | Tcon.taskType == 'DRw') & Tcon.idxNeurontype == 'IN' & Tcon.idxSpikeTotal == 1));
con_IN_ina = sum(double((Tcon.taskType == 'DRun' | Tcon.taskType == 'DRw') & Tcon.idxNeurontype == 'IN' & Tcon.idxSpikeTotal == -1));
con_IN_no = sum(double((Tcon.taskType == 'DRun' | Tcon.taskType == 'DRw') & Tcon.idxNeurontype == 'IN' & Tcon.idxSpikeTotal == 0));
l_IN = [l_IN_act, l_IN_ina, l_IN_no]/sum([l_IN_act, l_IN_ina, l_IN_no])*100;
nol_IN = [nol_IN_act, nol_IN_ina, nol_IN_no]/sum([nol_IN_act, nol_IN_ina, nol_IN_no])*100;
con_IN = [con_IN_act, con_IN_ina, con_IN_no]/sum([con_IN_act, con_IN_ina, con_IN_no])*100;

l_UNC_act = sum(double((T.taskType == 'DRun' | T.taskType == 'DRw') & T.idxNeurontype == 'UNC' & T.idxSpikeTotal == 1));
l_UNC_ina = sum(double((T.taskType == 'DRun' | T.taskType == 'DRw') & T.idxNeurontype == 'UNC' & T.idxSpikeTotal == -1));
l_UNC_no = sum(double((T.taskType == 'DRun' | T.taskType == 'DRw') & T.idxNeurontype == 'UNC' & T.idxSpikeTotal == 0));
nol_UNC_act = sum(double((T.taskType == 'noRun' | T.taskType == 'noRw') & T.idxNeurontype == 'UNC' & T.idxSpikeTotal == 1));
nol_UNC_ina = sum(double((T.taskType == 'noRun' | T.taskType == 'noRw') & T.idxNeurontype == 'UNC' & T.idxSpikeTotal == -1));
nol_UNC_no = sum(double((T.taskType == 'noRun' | T.taskType == 'noRw') & T.idxNeurontype == 'UNC' & T.idxSpikeTotal == 0));
con_UNC_act = sum(double((Tcon.taskType == 'DRun' | Tcon.taskType == 'DRw') & Tcon.idxNeurontype == 'UNC' & Tcon.idxSpikeTotal == 1));
con_UNC_ina = sum(double((Tcon.taskType == 'DRun' | Tcon.taskType == 'DRw') & Tcon.idxNeurontype == 'UNC' & Tcon.idxSpikeTotal == -1));
con_UNC_no = sum(double((Tcon.taskType == 'DRun' | Tcon.taskType == 'DRw') & Tcon.idxNeurontype == 'UNC' & Tcon.idxSpikeTotal == 0));
l_UNC = [l_UNC_act, l_UNC_ina, l_UNC_no]/sum([l_UNC_act, l_UNC_ina, l_UNC_no])*100;
nol_UNC = [nol_UNC_act, nol_UNC_ina, nol_UNC_no]/sum([nol_UNC_act, nol_UNC_ina, nol_UNC_no])*100;
con_UNC = [con_UNC_act, con_UNC_ina, con_UNC_no]/sum([con_UNC_act, con_UNC_ina, con_UNC_no])*100;

%% Plot
xptPF_light = [1,5,9,13,17,21];
xptPF_nolight = [2,6,10,14,18,22];
xptPF_eYFP = [3,7,11,15,19,23];
yptText = 100;

nCol = 3;
nRow = 2;

fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{2});
hBar(1) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1:2,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
bar(xptPF_light, [lightPF_in,lightPF_out], 0.2, 'faceColor', colorBlue);
hold on;
bar(xptPF_nolight, [nolightPF_in(1,:),nolightPF_out(1,:)], 0.2, 'faceColor', colorGray);
hold on;
bar(xptPF_eYFP, [contPF_in(1,:),conPF_out(1,:)], 0.2, 'faceColor', colorDarkGray);
line([12 12],[0 100],'color',colorBlack);
set(hBar(1),'XLim',[0,25],'XTick',xptPF_nolight,'XTickLabel',{'Inzone_Act';'Inzone_Ina';'Inzone_No';'Outzone_Act';'Outzone_Ina';'Outzone_No'});
text(1,85,'Blue: Light','fontSize',fontXL,'color',colorBlue,'fontWeight','bold');
text(1,75,'Gray: no light','fontSize',fontXL,'color',colorGray,'fontWeight','bold');
text(1,65,'Black: eYFP','fontSize',fontXL,'color',colorDarkGray,'fontWeight','bold');
text(1, yptText, num2str(l_PF_inField_act),'fontSize',fontL);
text(2, yptText, num2str(nol_PF_inField_act),'fontSize',fontL);
text(3, yptText, num2str(con_PF_inField_act),'fontSize',fontL);
text(5, yptText, num2str(l_PF_inField_ina),'fontSize',fontL);
text(6, yptText, num2str(nol_PF_inField_ina),'fontSize',fontL);
text(7, yptText, num2str(con_PF_inField_ina),'fontSize',fontL);
text(9, yptText, num2str(l_PF_inField_no),'fontSize',fontL);
text(10, yptText, num2str(nol_PF_inField_no),'fontSize',fontL);
text(11, yptText, num2str(con_PF_inField_no),'fontSize',fontL);
text(13, yptText, num2str(l_PF_outField_act),'fontSize',fontL);
text(14, yptText, num2str(nol_PF_outField_act),'fontSize',fontL);
text(15, yptText, num2str(con_PF_outField_act),'fontSize',fontL);
text(17, yptText, num2str(l_PF_outField_ina),'fontSize',fontL);
text(18, yptText, num2str(nol_PF_outField_ina),'fontSize',fontL);
text(19, yptText, num2str(con_PF_outField_ina),'fontSize',fontL);
text(21, yptText, num2str(l_PF_outField_no),'fontSize',fontL);
text(22, yptText, num2str(nol_PF_outField_no),'fontSize',fontL);
text(23, yptText, num2str(con_PF_outField_no),'fontSize',fontL);
ylabel('proportion (%)','fontSize',fontL);
title('Place field','fontSize',fontXL);

xptLight = [1,5,9];
xptNolight = [2,6,10];
xptCont = [3,7,11];
hBar(2) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,3,1,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
bar(xptLight, l_NPF, 0.2, 'faceColor', colorBlue);
hold on;
bar(xptNolight, nol_NPF, 0.2, 'faceColor', colorGray);
hold on;
bar(xptCont, con_NPF, 0.2, 'faceColor', colorDarkGray);
text(1, yptText, num2str(l_NPF_act),'fontSize',fontL);
text(2, yptText, num2str(nol_NPF_act),'fontSize',fontL);
text(3, yptText, num2str(con_NPF_act),'fontSize',fontL);
text(5, yptText, num2str(l_NPF_ina),'fontSize',fontL);
text(6, yptText, num2str(nol_NPF_ina),'fontSize',fontL);
text(7, yptText, num2str(con_NPF_ina),'fontSize',fontL);
text(9, yptText, num2str(l_NPF_no),'fontSize',fontL);
text(10, yptText, num2str(nol_NPF_no),'fontSize',fontL);
text(11, yptText, num2str(con_NPF_no),'fontSize',fontL);
set(hBar(2),'XLim',[0,12],'XTick',xptNolight,'XTickLabel',{'Act';'Ina';'No'});
ylabel('proportion (%)','fontSize',fontL);
title('Non place field','fontSize',fontXL);


hBar(3) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1,2,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
bar(xptLight, l_PN, 0.2, 'faceColor', colorBlue);
hold on;
bar(xptNolight, nol_PN, 0.2, 'faceColor', colorGray);
hold on;
bar(xptCont, con_PN, 0.2, 'faceColor', colorDarkGray);
text(1, yptText, num2str(l_PN_act),'fontSize',fontL);
text(2, yptText, num2str(nol_PN_act),'fontSize',fontL);
text(3, yptText, num2str(con_PN_act),'fontSize',fontL);
text(5, yptText, num2str(l_PN_ina),'fontSize',fontL);
text(6, yptText, num2str(nol_PN_ina),'fontSize',fontL);
text(7, yptText, num2str(con_PN_ina),'fontSize',fontL);
text(9, yptText, num2str(l_PN_no),'fontSize',fontL);
text(10, yptText, num2str(nol_PN_no),'fontSize',fontL);
text(11, yptText, num2str(con_PN_no),'fontSize',fontL);
set(hBar(3),'XLim',[0,12],'XTick',xptNolight,'XTickLabel',{'Act';'Ina';'No'});
ylabel('proportion (%)','fontSize',fontL);
title('Pyramidal neuron','fontSize',fontXL);


hBar(4) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,2,2,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
bar(xptLight, l_IN, 0.2, 'faceColor', colorBlue);
hold on;
bar(xptNolight, nol_IN, 0.2, 'faceColor', colorGray);
hold on;
bar(xptCont, con_IN, 0.2, 'faceColor', colorDarkGray);
text(1, yptText, num2str(l_IN_act),'fontSize',fontL);
text(2, yptText, num2str(nol_IN_act),'fontSize',fontL);
text(3, yptText, num2str(con_IN_act),'fontSize',fontL);
text(5, yptText, num2str(l_IN_ina),'fontSize',fontL);
text(6, yptText, num2str(nol_IN_ina),'fontSize',fontL);
text(7, yptText, num2str(con_IN_ina),'fontSize',fontL);
text(9, yptText, num2str(l_IN_no),'fontSize',fontL);
text(10, yptText, num2str(nol_IN_no),'fontSize',fontL);
text(11, yptText, num2str(con_IN_no),'fontSize',fontL);
set(hBar(4),'XLim',[0,12],'XTick',xptNolight,'XTickLabel',{'Act';'Ina';'No'});
ylabel('proportion (%)','fontSize',fontL);
title('Interneuron','fontSize',fontXL);

hBar(5) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,3,2,[0.1 0.1 0.85 0.85],wideInterval),midInterval));
bar(xptLight, l_UNC, 0.2, 'faceColor', colorBlue);
hold on;
bar(xptNolight, nol_UNC, 0.2, 'faceColor', colorGray);
hold on;
bar(xptCont, con_UNC, 0.2, 'faceColor', colorDarkGray);
text(1, yptText, num2str(l_UNC_act),'fontSize',fontL);
text(2, yptText, num2str(nol_UNC_act),'fontSize',fontL);
text(3, yptText, num2str(con_UNC_act),'fontSize',fontL);
text(5, yptText, num2str(l_UNC_ina),'fontSize',fontL);
text(6, yptText, num2str(nol_UNC_ina),'fontSize',fontL);
text(7, yptText, num2str(con_UNC_ina),'fontSize',fontL);
text(9, yptText, num2str(l_UNC_no),'fontSize',fontL);
text(10, yptText, num2str(nol_UNC_no),'fontSize',fontL);
text(11, yptText, num2str(con_UNC_no),'fontSize',fontL);
set(hBar(5),'XLim',[0,12],'XTick',xptCont,'XTickLabel',{'Act';'Ina';'No'});
ylabel('proportion (%)','fontSize',fontL);
title('Unclassfied neuron','fontSize',fontXL);

set(hBar,'Box','off','TickDir','out','YLim',[0 110],'YTick',0:20:100);
print('-painters','-dtiff','-r300',['final_fig6_InOutTotal_',datestr(now,formatOut),'.tif']);
close;