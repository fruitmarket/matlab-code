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

% Set variables
nCol = 3;
nRow = 2;
wideInterval = [0.07, 0.07];

width = 0.95;
barXpt.DMSO = 1:4;
barXpt.CNO = 7:10;
colorDMSO = [207, 216, 220]./255;
colorCNO = [38, 50, 56]./255;
fontL = 10;
fontM = 7;
fontS = 5;
tickLabel = ['NE';'SE';'SW';'NW'];
group = {'NE','SE','SW','NW'};
barXvalue = [];

%
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

% Statistics
p.Rbp4.DMSO.anova = anova1(Rbp4.probeQuadDMSO.raw',[],'off');
p.Rbp4.CNO.anova = anova1(Rbp4.probeQuadCNO.raw',[],'off');
p.Grik4.DMSO.anova = anova1(Grik4.probeQuadDMSO.raw',[],'off');
p.Grik4.CNO.anova = anova1(Grik4.probeQuadCNO.raw',[],'off');
[p.Camk2a.DMSO.anova,tbl,stats] = anova1(Camk2a.probeQuadDMSO.raw',[],'off');
p.Camk2a.CNO.anova = anova1(Camk2a.probeQuadCNO.raw',[],'off');

[~,pRbp4ttest] = ttest2(Rbp4.probeQuadDMSO.raw(4,:)',Rbp4.probeQuadCNO.raw(4,:)','Vartype','Unequal');
[~,pGrik4ttest] = ttest2(Grik4.probeQuadDMSO.raw(4,:)',Grik4.probeQuadCNO.raw(4,:)','Vartype','Unequal');
[~,pCamk2attest] = ttest2(Camk2a.probeQuadDMSO.raw(4,:)',Camk2a.probeQuadCNO.raw(4,:)','Vartype','Unequal');



hBar(1) = axes('Position',axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval));
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
    text(1,50,['DMSO (n=',num2str(Rbp4.nDMSO),')'],'FontSize',fontM);
    text(7,50,['CNO (n=',num2str(Rbp4.nCNO),')'],'FontSize',fontM);
    text(1.75,5,'S','FontSize',6.5,'FontWeight','bold');
    text(3.75,5,'G','FOntSize',6.5,'FontWeight','bold');
    text(7.75,5,'S','FontSize',6.5,'FontWeight','bold','Color',colorDMSO);
    text(9.75,5,'G','FontSize',6.5,'FontWeight','bold','Color',colorDMSO);
    title('DG');
    ylabel('Time (%)');
    set(gca,'FontSize',5);
    
hBar(2) = axes('Position',axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],wideInterval));
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
    text(1,50,['DMSO (n=',num2str(Grik4.nDMSO),')'],'FontSize',fontM);
    text(7,50,['CNO (n=',num2str(Grik4.nCNO),')'],'FontSize',fontM);
    text(1.75,5,'S','FontSize',6.5,'FontWeight','bold');
    text(3.75,5,'G','FOntSize',6.5,'FontWeight','bold');
    text(7.75,5,'S','FontSize',6.5,'FontWeight','bold','Color',colorDMSO);
    text(9.75,5,'G','FontSize',6.5,'FontWeight','bold','Color',colorDMSO);
    title('CA3');
    set(gca,'FontSize',5);
hBar(3) = axes('Position',axpt(nCol,nRow,3,1,[0.1 0.1 0.85 0.85],wideInterval));
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
    text(1,50,['DMSO (n=',num2str(Camk2a.nDMSO),')'],'FontSize',fontM);
    text(7,50,['CNO (n=',num2str(Camk2a.nCNO),')'],'FontSize',fontM);
    text(1.75,5,'S','FontSize',6.5,'FontWeight','bold');
    text(3.75,5,'G','FOntSize',6.5,'FontWeight','bold');
    text(7.75,5,'S','FontSize',6.5,'FontWeight','bold','Color',colorDMSO);
    text(9.75,5,'G','FontSize',6.5,'FontWeight','bold','Color',colorDMSO);
    
    title('CA1')
    set(gca,'FontSize',5);

set(hBar,'XLim',[0,12],'YLim',[0,60],'XTick',[1:4,7:10],'XTickLabel',tickLabel,'TickDir','out');

hText(1) = axes('Position',axpt(nCol,nRow,1,2,[],wideInterval));
hold on;
text(0.4,1,['p = ',num2str(pRbp4ttest,3), ' (t-test)'],'FontSize',fontM);

hText(2) = axes('Position',axpt(nCol,nRow,2,2,[],wideInterval));
hold on;
text(0.4,1,['p = ',num2str(pGrik4ttest,3), ' (t-test)'],'FontSize',fontM);

hText(3) = axes('Position',axpt(nCol,nRow,3,2,[],wideInterval));
hold on;
text(0.4,1,['p = ',num2str(pCamk2attest,3), ' (t-test)'],'FontSize',fontM);

set(hText,'Visible','off');
print(gcf,'-dtiff','-r300','Retrieval test')
