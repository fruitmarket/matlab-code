function tagstat_trackOri50hz()
%tagstatCC calculates statistical significance using log-rank test
% Variables for log-rank test & salt test

testRange50hz = 8;
testRange2hz = 8;

baseRange50hz = 400;
baseRange2hz = 480;

spkCriPlfm = 10;
spkCriTrack = 10; % spikes should be more than 10

allowance = 0.005; % 0.5% allowance for hazerd function.
movingWin = (0:2:8)';
alpha = 0.05/length(movingWin);

winLatency = [0 20];

warning('off','signal:findpeaks:largeMinPeakHeight');

if nargin == 0; sessionFolder = {}; end;
[tData, tList] = tLoad(sessionFolder);
matList = mLoad();
if isempty(tList); return; end;

nCell = length(tList);
for iCell = 1:nCell
    disp(['### Response stat analysis: ',tList{iCell}]);
    [cellPath,cellName,~] = fileparts(tList{iCell});
    cd(cellPath);

    load('Events.mat','lightTime','psdlightPre','psdlightPost');
    load(matList{iCell},'pethPlfm2hz','pethTrackLight');
    spikeData = tData{iCell};

    spkCriteria_Plfm2hz = spikeWin(spikeData,lightTime.Plfm2hz(201:400),[-50,50]);
    spkCriteria_Track50hz = spikeWin(spikeData,lightTime.Track50hz,[0, 20]);
    spkCriteria_Plfm50hz = spikeWin(spikeData, lightTime.Plfm50hz, [0, 20]);
    
    preLightIdx = [1; find(diff(psdlightPre)>1000)+1];
    baseLightTimeTrack = psdlightPre(preLightIdx);
    
    lightIdx_Plfm50hz = [1; find(diff(lightTime.Plfm50hz)>1000)+1];
    baseLightTimePlfm = lightTime.Plfm50hz(lightIdx_Plfm50hz);    
%% Log-rank test

    [pLR_Plfm2hzT,pLR_Plfm50hzT,pLR_TrackT] = deal(zeros(5,1));
    [timeLR_Plfm2hzT,H1_Plfm2hzT,H2_Plfm2hzT,timeLR_Plfm50hzT,H1_Plfm50hzT,H2_Plfm50hzT,timeLR_TrackT,H1_TrackT,H2_TrackT] = deal(cell(5,1));
%% pLR_Plfm2hz
    if sum(cell2mat(cellfun(@length,spkCriteria_Plfm2hz,'UniformOutput',false))) < spkCriPlfm % if the # of spikes are less than spkCri, do not calculate pLR
        pLR_Plfm2hz = 1;
        [statDir_Plfm2hz, latencyPlfm2hz1st, latencyPlfm2hz2nd, timeLR_Plfm2hz, H1_Plfm2hz, H2_Plfm2hz, calibPlfm2hz] = deal(NaN);
    else
        for iWin = 1:length(movingWin)
            [timePlfm2hz, censorPlfm2hz] = tagDataLoad(spikeData, lightTime.Plfm2hz(201:400)+movingWin(iWin), testRange2hz, baseRange2hz);
            [pLR_Plfm2hzTemp,timeLR_Plfm2hzT{iWin,1},H1_Plfm2hzT{iWin,1},H2_Plfm2hzT{iWin,1}] = logRankTest(timePlfm2hz, censorPlfm2hz); % H1: light induced firing H2: baseline
            if isempty(pLR_Plfm2hzTemp)
                pLR_Plfm2hzTemp = 1;
            end
            pLR_Plfm2hzT(iWin,1) = pLR_Plfm2hzTemp;
        end
        idxPlfm2hz = find(pLR_Plfm2hzT<alpha,1,'first');
        if isempty(idxPlfm2hz)
            idxPlfm2hz = 1;
        end
        idxH1_Plfm2hz = find(~cellfun(@isempty,H1_Plfm2hzT));
        idxH2_Plfm2hz = find(~cellfun(@isempty,H2_Plfm2hzT));
        idxcom_Plfm2hz = idxH1_Plfm2hz(idxH1_Plfm2hz == idxH2_Plfm2hz);
        for iTest = 1:length(idxcom_Plfm2hz)
            testPlfm(iTest) = all((H1_Plfm2hzT{iTest,:}-H2_Plfm2hzT{iTest,:}) >= -max(H1_Plfm2hzT{iTest,:})*allowance) | all((H2_Plfm2hzT{iTest,:}-H1_Plfm2hzT{iTest,:}) >= -max(H2_Plfm2hzT{iTest,:})*allowance); % H1 should all bigger or smaller than H2 (0.1% allowance)
        end
        idxH_Plfm2hz = idxcom_Plfm2hz(find(testPlfm==1,1,'first'));
        if isempty(idxH_Plfm2hz)
            idxH_Plfm2hz = 1;
        end
        if idxPlfm2hz >= idxH_Plfm2hz
            pLR_Plfm2hz = pLR_Plfm2hzT(idxPlfm2hz);
            timeLR_Plfm2hz = timeLR_Plfm2hzT{idxPlfm2hz};        
            H1_Plfm2hz = H1_Plfm2hzT{idxPlfm2hz};
            H2_Plfm2hz = H2_Plfm2hzT{idxPlfm2hz};
            calibPlfm2hz = movingWin(idxPlfm2hz);
        else
            pLR_Plfm2hz = pLR_Plfm2hzT(idxH_Plfm2hz);
            timeLR_Plfm2hz = timeLR_Plfm2hzT{idxH_Plfm2hz};        
            H1_Plfm2hz = H1_Plfm2hzT{idxH_Plfm2hz};
            H2_Plfm2hz = H2_Plfm2hzT{idxH_Plfm2hz};
            calibPlfm2hz = movingWin(idxH_Plfm2hz);
        end
        
% v2.0 (based on H1, H2)
        if H1_Plfm2hz(end)>H2_Plfm2hz(end)
            statDir_Plfm2hz = 1;
        elseif H1_Plfm2hz(end)<H2_Plfm2hz(end)
            statDir_Plfm2hz = -1;            
        else
            statDir_Plfm2hz = 0;
        end

% Latency (Platform)
        [pksPlfm2hz,locPlfm2hz] = findpeaks(pethPlfm2hz,'minpeakheight',10); % check whether there are two peaks or not. if there are two peaks, calculate each peaek.
        switch (statDir_Plfm2hz)
            case 1
                if length(locPlfm2hz) == 2
                    spkLatency_Plfm2hz1st = spikeWin(spikeData,lightTime.Plfm2hz(201:400),[0 9]);
                    temp_latencyPlfm2hz1st = cellfun(@min,spkLatency_Plfm2hz1st,'UniformOutput',false);
                    temp_latencyPlfm2hz1st = nanmedian(cell2mat(temp_latencyPlfm2hz1st));

                    spkLatency_Plfm2hz2nd = spikeWin(spikeData,lightTime.Plfm2hz(201:400),[11 20]);
                    temp_latencyPlfm2hz2nd = cellfun(@min,spkLatency_Plfm2hz2nd,'UniformOutput',false);
                    temp_latencyPlfm2hz2nd = nanmedian(cell2mat(temp_latencyPlfm2hz2nd));
                else
                    spkLatency_Plfm2hz = spikeWin(spikeData,lightTime.Plfm2hz(201:400),winLatency);
                    temp_latencyPlfm2hz = cellfun(@min,spkLatency_Plfm2hz,'UniformOutput',false);
                    temp_latencyPlfm2hz = nanmedian(cell2mat(temp_latencyPlfm2hz));
                end
            case -1
                spkLatency_Plfm2hz = spikeWin(spikeData,lightTime.Plfm2hz(201:400),winLatency);
                temp_latencyPlfm2hz = cellfun(@max,spkLatency_Plfm2hz,'UniformOutput',false);
                temp_latencyPlfm2hz = nanmedian(cell2mat(temp_latencyPlfm2hz));
            case 0
                spkLatency_Plfm2hz = spikeWin(spikeData,lightTime.Plfm2hz(201:400),winLatency);
                temp_latencyPlfm2hz = 0;
        end
        if exist('temp_latencyPlfm2hz1st','var') & ~isnan(temp_latencyPlfm2hz1st)
            latencyPlfm2hz1st = temp_latencyPlfm2hz1st;
            latencyPlfm2hz2nd = temp_latencyPlfm2hz2nd;
        elseif exist('temp_latencyPlfm2hz1st','var') & isnan(temp_latencyPlfm2hz1st)
            latencyPlfm2hz1st = temp_latencyPlfm2hz2nd;
            latencyPlfm2hz2nd = NaN;
        else
            latencyPlfm2hz1st = temp_latencyPlfm2hz;
            latencyPlfm2hz2nd = NaN;
        end
    end
    
%% pLR_Plfm50hz
    if sum(cell2mat(cellfun(@length,spkCriteria_Plfm50hz,'UniformOutput',false))) < spkCriPlfm % if the # of spikes are less than 10, do not calculate pLR
        pLR_Plfm50hz = 1; 
        [statDir_Plfm50hz, latencyPlfm50hz1st, latencyPlfm50hz2nd, timeLR_Plfm50hz, H1_Plfm50hz, H2_Plfm50hz, calibPlfm50hz] = deal(NaN);
    else
        [base_timePlfm50hz,base_censorPlfm50hz] = tagDataLoad(spikeData, baseLightTimePlfm, testRange50hz, baseRange50hz);
        base = [reshape(base_timePlfm50hz(1:(end-1),:),1,[]);reshape(base_censorPlfm50hz(1:(end-1),:),1,[])]';
        for iWin = 1:length(movingWin)
            [timePlfm50hz, censorPlfm50hz] = tagDataLoad(spikeData, lightTime.Plfm50hz+movingWin(iWin), testRange50hz, 8);
            if isempty(timePlfm50hz)
                [pLR_Plfm50hzTemp(iWin,1), timeLR_Plfm50hzT{iWin,1}, H1_Plfm50hzT{iWin,1}, H2_Plfm50hzT{iWin,1}] = deal(NaN);
                continue;
            end
            test = [timePlfm50hz(end,:); censorPlfm50hz(end,:)]';
            [pLR_Plfm50hzTemp,timeLR_Plfm50hzT{iWin,1},H1_Plfm50hzT{iWin,1},H2_Plfm50hzT{iWin,1}] = logrank(test,base); % H1: light induced firing H2: baseline
            if isempty(pLR_Plfm50hzTemp)
                pLR_Plfm50hzTemp = 1;
            end
            pLR_Plfm50hzT(iWin,1) = pLR_Plfm50hzTemp;
        end
        idxPlfm50hz = find(pLR_Plfm50hzT<alpha,1,'first');
        if isempty(idxPlfm50hz)
            idxPlfm50hz = 1;
        end
        idxH1_Plfm50hz = find(~cellfun(@isempty,H1_Plfm50hzT));
        idxH2_Plfm50hz = find(~cellfun(@isempty,H2_Plfm50hzT));
        idxcom_Plfm50hz = idxH1_Plfm50hz(idxH1_Plfm50hz == idxH2_Plfm50hz);
        for iTest = 1:length(idxcom_Plfm50hz)
            testPlfm(iTest) = all((H1_Plfm50hzT{iTest,:}-H2_Plfm50hzT{iTest,:}) >= - max(H1_Plfm50hzT{iTest,:})*allowance) | all((H2_Plfm50hzT{iTest,:}-H1_Plfm50hzT{iTest,:}) >= -max(H2_Plfm50hzT{iTest,:}));
        end
        idxH_Plfm50hz = idxcom_Plfm50hz(find(testPlfm==1,1,'first'));

        if isempty(idxH_Plfm50hz)
            idxH_Plfm50hz = 1;
        end
        if idxPlfm50hz >= idxH_Plfm50hz
            pLR_Plfm50hz = pLR_Plfm50hzT(idxPlfm50hz);
            timeLR_Plfm50hz = timeLR_Plfm50hzT{idxPlfm50hz};        
            H1_Plfm50hz = H1_Plfm50hzT{idxPlfm50hz};
            H2_Plfm50hz = H2_Plfm50hzT{idxPlfm50hz};
            calibPlfm50hz = movingWin(idxPlfm50hz);
        else
            pLR_Plfm50hz = pLR_Plfm50hzT(idxH_Plfm50hz);
            timeLR_Plfm50hz = timeLR_Plfm50hzT{idxH_Plfm50hz};        
            H1_Plfm50hz = H1_Plfm50hzT{idxH_Plfm50hz};
            H2_Plfm50hz = H2_Plfm50hzT{idxH_Plfm50hz};
            calibPlfm50hz = movingWin(idxH_Plfm50hz);
        end

% v2.0 (based on H1, H2)
        if H1_Plfm50hz(end)>H2_Plfm50hz(end)
            statDir_Plfm50hz = 1;
        elseif H1_Plfm50hz(end)<H2_Plfm50hz(end)
            statDir_Plfm50hz = -1;            
        else
            statDir_Plfm50hz = 0;
        end

% Latency (Platform)
    load(matList{iCell},'pethPlfm50hz')
    [pksPlfm50hz,locPlfm50hz] = findpeaks(pethPlfm50hz,'minpeakheight',10); % check whether there are two peaks or not. if there are two peaks, calculate each peaek.
    switch (statDir_Plfm50hz)
        case 1
            if length(locPlfm50hz) == 2
                spkLatency_Plfm50hz1st = spikeWin(spikeData,lightTime.Plfm50hz,[0 9]);
                temp_latencyPlfm50hz1st = cellfun(@min,spkLatency_Plfm50hz1st,'UniformOutput',false);
                temp_latencyPlfm50hz1st = nanmedian(cell2mat(temp_latencyPlfm50hz1st));

                spkLatency_Plfm50hz2nd = spikeWin(spikeData,lightTime.Plfm50hz,[11 20]);
                temp_latencyPlfm50hz2nd = cellfun(@min,spkLatency_Plfm50hz2nd,'UniformOutput',false);
                temp_latencyPlfm50hz2nd = nanmedian(cell2mat(temp_latencyPlfm50hz2nd));
            else
                spkLatency_Plfm50hz = spikeWin(spikeData,lightTime.Plfm50hz,winLatency);
                temp_latencyPlfm50hz = cellfun(@min,spkLatency_Plfm50hz,'UniformOutput',false);
                temp_latencyPlfm50hz = nanmedian(cell2mat(temp_latencyPlfm50hz));
            end
        case -1
            spkLatency_Plfm50hz = spikeWin(spikeData,lightTime.Plfm50hz,winLatency);
            temp_latencyPlfm50hz = cellfun(@max,spkLatency_Plfm50hz,'UniformOutput',false);
            temp_latencyPlfm50hz = nanmedian(cell2mat(temp_latencyPlfm50hz));
        case 0
            spkLatency_Plfm50hz = spikeWin(spikeData,lightTime.Plfm50hz,winLatency);
            temp_latencyPlfm50hz = 0;
    end
        if exist('temp_latencyPlfm50hz1st','var') & ~isnan(temp_latencyPlfm50hz1st)
            latencyPlfm50hz1st = temp_latencyPlfm50hz1st;
            latencyPlfm50hz2nd = temp_latencyPlfm50hz2nd;
        elseif exist('temp_latencyPlfm50hz1st','var') & isnan(temp_latencyPlfm50hz1st)
            latencyPlfm50hz1st = temp_latencyPlfm50hz2nd;
            latencyPlfm50hz2nd = NaN;
        else
            latencyPlfm50hz1st = temp_latencyPlfm50hz;
            latencyPlfm50hz2nd = NaN;
        end           
    end

%% pLR_Track
    if sum(cell2mat(cellfun(@length,spkCriteria_Track50hz,'UniformOutput',false))) < spkCriTrack
        pLR_Track = 1;
        [statDir_Track, latencyTrack1st, latencyTrack2nd, timeLR_Track, H1_Track, H2_Track, calibTrack] = deal(NaN);
    else
        [base_timeTrack50hz,base_censorTrack50hz] = tagDataLoad(spikeData, baseLightTimeTrack, testRange50hz, baseRange50hz);
        base = [reshape(base_timeTrack50hz(1:(end-1),:),1,[]);reshape(base_censorTrack50hz(1:(end-1),:),1,[])]';        
        for iWin = 1:length(movingWin)
            [timeTrack50hz, censorTrack50hz] = tagDataLoad(spikeData,lightTime.Track50hz+movingWin(iWin),testRange50hz,8);
            if isempty(timeTrack50hz)
                [pLR_TrackTemp(iWin,1), timeLR_TrackT{iWin,1}, H1_TrackT{iWin,1}, H2_TrackT{iWin,1}] = deal(NaN);
                continue;
            end
            test = [timeTrack50hz(end,:);censorTrack50hz(end,:)]';
            [pLR_TrackTemp,timeLR_TrackT{iWin,1},H1_TrackT{iWin,1},H2_TrackT{iWin,1}] = logrank(test, base);
            if isempty(pLR_TrackTemp)
                pLR_TrackTemp = 1;
            end
            pLR_TrackT(iWin,1) = pLR_TrackTemp;
        end
        idxTrack = find(pLR_TrackT<alpha,1,'first');
        if isempty(idxTrack)
            idxTrack = 1;
        end
        idxH1_Track = find(~cellfun(@isempty,H1_TrackT));
        idxH2_Track = find(~cellfun(@isempty,H2_TrackT));
        idxcom_Track = idxH1_Track(idxH1_Track == idxH2_Track);
        for iTest = 1:length(idxcom_Track)
            testTrack(iTest) = all((H1_TrackT{iTest,:}-H2_TrackT{iTest,:})>= -max(H1_TrackT{iTest,:})*allowance) | all((H2_TrackT{iTest,:}-H1_TrackT{iTest,:})>= -max(H2_TrackT{iTest,:})*allowance);
        end
        idxH_Track = idxcom_Track(find(testTrack==1,1,'first'));
        if isempty(idxH_Track)
            idxH_Track = 1;
        end
        if idxTrack >= idxH_Track
            pLR_Track = pLR_TrackT(idxTrack);
            timeLR_Track = timeLR_TrackT{idxTrack};
            H1_Track = H1_TrackT{idxTrack};
            H2_Track = H2_TrackT{idxTrack};
            calibTrack = movingWin(idxTrack);
        else
            pLR_Track = pLR_TrackT(idxH_Track);
            timeLR_Track = timeLR_TrackT{idxH_Track};
            H1_Track = H1_TrackT{idxH_Track};
            H2_Track = H2_TrackT{idxH_Track};
            calibTrack = movingWin(idxH_Track);
        end

% v2.0 (Based on H1, H2)
        if H1_Track(end) > H2_Track(end)
            statDir_Track = 1;
        elseif H1_Track(end) < H2_Track(end)
            statDir_Track = -1;
        else
            statDir_Track = 0;
        end
        
% Latency (Moving win)
        [pksTrack,locTrack] = findpeaks(pethTrackLight,'minpeakheight',15); % check whether there are two peaks or not. if there are two peaks, calculate each peaek.
        switch (statDir_Track)
            case 1                
                if length(locTrack) >= 2
                    spkLatency_Track1st = spikeWin(spikeData,lightTime.Track50hz,[0 9]);
                    temp_latencyTrack1st = cellfun(@min,spkLatency_Track1st,'UniformOutput',false);
                    temp_latencyTrack1st = nanmedian(cell2mat(temp_latencyTrack1st));

                    spkLatency_Track2nd = spikeWin(spikeData,lightTime.Track50hz,[11 20]);
                    temp_latencyTrack2nd = cellfun(@min,spkLatency_Track2nd,'UniformOutput',false);
                    temp_latencyTrack2nd = nanmedian(cell2mat(temp_latencyTrack2nd));
                else
                    spkLatency_Track = spikeWin(spikeData,lightTime.Track50hz,winLatency);
                    temp_latencyTrack = cellfun(@min,spkLatency_Track,'UniformOutput',false);
                    temp_latencyTrack = nanmedian(cell2mat(temp_latencyTrack));
                end
            case -1
                spkLatency_Track = spikeWin(spikeData,lightTime.Track50hz,winLatency);
                temp_latencyTrack = cellfun(@max,spkLatency_Track,'UniformOutput',false);
                temp_latencyTrack = nanmedian(cell2mat(temp_latencyTrack));
            case 0
                spkLatency_Track = spikeWin(spikeData,lightTime.Track50hz,winLatency);
                temp_latencyTrack = 0;
        end
        if exist('temp_latencyTrack1st','var') & ~isnan(temp_latencyTrack1st)
            latencyTrack1st = temp_latencyTrack1st;
            latencyTrack2nd = temp_latencyTrack2nd;
        elseif exist('temp_latencyTrack1st','var') & isnan(temp_latencyTrack1st)
            latencyTrack1st = temp_latencyTrack2nd;
            latencyTrack2nd = NaN;
        else
            latencyTrack1st = temp_latencyTrack;
            latencyTrack2nd = NaN;
        end
    end

    save([cellName,'.mat'],...
        'pLR_Plfm2hz','timeLR_Plfm2hz','H1_Plfm2hz','H2_Plfm2hz','calibPlfm2hz','statDir_Plfm2hz','latencyPlfm2hz1st','latencyPlfm2hz2nd',...
        'pLR_Plfm50hz','timeLR_Plfm50hz','H1_Plfm50hz','H2_Plfm50hz','calibPlfm50hz','statDir_Plfm50hz','latencyPlfm50hz1st','latencyPlfm50hz2nd',...
        'pLR_Track','timeLR_Track','H1_Track','H2_Track','calibTrack','statDir_Track','latencyTrack1st','latencyTrack2nd','-append')

%% Pre & Post light stimulation p-value check
    [timeTrack_pre, censorTrack_pre] = tagDataLoad(spikeData, psdlightPre+calibTrack, 8, 8);
    [timeTrack_post, censorTrack_post] = tagDataLoad(spikeData, psdlightPost+calibTrack, 8, 8);
    
    [pLR_Track_pre,timeLR_Track_pre,H1_Track_pre,H2_Track_pre] = logRankTest(timeTrack_pre, censorTrack_pre);
    [pLR_Track_post,timeLR_Track_post,H1_Track_post,H2_Track_post] = logRankTest(timeTrack_post, censorTrack_post);
    
    spkCriteria_pre = spikeWin(spikeData,psdlightPre+calibTrack,[0,20]);
    spkCriteria_post = spikeWin(spikeData,psdlightPost+calibTrack,[0,20]);
    if sum(cell2mat(cellfun(@length,spkCriteria_pre,'UniformOutput',false))) < spkCriTrack  % if the # of spikes are less than spkCri, do not calculate pLR
        pLR_Track_pre = 1;
    end
    if sum(cell2mat(cellfun(@length,spkCriteria_post,'UniformOutput',false))) < spkCriTrack
        pLR_Track_post = 1;
    end
    save([cellName, '.mat'],'pLR_Track_pre','timeLR_Track_pre','H1_Track_pre','H2_Track_pre','pLR_Track_post','timeLR_Track_post','H1_Track_post','H2_Track_post','-append')
end
disp('### TagStatTest & Latency calculation 50Hz are done!');

function [time, censor] = tagDataLoad(spikeData, onsetTime, testRange, baseRange)
%tagDataLoad makes dataset for statistical tests
%   spikeData: raw data from MClust t file (in msec)
%   onsetTime: time of light stimulation (in msec)
%   testRange: binning time range for test (in msec)
%   baseRange: binning time range for baseline (in msec)
%
%   time: nBin (nBin-1 number of baselines and 1 test) x nLightTrial

narginchk(4,4);
if isempty(onsetTime); time = []; censor = []; return; end;

% If onsetTime interval is shorter than test+baseline range, omit.
outBin = find(diff(onsetTime)<=(testRange+baseRange));
outBin = [outBin;outBin+1];
onsetTime(outBin(:))=[];
if isempty(onsetTime); time = []; censor = []; return; end;
nLight = length(onsetTime);

% Rearrange data
bin = [-floor(baseRange/testRange)*testRange:testRange:0];
nBin = length(bin);
binMat = ones(nLight,nBin)*diag(bin);
lightBin = (repmat(onsetTime',nBin,1)+binMat');
time = zeros(nBin,nLight);
censor = zeros(nBin,nLight);

for iLight=1:nLight
    for iBin=1:nBin
        idx = find(spikeData > lightBin(iBin,iLight), 1, 'first');
        if isempty(idx)
            time(iBin,iLight) = testRange;
            censor(iBin,iLight) = 1;
        else
            time(iBin,iLight) = spikeData(idx) - lightBin(iBin,iLight);
            if time(iBin,iLight) > testRange
                time(iBin,iLight) = testRange;
                censor(iBin,iLight) = 1;
            end
        end     
    end
end

function [p,time,H1,H2] = logRankTest(time, censor)
%logRankTest makes dataset for log-rank test

if isempty(time) || isempty(censor); p = []; time = []; H1 = []; H2 = []; return; end;

base = [reshape(time(1:(end-1),:),1,[]);reshape(censor(1:(end-1),:),1,[])]';
test = [time(end,:);censor(end,:)]';

[p,time,H1,H2] = logrank(test,base);

function [p, l] = saltTest(time, wn, dt)
if isempty(time) ; p = []; l= []; return; end;

base = time(1:(end-1),:)';
test = time(end,:)';

[p, l] = salt2(test, base, wn, dt);

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
