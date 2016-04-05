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
        if frBase>0.1 && frBase<7
            CNOfrBase = [CNOfrBase; frBase];
            CNOfrBaseTen = [CNOfrBaseTen; frBaseTen];
            CNOfrTest = [CNOfrTest; frTest];
            CNOfrTestTen = [CNOfrTestTen; frTestTen];
        end
    else
        load(mFile{iFile},'frBase','frBaseTen','frTest','frTestTen');
        if frBase>0.1 && frBase<7
            DMSOfrBase = [DMSOfrBase; frBase];
            DMSOfrBaseTen = [DMSOfrBaseTen; frBaseTen];
            DMSOfrTest = [DMSOfrTest; frTest];
            DMSOfrTestTen = [DMSOfrTestTen; frTestTen];
        end
    end
end

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

nCol = 4;
nRowSub = 8; % for the left column
nRowMain = 5; % for the main figure

hfrRate(1) = axes('Position',axpt(2,2,1,1,[],wideInterval));
    hold on;
    hbar(1) = bar(1,ms_CNOfrBaseTen(1),0.3,...
        'FaceColor',colorRed,'EdgeColor','k');
    
    hold on;
    hbar(2) = bar(1.5,ms_CNOfrTestTen(1),0.3,...
        'FaceColor',colorRed,'EdgeColor','k');

    hold on;
    hbar(3) = bar(2.5,ms_DMSOfrBaseTen(1),0.3,...
        'FaceColor',colorBlue,'EdgeColor','k');

    hold on;
    hbar(4) = bar(3,ms_DMSOfrTestTen(1),0.3,...
        'FaceColor',colorBlue,'EdgeColor','k');

hfrRate(2) = axes('Position',axpt(2,2,1,2,[],wideInterval));
    hold on;
    hbar(5) = bar(1,mean(CNOfrBaseTen./CNOfrBaseTen),0.3,...
        'FaceColor',colorRed,'EdgeColor','k');
    
    hold on;
    hbar(6) = bar(1.5,ms_norCNOTen(1),0.3,...
        'FaceColor',colorRed,'EdgeColor','k');

    hold on;
    hbar(7) = bar(2.5,mean(DMSOfrBase./DMSOfrBase),0.3,...
        'FaceColor',colorBlue,'EdgeColor','k');

    hold on;
    hbar(8) = bar(3,ms_norDMSOTen(1),0.3,...
        'FaceColor',colorBlue,'EdgeColor','k');
    
    set(hfrRate,'LineWidth',lineL);
    set(hbar,'LineWidth',lineL);
