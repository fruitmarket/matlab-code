clearvars; close all;

%% Data load
% Novel
rtDir = 'E:\Dropbox\SNL\P4_FamiliarNovel';
load('E:\Dropbox\Lab_mwjung\P2_Track\myParameters.mat');
formatOut = 'yymmdd';
load('E:\Dropbox\Lab_mwjung\P4_FamiliarNovel\behaviorList_novel_190219.mat');
T_nov = T;

% Familiar
load('E:\Dropbox\Lab_mwjung\P4_FamiliarNovel\behaviorList_familiar_190219.mat');
T_fam = T;

%%
% each lap analysis
idx_nov = logical([ones(7,1);zeros(1,1);ones(6,1)]);
eachLap_nov = round(cell2mat(T_nov.m_timeLap(idx_nov))/1000*100)/100;
nSess_nov = size(eachLap_nov,1);

m_eachLap_nov = mean(eachLap_nov);
sem_eachLap_nov = std(eachLap_nov,0,1)/sqrt(nSess_nov);
group_nov = {'basePRE','PRE','STIM','POST','basePOST'};
[p_KW_eachLap_main_nov,~,stats] = kruskalwallis(eachLap_nov,group_nov,'off');
result = multcompare(stats,'ctype','lsd','display','off');
p_KW_eachLap_detail_nov = result(:,end);

% block analysis
timeLap_nov = T_nov.timeLap(idx_nov);
nBlock_nov = 5;
timeBlock_nov = zeros(nSess_nov,5);
for iBlock = 1:nBlock_nov
    timeBlock_nov(:,iBlock) = cellfun(@(x) sum(x(30*(iBlock-1)+1:30*iBlock)), timeLap_nov);
end

timeBlock_nov = round(timeBlock_nov/(1000*60)*100)/100;
m_eachBlock_nov = mean(timeBlock_nov);
sem_eachBlock_nov = std(timeBlock_nov,0,1)/sqrt(nSess_nov);
[p_KW_eachBlock_main_nov,~,stats] = kruskalwallis(timeBlock_nov,group_nov,'off');
result = multcompare(stats,'ctype','lsd','display','off');
p_KW_eachBlock_detail_nov = result(:,end);

% lap by lap analysis
timeLapTotal_nov = reshape(cell2mat(T_nov.timeLap(idx_nov)),[150,nSess_nov])/1000; % unit: msec >> sec
% m_timeLap_nov = mean(timeLapTotal_nov,2);
% sem_timeLap_nov = std(timeLapTotal_nov,0,2)/sqrt(nSess_nov);
m_timeLap_nov = smooth(mean(timeLapTotal_nov,2));
sem_timeLap_nov = smooth(std(timeLapTotal_nov,0,2)/sqrt(nSess_nov));

% stimulated vs unstimulated
timeLap_stim_nov = reshape(cell2mat(cellfun(@(x) x(:,1),T_nov.timeInZone(idx_nov),'UniformOutput',0)),[150,nSess_nov]);
% m_timeStim_nov = mean(timeLap_stim_nov,2);
% sem_timeStim_nov = std(timeLap_stim_nov,0,2)/sqrt(nSess_nov);
m_timeStim_nov = smooth(mean(timeLap_stim_nov,2));
sem_timeStim_nov = smooth(std(timeLap_stim_nov,0,2)/sqrt(nSess_nov));

timeLap_unstim_nov = reshape(cell2mat(cellfun(@(x) x(:,3),T_nov.timeInZone(idx_nov),'UniformOutput',0)),[150,nSess_nov]);
% m_timeUnstim_nov = mean(timeLap_unstim_nov,2);
% sem_timeUnstim_nov = std(timeLap_unstim_nov,0,2)/sqrt(nSess_nov);
m_timeUnstim_nov = smooth(mean(timeLap_unstim_nov,2));
sem_timeUnstim_nov = smooth(std(timeLap_unstim_nov,0,2)/sqrt(nSess_nov));

timeBlock_stim_nov = reshape(cell2mat(T_nov.sum_timeZone(idx_nov)),[5,4,nSess_nov])/60; % unit: sec -> min
m_timeBlock_stim_nov = mean(timeBlock_stim_nov,3);
sem_timeBlock_stim_nov = std(timeBlock_stim_nov,0,3)/sqrt(nSess_nov);
m_timeBlock_unstim_nov = mean(timeBlock_stim_nov,1);
sem_timeBlock_unstim_nov = std(timeBlock_stim_nov,0,1)/sqrt(nSess_nov);

%%%%%%%%% Familiar %%%%%%%%%%%%%%%%%
% each lap analysis
idx_nov = logical([zeros(1,1);ones(19,1)]);
eachLap_fam = round(cell2mat(T_fam.m_timeLap(idx_nov))/1000*100)/100;
nSess_fam = size(eachLap_fam,1);

m_eachLap_fam = mean(eachLap_fam);
sem_eachLap_fam = std(eachLap_fam,0,1)/sqrt(nSess_fam);
group_fam = {'PRE','STIM','POST'};
[p_KW_eachLap_main_fam,~,stats] = kruskalwallis(eachLap_fam,group_fam,'off');
result = multcompare(stats,'ctype','lsd','display','off');
p_KW_eachLap_detail_fam = result(:,end);

% block analysis
timeLap_fam = T_fam.timeLap(idx_nov);
nBlock_fam = 3;
timeBlock_fam = zeros(nSess_fam,3);
for iBlock = 1:nBlock_fam
    timeBlock_fam(:,iBlock) = cellfun(@(x) sum(x(30*(iBlock-1)+1:30*iBlock)), timeLap_fam);
end
timeBlock_fam = round(timeBlock_fam/(1000*60)*100)/100;
m_eachBlock_fam = mean(timeBlock_fam);
sem_eachBlock_fam = std(timeBlock_fam,0,1)/sqrt(nSess_fam);
[p_KW_eachBlock_main_fam,~,stats] = kruskalwallis(timeBlock_fam,group_fam,'off');
result = multcompare(stats,'ctype','lsd','display','off');
p_KW_eachBlock_detail_fam = result(:,end);

% lap by lap analysis
timeLapTotal_fam = reshape(cell2mat(T_fam.timeLap(idx_nov)),[90,nSess_fam])/1000; % unit msec >> sec
% m_timeLap_fam = mean(timeLapTotal_fam,2);
% sem_timeLap_fam = std(timeLapTotal_fam,0,2)/sqrt(nSess_fam);
m_timeLap_fam = smooth(mean(timeLapTotal_fam,2));
sem_timeLap_fam = smooth(std(timeLapTotal_fam,0,2)/sqrt(nSess_fam));

% stimulated vs unstimulated
timeLap_stim_fam = reshape(cell2mat(cellfun(@(x) x(:,1),T_fam.timeInZone(idx_nov),'UniformOutput',0)),[90,nSess_fam]);
% m_timeStim_fam = mean(timeLap_stim_fam,2);
% sem_timeStim_fam = std(timeLap_stim_fam,0,2)/sqrt(nSess_fam);
m_timeStim_fam = smooth(mean(timeLap_stim_fam,2));
sem_timeStim_fam = smooth(std(timeLap_stim_fam,0,2)/sqrt(nSess_fam));

timeLap_unstim_fam = reshape(cell2mat(cellfun(@(x) x(:,3),T_fam.timeInZone(idx_nov),'UniformOutput',0)),[90,nSess_fam]);
% m_timeUnstim_fam = mean(timeLap_unstim_fam,2);
% sem_timeUnstim_fam = std(timeLap_unstim_fam,0,2)/sqrt(nSess_fam);
m_timeUnstim_fam = smooth(mean(timeLap_unstim_fam,2));
sem_timeUnstim_fam = smooth(std(timeLap_unstim_fam,0,2)/sqrt(nSess_fam));

timeBlock_stim_fam = reshape(cell2mat(T_fam.sum_timeZone(idx_nov)),[3,4,nSess_fam])/60; % unit: sec -> min
m_timeBlock_stim_fam = mean(timeBlock_stim_fam,3);
sem_timeBlock_stim_fam = std(timeBlock_stim_fam,0,3)/sqrt(nSess_fam);
m_timeBlock_unstim_fam = mean(timeBlock_stim_fam,1);
sem_timeBlock_unstim_fam = std(timeBlock_stim_fam,0,1)/sqrt(nSess_fam);

%% stat
p_KW_total(1) = ranksum(timeBlock_nov(:,2),timeBlock_fam(:,1));
p_KW_total(2) = ranksum(timeBlock_nov(:,3),timeBlock_fam(:,2));
p_KW_total(3) = ranksum(timeBlock_nov(:,4),timeBlock_fam(:,3));

p_KW_stim(1) = ranksum(squeeze(timeBlock_stim_nov(2,3,:)),squeeze(timeBlock_stim_fam(1,3,:)));
p_KW_stim(2) = ranksum(squeeze(timeBlock_stim_nov(3,3,:)),squeeze(timeBlock_stim_fam(2,3,:)));
p_KW_stim(3) = ranksum(squeeze(timeBlock_stim_nov(4,3,:)),squeeze(timeBlock_stim_fam(3,3,:)));

p_KW_unstim(1) = ranksum(squeeze(timeBlock_stim_nov(2,1,:)),squeeze(timeBlock_stim_fam(1,1,:)));
p_KW_unstim(2) = ranksum(squeeze(timeBlock_stim_nov(3,1,:)),squeeze(timeBlock_stim_fam(2,1,:)));
p_KW_unstim(3) = ranksum(squeeze(timeBlock_stim_nov(4,1,:)),squeeze(timeBlock_stim_fam(3,1,:)));

[p_main_Fri_nov_tot,~,stat] = friedman(timeBlock_nov(:,2:4),1,'off');
result = multcompare(stat,'Display','off');
p_Fri_nov(:,1) = result(:,end);

[p_Fri_nov_stim,~,stat] = friedman(squeeze(timeBlock_stim_nov(2:4,3,:))',1,'off');
result = multcompare(stat,'Display','off');
p_Fri_nov(:,2) = result(:,end);

[p_Fri_nov_unstim,~,stat] = friedman(squeeze(timeBlock_stim_nov(2:4,1,:))',1,'off');
result = multcompare(stat,'Display','off');
p_Fri_nov(:,3) = result(:,end);

[p_main_Fri_fam_tot,~,stat] = friedman(timeBlock_fam,1,'off');
result = multcompare(stat,'Display','off');
p_Fri_fam(:,1) = result(:,end);

[p_main_Fri_fam_stim,~,stat] = friedman(squeeze(timeBlock_stim_fam(:,3,:))',1,'off');
result = multcompare(stat,'Display','off');
p_Fri_fam(:,2) = result(:,end);

[p_main_Fri_fam_unstim,~,stat] = friedman(squeeze(timeBlock_stim_fam(:,1,:))',1,'off');
result = multcompare(stat,'Display','off');
p_Fri_fam(:,3) = result(:,end);

rm_data_tot = [reshape(timeBlock_nov(:,2:4),[13*3,1]);reshape(timeBlock_fam(:,1:3),[19*3,1])];
rm_data_stim = [reshape(squeeze(timeBlock_stim_nov(2:4,3,:))',[13*3,1]);reshape(squeeze(timeBlock_stim_fam(:,3,:))',[19*3,1])];
rm_data_unstim = [reshape(squeeze(timeBlock_stim_nov(2:4,1,:))',[13*3,1]);reshape(squeeze(timeBlock_stim_fam(:,1,:))',[19*3,1])];
nov_mice = [ones(3,1);2*ones(2,1);3*ones(2,1);4*ones(3,1);5*ones(1,1);6*ones(2,1)];
fam_mice = [ones(6,1);2*ones(4,1);3*ones(3,1);4*ones(4,1);5*ones(1,1);6*ones(1,1)];
rm_s = [repmat(nov_mice,[3,1]);repmat(fam_mice,[3,1])]; 
rm_f1 = [ones(13*3,1);2*ones(19*3,1)];
f2_nov = [ones(13,1);2*ones(13,1);3*ones(13,1)];
f2_fam = [ones(19,1);2*ones(19,1);3*ones(19,1)];
rm_f2 = [f2_nov;f2_fam];
rm_factname = {'NovVsFam';'PREvsSTIMvsPOST'};
stats_rm_tot = rm_anova2(rm_data_tot,rm_s,rm_f1,rm_f2,rm_factname);
stats_rm_stim = rm_anova2(rm_data_stim,rm_s,rm_f1,rm_f2,rm_factname);
stats_rm_unstim = rm_anova2(rm_data_unstim,rm_s,rm_f1,rm_f2,rm_factname);

%% plot
fHandle = figure('PaperUnits','centimeters','PaperPosition',[0 0 22 15]);

nCol = 4;
nRow = 3;
markerS = 3;

barWidth = 0.25;
eBarWidth = 1;
eBarLength = 0.3;
xptBar_nov = [1,4,7];
xptBar_fam = [2,5,8];
xptTrial = 1:90;
xptScatter_nov = (rand(nSess_nov,1)-0.5)*1*barWidth;
xptScatter_fam = (rand(nSess_fam,1)-0.5)*1*barWidth;

% panel 1 (Lap comparisons)
hTimeLap = axes('Position',axpt(nCol,nRow,1:2,1,[],wideInterval));
    hPatch(1) = patch([xptTrial,fliplr(xptTrial)],[m_timeLap_nov(31:120)'-sem_timeLap_nov(31:120)',fliplr(m_timeLap_nov(31:120)'+sem_timeLap_nov(31:120)')],colorDarkGray);
    hold on;
    hPatch(2) = patch([xptTrial,fliplr(xptTrial)],[m_timeLap_fam'-sem_timeLap_fam',fliplr(m_timeLap_fam'+sem_timeLap_fam')],colorLightGray);
    hold on;
    hPatch(3) = patch([30 60 60 30],[0.5 0.5 5 5],colorLightBlue,'edgeColor','none');
    hPlot(1) = plot(xptTrial,m_timeLap_nov(31:120),'lineStyle',':','color',colorBlack);
    hold on;
    hPlot(2) = plot(xptTrial,m_timeLap_fam,'lineStyle','-','color',colorBlack);
    ylabel('Time (sec)','fontSize',fontM);
    xlabel('Trial','fontSize',fontM);
    text(1,40,'Time in total zone','fontSize',fontM);
    set(hTimeLap,'Box','off','TickDir','out','XLim',[0,91],'XTIck',[0:10:90],'YLim',[0, 45],'fontSize',fontM);

% panel 2 (Block comparisons) 
hTimeLapBlock = axes('Position',axpt(nCol,nRow,3,1,[],wideInterval));
    hBar(1) = bar(xptBar_nov,m_eachBlock_nov(2:4),'barWidth',barWidth,'lineStyle','-','edgeColor',colorBlack,'faceColor',colorDarkGray,'lineWidth',1);
    hold on;
    errorbarJun(xptBar_nov,m_eachBlock_nov(2:4),sem_eachBlock_nov(2:4),eBarLength,eBarWidth,colorBlack);
    hold on;
    hBar(2) = bar(xptBar_fam,m_eachBlock_fam,'barWidth',barWidth,'lineStyle','-','edgeColor',colorBlack,'faceColor',colorLightGray,'lineWidth',1);
    hold on;
    errorbarJun(xptBar_fam,m_eachBlock_fam,sem_eachBlock_fam,eBarLength,eBarWidth,colorBlack);
    hold on;
    for iBlock = 1:3
        plot(xptBar_nov(iBlock)+xptScatter_nov,timeBlock_nov(:,iBlock+1),'lineStyle','none','marker','o','markerSize',markerS,'markerFaceColor',colorLightGray,'markerEdgeColor',colorBlack);
        hold on;
        plot(xptBar_fam(iBlock)+xptScatter_fam,timeBlock_fam(:,iBlock),'lineStyle','none','marker','o','markerSize',markerS,'markerFaceColor',colorLightGray,'markerEdgeColor',colorBlack);
        hold on;
    end
    text(1,24,['Novel (n = ',num2str(nSess_nov),')'],'fontSize',fontM);
    text(1,22,['Familiar (n = ',num2str(nSess_fam),')'],'fontSize',fontM);
    text(1.2,15,'**','color',colorRed,'fontSize',fontL);
    text(4.4,15,'**','color',colorRed,'fontSize',fontL);
    text(7.2,15,'***','color',colorRed,'fontSize',fontL);
    ylabel('Time (min)','fontSize',fontM);
    set(hTimeLapBlock,'Box','off','TickDir','out','XLim',[0 9],'XTick',[1.5 4.5 7.5],'XTickLabel',{'PRE','STIM','POST'},'YLim',[0 25],'YTick',[0:5:25],'fontSize',fontM);

% panel 3 (Running zone comparisons / stim vs opposite zone?)
hTimeStimZone = axes('Position',axpt(nCol,nRow,1:2,2,[],wideInterval));
    hPatch(1) = patch([xptTrial,fliplr(xptTrial)],[m_timeStim_nov(31:120)'-sem_timeStim_nov(31:120)',fliplr(m_timeStim_nov(31:120)'+sem_timeStim_nov(31:120)')],colorDarkGray);
    hold on;
    hPatch(2) = patch([xptTrial,fliplr(xptTrial)],[m_timeStim_fam'-sem_timeStim_fam',fliplr(m_timeStim_fam'+sem_timeStim_fam')],colorLightGray);
    hold on;
    hPlot(1) = plot(xptTrial,m_timeStim_nov(31:120),'lineStyle',':','color',colorBlack);
    hold on;
    hPlot(2) = plot(xptTrial,m_timeStim_fam,'lineStyle','-','color',colorBlack);
    text(1,18,'Time in stimulated running zone','fontSize',fontM);
    ylabel('Time (sec)','fontSize',fontM);
    xlabel('Trial','fontSize',fontM);
    set(hTimeStimZone,'Box','off','TickDir','out','XLim',[0,91],'XTIck',[0:10:90],'YLim',[0, 20],'fontSize',fontM);

% panel 4
hTimeStimBar = axes('Position',axpt(nCol,nRow,3,2,[],wideInterval));
    hBar(1) = bar(xptBar_nov,m_timeBlock_stim_nov(2:4,3),'barWidth',barWidth,'lineStyle','-','edgeColor',colorBlack,'faceColor',colorDarkGray,'lineWidth',1);
    hold on;
    errorbarJun(xptBar_nov,m_timeBlock_stim_nov(2:4,3),sem_timeBlock_stim_nov(2:4,3),eBarLength,eBarWidth,colorBlack);
    hold on;
    hBar(2) = bar(xptBar_fam,m_timeBlock_stim_fam(:,3),'barWidth',barWidth,'lineStyle','-','edgeColor',colorBlack,'faceColor',colorLightGray,'lineWidth',1);
    hold on;
    errorbarJun(xptBar_fam,m_timeBlock_stim_fam(:,3),sem_timeBlock_stim_fam(:,3),eBarLength,eBarWidth,colorBlack);
    hold on;
    for iBlock = 1:3
        plot(xptBar_nov(iBlock)+xptScatter_nov,squeeze(timeBlock_stim_nov(iBlock+1,3,:)),'lineStyle','none','marker','o','markerSize',markerS,'markerFaceColor',colorLightGray,'markerEdgeColor',colorBlack);
        hold on;
        plot(xptBar_fam(iBlock)+xptScatter_fam,squeeze(timeBlock_stim_fam(iBlock,3,:)),'lineStyle','none','marker','o','markerSize',markerS,'markerFaceColor',colorLightGray,'markerEdgeColor',colorBlack);
        hold on;
    end
    text(1.4,6,'*','color',colorRed,'fontSize',fontL);
    text(4.4,6,'*','color',colorRed,'fontSize',fontL);
    text(7.4,6,'*','color',colorRed,'fontSize',fontL);
    ylabel('Time (min)','fontSize',fontM);
    set(hTimeStimBar,'Box','off','TickDir','out','XLim',[0 9],'XTick',[1.5 4.5 7.5],'XTickLabel',{'PRE','STIM','POST'},'YLim',[0 10],'YTick',[0:2:10],'fontSize',fontM);

% panel 5
hTimeUnstimZone = axes('Position',axpt(nCol,nRow,1:2,3,[],wideInterval));
    hPatch(1) = patch([xptTrial,fliplr(xptTrial)],[m_timeUnstim_nov(31:120)'-sem_timeUnstim_nov(31:120)',fliplr(m_timeUnstim_nov(31:120)'+sem_timeUnstim_nov(31:120)')],colorDarkGray);
    hold on;
    hPatch(2) = patch([xptTrial,fliplr(xptTrial)],[m_timeUnstim_fam'-sem_timeUnstim_fam',fliplr(m_timeUnstim_fam'+sem_timeUnstim_fam')],colorLightGray);
    hold on;
    hPlot(1) = plot(xptTrial,m_timeUnstim_nov(31:120),'lineStyle',':','color',colorBlack);
    hold on;
    hPlot(2) = plot(xptTrial,m_timeUnstim_fam,'lineStyle','-','color',colorBlack);
    ylabel('Time (sec)','fontSize',fontM);
    xlabel('Trial','fontSize',fontM);
    text(1,18,'Time in unstimulated running zone','fontSize',fontM);
    set(hTimeUnstimZone,'Box','off','TickDir','out','XLim',[0,91],'XTIck',[0:10:90],'YLim',[0, 20],'fontSize',fontM);

% panel 6
hTimeUnstimBar = axes('Position',axpt(nCol,nRow,3,3,[],wideInterval));
    hBar(1) = bar(xptBar_nov,m_timeBlock_stim_nov(2:4,1),'barWidth',barWidth,'lineStyle','-','edgeColor',colorBlack,'faceColor',colorDarkGray,'lineWidth',1);
    hold on;
    errorbarJun(xptBar_nov,m_timeBlock_stim_nov(2:4,1),sem_timeBlock_stim_nov(2:4,1),eBarLength,eBarWidth,colorBlack);
    hold on;
    hBar(2) = bar(xptBar_fam,m_timeBlock_stim_fam(:,1),'barWidth',barWidth,'lineStyle','-','edgeColor',colorBlack,'faceColor',colorLightGray,'lineWidth',1);
    hold on;
    errorbarJun(xptBar_fam,m_timeBlock_stim_fam(:,1),sem_timeBlock_stim_fam(:,1),eBarLength,eBarWidth,colorBlack);
    hold on;
    for iBlock = 1:3
        plot(xptBar_nov(iBlock)+xptScatter_nov,squeeze(timeBlock_stim_nov(iBlock+1,1,:)),'lineStyle','none','marker','o','markerSize',markerS,'markerFaceColor',colorLightGray,'markerEdgeColor',colorBlack);
        hold on;
        plot(xptBar_fam(iBlock)+xptScatter_fam,squeeze(timeBlock_stim_fam(iBlock,1,:)),'lineStyle','none','marker','o','markerSize',markerS,'markerFaceColor',colorLightGray,'markerEdgeColor',colorBlack);
        hold on;
    end
    text(1.4,6,'*','color',colorRed,'fontSize',fontL);
    text(4.4,6,'*','color',colorRed,'fontSize',fontL);
    text(7.4,6,'*','color',colorRed,'fontSize',fontL);    
    ylabel('Time (min)','fontSize',fontM);
    set(hTimeUnstimBar,'Box','off','TickDir','out','XLim',[0 9],'XTick',[1.5 4.5 7.5],'XTickLabel',{'PRE','STIM','POST'},'YLim',[0 10],'YTick',[0:2:10],'fontSize',fontM);

xptBar_nov = [1,2,3];
xptBar_fam = [5,6,7];
barWidth = 0.8;
eBarWidth = 1;
eBarLength = 0.5;

hGroupTotal = axes('Position',axpt(nCol,nRow,4,1,[],wideInterval));
    hBar(1) = bar(xptBar_nov,m_eachBlock_nov(2:4),'barWidth',barWidth,'lineStyle','-','edgeColor',colorBlack,'faceColor',colorDarkGray,'lineWidth',1);
    hold on;
    errorbarJun(xptBar_nov,m_eachBlock_nov(2:4),sem_eachBlock_nov(2:4),eBarLength,eBarWidth,colorBlack);
    hold on;
    hBar(2) = bar(xptBar_fam,m_eachBlock_fam,'barWidth',barWidth,'lineStyle','-','edgeColor',colorBlack,'faceColor',colorLightGray,'lineWidth',1);
    hold on;
    errorbarJun(xptBar_fam,m_eachBlock_fam,sem_eachBlock_fam,eBarLength,eBarWidth,colorBlack);
    hold on;
    for iBlock = 1:3
        plot(xptBar_nov(iBlock)+xptScatter_nov,timeBlock_nov(:,iBlock+1),'lineStyle','none','marker','o','markerSize',markerS,'markerFaceColor',colorLightGray,'markerEdgeColor',colorBlack);
        hold on;
        plot(xptBar_fam(iBlock)+xptScatter_fam,timeBlock_fam(:,iBlock),'lineStyle','none','marker','o','markerSize',markerS,'markerFaceColor',colorLightGray,'markerEdgeColor',colorBlack);
        hold on;
    end
    text(1.5,20,['n.s.'],'color',colorRed,'fontSize',fontM);

    text(5.3,15,'n.s.','color',colorRed,'fontSize',fontM);
    ylabel('Time (min)','fontSize',fontM);
    set(hGroupTotal,'Box','off','TickDir','out','XLim',[0 8],'XTick',[2,6],'XTickLabel',{'Novel','Familiar'},'YLim',[0 25],'YTick',[0:5:25],'fontSize',fontM);

hGroupStim = axes('Position',axpt(nCol,nRow,4,2,[],wideInterval));
 hBar(1) = bar(xptBar_nov,m_timeBlock_stim_nov(2:4,3),'barWidth',barWidth,'lineStyle','-','edgeColor',colorBlack,'faceColor',colorDarkGray,'lineWidth',1);
    hold on;
    errorbarJun(xptBar_nov,m_timeBlock_stim_nov(2:4,3),sem_timeBlock_stim_nov(2:4,3),eBarLength,eBarWidth,colorBlack);
    hold on;
    hBar(2) = bar(xptBar_fam,m_timeBlock_stim_fam(:,3),'barWidth',barWidth,'lineStyle','-','edgeColor',colorBlack,'faceColor',colorLightGray,'lineWidth',1);
    hold on;
    errorbarJun(xptBar_fam,m_timeBlock_stim_fam(:,3),sem_timeBlock_stim_fam(:,3),eBarLength,eBarWidth,colorBlack);
    hold on;
    for iBlock = 1:3
        plot(xptBar_nov(iBlock)+xptScatter_nov,squeeze(timeBlock_stim_nov(iBlock+1,3,:)),'lineStyle','none','marker','o','markerSize',markerS,'markerFaceColor',colorLightGray,'markerEdgeColor',colorBlack);
        hold on;
        plot(xptBar_fam(iBlock)+xptScatter_fam,squeeze(timeBlock_stim_fam(iBlock,3,:)),'lineStyle','none','marker','o','markerSize',markerS,'markerFaceColor',colorLightGray,'markerEdgeColor',colorBlack);
        hold on;
    end
    text(1.5,6,['n.s.'],'color',colorRed,'fontSize',fontM);
    text(0.5,9,['PREvsPOST(fam): p=', num2str(p_Fri_fam(3,2),3)],'color',colorRed,'fontSize',fontM);
    ylabel('Time (min)','fontSize',fontM);
    set(hGroupStim,'Box','off','TickDir','out','XLim',[0 8],'XTick',[2,6],'XTickLabel',{'Novel','Familiar'},'YLim',[0 10],'YTick',[0:2:10],'fontSize',fontM);

hGroupUnstim = axes('Position',axpt(nCol,nRow,4,3,[],wideInterval));
    hBar(1) = bar(xptBar_nov,m_timeBlock_stim_nov(2:4,1),'barWidth',barWidth,'lineStyle','-','edgeColor',colorBlack,'faceColor',colorDarkGray,'lineWidth',1);
    hold on;
    errorbarJun(xptBar_nov,m_timeBlock_stim_nov(2:4,1),sem_timeBlock_stim_nov(2:4,1),eBarLength,eBarWidth,colorBlack);
    hold on;
    hBar(2) = bar(xptBar_fam,m_timeBlock_stim_fam(:,1),'barWidth',barWidth,'lineStyle','-','edgeColor',colorBlack,'faceColor',colorLightGray,'lineWidth',1);
    hold on;
    errorbarJun(xptBar_fam,m_timeBlock_stim_fam(:,1),sem_timeBlock_stim_fam(:,1),eBarLength,eBarWidth,colorBlack);
    hold on;
    for iBlock = 1:3
        plot(xptBar_nov(iBlock)+xptScatter_nov,squeeze(timeBlock_stim_nov(iBlock+1,1,:)),'lineStyle','none','marker','o','markerSize',markerS,'markerFaceColor',colorLightGray,'markerEdgeColor',colorBlack);
        hold on;
        plot(xptBar_fam(iBlock)+xptScatter_fam,squeeze(timeBlock_stim_fam(iBlock,1,:)),'lineStyle','none','marker','o','markerSize',markerS,'markerFaceColor',colorLightGray,'markerEdgeColor',colorBlack);
        hold on;
    end
    text(1.5,7,'n.s.','color',colorRed,'fontSize',fontM);
    text(5.5,7,'n.s.','color',colorRed,'fontSize',fontM);
    ylabel('Time (min)','fontSize',fontM);
    set(hGroupUnstim,'Box','off','TickDir','out','XLim',[0 8],'XTick',[2,6],'XTickLabel',{'Novel','Familiar'},'YLim',[0 10],'YTick',[0:2:10],'fontSize',fontM);

print('-painters','-r300','-dtiff',['plot_total_behavior_rmAnova',datestr(now,formatOut),'.tif']);