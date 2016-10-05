function trackLightISI
% The function calculates the number of light pulse durint track recording,
% and inter laser interval of each lap.
% time unit of eData: msec

clc; clearvars;

[eData, eList] = eLoad;
nFile = length(eList);
for iFile = 1:nFile
    timeStamp = eData(iFile).t; % unit: msec
    eventString = eData(iFile).s;
    
    recStart = find(strcmp(eventString,'Starting Recording'));
    recEnd = find(strcmp(eventString,'Stopping Recording'));
    
    lightTime = timeStamp(strcmp(eventString,'Light'));
    lightTimeTrack = lightTime(timeStamp(recStart(2))<lightTime & lightTime<timeStamp(recEnd(2)));
    lightISI = diff(lightTimeTrack);
    
    meanISI(iFile,1) = mean(lightISI(lightISI>1000)); % unit: msec
    meanLight(iFile,1) = ceil(length(lightTimeTrack)/30);
end

sessRun = strfind(eList,'Run');
sessRun = ~cellfun(@isempty,sessRun);
meanISI_Run= nanmean(meanISI(sessRun));
semISI_Run = nanstd(meanISI(sessRun))/sum(double(sessRun));
meanLight_Run= sum(meanLight(sessRun))/sum(meanLight(sessRun)~=0);
semLight_Run = std(meanLight(sessRun & (meanLight~=0)))/sum(double(sessRun & meanLight~=0));

sessRw = strfind(eList,'Rw');
sessRw = ~cellfun(@isempty,sessRw);
meanISI_Rw = nanmean(meanISI(sessRw));
semISI_Rw = nanstd(meanISI(sessRw))/sum(double(sessRw));
meanLight_Rw = sum(meanLight(sessRw))/sum(meanLight(sessRw)~=0);
semLight_Rw = std(meanLight(sessRw & (meanLight~=0)))/sum(double(sessRw & meanLight~=0));

save('TrackLightNumber.mat','meanISI_Run','meanLight_Run','semISI_Run','semLight_Run',...
    'meanISI_Rw','meanLight_Rw','semISI_Rw','semLight_Rw');