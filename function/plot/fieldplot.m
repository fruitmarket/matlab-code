%% mat-file collect
[matfile, nfile] = matfilecollector;

load('Events.mat','lighttime','lighttrain');
ntrial = length(lighttime)/lighttrain;
sfreq = [30 60]; %sampling frequence. A New version of Cheetah use 30Hz

%% Variables
win = [-10 40];
arc = linspace(pi/6*5,pi/6*7,200); % Optic stimulation position indicator

%% Paper properties
% set(gcf,'PaperType','a4','PaperUnit','centimeter','PaperPosition',[0.6345 2 18 24]);
full_axis = [0.1 0.09 0.85 0.85];
ytop = sum(full_axis([2,4]));
figwidth = [0.25];
figheight = [0.25 0.3 0.35 0.40 0.45 0.50 0.6 0.7];
interval_x = 0.04; interval_y = 0.005;
interfig_y = 0.05;
pannelheight = [0.008];
wfwidth = [0 figwidth(1)/2+0.01 0 figwidth(1)/2+0.01];
wfheight = [figheight(1)/2+0.01 figheight(1)/2+0.01 0 0];

startpoints = [0.1, 0.50, 0.09+figwidth+interval_x, 0.50, 0.09+(figwidth+interval_x)*2, 0.50;... % First raw
               0.1, 0.2,  0.09+figwidth+interval_x, 0.2,  0.09+(figwidth+interval_x)*2, 0.2];    % Second raw

%% Plot properties
lineclr = {[1 0 0], [1 0.5 0.5], [1 0.3 0.3]...
    [0 0 1], [0.5 0.5 1], [0.3 0.3 1]};

linewth = [0.75 0.5 0.5 0.75 0.5 0.5];

%% Analysis
for ifile = 1:nfile
    [cellpath,cellname,~] = fileparts(matfile{ifile});
    cd(cellpath);
    laser_width_idx = strfind(cellpath,'h');
    laser_width = cellpath(laser_width_idx+1:laser_width_idx+2);
    laser_width = str2double(laser_width);
    
    pathparts = strsplit(cellpath,'\');
    nameparts = strsplit(pathparts{end},'_');
    date = nameparts{1};
    
    load(matfile{ifile},...
        'xptlight','yptlight','bintag','lighthist',...
        'burst_pre','burst_stm','burst_post',...
        'burst_portion','total_burst_trial','burst_trial');
    ylims = ceil(max(lighthist));
    if ylims == 0;
        ylims = 20;
    end
    
    %% Raster plot   
    axes('Position',[startpoints(1,1) startpoints(1,2)+0.02 figwidth(1)-0.02 figheight(1)/2]);
        hold on;
        plot(xptlight,yptlight,...
                'Marker','.','MarkerSize',1,'Color','k','LineWidth',1);
        
        h1 = rectangle('Position',[0, 0, laser_width, ntrial],'EdgeColor','None','FaceColor',[0.2 0.6 1.0]);
        uistack(h1,'bottom');
        
        set(gca,'XLim',win,'XTick',[-10 0 10 20 40],'XColor','k');
        set(gca,'YLim',[0 ntrial],'YTick',[0 ntrial],'YTickLabel',{[],ntrial},'YColor','k');
        set(gca,'box','off','TickDir','out','FontSize',10);
        ylabel('Trials');
    
    %% Histogram
    axes('Position',[startpoints(1,1) startpoints(1,2)+figheight(1)*3/4+interval_y+0.02 figwidth(1)-0.02 figheight(1)/2]);
        hold on;
        h = bar(bintag,lighthist,'histc');
%         plot(bintag(1:end-1)+0.5,mhist(1:end-1),...
%             'LineStyle','-','LineWidth',1,'Color',[1 0.5 0.5]);
%         plot(bintag(1:end-1)+0.5,shist(1,1:end-1),...
%             'LineStyle','-','LineWidth',0.5,'Color',[1 0.75 0.75]);
%         plot(bintag(1:end-1)+0.5,shist(2,1:end-1),...
%             'LineStyle','-','LineWidth',0.5,'Color',[1 0.75 0.75]);
        set(h,'FaceColor','k','EdgeAlpha',0);
        set(gca,'XLim',win,'XTick',[-10, 0 10 20 40]);
        set(gca,'YLim',[0 ylims],'YTick',[0 ylims],'YColor','k');
        set(gca,'Box','off','TickDir','out','FontSize',10);
        ylabel('Spikes s^-^1');
      
    %% PSTH
%     axes('Position',axpt(1,2,2,:));
%         hold on;
%         h1 = bar(lightbins,extplot,'histc');
%         h2 = bar(lightbins,inhplot,'histc');
%         h3 = bar(lightbins,baseplot,'histc');
%         hpeak = max([extplot(1:end-1) inhplot(1:end-1) baseplot(1:end-1)']);
%         if pvalueext <= 0.01; text(basebinrange*0.4,hpeak*1.2,['p Value for maximal excitation after ',num2str(extslide-1),' ms = ',num2str(pvalueext,'%.1e')]); end;
%         if pvalueinh <= 0.01; text(basebinrange*0.4,hpeak*1.05,['p Value for maximal inhibition after ',num2str(inhslide-1),' ms = ',num2str(pvalueinh,'%.1e')]); end;
%         set(h1,'FaceColor',[0 0.66 1],'FaceAlpha',1,'EdgeAlpha',0);
%         set(h2,'FaceColor',[1 0.78 0],'FaceAlpha',0.5,'EdgeAlpha',0);
%         set(h3,'FaceColor',[0 0 0],'FaceAlpha',0.5,'EdgeAlpha',0);
%         xlabel('Time (ms)');
%         set(gca,'XLim',[0 basebinrange-1]);
%         set(gca,'box','off','TickDir','out','FontSize',10);

    %% Peri sensor time histogram
    
    %% Waveform
     load(matfile{ifile},'spkwv','spkwth','spkpvr');
     ylims3 = [min(spkwv(:)) max(spkwv(:))];
    
    for ich = 1:4
        axes('Position',[startpoints(1,3)+wfwidth(ich) startpoints(1,4)*8/7+wfheight(ich) figwidth(1)/2 figheight(1)/2]);
        plot(spkwv(ich,:),'LineStyle','-','LineWidth',0.4,'Color',[0.2 0.2 0.2]);
        
        set(gca,'XLim',[1 32]);
        set(gca,'YLim',ylims3);
        set(gca,'visible','off');
        if ich==4
            line([24 32],[ylims3(2)-50 ylims3(2)-50],'color','k','LineWidth',0.2); 
            line([24 24],[ylims3(2)-50 ylims3(2)],'color','k','LineWidth',0.2);
        end
    end
         axes('Position',[startpoints(1,3) startpoints(1,4) figheight(1)/4 figwidth(1)]); %wf information
         hold on;
         text(0,0.2,['Peak valley ratio: ',num2str(spkpvr,3),],'FontSize',8,'interpreter','none');
         text(0,0.1,['Spike width: ',num2str(spkwth,3),],'FontSize',8,'interpreter','none');
         set(gca,'visible','off');
         
    %% Heat map
    load(matfile{ifile},'pre_ratemap','stm_ratemap','post_ratemap');
    axes('Position',[startpoints(2,1) startpoints(2,2) figwidth(1) figheight(1)*3/2])
        hold on;
        zero_position = find(pre_ratemap==0);
        pre_ratemap(zero_position) = NaN;
        h1 = pcolor(pre_ratemap);
        peak = max(max(pre_ratemap))*sfreq(1);
        set(h1,'linestyle','none');
        set(gca,'visible','off')

    axes('Position',[startpoints(2,1)+figwidth(1)*3/4 startpoints(2,4) figwidth(1) figheight(1)*3/2])
        hold on;        
        zero_position = find(stm_ratemap==0);
        stm_ratemap(zero_position) = NaN;
        h1 = pcolor(stm_ratemap);
        peak = max(max(stm_ratemap))*sfreq(1);
        set(h1,'linestyle','none');
    
    % Drawing arc
        hold on;
        arc_r = 15;
        x = arc_r*cos(arc)+22;
        y = arc_r*sin(arc)+26;
        plot(x,y,'LineWidth',5,'color',[0.2 0.6 1.0]);
        set(gca,'visible','off')
                      
    axes('Position',[startpoints(2,1)+figwidth(1)*3/2 startpoints(2,6) figwidth(1) figheight(1)*3/2])
        hold on;
        zero_position = find(post_ratemap==0);        
        post_ratemap(zero_position) = NaN;
        h1 = pcolor(post_ratemap);
        peak = max(max(post_ratemap))*sfreq(1);
        set(h1,'linestyle','none');
        set(gca,'visible','off')
    
    axes('Position',[startpoints(2,1) 0.15 0.8 0.1])
        text(0.10,0.5,[num2str(ceil(max(max(pre_ratemap))*sfreq(1))), ' Hz'],'color','k','FontSize',10);
        text(0.06,0.2,'Pre-Stimulation','FontSize',9);
        text(0.32,0.51,[num2str(ceil(max(max(stm_ratemap))*sfreq(1))), ' Hz'],'color','k','FontSize',10);
        rectangle('Position',[0.29, 0.10, 0.018, 0.18], 'EdgeColor','none','Facecolor',[0.2 0.6 1.0]);
        text(0.31,0.2,': Stimulation','FontSize',9);
        text(0.57,0.5,[num2str(ceil(max(max(post_ratemap))*sfreq(1))), ' Hz'],'color','k','FontSize',10);
        text(0.525,0.2,'Post-Stimulation','FontSize',9);
        set(gca,'XLim',[0 1],'YLim',[0 1]);
        set(gca,'visible','off');
        
%     % Detection ratio calculation
%     load(matfile{ifile},'pre_flags','stm_flags','post_flags');
%     detec_ratio = [pre_flags(1)/pre_flags(2), stm_flags(1)/stm_flags(2), post_flags(1)/post_flags(2)];
%     mean_detec_ratio = mean(detec_ratio)*100;
    
    % Field size
    load(matfile{ifile},'pre_field_info','stm_field_info','post_field_info');
    pre_fieldsize = pre_field_info(1)/(72*48)*100;
    stm_fieldsize = stm_field_info(1)/(72*48)*100;
    post_fieldsize = post_field_info(1)/(72*48)*100;
    load(matfile{ifile},'mean_fr',...
        'pre_infos','stm_infos','post_infos')
    
    %% Pearson's correlation
	load(matfile{ifile},'pearson_r');
    axes('Position',[startpoints(2,1)+figwidth(1)*9/4+0.05 startpoints(2,6)+0.02 figwidth(1)/2 figheight(1)*3/4])
    imagesc(pearson_r,[0 1]);
    
    set(gca,'XTick',1:6,'XTicklabel',{'Pre1', 'Pre2', 'Stm1', 'Stm2', 'Post1', 'Post2'},'FontSize',7);
    set(gca,'XAxisLocation','top','XTickLabelRotation',45);
    set(gca,'YTick',1:6,'YTicklabel',{'Pre1', 'Pre2', 'Stm1', 'Stm2', 'Post1', 'Post2'},'FontSize',8);
    
    axes('Position',[startpoints(2,1)+figwidth(1)*11/4+0.01 startpoints(2,6)+0.02 figwidth(1)/2 figheight(1)*3/4])
    colorbar;
%     set(gca,'CLim',[0 1]);
    set(gca,'visible','off');
    
    %% Text info
    axes('Position',[startpoints(1,5) startpoints(1,6)-0.1 figwidth(1) figheight(5)])
    hold on;
        text(0,1, ['Pre burst #: ',num2str(burst_pre)],'FontSize',10,'interpreter','none');
        text(0,0.95, ['Stm burst #: ',num2str(burst_stm)],'FontSize',10,'interpreter','none');
        text(0,0.90, ['Post burst #: ',num2str(burst_post)],'FontSize',10,'interpreter','none');
        text(0,0.80, ['Base mean FR: ',num2str(mean_fr(1),3), ' Hz'], 'FontSize',10,'interpreter','none');
        text(0,0.75, ['Pre-mean FR: ',num2str(mean_fr(2),3), ' Hz'],'FontSize',10,'interpreter','none');
        text(0,0.70, ['Stm-mean FR: ',num2str(mean_fr(3),3), ' Hz'],'FontSize',10,'interpreter','none');
        text(0,0.65, ['Post-mean FR: ',num2str(mean_fr(4),3), ' Hz'],'FontSize',10,'interpreter','none');
        text(0,0.40, ['Pre-field info: ',num2str(pre_infos(1),3)],'FontSize',10,'interpreter','none');
        text(0,0.35, ['Stm-field info: ',num2str(stm_infos(1),3)],'FontSize',10,'interpreter','none');
        text(0,0.30, ['Post-field info: ',num2str(post_infos(1),3)],'FontSize',10,'interpreter','none');
%         text(0,0.10, ['Mean detection ratio: ',num2str(mean_detec_ratio,3), ' %'],'FontSize',10,'interpreter','none');
        set(gca, 'visible','off')
   
    axes('Position',[0.05 0.85 0.5 0.1])
    hold on;
    text(0,0.5, [pathparts{3},'\',pathparts{4},'\',cellname],'FontSize',7,'interpreter','none')
    set(gca,'visible','off')
    %% Save pictures
    print(gcf,'-dtiff','-r300',[date,'_',cellname]);
    close all;
end
% clear all;

