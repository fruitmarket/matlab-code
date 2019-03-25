function pethLight50hz()
% function pethLight(criteria_multi,criteria_add)
% Check whether the cell has light response or not.
% It calculates both in-block and between-block responses.
% criteria (%)
%   
%   Author: Joonyeup Lee
%   Version 1.0 (7/25/2016)

% Task variables
resolution = 10; % sigma = resoution * binSize = 100 msec
winTrack = [0 20];

% Tag variables
winPlfm2hz = [-25 475]; % unit: msec
winPlfm50hz = [0 20];
binSizeBlue = 2;

winCri = 20; % light effect criteria: 20ms

[tData, tList] = tLoad;
nCell = length(tList);

for iCell = 1:nCell
    disp(['### pethLight analysis: ',tList{iCell},'...']);
    [cellPath, cellName, ~] = fileparts(tList{iCell});
    cd(cellPath);
    
    % Load Events variables
    load('Events.mat');    
    % Load spike data
    % tData{iCell} unit: msec

% Light - ontrack
    if ~isempty(lightTime.Track50hz); % ChETA
        spikeTimeTrackLight = spikeWin(tData{iCell},lightTime.Track50hz,winTrack);
        [xptTrackLight, yptTrackLight, pethtimeTrackLight, pethTrackLight,pethTrackLightConv,pethTrackLightConvZ] = rasterPETH(spikeTimeTrackLight,true(size(lightTime.Track50hz)),winTrack,binSizeBlue,resolution,1);     
        lightSpk = sum(0<xptTrackLight{1} & xptTrackLight{1}<winCri);
        lightPreSpk = sum(-winCri<xptTrackLight{1} & xptTrackLight{1}<0);
        lightPostSpk = sum(winCri<xptTrackLight{1} & xptTrackLight{1}<2*winCri);      
        
        save([cellName,'.mat'],'spikeTimeTrackLight','xptTrackLight','yptTrackLight','pethtimeTrackLight','pethTrackLight','pethTrackLightConv','pethTrackLightConvZ','lightSpk','lightPreSpk','lightPostSpk','-append');
    end
    
% Pseudo light (On track)
    if exist('psdlightPre','var') && exist('psdlightPost','var')
        spikeTime_psdPre = spikeWin(tData{iCell},psdlightPre,winTrack); % Pseudo light Pre
        [xptPsdPre, yptPsdPre, pethtimePsdPre, pethPsdPre,pethPsdPreConv,pethPsdPreConvZ] = rasterPETH(spikeTime_psdPre,true(size(psdlightPre)),winTrack,binSizeBlue,resolution,1);
        spikeTime_psdPost = spikeWin(tData{iCell},psdlightPost,winTrack); % Pseudo light Post
        [xptPsdPost, yptPsdPost, pethtimePsdPost, pethPsdPost,pethPsdPostConv,pethPsdPostConvZ] = rasterPETH(spikeTime_psdPost,true(size(psdlightPost)),winTrack,binSizeBlue,resolution,1);
        psdPreSpk = sum(0<xptPsdPre{1} & xptPsdPre{1}<winCri);
        psdPostSpk = sum(0<xptPsdPost{1} & xptPsdPost{1}<winCri);
        
        save([cellName,'.mat'],'xptPsdPre','yptPsdPre','pethtimePsdPre','psdPreSpk','pethPsdPreConv','pethPsdPreConvZ','xptPsdPost','yptPsdPost','pethtimePsdPost','psdPostSpk','pethPsdPostConv','pethPsdPostConvZ','-append');
    end
    
% Light (Plfm) 8mw analysis [201:400]
    if isfield(lightTime,'Plfm2hz') % Activation (ChETA)
       spikeTimePlfm2hz = spikeWin(tData{iCell},lightTime.Plfm2hz(201:400),winPlfm2hz);
       [xptPlfm2hz, yptPlfm2hz, pethtimePlfm2hz, pethPlfm2hz,pethPlfm2hzConv,pethPlfm2hzConvZ] = rasterPETH(spikeTimePlfm2hz,true(size(lightTime.Plfm2hz(201:400))),winPlfm2hz,binSizeBlue,resolution,1);
       lightSpkPlfm2hz = sum(0<xptPlfm2hz{1} & xptPlfm2hz{1}<winCri);
       lightSpkPlfm2hz_pre = sum(-winCri<xptPlfm2hz{1} & xptPlfm2hz{1}<0);
       lightSpkPlfm2hz_post = sum(winCri<xptPlfm2hz{1} & xptPlfm2hz{1}<2*winCri);
       
       save([cellName,'.mat'],'spikeTimePlfm2hz','xptPlfm2hz','yptPlfm2hz','pethtimePlfm2hz','pethPlfm2hz','lightSpkPlfm2hz','pethPlfm2hzConv','pethPlfm2hzConvZ','lightSpkPlfm2hz_pre','lightSpkPlfm2hz_post','-append');
    end
    
    if isfield(lightTime,'Plfm50hz') & ~isempty(lightTime.Plfm50hz);
        spikeTimePlfm50hz = spikeWin(tData{iCell},lightTime.Plfm50hz,winPlfm50hz);
        [xptPlfm50hz, yptPlfm50hz, pethtimePlfm50hz, pethPlfm50hz,pethPlfm50hzConv,pethPlfm50hzConvZ] = rasterPETH(spikeTimePlfm50hz,true(size(lightTime.Plfm50hz)),winPlfm50hz,binSizeBlue,resolution,1);
        lightSpkPlfm50hz = sum(0<xptPlfm50hz{1} & xptPlfm50hz{1}<winCri);
        lightSpkPlfm50hz_pre = sum(-winCri<xptPlfm50hz{1} & xptPlfm50hz{1}<0);
        lightSpkPlfm50hz_post = sum(winCri<xptPlfm50hz{1} & xptPlfm50hz{1}<2*winCri);
        save([cellName,'.mat'],'spikeTimePlfm50hz','xptPlfm50hz','yptPlfm50hz','pethtimePlfm50hz','pethPlfm50hz','pethPlfm50hzConv','pethPlfm50hzConvZ','lightSpkPlfm50hz','lightSpkPlfm50hz_pre','lightSpkPlfm50hz_post','-append');
    else
        [spikeTimePlfm50hz,xptPlfm50hz,yptPlfm50hz,pethtimePlfm50hz,pethPlfm50hz,pethPlfm50hzConv,pethPlfm50hzConvZ,lightSpkPlfm50hz,lightSpkPlfm50hz_pre,lightSpkPlfm50hz_post] = deal(NaN);
        save([cellName,'.mat'],'spikeTimePlfm50hz','xptPlfm50hz','yptPlfm50hz','pethtimePlfm50hz','pethPlfm50hz','pethPlfm50hzConv','pethPlfm50hzConvZ','lightSpkPlfm50hz','lightSpkPlfm50hz_pre','lightSpkPlfm50hz_post','-append');
    end
end
disp('### pethLight50hz is done! ###');