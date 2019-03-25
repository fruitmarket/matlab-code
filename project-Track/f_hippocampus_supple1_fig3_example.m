clc; clearvars; close all;
rtDir = 'D:\Dropbox\SNL\P2_Track';
cd(rtDir);
load('D:\Dropbox\SNL\P2_Track\myParameters.mat');
load('neuronList_freq_171127.mat');
Txls = readtable('neuronList_freq_171127.xlsx');
Txls.latencyIndex = categorical(Txls.latencyIndex);
formatOut = 'yymmdd';
fontS = 6;
fontStyle = 'Arial';

%% Population separation
cSpkpvr = 1.2;
alpha = 0.01;

condiPN = T.spkpvr>cSpkpvr;
condiIN = ~condiPN;

lightActPN = condiPN & (T.idx_light8hz == 1);
lightActDirectPN = condiPN & (T.idx_light8hz == 1) & T.idx_latency == 'direct';
lightActIndirectPN = condiPN & (T.idx_light8hz == 1) & T.idx_latency == 'indirect';
lightActDoublePN = condiPN & (T.idx_light8hz == 1) & T.idx_latency == 'double';
lightInaPN = condiPN & (T.idx_light8hz == -1);
lightNoPN = condiPN & (T.idx_light8hz == 0);

path_actDirect = T.path(lightActDirectPN);
path_actIndirect = T.path(lightActIndirectPN);
path_actDouble = T.path(lightActDoublePN);
path_inaPN = T.path(lightInaPN);

% saveDir = 'E:\Dropbox\SNL\P2_Track\format_Hippocampus\rev_suppleNew\direct';
% path = path_actDirect;
% cellID = T.cellID(lightActDirectPN);

% saveDir = 'E:\Dropbox\SNL\P2_Track\format_Hippocampus\rev_suppleNew\indirect';
% path = path_actIndirect;
% cellID = T.cellID(lightActIndirectPN);

% saveDir = 'E:\Dropbox\SNL\P2_Track\format_Hippocampus\rev_suppleNew\double';
% path = path_actDouble;
% cellID = T.cellID(lightActDoublePN);

% saveDir = 'E:\Dropbox\SNL\P2_Track\format_Hippocampus\rev_suppleNew\inactivated';
% path = path_inaPN;
% cellID = T.cellID(lightInaPN);

nCell = length(path);
figSize = [0.2 0.15 0.95 0.80];
figSpace = [0.04 0.08];
nTrial = 300;

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
        patch([0 10 10 0],[0,0,nTrial,nTrial],colorLLightBlue,'LineStyle','none');
        hold on;
        plot(xpt8hz_ori{1},ypt8hz_ori{1},'LineStyle','none','Marker','.','MarkerSize',markerS,'color','k');
        ylabel('Trials','fontSize',fontS,'fontName',fontStyle);
    
    hPETH = axes('Position',axpt(3,2,1:2,2,figSize,figSpace));
        yLim = ceil(max(peth8hz_ori*1.1+0.01));
        patch([0 10 10 0],[0,0,nTrial,nTrial],colorLLightBlue,'LineStyle','none');
        hold on;
        hBar = bar(pethtime8hz_ori,peth8hz_ori,'histc');
        ylabel('Rate (Hz)','fontSize',fontS,'fontName',fontStyle);
        xlabel('Time (ms)','fontSize',fontS,'fontName',fontStyle);
        
%     hWvform = axes('Position',axpt(3,2,3,1:2,figSize,figSpace));
%         plot(m_evoked_wv{wv_maintt},'LineStyle','-','color',colorLightBlue);
%         hold on;
%         plot(m_spont_wv{wv_maintt},'LineStyle','-','color','k');
    
    set(hRaster,'Box','off','TickDir','out','fontSize',fontS,'fontName',fontStyle,'XLim',[-10,100],'XTick',[],'YLim',[0,nTrial],'YTick',[0,nTrial]);
    set(hBar,'faceColor','k','EdgeAlpha',0);
    set(hPETH,'Box','off','TickDir','out','fontSize',fontS,'fontName',fontStyle,'XLim',[-10,100],'XTick',[0, 10, 100],'YLim',[0, yLim],'YTick',[0,yLim]);
%     set(hWvform,'visible','off');
    
    align_ylabel([hRaster, hPETH]);
    cd(saveDir);
    print('-painters','-r300','-dtiff',[datestr(now,formatOut),'_cellID_',num2str(cellID(iCell)),'.tif']);
    print('-painters','-r300','-depsc',[datestr(now,formatOut),'_cellID_',num2str(cellID(iCell)),'.ai']);
    close;
end