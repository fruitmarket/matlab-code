function [m_neuralDist, neuralDist, tracePCA, scorePCA, latentPCA] = analysis_neuralTrace(neuronList,winWidth,mvWinStep,baseLine)
% function analysis_neural Track calculates neural response distance and
% spike trace (by using PCA)
%   input: neuronList 1 x n cell array that each row represents spike times of each neuron 
%       winWidth: an range for window size
%       mvWinStep: moving Window step
%       baseLine: [x, y] start point and end point (unit: msec)
%   output:
%       m_neuralDist: mean neural dist of total neurons
%       neuralDist: each row represents neural dist of one neuron
%       tracePCA: pca results
%       scoePCA: now use score value
%       LatentPCA: representation proportion
%   Author: Joonyeup Lee
%   Version 1.0 (3/23/2017)
if nargin == 1
    winWidth = 5;
    mvWinStep = 1;
    baseLine = [-20, 0];
elseif nargin == 2 | nargin == 3 | nargin > 4
    error('Neural trace: The function needs four input elements.');
end

% win = [0, winWidth];
bin = -20:mvWinStep:100;
nBin = length(bin)-1;
nCell = size(neuronList,1);
[smth_spike,neuralDist] = deal(zeros(nCell,nBin));
m_neuralDist = zeros(nBin,1);

temp_spike = cellfun(@(x) histc(x,-20:100),neuronList,'UniformOutput',false);
emptyIdx = find(cellfun(@isempty,temp_spike));

for iIdx = 1:length(emptyIdx)
    temp_spike{emptyIdx(iIdx)} = zeros(1,length(bin));
end

spike = cell2mat(temp_spike);
spike(:,end) = [];
for iCell = 1:nCell
   smth_spike(iCell,:) = smooth(spike(iCell,:),winWidth);
end
spikeBase = cellfun(@(x) sum(double(baseLine(1)<x & x<baseLine(2)))/abs(diff(baseLine)),neuronList);


for iCell = 1:nCell
    for iBin = 1:nBin
    neuralDist(iCell,iBin) = norm(smth_spike(iCell,iBin)-spikeBase(iCell));
    m_neuralDist(iBin,1) = norm(smth_spike(:,iBin)-spikeBase);
    end
end
neuralDist = neuralDist(:,3:end-2);
m_neuralDist = m_neuralDist(3:end-2)/nCell;

% for iWin = 1:nBin
%     spike(:,iWin) = cellfun(@(x) sum(double(win(1)+movingWin(iWin)<x & x<win(2)+movingWin(iWin)))/winWidth,neuronList);     % spikes/ms
% end
% spikeBase = cellfun(@(x) sum(double(baseLine(1)<x & x<baseLine(2)))/abs(diff(baseLine)),neuronList);
% 
% for iCell = 1:nCell
%     for iBin = 1:nBin
%     neuralDist(iCell,iBin) = norm(spike(iCell,iBin)-spikeBase(iCell));
%     m_neuralDist(iBin,1) = norm(spike(:,iBin)-spikeBase);
%     end
% end
% m_neuralDist = m_neuralDist/nCell;

[coeffPCA, scorePCA, latentPCA] = pca(smth_spike');
tracePCA = spike'*coeffPCA;
latentPCA = latentPCA/(sum(latentPCA))*100;
end