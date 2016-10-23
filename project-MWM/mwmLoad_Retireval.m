clearvars;

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
%%%%%%%%%%%%%%%%%% Rbp4 %%%%%%%%%%%%%%%%%%%%%%
% 1:1-1                 10:3-1
% 2:1-2                 11:3-2
% 3:1-3                 12:3-3
% 4:1-4                 13:3-4 (No expression on L.hemi)
% 5:2-1                 14:4-1 
% 6:2-2                 15:4-2 (No expression on L.hemi)
% 7:2-3 (No expression) 16:4-3
% 8:2-4                 17:4-4
% 9:2-5                 18:4-5
% CNO: 10-18
% DMSO: 1-9


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
% CNO: 5,6,7,8,9,10,11,12,17
% DMSO:1,2,3,4,13,14,15,16

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
    idxCNO = [1,2,4,5,6,7];
    idxDMSO = [8:12];
    nCNO = length(idxCNO);
    nDMSO = length(idxDMSO);
elseif regexp(fileName,'Grik4');
    idxCNO = [5:12];
    idxDMSO = [1:4,13:16];
    nCNO = length(idxCNO);
    nDMSO = length(idxDMSO);
else regexp(fileName,'Camk2a');
    idxCNO = [3,4,12,13];
    idxDMSO = [5,6,7,8];
    nCNO = length(idxCNO);
    nDMSO = length(idxDMSO);
end

for iField = 1:numel(fields)
    probeQuadCNO.(fields{iField})(1) = mean(probeQuad.(fields{iField})(idxCNO));
    probeQuadCNO.(fields{iField})(2) = std(probeQuad.(fields{iField})(idxCNO),1)/sqrt(length(idxCNO));
    probeQuadCNO.raw(iField,:) = probeQuad.(fields{iField})(idxCNO);
    probeQuadDMSO.(fields{iField})(1) = mean(probeQuad.(fields{iField})(idxDMSO));
    probeQuadDMSO.(fields{iField})(2) = std(probeQuad.(fields{iField})(idxDMSO),1)/sqrt(length(idxDMSO));
    probeQuadDMSO.raw(iField,:) = probeQuad.(fields{iField})(idxDMSO);
end

if regexp(fileName,'Rbp4');
    save(['Retrieval_Rbp4','.mat'],'probeQuadCNO','probeQuadDMSO','nCNO','nDMSO');
elseif regexp(fileName,'Grik4');
    save(['Retrieval_Grik4','.mat'],'probeQuadCNO','probeQuadDMSO','nCNO','nDMSO');
else regexp(fileName,'Camk2a');
    save(['Retrieval_Camk2a','.mat'],'probeQuadCNO','probeQuadDMSO','nCNO','nDMSO');
end