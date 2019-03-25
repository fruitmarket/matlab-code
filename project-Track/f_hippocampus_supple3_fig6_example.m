clc; clearvars; close all;
rtDir = 'E:\Dropbox\SNL\P2_Track';
cd(rtDir);
load('E:\Dropbox\SNL\P2_Track\myParameters.mat');

Txls = readtable('neuronList_ori_171227.xlsx');
Txls.latencyIndex = categorical(Txls.latencyIndex);
load('neuronList_ori_171227.mat');
% load('neuronList_ori_180517.mat');

formatOut = 'yymmdd';
fontS = 6;
fontStyle = 'Arial';

%% Population separation
run_act = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idx_evoSpikeDir == 1;
run_ina = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idx_evoSpikeDir == -1;

rw_act = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idx_evoSpikeDir == 1;
rw_ina = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idx_evoSpikeDir == -1;

path_run_act = T.path(run_act);
path_run_ina = T.path(run_ina);
path_rw_act = T.path(rw_act);
path_rw_ina = T.path(rw_ina);

saveDir = 'E:\Dropbox\SNL\P2_Track\format_Hippocampus\rev_suppleNew\examples_track\run_act';
path = path_run_act;
cellID = T.cellID(run_act);

% saveDir = 'E:\Dropbox\SNL\P2_Track\format_Hippocampus\rev_suppleNew\examples_track\run_ina';
% path = path_run_ina;
% cellID = T.cellID(run_ina);

% saveDir = 'E:\Dropbox\SNL\P2_Track\format_Hippocampus\rev_suppleNew\examples_track\rw_act';
% path = path_rw_act;
% cellID = T.cellID(rw_act);

% saveDir = 'E:\Dropbox\SNL\P2_Track\format_Hippocampus\rev_suppleNew\examples_track\rw_ina';
% path = path_rw_ina;
% cellID = T.cellID(rw_ina);

%% save dir _ver2
% run_di = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idx_evoSpikeDir == 1 & Txls.latencyIndex == 'direct';
% run_id = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idx_evoSpikeDir == 1 & Txls.latencyIndex == 'indirect';
% run_do = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idx_evoSpikeDir == 1 & Txls.latencyIndex == 'double';
% run_ina = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idx_evoSpikeDir == -1;
% 
% rw_di = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idx_evoSpikeDir == 1 & Txls.latencyIndex == 'direct';
% rw_id = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idx_evoSpikeDir == 1 & Txls.latencyIndex == 'indirect';
% rw_do = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idx_evoSpikeDir == 1 & Txls.latencyIndex == 'double';
% rw_ina = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idx_evoSpikeDir == -1;

% path_run_actDirect = T.path(run_di);
% path_run_actIndirect = T.path(run_id);
% path_run_actDouble = T.path(run_do);
% path_run_inaPN = T.path(run_ina);
% 
% path_rw_actDirect = T.path(rw_di);
% path_rw_actIndirect = T.path(rw_id);
% path_rw_actDouble = T.path(rw_do);
% path_rw_inaPN = T.path(rw_ina);

% saveDir = 'E:\Dropbox\SNL\P2_Track\format_Hippocampus\rev_suppleNew\examples_track\run_di';
% path = path_run_actDirect;
% cellID = T.cellID(run_di);

% saveDir = 'E:\Dropbox\SNL\P2_Track\format_Hippocampus\rev_suppleNew\examples_track\run_in';
% path = path_run_actDirect;
% cellID = T.cellID(run_id);
% 
% saveDir = 'E:\Dropbox\SNL\P2_Track\format_Hippocampus\rev_suppleNew\examples_track\run_do';
% path = path_run_actDirect;
% cellID = T.cellID(run_do);
% 
% saveDir = 'E:\Dropbox\SNL\P2_Track\format_Hippocampus\rev_suppleNew\examples_track\run_ina';
% path = path_run_actDirect;
% cellID = T.cellID(run_ina);

% saveDir = 'E:\Dropbox\SNL\P2_Track\format_Hippocampus\rev_suppleNew\examples_track\rw_di';
% path = path_rw_actDirect;
% cellID = T.cellID(rw_di);

% saveDir = 'E:\Dropbox\SNL\P2_Track\format_Hippocampus\rev_suppleNew\examples_track\rw_in';
% path = path_rw_actDirect;
% cellID = T.cellID(rw_id);

% saveDir = 'E:\Dropbox\SNL\P2_Track\format_Hippocampus\rev_suppleNew\examples_track\rw_do';
% path = path_rw_actDirect;
% cellID = T.cellID(rw_do);

% saveDir = 'E:\Dropbox\SNL\P2_Track\format_Hippocampus\rev_suppleNew\examples_track\rw_ina';
% path = path_rw_actDirect;
% cellID = T.cellID(rw_ina);

%% plot
nCell = length(path);
figSize = [0.25 0.30 0.80 0.60];
figSpace = [0.04 0.08];
nTrial = 300;
fontM = 7;

for iCell = 1:nCell
    [cellDir, cellName, ~] = fileparts(path{iCell});
    cellDirSplit = regexp(cellDir,'\','split');
    cellFigName = strcat(cellDirSplit(end-1),'_',cellDirSplit(end),'_',cellName);
    
    cd(cellDir);
    load(path{iCell});
    load Events.mat;
    
    cd(rtDir);
    
    fHandle = figure('PaperUnits','centimeter','PaperPosition',[0 0 4 1.5]);
    
    hRaster = axes('Position',axpt(4,1,1:3,1,figSize,figSpace));
        patch([0 10 10 0],[0,0,nTrial,nTrial],colorLLightBlue,'LineStyle','none');
        hold on;
        plot(xptTrackLight{1},yptTrackLight{1},'LineStyle','none','Marker','.','MarkerSize',markerS,'color','k');
        ylabel('Trials','fontSize',fontM,'fontName',fontStyle);
    set(hRaster,'Box','off','TickDir','out','fontSize',fontM,'fontName',fontStyle,'XLim',[-10,100],'XTick',[0,10,100],'XTickLabel',{'0','10','100 (ms)'},'YLim',[0,nTrial],'YTick',[0,nTrial]);
    
    cd(saveDir);
    print('-painters','-r300','-dtiff',[datestr(now,formatOut),'_cellID_',num2str(cellID(iCell)),'.tif']);
    print('-painters','-r300','-depsc',[datestr(now,formatOut),'_cellID_',num2str(cellID(iCell)),'.ai']);
    close;
end