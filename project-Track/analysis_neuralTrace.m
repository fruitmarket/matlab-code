function [neuralDist, tracePCA, latentPCA] = analysis_neuralTrace(neuronList,winSize,mvWinStep,baseLine)
% function analysis_neural Track calculates neural response distance and
% spike trace (by using PCA)
%   input: neuronList 1 x n cell array that each row represents spike times of each neuron 
%   winSize: an integer for window size
%   mvWinStep: moving Window step
%   baseLine: [x, y] start point and end point
%
%   Author: Joonyeup Lee
%   Version 1.0 (3/23/2017)
if nargin == 1
    winSize = 10;
    mvWinStep = 5;
    baseLine = [-20, 0];
elseif nargin == 2 | nargin == 3 | nargin > 4
    error('Neural trace: The function needs four input elements.');
end

win = [0, winSize];
movingWin = -20:mvWinStep:(100-winSize)+1;
nWin = length(movingWin);
nCell = size(neuronList,1);
spike = zeros(nCell,nWin);
neuralDist = zeros(nWin,1);

for iWin = 1:nWin
    spike(:,iWin) = cellfun(@(x) sum(double(win(1)+movingWin(iWin)<x & x<win(2)+movingWin(iWin)))/winSize,neuronList);
end
spikeBase = cellfun(@(x) sum(double(baseLine(1)<x & x<baseLine(2)))/abs(diff(baseLine)),neuronList);

 for iWin = 1:nWin
    neuralDist(iWin,1) = norm(spike(iWin)-spikeBase);
end

[coeffPCA, ~, latentPCA] = pca(spike');
tracePCA = spike'*coeffPCA;
latentPCA = latentPCA/(sum(latentPCA))*100;
end