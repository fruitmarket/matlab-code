% plot [spike number Vs. Stimulation frequency] for cellID 34 (TT5_2)
%
%
%
%
clearvars;

rtDir = 'D:\Dropbox\SNL\P2_Track';
cd(rtDir);

load('myParameters.mat');
% Txls = readtable('neuronList_freq_170602.xlsx');
% Txls.latencyIndex = categorical(Txls.latencyIndex);
% load('neuronList_freq_170602.mat');
% 
% folder = {'C:\Users\Jun\Desktop\platform_resp';
%           'C:\Users\Jun\Desktop\platform_noresp'};
% 
% alpha = 0.01;
% alpha2 = alpha/5;
% c_latency = 10;
% cMeanFR = 9;
% 
% lightResp = T.pLR_Plfm1hz < alpha | T.pLR_Plfm2hz < alpha | T.pLR_Plfm8hz < alpha | T.pLR_Plfm20hz < alpha | T.pLR_Plfm50hz < alpha;
% lightResp = ~lightResp; % this is for no light responsive population
% 
% nLightResp = sum(double(lightResp));
% nLightNoResp = sum(double(lightResp));
% 
% detoSpike1hz = T.detoSpk1hz(lightResp,:);
% detoSpike2hz = T.detoSpk2hz(lightResp,:);
% detoSpike8hz = T.detoSpk8hz(lightResp,:);
% detoSpike20hz = T.detoSpk20hz(lightResp,:);
% detoSpike50hz = T.detoSpk50hz(lightResp,:);
% 
% total_mFR = T.total_mFR(lightResp);
% spkwth = T.spkwth(lightResp);
% hfvwth = T.hfvwth(lightResp);
% spkpvr = T.spkpvr(lightResp);
% spkwv = T.spkwv(lightResp,:);
% latencyIndex = str2mat(Txls.latencyIndex(lightResp));
% cellID = Txls.cellID(lightResp);
examFolder = 'D:\Projects\Track_160824-5_Rbp60freq\170202_DV2.55_1hz2hz8hz20hz50hz_T5';
cd(examFolder);

matFile = mLoad;
nFile = length(matFile);
%%
nameSplit = regexp(matFile,'\','split');

nCol = 5;
nRow = 1;

xLim = [0 16];
yLim = [-5 90];

xpt = 1:15;

for iFile = 1:nFile

    load(matFile{iFile});
    
    hHandle = figure('PaperUnits','centimeters','PaperPosition',[0 0 25 15]);

    hPlot = axes('Position',axpt(nCol,nRow,1:4,1,[0.1 0.1 0.80 0.85],midInterval));
    plot(xpt,detoSpk1hz,'-o','color',colorBlack,'markerSize',markerM,'MarkerFaceColor',colorBlack);
    hold on;
    plot(xpt,detoSpk2hz,'-o','color',colorRed,'markerSize',markerM,'MarkerFaceColor',colorRed);
    hold on;
    plot(xpt,detoSpk8hz,'-o','color',colorYellow,'markerSize',markerM,'MarkerFaceColor',colorYellow);
    hold on;
    plot(xpt,detoSpk20hz,'-o','color',colorGreen,'markerSize',markerM,'MarkerFaceColor',colorGreen);
    hold on;
    plot(xpt,detoSpk50hz,'-o','color',colorBlue,'markerSize',markerM,'MarkerFaceColor',colorBlue);
    hold on;
    text(1,80,'1 Hz','fontSize',fontL,'color',colorBlack);
    text(1,77,'2 Hz','fontSize',fontL,'color',colorRed);
    text(1,74,'8 Hz','fontSize',fontL,'color',colorYellow);
    text(1,71,'20 Hz','fontSize',fontL,'color',colorGreen);
    text(1,68,'50 Hz','fontSize',fontL,'color',colorBlue);
    xlabel('n-th light pulse','fontSize',fontL);
    ylabel('Spike fidelity (%)','fontSize',fontL);
    set(hPlot,'Box','off','TickDir','out','XLim',xLim,'XTick',1:15,'YLim',yLim,'YTick',[5,10:10:90]);
    
    hText = axes('Position',axpt(4,4,1:4,1:2,axpt(nCol,nRow,5,1,[0.1 0.1 0.80 0.85],tightInterval),tightInterval));
    text(0,0.9,strcat(nameSplit{iFile}(3),'_',nameSplit{iFile}(5)), 'FontSize',fontM, 'Interpreter','none','FontWeight','bold');
    text(0,0.8,['Mean firing rate: ',num2str(total_mFR,3), ' Hz'], 'FontSize',fontL);
    text(0,0.7,['Spike width: ',num2str(spkwth,3),' us'], 'FontSize',fontL);
    text(0,0.6,['Half-valley width: ',num2str(hfvwth,3),' us'], 'FontSize',fontL);
    text(0,0.5,['Peak valley ratio: ',num2str(spkpvr,3)], 'FontSize',fontL);
%     text(0,0.4,['Light response: ',latencyIndex(iFile,:)],'fontSize',fontL,'fontWeight','bold','color',colorRed);
    set(hText,'Visible','off');

    yLimWaveform = [min(spkwv(:)), max(spkwv(:))];
    for iCh = 1:4
        hWaveform(iCh) = axes('Position',axpt(4,4,iCh,3,axpt(nCol,nRow,5,1,[0.03 0.2 0.90 0.50],tightInterval),midInterval));
        plot(spkwv(iCh,:), 'LineWidth', lineL, 'Color','k');
        if iCh == 4
            line([24 32], [yLimWaveform(2)-50 yLimWaveform(2)-50], 'Color','k', 'LineWidth', lineM);
            line([24 24],[yLimWaveform(2)-50 yLimWaveform(2)], 'Color','k', 'LineWidth',lineM);
        end
    end
    set(hWaveform, 'Visible', 'off','XLim',[1 32], 'YLim',yLimWaveform*1.05);
    
    formatOut = 'yymmdd';
    print('-painters','-r300','-dtiff',['cellID_',num2str(iFile),'.tif']);
%     close;
end
% cd(rtDir);