function f_fig4_neuralTrace_DRw
% Neural distance calculated by mahalanobis distance

% common part
clearvars;
rtDir = 'D:\Dropbox\SNL\P2_Track';
cd(rtDir);

load('D:\Dropbox\SNL\P2_Track\myParameters.mat');
load('neuronList_ori_170819.mat');
Txls = readtable('neuronList_ori_170819.xlsx');
Txls.taskType = categorical(Txls.taskType);
Txls.latencyIndex = categorical(Txls.latencyIndex);
formatOut = 'yymmdd';

% total population (DRwPN / DRwIN / DRwPN / DRwIN) with light responsiveness (light activated)
DRw_PN_total = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
DRw_PN_resp = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track;
DRw_PN_act = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == 1;
DRw_PN_ina = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == -1;
DRw_PN_noresp = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & ~T.idxpLR_Track;
DRw_PN_direct = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == 1 & Txls.latencyIndex == 'direct';
DRw_PN_indirect = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == 1 & Txls.latencyIndex == 'indirect';
DRw_PN_double = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum & T.idxpLR_Track & T.statDir_TrackN == 1 & Txls.latencyIndex == 'double';

% peri = DRw_PN_ina & ~T.idxOverLapLengthSTM;
% center = DRw_PN_ina & T.idxOverLapLengthSTM;
% fileList = T.path(peri);
% cellID = T.cellID(peri);
% plot_Track_multi_v3_lightconfirm(fileList,cellID,'C:\Users\Jun\Desktop\peri');
% fileList = T.path(center);
% cellID = T.cellID(center);
% plot_Track_multi_v3_lightconfirm(fileList,cellID,'C:\Users\Jun\Desktop\center')

% peri = ~logical(T.idxOverLapLengthSTM(DRw_PN_ina)); % index of overlap
% center = logical(T.idxOverLapLengthSTM(DRw_PN_ina)); % index of overlap
%% Raw data
spikePsdPreD = cell2mat(T.spikePsdPreD);
spikePsdStmD = cell2mat(T.spikePsdStmD);
spikePsdPostD = cell2mat(T.spikePsdPostD);


spikeTotal = spikePsdStmD(DRw_PN_total,:);
spikeResp = spikePsdStmD(DRw_PN_resp,:);
spikeAct = spikePsdStmD(DRw_PN_act,:);
spikeIna = spikePsdStmD(DRw_PN_ina,:);
spikeNoresp = spikePsdStmD(DRw_PN_noresp,:);
spikeDirect = spikePsdStmD(DRw_PN_direct,:);
spikeIndirect = spikePsdStmD(DRw_PN_indirect,:);
spikeDouble = spikePsdStmD(DRw_PN_double,:);


[nTotal, nBin] = size(spikeTotal);
[nResp, ~] = size(spikeResp);
[nAct, ~] = size(spikeAct);
[nIna, ~] = size(spikeIna);
[nNoresp, ~] = size(spikeNoresp);
[nDirect, ~] = size(spikeDirect);
[nIndirect, ~] = size(spikeIndirect);
[nDouble, ~] = size(spikeDouble);

%% Smoothed data --> normalized --> spike sum / spike norm
[spikeSmthTotal, spikeSmthResp, spikeSmthAct, spikeSmthIna, spikeSmthNoresp, spikeSmthDirect, spikeSmthIndirect, spikeSmthDouble] = deal([]);
winWidth = 5;
for iCell = 1:nTotal
    spikeSmthTotal(iCell,:) = smooth(spikeTotal(iCell,:),winWidth);
end
for iCell = 1:nResp
    spikeSmthResp(iCell,:) = smooth(spikeResp(iCell,:),winWidth);
end
for iCell = 1:nAct
    spikeSmthAct(iCell,:) = smooth(spikeAct(iCell,:),winWidth);
end
for iCell = 1:nIna
    spikeSmthIna(iCell,:) = smooth(spikeIna(iCell,:),winWidth);
end
for iCell = 1:nNoresp
    spikeSmthNoresp(iCell,:) = smooth(spikeNoresp(iCell,:),winWidth);
end
for iCell = 1:nDirect
    spikeSmthDirect(iCell,:) = smooth(spikeDirect(iCell,:),winWidth);
end
for iCell = 1:nIndirect
    spikeSmthIndirect(iCell,:) = smooth(spikeIndirect(iCell,:),winWidth);
end
for iCell = 1:nDouble
    spikeSmthDouble(iCell,:) = smooth(spikeDouble(iCell,:),winWidth);
end

spikeSmthTotal = spikeSmthTotal(:,3:end-2);
spikeSmthResp = spikeSmthResp(:,3:end-2);
spikeSmthAct = spikeSmthAct(:,3:end-2);
spikeSmthIna = spikeSmthIna(:,3:end-2);
spikeSmthNoresp = spikeSmthNoresp(:,3:end-2);
spikeSmthDirect = spikeSmthDirect(:,3:end-2);
spikeSmthIndirect = spikeSmthIndirect(:,3:end-2);
spikeSmthDouble = spikeSmthDouble(:,3:end-2);

%% mean first then normalized
m_spikeTotal = mean(spikeSmthTotal,1);
m_spikeResp = mean(spikeSmthResp,1);
m_spikeAct = mean(spikeSmthAct,1);
m_spikeIna = mean(spikeSmthIna,1);
m_spikeNoresp = mean(spikeSmthNoresp,1);
m_spikeDirect = mean(spikeSmthDirect,1);
m_spikeIndirect = mean(spikeSmthIndirect,1);
m_spikeDouble = mean(spikeSmthDouble,1);

norm_m_spikeTotal = m_spikeTotal./repmat(mean(m_spikeTotal(:,1:10),2),1,120);
norm_m_spikeResp = m_spikeResp./repmat(mean(m_spikeResp(:,1:10),2),1,120);
norm_m_spikeAct = m_spikeAct./repmat(mean(m_spikeAct(:,1:10),2),1,120);
norm_m_spikeIna = m_spikeIna./repmat(mean(m_spikeIna(:,1:10),2),1,120);
norm_m_spikeNoresp = m_spikeNoresp./repmat(mean(m_spikeNoresp(:,1:10),2),1,120);
norm_m_spikeDirect = m_spikeDirect./repmat(mean(m_spikeDirect(:,1:10),2),1,120);
norm_m_spikeIndirect = m_spikeIndirect./repmat(mean(m_spikeIndirect(:,1:10),2),1,120);
norm_m_spikeDouble = m_spikeDouble./repmat(mean(m_spikeDouble(:,1:10),2),1,120);


%% reference figures
fHandle(1) = figure('PaperUnits','centimeters','PaperPosition',paperSize{2});
nCol = 2;
nRow = 1;
xpt = -10:109;
markerXS = 5;
yLim = max([norm_m_spikeTotal, norm_m_spikeResp, norm_m_spikeAct, norm_m_spikeIna, norm_m_spikeNoresp])*1.2;
%%
hPlot(1) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval),wideInterval));
plot(xpt,norm_m_spikeTotal,'-o','color',colorGray,'MarkerFaceColor',colorDarkGray,'markerSize',markerXS,'LineWidth',lineM);
hold on;
plot(xpt,norm_m_spikeResp,'-o','color',colorGreen,'MarkerFaceColor',colorDarkGreen,'markerSize',markerXS,'LineWidth',lineM);
hold on;
plot(xpt,norm_m_spikeAct,'-o','color',colorBlue,'MarkerFaceColor',colorDarkBlue,'markerSize',markerXS,'LineWidth',lineM);
hold on;
plot(xpt,norm_m_spikeIna,'-o','color',colorRed,'MarkerFaceColor',colorDarkRed,'markerSize',markerXS,'LineWidth',lineM);
hold on;
plot(xpt,norm_m_spikeNoresp,'-o','color',colorBlack,'MarkerFaceColor',colorDarkGray,'markerSize',markerXS,'LineWidth',lineM);
set(hPlot,'Box','off','TickDIr','out','XLim',[-10,110],'XTick',[-10:10:50,110],'YLim',[0, yLim]);
text(40, 6, ['Total (n = ',num2str(nTotal),')'],'color',colorDarkGray,'fontSize',fontL);
text(40, 5.5, ['Light modulated (n = ',num2str(nResp),')'],'color',colorGreen,'fontSize',fontL);
text(40, 5, ['Light activated (n = ',num2str(nAct),')'],'color',colorBlue,'fontSize',fontL);
text(40, 4.5, ['Light inactivated (n = ',num2str(nIna),')'],'color',colorRed,'fontSize',fontL);
text(40, 4, ['No response (n = ',num2str(nNoresp),')'],'color',colorBlack,'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Normalized mean spike','fontSize',fontL);

hPlot(2) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],wideInterval),wideInterval));
plot(xpt,norm_m_spikeDirect,'-o','color',colorBlack,'MarkerFaceColor',[230, 81, 0]./255,'markerSize',markerXS,'LineWidth',lineM);
hold on;
plot(xpt,norm_m_spikeIndirect,'-o','color',colorBlack,'MarkerFaceColor',[104, 159, 56]./255,'markerSize',markerXS,'LineWidth',lineM);
hold on;
plot(xpt,norm_m_spikeDouble,'-o','color',colorBlack,'MarkerFaceColor',[38, 50, 56]./255,'markerSize',markerXS,'LineWidth',lineM);
set(hPlot(2),'Box','off','TickDIr','out','XLim',[-10,110],'XTick',[-10:10:50,110],'YLim',[0, 30]);
text(40,25,['Direct response (n = ',num2str(nDirect),')'],'color',[230, 81, 0]./255,'fontSize',fontL);
text(40,23,['Indirect response (n = ',num2str(nIndirect),')'],'color',[104, 159, 56]./255,'fontSize',fontL);
text(40,21,['Double response (n = ',num2str(nDouble),')'],'color',[38, 50, 56]./255,'fontSize',fontL);
xlabel('Time (ms)','fontSize',fontL);
ylabel('Normalized mean spike','fontSize',fontL);

print('-painters','-r300','-dtiff',['final_fig4_track_neuralTrace_DRw_',datestr(now,formatOut),'.tif']);
close all;
end