clearvars;
cd('E:\Dropbox\SNL\P2_Track');
load('E:\Dropbox\SNL\P2_Track\myParameters.mat');
winCri_ori = [-5, 20];
nTrial_ori = 300;
markerSS = 1;

formatOut = 'yymmdd';
saveDir = 'E:\Dropbox\SNL\P2_Track';

fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});
nCol = 4;
nRow = 6;

%% freq dependency
Txls = readtable('neuronList_freq_171127.xlsx');
load('neuronList_freq_181010.mat');
Txls.latencyIndex = categorical(Txls.latencyIndex);
formatOut = 'yymmdd';

alpha = 0.01;
alpha2 = alpha/5;
cSpkpvr = 1.2;

listPN = T.spkpvr > cSpkpvr;
listIN = ~listPN;

% lightAct = listPN & (Txls.latencyIndex == 'direct' | Txls.latencyIndex == 'indirect' | Txls.latencyIndex == 'double');
lightAct = listPN & (T.idx_light1hz == 1 | T.idx_light2hz == 1 | T.idx_light8hz == 1 | T.idx_light20hz == 1 | T.idx_light50hz == 1);
light5Prob1hzT = T.light5Prob1hz(lightAct);
light5Prob2hzT = T.light5Prob2hz(lightAct);
light5Prob8hzT = T.light5Prob8hz(lightAct);
light5Prob20hzT = T.light5Prob20hz(lightAct);
light5Prob50hzT = T.light5Prob50hz(lightAct);
nCellT = sum(double(lightAct));

% plot_freqDependency_multi(T.path(lightAct), T.cellID(lightAct), 'C:\Users\Jun\Desktop\example_50hzAct')

m_1hz_T = mean(light5Prob1hzT);
m_2hz_T = mean(light5Prob2hzT);
m_8hz_T = mean(light5Prob8hzT);
m_20hz_T = mean(light5Prob20hzT);
m_50hz_T = mean(light5Prob50hzT);

sem_1hz_T = std(light5Prob1hzT)/sqrt(nCellT);
sem_2hz_T = std(light5Prob2hzT)/sqrt(nCellT);
sem_8hz_T = std(light5Prob8hzT)/sqrt(nCellT);
sem_20hz_T = std(light5Prob20hzT)/sqrt(nCellT);
sem_50hz_T = std(light5Prob50hzT)/sqrt(nCellT);
a = [light5Prob1hzT, light5Prob2hzT, light5Prob8hzT, light5Prob20hzT, light5Prob50hzT];
[p,tbl,stats] = friedman(a,1,'off');
% [~,~,result] = multcompare(stats,'ctype','bonferroni');
% p_KW = result(:,end);
lightProb = [light5Prob1hzT, light5Prob2hzT, light5Prob8hzT, light5Prob20hzT, light5Prob50hzT];

hPlot = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1:2,2:3,[0.1 0.1 0.85 0.85],midInterval),midInterval));
for iCycle = 1:size(lightProb,1)
    plot(lightProb(iCycle,:),'-o','color',colorDarkGray,'markerSize',markerS-1.5,'markerEdgeColor',colorDarkGray,'markerFaceColor',colorLightGray);
    hold on;
end
% plot(lightProb(9,:),'-o','color',colorLightRed,'markerSize',markerS-1.5,'markerEdgeColor',colorRed,'markerFaceColor',colorLightRed);
% hold on;
% plot([1,2,3,4,5],[lightProb1hzT, lightProb2hzT, lightProb8hzT, lightProb20hzT, lightProb50hzT],'-o','color',colorGray,'markerSize',markerS-1.5,'markerEdgeColor',colorGray,'markerFaceColor',colorLightGray);
% hold on;
plot([1,2,3,4,5],[m_1hz_T, m_2hz_T, m_8hz_T, m_20hz_T, m_50hz_T],'o','color',colorBlack,'markerSize',markerS-0.5,'markerEdgeColor',colorBlack,'markerFaceColor',colorBlack);
hold on;
errorbarJun([1,2,3,4,5],[m_1hz_T, m_2hz_T, m_8hz_T, m_20hz_T, m_50hz_T],[sem_1hz_T,sem_2hz_T,sem_8hz_T,sem_20hz_T,sem_50hz_T],0.2, 0.8, colorBlack);
text(1,50,['n = ',num2str(nCellT)],'fontSize',fontM);
ylabel('Spike probability (%)','fontSize',fontM);
xlabel('Frequency (Hz)','fontSize',fontM);
% title('Total activated neuron','fontSize',fontS);

set(hPlot,'TickDir','out','Box','off','TickLength',[0.03,0.03]);
set(hPlot,'XLim',[0,6],'XTick',[1:5],'XTickLabel',{'1';'2';'8';'20';'50'},'fontSize',fontM);
set(hPlot,'YLim',[-1,65]);

print('-painters','-r300','-dtiff',['f_hippocampus_response_plfmFreq_v2_',datestr(now,formatOut),'.tif']);
print('-painters','-r300','-depsc',['f_hippocampus_response_plfmFreq_v2_',datestr(now,formatOut),'.ai']);
close;