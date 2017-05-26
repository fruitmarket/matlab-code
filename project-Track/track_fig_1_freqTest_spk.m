%
% plot [spike number Vs. Stimulation frequency]
clearvars;

rtDir = 'D:\Dropbox\SNL\P2_Track';
cd(rtDir);

load('myParameters.mat');
Txls = readtable('neuronList_freq_170526.xlsx');
load('neuronList_freq_170526.mat');

alpha = 0.01;
alpha2 = alpha/5;
c_latency = 10;
%% Light responsive population
latencyCri = ~(T.latency1hz1st>c_latency | T.latency2hz1st>c_latency | T.latency8hz1st>c_latency | T.latency20hz1st>c_latency | T.latency50hz1st>c_latency);
lightCri = T.total_mFR<9 & latencyCri & (T.pLR_Plfm1hz<alpha2 | T.pLR_Plfm2hz<alpha2 | T.pLR_Plfm8hz<alpha2 | T.pLR_Plfm20hz<alpha2 | T.pLR_Plfm50hz<alpha2);
nolightCri = T.total_mFR<9 & ~(T.pLR_Plfm1hz<alpha2 | T.pLR_Plfm2hz<alpha2 | T.pLR_Plfm8hz<alpha2 | T.pLR_Plfm20hz<alpha2 | T.pLR_Plfm50hz<alpha2);

evoSpike1hz = T.evoSpike1hz((lightCri));
evoSpike2hz = T.evoSpike2hz((lightCri));
evoSpike8hz = T.evoSpike8hz((lightCri));
evoSpike20hz = T.evoSpike20hz((lightCri));
evoSpike50hz = T.evoSpike50hz((lightCri));
totalSpk = [evoSpike1hz,evoSpike2hz,evoSpike8hz,evoSpike20hz,evoSpike50hz];
norm_totalSpk = totalSpk ./ repmat(max(totalSpk,[],2),1,5);

nCell = sum(double(lightCri));

nLight_1hz = sum(double(T.total_mFR<9 & T.pLR_Plfm1hz<alpha));
nLight_2hz = sum(double(T.total_mFR<9 & T.pLR_Plfm2hz<alpha));
nLight_8hz = sum(double(T.total_mFR<9 & T.pLR_Plfm8hz<alpha));
nLight_20hz = sum(double(T.total_mFR<9 & T.pLR_Plfm20hz<alpha));
nLight_50hz = sum(double(T.total_mFR<9 & T.pLR_Plfm50hz<alpha));
nlight_all = sum(double(T.total_mFR<9 & (T.pLR_Plfm1hz<alpha & T.pLR_Plfm2hz<alpha & T.pLR_Plfm8hz<alpha & T.pLR_Plfm20hz<alpha & T.pLR_Plfm50hz<alpha)));

m_1hz = mean(evoSpike1hz);
m_2hz = mean(evoSpike2hz);
m_8hz = mean(evoSpike8hz);
m_20hz = mean(evoSpike20hz);
m_50hz = mean(evoSpike50hz);
m_norm_totalSpk = mean(norm_totalSpk);

sem_1hz = std(evoSpike1hz)/sqrt(nCell);
sem_2hz = std(evoSpike2hz)/sqrt(nCell);
sem_8hz = std(evoSpike8hz)/sqrt(nCell);
sem_20hz = std(evoSpike20hz)/sqrt(nCell);
sem_50hz = std(evoSpike50hz)/sqrt(nCell);
sem_norm_totalSpk = std(norm_totalSpk)/sqrt(nCell);

%% No light responsive population
noevoSpike1hz = T.evoSpike1hz(nolightCri);
noevoSpike2hz = T.evoSpike2hz(nolightCri);
noevoSpike8hz = T.evoSpike8hz(nolightCri);
noevoSpike20hz = T.evoSpike20hz(nolightCri);
noevoSpike50hz = T.evoSpike50hz(nolightCri);

nNoLCell = length(noevoSpike1hz);

m_no_1hz = mean(noevoSpike1hz);
m_no_2hz = mean(noevoSpike2hz);
m_no_8hz = mean(noevoSpike8hz);
m_no_20hz = mean(noevoSpike20hz);
m_no_50hz = mean(noevoSpike50hz);

sem_no_1hz = std(noevoSpike1hz)/sqrt(nNoLCell);
sem_no_2hz = std(noevoSpike2hz)/sqrt(nNoLCell);
sem_no_8hz = std(noevoSpike8hz)/sqrt(nNoLCell);
sem_no_20hz = std(noevoSpike20hz)/sqrt(nNoLCell);
sem_no_50hz = std(noevoSpike50hz)/sqrt(nNoLCell);

%% Plot
nCol = 1;
nRow = 1;

hHandle = figure('PaperUnits','centimeters','PaperPosition',[0 0 6 6]*2);
% light response population
hPlot(1) = axes('Position',axpt(nCol,nRow,1,1,[0.1 0.1 0.80 0.85],wideInterval));
plot([1,2,3,4,5],[evoSpike1hz, evoSpike2hz, evoSpike8hz, evoSpike20hz, evoSpike50hz],'-o','color',colorDarkGray,'markerSize',markerL,'markerEdgeColor',colorDarkGray,'markerFaceColor',colorLightGray);
hold on;
plot([1,2,3,4,5],[m_1hz, m_2hz, m_8hz, m_20hz, m_50hz],'o','color',colorBlack,'markerSize',markerL,'markerEdgeColor',colorBlack,'markerFaceColor',colorBlack);
hold on;
errorbarJun([1,2,3,4,5],[m_1hz, m_2hz, m_8hz, m_20hz, m_50hz],[sem_1hz,sem_2hz,sem_8hz,sem_20hz,sem_50hz],0.2, 0.8, colorBlack);

text(1,60,['n = ',num2str(nCell)],'fontSize',fontL);
xlabel('Frequency, Hz','fontSize',fontL);
ylabel('Spike number','fontSize',fontL);

set(hPlot,'TickDir','out','Box','off');
set(hPlot,'XLim',[0,6],'XTick',[1:5],'XTickLabel',{'1';'2';'8';'20';'50'},'fontSize',fontL);
set(hPlot(1),'YLim',[-1,250]);

formatOut = 'yymmdd';
% print('-painters','-r300','-dtiff',['fig1_frequencyTest_spike_',datestr(now,formatOut),'.tif']);
% print('-painters','-r300','-depsc',['fig1_frequencyTest_spike_',datestr(now,formatOut),'.ai']);
% close();