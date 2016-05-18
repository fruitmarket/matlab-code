xlsfile = FindFiles('*.xls');
nFile = length(xlsfile);

%% Data load
for iFile = 1:nFile
    [filePath, fileName, ext] = fileparts(xlsfile{iFile});
    
    disp(['### Analyzing ', xlsfile{iFile}, '...']);
    cd(filePath);
    
    all_info = readtable([fileName, ext]);
    
    quad.NE(:,iFile) = all_info.TimeInZone____QuadrantNE;
    quad.SE(:,iFile) = all_info.TimeInZone____QuadrantSE;
    quad.SW(:,iFile) = all_info.TimeInZone____QuadrantSW;
    quad.NW(:,iFile) = all_info.TimeInZone____QuadrantNW;
end

nTrial = size(quad.NE,1);
probeTrial = nTrial-3;

probeQuad.NE = quad.NE(probeTrial,:);
probeQuad.SE = quad.SE(probeTrial,:);
probeQuad.SW = quad.SW(probeTrial,:);
probeQuad.NW = quad.NW(probeTrial,:);
fields = fieldnames(probeQuad);

%% Group discrimination
%%%%%%%%%%%%%%%%%% Camk2a %%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%% Grik4 %%%%%%%%%%%%%%%%%%%%%%
% 1:1-1(No expression on R.hemi)    9:3-1(No expresssion on R.hemi)
% 2:1-2                            10:3-2
% 3:1-3                            11:3-3
% 4:1-4                            12:3-4
% 5:2-1                            13:4-1
% 6:2-2                            14:4-2
% 7:2-3                            15:4-3
% 8:2-4                            16:4-4 
%                                  17:4-5


%%%%%%%%%%%%%%%%%% Camk2a %%%%%%%%%%%%%%%%%%%%%%
%CNO group:             DMSO group
% 10                        1
% 11                        2
% 12                        3
% 13                        4
% 14                        5
% 15                        6
% 16                        7
% 17                        8
% 18                        9
% 23: No expression         19
% 24: No expression         20: No expression
% 25                        21:
% 26: No expression         22: Unilateral expression


if regexp(fileName,'Rbp4');
    idxCNO = [];
    idxDMSO = [];
elseif regexp(fileName,'Grik4');
    idxCNO = [];
    idxDMSO = [];
else regexp(fileName,'Camk2a');
    idxCNO = [10:18,25];
    idxDMSO = [1:9,19,20,21,22];
end
    
for iField = 1:numel(fields)
    probeQuadCNO.(fields{iField})(1) = mean(probeQuad.(fields{iField})(idxCNO));
    probeQuadCNO.(fields{iField})(2) = std(probeQuad.(fields{iField})(idxCNO),1)/sqrt(length(idxCNO));
    probeQuadDMSO.(fields{iField})(1) = mean(probeQuad.(fields{iField})(idxDMSO));
    probeQuadDMSO.(fields{iField})(2) = std(probeQuad.(fields{iField})(idxCNO),1)/sqrt(length(idxDMSO));
end

barXvalue = [1,1.2; 2,2.2; 3,3.2; 4,4.2];
barYvalue = [probeQuadDMSO.NE(1),probeQuadCNO.NE(1);probeQuadDMSO.SE(1),probeQuadCNO.SE(1);...
    probeQuadDMSO.SW(1),probeQuadCNO.SW(1);probeQuadDMSO.NW(1),probeQuadCNO.NW(1)];
barError = [probeQuadDMSO.NE(2),probeQuadCNO.NE(2);probeQuadDMSO.SE(2),probeQuadCNO.SE(2);...
    probeQuadDMSO.SW(2),probeQuadCNO.SW(2);probeQuadDMSO.NW(2),probeQuadCNO.NW(2)];

bar(barXvalue,barYvalue,4)
hold on;
errorbar(barXvalue(1,1),barYvalue(1,1),barError(1,1))
% hold on;
% errorbar(barValue,barError,'none')



% barWidth = 1;
% barGroupnames = {'NE';'SE';'SW';'NW'};
errorbar_groups(barValue,barError)
% ,barWidth,barGroupnames,[],[],[],'jet','none',[],2,'axis');



