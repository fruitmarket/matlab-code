function plot_2hz8hz

lineColor = {[144, 164, 174]./255,... % Before stimulation
    [33 150 243]./ 255,... % During stimulation
    [38, 50, 56]./255}; % After stimulation

lineWth = [1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75];
fontS = 4; fontM = 5; fontL = 7; fontXL = 9; % font size large
lineS = 0.2; lineM = 0.5; lineL = 1; % line width large

colorBlue = [33 150 243] ./ 255;
colorLightBlue = [100 181 246] ./ 255;
colorLLightBlue = [187, 222, 251]./255;
colorRed = [237 50 52] ./ 255;
colorLightRed = [242 138 130] ./ 255;
colorGray = [189 189 189] ./ 255;
colorLightGray = [238, 238, 238] ./255;
colorDarkGray = [117, 117, 117] ./255;
colorYellow = [255 243 3] ./ 255;
colorLightYellow = [255 249 196] ./ 255;
colorBlack = [0, 0, 0];

markerS = 2.2; markerM = 4.4; markerL = 6.6; markerXL = 8.8;
tightInterval = [0.02 0.02]; wideInterval = [0.07 0.07];
width = 0.7;

paperSizeX = [18.3, 8.00];
figSize = [0.15 0.1 0.85 0.80];

winCri2hz = [0, 8000];
winCri8hz = [0, 2500];
winCri20hz = [0 1000];
winCri50hz = [0 1000];
winCri_ori = [-10, 100];
winCri_ori2 = [-10, 30];
winCri_ori3 = [-5, 15];

win2hz = [-500, 7500];
win8hz = [-250, 2000];
win20hz = [-100 1000];
win50hz = [-100 1000];

binSize = 2;
resolution = 10;

[tData, tList] = tLoad;
nCell = length(tList);

nTrial = 20;
nTrial_ori = 300;

for iCell = 1:nCell
    disp(['### Analyzing ',tList{iCell},'...']);
    [cellPath, cellName, ~] = fileparts(tList{iCell});
    cd(cellPath);
    
    load Events.mat
    
    switch nSession
        case 2
            nRow = 6;
            nCol = 5;
            
            % Original PETH
            spkTime2hz_ori = spikeWin(tData{iCell},light2hz,winCri_ori);
            [xpt2hz_ori, ypt2hz_ori, pethtime2hz_ori, peth2hz_ori, peth2hzConv_ori, peth2hzConvZ_ori] = rasterPETH(spkTime2hz_ori,true(size(light2hz)),winCri_ori,binSize,resolution,1);

            spkTime8hz_ori = spikeWin(tData{iCell},light8hz,winCri_ori);
            [xpt8hz_ori, ypt8hz_ori, pethtime8hz_ori, peth8hz_ori, peth8hzConv_ori, peth8hzConvZ_ori] = rasterPETH(spkTime8hz_ori,true(size(light8hz)),winCri_ori,binSize,resolution,1);

        % Spikes are aligned on each light 
            spkTime2hz = spikeWin(tData{iCell},light2hz(1:15:end),winCri2hz);
            [xpt2hz, ypt2hz, pethtime2hz, peth2hz, peth2hzConv, peth2hzConvZ] = rasterPETH(spkTime2hz,true(size(spkTime2hz)),win2hz,binSize,resolution,1);

            spkTime8hz = spikeWin(tData{iCell},light8hz(1:15:end),winCri8hz);
            [xpt8hz, ypt8hz, pethtime8hz, peth8hz, peth8hzConv, peth8hzConvZ] = rasterPETH(spkTime8hz,true(size(spkTime8hz)),win8hz,binSize,resolution,1);

        %% Original 2Hz
            fHandle = figure('PaperUnits','centimeters','PaperPosition',[0 0 10.5 15]); % A4: 210 x 297 mm

            hLight2hzOri(1) = axes('Position',axpt(nCol,nRow,1,2,[0.1 0.1 0.85 0.85],wideInterval));
            hLBar(1) = rectangle('Position',[0,0,10,nTrial_ori],'LineStyle','none','FaceColor',colorLLightBlue);
            hold on;
            hLBar(2) = rectangle('Position',[0,270,10,nTrial_ori/10],'LineStyle','none','FaceColor',colorBlue);
            hold on;
            plot(xpt2hz_ori{1},ypt2hz_ori{1},'LineStyle','none','Marker','.','MarkerSize',markerL,'Color','k');
            ylabel('Trials','FontSize',fontL);

            hLight2hzOri(2) = axes('Position',axpt(nCol,nRow,1,3,[0.1 0.1 0.85 0.85],wideInterval));
            yLim2hzOri = ceil(max(peth2hzConv_ori*1.1)+0.001);
            plot(pethtime2hz_ori,peth2hzConv_ori,'LineStyle','-','LineWidth',lineM,'Color',colorBlack);

            xlabel('Time (ms)','FontSize',fontL);
            ylabel('Rate (Hz)', 'FontSize', fontL);
            align_ylabel(hLight2hzOri,1);

            set(hLight2hzOri(1),'XLim',winCri_ori,'XTick',[],'YLim',[0, nTrial_ori],'YTick',[0, nTrial_ori],'YTickLabel',{0, nTrial_ori});
            set(hLight2hzOri(2), 'XLim', winCri_ori, 'XTick', [0,30,winCri_ori(2)],'YLim', [0 yLim2hzOri], 'YTick', [0 yLim2hzOri], 'YTickLabel', {[], yLim2hzOri});
            set(hLight2hzOri,'Box','off','TickDir','out','fontSize',fontL);

        %% Original 8Hz
            hLight8hzOri(1) = axes('Position',axpt(nCol,nRow,1,5,[0.1 0.1 0.85 0.85],wideInterval));
            hLBar(1) = rectangle('Position',[0,0,10,nTrial_ori],'LineStyle','none','FaceColor',colorLLightBlue);
            hold on;
            hLBar(2) = rectangle('Position',[0,270,10,nTrial_ori/10],'LineStyle','none','FaceColor',colorBlue);
            hold on;
            plot(xpt8hz_ori{1},ypt8hz_ori{1},'LineStyle','none','Marker','.','MarkerSize',markerL,'Color','k');
            ylabel('Trials','FontSize',fontL);

            hLight8hzOri(2) = axes('Position',axpt(nCol,nRow,1,6,[0.1 0.1 0.85 0.85],wideInterval));
            yLim8hzOri = ceil(max(peth8hzConv_ori*1.1)+0.001);
            plot(pethtime8hz_ori,peth8hzConv_ori,'LineStyle','-','LineWidth',lineM,'Color',colorBlack);

            xlabel('Time (ms)','FontSize',fontL);
            ylabel('Rate (Hz)','FontSize',fontL);
            align_ylabel(hLight8hzOri,1);

            set(hLight8hzOri(1),'XLim',winCri_ori,'XTick',[],'YLim',[0, nTrial_ori],'YTick',[0, nTrial_ori],'YTickLabel',{0, nTrial_ori});
            set(hLight8hzOri(2), 'XLim', winCri_ori, 'XTick', [0,30,winCri_ori(2)],'YLim', [0 yLim8hzOri], 'YTick', [0 yLim8hzOri], 'YTickLabel', {[], yLim8hzOri});
            set(hLight8hzOri,'Box','off','TickDir','out','fontSize',fontL);

        %% Each light (2hz)
            hFreq2hz(1) = axes('Position',axpt(nCol,nRow,1:5,1,[0.1 0.1 0.85 0.85],wideInterval));
            text(0,0.2,'2hz Stimulation','fontSize',fontXL,'fontWeight','bold');

            hFreq2hz(2) = axes('Position',axpt(nCol,nRow,2:5,2,[0.1 0.1 0.85 0.85],wideInterval));
            for iLight = 1:15
                hLBar(1) = rectangle('Position',[500*iLight-500, 0, 10, nTrial_ori],'LineStyle','none','FaceColor',colorLLightBlue);
                hold on;
                hLBar(2) = rectangle('Position',[500*iLight-500, 18, 10, nTrial_ori/10],'LineStyle','none','FaceColor',colorBlue);
                hold on;
            end
            plot(xpt2hz{1},ypt2hz{1},'LineStyle','none','Marker','.','MarkerSize',markerL,'Color','k');

            hFreq2hz(3) = axes('Position',axpt(nCol,nRow,2:5,3,[0.1 0.1 0.85 0.85],wideInterval));
            yLim2hz = ceil(max(peth2hzConv)*1.1+0.001);
            plot(pethtime2hz, peth2hzConv,'LineStyle','-','LineWidth',lineM,'Color',colorBlack);
            xlabel('Time (ms)','FontSize',fontL);

            set(hFreq2hz(1),'visible','off');
            set(hFreq2hz(2),'XLim',win2hz,'XTick',[],'YLim',[0, nTrial],'YTick',[0, nTrial],'YTickLabel',{0, nTrial});
            set(hFreq2hz(3), 'XLim', win2hz, 'XTick', [0:1000:win2hz(2)],'YLim', [0 yLim2hz], 'YTick', [0 yLim2hz], 'YTickLabel', {[], yLim2hz});
            set(hFreq2hz,'Box','off','TickDir','out','fontSize',fontL);

        %% Each light (8Hz)
            hFreq8hz(1) = axes('Position',axpt(nCol,nRow,1:5,4,[0.1 0.1 0.85 0.85],wideInterval));
            text(0,0.2,'8hz Stimulation','fontSize',fontXL,'fontWeight','bold');

            hFreq8hz(2) = axes('Position',axpt(nCol,nRow,2:5,5,[0.1 0.1 0.85 0.85],wideInterval));
            for iLight = 1:15
                hold on;
                hLBar(1) = rectangle('Position',[125*iLight-125, 0, 10, 20],'LineStyle','none','FaceColor',colorLLightBlue);
                hold on;
                hLBar(2) = rectangle('Position',[125*iLight-125, 18, 10, 2],'LineStyle','none','FaceColor',colorBlue);
            end
            plot(xpt8hz{1},ypt8hz{1},'LineStyle','none','Marker','.','MarkerSize',markerL,'Color','k');

            hFreq8hz(3) = axes('Position',axpt(nCol,nRow,2:5,6,[0.1 0.1 0.85 0.85],wideInterval));
            yLim8hz = ceil(max(peth8hzConv)*1.1+0.001);
            plot(pethtime8hz,peth8hzConv,'LineStyle','-','LineWidth',lineM,'Color',colorBlack);
            xlabel('Time (ms)','FontSize',fontL);

            set(hFreq8hz(1),'visible','off');
            set(hFreq8hz(2),'XLim',win8hz,'XTick',[],'YLim',[0, nTrial],'YTick',[0, nTrial],'YTickLabel',{0, nTrial});
            set(hFreq8hz(3), 'XLim', win8hz, 'XTick', [0:500:win8hz(2)],'YLim',[0, yLim8hz],'YTick',[0 yLim8hz],'YTickLabel',{[], yLim8hz});
            set(hFreq8hz,'Box','off','TickDir','out','fontSize',fontL);

            print('-painters',[cellName,'.tiff'],'-r300','-dtiff');
            close;

            fclose('all');
        case 4
            % Original PETH
            
            nRow = 12;
            nCol = 6;
            
            spkTime2hz_ori = spikeWin(tData{iCell},light2hz,winCri_ori);
            [xpt2hz_ori, ypt2hz_ori, pethtime2hz_ori, peth2hz_ori, peth2hzConv_ori, peth2hzConvZ_ori] = rasterPETH(spkTime2hz_ori,true(size(light2hz)),winCri_ori,binSize,resolution,1);

            spkTime8hz_ori = spikeWin(tData{iCell},light8hz,winCri_ori);
            [xpt8hz_ori, ypt8hz_ori, pethtime8hz_ori, peth8hz_ori, peth8hzConv_ori, peth8hzConvZ_ori] = rasterPETH(spkTime8hz_ori,true(size(light8hz)),winCri_ori,binSize,resolution,1);
            
            spkTime20hz_ori = spikeWin(tData{iCell},light20hz,winCri_ori);
            [xpt20hz_ori, ypt20hz_ori, pethtime20hz_ori, peth20hz_ori, peth20hzConv_ori, peth20hzConvZ_ori] = rasterPETH(spkTime20hz_ori,true(size(light20hz)),winCri_ori2,binSize,resolution,1);
            
            spkTime50hz_ori = spikeWin(tData{iCell},light50hz,winCri_ori);
            [xpt50hz_ori, ypt50hz_ori, pethtime50hz_ori, peth50hz_ori, peth50hzConv_ori, peth50hzConvZ_ori] = rasterPETH(spkTime50hz_ori,true(size(light50hz)),winCri_ori3,binSize,resolution,1);

        % Spikes are aligned on each light 
            spkTime2hz = spikeWin(tData{iCell},light2hz(1:15:end),winCri2hz);
            [xpt2hz, ypt2hz, pethtime2hz, peth2hz, peth2hzConv, peth2hzConvZ] = rasterPETH(spkTime2hz,true(size(spkTime2hz)),win2hz,binSize,resolution,1);

            spkTime8hz = spikeWin(tData{iCell},light8hz(1:15:end),winCri8hz);
            [xpt8hz, ypt8hz, pethtime8hz, peth8hz, peth8hzConv, peth8hzConvZ] = rasterPETH(spkTime8hz,true(size(spkTime8hz)),win8hz,binSize,resolution,1);

            spkTime20hz = spikeWin(tData{iCell},light20hz(1:15:end),winCri20hz);
            [xpt20hz, ypt20hz, pethtime20hz, peth20hz, peth20hzConv, peth20hzConvZ] = rasterPETH(spkTime20hz,true(size(spkTime20hz)),win20hz,binSize,resolution,1);
            
            spkTime50hz = spikeWin(tData{iCell},light50hz(1:15:end),winCri50hz);
            [xpt50hz, ypt50hz, pethtime50hz, peth50hz, peth50hzConv, peth50hzConvZ] = rasterPETH(spkTime50hz,true(size(spkTime50hz)),win50hz,binSize,resolution,1);
            
        %% Original 2Hz
            fHandle = figure('PaperUnits','centimeters','PaperPosition',[0 0 10.5 15]); % A4: 210 x 297 mm

            hLight2hzOri(1) = axes('Position',axpt(nCol,nRow,1,2,figSize,tightInterval));
            hLBar(1) = rectangle('Position',[0,0,10,nTrial_ori],'LineStyle','none','FaceColor',colorLLightBlue);
            hold on;
            hLBar(2) = rectangle('Position',[0,270,10,nTrial_ori/10],'LineStyle','none','FaceColor',colorBlue);
            hold on;
            plot(xpt2hz_ori{1},ypt2hz_ori{1},'LineStyle','none','Marker','.','MarkerSize',markerL,'Color','k');
            ylabel('Trials','FontSize',fontL);

            hLight2hzOri(2) = axes('Position',axpt(nCol,nRow,1,3,figSize,tightInterval));
            yLim2hzOri = ceil(max(peth2hzConv_ori*1.1)+0.001);
            plot(pethtime2hz_ori,peth2hzConv_ori,'LineStyle','-','LineWidth',lineM,'Color',colorBlack);

            xlabel('Time (ms)','FontSize',fontL);
            ylabel('Rate (Hz)', 'FontSize', fontL);
            align_ylabel(hLight2hzOri,1);

            set(hLight2hzOri(1),'XLim',winCri_ori,'XTick',[],'YLim',[0, nTrial_ori],'YTick',[0, nTrial_ori],'YTickLabel',{0, nTrial_ori});
            set(hLight2hzOri(2), 'XLim', winCri_ori, 'XTick', [0,30,winCri_ori(2)],'YLim', [0 yLim2hzOri], 'YTick', [0 yLim2hzOri], 'YTickLabel', {[], yLim2hzOri});
            set(hLight2hzOri,'Box','off','TickDir','out','fontSize',fontL);

        %% Original 8Hz
            hLight8hzOri(1) = axes('Position',axpt(nCol,nRow,1,5,figSize,tightInterval));
            hLBar(1) = rectangle('Position',[0,0,10,nTrial_ori],'LineStyle','none','FaceColor',colorLLightBlue);
            hold on;
            hLBar(2) = rectangle('Position',[0,270,10,nTrial_ori/10],'LineStyle','none','FaceColor',colorBlue);
            hold on;
            plot(xpt8hz_ori{1},ypt8hz_ori{1},'LineStyle','none','Marker','.','MarkerSize',markerL,'Color','k');
            ylabel('Trials','FontSize',fontL);

            hLight8hzOri(2) = axes('Position',axpt(nCol,nRow,1,6,figSize,tightInterval));
            yLim8hzOri = ceil(max(peth8hzConv_ori*1.1)+0.001);
            plot(pethtime8hz_ori,peth8hzConv_ori,'LineStyle','-','LineWidth',lineM,'Color',colorBlack);

            xlabel('Time (ms)','FontSize',fontL);
            ylabel('Rate (Hz)','FontSize',fontL);
            align_ylabel(hLight8hzOri,1);

            set(hLight8hzOri(1),'XLim',winCri_ori,'XTick',[],'YLim',[0, nTrial_ori],'YTick',[0, nTrial_ori],'YTickLabel',{0, nTrial_ori});
            set(hLight8hzOri(2), 'XLim', winCri_ori, 'XTick', [0,30,winCri_ori(2)],'YLim', [0 yLim8hzOri], 'YTick', [0 yLim8hzOri], 'YTickLabel', {[], yLim8hzOri});
            set(hLight8hzOri,'Box','off','TickDir','out','fontSize',fontL);

        %% Original 20Hz
            hLight20hzOri(1) = axes('Position',axpt(nCol,nRow,1,8,figSize,tightInterval));
            hLBar(1) = rectangle('Position',[0,0,10,nTrial_ori],'LineStyle','none','FaceColor',colorLLightBlue);
            hold on;
            hLBar(2) = rectangle('Position',[0,270,10,nTrial_ori/10],'LineStyle','none','FaceColor',colorBlue);
            hold on;
            plot(xpt20hz_ori{1},ypt20hz_ori{1},'LineStyle','none','Marker','.','MarkerSize',markerL,'Color','k');
            ylabel('Trials','FontSize',fontL);

            hLight20hzOri(2) = axes('Position',axpt(nCol,nRow,1,9,figSize,tightInterval));
            yLim20hzOri = ceil(max(peth20hzConv_ori*1.1)+0.001);
            plot(pethtime20hz_ori,peth20hzConv_ori,'LineStyle','-','LineWidth',lineM,'Color',colorBlack);

            xlabel('Time (ms)','FontSize',fontL);
            ylabel('Rate (Hz)','FontSize',fontL);
            align_ylabel(hLight20hzOri,1);

            set(hLight20hzOri(1),'XLim',winCri_ori2,'XTick',[],'YLim',[0, nTrial_ori],'YTick',[0, nTrial_ori],'YTickLabel',{0, nTrial_ori});
            set(hLight20hzOri(2), 'XLim', winCri_ori2, 'XTick', [0,10,winCri_ori2(2)],'YLim', [0 yLim20hzOri], 'YTick', [0 yLim20hzOri], 'YTickLabel', {[], yLim20hzOri});
            set(hLight20hzOri,'Box','off','TickDir','out','fontSize',fontL);
            
        %% Original 50Hz
            hLight50hzOri(1) = axes('Position',axpt(nCol,nRow,1,11,figSize,tightInterval));
            hLBar(1) = rectangle('Position',[0,0,10,nTrial_ori],'LineStyle','none','FaceColor',colorLLightBlue);
            hold on;
            hLBar(2) = rectangle('Position',[0,270,10,nTrial_ori/10],'LineStyle','none','FaceColor',colorBlue);
            hold on;
            plot(xpt50hz_ori{1},ypt50hz_ori{1},'LineStyle','none','Marker','.','MarkerSize',markerL,'Color','k');
            ylabel('Trials','FontSize',fontL);

            hLight50hzOri(2) = axes('Position',axpt(nCol,nRow,1,12,figSize,tightInterval));
            yLim50hzOri = ceil(max(peth50hzConv_ori*1.1)+0.001);
            plot(pethtime50hz_ori,peth50hzConv_ori,'LineStyle','-','LineWidth',lineM,'Color',colorBlack);

            xlabel('Time (ms)','FontSize',fontL);
            ylabel('Rate (Hz)','FontSize',fontL);
            align_ylabel(hLight50hzOri,1);

            set(hLight50hzOri(1),'XLim',winCri_ori3,'XTick',[],'YLim',[0, nTrial_ori],'YTick',[0, nTrial_ori],'YTickLabel',{0, nTrial_ori});
            set(hLight50hzOri(2), 'XLim', winCri_ori3, 'XTick', [0,10,winCri_ori3(2)],'YLim', [0 yLim50hzOri], 'YTick', [0 yLim50hzOri], 'YTickLabel', {[], yLim50hzOri});
            set(hLight50hzOri,'Box','off','TickDir','out','fontSize',fontL);
            
        %% Each light (2hz)
            hFreq2hz(1) = axes('Position',axpt(nCol,nRow,1:5,1,figSize,tightInterval));
            text(0,0.1,'2hz Stimulation','fontSize',fontXL,'fontWeight','bold');

            hFreq2hz(2) = axes('Position',axpt(nCol,nRow,3:5,2,figSize,tightInterval));
            for iLight = 1:15
                hLBar(1) = rectangle('Position',[500*iLight-500, 0, 10, nTrial_ori],'LineStyle','none','FaceColor',colorLLightBlue);
                hold on;
                hLBar(2) = rectangle('Position',[500*iLight-500, 18, 10, nTrial_ori/10],'LineStyle','none','FaceColor',colorBlue);
                hold on;
            end
            plot(xpt2hz{1},ypt2hz{1},'LineStyle','none','Marker','.','MarkerSize',markerL,'Color','k');

            hFreq2hz(3) = axes('Position',axpt(nCol,nRow,3:5,3,figSize,tightInterval));
            yLim2hz = ceil(max(peth2hzConv)*1.1+0.001);
            plot(pethtime2hz, peth2hzConv,'LineStyle','-','LineWidth',lineM,'Color',colorBlack);
            xlabel('Time (ms)','FontSize',fontL);

            set(hFreq2hz(1),'visible','off');
            set(hFreq2hz(2),'XLim',win2hz,'XTick',[],'YLim',[0, nTrial],'YTick',[0, nTrial],'YTickLabel',{0, nTrial});
            set(hFreq2hz(3), 'XLim', win2hz, 'XTick', [0:1000:win2hz(2)],'YLim', [0 yLim2hz], 'YTick', [0 yLim2hz], 'YTickLabel', {[], yLim2hz});
            set(hFreq2hz,'Box','off','TickDir','out','fontSize',fontL);

        %% Each light (8Hz)
            hFreq8hz(1) = axes('Position',axpt(nCol,nRow,1:5,4,figSize,tightInterval));
            text(0,0.1,'8hz Stimulation','fontSize',fontXL,'fontWeight','bold');

            hFreq8hz(2) = axes('Position',axpt(nCol,nRow,3:5,5,figSize,tightInterval));
            for iLight = 1:15
                hold on;
                hLBar(1) = rectangle('Position',[125*iLight-125, 0, 10, 20],'LineStyle','none','FaceColor',colorLLightBlue);
                hold on;
                hLBar(2) = rectangle('Position',[125*iLight-125, 18, 10, 2],'LineStyle','none','FaceColor',colorBlue);
            end
            plot(xpt8hz{1},ypt8hz{1},'LineStyle','none','Marker','.','MarkerSize',markerL,'Color','k');

            hFreq8hz(3) = axes('Position',axpt(nCol,nRow,3:5,6,figSize,tightInterval));
            yLim8hz = ceil(max(peth8hzConv)*1.1+0.001);
            plot(pethtime8hz,peth8hzConv,'LineStyle','-','LineWidth',lineM,'Color',colorBlack);
            xlabel('Time (ms)','FontSize',fontL);

            set(hFreq8hz(1),'visible','off');
            set(hFreq8hz(2),'XLim',win8hz,'XTick',[],'YLim',[0, nTrial],'YTick',[0, nTrial],'YTickLabel',{0, nTrial});
            set(hFreq8hz(3), 'XLim', win8hz, 'XTick', [0:500:win8hz(2)],'YLim',[0, yLim8hz],'YTick',[0 yLim8hz],'YTickLabel',{[], yLim8hz});
            set(hFreq8hz,'Box','off','TickDir','out','fontSize',fontL);
            
        %% Each light (20Hz)
            hFreq20hz(1) = axes('Position',axpt(nCol,nRow,1:5,7,figSize,tightInterval));
            text(0,0.1,'20hz Stimulation','fontSize',fontXL,'fontWeight','bold');

            hFreq20hz(2) = axes('Position',axpt(nCol,nRow,3:5,8,figSize,tightInterval));
            for iLight = 1:15
                hold on;
                hLBar(1) = rectangle('Position',[50*iLight-50, 0, 10, 20],'LineStyle','none','FaceColor',colorLLightBlue);
                hold on;
                hLBar(2) = rectangle('Position',[50*iLight-50, 18, 10, 2],'LineStyle','none','FaceColor',colorBlue);
            end
            plot(xpt20hz{1},ypt20hz{1},'LineStyle','none','Marker','.','MarkerSize',markerL,'Color','k');

            hFreq20hz(3) = axes('Position',axpt(nCol,nRow,3:5,9,figSize,tightInterval));
            yLim20hz = ceil(max(peth20hzConv)*1.1+0.001);
            plot(pethtime20hz,peth20hzConv,'LineStyle','-','LineWidth',lineM,'Color',colorBlack);
            xlabel('Time (ms)','FontSize',fontL);

            set(hFreq20hz(1),'visible','off');
            set(hFreq20hz(2),'XLim',win20hz,'XTick',[],'YLim',[0, nTrial],'YTick',[0, nTrial],'YTickLabel',{0, nTrial});
            set(hFreq20hz(3), 'XLim', win20hz, 'XTick', [0:500:win20hz(2)],'YLim',[0, yLim20hz],'YTick',[0 yLim20hz],'YTickLabel',{[], yLim20hz});
            set(hFreq20hz,'Box','off','TickDir','out','fontSize',fontL);
            
        %% Each light (50Hz)
            hFreq50hz(1) = axes('Position',axpt(nCol,nRow,1:5,10,figSize,tightInterval));
            text(0,0.1,'50hz Stimulation','fontSize',fontXL,'fontWeight','bold');

            hFreq50hz(2) = axes('Position',axpt(nCol,nRow,3:5,11,figSize,tightInterval));
            for iLight = 1:15
                hold on;
                hLBar(1) = rectangle('Position',[20*iLight-20, 0, 10, 20],'LineStyle','none','FaceColor',colorLLightBlue);
                hold on;
                hLBar(2) = rectangle('Position',[20*iLight-20, 18, 10, 2],'LineStyle','none','FaceColor',colorBlue);
            end
            plot(xpt50hz{1},ypt50hz{1},'LineStyle','none','Marker','.','MarkerSize',markerL,'Color','k');

            hFreq50hz(3) = axes('Position',axpt(nCol,nRow,3:5,12,figSize,tightInterval));
            yLim50hz = ceil(max(peth50hzConv)*1.1+0.001);
            plot(pethtime50hz,peth50hzConv,'LineStyle','-','LineWidth',lineM,'Color',colorBlack);
            xlabel('Time (ms)','FontSize',fontL);

            set(hFreq50hz(1),'visible','off');
            set(hFreq50hz(2),'XLim',win50hz,'XTick',[],'YLim',[0, nTrial],'YTick',[0, nTrial],'YTickLabel',{0, nTrial});
            set(hFreq50hz(3), 'XLim', win50hz, 'XTick', [0:500:win50hz(2)],'YLim',[0, yLim50hz],'YTick',[0 yLim50hz],'YTickLabel',{[], yLim50hz});
            set(hFreq50hz,'Box','off','TickDir','out','fontSize',fontL);

            print('-painters',[cellName,'.tiff'],'-r300','-dtiff');
            close;

            fclose('all');
    end
end

function spikeTime = spikeWin(spikeData, eventTime, win)
% spikeWin makes raw spikeData to eventTime aligned data
%   spikeData: raw data from MClust. Unit must be ms.
%   eventTime: each output cell will be eventTime aligned spike data. unit must be ms
%   win: spike within windows will be included. unit must be ms.
narginchk(3,3);

if isempty(eventTime); spikeTime =[]; return; end;
nEvent = size(eventTime);
spikeTime = cell(nEvent);
for iEvent = 1:nEvent(1)
    for jEvent = 1:nEvent(2)
        timeIndex = [];
        if isnan(eventTime(iEvent,jEvent)); continue; end;
        [~,timeIndex] = histc(spikeData,eventTime(iEvent,jEvent)+win);
        if isempty(timeIndex); continue; end;
        spikeTime{iEvent,jEvent} = spikeData(logical(timeIndex))-eventTime(iEvent,jEvent);
    end
end
function [xpt,ypt,spikeBin,spikeHist,spikeConv,spikeConvZ] = rasterPETH(spikeTime, trialIndex, win, binSize, resolution, dot)
% raterPSTH converts spike time into raster plot
%   spikeTime: cell array. Each cell contains vector array of spike times per each trial unit is ms.
%   trialIndex: number of raws should be same as number of trials (length of spikeTime)
%   win: window range of xpt. should be 2 numbers. unit is msec.
%   resolution: sigma for convolution = binsize * resolution.
%   dot: 1-dot, 0-line
%   unit of xpt will be msec.
narginchk(5,6);
if isempty(spikeTime) || isempty(trialIndex) || length(spikeTime) ~= size(trialIndex,1) || length(win) ~= 2
    xpt = []; ypt = []; spikeBin = []; spikeHist = []; spikeConv = []; spikeConvZ = [];
    return;
end;

spikeBin = win(1):binSize:win(2); % unit: msec
nSpikeBin = length(spikeBin);

nTrial = length(spikeTime);
nCue = size(trialIndex,2);
trialResult = sum(trialIndex);
resultSum = [0 cumsum(trialResult)];

yTemp = [0:nTrial-1; 1:nTrial; NaN(1,nTrial)]; % template for ypt
xpt = cell(1,nCue);
ypt = cell(1,nCue);
spikeHist = zeros(nCue,nSpikeBin);
spikeConv = zeros(nCue,nSpikeBin);

for iCue = 1:nCue
    % raster
    nSpikePerTrial = cellfun(@length,spikeTime(trialIndex(:,iCue)));
    nSpikeTotal = sum(nSpikePerTrial);
    if nSpikeTotal == 0; continue; end;
    
    spikeTemp = cell2mat(spikeTime(trialIndex(:,iCue)))';
    
    xptTemp = [spikeTemp;spikeTemp;NaN(1,nSpikeTotal)];
    if (nargin == 6) && (dot==1)
        xpt{iCue} = xptTemp(2,:);
    else
        xpt{iCue} = xptTemp(:);
    end
    
    yptTemp = [];
    for iy = 1:trialResult(iCue)
        yptTemp = [yptTemp repmat(yTemp(:,resultSum(iCue)+iy),1,nSpikePerTrial(iy))];
    end
    if (nargin == 6) && (dot==1)
        ypt{iCue} = yptTemp(2,:);
    else
        ypt{iCue} = yptTemp(:);
    end
    
    % psth
    spkhist_temp = histc(spikeTemp,spikeBin)/(binSize/10^3*trialResult(iCue));
    spkconv_temp = conv(spkhist_temp,fspecial('Gaussian',[1 5*resolution],resolution),'same');
    spikeHist(iCue,:) = spkhist_temp;
    spikeConv(iCue,:) = spkconv_temp;
end

totalHist = histc(cell2mat(spikeTime),spikeBin)/(binSize/10^3*nTrial);
fireMean = mean(totalHist);
fireStd = std(totalHist);
spikeConvZ = (spikeConv-fireMean)/fireStd;    
