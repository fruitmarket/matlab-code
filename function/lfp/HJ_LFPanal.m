% load lfp data from ncs file

load('D:\heejeong\OneDrive\classical_conditioning\data\cellTable_ChR.mat');
dirList = unique(cellfun(@fileparts,T.cellList,'UniformOutput',false));
dirList = cellfun(@(x) regexprep(x,'D:\\heejeong\\OneDrive\\classical_conditioning\\data\\',...
    'D:\\heejeong\\Documents\\Cheetah_data\\Classical_conditioning\\Interneuron_tagging\\'),...
    dirList,'UniformOutput',false);
nDir = length(dirList);
for iD = 1:nDir
    try
    cd(dirList{iD});
    cscList = FindFiles('*.ncs');
    nC = length(cscList);
    cscName = cell(nC,1);
    cscIndex = false(nC,1);
    for iC = 1:nC
        [~,name] = fileparts(cscList{iC});
        cscIndex(iC,1) = length(name)==4;
        cscName{iC} = name;
    end
    cscList = cscList(cscIndex);
    cscName = cscName(cscIndex);
    nC = length(cscList);
    movingwin = [0.5, 0.1];
    params.fpass = [18 100];
    params.trialave = 0;
    params.err = 0;
    params.Fs = 2000;
    params.tapers = [5 9];
    
    for i = 1:8
        ttLength(i) = length(FindFiles(['TT',num2str(i),'*.mat']));
    end
    [~,ind] = find(ttLength==max(ttLength));
    if length(ind)>1
        ind = randsample(ind,1);
    end
    
    iC = ind;
        
        [rowtimeStamp, fs, sample] = Nlx2MatCSC(cscList{iC},[1 0 1 0 1],0,1,[]);
        sampleF = nanmean(fs);
        timeBin = (rowtimeStamp(2)-rowtimeStamp(1))/512;
        addtimeStamp = [0:timeBin:timeBin*511]';
        addtimeStamp = repmat(addtimeStamp,1,length(sample(1,:)));
        timeStamp = repmat(rowtimeStamp,512,1)+addtimeStamp;
        sample = sample(:);
        timeStamp = timeStamp(:)/1000;
        
        % filt_sample = filt_LFP(sample,0.1,100);
        
        load('Events.mat','taskTime','eventTime','cue','reward','punishment','nTrial');
        if sum(cue==4)==0
            continue; end
        cueIndex = [cue==1 cue==2 cue==3 cue==4];
        trialIndex = [cue==1&reward==1 cue==1&reward==0 cue==4&punishment==1 cue==4&punishment==0];
        inTask = timeStamp>taskTime(1) & timeStamp<taskTime(2);
        sample = sample(inTask);
        timeStamp = timeStamp(inTask);
        
        timebin = -1000:0.5:4000;
        
        for iTrial = 1:nTrial
            inTrial = timeStamp>(eventTime(iTrial,2)-1000) & timeStamp<(eventTime(iTrial,2)+4000); %[-1 4]s from cue onset
            lfp{iTrial,1} = sample(inTrial);
            lfptime{iTrial,1} = timeStamp(inTrial)-eventTime(iTrial,2);
        end
        
        % interp_lfp = cell2mat(cellfun(@(x,y) interp1(x,y,timebin,'spline'),lfptime,lfp,'UniformOutput',false));
        interp_lfp = cell2mat(cellfun(@(x,y) interp1(x,y,timebin),lfptime,lfp,'UniformOutput',false));
        interp_lfp = interp_lfp(:,2:end-1)';
        time_lfp = timebin(2:end-1);
        
        data = interp_lfp(time_lfp>=-1000 & time_lfp<=5000,:);
        [S,t,f] = mtspecgramc(data,movingwin,params);
        
%         maxS = max(squeeze(max(S,[],1)),[],1);
%         for iTrial = 1:nTrial
%             S_norm(:,:,iTrial) = S(:,:,iTrial)/maxS(iTrial);
%         end
        
        time = time_lfp(time_lfp>=-1000 &time_lfp<=5000);
        
        fHandle = figure('PaperUnits','Centimeters','PaperPosition',[2 2 8 8]);
        subplot(3,1,1)
        diffS = nanmean(S(:,:,cueIndex(:,1)),3)'-nanmean(S(:,:,cueIndex(:,4)),3)';
        imagesc(time,f,diffS/max(diffS(:)));
        hold on;
        plot([0 0 NaN 1000 1000 NaN 2000 2000],[20 100 NaN 20 100 NaN 20 100],'k:');
        title('cueA - cueB','FontSize',5);
        axis xy
        colormap(jet);
        set(gca,'CLim',[-1 1],'XTick',-1000:1000:4000,'XTickLabel',[],'YTick',20:20:100,...
            'YLim',[20 100],'XLim',[-1000 4000],'Box','off','TickDir','out','FontSize',5,'LineWidth',0.35);
        
        subplot(3,1,2)
        diffS = nanmean(S(:,:,trialIndex(:,1)),3)'-nanmean(S(:,:,trialIndex(:,2)),3)';
        imagesc(time,f,diffS/max(diffS(:)));
        hold on;
        plot([0 0 NaN 1000 1000 NaN 2000 2000],[20 100 NaN 20 100 NaN 20 100],'k:');
        title('Rw - noRw','FontSize',5);
        axis xy
        colormap(jet);
        ylabel('Frequency (Hz)','FontSize',5);
        set(gca,'CLim',[-1 1],'XTick',-1000:1000:4000,'XTickLabel',[],'YTick',20:20:100,...
            'YLim',[20 100],'XLim',[-1000 4000],'Box','off','TickDir','out','FontSize',5,'LineWidth',0.35);
        
        subplot(3,1,3)
        diffS = nanmean(S(:,:,trialIndex(:,3)),3)'-nanmean(S(:,:,trialIndex(:,4)),3)';
        imagesc(time,f,diffS/max(diffS(:)));
        hold on;
        plot([0 0 NaN 1000 1000 NaN 2000 2000],[20 100 NaN 20 100 NaN 20 100],'k:');
        title('Pn - noPn','FontSize',5);
        axis xy
        colormap(jet);
        set(gca,'CLim',[-1 1],'XTick',-1000:1000:4000,'XTickLabel',-1:1:4,...
            'YTick',20:20:100,'YLim',[20 100],'XLim',[-1000 4000],...
            'Box','off','TickDir','out','FontSize',5,'LineWidth',0.35);
        xlabel('Time from trial onset (s)','FontSize',5);
        
        print(fHandle,'-dtiff','-r600',[fileparts(cscList{iC}),'\spectrogram_',num2str(iC),'.tif']);
        
        save([cscName{iC},'.mat'],'interp_lfp','time_lfp','S','t','f');
    catch
        iD
    end
    close all;
end