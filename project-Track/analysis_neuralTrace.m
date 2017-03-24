function [neuralDist, tracePCA, latentPCA] = analysis_neuralTrace(neuronMatrix)
% function analysis_neural Track calculates neural response distance and
% spike trace (by using PCA)
%  input: neuronMatrix n x m matrix (row: neuron / column: spikes in each time bin)
%   
%   Author: Joonyeup Lee
%   Version 1.0 (3/23/2017)

nBin = size(neuronMatrix,2);
nCell = size(neuronMatrix,1);
neuralDist = zeros(nBin,1);

for iBin = 1:nBin
    neuralDist(iBin,1) = norm(neuronMatrix(iBin)-neuronMatrix(1));
end

[coeffPCA, ~, latentPCA] = pca(neuronMatrix');
tracePCA = neuronMatrix'*coeffPCA;
latentPCA = latentPCA/(sum(latentPCA))*100;
end