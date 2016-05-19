Rbp4 = load('Rbp4.mat');
Grik4 = load('Grik4.mat');
Camk2a = load('Camk2a.mat');

%% Plot
% figure properties
lineWth = [1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75];
fontS = 4; % font size small
fontM = 6; % font size middle
fontL = 8; % font size large
lineS = 0.2; % line width small
lineM = 0.5; % line width middle
lineL = 1; % line width large

colorBlue = [33 150 243] ./ 255;
colorLightBlue = [223 239 252] ./ 255;
colorRed = [237 50 52] ./ 255;
colorLightRed = [242 138 130] ./ 255;
colorGray = [204 204 204] ./ 255;
colorYellow = [255 243 3] ./ 255;
colorLightYellow = [255 249 196] ./ 255;

tightInterval = [0.02 0.02];
wideInterval = [0.07 0.07];

markerS = 2.2;
markerM = 4.4;
markerL = 6.6;

nCol = 3;
nRowSub = 8; % for the left column
nRowMain = 2; % for the main figure

% firing rate of Rbp4 CNO & DMSO
hfrRate(1) = axes('Position',axpt(nCol,nRowMain,1,1,[],wideInterval));
    hold on;
    hRbpbar(1) = bar(1,Rbp4.ms_CNOfrBaseTen(1),0.3,...
        'FaceColor',colorRed,'EdgeColor','k');
    hold on;
    hRbpbar(2) = bar(1.5,Rbp4.ms_CNOfrTestTen(1),0.3,...
        'FaceColor',colorRed,'EdgeColor','k');
    hold on;
    hRbpbar(3) = bar(2.5,Rbp4.ms_DMSOfrBaseTen(1),0.3,...
        'FaceColor',colorBlue,'EdgeColor','k');
    hold on;
    hRbpbar(4) = bar(3,Rbp4.ms_DMSOfrTestTen(1),0.3,...
        'FaceColor',colorBlue,'EdgeColor','k');
    
    hRbpError(1) = errorbar(1,Rbp4.ms_CNOfrBaseTen(:,1),Rbp4.ms_CNOfrBaseTen(:,2),'Color','k');
    hRbpError(2) = errorbar(1.5,Rbp4.ms_CNOfrTestTen(:,1),Rbp4.ms_CNOfrTestTen(:,2),'Color','k');
    hRbpError(3) = errorbar(2.5,Rbp4.ms_DMSOfrBaseTen(:,1),Rbp4.ms_DMSOfrBaseTen(:,2),'Color','k');
    hRbpError(4) = errorbar(3,Rbp4.ms_DMSOfrTestTen(:,1),Rbp4.ms_DMSOfrTestTen(:,2),'Color','k');
    
    text(2.5,1.9, ['CNO = ',num2str(Rbp4.nCNO)],'FontSize',fontL,'Color',colorRed,'FontWeight','bold');
    text(2.5,1.75, ['DMSO = ', num2str(Rbp4.nDMSO)],'FontSize',fontL,'Color',colorBlue,'FontWeight','bold');
    ylabel('Firing rate (Hz)','FontSize',8);

% Normalized firing rate of Rbp4 CNO & DMSO
hfrRate(2) = axes('Position',axpt(nCol,nRowMain,1,2,[],wideInterval));
    hold on;
    hRbpbar(5) = bar(1,mean(Rbp4.CNOfrBaseTen./Rbp4.CNOfrBaseTen),0.3,...
        'FaceColor',colorRed,'EdgeColor','k');
    hold on;
    hRbpbar(6) = bar(1.5,Rbp4.ms_norCNOTen(1),0.3,...
        'FaceColor',colorRed,'EdgeColor','k');
    hold on;
    hRbpbar(7) = bar(2.5,mean(Rbp4.DMSOfrBaseTen./Rbp4.DMSOfrBaseTen),0.3,...
        'FaceColor',colorBlue,'EdgeColor','k');
    hold on;
    hRbpbar(8) = bar(3,Rbp4.ms_norDMSOTen(1),0.3,...
        'FaceColor',colorBlue,'EdgeColor','k');
    ylabel('Normalized firing rate (Hz)','FontSize',8);
    
   
% firing rate of Grik4 CNO & DMSO
hfrRate(3) = axes('Position',axpt(nCol,nRowMain,2,1,[],wideInterval));
    hold on;
    hGrik4bar(1) = bar(1,Grik4.ms_CNOfrBaseTen(1),0.3,...
        'FaceColor',colorRed,'EdgeColor','k');
    hold on;
    hGrik4bar(2) = bar(1.5,Grik4.ms_CNOfrTestTen(1),0.3,...
        'FaceColor',colorRed,'EdgeColor','k');
    hold on;
    hGrik4bar(3) = bar(2.5,Grik4.ms_DMSOfrBaseTen(1),0.3,...
        'FaceColor',colorBlue,'EdgeColor','k');
    hold on;
    hGrik4bar(4) = bar(3,Grik4.ms_DMSOfrTestTen(1),0.3,...
        'FaceColor',colorBlue,'EdgeColor','k');
    
    hGrik4Error(1) = errorbar(1,Grik4.ms_CNOfrBaseTen(:,1),Grik4.ms_CNOfrBaseTen(:,2),'Color','k');
    hGrik4Error(2) = errorbar(1.5,Grik4.ms_CNOfrTestTen(:,1),Grik4.ms_CNOfrTestTen(:,2),'Color','k');
    hGrik4Error(3) = errorbar(2.5,Grik4.ms_DMSOfrBaseTen(:,1),Grik4.ms_DMSOfrBaseTen(:,2),'Color','k');
    hGrik4Error(4) = errorbar(3,Grik4.ms_DMSOfrTestTen(:,1),Grik4.ms_DMSOfrTestTen(:,2),'Color','k');
    
    text(2.5,1.9, ['CNO = ',num2str(Grik4.nCNO)],'FontSize',fontL,'Color',colorRed,'FontWeight','bold');
    text(2.5,1.75, ['DMSO = ', num2str(Grik4.nDMSO)],'FontSize',fontL,'Color',colorBlue,'FontWeight','bold');


% Normalized firing rate of Grik4 CNO & DMSO
hfrRate(4) = axes('Position',axpt(nCol,nRowMain,2,2,[],wideInterval));
    hold on;
    hGrik4bar(5) = bar(1,mean(Grik4.CNOfrBaseTen./Grik4.CNOfrBaseTen),0.3,...
        'FaceColor',colorRed,'EdgeColor','k');
    hold on;
    hGrik4bar(6) = bar(1.5,Grik4.ms_norCNOTen(1),0.3,...
        'FaceColor',colorRed,'EdgeColor','k');
    hold on;
    hGrik4bar(7) = bar(2.5,mean(Grik4.DMSOfrBaseTen./Grik4.DMSOfrBaseTen),0.3,...
        'FaceColor',colorBlue,'EdgeColor','k');
    hold on;
    hGrik4bar(8) = bar(3,Grik4.ms_norDMSOTen(1),0.3,...
        'FaceColor',colorBlue,'EdgeColor','k');
        
    
% firing rate of Camk2a CNO & DMSO
hfrRate(5) = axes('Position',axpt(nCol,nRowMain,3,1,[],wideInterval));
    hold on;
    hCamk2abar(1) = bar(1,Camk2a.ms_CNOfrBaseTen(1),0.3,...
        'FaceColor',colorRed,'EdgeColor','k');
    hold on;
    hCamk2abar(2) = bar(1.5,Camk2a.ms_CNOfrTestTen(1),0.3,...
        'FaceColor',colorRed,'EdgeColor','k');
    hold on;
    hCamk2abar(3) = bar(2.5,Camk2a.ms_DMSOfrBaseTen(1),0.3,...
        'FaceColor',colorBlue,'EdgeColor','k');
    hold on;
    hCamk2abar(4) = bar(3,Camk2a.ms_DMSOfrTestTen(1),0.3,...
        'FaceColor',colorBlue,'EdgeColor','k');
    
    hCamk2aError(1) = errorbar(1,Camk2a.ms_CNOfrBaseTen(:,1),Camk2a.ms_CNOfrBaseTen(:,2),'Color','k');
    hCamk2aError(2) = errorbar(1.5,Camk2a.ms_CNOfrTestTen(:,1),Camk2a.ms_CNOfrTestTen(:,2),'Color','k');
    hCamk2aError(3) = errorbar(2.5,Camk2a.ms_DMSOfrBaseTen(:,1),Camk2a.ms_DMSOfrBaseTen(:,2),'Color','k');
    hCamk2aError(4) = errorbar(3,Camk2a.ms_DMSOfrTestTen(:,1),Camk2a.ms_DMSOfrTestTen(:,2),'Color','k');

    text(2.5,1.9, ['CNO = ',num2str(Camk2a.nCNO)],'FontSize',fontL,'Color',colorRed,'FontWeight','bold');
    text(2.5,1.75, ['DMSO = ', num2str(Camk2a.nDMSO)],'FontSize',fontL,'Color',colorBlue,'FontWeight','bold');


% Normalized firing rate of CNO & DMSO
hfrRate(6) = axes('Position',axpt(nCol,nRowMain,3,2,[],wideInterval));
    hold on;
    hCamk2abar(5) = bar(1,mean(Camk2a.CNOfrBaseTen./Camk2a.CNOfrBaseTen),0.3,...
        'FaceColor',colorRed,'EdgeColor','k');
    hold on;
    hCamk2abar(6) = bar(1.5,Camk2a.ms_norCNOTen(1),0.3,...
        'FaceColor',colorRed,'EdgeColor','k');
    hold on;
    hCamk2abar(7) = bar(2.5,mean(Camk2a.DMSOfrBase./Camk2a.DMSOfrBase),0.3,...
        'FaceColor',colorBlue,'EdgeColor','k');
    hold on;
    hCamk2abar(8) = bar(3,Camk2a.ms_norDMSOTen(1),0.3,...
        'FaceColor',colorBlue,'EdgeColor','k');

    set(hfrRate([1,3,5]),'YLim',[0, 2],'LineWidth',lineL);
    set(hfrRate([2,4,6]),'YLim',[0, 1.5],'LineWidth',lineL);
    set(hfrRate,'TickDir','out','Box','off','XTick',[]);
    
    print(gcf,'-dtiff','-r300','DREADDs Acute');