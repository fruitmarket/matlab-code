function [redraw, rekey, undoable] = ShowWaveformDensity(iClust)

% ShowWaveformDensity(iClust)
%
% INPUTS
%    iClust
%
% OUTPUTS
%
% NONE
% TO USE WITH MCLUST, put this in the MClust/ClusterOptions folder

% ADR 2003
%
% Status: PROMOTED (Release version) 
% See documentation for copyright (owned by original authors) and warranties (none!).
% This code released as part of MClust 3.0.
% Version control M3.0.
% Extensively modified by ADR to accomodate new ClusterOptions methodology

redraw = false; rekey = false; undoable = false; % don't need to update

        global MClust_TTData MClust_Clusters MClust_FeatureData MClust_ChannelValidity MClust_TTfn
        subsample_limit = 4000;
        goodch = find(MClust_ChannelValidity==1);
        f = FindInCluster(MClust_Clusters{iClust});
        
        if length(f) == 0
            run_avg_waveform = 0;
            msgbox('No points in cluster.')
            return
        end
        % Get a subsample because the density plot uses a lot of resources.
        r = randperm(length(f));
        subf = sort(f(r(1:min([subsample_limit length(r)]))));
        
        wv = ExtractCluster(MClust_TTData, subf);
        wv = Data(wv);
		
		mnwv = min(min(min(wv)));
		mxwv = max(max(max(wv)));
		
		[p,n,e] = fileparts(MClust_TTfn);
		WV_Density_Handle = figure('Name',['Waveform Density: ' [n e] ' Cluster ' num2str(iClust) ]); 
        for ii = 1:length(goodch)
			if length(goodch <= 4)
				subplot(2,2,goodch(ii));
			else
				nRows = floor(sqrt(length(goodch)));
				nCols = ceil(length(goodch)/nRows);
				subplot(nRows,nCols,ii)
			end
			figure(WV_Density_Handle);
            Waveform_density(squeeze(wv(:,goodch(ii),:)),1,2000,'mxwv',mxwv,'mnwv',mnwv); 
            %imagesc(H);
            title(['Channel ' num2str(goodch(ii))]);
			set(gca,'Xtick',[],'Ytick',[]);
			drawnow;
        end
