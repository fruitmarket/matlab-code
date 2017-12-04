function myParameters_track

lineColor = {[144, 164, 174]./255,... % Before stimulation
    [33 150 243]./ 255,... % During stimulation
    [38, 50, 56]./255}; % After stimulation

lineWth = [1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75];
fontSS = 4; fontS = 6; fontM = 8; fontL = 10; fontXL = 11;% font size large
lineS = 0.2; lineM = 0.5; lineL = 1; % line width large

colorDarkBlue = [13, 71, 161]/255;
colorBlue = [33, 150, 243]/255;
colorLightBlue = [100, 181, 246]/255;
colorLLightBlue = [187, 222, 251]/255;
colorDarkRed = [183, 28, 28]/255;
colorRed = [237, 50, 52]/255;
colorLightRed = [242, 138, 130]/255;
colorDarkGray = [117, 117, 117]/255;
colorGray = [189, 189, 189]/255;
colorLightGray = [238, 238, 238]/255;
colorDarkGreen = [27, 94, 32]/255;
colorGreen = [56, 142, 60]/255;
colorLightGreen = [67, 160, 71]/255;
colorLightYellow = [255, 249, 196]/255;
colorYellow = [251, 192, 45]/255;
colorDarkYellow = [245, 127, 23]/255;
colorLightPurple = [171, 71, 188]/255;
colorPurple = [123, 31, 162]/255;
colorDarkPurple = [74, 20, 140]/255;
colorBlack = [0, 0, 0];
colorWhite = [1, 1, 1];

markerSSS = 1; markerSS = 2; markerS = 4; markerM = 4.4; markerL = 6.6; markerXL = 8.8;
tightInterval = [0.03 0.03]; midInterval = [0.07, 0.07]; wideInterval = [0.11 0.11];
width = 0.7;

paperSize = {[0 0 21.0 29.7]; % A4_portrait
             [0 0 29.7 21.0]; % A4_landscape
             [0 0 15.7 21.0]; % A4_half landscape
             [0 0 21.6 27.9]}; % Letter

cMeanFR = 9;
cMaxPeakFR = 1;
cSpkpvr = 1.1;
alpha = 0.01;
areaDRun = [5/6 4/3]*pi*20;
areaDRw = [3/2 5/3]*pi*20;
areaRw1 = [1/2 2/3]*pi*20;
areaRw2 = [3/2 5/3]*pi*20;
errorPosi = 5;
correctY = 0.5;
lightBand = 3;

save('myParameters.mat');