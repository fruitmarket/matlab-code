% Latency of neurons which are activated on the platform. (Blue)
% Among neurons which are activated on the platform, latency of neurons which are also activated on the track
clearvars;
lineColor = {[144, 164, 174]./255,... % Before stimulation
    [33 150 243]./ 255,... % During stimulation
    [38, 50, 56]./255}; % After stimulation

lineWth = [1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75];
fontS = 4; fontM = 6; fontL = 8; fontXL = 10;% font size large
lineS = 0.2; lineM = 0.5; lineL = 1; % line width large

colorBlue = [33, 150, 243]/255;
colorLightBlue = [100, 181, 246]/255;
colorLLightBlue = [187, 222, 251]/255;
colorRed = [237, 50, 52]/255;
colorLightRed = [242, 138, 130]/255;
colorGray = [189, 189, 189]/255;
colorGreen = [46, 125, 50]/255;
colorLightGray = [238, 238, 238]/255;
colorDarkGray = [117, 117, 117]/255;
colorYellow = [255, 216, 53]/255;
colorLightYellow = [255, 249, 196]/255;
colorPurple = [123, 31, 162]/255;
colorBlack = [0, 0, 0];
colorWhite = [1, 1, 1];
markerSS = 1.95; markerS = 4; markerM = 4.4; markerL = 6.6; markerXL = 8.8;
tightInterval = [0.02 0.02]; midInterval = [0.09, 0.09]; wideInterval = [0.14 0.14];
width = 0.7;

paperSize = {[0 0 21.0 29.7]; % A4_portrait
             [0 0 29.7 21.0]; % A4_landscape
             [0 0 15.7 21.0]; % A4_half landscape
             [0 0 21.6 27.9]}; % Letter

cd('D:\Dropbox\SNL\P2_Track');
load('neuronList_ori_170421.mat');

cMeanFR = 9;
cMaxPeakFR = 0.1;
cSpkpvr = 1.1;
condiPN = T.spkpvr>cSpkpvr & T.meanFR_task<cMeanFR;
condiIN = ~condiPN;
alpha = 0.01;
areaDRun = [5/6 4/3]*pi*20;
areaDRw = [3/2 5/3]*pi*20;
areaRw1 = [1/2 2/3]*pi*20;
areaRw2 = [3/2 5/3]*pi*20;
errorPosi = 5;
correctY = 0.5;
lightBand = 3;
%% DRun sessions
DRunTN = (T.taskType == 'DRun') & (cellfun(@max, T.peakFR1D_track) > cMaxPeakFR) & ~(cellfun(@(x) any(isnan(x)),T.peakloci_total));
DRunPN = DRunTN & condiPN;
DRunIN = DRunTN & condiIN;

% DRunPN
nCell_DRunPN = sum(double(DRunPN));
normTrackFR_DRunPN = T.normTrackFR_total(DRunPN);
temp_peakloci_DRunPN = T.peakloci_total(DRunPN);
lightResp_track_DRunPN = double(T.pLR_Track(DRunPN)<alpha);
lightAct_track_DRunPN = double(T.pLR_Track(DRunPN)<alpha & T.statDir_Track(DRunPN)==1);
lightIna_track_DRunPN = double(T.pLR_Track(DRunPN)<alpha & T.statDir_Track(DRunPN)==-1);
lightResp_plfm_DRunPN = double(T.pLR_Plfm2hz(DRunPN)<alpha);

normTrackFR_DRunPN(:,2) = num2cell(cellfun(@(x) x(1),temp_peakloci_DRunPN)); % position of peak firing rate
normTrackFR_DRunPN(:,3) = num2cell(lightResp_track_DRunPN); % Resp population
normTrackFR_DRunPN(:,4) = num2cell(lightAct_track_DRunPN); % Act population
normTrackFR_DRunPN(:,5) = num2cell(lightIna_track_DRunPN); % Ina population

normTrackFR_DRunPN = sortrows(normTrackFR_DRunPN,-2);
normTrackFR_DRunPN = cell2mat(normTrackFR_DRunPN);
lightResp_idx_DRunPN = find(normTrackFR_DRunPN(:,126));
lightAct_idx_DRunPN = find(normTrackFR_DRunPN(:,127));
lightIna_idx_DRunPN = find(normTrackFR_DRunPN(:,128));
lightResp_plfm_idx_DRunPN = find(lightResp_plfm_DRunPN);

inStmzoneResp_DRunPN = sum(double((areaDRun(1)<=normTrackFR_DRunPN(:,125) & normTrackFR_DRunPN(:,125)<=areaDRun(2)) & normTrackFR_DRunPN(:,126)==1));
inStmzoneNoResp_DRunPN = sum(double((areaDRun(1)<=normTrackFR_DRunPN(:,125) & normTrackFR_DRunPN(:,125)<=areaDRun(2)) & normTrackFR_DRunPN(:,126)==0));
outStmzoneResp_DRunPN = sum(double(~(areaDRun(1)<normTrackFR_DRunPN(:,125) & normTrackFR_DRunPN(:,125)<areaDRun(2)) & normTrackFR_DRunPN(:,126)==1));
outStmzoneNoResp_DRunPN = sum(double(~(areaDRun(1)<normTrackFR_DRunPN(:,125) & normTrackFR_DRunPN(:,125)<areaDRun(2)) & normTrackFR_DRunPN(:,126)==0));

inStmzoneAct_DRunPN = sum(double((areaDRun(1)<=normTrackFR_DRunPN(:,125) & normTrackFR_DRunPN(:,125)<=areaDRun(2)) & normTrackFR_DRunPN(:,127)==1));
inStmzoneNoAct_DRunPN = sum(double((areaDRun(1)<=normTrackFR_DRunPN(:,125) & normTrackFR_DRunPN(:,125)<=areaDRun(2)) & normTrackFR_DRunPN(:,127)==0));
outStmzoneAct_DRunPN = sum(double(~(areaDRun(1)<normTrackFR_DRunPN(:,125) & normTrackFR_DRunPN(:,125)<areaDRun(2)) & normTrackFR_DRunPN(:,127)==1));
outStmzoneNoAct_DRunPN = sum(double(~(areaDRun(1)<normTrackFR_DRunPN(:,125) & normTrackFR_DRunPN(:,125)<areaDRun(2)) & normTrackFR_DRunPN(:,127)==0));

inStmzoneIna_DRunPN = sum(double((areaDRun(1)<=normTrackFR_DRunPN(:,125) & normTrackFR_DRunPN(:,125)<=areaDRun(2)) & normTrackFR_DRunPN(:,128)==1));
inStmzoneNoIna_DRunPN = sum(double((areaDRun(1)<=normTrackFR_DRunPN(:,125) & normTrackFR_DRunPN(:,125)<=areaDRun(2)) & normTrackFR_DRunPN(:,128)==0));
outStmzoneIna_DRunPN = sum(double(~(areaDRun(1)<normTrackFR_DRunPN(:,125) & normTrackFR_DRunPN(:,125)<areaDRun(2)) & normTrackFR_DRunPN(:,128)==1));
outStmzoneNoIna_DRunPN = sum(double(~(areaDRun(1)<normTrackFR_DRunPN(:,125) & normTrackFR_DRunPN(:,125)<areaDRun(2)) & normTrackFR_DRunPN(:,128)==0));

statResp_DRunPN = chisqNxN([inStmzoneResp_DRunPN, inStmzoneNoResp_DRunPN; outStmzoneResp_DRunPN outStmzoneNoResp_DRunPN]);
statAct_DRunPN = chisqNxN([inStmzoneAct_DRunPN, inStmzoneNoAct_DRunPN; outStmzoneAct_DRunPN outStmzoneNoAct_DRunPN]);
statIna_DRunPN = chisqNxN([inStmzoneIna_DRunPN, inStmzoneNoIna_DRunPN; outStmzoneIna_DRunPN outStmzoneNoIna_DRunPN]);

% DRunIN
nCell_DRunIN = sum(double(DRunIN));
normTrackFR_DRunIN = T.normTrackFR_total(DRunIN);
temp_peakloci_DRunIN = T.peakloci_total(DRunIN);
lightResp_track_DRunIN = double(T.pLR_Track(DRunIN)<alpha);
lightAct_track_DRunIN = double(T.pLR_Track(DRunIN)<alpha & T.statDir_Track(DRunIN)==1);
lightIna_track_DRunIN = double(T.pLR_Track(DRunIN)<alpha & T.statDir_Track(DRunIN)==-1);
lightResp_plfm_DRunIN = double(T.pLR_Plfm2hz(DRunIN)<alpha);

normTrackFR_DRunIN(:,2) = num2cell(cellfun(@(x) x(1),temp_peakloci_DRunIN));
normTrackFR_DRunIN(:,3) = num2cell(lightResp_track_DRunIN); % Resp population
normTrackFR_DRunIN(:,4) = num2cell(lightAct_track_DRunIN); % Act population
normTrackFR_DRunIN(:,5) = num2cell(lightIna_track_DRunIN); % Ina population

normTrackFR_DRunIN = sortrows(normTrackFR_DRunIN,-2);
normTrackFR_DRunIN = cell2mat(normTrackFR_DRunIN);
lightResp_idx_DRunIN = find(normTrackFR_DRunIN(:,126));
lightAct_idx_DRunIN = find(normTrackFR_DRunIN(:,127));
lightIna_idx_DRunIN = find(normTrackFR_DRunIN(:,128));
lightResp_plfm_idx_DRunIN = find(lightResp_plfm_DRunIN);

inStmzoneResp_DRunIN = sum(double((areaDRun(1)<=normTrackFR_DRunIN(:,125) & normTrackFR_DRunIN(:,125)<=areaDRun(2)) & normTrackFR_DRunIN(:,126)==1));
inStmzoneNoResp_DRunIN = sum(double((areaDRun(1)<=normTrackFR_DRunIN(:,125) & normTrackFR_DRunIN(:,125)<=areaDRun(2)) & normTrackFR_DRunIN(:,126)==0));
outStmzoneResp_DRunIN = sum(double(~(areaDRun(1)<normTrackFR_DRunIN(:,125) & normTrackFR_DRunIN(:,125)<areaDRun(2)) & normTrackFR_DRunIN(:,126)==1));
outStmzoneNoResp_DRunIN = sum(double(~(areaDRun(1)<normTrackFR_DRunIN(:,125) & normTrackFR_DRunIN(:,125)<areaDRun(2)) & normTrackFR_DRunIN(:,126)==0));

inStmzoneAct_DRunIN = sum(double((areaDRun(1)<=normTrackFR_DRunIN(:,125) & normTrackFR_DRunIN(:,125)<=areaDRun(2)) & normTrackFR_DRunIN(:,127)==1));
inStmzoneNoAct_DRunIN = sum(double((areaDRun(1)<=normTrackFR_DRunIN(:,125) & normTrackFR_DRunIN(:,125)<=areaDRun(2)) & normTrackFR_DRunIN(:,127)==0));
outStmzoneAct_DRunIN = sum(double(~(areaDRun(1)<normTrackFR_DRunIN(:,125) & normTrackFR_DRunIN(:,125)<areaDRun(2)) & normTrackFR_DRunIN(:,127)==1));
outStmzoneNoAct_DRunIN = sum(double(~(areaDRun(1)<normTrackFR_DRunIN(:,125) & normTrackFR_DRunIN(:,125)<areaDRun(2)) & normTrackFR_DRunIN(:,127)==0));

inStmzoneIna_DRunIN = sum(double((areaDRun(1)<=normTrackFR_DRunIN(:,125) & normTrackFR_DRunIN(:,125)<=areaDRun(2)) & normTrackFR_DRunIN(:,128)==1));
inStmzoneNoIna_DRunIN = sum(double((areaDRun(1)<=normTrackFR_DRunIN(:,125) & normTrackFR_DRunIN(:,125)<=areaDRun(2)) & normTrackFR_DRunIN(:,128)==0));
outStmzoneIna_DRunIN = sum(double(~(areaDRun(1)<normTrackFR_DRunIN(:,125) & normTrackFR_DRunIN(:,125)<areaDRun(2)) & normTrackFR_DRunIN(:,128)==1));
outStmzoneNoIna_DRunIN = sum(double(~(areaDRun(1)<normTrackFR_DRunIN(:,125) & normTrackFR_DRunIN(:,125)<areaDRun(2)) & normTrackFR_DRunIN(:,128)==0));

statResp_DRunIN = chisqNxN([inStmzoneResp_DRunIN, inStmzoneNoResp_DRunIN; outStmzoneResp_DRunIN outStmzoneNoResp_DRunIN]);
statAct_DRunIN = chisqNxN([inStmzoneAct_DRunIN, inStmzoneNoAct_DRunIN; outStmzoneAct_DRunIN outStmzoneNoAct_DRunIN]);
statIna_DRunIN = chisqNxN([inStmzoneIna_DRunIN, inStmzoneNoIna_DRunIN; outStmzoneIna_DRunIN outStmzoneNoIna_DRunIN]);


%% DRw sessions
DRwTN = (T.taskType == 'DRw') & (cellfun(@max, T.peakFR1D_track) > cMaxPeakFR) & ~(cellfun(@(x) any(isnan(x)),T.peakloci_total));
DRwPN = DRwTN & condiPN;
DRwIN = DRwTN & condiIN;

nCell_DRwPN = sum(double(DRwPN));
normTrackFR_DRwPN = T.normTrackFR_total(DRwPN);
temp_peakloci_DRwPN = T.peakloci_total(DRwPN);
lightResp_track_DRwPN = double(T.pLR_Track(DRwPN)<alpha);
lightAct_track_DRwPN = double(T.pLR_Track(DRwPN)<alpha & T.statDir_Track(DRwPN)==1);
lightIna_track_DRwPN = double(T.pLR_Track(DRwPN)<alpha & T.statDir_Track(DRwPN)==-1);
lightResp_plfm_DRwPN = double(T.pLR_Plfm2hz(DRwPN)<alpha);

normTrackFR_DRwPN(:,2) = num2cell(cellfun(@(x) x(1),temp_peakloci_DRwPN));
normTrackFR_DRwPN(:,3) = num2cell(lightResp_track_DRwPN);
normTrackFR_DRwPN(:,4) = num2cell(lightAct_track_DRwPN); % Act population
normTrackFR_DRwPN(:,5) = num2cell(lightIna_track_DRwPN); % Ina population

normTrackFR_DRwPN = sortrows(normTrackFR_DRwPN,-2);
normTrackFR_DRwPN = cell2mat(normTrackFR_DRwPN);
lightResp_idx_DRwPN = find(normTrackFR_DRwPN(:,126));
lightAct_idx_DRwPN = find(normTrackFR_DRwPN(:,127));
lightIna_idx_DRwPN = find(normTrackFR_DRwPN(:,128));
lightResp_plfm_idx_DRwPN = find(lightResp_plfm_DRwPN);

inStmzoneResp_DRwPN = sum(double((areaDRw(1)<=normTrackFR_DRwPN(:,125) & normTrackFR_DRwPN(:,125)<=areaDRw(2)) & normTrackFR_DRwPN(:,126)==1));
inStmzoneNoResp_DRwPN = sum(double((areaDRw(1)<=normTrackFR_DRwPN(:,125) & normTrackFR_DRwPN(:,125)<=areaDRw(2)) & normTrackFR_DRwPN(:,126)==0));
outStmzoneResp_DRwPN = sum(double(~(areaDRw(1)<normTrackFR_DRwPN(:,125) & normTrackFR_DRwPN(:,125)<areaDRw(2)) & normTrackFR_DRwPN(:,126)==1));
outStmzoneNoResp_DRwPN = sum(double(~(areaDRw(1)<normTrackFR_DRwPN(:,125) & normTrackFR_DRwPN(:,125)<areaDRw(2)) & normTrackFR_DRwPN(:,126)==0));

inStmzoneAct_DRwPN = sum(double((areaDRw(1)<=normTrackFR_DRwPN(:,125) & normTrackFR_DRwPN(:,125)<=areaDRw(2)) & normTrackFR_DRwPN(:,127)==1));
inStmzoneNoAct_DRwPN = sum(double((areaDRw(1)<=normTrackFR_DRwPN(:,125) & normTrackFR_DRwPN(:,125)<=areaDRw(2)) & normTrackFR_DRwPN(:,127)==0));
outStmzoneAct_DRwPN = sum(double(~(areaDRw(1)<normTrackFR_DRwPN(:,125) & normTrackFR_DRwPN(:,125)<areaDRw(2)) & normTrackFR_DRwPN(:,127)==1));
outStmzoneNoAct_DRwPN = sum(double(~(areaDRw(1)<normTrackFR_DRwPN(:,125) & normTrackFR_DRwPN(:,125)<areaDRw(2)) & normTrackFR_DRwPN(:,127)==0));

inStmzoneIna_DRwPN = sum(double((areaDRw(1)<=normTrackFR_DRwPN(:,125) & normTrackFR_DRwPN(:,125)<=areaDRw(2)) & normTrackFR_DRwPN(:,128)==1));
inStmzoneNoIna_DRwPN = sum(double((areaDRw(1)<=normTrackFR_DRwPN(:,125) & normTrackFR_DRwPN(:,125)<=areaDRw(2)) & normTrackFR_DRwPN(:,128)==0));
outStmzoneIna_DRwPN = sum(double(~(areaDRw(1)<normTrackFR_DRwPN(:,125) & normTrackFR_DRwPN(:,125)<areaDRw(2)) & normTrackFR_DRwPN(:,128)==1));
outStmzoneNoIna_DRwPN = sum(double(~(areaDRw(1)<normTrackFR_DRwPN(:,125) & normTrackFR_DRwPN(:,125)<areaDRw(2)) & normTrackFR_DRwPN(:,128)==0));

statResp_DRwPN = chisqNxN([inStmzoneResp_DRwPN, inStmzoneNoResp_DRwPN; outStmzoneResp_DRwPN outStmzoneNoResp_DRwPN]);
statAct_DRwPN = chisqNxN([inStmzoneAct_DRwPN, inStmzoneNoAct_DRwPN; outStmzoneAct_DRwPN outStmzoneNoAct_DRwPN]);
statIna_DRwPN = chisqNxN([inStmzoneIna_DRwPN, inStmzoneNoIna_DRwPN; outStmzoneIna_DRwPN outStmzoneNoIna_DRwPN]);

% DRwIN
nCell_DRwIN = sum(double(DRwIN));
normTrackFR_DRwIN = T.normTrackFR_total(DRwIN);
temp_peakloci_DRwIN = T.peakloci_total(DRwIN);
lightResp_track_DRwIN = double(T.pLR_Track(DRwIN)<alpha);
lightAct_track_DRwIN = double(T.pLR_Track(DRwIN)<alpha & T.statDir_Track(DRwIN)==1);
lightIna_track_DRwIN = double(T.pLR_Track(DRwIN)<alpha & T.statDir_Track(DRwIN)==-1);
lightResp_plfm_DRwIN = double(T.pLR_Plfm2hz(DRwIN)<alpha);

normTrackFR_DRwIN(:,2) = num2cell(cellfun(@(x) x(1),temp_peakloci_DRwIN));
normTrackFR_DRwIN(:,3) = num2cell(lightResp_track_DRwIN);
normTrackFR_DRwIN(:,4) = num2cell(lightAct_track_DRwIN); % Act population
normTrackFR_DRwIN(:,5) = num2cell(lightIna_track_DRwIN); % Ina population

normTrackFR_DRwIN = sortrows(normTrackFR_DRwIN,-2);
normTrackFR_DRwIN = cell2mat(normTrackFR_DRwIN);
lightResp_idx_DRwIN = find(normTrackFR_DRwIN(:,126));
lightAct_idx_DRwIN = find(normTrackFR_DRwIN(:,127));
lightIna_idx_DRwIN = find(normTrackFR_DRwIN(:,128));
lightResp_plfm_idx_DRwIN = find(lightResp_plfm_DRwIN);

inStmzoneResp_DRwIN = sum(double((areaDRw(1)<=normTrackFR_DRwIN(:,125) & normTrackFR_DRwIN(:,125)<=areaDRw(2)) & normTrackFR_DRwIN(:,126)==1));
inStmzoneNoResp_DRwIN = sum(double((areaDRw(1)<=normTrackFR_DRwIN(:,125) & normTrackFR_DRwIN(:,125)<=areaDRw(2)) & normTrackFR_DRwIN(:,126)==0));
outStmzoneResp_DRwIN = sum(double(~(areaDRw(1)<normTrackFR_DRwIN(:,125) & normTrackFR_DRwIN(:,125)<areaDRw(2)) & normTrackFR_DRwIN(:,126)==1));
outStmzoneNoResp_DRwIN = sum(double(~(areaDRw(1)<normTrackFR_DRwIN(:,125) & normTrackFR_DRwIN(:,125)<areaDRw(2)) & normTrackFR_DRwIN(:,126)==0));

inStmzoneAct_DRwIN = sum(double((areaDRw(1)<=normTrackFR_DRwIN(:,125) & normTrackFR_DRwIN(:,125)<=areaDRw(2)) & normTrackFR_DRwIN(:,127)==1));
inStmzoneNoAct_DRwIN = sum(double((areaDRw(1)<=normTrackFR_DRwIN(:,125) & normTrackFR_DRwIN(:,125)<=areaDRw(2)) & normTrackFR_DRwIN(:,127)==0));
outStmzoneAct_DRwIN = sum(double(~(areaDRw(1)<normTrackFR_DRwIN(:,125) & normTrackFR_DRwIN(:,125)<areaDRw(2)) & normTrackFR_DRwIN(:,127)==1));
outStmzoneNoAct_DRwIN = sum(double(~(areaDRw(1)<normTrackFR_DRwIN(:,125) & normTrackFR_DRwIN(:,125)<areaDRw(2)) & normTrackFR_DRwIN(:,127)==0));

inStmzoneIna_DRwIN = sum(double((areaDRw(1)<=normTrackFR_DRwIN(:,125) & normTrackFR_DRwIN(:,125)<=areaDRw(2)) & normTrackFR_DRwIN(:,128)==1));
inStmzoneNoIna_DRwIN = sum(double((areaDRw(1)<=normTrackFR_DRwIN(:,125) & normTrackFR_DRwIN(:,125)<=areaDRw(2)) & normTrackFR_DRwIN(:,128)==0));
outStmzoneIna_DRwIN = sum(double(~(areaDRw(1)<normTrackFR_DRwIN(:,125) & normTrackFR_DRwIN(:,125)<areaDRw(2)) & normTrackFR_DRwIN(:,128)==1));
outStmzoneNoIna_DRwIN = sum(double(~(areaDRw(1)<normTrackFR_DRwIN(:,125) & normTrackFR_DRwIN(:,125)<areaDRw(2)) & normTrackFR_DRwIN(:,128)==0));

statResp_DRwIN = chisqNxN([inStmzoneResp_DRwIN, inStmzoneNoResp_DRwIN; outStmzoneResp_DRwIN outStmzoneNoResp_DRwIN]);
statAct_DRwIN = chisqNxN([inStmzoneAct_DRwIN, inStmzoneNoAct_DRwIN; outStmzoneAct_DRwIN outStmzoneNoAct_DRwIN]);
statIna_DRwIN = chisqNxN([inStmzoneIna_DRwIN, inStmzoneNoIna_DRwIN; outStmzoneIna_DRwIN outStmzoneNoIna_DRwIN]);


%% plot
nCol = 2;
nRow = 2;
bWidth = 0.6;

fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{2});
% Figure PN
hStat(1) = axes('Position',axpt(nCol,nRow,1:2,1,[0.1 0.1 0.8 0.80],wideInterval));
bar([1,2],[inStmzoneResp_DRunPN/(inStmzoneResp_DRunPN+outStmzoneResp_DRunPN), inStmzoneNoResp_DRunPN/(inStmzoneNoResp_DRunPN+outStmzoneNoResp_DRunPN)],bWidth,'FaceColor',colorGreen);
hold on;
bar([4,5],[inStmzoneAct_DRunPN/(inStmzoneAct_DRunPN+outStmzoneAct_DRunPN), inStmzoneNoAct_DRunPN/(inStmzoneNoAct_DRunPN+outStmzoneNoAct_DRunPN)],bWidth,'FaceColor',colorBlue);
hold on;
bar([7,8],[inStmzoneIna_DRunPN/(inStmzoneIna_DRunPN+outStmzoneIna_DRunPN), inStmzoneNoIna_DRunPN/(inStmzoneNoIna_DRunPN+outStmzoneNoIna_DRunPN)],bWidth,'FaceColor',colorRed);
hold on;
line([1,2],[inStmzoneResp_DRunPN/(inStmzoneResp_DRunPN+outStmzoneResp_DRunPN) * 1.1,inStmzoneResp_DRunPN/(inStmzoneResp_DRunPN+outStmzoneResp_DRunPN) * 1.1],'color',colorBlack,'lineWidth',lineL);
line([7,8],[inStmzoneIna_DRunPN/(inStmzoneIna_DRunPN+outStmzoneIna_DRunPN) * 1.1,inStmzoneIna_DRunPN/(inStmzoneIna_DRunPN+outStmzoneIna_DRunPN) * 1.1],'color',colorBlack,'lineWidth',lineL);
text(1.5, inStmzoneResp_DRunPN/(inStmzoneResp_DRunPN+outStmzoneResp_DRunPN) * 1.2, '*','color',colorRed,'fontSize',14);
text(7.5, inStmzoneIna_DRunPN/(inStmzoneIna_DRunPN+outStmzoneIna_DRunPN) * 1.2, '*','color',colorRed,'fontSize',14);
text(1.0, 0.9, ['Light Resp.: p = ',num2str(statResp_DRunPN,3)],'color',colorGreen,'fontSize',fontL);
text(1.0, 0.8, ['Light Act.: p = ',num2str(statAct_DRunPN,3)],'color',colorBlue,'fontSize',fontL);
text(1.0, 0.7, ['Light Ina.: p = ',num2str(statIna_DRunPN,3)],'color',colorRed,'fontSize',fontL);
ylabel('Ratio of light modulated neurons','fontSize',fontXL);
title('DRun sessions (PN)','fontSize',fontXL,'fontWeight','bold');


hStat(2) = axes('Position',axpt(nCol,nRow,1:2,2,[0.1 0.1 0.8 0.80],wideInterval));
bar([1,2],[inStmzoneResp_DRwPN/(inStmzoneResp_DRwPN+outStmzoneResp_DRwPN), inStmzoneNoResp_DRwPN/(inStmzoneNoResp_DRwPN+outStmzoneNoResp_DRwPN)],bWidth,'FaceColor',colorGreen);
hold on;
bar([4,5],[inStmzoneAct_DRwPN/(inStmzoneAct_DRwPN+outStmzoneAct_DRwPN), inStmzoneNoAct_DRwPN/(inStmzoneNoAct_DRwPN+outStmzoneNoAct_DRwPN)],bWidth,'FaceColor',colorBlue);
hold on;
bar([7,8],[inStmzoneIna_DRwPN/(inStmzoneIna_DRwPN+outStmzoneIna_DRwPN), inStmzoneNoIna_DRwPN/(inStmzoneNoIna_DRwPN+outStmzoneNoIna_DRwPN)],bWidth,'FaceColor',colorRed);
hold on;
line([1,2],[inStmzoneResp_DRwPN/(inStmzoneResp_DRwPN+outStmzoneResp_DRwPN) * 1.1,inStmzoneResp_DRwPN/(inStmzoneResp_DRwPN+outStmzoneResp_DRwPN) * 1.1],'color',colorBlack,'lineWidth',lineL);
line([7,8],[inStmzoneIna_DRwPN/(inStmzoneIna_DRwPN+outStmzoneIna_DRwPN) * 1.1,inStmzoneIna_DRwPN/(inStmzoneIna_DRwPN+outStmzoneIna_DRwPN) * 1.1],'color',colorBlack,'lineWidth',lineL);
text(1.5, inStmzoneResp_DRwPN/(inStmzoneResp_DRwPN+outStmzoneResp_DRwPN) * 1.2, '*','color',colorRed,'fontSize',14);
text(7.5, inStmzoneIna_DRwPN/(inStmzoneIna_DRwPN+outStmzoneIna_DRwPN) * 1.2, '*','color',colorRed,'fontSize',14);
text(1.0, 0.9, ['Light Resp.: p = ',num2str(statResp_DRwPN,3)],'color',colorGreen,'fontSize',fontL);
text(1.0, 0.8, ['Light Act.: p = ',num2str(statAct_DRwPN,3)],'color',colorBlue,'fontSize',fontL);
text(1.0, 0.7, ['Light Ina.: p = ',num2str(statIna_DRwPN,3)],'color',colorRed,'fontSize',fontL);
ylabel('Ratio of light modulated neurons','fontSize',fontXL);
title('DRw sessions (PN)','fontSize',fontXL,'fontWeight','bold');

set(hStat,'Box','off','TickDir','out','XLim',[0,9],'YLim',[0,1],'XTick',[1,2,4,5,7,8],'XTickLabel',{'PF in zone','PF out zone','PF in zone','PF out zone','PF in zone','PF out zone'},'fontSize',fontXL,'YTick',0:0.2:1);

formatOut = 'yymmdd';
print('-painters','-r300','-dtiff',['gplot_placeField_stat_',datestr(now,formatOut),'.tif']);