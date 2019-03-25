clearvars;
rtDir = 'E:\Dropbox\Lab_mwjung\P4_FamiliarNovel';
load('E:\Dropbox\Lab_mwjung\P2_Track\myParameters.mat');
formatOut = 'yymmdd';
load('E:\Dropbox\Lab_mwjung\P4_FamiliarNovel\neuronList_novel_190301.mat');

PN = T.neuronType == 'PN';
tt_ca3bc = ((T.mouseID == 'rbp005' & (T.tetrode == 'TT1' | T.tetrode == 'TT5')) | (T.mouseID == 'rbp006' & T.tetrode == 'TT2') | (T.mouseID == 'rbp010' & T.tetrode == 'TT6')); % | (T.mouseID == 'rbp015' & T.tetrode == 'TT7')
PN_ca3bc = PN & tt_ca3bc;
PN_ca3a = PN & ~tt_ca3bc;

lightLoc_in = [37:98];
lightLoc_out = [1:36,99:124];
cri_peakFR = 2;

%% number of neurons
n_ca3a = sum(double(PN_ca3a));
n_ca3bc = sum(double(PN_ca3bc));
n_total = n_ca3a+n_ca3bc;
prop_total = round([n_ca3a, n_ca3bc]/n_total*100)/100*100;

% n_ca3a_act = sum(double(PN_ca3a & T.idxmFrIn == 1));
% n_ca3a_inh = sum(double(PN_ca3a & T.idxmFrIn == -1));
% n_ca3a_no = sum(double(PN_ca3a & T.idxmFrIn == 0));
% prop_ca3a_total = round([n_ca3a_act, n_ca3a_inh, n_ca3a_no]/n_ca3a*100)/100*100;
% 
% n_ca3bc_act = sum(double(PN_ca3bc & T.idxmFrIn == 1));
% n_ca3bc_inh = sum(double(PN_ca3bc & T.idxmFrIn == -1));
% n_ca3bc_no = sum(double(PN_ca3bc & T.idxmFrIn == 0));
% prop_ca3bc_total = round([n_ca3bc_act, n_ca3bc_inh, n_ca3bc_no]/n_ca3bc*100)/100*100;

n_ca3a_act = sum(double(PN_ca3a & T.idxmSpkIn == 1));
n_ca3a_inh = sum(double(PN_ca3a & T.idxmSpkIn == -1));
n_ca3a_no = sum(double(PN_ca3a & T.idxmSpkIn == 0));
prop_ca3a_total = round([n_ca3a_act, n_ca3a_inh, n_ca3a_no]/n_ca3a*100)/100*100;

n_ca3bc_act = sum(double(PN_ca3bc & T.idxmSpkIn == 1));
n_ca3bc_inh = sum(double(PN_ca3bc & T.idxmSpkIn == -1));
n_ca3bc_no = sum(double(PN_ca3bc & T.idxmSpkIn == 0));
prop_ca3bc_total = round([n_ca3bc_act, n_ca3bc_inh, n_ca3bc_no]/n_ca3bc*100)/100*100;

%% number of neurons with threshold
m_inPRE = cellfun(@(x) x(2), T.m_lapFrInzone);
min_lapFrInPRE = min(m_inPRE(PN & T.idxmSpkIn == -1)); % <<<<<<<<<<<<<< firing rate base
idx_thrPass = m_inPRE>=min_lapFrInPRE;

n_ca3a_th = sum(double(PN_ca3a & idx_thrPass));
n_ca3bc_th = sum(double(PN_ca3bc & idx_thrPass));
n_total_th = n_ca3a_th+n_ca3bc_th;
prop_total_th = round([n_ca3a_th, n_ca3bc_th]/n_total_th*100)/100*100;

n_ca3a_act_th = sum(double(PN_ca3a & T.idxmSpkIn == 1 & idx_thrPass));
n_ca3a_inh_th = sum(double(PN_ca3a & T.idxmSpkIn == -1 & idx_thrPass));
n_ca3a_no_th = sum(double(PN_ca3a & T.idxmSpkIn == 0 & idx_thrPass));
prop_ca3a_total_th = round([n_ca3a_act, n_ca3a_inh, n_ca3a_no]/n_ca3a*100)/100*100;

n_ca3bc_act_th = sum(double(PN_ca3bc & T.idxmSpkIn == 1 & idx_thrPass));
n_ca3bc_inh_th = sum(double(PN_ca3bc & T.idxmSpkIn == -1 & idx_thrPass));
n_ca3bc_no_th = sum(double(PN_ca3bc & T.idxmSpkIn == 0 & idx_thrPass));
prop_ca3bc_total_th = round([n_ca3bc_act_th, n_ca3bc_inh_th, n_ca3bc_no_th]/n_ca3bc_th*100)/100*100;

%% spike probability
lightProb_ca3a = T.lightProbTrack(PN_ca3a & T.idxmSpkIn == 1);
lightProb_ca3bc = T.lightProbTrack(PN_ca3bc & T.idxmSpkIn == 1);
% lightProb_ca3a = T.lightProbTrack(PN_ca3a & T.idxmFrIn == 1);
% lightProb_ca3bc = T.lightProbTrack(PN_ca3bc & T.idxmFrIn == 1);

lightProb_mean = [mean(lightProb_ca3a), mean(lightProb_ca3bc)];
lightProb_sem = [std(lightProb_ca3a,0,1)/sqrt(n_ca3a_act), std(lightProb_ca3bc,0,1)/sqrt(n_ca3bc_act)];

mFR_ca3a = T.meanFR_Task(PN_ca3a);
mFR_ca3bc = T.meanFR_Task(PN_ca3bc);
mFR_mean = [mean(mFR_ca3a), mean(mFR_ca3bc)];
mFR_sem = [std(mFR_ca3a)/sqrt(n_ca3a), std(mFR_ca3bc)/sqrt(n_ca3bc)];

peakFR_ca3a = cellfun(@(x) max(x(2:4)),T.peakFR1D_track(PN_ca3a));
peakFR_ca3bc = cellfun(@(x) max(x(2:4)),T.peakFR1D_track(PN_ca3bc));
peakFR_mean = [mean(peakFR_ca3a), mean(peakFR_ca3bc)];
peakFR_sem = [std(peakFR_ca3a)/sqrt(n_ca3a), std(peakFR_ca3bc)/sqrt(n_ca3bc)];

%% PRE vs POST significant firing rate change
sigTot_inc = sum(double(PN & cellfun(@(x) x(2,3)<0.05, T.p_ttestFr) & cellfun(@(x) x(4)>x(2),T.m_lapFrTotalzone))); % increased
sigTot_dec = sum(double(PN & cellfun(@(x) x(2,3)<0.05, T.p_ttestFr) & cellfun(@(x) x(4)<x(2),T.m_lapFrTotalzone))); % decreased
sigTot_non = n_total-(sigTot_inc+sigTot_dec); % nonresponsive
barStack = round([sigTot_inc, sigTot_dec, sigTot_non]/n_total*100)/100*100;

% In-zone 
sigIn_inc = PN & cellfun(@(x) x(2,1)<0.05, T.p_ttestFr) & cellfun(@(x) x(4)>x(2),T.m_lapFrInzone); % increased
sigIn_dec = PN & cellfun(@(x) x(2,1)<0.05, T.p_ttestFr) & cellfun(@(x) x(4)<x(2),T.m_lapFrInzone); % decreased
n_sigIn_inc = sum(double(sigIn_inc));
n_sigIn_dec = sum(double(sigIn_dec));

% Out-zone
sigOut_inc = PN & cellfun(@(x) x(2,2)<0.05, T.p_ttestFr) & cellfun(@(x) x(4)>x(2),T.m_lapFrOutzone); % increased
sigOut_dec = PN & cellfun(@(x) x(2,2)<0.05, T.p_ttestFr) & cellfun(@(x) x(4)<x(2),T.m_lapFrOutzone); % decreased
n_sigOut_inc = sum(double(sigOut_inc));
n_sigOut_dec = sum(double(sigOut_dec));

% Total
sigTot_inc = PN & cellfun(@(x) x(2,3)<0.05, T.p_ttestFr) & cellfun(@(x) x(4)>x(2),T.m_lapFrTotalzone); % increased
sigTot_dec = PN & cellfun(@(x) x(2,3)<0.05, T.p_ttestFr) & cellfun(@(x) x(4)<x(2),T.m_lapFrTotalzone); % increased
n_sigTot_inc = sum(double(sigOut_inc));
n_sigTot_dec = sum(double(sigOut_dec));

%% plot
xptBar = [1,3];
barWidth = 0.6;

xptScatter_a = (rand(n_ca3a,1)-0.5)*0.85*barWidth;
xptScatter_bc = (rand(n_ca3bc,1)-0.5)*0.85*barWidth;
xptScatter_a_act = (rand(n_ca3a_act,1)-0.5)*0.85*barWidth;
xptScatter_bc_act = (rand(n_ca3bc_act,1)-0.5)*0.85*barWidth;

nCol = 4;
nRow = 4;
yLim = [10, 80, 80];

fHandle = figure('PaperUnits','centimeter','PaperPosition',paperSize{1});

hPopulation = axes('Position',axpt(nCol,nRow,1:3,1,[],wideInterval));
text(-0.1,1,['total: ',num2str(n_total)],'fontSize',fontM);
text(-0.1,0.9,['ca3a: ',num2str(n_ca3a)],'fontSize',fontM);
text(-0.1,0.8,['ca3bc: ',num2str(n_ca3bc)],'fontSize',fontM);
text(-0.1,0.7,['ca3 prop: ',num2str(prop_total)],'fontSize',fontM);

text(0.1,1.0,['ca3a act: ',num2str(n_ca3a_act)],'fontSize',fontM);
text(0.1,0.9,['ca3a inh: ',num2str(n_ca3a_inh)],'fontSize',fontM);
text(0.1,0.8,['ca3a no: ',num2str(n_ca3a_no)],'fontSize',fontM);
text(0.1,0.7,['ca3a prop: ',num2str(prop_ca3a_total(1)),'/',num2str(prop_ca3a_total(2)),'/',num2str(prop_ca3a_total(3))],'fontSize',fontM);

text(0.35,1.0,['ca3bc act: ',num2str(n_ca3bc_act)],'fontSize',fontM);
text(0.35,0.9,['ca3bc inh: ',num2str(n_ca3bc_inh)],'fontSize',fontM);
text(0.35,0.8,['ca3bc no: ',num2str(n_ca3bc_no)],'fontSize',fontM);
text(0.35,0.7,['ca3a prop: ',num2str(prop_ca3bc_total(1)),'/',num2str(prop_ca3bc_total(2)),'/',num2str(prop_ca3bc_total(3))],'fontSize',fontM);

text(0.65,1,['total-th: ',num2str(n_total_th)],'fontSize',fontM);
text(0.65,0.9,['ca3a-th: ',num2str(n_ca3a_th)],'fontSize',fontM);
text(0.65,0.8,['ca3bc-th: ',num2str(n_ca3bc_th)],'fontSize',fontM);
text(0.65,0.7,['ca3 prop-th: ',num2str(prop_total_th)],'fontSize',fontM);

text(0.85,1.0,['ca3a act-th: ',num2str(n_ca3a_act_th)],'fontSize',fontM);
text(0.85,0.9,['ca3a inh-th: ',num2str(n_ca3a_inh_th)],'fontSize',fontM);
text(0.85,0.8,['ca3a no-th: ',num2str(n_ca3a_no_th)],'fontSize',fontM);
text(0.85,0.7,['ca3a prop-th: ',num2str(prop_ca3a_total_th(1)),'/',num2str(prop_ca3a_total_th(2)),'/',num2str(prop_ca3a_total_th(3))],'fontSize',fontM);

text(1.1,1.0,['ca3bc act-th: ',num2str(n_ca3bc_act_th)],'fontSize',fontM);
text(1.1,0.9,['ca3bc inh-th: ',num2str(n_ca3bc_inh_th)],'fontSize',fontM);
text(1.1,0.8,['ca3bc no-th: ',num2str(n_ca3bc_no_th)],'fontSize',fontM);
text(1.1,0.7,['ca3a prop-th: ',num2str(prop_ca3bc_total_th(1)),'/',num2str(prop_ca3bc_total_th(2)),'/',num2str(prop_ca3bc_total_th(3))],'fontSize',fontM);
set(hPopulation,'visible','off');

hMeanFR = axes('Position',axpt(nCol,nRow,1,2,[],wideInterval));
    hBar(1) = bar(xptBar,mFR_mean,'barWidth',barWidth,'lineStyle','-','edgeColor',colorBlack,'faceColor',colorLightGray);
    hold on;
    errorbarJun(xptBar,mFR_mean,mFR_sem,0.5,1,colorBlack);
    hold on;
    plot(xptBar(1)+xptScatter_a,mFR_ca3a,'lineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorRed,'markerEdgeColor',colorBlack);
    hold on;
    plot(xptBar(2)+xptScatter_bc,mFR_ca3bc,'lineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorRed,'markerEdgeColor',colorBlack);
    text(1.5,yLim(1)*0.8,['n = ',num2str(n_ca3a)],'fontSize',fontM);
    text(3.5,yLim(1)*0.8,['n = ',num2str(n_ca3bc)],'fontSize',fontM);
    ylabel('Mean firing rate (Hz)','fontSize',fontM);
set(hMeanFR,'Box','off','TickDir','out','XTick',[1,3],'XTicklabel',{'CA3a','CA3bc'},'XLim',[0,4],'YLim',[0,yLim(1)]);

hPeakFR = axes('Position',axpt(nCol,nRow,2,2,[],wideInterval));
    hBar(2) = bar(xptBar,peakFR_mean,'barWidth',barWidth,'lineStyle','-','edgeColor',colorBlack,'faceColor',colorLightGray);
    hold on;
    errorbarJun(xptBar,peakFR_mean,peakFR_sem,0.5,1,colorBlack);
    hold on;
    plot(xptBar(1)+xptScatter_a,peakFR_ca3a,'lineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorRed,'markerEdgeColor',colorBlack);
    hold on;
    plot(xptBar(2)+xptScatter_bc,peakFR_ca3bc,'lineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorRed,'markerEdgeColor',colorBlack);
    text(1.5,yLim(2)*0.8,['n = ',num2str(n_ca3a)],'fontSize',fontM);
    text(3.5,yLim(2)*0.8,['n = ',num2str(n_ca3bc)],'fontSize',fontM);
    ylabel('Peak firing rate (Hz)','fontSize',fontM);
set(hPeakFR,'Box','off','TickDir','out','XTick',[1,3],'XTicklabel',{'CA3a','CA3bc'},'XLim',[0,4],'YLim',[0,yLim(2)]);
    
hSpikeProb = axes('Position',axpt(nCol,nRow,3,2,[],wideInterval));
    hBar(3) = bar(xptBar,lightProb_mean,'barWidth',barWidth,'lineStyle','-','edgeColor',colorBlack,'faceColor',colorLightGray);
    hold on;
    errorbarJun(xptBar,lightProb_mean,lightProb_sem,0.5,1,colorBlack);
    hold on;
    plot(xptBar(1)+xptScatter_a_act,lightProb_ca3a,'lineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorRed,'markerEdgeColor',colorBlack);
    hold on;
    plot(xptBar(2)+xptScatter_bc_act,lightProb_ca3bc,'lineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorRed,'markerEdgeColor',colorBlack);
    text(1.5,yLim(3)*0.8,['n = ',num2str(n_ca3a_act)],'fontSize',fontM);
    text(3.5,yLim(3)*0.8,['n = ',num2str(n_ca3bc_act)],'fontSize',fontM);
    ylabel('Spike Prob. (%)','fontSize',fontM);
set(hSpikeProb,'Box','off','TickDir','out','XTick',[1,3],'XTicklabel',{'CA3a','CA3bc'},'XLim',[0,4],'YLim',[0,yLim(3)]);

hFRchange = axes('Position',axpt(nCol,nRow,1,3,[],wideInterval));
    patch([0 barWidth barWidth 0],[0, 0, barStack(1), barStack(1)],colorLightRed,'LineStyle','-');
    hold on;
    patch([0 barWidth barWidth 0],[barStack(1), barStack(1), barStack(1)+barStack(2), (barStack(1)+barStack(2))],colorLightBlue,'LineStyle','-');
    hold on;
    patch([0 barWidth barWidth 0],[barStack(1)+barStack(2), (barStack(1)+barStack(2)), 100 100],colorLightGray,'LineStyle','-');
    text(barWidth*0.3,barStack(1)/2,[num2str(barStack(1)),'%'],'fontSize',fontM);
    text(barWidth*0.3,barStack(1)+barStack(2)/2,[num2str(barStack(2)),'%'],'fontSize',fontM);
    text(barWidth*0.3,barStack(1)+barStack(2)+barStack(3)/2,[num2str(barStack(3)),'%'],'fontSize',fontM);
    set(hFRchange,'visible','off','XLim',[0,2],'YLim',[0,150]);
    
print('-painters','-r300','-dtiff',['plot_novel_population_',datestr(now,formatOut),'.tif']);
close all;