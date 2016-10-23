% Plot properties
fontS = 5; % font size small
fontM = 7; % font size middle
fontL = 9; % font size large
lineS = 0.2; % line width small
lineM = 0.5; % line width middle
lineL = 1; % line width large

% colorBlue = [0 153 227] ./ 255;
colorBlue = [33 150 243] ./ 255;
colorLightBlue = [223 239 252] ./ 255;
colorRed = [237 50 52] ./ 255;
colorLightRed = [242 138 130] ./ 255;
colorGray = [189 189 189] ./ 255;
colorLightGray = [238, 238, 238] ./255;
colorDarkGray = [117, 117, 117] ./255;
colorYellow = [255 243 3] ./ 255;
colorLightYellow = [255 249 196] ./ 255;

tightInterval = [0.02 0.02];
wideInterval = [0.07 0.07];

markerS = 2.2;
markerM = 4.4;
markerL = 6.6;

nCol = 3;
nRow = 3;

learnLimit = [24, 24];
%% Data loading
load('MWM_Learning_DG.mat');
load('MWM_Learning_CA3.mat');
load('MWM_Learning_CA1.mat');

win_reg_CA3 = [0.5 9.5];
win_reg_CA1 = [0.5 9.5];

reg_CA3_CNO_Latency = CA3stats.rawregLatencyCNO.Coefficients.Estimate(1)+ CA3stats.rawregLatencyCNO.Coefficients.Estimate(2)*win_reg_CA3;
reg_CA3_DMSO_Latency = CA3stats.rawregLatencyDMSO.Coefficients.Estimate(1)+ CA3stats.rawregLatencyDMSO.Coefficients.Estimate(2)*win_reg_CA3;
reg_CA1_CNO_Latency = CA1stats.rawregLatencyCNO.Coefficients.Estimate(1)+ CA1stats.rawregLatencyCNO.Coefficients.Estimate(2)*win_reg_CA1;
reg_CA1_DMSO_Latency = CA1stats.rawregLatencyDMSO.Coefficients.Estimate(1)+ CA1stats.rawregLatencyDMSO.Coefficients.Estimate(2)*win_reg_CA1;

reg_CA3_CNO_Disttotal = CA3stats.rawregDisttotalCNO.Coefficients.Estimate(1)+ CA3stats.rawregDisttotalCNO.Coefficients.Estimate(2)*win_reg_CA3;
reg_CA3_DMSO_Disttotal = CA3stats.rawregDisttotalDMSO.Coefficients.Estimate(1)+ CA3stats.rawregDisttotalDMSO.Coefficients.Estimate(2)*win_reg_CA3;
reg_CA1_CNO_Disttotal = CA1stats.rawregDisttotalCNO.Coefficients.Estimate(1)+ CA1stats.rawregDisttotalCNO.Coefficients.Estimate(2)*win_reg_CA1;
reg_CA1_DMSO_Disttotal = CA1stats.rawregDisttotalDMSO.Coefficients.Estimate(1)+ CA1stats.rawregDisttotalDMSO.Coefficients.Estimate(2)*win_reg_CA1;

%% Plot
% DG latency
hLatency(1) = axes('Position',axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval));
    hErrorbar(1) = errorbar([1:9],[DG_day.CNO.MS.latency(1:9,1)],[DG_day.CNO.MS.latency(1:9,2)],'Color','k');
    hold on;
    hErrorbar(2) = errorbar([1:9],[DG_day.DMSO.MS.latency(1:9,1)],[DG_day.DMSO.MS.latency(1:9,2)],'Color','k');
    hold on;
    plot(1:9,DG_day.CNO.MS.latency(1:9,1),'Color','k','LineWidth',1.5, 'Marker','s', 'MarkerSize',markerM,'MarkerFaceColor',colorRed,'MarkerEdgeColor','k');
    hold on;
    plot(1:9,DG_day.DMSO.MS.latency(1:9,1),'Color','k','LineWidth',1.5, 'Marker','o', 'MarkerSize',markerM,'MarkerFaceColor',colorBlue,'MarkerEdgeColor','k');       
    plot(5.5,45,'Marker','s','MarkerSize',markerM,'MarkerFaceColor',colorRed,'MarkerEdgeColor','k');
    hold on;
    plot(5.5,40,'Marker','o','MarkerSize',markerM,'MarkerFaceColor',colorBlue,'MarkerEdgeColor','k');
    hold on;
    line([0, 10], learnLimit,'LineStyle',':','Color','k'); 
    hold on;
    rec = rectangle('Position',[7.5,0,3,60],'LineStyle','none','FaceColor',colorDarkGray);
    uistack(rec,'bottom');
    text(6,45, ['CNO = ', num2str(size(DG_day.CNO.latency,2))],'FontSize',fontM);
    text(6,40, ['DMSO = ', num2str(size(DG_day.DMSO.latency,2))],'FontSize',fontM);
    text(5,13, ['p-value (ttest) = ', num2str(DGstats.rawttestlatencyPval,2)],'FontSize',fontM);
    set(hLatency(1),'XLim',[0,10],'XTick',[1:9]);
    ylabel('Latency (sec)')
    title('Dentate Gyrus');

% CA3 latency   
hLatency(2) = axes('Position',axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],wideInterval));
    hErrorbar(3) = errorbar([1:10],[CA3_day.CNO.MS.latency(1:10,1)],[CA3_day.CNO.MS.latency(1:10,2)],'Color','k');
    hold on;
    hErrorbar(4) = errorbar([1:10],[CA3_day.DMSO.MS.latency(1:10,1)],[CA3_day.DMSO.MS.latency(1:10,2)],'Color','k');
    hold on;
    plot(1:10,CA3_day.CNO.MS.latency(1:10,1),'Color','k','LineWidth',1.5, 'Marker','s', 'MarkerSize',markerM,'MarkerFaceColor',colorRed,'MarkerEdgeColor','k');
    hold on;
    plot(1:10,CA3_day.DMSO.MS.latency(1:10,1),'Color','k','LineWidth',1.5, 'Marker','o', 'MarkerSize',markerM,'MarkerFaceColor',colorBlue,'MarkerEdgeColor','k');
    hold on;
    hReg(1) = plot(win_reg_CA3, reg_CA3_CNO_Latency,'color',colorRed,'LineWidth',1.5);
    hold on;
    hReg(2) = plot(win_reg_CA3, reg_CA3_DMSO_Latency,'color',colorBlue,'LineWidth',1.5);
    plot(5.5,45,'Marker','s','MarkerSize',markerM,'MarkerFaceColor',colorRed,'MarkerEdgeColor','k');
    hold on;
    plot(5.5,40,'Marker','o','MarkerSize',markerM,'MarkerFaceColor',colorBlue,'MarkerEdgeColor','k');
    hold on;
    line([0, 11],learnLimit,'LineStyle',':','Color','k'); 
    hold on;
    rec = rectangle('Position',[9.5,0,2,60],'LineStyle','none','FaceColor',colorDarkGray);
    uistack(rec,'bottom');
    text(6,45, ['CNO = ', num2str(size(CA3_day.CNO.latency,2))],'FontSize',fontM);
    text(6,40, ['DMSO = ', num2str(size(CA3_day.DMSO.latency,2))],'FontSize',fontM);
    text(1,17, ['F(',num2str(CA3stats.latencydf),',',num2str(CA3stats.latencyE),') = ', num2str(CA3stats.latencyF,2)],'FontSize',fontM);
    text(1,13, ['p-value = ', num2str(CA3stats.latencyPval,2)],'FontSize',fontM);
    text(6,15,[{'p-value', ['t-test = ', num2str(CA3stats.rawttestlatencyPval,2)]}],'FontSize',fontM);
    set(hLatency(2),'XLim',[0,11],'XTick',[1:10]);
    title('CA3');

% CA1 latency
hLatency(3) = axes('Position',axpt(nCol,nRow,3,1,[0.1 0.1 0.85 0.85],wideInterval));
    hErrorbar(5) = errorbar([1:CA1_nDay],[CA1_day.CNO.MS.latency(:,1)],[CA1_day.CNO.MS.latency(:,2)],'Color','k');
    hold on;
    hErrorbar(6) = errorbar([1:CA1_nDay],[CA1_day.DMSO.MS.latency(:,1)],[CA1_day.DMSO.MS.latency(:,2)],'Color','k');
    hold on;
    plot(1:CA1_nDay,CA1_day.CNO.MS.latency(:,1),'Color','k','LineWidth',1.5, 'Marker','s', 'MarkerSize',markerM,'MarkerFaceColor',colorRed,'MarkerEdgeColor','k');
    hold on;
    plot(1:CA1_nDay,CA1_day.DMSO.MS.latency(:,1),'Color','k','LineWidth',1.5, 'Marker','o', 'MarkerSize',markerM,'MarkerFaceColor',colorBlue,'MarkerEdgeColor','k');
    hold on;  
    hReg(3) = plot(win_reg_CA1, reg_CA1_CNO_Latency,'color',colorRed,'LineWidth',1.5);
    hold on;
    hReg(4) = plot(win_reg_CA1, reg_CA1_DMSO_Latency,'color',colorBlue,'LineWidth',1.5);
    plot(5.5,45,'Marker','o','MarkerSize',markerM,'MarkerFaceColor',colorRed,'MarkerEdgeColor','k');
    hold on;
    plot(5.5,40,'Marker','o','MarkerSize',markerM,'MarkerFaceColor',colorBlue,'MarkerEdgeColor','k');
    hold on;
    line([0, 14],learnLimit,'LineStyle',':','Color','k');     
    hold on;
    rec = rectangle('Position',[9.5,0,3,60],'LineStyle','none','FaceColor',colorDarkGray);
    uistack(rec,'bottom');
    text(6,45, ['CNO = ', num2str(size(CA1_day.CNO.latency,2))],'FontSize',fontM);
    text(6,40, ['DMSO = ', num2str(size(CA1_day.DMSO.latency,2))],'FontSize',fontM);
    text(1,17, ['F(',num2str(CA1stats.latencydf),',',num2str(CA1stats.latencyE),') = ', num2str(CA1stats.latencyF,4)],'FontSize',fontM);
    text(1,13, ['p-value = ', num2str(CA1stats.latencyPval,2)],'FontSize',fontM);
    text(6,15,[{'p-value', ['t-test = ', num2str(CA1stats.rawttestlatencyPval,2)]}],'FontSize',fontM);
    set(hLatency(3),'XLim',[0,11],'XTick',[1:10]);
    title('CA1');

    
% DG disttotal    
hDisttotal(1) = axes('Position',axpt(nCol,nRow,1,2,[0.1 0.1 0.85 0.85],wideInterval));
    hErrorbar(7) = errorbar([1:9],[DG_day.CNO.MS.disttotal(1:9,1)],[DG_day.CNO.MS.disttotal(1:9,2)],'Color','k');
    hold on;
    hErrorbar(8) = errorbar([1:9],[DG_day.DMSO.MS.disttotal(1:9,1)],[DG_day.DMSO.MS.disttotal(1:9,2)],'Color','k');
    hold on;
    plot(1:9,DG_day.CNO.MS.disttotal(1:9,1),'Color','k','LineWidth',1.5, 'Marker','s', 'MarkerSize',markerM,'MarkerFaceColor',colorRed,'MarkerEdgeColor','k');
    hold on;
    plot(1:9,DG_day.DMSO.MS.disttotal(1:9,1),'Color','k','LineWidth',1.5, 'Marker','o', 'MarkerSize',markerM,'MarkerFaceColor',colorBlue,'MarkerEdgeColor','k');
    text(6,280,['p-value (ttest) = ', num2str(DGstats.rawttestdisttotalPval,3)],'FontSize',fontM);
    set(hDisttotal(1)','XLim',[0,10],'XTick',[1:9]);
    ylabel('Distance traveled (cm)')
    

% CA3 disttotal    
hDisttotal(2) = axes('Position',axpt(nCol,nRow,2,2,[0.1 0.1 0.85 0.85],wideInterval));
    hErrorbar(9) = errorbar([1:9],[CA3_day.CNO.MS.disttotal(1:9,1)],[CA3_day.CNO.MS.disttotal(1:9,2)],'Color','k');
    hold on;
    hErrorbar(10) = errorbar([1:9],[CA3_day.DMSO.MS.disttotal(1:9,1)],[CA3_day.DMSO.MS.disttotal(1:9,2)],'Color','k');
    hold on;
    plot(1:9,CA3_day.CNO.MS.disttotal(1:9,1),'Color','k','LineWidth',1.5, 'Marker','s', 'MarkerSize',markerM,'MarkerFaceColor',colorRed,'MarkerEdgeColor','k');
    hold on;
    plot(1:9,CA3_day.DMSO.MS.disttotal(1:9,1),'Color','k','LineWidth',1.5, 'Marker','o', 'MarkerSize',markerM,'MarkerFaceColor',colorBlue,'MarkerEdgeColor','k');
    hold on;
    hReg(7) = plot(win_reg_CA3, reg_CA3_CNO_Disttotal,'color',colorRed,'LineWidth',1.5);
    hold on;
    hReg(8) = plot(win_reg_CA3, reg_CA3_DMSO_Disttotal,'color',colorBlue,'LineWidth',1.5);
    text(1,350, ['F(',num2str(CA3stats.disttotaldf),',',num2str(CA3stats.disttotalE),') = ', num2str(CA3stats.disttotalF,4)],'FontSize',fontM);
    text(1,280, ['p-value = ', num2str(CA3stats.disttotalPval,3)],'FontSize',fontM);
    text(6,320,[{'p-value', ['t-test = ', num2str(CA3stats.rawttestdisttotalPval,2)]}],'FontSize',fontM);
    set(hDisttotal(2),'XLim',[0,11],'XTick',[1:10]);
    

% CA1 disttotal
hDisttotal(3) = axes('Position',axpt(nCol,nRow,3,2,[0.1 0.1 0.85 0.85],wideInterval));
    hErrorbar(9) = errorbar([1:CA1_nDay],[CA1_day.CNO.MS.disttotal(:,1)],[CA1_day.CNO.MS.disttotal(:,2)],'Color','k');
    hold on;
    hErrorbar(10) = errorbar([1:CA1_nDay],[CA1_day.DMSO.MS.disttotal(:,1)],[CA1_day.DMSO.MS.disttotal(:,2)],'Color','k');
    hold on;
    plot(1:CA1_nDay,CA1_day.CNO.MS.disttotal(:,1),...
        'Color','k','LineWidth',1.5, 'Marker','s', 'MarkerSize',markerM,'MarkerFaceColor',colorRed,'MarkerEdgeColor','k');
    hold on;    
    plot(1:CA1_nDay,CA1_day.DMSO.MS.disttotal(:,1),...
        'Color','k','LineWidth',1.5, 'Marker','o', 'MarkerSize',markerM,'MarkerFaceColor',colorBlue,'MarkerEdgeColor','k');
    hold on;
    hReg(7) = plot(win_reg_CA1, reg_CA1_CNO_Disttotal,'color',colorRed,'LineWidth',1.5);
    hold on;
    hReg(8) = plot(win_reg_CA1, reg_CA1_DMSO_Disttotal,'color',colorBlue,'LineWidth',1.5);
    text(1,350, ['F(',num2str(CA1stats.disttotaldf),',',num2str(CA1stats.disttotalE),') = ', num2str(CA1stats.disttotalF,4)],'FontSize',fontM);
    text(1,280, ['p-value = ', num2str(CA1stats.disttotalPval,3)],'FontSize',fontM);
    text(9,320,[{'p-value', ['t-test = ', num2str(CA1stats.rawttestdisttotalPval,2)]}],'FontSize',fontM);
    set(hDisttotal(3),'XLim',[0,11],'XTick',[1:11]);
   
% Mean distance to target
hMeandist2tar(1) = axes('Position',axpt(nCol,nRow,1,3,[0.1 0.1 0.85 0.85],wideInterval));
    hErrorbar(11) = errorbar([1:9],[DG_day.CNO.MS.meandist2target(1:9,1)],[DG_day.CNO.MS.meandist2target(1:9,2)],'Color','k');
    hold on;
    hErrorbar(12) = errorbar([1:9],[DG_day.DMSO.MS.meandist2target(1:9,1)],[DG_day.DMSO.MS.meandist2target(1:9,2)],'Color','k');
    hold on;
    plot(1:9,DG_day.CNO.MS.meandist2target(1:9,1),'Color','k','LineWidth',1.5, 'Marker','s', 'MarkerSize',markerM,'MarkerFaceColor',colorRed,'MarkerEdgeColor','k');
    hold on;
    plot(1:9,DG_day.DMSO.MS.meandist2target(1:9,1),'Color','k','LineWidth',1.5, 'Marker','o', 'MarkerSize',markerM,'MarkerFaceColor',colorBlue,'MarkerEdgeColor','k');
    set(hMeandist2tar(1),'XLim',[0,10],'XTick',[1:9]);
    ylabel('Mean dist. to target (cm)');
    xlabel('Day');

hMeandist2tar(2) = axes('Position',axpt(nCol,nRow,2,3,[0.1 0.1 0.85 0.85],wideInterval));
    hErrorbar(13) = errorbar([1:9],[CA3_day.CNO.MS.meandist2target(1:9,1)],[CA3_day.CNO.MS.meandist2target(1:9,2)],'Color','k');
    hold on;
    hErrorbar(14) = errorbar([1:9],[CA3_day.DMSO.MS.meandist2target(1:9,1)],[CA3_day.DMSO.MS.meandist2target(1:9,2)],'Color','k');
    hold on;
    plot(1:9,CA3_day.CNO.MS.meandist2target(1:9,1),'Color','k','LineWidth',1.5, 'Marker','s', 'MarkerSize',markerM,'MarkerFaceColor',colorRed,'MarkerEdgeColor','k');
    hold on;
    plot(1:9,CA3_day.DMSO.MS.meandist2target(1:9,1),'Color','k','LineWidth',1.5, 'Marker','o', 'MarkerSize',markerM,'MarkerFaceColor',colorBlue,'MarkerEdgeColor','k');
    set(hMeandist2tar(2),'XLim',[0,11],'XTick',[1:10]);
    xlabel('Day');
    
hMeandist2tar(3) = axes('Position',axpt(nCol,nRow,3,3,[0.1 0.1 0.85 0.85],wideInterval));
    hErrorbar(11) = errorbar([1:CA1_nDay],[CA1_day.CNO.MS.meandist2target(:,1)],[CA1_day.CNO.MS.meandist2target(:,2)],'Color','k');
    hold on;
    hErrorbar(12) = errorbar([1:CA1_nDay],[CA1_day.DMSO.MS.meandist2target(:,1)],[CA1_day.DMSO.MS.meandist2target(:,2)],'Color','k');
    hold on;
    plot(1:CA1_nDay,CA1_day.CNO.MS.meandist2target(:,1),'Color','k','LineWidth',1.5, 'Marker','s', 'MarkerSize',markerM,'MarkerFaceColor',colorRed,'MarkerEdgeColor','k');
    hold on;
    plot(1:CA1_nDay,CA1_day.DMSO.MS.meandist2target(:,1),'Color','k','LineWidth',1.5, 'Marker','o', 'MarkerSize',markerM,'MarkerFaceColor',colorBlue,'MarkerEdgeColor','k');
    set(hMeandist2tar(3),'XLim',[0,11],'XTick',[1:11]);
    xlabel('Day');
    
    set(hLatency,'Box','off','TickDir','out','Ylim',[0,60],'YTick',[0,10,24,30,40,50],'YTickLabel',{0;10;24;30;40;50});
    set(hDisttotal,'Box','off','TickDir','out','Ylim',[200,1000]);
    set(hMeandist2tar,'Box','off','TickDir','out','Ylim',[30, 55]);
    %% Save file
    print(gcf,'-dtiff','-r300','Learning_Total');
