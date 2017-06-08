% Latency of neurons which are activated on the platform. (Blue)
% Among neurons which are activated on the platform, latency of neurons which are also activated on the track
clearvars;

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
calib = [-3,3]; % unit: cm

cd('D:\Dropbox\SNL\P2_Track');
load('neuronList_ori_170606.mat');
load myParameters.mat;

condiTN = (cellfun(@max, T.peakFR1D_track) > cMaxPeakFR) & ~(cellfun(@(x) any(isnan(x)),T.peakloci_total));
condiPN = T.spkpvr>cSpkpvr & T.meanFR_task<cMeanFR;
condiIN = ~condiPN;

%% DRun sessions
DRunTN = (T.taskType == 'DRw') & condiTN;
DRunPN = DRunTN & condiPN;
DRunIN = DRunTN & condiIN;

% Bais corrected (minimum firing rate thresold is applied)
trackInac_DRunPN = DRunPN & (T.pLR_Track < alpha) & (T.statDir_Track == -1);
mfr_zone = T.sensorMeanFR_DRw(trackInac_DRunPN);
mean_mfr_zone = min(cellfun(@(x) mean(x(31:60)),mfr_zone));

populPass = ((cellfun(@(x) min(mean(x(31:60))),T.sensorMeanFR_DRw)) >= mean_mfr_zone); % neurons that passed threshold fr
populPassAct = populPass & (T.pLR_Track < alpha) & (T.statDir_Track == 1);
populPassIna = populPass & (T.pLR_Track < alpha) & (T.statDir_Track == -1);
populPassNoresp = populPass & (T.pLR_Track>=alpha);

populNopass = ~populPass;
populNopassAct = populNopass & (T.pLR_Track < alpha) & (T.statDir_Track == 1);
populNopassIna = populNopass & (T.pLR_Track < alpha) & (T.statDir_Track == -1);
populNopassNoresp = populNopass & (T.pLR_Track>=alpha);

% DRunPN
populPass = double(populPass(DRunPN));
populPassAct = populPassAct(DRunPN);
populPassIna = populPassIna(DRunPN);
populPassNoresp = double(populPassNoresp(DRunPN));

populNopass = double(populNopass(DRunPN));
populNopassAct = populNopassAct(DRunPN);
populNopassIna = populNopassIna(DRunPN);
populNopassNoresp = double(populNopassNoresp(DRunPN));

nPass = [sum(double(populPass)), sum(double(populPassAct)), sum(double(populPassIna)), sum(double(populPassNoresp))];
nNopass = [sum(double(populNopass)), sum(double(populNopassAct)), sum(double(populNopassIna)), sum(double(populNopassNoresp))];

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
normTrackFR_DRunPN(:,6) = num2cell(double(areaDRun(1)+calib(1)<=cell2mat(normTrackFR_DRunPN(:,2)) & cell2mat(normTrackFR_DRunPN(:,2))<=areaDRun(2)+calib(2)));
normTrackFR_DRunPN(:,7) = num2cell(populPass); % popul pass (stm zone min firing rate threshold is applied)
normTrackFR_DRunPN(:,8) = num2cell(populPassNoresp);

normTrackFR_DRunPN = sortrows(normTrackFR_DRunPN,-2);
normTrackFR_DRunPN = cell2mat(normTrackFR_DRunPN);
lightResp_idx_DRunPN = find(normTrackFR_DRunPN(:,126));
lightAct_idx_DRunPN = find(normTrackFR_DRunPN(:,127)); % activated
lightIna_idx_DRunPN = find(normTrackFR_DRunPN(:,128)); % inactivated
lightInPosiDRun = find(normTrackFR_DRunPN(:,129)); % inField position
lightResp_plfm_idx_DRunPN = find(lightResp_plfm_DRunPN);

nInField_DRun = sum(double(normTrackFR_DRunPN(:,129)));
nInFieldAct_DRun = sum(double(normTrackFR_DRunPN(:,129) & normTrackFR_DRunPN(:,127)));
nInFieldIna_DRun = sum(double(normTrackFR_DRunPN(:,129) & normTrackFR_DRunPN(:,128)));
nInFieldNoresp_DRun = sum(double(normTrackFR_DRunPN(:,129) & ~normTrackFR_DRunPN(:,126)));
ratioInField_DRun = [nInFieldAct_DRun, nInFieldIna_DRun, nInFieldNoresp_DRun]/nInField_DRun*100;

nOutField_DRun = sum(double(~normTrackFR_DRunPN(:,129)));
nOutFieldAct_DRun = sum(double(~normTrackFR_DRunPN(:,129) & normTrackFR_DRunPN(:,127)));
nOutFieldIna_DRun = sum(double(~normTrackFR_DRunPN(:,129) & normTrackFR_DRunPN(:,128)));
nOutFieldNoresp_DRun = sum(double(~normTrackFR_DRunPN(:,129) & ~normTrackFR_DRunPN(:,126)));
ratioOutField_DRun = [nOutFieldAct_DRun, nOutFieldIna_DRun, nOutFieldNoresp_DRun]/nOutField_DRun*100;

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

nInField_bDRun = sum(double(normTrackFR_DRunPN(:,130) & normTrackFR_DRunPN(:,129)));
nInFieldAct_bDRun = sum(double(normTrackFR_DRunPN(:,130) & normTrackFR_DRunPN(:,129) & normTrackFR_DRunPN(:,127)));
nInFieldIna_bDRun = sum(double(normTrackFR_DRunPN(:,130) & normTrackFR_DRunPN(:,129) & normTrackFR_DRunPN(:,128)));
nInFieldNoresp_bDRun = sum(double(normTrackFR_DRunPN(:,131) & normTrackFR_DRunPN(:,129) & ~normTrackFR_DRunPN(:,126)));
ratioInField_bDRun = [nInFieldAct_bDRun, nInFieldIna_bDRun, nInFieldNoresp_bDRun]/nInField_bDRun*100;

nOutField_bDRun = sum(double(normTrackFR_DRunPN(:,130) & ~normTrackFR_DRunPN(:,129)));
nOutFieldAct_bDRun = sum(double(normTrackFR_DRunPN(:,130) & ~normTrackFR_DRunPN(:,129) & normTrackFR_DRunPN(:,127)));
nOutFieldIna_bDRun = sum(double(normTrackFR_DRunPN(:,130) & ~normTrackFR_DRunPN(:,129) & normTrackFR_DRunPN(:,128)));
nOutFieldNoresp_bDRun = sum(double(normTrackFR_DRunPN(:,131) & ~normTrackFR_DRunPN(:,129) & ~normTrackFR_DRunPN(:,126)));
ratioOutField_bDRun = [nOutFieldAct_bDRun, nOutFieldIna_bDRun, nOutFieldNoresp_bDRun]/nOutField_bDRun*100;
%% plot
xptBar = [1,2,3,4,5,6,7];
fHandle = figure('PaperUnits','centimeters','PaperPosition',[0, 0, 6, 6]*3);
hRatio(1) = axes('Position',axpt(1,2,1,1,[0.15 0.10 0.80 0.80],wideInterval));
hBar(1) = bar(xptBar, [ratioInField_DRun,NaN,ratioOutField_DRun],0.8);
ylabel('Ratio (%)','fontSize',fontL);
text(0.8, 20,['n = ',num2str(nInFieldAct_DRun)],'fontSize',fontL);
text(1.8, 20,['n = ',num2str(nInFieldIna_DRun)],'fontSize',fontL);
text(2.8, 20,['n = ',num2str(nInFieldNoresp_DRun)],'fontSize',fontL);
text(4.8, 20,['n = ',num2str(nOutFieldAct_DRun)],'fontSize',fontL);
text(5.8, 20,['n = ',num2str(nOutFieldIna_DRun)],'fontSize',fontL);
text(6.8, 20,['n = ',num2str(nOutFieldNoresp_DRun)],'fontSize',fontL);

hRatio(2) = axes('Position',axpt(1,2,1,2,[0.15 0.10 0.80 0.80],wideInterval));
hBar(2) = bar(xptBar, [ratioInField_bDRun,NaN,ratioOutField_bDRun],0.8);
ylabel('Ratio (%)','fontSize',fontL);
text(0.8, 10,['n = ',num2str(nInFieldAct_bDRun)],'fontSize',fontL);
text(1.8, 10,['n = ',num2str(nInFieldIna_bDRun)],'fontSize',fontL);
text(2.8, 10,['n = ',num2str(nInFieldNoresp_bDRun)],'fontSize',fontL);
text(4.8, 10,['n = ',num2str(nOutFieldAct_bDRun)],'fontSize',fontL);
text(5.8, 10,['n = ',num2str(nOutFieldIna_bDRun)],'fontSize',fontL);
text(6.8, 10,['n = ',num2str(nOutFieldNoresp_bDRun)],'fontSize',fontL);

set(hBar,'FaceColor',colorGray);
set(hRatio,'Box','off','TickDir','out','XTick',[1,2,3,5,6,7],'XTickLabe',{'InPF_Act','InPF_Ina','InPF_Noresp','OutPF_Act','OutPF_Ina','OutPF_Noresp'},'YLim',[0,100],'fontSize',fontL);

formatOut = 'yymmdd';
print('-painters','-r300','-dtiff',['fig4_pfRatio_DRun_',datestr(now,formatOut),'.tif']);
% print('-painters','-r300','-depsc',['fig4_pfRatio_DRun_',datestr(now,formatOut),'.ai']);
close;