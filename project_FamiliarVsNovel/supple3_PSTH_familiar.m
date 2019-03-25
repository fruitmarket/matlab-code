% plot_FN_lightAct
clearvars;

load('E:\Dropbox\Lab_mwjung\P2_Track\myParameters.mat');
formatOut = 'yymmdd';
load('E:\Dropbox\Lab_mwjung\P4_FamiliarNovel\neuronList_familiar_190301.mat');
PN = T.neuronType == 'PN';
tt_ca3bc = ((T.mouseID == 'rbp005' & (T.tetrode == 'TT1' | T.tetrode == 'TT5')) | (T.mouseID == 'rbp006' & T.tetrode == 'TT2') | (T.mouseID == 'rbp010' & T.tetrode == 'TT6')); % | (T.mouseID == 'rbp015' & T.tetrode == 'TT7')
PN_ca3bc = PN & tt_ca3bc;
PN_ca3a = PN & ~tt_ca3bc;

%%%% spike number %%%%
ca3a_act = PN_ca3a & T.idxmSpkIn == 1;
ca3a_dir = PN_ca3a & T.idxmSpkIn == 1 & T.latencyTrack1st<10 & isnan(T.latencyTrack2nd);
ca3a_ind = PN_ca3a & T.idxmSpkIn == 1 & T.latencyTrack1st>=10 & isnan(T.latencyTrack2nd);
ca3a_rest = PN_ca3a & T.idxmSpkIn == 1 & ~(ca3a_dir | ca3a_ind);
ca3a_inh = PN_ca3a & T.idxmSpkIn == -1;
ca3a_non = PN_ca3a & T.idxmSpkIn == 0;

n_PN_ca3a = sum(double(PN_ca3a));
n_ca3a_act = sum(double(ca3a_act));
n_ca3a_dir = sum(double(ca3a_dir));
n_ca3a_ind = sum(double(ca3a_ind));
n_ca3a_rest = sum(double(ca3a_rest));
n_ca3a_inh = sum(double(ca3a_inh));
n_ca3a_non = sum(double(ca3a_non));

xpt = T.pethtime1stBStm(ca3a_dir);
xpt = xpt{1};

peth_act = T.peth1stBStm(ca3a_act);
m_ca3a_act = mean(cell2mat(peth_act),1);
sem_ca3a_act = std(cell2mat(peth_act),0,1)/sqrt(n_ca3a_act);

peth_dir = T.peth1stBStm(ca3a_dir);
m_ca3a_dir = mean(cell2mat(peth_dir),1);
sem_ca3a_dir = std(cell2mat(peth_dir),0,1)/sqrt(n_ca3a_dir);

peth_ind = T.peth1stBStm(ca3a_ind);
m_ca3a_ind = mean(cell2mat(peth_ind),1);
sem_ca3a_ind = std(cell2mat(peth_ind),0,1)/sqrt(n_ca3a_ind);

peth_rest = T.peth1stBStm(ca3a_rest);
m_ca3a_rest = mean(cell2mat(peth_rest),1);
sem_ca3a_rest = std(cell2mat(peth_rest),0,1)/sqrt(n_ca3a_rest);

peth_inh = T.peth1stBStm(ca3a_inh);
m_ca3a_inh = mean(cell2mat(peth_inh),1);
sem_ca3a_inh = std(cell2mat(peth_inh),0,1)/sqrt(n_ca3a_inh);

peth_non = T.peth1stBStm(ca3a_non);
m_ca3a_non = mean(cell2mat(peth_non),1);
sem_ca3a_non = std(cell2mat(peth_non),0,1)/sqrt(n_ca3a_non);

ca3bc_act = PN_ca3bc & T.idxmSpkIn == 1;
ca3bc_dir = PN_ca3bc & T.idxmSpkIn == 1 & T.latencyTrack1st<10 & isnan(T.latencyTrack2nd);
ca3bc_ind = PN_ca3bc & T.idxmSpkIn == 1 & T.latencyTrack1st>=10 & isnan(T.latencyTrack2nd);
ca3bc_rest = PN_ca3bc & T.idxmSpkIn == 1 & ~(ca3bc_dir | ca3bc_ind);
ca3bc_inh = PN_ca3bc & T.idxmSpkIn == -1;
ca3bc_non = PN_ca3bc & T.idxmSpkIn == 0;

n_PN_ca3bc = sum(double(PN_ca3bc));
n_ca3bc_act = sum(double(ca3bc_act));
n_ca3bc_dir = sum(double(ca3bc_dir));
n_ca3bc_rest = sum(double(ca3bc_rest));
n_ca3bc_inh = sum(double(ca3bc_inh));
n_ca3bc_non = sum(double(ca3bc_non));

peth_act = T.peth1stBStm(ca3bc_act);
m_ca3bc_act = mean(cell2mat(peth_act),1);
sem_ca3bc_act = std(cell2mat(peth_act),0,1)/sqrt(n_ca3bc_act);

peth_dir = T.peth1stBStm(ca3bc_dir);
m_ca3bc_dir = mean(cell2mat(peth_dir),1);
sem_ca3bc_dir = std(cell2mat(peth_dir),0,1)/sqrt(n_ca3bc_dir);

peth_rest = T.peth1stBStm(ca3bc_rest);
m_ca3bc_rest = mean(cell2mat(peth_rest),1);
sem_ca3bc_rest = std(cell2mat(peth_rest),0,1)/sqrt(n_ca3bc_rest);

peth_inh = T.peth1stBStm(ca3bc_inh);
m_ca3bc_inh = mean(cell2mat(peth_inh),1);
sem_ca3bc_inh = std(cell2mat(peth_inh),0,1)/sqrt(n_ca3bc_inh);

peth_non = T.peth1stBStm(ca3bc_non);
m_ca3bc_non = mean(cell2mat(peth_non),1);
sem_ca3bc_non = std(cell2mat(peth_non),0,1)/sqrt(n_ca3bc_non);

%% plot_Track
nCol = 2;
nRow = 6;
eBarWidth = 0.5;
spaceFig = [0.1 0.2 0.80 0.75];
wideInterval = [0.15 0.11];

fHandle = figure('PaperUnits','centimeters','PaperPosition',[0 0 12 15]);
yLim = [60 160, 40, 10, 10, 10];

% activated (all)
hPlot(1) = axes('Position',axpt(nCol,nRow,1,1,spaceFig,wideInterval));
    for iLight = 1:4
        lightPatch(iLight) = patch([20*(iLight-1) 20*(iLight-1)+10 20*(iLight-1)+10 20*(iLight-1)],[0 0 yLim(1) yLim(1)],colorLLightBlue,'LineStyle','none');
        hold on;
    end
    hBar(1) = bar(xpt,m_ca3a_act,'histc');
    errorbarJun(xpt+1,m_ca3a_act,sem_ca3a_act,1,eBarWidth,colorDarkGray);
    text(90,yLim(1)*0.8,['n = ',num2str(n_ca3a_act)],'fontSize',fontM);
    xlabel('Time (ms)','fontSize',fontM);
    ylabel('Rate (Hz)','fontSize',fontM);
    
% direct
hPlot(2) = axes('Position',axpt(nCol,nRow,1,2,spaceFig,wideInterval));
    for iLight = 1:4
        lightPatch(iLight) = patch([20*(iLight-1) 20*(iLight-1)+10 20*(iLight-1)+10 20*(iLight-1)],[0 0 yLim(2) yLim(2)],colorLLightBlue,'LineStyle','none');
        hold on;
    end
    hBar(2) = bar(xpt,m_ca3a_dir,'histc');
    errorbarJun(xpt+1,m_ca3a_dir,sem_ca3a_dir,1,eBarWidth,colorDarkGray);
    text(90,yLim(2)*0.8,['n = ',num2str(n_ca3a_dir)],'fontSize',fontM);
    xlabel('Time (ms)','fontSize',fontM);
    ylabel('Rate (Hz)','fontSize',fontM);

% indirect
hPlot(3) = axes('Position',axpt(nCol,nRow,1,3,spaceFig,wideInterval));
    for iLight = 1:4
        lightPatch(iLight) = patch([20*(iLight-1) 20*(iLight-1)+10 20*(iLight-1)+10 20*(iLight-1)],[0 0 yLim(3) yLim(3)],colorLLightBlue,'LineStyle','none');
        hold on;
    end
    hBar(3) = bar(xpt,m_ca3a_ind,'histc');
    errorbarJun(xpt+1,m_ca3a_ind,sem_ca3a_ind,1,eBarWidth,colorDarkGray);
    text(90,yLim(3)*0.8,['n = ',num2str(n_ca3a_ind)],'fontSize',fontM);
    xlabel('Time (ms)','fontSize',fontM);
    ylabel('Rate (Hz)','fontSize',fontM);

% rest
hPlot(4) = axes('Position',axpt(nCol,nRow,1,4,spaceFig,wideInterval));
    for iLight = 1:4
        lightPatch(iLight) = patch([20*(iLight-1) 20*(iLight-1)+10 20*(iLight-1)+10 20*(iLight-1)],[0 0 yLim(4) yLim(4)],colorLLightBlue,'LineStyle','none');
        hold on;
    end
    hBar(4) = bar(xpt,m_ca3a_rest,'histc');
    text(90,yLim(4)*0.8,['n = ',num2str(n_ca3a_rest)],'fontSize',fontM);
    xlabel('Time (ms)','fontSize',fontM);
    ylabel('Rate (Hz)','fontSize',fontM);

% inhibited
hPlot(5) = axes('Position',axpt(nCol,nRow,1,5,spaceFig,wideInterval));
    for iLight = 1:4
        lightPatch(iLight) = patch([20*(iLight-1) 20*(iLight-1)+10 20*(iLight-1)+10 20*(iLight-1)],[0 0 yLim(5) yLim(5)],colorLLightBlue,'LineStyle','none');
        hold on;
    end
    hBar(5) = bar(xpt,m_ca3a_inh,'histc');
    errorbarJun(xpt+1,m_ca3a_inh,sem_ca3a_inh,1,eBarWidth,colorDarkGray);
    text(90,yLim(5)*0.8,['n = ',num2str(n_ca3a_inh)],'fontSize',fontM);
    xlabel('Time (ms)','fontSize',fontM);
    ylabel('Rate (Hz)','fontSize',fontM);

% no response
hPlot(6) = axes('Position',axpt(nCol,nRow,1,6,spaceFig,wideInterval));
    for iLight = 1:4
        lightPatch(iLight) = patch([20*(iLight-1) 20*(iLight-1)+10 20*(iLight-1)+10 20*(iLight-1)],[0 0 yLim(6) yLim(6)],colorLLightBlue,'LineStyle','none');
        hold on;
    end
    hBar(6) = bar(xpt,m_ca3a_non,'histc');
    errorbarJun(xpt+1,m_ca3a_non,sem_ca3a_non,1,eBarWidth,colorDarkGray);
    text(90,yLim(6)*0.8,['n = ',num2str(n_ca3a_non)],'fontSize',fontM);
    xlabel('Time (ms)','fontSize',fontM);
    ylabel('Rate (Hz)','fontSize',fontM);

set(hPlot(1),'YLim',[0 yLim(1)],'YTick',[0:30:yLim(1)]);
set(hPlot(2),'YLim',[0 yLim(2)],'YTick',[0:80:yLim(2)]);
set(hPlot(3),'YLim',[0 yLim(3)],'YTick',[0:20:yLim(3)]);
set(hPlot(4),'YLim',[0 yLim(4)]);
set(hPlot(5),'YLim',[0 yLim(5)]);
set(hPlot(6),'YLim',[0 yLim(6)]);

%%
yLim_bc = [100 120, 160, 5, 5];

% activated (all)
hPlot(7) = axes('Position',axpt(nCol,nRow,2,1,spaceFig,wideInterval));
    for iLight = 1:4
        lightPatch(iLight) = patch([20*(iLight-1) 20*(iLight-1)+10 20*(iLight-1)+10 20*(iLight-1)],[0 0 yLim_bc(1) yLim_bc(1)],colorLLightBlue,'LineStyle','none');
        hold on;
    end
    hBar(7) = bar(xpt,m_ca3bc_act,'histc');
    errorbarJun(xpt+1,m_ca3bc_act,sem_ca3bc_act,1,eBarWidth,colorDarkGray);
    text(90,yLim_bc(1)*0.8,['n = ',num2str(n_ca3bc_act)],'fontSize',fontM);
    xlabel('Time (ms)','fontSize',fontM);
    ylabel('Rate (Hz)','fontSize',fontM);
    
% direct
hPlot(8) = axes('Position',axpt(nCol,nRow,2,2,spaceFig,wideInterval));
    for iLight = 1:4
        lightPatch(iLight) = patch([20*(iLight-1) 20*(iLight-1)+10 20*(iLight-1)+10 20*(iLight-1)],[0 0 yLim_bc(2) yLim_bc(2)],colorLLightBlue,'LineStyle','none');
        hold on;
    end
    hBar(8) = bar(xpt,m_ca3bc_dir,'histc');
    errorbarJun(xpt+1,m_ca3bc_dir,sem_ca3bc_dir,1,eBarWidth,colorDarkGray);
    text(90,yLim_bc(2)*0.8,['n = ',num2str(n_ca3bc_dir)],'fontSize',fontM);
    xlabel('Time (ms)','fontSize',fontM);
    ylabel('Rate (Hz)','fontSize',fontM);

% rest
hPlot(9) = axes('Position',axpt(nCol,nRow,2,4,spaceFig,wideInterval));
    for iLight = 1:4
        lightPatch(iLight) = patch([20*(iLight-1) 20*(iLight-1)+10 20*(iLight-1)+10 20*(iLight-1)],[0 0 yLim_bc(3) yLim_bc(3)],colorLLightBlue,'LineStyle','none');
        hold on;
    end
    errorbarJun(xpt+1,m_ca3bc_rest,sem_ca3bc_rest,1,eBarWidth,colorDarkGray);
    hBar(9) = bar(xpt,m_ca3bc_rest,'histc');
    text(90,yLim_bc(3)*0.8,['n = ',num2str(n_ca3bc_rest)],'fontSize',fontM);
    xlabel('Time (ms)','fontSize',fontM);
    ylabel('Rate (Hz)','fontSize',fontM);

% inhibit
% hPlot(10) = axes('Position',axpt(nCol,nRow,2,5,spaceFig,wideInterval));
%     for iLight = 1:4
%         lightPatch(iLight) = patch([20*(iLight-1) 20*(iLight-1)+10 20*(iLight-1)+10 20*(iLight-1)],[0 0 yLim_bc(4) yLim_bc(4)],colorLLightBlue,'LineStyle','none');
%         hold on;
%     end
%     hBar(10) = bar(xpt,m_ca3bc_inh,'histc');
%     errorbarJun(xpt+1,m_ca3bc_inh,sem_ca3bc_inh,1,eBarWidth,colorDarkGray);
%     text(90,yLim_bc(4)*0.8,['n = ',num2str(n_ca3bc_inh)],'fontSize',fontM);
%     xlabel('Time (ms)','fontSize',fontM);
%     ylabel('Rate (Hz)','fontSize',fontM);

% no response
hPlot(10) = axes('Position',axpt(nCol,nRow,2,6,spaceFig,wideInterval));
    for iLight = 1:4
        lightPatch(iLight) = patch([20*(iLight-1) 20*(iLight-1)+10 20*(iLight-1)+10 20*(iLight-1)],[0 0 yLim_bc(4) yLim_bc(4)],colorLLightBlue,'LineStyle','none');
        hold on;
    end
    hBar(10) = bar(xpt,m_ca3bc_non,'histc');
    errorbarJun(xpt+1,m_ca3bc_non,sem_ca3bc_non,1,eBarWidth,colorDarkGray);
    text(90,yLim_bc(5)*0.8,['n = ',num2str(n_ca3bc_non)],'fontSize',fontM);
    xlabel('Time (ms)','fontSize',fontM);
    ylabel('Rate (Hz)','fontSize',fontM);

align_ylabel(hPlot,-0.05,0);
    
set(hBar,'faceColor',colorDarkGray);
set(hPlot,'Box','off','TickDir','out','XLim',[-10 120],'XTick',[-10,0:20:100],'fontSize',fontM);
set(hPlot(7),'YLim',[0 yLim_bc(1)],'YTick',[0:50:yLim_bc(1)]);
set(hPlot(8),'YLim',[0 yLim_bc(2)],'YTick',[0:60:yLim_bc(2)]);
set(hPlot(9),'YLim',[0 yLim_bc(3)],'YTick',[0:80:yLim_bc(3)]);
% set(hPlot(10),'YLim',[0 yLim_bc(4)]);
set(hPlot(10),'YLim',[0 yLim_bc(5)]);

print('-painters','-r300','-dtiff',['supple3_PSTH_familiar_',datestr(now,formatOut),'.tif']);
print('-painters','-r300','-deps',['supple3_PSTH_familiar_',datestr(now,formatOut),'.ai']);
close all;