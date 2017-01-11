function plot_laserIntensity

lineColor = {[144, 164, 174]./255,... % Before stimulation
    [33 150 243]./ 255,... % During stimulation
    [38, 50, 56]./255}; % After stimulation

lineWth = [1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75];
fontS = 4; fontM = 5; fontL = 7; % font size large
lineS = 0.2; lineM = 0.5; lineL = 1; % line width large

colorBlue = [33 150 243] ./ 255;
colorLightBlue = [100 181 246] ./ 255;
colorLLightBlue = [187, 222, 251]./255;
colorRed = [237 50 52] ./ 255;
colorLightRed = [242 138 130] ./ 255;
colorGray = [189 189 189] ./ 255;
colorLightGray = [238, 238, 238] ./255;
colorDarkGray = [117, 117, 117] ./255;
colorYellow = [255 243 3] ./ 255;
colorLightYellow = [255 249 196] ./ 255;
colorBlack = [0, 0, 0];

markerS = 2.2; markerM = 4.4; markerL = 6.6; markerXL = 8.8;
tightInterval = [0.02 0.02]; wideInterval = [0.07 0.07];
width = 0.7;

paperSizeX = [18.3, 8.00];

%%
load('cellList_ori.mat');

DRunPn = T.taskProb == '100' & T.taskType == 'DRun' & T.peakFR_track>1 & T.meanFR_task<criteria_FR;
DRunIn = T.taskProb == '100' & T.taskType == 'DRun' & T.peakFR_track>1 & T.meanFR_task>criteria_FR;
DRwPn = T.taskProb == '100' & T.taskType == 'DRw' & T.peakFR_track>1 & T.meanFR_task<criteria_FR;
DRwIn = T.taskProb == '100' & T.taskType == 'DRw' & T.peakFR_track>1 & T.meanFR_task>criteria_FR;

plfmLight = T.statDir_Plfm2hz ~= 0 & T.pLR_Plfm2hz<0.005;
trackLight = T.statDir_Track ~= 0 & T.pLR_Track<0.005;

% none/either/both : Activated on Platform or Track?
DRunPn_none = DRunPn & ~(plfmLight | trackLight);
DRunPn_either = DRunPn & (plfmLight | trackLight);
DRunPn_both = DRunPn & (plfmLight & trackLight);

DRunIn_none = DRunIn & ~(plfmLight | trackLight);
DRunIn_either = DRunIn & (plfmLight | trackLight);
DRunIn_both = DRunIn & (plfmLight & trackLight);

DRwPn_none = DRwPn & ~(plfmLight | trackLight);
DRwPn_either = DRwPn & (plfmLight | trackLight);
DRwPn_both = DRwPn & (plfmLight & trackLight);

DRwIn_none = DRwIn & ~(plfmLight | trackLight);
DRwIn_either = DRwIn & (plfmLight | trackLight);
DRwIn_both = DRwIn & (plfmLight & trackLight);

