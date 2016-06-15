function h = MyErrorBarGroupPlot(y,x,barWidth,xColor)
%MyScatterBarPlot Plot scatter plot and Bar plot with sem error bar
%
% function MyScatterBarPlot(data,group,groupColor)
%
%
% Inputs
% y - value
% x - group variable for y
%   (first column for different groups, two column for different strata)
%
%   Only compatible with <2014a version
%
% Author: Dohoung Kim
% Created: June 2015
% Updated: May 2016
group = unique(x(:, 1));
strata = unique(x(:, 2));

nGroup = length(group);
nStrata = length(strata);


[yMean, ySem] = deal(zeros(nGroup, nStrata));
for iGroup = 1:nGroup
    for iStrata = 1:nStrata
        yPoint = y(x(:, 1)==group(iGroup) & x(:, 2)==strata(iStrata) & ~isnan(y));
        nPoint = sum(~isnan(yPoint));
        
        yMean(iGroup, iStrata) = nansum(yPoint)/nPoint;
        ySem(iGroup, iStrata) = nanstd(yPoint)/sqrt(nPoint);
    end
end

hold on;
h.bar = bar(yMean, 'BarWidth', barWidth);

for iStrata = 1:nStrata
    set(h.bar(iStrata), 'FaceColor', xColor{iStrata}, 'LineStyle', 'none', 'ShowBaseLine', 'off');
    
    xpt = get(get(h.bar(iStrata), 'Children'), 'XData');
    xpt = mean(xpt([1 4], :), 1);

    h.errorbar(iStrata) = errorbar(xpt,yMean(:, iStrata) ,ySem(:, iStrata),'LineWidth',2, 'Color',xColor{iStrata});
    errorbarT(h.errorbar(iStrata), 0.1, 0.2);
end

set(gca,'Box','off','TickDir','out','FontSize',5,'LineWidth',0.2,...
    'XLim',[0.5 nGroup+0.5],'XTick',1:nGroup);
