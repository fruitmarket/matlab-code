function myBarFour(mean_GroupA, mean_GroupB, sem_GroupA, sem_GroupB)

barWidth = 0.3;
errorWidth = barWidth/4;

nGroup = size(mean_GroupA,1);

% Bar plot
for iGroup = 1:nGroup
    barA(iGroup) = bar(iGroup-barWidth/2,mean_GroupA(iGroup),barWidth);
    hold on;
    
    barB(iGroup) = bar(iGroup+barWidth/2,mean_GroupB(iGroup),barWidth); 
    hold on;
end
set(barA,'FaceColor','none','EdgeColor','k');
set(barB,'FaceColor',[189, 189, 189]./255,'EdgeColor','k');

% Error plot
for iGroup = 1:nGroup
    % Errorbar_GroupA
    hElowerA(iGroup) = plot([iGroup-barWidth/2-errorWidth/2, iGroup-barWidth/2+errorWidth/2],[mean_GroupA(iGroup)-sem_GroupA(iGroup),mean_GroupA(iGroup)-sem_GroupA(iGroup)]);
    hold on;
    hEupperA(iGroup) = plot([iGroup-barWidth/2-errorWidth/2, iGroup-barWidth/2+errorWidth/2],[mean_GroupA(iGroup)+sem_GroupA(iGroup),mean_GroupA(iGroup)+sem_GroupA(iGroup)]);
    hold on;
    hEVerticalA(iGroup) = plot([iGroup-barWidth/2,iGroup-barWidth/2],[mean_GroupA(iGroup)-sem_GroupA(iGroup),mean_GroupA(iGroup)+sem_GroupA(iGroup)]);
    hold on;
    
    % Errorbar_GroupB
    hElowerB(iGroup) = plot([iGroup+barWidth/2-errorWidth/2, iGroup+barWidth/2+errorWidth/2],[mean_GroupB(iGroup)-sem_GroupB(iGroup),mean_GroupB(iGroup)-sem_GroupB(iGroup)]);
    hold on;
    hEupperB(iGroup) = plot([iGroup+barWidth/2-errorWidth/2, iGroup+barWidth/2+errorWidth/2],[mean_GroupB(iGroup)+sem_GroupB(iGroup),mean_GroupB(iGroup)+sem_GroupB(iGroup)]);
    hold on;
    hEVerticalB(iGroup) = plot([iGroup+barWidth/2,iGroup+barWidth/2],[mean_GroupB(iGroup)-sem_GroupB(iGroup),mean_GroupB(iGroup)+sem_GroupB(iGroup)]);
    hold on;    
end
set(hElowerA,'Color','k','LineWidth',1.0);
set(hEupperA,'Color','k','LineWidth',1.0);
set(hEVerticalA,'Color','k','LineWidth',1.0);
set(hElowerB,'Color','k','LineWidth',1.0);
set(hEupperB,'Color','k','LineWidth',1.0);
set(hEVerticalB,'Color','k','LineWidth',1.0);

set(gca,'TickDir','out','XLim',[0,nGroup+3.5],'XTick',[1,2,3,4,],'XTickLabel',{'hf-hf(EO)','bf-du', 'bf-af', 'du-af'},'Box','off');