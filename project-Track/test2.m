% ttDRunPlfm = T.taskProb == '100' & T.taskType == 'DRun' & T.meanFR_base>0;
clc;clearvars;
cd('/Users/Jun/Dropbox/SNL/P2_Track');
load('cellList_v3.mat');

ttDRunTrack = T.taskProb == '100' & T.taskType == 'DRun' & T.peakMap>1;
PN = T.meanFR_task < 10;

pn = ttDRunTrack & PN;
in = ttDRunTrack & ~PN;


pn_pLR_Plfm = T.pLR_Plfm2(pn,:);
pn_pLR_Track = T.pLR_Track2(pn,:);

in_pLR_Plfm = T.pLR_Plfm2(in,:);
in_pLR_Track = T.pLR_Track2(in,:);

pn_Dir_Plfm = T.statDir_Plfm2(pn,:);
pn_Dir_Track = T.statDir_Track2(pn,:);

in_Dir_Plfm = T.statDir_Plfm2(in,:);
in_Dir_Track = T.statDir_Track2(in,:);

groupA1 = sum(double((pn_pLR_Plfm(:,27)<0.05 & pn_Dir_Plfm(:,27)==1) & (pn_pLR_Track(:,27)<0.05 & pn_Dir_Track(:,27)==1)));
groupA2 = sum(double((in_pLR_Plfm(:,27)<0.05 & in_Dir_Plfm(:,27)==1) & (in_pLR_Track(:,27)<0.05 & in_Dir_Track(:,27)==1)));
groupB1 = sum(double((pn_pLR_Plfm(:,27)<0.05 & pn_Dir_Plfm(:,27)==1) & (pn_pLR_Track(:,27)<0.05 & pn_Dir_Track(:,27)==-1)));
groupB2 = sum(double((in_pLR_Plfm(:,27)<0.05 & in_Dir_Plfm(:,27)==1) & (in_pLR_Track(:,27)<0.05 & in_Dir_Track(:,27)==-1)));
groupC1 = sum(double((pn_pLR_Plfm(:,27)<0.05 & pn_Dir_Plfm(:,27)==1) & (pn_Dir_Track(:,27)==0)));
groupC2 = sum(double((in_pLR_Plfm(:,27)<0.05 & in_Dir_Plfm(:,27)==1) & (in_Dir_Track(:,27)==0)));

groupD1 = sum(double((pn_pLR_Plfm(:,27)<0.05 & pn_Dir_Plfm(:,27)==-1) & (pn_pLR_Track(:,27)<0.05 & pn_Dir_Track(:,27)==1)));
groupD2 = sum(double((in_pLR_Plfm(:,27)<0.05 & in_Dir_Plfm(:,27)==-1) & (in_pLR_Track(:,27)<0.05 & in_Dir_Track(:,27)==1)));
groupE1 = sum(double((pn_pLR_Plfm(:,27)<0.05 & pn_Dir_Plfm(:,27)==-1) & (pn_pLR_Track(:,27)<0.05 & pn_Dir_Track(:,27)==-1)));
groupE2 = sum(double((in_pLR_Plfm(:,27)<0.05 & in_Dir_Plfm(:,27)==-1) & (in_pLR_Track(:,27)<0.05 & in_Dir_Track(:,27)==-1)));
groupF1 = sum(double((pn_pLR_Plfm(:,27)<0.05 & pn_Dir_Plfm(:,27)==-1) & (pn_Dir_Track(:,27)==0)));
groupF2 = sum(double((in_pLR_Plfm(:,27)<0.05 & in_Dir_Plfm(:,27)==-1) & (in_Dir_Track(:,27)==0)));

groupG1 = sum(double((pn_Dir_Plfm(:,27)==0) & (pn_pLR_Track(:,27)<0.05 & pn_Dir_Track(:,27)==1)));
groupG2 = sum(double((in_Dir_Plfm(:,27)==0) & (in_pLR_Track(:,27)<0.05 & in_Dir_Track(:,27)==1)));
groupH1 = sum(double((pn_Dir_Plfm(:,27)==0) & (pn_pLR_Track(:,27)<0.05 & pn_Dir_Track(:,27)==-1)));
groupH2 = sum(double((in_Dir_Plfm(:,27)==0) & (in_pLR_Track(:,27)<0.05 & in_Dir_Track(:,27)==-1)));
groupI1 = sum(double((pn_Dir_Plfm(:,27)==0) & (pn_Dir_Track(:,27)==0)));
groupI2 = sum(double((in_Dir_Plfm(:,27)==0) & (in_Dir_Track(:,27)==0)));

[~,~,idx] = histcounts(T.meanFR_base(ttDRunPlfm),100);

rspN = T.statDir_Plfm2(ttDRunPlfm);
rspN(rspN == -1)=1;

for iBin= 1:100
    y(iBin) = sum(double(a(idx==iBin)));
end