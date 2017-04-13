function [m_neuralDist, tracePCA, latentPCA] = analysis_neuralTrace(neuronList,winWidth,mvWinStep,baseLine)
% function analysis_neural Track calculates neural response distance and
% spike trace (by using PCA)
%   input: neuronList 1 x n cell array that each row represents spike times of each neuron 
%   winWidth: an range for window size
%   mvWinStep: moving Window step
%   baseLine: [x, y] start point and end point (unit: msec)
%
%   Author: Joonyeup Lee
%   Version 1.0 (3/23/2017)
if nargin == 1
    winWidth = 10;
    mvWinStep = 5;
    baseLine = [-20, 0];
elseif nargin == 2 | nargin == 3 | nargin > 4
    error('Neural trace: The function needs four input elements.');
end

win = [0, winWidth];
movingWin = -20:mvWinStep:(100-winWidth)+1;
nWin = length(movingWin);
nCell = size(neuronList,1);
spike = zeros(nCell,nWin);
m_neuralDist = zeros(nWin,1);

for iWin = 1:nWin
    spike(:,iWin) = cellfun(@(x) sum(double(win(1)+movingWin(iWin)<x & x<win(2)+movingWin(iWin)))/winWidth,neuronList);     % spikes/ms
end
spikeBase = cellfun(@(x) sum(double(baseLine(1)<x & x<baseLine(2)))/abs(diff(baseLine)),neuronList);

 for iWin = 1:nWin
    m_neuralDist(iWin,1) = norm(spike(:,iWin)-spikeBase);
end

[coeffPCA, ~, latentPCA] = pca(spike');
tracePCA = spike'*coeffPCA;
latentPCA = latentPCA/(sum(latentPCA))*100;
end