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
sess_nov = [1:7,9:12,14];
sess_fam = [4:6,10,11,13:17,19,20];

%%
% each lap analysis
eachLap_nov = round(cell2mat(T_nov.m_timeLap(sess_nov))/1000*100)/100;
nSess_nov = size(eachLap_nov,1);

m_eachLap_nov = mean(eachLap_nov);
sem_eachLap_nov = std(eachLap_nov,0,1)/sqrt(nSess_nov);
group_nov = {'basePRE','PRE','STIM','POST','basePOST'};
[p_KW_eachLap_main_nov,~,stats] = kruskalwallis(eachLap_nov,group_nov,'off');
result = multcompare(stats,'ctype','lsd','display','off');
p_KW_eachLap_detail_nov = result(:,end);

% block analysis
timeLap_nov = T_nov.timeLap(sess_nov);
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
timeLapTotal_nov = reshape(cell2mat(T_nov.timeLap(sess_nov)),[150,nSess_nov])/1000; % unit: msec >> sec
% m_timeLap_nov = mean(timeLapTotal_nov,2);
% sem_timeLap_nov = std(timeLapTotal_nov,0,2)/sqrt(nSess_nov);
m_timeLap_nov = smooth(mean(timeLapTotal_nov,2));
sem_timeLap_nov = smooth(std(timeLapTotal_nov,0,2)/sqrt(nSess_nov));

% stimulated vs unstimulated
timeLap_stim_nov = reshape(cell2mat(cellfun(@(x) x(:,1),T_nov.timeInZone(sess_nov),'UniformOutput',0)),[150,nSess_nov]);
% m_timeStim_nov = mean(timeLap_stim_nov,2);
% sem_timeStim_nov = std(timeLap_stim_nov,0,2)/sqrt(nSess_nov);
m_timeStim_nov = smooth(mean(timeLap_stim_nov,2));
sem_timeStim_nov = smooth(std(timeLap_stim_nov,0,2)/sqrt(nSess_nov));

timeLap_unstim_nov = reshape(cell2mat(cellfun(@(x) x(:,3),T_nov.timeInZone(sess_nov),'UniformOutput',0)),[150,nSess_nov]);
% m_timeUnstim_nov = mean(timeLap_unstim_nov,2);
% sem_timeUnstim_nov = std(timeLap_unstim_nov,0,2)/sqrt(nSess_nov);
m_timeUnstim_nov = smooth(mean(timeLap_unstim_nov,2));
sem_timeUnstim_nov = smooth(std(timeLap_unstim_nov,0,2)/sqrt(nSess_nov));

timeBlock_zone_nov = reshape(cell2mat(T_nov.sum_timeZone(sess_nov)),[5,4,nSess_nov])/60; % unit: sec -> min
m_timeBlock_zone_nov = mean(timeBlock_zone_nov,3);
sem_timeBlock_zone_nov = std(timeBlock_zone_nov,0,3)/sqrt(nSess_nov);

%%%%%%%%% Familiar %%%%%%%%%%%%%%%%%
% each lap analysis
eachLap_fam = round(cell2mat(T_fam.m_timeLap(sess_fam))/1000*100)/100;
nSess_fam = size(eachLap_fam,1);

m_eachLap_fam = mean(eachLap_fam);
sem_eachLap_fam = std(eachLap_fam,0,1)/sqrt(nSess_fam);
group_fam = {'PRE','STIM','POST'};
[p_KW_eachLap_main_fam,~,stats] = kruskalwallis(eachLap_fam,group_fam,'off');
result = multcompare(stats,'ctype','lsd','display','off');
p_KW_eachLap_detail_fam = result(:,end);

% block analysis
timeLap_fam = T_fam.timeLap(sess_fam);
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
timeLapTotal_fam = reshape(cell2mat(T_fam.timeLap(sess_fam)),[90,nSess_fam])/1000; % unit msec >> sec
% m_timeLap_fam = mean(timeLapTotal_fam,2);
% sem_timeLap_fam = std(timeLapTotal_fam,0,2)/sqrt(nSess_fam);
m_timeLap_fam = smooth(mean(timeLapTotal_fam,2));
sem_timeLap_fam = smooth(std(timeLapTotal_fam,0,2)/sqrt(nSess_fam));

% stimulated vs unstimulated
timeLap_stim_fam = reshape(cell2mat(cellfun(@(x) x(:,1),T_fam.timeInZone(sess_fam),'UniformOutput',0)),[90,nSess_fam]);
% m_timeStim_fam = mean(timeLap_stim_fam,2);
% sem_timeStim_fam = std(timeLap_stim_fam,0,2)/sqrt(nSess_fam);
m_timeStim_fam = smooth(mean(timeLap_stim_fam,2));
sem_timeStim_fam = smooth(std(timeLap_stim_fam,0,2)/sqrt(nSess_fam));

timeLap_unstim_fam = reshape(cell2mat(cellfun(@(x) x(:,3),T_fam.timeInZone(sess_fam),'UniformOutput',0)),[90,nSess_fam]);
% m_timeUnstim_fam = mean(timeLap_unstim_fam,2);
% sem_timeUnstim_fam = std(timeLap_unstim_fam,0,2)/sqrt(nSess_fam);
m_timeUnstim_fam = smooth(mean(timeLap_unstim_fam,2));
sem_timeUnstim_fam = smooth(std(timeLap_unstim_fam,0,2)/sqrt(nSess_fam));

timeBlock_zone_fam = reshape(cell2mat(T_fam.sum_timeZone(sess_fam)),[3,4,nSess_fam])/60; % unit: sec -> min
m_timeBlock_zone_fam = mean(timeBlock_zone_fam,3);
sem_timeBlock_zone_fam = std(timeBlock_zone_fam,0,3)/sqrt(nSess_fam);

%% stat
p_sr_total(1) = signrank(timeBlock_nov(:,2),timeBlock_fam(:,1));
p_sr_total(2) = signrank(timeBlock_nov(:,3),timeBlock_fam(:,2));
p_sr_total(3) = signrank(timeBlock_nov(:,4),timeBlock_fam(:,3));
p_sr_stim(1) = signrank(squeeze(timeBlock_zone_nov(2,3,:)),squeeze(timeBlock_zone_fam(1,3,:)));
p_sr_stim(2) = signrank(squeeze(timeBlock_zone_nov(3,3,:)),squeeze(timeBlock_zone_fam(2,3,:)));
p_sr_stim(3) = signrank(squeeze(timeBlock_zone_nov(4,3,:)),squeeze(timeBlock_zone_fam(3,3,:)));
p_sr_unstim(1) = signrank(squeeze(timeBlock_zone_nov(2,1,:)),squeeze(timeBlock_zone_fam(1,1,:)));
p_sr_unstim(2) = signrank(squeeze(timeBlock_zone_nov(3,1,:)),squeeze(timeBlock_zone_fam(2,1,:)));
p_sr_unstim(3) = signrank(squeeze(timeBlock_zone_nov(4,1,:)),squeeze(timeBlock_zone_fam(3,1,:)));

p_sr_sup(1) = signrank(timeBlock_nov(:,3),timeBlock_fam(:,3));
p_sr_sup(2) = signrank(squeeze(timeBlock_zone_nov(3,3,:)),squeeze(timeBlock_zone_fam(3,3,:)));
p_sr_sup(3) = signrank(squeeze(timeBlock_zone_nov(3,1,:)),squeeze(timeBlock_zone_fam(3,1,:)));

% [p_main_Fri_nov_tot,~,stat] = friedman(timeBlock_nov(:,2:4),1,'off');
% result = multcompare(stat,'Display','off');
% p_Fri_nov(:,1) = result(:,end);
% 
% [p_Fri_nov_stim,~,stat] = friedman(squeeze(timeBlock_zone_nov(2:4,3,:))',1,'off');
% result = multcompare(stat,'Display','off');
% p_Fri_nov(:,2) = result(:,end);
% 
% [p_Fri_nov_unstim,~,stat] = friedman(squeeze(timeBlock_zone_nov(2:4,1,:))',1,'off');
% result = multcompare(stat,'Display','off');
% p_Fri_nov(:,3) = result(:,end);
% 
% [p_main_Fri_fam_tot,~,stat] = friedman(timeBlock_fam,1,'off');
% result = multcompare(stat,'Display','off');
% p_Fri_fam(:,1) = result(:,end);
% 
% [p_main_Fri_fam_stim,~,stat] = friedman(squeeze(timeBlock_zone_fam(:,3,:))',1,'off');
% result = multcompare(stat,'Display','off');
% p_Fri_fam(:,2) = result(:,end);
% 
% [p_main_Fri_fam_unstim,~,stat] = friedman(squeeze(timeBlock_zone_fam(:,1,:))',1,'off');
% result = multcompare(stat,'Display','off');
% p_Fri_fam(:,3) = result(:,end);

%% plot
fHandle = figure('PaperUnits','centimeters','PaperPosition',[0 0 15 18]);

nCol = 1;
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
xptPRE = [1,2];
xptSTIM = [4,5];
xptPOST = [7,8];

% panel 1 (example animal)
hTimeLap = axes('Position',axpt(6,6,1:3,1:5,axpt(nCol,nRow,1,1,[],wideInterval),wideInterval));
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
    plot(xptPRE,[timeBlock_nov(:,2),timeBlock_fam(:,1)],'lineStyle','-','marker','none','color',colorDarkGray);
    hold on;
    errorbarJun(xptPRE,[m_eachBlock_nov(2),m_eachBlock_fam(1)],[sem_eachBlock_nov(2), sem_eachBlock_fam(1)],eBarLength,eBarWidth,colorBlack);
    hold on;
    plot(xptPRE,[m_eachBlock_nov(2),m_eachBlock_fam(1)],'lineStyle','-','marker','none','color',colorBlack);
    hold on;
    plot(xptPRE(1),m_eachBlock_nov(2),'lineStyle','none','marker','o','markerSize',markerS,'color',colorBlack,'markerFacecolor',colorDarkGray);
    hold on;
    plot(xptPRE(2),m_eachBlock_fam(1),'lineStyle','none','marker','o','markerSize',markerS,'color',colorBlack,'markerFacecolor',colorLightGray);
    hold on;
    
    plot(xptSTIM,[timeBlock_nov(:,3), timeBlock_fam(:,2)],'lineStyle','-','marker','none','color',colorDarkGray);
    hold on;
    errorbarJun(xptSTIM,[m_eachBlock_nov(3),m_eachBlock_fam(2)],[sem_eachBlock_nov(3), sem_eachBlock_fam(2)],eBarLength,eBarWidth,colorBlack);
    hold on;
    plot(xptSTIM,[m_eachBlock_nov(3),m_eachBlock_fam(2)],'lineStyle','-','marker','none','color',colorBlack);
    hold on;
    plot(xptSTIM(1),m_eachBlock_nov(3),'lineStyle','none','marker','o','markerSize',markerS,'color',colorBlack,'markerFacecolor',colorDarkGray);
    hold on;
    plot(xptSTIM(2),m_eachBlock_fam(2),'lineStyle','none','marker','o','markerSize',markerS,'color',colorBlack,'markerFacecolor',colorLightGray);
    hold on;
    
    plot(xptPOST,[timeBlock_nov(:,4), timeBlock_fam(:,3)],'lineStyle','-','marker','none','color',colorDarkGray);
    hold on;
    errorbarJun(xptPOST,[m_eachBlock_nov(4),m_eachBlock_fam(3)],[sem_eachBlock_nov(4), sem_eachBlock_fam(3)],eBarLength,eBarWidth,colorBlack);
    hold on;
    plot(xptPOST,[m_eachBlock_nov(4),m_eachBlock_fam(3)],'lineStyle','-','marker','none','color',colorBlack);
    hold on;
    plot(xptPOST(1),m_eachBlock_nov(4),'lineStyle','none','marker','o','markerSize',markerS,'color',colorBlack,'markerFacecolor',colorDarkGray);
    hold on;
    plot(xptPOST(2),m_eachBlock_fam(3),'lineStyle','none','marker','o','markerSize',markerS,'color',colorBlack,'markerFacecolor',colorLightGray);

    text(0.5,34,['Novel (n = ',num2str(nSess_nov),')'],'fontSize',fontM);
    text(0.5,30,['Familiar (n = ',num2str(nSess_fam),')'],'fontSize',fontM);
    text(1,25,'**','color',colorRed,'fontSize',fontL);
    text(4,25,'**','color',colorRed,'fontSize',fontL);
    text(7,25,'***','color',colorRed,'fontSize',fontL);
    text(0,-10,[num2str(p_sr_total,3)],'fontSize',fontM);
    ylabel('Time (min)','fontSize',fontM);
    set(hTimeLapBlock,'Box','off','TickDir','out','XLim',[0 9],'XTick',[1.5 4.5 7.5],'XTickLabel',{'PRE','STIM','POST'},'YLim',[0 30],'YTick',[0:5:30],'fontSize',fontM);

% panel 4
hTimeStimBar = axes('Position',axpt(3,3,2,1:2,axpt(nCol,nRow,1,2,[],wideInterval),wideInterval));
    plot(xptPRE,[squeeze(timeBlock_zone_nov(2,3,:)),squeeze(timeBlock_zone_fam(1,3,:))],'lineStyle','-','marker','none','color',colorDarkGray);
    hold on;
    errorbarJun(xptPRE,[m_timeBlock_zone_nov(2,3),m_timeBlock_zone_fam(1,3)],[sem_timeBlock_zone_nov(2,3), sem_timeBlock_zone_fam(1,3)],eBarLength,eBarWidth,colorBlack);
    hold on;
    plot(xptPRE,[m_timeBlock_zone_nov(2,3),m_timeBlock_zone_fam(1,3)],'lineStyle','-','marker','none','color',colorBlack);
    hold on;
    
    plot(xptSTIM,[squeeze(timeBlock_zone_nov(3,3,:)),squeeze(timeBlock_zone_fam(2,3,:))],'lineStyle','-','marker','none','color',colorDarkGray);
    hold on;
    errorbarJun(xptSTIM,[m_timeBlock_zone_nov(3,3),m_timeBlock_zone_fam(2,3)],[sem_timeBlock_zone_nov(3,3), sem_timeBlock_zone_fam(2,3)],eBarLength,eBarWidth,colorBlack);
    hold on;
    plot(xptSTIM,[m_timeBlock_zone_nov(3,3),m_timeBlock_zone_fam(2,3)],'lineStyle','-','marker','none','color',colorBlack);
    hold on;
    
    plot(xptPOST,[squeeze(timeBlock_zone_nov(4,3,:)),squeeze(timeBlock_zone_fam(3,3,:))],'lineStyle','-','marker','none','color',colorDarkGray);
    hold on;
    errorbarJun(xptPOST,[m_timeBlock_zone_nov(4,3),m_timeBlock_zone_fam(3,3)],[sem_timeBlock_zone_nov(4,3), sem_timeBlock_zone_fam(3,3)],eBarLength,eBarWidth,colorBlack);
    hold on;
    plot(xptPOST,[m_timeBlock_zone_nov(4,3),m_timeBlock_zone_fam(3,3)],'lineStyle','-','marker','none','color',colorBlack);
    hold on;
    
    plot([xptPRE(1),xptSTIM(1),xptPOST(1)],m_timeBlock_zone_nov(2:4,3),'lineStyle','none','marker','o','markerSize',markerS,'color',colorBlack,'markerFacecolor',colorDarkGray);
    hold on;
    plot([xptPRE(2),xptSTIM(2),xptPOST(2)],m_timeBlock_zone_fam(1:3,3),'lineStyle','none','marker','o','markerSize',markerS,'color',colorBlack,'markerFacecolor',colorLightGray);
    hold on;
        
    text(7.1,8,'**','color',colorRed,'fontSize',fontL);
    text(0,-3,[num2str(p_sr_stim,3)],'fontSize',fontM);
    ylabel('Time (min)','fontSize',fontM);
    set(hTimeStimBar,'Box','off','TickDir','out','XLim',[0 9],'XTick',[1.5 4.5 7.5],'XTickLabel',{'PRE','STIM','POST'},'YLim',[0 10],'YTick',[0:2:10],'fontSize',fontM);

% panel 5
hTimeUnstimBar = axes('Position',axpt(3,3,3,1:2,axpt(nCol,nRow,1,2,[],wideInterval),wideInterval));
    plot(xptPRE,[squeeze(timeBlock_zone_nov(2,1,:)),squeeze(timeBlock_zone_fam(1,1,:))],'lineStyle','-','marker','none','color',colorDarkGray);
    hold on;
    errorbarJun(xptPRE,[m_timeBlock_zone_nov(2,1),m_timeBlock_zone_fam(1,1)],[sem_timeBlock_zone_nov(2,1), sem_timeBlock_zone_fam(1,1)],eBarLength,eBarWidth,colorBlack);
    hold on;
    plot(xptPRE,[m_timeBlock_zone_nov(2,1),m_timeBlock_zone_fam(1,1)],'lineStyle','-','marker','none','color',colorBlack);
    hold on;
    
    plot(xptSTIM,[squeeze(timeBlock_zone_nov(3,1,:)),squeeze(timeBlock_zone_fam(2,1,:))],'lineStyle','-','marker','none','color',colorDarkGray);
    hold on;
    errorbarJun(xptSTIM,[m_timeBlock_zone_nov(3,1),m_timeBlock_zone_fam(2,1)],[sem_timeBlock_zone_nov(3,1), sem_timeBlock_zone_fam(2,1)],eBarLength,eBarWidth,colorBlack);
    hold on;
    plot(xptSTIM,[m_timeBlock_zone_nov(3,1),m_timeBlock_zone_fam(2,1)],'lineStyle','-','marker','none','color',colorBlack);
    hold on;
    
    plot(xptPOST,[squeeze(timeBlock_zone_nov(4,1,:)),squeeze(timeBlock_zone_fam(3,1,:))],'lineStyle','-','marker','none','color',colorDarkGray);
    hold on;
    errorbarJun(xptPOST,[m_timeBlock_zone_nov(4,1),m_timeBlock_zone_fam(3,1)],[sem_timeBlock_zone_nov(4,1), sem_timeBlock_zone_fam(3,1)],eBarLength,eBarWidth,colorBlack);
    hold on;
    plot(xptPOST,[m_timeBlock_zone_nov(4,1),m_timeBlock_zone_fam(3,1)],'lineStyle','-','marker','none','color',colorBlack);
    hold on;
    
    plot([xptPRE(1),xptSTIM(1),xptPOST(1)],m_timeBlock_zone_nov(2:4,1),'lineStyle','none','marker','o','markerSize',markerS,'color',colorBlack,'markerFacecolor',colorDarkGray);
    hold on;
    plot([xptPRE(2),xptSTIM(2),xptPOST(2)],m_timeBlock_zone_fam(1:3,1),'lineStyle','none','marker','o','markerSize',markerS,'color',colorBlack,'markerFacecolor',colorLightGray);
    hold on;
    text(4.2,9,'*','color',colorRed,'fontSize',fontL);
    text(7,9,'***','color',colorRed,'fontSize',fontL);
    text(0,-3,[num2str(p_sr_unstim,3)],'fontSize',fontM);
    ylabel('Time (min)','fontSize',fontM);
    set(hTimeUnstimBar,'Box','off','TickDir','out','XLim',[0 9],'XTick',[1.5 4.5 7.5],'XTickLabel',{'PRE','STIM','POST'},'YLim',[0 10],'YTick',[0:2:10],'fontSize',fontM);

% Supple
hSupple(1) = axes('Position',axpt(4,6,1,1:5,axpt(nCol,nRow,1,3,[],wideInterval),wideInterval));
    plot(xptPRE,[timeBlock_nov(:,3),timeBlock_fam(:,3)],'lineStyle','-','marker','none','color',colorDarkGray);
    hold on;
    errorbarJun(xptPRE,[m_eachBlock_nov(3),m_eachBlock_fam(3)],[sem_eachBlock_nov(3), sem_eachBlock_fam(3)],eBarLength,eBarWidth,colorBlack);
    hold on;
    plot(xptPRE,[m_eachBlock_nov(3),m_eachBlock_fam(3)],'lineStyle','-','marker','none','color',colorBlack);
    hold on;
    plot(xptPRE(1),m_eachBlock_nov(3),'lineStyle','none','marker','o','markerSize',markerS,'color',colorBlack,'markerFacecolor',colorDarkGray);
    hold on;
    plot(xptPRE(2),m_eachBlock_fam(3),'lineStyle','none','marker','o','markerSize',markerS,'color',colorBlack,'markerFacecolor',colorLightGray);
    text(0,-5,['KW-test: ',num2str(p_sr_sup(1))],'fontSize',fontM);
    text(1.5,17,'*','color',colorRed,'fontSize',fontL);
    ylabel('Time (min)','fontSize',fontM);
    title('Entire','fontSize',fontM);
    
hSupple(2) = axes('Position',axpt(4,6,2,1:5,axpt(nCol,nRow,1,3,[],wideInterval),wideInterval));
    plot(xptPRE,[squeeze(timeBlock_zone_nov(3,3,:)),squeeze(timeBlock_zone_fam(3,3,:))],'lineStyle','-','marker','none','color',colorDarkGray);
    hold on;
    errorbarJun(xptPRE,[m_timeBlock_zone_nov(3,3),m_timeBlock_zone_fam(3,3)],[sem_timeBlock_zone_nov(3,3), sem_timeBlock_zone_fam(3,3)],eBarLength,eBarWidth,colorBlack);
    hold on;
    plot(xptPRE,[m_timeBlock_zone_nov(3,3),m_timeBlock_zone_fam(3,3)],'lineStyle','-','marker','none','color',colorBlack);
    hold on;
    plot(1,m_timeBlock_zone_nov(3,3),'lineStyle','none','marker','o','markerSize',markerS,'color',colorBlack,'markerFacecolor',colorDarkGray);
    hold on;
    plot(2,m_timeBlock_zone_fam(3,3),'lineStyle','none','marker','o','markerSize',markerS,'color',colorBlack,'markerFacecolor',colorLightGray);
    text(0,-1,['KW-test: ',num2str(p_sr_sup(2))],'fontSize',fontM);
    ylabel('Time (min)','fontSize',fontM);
    title('In-zone','fontSize',fontM);
    
hSupple(3) = axes('Position',axpt(4,6,3,1:5,axpt(nCol,nRow,1,3,[],wideInterval),wideInterval));
    plot(xptPRE,[squeeze(timeBlock_zone_nov(3,1,:)),squeeze(timeBlock_zone_fam(3,1,:))],'lineStyle','-','marker','none','color',colorDarkGray);
    hold on;
    errorbarJun(xptPRE,[m_timeBlock_zone_nov(3,1),m_timeBlock_zone_fam(3,1)],[sem_timeBlock_zone_nov(3,1), sem_timeBlock_zone_fam(3,1)],eBarLength,eBarWidth,colorBlack);
    hold on;
    plot(xptPRE,[m_timeBlock_zone_nov(3,1),m_timeBlock_zone_fam(3,1)],'lineStyle','-','marker','none','color',colorBlack);
    hold on;
    plot(1,m_timeBlock_zone_nov(3,1),'lineStyle','none','marker','o','markerSize',markerS,'color',colorBlack,'markerFacecolor',colorDarkGray);
    hold on;
    plot(2,m_timeBlock_zone_fam(3,1),'lineStyle','none','marker','o','markerSize',markerS,'color',colorBlack,'markerFacecolor',colorLightGray);
    text(0,-2,['KW-test: ',num2str(p_sr_sup(3))],'fontSize',fontM);
    ylabel('Time (min)','fontSize',fontM);
    title('Ctrl-zone','fontSize',fontM);
    
    set(hSupple,'Box','off','TickDir','out','XLim',[0.5,2.5],'XTick',[1,2],'XTickLabel',{'Novel', 'Familiar'},'fontSize',fontM);
%     ylabel('Time (sec)','fontSize',fontM);
%     xlabel('Trial','fontSize',fontM);
%     text(1,43,['Novel (n = ',num2str(nSess_nov),')'],'fontSize',fontM);
%     text(1,39,['Familiar (n = ',num2str(nSess_fam),')'],'fontSize',fontM);
%     set(hTimeLap,'Box','off','TickDir','out','XLim',[0,91],'XTIck',[0:10:90],'YLim',[0, 45],'fontSize',fontM);
    
print('-painters','-r300','-dtiff',['fig2_behavior_',datestr(now,formatOut),'.tif']);
print('-painters','-r300','-depsc',['fig2_behavior_',datestr(now,formatOut),'.ai']); % print from matlab2014a
close all;