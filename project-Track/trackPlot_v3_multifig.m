function trackPlot_v3_multifig(fileList,rtDir)
% ##### Modified Dohyoung Kim's code. Thanks to Dohyoung! ##### %
% This v3.0 draws figures which are based on mat-files in the folder
%
% 

% Plot properties
lineColor = {[144, 164, 174]./255,... % Before stimulation
    [244, 67, 54]./255,... % During stimulation
    [38, 50, 56]./255}; % After stimulation

lineWth = [1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75];
fontS = 4; fontM = 6; fontL = 8; % font size
lineS = 0.2; lineM = 0.5; lineL = 1; % line width large
tightInterval = [0.02 0.02]; wideInterval = [0.07 0.07];
markerS = 2.2; markerM = 4.4; markerL = 6.6;

colorBlue = [33 150 243] ./ 255;
colorLightBlue = [223 239 252] ./ 255;
colorRed = [237 50 52] ./ 255;
colorLightRed = [242 138 130] ./ 255;
colorGray = [189 189 189] ./ 255;
colorYellow = [255 243 3] ./ 255;
colorLightYellow = [255 249 196] ./ 255;
colorBlack = [0, 0, 0];
colorBar3 = [colorGray;colorBlue;colorGray];

nCol = 4;
nRowSub = 8; % for the left column
nRowMain = 5; % for the main figure

matFile = fileList;
nFile = length(matFile);

for iFile = 1:nFile
    [cellDir,cellName,~] = fileparts(matFile{iFile});
    cellDirSplit = regexp(cellDir,'\','split');
    cellFigName = strcat(cellDirSplit(end-1),'_',cellDirSplit(end),'_',cellName);
    sfreq = [30 60];
    
    % Arc property
    if ~isempty(strfind(cellDir,'DRun'));
        arc = linspace(pi,pi/2*3,170); % s6-s9
    else ~isempty(strfind(cellDir,'DRw'));
        arc = linspace(pi/6*5, pi/6*4,170);
    end
    
    cd(cellDir);
    load(matFile{iFile});
    load('Events.mat');  
    
    % Cell information
    fHandle = figure('PaperUnits','centimeters','PaperPosition',[0 0 18.3 13.725]);
    hText = axes('Position',axpt(1,2,1,1,axpt(nCol,nRowSub,1,1:2,[],wideInterval),tightInterval));
    hold on;
    text(0,1.5,matFile{iFile}, 'FontSize',fontM, 'Interpreter','none');
%     text(0,0.9,['p_A = ',num2str(trialResult(1)/(trialResult(1)+trialResult(3)),2), ...
%         ', p_B = ',num2str(trialResult(5)/(trialResult(5)+trialResult(7)),2)], 'FontSize', fontS);
    text(0,0.7,['Mean firing rate (baseline): ',num2str(meanFR_base,3), ' Hz'], 'FontSize',fontS);
    text(0,0.55,['Mean firing rate (task): ',num2str(meanFR_task,3), ' Hz'], 'FontSize',fontS);
    text(0,0.35,['Spike width: ',num2str(spkwth,3),' us'], 'FontSize',fontS);
    text(0,0.2,['Half-valley width: ',num2str(hfvwth,3),' us'], 'FontSize',fontS);
    text(0,0.05,['Peak valley ratio: ',num2str(spkpvr,3)], 'FontSize',fontS);
    set(hText,'Visible','off');
    
    % Waveform
    yLimWaveform = [min(spkwv(:)) max(spkwv(:))];
        for iCh = 1:4
            hWaveform(iCh) = axes('Position',axpt(4,2,iCh,2,axpt(nCol,nRowSub,1,1:2,[],wideInterval),tightInterval));
            plot(spkwv(iCh,:), 'LineWidth', lineL, 'Color','k');
            if iCh == 4
                line([24 32], [yLimWaveform(2)-50 yLimWaveform(2)-50], 'Color','k', 'LineWidth', lineM);
                line([24 24],[yLimWaveform(2)-50 yLimWaveform(2)], 'Color','k', 'LineWidth',lineM);
            end
        end
        set(hWaveform, 'Visible', 'off', ...
            'XLim',[1 32], 'YLim',yLimWaveform*1.05);
    
    %% Tagging
    if ~isempty(lightTime.Tag);
        
    % Activation or Inactivation?
      if isfield(lightTime,'Tag') && exist('xptTagBlue','var');
        lightDuration = 10;
        lightDurationColor = colorLightBlue;
        testRangeChETA = 10; % ChETA light response test range (ex. 10ms)       
      else isfield(lightTime,'Tag') && exist('xptTagYel','var');
        lightDuration = 1000;
        lightDurationColor = colorLightYellow;
%         testRangeTag = 500; 
      end
    
    if isfield(lightTime,'Tag') && exist('xptTagBlue','var') && ~isempty(xptTagBlue)
        nBlue = length(lightTime.Tag);
        winBlue = [min(pethtimeTagBlue) max(pethtimeTagBlue)];
    % Blue tag raster
        hTagBlue(1) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRowMain,2,1,[],wideInterval),tightInterval));
        plot(xptTagBlue{1},yptTagBlue{1},...
            'LineStyle','none','Marker','.','MarkerSize',markerS,'Color','k');
        set(hTagBlue(1),'XLim',winBlue,'XTick',[],...
            'YLim',[0 nBlue], 'YTick', [0 nBlue], 'YTickLabel', {[], nBlue});
        ylabel('Trials','FontSize',fontS);
        title('Baseline Response (2Hz)','FontSize',fontM);     
    % Blue tag psth
        hTagBlue(2) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRowMain,2,1,[],wideInterval),tightInterval));
        hold on;
        yLimBarBlue = ceil(max(pethTagBlue(:))*1.05+0.0001);
        bar(5, 1000, 'BarWidth', 10, 'LineStyle','none', 'FaceColor', colorLightBlue);
        rectangle('Position', [0 yLimBarBlue*0.925, 10, yLimBarBlue*0.075], 'LineStyle', 'none', 'FaceColor', colorBlue);
        hBarBlue = bar(pethtimeTagBlue, pethTagBlue, 'histc');
        text(sum(winBlue)*0.3,yLimBarBlue*0.9,['latency = ', num2str(testLatencyTag_first,3)],'FontSize',fontS,'interpreter','none');
        text(sum(winBlue)*0.85,yLimBarBlue*0.9,['p_lat = ',num2str(pLatencyTag_first,3)],'FontSize',fontS,'interpreter','none');
        set(hBarBlue, 'FaceColor','k', 'EdgeAlpha',0);
        set(hTagBlue(2), 'XLim', winBlue, 'XTick', [winBlue(1) 0 winBlue(2)], ...
            'YLim', [0 yLimBarBlue], 'YTick', [0 yLimBarBlue], 'YTickLabel', {[], yLimBarBlue});
        xlabel('Time (ms)', 'FontSize', fontS);
        ylabel('Rate (Hz)', 'FontSize', fontS);
    % Blue tag hazard function  
        hTagBlue(3) = axes('Position',axpt(1,20,1,1:8,axpt(nCol,nRowMain,4,1,[],wideInterval),tightInterval));
        hold on;
        ylimH = min([ceil(max([H1_tag;H2_tag])*1100+0.0001)/1000 1]);
        winHTag = [0 testRangeChETA];
        stairs(timeLR_tag, H2_tag, 'LineStyle',':','LineWidth',lineL,'Color','k');
        stairs(timeLR_tag, H1_tag,'LineStyle','-','LineWidth',lineL,'Color',colorBlue);
        text(winHTag(2)*0.1,ylimH*0.9,['p = ',num2str(pLR_tag,3),' (log-rank)'],'FontSize',fontS,'Interpreter','none');
        set(hTagBlue(3),'XLim',winHTag,'XTick',winHTag,...
            'YLim',[0 ylimH], 'YTick', [0 ylimH], 'YTickLabel', {[], ylimH});
%         xlabel('Time (ms)','FontSize',fontS);
        ylabel('H(t)','FontSize',fontS);
        set(hTagBlue,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS);
        align_ylabel(hTagBlue)
    end

    % Yello tag
    if isfield(lightTime,'Tag') && exist('xptTagYel','var') && ~isempty(xptTagYel)
        nYel = length(lightTime.Tag);
        winYel = [min(pethtimeTagYel) max(pethtimeTagYel)];
    % Yellow tag raster
        hTagYel(1) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRowMain,2,1,[],wideInterval),tightInterval));
        plot(xptTagYel{1},yptTagYel{1},...
            'LineStyle','none','Marker','.','MarkerSize',markerS,'Color','k');
        set(hTagYel(1),'XLim',winYel,'XTick',[],...
            'YLim',[0 nYel], 'YTick', [0 nYel], 'YTickLabel', {[], nYel});
        ylabel('Trials','FontSize',fontS);
        title('Tagging','FontSize',fontM);
    % Yellow tag psth
        hTagYel(2) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRowMain,2,1,[],wideInterval),tightInterval));
        hold on;
        yLimBarYel = ceil(max(pethTagYel(:))*1.05+0.0001);
        bar(1000, 1000, 'BarWidth', 2000, 'LineStyle', 'none', 'FaceColor', colorLightYellow);
        rectangle('Position', [0 yLimBarYel*0.925 2000 yLimBarYel*0.075], 'LineStyle', 'none', 'FaceColor', colorYellow);
        hBarYel = bar(pethtimeTagYel, pethTagYel, 'histc');
        set(hBarYel, 'FaceColor','k', 'EdgeAlpha',0);
        set(hTagYel(2), 'XLim', winYel, 'XTick', [winYel(1) 0 winYel(2)], ...
            'YLim', [0 yLimBarYel], 'YTick', [0 yLimBarYel], 'YTickLabel', {[], yLimBarYel});
        xlabel('Time (ms)', 'FontSize', fontS);
        ylabel('Rate (Hz)', 'FontSize', fontS);
        set(hTagYel, 'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS);
        align_ylabel(hTagYel)          
    end
    
   %% Modulation
    % Blue modulation
    if isfield(lightTime,'Modu') && exist('xptModuBlue','var') && ~isempty(xptModuBlue)
        nBlue = length(lightTime.Modu);
        winBlue = [min(pethtimeModuBlue) max(pethtimeModuBlue)];
    % Blue modulation raster
        hModuBlue(1) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRowMain,3,1,[],wideInterval),tightInterval));
        plot(xptModuBlue{1},yptModuBlue{1},...
            'LineStyle','none','Marker','.','MarkerSize',markerS,'Color','k');
        set(hModuBlue(1),'XLim',winBlue,'XTick',[],...
            'YLim',[0 nBlue], 'YTick', [0 nBlue], 'YTickLabel', {[], nBlue});
        ylabel('Trials','FontSize',fontS);
        title('On track','FontSize',fontM);    
    % Blue modulation psth
        hModuBlue(2) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRowMain,3,1,[],wideInterval),tightInterval));
        hold on;
        yLimBarBlue = ceil(max(pethModuBlue(:))*1.05+0.0001);
        bar(5, 1000, 'BarWidth', 10,'LineStyle', 'none', 'FaceColor', colorLightBlue);
        rectangle('Position', [0, yLimBarBlue*0.925, 10, yLimBarBlue*0.075], 'LineStyle', 'none', 'FaceColor', colorBlue);
        hBarBlue = bar(pethtimeModuBlue, pethModuBlue, 'histc');
        text(sum(winBlue)*0.3,yLimBarBlue*0.9,['latency = ', num2str(testLatencyModu_first,3)],'FontSize',fontS,'interpreter','none');
        text(sum(winBlue)*0.85,yLimBarBlue*0.9,['p_lat = ',num2str(pLatencyModu_first,3)],'FontSize',fontS,'interpreter','none');
        set(hBarBlue, 'FaceColor','k', 'EdgeAlpha',0);
        set(hModuBlue(2), 'XLim', winBlue, 'XTick', [winBlue(1), 0, winBlue(2)],'XTickLabel',{winBlue(1);0;[num2str(winBlue(2)),'(ms)']},...
            'YLim', [0 yLimBarBlue], 'YTick', [0 yLimBarBlue], 'YTickLabel', {[], yLimBarBlue});
        ylabel('Rate (Hz)', 'FontSize', fontS);  
    % Blue log-rank test plot    
        hModuBlue(3) = axes('Position',axpt(1,20,1,13:20,axpt(nCol,nRowMain,4,1,[],wideInterval),tightInterval));
        hold on;
        ylimH = min([ceil(max([H1_modu;H2_modu])*1100+0.0001)/1000 1]);
        winHModu = [0 testRangeChETA];
        stairs(timeLR_modu, H2_modu, 'LineStyle',':','LineWidth',lineL,'Color','k');
        stairs(timeLR_modu, H1_modu,'LineStyle','-','LineWidth',lineL,'Color',colorBlue);
        text(winHModu(2)*0.1,ylimH*0.9,['p = ',num2str(pLR_modu,3),' (log-rank)'],'FontSize',fontS,'Interpreter','none');
        set(hModuBlue(3),'XLim',winHModu,'XTick',winHModu,'XTickLabel',{winHModu(1);[num2str(winHModu(2)),'(ms)']},...
            'YLim',[0 ylimH], 'YTick', [0 ylimH], 'YTickLabel', {[], ylimH});
        xlabel('Time (ms)','FontSize',fontS);
        ylabel('H(t)','FontSize',fontS);
        set(hModuBlue,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS);
        align_ylabel(hModuBlue)     
    end

    % Yello Modulation
    if  exist('xptModuYel','var') && ~isempty(xptModuYel) && ~isempty(xptModuYel)
        nYel = length(lightTime.Modu);
        winYel = [min(pethtimeModuYel) max(pethtimeModuYel)];
    % Yellow modulation raster
        hModuYel(1) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRowMain,3,1,[],wideInterval),tightInterval));
        plot(xptModuYel{1},yptModuYel{1},...
            'LineStyle','none','Marker','.','MarkerSize',markerS,'Color','k');
        set(hModuYel(1),'XLim',winYel,'XTick',[],...
            'YLim',[0 nYel], 'YTick', [0 nYel], 'YTickLabel', {[], nYel});
        ylabel('Trials','FontSize',fontS);
        title('On track','FontSize',fontM);       
    % Yellow modulation psth
        hModuYel(2) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRowMain,3,1,[],wideInterval),tightInterval));
        hold on;
        yLimBarYel = ceil(max(pethModuYel(:))*1.05+0.0001);
        bar(250, 1000, 'BarWidth', 500, 'LineStyle', 'none', 'FaceColor', colorLightYellow);
        rectangle('Position', [0 yLimBarYel*0.925 500 yLimBarYel*0.075], 'LineStyle', 'none', 'FaceColor', colorYellow);
        hBarYel = bar(pethtimeModuYel, pethModuYel, 'histc');
        set(hBarYel, 'FaceColor','k', 'EdgeAlpha',0);
        set(hModuYel(2), 'XLim', winYel, 'XTick', [winYel(1) 0 winYel(2)], ...
            'YLim', [0 yLimBarYel], 'YTick', [0 yLimBarYel], 'YTickLabel', {[], yLimBarYel});
        xlabel('Time (ms)', 'FontSize', fontS);
        ylabel('Rate (Hz)', 'FontSize', fontS);
        set(hModuYel, 'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS);  
    end
    else
       lightDurationColor = [1, 1, 1];
    end  
       
    %% Heat map
    pre_ratemap(pre_ratemap==0) = NaN;
    peak_pre = max(max(pre_ratemap))*sfreq(1);
    stm_ratemap(stm_ratemap==0) = NaN;
    peak_stm = max(max(stm_ratemap))*sfreq(1);
    post_ratemap(post_ratemap==0) = NaN;
    peak_post = max(max(post_ratemap))*sfreq(1);
    
    totalmap = [pre_ratemap(1:45,23:67),stm_ratemap(1:45,23:67),post_ratemap(1:45,23:67)];
    hMap = axes('Position',axpt(nCol,nRowMain,1:2,2,[],wideInterval));
        hold on;
        hField = pcolor(totalmap);
        
        if ~isempty(lightTime.Modu)
            hold on;
            arc_r = 20;
            x = arc_r*cos(arc)+70;
            y = arc_r*sin(arc)+25;
            if exist('xptModuBlue','var');
                plot(x,y,'LineWidth',4,'color',colorBlue);
            else exist('xptModuYel','var');
                plot(x,y,'LineWidth',4,'color',colorYellow);
            end
        else
        end;
        set(hField,'linestyle','none');
        set(hMap,'XLim',[0,135],'YLim',[0,45],'visible','off');
        text(125,40,[num2str(ceil(max(max(totalmap*sfreq(1))))), ' Hz'],'color','k','FontSize',fontM)
        text(17,0,'Pre-stm','color','k','FontSize',fontM);
        text(65,0,'Stm','color','k','FontSize',fontM)
        text(107,0,'Post-stm','color','k','FontSize',fontM)

    % Pearson's correlation
        hCorr = axes('Position',axpt(6,1,4,1,axpt(nCol,nRowMain,1:nCol,2,[],wideInterval),wideInterval));
        hold on;
        xptPcomp = 1:4;
        yptStim = [r_Corrhfxhf;r_Corrbfxdr;r_Corrbfxaft;r_Corrdrxaft];
        bar(xptPcomp,yptStim,0.6,'FaceColor',colorGray,'EdgeColor','k');
        set(hCorr,'XLim',[0,5],'YLim',[-1.2 1.2],'XTick',1:4, 'XTickLabel',{'hxh','bxd','bxa','dxa'},'YTick',[-1:0.5:1],'FontSize',fontS,'LineWidth',lineM,'TickDir','out');

    % Light modulation direction 
        if exist('lightSpk','var') && exist('psdPreSpk','var')
            hLight(1) = axes('Position',axpt(6,1,5,1,axpt(nCol,nRowMain,1:nCol,2,[],wideInterval),wideInterval)); %(between session)
            hold on;
            nbar = 3;
            yptLight_inter = [psdPreSpk;lightSpk;psdPostSpk];
            for ibar = 1:nbar
                hinterBar = bar(ibar,yptLight_inter(ibar,1),'EdgeColor',[0,0,0],'FaceColor',colorBar3(ibar,:));
            end
            title('Btw-block','FontSize',fontM);
            set(hLight(1),'YLim',[0,1.2*max(yptLight_inter)+0.01],'XTick',1:3,'XTickLabel',{'Pre';'Stm';'Post'},'FontSize',fontS,'LineWidth',lineS,'TickDir','out');
            
            hLight(2) = axes('Position',axpt(6,1,6,1,axpt(nCol,nRowMain,1:nCol,2,[],wideInterval),wideInterval));
            hold on;
            yptLight_intra = [lightPreSpk;lightSpk;lightPostSpk];
            for ibar = 1:nbar
                hintraBar = bar(ibar,yptLight_intra(ibar,1),'EdgeColor',[0,0,0],'FaceColor',colorBar3(ibar,:));
            end
            title('In-block','FontSize',fontM);
            set(hLight(2),'YLim',[0,1.2*max(yptLight_intra)+0.01],'XTick',1:3,'XTickLabel',{'-15~0','0~15','15~30'},'FontSize',fontS,'LineWidth',lineS,'TickDir','out');
        end

    %% Sensor aligned
        for iSensor = 1:nSensor
            if rem(iSensor,4) == 0;
                xPositionIdx = 4;
            else
                xPositionIdx = rem(iSensor,4);
            end
            
            switch ceil(iSensor/4)
                case 1
                    yPositionIdx = 3;
                case 2
                    yPositionIdx = 4;
                case 3
                    yPositionIdx = 5;
            end
            
            hRaster(iSensor) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRowMain,xPositionIdx,yPositionIdx,[],wideInterval),wideInterval));
            hold on;
            plot([xpt.(fields{iSensor}){1} xpt.(fields{iSensor}){2}, xpt.(fields{iSensor}){3}],[ypt.(fields{iSensor}){1}, ypt.(fields{iSensor}){2}, ypt.(fields{iSensor}){3}],...
                'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');
            rec(iSensor) = rectangle('Position',[-0.99 31 2 30], 'LineStyle','none','FaceColor',lightDurationColor);
            ylabel('Trial','FontSize',fontS);
            title(fields{iSensor},'FontSize',fontM);
            
            hPsth(iSensor) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRowMain,xPositionIdx,yPositionIdx,[],wideInterval),wideInterval));
            ylimpeth(iSensor) = ceil(max(pethconv.(fields{iSensor})(:))*1.1+0.0001);
            hold on;
            for iType = 1:3
                plot(pethtime.(fields{iSensor}),pethconv.(fields{iSensor})(iType,:),...
                'LineStyle',':','LineWidth',lineM,'Color',lineColor{iType})
            end
            ylabel('Rate (Hz)', 'FontSize', fontS);
            uistack(rec(iSensor),'bottom');
        end      
        set(hRaster,'Box', 'off', 'TickDir', 'out', 'LineWidth', lineS, 'FontSize', fontS,...
                'XLim',[-1 1], 'XTick', [], 'YLim', [0, 90], 'YTick', [0:30:90]);
        set(hPsth, 'Box', 'off', 'TickDir', 'out', 'LineWidth', lineS, 'FontSize', fontS,...
                'XLim', [-1, 1], 'XTick', [-1:0.2:1]);         
        for iSensor = 1:nSensor
            set(hPsth(iSensor),'YLim',[0 ylimpeth(iSensor)]);
        end
        cd(rtDir)
        print(gcf,'-dtiff','-r300',[cellFigName{1},'.tif']);
        close;
end
end