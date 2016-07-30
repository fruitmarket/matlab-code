clearvars; clf; close all;

load('cellList_new.mat');
T((T.taskType == 'nolight'),:) = [];
T(~(T.taskProb == '100'),:) = [];

tDRw = T;

pnDRw = tDRw.fr_task > 0.01 & tDRw.fr_task < 10;
npnDRw = sum(double(pnDRw));
inDRw = tDRw.fr_task > 10;
ninDRw = sum(double(inDRw));

intraAc = tDRw.intraLightDir==1;
intraIn = tDRw.intraLightDir==-1;
intraNo = tDRw.intraLightDir==0;

interAc = tDRw.interLightDir==1;
interIn = tDRw.interLightDir==-1;
interNo = tDRw.interLightDir==0;

tagAc = tDRw.tagLightDir==1;
tagIn = tDRw.tagLightDir==-1;
tagNo = tDRw.tagLightDir==0;

% Population separation track(intra) vs track(inter)
subTbl_trXtr = [sum(double(pnDRw&intraAc&interAc)), sum(double(pnDRw&intraAc&interIn)), sum(double(pnDRw&intraAc&interNo));
            sum(double(pnDRw&intraIn&interAc)), sum(double(pnDRw&intraIn&interIn)), sum(double(pnDRw&intraIn&interNo));
            sum(double(pnDRw&intraNo&interAc)), sum(double(pnDRw&intraNo&interIn)), sum(double(pnDRw&intraNo&interNo))];
% Population separation track vs tag
subTbl_trXtg = [sum(double(pnDRw&intraAc&tagAc)), sum(double(pnDRw&intraAc&tagIn)), sum(double(pnDRw&intraAc&tagNo));
            sum(double(pnDRw&intraIn&tagAc)), sum(double(pnDRw&intraIn&tagIn)), sum(double(pnDRw&intraIn&tagNo));
            sum(double(pnDRw&intraNo&tagAc)), sum(double(pnDRw&intraNo&tagIn)), sum(double(pnDRw&intraNo&tagNo))];
        
tDRw.Path(pnDRw&intraAc&interAc)
tDRw.Path(pnDRw&intraAc&interIn)
tDRw.Path(pnDRw&intraAc&interNo)
tDRw.Path(pnDRw&intraIn&interAc)
tDRw.Path(pnDRw&intraIn&interIn)
tDRw.Path(pnDRw&intraIn&interNo)
tDRw.Path(pnDRw&intraNo&interAc)
tDRw.Path(pnDRw&intraNo&interIn)
tDRw.Path(pnDRw&intraNo&interNo)

tDRw.Path(pnDRw&intraAc&tagAc)
tDRw.Path(pnDRw&intraAc&tagIn)
tDRw.Path(pnDRw&intraAc&tagNo)
tDRw.Path(pnDRw&intraIn&tagAc)
tDRw.Path(pnDRw&intraIn&tagNo)
tDRw.Path(pnDRw&intraNo&tagAc)
tDRw.Path(pnDRw&intraNo&tagIn)
tDRw.Path(pnDRw&intraNo&tagNo)