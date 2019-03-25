function plot_Track_cscTrace_v2

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
winCscOn = win1*Fs; % sec * Fs = samples
xptTimeOn = winCscOn(1):winCscOn(2);

win2 = [-2, 0.5];
winCscOff = win2*Fs;
xptTimeOff = winCscOff(1):winCscOff(2);

xptPeak = [1,2,3];
xLimOn = [-0.5 1.5]*Fs;
xLimOff = [-1.5 0.5]*Fs;
nCol = 2;
nRow = 5;

figSize = [0.07 0.05 0.85 0.90];
wideInterval = [0.07 0.13];
tightInterval = [0.05 0.05];
lineW = [0.7, 0.5];
colorBlueGrad = {[13,71,126]/255;
                 [21,101,192]/255;
                 [25,118,210]/255;
                 [30,136,229]/255;
                 [33,150,243]/255;
                 [66,165,245]/255;
                 [100,181,246]/255;
                 [144,202,249]/255;
                 [187,222,251]/255;
                 [227,242,253]/255};

fHandle = figure('PaperUnits','centimeters','paperPosition',paperSize{1});

hText = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1,1:2,figSize,midInterval),wideInterval));
    text(-0.1,1.1, dir, 'FontSize', fontM, 'Interpreter', 'none', 'fontWeight', 'bold');
    set(hText,'visible','off')

%% On
for iT = 1:3
    hSensorOn_Raw(iT) = axes('Position',axpt(1,3,1,iT,axpt(nCol,nRow,1,1,figSize,tightInterval),wideInterval));
        for iLap = 30*(iT-1)+1:30*iT
            plot(xptTimeOn,rCscSOn_raw{iLap},'lineStyle','-','color',colorBlack,'lineWidth',lineW(1));
            hold on;
        end
        plot(xptTimeOn,meanCscSOn_raw{iT,:},'lineStyle','-','color',colorRed,'lineWidth',lineW(2));
        if iT == 1
            for iCycle = 1:10
                hold on;
                if regexp(pwd,'Run')
                    pw(iCycle) = patch([200*iCycle-200, 200*iCycle,200*iCycle,200*iCycle-200],[10 10 15 15],colorBlueGrad{iCycle},'lineStyle','none');
                else
                    pw(iCycle) = patch([500*iCycle-500, 500*iCycle,500*iCycle,500*iCycle-500],[10 10 15 15],colorBlueGrad{iCycle},'lineStyle','none');
                end
            end
            text(-900,12,'Raw trace','fontSize',fontM);
            title('Aligned on laser onset sensor','fontSize',fontM);
        elseif iT == 2
            ylabel('z-score LFP','fontSize',fontM);
        elseif iT == 3
            xlabel('Time (sec)','fontSize',fontM);
        end        

    hSensorOn_Th(iT) = axes('Position',axpt(1,3,1,iT,axpt(nCol,nRow,1,2,figSize,tightInterval),wideInterval));
        for iLap = 30*(iT-1)+1:30*iT
            plot(xptTimeOn,rCscSOn_th{iLap},'lineStyle','-','color',colorBlack,'lineWidth',lineW(1));
            hold on;
        end
        plot(xptTimeOn,meanCscSOn_th{iT,:},'lineStyle','-','color',colorRed,'lineWidth',lineW(2));
        if iT == 1
            text(-900,12,'Theta (4-12 Hz)','fontSize',fontM);
        end
        
    hSensorOn_Sg(iT) = axes('Position',axpt(1,3,1,iT,axpt(nCol,nRow,1,3,figSize,tightInterval),wideInterval));
        for iLap = 30*(iT-1)+1:30*iT
            plot(xptTimeOn,rCscSOn_sg{iLap},'lineStyle','-','color',colorBlack,'lineWidth',lineW(1));
            hold on;
        end
        plot(xptTimeOn,meanCscSOn_sg{iT,:},'lineStyle','-','color',colorRed,'lineWidth',lineW(2));
        if iT == 1
            text(-900,12,'Slow gamma (20-50 Hz)','fontSize',fontM);
        end
        
    hSensorOn_Fg(iT) = axes('Position',axpt(1,3,1,iT,axpt(nCol,nRow,1,4,figSize,tightInterval),wideInterval));
        for iLap = 30*(iT-1)+1:30*iT
            plot(xptTimeOn,rCscSOn_fg{iLap},'lineStyle','-','color',colorBlack,'lineWidth',lineW(1));
            hold on;
        end
        plot(xptTimeOn,meanCscSOn_fg{iT,:},'lineStyle','-','color',colorRed,'lineWidth',lineW(2));
        if iT == 1
            text(-900,12,'Fast gamma (65-140 Hz)','fontSize',fontM);
        end
        
    hSensorOn_Ri(iT) = axes('Position',axpt(1,3,1,iT,axpt(nCol,nRow,1,5,figSize,tightInterval),wideInterval));
        for iLap = 30*(iT-1)+1:30*iT
            plot(xptTimeOn,rCscSOn_ri{iLap},'lineStyle','-','color',colorBlack,'lineWidth',lineW(1));
            hold on;
        end
        plot(xptTimeOn,meanCscSOn_ri{iT,:},'lineStyle','-','color',colorRed,'lineWidth',lineW(2));
        if iT == 1
            text(-900,12,'Ripple (150-250 Hz)','fontSize',fontM);
        end
end
    set(hSensorOn_Raw,'Box','off','TickDir','out','FontSize',fontM,'XLim',[xLimOn(1), xLimOn(2)],'XTick',[xLimOn(1):1000:xLimOn(end)],'XTickLabel',{'-0.5','0','0.5','1','1.5'},'YLim',[-15,15]);
    set(hSensorOn_Th,'Box','off','TickDir','out','FontSize',fontM,'XLim',[xLimOn(1), xLimOn(2)],'XTick',[xLimOn(1):1000:xLimOn(end)],'XTickLabel',{'-0.5','0','0.5','1','1.5'},'YLim',[-15,15]);
    set(hSensorOn_Sg,'Box','off','TickDir','out','FontSize',fontM,'XLim',[xLimOn(1), xLimOn(2)],'XTick',[xLimOn(1):1000:xLimOn(end)],'XTickLabel',{'-0.5','0','0.5','1','1.5'},'YLim',[-15,15]);
    set(hSensorOn_Fg,'Box','off','TickDir','out','FontSize',fontM,'XLim',[xLimOn(1), xLimOn(2)],'XTick',[xLimOn(1):1000:xLimOn(end)],'XTickLabel',{'-0.5','0','0.5','1','1.5'},'YLim',[-15,15]);
    set(hSensorOn_Ri,'Box','off','TickDir','out','FontSize',fontM,'XLim',[xLimOn(1), xLimOn(2)],'XTick',[xLimOn(1):1000:xLimOn(end)],'XTickLabel',{'-0.5','0','0.5','1','1.5'},'YLim',[-15,15]);

%% Off
for iT = 1:3
    hSensorOff_Raw(iT) = axes('Position',axpt(1,3,1,iT,axpt(nCol,nRow,2,1,figSize,tightInterval),wideInterval));
        for iLap = 30*(iT-1)+1:30*iT
            plot(xptTimeOff,rCscSOff_raw{iLap},'lineStyle','-','color',colorBlack,'lineWidth',lineW(1));
            hold on;
        end
        plot(xptTimeOff,meanCscSOff_raw{iT,:},'lineStyle','-','color',colorRed,'lineWidth',lineW(2));
        if iT == 1
            for iCycle = 1:10
                hold on;
                if regexp(pwd,'Run')
                    pw(iCycle) = patch([200*iCycle-2200, 200*iCycle-2000,200*iCycle-2000,200*iCycle-2200],[10 10 15 15],colorBlueGrad{11-iCycle},'lineStyle','none');
                else
                    pw(iCycle) = patch([500*iCycle-1500, 500*iCycle,500*iCycle,500*iCycle-1500],[10 10 15 15],colorBlueGrad{11-iCycle},'lineStyle','none');
                end
            end
            title('Aligned on laser offset sensor','fontSize',fontM);
        elseif iT == 2
%             ylabel('z-score LFP','fontSize',fontM);
        elseif iT == 3
            xlabel('Time (sec)','fontSize',fontM);
        end        

    hSensorOff_Th(iT) = axes('Position',axpt(1,3,1,iT,axpt(nCol,nRow,2,2,figSize,tightInterval),wideInterval));
        for iLap = 30*(iT-1)+1:30*iT
            plot(xptTimeOff,rCscSOff_th{iLap},'lineStyle','-','color',colorBlack,'lineWidth',lineW(1));
            hold on;
        end
        plot(xptTimeOff,meanCscSOff_th{iT,:},'lineStyle','-','color',colorRed,'lineWidth',lineW(2));
        
    hSensorOff_Sg(iT) = axes('Position',axpt(1,3,1,iT,axpt(nCol,nRow,2,3,figSize,tightInterval),wideInterval));
        for iLap = 30*(iT-1)+1:30*iT
            plot(xptTimeOff,rCscSOff_sg{iLap},'lineStyle','-','color',colorBlack,'lineWidth',lineW(1));
            hold on;
        end
        plot(xptTimeOff,meanCscSOff_sg{iT,:},'lineStyle','-','color',colorRed,'lineWidth',lineW(2));
        
    hSensorOff_Fg(iT) = axes('Position',axpt(1,3,1,iT,axpt(nCol,nRow,2,4,figSize,tightInterval),wideInterval));
        for iLap = 30*(iT-1)+1:30*iT
            plot(xptTimeOff,rCscSOff_fg{iLap},'lineStyle','-','color',colorBlack,'lineWidth',lineW(1));
            hold on;
        end
        plot(xptTimeOff,meanCscSOff_fg{iT,:},'lineStyle','-','color',colorRed,'lineWidth',lineW(2));
        
    hSensorOff_Ri(iT) = axes('Position',axpt(1,3,1,iT,axpt(nCol,nRow,2,5,figSize,tightInterval),wideInterval));
        for iLap = 30*(iT-1)+1:30*iT
            plot(xptTimeOff,rCscSOff_ri{iLap},'lineStyle','-','color',colorBlack,'lineWidth',lineW(1));
            hold on;
        end
        plot(xptTimeOff,meanCscSOff_ri{iT,:},'lineStyle','-','color',colorRed,'lineWidth',lineW(2));
end
    set(hSensorOff_Raw,'Box','off','TickDir','out','FontSize',fontM,'XLim',[xLimOff(1), xLimOff(2)],'XTick',[xLimOff(1):1000:xLimOff(end)],'XTickLabel',{'-1.5','-1','-0.5','0','0.5'},'YLim',[-15,15]);
    set(hSensorOff_Th,'Box','off','TickDir','out','FontSize',fontM,'XLim',[xLimOff(1), xLimOff(2)],'XTick',[xLimOff(1):1000:xLimOff(end)],'XTickLabel',{'-1.5','-1','-0.5','0','0.5'},'YLim',[-15,15]);
    set(hSensorOff_Sg,'Box','off','TickDir','out','FontSize',fontM,'XLim',[xLimOff(1), xLimOff(2)],'XTick',[xLimOff(1):1000:xLimOff(end)],'XTickLabel',{'-1.5','-1','-0.5','0','0.5'},'YLim',[-15,15]);
    set(hSensorOff_Fg,'Box','off','TickDir','out','FontSize',fontM,'XLim',[xLimOff(1), xLimOff(2)],'XTick',[xLimOff(1):1000:xLimOff(end)],'XTickLabel',{'-1.5','-1','-0.5','0','0.5'},'YLim',[-15,15]);
    set(hSensorOff_Ri,'Box','off','TickDir','out','FontSize',fontM,'XLim',[xLimOff(1), xLimOff(2)],'XTick',[xLimOff(1):1000:xLimOff(end)],'XTickLabel',{'-1.5','-1','-0.5','0','0.5'},'YLim',[-15,15]);

if regexp(pwd,'Run')
    print('-painters','-r300','-dtiff',['plot_csc_Run','.tif']);
    print('-painters','-r300','-depsc',['plot_csc_Run','.ai']);
else
    print('-painters','-r300','-dtiff',['plot_csc_Rw','.tif']);
    print('-painters','-r300','-depsc',['plot_csc_Run','.ai']);
end
close;