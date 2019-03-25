clearvars;
rtDir = 'E:\Dropbox\Lab_mwjung\P4_FamiliarNovel';
load('E:\Dropbox\Lab_mwjung\P2_Track\myParameters.mat');
formatOut = 'yymmdd';

load('E:\Dropbox\Lab_mwjung\P4_FamiliarNovel\neuronList_familiar_190301.mat');
% load('E:\Dropbox\Lab_mwjung\P4_FamiliarNovel\neuronList_familiar_190203.mat');
PN = T.neuronType == 'PN';
tt_ca3bc = ((T.mouseID == 'rbp005' & (T.tetrode == 'TT1' | T.tetrode == 'TT5')) | (T.mouseID == 'rbp006' & T.tetrode == 'TT2') | (T.mouseID == 'rbp010' & T.tetrode == 'TT6')); % | (T.mouseID == 'rbp015' & T.tetrode == 'TT7')
PN_ca3bc = PN & tt_ca3bc;
PN_ca3a = PN & ~tt_ca3bc;

% original
% lightLoc_in = [37:98];
% lightLoc_out = [1:36,99:124];

lightLoc_in = [50:84];
lightLoc_out = [1:22,112:124];

cri_peakFR = 2;

% CA3 total
PN_th = PN & cellfun(@(x) max(max(x)), T.pethconvSpatial)>cri_peakFR;
nPN_th_fam = sum(double(PN_th));

PRE = cell2mat(T.rateMap1D_PRE(PN_th));
STIM = cell2mat(T.rateMap1D_STM(PN_th));
POST = cell2mat(T.rateMap1D_POST(PN_th));

nBin = size(PRE,2);

% normalize
PRE = PRE./repmat(max(PRE,[],2),1,nBin);
STIM = STIM./repmat(max(STIM,[],2),1,nBin);
POST = POST./repmat(max(POST,[],2),1,nBin);

% inzone
inZone_PRE = PRE(:,lightLoc_in);
inZone_STIM = STIM(:,lightLoc_in);
inZone_POST = POST(:,lightLoc_in);

% outzone
outZone_PRE = PRE(:,lightLoc_out);
outZone_STIM = STIM(:,lightLoc_out);
outZone_POST = POST(:,lightLoc_out);

[rCor_fam_in_PRExSTIM, rCor_fam_in_PRExPOST, rCor_fam_in_STIMxPOST] = deal([]);
[rCor_fam_out_PRExSTIM, rCor_fam_out_PRExPOST, rCor_fam_out_STIMxPOST] = deal([]);

for iCell = 1:nPN_th_fam
    rCor_fam_in_PRExSTIM(iCell,1) = corr(inZone_PRE(iCell,:)',inZone_STIM(iCell,:)','rows','complete','type','pearson');
    rCor_fam_in_PRExPOST(iCell,1) = corr(inZone_PRE(iCell,:)',inZone_POST(iCell,:)','rows','complete','type','pearson');
    rCor_fam_in_STIMxPOST(iCell,1) = corr(inZone_STIM(iCell,:)',inZone_POST(iCell,:)','rows','complete','type','pearson');
    rCor_fam_out_PRExSTIM(iCell,1) = corr(outZone_PRE(iCell,:)',outZone_STIM(iCell,:)','rows','complete','type','pearson');
    rCor_fam_out_PRExPOST(iCell,1) = corr(outZone_PRE(iCell,:)',outZone_POST(iCell,:)','rows','complete','type','pearson');
    rCor_fam_out_STIMxPOST(iCell,1) = corr(outZone_STIM(iCell,:)',outZone_POST(iCell,:)','rows','complete','type','pearson');
end

% mean spatial correlation
m_rCor_fam_in = [nanmean(rCor_fam_in_PRExSTIM), nanmean(rCor_fam_in_PRExPOST), nanmean(rCor_fam_in_STIMxPOST)];
sem_rCor_fam_in = [nanstd(rCor_fam_in_PRExSTIM)/sqrt(sum(double(~isnan(rCor_fam_in_PRExSTIM)))), nanstd(rCor_fam_in_PRExPOST)/sqrt(sum(double(~isnan(rCor_fam_in_PRExPOST)))), nanstd(rCor_fam_in_STIMxPOST)/sqrt(sum(double(~isnan(rCor_fam_in_STIMxPOST))))];
m_rCor_fam_out = [nanmean(rCor_fam_out_PRExSTIM), nanmean(rCor_fam_out_PRExPOST), nanmean(rCor_fam_out_STIMxPOST)];
sem_rCor_fam_out = [nanstd(rCor_fam_out_PRExSTIM)/sqrt(sum(double(~isnan(rCor_fam_out_PRExSTIM)))), nanstd(rCor_fam_out_PRExPOST)/sqrt(sum(double(~isnan(rCor_fam_out_PRExPOST)))), nanstd(rCor_fam_out_STIMxPOST)/sqrt(sum(double(~isnan(rCor_fam_out_STIMxPOST))))];

% CA3a
PN_th_a = PN_ca3a & cellfun(@(x) max(max(x)), T.pethconvSpatial)>cri_peakFR;
nPN_th_fam_a = sum(double(PN_th_a));

PRE_a = cell2mat(T.rateMap1D_PRE(PN_th_a));
STIM_a = cell2mat(T.rateMap1D_STM(PN_th_a));
POST_a = cell2mat(T.rateMap1D_POST(PN_th_a));

nBin_a = size(PRE_a,2);

% normalize
PRE_a = PRE_a./repmat(max(PRE_a,[],2),1,nBin_a);
STIM_a = STIM_a./repmat(max(STIM_a,[],2),1,nBin_a);
POST_a = POST_a./repmat(max(POST_a,[],2),1,nBin_a);

% inzone
inZone_PRE_a = PRE_a(:,lightLoc_in);
inZone_STIM_a = STIM_a(:,lightLoc_in);
inZone_POST_a = POST_a(:,lightLoc_in);

% outzone
outZone_PRE_a = PRE_a(:,lightLoc_out);
outZone_STIM_a = STIM_a(:,lightLoc_out);
outZone_POST_a = POST_a(:,lightLoc_out);

[rCor_fam_in_PRExSTIM_a, rCor_fam_in_PRExPOST_a, rCor_fam_in_STIMxPOST_a] = deal([]);
[rCor_fam_out_PRExSTIM_a, rCor_fam_out_PRExPOST_a, rCor_fam_out_STIMxPOST_a] = deal([]);

for iCell = 1:nPN_th_fam_a
    rCor_fam_in_PRExSTIM_a(iCell,1) = corr(inZone_PRE_a(iCell,:)',inZone_STIM_a(iCell,:)','rows','complete','type','pearson');
    rCor_fam_in_PRExPOST_a(iCell,1) = corr(inZone_PRE_a(iCell,:)',inZone_POST_a(iCell,:)','rows','complete','type','pearson');
    rCor_fam_in_STIMxPOST_a(iCell,1) = corr(inZone_STIM_a(iCell,:)',inZone_POST_a(iCell,:)','rows','complete','type','pearson');
    rCor_fam_out_PRExSTIM_a(iCell,1) = corr(outZone_PRE_a(iCell,:)',outZone_STIM_a(iCell,:)','rows','complete','type','pearson');
    rCor_fam_out_PRExPOST_a(iCell,1) = corr(outZone_PRE_a(iCell,:)',outZone_POST_a(iCell,:)','rows','complete','type','pearson');
    rCor_fam_out_STIMxPOST_a(iCell,1) = corr(outZone_STIM_a(iCell,:)',outZone_POST_a(iCell,:)','rows','complete','type','pearson');
end

% mean spatial correlation
m_rCor_fam_in_a = [nanmean(rCor_fam_in_PRExSTIM_a), nanmean(rCor_fam_in_PRExPOST_a), nanmean(rCor_fam_in_STIMxPOST_a)];
sem_rCor_fam_in_a = [nanstd(rCor_fam_in_PRExSTIM_a)/sqrt(sum(double(~isnan(rCor_fam_in_PRExSTIM_a)))), nanstd(rCor_fam_in_PRExPOST_a)/sqrt(sum(double(~isnan(rCor_fam_in_PRExPOST_a)))), nanstd(rCor_fam_in_STIMxPOST_a)/sqrt(sum(double(~isnan(rCor_fam_in_STIMxPOST_a))))];
m_rCor_fam_out_a = [nanmean(rCor_fam_out_PRExSTIM_a), nanmean(rCor_fam_out_PRExPOST_a), nanmean(rCor_fam_out_STIMxPOST_a)];
sem_rCor_fam_out_a = [nanstd(rCor_fam_out_PRExSTIM_a)/sqrt(sum(double(~isnan(rCor_fam_out_PRExSTIM_a)))), nanstd(rCor_fam_out_PRExPOST_a)/sqrt(sum(double(~isnan(rCor_fam_out_PRExPOST_a)))), nanstd(rCor_fam_out_STIMxPOST_a)/sqrt(sum(double(~isnan(rCor_fam_out_STIMxPOST_a))))];

% ca3bc
PN_th_bc = PN_ca3bc & cellfun(@(x) max(max(x)), T.pethconvSpatial)>cri_peakFR;
nPN_th_fam_bc = sum(double(PN_th_bc));

PRE_bc = cell2mat(T.rateMap1D_PRE(PN_th_bc));
STIM_bc = cell2mat(T.rateMap1D_STM(PN_th_bc));
POST_bc = cell2mat(T.rateMap1D_POST(PN_th_bc));

nBin_bc = size(PRE_bc,2);

% normalize
PRE_bc = PRE_bc./repmat(max(PRE_bc,[],2),1,nBin_bc);
STIM_bc = STIM_bc./repmat(max(STIM_bc,[],2),1,nBin_bc);
POST_bc = POST_bc./repmat(max(POST_bc,[],2),1,nBin_bc);

% inzone
inZone_PRE_bc = PRE_bc(:,lightLoc_in);
inZone_STIM_bc = STIM_bc(:,lightLoc_in);
inZone_POST_bc = POST_bc(:,lightLoc_in);

% outzone
outZone_PRE_bc = PRE_bc(:,lightLoc_out);
outZone_STIM_bc = STIM_bc(:,lightLoc_out);
outZone_POST_bc = POST_bc(:,lightLoc_out);

[rCor_fam_in_PRExSTIM_bc, rCor_fam_in_PRExPOST_bc, rCor_fam_in_STIMxPOST_bc] = deal([]);
[rCor_fam_out_PRExSTIM_bc, rCor_fam_out_PRExPOST_bc, rCor_fam_out_STIMxPOST_bc] = deal([]);

for iCell = 1:nPN_th_fam_bc
    rCor_fam_in_PRExSTIM_bc(iCell,1) = corr(inZone_PRE_bc(iCell,:)',inZone_STIM_bc(iCell,:)','rows','complete','type','pearson');
    rCor_fam_in_PRExPOST_bc(iCell,1) = corr(inZone_PRE_bc(iCell,:)',inZone_POST_bc(iCell,:)','rows','complete','type','pearson');
    rCor_fam_in_STIMxPOST_bc(iCell,1) = corr(inZone_STIM_bc(iCell,:)',inZone_POST_bc(iCell,:)','rows','complete','type','pearson');
    
    rCor_fam_out_PRExSTIM_bc(iCell,1) = corr(outZone_PRE_bc(iCell,:)',outZone_STIM_bc(iCell,:)','rows','complete','type','pearson');
    rCor_fam_out_PRExPOST_bc(iCell,1) = corr(outZone_PRE_bc(iCell,:)',outZone_POST_bc(iCell,:)','rows','complete','type','pearson');
    rCor_fam_out_STIMxPOST_bc(iCell,1) = corr(outZone_STIM_bc(iCell,:)',outZone_POST_bc(iCell,:)','rows','complete','type','pearson');
end

% mean spatial correlation
m_rCor_fam_in_bc = [nanmean(rCor_fam_in_PRExSTIM_bc), nanmean(rCor_fam_in_PRExPOST_bc), nanmean(rCor_fam_in_STIMxPOST_bc)];
sem_rCor_fam_in_bc = [nanstd(rCor_fam_in_PRExSTIM_bc)/sqrt(sum(double(~isnan(rCor_fam_in_PRExSTIM_bc)))), nanstd(rCor_fam_in_PRExPOST_bc)/sqrt(sum(double(~isnan(rCor_fam_in_PRExPOST_bc)))), nanstd(rCor_fam_in_STIMxPOST_bc)/sqrt(sum(double(~isnan(rCor_fam_in_STIMxPOST_bc))))];
m_rCor_fam_out_bc = [nanmean(rCor_fam_out_PRExSTIM_bc), nanmean(rCor_fam_out_PRExPOST_bc), nanmean(rCor_fam_out_STIMxPOST_bc)];
sem_rCor_fam_out_bc = [nanstd(rCor_fam_out_PRExSTIM_bc)/sqrt(sum(double(~isnan(rCor_fam_out_PRExSTIM_bc)))), nanstd(rCor_fam_out_PRExPOST_bc)/sqrt(sum(double(~isnan(rCor_fam_out_PRExPOST_bc)))), nanstd(rCor_fam_out_STIMxPOST_bc)/sqrt(sum(double(~isnan(rCor_fam_out_STIMxPOST_bc))))];

% statistic test
[~, p_val_fam(1)] = ttest(rCor_fam_in_PRExSTIM, rCor_fam_out_PRExSTIM);
[~, p_val_fam(2)] = ttest(rCor_fam_in_PRExPOST, rCor_fam_out_PRExPOST);
[~, p_val_fam(3)] = ttest(rCor_fam_in_STIMxPOST, rCor_fam_out_STIMxPOST);

[~, p_val_fam_a(1)] = ttest(rCor_fam_in_PRExSTIM_a, rCor_fam_out_PRExSTIM_a);
[~, p_val_fam_a(2)] = ttest(rCor_fam_in_PRExPOST_a, rCor_fam_out_PRExPOST_a);
[~, p_val_fam_a(3)] = ttest(rCor_fam_in_STIMxPOST_a, rCor_fam_out_STIMxPOST_a);

p_val_fam_bc(1) = ranksum(rCor_fam_in_PRExSTIM_bc, rCor_fam_out_PRExSTIM_bc);
p_val_fam_bc(2) = ranksum(rCor_fam_in_PRExPOST_bc, rCor_fam_out_PRExPOST_bc);
p_val_fam_bc(3) = ranksum(rCor_fam_in_STIMxPOST_bc, rCor_fam_out_STIMxPOST_bc);

%%
load('E:\Dropbox\Lab_mwjung\P4_FamiliarNovel\neuronList_novel_190301.mat');
PN = T.neuronType == 'PN';
tt_ca3bc = ((T.mouseID == 'rbp005' & (T.tetrode == 'TT1' | T.tetrode == 'TT5')) | (T.mouseID == 'rbp006' & T.tetrode == 'TT2') | (T.mouseID == 'rbp010' & T.tetrode == 'TT6')); % | (T.mouseID == 'rbp015' & T.tetrode == 'TT7')
PN_ca3bc = PN & tt_ca3bc;
PN_ca3a = PN & ~tt_ca3bc;

% CA3 total
PN_th = PN & cellfun(@(x) max(max(x(2:4,:))), T.pethconvSpatial)>cri_peakFR;
nPN_th_nov = sum(double(PN_th));

PRE = cell2mat(T.rateMap1D_PRE(PN_th));
STIM = cell2mat(T.rateMap1D_STM(PN_th));
POST = cell2mat(T.rateMap1D_POST(PN_th));

nBin = size(PRE,2);

% normalize
PRE = PRE./repmat(max(PRE,[],2),1,nBin);
STIM = STIM./repmat(max(STIM,[],2),1,nBin);
POST = POST./repmat(max(POST,[],2),1,nBin);

% inzone
inZone_PRE = PRE(:,lightLoc_in);
inZone_STIM = STIM(:,lightLoc_in);
inZone_POST = POST(:,lightLoc_in);

% outzone
outZone_PRE = PRE(:,lightLoc_out);
outZone_STIM = STIM(:,lightLoc_out);
outZone_POST = POST(:,lightLoc_out);

[rCor_nov_in_PRExSTIM, rCor_nov_in_PRExPOST, rCor_nov_in_STIMxPOST] = deal([]);
[rCor_nov_out_PRExSTIM, rCor_nov_out_PRExPOST, rCor_nov_out_STIMxPOST] = deal([]);

for iCell = 1:nPN_th_nov
    rCor_nov_in_PRExSTIM(iCell,1) = corr(inZone_PRE(iCell,:)',inZone_STIM(iCell,:)','rows','complete','type','pearson');
    rCor_nov_in_PRExPOST(iCell,1) = corr(inZone_PRE(iCell,:)',inZone_POST(iCell,:)','rows','complete','type','pearson');
    rCor_nov_in_STIMxPOST(iCell,1) = corr(inZone_STIM(iCell,:)',inZone_POST(iCell,:)','rows','complete','type','pearson');
    
    rCor_nov_out_PRExSTIM(iCell,1) = corr(outZone_PRE(iCell,:)',outZone_STIM(iCell,:)','rows','complete','type','pearson');
    rCor_nov_out_PRExPOST(iCell,1) = corr(outZone_PRE(iCell,:)',outZone_POST(iCell,:)','rows','complete','type','pearson');
    rCor_nov_out_STIMxPOST(iCell,1) = corr(outZone_STIM(iCell,:)',outZone_POST(iCell,:)','rows','complete','type','pearson');
end

% mean spatial correlation
m_rCor_nov_in = [nanmean(rCor_nov_in_PRExSTIM), nanmean(rCor_nov_in_PRExPOST), nanmean(rCor_nov_in_STIMxPOST)];
sem_rCor_nov_in = [nanstd(rCor_nov_in_PRExSTIM)/sqrt(sum(double(~isnan(rCor_nov_in_PRExSTIM)))), nanstd(rCor_nov_in_PRExPOST)/sqrt(sum(double(~isnan(rCor_nov_in_PRExPOST)))), nanstd(rCor_nov_in_STIMxPOST)/sqrt(sum(double(~isnan(rCor_nov_in_STIMxPOST))))];
m_rCor_nov_out = [nanmean(rCor_nov_out_PRExSTIM), nanmean(rCor_nov_out_PRExPOST), nanmean(rCor_nov_out_STIMxPOST)];
sem_rCor_nov_out = [nanstd(rCor_nov_out_PRExSTIM)/sqrt(sum(double(~isnan(rCor_nov_out_PRExSTIM)))), nanstd(rCor_nov_out_PRExPOST)/sqrt(sum(double(~isnan(rCor_nov_out_PRExPOST)))), nanstd(rCor_nov_out_STIMxPOST)/sqrt(sum(double(~isnan(rCor_nov_out_STIMxPOST))))];

% CA3a
PN_th_a = PN_ca3a & cellfun(@(x) max(max(x(2:4,:))), T.pethconvSpatial)>cri_peakFR;
nPN_th_nov_a = sum(double(PN_th_a));

PRE_a = cell2mat(T.rateMap1D_PRE(PN_th_a));
STIM_a = cell2mat(T.rateMap1D_STM(PN_th_a));
POST_a = cell2mat(T.rateMap1D_POST(PN_th_a));

nBin_a = size(PRE_a,2);

% normalize
PRE_a = PRE_a./repmat(max(PRE_a,[],2),1,nBin_a);
STIM_a = STIM_a./repmat(max(STIM_a,[],2),1,nBin_a);
POST_a = POST_a./repmat(max(POST_a,[],2),1,nBin_a);

% inzone
inZone_PRE_a = PRE_a(:,lightLoc_in);
inZone_STIM_a = STIM_a(:,lightLoc_in);
inZone_POST_a = POST_a(:,lightLoc_in);

% outzone
outZone_PRE_a = PRE_a(:,lightLoc_out);
outZone_STIM_a = STIM_a(:,lightLoc_out);
outZone_POST_a = POST_a(:,lightLoc_out);

[rCor_nov_in_PRExSTIM_a, rCor_nov_in_PRExPOST_a, rCor_nov_in_STIMxPOST_a] = deal([]);
[rCor_nov_out_PRExSTIM_a, rCor_nov_out_PRExPOST_a, rCor_nov_out_STIMxPOST_a] = deal([]);

for iCell = 1:nPN_th_nov_a
    rCor_nov_in_PRExSTIM_a(iCell,1) = corr(inZone_PRE_a(iCell,:)',inZone_STIM_a(iCell,:)','rows','complete','type','pearson');
    rCor_nov_in_PRExPOST_a(iCell,1) = corr(inZone_PRE_a(iCell,:)',inZone_POST_a(iCell,:)','rows','complete','type','pearson');
    rCor_nov_in_STIMxPOST_a(iCell,1) = corr(inZone_STIM_a(iCell,:)',inZone_POST_a(iCell,:)','rows','complete','type','pearson');
    
    rCor_nov_out_PRExSTIM_a(iCell,1) = corr(outZone_PRE_a(iCell,:)',outZone_STIM_a(iCell,:)','rows','complete','type','pearson');
    rCor_nov_out_PRExPOST_a(iCell,1) = corr(outZone_PRE_a(iCell,:)',outZone_POST_a(iCell,:)','rows','complete','type','pearson');
    rCor_nov_out_STIMxPOST_a(iCell,1) = corr(outZone_STIM_a(iCell,:)',outZone_POST_a(iCell,:)','rows','complete','type','pearson');
end

% mean spatial correlation
m_rCor_nov_in_a = [nanmean(rCor_nov_in_PRExSTIM_a), nanmean(rCor_nov_in_PRExPOST_a), nanmean(rCor_nov_in_STIMxPOST_a)];
sem_rCor_nov_in_a = [nanstd(rCor_nov_in_PRExSTIM_a)/sqrt(sum(double(~isnan(rCor_nov_in_PRExSTIM_a)))), nanstd(rCor_nov_in_PRExPOST_a)/sqrt(sum(double(~isnan(rCor_nov_in_PRExPOST_a)))), nanstd(rCor_nov_in_STIMxPOST_a)/sqrt(sum(double(~isnan(rCor_nov_in_STIMxPOST_a))))];
m_rCor_nov_out_a = [nanmean(rCor_nov_out_PRExSTIM_a), nanmean(rCor_nov_out_PRExPOST_a), nanmean(rCor_nov_out_STIMxPOST_a)];
sem_rCor_nov_out_a = [nanstd(rCor_nov_out_PRExSTIM_a)/sqrt(sum(double(~isnan(rCor_nov_out_PRExSTIM_a)))), nanstd(rCor_nov_out_PRExPOST_a)/sqrt(sum(double(~isnan(rCor_nov_out_PRExPOST_a)))), nanstd(rCor_nov_out_STIMxPOST_a)/sqrt(sum(double(~isnan(rCor_nov_out_STIMxPOST_a))))];

% ca3bc
PN_th_bc = PN_ca3bc & cellfun(@(x) max(max(x(2:4,:))), T.pethconvSpatial)>cri_peakFR;
nPN_th_nov_bc = sum(double(PN_th_bc));

PRE_bc = cell2mat(T.rateMap1D_PRE(PN_th_bc));
STIM_bc = cell2mat(T.rateMap1D_STM(PN_th_bc));
POST_bc = cell2mat(T.rateMap1D_POST(PN_th_bc));

nBin_bc = size(PRE_bc,2);

% normalize
PRE_bc = PRE_bc./repmat(max(PRE_bc,[],2),1,nBin_bc);
STIM_bc = STIM_bc./repmat(max(STIM_bc,[],2),1,nBin_bc);
POST_bc = POST_bc./repmat(max(POST_bc,[],2),1,nBin_bc);

% inzone
inZone_PRE_bc = PRE_bc(:,lightLoc_in);
inZone_STIM_bc = STIM_bc(:,lightLoc_in);
inZone_POST_bc = POST_bc(:,lightLoc_in);

% outzone
outZone_PRE_bc = PRE_bc(:,lightLoc_out);
outZone_STIM_bc = STIM_bc(:,lightLoc_out);
outZone_POST_bc = POST_bc(:,lightLoc_out);

[rCor_nov_in_PRExSTIM_bc, rCor_nov_in_PRExPOST_bc, rCor_nov_in_STIMxPOST_bc] = deal([]);
[rCor_nov_out_PRExSTIM_bc, rCor_nov_out_PRExPOST_bc, rCor_nov_out_STIMxPOST_bc] = deal([]);

for iCell = 1:nPN_th_nov_bc
    rCor_nov_in_PRExSTIM_bc(iCell,1) = corr(inZone_PRE_bc(iCell,:)',inZone_STIM_bc(iCell,:)','rows','complete','type','pearson');
    rCor_nov_in_PRExPOST_bc(iCell,1) = corr(inZone_PRE_bc(iCell,:)',inZone_POST_bc(iCell,:)','rows','complete','type','pearson');
    rCor_nov_in_STIMxPOST_bc(iCell,1) = corr(inZone_STIM_bc(iCell,:)',inZone_POST_bc(iCell,:)','rows','complete','type','pearson');
    
    rCor_nov_out_PRExSTIM_bc(iCell,1) = corr(outZone_PRE_bc(iCell,:)',outZone_STIM_bc(iCell,:)','rows','complete','type','pearson');
    rCor_nov_out_PRExPOST_bc(iCell,1) = corr(outZone_PRE_bc(iCell,:)',outZone_POST_bc(iCell,:)','rows','complete','type','pearson');
    rCor_nov_out_STIMxPOST_bc(iCell,1) = corr(outZone_STIM_bc(iCell,:)',outZone_POST_bc(iCell,:)','rows','complete','type','pearson');
end

% mean spatial correlation
m_rCor_nov_in_bc = [nanmean(rCor_nov_in_PRExSTIM_bc), nanmean(rCor_nov_in_PRExPOST_bc), nanmean(rCor_nov_in_STIMxPOST_bc)];
sem_rCor_nov_in_bc = [nanstd(rCor_nov_in_PRExSTIM_bc)/sqrt(sum(double(~isnan(rCor_nov_in_PRExSTIM_bc)))), nanstd(rCor_nov_in_PRExPOST_bc)/sqrt(sum(double(~isnan(rCor_nov_in_PRExPOST_bc)))), nanstd(rCor_nov_in_STIMxPOST_bc)/sqrt(sum(double(~isnan(rCor_nov_in_STIMxPOST_bc))))];
m_rCor_nov_out_bc = [nanmean(rCor_nov_out_PRExSTIM_bc), nanmean(rCor_nov_out_PRExPOST_bc), nanmean(rCor_nov_out_STIMxPOST_bc)];
sem_rCor_nov_out_bc = [nanstd(rCor_nov_out_PRExSTIM_bc)/sqrt(sum(double(~isnan(rCor_nov_out_PRExSTIM_bc)))), nanstd(rCor_nov_out_PRExPOST_bc)/sqrt(sum(double(~isnan(rCor_nov_out_PRExPOST_bc)))), nanstd(rCor_nov_out_STIMxPOST_bc)/sqrt(sum(double(~isnan(rCor_nov_out_STIMxPOST_bc))))];

% statistic test
[~, p_val_nov(1)] = ttest(rCor_nov_in_PRExSTIM, rCor_nov_out_PRExSTIM);
[~, p_val_nov(2)] = ttest(rCor_nov_in_PRExPOST, rCor_nov_out_PRExPOST);
[~, p_val_nov(3)] = ttest(rCor_nov_in_STIMxPOST, rCor_nov_out_STIMxPOST);
[~, p_val_nov_a(1)] = ttest(rCor_nov_in_PRExSTIM_a, rCor_nov_out_PRExSTIM_a);
[~, p_val_nov_a(2)] = ttest(rCor_nov_in_PRExPOST_a, rCor_nov_out_PRExPOST_a);
[~, p_val_nov_a(3)] = ttest(rCor_nov_in_STIMxPOST_a, rCor_nov_out_STIMxPOST_a);
p_val_nov_bc(1) = ranksum(rCor_nov_in_PRExSTIM_bc, rCor_nov_out_PRExSTIM_bc);
p_val_nov_bc(2) = ranksum(rCor_nov_in_PRExPOST_bc, rCor_nov_out_PRExPOST_bc);
p_val_nov_bc(3) = ranksum(rCor_nov_in_STIMxPOST_bc, rCor_nov_out_STIMxPOST_bc);

[~, p_val_fam(1)] = ttest(rCor_fam_in_PRExSTIM, rCor_fam_out_PRExSTIM);
[~, p_val_fam(2)] = ttest(rCor_fam_in_PRExPOST, rCor_fam_out_PRExPOST);
[~, p_val_fam(3)] = ttest(rCor_fam_in_STIMxPOST, rCor_fam_out_STIMxPOST);
[~, p_val_fam_a(1)] = ttest(rCor_fam_in_PRExSTIM_a, rCor_fam_out_PRExSTIM_a);
[~, p_val_fam_a(2)] = ttest(rCor_fam_in_PRExPOST_a, rCor_fam_out_PRExPOST_a);
[~, p_val_fam_a(3)] = ttest(rCor_fam_in_STIMxPOST_a, rCor_fam_out_STIMxPOST_a);
p_val_fam_bc(1) = ranksum(rCor_fam_in_PRExSTIM_bc, rCor_fam_out_PRExSTIM_bc);
p_val_fam_bc(2) = ranksum(rCor_fam_in_PRExPOST_bc, rCor_fam_out_PRExPOST_bc);
p_val_fam_bc(3) = ranksum(rCor_fam_in_STIMxPOST_bc, rCor_fam_out_STIMxPOST_bc);

% anova_all_PRExSTIM = [rCor_fam_in_PRExSTIM; rCor_fam_out_PRExSTIM; rCor_nov_in_PRExSTIM; rCor_nov_out_PRExSTIM];
% anova_all_PRExPOST = [rCor_fam_in_PRExPOST; rCor_fam_out_PRExPOST; rCor_nov_in_PRExPOST; rCor_nov_out_PRExPOST];
% anova_all_STIMxPOST = [rCor_fam_in_STIMxPOST; rCor_fam_out_STIMxPOST; rCor_nov_in_STIMxPOST; rCor_nov_out_STIMxPOST];
% g1 = [repelem({'In'},70,1);repelem({'Out'},70,1);repelem({'In'},56,1);repelem({'Out'},56,1)];
% g2 = [repelem({'Fam'},140,1); repelem({'Nov'},112,1)];
% p_anova_all(:,1) = anovan(anova_all_PRExSTIM,{g1,g2},'varnames',{'InOut','FamNov'},'display','off');
% p_anova_all(:,2) = anovan(anova_all_PRExPOST,{g1,g2},'varnames',{'InOut','FamNov'},'display','off');
% p_anova_all(:,3) = anovan(anova_all_STIMxPOST,{g1,g2},'varnames',{'InOut','FamNov'},'display','off');
% 
% anova_ca3a_PRExSTIM = [rCor_fam_in_PRExSTIM_a; rCor_fam_out_PRExSTIM_a; rCor_nov_in_PRExSTIM_a; rCor_nov_out_PRExSTIM_a];
% anova_ca3a_PRExPOST = [rCor_fam_in_PRExPOST_a; rCor_fam_out_PRExPOST_a; rCor_nov_in_PRExPOST_a; rCor_nov_out_PRExPOST_a];
% anova_ca3a_STIMxPOST = [rCor_fam_in_STIMxPOST_a; rCor_fam_out_STIMxPOST_a; rCor_nov_in_STIMxPOST_a; rCor_nov_out_STIMxPOST_a];
% g1 = [repelem({'In'},60,1);repelem({'Out'},60,1);repelem({'In'},49,1);repelem({'Out'},49,1)];
% g2 = [repelem({'Fam'},120,1); repelem({'Nov'},98,1)];
% p_anova_ca3a(:,1) = anovan(anova_ca3a_PRExSTIM,{g1,g2},'varnames',{'InOut','FamNov'},'display','off');
% p_anova_ca3a(:,2) = anovan(anova_ca3a_PRExPOST,{g1,g2},'varnames',{'InOut','FamNov'},'display','off');
% p_anova_ca3a(:,3) = anovan(anova_ca3a_STIMxPOST,{g1,g2},'varnames',{'InOut','FamNov'},'display','off');
% 
% anova_ca3bc_PRExSTIM = [rCor_fam_in_PRExSTIM_bc; rCor_fam_out_PRExSTIM_bc; rCor_nov_in_PRExSTIM_bc; rCor_nov_out_PRExSTIM_bc];
% anova_ca3bc_PRExPOST = [rCor_fam_in_PRExPOST_bc; rCor_fam_out_PRExPOST_bc; rCor_nov_in_PRExPOST_bc; rCor_nov_out_PRExPOST_bc];
% anova_ca3bc_STIMxPOST = [rCor_fam_in_STIMxPOST_bc; rCor_fam_out_STIMxPOST_bc; rCor_nov_in_STIMxPOST_bc; rCor_nov_out_STIMxPOST_bc];
% g1 = [repelem({'In'},10,1);repelem({'Out'},10,1);repelem({'In'},7,1);repelem({'Out'},7,1)];
% g2 = [repelem({'Fam'},20,1); repelem({'Nov'},14,1)];
% p_anova_ca3bc(:,1) = anovan(anova_ca3bc_PRExSTIM,{g1,g2},'varnames',{'InOut','FamNov'},'display','off');
% p_anova_ca3bc(:,2) = anovan(anova_ca3bc_PRExPOST,{g1,g2},'varnames',{'InOut','FamNov'},'display','off');
% p_anova_ca3bc(:,3) = anovan(anova_ca3bc_STIMxPOST,{g1,g2},'varnames',{'InOut','FamNov'},'display','off');

%%
barWidth = 0.15;
eBarLength = 0.4;
eBarWidth = 1;
dotS = 4;
colorDot = [55 55 55]/255;

xBar = [1,7,13;
        2,8,14;
        3,9,15;
        4,10,16];

xScatter_fam = (rand(nPN_th_fam,1)-0.5)*barWidth*2.2;
xScatter_fam_a = (rand(nPN_th_fam_a,1)-0.5)*barWidth*2.2;
xScatter_fam_bc = (rand(nPN_th_fam_bc,1)-0.5)*barWidth*2.2;

xScatter_nov = (rand(nPN_th_nov,1)-0.5)*barWidth*2.2;
xScatter_nov_a = (rand(nPN_th_nov_a,1)-0.5)*barWidth*2.2;
xScatter_nov_bc = (rand(nPN_th_nov_bc,1)-0.5)*barWidth*2.2;

nCol = 2;
nRow = 3;
figSize = [0.12 0.1 0.75 0.80];
wideInterval = [0.05 0.1];

fHandle = figure('PaperUnits','centimeters','PaperPosition',[0 0 12 14]);

hCor(1) = axes('Position',axpt(nCol,nRow,1,1,figSize,wideInterval));
    bar(xBar(1,:),m_rCor_fam_in,barWidth,'faceColor',colorLLightBlue);
    hold on;
    errorbarJun(xBar(1,:),m_rCor_fam_in,sem_rCor_fam_in,eBarLength,eBarWidth,colorBlack);
    hold on;
    bar(xBar(2,:),m_rCor_fam_out,barWidth,'faceColor',colorGray);
    hold on;
    errorbarJun(xBar(2,:),m_rCor_fam_out,sem_rCor_fam_out,eBarLength,eBarWidth,colorBlack);
    hold on;
    bar(xBar(3,:),m_rCor_nov_in,barWidth,'faceColor',colorLightBlue);
    hold on;
    errorbarJun(xBar(3,:),m_rCor_nov_in,sem_rCor_nov_in,eBarLength,eBarWidth,colorBlack);
    hold on;
    bar(xBar(4,:),m_rCor_nov_out,barWidth,'faceColor',colorDarkGray);
    hold on;
    errorbarJun(xBar(4,:),m_rCor_nov_out,sem_rCor_nov_out,eBarLength,eBarWidth,colorBlack);
    hold on;

    plot(1+xScatter_fam,rCor_fam_in_PRExSTIM,'.','markerSize',dotS,'markerEdgeColor',colorDot);
    hold on;
    plot(7+xScatter_fam,rCor_fam_in_PRExPOST,'.','markerSize',dotS,'markerEdgeColor',colorDot);
    hold on;
    plot(13+xScatter_fam,rCor_fam_in_STIMxPOST,'.','markerSize',dotS,'markerEdgeColor',colorDot);
    hold on;
    plot(2+xScatter_fam,rCor_fam_out_PRExSTIM,'.','markerSize',dotS,'markerEdgeColor',colorDot);
    hold on;
    plot(8+xScatter_fam,rCor_fam_out_PRExPOST,'.','markerSize',dotS,'markerEdgeColor',colorDot);
    hold on;
    plot(14+xScatter_fam,rCor_fam_out_STIMxPOST,'.','markerSize',dotS,'markerEdgeColor',colorDot);
    hold on;
    plot(3+xScatter_nov,rCor_nov_in_PRExSTIM,'.','markerSize',dotS,'markerEdgeColor',colorDot);
    hold on;
    plot(9+xScatter_nov,rCor_nov_in_PRExPOST,'.','markerSize',dotS,'markerEdgeColor',colorDot);
    hold on;
    plot(15+xScatter_nov,rCor_nov_in_STIMxPOST,'.','markerSize',dotS,'markerEdgeColor',colorDot);
    hold on;
    plot(4+xScatter_nov,rCor_nov_out_PRExSTIM,'.','markerSize',dotS,'markerEdgeColor',colorDot);
    hold on;
    plot(10+xScatter_nov,rCor_nov_out_PRExPOST,'.','markerSize',dotS,'markerEdgeColor',colorDot);
    hold on;
    plot(16+xScatter_nov,rCor_nov_out_STIMxPOST,'.','markerSize',dotS,'markerEdgeColor',colorDot);

    text(10,-0.7,['n (familiar) = ',num2str(nPN_th_fam)],'fontSize',fontM);
    text(10,-0.9,['n (novel) = ',num2str(nPN_th_nov)],'fontSize',fontM);
    ylabel('Spatial correlation (r)','fontSize',fontM);

hCor(2) = axes('Position',axpt(nCol,nRow,1,2,figSize,wideInterval));
    bar(xBar(1,:),m_rCor_fam_in_a,barWidth,'faceColor',colorLLightBlue);
    hold on;
    errorbarJun(xBar(1,:),m_rCor_fam_in_a,sem_rCor_fam_in_a,eBarLength,eBarWidth,colorBlack);
    hold on;
    bar(xBar(2,:),m_rCor_fam_out_a,barWidth,'faceColor',colorGray);
    hold on;
    errorbarJun(xBar(2,:),m_rCor_fam_out_a,sem_rCor_fam_out_a,eBarLength,eBarWidth,colorBlack);
    hold on;
    bar(xBar(3,:),m_rCor_nov_in_a,barWidth,'faceColor',colorLightBlue);
    hold on;
    errorbarJun(xBar(3,:),m_rCor_nov_in_a,sem_rCor_nov_in_a,eBarLength,eBarWidth,colorBlack);
    hold on;
    bar(xBar(4,:),m_rCor_nov_out_a,barWidth,'faceColor',colorDarkGray);
    hold on;
    errorbarJun(xBar(4,:),m_rCor_nov_out_a,sem_rCor_nov_out_a,eBarLength,eBarWidth,colorBlack);
    hold on;

    plot(1+xScatter_fam_a,rCor_fam_in_PRExSTIM_a,'.','markerSize',dotS,'markerEdgeColor',colorDot);
    hold on;
    plot(7+xScatter_fam_a,rCor_fam_in_PRExPOST_a,'.','markerSize',dotS,'markerEdgeColor',colorDot);
    hold on;
    plot(13+xScatter_fam_a,rCor_fam_in_STIMxPOST_a,'.','markerSize',dotS,'markerEdgeColor',colorDot);
    hold on;
    plot(2+xScatter_fam_a,rCor_fam_out_PRExSTIM_a,'.','markerSize',dotS,'markerEdgeColor',colorDot);
    hold on;
    plot(8+xScatter_fam_a,rCor_fam_out_PRExPOST_a,'.','markerSize',dotS,'markerEdgeColor',colorDot);
    hold on;
    plot(14+xScatter_fam_a,rCor_fam_out_STIMxPOST_a,'.','markerSize',dotS,'markerEdgeColor',colorDot);
    hold on;
    plot(3+xScatter_nov_a,rCor_nov_in_PRExSTIM_a,'.','markerSize',dotS,'markerEdgeColor',colorDot);
    hold on;
    plot(9+xScatter_nov_a,rCor_nov_in_PRExPOST_a,'.','markerSize',dotS,'markerEdgeColor',colorDot);
    hold on;
    plot(15+xScatter_nov_a,rCor_nov_in_STIMxPOST_a,'.','markerSize',dotS,'markerEdgeColor',colorDot);
    hold on;
    plot(4+xScatter_nov_a,rCor_nov_out_PRExSTIM_a,'.','markerSize',dotS,'markerEdgeColor',colorDot);
    hold on;
    plot(10+xScatter_nov_a,rCor_nov_out_PRExPOST_a,'.','markerSize',dotS,'markerEdgeColor',colorDot);
    hold on;
    plot(16+xScatter_nov_a,rCor_nov_out_STIMxPOST_a,'.','markerSize',dotS,'markerEdgeColor',colorDot);

    text(10,-0.7,['n (familiar) = ',num2str(nPN_th_fam_a)],'fontSize',fontM);
    text(10,-0.9,['n (novel) = ',num2str(nPN_th_nov_a)],'fontSize',fontM);
    ylabel('Spatial correlation (r)','fontSize',fontM);

hCor(3) = axes('Position',axpt(nCol,nRow,1,3,figSize,wideInterval));
    bar(xBar(1,:),m_rCor_fam_in_bc,barWidth,'faceColor',colorLLightBlue);
    hold on;
    errorbarJun(xBar(1,:),m_rCor_fam_in_bc,sem_rCor_fam_in_bc,eBarLength,eBarWidth,colorBlack);
    hold on;
    bar(xBar(2,:),m_rCor_fam_out_bc,barWidth,'faceColor',colorGray);
    hold on;
    errorbarJun(xBar(2,:),m_rCor_fam_out_bc,sem_rCor_fam_out_bc,eBarLength,eBarWidth,colorBlack);
    hold on;
    bar(xBar(3,:),m_rCor_nov_in_bc,barWidth,'faceColor',colorLightBlue);
    hold on;
    errorbarJun(xBar(3,:),m_rCor_nov_in_bc,sem_rCor_nov_in_bc,eBarLength,eBarWidth,colorBlack);
    hold on;
    bar(xBar(4,:),m_rCor_nov_out_bc,barWidth,'faceColor',colorDarkGray);
    hold on;
    errorbarJun(xBar(4,:),m_rCor_nov_out_bc,sem_rCor_nov_out_bc,eBarLength,eBarWidth,colorBlack);
    hold on;

    plot(1+xScatter_fam_bc,rCor_fam_in_PRExSTIM_bc,'.','markerSize',dotS,'markerEdgeColor',colorDot);
    hold on;
    plot(7+xScatter_fam_bc,rCor_fam_in_PRExPOST_bc,'.','markerSize',dotS,'markerEdgeColor',colorDot);
    hold on;
    plot(13+xScatter_fam_bc,rCor_fam_in_STIMxPOST_bc,'.','markerSize',dotS,'markerEdgeColor',colorDot);
    hold on;
    plot(2+xScatter_fam_bc,rCor_fam_out_PRExSTIM_bc,'.','markerSize',dotS,'markerEdgeColor',colorDot);
    hold on;
    plot(8+xScatter_fam_bc,rCor_fam_out_PRExPOST_bc,'.','markerSize',dotS,'markerEdgeColor',colorDot);
    hold on;
    plot(14+xScatter_fam_bc,rCor_fam_out_STIMxPOST_bc,'.','markerSize',dotS,'markerEdgeColor',colorDot);
    hold on;
    plot(3+xScatter_nov_bc,rCor_nov_in_PRExSTIM_bc,'.','markerSize',dotS,'markerEdgeColor',colorDot);
    hold on;
    plot(9+xScatter_nov_bc,rCor_nov_in_PRExPOST_bc,'.','markerSize',dotS,'markerEdgeColor',colorDot);
    hold on;
    plot(15+xScatter_nov_bc,rCor_nov_in_STIMxPOST_bc,'.','markerSize',dotS,'markerEdgeColor',colorDot);
    hold on;
    plot(4+xScatter_nov_bc,rCor_nov_out_PRExSTIM_bc,'.','markerSize',dotS,'markerEdgeColor',colorDot);
    hold on;
    plot(10+xScatter_nov_bc,rCor_nov_out_PRExPOST_bc,'.','markerSize',dotS,'markerEdgeColor',colorDot);
    hold on;
    plot(16+xScatter_nov_bc,rCor_nov_out_STIMxPOST_bc,'.','markerSize',dotS,'markerEdgeColor',colorDot);
    hold on;

    text(10,-0.7,['n (familiar) = ',num2str(nPN_th_fam_bc)],'fontSize',fontM);
    text(10,-0.9,['n (novel) = ',num2str(nPN_th_nov_bc)],'fontSize',fontM);
    ylabel('Spatial correlation (r)','fontSize',fontM);
set(hCor,'Box','off','TickDir','out','XLim',[0,17],'XTick',[2.5, 8.5, 14.5],'XTickLabel',{'PRExSTIM','PRExPOST','STIMxPOST'},'YLim',[-1,1.5],'YTick',-1:0.5:1,'fontSize',fontM);

hCor(4) = axes('Position',axpt(nCol,nRow,2,1,figSize,wideInterval));
    text(0.1, 1.0, ['Fam: p = ',num2str(p_val_fam(1))],'fontSize',fontM);
    text(0.1, 0.9, ['Fam: p = ',num2str(p_val_fam(2))],'fontSize',fontM);
    text(0.1, 0.8, ['Fam: p = ',num2str(p_val_fam(3))],'fontSize',fontM);
    text(0.1, 0.6, ['Nov: p = ',num2str(p_val_nov(1))],'fontSize',fontM);
    text(0.1, 0.5, ['Nov: p = ',num2str(p_val_nov(2))],'fontSize',fontM);
    text(0.1, 0.4, ['Nov: p = ',num2str(p_val_nov(3))],'fontSize',fontM);
    text(0.1, 0.2, ['Anova: p = ',num2str(p_anova_all(2,1))],'fontSize',fontM);
    text(0.1, 0.1, ['Anova: p = ',num2str(p_anova_all(2,2))],'fontSize',fontM);
    text(0.1, 0.0, ['Anova: p = ',num2str(p_anova_all(2,3))],'fontSize',fontM);
    
hCor(5) = axes('Position',axpt(nCol,nRow,2,2,figSize,wideInterval));
    text(0.1, 1.0, ['Fam: p = ',num2str(p_val_fam_a(1))],'fontSize',fontM);
    text(0.1, 0.9, ['Fam: p = ',num2str(p_val_fam_a(2))],'fontSize',fontM);
    text(0.1, 0.8, ['Fam: p = ',num2str(p_val_fam_a(3))],'fontSize',fontM);
    text(0.1, 0.6, ['Nov: p = ',num2str(p_val_nov_a(1))],'fontSize',fontM);
    text(0.1, 0.5, ['Nov: p = ',num2str(p_val_nov_a(2))],'fontSize',fontM);
    text(0.1, 0.4, ['Nov: p = ',num2str(p_val_nov_a(3))],'fontSize',fontM);
    text(0.1, 0.2, ['Anova: p = ',num2str(p_anova_ca3a(2,1))],'fontSize',fontM);
    text(0.1, 0.1, ['Anova: p = ',num2str(p_anova_ca3a(2,2))],'fontSize',fontM);
    text(0.1, 0.0, ['Anova: p = ',num2str(p_anova_ca3a(2,3))],'fontSize',fontM);
    
hCor(6) = axes('Position',axpt(nCol,nRow,2,3,figSize,wideInterval));
    text(0.1, 1.0, ['Fam: p = ',num2str(p_val_fam_bc(1))],'fontSize',fontM);
    text(0.1, 0.9, ['Fam: p = ',num2str(p_val_fam_bc(2))],'fontSize',fontM);
    text(0.1, 0.8, ['Fam: p = ',num2str(p_val_fam_bc(3))],'fontSize',fontM);
    text(0.1, 0.6, ['Nov: p = ',num2str(p_val_nov_bc(1))],'fontSize',fontM);
    text(0.1, 0.5, ['Nov: p = ',num2str(p_val_nov_bc(2))],'fontSize',fontM);
    text(0.1, 0.4, ['Nov: p = ',num2str(p_val_nov_bc(3))],'fontSize',fontM);
    text(0.1, 0.2, ['Anova: p = ',num2str(p_anova_ca3bc(2,1))],'fontSize',fontM);
    text(0.1, 0.1, ['Anova: p = ',num2str(p_anova_ca3bc(2,2))],'fontSize',fontM);
    text(0.1, 0.0, ['Anova: p = ',num2str(p_anova_ca3bc(2,3))],'fontSize',fontM);
set(hCor(4:6),'visible',' off');

print('-painters','-r300','-dtiff',['fig5_spatialcorrelation_',datestr(now,formatOut),'.tif']);
% print('-painters','-r300','-depsc',['fig6_spatialcorrelation_',datestr(now,formatOut),'.ai']);

close all;