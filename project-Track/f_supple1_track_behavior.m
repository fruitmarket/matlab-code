clearvars;
rtPath = 'D:\Dropbox\SNL\P2_Track';
startingDir = {'D:\Projects\Track_151029-5_Rbp8';
               'D:\Projects\Track_160221-1_Rbp16';
               'D:\Projects\Track_160417-1_Rbp32ori';
               'D:\Projects\Track_160417-2_Rbp34ori';
               'D:\Projects\Track_160422-14_Rbp36ori';
               'D:\Projects\Track_160726-1_Rbp48ori';
               'D:\Projects\Track_160726-2_Rbp50ori';
               'D:\Projects\Track_160824-2_Rbp58ori';
               'D:\Projects\Track_160824-5_Rbp60ori';
               'D:\Projects\Track_161130-3_Rbp64ori';
               'D:\Projects\Track_161130-7_Rbp68ori';
               'D:\Projects\Track_170119-1_Rbp70ori';
               'D:\Projects\Track_170109-2_Rbp72ori';
               'D:\Projects\Track_170305-1_Rbp76ori';
               'D:\Projects\Track_170305-2_Rbp78ori'};
           % 20170907 modifided
           % 'D:\Projects\Track_151029-4_Rbp6' excluded because of virus expression
           % 'D:\Projects\Track_151213-2_Rbp14' excluded because of optic fiber location
           % 'D:\Projects\Track_161130-5_Rbp66ori' excluded because of almost no expression
           % 'D:\Projects\Track_170115-4_Rbp74ori' excluede because of no expression

matFile = [];
nDir = size(startingDir,1);
for iDir = 1:nDir
    tempmatFile = FindFiles('Events.mat','StartingDirectory',startingDir{iDir},'CheckSubdirs',1);
    matFile = [matFile; tempmatFile];    
end
nFile = length(matFile);

[T, Txls] = deal(table());
for iFile = 1:nFile
    load(matFile{iFile});
    
    [cellDir, cellName, ~] = fileparts(matFile{iFile});
    cellDirSplit = regexp(cellDir,['\','_'],'split');
    
    cellDir = categorical(cellstr(cellDir));
    session = categorical(cellstr(cellDirSplit{6}));
    sessionID = iFile;
    
    preTime = diff(preTime)/(1000 * 60); % unit change [ms -> min]
    stmTime = diff(stmTime)/(1000 * 60);
    postTime = diff(postTime)/(1000 * 60);

    temT = table(cellDir, sessionID, session, preTime, stmTime, postTime);
    T = [T; temT];
    
    fclose('all');
end
cd(rtPath);
group = {'PRE','STM','POST'};

%% mean & SEM
DRunPRE = T.preTime(T.session == 'DRun');
DRunSTM = T.stmTime(T.session == 'DRun');
DRunPOST = T.postTime(T.session == 'DRun');
nDRun = length(DRunPRE);
m_timeDRun = [mean(DRunPRE), mean(DRunSTM), mean(DRunPOST)];
sem_timeDRun = [std(DRunPRE,0,1)/sqrt(length(DRunPRE)), std(DRunSTM,0,1)/sqrt(length(DRunPRE)), std(DRunPOST,0,1)/sqrt(length(DRunPRE))];

DRwPRE = T.preTime(T.session == 'DRw');
DRwSTM = T.stmTime(T.session == 'DRw');
DRwPOST = T.postTime(T.session == 'DRw');
nDRw = length(DRwPRE);
m_timeDRw = [mean(DRwPRE), mean(DRwSTM), mean(DRwPOST)];
sem_timeDRw = [std(DRwPRE,0,1)/sqrt(length(DRwPRE)), std(DRwSTM,0,1)/sqrt(length(DRwPRE)), std(DRwPOST,0,1)/sqrt(length(DRwPRE))];

noRunPRE = T.preTime(T.session == 'noRun');
noRunSTM = T.stmTime(T.session == 'noRun');
noRunPOST = T.postTime(T.session == 'noRun');
nnoRun = length(noRunPRE);
m_timenoRun = [mean(noRunPRE), mean(noRunSTM), mean(noRunPOST)];
sem_timenoRun = [std(noRunPRE,0,1)/sqrt(length(noRunPRE)), std(noRunSTM,0,1)/sqrt(length(noRunPRE)), std(noRunPOST,0,1)/sqrt(length(noRunPRE))];

noRwPRE = T.preTime(T.session == 'noRw');
noRwSTM = T.stmTime(T.session == 'noRw');
noRwPOST = T.postTime(T.session == 'noRw');
nnoRw = length(noRwPRE);
m_timenoRw = [mean(noRwPRE), mean(noRwSTM), mean(noRwPOST)];
sem_timenoRw = [std(noRwPRE,0,1)/sqrt(length(noRwPRE)), std(noRwSTM,0,1)/sqrt(length(noRwPRE)), std(noRwPOST,0,1)/sqrt(length(noRwPRE))];

%% With-in session ANOVA test
[~, tble_DRun, stats_DRun] = anova1([DRunPRE, DRunSTM, DRunPOST],group,'off');
result_DRun = multcompare(stats_DRun,'Alpha',0.05,'CType','bonferroni','Display','off');
p_behavior_DRun(:,1) = result_DRun(:,end);

[~, tble_DRw, stats_DRw] = anova1([DRwPRE, DRwSTM, DRwPOST],group,'off');
result_DRw = multcompare(stats_DRw,'Alpha',0.05,'CType','bonferroni','Display','off');
p_behavior_DRw(:,1) = result_DRw(:,end);

[~, tble_noRun, stats_noRun] = anova1([noRunPRE, noRunSTM, noRunPOST],group,'off');
result_noRun = multcompare(stats_noRun,'Alpha',0.05,'CType','bonferroni','Display','off');
p_behavior_noRun(:,1) = result_noRun(:,end);

[~, tble_noRw, stats_noRw] = anova1([noRwPRE, noRwSTM, noRwPOST],group,'off');
result_noRw = multcompare(stats_noRw,'Alpha',0.05,'CType','bonferroni','Display','off');
p_behavior_noRw(:,1) = result_noRw(:,end);

%% Between session unpaired ttest
[~, p_btw_DRun_PRE,~,stat_DRun_PRE] = ttest2(DRunPRE,noRunPRE);
[~, p_btw_DRun_STM,~,stat_DRun_STM] = ttest2(DRunSTM,noRunSTM);
[~, p_btw_DRun_POST,~,stat_DRun_POST] = ttest2(DRunPOST,noRunPOST);

[~, p_btw_DRw_PRE,~,stat_DRw_PRE] = ttest2(DRwPRE,noRwPRE);
[~, p_btw_DRw_STM,~,stat_DRw_STM] = ttest2(DRwSTM,noRwSTM);
[~, p_btw_DRw_POST,~,stat_DRw_POST] = ttest2(DRwPOST,noRwPOST);

%% plot
load('D:\Dropbox\SNL\P2_Track\myParameters.mat');
formatOut = 'yymmdd';
barWidth = 0.2;
eBarLength = 0.3;
eBarWidth = 0.8;
eBarColor = colorBlack;

fHandle = figure('PaperUnits','centimeters','PaperPosition',[0 0 9 4]);
hBehav(1) = axes('Position',axpt(2,1,1,1,[0.1 0.1 0.85 0.80],wideInterval));
bar([1,4,7],m_timeDRun,barWidth,'faceColor',colorLightBlue);
hold on;
errorbarJun([1,4,7],m_timeDRun,sem_timeDRun,eBarLength,eBarWidth,eBarColor);
hold on;
bar([2,5,8],m_timenoRun,barWidth,'faceColor',colorGray);
hold on;
errorbarJun([2,5,8],m_timenoRun,sem_timenoRun,eBarLength,eBarWidth,eBarColor);

title('Run sessions','fontSize',fontS,'fontWeight','bold');
ylabel('Time (min)','fontSize',fontS);
text(5.5, 8.5,['n (DRun) = ',num2str(nDRun)],'fontSize',fontS,'color',colorDarkBlue);
text(5.5, 8,['n (noRun) = ',num2str(nnoRun)],'fontSize',fontS,'color',colorDarkGray);

hBehav(2) = axes('Position',axpt(2,1,2,1,[0.1 0.1 0.85 0.80],wideInterval));
bar([1,4,7],m_timeDRw,barWidth,'faceColor',colorLightBlue);
hold on;
errorbarJun([1,4,7],m_timeDRw,sem_timeDRw,eBarLength,eBarWidth,eBarColor);
hold on;
bar([2,5,8],m_timenoRw,barWidth,'faceColor',colorGray);
hold on;
errorbarJun([2,5,8],m_timenoRw,sem_timenoRw,eBarLength,eBarWidth,eBarColor);

title('Reward sessions','fontSize',fontS,'fontWeight','bold');
ylabel('Time (min)','fontSize',fontS);
text(5.5, 8.5,['n (DRw) = ',num2str(nDRw)],'fontSize',fontS,'color',colorDarkBlue);
text(5.5, 8,['n (noRw) = ',num2str(nnoRw)],'fontSize',fontS,'color',colorDarkGray);

set(hBehav,'Box','off','TickDir','out','XLim',[0,9],'XTick',[1.5, 4.5, 7.5],'XTickLabel',{'PRE','STM','POST'},'YLim',[0,10]);
set(hBehav,'fontSize',fontS);

print('-painters','-r300','-dtiff',['final_fig3_behavior_',datestr(now,formatOut),'.tif']);
print('-painters','-r300','-depsc',['final_fig3_behavior_',datestr(now,formatOut),'.ai']);
close;