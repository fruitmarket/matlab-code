% Latency of neurons which are activated on the platform. (Blue)
% Among neurons which are activated on the platform, latency of neurons which are also activated on the track
clearvars;

cMeanFR = 9;
cMaxPeakFR = 1;
cSpkpvr = 1.1;
alpha = 0.01;
areaDRw = [5/6 4/3]*pi*20;
areaDRw = [3/2 5/3]*pi*20;
areaRw1 = [1/2 2/3]*pi*20;
areaRw2 = [3/2 5/3]*pi*20;
errorPosi = 5;
correctY = 0.5;
lightBand = 3;
calib = [-3,3]; % unit: cm

cd('D:\Dropbox\SNL\P2_Track');
load('neuronList_ori_170516.mat');
load myParameters.mat;

condiTN = (cellfun(@max, T.peakFR1D_track) > cMaxPeakFR) & ~(cellfun(@(x) any(isnan(x)),T.peakloci_total));
condiPN = T.spkpvr>cSpkpvr & T.meanFR_task<cMeanFR;
condiIN = ~condiPN;

%% DRw sessions
DRwTN = (T.taskType == 'DRw') & condiTN;
DRwPN = DRwTN & condiPN;
DRwIN = DRwTN & condiIN;

% Bais corrected (minimum firing rate thresold is applied)
trackInac_DRwPN = DRwPN & (T.pLR_Track < alpha) & (T.statDir_Track == -1);
mfr_zone = T.sensorMeanFR_DRw(trackInac_DRwPN);
mean_mfr_zone = min(cellfun(@(x) mean(x(31:60)),mfr_zone));
populPass = ((cellfun(@(x) min(mean(x(31:60))),T.sensorMeanFR_DRw)) > mean_mfr_zone) & (T.pLR_Track<=alpha);
populAct = populPass & (T.statDir_Track == 1);
populIna = populPass & (T.statDir_Track == -1);
populNoresp = ((cellfun(@(x) min(mean(x(31:60))),T.sensorMeanFR_DRw)) > mean_mfr_zone) & (T.pLR_Track>alpha);

populPass = double(populPass(DRwPN));
populAct = populAct(DRwPN);
populIna = populIna(DRwPN);
populNoresp = double(populNoresp(DRwPN));

% DRwPN
nCell_DRwPN = sum(double(DRwPN));
normTrackFR_DRwPN = T.normTrackFR_total(DRwPN);
temp_peakloci_DRwPN = T.peakloci_total(DRwPN);
lightResp_track_DRwPN = double(T.pLR_Track(DRwPN)<alpha);
lightAct_track_DRwPN = double(T.pLR_Track(DRwPN)<alpha & T.statDir_Track(DRwPN)==1);
lightIna_track_DRwPN = double(T.pLR_Track(DRwPN)<alpha & T.statDir_Track(DRwPN)==-1);
lightResp_plfm_DRwPN = double(T.pLR_Plfm2hz(DRwPN)<alpha);

normTrackFR_DRwPN(:,2) = num2cell(cellfun(@(x) x(1),temp_peakloci_DRwPN)); % position of peak firing rate
normTrackFR_DRwPN(:,3) = num2cell(lightResp_track_DRwPN); % Resp population
normTrackFR_DRwPN(:,4) = num2cell(lightAct_track_DRwPN); % Act population
normTrackFR_DRwPN(:,5) = num2cell(lightIna_track_DRwPN); % Ina population
normTrackFR_DRwPN(:,6) = num2cell(double(areaDRw(1)+calib(1)<=cell2mat(normTrackFR_DRwPN(:,2)) & cell2mat(normTrackFR_DRwPN(:,2))<=areaDRw(2)+calib(2)));
normTrackFR_DRwPN(:,7) = num2cell(populPass); % popul pass (stm zone min firing rate threshold is applied)
normTrackFR_DRwPN(:,8) = num2cell(populNoresp); % popul pass (stm zone min firing rate threshold is applied)

normTrackFR_DRwPN = sortrows(normTrackFR_DRwPN,-2);
normTrackFR_DRwPN = cell2mat(normTrackFR_DRwPN);
lightResp_idx_DRwPN = find(normTrackFR_DRwPN(:,126));
lightAct_idx_DRwPN = find(normTrackFR_DRwPN(:,127)); % activated
lightIna_idx_DRwPN = find(normTrackFR_DRwPN(:,128)); % inactivated
lightInPosiDRw = find(normTrackFR_DRwPN(:,129)); % inField position
lightResp_plfm_idx_DRwPN = find(lightResp_plfm_DRwPN);

nInField_DRw = sum(double(normTrackFR_DRwPN(:,129)));
nInFieldAct_DRw = sum(double(normTrackFR_DRwPN(:,129) & normTrackFR_DRwPN(:,127)));
nInFieldIna_DRw = sum(double(normTrackFR_DRwPN(:,129) & normTrackFR_DRwPN(:,128)));
nInFieldNoresp_DRw = sum(double(normTrackFR_DRwPN(:,129) & ~normTrackFR_DRwPN(:,126)));
ratioInField_DRw = [nInFieldAct_DRw, nInFieldIna_DRw, nInFieldNoresp_DRw]/nInField_DRw*100;

nOutField_DRw = sum(double(~normTrackFR_DRwPN(:,129)));
nOutFieldAct_DRw = sum(double(~normTrackFR_DRwPN(:,129) & normTrackFR_DRwPN(:,127)));
nOutFieldIna_DRw = sum(double(~normTrackFR_DRwPN(:,129) & normTrackFR_DRwPN(:,128)));
nOutFieldNoresp_DRw = sum(double(~normTrackFR_DRwPN(:,129) & ~normTrackFR_DRwPN(:,126)));
ratioOutField_DRw = [nOutFieldAct_DRw, nOutFieldIna_DRw, nOutFieldNoresp_DRw]/nOutField_DRw*100;

% DRwIN
nCell_DRwIN = sum(double(DRwIN));
normTrackFR_DRwIN = T.normTrackFR_total(DRwIN);
temp_peakloci_DRwIN = T.peakloci_total(DRwIN);
lightResp_track_DRwIN = double(T.pLR_Track(DRwIN)<alpha);
lightAct_track_DRwIN = double(T.pLR_Track(DRwIN)<alpha & T.statDir_Track(DRwIN)==1);
lightIna_track_DRwIN = double(T.pLR_Track(DRwIN)<alpha & T.statDir_Track(DRwIN)==-1);
lightResp_plfm_DRwIN = double(T.pLR_Plfm2hz(DRwIN)<alpha);

normTrackFR_DRwIN(:,2) = num2cell(cellfun(@(x) x(1),temp_peakloci_DRwIN));
normTrackFR_DRwIN(:,3) = num2cell(lightResp_track_DRwIN); % Resp population
normTrackFR_DRwIN(:,4) = num2cell(lightAct_track_DRwIN); % Act population
normTrackFR_DRwIN(:,5) = num2cell(lightIna_track_DRwIN); % Ina population

normTrackFR_DRwIN = sortrows(normTrackFR_DRwIN,-2);
normTrackFR_DRwIN = cell2mat(normTrackFR_DRwIN);
lightResp_idx_DRwIN = find(normTrackFR_DRwIN(:,126));
lightAct_idx_DRwIN = find(normTrackFR_DRwIN(:,127));
lightIna_idx_DRwIN = find(normTrackFR_DRwIN(:,128));
lightResp_plfm_idx_DRwIN = find(lightResp_plfm_DRwIN);

nInField_bDRw = sum(double(normTrackFR_DRwPN(:,130) & normTrackFR_DRwPN(:,129)));
nInFieldAct_bDRw = sum(double(normTrackFR_DRwPN(:,130) & normTrackFR_DRwPN(:,129) & normTrackFR_DRwPN(:,127)));
nInFieldIna_bDRw = sum(double(normTrackFR_DRwPN(:,130) & normTrackFR_DRwPN(:,129) & normTrackFR_DRwPN(:,128)));
nInFieldNoresp_bDRw = sum(double(normTrackFR_DRwPN(:,131) & normTrackFR_DRwPN(:,129) & ~normTrackFR_DRwPN(:,126)));
ratioInField_bDRw = [nInFieldAct_bDRw, nInFieldIna_bDRw, nInFieldNoresp_bDRw]/nInField_bDRw*100;

nOutField_bDRw = sum(double(normTrackFR_DRwPN(:,130) & ~normTrackFR_DRwPN(:,129)));
nOutFieldAct_bDRw = sum(double(normTrackFR_DRwPN(:,130) & ~normTrackFR_DRwPN(:,129) & normTrackFR_DRwPN(:,127)));
nOutFieldIna_bDRw = sum(double(normTrackFR_DRwPN(:,130) & ~normTrackFR_DRwPN(:,129) & normTrackFR_DRwPN(:,128)));
nOutFieldNoresp_bDRw = sum(double(normTrackFR_DRwPN(:,131) & ~normTrackFR_DRwPN(:,129) & ~normTrackFR_DRwPN(:,126)));
ratioOutField_bDRw = [nOutFieldAct_bDRw, nOutFieldIna_bDRw, nOutFieldNoresp_bDRw]/nOutField_bDRw*100;
%% plot
xptBar = [1,2,3,4,5,6,7];
fHandle = figure('PaperUnits','centimeters','PaperPosition',[0, 0, 6, 6]*3);
hRatio(1) = axes('Position',axpt(1,2,1,1,[0.15 0.10 0.80 0.80],wideInterval));
hBar(1) = bar(xptBar, [ratioInField_DRw,NaN,ratioOutField_DRw],0.8);
ylabel('Ratio (%)','fontSize',fontL);
text(0.8, 15,['n = ',num2str(nInFieldAct_DRw)],'fontSize',fontL);
text(1.8, 15,['n = ',num2str(nInFieldIna_DRw)],'fontSize',fontL);
text(2.8, 15,['n = ',num2str(nInFieldNoresp_DRw)],'fontSize',fontL);
text(4.8, 15,['n = ',num2str(nOutFieldAct_DRw)],'fontSize',fontL);
text(5.8, 15,['n = ',num2str(nOutFieldIna_DRw)],'fontSize',fontL);
text(6.8, 15,['n = ',num2str(nOutFieldNoresp_DRw)],'fontSize',fontL);

hRatio(2) = axes('Position',axpt(1,2,1,2,[0.15 0.10 0.80 0.80],wideInterval));
hBar(2) = bar(xptBar, [ratioInField_bDRw,NaN,ratioOutField_bDRw],0.8);
ylabel('Ratio (%)','fontSize',fontL);
text(0.8, 10,['n = ',num2str(nInFieldAct_bDRw)],'fontSize',fontL);
text(1.8, 10,['n = ',num2str(nInFieldIna_bDRw)],'fontSize',fontL);
text(2.8, 10,['n = ',num2str(nInFieldNoresp_bDRw)],'fontSize',fontL);
text(4.8, 10,['n = ',num2str(nOutFieldAct_bDRw)],'fontSize',fontL);
text(5.8, 10,['n = ',num2str(nOutFieldIna_bDRw)],'fontSize',fontL);
text(6.8, 10,['n = ',num2str(nOutFieldNoresp_bDRw)],'fontSize',fontL);

set(hBar,'FaceColor',colorGray);
set(hRatio,'Box','off','TickDir','out','XTick',[1,2,3,5,6,7],'XTickLabe',{'InPF_Act','InPF_Ina','InPF_Noresp','OutPF_Act','OutPF_Ina','OutPF_Noresp'},'YLim',[0,100],'fontSize',fontL);

formatOut = 'yymmdd';
print('-painters','-r300','-dtiff',['fig4_pfRatio_DRw_',datestr(now,formatOut),'.tif']);
% print('-painters','-r300','-depsc',['fig4_pfRatio_DRw_',datestr(now,formatOut),'.ai']);
close;