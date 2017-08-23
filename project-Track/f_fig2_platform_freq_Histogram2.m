clearvars;

rtDir = 'D:\Dropbox\SNL\P2_Track';
cd(rtDir);
load myParameters.mat
load('neuronList_freq_170821.mat');
Txls = readtable('neuronList_freq_170821.xlsx');
Txls.latencyIndex = categorical(Txls.latencyIndex);
formatOut = 'yymmdd';

%% Population separation
cri_MeanFR = 9;
cMaxPeakFR = 1;
cSpkpvr = 1.1;
alpha = 0.01;

condiPN = T.spkpvr>cSpkpvr & T.meanFR<cri_MeanFR;
condiPN = T.spkpvr>cSpkpvr;
condiIN = ~condiPN;

lightActPN = condiPN & (Txls.statDir_visual == 1);
lightActDirectPN = condiPN & (Txls.statDir_visual == 1) & Txls.latencyIndex == 'direct';
lightActIndirectPN = condiPN & (Txls.statDir_visual == 1) & Txls.latencyIndex == 'indirect';
lightActDoublePN = condiPN & (Txls.statDir_visual == 1) & Txls.latencyIndex == 'double';
lightInaPN = condiPN & (Txls.statDir_visual == -1);
lightNoPN = condiPN & (Txls.statDir_visual == 0);

% Pyramidal neuron
actPN_peth = cell2mat(T.peth8hz_ori(lightActPN));
actRPN_peth = cell2mat(T.peth8hz_ori(lightActDirectPN));
actDPN_peth = cell2mat(T.peth8hz_ori(lightActIndirectPN));
actDBPN_peth = cell2mat(T.peth8hz_ori(lightActDoublePN));
inactPN_peth = cell2mat(T.peth8hz_ori(lightInaPN));
noPN_peth = cell2mat(T.peth8hz_ori(lightNoPN));


%% Mean & SEM
nactPN = size(actPN_peth,1);
m_actPN_peth = mean(actPN_peth,1);
sem_actPN_peth = std(actPN_peth,0,1)/sqrt(nactPN);

nactRPN = size(actRPN_peth,1);
m_actRPN_peth = mean(actRPN_peth,1);
sem_actRPN_peth = std(actRPN_peth,0,1)/sqrt(nactRPN);

nactDPN = size(actDPN_peth,1);
m_actDPN_peth = mean(actDPN_peth,1);
sem_actDPN_peth = std(actDPN_peth,0,1)/sqrt(nactDPN);

nactDBPN = size(actDBPN_peth,1); % double activated (both direct, indirect)
m_actDBPN_peth = mean(actDBPN_peth,1);
sem_actDBPN_peth = std(actDBPN_peth,0,1)/sqrt(nactDBPN);

ninactPN = size(inactPN_peth,1);
m_inactPN_peth = mean(inactPN_peth,1);
sem_inactPN_peth = std(inactPN_peth,0,1)/sqrt(ninactPN);

nnoPN = size(noPN_peth,1);
m_noPN_peth = mean(noPN_peth,1);
sem_noPN_peth = std(noPN_peth,0,1)/sqrt(nnoPN);

%% Plot
% Pyramidal neuron
nCol = 3;
nRow = 4;
xpt = T.pethtime8hz_ori{1};
yMaxPN = max(m_actPN_peth)*2;
yLim = [25 25 40 150 40 10];

fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{2});

hPlotPN(1) = axes('Position',axpt(nCol,nRow,1,1,[0.10 0.10 0.85 0.8],wideInterval));
lightPatch(1) = patch([0 10 10 0],[0 0 yLim(1) yLim(1)],colorLLightBlue);
hold on;
lightPatch(2) = patch([0 10 10 0],[yLim(1)*0.925 yLim(1)*0.925 yLim(1) yLim(1)],colorBlue);
hold on;
hBarPN(1) = bar(xpt,m_actPN_peth,'histc');
errorbarJun(xpt+1,m_actPN_peth,sem_actPN_peth,1,0.4,colorDarkGray);
text(15, yLim(1)*0.8,['n = ',num2str(nactPN)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN_activated','fontSize',fontL,'interpreter','none','fontWeight','bold');

hPlotPN(2) = axes('Position',axpt(nCol,nRow,1,2,[0.10 0.10 0.85 0.8],wideInterval));
lightPatch(3) = patch([0 10 10 0],[0 0 yLim(2) yLim(2)],colorLLightBlue);
hold on;
lightPatch(4) = patch([0 10 10 0],[yLim(2)*0.925 yLim(2)*0.925 yLim(2) yLim(2)],colorBlue);
hold on;
hBarPN(2) = bar(xpt,m_actRPN_peth,'histc');
errorbarJun(xpt+1,m_actRPN_peth,sem_actRPN_peth,1,0.4,colorDarkGray);
text(15, yLim(2)*0.8,['n = ',num2str(nactRPN)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN_direct','fontSize',fontL,'interpreter','none','fontWeight','bold');

hPlotPN(3) = axes('Position',axpt(nCol,nRow,1,3,[0.10 0.10 0.85 0.8],wideInterval));
lightPatch(5) = patch([0 10 10 0],[0 0 yLim(3) yLim(3)],colorLLightBlue);
hold on;
lightPatch(6) = patch([0 10 10 0],[yLim(3)*0.925 yLim(3)*0.925 yLim(3) yLim(3)],colorBlue);
hold on;
hBarPN(3) = bar(xpt,m_actDPN_peth,'histc');
errorbarJun(xpt+1,m_actDPN_peth,sem_actDPN_peth,1,0.4,colorDarkGray);
text(15, yLim(3)*0.8,['n = ',num2str(nactDPN)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN_indirect','fontSize',fontL,'interpreter','none','fontWeight','bold');

hPlotPN(4) = axes('Position',axpt(nCol,nRow,1,4,[0.10 0.10 0.85 0.8],wideInterval));
lightPatch(7) = patch([0 10 10 0],[0 0 100 100],colorLLightBlue);
hold on;
lightPatch(8) = patch([0 10 10 0],[100*0.925 100*0.925 100 100],colorBlue);
hold on;
hBarPN(4) = bar(xpt,m_actDBPN_peth,'histc');
errorbarJun(xpt+1,m_actDBPN_peth,sem_actDBPN_peth,1,0.4,colorDarkGray);
text(15, 100*0.8,['n = ',num2str(nactDBPN)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN_double peak','fontSize',fontL,'interpreter','none','fontWeight','bold');

hPlotPN(5) = axes('Position',axpt(nCol,nRow,2,1,[0.10 0.10 0.85 0.8],wideInterval));
lightPatch(9) = patch([0 10 10 0],[0 0 yLim(5) yLim(5)],colorLLightBlue);
hold on;
lightPatch(10) = patch([0 10 10 0],[yLim(5)*0.925 yLim(5)*0.925 yLim(5) yLim(5)],colorBlue);
hold on;
hBarPN(5) = bar(xpt,m_inactPN_peth,'histc');
errorbarJun(xpt+1,m_inactPN_peth,sem_inactPN_peth,1,0.4,colorDarkGray);
text(15, yLim(5)*0.8,['n = ',num2str(ninactPN)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN_inactivated','interpreter','none','fontSize',fontL,'fontWeight','bold');

hPlotPN(6) = axes('Position',axpt(nCol,nRow,3,1,[0.10 0.10 0.85 0.8],wideInterval));
lightPatch(11) = patch([0 10 10 0],[0 0 yLim(6) yLim(6)],colorLLightBlue);
hold on;
lightPatch(12) = patch([0 10 10 0],[yLim(6)*0.925 yLim(6)*0.925 yLim(6) yLim(6)],colorBlue);
hold on;
hBarPN(6) = bar(xpt,m_noPN_peth,'histc');
errorbarJun(xpt+1,m_noPN_peth,sem_noPN_peth,1,0.4,colorDarkGray);
text(15, yLim(6)*0.8,['n = ',num2str(nnoPN)],'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Spikes/bin','fontSize',fontL);
title('PN_no response','fontSize',fontL,'interpreter','none','fontWeight','bold');

set(lightPatch,'LineStyle','none');
set(hBarPN,'FaceColor',colorBlack,'EdgeColor',colorBlack,'FaceAlpha',1);
set(hPlotPN,'Box','off','TickDir','out','XLim',[-10,115],'XTick',[-10:10:20,115],'fontSize',fontL);

set(hPlotPN(1),'YLim',[0 yLim(1)],'fontSize',fontL);
set(hPlotPN(2),'YLim',[0 yLim(2)],'fontSize',fontL);
set(hPlotPN(3),'YLim',[0 yLim(3)],'fontSize',fontL);
set(hPlotPN(4),'YLim',[0 yLim(4)],'fontSize',fontL);
set(hPlotPN(5),'YLim',[0 yLim(5)],'fontSize',fontL);
set(hPlotPN(6),'YLim',[0 yLim(6)],'fontSize',fontL);

print('-painters','-r300','-dtiff',['final_fig2_platform_8hzHistogram',datestr(now,formatOut),'.tif']);
% print('-painters','-r300','-depsc',[datestr(now,formatOut),'_plot_freqTest_totalPETH_','.ai']);