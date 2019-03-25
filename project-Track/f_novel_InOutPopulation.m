clc; clearvars; close all;

cd('E:\Dropbox\SNL\P2_Track');
load('E:\Dropbox\SNL\P2_Track\myParameters.mat');
formatOut = 'yymmdd';
saveDir = 'E:\Dropbox\SNL\P2_Track';

load('neuronList_novel_181024.mat');

PN = T.neuronType == 'PN';


m_lapFrInBasePRE = cellfun(@(x) x(1), T.m_lapFrInzone);
m_lapFrInPRE = cellfun(@(x) x(2), T.m_lapFrInzone);
m_lapFrInSTIM = cellfun(@(x) x(3), T.m_lapFrInzone);
m_lapFrInPOST = cellfun(@(x) x(4), T.m_lapFrInzone);
m_lapFrInBasePOST = cellfun(@(x) x(5), T.m_lapFrInzone);

% index of significant change
idx_pPRExSTIM = cellfun(@(x) x(1,1)<0.05, T.p_ttestFr);

% index of increase & decrease 
idx_inc = m_lapFrInPRE<m_lapFrInSTIM;
idx_dec = m_lapFrInPRE>m_lapFrInSTIM;
FrThr = min(m_lapFrInPRE(PN & idx_dec & idx_pPRExSTIM)); % minimum firing rate (threhold) of PRE firing rate
idx_FrThr = m_lapFrInPRE>=FrThr; % idx of threshold passed neurons

% population
nThrbefore(1) = sum(double(PN & idx_inc & idx_pPRExSTIM));
nThrbefore(2) = sum(double(PN & idx_dec & idx_pPRExSTIM));
nThrbefore(3) = sum(double(PN & ~idx_pPRExSTIM));

nThrAfter(1) = sum(double(PN & idx_inc & idx_FrThr & idx_pPRExSTIM));
nThrAfter(2) = sum(double(PN & idx_dec & idx_FrThr & idx_pPRExSTIM));
nThrAfter(3) = sum(double(PN & idx_FrThr & ~idx_pPRExSTIM));

