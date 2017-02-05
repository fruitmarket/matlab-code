clearvars;

lineColor = {[144, 164, 174]./255,... % Before stimulation
    [33 150 243]./ 255,... % During stimulation
    [38, 50, 56]./255}; % After stimulation

lineWth = [1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75];
fontS = 4; fontM = 5; fontL = 7; fontXL = 9; % font size large
lineS = 0.2; lineM = 0.5; lineL = 1; % line width large

colorBlue = [33 150 243] ./ 255;
colorLightBlue = [100 181 246] ./ 255;
colorLLightBlue = [187, 222, 251]./255;
colorRed = [237 50 52] ./ 255;
colorLightRed = [242 138 130] ./ 255;
colorGray = [189 189 189] ./ 255;
colorLightGray = [238, 238, 238] ./255;
colorDarkGray = [117, 117, 117] ./255;
colorYellow = [255 243 3] ./ 255;
colorLightYellow = [255 249 196] ./ 255;
colorBlack = [0, 0, 0];

markerS = 4; markerM = 6; markerL = 8; markerXL = 12*2;
tightInterval = [0.02 0.02]; midInterval = [0.09, 0.09]; wideInterval = [0.14 0.14];
width = 0.7;

paperSize = {[0 0 21.0 29.7];
             [0 0 21.6 27.9]};

rtDir = 'D:\Dropbox\SNL\P2_Track';
load('neuronList_freq_05-Feb-2017.mat');

lightProb1hz = T.lightProb1hz(~isnan(T.lightProb1hz));
lightProb2hz = T.lightProb2hz(~isnan(T.lightProb2hz));
lightProb8hz = T.lightProb8hz(~isnan(T.lightProb8hz));
lightProb20hz = T.lightProb20hz(~isnan(T.lightProb20hz));
lightProb50hz = T.lightProb50hz(~isnan(T.lightProb50hz));

nCell = length(lightProb1hz);

m_1hz = mean(lightProb1hz);
m_2hz = mean(lightProb2hz);
m_8hz = mean(lightProb8hz);
m_20hz = mean(lightProb20hz);
m_50hz = mean(lightProb50hz);

sem_1hz = std(lightProb1hz)/nCell;
sem_2hz = std(lightProb2hz)/nCell;
sem_8hz = std(lightProb8hz)/nCell;
sem_20hz = std(lightProb20hz)/nCell;
sem_50hz = std(lightProb50hz)/nCell;

%% Plot
nCol = 4;
nRow = 4;

hHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});
hPlot = axes('Position',axpt(nCol,nRow,1:3,1:2,[0.1 0.1 0.85 0.85],wideInterval));
plot([1,2,3,4,5],[lightProb1hz, lightProb2hz, lightProb8hz, lightProb20hz, lightProb50hz],'o','color',colorBlack,'markerSize',markerM,'markerEdgeColor',colorBlack,'markerFaceColor','none');
hold on;
plot([1,2,3,4,5],[m_1hz, m_2hz, m_8hz, m_20hz, m_50hz],'o','color',colorBlack,'markerSize',markerM,'markerEdgeColor',colorBlack,'markerFaceColor',colorBlue);
hold on;
errorbar([1,2,3,4,5],[m_1hz, m_2hz, m_8hz, m_20hz, m_50hz],[sem_1hz,sem_2hz,sem_8hz,sem_20hz,sem_50hz],'o','color',colorBlack);

set(hPlot,'XLim',[0,6],'XTick',[1:5],'XTickLabel',{'1';'2';'8';'20';'50'},'YLim',[0,70]);
set(hPlot,'TickDir','out','Box','off');

text(1,60,['n = ',num2str(nCell)],'fontSize',fontXL);
xlabel('Frequency, Hz','fontSize',fontXL);
ylabel('Spike P, %','fontSize',fontXL);

print('-painters',['plot_freqTest_plfm',datestr(date)],'-r300','-dtiff');