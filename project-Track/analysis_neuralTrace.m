function [m_neuralDist, sem_neuralDist, neuralDist, tracePCA, scorePCA, latentPCA] = analysis_neuralTrace(neuronList,winWidth,mvWinStep,baseLine)
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

win = -22:mvWinStep:102;
nBin = length(win)-1;
nCell = size(neuronList,1);
[smth_spike,neuralDist] = deal(zeros(nCell,nBin));
m_neuralDist = zeros(nBin,1);

temp_spike = cellfun(@(x) histc(x,win),neuronList,'UniformOutput',false);
emptyIdx = find(cellfun(@isempty,temp_spike));

for iIdx = 1:length(emptyIdx)
    temp_spike{emptyIdx(iIdx)} = zeros(1,length(win));
end

spike = cell2mat(temp_spike);
spike(:,end) = [];
for iCell = 1:nCell
   smth_spike(iCell,:) = smooth(spike(iCell,:),winWidth); % divided by winWidth
end
spikeBase = cellfun(@(x) sum(double(baseLine(1)<x & x<baseLine(2)))/abs(diff(baseLine)),neuronList); % firing rate (spikes/msec)
for iBin = 1:nBin
%     m_neuralDist(iBin,1) = norm(smth_spike(:,iBin)-spikeBase); %Euclidean distance
    for iCell = 1:nCell
        neuralDist(iCell,iBin) = norm(smth_spike(iCell,iBin)-spikeBase(iCell));
    end
end

% since five bins were averaged, first two and last two bins should be excluded.
% m_neuralDist = m_neuralDist(3:end-2)/nCell;
% m_neuralDist = m_neuralDist(3:end-2);
neuralDist = neuralDist(:,3:end-2);
m_neuralDist = mean(neuralDist,1);
sem_neuralDist = std(neuralDist,0,1)/sqrt(nCell);

[coeffPCA, scorePCA, latentPCA] = pca(smth_spike');
tracePCA = spike'*coeffPCA;
latentPCA = latentPCA/(sum(latentPCA))*100;
end