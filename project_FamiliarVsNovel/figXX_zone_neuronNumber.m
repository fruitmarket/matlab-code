clearvars;

load('D:\Dropbox\Lab_mwjung\P2_Track\myParameters.mat');
formatOut = 'yymmdd';
load('D:\Dropbox\Lab_mwjung\P4_FamiliarNovel\neuronList_novel_190301.mat');
T_nov = T;
pn_nov = T_nov.neuronType == 'PN';
in_nov = T_nov.neuronType == 'IN';
tt_ca3bc_nov = ((T_nov.mouseID == 'rbp005' & (T_nov.tetrode == 'TT1' | T_nov.tetrode == 'TT5')) | (T_nov.mouseID == 'rbp006' & T_nov.tetrode == 'TT2') | (T_nov.mouseID == 'rbp010' & T_nov.tetrode == 'TT6'));
ca3bc_nov = pn_nov & tt_ca3bc_nov;
ca3a_nov = pn_nov & ~tt_ca3bc_nov;

load('D:\Dropbox\Lab_mwjung\P4_FamiliarNovel\neuronList_familiar_190301.mat');
T_fam = T;
pn_fam = T_fam.neuronType == 'PN';
in_fam = T_fam.neuronType == 'IN';
tt_ca3bc_fam = ((T_fam.mouseID == 'rbp005' & (T_fam.tetrode == 'TT1' | T_fam.tetrode == 'TT5')) | (T_fam.mouseID == 'rbp006' & T_fam.tetrode == 'TT2') | (T_fam.mouseID == 'rbp010' & T_fam.tetrode == 'TT6'));
ca3bc_fam = pn_fam & tt_ca3bc_fam;
ca3a_fam = pn_fam & ~tt_ca3bc_fam;

n_fam_ca3bc(1) = sum(double(T_fam.idxmFrIn == 1 & ca3bc_fam));
n_fam_ca3bc(2) = sum(double(T_fam.idxmFrIn == -1 & ca3bc_fam));
n_fam_ca3bc(3) = sum(double(T_fam.idxmFrIn == 0 & ca3bc_fam));

n_fam_ca3a(1) = sum(double(T_fam.idxmFrIn == 1 & ca3a_fam));
n_fam_ca3a(2) = sum(double(T_fam.idxmFrIn == -1 & ca3a_fam));
n_fam_ca3a(3) = sum(double(T_fam.idxmFrIn == 0 & ca3a_fam));

p_fam = chisqNxN([6 62; 6 6]);

n_nov_ca3bc(1) = sum(double(T_nov.idxmFrIn == 1 & ca3bc_nov));
n_nov_ca3bc(2) = sum(double(T_nov.idxmFrIn == -1 & ca3bc_nov));
n_nov_ca3bc(3) = sum(double(T_nov.idxmFrIn == 0 & ca3bc_nov));

n_nov_ca3a(1) = sum(double(T_nov.idxmFrIn == 1 & ca3a_nov));
n_nov_ca3a(2) = sum(double(T_nov.idxmFrIn == -1 & ca3a_nov));
n_nov_ca3a(3) = sum(double(T_nov.idxmFrIn == 0 & ca3a_nov));

p_nov = chisqNxN([16 56; 4 7]); 