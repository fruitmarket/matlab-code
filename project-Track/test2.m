% ttDRunPlfm = T.taskProb == '100' & T.taskType == 'DRun' & T.meanFR_base>0;
% clc;clearvars;
cd('/Users/Jun/Dropbox/SNL/P2_Track');
load('cellList_v3st.mat');

ttDRunTrack = T.taskProb == '100' & T.taskType == 'DRun';
% ttDRunTrack = T.taskProb == '100' & T.taskType == 'DRun' & T.peakMap>1;
PN = T.meanFR_task < 10;

pn = ttDRunTrack & PN;
in = ttDRunTrack & ~PN;


meanFR_base = T.meanFR_base(pn);
lightBase_pre = T.lighttagPreSpk(pn);
lightBase_stm = T.lighttagSpk(pn);

lightTrack_pre = T.lightPreSpk(pn);
lightTrack_stm = T.lightSpk(pn);

plot(

% pn_pLR_Plfm = T.pLR_Plfm(pn);
% pn_pLR_Track = T.pLR_Track(pn);
% 
% in_pLR_Plfm = T.pLR_Plfm(in);
% in_pLR_Track = T.pLR_Track(in);
% 
% pn_Dir_Plfm = T.statDir_Plfm(pn);
% pn_Dir_Track = T.statDir_Track(pn);
% 
% in_Dir_Plfm = T.statDir_Plfm(in);
% in_Dir_Track = T.statDir_Track(in);
% 
% groupA1 = sum(double((pn_pLR_Plfm<0.05 & pn_Dir_Plfm==1) & (pn_pLR_Track<0.05 & pn_Dir_Track==1)));
% groupA2 = sum(double((in_pLR_Plfm<0.05 & in_Dir_Plfm==1) & (in_pLR_Track<0.05 & in_Dir_Track==1)));
% groupB1 = sum(double((pn_pLR_Plfm<0.05 & pn_Dir_Plfm==1) & (pn_pLR_Track<0.05 & pn_Dir_Track==-1)));
% groupB2 = sum(double((in_pLR_Plfm<0.05 & in_Dir_Plfm==1) & (in_pLR_Track<0.05 & in_Dir_Track==-1)));
% groupC1 = sum(double((pn_pLR_Plfm<0.05 & pn_Dir_Plfm==1) & (pn_Dir_Track==0)));
% groupC2 = sum(double((in_pLR_Plfm<0.05 & in_Dir_Plfm==1) & (in_Dir_Track==0)));
% 
% groupD1 = sum(double((pn_pLR_Plfm<0.05 & pn_Dir_Plfm==-1) & (pn_pLR_Track<0.05 & pn_Dir_Track==1)));
% groupD2 = sum(double((in_pLR_Plfm<0.05 & in_Dir_Plfm==-1) & (in_pLR_Track<0.05 & in_Dir_Track==1)));
% groupE1 = sum(double((pn_pLR_Plfm<0.05 & pn_Dir_Plfm==-1) & (pn_pLR_Track<0.05 & pn_Dir_Track==-1)));
% groupE2 = sum(double((in_pLR_Plfm<0.05 & in_Dir_Plfm==-1) & (in_pLR_Track<0.05 & in_Dir_Track==-1)));
% groupF1 = sum(double((pn_pLR_Plfm<0.05 & pn_Dir_Plfm==-1) & (pn_Dir_Track==0)));
% groupF2 = sum(double((in_pLR_Plfm<0.05 & in_Dir_Plfm==-1) & (in_Dir_Track==0)));
% 
% groupG1 = sum(double((pn_Dir_Plfm==0) & (pn_pLR_Track<0.05 & pn_Dir_Track==1)));
% groupG2 = sum(double((in_Dir_Plfm==0) & (in_pLR_Track<0.05 & in_Dir_Track==1)));
% groupH1 = sum(double((pn_Dir_Plfm==0) & (pn_pLR_Track<0.05 & pn_Dir_Track==-1)));
% groupH2 = sum(double((in_Dir_Plfm==0) & (in_pLR_Track<0.05 & in_Dir_Track==-1)));
% groupI1 = sum(double((pn_Dir_Plfm==0) & (pn_Dir_Track==0)));
% groupI2 = sum(double((in_Dir_Plfm==0) & (in_Dir_Track==0)));
% 
% [~,~,idx] = histcounts(T.meanFR_base(ttDRunTrack),100);
% 
% rspN = T.statDir_Plfm2(ttDRunPlfm);
% rspN(rspN == -1)=1;
% 
% for iBin= 1:100
%     y(iBin) = sum(double(a(idx==iBin)));
% end