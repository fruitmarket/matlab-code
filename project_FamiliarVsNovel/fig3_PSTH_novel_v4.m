% plot_FN_lightAct
clearvars;

load('D:\Dropbox\Lab_mwjung\P2_Track\myParameters.mat');
formatOut = 'yymmdd';
load('D:\Dropbox\Lab_mwjung\P4_FamiliarNovel\neuronList_novel_190301.mat');
PN = T.neuronType == 'PN';
tt_ca3bc = ((T.mouseID == 'rbp005' & (T.tetrode == 'TT1' | T.tetrode == 'TT5')) | (T.mouseID == 'rbp006' & T.tetrode == 'TT2') | (T.mouseID == 'rbp010' & T.tetrode == 'TT6'));
PN_ca3bc = PN & tt_ca3bc;
PN_ca3a = PN & ~tt_ca3bc;

%%%% spike number %%%%
ca3a_act = PN_ca3a & T.idxLight == 1;
ca3a_inh = PN_ca3a & T.idxLight == -1;
ca3a_non = PN_ca3a & T.idxLight == 0;

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

ca3bc_act = PN_ca3bc &  T.idxLight == 1;
ca3bc_non = PN_ca3bc &  T.idxLight == 0;

n_PN_ca3bc = sum(double(PN_ca3bc));
n_ca3bc_act = sum(double(ca3bc_act));
n_ca3bc_non = sum(double(ca3bc_non));

peth_act = T.peth1stBStm(ca3bc_act);
m_ca3bc_act = mean(cell2mat(peth_act),1);
sem_ca3bc_act = std(cell2mat(peth_act),0,1)/sqrt(n_ca3bc_act);

peth_non = T.peth1stBStm(ca3bc_non);
m_ca3bc_non = mean(cell2mat(peth_non),1);
sem_ca3bc_non = std(cell2mat(peth_non),0,1)/sqrt(n_ca3bc_non);

% neural trace
spikeBPreDist = cell2mat(T.spikeBPreD);
spikePreCa3aAct = spikeBPreDist(ca3a_act,:);
spikePreCa3aInh = spikeBPreDist(ca3a_inh,:);
spikePreCa3aNon = spikeBPreDist(ca3a_non,:);
spikePreCa3bcAct = spikeBPreDist(ca3bc_act,:);
spikePreCa3bcNon = spikeBPreDist(ca3bc_non,:);

spikeBStimDist = cell2mat(T.spikeBStimD);
spikeStimCa3aAct = spikeBStimDist(ca3a_act,:);
spikeStimCa3aInh = spikeBStimDist(ca3a_inh,:);
spikeStimCa3aNon = spikeBStimDist(ca3a_non,:);
spikeStimCa3bcAct = spikeBStimDist(ca3bc_act,:);
spikeStimCa3bcNon = spikeBStimDist(ca3bc_non,:);

[spikeSmthStimCa3aAct, spikeSmthStimCa3aInh, spikeSmthStimCa3aNon, spikeSmthStimCa3bcAct, spikeSmthStimCa3bcNon] = deal([]);
[spikeSmthPreCa3aAct, spikeSmthPreCa3aInh, spikeSmthPreCa3aNon, spikeSmthPreCa3bcAct, spikeSmthPreCa3bcNon] = deal([]);

winWidth = 5;
for iCell = 1:n_ca3a_act
    spikeSmthStimCa3aAct(iCell,:) = smooth(spikeStimCa3aAct(iCell,:),winWidth);
    spikeSmthPreCa3aAct(iCell,:) = smooth(spikePreCa3aAct(iCell,:),winWidth);
end
for iCell = 1:n_ca3a_inh
    spikeSmthStimCa3aInh(iCell,:) = smooth(spikeStimCa3aInh(iCell,:),winWidth);
    spikeSmthPreCa3aInh(iCell,:) = smooth(spikePreCa3aInh(iCell,:),winWidth);
end
for iCell = 1:n_ca3a_non
    spikeSmthStimCa3aNon(iCell,:) = smooth(spikeStimCa3aNon(iCell,:),winWidth);
    spikeSmthPreCa3aNon(iCell,:) = smooth(spikePreCa3aNon(iCell,:),winWidth);
end
for iCell = 1:n_ca3bc_act
    spikeSmthStimCa3bcAct(iCell,:) = smooth(spikeStimCa3bcAct(iCell,:),winWidth);
    spikeSmthPreCa3bcAct(iCell,:) = smooth(spikePreCa3bcAct(iCell,:),winWidth);
end
for iCell = 1:n_ca3bc_non
    spikeSmthStimCa3bcNon(iCell,:) = smooth(spikeStimCa3bcNon(iCell,:),winWidth);
    spikeSmthPreCa3bcNon(iCell,:) = smooth(spikePreCa3bcNon(iCell,:),winWidth);
end

spikeSmthPreCa3aAct = spikeSmthPreCa3aAct(:,3:end-2);
spikeSmthPreCa3aInh = spikeSmthPreCa3aInh(:,3:end-2);
spikeSmthPreCa3aNon = spikeSmthPreCa3aNon(:,3:end-2);
spikeSmthPreCa3bcAct = spikeSmthPreCa3bcAct(:,3:end-2);
spikeSmthPreCa3bcNon = spikeSmthPreCa3bcNon(:,3:end-2);

spikeSmthStimCa3aAct = spikeSmthStimCa3aAct(:,3:end-2);
spikeSmthStimCa3aInh = spikeSmthStimCa3aInh(:,3:end-2);
spikeSmthStimCa3aNon = spikeSmthStimCa3aNon(:,3:end-2);
spikeSmthStimCa3bcAct = spikeSmthStimCa3bcAct(:,3:end-2);
spikeSmthStimCa3bcNon = spikeSmthStimCa3bcNon(:,3:end-2);

% mean first then normalized
m_spikeCa3aAct = mean(spikeSmthStimCa3aAct,1);
m_spikeCa3aInh = mean(spikeSmthStimCa3aInh,1);
m_spikeCa3aNon = mean(spikeSmthStimCa3aNon,1);
m_spikeCa3bcAct = mean(spikeSmthStimCa3bcAct,1);
m_spikeCa3bcNon = mean(spikeSmthStimCa3bcNon,1);

norm_m_ca3aAct = m_spikeCa3aAct./repmat(mean(m_spikeCa3aAct(1:20),2),1,120); % baseline[-20,0] normalization
norm_m_ca3aInh = m_spikeCa3aInh./repmat(mean(m_spikeCa3aInh(1:20),2),1,120);
norm_m_ca3aNon = m_spikeCa3aNon./repmat(mean(m_spikeCa3aNon(1:20),2),1,120);
norm_m_ca3bcAct = m_spikeCa3bcAct./repmat(mean(m_spikeCa3bcAct(1:20),2),1,120);
norm_m_ca3bcNon = m_spikeCa3bcNon./repmat(mean(m_spikeCa3bcNon(1:20),2),1,120);

% CBP test
% sigArea_ca3aAct = sort(statCBP_v3(spikeSmthStimCa3aAct,spikeSmthPreCa3aAct));
% sigArea_ca3aInh = sort(statCBP_v3(spikeSmthStimCa3aInh,spikeSmthPreCa3aInh));
% sigArea_ca3aNon = statCBP_v3(spikeSmthStimCa3aNon,spikeSmthPreCa3aNon);
% sigArea_ca3bcAct = statCBP_v3(spikeSmthStimCa3bcAct,spikeSmthPreCa3bcAct);
% sigArea_ca3bcNon = statCBP_v3(spikeSmthStimCa3bcNon,spikeSmthPreCa3bcNon);
sigArea_ca3aAct = [2:19,23:34,37:55,61:76];
sigArea_ca3aInh = [11:44,49:88];
sigArea_ca3aNon = [53:63,72:86];
sigArea_ca3bcAct = [0,0];
sigArea_ca3bcNon = [0,0];

%% plot_Track
nCol = 2;
nRow = 6;
eBarWidth = 0.5;
spaceFig = [0.12 0.2 0.80 0.75];
wideInterval = [0.25 0.11];

fHandle = figure('PaperUnits','centimeters','PaperPosition',[0 0 12 15]);
yLim = [40, 7, 5];

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
    
%% neural distance
xptTrace = -20:99;
hPlot(6) = axes('Position',axpt(nCol,nRow,1,4:5,spaceFig,wideInterval));
plot(xptTrace,norm_m_ca3aAct,'-o','color',colorRed,'MarkerFaceColor',colorDarkRed,'markerSize',markerSS,'LineWidth',lineM);
hold on;
plot(xptTrace,norm_m_ca3aInh,'-o','color',colorBlue,'MarkerFaceColor',colorDarkBlue,'markerSize',markerSS,'LineWidth',lineM);
hold on;
plot(xptTrace,norm_m_ca3aNon,'-o','color',colorBlack,'MarkerFaceColor',colorDarkGray,'markerSize',markerSS,'LineWidth',lineM);
hold on
line([2,19],[35,35],'color',colorRed,'lineWidth', 2, 'lineStyle','-');
hold on;
line([23,34],[35,35],'color',colorRed,'lineWidth', 2, 'lineStyle','-');
hold on;
line([37,55],[35,35],'color',colorRed,'lineWidth', 2, 'lineStyle','-');
hold on;
line([61,76],[35,35],'color',colorRed,'lineWidth', 2, 'lineStyle','-');
hold on;
line([11,44],[32,32],'color',colorBlue,'lineWidth', 2, 'lineStyle','-');
hold on;
line([49,88],[32,32],'color',colorBlue,'lineWidth', 2, 'lineStyle','-');
hold on;
line([53,63],[29,29],'color',colorDarkGray,'lineWidth', 2, 'lineStyle','-');
hold on;
line([72,86],[29,29],'color',colorDarkGray,'lineWidth', 2, 'lineStyle','-');
xlabel('Time (ms)','fontSize',fontM);
ylabel('Normalized mean spike','fontSize',fontM);

hPlot(7) = axes('Position',axpt(nCol,nRow,2,4:5,spaceFig,wideInterval));
plot(xptTrace,norm_m_ca3bcAct,'-o','color',colorRed,'MarkerFaceColor',colorDarkRed,'markerSize',markerSS,'LineWidth',lineM);
hold on;
plot(xptTrace,norm_m_ca3bcNon,'-o','color',colorBlack,'MarkerFaceColor',colorDarkGray,'markerSize',markerSS,'LineWidth',lineM);

xlabel('Time (ms)','fontSize',fontM);
ylabel('Normalized mean spike','fontSize',fontM);

set(hBar,'faceColor',colorDarkGray);
set(hPlot(4),'YLim',[0 yLim_bc(1)],'YTick',[0:50:yLim_bc(1)]);
set(hPlot(5),'YLim',[0 yLim_bc(2)]);
set(hPlot(6),'YLim',[0 40]);
set(hPlot(7),'YLim',[0 80],'YTick',[0:20:80]);
set(hPlot,'Box','off','TickDir','out','XLim',[-20 100],'XTick',[-20,0:20:100],'fontSize',fontM);

print('-painters','-r300','-dtiff',['fig3_PSTH_novel_v4_',datestr(now,formatOut),'.tif']);
print('-painters','-r300','-depsc',['fig3_PSTH_novel_v4_',datestr(now,formatOut),'.ai']);
close all;