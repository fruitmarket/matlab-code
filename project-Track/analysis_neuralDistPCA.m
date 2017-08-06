function [distance, score, latent] = analysis_neuralDistPCA(spike)
%
% spike data format should be nBin X nCell 
% score: PCA x nBin dimension

[~, score, latent] = pca(spike);
score = score';
latent = latent/sum(latent)*100;

pcDimension = score(1:3,:);
pcBase = score(1:3,1);
nBin = size(spike,1);
distance = zeros(nBin,1);

for iBin = 1:nBin
    distance(iBin) = norm(pcDimension(:,iBin) - pcBase);
end
end