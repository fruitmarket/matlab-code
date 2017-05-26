% Frequency dependency on platform
% the function plot Frequency Vs. spike probability
%
clearvars;

% lineColor = {[144, 164, 174]./255,... % Before stimulation
%     [33 150 243]./ 255,... % During stimulation
%     [38, 50, 56]./255}; % After stimulation
% 
% lineWth = [1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75];
% fontS = 4; fontM = 5; fontL = 7; fontXL = 9; % font size large
% lineS = 0.2; lineM = 0.5; lineL = 1; % line width large
% 
% colorBlue = [33 150 243] ./ 255;
% colorLightBlue = [100 181 246] ./ 255;
% colorLLightBlue = [187, 222, 251]./255;
% colorRed = [237 50 52] ./ 255;
% colorLightRed = [242 138 130] ./ 255;
% colorGray = [189 189 189] ./ 255;
% colorLightGray = [238, 238, 238] ./255;
% colorDarkGray = [117, 117, 117] ./255;
% colorYellow = [255 243 3] ./ 255;
% colorLightYellow = [255 249 196] ./ 255;
% colorBlack = [0, 0, 0];
% 
% markerS = 4; markerM = 6; markerL = 8; markerXL = 12*2;
% tightInterval = [0.02 0.02]; midInterval = [0.09, 0.09]; wideInterval = [0.14 0.14];
% width = 0.7;
% 
% paperSize = {[0 0 21.0 29.7];
%              [0 0 21.6 27.9]};

rtDir = 'D:\Dropbox\SNL\P2_Track';
cd(rtDir);

load('myParameters.mat');
Txls = readtable('neuronList_freq_170509.xlsx');
load('neuronList_freq_170509.mat');

% folder = 'D:\Dropbox\#team_hippocampus Team Folder\project_Track\samples_v9\';

alpha = 0.01;
alpha2 = alpha/5;
%% Light responsive population
lightCri = T.total_mFR<9 & (T.pLR_Plfm1hz<alpha2 | T.pLR_Plfm2hz<alpha2 | T.pLR_Plfm8hz<alpha2 | T.pLR_Plfm20hz<alpha2 | T.pLR_Plfm50hz<alpha2);
nolightCri = T.total_mFR<9 & ~(T.pLR_Plfm1hz<alpha2 | T.pLR_Plfm2hz<alpha2 | T.pLR_Plfm8hz<alpha2 | T.pLR_Plfm20hz<alpha2 | T.pLR_Plfm50hz<alpha2);

lightProb1hz = T.lightProb1hz((lightCri));
lightProb2hz = T.lightProb2hz((lightCri));
lightProb8hz = T.lightProb8hz((lightCri));
lightProb20hz = T.lightProb20hz((lightCri));
lightProb50hz = T.lightProb50hz((lightCri));

nCell = sum(double(lightCri));

nLight_1hz = sum(double(T.total_mFR<9 & T.pLR_Plfm1hz<alpha));
nLight_2hz = sum(double(T.total_mFR<9 & T.pLR_Plfm2hz<alpha));
nLight_8hz = sum(double(T.total_mFR<9 & T.pLR_Plfm8hz<alpha));
nLight_20hz = sum(double(T.total_mFR<9 & T.pLR_Plfm20hz<alpha));
nLight_50hz = sum(double(T.total_mFR<9 & T.pLR_Plfm50hz<alpha));
nlight_all = sum(double(T.total_mFR<9 & (T.pLR_Plfm1hz<alpha & T.pLR_Plfm2hz<alpha & T.pLR_Plfm8hz<alpha & T.pLR_Plfm20hz<alpha & T.pLR_Plfm50hz<alpha)));

m_1hz = mean(lightProb1hz);
m_2hz = mean(lightProb2hz);
m_8hz = mean(lightProb8hz);
m_20hz = mean(lightProb20hz);
m_50hz = mean(lightProb50hz);

sem_1hz = std(lightProb1hz)/sqrt(nCell);
sem_2hz = std(lightProb2hz)/sqrt(nCell);
sem_8hz = std(lightProb8hz)/sqrt(nCell);
sem_20hz = std(lightProb20hz)/sqrt(nCell);
sem_50hz = std(lightProb50hz)/sqrt(nCell);

%% No light responsive population
nolightProb1hz = T.lightProb1hz(nolightCri);
nolightProb2hz = T.lightProb2hz(nolightCri);
nolightProb8hz = T.lightProb8hz(nolightCri);
nolightProb20hz = T.lightProb20hz(nolightCri);
nolightProb50hz = T.lightProb50hz(nolightCri);

nNoLCell = length(nolightProb1hz);

m_no_1hz = mean(nolightProb1hz);
m_no_2hz = mean(nolightProb2hz);
m_no_8hz = mean(nolightProb8hz);
m_no_20hz = mean(nolightProb20hz);
m_no_50hz = mean(nolightProb50hz);

sem_no_1hz = std(nolightProb1hz)/sqrt(nNoLCell);
sem_no_2hz = std(nolightProb2hz)/sqrt(nNoLCell);
sem_no_8hz = std(nolightProb8hz)/sqrt(nNoLCell);
sem_no_20hz = std(nolightProb20hz)/sqrt(nNoLCell);
sem_no_50hz = std(nolightProb50hz)/sqrt(nNoLCell);

%% Plot
nCol = 1;
nRow = 1;

hHandle = figure('PaperUnits','centimeters','PaperPosition',[0 0 6 6]*2);
% light response population
hPlot(1) = axes('Position',axpt(nCol,nRow,1,1,[0.1 0.1 0.80 0.85],wideInterval));
plot([1,2,3,4,5],[lightProb1hz, lightProb2hz, lightProb8hz, lightProb20hz, lightProb50hz],'-o','color',colorDarkGray,'markerSize',markerL,'markerEdgeColor',colorDarkGray,'markerFaceColor',colorLightGray);
hold on;
plot([1,2,3,4,5],[m_1hz, m_2hz, m_8hz, m_20hz, m_50hz],'o','color',colorBlack,'markerSize',markerL,'markerEdgeColor',colorBlack,'markerFaceColor',colorBlack);
hold on;
errorbarJun([1,2,3,4,5],[m_1hz, m_2hz, m_8hz, m_20hz, m_50hz],[sem_1hz,sem_2hz,sem_8hz,sem_20hz,sem_50hz],0.2, 0.8, colorBlack);

text(1,60,['n = ',num2str(nCell)],'fontSize',fontL);
xlabel('Frequency, Hz','fontSize',fontL);
ylabel('Spike fidelity (%)','fontSize',fontL);

set(hPlot,'TickDir','out','Box','off');
set(hPlot,'XLim',[0,6],'XTick',[1:5],'XTickLabel',{'1';'2';'8';'20';'50'},'fontSize',fontL);
set(hPlot(1),'YLim',[-1,70]);

formatOut = 'yymmdd';
print('-painters','-r300','-dtiff',['fig1_frequencyTest_',datestr(now,formatOut),'.tif']);
print('-painters','-r300','-depsc',['fig1_frequencyTest_',datestr(now,formatOut),'.ai']);
close();

%%
% hPlot(1) = axes('Position',axpt(nCol,nRow,1:2,1:2,[0.1 0.1 0.85 0.85],wideInterval));
% plot([1,2,3,4,5],[lightProb1hz, lightProb2hz, lightProb8hz, lightProb20hz, lightProb50hz],'-o','color',colorDarkGray,'markerSize',markerM,'markerEdgeColor',colorDarkGray,'markerFaceColor',colorLightGray);
% hold on;
% plot([1,2,3,4,5],[m_1hz, m_2hz, m_8hz, m_20hz, m_50hz],'o','color',colorBlack,'markerSize',markerM,'markerEdgeColor',colorBlack,'markerFaceColor',colorBlack);
% hold on;
% errorbar([1,2,3,4,5],[m_1hz, m_2hz, m_8hz, m_20hz, m_50hz],[sem_1hz,sem_2hz,sem_8hz,sem_20hz,sem_50hz],'o','color',colorBlack,'markerSize',markerM);
% 
% text(1,60,['n = ',num2str(nCell)],'fontSize',fontM);
% xlabel('Frequency, Hz','fontSize',fontM);
% ylabel('Spike P, %','fontSize',fontM);
% 
% hPlot(2) = axes('Position',axpt(nCol,nRow,3:4,1:2,[0.1 0.1 0.85 0.85],wideInterval));
% plot([1,2,3,4,5],[nLight_1hz, nLight_2hz, nLight_8hz, nLight_20hz, nLight_50hz],'-o','color',colorBlack,'MarkerFaceColor',colorBlack,'MarkerSize',markerM);
% xlabel('Frequency, Hz','fontSize',fontM);
% ylabel('Number of light responsive neurons, n','fontSize',fontM);
% 
% % no light response
% hPlot(3) = axes('Position',axpt(nCol,nRow,1:2,3:4,[0.1 0.1 0.85 0.85],wideInterval));
% plot([1,2,3,4,5],[nolightProb1hz, nolightProb2hz, nolightProb8hz, nolightProb20hz, nolightProb50hz],'o','color',colorGray,'markerSize',markerM,'markerEdgeColor',colorDarkGray,'markerFaceColor',colorGray);
% hold on;
% plot([1,2,3,4,5],[m_no_1hz, m_no_2hz, m_no_8hz, m_no_20hz, m_no_50hz],'o','color',colorBlack,'markerSize',markerM,'markerEdgeColor',colorBlack,'markerFaceColor',colorBlack);
% hold on;
% errorbar([1,2,3,4,5],[m_no_1hz, m_no_2hz, m_no_8hz, m_no_20hz, m_no_50hz],[sem_no_1hz,sem_no_2hz,sem_no_8hz,sem_no_20hz,sem_no_50hz],'o','color',colorBlack,'markerSize',markerM);
% 
% text(1,60,['n = ',num2str(nNoLCell)],'fontSize',fontM);
% xlabel('Frequency, Hz','fontSize',fontM);
% ylabel('Spike P, %','fontSize',fontM);
% 
% set(hPlot,'TickDir','out','Box','off');
% set(hPlot,'XLim',[0,6],'XTick',[1:5],'XTickLabel',{'1';'2';'8';'20';'50'},'fontSize',fontM);
% set(hPlot(1),'YLim',[-1,70]);
% set(hPlot(2),'YLim',[1,15],'YTick',[5:2:15]);
% set(hPlot(3),'YLim',[-1,70]);
%% Example file classification
% path1hz = T.path(T.pLR_Plfm1hz < alpha);
% path2hz = T.path(T.pLR_Plfm2hz < alpha);
% path8hz = T.path(T.pLR_Plfm8hz < alpha);
% path20hz = T.path(T.pLR_Plfm20hz < alpha);
% path50hz = T.path(T.pLR_Plfm50hz < alpha);
% 
% dir1hz = 'D:\Dropbox\SNL\P2_Track\analysis_freq\1hz';
% dir2hz = 'D:\Dropbox\SNL\P2_Track\analysis_freq\2hz';
% dir8hz = 'D:\Dropbox\SNL\P2_Track\analysis_freq\8hz';
% dir20hz = 'D:\Dropbox\SNL\P2_Track\analysis_freq\20hz';
% dir50hz = 'D:\Dropbox\SNL\P2_Track\analysis_freq\50hz';
% 
% plot_freqDependency_v3(path1hz,dir1hz);
% plot_freqDependency_v3(path2hz,dir2hz);
% plot_freqDependency_v3(path8hz,dir8hz);
% plot_freqDependency_v3(path20hz,dir20hz);
% plot_freqDependency_v3(path50hz,dir50hz);
% 
% close('all');
% cd(rtDir);