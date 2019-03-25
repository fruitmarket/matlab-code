function analysis_findPeakLoci_novel

matFile = mLoad;
nFile = length(matFile);

for iFile = 1:nFile
    disp(['### analyzing peak location:',matFile{iFile},'...']);
    [cellDir, cellName, ~] = fileparts(matFile{iFile});
    cd(cellDir);
    load(matFile{iFile},'pethSpatial','pethconvSpatial');
    
    infoTotal = analysis_pcInfo1D(mean(pethconvSpatial,1));
    infoBasePre = analysis_pcInfo1D(pethconvSpatial(1,:));
    infoTaskPre = analysis_pcInfo1D(pethconvSpatial(2,:));
    infoTaskStm = analysis_pcInfo1D(pethconvSpatial(3,:));
    infoTaskPost = analysis_pcInfo1D(pethconvSpatial(4,:));
    infoBasePost = analysis_pcInfo1D(pethconvSpatial(5,:));
    
    peakloci_total = infoTotal.peakloci;
    normTrackFR_total = infoTotal.normTrackfr;
    peakloci_basePre = infoBasePre.peakloci;
    peakloci_pre = infoTaskPre.peakloci;
    peakloci_stm = infoTaskStm.peakloci;
    peakloci_post = infoTaskPost.peakloci;
    peakloci_basePost = infoBasePost.peakloci;
    fieldArea_total = infoTotal.area;
    
    save([cellName,'.mat'],'peakloci_total','normTrackFR_total','peakloci_basePre','peakloci_pre','peakloci_stm','peakloci_post','peakloci_basePost','fieldArea_total','-append');
end
disp('### analysis: finding peak location is done! ###')