function [neuralDist, tracePCA, latentPCA] = analysis_neuralTrace(neuronList)
% function analysis_neural Track calculates neural response distance and
% spike trace (by using PCA)
%  input: neuronList 1 x n cell array that each row represents spike times of each neuron 
%   
%   Author: Joonyeup Lee
%   Version 1.0 (3/23/2017)

win = [0, 20];
movingWin = -20:5:80;
nWin = length(movingWin);
nCell = size(neuronList,1);
spikes = zeros(nCell,nWin);

for iWin = 1:nWin
    spikes(:,iWin) = cellfun(@(x) sum(double(win(1)+movingWin(iWin)<x & x<win(2)+movingWin(iWin))),neuronList);
end

 for iWin = 1:nWin
    neuralDist(iWin,1) = norm(spikes(iWin)-spikes(1));
end

[coeffPCA, ~, latentPCA] = pca(spikes');
tracePCA = spikes'*coeffPCA;
latentPCA = latentPCA/(sum(latentPCA))*100;
end