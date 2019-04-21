function analysis_pethLight_Track()
% function pethLight(criteria_multi,criteria_add)
% Check whether the cell has light response or not.
% It calculates both in-block and between-block responses.
% criteria (%)
%   
%   Author: Joonyeup Lee
%   Version 1.0 (7/25/2016)

% Task variables
resolution = 10; % resoution * binSize = 20 msec (sigma)
binSize = 2;
win8hz = [-25 100];
win8hzPsd = [0 125];
win50hz = [0 20];

winCri = 20; % light effect criteria: 20ms
dot = 0;

[tData, tList] = tLoad;
nCell = length(tList);

for iCell = 1:nCell
    disp(['### pethLight analysis: ',tList{iCell},'...']);
    [cellPath, cellName, ~] = fileparts(tList{iCell});
    cd(cellPath);
    
    % Load Events variables
    load('Events.mat');
%% 8 Hz stimulation
    if(regexp(cellPath,'ori'))
        if ~isempty(lightTime.Track8hz); % ChETA
            spikeTimeTrackLight = spikeWin(tData{iCell},lightTime.Track8hz,win8hz);
            [xptTrackLight, yptTrackLight, pethtimeTrackLight, pethTrackLight,pethTrackLightConv,pethTrackLightConvZ] = rasterPETH(spikeTimeTrackLight,true(size(lightTime.Track8hz)),win8hz,binSize,resolution,dot);
            lightSpk = sum(0<xptTrackLight{1} & xptTrackLight{1}<winCri);
            lightPreSpk = sum(-winCri<xptTrackLight{1} & xptTrackLight{1}<0);
            lightPostSpk = sum(winCri<xptTrackLight{1} & xptTrackLight{1}<2*winCri);      

            save([cellName,'.mat'],'spikeTimeTrackLight','xptTrackLight','yptTrackLight','pethtimeTrackLight','pethTrackLight','pethTrackLightConv','pethTrackLightConvZ','lightSpk','lightPreSpk','lightPostSpk','-append');

        % Pseudo light calculation
            spikeTime_psdPre = spikeWin(tData{iCell},psdlightPre,win8hzPsd); % Pseudo light Pre
            [xptPsdPre, yptPsdPre, pethtimePsdPre, pethPsdPre,pethPsdPreConv,pethPsdPreConvZ] = rasterPETH(spikeTime_psdPre,true(size(psdlightPre)),win8hzPsd,binSize,resolution,dot);
            spikeTime_psdStm = spikeWin(tData{iCell},lightTime.Track8hz,win8hzPsd); % Pseudo light Pre
            [xptPsdStm, yptPsdStm, pethtimePsdStm, pethPsdStm,pethPsdStmConv,pethPsdStmConvZ] = rasterPETH(spikeTime_psdStm,true(size(lightTime.Track8hz)),win8hzPsd,binSize,resolution,dot);
            spikeTime_psdPost = spikeWin(tData{iCell},psdlightPost,win8hzPsd); % Pseudo light Post
            [xptPsdPost, yptPsdPost, pethtimePsdPost, pethPsdPost,pethPsdPostConv,pethPsdPostConvZ] = rasterPETH(spikeTime_psdPost,true(size(psdlightPost)),win8hzPsd,binSize,resolution,dot);
            psdPreSpk = sum(0<xptPsdPre{1} & xptPsdPre{1}<winCri);
            psdStmSpk = sum(0<xptPsdStm{1} & xptPsdStm{1}<winCri);
            psdPostSpk = sum(0<xptPsdPost{1} & xptPsdPost{1}<winCri);

            save([cellName,'.mat'],'xptPsdPre','yptPsdPre','pethtimePsdPre','pethPsdPre','pethPsdPreConv','pethPsdPreConvZ','psdPreSpk',...
                'xptPsdStm', 'yptPsdStm', 'pethtimePsdStm', 'pethPsdStm', 'pethPsdStmConv', 'pethPsdStmConvZ','psdStmSpk',...
                'xptPsdPost','yptPsdPost','pethtimePsdPost','pethPsdPost','pethPsdPostConv','pethPsdPostConvZ','psdPostSpk','-append');

        % Neural distance calculation        
            binSizeDist = 1;
            winTrackD = [-22 102];
            winDist = [-22 102];
            binWin = 1;
            binStep = 1;
            spikeTime_psdPreD = spikeWin(tData{iCell},psdlightPre,winTrackD); % Pseudo light Pre
            [xptPsdPreD, yptPsdPreD, pethtimePsdPreD, pethPsdPreD,~,~] = rasterPETH(spikeTime_psdPreD,true(size(psdlightPre)),winTrackD,binSizeDist,resolution,dot);
            spikeTime_psdStmD = spikeWin(tData{iCell},lightTime.Track8hz,winTrackD); % Pseudo light Pre
            [xptPsdStmD, yptPsdStmD, pethtimePsdStmD, pethPsdStmD, ~, ~] = rasterPETH(spikeTime_psdStmD,true(size(lightTime.Track8hz)),winTrackD,binSizeDist,resolution,dot);
            spikeTime_psdPostD = spikeWin(tData{iCell},psdlightPost,winTrackD); % Pseudo light Post
            [xptPsdPostD, yptPsdPostD, pethtimePsdPostD, pethPsdPostD, ~, ~] = rasterPETH(spikeTime_psdPostD,true(size(psdlightPost)),winTrackD,binSizeDist,resolution,dot);

            [~,spikePsdPreD] = spikeBin(spikeTime_psdPreD,winDist,binWin,binStep);
            [~,spikePsdStmD] = spikeBin(spikeTime_psdStmD,winDist,binWin,binStep);
            [~,spikePsdPostD] = spikeBin(spikeTime_psdPostD,winDist,binWin,binStep);

            spikePsdPreD = sum(spikePsdPreD,1);
            spikePsdStmD = sum(spikePsdStmD,1);
            spikePsdPostD = sum(spikePsdPostD,1);

            save([cellName,'.mat'],'spikeTime_psdPreD','spikeTime_psdStmD','spikeTime_psdPostD','xptPsdPreD','yptPsdPreD','pethtimePsdPreD','pethPsdPreD',...
                'xptPsdStmD', 'yptPsdStmD', 'pethtimePsdStmD', 'pethPsdStmD',...
                'xptPsdPostD','yptPsdPostD','pethtimePsdPostD','pethPsdPostD',...
                'spikePsdPreD','spikePsdStmD','spikePsdPostD','-append');
        end
    end

%% 50 Hz stimulation
    if(regexp(cellPath,'50hz'))
        if ~isempty(lightTime.Track50hz); % ChETA
            spikeTimeTrackLight = spikeWin(tData{iCell}, lightTime.Track50hz, win50hz);
            [xptTrackLight, yptTrackLight, pethtimeTrackLight, pethTrackLight,pethTrackLightConv,pethTrackLightConvZ] = rasterPETH(spikeTimeTrackLight, true(size(lightTime.Track50hz)), win50hz, binSize ,resolution, dot);     
            lightSpk = sum(0<xptTrackLight{1} & xptTrackLight{1}<winCri);

            save([cellName,'.mat'],'spikeTimeTrackLight','xptTrackLight','yptTrackLight','pethtimeTrackLight','pethTrackLight','pethTrackLightConv','pethTrackLightConvZ','lightSpk','-append');

            spikeTime_psdPre = spikeWin(tData{iCell},psdlightPre,win50hz); % Pseudo light Pre
            [xptPsdPre, yptPsdPre, pethtimePsdPre, pethPsdPre,pethPsdPreConv,pethPsdPreConvZ] = rasterPETH(spikeTime_psdPre,true(size(psdlightPre)),win50hz,binSize,resolution,dot);
            spikeTime_psdPost = spikeWin(tData{iCell},psdlightPost,win50hz); % Pseudo light Post
            [xptPsdPost, yptPsdPost, pethtimePsdPost, pethPsdPost,pethPsdPostConv,pethPsdPostConvZ] = rasterPETH(spikeTime_psdPost,true(size(psdlightPost)),win50hz,binSize,resolution,dot);
            psdPreSpk = sum(0<xptPsdPre{1} & xptPsdPre{1}<winCri);
            psdPostSpk = sum(0<xptPsdPost{1} & xptPsdPost{1}<winCri);

            save([cellName,'.mat'],'xptPsdPre','yptPsdPre','pethtimePsdPre','psdPreSpk','pethPsdPreConv','pethPsdPreConvZ','xptPsdPost','yptPsdPost','pethtimePsdPost','psdPostSpk','pethPsdPostConv','pethPsdPostConvZ','-append');
        end
    end
    
%% Familiar Burst stimulation (50Hz)
    if(regexp(cellPath,'familiar'))
        lightTime = lightTime.Track;
        spikeTimeTrackLight = spikeWin(tData{iCell}, lightTime, win50hz);
        [xptTrackLight, yptTrackLight, pethtimeTrackLight, pethTrackLight,pethTrackLightConv,pethTrackLightConvZ] = rasterPETH(spikeTimeTrackLight, true(size(lightTime)), win50hz, binSize ,resolution, dot);     
        lightSpk = length(xptTrackLight{1});
        save([cellName,'.mat'],'spikeTimeTrackLight','xptTrackLight','yptTrackLight','pethtimeTrackLight','pethTrackLight','pethTrackLightConv','pethTrackLightConvZ','lightSpk','-append');
        
        spikeTime_psdPre = spikeWin(tData{iCell},psdlightPre,win50hz); % Pseudo light Pre
        [xptPsdPre, yptPsdPre, pethtimePsdPre, pethPsdPre,pethPsdPreConv,pethPsdPreConvZ] = rasterPETH(spikeTime_psdPre,true(size(psdlightPre)),win50hz,binSize,resolution,dot);
        psdPreSpk = length(xptPsdPre{1});
        spikeTime_psdPost = spikeWin(tData{iCell},psdlightPost,win50hz); % Pseudo light Post
        [xptPsdPost, yptPsdPost, pethtimePsdPost, pethPsdPost,pethPsdPostConv,pethPsdPostConvZ] = rasterPETH(spikeTime_psdPost,true(size(psdlightPost)),win50hz,binSize,resolution,dot);
        psdPostSpk = length(xptPsdPost{1});
        save([cellName,'.mat'],...
            'xptPsdPre','yptPsdPre','pethtimePsdPre','psdPreSpk','pethPsdPreConv','pethPsdPreConvZ',...
            'xptPsdPost','yptPsdPost','pethtimePsdPost','psdPostSpk','pethPsdPostConv','pethPsdPostConvZ','-append');

% Align on 1st light of each burst
        winDist = [-22 102];        
        binStep = 1;
        binWin = 1;
        lightOnStm = lightTime([1; (find(diff(lightTime)>50)+1)]);
        lightOnPre = psdlightPre([1; (find(diff(psdlightPre)>50)+1)]);
        lightOnPost = psdlightPost([1; (find(diff(psdlightPost)>50)+1)]);
        winBurst = [-20 120];
        spikeTimeStm = spikeWin(tData{iCell}, lightOnStm, winBurst);
        [xpt1stBStm, ypt1stBStm, pethtime1stBStm, peth1stBStm, pethConv1stBStm, pethConvZ1stBStm] = rasterPETH(spikeTimeStm, true(size(lightOnStm)), winBurst, binSize, resolution, dot);
        spikeTimePre = spikeWin(tData{iCell},lightOnPre,winBurst);
        [xpt1stBPre, ypt1stBPre, pethtime1stBPre, peth1stBPre, pethConv1stBPre, pethConvZ1stBPre] = rasterPETH(spikeTimePre, true(size(lightOnPre)), winBurst, binSize, resolution, dot);
        spikeTimePost = spikeWin(tData{iCell},lightOnPost,winBurst);
        [xpt1stBPost, ypt1stBPost, pethtime1stBPost, peth1stBPost, pethConv1stBPost, pethConvZ1stBPost] = rasterPETH(spikeTimePost, true(size(lightOnPost)), winBurst, binSize, resolution, dot);
        
        temp_spikeBPreD = spikeWin(tData{iCell},lightOnPre,winDist);
        [~,spikeBPreD] = spikeBin(temp_spikeBPreD,winDist,binWin,binStep);
        spikeBPreD = sum(spikeBPreD,1);
        
        temp_spikeBStimD = spikeWin(tData{iCell},lightOnStm,winDist);
        [~,spikeBStimD] = spikeBin(temp_spikeBStimD,winDist,binWin,binStep);
        spikeBStimD = sum(spikeBStimD,1);
        
        temp_spikeNumPre = spikeWin(tData{iCell},lightOnPre,[0 80]);
        [spikeNumPre,~,~,~,~,~] = rasterPETH(temp_spikeNumPre,true(size(lightOnPre)),[0 80],binSize,resolution,1);
        temp_spikeNumStim = spikeWin(tData{iCell},lightOnStm,[0 80]);
        [spikeNumStim,~,~,~,~,~] = rasterPETH(temp_spikeNumStim,true(size(lightOnStm)),[0 80],binSize,resolution,1);
        
        save([cellName, '.mat'],...
            'xpt1stBStm','ypt1stBStm','pethtime1stBStm','peth1stBStm','pethConv1stBStm','pethConvZ1stBStm',...
            'xpt1stBPre','ypt1stBPre','pethtime1stBPre','peth1stBPre','pethConv1stBPre','pethConvZ1stBPre',...
            'xpt1stBPost','ypt1stBPost','pethtime1stBPost','peth1stBPost','pethConv1stBPost','pethConvZ1stBPost','spikeBPreD','spikeBStimD','spikeNumPre','spikeNumStim','-append');
        
% Align on 1st light of each lap
        lightOnStm = lightTime([1; (find(diff(lightTime)>1000)+1)]);
        lightOnPre = psdlightPre([1; (find(diff(psdlightPre)>1000)+1)]);
        lightOnPost = psdlightPost([1; (find(diff(psdlightPost)>1000)+1)]);
        winBurst = [-1000 5000];
        spikeTimeStm = spikeWin(tData{iCell}, lightOnStm, winBurst);
        [xpt1stLStm, ypt1stLStm, pethtime1stLStm, peth1stLStm, pethConv1stLStm, pethConvZ1stLStm] = rasterPETH(spikeTimeStm, true(size(lightOnStm)), winBurst, binSize, resolution, dot);
        spikeTimePre = spikeWin(tData{iCell},lightOnPre,winBurst);
        [xpt1stLPre, ypt1stLPre, pethtime1stLPre, peth1stLPre, pethConv1stLPre, pethConvZ1stLPre] = rasterPETH(spikeTimePre, true(size(lightOnPre)), winBurst, binSize, resolution, dot);
        spikeTimePost = spikeWin(tData{iCell},lightOnPost,winBurst);
        [xpt1stLPost, ypt1stLPost, pethtime1stLPost, peth1stLPost, pethConv1stLPost, pethConvZ1stLPost] = rasterPETH(spikeTimePost, true(size(lightOnPost)), winBurst, binSize, resolution, dot);
        
        save([cellName, '.mat'],...
            'xpt1stLStm','ypt1stLStm','pethtime1stLStm','peth1stLStm','pethConv1stLStm','pethConvZ1stLStm',...
            'xpt1stLPre','ypt1stLPre','pethtime1stLPre','peth1stLPre','pethConv1stLPre','pethConvZ1stLPre',...
            'xpt1stLPost','ypt1stLPost','pethtime1stLPost','peth1stLPost','pethConv1stLPost','pethConvZ1stLPost','-append');
        
% Spike probability
        lightProbTrack = sum(double(~cellfun(@isempty,spikeTimeTrackLight)))/length(lightTime)*100;
        save([cellName, '.mat'],'lightProbTrack','-append');       
    end
%% Novel environment stimulation (50Hz)
    if(regexp(cellPath,'novel'))
        spikeTimeTrackLight = spikeWin(tData{iCell}, lightTime, win50hz);
        [xptTrackLight, yptTrackLight, pethtimeTrackLight, pethTrackLight,pethTrackLightConv,pethTrackLightConvZ] = rasterPETH(spikeTimeTrackLight, true(size(lightTime)), win50hz, binSize ,resolution, dot);     
        lightSpk = length(xptTrackLight{1});
        save([cellName,'.mat'],'spikeTimeTrackLight','xptTrackLight','yptTrackLight','pethtimeTrackLight','pethTrackLight','pethTrackLightConv','pethTrackLightConvZ','lightSpk','-append');
        
        spikeTime_psdPre = spikeWin(tData{iCell},psdlightPre,win50hz); % Pseudo light Pre
        [xptPsdPre, yptPsdPre, pethtimePsdPre, pethPsdPre,pethPsdPreConv,pethPsdPreConvZ] = rasterPETH(spikeTime_psdPre,true(size(psdlightPre)),win50hz,binSize,resolution,dot);
        psdPreSpk = length(xptPsdPre{1});
        spikeTime_psdPost = spikeWin(tData{iCell},psdlightPost,win50hz); % Pseudo light Post
        [xptPsdPost, yptPsdPost, pethtimePsdPost, pethPsdPost,pethPsdPostConv,pethPsdPostConvZ] = rasterPETH(spikeTime_psdPost,true(size(psdlightPost)),win50hz,binSize,resolution,dot);
        psdPostSpk = length(xptPsdPost{1});
        save([cellName,'.mat'],...
            'xptPsdPre','yptPsdPre','pethtimePsdPre','psdPreSpk','pethPsdPreConv','pethPsdPreConvZ',...
            'xptPsdPost','yptPsdPost','pethtimePsdPost','psdPostSpk','pethPsdPostConv','pethPsdPostConvZ','-append');

% Align on 1st light of each burst
        winDist = [-22 102];
        binStep = 1;
        binWin = 1;
        lightOnStm = lightTime([1; (find(diff(lightTime)>50)+1)]);
        lightOnPre = psdlightPre([1; (find(diff(psdlightPre)>50)+1)]);
        lightOnPost = psdlightPost([1; (find(diff(psdlightPost)>50)+1)]);
        winBurst = [-20 120];
        spikeTimeStm = spikeWin(tData{iCell}, lightOnStm, winBurst);
        [xpt1stBStm, ypt1stBStm, pethtime1stBStm, peth1stBStm, pethConv1stBStm, pethConvZ1stBStm] = rasterPETH(spikeTimeStm, true(size(lightOnStm)), winBurst, binSize, resolution, dot);
        spikeTimePre = spikeWin(tData{iCell},lightOnPre,winBurst);
        [xpt1stBPre, ypt1stBPre, pethtime1stBPre, peth1stBPre, pethConv1stBPre, pethConvZ1stBPre] = rasterPETH(spikeTimePre, true(size(lightOnPre)), winBurst, binSize, resolution, dot);
        spikeTimePost = spikeWin(tData{iCell},lightOnPost,winBurst);
        [xpt1stBPost, ypt1stBPost, pethtime1stBPost, peth1stBPost, pethConv1stBPost, pethConvZ1stBPost] = rasterPETH(spikeTimePost, true(size(lightOnPost)), winBurst, binSize, resolution, dot);
        
        temp_spikeBPreD = spikeWin(tData{iCell},lightOnPre,winDist);
        [~,spikeBPreD] = spikeBin(temp_spikeBPreD,winDist,binWin,binStep);
        spikeBPreD = sum(spikeBPreD,1);
        
        temp_spikeBStimD = spikeWin(tData{iCell},lightOnStm,winDist);
        [~,spikeBStimD] = spikeBin(temp_spikeBStimD,winDist,binWin,binStep);
        spikeBStimD = sum(spikeBStimD,1);
        
        temp_spikeNumPre = spikeWin(tData{iCell},lightOnPre,[0 80]);
        [spikeNumPre,~,~,~,~,~] = rasterPETH(temp_spikeNumPre,true(size(lightOnPre)),[0 80],binSize,resolution,1);
        temp_spikeNumStim = spikeWin(tData{iCell},lightOnStm,[0 80]);
        [spikeNumStim,~,~,~,~,~] = rasterPETH(temp_spikeNumStim,true(size(lightOnStm)),[0 80],binSize,resolution,1);
        save([cellName, '.mat'],...
            'xpt1stBStm','ypt1stBStm','pethtime1stBStm','peth1stBStm','pethConv1stBStm','pethConvZ1stBStm',...
            'xpt1stBPre','ypt1stBPre','pethtime1stBPre','peth1stBPre','pethConv1stBPre','pethConvZ1stBPre',...
            'xpt1stBPost','ypt1stBPost','pethtime1stBPost','peth1stBPost','pethConv1stBPost','pethConvZ1stBPost','spikeBPreD','spikeBStimD','spikeNumPre','spikeNumStim','-append');
        
% Align on 1st light of each lap
        lightOnStm = lightTime([1; (find(diff(lightTime)>1000)+1)]);
        lightOnPre = psdlightPre([1; (find(diff(psdlightPre)>1000)+1)]);
        lightOnPost = psdlightPost([1; (find(diff(psdlightPost)>1000)+1)]);
        winBurst = [-1000 5000];
        spikeTimeStm = spikeWin(tData{iCell}, lightOnStm, winBurst);
        [xpt1stLStm, ypt1stLStm, pethtime1stLStm, peth1stLStm, pethConv1stLStm, pethConvZ1stLStm] = rasterPETH(spikeTimeStm, true(size(lightOnStm)), winBurst, binSize, resolution, dot);
        spikeTimePre = spikeWin(tData{iCell},lightOnPre,winBurst);
        [xpt1stLPre, ypt1stLPre, pethtime1stLPre, peth1stLPre, pethConv1stLPre, pethConvZ1stLPre] = rasterPETH(spikeTimePre, true(size(lightOnPre)), winBurst, binSize, resolution, dot);
        spikeTimePost = spikeWin(tData{iCell},lightOnPost,winBurst);
        [xpt1stLPost, ypt1stLPost, pethtime1stLPost, peth1stLPost, pethConv1stLPost, pethConvZ1stLPost] = rasterPETH(spikeTimePost, true(size(lightOnPost)), winBurst, binSize, resolution, dot);
        
        save([cellName, '.mat'],...
            'xpt1stLStm','ypt1stLStm','pethtime1stLStm','peth1stLStm','pethConv1stLStm','pethConvZ1stLStm',...
            'xpt1stLPre','ypt1stLPre','pethtime1stLPre','peth1stLPre','pethConv1stLPre','pethConvZ1stLPre',...
            'xpt1stLPost','ypt1stLPost','pethtime1stLPost','peth1stLPost','pethConv1stLPost','pethConvZ1stLPost','-append');
        
% Spike probability
        lightProbTrack = sum(double(~cellfun(@isempty,spikeTimeTrackLight)))/length(lightTime)*100;
        save([cellName, '.mat'],'lightProbTrack','-append');
    end
end
disp('### pethLight50hz is done! ###');