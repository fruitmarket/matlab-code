function CompareMeans(varargin)

% CompareMeans
% Written by Baldwin Goodell
% Montana State University
% Charlie Gray Lab
% 30 September 2003
%
% Put this in the ClusterOptions directory
%
%plots means of all selected clusters on a single figure
%with a signal to noise ratio defined as max mean negativity divided by
%3 sigma of noise calculated from first point of extracted signal.


global MClust_TTData MClust_Clusters MClust_FeatureData
global MClust_Colors

numClusters = length(MClust_Clusters);
c = 1:numClusters;
[templates,status] = listdlg('PromptString','Select Waveform channels:','SelectionMode','multiple',...
    'ListString',cellstr(num2str(c')),'ListSize',[160 (numClusters-1)*18]);
if status~=1
    return;
end
%plot templates 
figure;
amin=0;amax=0;  %initialize y axis limits
for i=1:length(templates)
    %which spikes in this cluster?
    f = FindInCluster(MClust_Clusters{templates(i)});
%     f = FindInCluster(MClust_Clusters{templates(i)}, MClust_FeatureData);
    %get data of the spikes in this cluster
    clustTT  = ExtractCluster(MClust_TTData, f); 
    WVD = Data(clustTT);    %waveform data for this cluster
    mWV = squeeze(mean(WVD,1));
    
    %find signal to noise ratio based on max mean negativity divided by
    %3 sigma of noise calculated from first point of extracted signal.
    [y,ii] = max(max(mWV,[],2));
    amax = max(amax,y);
    [y,ii] = min(min(mWV,[],2));
    amin = min(amin,y);
    
    SN = abs(y/(3*std(WVD(:,ii,1))));
    nptSubplot(length(templates),i)
    cha=size(mWV,1);
    for it = 1:cha
        xrange = (34 * (it-1)) + (1:32); 
        hold on
        mean_handle(it) = plot(xrange, mWV(it,:),'Color',MClust_Colors(templates(i)+1,:),'lineWidth',3);
    end
    title(['Cluster ' num2str(templates(i)) '    S/N: ' num2str(SN)]) 
end
for i=1:length(templates)
    nptSubplot(length(templates),i)
    axis([0  max(xrange) 1.1*amin 1.1*amax]);
end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function nptSubplot(n,p)
%nptSubplot(n,p)
%subplot with n being total number of plots
%and p being the current plot.
%this function decides how to split up 
%the axis space.  Useful when calling subplot with 
%a variable number of subplots.

switch n
    case 1
        r=1;c=1;
    case 2 
        r=1;c=2;
    case 3
        r=1;c=3;
    case 4
        r=2;c=2;
    case {5,6}
        r=2;c=3;
    case {7,8,9}
        r=3;c=3;
    case {10,11,12}
        r=3;c=4;
    case {13,14,15,16}
            r=4;c=4;
    case {17,18,19,20}
        r=4;c=5;
    otherwise
        r=5;
        c=ceil(n/5);
end

        
       
subplot(r,c,p)