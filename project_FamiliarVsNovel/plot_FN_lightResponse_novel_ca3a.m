% plot_FN_lightAct
clearvars;

rtDir = 'E:\Dropbox\Lab_mwjung\P4_FamiliarNovel';
load('E:\Dropbox\Lab_mwjung\P2_Track\myParameters.mat');
formatOut = 'yymmdd';
load('E:\Dropbox\Lab_mwjung\P4_FamiliarNovel\neuronList_novel_190118.mat');
PN = T.neuronType == 'PN';
tt_ca3bc = ((T.mouseID == 'rbp005' & (T.tetrode == 'TT1' | T.tetrode == 'TT5')) | (T.mouseID == 'rbp006' & T.tetrode == 'TT2') | (T.mouseID == 'rbp010' & T.tetrode == 'TT6')); % | (T.mouseID == 'rbp015' & T.tetrode == 'TT7')
PN_ca3bc = PN & tt_ca3bc;
PN_ca3a = PN & ~tt_ca3bc;
PN = PN_ca3a;

%%%% firing rate %%%%
neuron_act = PN & T.idxmFrIn == 1;
neuron_dir = PN & T.idxmFrIn == 1 & T.latencyTrack1st>=4 & T.latencyTrack1st<10 & isnan(T.latencyTrack2nd);
neuron_ind = PN & T.idxmFrIn == 1 & T.latencyTrack1st>=10 & isnan(T.latencyTrack2nd);
neuron_doub = PN & T.idxmFrIn == 1 & ~isnan(T.latencyTrack2nd);
neuron_inh = PN & T.idxmFrIn == -1;
neuron_non = PN & T.idxmFrIn == 0;

%%%% spike number %%%%
% neuron_act = PN & T.idxmSpkIn == 1;
% neuron_dir = PN & T.idxmSpkIn == 1 & T.latencyTrack1st<10 & isnan(T.latencyTrack2nd);
% neuron_ind = PN & T.idxmSpkIn == 1 & T.latencyTrack1st>=10 & isnan(T.latencyTrack2nd);
% neuron_doub = PN & T.idxmSpkIn == 1 & ~isnan(T.latencyTrack2nd);
% neuron_inh = PN & T.idxmSpkIn == -1;
% neuron_non = PN & T.idxmSpkIn == 0;

m_lapFrInPRE = cellfun(@(x) x(2),T.m_lapFrInzone); % PRE lap firing rate inzone
m_lapFrInSTIM = cellfun(@(x) x(3),T.m_lapFrInzone); % PRE lap firing rate inzone
m_lapFrInPOST = cellfun(@(x) x(4),T.m_lapFrInzone); % PRE lap firing rate inzone

% n_pn = sum(double(PN));
n_act = sum(double(neuron_act));
n_dir = sum(double(neuron_dir));
n_ind = sum(double(neuron_ind));
n_doub = sum(double(neuron_doub));
n_inh = sum(double(neuron_inh));
n_non = sum(double(neuron_non));
n_pn = sum([n_dir, n_ind, n_doub, n_inh, n_non]);

xpt = T.pethtime1stBStm(neuron_dir);
xpt = xpt{1};

peth_dir = T.peth1stBStm(neuron_dir);
m_peth_dir = mean(cell2mat(peth_dir),1);
sem_peth_dir = std(cell2mat(peth_dir),0,1)/sqrt(n_dir);

peth_ind = T.peth1stBStm(neuron_ind);
m_peth_ind = mean(cell2mat(peth_ind),1);
sem_peth_ind = std(cell2mat(peth_ind),0,1)/sqrt(n_ind);

peth_doub = T.peth1stBStm(neuron_doub);
m_peth_doub = mean(cell2mat(peth_doub),1);
sem_peth_doub = std(cell2mat(peth_doub),0,1)/sqrt(n_doub);

peth_inh = T.peth1stBStm(neuron_inh);
m_peth_inh = mean(cell2mat(peth_inh),1);
sem_peth_inh = std(cell2mat(peth_inh),0,1)/sqrt(n_inh);

peth_non = T.peth1stBStm(neuron_non);
m_peth_non = mean(cell2mat(peth_non),1);
sem_peth_non = std(cell2mat(peth_non),0,1)/sqrt(n_non);

fr_act = [m_lapFrInPRE(neuron_act), m_lapFrInSTIM(neuron_act), m_lapFrInPOST(neuron_act)];
fr_inh = [m_lapFrInPRE(neuron_inh), m_lapFrInSTIM(neuron_inh), m_lapFrInPOST(neuron_inh)];
fr_non = [m_lapFrInPRE(neuron_non), m_lapFrInSTIM(neuron_non), m_lapFrInPOST(neuron_non)];

m_fr = mean([fr_act; fr_inh; fr_non],1);
sem_fr = std([fr_act; fr_inh; fr_non],1)/sqrt(n_pn);

%% Threshold apply

idx_inc = T.idxmFrIn == 1;
idx_dec = T.idxmFrIn == -1; % STM block decreased neurons (inactivation)
% min_lapFrInPRE = min(m_lapFrInPRE(PN & idx_dec)); % <<<<<<<<<<<<<< firing rate base
m_lapSpkInPRE = cellfun(@(x) x(2), T.m_inzoneSpike);
min_lapSpkInPRE = min(m_lapSpkInPRE(PN & idx_dec)); % <<<<<<<<<<<<<<<< spike number base
if isempty(min_lapSpkInPRE)
    min_lapSpkInPRE = 0;
end
idx_thrPass = m_lapSpkInPRE>=min_lapSpkInPRE; % <<<<<<<<<<<<<<< threshold; min firing rate that can be detected by inactivation

%%%%%% firing rate
neuron_th_act = PN & T.idxmFrIn == 1 & idx_thrPass;
neuron_th_dir = PN & T.idxmFrIn == 1 & T.latencyTrack1st>=4 & T.latencyTrack1st<10 & isnan(T.latencyTrack2nd) & idx_thrPass;
neuron_th_ind = PN & T.idxmFrIn == 1 & T.latencyTrack1st>=10 & isnan(T.latencyTrack2nd) & idx_thrPass;
neuron_th_doub = PN & T.idxmFrIn == 1 & ~isnan(T.latencyTrack2nd) & idx_thrPass;
neuron_th_inh = PN & T.idxmFrIn == -1 & idx_thrPass;
neuron_th_non = PN & T.idxmFrIn == 0 & idx_thrPass;

%%%% spike number %%%%
% neuron_th_act = PN & T.idxmSpkIn == 1 & idx_thrPass;
% neuron_th_dir = PN & T.idxmSpkIn == 1 & T.latencyTrack1st<10 & isnan(T.latencyTrack2nd) & idx_thrPass;
% neuron_th_ind = PN & T.idxmSpkIn == 1 & T.latencyTrack1st>=10 & isnan(T.latencyTrack2nd) & idx_thrPass;
% neuron_th_doub = PN & T.idxmSpkIn == 1 & ~isnan(T.latencyTrack2nd) & idx_thrPass;
% neuron_th_inh = PN & T.idxmSpkIn == -1 & idx_thrPass;
% neuron_th_non = PN & T.idxmSpkIn == 0 & idx_thrPass;

% n_th_pn = sum(double(PN & idx_thrPass));
n_th_act = sum(double(neuron_th_act));
n_th_dir = sum(double(neuron_th_dir));
n_th_ind = sum(double(neuron_th_ind));
n_th_doub = sum(double(neuron_th_doub));
n_th_inh = sum(double(neuron_th_inh));
n_th_non = sum(double(neuron_th_non));
n_th_pn = sum([n_th_dir, n_th_ind, n_th_doub, n_th_inh, n_th_non]);

peth_th_dir = T.peth1stBStm(neuron_th_dir);
m_peth_th_dir = mean(cell2mat(peth_th_dir),1);
sem_peth_th_dir = std(cell2mat(peth_th_dir),0,1)/sqrt(n_th_dir);

peth_th_ind = T.peth1stBStm(neuron_th_ind);
m_peth_th_ind = mean(cell2mat(peth_th_ind),1);
sem_peth_th_ind = std(cell2mat(peth_th_ind),0,1)/sqrt(n_th_ind);

peth_th_doub = T.peth1stBStm(neuron_th_doub);
m_peth_th_doub = mean(cell2mat(peth_th_doub),1);
sem_peth_th_doub = std(cell2mat(peth_th_doub),0,1)/sqrt(n_th_doub);

peth_th_inh = T.peth1stBStm(neuron_th_inh);
m_peth_th_inh = mean(cell2mat(peth_th_inh),1);
sem_peth_th_inh = std(cell2mat(peth_th_inh),0,1)/sqrt(n_th_inh);

peth_th_non = T.peth1stBStm(neuron_th_non);
m_peth_th_non = mean(cell2mat(peth_th_non),1);
sem_peth_th_non = std(cell2mat(peth_th_non),0,1)/sqrt(n_th_non);

fr_th_act = [m_lapFrInPRE(neuron_th_act), m_lapFrInSTIM(neuron_th_act), m_lapFrInPOST(neuron_th_act)];
fr_th_inh = [m_lapFrInPRE(neuron_th_inh), m_lapFrInSTIM(neuron_th_inh), m_lapFrInPOST(neuron_th_inh)];
fr_th_non = [m_lapFrInPRE(neuron_th_non), m_lapFrInSTIM(neuron_th_non), m_lapFrInPOST(neuron_th_non)];

m_th_fr = mean([fr_th_act; fr_th_inh; fr_th_non],1);
sem_th_fr = std([fr_th_act; fr_th_inh; fr_th_non],1)/sqrt(n_th_pn);
%% plot_Track.
nCol = 2;
nRow = 7;
barWidth = 0.7;
eBarWidth = 1;
spaceFig = [];
midInterval = [0.07 0.07];

fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});
xptBar = [1,3,5];
xptScatter_act = (rand(n_act,1)-0.5)*0.85*barWidth;
xptScatter_inh = (rand(n_inh,1)-0.5)*0.85*barWidth;
xptScatter_non = (rand(n_non,1)-0.5)*0.85*barWidth;
yLim = [80, 30, 160, 10, 10];

hSummary = axes('Position',axpt(2,1,1,1,axpt(nCol,nRow,1,1:2,[],wideInterval),wideInterval));
text(-0.2,1,['No FR threshold (n = ',num2str(n_pn),')'],'fontSize',fontM,'fontWeight','bold');
text(0,0.7,['Activated: ',num2str([n_dir+n_ind+n_doub]/n_pn*100,2),'%'],'fontSize',fontM);
text(0,0.5,['Inhibited: ',num2str(n_inh/n_pn*100,2),'%'],'fontSize',fontM);
text(0,0.3,['No-responsive: ',num2str(n_non/n_pn*100,2),'%'],'fontSize',fontM);
set(hSummary,'visible','off');

hScatter = axes('Position',axpt(2,1,2,1,axpt(nCol,nRow,1,1:2,[],wideInterval),wideInterval));
bar(xptBar,m_fr,'barWidth',0.6,'lineStyle','-','edgeColor',colorBlack,'faceColor',colorDarkGray,'lineWidth',1);
hold on;
for iBlock = 1:3
    plot((2*iBlock-1)+xptScatter_act,fr_act(:,iBlock),'lineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorRed,'markerEdgeColor',colorBlack);
    hold on;
    plot((2*iBlock-1)+xptScatter_inh,fr_inh(:,iBlock),'lineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorBlue,'markerEdgeColor',colorBlack);
    hold on;
    plot((2*iBlock-1)+xptScatter_non,fr_non(:,iBlock),'lineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorGray,'markerEdgeColor',colorBlack);
    hold on;
end
for iLine = 1:n_act
    plot([1+xptScatter_act(iLine),3+xptScatter_act(iLine),5+xptScatter_act(iLine)],[fr_act(iLine,1),fr_act(iLine,2),fr_act(iLine,3)],'lineStyle','-','color',colorLightRed);
    hold on;
end
for iLine = 1:n_inh
    plot([1+xptScatter_inh(iLine),3+xptScatter_inh(iLine),5+xptScatter_inh(iLine)],[fr_inh(iLine,1),fr_inh(iLine,2),fr_inh(iLine,3)],'lineStyle','-','color',colorLightBlue);
    hold on;
end
for iLine = 1:n_non
    plot([1+xptScatter_non(iLine),3+xptScatter_non(iLine),5+xptScatter_non(iLine)],[fr_non(iLine,1),fr_non(iLine,2),fr_non(iLine,3)],'lineStyle','-','color',colorLightGray);
    hold on;
end
errorbarJun(xptBar,m_fr,sem_fr,0.4,eBarWidth,colorBlack);
ylabel('Firing rate (Hz)','fontSize',fontM);

hPlot(1) = axes('Position',axpt(nCol,nRow,1,3,spaceFig,midInterval));
for iLight = 1:4
    lightPatch(iLight) = patch([20*(iLight-1) 20*(iLight-1)+10 20*(iLight-1)+10 20*(iLight-1)],[0 0 yLim(1) yLim(1)],colorLLightBlue,'LineStyle','none');
    hold on;
end
hBar(1) = bar(xpt,m_peth_dir,'histc');
errorbarJun(xpt+1,m_peth_dir,sem_peth_dir,1,0.4,colorDarkGray);
text(100,yLim(1)*0.8,['n = ',num2str(n_dir)],'fontSize',fontM);
xlabel('Time (ms)','fontSize',fontM);
ylabel('Rate (Hz)','fontSize',fontM);
text(-8,yLim(1)*1.2,'Directly activated (delay < 10 ms)','fontSize',fontM);

hPlot(2) = axes('Position',axpt(nCol,nRow,1,4,spaceFig,midInterval));
for iLight = 1:4
    lightPatch(iLight) = patch([20*(iLight-1) 20*(iLight-1)+10 20*(iLight-1)+10 20*(iLight-1)],[0 0 yLim(1) yLim(1)],colorLLightBlue,'LineStyle','none');
    hold on;
end
hBar(2) = bar(xpt,m_peth_ind,'histc');
errorbarJun(xpt+1,m_peth_ind,sem_peth_ind,1,0.4,colorDarkGray);
text(100,yLim(2)*0.8,['n = ',num2str(n_ind)],'fontSize',fontM);
xlabel('Time (ms)','fontSize',fontM);
ylabel('Rate (Hz)','fontSize',fontM);
text(-8,yLim(2)*1.2,'Indirectly activated (delay > 10 ms)','fontSize',fontM);

hPlot(3) = axes('Position',axpt(nCol,nRow,1,5,spaceFig,midInterval));
set(hPlot(3),'visible','off');
% for iLight = 1:4
%     lightPatch(iLight) = patch([20*(iLight-1) 20*(iLight-1)+10 20*(iLight-1)+10 20*(iLight-1)],[0 0 yLim(1) yLim(1)],colorLLightBlue,'LineStyle','none');
%     hold on;
% end
% hBar(3) = bar(xpt,m_peth_doub,'histc');
% errorbarJun(xpt+1,m_peth_doub,sem_peth_doub,1,0.4,colorDarkGray);
% text(100,yLim(3)*0.8,['n = ',num2str(n_doub)],'fontSize',fontM);
% xlabel('Time (ms)','fontSize',fontM);
% ylabel('Rate (Hz)','fontSize',fontM);
% text(-8,yLim(3)*1.2,'Double activated','fontSize',fontM);

hPlot(4) = axes('Position',axpt(nCol,nRow,1,6,spaceFig,midInterval));
for iLight = 1:4
    lightPatch(iLight) = patch([20*(iLight-1) 20*(iLight-1)+10 20*(iLight-1)+10 20*(iLight-1)],[0 0 yLim(1) yLim(1)],colorLLightBlue,'LineStyle','none');
    hold on;
end
hBar(3) = bar(xpt,m_peth_inh,'histc');
errorbarJun(xpt+1,m_peth_inh,sem_peth_inh,1,0.4,colorDarkGray);
text(100,yLim(4)*0.8,['n = ',num2str(n_inh)],'fontSize',fontM);
xlabel('Time (ms)','fontSize',fontM);
ylabel('Rate (Hz)','fontSize',fontM);
text(-8,yLim(4)*1.2,'Inhibited','fontSize',fontM);

hPlot(5) = axes('Position',axpt(nCol,nRow,1,7,spaceFig,midInterval));
for iLight = 1:4
    lightPatch(iLight) = patch([20*(iLight-1) 20*(iLight-1)+10 20*(iLight-1)+10 20*(iLight-1)],[0 0 yLim(1) yLim(1)],colorLLightBlue,'LineStyle','none');
    hold on;
end
hBar(4) = bar(xpt,m_peth_non,'histc');
errorbarJun(xpt+1,m_peth_non,sem_peth_non,1,0.4,colorDarkGray);
text(100,yLim(5)*0.8,['n = ',num2str(n_non)],'fontSize',fontM);
xlabel('Time (ms)','fontSize',fontM);
ylabel('Rate (Hz)','fontSize',fontM);
text(-8,yLim(5)*1.2,'Non-responsive','fontSize',fontM);

set(hBar,'faceColor',colorBlack,'edgeColor',colorBlack,'faceAlpha',1);
set(hScatter,'Box','off','TickDir','out','TickLength',[0.03 0.03],'XLim',[0,6],'XTick',[1,3,5],'XTickLabel',{'PRE','STIM','POST'},'fontSize',fontM);
set(hPlot,'Box','off','TickDir','out','XLim',[-10 120],'fontSize',fontM);
set(hPlot(1),'YLim',[0 yLim(1)],'YTick',[0:20:60]);
set(hPlot(2),'YLim',[0 yLim(2)],'YTick',[0:10:40]);
set(hPlot(3),'YLim',[0 yLim(3)],'YTick',[0:40:160]);
set(hPlot(4),'YLim',[0 yLim(4)],'YTick',[0:5:15]);
set(hPlot(5),'YLim',[0 yLim(5)],'YTick',[0:5:15]);

%% Threshold
yLim = [120, 60, 160, 10, 10];

xptScatter_th_act = (rand(n_th_act,1)-0.5)*0.85*barWidth;
xptScatter_th_inh = (rand(n_th_inh,1)-0.5)*0.85*barWidth;
xptScatter_th_non = (rand(n_th_non,1)-0.5)*0.85*barWidth;

hSummary = axes('Position',axpt(2,1,1,1,axpt(nCol,nRow,2,1:2,[],wideInterval),midInterval));
text(-0.2,1,['FR threshold applied (n = ',num2str(n_th_pn),')'],'fontSize',fontM,'fontWeight','bold');
text(0,0.7,['Activated: ',num2str([n_th_dir+n_th_ind+n_th_doub]/n_th_pn*100,2),'%'],'fontSize',fontM);
text(0,0.5,['Inhibited: ',num2str(n_th_inh/n_th_pn*100,2),'%'],'fontSize',fontM);
text(0,0.3,['No-responsive: ',num2str(n_th_non/n_th_pn*100,2),'%'],'fontSize',fontM);
set(hSummary,'visible','off');

hScatter = axes('Position',axpt(2,1,2,1,axpt(nCol,nRow,2,1:2,[],wideInterval),wideInterval));
bar(xptBar,m_th_fr,'barWidth',0.6,'lineStyle','-','edgeColor',colorBlack,'faceColor',colorDarkGray,'lineWidth',1);
hold on;
for iBlock = 1:3
    plot((2*iBlock-1)+xptScatter_th_act,fr_th_act(:,iBlock),'lineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorRed,'markerEdgeColor',colorBlack);
    hold on;
    plot((2*iBlock-1)+xptScatter_th_inh,fr_th_inh(:,iBlock),'lineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorBlue,'markerEdgeColor',colorBlack);
    hold on;
    plot((2*iBlock-1)+xptScatter_th_non,fr_th_non(:,iBlock),'lineStyle','none','Marker','o','markerSize',markerS,'markerFaceColor',colorGray,'markerEdgeColor',colorBlack);
    hold on;
end
for iLine = 1:n_th_act
    plot([1+xptScatter_th_act(iLine),3+xptScatter_th_act(iLine),5+xptScatter_th_act(iLine)],[fr_th_act(iLine,1),fr_th_act(iLine,2),fr_th_act(iLine,3)],'lineStyle','-','color',colorLightRed);
    hold on;
end
for iLine = 1:n_th_inh
    plot([1+xptScatter_th_inh(iLine),3+xptScatter_th_inh(iLine),5+xptScatter_th_inh(iLine)],[fr_th_inh(iLine,1),fr_th_inh(iLine,2),fr_th_inh(iLine,3)],'lineStyle','-','color',colorLightBlue);
    hold on;
end
for iLine = 1:n_th_non
    plot([1+xptScatter_th_non(iLine),3+xptScatter_th_non(iLine),5+xptScatter_th_non(iLine)],[fr_th_non(iLine,1),fr_th_non(iLine,2),fr_th_non(iLine,3)],'lineStyle','-','color',colorLightGray);
    hold on;
end
errorbarJun(xptBar,m_th_fr,sem_th_fr,0.4,eBarWidth,colorBlack);
ylabel('Firing rate (Hz)','fontSize',fontM);

hPlot(1) = axes('Position',axpt(nCol,nRow,2,3,spaceFig,midInterval));
for iLight = 1:4
    lightPatch(iLight) = patch([20*(iLight-1) 20*(iLight-1)+10 20*(iLight-1)+10 20*(iLight-1)],[0 0 yLim(1) yLim(1)],colorLLightBlue,'LineStyle','none');
    hold on;
end
hBar(1) = bar(xpt,m_peth_th_dir,'histc');
errorbarJun(xpt+1,m_peth_th_dir,sem_peth_th_dir,1,0.4,colorDarkGray);
text(100,yLim(1)*0.8,['n = ',num2str(n_th_dir)],'fontSize',fontM);
xlabel('Time (ms)','fontSize',fontM);
ylabel('Rate (Hz)','fontSize',fontM);
text(-8,yLim(1)*1.2,'Directly activated (delay < 10 ms)','fontSize',fontM);

hPlot(2) = axes('Position',axpt(nCol,nRow,2,4,spaceFig,midInterval));
for iLight = 1:4
    lightPatch(iLight) = patch([20*(iLight-1) 20*(iLight-1)+10 20*(iLight-1)+10 20*(iLight-1)],[0 0 yLim(1) yLim(1)],colorLLightBlue,'LineStyle','none');
    hold on;
end
hBar(2) = bar(xpt,m_peth_th_ind,'histc');
errorbarJun(xpt+1,m_peth_th_ind,sem_peth_th_ind,1,0.4,colorDarkGray);
text(100,yLim(2)*0.8,['n = ',num2str(n_th_ind)],'fontSize',fontM);
xlabel('Time (ms)','fontSize',fontM);
ylabel('Rate (Hz)','fontSize',fontM);
text(-8,yLim(2)*1.2,'Indirectly activated (delay > 10 ms)','fontSize',fontM);

hPlot(3) = axes('Position',axpt(nCol,nRow,2,5,spaceFig,midInterval));
set(hPlot(3),'visible','off');
% for iLight = 1:4
%     lightPatch(iLight) = patch([20*(iLight-1) 20*(iLight-1)+10 20*(iLight-1)+10 20*(iLight-1)],[0 0 yLim(1) yLim(1)],colorLLightBlue,'LineStyle','none');
%     hold on;
% end
% hBar(3) = bar(xpt,m_peth_th_doub,'histc');
% errorbarJun(xpt+1,m_peth_th_doub,sem_peth_th_doub,1,0.4,colorDarkGray);
% text(100,yLim(3)*0.8,['n = ',num2str(n_th_doub)],'fontSize',fontM);
% xlabel('Time (ms)','fontSize',fontM);
% ylabel('Rate (Hz)','fontSize',fontM);
% text(-8,yLim(3)*1.2,'Double activated','fontSize',fontM);

hPlot(4) = axes('Position',axpt(nCol,nRow,2,6,spaceFig,midInterval));
for iLight = 1:4
    lightPatch(iLight) = patch([20*(iLight-1) 20*(iLight-1)+10 20*(iLight-1)+10 20*(iLight-1)],[0 0 yLim(1) yLim(1)],colorLLightBlue,'LineStyle','none');
    hold on;
end
hBar(3) = bar(xpt,m_peth_th_inh,'histc');
errorbarJun(xpt+1,m_peth_th_inh,sem_peth_th_inh,1,0.4,colorDarkGray);
text(100,yLim(4)*0.8,['n = ',num2str(n_th_inh)],'fontSize',fontM);
xlabel('Time (ms)','fontSize',fontM);
ylabel('Rate (Hz)','fontSize',fontM);
text(-8,yLim(4)*1.2,'Inhibited','fontSize',fontM);

hPlot(5) = axes('Position',axpt(nCol,nRow,2,7,spaceFig,midInterval));
for iLight = 1:4
    lightPatch(iLight) = patch([20*(iLight-1) 20*(iLight-1)+10 20*(iLight-1)+10 20*(iLight-1)],[0 0 yLim(1) yLim(1)],colorLLightBlue,'LineStyle','none');
    hold on;
end
hBar(4) = bar(xpt,m_peth_th_non,'histc');
errorbarJun(xpt+1,m_peth_th_non,sem_peth_th_non,1,0.4,colorDarkGray);
text(100,yLim(5)*0.8,['n = ',num2str(n_th_non)],'fontSize',fontM);
xlabel('Time (ms)','fontSize',fontM);
ylabel('Rate (Hz)','fontSize',fontM);
text(-8,yLim(5)*1.2,'Non-responsive','fontSize',fontM);

set(hBar,'faceColor',colorBlack,'edgeColor',colorBlack,'faceAlpha',1);
set(hScatter,'Box','off','TickDir','out','TickLength',[0.03 0.03],'XLim',[0,6],'XTick',[1,3,5],'XTickLabel',{'PRE','STIM','POST'},'fontSize',fontM);
set(hPlot,'Box','off','TickDir','out','XLim',[-10 120],'fontSize',fontM);
set(hPlot(1),'YLim',[0 yLim(1)],'YTick',[0:30:120]);
set(hPlot(2),'YLim',[0 yLim(2)],'YTick',[0:20:60]);
set(hPlot(3),'YLim',[0 yLim(3)],'YTick',[0:20:100]);
set(hPlot(4),'YLim',[0 yLim(4)],'YTick',[0:5:15]);
set(hPlot(5),'YLim',[0 yLim(5)],'YTick',[0:5:10]);

cd(rtDir);
print('-painters','-r300','-dtiff',['plot_novel_lightResponse_CA3a_',datestr(now,formatOut),'.tif']);
close all;