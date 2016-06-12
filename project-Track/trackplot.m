function trackplot()
% psthtrack Converts data from MClust t files to Matlab mat files
% ##### Modified Dohyoung Kim's code. Thanks to Dohyoung! ##### %
[matFile, nFile] = matfilecollector;
rtdir = pwd;

% Plot properties
lineClr = {[0.8 0 0], ... % Cue A, Rw, no mod
    [1 0.6 0.6], ... % Cue A, Rw, mod
    [1 0.6 0], ... % Cue A, no Rw, no mod
    [1 0.8 0.4], ... % Cue A, no Rw, mod
    [0 0 0.8], ... % Cue B, Rw, no mod
    [0.6 0.6 1], ... % Cue B, Rw, mod
    [0 0.6 1], ... % Cue B, no Rw, no mod
    [0.4 0.8 1], ... % Cue B, no Rw, mod
    [1 0.6 0], ... % Cue C
    [1 1 0.4], ...
    [1 0.6 0], ...
    [1 1 0.4], ...
    [0 0.6 1], ... % Cue D
    [0.4 1 1], ...
    [0 0.6 1], ...
    [0.4 1 1]};

lineStl = {'-', '-', '-', '-', ...
    '-', '-', '-', '-', ...
    '-', '-', '-', '-', ...
    '-', '-', '-', '-'};

lineColor = {[144, 164, 174]./255,... % Before stimulation
    [244, 67, 54]./255,... % During stimulation
    [38, 50, 56]./255}; % After stimulation

lineWth = [1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75];
fontS = 4; % font size small
fontM = 6; % font size middle
fontL = 8; % font size large
lineS = 0.2; % line width small
lineM = 0.5; % line width middle
lineL = 1; % line width large

colorBlue = [33 150 243] ./ 255;
colorLightBlue = [223 239 252] ./ 255;
colorRed = [237 50 52] ./ 255;
colorLightRed = [242 138 130] ./ 255;
colorGray = [189 189 189] ./ 255;
colorYellow = [255 243 3] ./ 255;
colorLightYellow = [255 249 196] ./ 255;

tightInterval = [0.02 0.02];
wideInterval = [0.07 0.07];

nCol = 4;
nRowSub = 8; % for the left column
nRowMain = 5; % for the main figure

markerS = 2.2;
markerM = 4.4;
markerL = 6.6;

% properties

for iFile = 1:nFile
    [cellDir,cellName,~] = fileparts(matFile{iFile});
    cellDirSplit = regexp(cellDir,'\','split');
    cellFigName = strcat(cellDirSplit(end-1),'_',cellDirSplit(end),'_',cellName);
    
    % Arc property
    sfreq = [30 60];
    if ~isempty(strfind(cellDir,'DRun'));
        arc = linspace(pi/6*5,pi/2*3,200); % s6-s10
    elseif ~isempty(strfind(cellDir,'ARw'));
        arc = linspace(pi,pi/6*10,200); % Optic stimulation position indicator
    elseif ~isempty(strfind(cellDir,'BRw'));
        arc = linspace(pi/6*5,pi/6*7,200); % Optic stimulation position indicator
    else ~isempty(strfind(cellDir,'DRw'));
        arc = linspace(pi/6*5, pi/6*4,200);
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
    text(0,0.7,['Mean firing rate (baseline): ',num2str(fr_base,3), ' Hz'], 'FontSize',fontS);
    text(0,0.55,['Mean firing rate (task): ',num2str(fr_task,3), ' Hz'], 'FontSize',fontS);
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
    % Blue tag
      if isfield(lightTime,'Tag') && exist('xptTagBlue','var');
        lightDuration = 10;
        lightDurationColor = colorLightBlue;
      else isfield(lightTime,'Tag') && exist('xptTagYel','var');
        lightDuration = 1000;
        lightDurationColor = colorLightYellow;
      end
    
    if isfield(lightTime,'Tag') && exist('xptTagBlue','var') && ~isempty(xptTagBlue)
        nBlue = length(lightTime.Tag);
        winBlue = [min(psthtimeTagBlue) max(psthtimeTagBlue)];

        % Blue tag raster
        hTagBlue(1) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRowMain,2,1,[],wideInterval),tightInterval));
        plot(xptTagBlue{1},yptTagBlue{1},...
            'LineStyle','none','Marker','.','MarkerSize',markerS,'Color','k');
        set(hTagBlue(1),'XLim',winBlue,'XTick',[],...
            'YLim',[0 nBlue], 'YTick', [0 nBlue], 'YTickLabel', {[], nBlue});
        ylabel('Trials','FontSize',fontS);
        title('Tagging (2Hz)','FontSize',fontM);
        % Blue tag psth
        hTagBlue(2) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRowMain,2,1,[],wideInterval),tightInterval));
        hold on;
        yLimBarBlue = ceil(max(psthTagBlue(:))*1.05+0.0001);
        bar(5, 1000, 'BarWidth', 10, 'LineStyle','none', 'FaceColor', colorLightBlue);
        rectangle('Position', [0 yLimBarBlue*0.925, 10, yLimBarBlue*0.075], 'LineStyle', 'none', 'FaceColor', colorBlue);
        hBarBlue = bar(psthtimeTagBlue, psthTagBlue, 'histc');
        set(hBarBlue, 'FaceColor','k', 'EdgeAlpha',0);
        set(hTagBlue(2), 'XLim', winBlue, 'XTick', [winBlue(1) 0 winBlue(2)], ...
            'YLim', [0 yLimBarBlue], 'YTick', [0 yLimBarBlue], 'YTickLabel', {[], yLimBarBlue});
        xlabel('Time (ms)', 'FontSize', fontS);
        ylabel('Rate (Hz)', 'FontSize', fontS);
%         set(hTagBlue, 'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS);
%         align_ylabel(hTagBlue)
        
        hTagBlue(3) = axes('Position',axpt(1,20,1,1:8,axpt(nCol,nRowMain,4,1,[],wideInterval),tightInterval));
        hold on;
        ylimH = min([ceil(max([H1_tag;H2_tag])*1100+0.0001)/1000 1]);
        winHTag = [0 ceil(max(time_tag))];
        stairs(time_tag, H2_tag, 'LineStyle',':','LineWidth',lineL,'Color','k');
        stairs(time_tag, H1_tag,'LineStyle','-','LineWidth',lineL,'Color',colorBlue);
        if ~isempty(H1_tag)
        text(winHTag(2)*0.1,ylimH*0.9,['p = ',num2str(p_tag,3),' (log-rank)'],'FontSize',fontS,'Interpreter','none');
        set(hTagBlue(3),'XLim',winHTag,'XTick',winHTag,...
            'YLim',[0 ylimH], 'YTick', [0 ylimH], 'YTickLabel', {[], ylimH});
%         xlabel('Time (ms)','FontSize',fontS);
        else
        end
        ylabel('H(t)','FontSize',fontS);
        set(hTagBlue,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS);
        align_ylabel(hTagBlue)
    end

    % Yello tag
    if isfield(lightTime,'Tag') && exist('xptTagYel','var') && ~isempty(xptTagYel)
        nYel = length(lightTime.Tag);
        winYel = [min(psthtimeTagYel) max(psthtimeTagYel)];

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
        yLimBarYel = ceil(max(psthTagYel(:))*1.05+0.0001);
        bar(1000, 1000, 'BarWidth', 2000, 'LineStyle', 'none', 'FaceColor', colorLightYellow);
        rectangle('Position', [0 yLimBarYel*0.925 2000 yLimBarYel*0.075], 'LineStyle', 'none', 'FaceColor', colorYellow);
        hBarYel = bar(psthtimeTagYel, psthTagYel, 'histc');
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
        winBlue = [min(psthtimeModuBlue) max(psthtimeModuBlue)];

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
        yLimBarBlue = ceil(max(psthModuBlue(:))*1.05+0.0001);
        bar(5, 1000, 'BarWidth', 10,'LineStyle', 'none', 'FaceColor', colorLightBlue);
        rectangle('Position', [0, yLimBarBlue*0.925, 10, yLimBarBlue*0.075], 'LineStyle', 'none', 'FaceColor', colorBlue);
        hBarBlue = bar(psthtimeModuBlue, psthModuBlue, 'histc');
        set(hBarBlue, 'FaceColor','k', 'EdgeAlpha',0);
        set(hModuBlue(2), 'XLim', winBlue, 'XTick', [winBlue(1) 0 winBlue(2)], ...
            'YLim', [0 yLimBarBlue], 'YTick', [0 yLimBarBlue], 'YTickLabel', {[], yLimBarBlue});
        xlabel('Time (ms)', 'FontSize', fontS);
        ylabel('Rate (Hz)', 'FontSize', fontS);
        
        hModuBlue(3) = axes('Position',axpt(1,20,1,13:20,axpt(nCol,nRowMain,4,1,[],wideInterval),tightInterval));
        hold on;
        ylimH = min([ceil(max([H1_Modu;H2_Modu])*1100+0.0001)/1000 1]);
        winHModu = [0 ceil(max(time_Modu))];
        stairs(time_Modu, H2_Modu, 'LineStyle',':','LineWidth',lineL,'Color','k');
        stairs(time_Modu, H1_Modu,'LineStyle','-','LineWidth',lineL,'Color',colorBlue);
        if ~isempty(H1_Modu)
        text(winHModu(2)*0.1,ylimH*0.9,['p = ',num2str(p_Modu,3),' (log-rank)'],'FontSize',fontS,'Interpreter','none');
        set(hModuBlue(3),'XLim',winHModu,'XTick',winHModu,...
            'YLim',[0 ylimH], 'YTick', [0 ylimH], 'YTickLabel', {[], ylimH});
        else
        end;
        xlabel('Time (ms)','FontSize',fontS);
        ylabel('H(t)','FontSize',fontS);
        set(hModuBlue,'Box','off','TickDir','out','LineWidth',lineS,'FontSize',fontS);
        align_ylabel(hModuBlue)     
    end

    % Yello Modulation
    if  exist('xptModuYel','var') && ~isempty(xptModuYel) && ~isempty(xptModuYel)
        nYel = length(lightTime.Modu);
        winYel = [min(psthtimeModuYel) max(psthtimeModuYel)];

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
        yLimBarYel = ceil(max(psthModuYel(:))*1.05+0.0001);
        bar(250, 1000, 'BarWidth', 500, 'LineStyle', 'none', 'FaceColor', colorLightYellow);
        rectangle('Position', [0 yLimBarYel*0.925 500 yLimBarYel*0.075], 'LineStyle', 'none', 'FaceColor', colorYellow);
        hBarYel = bar(psthtimeModuYel, psthModuYel, 'histc');
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
        hMap(1) = axes('Position',axpt(nCol,nRowMain,1,2,[],wideInterval));
            hold on;
            pre_ratemap(pre_ratemap==0) = NaN;
            hField(1) = pcolor(pre_ratemap);
            peak = max(max(pre_ratemap))*sfreq(1);
            text(60, 10, [num2str(ceil(peak)), ' Hz'],'color','k','FontSize',fontM);
%             text(45.5, 34,'S12','FontSize',fontS); 
%             text(50, 31,'S1','FontSize',fontS);
%             text(54, 28,'S2','FontSize',fontS); 
%             text(57.5, 25,'S3','FontSize',fontS);
%             text(54, 22,'S4','FontSize',fontS);
%             text(50, 19,'S5','FontSize',fontS);
%             text(45.5, 16,'S6','FontSize',fontS);
%             text(41.5, 19,'S7','FontSize',fontS);
%             text(37.5, 22,'S8','FontSize',fontS);
%             text(35, 25,'S9','FontSize',fontS);
%             text(37.5, 28,'S10','FontSize',fontS);
%             text(41.5, 31,'S11','FontSize',fontS);
            
        hMap(2) = axes('Position',axpt(nCol,nRowMain,2,2,[],wideInterval));
            hold on;        
            stm_ratemap(stm_ratemap==0) = NaN;
            peak = max(max(stm_ratemap))*sfreq(1);          
            hField(2) = pcolor(stm_ratemap);
            text(60, 10, [num2str(ceil(peak)), ' Hz'],'color','k','FontSize',fontM);
            % Drawing arc
            if ~isempty(lightTime.Modu)
                hold on;
                arc_r = 20;
                x = arc_r*cos(arc)+45;
                y = arc_r*sin(arc)+25;
                if exist('xptModuBlue','var');
                plot(x,y,'LineWidth',5,'color',colorBlue);
                else exist('xptModuYel','var');
                plot(x,y,'LineWidth',5,'color',colorYellow);
                end
            else
            end;

        hMap(3) = axes('Position',axpt(nCol,nRowMain,3,2,[],wideInterval));
            hold on;
            post_ratemap(post_ratemap==0) = NaN;
            hField(3) = pcolor(post_ratemap);
            peak = max(max(post_ratemap))*sfreq(1);
            text(60, 10, [num2str(ceil(peak)), ' Hz'],'color','k','FontSize',fontM);
            
        set(hField,'linestyle','none');       
        set(hMap,'XLim',[15 75],'YLim',[5 45],'XTick',[5:5:45],'YTick',[5:5:45],'visible','off');

%         axes('Position',[startpoints(2,1) 0.15 0.8 0.1])
%             text(0.10,0.5,[num2str(ceil(max(max(pre_ratemap))*sfreq(1))), ' Hz'],'color','k','FontSize',10);
%             text(0.06,0.2,'Pre-Stimulation','FontSize',9);
%             text(0.32,0.51,[num2str(ceil(max(max(stm_ratemap))*sfreq(1))), ' Hz'],'color','k','FontSize',10);
%             rectangle('Position',[0.29, 0.10, 0.018, 0.18], 'EdgeColor','none','Facecolor',[0.2 0.6 1.0]);
%             text(0.31,0.2,': Stimulation','FontSize',9);
%             text(0.57,0.5,[num2str(ceil(max(max(post_ratemap))*sfreq(1))), ' Hz'],'color','k','FontSize',10);
%             text(0.525,0.2,'Post-Stimulation','FontSize',9);
%             set(gca,'XLim',[0 1],'YLim',[0 1]);
%             set(gca,'visible','off');

%         % Field size
%         load(matfile{ifile},'pre_field_info','stm_field_info','post_field_info');
%         pre_fieldsize = pre_field_info(1)/(72*48)*100;
%         stm_fieldsize = stm_field_info(1)/(72*48)*100;
%         post_fieldsize = post_field_info(1)/(72*48)*100;
%         load(matfile{ifile},'mean_fr',...
%             'pre_infos','stm_infos','post_infos')

        % Pearson's correlation
        hCorr = axes('Position',axpt(8,1,1:5,1,axpt(nCol,nRowMain,4,2,[],wideInterval),tightInterval));
        xptPcomp = 1:3;
        yptStim = compPearson_r(1:3);
        yptPost = compPearson_r(4:6);
        hold on;
        plot(xptPcomp,yptStim,...
            'Marker','o','MarkerSize',markerL,'MarkerFaceColor',colorRed,'MarkerEdgeColor','k','Color',colorRed);
        hold on;
        plot(xptPcomp,yptPost,...
            'Marker','s','MarkerSize',markerL,'MarkerFaceColor',colorBlue,'MarkerEdgeColor','k','Color',colorBlue);
        set(hCorr,'XLim',[0,4],'YLim',[-1.2 1.2],'XTick',1:3, 'XTickLabel',{'1','2','3'},'YTick',[-1:0.5:1],'FontSize',fontM,'LineWidth',lineS);
%         imagesc(pearson_r,[0 1]);
%             
%         hScale = axes('Position',axpt(8,1,5,1,axpt(nCol,nRowMain,4,2,[],wideInterval),tightInterval));
%         colorbar;
%         set(hScale,'visible','off','FontSize',fontM)
%         set(hCorr,'XTick',1:9,'XTicklabel',{'Pre1', 'Pre2', 'Pre3', 'Stm1', 'Stm2', 'Stm3', 'Post1', 'Post2', 'Post3'},'FontSize',fontM);
%         set(hCorr,'XAxisLocation','top','XTickLabelRotation',45);
%         set(hCorr,'YTick',1:9,'YTicklabel',{'Pre1', 'Pre2', 'Pre3', 'Stm1', 'Stm2', 'Stm3', 'Post1', 'Post2', 'Post3'},'FontSize',fontM);

       %% Sensor aligned
        for iSensor = 1:nSensor
            if rem(iSensor,4) == 0;
                xPositionIdx = 4;
            else
                xPositionIdx = rem(iSensor,4);
            end
            
            if ceil(iSensor/4) == 1;
                yPositionIdx = 3;
            elseif ceil(iSensor/4) == 2;
                yPositionIdx = 4;
            else ceil(iSensor/4) == 3;
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
            ylimpsth(iSensor) = ceil(max(psthconv.(fields{iSensor})(:))*1.1+0.0001);
            hold on;
            for iType = 1:3
                plot(psthtime.(fields{iSensor}),psthconv.(fields{iSensor})(iType,:),...
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
            set(hPsth(iSensor),'YLim',[0 ylimpsth(iSensor)]);
        end

               
%         hRaster(1) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRowMain,1,3,[],wideInterval),wideInterval));
%         hold on;
%         plot([xpt.(fields{1}){1} xpt.(fields{1}){2}, xpt.(fields{1}){3}],[ypt.(fields{1}){1}, ypt.(fields{1}){2}, ypt.(fields{1}){3}],...
%             'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');
%         rec(1) = rectangle('Position',[-0.99 31 2 30], 'LineStyle','none','FaceColor',lightDurationColor);
%         ylabel('Trial','FontSize',fontS);
%         title('Sensor1','FontSize',fontM);
%         hPsth(1) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRowMain,1,3,[],wideInterval),wideInterval));
%         ylimpsth(1) = ceil(max(psthconv.S1(:))*1.1+0.0001);
%         hold on;
%         for iType = 1:3
%             plot(psthtime.(fields{1}),psthconv.(fields{1})(iType,:),...
%             'LineStyle',':','LineWidth',lineM,'Color',lineColor{iType})
%         end
% 
%         hRaster(2) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRowMain,2,3,[],wideInterval),wideInterval));
%         rec(2) = rectangle('Position',[-0.99 31 2 30], 'LineStyle','none','FaceColor',lightDurationColor);
%         hold on;
%         plot([xpt.(fields{2}){1} xpt.(fields{2}){2}, xpt.(fields{2}){3}],[ypt.(fields{2}){1}, ypt.(fields{2}){2}, ypt.(fields{2}){3}],...
%             'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');
%         ylabel('Trial','FontSize',fontS);
%         title('Sensor2','FontSize',fontM);
%         hPsth(2) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRowMain,2,3,[],wideInterval),wideInterval));
%         hold on;
%         ylimpsth(2) = ceil(max(psthconv.S2(:))*1.1+0.0001);
%         for iType = 1:3
%             plot(psthtime.S2,psthconv.S2(iType,:),...
%             'LineStyle',':','LineWidth',lineM,'Color',lineColor{iType})
%         end
%         
%         hRaster(3) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRowMain,3,3,[],wideInterval),wideInterval));
%         rec(3) = rectangle('Position',[-0.99 31 2 30], 'LineStyle','none','FaceColor',lightDurationColor);
%         hold on;
%         plot([xpt.S3{1} xpt.S3{2}, xpt.S3{3}],[ypt.S3{1}, ypt.S3{2}, ypt.S3{3}],...
%             'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');
%         ylabel('Trial','FontSize',fontS);
%         title('Sensor4','FontSize',fontM);        
%         hPsth(3) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRowMain,3,3,[],wideInterval),wideInterval));
%         hold on;
%         ylimpsth(3) = ceil(max(psthconv.S3(:))*1.1+0.0001);
%         for iType = 1:3
%             plot(psthtime.S3, psthconv.S3(iType,:),...
%             'LineStyle',':','LineWidth',lineM,'Color',lineColor{iType});
%         end
% 
%         hRaster(4) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRowMain,4,3,[],wideInterval),wideInterval));
%         rec(4) = rectangle('Position',[-0.99 31 2 30], 'LineStyle','none','FaceColor',lightDurationColor);
%         hold on;
%         plot([xpt.S4{1} xpt.S4{2}, xpt.S4{3}],[ypt.S4{1}, ypt.S4{2}, ypt.S4{3}],...
%             'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');
%         ylabel('Trial','FontSize',fontS);
%         title('Sensor5','FontSize',fontM);        
%         hPsth(4) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRowMain,4,3,[],wideInterval),wideInterval));
%         hold on;
%         ylimpsth(4) = ceil(max(psthconv.S4(:))*1.1+0.0001);
%         for iType = 1:3
%             plot(psthtime.S4, psthconv.S4(iType,:),...
%             'LineStyle',':','LineWidth',lineM,'Color',lineColor{iType});
%         end
%         ylabel('Rate (Hz)','FontSize',fontS);
% 
%         hRaster(5) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRowMain,1,4,[],wideInterval),wideInterval));
%         rec(5) = rectangle('Position',[-0.99 31 2 30], 'LineStyle','none','FaceColor',lightDurationColor);
%         hold on;
%         plot([xpt.S5{1} xpt.S5{2}, xpt.S5{3}],[ypt.S5{1}, ypt.S5{2}, ypt.S5{3}],...
%             'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');
%         ylabel('Trial','FontSize',fontS);
%         title('Sensor7','FontSize',fontM);        
%         hPsth(5) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRowMain,1,4,[],wideInterval),wideInterval));
%         hold on;
%         ylimpsth(5) = ceil(max(psthconv.S5(:))*1.1+0.0001);
%         for iType = 1:3
%             plot(psthtime.S5, psthconv.S5(iType,:),...
%             'LineStyle',':','LineWidth',lineM,'Color',lineColor{iType});
%         end
%         ylabel('Rate (Hz)','FontSize',fontS);
% 
%         hRaster(6) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRowMain,2,4,[],wideInterval),wideInterval));
%         rec(6) = rectangle('Position',[-0.99 31 2 30], 'LineStyle','none','FaceColor',lightDurationColor);
%         hold on;
%         plot([xpt.S6{1} xpt.S6{2}, xpt.S6{3}],[ypt.S6{1}, ypt.S6{2}, ypt.S6{3}],...
%             'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');
%         ylabel('Trial','FontSize',fontS);
%         title('Sensor8 & Light','FontSize',fontM);        
%         hPsth(6) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRowMain,2,4,[],wideInterval),wideInterval));
%         hold on;
%         ylimpsth(6) = ceil(max(psthconv.S6(:))*1.1+0.0001);
%         for iType = 1:3
%             plot(psthtime.S6, psthconv.S6(iType,:),...
%             'LineStyle',':','LineWidth',lineM,'Color',lineColor{iType});    
%         end
%         ylabel('Rate (Hz)','FontSize',fontS);
% 
%         hRaster(7) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRowMain,3,4,[],wideInterval),wideInterval));
%         rec(7) = rectangle('Position',[-0.99 31 2 30], 'LineStyle','none','FaceColor',lightDurationColor);
%         hold on;
%         plot([xpt.S7{1} xpt.S7{2}, xpt.S7{3}],[ypt.S7{1}, ypt.S7{2}, ypt.S7{3}],...
%             'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');
%         ylabel('Trial','FontSize',fontS);
%         title('Sensor10','FontSize',fontM);        
%         hPsth(7) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRowMain,3,4,[],wideInterval),wideInterval));
%         hold on;
%         ylimpsth(7) = ceil(max(psthconv.S7(:))*1.1+0.0001);
%         for iType = 1:3
%             plot(psthtime.S7, psthconv.S7(iType,:),...
%             'LineStyle',':','LineWidth',lineM,'Color',lineColor{iType});    
%         end
%         ylabel('Rate (Hz)','FontSize',fontS);
% 
%         hRaster(8) = axes('Position',axpt(1,2,1,1,axpt(nCol,nRowMain,4,4,[],wideInterval),wideInterval));
%         rec(8) = rectangle('Position',[-0.99 31 2 30], 'LineStyle','none','FaceColor',lightDurationColor);
%         hold on;
%         plot([xpt.S8{1} xpt.S8{2}, xpt.S8{3}],[ypt.S8{1}, ypt.S8{2}, ypt.S8{3}],...
%             'Marker','.','MarkerSize',markerS,'LineStyle','none','Color','k');   
%         ylabel('Trial','FontSize',fontS);
%         title('Sensor11','FontSize',fontM);
%         hPsth(8) = axes('Position',axpt(1,2,1,2,axpt(nCol,nRowMain,4,4,[],wideInterval),wideInterval));
%         hold on;
%         ylimpsth(8) = ceil(max(psthconv.S8(:))*1.1+0.0001);
%         for iType = 1:3
%             plot(psthtime.S8, psthconv.S8(iType,:),...
%             'LineStyle',':','LineWidth',lineM,'Color',lineColor{iType});
%         end
%         ylabel('Rate (Hz)','FontSize',fontS);
% 
%         set(hRaster, 'Box', 'off', 'TickDir', 'out', 'LineWidth', lineS, 'FontSize', fontS, ...
%             'XLim',[-1, 1],'XTick',[],'YLim',[0 90],'YTick',[0:30:90]);
%         uistack(rec(1),'bottom')
%         
%         set(hPsth, 'Box', 'off', 'TickDir', 'out', 'LineWidth', lineS, 'FontSize', fontS, ...
%             'XLim',[-1, 1],'XTick',[-1:0.2:1]);
%         
%         for iPsth = 1:size(hPsth)
%             set(hPsth(iPsth),'YLim',[0 ylimpsth(iPsth)]);
%         end
%         
        print(gcf,'-dtiff','-r300',[cellFigName{1},'.tif']);
        close;
end
cd(rtdir);


