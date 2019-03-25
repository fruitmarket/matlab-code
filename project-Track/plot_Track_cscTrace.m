function plot_Track_cscTrace

load('D:\Dropbox\SNL\P2_Track\myParameters.mat');
fontM = 7;
paperSize = {[0 0 21.0 29.7]; % A4_portrait
             [0 0 29.7 21.0]; % A4_landscape
             [0 0 15.7 21.0]; % A4_half landscape
             [0 0 21.6 27.9]}; % Letter

lineColor = {colorLightGray; colorGray; colorBlack};
dir = pwd;
load('csc.mat');

Fs = 2000; % frequency: 2kHz0
win1 = [-0.5, 2];
win2 = [-2, 0.5];
winCscOn = win1*Fs; % sec * Fs = samples
winCscOff = win2*Fs;
xptTime = winCscOn(1):winCscOn(2);
xptTime2 = winCscOff(1):winCscOff(2);
xptPeak = [1,2,3];
xLim = [-0.5 1.5]*Fs;
xLimOff = [-1.5 0.5]*Fs;
nCol = 4;
nRow = 10;

figSize = [0.05 0.1 0.85 0.85];
wideInterval = [0.07 0.13];
lineW = [0.7, 0.5];

fHandle = figure('PaperUnits','centimeters','paperPosition',paperSize{2});

hText = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1:4,1:2,figSize,midInterval),wideInterval));
    text(0,1, dir, 'FontSize', fontM, 'Interpreter', 'none', 'fontWeight', 'bold');
    set(hText,'visible','off')

for iT = 1:3
    hSensorRaw(iT) = axes('Position',axpt(4,3,1,iT,axpt(nCol,nRow,1:4,2:4,figSize,midInterval),wideInterval));
        for iLap = 30*(iT-1)+1:30*iT
            plot(xptTime,sTrace.raw{iLap},'lineStyle','-','color',colorBlack,'lineWidth',lineW(1));
            hold on;
        end
        plot(xptTime,meanCscS_raw(iT,:),'lineStyle','-','color',colorRed,'lineWidth',lineW(2));
        if iT == 1
            xlabel('Time (ms)','fontSize',fontM);
            ylabel('z-score LFP','fontSize',fontM);
        end

    hSensorTh(iT) = axes('Position',axpt(4,3,2,iT,axpt(nCol,nRow,1:4,2:4,figSize,midInterval),wideInterval));
        for iLap = 30*(iT-1)+1:30*iT
            plot(xptTime,sTrace.th{iLap},'lineStyle','-','color',colorBlack,'lineWidth',lineW(1));
            hold on;
        end
        plot(xptTime,meanCscS_th(iT,:),'lineStyle','-','color',colorRed,'lineWidth',lineW(2));
        
    hSensorSg(iT) = axes('Position',axpt(4,3,3,iT,axpt(nCol,nRow,1:4,2:4,figSize,midInterval),wideInterval));
        for iLap = 30*(iT-1)+1:30*iT
            plot(xptTime,sTrace.sg{iLap},'lineStyle','-','color',colorBlack,'lineWidth',lineW(1));
            hold on;
        end
        plot(xptTime,meanCscS_sg(iT,:),'lineStyle','-','color',colorRed,'lineWidth',lineW(2));
        
    hSensorFg(iT) = axes('Position',axpt(4,3,4,iT,axpt(nCol,nRow,1:4,2:4,figSize,midInterval),wideInterval));
        for iLap = 30*(iT-1)+1:30*iT
            plot(xptTime,sTrace.fg{iLap},'lineStyle','-','color',colorBlack,'lineWidth',lineW(1));
            hold on;
        end
        plot(xptTime,meanCscS_fg(iT,:),'lineStyle','-','color',colorRed,'lineWidth',lineW(2));
end
    set(hSensorRaw,'Box','off','TickDir','out','FontSize',fontM,'XLim',[xLim(1), xLim(2)],'XTick',[xLim(1):1000:xLim(end)],'XTickLabel',{'-0.5','0','0.5','1','1.5'});
    set(hSensorTh,'Box','off','TickDir','out','FontSize',fontM,'XLim',[xLim(1), xLim(2)],'XTick',[xLim(1):1000:xLim(end)],'XTickLabel',{'-0.5','0','0.5','1','1.5'});
    set(hSensorSg,'Box','off','TickDir','out','FontSize',fontM,'XLim',[xLim(1), xLim(2)],'XTick',[xLim(1):1000:xLim(end)],'XTickLabel',{'-0.5','0','0.5','1','1.5'});
    set(hSensorFg,'Box','off','TickDir','out','FontSize',fontM,'XLim',[xLim(1), xLim(2)],'XTick',[xLim(1):1000:xLim(end)],'XTickLabel',{'-0.5','0','0.5','1','1.5'});
%% laser on
for iT = 1:3
    hLOnRaw(iT) = axes('Position',axpt(4,3,1,iT,axpt(nCol,nRow,1:4,5:7,figSize,midInterval),wideInterval));
        for iLap = 30*(iT-1)+1:30*iT
            plot(xptTime,liTraceOn.raw{iLap},'lineStyle','-','color',colorBlack,'lineWidth',lineW(1));
            hold on;
        end
        plot(xptTime,meanCscOn_raw(iT,:),'lineStyle','-','color',colorBlue,'lineWidth',lineW(2));

    hLOnTh(iT) = axes('Position',axpt(4,3,2,iT,axpt(nCol,nRow,1:4,5:7,figSize,midInterval),wideInterval));
        for iLap = 30*(iT-1)+1:30*iT
            plot(xptTime,liTraceOn.th{iLap},'lineStyle','-','color',colorBlack,'lineWidth',lineW(1));
            hold on;
        end
        plot(xptTime,meanCscOn_th(iT,:),'lineStyle','-','color',colorBlue,'lineWidth',lineW(2));
        
    hLOnSg(iT) = axes('Position',axpt(4,3,3,iT,axpt(nCol,nRow,1:4,5:7,figSize,midInterval),wideInterval));
        for iLap = 30*(iT-1)+1:30*iT
            plot(xptTime,liTraceOn.sg{iLap},'lineStyle','-','color',colorBlack,'lineWidth',lineW(1));
            hold on;
        end
        plot(xptTime,meanCscOn_sg(iT,:),'lineStyle','-','color',colorBlue,'lineWidth',lineW(2));
        
    hLOnFg(iT) = axes('Position',axpt(4,3,4,iT,axpt(nCol,nRow,1:4,5:7,figSize,midInterval),wideInterval));
        for iLap = 30*(iT-1)+1:30*iT
            plot(xptTime,liTraceOn.fg{iLap},'lineStyle','-','color',colorBlack,'lineWidth',lineW(1));
            hold on;
        end
        plot(xptTime,meanCscOn_fg(iT,:),'lineStyle','-','color',colorBlue,'lineWidth',lineW(2));
end
    set(hLOnRaw,'Box','off','TickDir','out','FontSize',fontM,'XLim',[xLim(1), xLim(2)],'XTick',[xLim(1):1000:xLim(end)],'XTickLabel',{'-0.5','0','0.5','1','1.5'});
    set(hLOnTh,'Box','off','TickDir','out','FontSize',fontM,'XLim',[xLim(1), xLim(2)],'XTick',[xLim(1):1000:xLim(end)],'XTickLabel',{'-0.5','0','0.5','1','1.5'});
    set(hLOnSg,'Box','off','TickDir','out','FontSize',fontM,'XLim',[xLim(1), xLim(2)],'XTick',[xLim(1):1000:xLim(end)],'XTickLabel',{'-0.5','0','0.5','1','1.5'});
    set(hLOnFg,'Box','off','TickDir','out','FontSize',fontM,'XLim',[xLim(1), xLim(2)],'XTick',[xLim(1):1000:xLim(end)],'XTickLabel',{'-0.5','0','0.5','1','1.5'});
    
%% laser off
for iT = 1:3
    hLOffRaw(iT) = axes('Position',axpt(4,3,1,iT,axpt(nCol,nRow,1:4,8:10,figSize,midInterval),wideInterval));
        for iLap = 30*(iT-1)+1:30*iT
            plot(xptTime2,liTraceOff.raw{iLap},'lineStyle','-','color',colorBlack,'lineWidth',lineW(1));
            hold on;
        end
        plot(xptTime2,meanCscOff_raw(iT,:),'lineStyle','-','color',colorBlue,'lineWidth',lineW(2));

    hLOffTh(iT) = axes('Position',axpt(4,3,2,iT,axpt(nCol,nRow,1:4,8:10,figSize,midInterval),wideInterval));
        for iLap = 30*(iT-1)+1:30*iT
            plot(xptTime2,liTraceOff.th{iLap},'lineStyle','-','color',colorBlack,'lineWidth',lineW(1));
            hold on;
        end
        plot(xptTime2,meanCscOff_th(iT,:),'lineStyle','-','color',colorBlue,'lineWidth',lineW(2));
        
    hLOffSg(iT) = axes('Position',axpt(4,3,3,iT,axpt(nCol,nRow,1:4,8:10,figSize,midInterval),wideInterval));
        for iLap = 30*(iT-1)+1:30*iT
            plot(xptTime2,liTraceOff.sg{iLap},'lineStyle','-','color',colorBlack,'lineWidth',lineW(1));
            hold on;
        end
        plot(xptTime2,meanCscOff_sg(iT,:),'lineStyle','-','color',colorBlue,'lineWidth',lineW(2));

    hLOffFg(iT) = axes('Position',axpt(4,3,4,iT,axpt(nCol,nRow,1:4,8:10,figSize,midInterval),wideInterval));
        for iLap = 30*(iT-1)+1:30*iT
            plot(xptTime2,liTraceOff.fg{iLap},'lineStyle','-','color',colorBlack,'lineWidth',lineW(1));
            hold on;
        end
        plot(xptTime2,meanCscOff_fg(iT,:),'lineStyle','-','color',colorBlue,'lineWidth',lineW(2));
end
    set(hLOffRaw,'Box','off','TickDir','out','FontSize',fontM,'XLim',[xLimOff(1), xLimOff(2)],'XTick',[xLimOff(1):1000:xLimOff(end)],'XTickLabel',{'-1.5','-1','-0.5','0','0.5'});
    set(hLOffTh,'Box','off','TickDir','out','FontSize',fontM,'XLim',[xLimOff(1), xLimOff(2)],'XTick',[xLimOff(1):1000:xLimOff(end)],'XTickLabel',{'-1.5','-1','-0.5','0','0.5'});
    set(hLOffSg,'Box','off','TickDir','out','FontSize',fontM,'XLim',[xLimOff(1), xLimOff(2)],'XTick',[xLimOff(1):1000:xLimOff(end)],'XTickLabel',{'-1.5','-1','-0.5','0','0.5'});
    set(hLOffFg,'Box','off','TickDir','out','FontSize',fontM,'XLim',[xLimOff(1), xLimOff(2)],'XTick',[xLimOff(1):1000:xLimOff(end)],'XTickLabel',{'-1.5','-1','-0.5','0','0.5'});

%% peak comparison (sensor)
%     hSensorPeak(1) = axes('Position',axpt(1,3,1,1,axpt(nCol,nRow,5,2:4,figSize,midInterval),wideInterval));
%     for iT = 1:3
%         plot(xptPeak, meanPeakS_th(iT,:),'lineStyle','-','marker','o','color',lineColor{iT});
%         hold on;
%         errorbarJun(xptPeak,meanPeakS_th(iT,:),semPeakS_th(iT,:),0.3,1.0,colorBlack);
%         hold on;
%     end
%     xlabel('n-th Peak after sensor','fontSize',fontM);
%     ylabel('variance (ms^2)','fontSize',fontM);
%     
%     hSensorPeak(2) = axes('Position',axpt(1,3,1,2,axpt(nCol,nRow,5,2:4,figSize,midInterval),wideInterval));
%     for iT = 1:3
%         plot(xptPeak, meanPeakS_sg(iT,:),'lineStyle','-','marker','o','color',lineColor{iT});
%         hold on;
%         errorbarJun(xptPeak,meanPeakS_sg(iT,:),semPeakS_sg(iT,:),0.3,1.0,colorBlack);
%         hold on;
%     end
%     
%     hSensorPeak(3) = axes('Position',axpt(1,3,1,3,axpt(nCol,nRow,5,2:4,figSize,midInterval),wideInterval));
%     for iT = 1:3
%         plot(xptPeak, meanPeakS_fg(iT,:),'lineStyle','-','marker','o','color',lineColor{iT});
%         hold on;
%         errorbarJun(xptPeak,meanPeakS_fg(iT,:),semPeakS_fg(iT,:),0.3,1.0,colorBlack);
%         hold on;
%     end
%     set(hSensorPeak,'Box','off','TickDir','out','FontSize',fontM,'XLim',[0,4],'XTick',1:3,'XTickLabel',{'1st','2nd','3rd'});

%% peak comparison (light on)
%     hLOnPeak(1) = axes('Position',axpt(1,3,1,1,axpt(nCol,nRow,5,5:7,figSize,midInterval),wideInterval));
%     for iT = 1:3
%         plot(xptPeak, meanPeakOn_th(iT,:),'lineStyle','-','marker','o','color',lineColor{iT});
%         hold on;
%         errorbarJun(xptPeak,meanPeakOn_th(iT,:),semPeakOn_th(iT,:),0.3,1.0,colorBlack);
%         hold on;
%     end
%     xlabel('n-th Peak after sensor','fontSize',fontM);
%     ylabel('variance (ms^2)','fontSize',fontM);
%     
%     hLOnPeak(2) = axes('Position',axpt(1,3,1,2,axpt(nCol,nRow,5,5:7,figSize,midInterval),wideInterval));
%     for iT = 1:3
%         plot(xptPeak, meanPeakOn_sg(iT,:),'lineStyle','-','marker','o','color',lineColor{iT});
%         hold on;
%         errorbarJun(xptPeak,meanPeakOn_sg(iT,:),semPeakOn_sg(iT,:),0.3,1.0,colorBlack);
%         hold on;
%     end
%     
%     hLOnPeak(3) = axes('Position',axpt(1,3,1,3,axpt(nCol,nRow,5,5:7,figSize,midInterval),wideInterval));
%     for iT = 1:3
%         plot(xptPeak, meanPeakOn_fg(iT,:),'lineStyle','-','marker','o','color',lineColor{iT});
%         hold on;
%         errorbarJun(xptPeak,meanPeakOn_fg(iT,:),semPeakOn_fg(iT,:),0.3,1.0,colorBlack);
%         hold on;
%     end
%     set(hLOnPeak,'Box','off','TickDir','out','FontSize',fontM,'XLim',[0,4],'XTick',1:3,'XTickLabel',{'1st','2nd','3rd'});

%% peak comparison (light off)
%     hLOffPeak(1) = axes('Position',axpt(1,3,1,1,axpt(nCol,nRow,5,8:10,figSize,midInterval),wideInterval));
%     for iT = 1:3
%         plot(xptPeak, meanPeakOff_th(iT,:),'lineStyle','-','marker','o','color',lineColor{iT});
%         hold on;
%         errorbarJun(xptPeak,meanPeakOff_th(iT,:),semPeakOff_th(iT,:),0.3,1.0,colorBlack);
%         hold on;
%     end
%     xlabel('n-th Peak after sensor','fontSize',fontM);
%     ylabel('variance (ms^2)','fontSize',fontM);
%     
%     hLOffPeak(2) = axes('Position',axpt(1,3,1,2,axpt(nCol,nRow,5,8:10,figSize,midInterval),wideInterval));
%     for iT = 1:3
%         plot(xptPeak, meanPeakOff_sg(iT,:),'lineStyle','-','marker','o','color',lineColor{iT});
%         hold on;
%         errorbarJun(xptPeak,meanPeakOff_sg(iT,:),semPeakOff_sg(iT,:),0.3,1.0,colorBlack);
%         hold on;
%     end
%     
%     hLOffPeak(3) = axes('Position',axpt(1,3,1,3,axpt(nCol,nRow,5,8:10,figSize,midInterval),wideInterval));
%     for iT = 1:3
%         plot(xptPeak, meanPeakOff_fg(iT,:),'lineStyle','-','marker','o','color',lineColor{iT});
%         hold on;
%         errorbarJun(xptPeak,meanPeakOff_fg(iT,:),semPeakOff_fg(iT,:),0.3,1.0,colorBlack);
%         hold on;
%     end
%     set(hLOffPeak,'Box','off','TickDir','out','FontSize',fontM,'XLim',[0,4],'XTick',1:3,'XTickLabel',{'1st','2nd','3rd'});
    
print('-painters','-r300','-dtiff',['plot_csc','.tif']);
close;