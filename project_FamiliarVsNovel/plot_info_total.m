clearvars; close all;
rtDir = 'E:\Dropbox\SNL\P4_FamiliarNovel';
load('E:\Dropbox\Lab_mwjung\P2_Track\myParameters.mat');
formatOut = 'yymmdd';
load('E:\Dropbox\Lab_mwjung\P4_FamiliarNovel\neuronList_novel_190301.mat');

T_nov = T;
PN_nov = T_nov.neuronType == 'PN';
tt_ca3bc = ((T_nov.mouseID == 'rbp005' & (T_nov.tetrode == 'TT1' | T_nov.tetrode == 'TT5')) | (T_nov.mouseID == 'rbp006' & T_nov.tetrode == 'TT2') | (T_nov.mouseID == 'rbp010' & T_nov.tetrode == 'TT6')); % | (T_novel.mouseID == 'rbp015' & T_novel.tetrode == 'TT7')
PN_nov_ca3bc = PN_nov & tt_ca3bc;
PN_nov_ca3a = PN_nov & ~tt_ca3bc;

load('E:\Dropbox\Lab_mwjung\P4_FamiliarNovel\neuronList_familiar_190301.mat');
T_fam = T;
tt_ca3bc = ((T_fam.mouseID == 'rbp005' & (T_fam.tetrode == 'TT1' | T_fam.tetrode == 'TT5')) | (T_fam.mouseID == 'rbp006' & T_fam.tetrode == 'TT2') | (T_fam.mouseID == 'rbp010' & T_fam.tetrode == 'TT6')); % | (T_novel.mouseID == 'rbp015' & T_novel.tetrode == 'TT7')
PN_fam = T_fam.neuronType == 'PN';
PN_fam_ca3bc = PN_fam & tt_ca3bc;
PN_fam_ca3a = PN_fam & ~tt_ca3bc;

nov_act = PN_nov & T_nov.idxmFrIn == 1;
nov_inh = PN_nov & T_nov.idxmFrIn == -1;
nov_non = PN_nov & T_nov.idxmFrIn == 0;

n_nov_act = sum(double(nov_act));
n_nov_inh = sum(double(nov_inh));
n_nov_non = sum(double(nov_non));

fam_act = PN_fam & T_fam.idxmFrIn == 1;
fam_inh = PN_fam & T_fam.idxmFrIn == -1;
fam_non = PN_fam & T_fam.idxmFrIn == 0;

n_fam_act = sum(double(fam_act));
n_fam_inh = sum(double(fam_inh));
n_fam_non = sum(double(fam_non));

%% number of neurons
n_nov_ca3a = sum(double(PN_nov_ca3a));
n_nov_ca3bc = sum(double(PN_nov_ca3bc));
n_nov_total = n_nov_ca3a+n_nov_ca3bc;
prop_nov_total = round([n_nov_ca3a, n_nov_ca3bc]/n_nov_total*100)/100*100;

n_nov_ca3a_act = sum(double(PN_nov_ca3a &T_nov.idxmSpkIn == 1));
n_nov_ca3a_inh = sum(double(PN_nov_ca3a & T_nov.idxmSpkIn == -1));
n_nov_ca3a_no = sum(double(PN_nov_ca3a & T_nov.idxmSpkIn == 0));
n_nov_ca3a_other = sum(double(PN_nov_ca3a & ~(T_nov.idxmSpkIn == 1)));
% prop_nov_ca3a_total = round([n_nov_ca3a_act, n_nov_ca3a_inh, n_nov_ca3a_no]/n_nov_ca3a*100)/100*100;
prop_nov_ca3a = round([n_nov_ca3a_act, n_nov_ca3a_other]/n_nov_ca3a*100)/100*100;

n_nov_ca3bc_act = sum(double(PN_nov_ca3bc & T_nov.idxmSpkIn == 1));
n_nov_ca3bc_inh = sum(double(PN_nov_ca3bc & T_nov.idxmSpkIn == -1));
n_nov_ca3bc_no = sum(double(PN_nov_ca3bc & T_nov.idxmSpkIn == 0));
n_nov_ca3bc_other = sum(double(PN_nov_ca3bc & ~(T_nov.idxmSpkIn == 1)));
% prop_nov_ca3bc_total = round([n_nov_ca3bc_act, n_nov_ca3bc_inh, n_nov_ca3bc_no]/n_nov_ca3bc*100)/100*100;
prop_nov_ca3bc = round([n_nov_ca3bc_act, n_nov_ca3bc_other]/n_nov_ca3bc*100)/100*100;

n_nov_ca3_act = n_nov_ca3a_act+n_nov_ca3bc_act;
n_nov_ca3_other = n_nov_ca3a_other + n_nov_ca3bc_other;
prop_n_nov_total = round([n_nov_ca3_act, n_nov_ca3_other]/n_nov_total*100)/100*100;

n_fam_ca3a = sum(double(PN_fam_ca3a));
n_fam_ca3bc = sum(double(PN_fam_ca3bc));
n_fam_total = n_fam_ca3a+n_fam_ca3bc;
prop_fam_total = round([n_fam_ca3a, n_fam_ca3bc]/n_fam_total*100)/100*100;

n_fam_ca3a_act = sum(double(PN_fam_ca3a & T_fam.idxmSpkIn == 1));
n_fam_ca3a_inh = sum(double(PN_fam_ca3a & T_fam.idxmSpkIn == -1));
n_fam_ca3a_no = sum(double(PN_fam_ca3a & T_fam.idxmSpkIn == 0));
n_fam_ca3a_other = sum(double(PN_fam_ca3a & ~(T_fam.idxmSpkIn == 1)));
% prop_fam_ca3a_total = round([n_fam_ca3a_act, n_fam_ca3a_inh, n_fam_ca3a_no]/n_fam_ca3a*100)/100*100;
prop_fam_ca3a = round([n_fam_ca3a_act, n_fam_ca3a_other]/n_fam_ca3a*100)/100*100;

n_fam_ca3bc_act = sum(double(PN_fam_ca3bc & T_fam.idxmSpkIn == 1));
n_fam_ca3bc_inh = sum(double(PN_fam_ca3bc & T_fam.idxmSpkIn == -1));
n_fam_ca3bc_no = sum(double(PN_fam_ca3bc & T_fam.idxmSpkIn == 0));
n_fam_ca3bc_other = sum(double(PN_fam_ca3bc & ~(T_fam.idxmSpkIn == 1)));
% prop_fam_ca3bc_total = round([n_fam_ca3bc_act, n_fam_ca3bc_inh, n_fam_ca3bc_no]/n_fam_ca3bc*100)/100*100;
prop_fam_ca3bc = round([n_fam_ca3bc_act, n_fam_ca3bc_other]/n_fam_ca3bc*100)/100*100;

n_fam_ca3_act = n_fam_ca3a_act + n_fam_ca3bc_act;
n_fam_ca3_other = n_fam_ca3a_other + n_fam_ca3bc_other;
prop_n_fam_total = ([n_fam_ca3_act, n_fam_ca3_other]/n_fam_total*100)/100*100;

%% number of neurons with threshold
m_nov_inPRE = cellfun(@(x) x(2), T_nov.m_lapFrInzone);
min_nov_lapFrInPRE = min(m_nov_inPRE(PN_nov & T_nov.idxmSpkIn == -1)); % <<<<<<<<<<<<<< firing rate base
idx_nov_thrPass = m_nov_inPRE>=min_nov_lapFrInPRE;

n_nov_ca3a_th = sum(double(PN_nov_ca3a & idx_nov_thrPass));
n_nov_ca3bc_th = sum(double(PN_nov_ca3bc & idx_nov_thrPass));
n_nov_total_th = n_nov_ca3a_th+n_nov_ca3bc_th;
prop_nov_total_th = round([n_nov_ca3a_th, n_nov_ca3bc_th]/n_nov_total_th*100)/100*100;

n_nov_ca3a_act_th = sum(double(PN_nov_ca3a & T_nov.idxmSpkIn == 1 & idx_nov_thrPass));
n_nov_ca3a_inh_th = sum(double(PN_nov_ca3a & T_nov.idxmSpkIn == -1 & idx_nov_thrPass));
n_nov_ca3a_no_th = sum(double(PN_nov_ca3a & T_nov.idxmSpkIn == 0 & idx_nov_thrPass));
n_nov_ca3a_other_th = sum(double(PN_nov_ca3a & ~(T_nov.idxmSpkIn == 1) & idx_nov_thrPass));
% prop_nov_ca3a_total_th = round([n_nov_ca3a_act_th, n_nov_ca3a_inh_th, n_nov_ca3a_no_th]/n_nov_ca3a_th*100)/100*100;
prop_nov_ca3a_th = round([n_nov_ca3a_act_th, n_nov_ca3a_other_th]/n_nov_ca3a_th*100)/100*100;

n_nov_ca3bc_act_th = sum(double(PN_nov_ca3bc & T_nov.idxmSpkIn == 1 & idx_nov_thrPass));
n_nov_ca3bc_inh_th = sum(double(PN_nov_ca3bc & T_nov.idxmSpkIn == -1 & idx_nov_thrPass));
n_nov_ca3bc_no_th = sum(double(PN_nov_ca3bc & T_nov.idxmSpkIn == 0 & idx_nov_thrPass));
n_nov_ca3bc_other_th = sum(double(PN_nov_ca3bc & ~(T_nov.idxmSpkIn == 1) & idx_nov_thrPass));
% prop_nov_ca3bc_total_th = round([n_nov_ca3bc_act_th, n_nov_ca3bc_inh_th, n_nov_ca3bc_no_th]/n_nov_ca3bc_th*100)/100*100;
prop_nov_ca3bc_th = round([n_nov_ca3bc_act_th, n_nov_ca3bc_other_th]/n_nov_ca3bc_th*100)/100*100;

n_nov_ca3_act_th = n_nov_ca3a_act_th + n_nov_ca3bc_act_th;
n_nov_ca3_other_th = n_nov_ca3a_other_th + n_nov_ca3bc_other_th;
prop_n_nov_total_th = round([n_nov_ca3_act_th, n_nov_ca3_other_th]/n_nov_total_th*100)/100*100;

m_fam_inPRE = cellfun(@(x) x(2), T_fam.m_lapFrInzone);
min_fam_lapFrInPRE = min(m_fam_inPRE(PN_fam & T_fam.idxmSpkIn == -1)); % <<<<<<<<<<<<<< firing rate base
idx_fam_thrPass = m_fam_inPRE>=min_fam_lapFrInPRE;

n_fam_ca3a_th = sum(double(PN_fam_ca3a & idx_fam_thrPass));
n_fam_ca3bc_th = sum(double(PN_fam_ca3bc & idx_fam_thrPass));
n_fam_total_th = n_fam_ca3a_th+n_fam_ca3bc_th;
prop_fam_total_th = round([n_fam_ca3a_th, n_fam_ca3bc_th]/n_fam_total_th*100)/100*100;

n_fam_ca3a_act_th = sum(double(PN_fam_ca3a & T_fam.idxmSpkIn == 1 & idx_fam_thrPass));
n_fam_ca3a_inh_th = sum(double(PN_fam_ca3a & T_fam.idxmSpkIn == -1 & idx_fam_thrPass));
n_fam_ca3a_no_th = sum(double(PN_fam_ca3a & T_fam.idxmSpkIn == 0 & idx_fam_thrPass));
n_fam_ca3a_other_th = sum(double(PN_fam_ca3a & ~(T_fam.idxmSpkIn == 1) & idx_fam_thrPass));
% prop_fam_ca3a_total_th = round([n_fam_ca3a_act_th, n_fam_ca3a_inh_th, n_fam_ca3a_no_th]/n_fam_ca3a_th*100)/100*100;
prop_fam_ca3a_th = round([n_fam_ca3a_act_th, n_fam_ca3a_other_th]/n_fam_ca3a_th*100)/100*100;

n_fam_ca3bc_act_th = sum(double(PN_fam_ca3bc & T_fam.idxmSpkIn == 1 & idx_fam_thrPass));
n_fam_ca3bc_inh_th = sum(double(PN_fam_ca3bc & T_fam.idxmSpkIn == -1 & idx_fam_thrPass));
n_fam_ca3bc_no_th = sum(double(PN_fam_ca3bc & T_fam.idxmSpkIn == 0 & idx_fam_thrPass));
n_fam_ca3bc_other_th = sum(double(PN_fam_ca3bc & ~(T_fam.idxmSpkIn == 1) & idx_fam_thrPass));
% prop_fam_ca3bc_total_th = round([n_fam_ca3bc_act_th, n_fam_ca3bc_inh_th, n_fam_ca3bc_no_th]/n_fam_ca3bc_th*100)/100*100;
prop_fam_ca3bc_th = round([n_fam_ca3bc_act_th, n_fam_ca3bc_other_th]/n_fam_ca3bc_th*100)/100*100;

n_fam_ca3_act_th = n_fam_ca3a_act_th + n_fam_ca3bc_act_th;
n_fam_ca3_other_th = n_fam_ca3a_other_th + n_fam_ca3bc_other_th;
prop_n_fam_total_th = ([n_fam_ca3_act_th, n_fam_ca3_other_th]/n_fam_total_th*100)/100*100;

%% plot
fHandle = figure('PaperUnits','centimeter','PaperPosition',[0 0 15 10]);

nCol = 3;
nRow = 2;
barWidth = 0.5;
xptBar = [1,3];
xptBar_nov = [xptBar(1)-barWidth xptBar(1)+barWidth xptBar(1)+barWidth xptBar(1)-barWidth];
xptBar_fam = [xptBar(2)-barWidth xptBar(2)+barWidth xptBar(2)+barWidth xptBar(2)-barWidth];

hBar(1) = axes('Position',axpt(nCol,nRow,1,1,[],wideInterval));
    patch(xptBar_nov,[0 0 prop_n_nov_total(1) prop_n_nov_total(1)],colorLightRed,'LineStyle','-');
    hold on;
    patch(xptBar_nov,[prop_n_nov_total(1) prop_n_nov_total(1) sum(prop_n_nov_total) sum(prop_n_nov_total)],colorGray,'LineStyle','-');
    hold on;
    patch(xptBar_fam,[0 0 prop_n_fam_total(1) prop_n_fam_total(1)],colorLightRed,'LineStyle','-');
    hold on;
    patch(xptBar_fam,[prop_n_fam_total(1) prop_n_fam_total(1) sum(prop_n_fam_total) sum(prop_n_fam_total)],colorGray,'LineStyle','-');
    text(xptBar(1)*0.7,prop_n_nov_total(1)*0.5,'Act.','fontSize',fontM);
    text(xptBar(1)*0.7,prop_n_nov_total(1)+prop_n_nov_total(2)*0.5,'Oth.','fontSize',fontM);
    title('Total','fontSize',fontM);
    ylabel('Population ratio (%)','fontSize',fontM);

hBar(2) = axes('Position',axpt(nCol,nRow,2,1,[],wideInterval));
    patch(xptBar_nov,[0 0 prop_nov_ca3a(1) prop_nov_ca3a(1)],colorLightRed,'LineStyle','-');
    hold on;
    patch(xptBar_nov,[prop_nov_ca3a(1) prop_nov_ca3a(1) sum(prop_nov_ca3a) sum(prop_nov_ca3a)],colorGray,'LineStyle','-');
    hold on;
    patch(xptBar_fam,[0 0 prop_fam_ca3a(1) prop_fam_ca3a(1)],colorLightRed,'LineStyle','-');
    hold on;
    patch(xptBar_fam,[prop_fam_ca3a(1) prop_fam_ca3a(1) sum(prop_fam_ca3a) sum(prop_fam_ca3a)],colorGray,'LineStyle','-');
    text(xptBar(1)*0.7,prop_nov_ca3a(1)*0.5,'Act.','fontSize',fontM);
    text(xptBar(1)*0.7,prop_nov_ca3a(1)+prop_nov_ca3a(2)*0.5,'Oth.','fontSize',fontM);
    title('CA3a','fontSize',fontM);
    ylabel('Population ratio (%)','fontSize',fontM);

hBar(3) = axes('Position',axpt(nCol,nRow,3,1,[],wideInterval));
    patch(xptBar_nov,[0 0 prop_nov_ca3bc(1) prop_nov_ca3bc(1)],colorLightRed,'LineStyle','-');
    hold on;
    patch(xptBar_nov,[prop_nov_ca3bc(1) prop_nov_ca3bc(1) sum(prop_nov_ca3bc) sum(prop_nov_ca3bc)],colorGray,'LineStyle','-');
    hold on;
    patch(xptBar_fam,[0 0 prop_fam_ca3bc(1) prop_fam_ca3bc(1)],colorLightRed,'LineStyle','-');
    hold on;
    patch(xptBar_fam,[prop_fam_ca3bc(1) prop_fam_ca3bc(1) sum(prop_fam_ca3bc) sum(prop_fam_ca3bc)],colorGray,'LineStyle','-');
    text(xptBar(1)*0.7,prop_nov_ca3bc(1)*0.5,'Act.','fontSize',fontM);
    text(xptBar(1)*0.7,prop_nov_ca3bc(1)+prop_nov_ca3bc(2)*0.5,'Oth.','fontSize',fontM);
    title('CA3bc','fontSize',fontM);
    ylabel('Population ratio (%)','fontSize',fontM);
    
hBar(4) = axes('Position',axpt(nCol,nRow,1,2,[],wideInterval));
    patch(xptBar_nov,[0 0 prop_nov_ca3a(1) prop_nov_ca3a(1)],colorLightRed,'LineStyle','-');
    hold on;
    patch(xptBar_nov,[prop_nov_ca3a(1) prop_nov_ca3a(1) sum(prop_nov_ca3a) sum(prop_nov_ca3a)],colorGray,'LineStyle','-');
    hold on;
    patch(xptBar_fam,[0 0 prop_nov_ca3bc(1) prop_nov_ca3bc(1)],colorLightRed,'LineStyle','-');
    hold on;
    patch(xptBar_fam,[prop_nov_ca3bc(1) prop_nov_ca3bc(1) sum(prop_nov_ca3bc) sum(prop_nov_ca3bc)],colorGray,'LineStyle','-');
    text(xptBar(1)*0.7,prop_nov_ca3a(1)*0.5,'Act.','fontSize',fontM);
    text(xptBar(1)*0.7,prop_nov_ca3a(1)+prop_nov_ca3a(2)*0.5,'Oth.','fontSize',fontM);
    title('Novel','fontSize',fontM);
    ylabel('Population ratio (%)','fontSize',fontM);
        
hBar(5) = axes('Position',axpt(nCol,nRow,2,2,[],wideInterval));
    patch(xptBar_nov,[0 0 prop_fam_ca3a(1) prop_fam_ca3a(1)],colorLightRed,'LineStyle','-');
    hold on;
    patch(xptBar_nov,[prop_fam_ca3a(1) prop_fam_ca3a(1) sum(prop_fam_ca3a) sum(prop_fam_ca3a)],colorGray,'LineStyle','-');
    hold on;
    patch(xptBar_fam,[0 0 prop_fam_ca3bc(1) prop_fam_ca3bc(1)],colorLightRed,'LineStyle','-');
    hold on;
    patch(xptBar_fam,[prop_fam_ca3bc(1) prop_fam_ca3bc(1) sum(prop_fam_ca3bc) sum(prop_fam_ca3bc)],colorGray,'LineStyle','-');
    text(xptBar(1)*0.7,prop_fam_ca3a(1)*0.5,'Act.','fontSize',fontM);
    text(xptBar(1)*0.7,prop_fam_ca3a(1)+prop_fam_ca3a(2)*0.5,'Oth.','fontSize',fontM);
    title('Familiar','fontSize',fontM);
    ylabel('Population ratio (%)','fontSize',fontM);

set(hBar(1:3),'Box','off','TickDir','out','XLim',[0 4],'XTick',[1,3],'XTicklabel',{'Novel','Familiar'},'YLim',[0 100],'fontSize',fontM);
set(hBar(4:5),'Box','off','TickDir','out','XLim',[0 4],'XTick',[1,3],'XTicklabel',{'CA3a','ca3b/c'},'YLim',[0 100],'fontSize',fontM);

print('-painters','-r300','-dtiff',['plot_infoPopul_total_',datestr(now,formatOut),'.tif']);