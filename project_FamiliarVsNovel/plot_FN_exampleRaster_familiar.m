clc; clearvars; close all;

rtDir = 'E:\Dropbox\SNL\P4_FamiliarNovel';
load('E:\Dropbox\SNL\P2_Track\myParameters.mat');
formatOut = 'yymmdd';
load('E:\Dropbox\SNL\P4_FamiliarNovel\neuronList_familiar_190113.mat');
PN = T.neuronType == 'PN';
cd(rtDir);

fontS = 6;
markerS = 1;
fontStyle = 'Arial';

%% Population separation

% neuron_dir = PN & T.idxmFrIn == 1 & T.latencyTrack1st<10 & isnan(T.latencyTrack2nd);
% neuron_ind = PN & T.idxmFrIn == 1 & T.latencyTrack1st>=10 & isnan(T.latencyTrack2nd);
% neuron_doub = PN & T.idxmFrIn == 1 & ~isnan(T.latencyTrack2nd);
% neuron_inh = PN & T.idxmFrIn == -1;

neuron_dir = PN & T.idxmSpkIn == 1 & T.latencyTrack1st<10 & isnan(T.latencyTrack2nd);
neuron_ind = PN & T.idxmSpkIn == 1 & T.latencyTrack1st>=10 & isnan(T.latencyTrack2nd);
neuron_doub = PN & T.idxmSpkIn == 1 & ~isnan(T.latencyTrack2nd);
neuron_inh = PN & T.idxmSpkIn == -1;

n_dir = sum(double(neuron_dir));
n_ind = sum(double(neuron_ind));
n_doub = sum(double(neuron_doub));
n_inh = sum(double(neuron_inh));

path_dir = T.path(neuron_dir);
path_ind = T.path(neuron_ind);
path_doub = T.path(neuron_doub);
path_inh = T.path(neuron_inh);

saveDir = 'E:\Dropbox\SNL\P4_FamiliarNovel\example_familiar\raster_dir_190113';
path = path_dir;
cellID = T.cellID(neuron_dir);

% saveDir = 'E:\Dropbox\SNL\P4_FamiliarNovel\example_familiar\raster_ind_190113';
% path = path_ind;
% cellID = T.cellID(neuron_ind);

% saveDir = 'E:\Dropbox\SNL\P4_FamiliarNovel\example_familiar\raster_doub_190113';
% path = path_doub;
% cellID = T.cellID(neuron_doub);

% saveDir = 'E:\Dropbox\SNL\P4_FamiliarNovel\example_familiar\raster_inh_190113';
% path = path_inh;
% cellID = T.cellID(neuron_inh);

nCell = length(path);
figSize = [0.2 0.15 0.95 0.80];
figSpace = [0.04 0.08];
lineSpikeM = 0.8;

for iCell = 1:nCell
    [cellDir, cellName, ~] = fileparts(path{iCell});
    cellDirSplit = regexp(cellDir,'\','split');
    cellFigName = strcat(cellDirSplit(end-1),'_',cellDirSplit(end),'_',cellName);
    
    cd(cellDir);
    load(path{iCell});
    load Events.mat;
    
    cd(rtDir);
    fHandle = figure('PaperUnits','centimeter','PaperPosition',[0 0 4 3]);
    
    hRaster = axes('Position',axpt(3,2,1:2,1,figSize,figSpace));
    for iLight = 1:nTrain_Track
        patch([20*(iLight-1) 20*(iLight-1)+10 20*(iLight-1)+10 20*(iLight-1)],[0,0,nBurst_Track,nBurst_Track],colorLLightBlue,'LineStyle','none');
        hold on;
    end
        plot(xpt1stBStm{1},ypt1stBStm{1},'lineStyle','none','marker','o','markerSize',markerS,'markerFaceColor',colorBlack,'markerEdgeColor','none');
        ylabel('Trials','fontSize',fontS,'fontName',fontStyle);
    
    hPETH = axes('Position',axpt(3,2,1:2,2,figSize,figSpace));
        yLim = ceil(max(peth1stBStm*1.1+0.01));
    for iLight = 1:nTrain_Track
        patch([20*(iLight-1) 20*(iLight-1)+10 20*(iLight-1)+10 20*(iLight-1)],[0,0,yLim,yLim],colorLLightBlue,'LineStyle','none');
        hold on;
    end
        hBar = bar(pethtime1stBStm,peth1stBStm,'histc');
        ylabel('Rate (Hz)','fontSize',fontS,'fontName',fontStyle);
        xlabel('Time (ms)','fontSize',fontS,'fontName',fontStyle);
        text(100,yLim*0.9,['cellID: ',num2str(cellID(iCell))],'fontSize',fontS-2);
        text(100,yLim*0.7,cellDirSplit{3}(7:12),'fontSize',fontS-2);
        
    set(hRaster,'Box','off','TickDir','out','fontSize',fontS,'fontName',fontStyle,'XLim',[-10,100],'XTick',[],'YLim',[0,nBurst_Track],'YTick',[0,nBurst_Track]);
    set(hBar,'faceColor','k','EdgeAlpha',0);
    set(hPETH,'Box','off','TickDir','out','fontSize',fontS,'fontName',fontStyle,'XLim',[-10,100],'XTick',[0, 10, 100],'YLim',[0, yLim],'YTick',[0,yLim]);
    
    align_ylabel([hRaster, hPETH],1,-0.1);
    cd(saveDir);
    print('-painters','-r300','-dtiff',['cellID_',num2str(cellID(iCell)),'.tif']);
    print('-painters','-r300','-depsc',['cellID_',num2str(cellID(iCell)),'.ai']);
    close;
end