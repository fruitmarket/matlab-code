clearvars;
formatOut = 'yymmdd';

rtDir = 'D:\Dropbox\SNL\P2_Track';
cd(rtDir);
load('D:\Dropbox\SNL\P2_Track\myParameters.mat');
load('neuronList_ori_180213.mat');
Txls = readtable('neuronList_ori_180206.xlsx');
T.compIdxControl = categorical(Txls.compIdxControl);

cri_peakFR = 2;
tPC = ((T.taskType == 'noRun' & isundefined(T.compIdxControl)) | (T.taskType == 'noRw' & isundefined(T.compIdxControl)) | (T.sessionOrder == '1' & ~isundefined(T.compIdxControl))) & T.idxNeurontype == 'PN'; % 1st session
% tPC = T.taskType == 'DRw' & T.idxNeurontype == 'PN'; 
% tPC = T.taskType == 'DRun' & T.idxNeurontype == 'PN';
%% Population separation
% cSpkpvr = 1.2;
% alpha = 0.01;
% condiPN = T.spkpvr>cSpkpvr;
% condiIN = ~condiPN;

condiPN = tPC;

lightActPN = condiPN & (T.idx_plfm8hz == 1);
lightActDirectPN = condiPN & (T.idx_plfm8hz == 1) & T.idx_plfm8hzLatency == 'direct';
lightActIndirectPN = condiPN & (T.idx_plfm8hz == 1) & T.idx_plfm8hzLatency == 'indirect';
lightActDoublePN = condiPN & (T.idx_plfm8hz == 1) & T.idx_plfm8hzLatency == 'double';

lightInaPN = condiPN & (T.idx_plfm8hz == -1);
lightNoPN = condiPN & (T.idx_plfm8hz == 0);

latency_dir =  nanmean(T.plfm8hzLatency1(lightActDirectPN));
latency_ind = nanmean(T.plfm8hzLatency2(lightActIndirectPN));
%%

% Pyramidal neuron
actPN_peth = cell2mat(T.pethPlfm8hz(lightActPN));
actPN_peth_direct = cell2mat(T.pethPlfm8hz(lightActDirectPN));
actPN_peth_indirect = cell2mat(T.pethPlfm8hz(lightActIndirectPN));
actDBPN_peth = cell2mat(T.pethPlfm8hz(lightActDoublePN));
inactPN_peth = cell2mat(T.pethPlfm8hz(lightInaPN));
noPN_peth = cell2mat(T.pethPlfm8hz(lightNoPN));


%% Mean & SEM
nactPN = size(actPN_peth,1);
m_actPN_peth = mean(actPN_peth,1);
sem_actPN_peth = std(actPN_peth,0,1)/sqrt(nactPN);

nactPN_direct = size(actPN_peth_direct,1);
m_actPN_peth_direct = mean(actPN_peth_direct,1);
sem_actPN_peth_direct = std(actPN_peth_direct,0,1)/sqrt(nactPN_direct);

nactPN_indirect = size(actPN_peth_indirect,1);
m_actPN_peth_indirect = mean(actPN_peth_indirect,1);
sem_actPN_peth_indirect = std(actPN_peth_indirect,0,1)/sqrt(nactPN_indirect);

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
xpt = [-25:2:99];
yLim = [35 35 70 10 10 120];

fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});
nCol = 2;
nRow = 2;
%% PN activated
hPlotPN(1) = axes('Position',axpt(2,6,1,1,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
lightPatch(1) = patch([0 10 10 0],[0 0 yLim(1) yLim(1)],colorLLightBlue);
hold on;
hBarPN(1) = bar(xpt,m_actPN_peth,'histc');
errorbarJun(xpt+1,m_actPN_peth,sem_actPN_peth,1,0.4,colorDarkGray);
text(57, yLim(1)*0.8,['n = ',num2str(nactPN)],'fontSize',fontM);
% xlabel('Time (ms)','fontSize',fontS);
ylabel('Rate (Hz)','fontSize',fontM);
% title('PN_activated','fontSize',fontM,'interpreter','none','fontWeight','bold');

%% direct
hPlotPN(2) = axes('Position',axpt(2,6,1,2,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
lightPatch(2) = patch([0 10 10 0],[0 0 yLim(2) yLim(2)],colorLLightBlue);
hold on;
hBarPN(2) = bar(xpt,m_actPN_peth_direct,'histc');
errorbarJun(xpt+1,m_actPN_peth_direct,sem_actPN_peth_direct,1,0.4,colorDarkGray);
text(57, yLim(2)*0.8,['n = ',num2str(nactPN_direct)],'fontSize',fontM);
% xlabel('Time (ms)','fontSize',fontS);
ylabel('Rate (Hz)','fontSize',fontM);
% title('PN_direct','fontSize',fontM,'interpreter','none','fontWeight','bold');

%% indirect
hPlotPN(3) = axes('Position',axpt(2,6,1,3,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
lightPatch(3) = patch([0 10 10 0],[0 0 yLim(3) yLim(3)],colorLLightBlue);
hold on;
hBarPN(3) = bar(xpt,m_actPN_peth_indirect,'histc');
errorbarJun(xpt+1,m_actPN_peth_indirect,sem_actPN_peth_indirect,1,0.4,colorDarkGray);
text(57, yLim(3)*0.8,['n = ',num2str(nactPN_indirect)],'fontSize',fontM);
% xlabel('Time (ms)','fontSize',fontS);
ylabel('Rate (Hz)','fontSize',fontM);
% title('PN_indirect','fontSize',fontM,'interpreter','none','fontWeight','bold');

% hPlotPN(4) = axes('Position',axpt(nCol,nRow,1,4,[0.10 0.10 0.85 0.8],midInterval));
% lightPatch(7) = patch([0 10 10 0],[0 0 100 100],colorLLightBlue);
% hold on;
% lightPatch(8) = patch([0 10 10 0],[100*0.925 100*0.925 100 100],colorBlue);
% hold on;
% hBarPN(4) = bar(xpt,m_actDBPN_peth,'histc');
% errorbarJun(xpt+1,m_actDBPN_peth,sem_actDBPN_peth,1,0.4,colorDarkGray);
% text(57, 100*0.8,['n = ',num2str(nactDBPN)],'fontSize',fontS);
% xlabel('Time (ms)','fontSize',fontS);
% ylabel('Rate (Hz)','fontSize',fontS);
% title('PN_double peak','fontSize',fontS,'interpreter','none','fontWeight','bold');

%% inactivated
hPlotPN(4) = axes('Position',axpt(2,6,1,5,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
lightPatch(4) = patch([0 10 10 0],[0 0 yLim(4) yLim(4)],colorLLightBlue);
hold on;
hBarPN(4) = bar(xpt,m_inactPN_peth,'histc');
errorbarJun(xpt+1,m_inactPN_peth,sem_inactPN_peth,1,0.4,colorDarkGray);
text(57, yLim(4)*0.8,['n = ',num2str(ninactPN)],'fontSize',fontM);
ylabel('Rate (Hz)','fontSize',fontM);
% title('PN_inactivated','interpreter','none','fontSize',fontM,'fontWeight','bold');

%% no resp
hPlotPN(5) = axes('Position',axpt(2,6,1,6,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
lightPatch(5) = patch([0 10 10 0],[0 0 yLim(5) yLim(5)],colorLLightBlue);
hold on;
hBarPN(5) = bar(xpt,m_noPN_peth,'histc');
errorbarJun(xpt+1,m_noPN_peth,sem_noPN_peth,1,0.4,colorDarkGray);
text(57, yLim(5)*0.8,['n = ',num2str(nnoPN)],'fontSize',fontM);
xlabel('Time (ms)','fontSize',fontM);
ylabel('Rate (Hz)','fontSize',fontM);
% title('PN_no response','fontSize',fontM,'interpreter','none','fontWeight','bold');

%% double
hPlotPN(6) = axes('Position',axpt(2,6,1,4,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
lightPatch(6) = patch([0 10 10 0],[0 0 yLim(6) yLim(6)],colorLLightBlue);
hold on;
hBarPN(6) = bar(xpt,m_actDBPN_peth,'histc');
errorbarJun(xpt+1,m_actDBPN_peth,sem_actDBPN_peth,1,0.4,colorDarkGray);
text(57, yLim(6)*0.8,['n = ',num2str(nactDBPN)],'fontSize',fontM);
ylabel('Rate (Hz)','fontSize',fontM);
% title('PN_double response','fontSize',fontM,'interpreter','none','fontWeight','bold');

%%
align_ylabel(hPlotPN);
set(lightPatch,'LineStyle','none');
set(hBarPN,'FaceColor',colorBlack,'EdgeColor',colorBlack,'FaceAlpha',1);
set(hPlotPN,'Box','off','TickDir','out','XLim',[-10,75],'fontSize',fontM);
set(hPlotPN(1),'YLim',[0 yLim(1)],'YTick',[0:10:30]); % act
set(hPlotPN(2),'YLim',[0 yLim(2)],'YTick',[0:10:30]); % direct
set(hPlotPN(3),'YLim',[0 yLim(3)],'YTick',[0:20:60]); % indirect
set(hPlotPN(4),'YLim',[0 yLim(4)]); % inactivated
set(hPlotPN(5),'YLim',[0 yLim(5)]); % noresp
set(hPlotPN(6),'YLim',[0 yLim(6)]); % double
set(hPlotPN(1:6),'XTick',[-10 0 10 20 75]);
set(hPlotPN,'TickLength',[0.03, 0.03]);
% set(hPlotPN(5),'XTick',[-10 0 10 20 75],'XTickLabel',[-10 0 10 20 75]);

% print('-painters','-r300','-depsc',['final_Neuron_fig1_platform_ori8hz_v4_Control_',datestr(now,formatOut),'.ai']);
% print('-painters','-r300','-dtiff',['final_Neuron_fig1_platform_ori8hz_v4_Control_',datestr(now,formatOut),'.tif']);
% close;