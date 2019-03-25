clearvars; clc; close all;

load('D:\heejeong\OneDrive\classical_conditioning\data\cellTable_ChR.mat');
dirList = unique(cellfun(@fileparts,T.cellList,'UniformOutput',false));
dirList = cellfun(@(x) regexprep(x,'D:\\heejeong\\OneDrive\\classical_conditioning\\data\\',...
    'D:\\heejeong\\Documents\\Cheetah_data\\Classical_conditioning\\Interneuron_tagging\\'),...
    dirList,'UniformOutput',false);
nDir = length(dirList);
Fs = 2000;
Nyquist = Fs/2;

d = designfilt('bandstopiir','FilterOrder',2, ...
               'HalfPowerFrequency1',59,'HalfPowerFrequency2',61, ...
               'DesignMethod','butter','SampleRate',Fs);

[lfp_ave,spec_ave,rel_ave] = deal(cell(nDir,4));
lfp_diff = cell(nDir,3);

titleList = {'Rw';'noRw';'Pn';'noPn'};
diffList = {'CueA-CueB';'Rw-noRw';'Pn-noPn'};
epochList = {'Baseline';'Cue';'Delay';'Outcome'};

time = -1000:0.5:4000;

for iD = 1:nDir
    try
    close all;
    cd(dirList{iD});
    load('Events.mat','cue');
    if sum(cue==4)==0
        continue; end
    cscList = FindFiles('*.ncs');
    for i = 1:8
        ttLength(i) = length(FindFiles(['TT',num2str(i),'*.mat']));
    end
    [~,ind] = find(ttLength==max(ttLength));
    if length(ind)>1
        ind = randsample(ind,1);
    end
    [rowtimeStamp, sample] = Nlx2MatCSC(cscList{ind},[1 0 0 0 1],0,1,[]);
    timeBin = (rowtimeStamp(2)-rowtimeStamp(1))/512;
    addtimeStamp = [0:timeBin:timeBin*511]';
    addtimeStamp = repmat(addtimeStamp,1,length(sample(1,:)));
    timeStamp = repmat(rowtimeStamp,512,1)+addtimeStamp;
    sample = sample(:);
    timeStamp = timeStamp(:)/1000;
    load('Events.mat','taskTime','eventTime','cue','reward','punishment','nTrial');
    
    lfpPower = NaN(nTrial,length(time),20);
    for iTrial = 1:nTrial
        inTrial = timeStamp>(eventTime(iTrial,2)-1500) & timeStamp<(eventTime(iTrial,2)+4500); %[-1 4]s from cue onset
        lfp_tmp = sample(inTrial);
        time_tmp = timeStamp(inTrial)-eventTime(iTrial,2);
        [~,zeroInd] = min(abs(time_tmp));
        time_tmp = time_tmp-(time_tmp(zeroInd)-0);  
        time_tmp = round(time_tmp*10)/10;
        
        lfp{iTrial,1} = lfp_tmp(time_tmp>=-1000 & time_tmp<=4000);
        
        lfp_filter{iTrial,1} = filtfilt(d,lfp{iTrial});
        
        for iF = 1:20
            lowcut = 1+5*(iF-1);
            highcut = 5+5*(iF-1);
            [b,a] = butter(2,[lowcut highcut]/Nyquist,'bandpass');
            fLFP = filter(b,a,lfp_filter{iTrial});
            x = hilbert(fLFP);
            lfpPower(iTrial,:,iF) = abs(x);
            xData(iF) = nanmean([1+5*(iF-1), 5+5*(iF-1)]);
        end
    end
    totalPower = trapz(xData,nansum(squeeze(nanmean(lfpPower,1))));
    lfpPower_rel = lfpPower/totalPower;
%     
    raw= cell2mat(lfp_filter')';
    fHandle = figure('PaperUnits','Centimeters','PaperPosition',[2 2 8 3]);
    plot(time,nanmean(raw(cue==1&reward==1,:)),'b','LineWidth',0.5)
    hold on;
    plot(time,nanmean(raw(cue==1&reward==0,:)),'b:','LineWidth',0.5)
    plot(time,nanmean(raw(cue==4&punishment==1,:)),'r','LineWidth',0.5)
    plot(time,nanmean(raw(cue==4&punishment==0,:)),'r:','LineWidth',0.5)
    plot([0 0 NaN 1000 1000 NaN 2000 2000],[-3 3 NaN -3 3 NaN -3 3]*10^4,'k:')
    set(gca,'Box','off','TickDir','out','FontSize',5,'LineWidth',0.35,...
        'XTick',-1000:1000:4000,'XTickLabel',-1:1:4,'YTick',[-3 0 3]*10^(4));
    ylabel('LFP','FontSize',5);
    xlabel('Time from trial onset (s)','FontSize',5)
    xlim([-1000 4000])
    ylim([-3 3]*10^4)
    print(fHandle,'-dtiff','-r600',['D:\heejeong\OneDrive\Research\DataFig\CC-IN-ChR\lfp\example_lfp_trace_',num2str(iD),'.tif']);

    
    trialInd = [cue==1&reward==1 cue==1&reward==0 cue==4&punishment==1 cue==4&punishment==0];
    fHandle = figure('PaperUnits','Centimeters','PaperPosition',[2 2 9.5 10]);
    for i = 1:4
        subplot(4,1,i)
        rel_ave{iD,i} = squeeze(nanmean(lfpPower_rel(trialInd(:,i),:,:)));
        imagesc(time,xData,rel_ave{iD,i}');
        axis xy
        set(gca,'CLim',[0 0.000005],'Box','off','TickDir','out','FontSize',5,...
            'LineWidth',0.35,'XTick',-1000:1000:4000,'XTickLabel',-1:1:4,...
            'YTick',0:20:100);
        hold on;
       plot([0 0 NaN 1000 1000 NaN 2000 2000],[0 100 NaN 0 100 NaN 0 100],'k:',...
           'LineWidth',0.35);
       if i==4
           set(gca,'XTickLabel',-1:1:4)
           xlabel('Time from trial onset (s)','FontSize',5);
       else
           set(gca,'XTickLabel',[]);
       end
       ylabel({titleList{i};'';'Frequency (Hz)'},'FontSize',5);
    end   
     print(fHandle,'-dtiff','-r600',['D:\heejeong\OneDrive\Research\DataFig\CC-IN-ChR\lfp\example_spectrogram_',num2str(iD),'.tif']);
    diffInd = [1 3; 1 2; 3 4];
    for i = 1:3
        lfp_diff{iD,i} = rel_ave{iD,diffInd(i,1)}-rel_ave{iD,diffInd(i,2)};
    end
    catch
        dirList{iD}
    end
end

jD = 0;
for iD = 1:nDir
    if isempty(rel_ave{iD,1})
        continue;
    end
    jD = jD+1;
    avePower{1}(jD,:,:) = rel_ave{iD,1};
    avePower{2}(jD,:,:) = rel_ave{iD,2};
    avePower{3}(jD,:,:) = rel_ave{iD,3};
    avePower{4}(jD,:,:) = rel_ave{iD,4};
end

epoch{1} = time>=-1000 & time<0;
epoch{2} = time>=0 & time<1000;
epoch{3} = time>=1000 & time<2000;
epoch{4} = time>=2000 & time<3000;

nEpoch = length(epoch);

plotstyle = {'b';'b:';'r';'r:'};
face = {'b';'none';'r';'none'};
edge = {'b';'b';'r';'r'};
frequency{1} = xData>=5 & xData<=10;
frequency{2} = xData>=12 & xData<=24;
frequency{3} = xData>=30 & xData<=40;
frequency{4} = xData>=60 & xData<=80;



fHandle = figure('PaperUnits','Centimeters','PaperPosition',[2 2 9.5 10]);
for iE = 1:nEpoch
    subplot(nEpoch,8,(iE-1)*8+1:(iE-1)*8+4)
    hold on;
    for iO = 1:4
        data = squeeze(nanmean(avePower{iO}(:,epoch{iE},:),2));
        m(iO,:) = nanmean(data,1);
        s(iO,:) = nanstd(data,[],1)/sqrt(size(data,1));
        plot(xData,log10(m(iO,:)+s(iO,:)),plotstyle{iO});
        plot(xData,log10(m(iO,:)-s(iO,:)),plotstyle{iO});
    end
    ylim([-6.5 -5]);
    xlim([0 100]);
    set(gca,'Box','off','TickDir','out','FontSize',5,'LineWidth',0.35);  
    ylabel({epochList{iE};''; 'Relative power (log_1_0)'},'FontSize',5);
    
    
    data = [];
    for iF = 1:4
        subplot(nEpoch,8,(iE-1)*8+6:iE*8)
        for iO = 1:4
            data_tmp = avePower{iO}(:,epoch{iE},frequency{iF});
            if length(size(data_tmp))<3
                data(:,iO) = nanmean(data_tmp,2);
            else
                data(:,iO) = nanmean(nanmean(data_tmp,3),2);
            end
            mD(iF,iO) = nanmean(data(:,iO));
            sD(iF,iO) = nanstd(data(:,iO))/sqrt(length(data(:,iO)));
        end
        x = repmat([1 2 3 4],size(data,1),1);
        [p(iE,iF),table,stats] = anova1(data(:),x(:),'off');
        c{iE,iF} = multcompare(stats,'display','off');
    end
    
    for iO = 1:4
        h = bar([0:2.5:7.5]+0.5*(iO-1),mD(:,iO),0.15,'FaceColor',face{iO},'EdgeColor',edge{iO});
        hold on;
        errorbar([0:2.5:7.5]+0.5*(iO-1),mD(:,iO),sD(:,iO),'LineStyle','none','Color',edge{iO},'LineWidth',0.35);
    end
    if iE==2
        text([0.75 0.75+2.5],repmat(3.6*10^(-6),1,2),'*','FontSize',5);
    elseif iE>2
        text(0.75:2.5:8.25,repmat(3.6*10^(-6),1,4),'*','FontSize',5);
    end
    set(gca,'Box','off','TickDir','out','FontSize',5,'LineWidth',0.35,...
        'YTick',[0 2 4]*10^(-6),'XTick',0.75:2.5:8.25);
    ylim([0 4]*10^(-6));
    xlim([-1 10]);
    ylabel('Relative power','FontSize',5);
    if iE==4
        set(gca,'XTickLabel',{'5-10';'12-24';'30-40';'60-80'});
        xlabel('Frequency (Hz)','FontSize',5);
    else
        set(gca,'XTickLabel',[]);
    end
end
print(fHandle,'-dtiff','-r600','D:\heejeong\OneDrive\Research\DataFig\CC-IN-ChR\lfp\mean_rel_power.tif');

diff = [1,3;1,2;3,4];
titleList = {'CueA-CueB';'Rw-noRw';'Pn-noPn'};
fHandle = figure('PaperUnits','Centimeters','PaperPosition',[2 2 6 6]);
for i = 1:3
   subplot(3,1,i)
   diffData = squeeze(nanmean(avePower{diff(i,1)}-avePower{diff(i,2)},1));
   imagesc(time,xData,diffData');
   hold on;
   plot([0 0 NaN 1000 1000 NaN 2000 2000],[0 100 NaN 0 100 NaN 0 100],...
       'k:','LineWidth',0.35);
   axis xy
   set(gca,'CLim',[-1/2*10^(-6) 1/2*10^(-6)],'XTick',-1000:1000:4000,'YTick',0:20:100,...
       'Box','off','TickDir','out','FontSize',5,'XLim',[-1000 4000],'YLim',[0 100]);
   title(titleList{i},'FontSize',5);
   ylabel('Frequency (Hz)','FontSize',5);
   if i==3
       set(gca,'XTickLabel',-1:1:4)
       xlabel('Time from trial onset (s)','FontSize',5);
   else
       set(gca,'XTickLabel',[]);
   end
end
print(fHandle,'-dtiff','-r600','D:\heejeong\OneDrive\Research\DataFig\CC-IN-ChR\lfp\diff_spectogram.tif');

titleList = {'Rw';'noRw';'Pn';'noPn'};
fHandle = figure('PaperUnits','Centimeters','PaperPosition',[2 2 6 8]);
for i = 1:4
   subplot(4,1,i)
   data = squeeze(nanmean(avePower{i},1));
   imagesc(time,xData,data');
   hold on;
   plot([0 0 NaN 1000 1000 NaN 2000 2000],[0 100 NaN 0 100 NaN 0 100],...
       'k:','LineWidth',0.35);
   axis xy
   set(gca,'CLim',[0 4/7*10^(-5)],'XTick',-1000:1000:4000,'YTick',0:20:100,...
       'Box','off','TickDir','out','FontSize',5,'XLim',[-1000 4000],'YLim',[0 100]);
   title(titleList{i},'FontSize',5);
   ylabel('Frequency (Hz)','FontSize',5);
   if i==4
       set(gca,'XTickLabel',-1:1:4)
       xlabel('Time from trial onset (s)','FontSize',5);
   else
       set(gca,'XTickLabel',[]);
   end
end
print(fHandle,'-dtiff','-r600','D:\heejeong\OneDrive\Research\DataFig\CC-IN-ChR\lfp\spectogram.tif');
