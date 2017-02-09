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
r = mean(sqrt((taskposiX-centerX).^2+(taskposiY-centerY).^2));

nPosi = length(posiX(idx.task));
coefLine = zeros(nPosi,2);
[newX, newY] = deal(zeros(nPosi,1));
for iPosi = 1:nPosi
    coefLine = polyfit([taskposiX(iPosi),centerX],[taskposiY(iPosi),centerY],1);
    [tempX,tempY] = linecirc(coefLine(1,1),coefLine(1,2),centerX,centerY,r);
    if abs(tempX(1)-taskposiX(iPosi))+abs(tempY(1)-taskposiY(iPosi)) > abs(tempX(2)-taskposiX(iPosi))+abs(tempY(2)-taskposiY(iPosi))
        newX(iPosi,1) = tempX(2);
        newY(iPosi,1) = tempY(2);
    else
        newX(iPosi,1) = tempX(1);
        newY(iPosi,1) = tempY(1);
    end
end


