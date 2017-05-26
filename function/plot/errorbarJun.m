function h=errorbarJun(xData,yData,sem,barLength,lineWidth,lineColor)
% h=errorbarJun(xData,yData,sem,barLength,lineWidth,lineColor)
% inputs
% xData: data points of x
% yData: data points of y
% sem: either sem or std (xData, yData, sem should be the same length)
% bar Length:
% linecolor: RGB color code [x, y, z]

xptH = NaN(length(xData)*6,1);
yptH = NaN(length(xData)*6,1);
for index = 1:length(xData)
    xptH(6*index-5) = xData(index)-barLength/2;
    xptH(6*index-4) = xData(index)+barLength/2;
    xptH(6*index-2) = xData(index)-barLength/2;
    xptH(6*index-1) = xData(index)+barLength/2;
    
    yptH(6*index-5) = yData(index)-sem(index);
    yptH(6*index-4) = yData(index)-sem(index);
    yptH(6*index-2) = yData(index)+sem(index);
    yptH(6*index-1) = yData(index)+sem(index);
end

xptV = NaN(length(xData)*3,1);
yptV = NaN(length(yData)*3,1);
for index = 1:length(xData)
    xptV(3*index-2) = xData(index);
    xptV(3*index-1) = xData(index);
    
    yptV(3*index-2) = yData(index)-sem(index);
    yptV(3*index-1) = yData(index)+sem(index);
end

h.hori = plot(xptH,yptH,'-','lineWidth',lineWidth,'color',lineColor);
hold on;
h.verti = plot(xptV,yptV,'-','lineWidth',lineWidth,'color',lineColor);
end