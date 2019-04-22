function [areaSig] = statCBP_v3(data,base)

%% Data loading
%load('data.mat'); % Subject x Time
narginchk(1,2);
if nargin == 1
    ref = 1+randn(size(data));
else
    ref = base;
end
time = -0.02:0.001:0.099; % [-20 ms, 99 ms]   %% -0.9:0.01:6.9;  must be equal to the size of data
NoS  = size(data, 1); % Number of NoSect

%% Parameter setting
clear Cond1 Cond2 cfg design
Cond1(:,1,:) = data; % Subject x Channel x Time
Cond2(:,1,:) = ref;

clear Cond1Mat
Cond1Mat.label      = cell(1,1);
Cond1Mat.label{1}   = 'MLC11'; % Any channel name
Cond1Mat.fsample    = 1000; % 1ms bin %%100;
Cond1Mat.individual = Cond1;
Cond1Mat.avg        = mean(Cond1,1);
Cond1Mat.time       = time;
Cond1Mat.dimord     = 'subj_chan_time';

clear Cond2Mat
Cond2Mat.label      = cell(1,1);
Cond2Mat.label{1}   = 'MLC11'; % Any channel name
Cond2Mat.fsample    = 1000; % 1ms bin  %%100
Cond2Mat.individual = Cond2;
Cond2Mat.avg        = mean(Cond2,1);
Cond2Mat.time       = time;
Cond2Mat.dimord     = 'subj_chan_time';

cfg                  = [];
cfg.channel          = 1; 
cfg.latency          = [0 0.090]; %[0 6]; % Time of interest
cfg.parameter        = 'individual';
cfg.method           = 'montecarlo';
cfg.statistic        = 'depsamplesT';
cfg.correctm         = 'cluster';
cfg.clusteralpha     = 0.05;
cfg.clusterstatistic = 'maxsum';
cfg.clusterthreshold = 'nonparametric_individual';
cfg.neighbours       = [];
cfg.clustertail      = 0;
cfg.alpha            = 0.05;
cfg.correcttail      = 'alpha';
cfg.tail             = 0;
cfg.numrandomization = 10000; %200;

% Design matrix
design = zeros(2,2*NoS);
for i = 1:NoS
    design(1,i) = i;
end
for i = 1:NoS
    design(1,NoS+i) = i;
end
design(2,1:NoS) = 1;
design(2,NoS+1:2*NoS) = 2;

cfg.design = design;
cfg.uvar   = 1;
cfg.ivar   = 2;

%% RUN !!!
[stat] = ft_timelockstatistics(cfg, Cond1Mat, Cond2Mat);

%% Visualization
sigMat_pos = [];

for i = 1:size(stat.posclusters, 2)
    if stat.posclusters(i).prob < 0.05
        sigMat_pos = [sigMat_pos i];
    end
end

sigMat_neg = [];
for i = 1:size(stat.negclusters, 2)
    if stat.negclusters(i).prob < 0.05
        sigMat_neg = [sigMat_neg i];
    end
end


sigWind = [];
for j = 1:length(sigMat_pos)
    sigWind = [sigWind stat.time(find(stat.posclusterslabelmat==sigMat_pos(j)))];
end
for j = 1:length(sigMat_neg)
    sigWind = [sigWind stat.time(find(stat.negclusterslabelmat==sigMat_neg(j)))];
end

areaSig = sigWind * 1000; % unit change 'sec' to 'ms'
clear Cond1 Cond2
end