load('D:\Dropbox\SNL\P2_Track\neuronList_ori50hz_171014.mat');
% load('D:\Dropbox\SNL\P2_Track\neuronList_ori_171205.mat');
list_pn_Run = T.taskType == 'DRun' & T.idxNeurontype == 'PN';
list_pc_Run = T.taskType == 'DRun' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;
list_pn_Rw = T.taskType == 'DRw' & T.idxNeurontype == 'PN';
list_pc_Rw = T.taskType == 'DRw' & T.idxNeurontype == 'PN' & T.idxPeakFR & T.idxPlaceField & T.idxTotalSpikeNum;

list_in_Run = T.taskType == 'DRun' & T.idxNeurontype == 'IN';
list_in_Rw = T.taskType == 'DRw' & T.idxNeurontype == 'IN';

lightZone_Run = [5/6 8/6]*20*pi;
lightZone_Rw = [9/6 10/6]*20*pi;

% example file
% saveDir_Run = 'D:\Dropbox\SNL\P2_Track\example_50hz_InOutzoneRun';
% saveDir_Rw = 'D:\Dropbox\SNL\P2_Track\example_50hz_InOutzoneRw';
% plot_Track_multi_v50hz(T.path(list_pc_Run),T.cellID(list_pc_Run),saveDir_Run);
% plot_Track_multi_v50hz(T.path(list_pc_Rw),T.cellID(list_pc_Rw),saveDir_Rw);
%% place field overlap calculation
% Run
% size of place field (Run)
% fieldArea_total1st_Run = cellfun(@(x) x(1), T.fieldArea_total(list_pc_Run));
% size_placefield_Run = cellfun(@length, fieldArea_total1st_Run);
% 
% % overlap size
% nPC_Run = sum(double(list_pc_Run));
% size_overLap = zeros(nPC_Run,1);
% for iPC = 1:nPC_Run
%     size_overLap(iPC,1) = length(intersect(fieldArea_total1st_Run{iPC},[floor(lightZone_Run(1)):ceil(lightZone_Run(2))]));
% end
% ratio_overLap_Run = size_overLap./size_placefield_Run*100;

% Rw
% size of place field (Run)
% fieldArea_total1st_Rw = cellfun(@(x) x(1), T.fieldArea_total(list_pc_Rw));
% size_placefield_Rw = cellfun(@length, fieldArea_total1st_Rw);
% 
% % overlap size
% nPC_Rw = sum(double(list_pc_Rw));
% size_overLap = zeros(nPC_Rw,1);
% for iPC = 1:nPC_Rw
%     size_overLap(iPC,1) = length(intersect(fieldArea_total1st_Rw{iPC},[floor(lightZone_Rw(1)):ceil(lightZone_Rw(2))]));
% end
% ratio_overLap_Rw = size_overLap./size_placefield_Rw*100;

%% Results
% cri_Run = 50;
% cri_Rw = cri_Run*length(floor(lightZone_Rw(1)):ceil(lightZone_Rw(2)))/length(floor(lightZone_Run(1)):ceil(lightZone_Run(2)));
% 
% withinPC = [sum(double(ratio_overLap_Run>=cri_Run)), sum(double(ratio_overLap_Rw>=cri_Rw))];
% 
% disp(['overlap pc #: ',num2str(withinPC(1))]);
% disp(['non-overlap pc #: ',num2str([sum(double(list_pc_Run))-withinPC(1)])]);
% disp(['non-place cell #: ',num2str([sum(double(list_pn_Run))-sum(double(list_pc_Run))])]);

disp(['mean FR (Run): ',num2str(mean(T.meanFR_task(list_pn_Run)),3),' Hz']);
disp(['sem FR (Run): ',num2str(std(T.meanFR_task(list_pn_Run))/sqrt(sum(double(list_pn_Run))),3),' Hz']);
disp(['mean pv-ratio (Run): ',num2str(mean(T.spkpvr(list_pn_Run)),3)]);
disp(['sem pv-ratio (Run): ',num2str(std(T.spkpvr(list_pn_Run))/sqrt(sum(double(list_pn_Run))),3)]);
disp(['mean hv-witdh (Run): ',num2str(mean(T.hfvwth(list_pn_Run)),3), ' usec']);
disp(['sem hv-witdh (Run): ',num2str(std(T.hfvwth(list_pn_Run))/sqrt(sum(double(list_pn_Run))),3), ' usec']);

disp(['mean FR (Run): ',num2str(mean(T.meanFR_task(list_pn_Rw)),3),' Hz']);
disp(['sem FR (Run): ',num2str(std(T.meanFR_task(list_pn_Rw))/sqrt(sum(double(list_pn_Rw))),3),' Hz']);
disp(['mean pv-ratio (Run): ',num2str(mean(T.spkpvr(list_pn_Rw)),3)]);
disp(['sem pv-ratio (Run): ',num2str(std(T.spkpvr(list_pn_Rw))/sqrt(sum(double(list_pn_Rw))),3)]);
disp(['mean hv-witdh (Run): ',num2str(mean(T.hfvwth(list_pn_Rw)),3), ' usec']);
disp(['sem hv-witdh (Run): ',num2str(std(T.hfvwth(list_pn_Rw))/sqrt(sum(double(list_pn_Rw))),3), ' usec']);