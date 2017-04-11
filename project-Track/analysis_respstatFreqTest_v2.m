function analysis_respstatFreqTest_v2()
%respstatPlfm calculates statistical significance using log-rank test

% Variables for log-rank test & salt test
testRange = 8;
baseRange = 400;

spkCriPlfm = 10;

movingWin = (0:2:8)';
alpha = 0.05/length(movingWin);
allowance = 0.005; % 0.5% allowance for hazerd function.

% Load data
if nargin == 0; sessionFolder = {}; end;
[tData, tList] = tLoad(sessionFolder);
if isempty(tList); return; end;

nCell = length(tList);
for iCell = 1:nCell
    disp(['### Response stat test: ',tList{iCell}]);
    [cellPath,cellName,~] = fileparts(tList{iCell});
    cd(cellPath);

    load('Events.mat','lightTime');
    
% create pseudo light events for baseline
    [baseLightTime1hz, baseLightTime2hz, baseLightTime8hz, baseLightTime20hz, baseLightTime50hz] = deal([]);
    for iLap = 1:20
        temp_baseLightTime1hz = lightTime.Plfm1hz(15*iLap)+rand([15,1])*1000;
        baseLightTime1hz = [baseLightTime1hz; temp_baseLightTime1hz];
        
        temp_baseLightTime2hz = lightTime.Plfm1hz(15*iLap)+rand([15,1])*1000;
        baseLightTime2hz = [baseLightTime2hz; temp_baseLightTime2hz];
        
        temp_baseLightTime8hz = lightTime.Plfm1hz(15*iLap)+rand([15,1])*1000;
        baseLightTime8hz = [baseLightTime8hz; temp_baseLightTime8hz];
        
        temp_baseLightTime20hz = lightTime.Plfm1hz(15*iLap)+rand([15,1])*1000;
        baseLightTime20hz = [baseLightTime20hz; temp_baseLightTime20hz];
        
        temp_baseLightTime50hz = lightTime.Plfm50hz(15*iLap)+rand([15,1])*1000;
        baseLightTime50hz = [baseLightTime50hz; temp_baseLightTime50hz];
    end
    
    spikeData = tData{iCell};
    
% if spikes are noe enough, don't calculate the logrank test
    spkCriteria_Plfm1hz = spikeWin(spikeData,lightTime.Plfm1hz,[-50,50]);
    spkCriteria_Plfm2hz = spikeWin(spikeData,lightTime.Plfm2hz,[-50,50]);
    spkCriteria_Plfm8hz = spikeWin(spikeData,lightTime.Plfm8hz,[-50,50]);
    spkCriteria_Plfm20hz = spikeWin(spikeData,lightTime.Plfm20hz,[-50,50]);
    spkCriteria_Plfm50hz = spikeWin(spikeData,lightTime.Plfm50hz,[-50,50]);

%% Plfm1hz
    if sum(cell2mat(cellfun(@length,spkCriteria_Plfm1hz,'UniformOutput',false)))< spkCriPlfm
        pLR_Plfm1hz = 1;
        [statDir_Plfm1hz, latencyPlfm1hz, timeLR_Plfm1hz, H1_Plfm1hz, H2_Plfm1hz, calibPlfm1hz] = deal(NaN);
    else
        [base_timePlfm1hz,base_censorPlfm1hz] = tagDataLoad(spikeData, baseLightTime1hz, testRange, baseRange);
        base = [reshape(base_timePlfm1hz(1:(end-1),:),1,[]);reshape(base_censorPlfm1hz(1:(end-1),:),1,[])]';
        for iWin = 1:length(movingWin)
            [timePlfm1hz, censorPlfm1hz] = tagDataLoad(spikeData, lightTime.Plfm1hz+movingWin(iWin), testRange, baseRange);
            test = [timePlfm1hz(end,:);censorPlfm1hz(end,:)]';
            [pLR_Plfm1hzTemp, timeLR_Plfm1hzT{iWin,1},H1_Plfm1hzT{iWin,1},H2_Plfm1hzT{iWin,1}] = logrank(test,base);
            if isempty(pLR_Plfm1hzTemp)
                pLR_Plfm1hzTemp = 1;
            end
            pLR_Plfm1hzT(iWin,1) = pLR_Plfm1hzTemp;
        end
        idxPlfm1hz = find(pLR_Plfm1hzT<alpha,1,'first');
        if isempty(idxPlfm1hz)
            idxPlfm1hz = 1;
        end
        idxH1_Plfm1hz = find(~cellfun(@isempty,H1_Plfm1hzT));
        idxH2_Plfm1hz = find(~cellfun(@isempty,H2_Plfm1hzT));
        idxcom_Plfm1hz = idxH1_Plfm1hz(idxH1_Plfm1hz == idxH2_Plfm1hz);
        for iTest = 1:length(idxcom_Plfm1hz)
            testPlfm(iTest) = all((H1_Plfm1hzT{iTest,:}-H2_Plfm1hzT{iTest,:}) >= -max(H1_Plfm1hzT{iTest,:})*allowance) | all((H2_Plfm1hzT{iTest,:}-H1_Plfm1hzT{iTest,:}) >= -max(H2_Plfm1hzT{iTest,:})*allowance); % H1 should all bigger or smaller than H2 (0.1% allowance)
        end
        idxH_Plfm1hz = idxcom_Plfm1hz(find(testPlfm==1,1,'first'));
        if isempty(idxH_Plfm1hz)
            idxH_Plfm1hz = 1;
        end
        if idxPlfm1hz >= idxH_Plfm1hz
            pLR_Plfm1hz = pLR_Plfm1hzT(idxPlfm1hz);
            timeLR_Plfm1hz = timeLR_Plfm1hzT{idxPlfm1hz};        
            H1_Plfm1hz = H1_Plfm1hzT{idxPlfm1hz};
            H2_Plfm1hz = H2_Plfm1hzT{idxPlfm1hz};
            calibPlfm1hz = movingWin(idxPlfm1hz);
        else
            pLR_Plfm1hz = pLR_Plfm1hzT(idxH_Plfm1hz);
            timeLR_Plfm1hz = timeLR_Plfm1hzT{idxH_Plfm1hz};        
            H1_Plfm1hz = H1_Plfm1hzT{idxH_Plfm1hz};
            H2_Plfm1hz = H2_Plfm1hzT{idxH_Plfm1hz};
            calibPlfm1hz = movingWin(idxH_Plfm1hz);
        end
    end
    
%% Plfm2hz
    if sum(cell2mat(cellfun(@length,spkCriteria_Plfm2hz,'UniformOutput',false)))< spkCriPlfm
        pLR_Plfm2hz = 1;
        [statDir_Plfm2hz, latencyPlfm2hz, timeLR_Plfm2hz, H1_Plfm2hz, H2_Plfm2hz, calibPlfm2hz] = deal(NaN);
    else
        [base_timePlfm2hz,base_censorPlfm2hz] = tagDataLoad(spikeData, baseLightTime2hz, testRange, baseRange);
        base = [reshape(base_timePlfm2hz(1:(end-1),:),1,[]);reshape(base_censorPlfm2hz(1:(end-1),:),1,[])]';
        for iWin = 1:length(movingWin)
            [timePlfm2hz, censorPlfm2hz] = tagDataLoad(spikeData, lightTime.Plfm2hz+movingWin(iWin), testRange, baseRange);
            test = [timePlfm2hz(end,:);censorPlfm2hz(end,:)]';
            [pLR_Plfm2hzTemp, timeLR_Plfm2hzT{iWin,1},H1_Plfm2hzT{iWin,1},H2_Plfm2hzT{iWin,1}] = logrank(test,base);
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
    end
    
    %% Plfm8hz
    if sum(cell2mat(cellfun(@length,spkCriteria_Plfm8hz,'UniformOutput',false)))< spkCriPlfm
        pLR_Plfm8hz = 1;
        [statDir_Plfm8hz, latencyPlfm8hz, timeLR_Plfm8hz, H1_Plfm8hz, H2_Plfm8hz, calibPlfm8hz] = deal(NaN);
    else
        [base_timePlfm8hz,base_censorPlfm8hz] = tagDataLoad(spikeData, baseLightTime8hz, testRange, baseRange);
        base = [reshape(base_timePlfm8hz(1:(end-1),:),1,[]);reshape(base_censorPlfm8hz(1:(end-1),:),1,[])]';
        for iWin = 1:length(movingWin)
            [timePlfm8hz, censorPlfm8hz] = tagDataLoad(spikeData, lightTime.Plfm8hz+movingWin(iWin), testRange, baseRange);
            test = [timePlfm8hz(end,:);censorPlfm8hz(end,:)]';
            [pLR_Plfm8hzTemp, timeLR_Plfm8hzT{iWin,1},H1_Plfm8hzT{iWin,1},H2_Plfm8hzT{iWin,1}] = logrank(test,base);
            if isempty(pLR_Plfm8hzTemp)
                pLR_Plfm8hzTemp = 1;
            end
            pLR_Plfm8hzT(iWin,1) = pLR_Plfm8hzTemp;
        end
        idxPlfm8hz = find(pLR_Plfm8hzT<alpha,1,'first');
        if isempty(idxPlfm8hz)
            idxPlfm8hz = 1;
        end
        idxH1_Plfm8hz = find(~cellfun(@isempty,H1_Plfm8hzT));
        idxH2_Plfm8hz = find(~cellfun(@isempty,H2_Plfm8hzT));
        idxcom_Plfm8hz = idxH1_Plfm8hz(idxH1_Plfm8hz == idxH2_Plfm8hz);
        for iTest = 1:length(idxcom_Plfm8hz)
            testPlfm(iTest) = all((H1_Plfm8hzT{iTest,:}-H2_Plfm8hzT{iTest,:}) >= -max(H1_Plfm8hzT{iTest,:})*allowance) | all((H2_Plfm8hzT{iTest,:}-H1_Plfm8hzT{iTest,:}) >= -max(H2_Plfm8hzT{iTest,:})*allowance); % H1 should all bigger or smaller than H2 (0.1% allowance)
        end
        idxH_Plfm8hz = idxcom_Plfm8hz(find(testPlfm==1,1,'first'));
        if isempty(idxH_Plfm8hz)
            idxH_Plfm8hz = 1;
        end
        if idxPlfm8hz >= idxH_Plfm8hz
            pLR_Plfm8hz = pLR_Plfm8hzT(idxPlfm8hz);
            timeLR_Plfm8hz = timeLR_Plfm8hzT{idxPlfm8hz};        
            H1_Plfm8hz = H1_Plfm8hzT{idxPlfm8hz};
            H2_Plfm8hz = H2_Plfm8hzT{idxPlfm8hz};
            calibPlfm8hz = movingWin(idxPlfm8hz);
        else
            pLR_Plfm8hz = pLR_Plfm8hzT(idxH_Plfm8hz);
            timeLR_Plfm8hz = timeLR_Plfm8hzT{idxH_Plfm8hz};        
            H1_Plfm8hz = H1_Plfm8hzT{idxH_Plfm8hz};
            H2_Plfm8hz = H2_Plfm8hzT{idxH_Plfm8hz};
            calibPlfm8hz = movingWin(idxH_Plfm8hz);
        end
    end
    
    %% Plfm20hz
    if sum(cell2mat(cellfun(@length,spkCriteria_Plfm20hz,'UniformOutput',false)))< spkCriPlfm
        pLR_Plfm20hz = 1;
        [statDir_Plfm20hz, latencyPlfm20hz, timeLR_Plfm20hz, H1_Plfm20hz, H2_Plfm20hz, calibPlfm20hz] = deal(NaN);
    else
        [base_timePlfm20hz,base_censorPlfm20hz] = tagDataLoad(spikeData, baseLightTime20hz, testRange, baseRange);
        base = [reshape(base_timePlfm20hz(1:(end-1),:),1,[]);reshape(base_censorPlfm20hz(1:(end-1),:),1,[])]';
        for iWin = 1:length(movingWin)
            [timePlfm20hz, censorPlfm20hz] = tagDataLoad(spikeData, lightTime.Plfm20hz+movingWin(iWin), testRange, baseRange);
            test = [timePlfm20hz(end,:);censorPlfm20hz(end,:)]';
            [pLR_Plfm20hzTemp, timeLR_Plfm20hzT{iWin,1},H1_Plfm20hzT{iWin,1},H2_Plfm20hzT{iWin,1}] = logrank(test,base);
            if isempty(pLR_Plfm20hzTemp)
                pLR_Plfm20hzTemp = 1;
            end
            pLR_Plfm20hzT(iWin,1) = pLR_Plfm20hzTemp;
        end
        idxPlfm20hz = find(pLR_Plfm20hzT<alpha,1,'first');
        if isempty(idxPlfm20hz)
            idxPlfm20hz = 1;
        end
        idxH1_Plfm20hz = find(~cellfun(@isempty,H1_Plfm20hzT));
        idxH2_Plfm20hz = find(~cellfun(@isempty,H2_Plfm20hzT));
        idxcom_Plfm20hz = idxH1_Plfm20hz(idxH1_Plfm20hz == idxH2_Plfm20hz);
        for iTest = 1:length(idxcom_Plfm20hz)
            testPlfm(iTest) = all((H1_Plfm20hzT{iTest,:}-H2_Plfm20hzT{iTest,:}) >= -max(H1_Plfm20hzT{iTest,:})*allowance) | all((H2_Plfm20hzT{iTest,:}-H1_Plfm20hzT{iTest,:}) >= -max(H2_Plfm20hzT{iTest,:})*allowance); % H1 should all bigger or smaller than H2 (0.1% allowance)
        end
        idxH_Plfm20hz = idxcom_Plfm20hz(find(testPlfm==1,1,'first'));
        if isempty(idxH_Plfm20hz)
            idxH_Plfm20hz = 1;
        end
        if idxPlfm20hz >= idxH_Plfm20hz
            pLR_Plfm20hz = pLR_Plfm20hzT(idxPlfm20hz);
            timeLR_Plfm20hz = timeLR_Plfm20hzT{idxPlfm20hz};        
            H1_Plfm20hz = H1_Plfm20hzT{idxPlfm20hz};
            H2_Plfm20hz = H2_Plfm20hzT{idxPlfm20hz};
            calibPlfm20hz = movingWin(idxPlfm20hz);
        else
            pLR_Plfm20hz = pLR_Plfm20hzT(idxH_Plfm20hz);
            timeLR_Plfm20hz = timeLR_Plfm20hzT{idxH_Plfm20hz};        
            H1_Plfm20hz = H1_Plfm20hzT{idxH_Plfm20hz};
            H2_Plfm20hz = H2_Plfm20hzT{idxH_Plfm20hz};
            calibPlfm20hz = movingWin(idxH_Plfm20hz);
        end
    end
    
    %% Plfm50hz
    if sum(cell2mat(cellfun(@length,spkCriteria_Plfm50hz,'UniformOutput',false)))< spkCriPlfm
        pLR_Plfm50hz = 1;
        [statDir_Plfm50hz, latencyPlfm50hz, timeLR_Plfm50hz, H1_Plfm50hz, H2_Plfm50hz, calibPlfm50hz] = deal(NaN);
    else
        [base_timePlfm50hz,base_censorPlfm50hz] = tagDataLoad(spikeData, baseLightTime50hz, testRange, baseRange);
        base = [reshape(base_timePlfm50hz(1:(end-1),:),1,[]);reshape(base_censorPlfm50hz(1:(end-1),:),1,[])]';
        for iWin = 1:length(movingWin)
            [timePlfm50hz, censorPlfm50hz] = tagDataLoad(spikeData, lightTime.Plfm50hz+movingWin(iWin), testRange, baseRange);
            test = [timePlfm50hz(end,:);censorPlfm50hz(end,:)]';
            [pLR_Plfm50hzTemp, timeLR_Plfm50hzT{iWin,1},H1_Plfm50hzT{iWin,1},H2_Plfm50hzT{iWin,1}] = logrank(test,base);
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
            testPlfm(iTest) = all((H1_Plfm50hzT{iTest,:}-H2_Plfm50hzT{iTest,:}) >= -max(H1_Plfm50hzT{iTest,:})*allowance) | all((H2_Plfm50hzT{iTest,:}-H1_Plfm50hzT{iTest,:}) >= -max(H2_Plfm50hzT{iTest,:})*allowance); % H1 should all bigger or smaller than H2 (0.1% allowance)
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
    end
    save([cellName,'.mat'],'pLR_Plfm1hz','pLR_Plfm2hz','pLR_Plfm8hz','pLR_Plfm20hz','pLR_Plfm50hz','-append')
end
disp('### RespStatTest calculation is done!');

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
% outBin = find(diff(onsetTime)<=(testRange+baseRange));
% outBin = [outBin;outBin+1];
% onsetTime(outBin(:))=[];
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