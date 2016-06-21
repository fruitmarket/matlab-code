clf; clearvars;

lineColor = {[144, 164, 174]./255,... % Before stimulation
    [244, 67, 54]./255,... % During stimulation
    [38, 50, 56]./255}; % After stimulation

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
colorGray = [189 189 189] ./ 255;
colorYellow = [255 243 3] ./ 255;
colorLightYellow = [255 249 196] ./ 255;

% four group color
colorPink = [183, 28, 28]./255;
colorPurple = [74, 20, 140]./255;
colorBlue3 = [13, 71, 161]./255;
colorOrange = [27, 94, 32]./255;

tightInterval = [0.02 0.02];
wideInterval = [0.09 0.09];

nCol = 4;
nRowSub = 8; % for the left column
nRowMain = 5; % for the main figure

markerS = 2.2;
markerM = 4.4;
markerL = 6.6;

rtpath = pwd;

%% Data load
load('cellList_DRw_10.mat','T');
tDRw = T;

load('cellList_DRun_10.mat','T');
tDRun = T;

load('cellList_Nolight_10.mat','T');
tNolight = T;

%%
pnDRw = (tDRw.fr_task > 0.01 & tDRw.fr_task < 10);
npnDRw = sum(double(pnDRw));
inDRw = (tDRw.fr_task > 10);
ninDRw = sum(double(inDRw));

pnDRun = (tDRun.fr_task > 0.01 & tDRun.fr_task < 10);
npnDRun = sum(double(pnDRun));
inDRun = (tDRun.fr_task > 10);
ninDRun = sum(double(inDRun));

pnNolight = (tNolight.fr_task > 0.01 & tNolight.fr_task < 10);
npnNolight = sum(double(pnNolight));
inNolight = (tNolight.fr_task > 10);
ninNolight = sum(double(inNolight));

%% DRw
matFile = tDRw.Path;
nFile = length(matFile);

for iCell = 1:nFile
    [cellpath,~,~] = fileparts(matFile{iCell});
    cellPath{iCell,1} = cellpath;
end

cellPath = unique(cellPath);
nPath = length(cellPath);

r_DRwpn_Corrbfxaft = []; r_DRwpn_Corrbfxdr = []; r_DRwpn_Corrdrxaft = []; r_DRwpn_Corrhfxhf = [];
r_DRwin_Corrbfxaft = []; r_DRwin_Corrbfxdr = []; r_DRwin_Corrdrxaft = []; r_DRwin_Corrhfxhf = [];

for iPath = 1:nPath
    cd(cellPath{iPath});
    submatFile = FindFiles('tt*.mat','CheckSubdirs',0);
    nsubmatFile = length(submatFile);
       
    for iSub = 1:nsubmatFile
        load(submatFile{iSub},'fr_task','r_Corrbfxaft','r_Corrbfxdr','r_Corrdrxaft','r_Corrhfxhf');
        if (fr_task>0.01 && fr_task<10);
            r_DRwpn_Corrbfxaft = [r_DRwpn_Corrbfxaft; r_Corrbfxaft];
            r_DRwpn_Corrbfxdr = [r_DRwpn_Corrbfxdr; r_Corrbfxdr];
            r_DRwpn_Corrdrxaft = [r_DRwpn_Corrdrxaft; r_Corrdrxaft];
            r_DRwpn_Corrhfxhf = [r_DRwpn_Corrhfxhf; r_Corrhfxhf];
        else fr_task > 10;
            r_DRwin_Corrbfxaft = [r_DRwin_Corrbfxaft; r_Corrbfxaft];
            r_DRwin_Corrbfxdr = [r_DRwin_Corrbfxdr; r_Corrbfxdr];
            r_DRwin_Corrdrxaft = [r_DRwin_Corrdrxaft; r_Corrdrxaft];
            r_DRwin_Corrhfxhf = [r_DRwin_Corrhfxhf; r_Corrhfxhf];
        end;
    end
    
    r_sessDRwpn_Corrbfxaft(iPath,1) = mean(r_DRwpn_Corrbfxaft);
    r_sessDRwpn_Corrbfxdr(iPath,1) = mean(r_DRwpn_Corrbfxdr);
    r_sessDRwpn_Corrdrxaft(iPath,1) = mean(r_DRwpn_Corrdrxaft);
    r_sessDRwpn_Corrhfxhf(iPath,1) = mean(r_DRwpn_Corrhfxhf);
    
    r_sessDRwin_Corrbfxaft(iPath,1) = mean(r_DRwin_Corrbfxaft);
    r_sessDRwin_Corrbfxdr(iPath,1) = mean(r_DRwin_Corrbfxdr);
    r_sessDRwin_Corrdrxaft(iPath,1) = mean(r_DRwin_Corrdrxaft);
    r_sessDRwin_Corrhfxhf(iPath,1) = mean(r_DRwin_Corrhfxhf);
end
nSessionPnDRw = length(isnan(r_sessDRwpn_Corrbfxaft));
nSessionInDRw = length(isnan(r_sessDRwin_Corrbfxaft));
cd(rtpath);
% save(['sessionCorrelation_DRw','.mat'],...
%     'r_sessDRwpn_Corrbfxaft','r_sessDRwpn_Corrbfxdr','r_sessDRwpn_Corrdrxaft','r_sessDRwpn_Corrhfxhf',...
%     'r_sessDRwin_Corrbfxaft','r_sessDRwin_Corrbfxdr','r_sessDRwin_Corrdrxaft','r_sessDRwin_Corrhfxhf');

%% DRun
matFile = tDRun.Path;
nFile = length(matFile);

for iCell = 1:nFile
    [cellpath,~,~] = fileparts(matFile{iCell});
    cellPath{iCell,1} = cellpath;
end

cellPath = unique(cellPath);
nPath = length(cellPath);

r_DRunpn_Corrbfxaft = []; r_DRunpn_Corrbfxdr = []; r_DRunpn_Corrdrxaft = []; r_DRunpn_Corrhfxhf = [];
r_DRunin_Corrbfxaft = []; r_DRunin_Corrbfxdr = []; r_DRunin_Corrdrxaft = []; r_DRunin_Corrhfxhf = [];

for iPath = 1:nPath
    cd(cellPath{iPath});
    submatFile = FindFiles('tt*.mat','CheckSubdirs',0);
    nsubmatFile = length(submatFile);
       
    for iSub = 1:nsubmatFile
        load(submatFile{iSub},'fr_task','r_Corrbfxaft','r_Corrbfxdr','r_Corrdrxaft','r_Corrhfxhf');
        if (fr_task>0.01 && fr_task<10);
            r_DRunpn_Corrbfxaft = [r_DRunpn_Corrbfxaft; r_Corrbfxaft];
            r_DRunpn_Corrbfxdr = [r_DRunpn_Corrbfxdr; r_Corrbfxdr];
            r_DRunpn_Corrdrxaft = [r_DRunpn_Corrdrxaft; r_Corrdrxaft];
            r_DRunpn_Corrhfxhf = [r_DRunpn_Corrhfxhf; r_Corrhfxhf];
        else fr_task > 10;
            r_DRunin_Corrbfxaft = [r_DRunin_Corrbfxaft; r_Corrbfxaft];
            r_DRunin_Corrbfxdr = [r_DRunin_Corrbfxdr; r_Corrbfxdr];
            r_DRunin_Corrdrxaft = [r_DRunin_Corrdrxaft; r_Corrdrxaft];
            r_DRunin_Corrhfxhf = [r_DRunin_Corrhfxhf; r_Corrhfxhf];
        end;
    end
    
    r_sessDRunpn_Corrbfxaft(iPath,1) = mean(r_DRunpn_Corrbfxaft);
    r_sessDRunpn_Corrbfxdr(iPath,1) = mean(r_DRunpn_Corrbfxdr);
    r_sessDRunpn_Corrdrxaft(iPath,1) = mean(r_DRunpn_Corrdrxaft);
    r_sessDRunpn_Corrhfxhf(iPath,1) = mean(r_DRunpn_Corrhfxhf);
    
    r_sessDRunin_Corrbfxaft(iPath,1) = mean(r_DRunin_Corrbfxaft);
    r_sessDRunin_Corrbfxdr(iPath,1) = mean(r_DRunin_Corrbfxdr);
    r_sessDRunin_Corrdrxaft(iPath,1) = mean(r_DRunin_Corrdrxaft);
    r_sessDRunin_Corrhfxhf(iPath,1) = mean(r_DRunin_Corrhfxhf);
end
cd(rtpath);
nSessionPnDRun = length(isnan(r_sessDRunpn_Corrbfxaft));
nSessionInDRun = length(isnan(r_sessDRunin_Corrbfxaft));
% save(['sessionCorrelation_DRun','.mat'],...
%     'r_sessDRunpn_Corrbfxaft','r_sessDRunpn_Corrbfxdr','r_sessDRunpn_Corrdrxaft','r_sessDRunpn_Corrhfxhf',...
%     'r_sessDRunin_Corrbfxaft','r_sessDRunin_Corrbfxdr','r_sessDRunin_Corrdrxaft','r_sessDRunin_Corrhfxhf');

%% Nolight
matFile = tNolight.Path;
nFile = length(matFile);

for iCell = 1:nFile
    [cellpath,~,~] = fileparts(matFile{iCell});
    cellPath{iCell,1} = cellpath;
end

cellPath = unique(cellPath);
nPath = length(cellPath);

r_Nolightpn_Corrbfxaft = []; r_Nolightpn_Corrbfxdr = []; r_Nolightpn_Corrdrxaft = []; r_Nolightpn_Corrhfxhf = [];
r_Nolightin_Corrbfxaft = []; r_Nolightin_Corrbfxdr = []; r_Nolightin_Corrdrxaft = []; r_Nolightin_Corrhfxhf = [];

for iPath = 1:nPath
    cd(cellPath{iPath});
    submatFile = FindFiles('tt*.mat','CheckSubdirs',0);
    nsubmatFile = length(submatFile);
       
    for iSub = 1:nsubmatFile
        load(submatFile{iSub},'fr_task','r_Corrbfxaft','r_Corrbfxdr','r_Corrdrxaft','r_Corrhfxhf');
        if (fr_task>0.01 && fr_task<10);
            r_Nolightpn_Corrbfxaft = [r_Nolightpn_Corrbfxaft; r_Corrbfxaft];
            r_Nolightpn_Corrbfxdr = [r_Nolightpn_Corrbfxdr; r_Corrbfxdr];
            r_Nolightpn_Corrdrxaft = [r_Nolightpn_Corrdrxaft; r_Corrdrxaft];
            r_Nolightpn_Corrhfxhf = [r_Nolightpn_Corrhfxhf; r_Corrhfxhf];
        else fr_task > 10;
            r_Nolightin_Corrbfxaft = [r_Nolightin_Corrbfxaft; r_Corrbfxaft];
            r_Nolightin_Corrbfxdr = [r_Nolightin_Corrbfxdr; r_Corrbfxdr];
            r_Nolightin_Corrdrxaft = [r_Nolightin_Corrdrxaft; r_Corrdrxaft];
            r_Nolightin_Corrhfxhf = [r_Nolightin_Corrhfxhf; r_Corrhfxhf];
        end;
    end
    
    r_sessNolightpn_Corrbfxaft(iPath,1) = mean(r_Nolightpn_Corrbfxaft);
    r_sessNolightpn_Corrbfxdr(iPath,1) = mean(r_Nolightpn_Corrbfxdr);
    r_sessNolightpn_Corrdrxaft(iPath,1) = mean(r_Nolightpn_Corrdrxaft);
    r_sessNolightpn_Corrhfxhf(iPath,1) = mean(r_Nolightpn_Corrhfxhf);
    
    r_sessNolightin_Corrbfxaft(iPath,1) = mean(r_Nolightin_Corrbfxaft);
    r_sessNolightin_Corrbfxdr(iPath,1) = mean(r_Nolightin_Corrbfxdr);
    r_sessNolightin_Corrdrxaft(iPath,1) = mean(r_Nolightin_Corrdrxaft);
    r_sessNolightin_Corrhfxhf(iPath,1) = mean(r_Nolightin_Corrhfxhf);
end
cd(rtpath);
nSessionPnNolight = sum(double((~isnan(r_sessNolightpn_Corrbfxaft))));
nSessionInNolight = sum(double((~isnan(r_sessNolightin_Corrbfxaft))));
% 
% save(['sessionCorrelation_Nolight','.mat'],...
%     'r_sessNolightpn_Corrbfxaft','r_sessNolightpn_Corrbfxdr','r_sessNolightpn_Corrdrxaft','r_sessNolightpn_Corrhfxhf',...
%     'r_sessNolightin_Corrbfxaft','r_sessNolightin_Corrbfxdr','r_sessNolightin_Corrdrxaft','r_sessNolightin_Corrhfxhf');

%%
    xpt_corrPnDRw = [ones(nSessionPnDRw,1);ones(nSessionPnDRw,1)*2;ones(nSessionPnDRw,1)*3;ones(nSessionPnDRw,1)*4];
    xpt_corrInDRw = [ones(nSessionInDRw,1);ones(nSessionInDRw,1)*2;ones(nSessionInDRw,1)*3;ones(nSessionInDRw,1)*4];
    ypt_corrPnDRw = [r_sessDRwpn_Corrbfxaft;r_sessDRwpn_Corrbfxdr;r_sessDRwpn_Corrdrxaft;r_sessDRwpn_Corrhfxhf];
    ypt_corrInDRw = [r_sessDRwin_Corrbfxaft;r_sessDRwin_Corrbfxdr;r_sessDRwin_Corrdrxaft;r_sessDRwin_Corrhfxhf];
      
    xpt_corrPnDRun = [ones(nSessionPnDRun,1);ones(nSessionPnDRun,1)*2;ones(nSessionPnDRun,1)*3;ones(nSessionPnDRun,1)*4];
    xpt_corrInDRun = [ones(nSessionInDRun,1);ones(nSessionInDRun,1)*2;ones(nSessionInDRun,1)*3;ones(nSessionInDRun,1)*4];
    ypt_corrPnDRun = [r_sessDRunpn_Corrbfxaft;r_sessDRunpn_Corrbfxdr;r_sessDRunpn_Corrdrxaft;r_sessDRunpn_Corrhfxhf]; 
    ypt_corrInDRun = [r_sessDRunin_Corrbfxaft;r_sessDRunin_Corrbfxdr;r_sessDRunin_Corrdrxaft;r_sessDRunin_Corrhfxhf];
    
    xpt_corrPnNolight = [ones(nSessionPnNolight,1);ones(nSessionPnNolight,1)*2;ones(nSessionPnNolight,1)*3;ones(nSessionPnNolight,1)*4];
    xpt_corrInNolight = [ones(nSessionInNolight,1);ones(nSessionInNolight,1)*2;ones(nSessionInNolight,1)*3;ones(nSessionInNolight,1)*4];
    ypt_corrPnNolight = [r_sessNolightpn_Corrbfxaft;r_sessNolightpn_Corrbfxdr;r_sessNolightpn_Corrdrxaft;r_sessNolightpn_Corrhfxhf];
    ypt_corrInNolight = [r_sessNolightin_Corrbfxaft;r_sessNolightin_Corrbfxdr;r_sessNolightin_Corrdrxaft;r_sessNolightin_Corrhfxhf];
    ypt_corrInNolight(isnan(ypt_corrInNolight)) = [];

%% Z-transformation
[ypt_ZcorrPnDRw, ~] = fisherZ(ypt_corrPnDRw);
[ypt_ZcorrPnDRun, ~] = fisherZ(ypt_corrPnDRun);
[ypt_ZcorrPnNolight, ~] = fisherZ(ypt_corrPnNolight);
[ypt_ZcorrInDRw, ~] = fisherZ(ypt_corrInDRw);
[ypt_ZcorrInDRun, ~] = fisherZ(ypt_corrInDRun);
[ypt_ZcorrInNolight, ~] = fisherZ(ypt_corrInNolight);
    
% Statistics
[~, ~, statsPnDRw] = anovan(ypt_ZcorrPnDRw,{xpt_corrPnDRw},'display','off');
[~, ~, statsPnDRun] = anovan(ypt_ZcorrPnDRun,{xpt_corrPnDRun},'display','off');
[~, ~, statsPnNolight] = anovan(ypt_ZcorrPnNolight,{xpt_corrPnNolight},'display','off');
[~, ~, statsInDRw] = anovan(ypt_ZcorrInDRw,{xpt_corrInDRw},'display','off');
[~, ~, statsInDRun] = anovan(ypt_ZcorrInDRun,{xpt_corrInDRun},'display','off');
[~, ~, statsInNolight] = anovan(ypt_ZcorrInNolight,{xpt_corrInNolight},'display','off');

% Multiple comparison
mulPnDRw = multcompare(statsPnDRw,'display','off');
mulPnDRun = multcompare(statsPnDRun,'display','off');
mulPnNolight = multcompare(statsPnNolight,'display','off');
mulInDRw = multcompare(statsInDRw,'display','off');
mulInDRun = multcompare(statsInDRun,'display','off');
mulInNolight = multcompare(statsInNolight,'display','off');    

    
%% Plot
    hSessCorr(1) = axes('Position',axpt(3,2,1,1,[0.1 0.1 0.85 0.85],wideInterval));
    hold on;
    MyScatterBarPlot(ypt_corrPnDRw,xpt_corrPnDRw,0.35,{colorPink,colorPurple,colorBlue3,colorOrange},[]);
    ylabel('Correlation');
    title('Stimulation during Reward zone (PN)','FontSize',fontM);
    text(4, 1,['n = ',num2str(nSessionPnDRw)]);
    
    hSessCorr(2) = axes('Position',axpt(3,2,2,1,[0.1 0.1 0.85 0.85],wideInterval));
    hold on;
    MyScatterBarPlot(ypt_corrPnDRun,xpt_corrPnDRun,0.35,{colorPink,colorPurple,colorBlue3,colorOrange},[]);
    title('Stimulation during Running zone (PN)','FontSize',fontM);
    text(4, 1,['n = ',num2str(nSessionPnDRun)]);
    
    hSessCorr(3) = axes('Position',axpt(3,2,3,1,[0.1 0.1 0.85 0.85],wideInterval));
    hold on;
    MyScatterBarPlot(ypt_corrPnNolight,xpt_corrPnNolight,0.36,{colorPink,colorPurple,colorBlue3,colorOrange},[]);
    title('No stimulation (PN)','FontSize',fontM);
    text(4, 1,['n = ',num2str(nSessionPnNolight)]);
    
    hSessCorr(4) = axes('Position',axpt(3,2,1,2,[0.1 0.1 0.85 0.85],wideInterval));
    hold on;
    MyScatterBarPlot(ypt_corrInDRw,xpt_corrInDRw,0.35,{colorPink,colorPurple,colorBlue3,colorOrange},[]);
    title('Stimulation during Reward zone (IN)','FontSize',fontM);
    text(4, 1,['n = ',num2str(nSessionInDRw)]);
    
    hSessCorr(5) = axes('Position',axpt(3,2,2,2,[0.1 0.1 0.85 0.85],wideInterval));
    hold on;
    MyScatterBarPlot(ypt_corrInDRun,xpt_corrInDRun,0.35,{colorPink,colorPurple,colorBlue3,colorOrange},[]);
    title('Stimulation during Running zone (IN)','FontSize',fontM);
    text(4, 1,['n = ',num2str(nSessionInDRun)]);
    
    hSessCorr(6) = axes('Position',axpt(3,2,3,2,[0.1 0.1 0.85 0.85],wideInterval));
    hold on;
    MyScatterBarPlot(ypt_corrInNolight,xpt_corrInNolight,0.35,{colorPink,colorPurple,colorBlue3,colorOrange},[]);
    title('No Stimulation (IN)','FontSize',fontM);
    text(4, 1,['n = ',num2str(nSessionInNolight)]);
    
    set(hSessCorr,'TickDir','out','Box','off','XLim',[0,5],'YLim',[-0,1.2],'XTick',[1,2,3,4],'XTickLabel',[{'hf x hf','bf x dur', 'bf x aft','dur x aft'}],'FontSize',fontM);
print(gcf, '-depsc','-r300','Sess_Correlation_10');