clc; clearvars; close all;
% File load
mFile = FindFiles('*.mat','CheckSubdirs',0);
nFile = length(mFile);

CNOfrBase = [];
CNOfrBaseTen = [];
CNOfrTest = [];
CNOfrTestTen = [];

DMSOfrBase = [];
DMSOfrBaseTen = [];
DMSOfrTest = [];
DMSOfrTestTen = [];

frNormalized = [];

for iFile = 1:nFile
    [filePath, fileName, ~] = fileparts(mFile{iFile});
    if isempty(strfind(mFile{iFile},'DMSO'))
        load(mFile{iFile},'frBase','frBaseTen','frTest','frTestTen');
        if frBase>0.1 && frBase<5
            CNOfrBase = [CNOfrBase; frBase];
            CNOfrBaseTen = [CNOfrBaseTen; frBaseTen];
            CNOfrTest = [CNOfrTest; frTest];
            CNOfrTestTen = [CNOfrTestTen; frTestTen];
        end
    else
        load(mFile{iFile},'frBase','frBaseTen','frTest','frTestTen');
        if frBase>0.1 && frBase<5
            DMSOfrBase = [DMSOfrBase; frBase];
            DMSOfrBaseTen = [DMSOfrBaseTen; frBaseTen];
            DMSOfrTest = [DMSOfrTest; frTest];
            DMSOfrTestTen = [DMSOfrTestTen; frTestTen];
        end
    end
    if ~isempty(strfind(mFile{1},'Camk2a'))
        miceLine = 'Camk2a';
    elseif ~isempty(strfind(mFile{1},'Grik4'))
        miceLine = 'Grik4';
    else ~isempty(strfind(mFile{1},'Rbp4'));
        miceLine = 'Rbp4';
    end
end

nCNO = length(CNOfrBaseTen);
nDMSO = length(DMSOfrBaseTen);

% Raw firing rate
ms_CNOfrBase = [mean(CNOfrBase), std(CNOfrBase,1,1)/size(CNOfrBase,1)];
ms_CNOfrBaseTen = [mean(CNOfrBaseTen), std(CNOfrBaseTen,1,1)/size(CNOfrBase,1)];
ms_CNOfrTest = [mean(CNOfrTest), std(CNOfrTest,1,1)/size(CNOfrTest,1)];
ms_CNOfrTestTen = [mean(CNOfrTestTen), std(CNOfrTestTen,1,1)/size(CNOfrTestTen,1)];

ms_DMSOfrBase = [mean(DMSOfrBase), std(DMSOfrBase,1,1)/size(DMSOfrBase,1)];
ms_DMSOfrBaseTen = [mean(DMSOfrBaseTen), std(DMSOfrBaseTen,1,1)/size(DMSOfrBaseTen,1)];
ms_DMSOfrTest = [mean(DMSOfrTest), std(DMSOfrTest,1,1)/size(DMSOfrTest,1)];
ms_DMSOfrTestTen = [mean(DMSOfrTestTen), std(DMSOfrTestTen,1,1)/size(DMSOfrTestTen,1)];

% Normalized firing rate (by baseline)
norCNO = CNOfrTest./CNOfrBase;
norCNOTen = CNOfrTestTen./CNOfrBaseTen;
norDMSO =  DMSOfrTest./DMSOfrBase;
norDMSOTen = DMSOfrTestTen./DMSOfrBaseTen;

ms_norCNO = [mean(norCNO), std(norCNO,1,1)/size(norCNO,1)];
ms_norCNOTen = [mean(norCNOTen), std(norCNOTen,1,1)/size(norCNOTen,1)];
ms_norDMSO = [mean(norDMSO), std(norDMSO,1,1)/size(norDMSO,1)];
ms_norDMSOTen = [mean(norDMSOTen), std(norDMSOTen,1,1)/size(norDMSOTen,1)];

% Sign Wilcoxon rank sum test
p_CNO = signrank(CNOfrBase(:), CNOfrTest(:));
p_CNOTen = signrank(CNOfrBaseTen(:), CNOfrTestTen(:));
p_DMSO = signrank(DMSOfrBase(:), DMSOfrTest(:));
p_DMSOTen = signrank(DMSOfrBaseTen(:), DMSOfrTestTen(:));

p_norCNO = signrank((CNOfrBase./CNOfrBase),norCNO(:));
p_norCNOTen = signrank((CNOfrBaseTen./CNOfrBaseTen),norCNOTen(:));
p_norDMSO = signrank((DMSOfrBase./DMSOfrBase),norDMSO(:));
p_norDMSOTen = signrank((DMSOfrBaseTen./DMSOfrBaseTen),norDMSOTen(:));

save([miceLine,'.mat'],...
    'nCNO','nDMSO',...
    'ms_CNOfrBaseTen','ms_CNOfrTestTen','ms_norCNOTen','CNOfrBaseTen','CNOfrBase','CNOfrTestTen',...
    'ms_DMSOfrBaseTen','ms_DMSOfrTestTen','ms_norDMSOTen','DMSOfrBaseTen','DMSOfrBase','DMSOfrTestTen',...
    'p_CNOTen','p_DMSOTen','p_norCNOTen','p_norDMSOTen')


% %% Plot
% % figure properties
% 
% % firing rate of Camk2a CNO & DMSO
% hfrRate(1) = axes('Position',axpt(nCol,nRowMain,3,1,[],wideInterval));
%     hold on;
%     hRbpbar(1) = bar(1,ms_CNOfrBaseTen(1),0.3,...
%         'FaceColor',colorRed,'EdgeColor','k');
%     hold on;
%     hRbpbar(2) = bar(1.5,ms_CNOfrTestTen(1),0.3,...
%         'FaceColor',colorRed,'EdgeColor','k');
%     hold on;
%     hRbpbar(3) = bar(2.5,ms_DMSOfrBaseTen(1),0.3,...
%         'FaceColor',colorBlue,'EdgeColor','k');
%     hold on;
%     hRbpbar(4) = bar(3,ms_DMSOfrTestTen(1),0.3,...
%         'FaceColor',colorBlue,'EdgeColor','k');
%     
%     hError(1) = errorbar(1,ms_CNOfrBaseTen(:,1),ms_CNOfrBaseTen(:,2));
%     hError(2) = errorbar(1.5,ms_CNOfrTestTen(:,1),ms_CNOfrTestTen(:,2));
% %     errorbarT(hError(1),1,1,80);
% %     errorbarT(hError(2),0.5,1,80);
% 
% 
% % Normalized firing rate of CNO & DMSO
% hfrRate(2) = axes('Position',axpt(nCol,nRowMain,3,2,[],wideInterval));
%     hold on;
%     hRbpbar(5) = bar(1,mean(CNOfrBaseTen./CNOfrBaseTen),0.3,...
%         'FaceColor',colorRed,'EdgeColor','k');
%     hold on;
%     hRbpbar(6) = bar(1.5,ms_norCNOTen(1),0.3,...
%         'FaceColor',colorRed,'EdgeColor','k');
%     hold on;
%     hRbpbar(7) = bar(2.5,mean(DMSOfrBase./DMSOfrBase),0.3,...
%         'FaceColor',colorBlue,'EdgeColor','k');
%     hold on;
%     hRbpbar(8) = bar(3,ms_norDMSOTen(1),0.3,...
%         'FaceColor',colorBlue,'EdgeColor','k');
%     
%     set(hfrRate(1),'LineWidth',lineL,'YLim',[0, 2]);
%     set(hfrRate(2),'LineWidth',lineL,'YLim',[0, 1.5]);
%     set(hRbpbar(1:4),'LineWidth',lineL);
%     set(hRbpbar(5:8),'LineWidth',lineL);
%     
% % firing rate of DG CNO & DMSO
% hfrRate(3) = axes('Position',axpt(nCol,nRowMain,3,1,[],wideInterval));
%     hold on;
%     hGrik4bar(1) = bar(1,ms_CNOfrBaseTen(1),0.3,...
%         'FaceColor',colorRed,'EdgeColor','k');
%     hold on;
%     hGrik4bar(2) = bar(1.5,ms_CNOfrTestTen(1),0.3,...
%         'FaceColor',colorRed,'EdgeColor','k');
%     hold on;
%     hGrik4bar(3) = bar(2.5,ms_DMSOfrBaseTen(1),0.3,...
%         'FaceColor',colorBlue,'EdgeColor','k');
%     hold on;
%     hGrik4bar(4) = bar(3,ms_DMSOfrTestTen(1),0.3,...
%         'FaceColor',colorBlue,'EdgeColor','k');
%     
%     hError(1) = errorbar(1,ms_CNOfrBaseTen(:,1),ms_CNOfrBaseTen(:,2));
%     hError(2) = errorbar(1.5,ms_CNOfrTestTen(:,1),ms_CNOfrTestTen(:,2));
% %     errorbarT(hError(1),1,1,80);
% %     errorbarT(hError(2),0.5,1,80);
% 
% 
% % Normalized firing rate of CNO & DMSO
% hfrRate(4) = axes('Position',axpt(nCol,nRowMain,3,2,[],wideInterval));
%     hold on;
%     hGrik4bar(5) = bar(1,mean(CNOfrBaseTen./CNOfrBaseTen),0.3,...
%         'FaceColor',colorRed,'EdgeColor','k');
%     hold on;
%     hGrik4bar(6) = bar(1.5,ms_norCNOTen(1),0.3,...
%         'FaceColor',colorRed,'EdgeColor','k');
%     hold on;
%     hGrik4bar(7) = bar(2.5,mean(DMSOfrBase./DMSOfrBase),0.3,...
%         'FaceColor',colorBlue,'EdgeColor','k');
%     hold on;
%     hGrik4bar(8) = bar(3,ms_norDMSOTen(1),0.3,...
%         'FaceColor',colorBlue,'EdgeColor','k');
%     
%     set(hfrRate(1),'LineWidth',lineL,'YLim',[0, 2]);
%     set(hfrRate(2),'LineWidth',lineL,'YLim',[0, 1.5]);
%     set(hbar(1:4),'LineWidth',lineL);
%     set(hbar(5:8),'LineWidth',lineL);
% 
% % firing rate of Camk2a CNO & DMSO
% hfrRate(5) = axes('Position',axpt(nCol,nRowMain,3,1,[],wideInterval));
%     hold on;
%     hCamk2abar(1) = bar(1,ms_CNOfrBaseTen(1),0.3,...
%         'FaceColor',colorRed,'EdgeColor','k');
%     hold on;
%     hCamk2abar(2) = bar(1.5,ms_CNOfrTestTen(1),0.3,...
%         'FaceColor',colorRed,'EdgeColor','k');
%     hold on;
%     hCamk2abar(3) = bar(2.5,ms_DMSOfrBaseTen(1),0.3,...
%         'FaceColor',colorBlue,'EdgeColor','k');
%     hold on;
%     hCamk2abar(4) = bar(3,ms_DMSOfrTestTen(1),0.3,...
%         'FaceColor',colorBlue,'EdgeColor','k');
%     
%     hError(1) = errorbar(1,ms_CNOfrBaseTen(:,1),ms_CNOfrBaseTen(:,2));
%     hError(2) = errorbar(1.5,ms_CNOfrTestTen(:,1),ms_CNOfrTestTen(:,2));
% %     errorbarT(hError(1),1,1,80);
% %     errorbarT(hError(2),0.5,1,80);
% 
% 
% % Normalized firing rate of CNO & DMSO
% hfrRate(6) = axes('Position',axpt(nCol,nRowMain,3,2,[],wideInterval));
%     hold on;
%     hCamk2abar(5) = bar(1,mean(CNOfrBaseTen./CNOfrBaseTen),0.3,...
%         'FaceColor',colorRed,'EdgeColor','k');
%     hold on;
%     hCamk2abar(6) = bar(1.5,ms_norCNOTen(1),0.3,...
%         'FaceColor',colorRed,'EdgeColor','k');
%     hold on;
%     hCamk2abar(7) = bar(2.5,mean(DMSOfrBase./DMSOfrBase),0.3,...
%         'FaceColor',colorBlue,'EdgeColor','k');
%     hold on;
%     hCamk2abar(8) = bar(3,ms_norDMSOTen(1),0.3,...
%         'FaceColor',colorBlue,'EdgeColor','k');
%     
%     set(hfrRate(1),'LineWidth',lineL,'YLim',[0, 2]);
%     set(hfrRate(2),'LineWidth',lineL,'YLim',[0, 1.5]);
%     set(hbar(1:4),'LineWidth',lineL);
%     set(hbar(5:8),'LineWidth',lineL);
