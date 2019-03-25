function analysis_cscFreqTest
% analysis_cscFreqTest
%
% The function calculated laser response on csc while animals on a platform
% The function will save filtered mean response of light stimulation
% (filtered frequency: 1-20 Hz)
%

sFreq = 2000; % sampling frequency: 2kHz
win1hz = [-1 20]*sFreq; % number of elements
win2hz = [-1 10]*sFreq;
win8hz = [-1 5]*sFreq;
win20hz = [-1 5]*sFreq;
win50hz = [-1 5]*sFreq;
lightIdx = 1:15:300;

[cscTime,cscSample,cscList] = cscLoad;
if isempty(cscList); return; end

nCSC = length(cscList);
for iCSC = 1:nCSC
    disp(['### CSC analysis: ',cscList{iCSC}]);
    [cscPath, cscName,~] = fileparts(cscList{iCSC});
    cd(cscPath);
    
    load Events.mat

    lightOn1hz = lightTime.Plfm1hz(lightIdx);
    lightOn2hz = lightTime.Plfm2hz(lightIdx);
    lightOn8hz = lightTime.Plfm8hz(lightIdx);
    lightOn20hz = lightTime.Plfm20hz(lightIdx);
    lightOn50hz = lightTime.Plfm50hz(lightIdx);

    [idxLight1hz, idxLight2hz, idxLight8hz, idxLight20hz, idxLight50hz] = deal(zeros(20,1));
    for iCycle = 1:20
        idxLight1hz(iCycle) = find(cscTime{1}>lightOn1hz(iCycle),1,'first');
        idxLight2hz(iCycle) = find(cscTime{1}>lightOn2hz(iCycle),1,'first');
        idxLight8hz(iCycle) = find(cscTime{1}>lightOn8hz(iCycle),1,'first');
        idxLight20hz(iCycle) = find(cscTime{1}>lightOn20hz(iCycle),1,'first');
        idxLight50hz(iCycle) = find(cscTime{1}>lightOn50hz(iCycle),1,'first');
    end
    
    temp_cscSample = cscSample{iCSC};
    for iCycle = 1:20
        cscLight1hz(:,iCycle) = temp_cscSample((idxLight1hz(iCycle)+win1hz(1)):(idxLight1hz(iCycle)+win1hz(2)));
        cscLight2hz(:,iCycle) = temp_cscSample((idxLight2hz(iCycle)+win2hz(1)):(idxLight2hz(iCycle)+win2hz(2)));
        cscLight8hz(:,iCycle) = temp_cscSample((idxLight8hz(iCycle)+win8hz(1)):(idxLight8hz(iCycle)+win8hz(2)));
        cscLight20hz(:,iCycle) = temp_cscSample((idxLight20hz(iCycle)+win20hz(1)):(idxLight20hz(iCycle)+win20hz(2)));
        cscLight50hz(:,iCycle) = temp_cscSample((idxLight50hz(iCycle)+win50hz(1)):(idxLight50hz(iCycle)+win50hz(2)));
    end

    m_cscLight1hz = mean(cscLight1hz,2);
    m_cscLight2hz = mean(cscLight2hz,2);
    m_cscLight8hz = mean(cscLight8hz,2);
    m_cscLight20hz = mean(cscLight20hz,2);
    m_cscLight50hz = mean(cscLight50hz,2);
    
    f_cscLight = cell(5,1);
    f_cscLight{1} = bandpassFilter(m_cscLight1hz,sFreq,1,20);
    f_cscLight{2} = bandpassFilter(m_cscLight2hz,sFreq,1,20);
    f_cscLight{3} = bandpassFilter(m_cscLight8hz,sFreq,1,20);
    f_cscLight{4} = bandpassFilter(m_cscLight20hz,sFreq,1,20);
    f_cscLight{5} = bandpassFilter(m_cscLight50hz,sFreq,1,20);

    save([cscName,'.mat'],'f_cscLight');
end