clearvars;

rtDir = 'D:\Dropbox\SNL\P2_Track';
cd(rtDir);

load('D:\Dropbox\SNL\P2_Track\myParameters.mat');
Txls = readtable('neuronList_freq_170921.xlsx');
load('neuronList_freq_171127.mat');
Txls.latencyIndex = categorical(Txls.latencyIndex);
% folder = 'D:\Dropbox\#team_hippocampus Team Folder\project_Track\samples_v9\';
formatOut = 'yymmdd';

cSpkpvr = 1.2;

%% 300ms 1500ms comparison
% lightSpike1hz = cell2mat(T.lightSpike1hz)';
% baseSpike1hz = cell2mat(T.baseSpike1hz)';
% baseSpike1hz_v2 = cell2mat(T.baseSpike1hz_v2)';
% 
% lightSpike2hz = cell2mat(T.lightSpike2hz)';
% baseSpike2hz = cell2mat(T.baseSpike2hz)';
% baseSpike2hz_v2 = cell2mat(T.baseSpike2hz_v2)';
% 
% lightSpike8hz = cell2mat(T.lightSpike8hz)';
% baseSpike8hz = cell2mat(T.baseSpike8hz)';
% baseSpike8hz_v2 = cell2mat(T.baseSpike8hz_v2)';
% 
% lightSpike20hz = cell2mat(T.lightSpike20hz)';
% baseSpike20hz = cell2mat(T.baseSpike20hz)';
% baseSpike20hz_v2 = cell2mat(T.baseSpike20hz_v2)';
% 
% lightSpike50hz = cell2mat(T.lightSpike50hz)';
% baseSpike50hz = cell2mat(T.baseSpike50hz)';
% baseSpike50hz_v2 = cell2mat(T.baseSpike50hz_v2)';

%% Light responsive population
condiPN = T.spkpvr>cSpkpvr;
condiIN = ~condiPN;

pop_1hz_act = condiPN & (T.idx_light1hz == 1);
pop_1hz_ina = condiPN & (T.idx_light1hz == -1);
pop_1hz_no = condiPN & (T.idx_light1hz == 0);

pop_2hz_act = condiPN & (T.idx_light2hz == 1);
pop_2hz_ina = condiPN & (T.idx_light2hz == -1);
pop_2hz_no = condiPN & (T.idx_light2hz == 0);

pop_8hz_act = condiPN & (T.idx_light8hz == 1);
pop_8hz_ina = condiPN & (T.idx_light8hz == -1);
pop_8hz_no = condiPN & (T.idx_light8hz == 0);

pop_20hz_act = condiPN & (T.idx_light20hz == 1);
pop_20hz_ina = condiPN & (T.idx_light20hz == -1);
pop_20hz_no = condiPN & (T.idx_light20hz == 0);

pop_50hz_act = condiPN & (T.idx_light50hz == 1);
pop_50hz_ina = condiPN & (T.idx_light50hz == -1);
pop_50hz_no = condiPN & (T.idx_light50hz == 0);

popul_1hz = [sum(double(pop_1hz_act)), sum(double(pop_1hz_ina)), sum(double(pop_1hz_no))];
popul_2hz = [sum(double(pop_2hz_act)), sum(double(pop_2hz_ina)), sum(double(pop_2hz_no))];
popul_8hz = [sum(double(pop_8hz_act)), sum(double(pop_8hz_ina)), sum(double(pop_8hz_no))];
popul_20hz = [sum(double(pop_20hz_act)), sum(double(pop_20hz_ina)), sum(double(pop_20hz_no))];
popul_50hz = [sum(double(pop_50hz_act)), sum(double(pop_50hz_ina)), sum(double(pop_50hz_no))];

pop_total = [popul_1hz; popul_2hz; popul_8hz; popul_20hz; popul_50hz];
pop_total_ratio = pop_total/122*100;
%%
% plot_freqDependency_multi(T.path(pop_8hz_act), T.cellID(pop_8hz_act), 'C:\Users\Jun\Desktop\Exam_freqAct')

%%
fHandle = figure('PaperUnits','centimeters','PaperPosition',[0 0 10 10]);
hBaseLight = axes('Position',axpt(1,1,1,1,[0.12 0.08 0.85 0.80],wideInterval));
hBar = bar(pop_total_ratio,'stacked');

text(1-0.17,5,[num2str(pop_total_ratio(1,1),3),' %'],'fontSize',fontM)
text(1-0.17,50,[num2str(pop_total_ratio(1,2),3),' %'],'fontSize',fontM)
text(1-0.15,90,[num2str(pop_total_ratio(1,3),3),' %'],'fontSize',fontM)

text(2-0.15,5,[num2str(pop_total_ratio(2,1),3),' %'],'fontSize',fontM)
text(2-0.15,50,[num2str(pop_total_ratio(2,2),3),' %'],'fontSize',fontM)
text(2-0.15,90,[num2str(pop_total_ratio(2,3),3),' %'],'fontSize',fontM)

text(3-0.15,5,[num2str(pop_total_ratio(3,1),3),' %'],'fontSize',fontM)
text(3-0.15,50,[num2str(pop_total_ratio(3,2),3),' %'],'fontSize',fontM)
text(3-0.15,90,[num2str(pop_total_ratio(3,3),3),' %'],'fontSize',fontM)

text(4-0.15,5,[num2str(pop_total_ratio(4,1),3),' %'],'fontSize',fontM)
text(4-0.15,50,[num2str(pop_total_ratio(4,2),3),' %'],'fontSize',fontM)
text(4-0.15,90,[num2str(pop_total_ratio(4,3),3),' %'],'fontSize',fontM)

text(5-0.15,5,[num2str(pop_total_ratio(5,1),3),' %'],'fontSize',fontM)
text(5-0.15,50,[num2str(pop_total_ratio(5,2),3),' %'],'fontSize',fontM)
text(5-0.15,90,[num2str(pop_total_ratio(5,3),3),' %'],'fontSize',fontM)

ylabel('Population (%)','fontSize',fontM);

set(hBar,'LineStyle','-','LineWidth',1);
set(hBar(1),'faceColor',colorLightBlue);
set(hBar(2),'faceColor',colorLightRed);
set(hBar(3),'faceColor',colorGray);

set(hBaseLight,'Box','off','TickDir','out','XLim',[0 6],'XTick',[1:5],'XTickLabel',{'1 Hz','2 Hz','8 Hz','20 Hz','50 Hz'},'fontSize',fontM,'YLim',[0,105]);
print('-painters','-r300','-dtiff',['final_figXX_plfm_BaseVsLight_',datestr(now,formatOut),'_v2.tif']);
