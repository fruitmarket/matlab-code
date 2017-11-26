% Latency of neurons which are activated on the platform. (Blue)
% Among neurons which are activated on the platform, latency of neurons which are also activated on the track

% common part
clearvars;

cd('D:\Dropbox\SNL\P2_Track'); % win version
% cd('/Users/Jun/Dropbox/SNL/P2_Track'); % mac version
Txls = readtable('neuronList_ori_171018.xlsx');
load('neuronList_ori_171018.mat');
load myParameters.mat;
Txls.latencyIndex = categorical(Txls.latencyIndex);
formatOut = 'yymmdd';

% DRunPN = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
DRunPN = T.taskType == 'DRun' & T.idxNeurontype == 'PN';
DRunIN = T.taskType == 'DRun' & T.idxNeurontype == 'IN';
DRunUNC = T.taskType == 'DRun' & T.idxNeurontype == 'UNC';

% total population (DRwPN / DRwIN / DRwPN / DRwIN) with light responsiveness (light activated)
PN_act = DRunPN & T.idxpLR_Track & T.statDir_TrackN == 1;
PN_ina = DRunPN & T.idxpLR_Track & T.statDir_TrackN == -1;
PN_no = DRunPN & ~T.idxpLR_Track;

PN_actDirect = DRunPN & Txls.latencyIndex == 'direct';
PN_actIndirect = DRunPN & Txls.latencyIndex == 'indirect';
PN_actDouble = DRunPN & Txls.latencyIndex == 'double';

IN_act = DRunIN & T.idxpLR_Track & T.statDir_TrackN == 1;
IN_actDirect = DRunIN & T.idxpLR_Track & T.statDir_TrackN == 1 & Txls.latencyIndex == 'direct';
IN_actIndirect = DRunIN & T.idxpLR_Track & T.statDir_TrackN == 1 & Txls.latencyIndex == 'indirect';
IN_ina = DRunIN & T.idxpLR_Track & T.statDir_TrackN == -1;
IN_no = DRunIN & ~T.idxpLR_Track;

%% PETH
DRunPN_act_pethTrack = T.pethTrackLight(PN_act,:);
DRunPN_actRapid_pethTrack = T.pethTrackLight(PN_actDirect,:);
DRunPN_actDelay_pethTrack = T.pethTrackLight(PN_actIndirect,:);
DRunPN_actDouble_pethTrack = T.pethTrackLight(PN_actDouble,:);
DRunPN_ina_pethTrack = T.pethTrackLight(PN_ina,:);
DRunPN_no_pethTrack = T.pethTrackLight(PN_no,:);

DRunIN_act_pethTrack = T.pethTrackLight(IN_act,:);
DRunIN_actRapid_pethTrack = T.pethTrackLight(IN_actDirect,:);
DRunIN_actDelay_pethTrack = T.pethTrackLight(IN_actIndirect,:);
DRunIN_ina_pethTrack = T.pethTrackLight(IN_ina,:);
DRunIN_no_pethTrack = T.pethTrackLight(IN_no,:);

%% Mean & Sem
n_DRunPN_act_pethTrack = size(DRunPN_act_pethTrack,1);
m_DRunPN_act_pethTrack = mean(DRunPN_act_pethTrack,1);
sem_DRunPN_act_pethTrack = std(DRunPN_act_pethTrack,1)/sqrt(n_DRunPN_act_pethTrack);

n_DRunPN_actRapid_pethTrack = size(DRunPN_actRapid_pethTrack,1);
m_DRunPN_actRapid_pethTrack = mean(DRunPN_actRapid_pethTrack,1);
sem_DRunPN_actRapid_pethTrack = std(DRunPN_actRapid_pethTrack,1)/sqrt(n_DRunPN_actRapid_pethTrack);

n_DRunPN_actDelay_pethTrack = size(DRunPN_actDelay_pethTrack,1);
m_DRunPN_actDelay_pethTrack = mean(DRunPN_actDelay_pethTrack,1);
sem_DRunPN_actDelay_pethTrack = std(DRunPN_actDelay_pethTrack,1)/sqrt(n_DRunPN_actDelay_pethTrack);

n_DRunPN_actDouble_pethTrack = size(DRunPN_actDouble_pethTrack,1);
m_DRunPN_actDouble_pethTrack = mean(DRunPN_actDouble_pethTrack,1);
sem_DRunPN_actDouble_pethTrack = std(DRunPN_actDouble_pethTrack,1)/sqrt(n_DRunPN_actDouble_pethTrack);

n_DRunPN_ina_pethTrack = size(DRunPN_ina_pethTrack,1);
m_DRunPN_ina_pethTrack = mean(DRunPN_ina_pethTrack,1);
sem_DRunPN_ina_pethTrack = std(DRunPN_ina_pethTrack,1)/sqrt(n_DRunPN_ina_pethTrack);

n_DRunPN_no_pethTrack = size(DRunPN_no_pethTrack,1);
m_DRunPN_no_pethTrack = mean(DRunPN_no_pethTrack,1);
sem_DRunPN_no_pethTrack = std(DRunPN_no_pethTrack,1)/sqrt(n_DRunPN_no_pethTrack);

n_DRunIN_act_pethTrack = size(DRunIN_act_pethTrack,1);
m_DRunIN_act_pethTrack = mean(DRunIN_act_pethTrack,1);
sem_DRunIN_act_pethTrack = std(DRunIN_act_pethTrack,1)/sqrt(n_DRunIN_act_pethTrack);

n_DRunIN_actRapid_pethTrack = size(DRunIN_actRapid_pethTrack,1);
m_DRunIN_actRapid_pethTrack = mean(DRunIN_actRapid_pethTrack,1);
sem_DRunIN_actRapid_pethTrack = std(DRunIN_actRapid_pethTrack,1)/sqrt(n_DRunIN_actRapid_pethTrack);

n_DRunIN_actDelay_pethTrack = size(DRunIN_actDelay_pethTrack,1);
m_DRunIN_actDelay_pethTrack = mean(DRunIN_actDelay_pethTrack,1);
sem_DRunIN_actDelay_pethTrack = std(DRunIN_actDelay_pethTrack,1)/sqrt(n_DRunIN_actDelay_pethTrack);

n_DRunIN_ina_pethTrack = size(DRunIN_ina_pethTrack,1);
m_DRunIN_ina_pethTrack = mean(DRunIN_ina_pethTrack,1);
sem_DRunIN_ina_pethTrack = std(DRunIN_ina_pethTrack,1)/sqrt(n_DRunIN_ina_pethTrack);

n_DRunIN_no_pethTrack = size(DRunIN_no_pethTrack,1);
m_DRunIN_no_pethTrack = mean(DRunIN_no_pethTrack,1);
sem_DRunIN_no_pethTrack = std(DRunIN_no_pethTrack,1)/sqrt(n_DRunIN_no_pethTrack);

%%
nCol = 2;
nRow = 3;
wideInterval = wideInterval + [0.04 0.04];
xpt = T.pethtimeTrackLight(2,:);
yMaxDRunPN = max([m_DRunPN_act_pethTrack, m_DRunPN_ina_pethTrack, m_DRunPN_no_pethTrack])*2;
yMaxDRunIN = max([m_DRunIN_act_pethTrack, m_DRunIN_ina_pethTrack, m_DRunIN_no_pethTrack])*1.5;

yLimPN = [30 25 10];
yLimIN = [200, 60];

fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});
% activated total
hPlotDRunPN(1) = axes('Position',axpt(2,4,1,1,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
bar(5,yLimPN(1),'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yLimPN(1)*0.925,10,yLimPN(1)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRunPN(1) = bar(xpt,m_DRunPN_act_pethTrack,'histc');
errorbarJun(xpt+1,m_DRunPN_act_pethTrack,sem_DRunPN_act_pethTrack,1,0.4,colorDarkGray);
text(80, yLimPN(1)*0.8,['n = ',num2str(n_DRunPN_act_pethTrack)],'fontSize',fontS);
xlabel('Time (ms)','fontSize',fontS);
ylabel('Spikes/bin','fontSize',fontS);
title('PN: Total activated','fontSize',fontS,'fontWeight','bold');

% inactivated
hPlotDRunPN(2) = axes('Position',axpt(2,4,1,2,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
bar(5,yLimPN(2),'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yLimPN(2)*0.925,10,yLimPN(2)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRunPN(2) = bar(xpt,m_DRunPN_ina_pethTrack,'histc');
errorbarJun(xpt+1,m_DRunPN_ina_pethTrack,sem_DRunPN_ina_pethTrack,1,0.4,colorDarkGray);
text(80, yLimPN(2)*0.8,['n = ',num2str(n_DRunPN_ina_pethTrack)],'fontSize',fontS);
xlabel('Time (ms)','fontSize',fontS);
ylabel('Spikes/bin','fontSize',fontS);
title('PN: inactivated','fontSize',fontS,'fontWeight','bold');

% no response
hPlotDRunPN(3) = axes('Position',axpt(2,4,1,3,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
bar(5,yLimPN(3),'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yLimPN(3)*0.925,10,yLimPN(3)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRunPN(3) = bar(xpt,m_DRunPN_no_pethTrack,'histc');
errorbarJun(xpt+1,m_DRunPN_no_pethTrack,sem_DRunPN_no_pethTrack,1,0.4,colorDarkGray);
text(80, yLimPN(3)*0.8,['n = ',num2str(n_DRunPN_no_pethTrack)],'fontSize',fontS);
xlabel('Time (ms)','fontSize',fontS);
ylabel('Spikes/bin','fontSize',fontS);
title('PN: no response','fontSize',fontS,'fontWeight','bold');

%% Interneuron
hPlotDRunIN(1) = axes('Position',axpt(2,4,2,1,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
bar(5,yLimIN(1),'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yLimIN(1)*0.925,10,yLimIN(1)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRunIN(1) = bar(xpt,m_DRunIN_act_pethTrack,'histc');
errorbarJun(xpt+1,m_DRunIN_act_pethTrack,sem_DRunIN_act_pethTrack,1,0.4,colorDarkGray);
text(80, yLimIN(1)*0.8,['n = ',num2str(n_DRunIN_act_pethTrack)],'fontSize',fontS);
xlabel('Time (ms)','fontSize',fontS);
ylabel('Spikes/bin','fontSize',fontS);
title('IN: Total activated','fontSize',fontS,'fontWeight','bold');

hPlotDRunIN(2) = axes('Position',axpt(2,4,2,2,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
bar(5,yLimIN(2),'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yLimIN(2)*0.925,10,yLimIN(2)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRunIN(2) = bar(xpt,m_DRunIN_ina_pethTrack,'histc');
errorbarJun(xpt+1,m_DRunIN_ina_pethTrack,sem_DRunIN_ina_pethTrack,1,0.4,colorDarkGray);
text(80, yLimIN(2)*0.8,['n = ',num2str(n_DRunIN_ina_pethTrack)],'fontSize',fontS);
xlabel('Time (ms)','fontSize',fontS);
ylabel('Spikes/bin','fontSize',fontS);
title('IN: inactivated','fontSize',fontS,'fontWeight','bold');

hPlotDRunIN(3) = axes('Position',axpt(2,4,2,3,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
bar(5,yLimIN(2),'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yLimIN(2)*0.925,10,yLimIN(2)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarDRunIN(3) = bar(xpt,m_DRunIN_no_pethTrack,'histc');
errorbarJun(xpt+1,m_DRunIN_no_pethTrack,sem_DRunIN_no_pethTrack,1,0.4,colorDarkGray);
text(80, yLimIN(2)*0.8,['n = ',num2str(n_DRunIN_no_pethTrack)],'fontSize',fontS);
xlabel('Time (ms)','fontSize',fontS);
ylabel('Spikes/bin','fontSize',fontS);
title('IN: no response','fontSize',fontS,'fontWeight','bold');

set(hBarDRunPN,'FaceColor',colorBlack,'EdgeColor','none');
set(hBarDRunIN,'FaceColor',colorBlack,'EdgeColor','none');
set(hPlotDRunPN,'Box','off','TickDir','out','XLim',[-20,100],'XTick',[-20,0,10,100],'fontSize',fontS)
set(hPlotDRunPN(1),'YLim',[0, yLimPN(1)]);
set(hPlotDRunPN(2),'YLim',[0, yLimPN(2)]);
set(hPlotDRunPN(3),'YLim',[0, yLimPN(3)]);

set(hPlotDRunIN(1),'Box','off','TickDir','out','XLim',[-20 100],'XTick',[-20,0,10,100],'YLim',[0, yLimIN(1)],'fontSize',fontS);
set(hPlotDRunIN(2:3),'Box','off','TickDir','out','XLim',[-20 100],'XTick',[-20,0,10,100],'YLim',[0, yLimIN(2)],'fontSize',fontS);

%% neural trace
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DRun_PN_total = T.taskType == 'DRun' & T.idxNeurontype == 'PN';
DRun_PN_resp = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxpLR_Track;
DRun_PN_act = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxpLR_Track & T.statDir_TrackN == 1;
DRun_PN_ina = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxpLR_Track & T.statDir_TrackN == -1;
DRun_PN_noresp = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & ~T.idxpLR_Track;

% Raw data
spikePsdPreD = cell2mat(T.spikePsdPreD);
spikePsdStmD = cell2mat(T.spikePsdStmD);
spikePsdPostD = cell2mat(T.spikePsdPostD);

spikeTotalPre_PN = spikePsdPreD(DRun_PN_total,:);
spikeRespPre_PN = spikePsdPreD(DRun_PN_resp,:);
spikeActPre_PN = spikePsdPreD(DRun_PN_act,:);
spikeInaPre_PN = spikePsdPreD(DRun_PN_ina,:);
spikeNorespPre_PN = spikePsdPreD(DRun_PN_noresp,:);

spikeTotalStm_PN = spikePsdStmD(DRun_PN_total,:);
spikeRespStm_PN = spikePsdStmD(DRun_PN_resp,:);
spikeActStm_PN = spikePsdStmD(DRun_PN_act,:);
spikeInaStm_PN = spikePsdStmD(DRun_PN_ina,:);
spikeNorespStm_PN = spikePsdStmD(DRun_PN_noresp,:);

[nTotal, nBin] = size(spikeTotalPre_PN);
[nResp, ~] = size(spikeRespPre_PN);
[nAct, ~] = size(spikeActPre_PN);
[nIna, ~] = size(spikeInaPre_PN);
[nNoresp, ~] = size(spikeNorespPre_PN);

% Smoothed data --> normalized --> spike sum / spike norm
[spikeSmthTotalPre, spikeSmthRespPre, spikeSmthActPre, spikeSmthInaPre, spikeSmthNorespPre, spikeSmthTotalStm, spikeSmthRespStm, spikeSmthActStm, spikeSmthInaStm, spikeSmthNorespStm] = deal([]);
winWidth = 5;
for iCell = 1:nTotal
    spikeSmthTotalPre(iCell,:) = smooth(spikeTotalPre_PN(iCell,:),winWidth);
    spikeSmthTotalStm(iCell,:) = smooth(spikeTotalStm_PN(iCell,:),winWidth);
end
for iCell = 1:nResp
    spikeSmthRespPre(iCell,:) = smooth(spikeRespPre_PN(iCell,:),winWidth);
    spikeSmthRespStm(iCell,:) = smooth(spikeRespStm_PN(iCell,:),winWidth);
end
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

spikeSmthTotalPre = spikeSmthTotalPre(:,3:end-2);
spikeSmthRespPre = spikeSmthRespPre(:,3:end-2);
spikeSmthActPre = spikeSmthActPre(:,3:end-2);
spikeSmthInaPre = spikeSmthInaPre(:,3:end-2);
spikeSmthNorespPre = spikeSmthNorespPre(:,3:end-2);

spikeSmthTotalStm = spikeSmthTotalStm(:,3:end-2);
spikeSmthRespStm = spikeSmthRespStm(:,3:end-2);
spikeSmthActStm = spikeSmthActStm(:,3:end-2);
spikeSmthInaStm = spikeSmthInaStm(:,3:end-2);
spikeSmthNorespStm = spikeSmthNorespStm(:,3:end-2);

% mean first then normalized
m_spikeTotalStm = mean(spikeSmthTotalStm,1);
m_spikeRespStm = mean(spikeSmthRespStm,1);
m_spikeActStm = mean(spikeSmthActStm,1);
m_spikeInaStm = mean(spikeSmthInaStm,1);
m_spikeNorespStm = mean(spikeSmthNorespStm,1);

norm_m_spikeTotalStm = m_spikeTotalStm./repmat(mean(m_spikeTotalStm(1:20),2),1,120);
norm_m_spikeRespStm = m_spikeRespStm./repmat(mean(m_spikeRespStm(1:20),2),1,120);
norm_m_spikeActStm = m_spikeActStm./repmat(mean(m_spikeActStm(1:20),2),1,120);
norm_m_spikeInaStm = m_spikeInaStm./repmat(mean(m_spikeInaStm(1:20),2),1,120);
norm_m_spikeNorespStm = m_spikeNorespStm./repmat(mean(m_spikeNorespStm(1:20),2),1,120);

%% CBP test
% norm_spikeSmthAct = spikeSmthActStm/mean(m_spikeActStm(1:20),2);
% norm_spikeSmthIna = spikeSmthInaStm/mean(m_spikeInaStm(1:20),2);
% norm_spikeSmthNoresp = spikeSmthNorespStm/mean(m_spikeNorespStm(1:20),2);
% save('neuralTraceDRun_171016.mat','norm_spikeSmthAct','norm_spikeSmthIna','norm_spikeSmthNoresp')

sigArea_PNact = statCBP_v2(spikeSmthActStm,spikeSmthActPre);
sigArea_PNina = statCBP_v2(spikeSmthInaStm,spikeSmthInaPre);
sigArea_PNnoresp = statCBP_v2(spikeSmthNorespStm,spikeSmthNorespPre);

%%
xpt = -20:99;
yLim = max([norm_m_spikeTotalStm, norm_m_spikeRespStm, norm_m_spikeActStm, norm_m_spikeInaStm, norm_m_spikeNorespStm])*1.2;

hPlotTrace(1) = axes('Position',axpt(2,4,1,4,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
% plot(xpt,norm_m_spikeTotalStm,'-o','color',colorGray,'MarkerFaceColor',colorDarkGray,'markerSize',markerSS,'LineWidth',lineM);
% hold on;
% plot(xpt,norm_m_spikeRespStm,'-o','color',colorGreen,'MarkerFaceColor',colorDarkGreen,'markerSize',markerSS,'LineWidth',lineM);
% hold on;
plot(xpt,norm_m_spikeActStm,'-o','color',colorBlue,'MarkerFaceColor',colorDarkBlue,'markerSize',markerSS,'LineWidth',lineM);
hold on;
plot(xpt,norm_m_spikeInaStm,'-o','color',colorRed,'MarkerFaceColor',colorDarkRed,'markerSize',markerSS,'LineWidth',lineM);
hold on;
plot(xpt,norm_m_spikeNorespStm,'-o','color',colorBlack,'MarkerFaceColor',colorDarkGray,'markerSize',markerSS,'LineWidth',lineM);
hold on;
line([sigArea_PNact(1), sigArea_PNact(end)],[7.5,7.5],'color',colorBlue,'lineWidth', 2, 'lineStyle','-');
hold on;
line([sigArea_PNina(1), sigArea_PNina(end)],[-2,-2],'color',colorRed,'lineWidth', 2, 'lineStyle','-');
hold on;
line([sigArea_PNnoresp(1), sigArea_PNnoresp(end)],[-3,-3],'color',colorDarkGray,'lineWidth', 2, 'lineStyle','-');
set(hPlotTrace,'Box','off','TickDIr','out','XLim',[-20,100],'XTick',[-20:10:40,100],'YLim',[-4, 8.5],'fontSize',fontS);
% text(30, 6, ['Total (n = ',num2str(nTotal),')'],'color',colorDarkGray,'fontSize',fontS);
% text(30, 5, ['Light modulated (n = ',num2str(nResp),')'],'color',colorGreen,'fontSize',fontS);
text(30, 4, ['Light activated (n = ',num2str(nAct),')'],'color',colorBlue,'fontSize',fontS);
text(30, 3, ['Light inactivated (n = ',num2str(nIna),')'],'color',colorRed,'fontSize',fontS);
text(30, 2, ['No response (n = ',num2str(nNoresp),')'],'color',colorBlack,'fontSize',fontS);
xlabel('Time (ms)','fontSize',fontS);
ylabel('Normalized mean spike','fontSize',fontS);

%% neural trace (IN)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DRun_IN_total = T.taskType == 'DRun' & T.idxNeurontype == 'IN';
DRun_IN_resp = T.taskType == 'DRun' & T.idxNeurontype == 'IN' & T.idxpLR_Track;
DRun_IN_act = T.taskType == 'DRun' & T.idxNeurontype == 'IN' & T.idxpLR_Track & T.statDir_TrackN == 1;
DRun_IN_ina = T.taskType == 'DRun' & T.idxNeurontype == 'IN' & T.idxpLR_Track & T.statDir_TrackN == -1;
DRun_IN_noresp = T.taskType == 'DRun' & T.idxNeurontype == 'IN' & ~T.idxpLR_Track;

% Raw data
spikePsdPreD = cell2mat(T.spikePsdPreD);
spikePsdStmD = cell2mat(T.spikePsdStmD);
spikePsdPostD = cell2mat(T.spikePsdPostD);

spikeTotalPre_IN = spikePsdPreD(DRun_IN_total,:);
spikeRespPre_IN = spikePsdPreD(DRun_IN_resp,:);
spikeActPre_IN = spikePsdPreD(DRun_IN_act,:);
spikeInaPre_IN = spikePsdPreD(DRun_IN_ina,:);
spikeNorespPre_IN = spikePsdPreD(DRun_IN_noresp,:);

spikeTotalStm_IN = spikePsdStmD(DRun_IN_total,:);
spikeRespStm_IN = spikePsdStmD(DRun_IN_resp,:);
spikeActStm_IN = spikePsdStmD(DRun_IN_act,:);
spikeInaStm_IN = spikePsdStmD(DRun_IN_ina,:);
spikeNorespStm_IN = spikePsdStmD(DRun_IN_noresp,:);

[nTotal, nBin] = size(spikeTotalPre_IN);
[nResp, ~] = size(spikeRespPre_IN);
[nAct, ~] = size(spikeActPre_IN);
[nIna, ~] = size(spikeInaPre_IN);
[nNoresp, ~] = size(spikeNorespPre_IN);

% Smoothed data --> normalized --> spike sum / spike norm
[spikeSmthTotalPre, spikeSmthRespPre, spikeSmthActPre, spikeSmthInaPre, spikeSmthNorespPre, spikeSmthTotalStm, spikeSmthRespStm, spikeSmthActStm, spikeSmthInaStm, spikeSmthNorespStm] = deal([]);
winWidth = 5;
for iCell = 1:nTotal
    spikeSmthTotalPre(iCell,:) = smooth(spikeTotalPre_IN(iCell,:),winWidth);
    spikeSmthTotalStm(iCell,:) = smooth(spikeTotalStm_IN(iCell,:),winWidth);
end
for iCell = 1:nResp
    spikeSmthRespPre(iCell,:) = smooth(spikeRespPre_IN(iCell,:),winWidth);
    spikeSmthRespStm(iCell,:) = smooth(spikeRespStm_IN(iCell,:),winWidth);
end
for iCell = 1:nAct
    spikeSmthActPre(iCell,:) = smooth(spikeActPre_IN(iCell,:),winWidth);
    spikeSmthActStm(iCell,:) = smooth(spikeActStm_IN(iCell,:),winWidth);
end
for iCell = 1:nIna
    spikeSmthInaPre(iCell,:) = smooth(spikeInaPre_IN(iCell,:),winWidth);
    spikeSmthInaStm(iCell,:) = smooth(spikeInaStm_IN(iCell,:),winWidth);
end
for iCell = 1:nNoresp
    spikeSmthNorespPre(iCell,:) = smooth(spikeNorespPre_IN(iCell,:),winWidth);
    spikeSmthNorespStm(iCell,:) = smooth(spikeNorespStm_IN(iCell,:),winWidth);
end

spikeSmthTotalPre = spikeSmthTotalPre(:,3:end-2);
spikeSmthRespPre = spikeSmthRespPre(:,3:end-2);
spikeSmthActPre = spikeSmthActPre(:,3:end-2);
spikeSmthInaPre = spikeSmthInaPre(:,3:end-2);
spikeSmthNorespPre = spikeSmthNorespPre(:,3:end-2);

spikeSmthTotalStm = spikeSmthTotalStm(:,3:end-2);
spikeSmthRespStm = spikeSmthRespStm(:,3:end-2);
spikeSmthActStm = spikeSmthActStm(:,3:end-2);
spikeSmthInaStm = spikeSmthInaStm(:,3:end-2);
spikeSmthNorespStm = spikeSmthNorespStm(:,3:end-2);

% mean first then normalized
m_spikeTotalStm = mean(spikeSmthTotalStm,1);
m_spikeRespStm = mean(spikeSmthRespStm,1);
m_spikeActStm = mean(spikeSmthActStm,1);
m_spikeInaStm = mean(spikeSmthInaStm,1);
m_spikeNorespStm = mean(spikeSmthNorespStm,1);

% norm_m_spikeTotalStm = m_spikeTotalStm./repmat(mean(m_spikeTotalStm(1:20),2),1,120);
% norm_m_spikeRespStm = m_spikeRespStm./repmat(mean(m_spikeRespStm(1:20),2),1,120);
% norm_m_spikeActStm = m_spikeActStm./repmat(mean(m_spikeActStm(1:20),2),1,120);
% norm_m_spikeInaStm = m_spikeInaStm./repmat(mean(m_spikeInaStm(1:20),2),1,120);
% norm_m_spikeNorespStm = m_spikeNorespStm./repmat(mean(m_spikeNorespStm(1:20),2),1,120);

%% CBP test
% norm_spikeSmthAct = spikeSmthActStm/mean(m_spikeActStm(1:20),2);
% norm_spikeSmthIna = spikeSmthInaStm/mean(m_spikeInaStm(1:20),2);
% norm_spikeSmthNoresp = spikeSmthNorespStm/mean(m_spikeNorespStm(1:20),2);

sigArea_INact = statCBP_v2(spikeSmthActStm,spikeSmthActPre);
sigArea_INina = statCBP_v2(spikeSmthInaStm,spikeSmthInaPre);
sigArea_INnoresp = statCBP_v2(spikeSmthNorespStm,spikeSmthNorespPre);

xpt = -20:99;
% yLim = max([norm_m_spikeTotal, norm_m_spikeResp, norm_m_spikeAct, norm_m_spikeIna, norm_m_spikeNoresp])*1.2;

hPlotTrace(1) = axes('Position',axpt(2,4,2,4,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],midInterval),wideInterval));
% plot(xpt,norm_m_spikeTotalStm,'-o','color',colorGray,'MarkerFaceColor',colorDarkGray,'markerSize',markerSS,'LineWidth',lineM);
% hold on;
% plot(xpt,norm_m_spikeRespStm,'-o','color',colorGreen,'MarkerFaceColor',colorDarkGreen,'markerSize',markerSS,'LineWidth',lineM);
% hold on;
plot(xpt,norm_m_spikeActStm,'-o','color',colorBlue,'MarkerFaceColor',colorDarkBlue,'markerSize',markerSS,'LineWidth',lineM);
hold on;
plot(xpt,norm_m_spikeInaStm,'-o','color',colorRed,'MarkerFaceColor',colorDarkRed,'markerSize',markerSS,'LineWidth',lineM);
hold on;
plot(xpt,norm_m_spikeNorespStm,'-o','color',colorBlack,'MarkerFaceColor',colorDarkGray,'markerSize',markerSS,'LineWidth',lineM);
hold on;
% line([sigArea_INact(1), sigArea_INact(end)],[7.5,7.5],'color',colorBlue,'lineWidth', 2, 'lineStyle','-');
hold on;
line([sigArea_INina(1), sigArea_INina(end)],[-2,-2],'color',colorRed,'lineWidth', 2, 'lineStyle','-');
hold on;
% line([sigArea_INnoresp(1), sigArea_INnoresp(end)],[-3,-3],'color',colorDarkGray,'lineWidth', 2, 'lineStyle','-');

set(hPlotTrace,'Box','off','TickDIr','out','XLim',[-20,100],'XTick',[-20:10:40,100],'YLim',[-4, 8.5],'fontSize',fontS);
% text(30, 6, ['Total (n = ',num2str(nTotal),')'],'color',colorDarkGray,'fontSize',fontS);
% text(30, 5, ['Light modulated (n = ',num2str(nResp),')'],'color',colorGreen,'fontSize',fontS);
text(30, 4, ['Light activated (n = ',num2str(nAct),')'],'color',colorBlue,'fontSize',fontS);
text(30, 3, ['Light inactivated (n = ',num2str(nIna),')'],'color',colorRed,'fontSize',fontS);
text(30, 2, ['No response (n = ',num2str(nNoresp),')'],'color',colorBlack,'fontSize',fontS);
xlabel('Time (ms)','fontSize',fontS);
ylabel('Normalized mean spike','fontSize',fontS);

print('-painters','-r300','-dtiff',['final_fig4_track_lightPETH_DRun_',datestr(now,formatOut),'.tif']);
print('-painters','-r300','-depsc',['final_fig4_track_lightPETH_DRun_',datestr(now,formatOut),'.ai']);
close;