clearvars; close all;
formatOut = 'yymmdd';
cd('E:\Dropbox\SNL\P2_Track');
load('cscList_ori50hz_180926.mat');

taskType = 'DRw';
cscRun = T.taskType == taskType;
nRun = sum(double(cscRun));
%% Theta
temp = T.peakAmpOn_th_beforeOn(cscRun);
% peakAmpOn_th_bef_PRE = cell2mat(cellfun(@(x) x{1},temp,'UniformOutput',0));
% peakAmpOn_th_bef_STIM = cell2mat(cellfun(@(x) x{2},temp,'UniformOutput',0));
% peakAmpOn_th_bef_POST = cell2mat(cellfun(@(x) x{3},temp,'UniformOutput',0));
peakAmpOn_th_bef_PRE = cell2mat(cellfun(@(x) x{1}(end-1:end),temp,'UniformOutput',0));
peakAmpOn_th_bef_STIM = cell2mat(cellfun(@(x) x{2}(end-1:end),temp,'UniformOutput',0));
peakAmpOn_th_bef_POST = cell2mat(cellfun(@(x) x{3}(end-1:end),temp,'UniformOutput',0));

m_peakAmpOn_th_bef_PRE = mean(peakAmpOn_th_bef_PRE,1);
sem_peakAmpOn_th_bef_PRE = std(peakAmpOn_th_bef_PRE,0,1)/sqrt(nRun);
m_peakAmpOn_th_bef_STIM = mean(peakAmpOn_th_bef_STIM,1);
sem_peakAmpOn_th_bef_STIM = std(peakAmpOn_th_bef_STIM,0,1)/sqrt(nRun);
m_peakAmpOn_th_bef_POST = mean(peakAmpOn_th_bef_POST,1);
sem_peakAmpOn_th_bef_POST = std(peakAmpOn_th_bef_POST,0,1)/sqrt(nRun);

temp = T.peakAmpOn_th_afterOn(cscRun);
peakAmpOn_th_aft_PRE = cell2mat(cellfun(@(x) x{1},temp,'UniformOutput',0));
peakAmpOn_th_aft_STIM = cell2mat(cellfun(@(x) x{2},temp,'UniformOutput',0));
peakAmpOn_th_aft_POST = cell2mat(cellfun(@(x) x{3},temp,'UniformOutput',0));

m_peakAmpOn_th_aft_PRE = mean(peakAmpOn_th_aft_PRE,1);
sem_peakAmpOn_th_aft_PRE = std(peakAmpOn_th_aft_PRE,0,1)/sqrt(nRun);
m_peakAmpOn_th_aft_STIM = mean(peakAmpOn_th_aft_STIM,1);
sem_peakAmpOn_th_aft_STIM = std(peakAmpOn_th_aft_STIM,0,1)/sqrt(nRun);
m_peakAmpOn_th_aft_POST = mean(peakAmpOn_th_aft_POST,1);
sem_peakAmpOn_th_aft_POST = std(peakAmpOn_th_aft_POST,0,1)/sqrt(nRun);

m_peakAmpOn_th_PRE = [m_peakAmpOn_th_bef_PRE, m_peakAmpOn_th_aft_PRE];
m_peakAmpOn_th_STIM = [m_peakAmpOn_th_bef_STIM, m_peakAmpOn_th_aft_STIM];
m_peakAmpOn_th_POST = [m_peakAmpOn_th_bef_POST, m_peakAmpOn_th_aft_POST];

sem_peakAmpOn_th_PRE = [sem_peakAmpOn_th_bef_PRE, sem_peakAmpOn_th_aft_PRE];
sem_peakAmpOn_th_STIM = [sem_peakAmpOn_th_bef_STIM, sem_peakAmpOn_th_aft_STIM];
sem_peakAmpOn_th_POST = [sem_peakAmpOn_th_bef_POST, sem_peakAmpOn_th_aft_POST];

temp = T.peakAmpOff_th_beforeOn(cscRun);
peakAmpOff_th_bef_PRE = cell2mat(cellfun(@(x) x{1},temp,'UniformOutput',0));
peakAmpOff_th_bef_STIM = cell2mat(cellfun(@(x) x{2},temp,'UniformOutput',0));
peakAmpOff_th_bef_POST = cell2mat(cellfun(@(x) x{3},temp,'UniformOutput',0));

m_peakAmpOff_th_bef_PRE = mean(peakAmpOff_th_bef_PRE,1);
sem_peakAmpOff_th_bef_PRE = std(peakAmpOff_th_bef_PRE,0,1)/sqrt(nRun);
m_peakAmpOff_th_bef_STIM = mean(peakAmpOff_th_bef_STIM,1);
sem_peakAmpOff_th_bef_STIM = std(peakAmpOff_th_bef_STIM,0,1)/sqrt(nRun);
m_peakAmpOff_th_bef_POST = mean(peakAmpOff_th_bef_POST,1);
sem_peakAmpOff_th_bef_POST = std(peakAmpOff_th_bef_POST,0,1)/sqrt(nRun);

temp = T.peakAmpOff_th_afterOn(cscRun);
peakAmpOff_th_aft_PRE = cell2mat(cellfun(@(x) x{1}(end-1:end),temp,'UniformOutput',0));
peakAmpOff_th_aft_STIM = cell2mat(cellfun(@(x) x{2}(end-1:end),temp,'UniformOutput',0));
peakAmpOff_th_aft_POST = cell2mat(cellfun(@(x) x{3}(end-1:end),temp,'UniformOutput',0));

m_peakAmpOff_th_aft_PRE = mean(peakAmpOff_th_aft_PRE,1);
sem_peakAmpOff_th_aft_PRE = std(peakAmpOff_th_aft_PRE,0,1)/sqrt(nRun);
m_peakAmpOff_th_aft_STIM = mean(peakAmpOff_th_aft_STIM,1);
sem_peakAmpOff_th_aft_STIM = std(peakAmpOff_th_aft_STIM,0,1)/sqrt(nRun);
m_peakAmpOff_th_aft_POST = mean(peakAmpOff_th_aft_POST,1);
sem_peakAmpOff_th_aft_POST = std(peakAmpOff_th_aft_POST,0,1)/sqrt(nRun);

m_peakAmpOff_th_PRE = [m_peakAmpOff_th_bef_PRE, m_peakAmpOff_th_aft_PRE];
m_peakAmpOff_th_STIM = [m_peakAmpOff_th_bef_STIM, m_peakAmpOff_th_aft_STIM];
m_peakAmpOff_th_POST = [m_peakAmpOff_th_bef_POST, m_peakAmpOff_th_aft_POST];

sem_peakAmpOff_th_PRE = [sem_peakAmpOff_th_bef_PRE, sem_peakAmpOff_th_aft_PRE];
sem_peakAmpOff_th_STIM = [sem_peakAmpOff_th_bef_STIM, sem_peakAmpOff_th_aft_STIM];
sem_peakAmpOff_th_POST = [sem_peakAmpOff_th_bef_POST, sem_peakAmpOff_th_aft_POST];

%% slow gamma
temp = T.peakAmpOn_sg_beforeOn(cscRun);
peakAmpOn_sg_bef_PRE = cell2mat(cellfun(@(x) x{1},temp,'UniformOutput',0));
peakAmpOn_sg_bef_STIM = cell2mat(cellfun(@(x) x{2},temp,'UniformOutput',0));
peakAmpOn_sg_bef_POST = cell2mat(cellfun(@(x) x{3},temp,'UniformOutput',0));

m_peakAmpOn_sg_bef_PRE = mean(peakAmpOn_sg_bef_PRE,1);
sem_peakAmpOn_sg_bef_PRE = std(peakAmpOn_sg_bef_PRE,0,1)/sqrt(nRun);
m_peakAmpOn_sg_bef_STIM = mean(peakAmpOn_sg_bef_STIM,1);
sem_peakAmpOn_sg_bef_STIM = std(peakAmpOn_sg_bef_STIM,0,1)/sqrt(nRun);
m_peakAmpOn_sg_bef_POST = mean(peakAmpOn_sg_bef_POST,1);
sem_peakAmpOn_sg_bef_POST = std(peakAmpOn_sg_bef_POST,0,1)/sqrt(nRun);

temp = T.peakAmpOn_sg_afterOn(cscRun);
peakAmpOn_sg_aft_PRE = cell2mat(cellfun(@(x) x{1},temp,'UniformOutput',0));
peakAmpOn_sg_aft_STIM = cell2mat(cellfun(@(x) x{2},temp,'UniformOutput',0));
peakAmpOn_sg_aft_POST = cell2mat(cellfun(@(x) x{3},temp,'UniformOutput',0));

m_peakAmpOn_sg_aft_PRE = mean(peakAmpOn_sg_aft_PRE,1);
sem_peakAmpOn_sg_aft_PRE = std(peakAmpOn_sg_aft_PRE,0,1)/sqrt(nRun);
m_peakAmpOn_sg_aft_STIM = mean(peakAmpOn_sg_aft_STIM,1);
sem_peakAmpOn_sg_aft_STIM = std(peakAmpOn_sg_aft_STIM,0,1)/sqrt(nRun);
m_peakAmpOn_sg_aft_POST = mean(peakAmpOn_sg_aft_POST,1);
sem_peakAmpOn_sg_aft_POST = std(peakAmpOn_sg_aft_POST,0,1)/sqrt(nRun);

m_peakAmpOn_sg_PRE = [m_peakAmpOn_sg_bef_PRE, m_peakAmpOn_sg_aft_PRE];
m_peakAmpOn_sg_STIM = [m_peakAmpOn_sg_bef_STIM, m_peakAmpOn_sg_aft_STIM];
m_peakAmpOn_sg_POST = [m_peakAmpOn_sg_bef_POST, m_peakAmpOn_sg_aft_POST];

sem_peakAmpOn_sg_PRE = [sem_peakAmpOn_sg_bef_PRE, sem_peakAmpOn_sg_aft_PRE];
sem_peakAmpOn_sg_STIM = [sem_peakAmpOn_sg_bef_STIM, sem_peakAmpOn_sg_aft_STIM];
sem_peakAmpOn_sg_POST = [sem_peakAmpOn_sg_bef_POST, sem_peakAmpOn_sg_aft_POST];

temp = T.peakAmpOff_sg_beforeOn(cscRun);
peakAmpOff_sg_bef_PRE = cell2mat(cellfun(@(x) x{1},temp,'UniformOutput',0));
peakAmpOff_sg_bef_STIM = cell2mat(cellfun(@(x) x{2},temp,'UniformOutput',0));
peakAmpOff_sg_bef_POST = cell2mat(cellfun(@(x) x{3},temp,'UniformOutput',0));

m_peakAmpOff_sg_bef_PRE = mean(peakAmpOff_sg_bef_PRE,1);
sem_peakAmpOff_sg_bef_PRE = std(peakAmpOff_sg_bef_PRE,0,1)/sqrt(nRun);
m_peakAmpOff_sg_bef_STIM = mean(peakAmpOff_sg_bef_STIM,1);
sem_peakAmpOff_sg_bef_STIM = std(peakAmpOff_sg_bef_STIM,0,1)/sqrt(nRun);
m_peakAmpOff_sg_bef_POST = mean(peakAmpOff_sg_bef_POST,1);
sem_peakAmpOff_sg_bef_POST = std(peakAmpOff_sg_bef_POST,0,1)/sqrt(nRun);

temp = T.peakAmpOff_sg_afterOn(cscRun);
peakAmpOff_sg_aft_PRE = cell2mat(cellfun(@(x) x{1},temp,'UniformOutput',0));
peakAmpOff_sg_aft_STIM = cell2mat(cellfun(@(x) x{2},temp,'UniformOutput',0));
peakAmpOff_sg_aft_POST = cell2mat(cellfun(@(x) x{3},temp,'UniformOutput',0));

m_peakAmpOff_sg_aft_PRE = mean(peakAmpOff_sg_aft_PRE,1);
sem_peakAmpOff_sg_aft_PRE = std(peakAmpOff_sg_aft_PRE,0,1)/sqrt(nRun);
m_peakAmpOff_sg_aft_STIM = mean(peakAmpOff_sg_aft_STIM,1);
sem_peakAmpOff_sg_aft_STIM = std(peakAmpOff_sg_aft_STIM,0,1)/sqrt(nRun);
m_peakAmpOff_sg_aft_POST = mean(peakAmpOff_sg_aft_POST,1);
sem_peakAmpOff_sg_aft_POST = std(peakAmpOff_sg_aft_POST,0,1)/sqrt(nRun);

m_peakAmpOff_sg_PRE = [m_peakAmpOff_sg_bef_PRE, m_peakAmpOff_sg_aft_PRE];
m_peakAmpOff_sg_STIM = [m_peakAmpOff_sg_bef_STIM, m_peakAmpOff_sg_aft_STIM];
m_peakAmpOff_sg_POST = [m_peakAmpOff_sg_bef_POST, m_peakAmpOff_sg_aft_POST];

sem_peakAmpOff_sg_PRE = [sem_peakAmpOff_sg_bef_PRE, sem_peakAmpOff_sg_aft_PRE];
sem_peakAmpOff_sg_STIM = [sem_peakAmpOff_sg_bef_STIM, sem_peakAmpOff_sg_aft_STIM];
sem_peakAmpOff_sg_POST = [sem_peakAmpOff_sg_bef_POST, sem_peakAmpOff_sg_aft_POST];

%% fast gamma
temp = T.peakAmpOn_fg_beforeOn(cscRun);
peakAmpOn_fg_bef_PRE = cell2mat(cellfun(@(x) x{1},temp,'UniformOutput',0));
peakAmpOn_fg_bef_STIM = cell2mat(cellfun(@(x) x{2},temp,'UniformOutput',0));
peakAmpOn_fg_bef_POST = cell2mat(cellfun(@(x) x{3},temp,'UniformOutput',0));

m_peakAmpOn_fg_bef_PRE = mean(peakAmpOn_fg_bef_PRE,1);
sem_peakAmpOn_fg_bef_PRE = std(peakAmpOn_fg_bef_PRE,0,1)/sqrt(nRun);
m_peakAmpOn_fg_bef_STIM = mean(peakAmpOn_fg_bef_STIM,1);
sem_peakAmpOn_fg_bef_STIM = std(peakAmpOn_fg_bef_STIM,0,1)/sqrt(nRun);
m_peakAmpOn_fg_bef_POST = mean(peakAmpOn_fg_bef_POST,1);
sem_peakAmpOn_fg_bef_POST = std(peakAmpOn_fg_bef_POST,0,1)/sqrt(nRun);

temp = T.peakAmpOn_fg_afterOn(cscRun);
peakAmpOn_fg_aft_PRE = cell2mat(cellfun(@(x) x{1},temp,'UniformOutput',0));
peakAmpOn_fg_aft_STIM = cell2mat(cellfun(@(x) x{2},temp,'UniformOutput',0));
peakAmpOn_fg_aft_POST = cell2mat(cellfun(@(x) x{3},temp,'UniformOutput',0));

m_peakAmpOn_fg_aft_PRE = mean(peakAmpOn_fg_aft_PRE,1);
sem_peakAmpOn_fg_aft_PRE = std(peakAmpOn_fg_aft_PRE,0,1)/sqrt(nRun);
m_peakAmpOn_fg_aft_STIM = mean(peakAmpOn_fg_aft_STIM,1);
sem_peakAmpOn_fg_aft_STIM = std(peakAmpOn_fg_aft_STIM,0,1)/sqrt(nRun);
m_peakAmpOn_fg_aft_POST = mean(peakAmpOn_fg_aft_POST,1);
sem_peakAmpOn_fg_aft_POST = std(peakAmpOn_fg_aft_POST,0,1)/sqrt(nRun);

m_peakAmpOn_fg_PRE = [m_peakAmpOn_fg_bef_PRE, m_peakAmpOn_fg_aft_PRE];
m_peakAmpOn_fg_STIM = [m_peakAmpOn_fg_bef_STIM, m_peakAmpOn_fg_aft_STIM];
m_peakAmpOn_fg_POST = [m_peakAmpOn_fg_bef_POST, m_peakAmpOn_fg_aft_POST];

sem_peakAmpOn_fg_PRE = [sem_peakAmpOn_fg_bef_PRE, sem_peakAmpOn_fg_aft_PRE];
sem_peakAmpOn_fg_STIM = [sem_peakAmpOn_fg_bef_STIM, sem_peakAmpOn_fg_aft_STIM];
sem_peakAmpOn_fg_POST = [sem_peakAmpOn_fg_bef_POST, sem_peakAmpOn_fg_aft_POST];

temp = T.peakAmpOff_fg_beforeOn(cscRun);
peakAmpOff_fg_bef_PRE = cell2mat(cellfun(@(x) x{1},temp,'UniformOutput',0));
peakAmpOff_fg_bef_STIM = cell2mat(cellfun(@(x) x{2},temp,'UniformOutput',0));
peakAmpOff_fg_bef_POST = cell2mat(cellfun(@(x) x{3},temp,'UniformOutput',0));

m_peakAmpOff_fg_bef_PRE = mean(peakAmpOff_fg_bef_PRE,1);
sem_peakAmpOff_fg_bef_PRE = std(peakAmpOff_fg_bef_PRE,0,1)/sqrt(nRun);
m_peakAmpOff_fg_bef_STIM = mean(peakAmpOff_fg_bef_STIM,1);
sem_peakAmpOff_fg_bef_STIM = std(peakAmpOff_fg_bef_STIM,0,1)/sqrt(nRun);
m_peakAmpOff_fg_bef_POST = mean(peakAmpOff_fg_bef_POST,1);
sem_peakAmpOff_fg_bef_POST = std(peakAmpOff_fg_bef_POST,0,1)/sqrt(nRun);

temp = T.peakAmpOff_fg_afterOn(cscRun);
peakAmpOff_fg_aft_PRE = cell2mat(cellfun(@(x) x{1},temp,'UniformOutput',0));
peakAmpOff_fg_aft_STIM = cell2mat(cellfun(@(x) x{2},temp,'UniformOutput',0));
peakAmpOff_fg_aft_POST = cell2mat(cellfun(@(x) x{3},temp,'UniformOutput',0));

m_peakAmpOff_fg_aft_PRE = mean(peakAmpOff_fg_aft_PRE,1);
sem_peakAmpOff_fg_aft_PRE = std(peakAmpOff_fg_aft_PRE,0,1)/sqrt(nRun);
m_peakAmpOff_fg_aft_STIM = mean(peakAmpOff_fg_aft_STIM,1);
sem_peakAmpOff_fg_aft_STIM = std(peakAmpOff_fg_aft_STIM,0,1)/sqrt(nRun);
m_peakAmpOff_fg_aft_POST = mean(peakAmpOff_fg_aft_POST,1);
sem_peakAmpOff_fg_aft_POST = std(peakAmpOff_fg_aft_POST,0,1)/sqrt(nRun);

m_peakAmpOff_fg_PRE = [m_peakAmpOff_fg_bef_PRE, m_peakAmpOff_fg_aft_PRE];
m_peakAmpOff_fg_STIM = [m_peakAmpOff_fg_bef_STIM, m_peakAmpOff_fg_aft_STIM];
m_peakAmpOff_fg_POST = [m_peakAmpOff_fg_bef_POST, m_peakAmpOff_fg_aft_POST];

sem_peakAmpOff_fg_PRE = [sem_peakAmpOff_fg_bef_PRE, sem_peakAmpOff_fg_aft_PRE];
sem_peakAmpOff_fg_STIM = [sem_peakAmpOff_fg_bef_STIM, sem_peakAmpOff_fg_aft_STIM];
sem_peakAmpOff_fg_POST = [sem_peakAmpOff_fg_bef_POST, sem_peakAmpOff_fg_aft_POST];

%% ripple
temp = T.peakAmpOn_ri_beforeOn(cscRun);
peakAmpOn_ri_bef_PRE = cell2mat(cellfun(@(x) x{1},temp,'UniformOutput',0));
peakAmpOn_ri_bef_STIM = cell2mat(cellfun(@(x) x{2},temp,'UniformOutput',0));
peakAmpOn_ri_bef_POST = cell2mat(cellfun(@(x) x{3},temp,'UniformOutput',0));

m_peakAmpOn_ri_bef_PRE = mean(peakAmpOn_ri_bef_PRE,1);
sem_peakAmpOn_ri_bef_PRE = std(peakAmpOn_ri_bef_PRE,0,1)/sqrt(nRun);
m_peakAmpOn_ri_bef_STIM = mean(peakAmpOn_ri_bef_STIM,1);
sem_peakAmpOn_ri_bef_STIM = std(peakAmpOn_ri_bef_STIM,0,1)/sqrt(nRun);
m_peakAmpOn_ri_bef_POST = mean(peakAmpOn_ri_bef_POST,1);
sem_peakAmpOn_ri_bef_POST = std(peakAmpOn_ri_bef_POST,0,1)/sqrt(nRun);

temp = T.peakAmpOn_ri_afterOn(cscRun);
peakAmpOn_ri_aft_PRE = cell2mat(cellfun(@(x) x{1},temp,'UniformOutput',0));
peakAmpOn_ri_aft_STIM = cell2mat(cellfun(@(x) x{2},temp,'UniformOutput',0));
peakAmpOn_ri_aft_POST = cell2mat(cellfun(@(x) x{3},temp,'UniformOutput',0));

m_peakAmpOn_ri_aft_PRE = mean(peakAmpOn_ri_aft_PRE,1);
sem_peakAmpOn_ri_aft_PRE = std(peakAmpOn_ri_aft_PRE,0,1)/sqrt(nRun);
m_peakAmpOn_ri_aft_STIM = mean(peakAmpOn_ri_aft_STIM,1);
sem_peakAmpOn_ri_aft_STIM = std(peakAmpOn_ri_aft_STIM,0,1)/sqrt(nRun);
m_peakAmpOn_ri_aft_POST = mean(peakAmpOn_ri_aft_POST,1);
sem_peakAmpOn_ri_aft_POST = std(peakAmpOn_ri_aft_POST,0,1)/sqrt(nRun);

m_peakAmpOn_ri_PRE = [m_peakAmpOn_ri_bef_PRE, m_peakAmpOn_ri_aft_PRE];
m_peakAmpOn_ri_STIM = [m_peakAmpOn_ri_bef_STIM, m_peakAmpOn_ri_aft_STIM];
m_peakAmpOn_ri_POST = [m_peakAmpOn_ri_bef_POST, m_peakAmpOn_ri_aft_POST];

sem_peakAmpOn_ri_PRE = [sem_peakAmpOn_ri_bef_PRE, sem_peakAmpOn_ri_aft_PRE];
sem_peakAmpOn_ri_STIM = [sem_peakAmpOn_ri_bef_STIM, sem_peakAmpOn_ri_aft_STIM];
sem_peakAmpOn_ri_POST = [sem_peakAmpOn_ri_bef_POST, sem_peakAmpOn_ri_aft_POST];

temp = T.peakAmpOff_ri_beforeOn(cscRun);
peakAmpOff_ri_bef_PRE = cell2mat(cellfun(@(x) x{1},temp,'UniformOutput',0));
peakAmpOff_ri_bef_STIM = cell2mat(cellfun(@(x) x{2},temp,'UniformOutput',0));
peakAmpOff_ri_bef_POST = cell2mat(cellfun(@(x) x{3},temp,'UniformOutput',0));

m_peakAmpOff_ri_bef_PRE = mean(peakAmpOff_ri_bef_PRE,1);
sem_peakAmpOff_ri_bef_PRE = std(peakAmpOff_ri_bef_PRE,0,1)/sqrt(nRun);
m_peakAmpOff_ri_bef_STIM = mean(peakAmpOff_ri_bef_STIM,1);
sem_peakAmpOff_ri_bef_STIM = std(peakAmpOff_ri_bef_STIM,0,1)/sqrt(nRun);
m_peakAmpOff_ri_bef_POST = mean(peakAmpOff_ri_bef_POST,1);
sem_peakAmpOff_ri_bef_POST = std(peakAmpOff_ri_bef_POST,0,1)/sqrt(nRun);

temp = T.peakAmpOff_ri_afterOn(cscRun);
peakAmpOff_ri_aft_PRE = cell2mat(cellfun(@(x) x{1},temp,'UniformOutput',0));
peakAmpOff_ri_aft_STIM = cell2mat(cellfun(@(x) x{2},temp,'UniformOutput',0));
peakAmpOff_ri_aft_POST = cell2mat(cellfun(@(x) x{3},temp,'UniformOutput',0));

m_peakAmpOff_ri_aft_PRE = mean(peakAmpOff_ri_aft_PRE,1);
sem_peakAmpOff_ri_aft_PRE = std(peakAmpOff_ri_aft_PRE,0,1)/sqrt(nRun);
m_peakAmpOff_ri_aft_STIM = mean(peakAmpOff_ri_aft_STIM,1);
sem_peakAmpOff_ri_aft_STIM = std(peakAmpOff_ri_aft_STIM,0,1)/sqrt(nRun);
m_peakAmpOff_ri_aft_POST = mean(peakAmpOff_ri_aft_POST,1);
sem_peakAmpOff_ri_aft_POST = std(peakAmpOff_ri_aft_POST,0,1)/sqrt(nRun);

m_peakAmpOff_ri_PRE = [m_peakAmpOff_ri_bef_PRE, m_peakAmpOff_ri_aft_PRE];
m_peakAmpOff_ri_STIM = [m_peakAmpOff_ri_bef_STIM, m_peakAmpOff_ri_aft_STIM];
m_peakAmpOff_ri_POST = [m_peakAmpOff_ri_bef_POST, m_peakAmpOff_ri_aft_POST];

sem_peakAmpOff_ri_PRE = [sem_peakAmpOff_ri_bef_PRE, sem_peakAmpOff_ri_aft_PRE];
sem_peakAmpOff_ri_STIM = [sem_peakAmpOff_ri_bef_STIM, sem_peakAmpOff_ri_aft_STIM];
sem_peakAmpOff_ri_POST = [sem_peakAmpOff_ri_bef_POST, sem_peakAmpOff_ri_aft_POST];

%% statistic test
groupOn = {'-3','-2','-1','+1','+2','+3'};
groupOff = {'+3','+2','+1','-1','-2','-3'};
group_stat_th = [zeros(nRun*2,1);ones(nRun*2,1)];
group_stat1 = [zeros(nRun*3,1);ones(nRun*3,1)];

[~,pOn_th_STIM] = kruskalwallis([reshape(peakAmpOn_th_bef_STIM(:,1:2),[nRun*2,1]);reshape(peakAmpOn_th_aft_STIM(:,1:2),[nRun*2,1])],group_stat_th,'off');
[~,pOff_th_STIM] = kruskalwallis([reshape(peakAmpOff_th_bef_STIM(:,1:2),[nRun*2,1]);reshape(peakAmpOff_th_aft_STIM(:,1:2),[nRun*2,1])],group_stat_th,'off');

[~,pOn_sg_STIM] = kruskalwallis([reshape(peakAmpOn_sg_bef_STIM(:,2:4),[nRun*3,1]);reshape(peakAmpOn_sg_aft_STIM(:,1:3),[nRun*3,1])],group_stat1,'off');
[~,pOff_sg_STIM] = kruskalwallis([reshape(peakAmpOff_sg_bef_STIM(:,2:4),[nRun*3,1]);reshape(peakAmpOff_sg_aft_STIM(:,1:3),[nRun*3,1])],group_stat1,'off');

[~,pOn_fg_STIM] = kruskalwallis([reshape(peakAmpOn_fg_bef_STIM(:,2:4),[nRun*3,1]);reshape(peakAmpOn_fg_aft_STIM(:,1:3),[nRun*3,1])],group_stat1,'off');
[~,pOff_fg_STIM] = kruskalwallis([reshape(peakAmpOff_fg_bef_STIM(:,2:4),[nRun*3,1]);reshape(peakAmpOff_fg_aft_STIM(:,1:3),[nRun*3,1])],group_stat1,'off');

[~,pOn_ri_STIM] = kruskalwallis([reshape(peakAmpOn_ri_bef_STIM(:,2:4),[nRun*3,1]);reshape(peakAmpOn_ri_aft_STIM(:,1:3),[nRun*3,1])],group_stat1,'off');
[~,pOff_ri_STIM] = kruskalwallis([reshape(peakAmpOff_ri_bef_STIM(:,2:4),[nRun*3,1]);reshape(peakAmpOff_ri_aft_STIM(:,1:3),[nRun*3,1])],group_stat1,'off');

%% Plot
load('D:\Dropbox\SNL\P2_Track\myParameters.mat');
fontM = 9; %7
paperSize = {[0 0 21.0 29.7]; % A4_portrait
             [0 0 29.7 21.0]; % A4_landscape
             [0 0 15.7 21.0]; % A4_half landscape
             [0 0 21.6 27.9]}; % Letter

lineColor = {colorLightGray; colorGray; colorBlack};

figSize = [0.1 0.1 0.85 0.85];
wideInterval = [0.07 0.13];

nCol = 2; 
nRow = 4;

barWidth = 0.8;
eLength = 0.4;
lineW = 0.4;
markerM = 5;

xpt_th = 1:4;
xpt = 1:6;

xScatter_th = [1+(rand(nRun,1)-0.5)*barWidth*0.6,2+(rand(nRun,1)-0.5)*barWidth*0.6,3+(rand(nRun,1)-0.5)*barWidth*0.6,4+(rand(nRun,1)-0.5)*barWidth*0.6];
% xScatter_th = [1+(rand(nRun,1)-0.5)*barWidth*0.6,2+(rand(nRun,1)-0.5)*barWidth*0.6,3+(rand(nRun,1)-0.5)*barWidth*0.6,4+(rand(nRun,1)-0.5)*barWidth*0.6,5+(rand(nRun,1)-0.5)*barWidth*0.6];
xScatter = [1+(rand(nRun,1)-0.5)*barWidth*0.6,2+(rand(nRun,1)-0.5)*barWidth*0.6,3+(rand(nRun,1)-0.5)*barWidth*0.6,4+(rand(nRun,1)-0.5)*barWidth*0.6,...
            5+(rand(nRun,1)-0.5)*barWidth*0.6,6+(rand(nRun,1)-0.5)*barWidth*0.6];
       
xTickLabel_thOn = {'-2','-1','+1','+2'};
xTickLabel_thOff = {'+2','+1','-1','-2'};
% xTickLabel_thOn = {'-2','-1','+1','+2','+3'};
% xTickLabel_thOff = {'+3','+2','+1','-1','-2'};
xTickLabel_On = {'-3','-2','-1','+1','+2','+3'};
xTickLabel_Off = {'+3','+2','+1','-1','-2','-3'};

fHandle = figure('PaperUnits','centimeters','paperPosition',paperSize{1});

hText = axes('Position',axpt(nCol,nRow,1,1,figSize,wideInterval));
    text(0,1.2, [taskType,' sessions'], 'FontSize', fontM, 'Interpreter', 'none', 'fontWeight', 'bold');
set(hText,'visible','off')

hTheta(1) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1,1,figSize,midInterval),wideInterval));
    bar(xpt_th,m_peakAmpOn_th_STIM(1:4),barWidth,'faceColor',colorGray);
    hold on;
    errorbarJun(xpt_th,m_peakAmpOn_th_STIM(1:4),sem_peakAmpOn_th_STIM(1:4),lineW,eLength,colorBlack);
    hold on;
    plot(xScatter_th,[peakAmpOn_th_bef_STIM,peakAmpOn_th_aft_STIM(:,1:2)],'.','markerSize',markerM,'markerFaceColor',colorWhite,'markerEdgeColor',colorBlack);
    text(0.2, 4.2, 'Theta (4-12 Hz)','fontSize',fontM);
    text(3.5,3.5,['p = ',num2str(pOn_th_STIM{2,6},3)],'fontSize',fontM);
    ylabel('Norm. amplitude','fontSize',fontM);
    xlabel('n-th peak (-:Light Off / +:Light On)','fontSize',fontM);
    title('Aligned on laser onset sensor','fontSize',fontM);
    
hTheta(2) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,2,1,figSize,midInterval),wideInterval));
    bar(xpt_th,m_peakAmpOff_th_STIM(2:5),barWidth,'faceColor',colorGray);
    hold on;
    errorbarJun(xpt_th,m_peakAmpOff_th_STIM(2:5),sem_peakAmpOff_th_STIM(2:5),lineW,eLength,colorBlack);
    hold on;
    plot(xScatter_th,[peakAmpOff_th_bef_STIM(:,2:3),peakAmpOff_th_aft_STIM],'.','markerSize',markerM,'markerFaceColor',colorWhite,'markerEdgeColor',colorBlack);
    text(0.2, 4.2, 'Theta (4-12 Hz)','fontSize',fontM);
    text(3.5,3.5,['p = ',num2str(pOff_th_STIM{2,6},3)],'fontSize',fontM);
    ylabel('Norm. amplitude','fontSize',fontM);
    xlabel('n-th peak (+:Light On / -:Light Off)','fontSize',fontM);
    title('Aligned on laser offset sensor','fontSize',fontM);
    
    set(hTheta,'Box','off','TickDir','out','XLim',[0,5],'YLim',[-0.5,4.5],'XTick',1:4,'YTick',[0:4]);
    set(hTheta(1),'XTickLabel',xTickLabel_thOn,'fontSize',fontM);
    set(hTheta(2),'XTickLabel',xTickLabel_thOff,'fontSize',fontM);

%%
hSGamma(1) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1,2,figSize,midInterval),wideInterval));
    bar(xpt,m_peakAmpOn_sg_STIM(2:7),barWidth,'faceColor',colorGray);
    hold on;
    errorbarJun(xpt,m_peakAmpOn_sg_STIM(2:7),sem_peakAmpOn_sg_STIM(2:7),lineW,eLength,colorBlack);
    hold on;
    plot(xScatter,[peakAmpOn_sg_bef_STIM(:,2:4),peakAmpOn_sg_aft_STIM(:,1:3)],'.','markerSize',markerM,'markerFaceColor',colorWhite,'markerEdgeColor',colorBlack);
    text(0.2, 4.2, 'Slow gamma (20-50 Hz)','fontSize',fontM);
    text(4.5,3.5,['p = ',num2str(pOn_sg_STIM{2,6},3)],'fontSize',fontM);
    ylabel('Norm. amplitude','fontSize',fontM);
    xlabel('n-th peak (-:Light Off / +:Light On)','fontSize',fontM);
    
hSGamma(2) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,2,2,figSize,midInterval),wideInterval));
    bar(xpt,m_peakAmpOff_sg_STIM(2:7),barWidth,'faceColor',colorGray);
    hold on;
    errorbarJun(xpt,m_peakAmpOff_sg_STIM(2:7),sem_peakAmpOff_sg_STIM(2:7),lineW,eLength,colorBlack);
    hold on;
    plot(xScatter,[peakAmpOff_sg_bef_STIM(:,2:4),peakAmpOff_sg_aft_STIM(:,1:3)],'.','markerSize',markerM,'markerFaceColor',colorWhite,'markerEdgeColor',colorBlack);
    text(0.2, 4.2, 'Slow gamma (20-50 Hz)','fontSize',fontM);
    text(4.5,3.5,['p = ',num2str(pOff_sg_STIM{2,6},3)],'fontSize',fontM);
    ylabel('Norm. amplitude','fontSize',fontM);
    xlabel('n-th peak (+:Light On / -:Light Off)','fontSize',fontM);
    
    set(hSGamma,'Box','off','TickDir','out','XLim',[0,7],'YLim',[-0.5,4.5],'XTick',1:6,'YTick',[0:4]);
    set(hSGamma(1),'XTickLabel',xTickLabel_On,'fontSize',fontM);
    set(hSGamma(2),'XTickLabel',xTickLabel_Off,'fontSize',fontM);

%%
hFGamma(1) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1,3,figSize,midInterval),wideInterval));
    bar(xpt,m_peakAmpOn_fg_STIM(2:7),barWidth,'faceColor',colorGray);
    hold on;
    errorbarJun(xpt,m_peakAmpOn_fg_STIM(2:7),sem_peakAmpOn_fg_STIM(2:7),lineW,eLength,colorBlack);
    hold on;
    plot(xScatter,[peakAmpOn_fg_bef_STIM(:,2:4),peakAmpOn_fg_aft_STIM(:,1:3)],'.','markerSize',markerM,'markerFaceColor',colorWhite,'markerEdgeColor',colorBlack);
    text(0.2, 4.2, 'Fast gamma (65-140 Hz)','fontSize',fontM);
    text(4.5,3.5,['p = ',num2str(pOn_fg_STIM{2,6},3)],'fontSize',fontM);
    ylabel('Norm. amplitude','fontSize',fontM);
    xlabel('n-th peak (-:Light Off / +:Light On)','fontSize',fontM);
    
hFGamma(2) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,2,3,figSize,midInterval),wideInterval));
    bar(xpt,m_peakAmpOff_fg_STIM(2:7),barWidth,'faceColor',colorGray);
    hold on;
    errorbarJun(xpt,m_peakAmpOff_fg_STIM(2:7),sem_peakAmpOff_fg_STIM(2:7),lineW,eLength,colorBlack);
    hold on;
    plot(xScatter,[peakAmpOff_fg_bef_STIM(:,2:4),peakAmpOff_fg_aft_STIM(:,1:3)],'.','markerSize',markerM,'markerFaceColor',colorWhite,'markerEdgeColor',colorBlack);
    text(0.2, 4.2, 'Fast gamma (65-140 Hz)','fontSize',fontM);
    text(4.5,3.5,['p = ',num2str(pOff_fg_STIM{2,6},3)],'fontSize',fontM);
    ylabel('Norm. amplitude','fontSize',fontM);
    xlabel('n-th peak (+:Light On / -:Light Off)','fontSize',fontM);
    
    set(hFGamma,'Box','off','TickDir','out','XLim',[0,7],'YLim',[-0.5,4.5],'XTick',1:6,'YTick',[0:4]);
    set(hFGamma(1),'XTickLabel',xTickLabel_On,'fontSize',fontM);
    set(hFGamma(2),'XTickLabel',xTickLabel_Off,'fontSize',fontM);
    
%%
hRipple(1) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1,4,figSize,midInterval),wideInterval));
    bar(xpt,m_peakAmpOn_ri_STIM(2:7),barWidth,'faceColor',colorGray);
    hold on;
    errorbarJun(xpt,m_peakAmpOn_ri_STIM(2:7),sem_peakAmpOn_ri_STIM(2:7),lineW,eLength,colorBlack);
    hold on;
    plot(xScatter,[peakAmpOn_ri_bef_STIM(:,2:4),peakAmpOn_ri_aft_STIM(:,1:3)],'.','markerSize',markerM,'markerFaceColor',colorWhite,'markerEdgeColor',colorBlack);
    text(0.2, 4.2, 'Ripple (150-250 Hz)','fontSize',fontM);
    text(4.5,3.5,['p = ',num2str(pOn_ri_STIM{2,6},3)],'fontSize',fontM);
    ylabel('Norm. amplitude','fontSize',fontM);
    xlabel('n-th peak (-:Light Off / +:Light On)','fontSize',fontM);
    
hRipple(2) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,2,4,figSize,midInterval),wideInterval));
    bar(xpt,m_peakAmpOff_ri_STIM(2:7),barWidth,'faceColor',colorGray);
    hold on;
    errorbarJun(xpt,m_peakAmpOff_ri_STIM(2:7),sem_peakAmpOff_ri_STIM(2:7),lineW,eLength,colorBlack);
    hold on;
    plot(xScatter,[peakAmpOff_ri_bef_STIM(:,2:4),peakAmpOff_ri_aft_STIM(:,1:3)],'.','markerSize',markerM,'markerFaceColor',colorWhite,'markerEdgeColor',colorBlack);
    text(0.2, 4.2, 'Ripple (150-250 Hz)','fontSize',fontM);
    text(4.5,3.5,['p = ',num2str(pOff_ri_STIM{2,6},3)],'fontSize',fontM);
    ylabel('Norm. amplitude','fontSize',fontM);
    xlabel('n-th peak (+:Light On / -:Light Off)','fontSize',fontM);
    
    set(hRipple,'Box','off','TickDir','out','XLim',[0,7],'YLim',[-0.5,4.5],'XTick',1:6,'YTick',[0:4]);
    set(hRipple(1),'XTickLabel',xTickLabel_On,'fontSize',fontM);
    set(hRipple(2),'XTickLabel',xTickLabel_Off,'fontSize',fontM);

if regexp(taskType,'Run')
    print('-painters','-r300','-dtiff',['f_supple_cscPeak_',datestr(now,formatOut),'_STIM_Run.tif']);
    print('-painters','-r300','-depsc',['f_supple_cscPeak_',datestr(now,formatOut),'_STIM_Run.ai']);
else
    print('-painters','-r300','-dtiff',['f_supple_cscPeak_',datestr(now,formatOut),'_STIM_Rw.tif']);
    print('-painters','-r300','-depsc',['f_supple_cscPeak_',datestr(now,formatOut),'_STIM_Rw.ai']);
end
close;