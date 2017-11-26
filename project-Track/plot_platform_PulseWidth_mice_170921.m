load myParameters.mat;
formatOut = 'yymmdd';
load('neuronList_width_170920.mat');
Txls = readtable('neuronList_width_170920.xlsx');

lightAct_48 = T.mouseLine == 'Rbp48pulse' & T.spkpvr>cSpkpvr & T.pLR_Plfm2hz<alpha & Txls.statDir==1;
lightAct_50 = T.mouseLine == 'Rbp50pulse' & T.spkpvr>cSpkpvr & T.pLR_Plfm2hz<alpha & Txls.statDir==1;
lightAct_58 = T.mouseLine == 'Rbp58pulse' & T.spkpvr>cSpkpvr & T.pLR_Plfm2hz<alpha & Txls.statDir==1;
lightAct_60 = T.mouseLine == 'Rbp60pulse' & T.spkpvr>cSpkpvr & T.pLR_Plfm2hz<alpha & Txls.statDir==1;
lightAct_64 = T.mouseLine == 'Rbp64pulse' & T.spkpvr>cSpkpvr & T.pLR_Plfm2hz<alpha & Txls.statDir==1;
lightAct_68 = T.mouseLine == 'Rbp68pulse' & T.spkpvr>cSpkpvr & T.pLR_Plfm2hz<alpha & Txls.statDir==1;
lightAct_70 = T.mouseLine == 'Rbp70pulse' & T.spkpvr>cSpkpvr & T.pLR_Plfm2hz<alpha & Txls.statDir==1;
lightAct_72 = T.mouseLine == 'Rbp72pulse' & T.spkpvr>cSpkpvr & T.pLR_Plfm2hz<alpha & Txls.statDir==1;
lightAct_76 = T.mouseLine == 'Rbp76pulse' & T.spkpvr>cSpkpvr & T.pLR_Plfm2hz<alpha & Txls.statDir==1;
lightAct_78 = T.mouseLine == 'Rbp78pulse' & T.spkpvr>cSpkpvr & T.pLR_Plfm2hz<alpha & Txls.statDir==1;


%% Population separation
xpt = -100:2:400;
yMaxPN = [80, 100, 40, 100, 80, 40, 100, 40];

% Pyramidal neuron
actPN_peth10_48 = cell2mat(T.peth10ms(lightAct_48));
actPN_peth10_50 = cell2mat(T.peth10ms(lightAct_50));
actPN_peth10_58 = cell2mat(T.peth10ms(lightAct_58));
actPN_peth10_60 = cell2mat(T.peth10ms(lightAct_60));
actPN_peth10_64 = cell2mat(T.peth10ms(lightAct_64));
actPN_peth10_68 = cell2mat(T.peth10ms(lightAct_68));
actPN_peth10_70 = cell2mat(T.peth10ms(lightAct_70));
actPN_peth10_72 = cell2mat(T.peth10ms(lightAct_72));
actPN_peth10_76 = cell2mat(T.peth10ms(lightAct_76));
actPN_peth10_78 = cell2mat(T.peth10ms(lightAct_78));

actPN_peth50_48 = cell2mat(T.peth50ms(lightAct_48));
actPN_peth50_50 = cell2mat(T.peth50ms(lightAct_50));
actPN_peth50_58 = cell2mat(T.peth50ms(lightAct_58));
actPN_peth50_60 = cell2mat(T.peth50ms(lightAct_60));
actPN_peth50_64 = cell2mat(T.peth50ms(lightAct_64));
actPN_peth50_68 = cell2mat(T.peth50ms(lightAct_68));
actPN_peth50_70 = cell2mat(T.peth50ms(lightAct_70));
actPN_peth50_72 = cell2mat(T.peth50ms(lightAct_72));
actPN_peth50_76 = cell2mat(T.peth50ms(lightAct_76));
actPN_peth50_78 = cell2mat(T.peth50ms(lightAct_78));

%%
nactPN10ms_48 = size(actPN_peth10_48,1);
m_actPN_peth10ms_48 = mean(actPN_peth10_48,1);
sem_actPN_peth10ms_48 = std(actPN_peth10_48,0,1)/sqrt(nactPN10ms_48);
nactPN50ms_48 = size(actPN_peth50_48,1);
m_actPN_peth50ms_48 = mean(actPN_peth50_48,1);
sem_actPN_peth50ms_48 = std(actPN_peth50_48,0,1)/sqrt(nactPN50ms_48);

nactPN10ms_50 = size(actPN_peth10_50,1);
m_actPN_peth10ms_50 = mean(actPN_peth10_50,1);
sem_actPN_peth10ms_50 = std(actPN_peth10_50,0,1)/sqrt(nactPN10ms_50);
nactPN50ms_50 = size(actPN_peth50_50,1);
m_actPN_peth50ms_50 = mean(actPN_peth50_50,1);
sem_actPN_peth50ms_50 = std(actPN_peth50_50,0,1)/sqrt(nactPN50ms_50);

nactPN10ms_58 = size(actPN_peth10_58,1);
m_actPN_peth10ms_58 = mean(actPN_peth10_58,1);
sem_actPN_peth10ms_58 = std(actPN_peth10_58,0,1)/sqrt(nactPN10ms_58);
nactPN50ms_58 = size(actPN_peth50_58,1);
m_actPN_peth50ms_58 = mean(actPN_peth50_58,1);
sem_actPN_peth50ms_58 = std(actPN_peth50_58,0,1)/sqrt(nactPN50ms_58);

nactPN10ms_60 = size(actPN_peth10_60,1);
m_actPN_peth10ms_60 = mean(actPN_peth10_60,1);
sem_actPN_peth10ms_60 = std(actPN_peth10_60,0,1)/sqrt(nactPN10ms_60);
nactPN50ms_60 = size(actPN_peth50_60,1);
m_actPN_peth50ms_60 = mean(actPN_peth50_60,1);
sem_actPN_peth50ms_60 = std(actPN_peth50_60,0,1)/sqrt(nactPN50ms_60);

nactPN10ms_64 = size(actPN_peth10_64,1);
m_actPN_peth10ms_64 = mean(actPN_peth10_64,1);
sem_actPN_peth10ms_64 = std(actPN_peth10_64,0,1)/sqrt(nactPN10ms_64);
nactPN50ms_64 = size(actPN_peth50_64,1);
m_actPN_peth50ms_64 = mean(actPN_peth50_64,1);
sem_actPN_peth50ms_64 = std(actPN_peth50_64,0,1)/sqrt(nactPN50ms_64);

nactPN10ms_68 = size(actPN_peth10_68,1);
m_actPN_peth10ms_68 = mean(actPN_peth10_68,1);
sem_actPN_peth10ms_68 = std(actPN_peth10_68,0,1)/sqrt(nactPN10ms_68);
nactPN50ms_68 = size(actPN_peth50_68,1);
m_actPN_peth50ms_68 = mean(actPN_peth50_68,1);
sem_actPN_peth50ms_68 = std(actPN_peth50_68,0,1)/sqrt(nactPN50ms_68);

nactPN10ms_70 = size(actPN_peth10_70,1);
m_actPN_peth10ms_70 = mean(actPN_peth10_70,1);
sem_actPN_peth10ms_70 = std(actPN_peth10_70,0,1)/sqrt(nactPN10ms_70);
nactPN50ms_70 = size(actPN_peth50_70,1);
m_actPN_peth50ms_70 = mean(actPN_peth50_70,1);
sem_actPN_peth50ms_70 = std(actPN_peth50_70,0,1)/sqrt(nactPN50ms_70);

nactPN10ms_72 = size(actPN_peth10_72,1);
m_actPN_peth10ms_72 = mean(actPN_peth10_72,1);
sem_actPN_peth10ms_72 = std(actPN_peth10_72,0,1)/sqrt(nactPN10ms_72);
nactPN50ms_72 = size(actPN_peth50_72,1);
m_actPN_peth50ms_72 = mean(actPN_peth50_72,1);
sem_actPN_peth50ms_72 = std(actPN_peth50_72,0,1)/sqrt(nactPN50ms_72);

nactPN10ms_76 = size(actPN_peth10_76,1);
m_actPN_peth10ms_76 = mean(actPN_peth10_76,1);
sem_actPN_peth10ms_76 = std(actPN_peth10_76,0,1)/sqrt(nactPN10ms_76);
nactPN50ms_76 = size(actPN_peth50_76,1);
m_actPN_peth50ms_76 = mean(actPN_peth50_76,1);
sem_actPN_peth50ms_76 = std(actPN_peth50_76,0,1)/sqrt(nactPN50ms_76);

nactPN10ms_78 = size(actPN_peth10_78,1);
m_actPN_peth10ms_78 = mean(actPN_peth10_78,1);
sem_actPN_peth10ms_78 = std(actPN_peth10_78,0,1)/sqrt(nactPN10ms_78);
nactPN50ms_78 = size(actPN_peth50_78,1);
m_actPN_peth50ms_78 = mean(actPN_peth50_78,1);
sem_actPN_peth50ms_78 = std(actPN_peth50_78,0,1)/sqrt(nactPN50ms_78);

%% 48
nCol = 5;
nRow = 2;
fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{2});

hPlotPN(1) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,1,1,[0.10 0.10 0.85 0.8],wideInterval),wideInterval));
bar(5,yMaxPN(1),'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxPN(1)*0.925,10,yMaxPN(1)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarPN(1) = bar(xpt,m_actPN_peth10ms_48,'histc');
errorbarJun(xpt+1,m_actPN_peth10ms_48,sem_actPN_peth10ms_48,1,0.4,colorDarkGray);
text(100, yMaxPN(1)*0.8,['n = ',num2str(nactPN10ms_48)],'fontSize',fontM);
xlabel('Time (ms)','fontSize',fontM);
ylabel('Spikes/bin','fontSize',fontM);
title('10 ms @ 2 Hz','fontSize',fontM,'interpreter','none','fontWeight','bold');

hPlotPN(2) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,1,1,[0.10 0.10 0.85 0.8],wideInterval),wideInterval));
bar(25,yMaxPN(1),'BarWidth',50,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxPN(1)*0.925,50,yMaxPN(1)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarPN(2) = bar(xpt,m_actPN_peth50ms_48,'histc');
errorbarJun(xpt+1,m_actPN_peth50ms_48,sem_actPN_peth50ms_48,1,0.4,colorDarkGray);
xlabel('Time (ms)','fontSize',fontM);
ylabel('Spikes/bin','fontSize',fontM);
title('50 ms @ 2 Hz','fontSize',fontM,'interpreter','none','fontWeight','bold');

%% 50
hPlotPN(3) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,2,1,[0.10 0.10 0.85 0.8],wideInterval),wideInterval));
bar(5,yMaxPN(2),'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxPN(2)*0.925,10,yMaxPN(2)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarPN(3) = bar(xpt,m_actPN_peth10ms_50,'histc');
errorbarJun(xpt+1,m_actPN_peth10ms_50,sem_actPN_peth10ms_50,1,0.4,colorDarkGray);
text(100, yMaxPN(2)*0.8,['n = ',num2str(nactPN10ms_50)],'fontSize',fontM);
xlabel('Time (ms)','fontSize',fontM);
ylabel('Spikes/bin','fontSize',fontM);
title('10 ms @ 2 Hz','fontSize',fontM,'interpreter','none','fontWeight','bold');

hPlotPN(4) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,2,1,[0.10 0.10 0.85 0.8],wideInterval),wideInterval));
bar(25,yMaxPN(2),'BarWidth',50,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxPN(2)*0.925,50,yMaxPN(2)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarPN(4) = bar(xpt,m_actPN_peth50ms_50,'histc');
errorbarJun(xpt+1,m_actPN_peth50ms_50,sem_actPN_peth50ms_50,1,0.4,colorDarkGray);
xlabel('Time (ms)','fontSize',fontM);
ylabel('Spikes/bin','fontSize',fontM);
title('50 ms @ 2 Hz','fontSize',fontM,'interpreter','none','fontWeight','bold');

%% 58
hPlotPN(5) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,3,1,[0.10 0.10 0.85 0.8],wideInterval),wideInterval));
bar(5,yMaxPN(3),'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxPN(3)*0.925,10,yMaxPN(3)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarPN(5) = bar(xpt,m_actPN_peth10ms_58,'histc');
errorbarJun(xpt+1,m_actPN_peth10ms_58,sem_actPN_peth10ms_58,1,0.4,colorDarkGray);
text(100, yMaxPN(3)*0.8,['n = ',num2str(nactPN10ms_58)],'fontSize',fontM);
xlabel('Time (ms)','fontSize',fontM);
ylabel('Spikes/bin','fontSize',fontM);
title('10 ms @ 2 Hz','fontSize',fontM,'interpreter','none','fontWeight','bold');

hPlotPN(6) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,3,1,[0.10 0.10 0.85 0.8],wideInterval),wideInterval));
bar(25,yMaxPN(3),'BarWidth',50,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxPN(3)*0.925,50,yMaxPN(3)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarPN(6) = bar(xpt,m_actPN_peth50ms_58,'histc');
errorbarJun(xpt+1,m_actPN_peth50ms_58,sem_actPN_peth50ms_58,1,0.4,colorDarkGray);
xlabel('Time (ms)','fontSize',fontM);
ylabel('Spikes/bin','fontSize',fontM);
title('50 ms @ 2 Hz','fontSize',fontM,'interpreter','none','fontWeight','bold');

%% 60
hPlotPN(7) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,4,1,[0.10 0.10 0.85 0.8],wideInterval),wideInterval));
bar(5,yMaxPN(4),'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxPN(4)*0.925,10,yMaxPN(4)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarPN(7) = bar(xpt,m_actPN_peth10ms_60,'histc');
errorbarJun(xpt+1,m_actPN_peth10ms_60,sem_actPN_peth10ms_60,1,0.4,colorDarkGray);
text(100, yMaxPN(4)*0.8,['n = ',num2str(nactPN10ms_60)],'fontSize',fontM);
xlabel('Time (ms)','fontSize',fontM);
ylabel('Spikes/bin','fontSize',fontM);
title('10 ms @ 2 Hz','fontSize',fontM,'interpreter','none','fontWeight','bold');

hPlotPN(8) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,4,1,[0.10 0.10 0.85 0.8],wideInterval),wideInterval));
bar(25,yMaxPN(4),'BarWidth',50,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxPN(4)*0.925,50,yMaxPN(4)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarPN(8) = bar(xpt,m_actPN_peth50ms_60,'histc');
errorbarJun(xpt+1,m_actPN_peth50ms_60,sem_actPN_peth50ms_60,1,0.4,colorDarkGray);
xlabel('Time (ms)','fontSize',fontM);
ylabel('Spikes/bin','fontSize',fontM);
title('50 ms @ 2 Hz','fontSize',fontM,'interpreter','none','fontWeight','bold');

%% 64
% hPlotPN(9) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,5,1,[0.10 0.10 0.85 0.8],wideInterval),wideInterval));
% bar(5,yMaxPN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
% hold on;
% rectangle('Position',[0,yMaxPN*0.925,10,yMaxPN*0.075],'LineStyle','none','FaceColor',colorBlue);
% hold on;
% hBarPN(9) = bar(xpt,m_actPN_peth10ms_64,'histc');
% errorbarJun(xpt+1,m_actPN_peth10ms_64,sem_actPN_peth10ms_64,1,0.4,colorDarkGray);
% text(100, yMaxPN*0.8,['n = ',num2str(nactPN10ms_64)],'fontSize',fontM);
% xlabel('Time (ms)','fontSize',fontM);
% ylabel('Spikes/bin','fontSize',fontM);
% title('10 ms @ 2 Hz','fontSize',fontM,'interpreter','none','fontWeight','bold');
% 
% hPlotPN(10) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,5,1,[0.10 0.10 0.85 0.8],wideInterval),wideInterval));
% bar(25,yMaxPN,'BarWidth',50,'LineStyle','none','FaceColor',colorLLightBlue);
% hold on;
% rectangle('Position',[0,yMaxPN*0.925,50,yMaxPN*0.075],'LineStyle','none','FaceColor',colorBlue);
% hold on;
% hBarPN(10) = bar(xpt,m_actPN_peth50ms_64,'histc');
% errorbarJun(xpt+1,m_actPN_peth50ms_64,sem_actPN_peth50ms_64,1,0.4,colorDarkGray);
% xlabel('Time (ms)','fontSize',fontM);
% ylabel('Spikes/bin','fontSize',fontM);
% title('50 ms @ 2 Hz','fontSize',fontM,'interpreter','none','fontWeight','bold');

%% 68
% hPlotPN(11) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,1,2,[0.10 0.10 0.85 0.8],wideInterval),wideInterval));
% bar(5,yMaxPN,'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
% hold on;
% rectangle('Position',[0,yMaxPN*0.925,10,yMaxPN*0.075],'LineStyle','none','FaceColor',colorBlue);
% hold on;
% hBarPN(11) = bar(xpt,m_actPN_peth10ms_68,'histc');
% errorbarJun(xpt+1,m_actPN_peth10ms_68,sem_actPN_peth10ms_68,1,0.4,colorDarkGray);
% text(100, yMaxPN*0.8,['n = ',num2str(nactPN10ms_68)],'fontSize',fontM);
% xlabel('Time (ms)','fontSize',fontM);
% ylabel('Spikes/bin','fontSize',fontM);
% title('10 ms @ 2 Hz','fontSize',fontM,'interpreter','none','fontWeight','bold');
% 
% hPlotPN(12) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,1,2,[0.10 0.10 0.85 0.8],wideInterval),wideInterval));
% bar(25,yMaxPN,'BarWidth',50,'LineStyle','none','FaceColor',colorLLightBlue);
% hold on;
% rectangle('Position',[0,yMaxPN*0.925,50,yMaxPN*0.075],'LineStyle','none','FaceColor',colorBlue);
% hold on;
% hBarPN(12) = bar(xpt,m_actPN_peth50ms_68,'histc');
% errorbarJun(xpt+1,m_actPN_peth50ms_68,sem_actPN_peth50ms_68,1,0.4,colorDarkGray);
% xlabel('Time (ms)','fontSize',fontM);
% ylabel('Spikes/bin','fontSize',fontM);
% title('50 ms @ 2 Hz','fontSize',fontM,'interpreter','none','fontWeight','bold');

%% 70
hPlotPN(9) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,2,2,[0.10 0.10 0.85 0.8],wideInterval),wideInterval));
bar(5,yMaxPN(5),'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxPN(5)*0.925,10,yMaxPN(5)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarPN(9) = bar(xpt,m_actPN_peth10ms_70,'histc');
errorbarJun(xpt+1,m_actPN_peth10ms_70,sem_actPN_peth10ms_70,1,0.4,colorDarkGray);
text(100, yMaxPN(5)*0.8,['n = ',num2str(nactPN10ms_70)],'fontSize',fontM);
xlabel('Time (ms)','fontSize',fontM);
ylabel('Spikes/bin','fontSize',fontM);
title('10 ms @ 2 Hz','fontSize',fontM,'interpreter','none','fontWeight','bold');

hPlotPN(10) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,2,2,[0.10 0.10 0.85 0.8],wideInterval),wideInterval));
bar(25,yMaxPN(5),'BarWidth',50,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxPN(5)*0.925,50,yMaxPN(5)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarPN(10) = bar(xpt,m_actPN_peth50ms_70,'histc');
errorbarJun(xpt+1,m_actPN_peth50ms_70,sem_actPN_peth50ms_70,1,0.4,colorDarkGray);
xlabel('Time (ms)','fontSize',fontM);
ylabel('Spikes/bin','fontSize',fontM);
title('50 ms @ 2 Hz','fontSize',fontM,'interpreter','none','fontWeight','bold');

%% 72
hPlotPN(11) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,3,2,[0.10 0.10 0.85 0.8],wideInterval),wideInterval));
bar(5,yMaxPN(6),'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxPN(6)*0.925,10,yMaxPN(6)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarPN(11) = bar(xpt,m_actPN_peth10ms_72,'histc');
errorbarJun(xpt+1,m_actPN_peth10ms_72,sem_actPN_peth10ms_72,1,0.4,colorDarkGray);
text(100, yMaxPN(6)*0.8,['n = ',num2str(nactPN10ms_72)],'fontSize',fontM);
xlabel('Time (ms)','fontSize',fontM);
ylabel('Spikes/bin','fontSize',fontM);
title('10 ms @ 2 Hz','fontSize',fontM,'interpreter','none','fontWeight','bold');

hPlotPN(12) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,3,2,[0.10 0.10 0.85 0.8],wideInterval),wideInterval));
bar(25,yMaxPN(6),'BarWidth',50,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxPN(6)*0.925,50,yMaxPN(6)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarPN(12) = bar(xpt,m_actPN_peth50ms_72,'histc');
errorbarJun(xpt+1,m_actPN_peth50ms_72,sem_actPN_peth50ms_72,1,0.4,colorDarkGray);
xlabel('Time (ms)','fontSize',fontM);
ylabel('Spikes/bin','fontSize',fontM);
title('50 ms @ 2 Hz','fontSize',fontM,'interpreter','none','fontWeight','bold');

%% 76
hPlotPN(13) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,4,2,[0.10 0.10 0.85 0.8],wideInterval),wideInterval));
bar(5,yMaxPN(7),'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxPN(7)*0.925,10,yMaxPN(7)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarPN(13) = bar(xpt,m_actPN_peth10ms_76,'histc');
errorbarJun(xpt+1,m_actPN_peth10ms_76,sem_actPN_peth10ms_76,1,0.4,colorDarkGray);
text(100, yMaxPN(7)*0.8,['n = ',num2str(nactPN10ms_76)],'fontSize',fontM);
xlabel('Time (ms)','fontSize',fontM);
ylabel('Spikes/bin','fontSize',fontM);
title('10 ms @ 2 Hz','fontSize',fontM,'interpreter','none','fontWeight','bold');

hPlotPN(14) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,4,2,[0.10 0.10 0.85 0.8],wideInterval),wideInterval));
bar(25,yMaxPN(7),'BarWidth',50,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxPN(7)*0.925,50,yMaxPN(7)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarPN(14) = bar(xpt,m_actPN_peth50ms_76,'histc');
errorbarJun(xpt+1,m_actPN_peth50ms_76,sem_actPN_peth50ms_76,1,0.4,colorDarkGray);
xlabel('Time (ms)','fontSize',fontM);
ylabel('Spikes/bin','fontSize',fontM);
title('50 ms @ 2 Hz','fontSize',fontM,'interpreter','none','fontWeight','bold');

%% 78
hPlotPN(15) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRow,5,2,[0.10 0.10 0.85 0.8],wideInterval),wideInterval));
bar(5,yMaxPN(8),'BarWidth',10,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxPN(8)*0.925,10,yMaxPN(8)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarPN(15) = bar(xpt,m_actPN_peth10ms_78,'histc');
errorbarJun(xpt+1,m_actPN_peth10ms_78,sem_actPN_peth10ms_78,1,0.4,colorDarkGray);
text(100, yMaxPN(8)*0.8,['n = ',num2str(nactPN10ms_78)],'fontSize',fontM);
xlabel('Time (ms)','fontSize',fontM);
ylabel('Spikes/bin','fontSize',fontM);
title('10 ms @ 2 Hz','fontSize',fontM,'interpreter','none','fontWeight','bold');

hPlotPN(16) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRow,5,2,[0.10 0.10 0.85 0.8],wideInterval),wideInterval));
bar(25,yMaxPN(8),'BarWidth',50,'LineStyle','none','FaceColor',colorLLightBlue);
hold on;
rectangle('Position',[0,yMaxPN(8)*0.925,50,yMaxPN(8)*0.075],'LineStyle','none','FaceColor',colorBlue);
hold on;
hBarPN(16) = bar(xpt,m_actPN_peth50ms_78,'histc');
errorbarJun(xpt+1,m_actPN_peth50ms_78,sem_actPN_peth50ms_78,1,0.4,colorDarkGray);
xlabel('Time (ms)','fontSize',fontM);
ylabel('Spikes/bin','fontSize',fontM);
title('50 ms @ 2 Hz','fontSize',fontM,'interpreter','none','fontWeight','bold');

set(hBarPN(1:16),'FaceColor',colorBlack,'EdgeColor',colorBlack,'FaceAlpha',1);
set(hPlotPN(1:16),'Box','off','TickDir','out','XLim',[-10,115],'XTick',[-10:10:20,115],'fontSize',fontM);

print('-painters','-r300','-dtiff',['final_fig2_platform_pulseWidth_eachMice',datestr(now,formatOut),'.tif']);