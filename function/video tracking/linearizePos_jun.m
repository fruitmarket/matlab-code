px2cm = 0.13;

[vtTime, vtPosition, vtList] = vtLoad;
[tData, tList] = tLoad;

load('Events.mat','baseTime','preTime','stmTime','postTime','taskTime');
timestamp = vtTime{1};

posiX = vtPosition{1}(:,1);
posiY = vtPosition{1}(:,2);

idx.task = taskTime(1,1)<=timestamp & timestamp<=taskTime(2,1);

taskposiX = posiX(idx.task);
taskposiY = posiY(idx.task);

idx.posiTask = find(~isnan(taskposiX) & ~isnan(taskposiY));
taskposiX = taskposiX(idx.posiTask);
taskposiY = taskposiY(idx.posiTask);

centerX = mean(taskposiX);
centerY = mean(taskposiY);

nPosi = length(posiX(idx.task));
coeffLine = zeros(nPosi,2);
for iPosi = 1:nPosi
    coeffLine(iPosi,:) = polyfit([taskposiX(iPosi),centerX],[taskposiY(iPosi),centerY],1);
    
end

r = mean(sqrt((taskposiX-centerX).^2+(taskposiY-centerY).^2));
