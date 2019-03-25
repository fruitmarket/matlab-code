% supple1. Light responses of all activated CA3 neurons from novel environments.
clearvars;

load('E:\Dropbox\Lab_mwjung\P2_Track\myParameters.mat');
formatOut = 'yymmdd';
load('E:\Dropbox\Lab_mwjung\P4_FamiliarNovel\neuronList_familiar_190301.mat');
PN = T.neuronType == 'PN';
tt_ca3bc = ((T.mouseID == 'rbp005' & (T.tetrode == 'TT1' | T.tetrode == 'TT5')) | (T.mouseID == 'rbp006' & T.tetrode == 'TT2') | (T.mouseID == 'rbp010' & T.tetrode == 'TT6')); % | (T.mouseID == 'rbp015' & T.tetrode == 'TT7')
PN_ca3bc = PN & tt_ca3bc;
PN_ca3a = PN & ~tt_ca3bc;

saveDir = 'E:\Dropbox\Lab_mwjung\P4_FamiliarNovel\example_supple2';
%%%% spike number %%%%
ca3_act = PN & T.idxmSpkIn == 1;
ca3_dir = PN & T.idxmSpkIn == 1 & T.latencyTrack1st<10 & isnan(T.latencyTrack2nd);
ca3_ind = PN & T.idxmSpkIn == 1 & T.latencyTrack1st>=10 & isnan(T.latencyTrack2nd);

n_PN_ca3a = sum(double(PN_ca3a));
n_ca3_act = sum(double(ca3_act));

xpt = T.pethtime1stBStm(ca3_dir);
xpt = xpt{1};

peth_act = T.peth1stBStm(ca3_act);
m_ca3a_act = mean(cell2mat(peth_act),1);
sem_ca3a_act = std(cell2mat(peth_act),0,1)/sqrt(n_ca3_act);

paperSize = [0 0 3.5 3.5];
figSize = [0.25 0.25 0.98 0.70];
figSpace = [0.04 0.09];

path = T.path(ca3_act);
nCell = length(path);
fontS = 7;

for iCell = 1:nCell
    [cellDir, cellName, ~] = fileparts(path{iCell});
    cellDirSplit = regexp(cellDir,'\','split');
    cellFigName = strcat(cellDirSplit(end-1),'_',cellDirSplit(end),'_',cellName);
    
    cd(cellDir);
    load(path{iCell});
    load Events.mat;
    
    cd(cellDir);
    nLight = nBurst_Track;
    
    fHandle = figure('PaperUnits','centimeter','PaperPosition',paperSize);
    
    hRaster = axes('Position',axpt(3,2,1:2,1,figSize,figSpace));
        for iPatch = 1:4
            lightPatch(iPatch) = patch([20*(iPatch-1) 20*(iPatch-1)+10 20*(iPatch-1)+10 20*(iPatch-1)],[0 0 nLight, nLight], colorLLightBlue, 'lineStyle','none');
            hold on;
        end
        plot(xpt1stBStm{1},ypt1stBStm{1},'LineStyle','none','Marker','.','MarkerSize',markerS,'color',colorBlack);
        ylabel('Trials','fontSize',fontS);
        
    hPETH = axes('Position',axpt(3,2,1:2,2,figSize,figSpace));
        yLim = ceil(max(peth1stBStm*1.1+0.01));
        for iPatch = 1:4
            lightPatch(iPatch) = patch([20*(iPatch-1) 20*(iPatch-1)+10 20*(iPatch-1)+10 20*(iPatch-1)],[0 0 nLight, nLight], colorLLightBlue, 'lineStyle','none');
            hold on;
        end
        hBar = bar(pethtime1stBStm,peth1stBStm,'histc');
        ylabel('Rate (Hz)','fontSize',fontS);
        xlabel('Time (ms)','fontSize',fontS);
        
    set(hRaster,'Box','off','TickDir','out','fontSize',fontS,'XLim',[-20 100],'XTick',[],'YLim',[0 nLight],'YTick',[0 nLight]);
    set(hBar,'faceColor',colorBlack);
    set(hPETH,'Box','off','TickDir','out','fontSize',fontS,'XLim',[-20 100],'XTick',[-20 0 20 40 60 80 100],'YLim',[0 yLim],'YTick',[0 yLim]);
    
    align_ylabel([hRaster, hPETH],2,0);
    cd(saveDir);
    
%     print('-painters','-r300','-dtiff',[datestr(now,formatOut),'_cellID_',num2str(T.cellID(iCell)),'.tif']);
    print('-painters','-r300','-depsc',[datestr(now,formatOut),'_cellID_',num2str(T.cellID(iCell)),'.ai']);
    close all;
end