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
eachLap_nov = round(cell2mat(T_nov.m_timeLap)/1000*100)/100;
nSess_nov = size(eachLap_nov,1);

m_eachLap_nov = mean(eachLap_nov);
sem_eachLap_nov = std(eachLap_nov,0,1)/sqrt(nSess_nov);
group_nov = {'basePRE','PRE','STIM','POST','basePOST'};
[p_KW_eachLap_main_nov,~,stats] = kruskalwallis(eachLap_nov,group_nov,'off');
result = multcompare(stats,'ctype','lsd','display','off');
p_KW_eachLap_detail_nov = result(:,end);

% block analysis
timeLap_nov = T_nov.timeLap;
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
timeLapTotal_nov = reshape(cell2mat(T_nov.timeLap),[150,nSess_nov])/1000; % unit: msec >> sec
% m_timeLap_nov = mean(timeLapTotal_nov,2);
% sem_timeLap_nov = std(timeLapTotal_nov,0,2)/sqrt(nSess_nov);
m_timeLap_nov = smooth(mean(timeLapTotal_nov,2));
sem_timeLap_nov = smooth(std(timeLapTotal_nov,0,2)/sqrt(nSess_nov));

% stimulated vs unstimulated
timeLap_stim_nov = reshape(cell2mat(cellfun(@(x) x(:,1),T_nov.timeInZone,'UniformOutput',0)),[150,nSess_nov]);
% m_timeStim_nov = mean(timeLap_stim_nov,2);
% sem_timeStim_nov = std(timeLap_stim_nov,0,2)/sqrt(nSess_nov);
m_timeStim_nov = smooth(mean(timeLap_stim_nov,2));
sem_timeStim_nov = smooth(std(timeLap_stim_nov,0,2)/sqrt(nSess_nov));

timeLap_unstim_nov = reshape(cell2mat(cellfun(@(x) x(:,3),T_nov.timeInZone,'UniformOutput',0)),[150,nSess_nov]);
% m_timeUnstim_nov = mean(timeLap_unstim_nov,2);
% sem_timeUnstim_nov = std(timeLap_unstim_nov,0,2)/sqrt(nSess_nov);
m_timeUnstim_nov = smooth(mean(timeLap_unstim_nov,2));
sem_timeUnstim_nov = smooth(std(timeLap_unstim_nov,0,2)/sqrt(nSess_nov));

timeBlock_stim_nov = reshape(cell2mat(T_nov.sum_timeZone),[5,4,nSess_nov])/60; % unit: sec -> min
m_timeBlock_stim_nov = mean(timeBlock_stim_nov,3);
sem_timeBlock_stim_nov = std(timeBlock_stim_nov,0,3)/sqrt(nSess_nov);
m_timeBlock_unstim_nov = mean(timeBlock_stim_nov,1);
sem_timeBlock_unstim_nov = std(timeBlock_stim_nov,0,1)/sqrt(nSess_nov);

ex_nov = reshape(cell2mat(T_nov.timeLap(9:11)),[150,3])/1000;
m_ex_nov = smooth(mean(ex_nov,2));
sem_ex_nov = smooth(std(ex_nov,0,2)/sqrt(3));

%%%%%%%%% Familiar %%%%%%%%%%%%%%%%%
% each lap analysis
eachLap_fam = round(cell2mat(T_fam.m_timeLap)/1000*100)/100;
nSess_fam = size(eachLap_fam,1);

m_eachLap_fam = mean(eachLap_fam);
sem_eachLap_fam = std(eachLap_fam,0,1)/sqrt(nSess_fam);
group_fam = {'PRE','STIM','POST'};
[p_KW_eachLap_main_fam,~,stats] = kruskalwallis(eachLap_fam,group_fam,'off');
result = multcompare(stats,'ctype','lsd','display','off');
p_KW_eachLap_detail_fam = result(:,end);

% block analysis
timeLap_fam = T_fam.timeLap;
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
timeLapTotal_fam = reshape(cell2mat(T_fam.timeLap),[90,nSess_fam])/1000; % unit msec >> sec
% m_timeLap_fam = mean(timeLapTotal_fam,2);
% sem_timeLap_fam = std(timeLapTotal_fam,0,2)/sqrt(nSess_fam);
m_timeLap_fam = smooth(mean(timeLapTotal_fam,2));
sem_timeLap_fam = smooth(std(timeLapTotal_fam,0,2)/sqrt(nSess_fam));

% stimulated vs unstimulated
timeLap_stim_fam = reshape(cell2mat(cellfun(@(x) x(:,1),T_fam.timeInZone,'UniformOutput',0)),[90,nSess_fam]);
% m_timeStim_fam = mean(timeLap_stim_fam,2);
% sem_timeStim_fam = std(timeLap_stim_fam,0,2)/sqrt(nSess_fam);
m_timeStim_fam = smooth(mean(timeLap_stim_fam,2));
sem_timeStim_fam = smooth(std(timeLap_stim_fam,0,2)/sqrt(nSess_fam));

timeLap_unstim_fam = reshape(cell2mat(cellfun(@(x) x(:,3),T_fam.timeInZone,'UniformOutput',0)),[90,nSess_fam]);
% m_timeUnstim_fam = mean(timeLap_unstim_fam,2);
% sem_timeUnstim_fam = std(timeLap_unstim_fam,0,2)/sqrt(nSess_fam);
m_timeUnstim_fam = smooth(mean(timeLap_unstim_fam,2));
sem_timeUnstim_fam = smooth(std(timeLap_unstim_fam,0,2)/sqrt(nSess_fam));

timeBlock_stim_fam = reshape(cell2mat(T_fam.sum_timeZone),[3,4,nSess_fam])/60; % unit: sec -> min
m_timeBlock_stim_fam = mean(timeBlock_stim_fam,3);
sem_timeBlock_stim_fam = std(timeBlock_stim_fam,0,3)/sqrt(nSess_fam);
m_timeBlock_unstim_fam = mean(timeBlock_stim_fam,1);
sem_timeBlock_unstim_fam = std(timeBlock_stim_fam,0,1)/sqrt(nSess_fam);

ex_fam = reshape(cell2mat(T_fam.timeLap(15:18)),[90,4])/1000;
m_ex_fam = smooth(mean(ex_fam,2));
sem_ex_fam = smooth(std(ex_fam,0,2)/sqrt(3));

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

%% plot
fHandle = figure('PaperUnits','centimeters','PaperPosition',[0 0 15 12]);

nCol = 1;
nRow = 2;
markerS = 3;

barWidth = 0.25;
eBarWidth = 1;
eBarLength = 0.3;
xptBar_nov = [1,4,7];
xptBar_fam = [2,5,8];
xptTrial = 1:90;
xptScatter_nov = (rand(nSess_nov,1)-0.5)*1*barWidth;
xptScatter_fam = (rand(nSess_fam,1)-0.5)*1*barWidth;

% panel 1 (example animal)
hExample = axes('Position',axpt(2,6,1,1:5,axpt(nCol,nRow,1,1,[],wideInterval),wideInterval));
    hPatch(1) = patch([xptTrial,fliplr(xptTrial)],[m_ex_nov(31:120)'-sem_ex_nov(31:120)',fliplr(m_ex_nov(31:120)'+sem_ex_nov(31:120)')],colorDarkGray);
    hold on;
    hPatch(2) = patch([xptTrial,fliplr(xptTrial)],[m_ex_fam'-sem_ex_fam',fliplr(m_ex_fam'+sem_ex_fam')],colorLightGray);
    hold on;
    hPatch(3) = patch([30 60 60 30],[0.3 0.3 65*0.05 65*0.05],colorLightBlue,'edgeColor','none');
    hPlot(1) = plot(xptTrial,m_ex_nov(31:120),'lineStyle','-','color',colorBlack);
    hold on;
    hPlot(2) = plot(xptTrial,m_ex_fam,'lineStyle','-','color',colorBlack);
    ylabel('Time (sec)','fontSize',fontM);
    xlabel('Trial','fontSize',fontM);
    text(1,64,'Novel (n = 3)','fontSize',fontM);
    text(1,59,'Familiar (n = 3)','fontSize',fontM);
    set(hExample,'Box','off','TickDir','out','XLim',[0,91],'XTIck',[0:10:90],'YLim',[0, 65],'YTick',[0:20:60],'fontSize',fontM);
    
% panel 2 (Total)
hTimeLap = axes('Position',axpt(2,6,2,1:5,axpt(nCol,nRow,1,1,[],wideInterval),wideInterval));
    hPatch(1) = patch([xptTrial,fliplr(xptTrial)],[m_timeLap_nov(31:120)'-sem_timeLap_nov(31:120)',fliplr(m_timeLap_nov(31:120)'+sem_timeLap_nov(31:120)')],colorDarkGray);
    hold on;
    hPatch(2) = patch([xptTrial,fliplr(xptTrial)],[m_timeLap_fam'-sem_timeLap_fam',fliplr(m_timeLap_fam'+sem_timeLap_fam')],colorLightGray);
    hold on;
    hPatch(3) = patch([30 60 60 30],[0.3 0.3 45*0.05 45*0.05],colorLightBlue,'edgeColor','none');
    hPlot(1) = plot(xptTrial,m_timeLap_nov(31:120),'lineStyle','-','color',colorBlack);
    hold on;
    hPlot(2) = plot(xptTrial,m_timeLap_fam,'lineStyle','-','color',colorBlack);
    ylabel('Time (sec)','fontSize',fontM);
    xlabel('Trial','fontSize',fontM);
    text(1,43,['Novel (n = ',num2str(nSess_nov),')'],'fontSize',fontM);
    text(1,39,['Familiar (n = ',num2str(nSess_fam),')'],'fontSize',fontM);
    set(hTimeLap,'Box','off','TickDir','out','XLim',[0,91],'XTIck',[0:10:90],'YLim',[0, 45],'fontSize',fontM);

% panel 3 (block comparison)
hTimeLapBlock = axes('Position',axpt(3,3,1,1:2,axpt(nCol,nRow,1,2,[],wideInterval),wideInterval));
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
    text(0.5,24,['Novel (n = ',num2str(nSess_nov),')'],'fontSize',fontM);
    text(0.5,22,['Familiar (n = ',num2str(nSess_fam),')'],'fontSize',fontM);
    text(1.2,15,'**','color',colorRed,'fontSize',fontL);
    text(4.4,15,'**','color',colorRed,'fontSize',fontL);
    text(7.2,15,'***','color',colorRed,'fontSize',fontL);
    ylabel('Time (min)','fontSize',fontM);
    set(hTimeLapBlock,'Box','off','TickDir','out','XLim',[0 9],'XTick',[1.5 4.5 7.5],'XTickLabel',{'PRE','STIM','POST'},'YLim',[0 25],'YTick',[0:5:25],'fontSize',fontM);

% panel 4
hTimeStimBar = axes('Position',axpt(3,3,2,1:2,axpt(nCol,nRow,1,2,[],wideInterval),wideInterval));
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
    text(4.4,6,'**','color',colorRed,'fontSize',fontL);
    text(7.2,6,'***','color',colorRed,'fontSize',fontL);
    ylabel('Time (min)','fontSize',fontM);
    set(hTimeStimBar,'Box','off','TickDir','out','XLim',[0 9],'XTick',[1.5 4.5 7.5],'XTickLabel',{'PRE','STIM','POST'},'YLim',[0 10],'YTick',[0:2:10],'fontSize',fontM);

% panel 5
hTimeUnstimBar = axes('Position',axpt(3,3,3,1:2,axpt(nCol,nRow,1,2,[],wideInterval),wideInterval));
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
    text(7.2,6,'***','color',colorRed,'fontSize',fontL);    
    ylabel('Time (min)','fontSize',fontM);
    set(hTimeUnstimBar,'Box','off','TickDir','out','XLim',[0 9],'XTick',[1.5 4.5 7.5],'XTickLabel',{'PRE','STIM','POST'},'YLim',[0 10],'YTick',[0:2:10],'fontSize',fontM);

print('-painters','-r300','-dtiff',['fig3_behavior_',datestr(now,formatOut),'.tif']);
print('-painters','-r300','-depsc',['fig3_behavior_',datestr(now,formatOut),'.ai']); % print from matlab2014a
close all;