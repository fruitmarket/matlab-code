%% mat-file collect
[matfile, nfile] = matfilecollector;

win = [-200 500];
load('Events.mat','lighttime','lighttrain');
ntrial = 60;
sfreq = [30 60]; %sampling frequence. A New version of Cheetah use 30Hz

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
               0.1, 0.05,  0.09+figwidth+interval_x, 0.05,  0.09+(figwidth+interval_x)*2, 0.05];    % Second raw

%% Plot properties
lineclr = {[1 0 0], [1 0.5 0.5], [1 0.3 0.3]...
    [0 0 1], [0.5 0.5 1], [0.3 0.3 1]};

linewth = [0.75 0.5 0.5 0.75 0.5 0.5];

%% Analysis
for ifile = 1:nfile
    [cellpath,cellname,~] = fileparts(matfile{ifile});
    cd(cellpath);
    
    load(matfile{ifile},'xpt','ypt','spkhist_temp');
    ylims = ceil(max(spkhist_temp));
%     if ylims == 0;
%         ylims = 20;
%     end
    
    %% Peri sensor time histogram
    axes('Position', [startpoints(1,1) startpoints(1,2) figwidth(1)-0.02 figheight(1)/2]);
    hold on;
    plot(xpt{3},ypt{3},...
        'Marker','.','MarkerSize',1,'Color','k','LineWidth',1);
    
    set(gca,'XLim',win,'XTick',[-200 0 200 400],'color','w');
    set(gca,'YLim',[0 ntrial],'YTick',[0 ntrial],'YTickLabel',{[],ntrial},'YColor','k');
    set(gca,'box','off','TickDir','out','FontSize',10);
    ylabel('Trials');
    
    print(gcf,'-dtiff','-r300',[cellname,'_tag']);
    close all;
end
clear all;