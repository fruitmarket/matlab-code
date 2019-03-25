clearvars;

cd('E:\Dropbox\SNL\P2_Track'); % win version
load myParameters.mat;
formatOut = 'yymmdd';
Txls = readtable('neuronList_ori_171227.xlsx');
Txls.latencyIndex = categorical(Txls.latencyIndex);
% load('neuronList_ori_171227.mat');
load('neuronList_ori_180517.mat');

% total population (RunPN / RwPN / RunPN / RwPN) with light responsiveness (light activated)
% Run_PN_act = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxpLR_Track & T.statDir_TrackN == 1;
% Run_PN_actDirect = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxpLR_Track & T.statDir_TrackN == 1 & Txls.latencyIndex == 'direct';
% Run_PN_actIndirect = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxpLR_Track & T.statDir_TrackN == 1 & Txls.latencyIndex == 'indirect';
% Run_PN_actDouble = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxpLR_Track & T.statDir_TrackN == 1 & Txls.latencyIndex == 'double';
% Run_PN_ina = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxpLR_Track & T.statDir_TrackN == -1;
% Run_PN_noresp = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & ~T.idxpLR_Track;
% Run_PN_actDirect = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idx_evoSpikeDir == 1 & Txls.latencyIndex == 'direct';
% Run_PN_actIndirect = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idx_evoSpikeDir == 1 & Txls.latencyIndex == 'indirect';
% Run_PN_actDouble = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idx_evoSpikeDir == 1 & Txls.latencyIndex == 'double';
Run_PN_act = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idx_evoSpikeDir == 1;
Run_PN_ina = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idx_evoSpikeDir == -1;
Run_PN_noresp = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idx_evoSpikeDir == 0;

% latency time
% direct = mean(T.latencyTrack1stN(Run_PN_actDirect));
% indirect = mean(T.latencyTrack1stN(Run_PN_actIndirect));

%% PETH
RunPN_act_pethTrack = T.pethTrackLight(Run_PN_act,:);
% RunPN_actRapid_pethTrack = T.pethTrackLight(Run_PN_actDirect,:);
% RunPN_actDelay_pethTrack = T.pethTrackLight(Run_PN_actIndirect,:);
% RunPN_actDouble_pethTrack = T.pethTrackLight(Run_PN_actDouble,:);
RunPN_ina_pethTrack = T.pethTrackLight(Run_PN_ina,:);
RunPN_no_pethTrack = T.pethTrackLight(Run_PN_noresp,:);

%% Mean & Sem
n_RunPN_act_pethTrack = size(RunPN_act_pethTrack,1);
m_RunPN_act_pethTrack = mean(RunPN_act_pethTrack,1);
sem_RunPN_act_pethTrack = std(RunPN_act_pethTrack,1)/sqrt(n_RunPN_act_pethTrack);

% n_RunPN_actRapid_pethTrack = size(RunPN_actRapid_pethTrack,1);
% m_RunPN_actRapid_pethTrack = mean(RunPN_actRapid_pethTrack,1);
% sem_RunPN_actRapid_pethTrack = std(RunPN_actRapid_pethTrack,1)/sqrt(n_RunPN_actRapid_pethTrack);
% 
% n_RunPN_actDelay_pethTrack = size(RunPN_actDelay_pethTrack,1);
% m_RunPN_actDelay_pethTrack = mean(RunPN_actDelay_pethTrack,1);
% sem_RunPN_actDelay_pethTrack = std(RunPN_actDelay_pethTrack,1)/sqrt(n_RunPN_actDelay_pethTrack);
% 
% n_RunPN_actDouble_pethTrack = size(RunPN_actDouble_pethTrack,1);
% m_RunPN_actDouble_pethTrack = mean(RunPN_actDouble_pethTrack,1);
% sem_RunPN_actDouble_pethTrack = std(RunPN_actDouble_pethTrack,1)/sqrt(n_RunPN_actDouble_pethTrack);

n_RunPN_ina_pethTrack = size(RunPN_ina_pethTrack,1);
m_RunPN_ina_pethTrack = mean(RunPN_ina_pethTrack,1);
sem_RunPN_ina_pethTrack = std(RunPN_ina_pethTrack,1)/sqrt(n_RunPN_ina_pethTrack);

n_RunPN_no_pethTrack = size(RunPN_no_pethTrack,1);
m_RunPN_no_pethTrack = mean(RunPN_no_pethTrack,1);
sem_RunPN_no_pethTrack = std(RunPN_no_pethTrack,1)/sqrt(n_RunPN_no_pethTrack);

%%
nCol = 4;
nRow = 3;
wideInterval = wideInterval + [0.05 0.05];

xpt = T.pethtimeTrackLight(2,:);
yMaxRunPN = max([m_RunPN_act_pethTrack, m_RunPN_ina_pethTrack, m_RunPN_no_pethTrack])*2;

yLimPN = [30 25 10];

fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});
% activated total
hPlotRunPN(1) = axes('Position',axpt(2,4,1,1,axpt(nCol,nRow,1:2,1:2,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
pLight(1) = patch([0 10 10 0],[0 0 yLimPN(1) yLimPN(1)],colorLLightBlue);
hold on;
hBarRunPN(1) = bar(xpt,m_RunPN_act_pethTrack,'histc');
errorbarJun(xpt+1,m_RunPN_act_pethTrack,sem_RunPN_act_pethTrack,1,0.4,colorDarkGray);
text(75, yLimPN(1)*0.8,['n = ',num2str(n_RunPN_act_pethTrack)],'fontSize',fontM);
xlabel('Time (ms)','fontSize',fontM);
ylabel('Rate (Hz)','fontSize',fontM);
% title('PN: Total activated','fontSize',fontM,'fontWeight','bold');

% inactivated
hPlotRunPN(2) = axes('Position',axpt(2,4,1,2,axpt(nCol,nRow,1:2,1:2,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
pLight(2) = patch([0 10 10 0],[0 0 yLimPN(2) yLimPN(2)],colorLLightBlue);
hold on;
hBarRunPN(2) = bar(xpt,m_RunPN_ina_pethTrack,'histc');
errorbarJun(xpt+1,m_RunPN_ina_pethTrack,sem_RunPN_ina_pethTrack,1,0.4,colorDarkGray);
text(75, yLimPN(2)*0.8,['n = ',num2str(n_RunPN_ina_pethTrack)],'fontSize',fontM);
xlabel('Time (ms)','fontSize',fontM);
ylabel('Rate (Hz)','fontSize',fontM);
% title('PN: inactivated','fontSize',fontM,'fontWeight','bold');

% no response
hPlotRunPN(3) = axes('Position',axpt(2,4,1,3,axpt(nCol,nRow,1:2,1:2,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
pLight(3) = patch([0 10 10 0],[0 0 yLimPN(3) yLimPN(3)],colorLLightBlue);
hold on;
hBarRunPN(3) = bar(xpt,m_RunPN_no_pethTrack,'histc');
errorbarJun(xpt+1,m_RunPN_no_pethTrack,sem_RunPN_no_pethTrack,1,0.4,colorDarkGray);
text(75, yLimPN(3)*0.8,['n = ',num2str(n_RunPN_no_pethTrack)],'fontSize',fontM);
xlabel('Time (ms)','fontSize',fontM);
ylabel('Rate (Hz)','fontSize',fontM);
% title('PN: no response','fontSize',fontM,'fontWeight','bold');

set(hBarRunPN,'FaceColor',colorBlack,'EdgeColor','none');
set(hPlotRunPN,'Box','off','TickDir','out','XLim',[-20,100],'XTick',[-20,0,10,100],'fontSize',fontM)
set(hPlotRunPN(1),'YLim',[0, yLimPN(1)]);
set(hPlotRunPN(2),'YLim',[0, yLimPN(2)]);
set(hPlotRunPN(3),'YLim',[0, yLimPN(3)]);
set(pLight,'LineStyle','none');
set(hPlotRunPN,'TickLength',[0.03 0.03]);
%% neural trace

% Raw data
spikePsdPreD = cell2mat(T.spikePsdPreD);
spikePsdStmD = cell2mat(T.spikePsdStmD);
spikePsdPostD = cell2mat(T.spikePsdPostD);

spikeActPre_PN = spikePsdPreD(Run_PN_act,:);
spikeInaPre_PN = spikePsdPreD(Run_PN_ina,:);
spikeNorespPre_PN = spikePsdPreD(Run_PN_noresp,:);

spikeActStm_PN = spikePsdStmD(Run_PN_act,:);
spikeInaStm_PN = spikePsdStmD(Run_PN_ina,:);
spikeNorespStm_PN = spikePsdStmD(Run_PN_noresp,:);

[nAct, ~] = size(spikeActPre_PN);
[nIna, ~] = size(spikeInaPre_PN);
[nNoresp, ~] = size(spikeNorespPre_PN);

% Smoothed data --> normalized --> spike sum / spike norm
[spikeSmthActPre, spikeSmthInaPre, spikeSmthNorespPre, spikeSmthActStm, spikeSmthInaStm, spikeSmthNorespStm] = deal([]);
winWidth = 5;

for iCell = 1:nAct
    spikeSmthActPre(iCell,:) = smooth(spikeActPre_PN(iCell,:),winWidth);
    spikeSmthActStm(iCell,:) = smooth(spikeActStm_PN(iCell,:),winWidth);
end
for iCell = 1:nIna
    spikeSmthInaPre(iCell,:) = smooth(spikeInaPre_PN(iCell,:),winWidth);
    spikeSmthInaStm(iCell,:) = smooth(spikeInaStm_PN(iCell,:),winWidth);
end
for iCell = 1:nNoresp
    spikeSmthNorespPre(iCell,:) = smooth(spikeNorespPre_PN(iCell,:),winWidth);
    spikeSmthNorespStm(iCell,:) = smooth(spikeNorespStm_PN(iCell,:),winWidth);
end

spikeSmthActPre = spikeSmthActPre(:,3:end-2);
spikeSmthInaPre = spikeSmthInaPre(:,3:end-2);
spikeSmthNorespPre = spikeSmthNorespPre(:,3:end-2);

spikeSmthActStm = spikeSmthActStm(:,3:end-2);
spikeSmthInaStm = spikeSmthInaStm(:,3:end-2);
spikeSmthNorespStm = spikeSmthNorespStm(:,3:end-2);

% mean first then normalized
m_spikeActStm = mean(spikeSmthActStm,1);
m_spikeInaStm = mean(spikeSmthInaStm,1);
m_spikeNorespStm = mean(spikeSmthNorespStm,1);

norm_m_spikeActStm = m_spikeActStm./repmat(mean(m_spikeActStm(1:20),2),1,120);
norm_m_spikeInaStm = m_spikeInaStm./repmat(mean(m_spikeInaStm(1:20),2),1,120);
norm_m_spikeNorespStm = m_spikeNorespStm./repmat(mean(m_spikeNorespStm(1:20),2),1,120);

%%
for iBin = 1:120
    pBin_Run(iBin,1) = ranksum(spikeSmthActPre(:,iBin), spikeSmthActStm(:,iBin));
    pBin_Run(iBin,2) = ranksum(spikeSmthInaPre(:,iBin), spikeSmthInaStm(:,iBin));
    [~, pBin_Run(iBin,3)] = ttest(spikeSmthNorespPre(:,iBin), spikeSmthNorespStm(:,iBin));
end
%% CBP test
sigArea_PNact_Run = [4 15];
sigArea_PNina_Run = [3 24];
sigArea_PNnoresp_Run = [20 29];
% sigArea_PNact = statCBP_v2(spikeSmthActStm,spikeSmthActPre);
% sigArea_PNina = statCBP_v2(spikeSmthInaStm,spikeSmthInaPre);
% sigArea_PNnoresp = statCBP_v2(spikeSmthNorespStm,spikeSmthNorespPre);
% sigArea_PNact_Run = statCBP_v2(spikeSmthActStm(:,21:60),spikeSmthActPre(:,21:60));
% sigArea_PNina_Run = statCBP_v2(spikeSmthInaStm(:,21:60),spikeSmthInaPre(:,21:60));
% sigArea_PNnoresp_Run = statCBP_v2(spikeSmthNorespStm(:,21:60),spikeSmthNorespPre(:,21:60));
% sigArea_PNact = statCBP_v2(spikeSmthActStm);
% sigArea_PNina = statCBP_v2(spikeSmthInaStm);
% sigArea_PNnoresp = statCBP_v2(spikeSmthNorespStm);

%%
xpt = -20:99;

hPlotTrace(1) = axes('Position',axpt(2,4,1,4,axpt(nCol,nRow,1:2,1:2,[0.1 0.1 0.85 0.85],midInterval),(wideInterval-[0, 0.07])));
plot(xpt,norm_m_spikeActStm,'-o','color',colorRed,'MarkerFaceColor',colorDarkRed,'markerSize',markerSS,'LineWidth',lineM);
hold on;
plot(xpt,norm_m_spikeInaStm,'-o','color',colorBlue,'MarkerFaceColor',colorDarkBlue,'markerSize',markerSS,'LineWidth',lineM);
hold on;
plot(xpt,norm_m_spikeNorespStm,'-o','color',colorBlack,'MarkerFaceColor',colorDarkGray,'markerSize',markerSS,'LineWidth',lineM);
hold on;
line([sigArea_PNact_Run(1), sigArea_PNact_Run(end)],[17,17],'color',colorRed,'lineWidth', 2, 'lineStyle','-');
hold on;
line([sigArea_PNina_Run(1), sigArea_PNina_Run(end)],[-1.5,-1.5],'color',colorBlue,'lineWidth', 2, 'lineStyle','-');
hold on;
line([sigArea_PNnoresp_Run(1), sigArea_PNnoresp_Run(end)],[-2.5,-2.5],'color',colorDarkGray,'lineWidth', 2, 'lineStyle','-');
set(hPlotTrace(1),'Box','off','TickDIr','out','XLim',[-20,100],'XTick',[-20:20:40,100],'YLim',[-4, 20],'fontSize',fontM);
set(hPlotTrace(1),'TickLength',[0.03 0.03]);
text(30, 6, ['Activated (n = ',num2str(nAct),')'],'color',colorRed,'fontSize',fontM);
text(30, 4.5, ['Inactivated (n = ',num2str(nIna),')'],'color',colorBlue,'fontSize',fontM);
text(30, 3, ['No response (n = ',num2str(nNoresp),')'],'color',colorBlack,'fontSize',fontM);
xlabel('Time (ms)','fontSize',fontM);
ylabel('Normalized mean spike','fontSize',fontM);

%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% Rw %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%

% total population (DRwPN / DRwIN / DRwPN / DRwIN) with light responsiveness (light activated)
% Rw_PN_act = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxpLR_Track & T.statDir_TrackN == 1;
% Rw_PN_ina = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxpLR_Track & T.statDir_TrackN == -1;
% Rw_PN_no = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & ~T.idxpLR_Track;
% Rw_PN_Direct = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxpLR_Track & Txls.latencyIndex == 'direct';
% Rw_PN_Indirect = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxpLR_Track & Txls.latencyIndex == 'indirect';
% RW_PN_Double = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxpLR_Track & Txls.latencyIndex == 'double';
% Rw_PN_Direct = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idx_evoSpikeDir == 1 & Txls.latencyIndex == 'direct';
% Rw_PN_Indirect = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idx_evoSpikeDir == 1 & Txls.latencyIndex == 'indirect';
% RW_PN_Double = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idx_evoSpikeDir == 1 & Txls.latencyIndex == 'double';
Rw_PN_act = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idx_evoSpikeDir == 1;
Rw_PN_ina = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idx_evoSpikeDir == -1;
Rw_PN_no = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idx_evoSpikeDir == 0;

% latency time
% direct = mean(T.latencyTrack1stN(PN_actDirect));
% indirect = mean(T.latencyTrack1stN(PN_actIndirect));

%% PETH
% DRwPN_actRapid_pethTrack = T.pethTrackLight(Rw_PN_Direct,:);
% DRwPN_actDelay_pethTrack = T.pethTrackLight(Rw_PN_Indirect,:);
% DRwPN_actDouble_pethTrack = T.pethTrackLight(RW_PN_Double,:);
DRwPN_act_pethTrack = T.pethTrackLight(Rw_PN_act,:);
DRwPN_ina_pethTrack = T.pethTrackLight(Rw_PN_ina,:);
DRwPN_no_pethTrack = T.pethTrackLight(Rw_PN_no,:);

%% Mean & Sem
% n_DRwPN_actRapid_pethTrack = size(DRwPN_actRapid_pethTrack,1);
% m_DRwPN_actRapid_pethTrack = mean(DRwPN_actRapid_pethTrack,1);
% sem_DRwPN_actRapid_pethTrack = std(DRwPN_actRapid_pethTrack,1)/sqrt(n_DRwPN_actRapid_pethTrack);
% 
% n_DRwPN_actDelay_pethTrack = size(DRwPN_actDelay_pethTrack,1);
% m_DRwPN_actDelay_pethTrack = mean(DRwPN_actDelay_pethTrack,1);
% sem_DRwPN_actDelay_pethTrack = std(DRwPN_actDelay_pethTrack,1)/sqrt(n_DRwPN_actDelay_pethTrack);
% 
% n_DRwPN_actDouble_pethTrack = size(DRwPN_actDouble_pethTrack,1);
% m_DRwPN_actDouble_pethTrack = mean(DRwPN_actDouble_pethTrack,1);
% sem_DRwPN_actDouble_pethTrack = std(DRwPN_actDouble_pethTrack,1)/sqrt(n_DRwPN_actDouble_pethTrack);

n_DRwPN_act_pethTrack = size(DRwPN_act_pethTrack,1);
m_DRwPN_act_pethTrack = mean(DRwPN_act_pethTrack,1);
sem_DRwPN_act_pethTrack = std(DRwPN_act_pethTrack,1)/sqrt(n_DRwPN_act_pethTrack);

n_DRwPN_ina_pethTrack = size(DRwPN_ina_pethTrack,1);
m_DRwPN_ina_pethTrack = mean(DRwPN_ina_pethTrack,1);
sem_DRwPN_ina_pethTrack = std(DRwPN_ina_pethTrack,1)/sqrt(n_DRwPN_ina_pethTrack);

n_DRwPN_no_pethTrack = size(DRwPN_no_pethTrack,1);
m_DRwPN_no_pethTrack = mean(DRwPN_no_pethTrack,1);
sem_DRwPN_no_pethTrack = std(DRwPN_no_pethTrack,1)/sqrt(n_DRwPN_no_pethTrack);

%%
xpt = T.pethtimeTrackLight(2,:);
yMaxDRwPN = max([m_DRwPN_act_pethTrack, m_DRwPN_ina_pethTrack, m_DRwPN_no_pethTrack])*2;

% activated total
hPlotRwPN(1) = axes('Position',axpt(2,4,2,1,axpt(nCol,nRow,1:2,1:2,[0.15 0.1 0.85 0.85],midInterval),wideInterval));
pLight(1) = patch([0 10 10 0],[0 0 yLimPN(1) yLimPN(1)],colorLLightBlue);
hold on;
hBarDRwPN(1) = bar(xpt,m_DRwPN_act_pethTrack,'histc');
errorbarJun(xpt+1,m_DRwPN_act_pethTrack,sem_DRwPN_act_pethTrack,1,0.4,colorDarkGray);
text(75, yLimPN(1)*0.8,['n = ',num2str(n_DRwPN_act_pethTrack)],'fontSize',fontM);
xlabel('Time (ms)','fontSize',fontM);
ylabel('Rate (Hz)','fontSize',fontM);
% title('PN: Total activated','fontSize',fontM,'fontWeight','bold');

% inactivated
hPlotRwPN(2) = axes('Position',axpt(2,4,2,2,axpt(nCol,nRow,1:2,1:2,[0.15 0.1 0.85 0.85],midInterval),wideInterval));
pLight(2) = patch([0 10 10 0],[0 0 yLimPN(2) yLimPN(2)],colorLLightBlue);
hold on;
hBarDRwPN(2) = bar(xpt,m_DRwPN_ina_pethTrack,'histc');
errorbarJun(xpt+1,m_DRwPN_ina_pethTrack,sem_DRwPN_ina_pethTrack,1,0.4,colorDarkGray);
text(75, yLimPN(2)*0.8,['n = ',num2str(n_DRwPN_ina_pethTrack)],'fontSize',fontM);
xlabel('Time (ms)','fontSize',fontM);
ylabel('Rate (Hz)','fontSize',fontM);
% title('PN: inactivated','fontSize',fontM,'fontWeight','bold');

% no response
hPlotRwPN(3) = axes('Position',axpt(2,4,2,3,axpt(nCol,nRow,1:2,1:2,[0.15 0.1 0.85 0.85],midInterval),wideInterval));
pLight(3) = patch([0 10 10 0],[0 0 yLimPN(3) yLimPN(3)],colorLLightBlue);
hold on;
hBarDRwPN(3) = bar(xpt,m_DRwPN_no_pethTrack,'histc');
errorbarJun(xpt+1,m_DRwPN_no_pethTrack,sem_DRwPN_no_pethTrack,1,0.4,colorDarkGray);
text(75, yLimPN(3)*0.8,['n = ',num2str(n_DRwPN_no_pethTrack)],'fontSize',fontM);
xlabel('Time (ms)','fontSize',fontM);
ylabel('Rate (Hz)','fontSize',fontM);
% title('PN: no response','fontSize',fontM,'fontWeight','bold');

set(hBarDRwPN,'FaceColor',colorBlack,'EdgeColor','none');
set(hPlotRwPN,'Box','off','TickDir','out','XLim',[-20,100],'XTick',[-20,0,10,100],'fontSize',fontM)
set(hPlotRwPN(1),'YLim',[0, yLimPN(1)]);
set(hPlotRwPN(2),'YLim',[0, yLimPN(2)]);
set(hPlotRwPN(3),'YLim',[0, yLimPN(3)]);
set(hPlotRwPN,'TickLength',[0.03 0.03]);

set(pLight,'LineStyle','none');
%% neural trace
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Raw data
spikePsdPreD = cell2mat(T.spikePsdPreD);
spikePsdStmD = cell2mat(T.spikePsdStmD);
spikePsdPostD = cell2mat(T.spikePsdPostD);

spikeActPre_PN = spikePsdPreD(Rw_PN_act,:);
spikeInaPre_PN = spikePsdPreD(Rw_PN_ina,:);
spikeNorespPre_PN = spikePsdPreD(Rw_PN_no,:);

spikeActStm_PN = spikePsdStmD(Rw_PN_act,:);
spikeInaStm_PN = spikePsdStmD(Rw_PN_ina,:);
spikeNorespStm_PN = spikePsdStmD(Rw_PN_no,:);

[nAct, ~] = size(spikeActPre_PN);
[nIna, ~] = size(spikeInaPre_PN);
[nNoresp, ~] = size(spikeNorespPre_PN);

% Smoothed data --> normalized --> spike sum / spike norm
[spikeSmthActPre_Rw, spikeSmthInaPre_Rw, spikeSmthNorespPre_Rw, spikeSmthActStm_Rw, spikeSmthInaStm_Rw, spikeSmthNorespStm_Rw] = deal([]);
winWidth = 5;
for iCell = 1:nAct
    spikeSmthActPre_Rw(iCell,:) = smooth(spikeActPre_PN(iCell,:),winWidth);
    spikeSmthActStm_Rw(iCell,:) = smooth(spikeActStm_PN(iCell,:),winWidth);
end
for iCell = 1:nIna
    spikeSmthInaPre_Rw(iCell,:) = smooth(spikeInaPre_PN(iCell,:),winWidth);
    spikeSmthInaStm_Rw(iCell,:) = smooth(spikeInaStm_PN(iCell,:),winWidth);
end
for iCell = 1:nNoresp
    spikeSmthNorespPre_Rw(iCell,:) = smooth(spikeNorespPre_PN(iCell,:),winWidth);
    spikeSmthNorespStm_Rw(iCell,:) = smooth(spikeNorespStm_PN(iCell,:),winWidth);
end

spikeSmthActPre_Rw = spikeSmthActPre_Rw(:,3:end-2);
spikeSmthInaPre_Rw = spikeSmthInaPre_Rw(:,3:end-2);
spikeSmthNorespPre_Rw = spikeSmthNorespPre_Rw(:,3:end-2);

spikeSmthActStm_Rw = spikeSmthActStm_Rw(:,3:end-2);
spikeSmthInaStm_Rw = spikeSmthInaStm_Rw(:,3:end-2);
spikeSmthNorespStm_Rw = spikeSmthNorespStm_Rw(:,3:end-2);

% mean first then normalized
m_spikeActStm = mean(spikeSmthActStm_Rw,1);
m_spikeInaStm = mean(spikeSmthInaStm_Rw,1);
m_spikeNorespStm = mean(spikeSmthNorespStm_Rw,1);

norm_m_spikeActStm = m_spikeActStm./repmat(mean(m_spikeActStm(1:20),2),1,120);
norm_m_spikeInaStm = m_spikeInaStm./repmat(mean(m_spikeInaStm(1:20),2),1,120);
norm_m_spikeNorespStm = m_spikeNorespStm./repmat(mean(m_spikeNorespStm(1:20),2),1,120);

%%
for iBin = 1:120
    pBin_Rw(iBin,1) = ranksum(spikeSmthActPre_Rw(:,iBin), spikeSmthActStm_Rw(:,iBin));
    pBin_Rw(iBin,2) = ranksum(spikeSmthInaPre_Rw(:,iBin), spikeSmthInaStm_Rw(:,iBin));
    [~, pBin_Rw(iBin,3)] = ttest(spikeSmthNorespPre_Rw(:,iBin), spikeSmthNorespStm_Rw(:,iBin));
end

%% CBP test
sigArea_PNact_Rw = [3 17];
sigArea_PNina_Rw = [6 27];
sigArea_PNnoresp_Rw = [9 27];
% sigArea_PNact_Rw = statCBP_v2(spikeSmthActStm_Rw(:,21:60),spikeSmthActPre_Rw(:,21:60));
% sigArea_PNina_Rw = statCBP_v2(spikeSmthInaStm_Rw(:,21:60),spikeSmthInaPre_Rw(:,21:60));
% sigArea_PNnoresp_Rw = statCBP_v2(spikeSmthNorespStm_Rw(:,21:60),spikeSmthNorespPre_Rw(:,21:60));
% sigArea_PNact = statCBP_v2(spikeSmthActStm_Rw);
% sigArea_PNina = statCBP_v2(spikeSmthInaStm_Rw);
% sigArea_PNnoresp = statCBP_v2(spikeSmthNorespStm_Rw);
%%
xpt = -20:99;

hPlotTrace(2) = axes('Position',axpt(2,4,2,4,axpt(nCol,nRow,1:2,1:2,[0.15 0.1 0.85 0.85],midInterval),(wideInterval-[0,0.07])));
plot(xpt,norm_m_spikeActStm,'-o','color',colorRed,'MarkerFaceColor',colorDarkRed,'markerSize',markerSS,'LineWidth',lineM);
hold on;
plot(xpt,norm_m_spikeInaStm,'-o','color',colorBlue,'MarkerFaceColor',colorDarkBlue,'markerSize',markerSS,'LineWidth',lineM);
hold on;
plot(xpt,norm_m_spikeNorespStm,'-o','color',colorBlack,'MarkerFaceColor',colorDarkGray,'markerSize',markerSS,'LineWidth',lineM);
hold on;
line([sigArea_PNact_Rw(1), sigArea_PNact_Rw(end)],[8.5 8.5],'color',colorRed,'lineWidth', 2, 'lineStyle','-');
hold on;
line([sigArea_PNina_Rw(1), sigArea_PNina_Rw(end)],[-1.5,-1.5],'color',colorBlue,'lineWidth', 2, 'lineStyle','-');
hold on;
line([sigArea_PNnoresp_Rw(1), sigArea_PNnoresp_Rw(end)],[-2.5,-2.5],'color',colorDarkGray,'lineWidth', 2, 'lineStyle','-');
set(hPlotTrace(2),'Box','off','TickDIr','out','XLim',[-20,100],'XTick',[-20:20:40,100],'YLim',[-4, 10],'fontSize',fontM);
set(hPlotTrace(2),'TickLength',[0.03 0.03]);
text(30, 6, ['Aactivated (n = ',num2str(nAct),')'],'color',colorRed,'fontSize',fontM);
text(30, 4.5, ['Inactivated (n = ',num2str(nIna),')'],'color',colorBlue,'fontSize',fontM);
text(30, 3, ['No response (n = ',num2str(nNoresp),')'],'color',colorBlack,'fontSize',fontM);
xlabel('Time (ms)','fontSize',fontM);
ylabel('Normalized mean spike','fontSize',fontM);

%%
% print('-painters','-r300','-dtiff',['f_CellReport_lightPETH_',datestr(now,formatOut),'.tif']);
% print('-painters','-r300','-depsc',['f_CellReport_lightPETH_',datestr(now,formatOut),'.ai']);
% close;