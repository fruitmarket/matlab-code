clearvars;

%% Data load
load Retrieval_Rbp4.mat
Rbp4.probeQuadCNO = probeQuadCNO;
Rbp4.probeQuadDMSO = probeQuadDMSO;

load Retrieval_Grik4.mat
Grik4.probeQuadCNO = probeQuadCNO;
Grik4.probeQuadDMSO = probeQuadDMSO;

load Retrieval_Camk2a.mat
Camk2a.probeQuadCNO = probeQuadCNO;
Camk2a.probeQuadDMSO = probeQuadDMSO;

clear probeQuadCNO probeQuadDMSO

%%
nCol = 3;
nRow = 2;
wideInterval = [0.07, 0.07];

%%

% barYvalue = [Rbp4.probeQuadDMSO.NE(1),Rbp4.probeQuadCNO.NE(1);Rbp4.probeQuadDMSO.SE(1),Rbp4.probeQuadCNO.SE(1);...
%     Rbp4.probeQuadDMSO.SW(1),Rbp4.probeQuadCNO.SW(1);Rbp4.probeQuadDMSO.NW(1),Rbp4.probeQuadCNO.NW(1)];
% barError = [Rbp4.probeQuadDMSO.NE(2),Rbp4.probeQuadCNO.NE(2);Rbp4.probeQuadDMSO.SE(2),Rbp4.probeQuadCNO.SE(2);...
%     Rbp4.probeQuadDMSO.SW(2),Rbp4.probeQuadCNO.SW(2);Rbp4.probeQuadDMSO.NW(2),Rbp4.probeQuadCNO.NW(2)];

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

width = 0.95;
barXpt = 1:4;
colorDMSO = [1,0,1];
hBar(1) = axes('Position',axpt(nCol,nRow,1,1,[],wideInterval));
    hold on
    for iStrata = 1:4
        h.barRbp4_DMSO(iStrata) = bar(barXpt(iStrata),barYvalue.Rbp4(1,iStrata),width,'FaceColor',colorDMSO);
        h.errorbar_DMSO(iStrata) = errorbar(barXpt(iStrata),barYvalue.Rbp4(1,iStrata),barEvalue.Rbp4(2,iStrata));
    hold on
    end
    
    
%     [b,e] = errorbarbar(barXvalue,barYvalue.Rbp4,barEvalue.Rbp4);
    ylabel('Time (%)');
    title('DG');
    
hBar(2) = axes('Position',axpt(nCol,nRow,2,1,[],wideInterval));
    hold on
    h_barGrik4 = bar(barYvalue.Grik4);
    hold on
    title('Grik4');
%     errorbarbar(barYvalue.Grik4,barEvalue.Grik4);
    
hBar(3) = axes('Position',axpt(nCol,nRow,3,1,[],wideInterval));
    hold on
    h_barCamk2a = bar(barYvalue.Camk2a);
    hold on
    title('Camk2a');
%     errorbarbar(barYvalue.Camk2a,barEvalue.Camk2a);
    
%     set(hBar,'YLim',[0,40],'XLim',[0.5,2.5]);
    
    
    
