% plot_FN_lightAct
clearvars;

load('E:\Dropbox\Lab_mwjung\P2_Track\myParameters.mat');
formatOut = 'yymmdd';
load('E:\Dropbox\Lab_mwjung\P4_FamiliarNovel\neuronList_novel_190301.mat');
PN = T.neuronType == 'PN';
tt_ca3bc = ((T.mouseID == 'rbp005' & (T.tetrode == 'TT1' | T.tetrode == 'TT5')) | (T.mouseID == 'rbp006' & T.tetrode == 'TT2') | (T.mouseID == 'rbp010' & T.tetrode == 'TT6'));
PN_ca3bc = PN & tt_ca3bc;
PN_ca3a = PN & ~tt_ca3bc;

%%%% spike number %%%%
ca3a_act = PN_ca3a & T.idxmSpkIn == 1;
ca3a_inh = PN_ca3a & T.idxmSpkIn == -1;
ca3a_non = PN_ca3a & T.idxmSpkIn == 0;

n_PN_ca3a = sum(double(PN_ca3a));
n_ca3a_act = sum(double(ca3a_act));
n_ca3a_inh = sum(double(ca3a_inh));
n_ca3a_non = sum(double(ca3a_non));

xpt = T.pethtime1stBStm(ca3a_act);
xpt = xpt{1};

peth_act = T.peth1stBStm(ca3a_act);
m_ca3a_act = mean(cell2mat(peth_act),1);
sem_ca3a_act = std(cell2mat(peth_act),0,1)/sqrt(n_ca3a_act);

peth_inh = T.peth1stBStm(ca3a_inh);
m_ca3a_inh = mean(cell2mat(peth_inh),1);
sem_ca3a_inh = std(cell2mat(peth_inh),0,1)/sqrt(n_ca3a_inh);

peth_non = T.peth1stBStm(ca3a_non);
m_ca3a_non = mean(cell2mat(peth_non),1);
sem_ca3a_non = std(cell2mat(peth_non),0,1)/sqrt(n_ca3a_non);

ca3bc_act = PN_ca3bc & T.idxmSpkIn == 1;
ca3bc_non = PN_ca3bc & T.idxmSpkIn == 0;

n_PN_ca3bc = sum(double(PN_ca3bc));
n_ca3bc_act = sum(double(ca3bc_act));
n_ca3bc_non = sum(double(ca3bc_non));

peth_act = T.peth1stBStm(ca3bc_act);
m_ca3bc_act = mean(cell2mat(peth_act),1);
sem_ca3bc_act = std(cell2mat(peth_act),0,1)/sqrt(n_ca3bc_act);

peth_non = T.peth1stBStm(ca3bc_non);
m_ca3bc_non = mean(cell2mat(peth_non),1);
sem_ca3bc_non = std(cell2mat(peth_non),0,1)/sqrt(n_ca3bc_non);

%% plot_Track
nCol = 2;
nRow = 6;
eBarWidth = 0.5;
spaceFig = [0.12 0.2 0.80 0.75];
wideInterval = [0.25 0.11];

fHandle = figure('PaperUnits','centimeters','PaperPosition',[0 0 12 15]);
yLim = [40, 5, 5];

% activated (all)
hPlot(1) = axes('Position',axpt(nCol,nRow,1,1,spaceFig,wideInterval));
    for iLight = 1:4
        lightPatch(iLight) = patch([20*(iLight-1) 20*(iLight-1)+10 20*(iLight-1)+10 20*(iLight-1)],[0 0 yLim(1) yLim(1)],colorLLightBlue,'LineStyle','none');
        hold on;
    end
    hBar(1) = bar(xpt,m_ca3a_act,'histc');
    errorbarJun(xpt+1,m_ca3a_act,sem_ca3a_act,1,eBarWidth,colorDarkGray);
    text(100,yLim(1)*0.8,['n = ',num2str(n_ca3a_act)],'fontSize',fontM);
    xlabel('Time (ms)','fontSize',fontM);
    ylabel('Rate (Hz)','fontSize',fontM);
    
% inhibited
hPlot(2) = axes('Position',axpt(nCol,nRow,1,2,spaceFig,wideInterval));
    for iLight = 1:4
        lightPatch(iLight) = patch([20*(iLight-1) 20*(iLight-1)+10 20*(iLight-1)+10 20*(iLight-1)],[0 0 yLim(2) yLim(2)],colorLLightBlue,'LineStyle','none');
        hold on;
    end
    hBar(2) = bar(xpt,m_ca3a_inh,'histc');
    errorbarJun(xpt+1,m_ca3a_inh,sem_ca3a_inh,1,eBarWidth,colorDarkGray);
    text(100,yLim(2)*0.8,['n = ',num2str(n_ca3a_inh)],'fontSize',fontM);
    xlabel('Time (ms)','fontSize',fontM);
    ylabel('Rate (Hz)','fontSize',fontM);

% in sensitive
hPlot(3) = axes('Position',axpt(nCol,nRow,1,3,spaceFig,wideInterval));
    for iLight = 1:4
        lightPatch(iLight) = patch([20*(iLight-1) 20*(iLight-1)+10 20*(iLight-1)+10 20*(iLight-1)],[0 0 yLim(3) yLim(3)],colorLLightBlue,'LineStyle','none');
        hold on;
    end
    hBar(3) = bar(xpt,m_ca3a_non,'histc');
    errorbarJun(xpt+1,m_ca3a_non,sem_ca3a_non,1,eBarWidth,colorDarkGray);
    text(100,yLim(3)*0.8,['n = ',num2str(n_ca3a_non)],'fontSize',fontM);
    xlabel('Time (ms)','fontSize',fontM);
    ylabel('Rate (Hz)','fontSize',fontM);

set(hPlot(1),'YLim',[0 yLim(1)],'YTick',[0:20:yLim(1)]);
set(hPlot(2),'YLim',[0 yLim(2)],'YTick',[0:5:yLim(2)]);
set(hPlot(3),'YLim',[0 yLim(3)],'YTick',[0:5:yLim(3)]);

%%
yLim_bc = [100, 5];

% activated (all)
hPlot(4) = axes('Position',axpt(nCol,nRow,2,1,spaceFig,wideInterval));
    for iLight = 1:4
        lightPatch(iLight) = patch([20*(iLight-1) 20*(iLight-1)+10 20*(iLight-1)+10 20*(iLight-1)],[0 0 yLim_bc(1) yLim_bc(1)],colorLLightBlue,'LineStyle','none');
        hold on;
    end
    hBar(4) = bar(xpt,m_ca3bc_act,'histc');
    errorbarJun(xpt+1,m_ca3bc_act,sem_ca3bc_act,1,eBarWidth,colorDarkGray);
    text(100,yLim_bc(1)*0.8,['n = ',num2str(n_ca3bc_act)],'fontSize',fontM);
    xlabel('Time (ms)','fontSize',fontM);
    ylabel('Rate (Hz)','fontSize',fontM);
    
% no response
hPlot(5) = axes('Position',axpt(nCol,nRow,2,3,spaceFig,wideInterval));
    for iLight = 1:4
        lightPatch(iLight) = patch([20*(iLight-1) 20*(iLight-1)+10 20*(iLight-1)+10 20*(iLight-1)],[0 0 yLim_bc(2) yLim_bc(2)],colorLLightBlue,'LineStyle','none');
        hold on;
    end
    hBar(5) = bar(xpt,m_ca3bc_non,'histc');
    errorbarJun(xpt+1,m_ca3bc_non,sem_ca3bc_non,1,eBarWidth,colorDarkGray);
    text(100,yLim_bc(2)*0.8,['n = ',num2str(n_ca3bc_non)],'fontSize',fontM);
    xlabel('Time (ms)','fontSize',fontM);
    ylabel('Rate (Hz)','fontSize',fontM);

align_ylabel(hPlot,-0.05,0);
    
set(hBar,'faceColor',colorDarkGray);
set(hPlot,'Box','off','TickDir','out','XLim',[-20 100],'XTick',[-20,0:20:100],'fontSize',fontM);
set(hPlot(4),'YLim',[0 yLim_bc(1)],'YTick',[0:50:yLim_bc(1)]);
set(hPlot(5),'YLim',[0 yLim_bc(2)]);

print('-painters','-r300','-dtiff',['fig3_PSTH_novel_',datestr(now,formatOut),'.tif']);
print('-painters','-r300','-depsc',['fig3_PSTH_novel_',datestr(now,formatOut),'.ai']);
close all;