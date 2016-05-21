clearvars; close;

%% Data load
load Retrieval_Rbp4.mat
Rbp4.probeQuadCNO = probeQuadCNO;
Rbp4.probeQuadDMSO = probeQuadDMSO;
Rbp4.nCNO = nCNO;
Rbp4.nDMSO = nDMSO;
load Retrieval_Grik4.mat
Grik4.probeQuadCNO = probeQuadCNO;
Grik4.probeQuadDMSO = probeQuadDMSO;
Grik4.nCNO = nCNO;
Grik4.nDMSO = nDMSO;
load Retrieval_Camk2a.mat
Camk2a.probeQuadCNO = probeQuadCNO;
Camk2a.probeQuadDMSO = probeQuadDMSO;
Camk2a.nCNO = nCNO;
Camk2a.nDMSO = nDMSO;
clear probeQuadCNO probeQuadDMSO

barXvalue = [];


barYvalue.Rbp4 = [Rbp4.probeQuadDMSO.NE(1), Rbp4.probeQuadDMSO.SE(1), Rbp4.probeQuadDMSO.SW(1), Rbp4.probeQuadDMSO.NW(1);...
    Rbp4.probeQuadCNO.NE(1),Rbp4.probeQuadCNO.SE(1),Rbp4.probeQuadCNO.SW(1),Rbp4.probeQuadCNO.NW(1)];

barEvalue.Rbp4 = [Rbp4.probeQuadDMSO.NE(2), Rbp4.probeQuadDMSO.SE(2), Rbp4.probeQuadDMSO.SW(2), Rbp4.probeQuadDMSO.NW(2);...
    Rbp4.probeQuadCNO.NE(2),Rbp4.probeQuadCNO.SE(2),Rbp4.probeQuadCNO.SW(2),Rbp4.probeQuadCNO.NW(2)];

barYvalue.Grik4 = [Grik4.probeQuadDMSO.NE(1), Grik4.probeQuadDMSO.SE(1), Grik4.probeQuadDMSO.SW(1), Grik4.probeQuadDMSO.NW(1);...
    Grik4.probeQuadCNO.NE(1),Grik4.probeQuadCNO.SE(1),Grik4.probeQuadCNO.SW(1),Grik4.probeQuadCNO.NW(1)];

barEvalue.Grik4 = [Grik4.probeQuadDMSO.NE(2), Grik4.probeQuadDMSO.SE(2), Grik4.probeQuadDMSO.SW(2), Grik4.probeQuadDMSO.NW(2);...
    Grik4.probeQuadCNO.NE(2),Grik4.probeQuadCNO.SE(2),Grik4.probeQuadCNO.SW(2),Grik4.probeQuadCNO.NW(2)];

barYvalue.Camk2a = [Camk2a.probeQuadDMSO.NE(1), Camk2a.probeQuadDMSO.SE(1), Camk2a.probeQuadDMSO.SW(1), Camk2a.probeQuadDMSO.NW(1);...
    Camk2a.probeQuadCNO.NE(1),Camk2a.probeQuadCNO.SE(1),Camk2a.probeQuadCNO.SW(1),Camk2a.probeQuadCNO.NW(1)];

barEvalue.Camk2a = [Camk2a.probeQuadDMSO.NE(2), Camk2a.probeQuadDMSO.SE(2), Camk2a.probeQuadDMSO.SW(2), Camk2a.probeQuadDMSO.NW(2);...
    Camk2a.probeQuadCNO.NE(2),Camk2a.probeQuadCNO.SE(2),Camk2a.probeQuadCNO.SW(2),Camk2a.probeQuadCNO.NW(2)];

nCol = 3;
nRow = 2;
wideInterval = [0.07, 0.07];

width = 0.95;
barXpt.DMSO = 1:4;
barXpt.CNO = 7:10;
colorDMSO = [207, 216, 220]./255;
colorCNO = [38, 50, 56]./255;
tickLabel = ['NE';'SE';'SW';'NW'];
hBar(1) = axes('Position',axpt(nCol,nRow,1,1,[],wideInterval));
    hold on
    for iStrata = 1:4
        h.barRbp4_DMSO(iStrata) = bar(barXpt.DMSO(iStrata),barYvalue.Rbp4(1,iStrata),width,'FaceColor',colorDMSO,'LineWidth',1,'EdgeColor',colorCNO);
        h.errorbar.Rbp4_DMSO(iStrata) = errorbar(barXpt.DMSO(iStrata),barYvalue.Rbp4(1,iStrata),barEvalue.Rbp4(1,iStrata),'color','k','LineWidth',0.5);
        hold on
    end
    for iStrata = 1:4
        hold on;
        h.barRbp4_CNO(iStrata) = bar(barXpt.CNO(iStrata),barYvalue.Rbp4(2,iStrata),width,'FaceColor',colorCNO,'LineWidth',1,'EdgeColor',colorDMSO);
        h.errorbar.Rbp4_CNO(iStrata) = errorbar(barXpt.CNO(iStrata),barYvalue.Rbp4(2,iStrata),barEvalue.Rbp4(2,iStrata),'color','k');
    end
    text(1,50,['DMSO (n=',num2str(Rbp4.nDMSO),')']);
    text(7,50,['CNO (n=',num2str(Rbp4.nCNO),')']);
    text(3.85,10,'G','FontSize',6.5,'FontWeight','bold');
    text(1.85,10,'S','FOntSize',6.5,'FontWeight','bold');
    title('DG');
    ylabel('Time (%)');
    set(gca,'FontSize',7);
    
hBar(2) = axes('Position',axpt(nCol,nRow,2,1,[],wideInterval));
    hold on
    for iStrata = 1:4
        h.barGrik4_DMSO(iStrata) = bar(barXpt.DMSO(iStrata),barYvalue.Grik4(1,iStrata),width,'FaceColor',colorDMSO,'LineWidth',1,'EdgeColor',colorCNO);
        h.errorbar.Grik4_DMSO(iStrata) = errorbar(barXpt.DMSO(iStrata),barYvalue.Grik4(1,iStrata),barEvalue.Grik4(1,iStrata),'color','k');
        hold on;
    end
    hold on;
    for iStrata = 1:4
        h.barGrik4_CNO(iStrata) = bar(barXpt.CNO(iStrata),barYvalue.Grik4(2,iStrata),width,'FaceColor',colorCNO,'LineWidth',1,'EdgeColor',colorDMSO);
        h.errorbar.Grik4_CNO(iStrata) = errorbar(barXpt.CNO(iStrata),barYvalue.Grik4(2,iStrata),barEvalue.Grik4(2,iStrata),'color','k');
        hold on;
    end
    text(1,50,['DMSO (n=',num2str(Grik4.nDMSO),')']);
    text(7,50,['CNO (n=',num2str(Grik4.nCNO),')']);
    title('CA3');
    set(gca,'FontSize',7);
hBar(3) = axes('Position',axpt(nCol,nRow,3,1,[],wideInterval));
    hold on
    for iStrata = 1:4
        h.barCamk2a_DMSO(iStrata) = bar(barXpt.DMSO(iStrata),barYvalue.Camk2a(1,iStrata),width,'FaceColor',colorDMSO,'LineWidth',1,'EdgeColor',colorCNO);
        h.errorbar.Camk2a_DMSO(iStrata) = errorbar(barXpt.DMSO(iStrata),barYvalue.Camk2a(1,iStrata),barEvalue.Camk2a(1,iStrata),'color','k');
        hold on;
    end
    for iStrata = 1:4
        h.barCamk2a_CNO(iStrata) = bar(barXpt.CNO(iStrata),barYvalue.Camk2a(2,iStrata),width,'FaceColor',colorCNO,'LineWidth',1,'EdgeColor',colorDMSO);
        h.errorbar.Camk2a_CNO(iStrata) = errorbar(barXpt.CNO(iStrata),barYvalue.Camk2a(2,iStrata),barEvalue.Camk2a(2,iStrata),'color','k');
        hold on;
    end
    text(1,50,['DMSO (n=',num2str(Camk2a.nDMSO),')']);
    text(7,50,['CNO (n=',num2str(Camk2a.nCNO),')']);
    title('CA1')
    set(gca,'FontSize',7);

set(hBar,'XLim',[0,12],'YLim',[0,60],'XTick',[1:4,7:10],'XTickLabel',tickLabel,'TickDir','out');

print(gcf,'-dtiff','-r300','Retrieval test')
