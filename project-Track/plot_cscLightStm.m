% clearvars;
lineColor = {[144, 164, 174]./255,... % Before stimulation
    [33 150 243]./ 255,... % During stimulation
    [38, 50, 56]./255}; % After stimulation

lineWth = [1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75];
fontS = 4; fontM = 6; fontL = 8; % font size large
lineS = 0.2; lineM = 0.5; lineL = 0.7; % line width large

colorBlue = [33, 150, 243]/255;
colorLightBlue = [100, 181, 246]/255;
colorLLightBlue = [187, 222, 251]/255;
colorRed = [237, 50, 52]/255;
colorLightRed = [242, 138, 130]/255;
colorGray = [189, 189, 189]/255;
colorGreen = [46, 125, 50]/255;
colorLightGray = [238, 238, 238]/255;
colorDarkGray = [117, 117, 117]/255;
colorYellow = [255, 243, 3]/255;
colorLightYellow = [255, 249, 196]/255;
colorPurple = [123, 31, 162]/255;
colorBlack = [0, 0, 0];

markerS = 2.2; markerM = 4.4; markerL = 6.6; markerXL = 8.8;
tightInterval = [0.02 0.02]; midInterval = [0.09, 0.09]; wideInterval = [0.14 0.14];
width = 0.7;

paperSize = {[0 0 21.0 29.7]; % A4_portrait
             [0 0 29.7 21.0]; % A4_landscape
             [0 0 15.7 21.0]; % A4_half landscape
             [0 0 21.6 27.9]}; % Letter
         
cscFile = mcscLoad;
nFile = length(cscFile);
freqText = [1,2,8,20,50];
saveDir = 'D:\Dropbox\SNL\P2_Track\analysis_csc';

nRow = 4;
nCol = 2;

fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});
for iFile = 1:nFile
    [fileDir, fileName,~] = fileparts(cscFile{iFile});
    fileDirSplit = regexp(fileDir,'\','split');
    fileFigName = strcat(fileDirSplit(end-1),'_',fileDirSplit(end));
    
    cd(fileDir);
    load(cscFile{iFile});
    
    hText = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1:2,1:4,[0.05 0.1 0.90 0.90],tightInterval),wideInterval));
    text(0,0.97,[fileFigName{1},'_csc'],'fontSize',fontM,'Interpreter','none','fontWeight','bold');
    set(hText,'visible','off');

    if iFile<=4
        hiCSC(iFile) = axes('Position',axpt(5,6,1,1,axpt(nCol,nRow,1,iFile,[0.02 0.03 0.80 0.93],tightInterval),midInterval));
        text(0.1,0.5,['CSC',num2str(iFile)],'fontSize',fontL,'fontWeight','bold');
        set(hiCSC(iFile),'visible','off');
    for iLfp = 1:5
        hText(iLfp) = axes('Position',axpt(5,6,1,iLfp,axpt(nCol,nRow,1,iFile,[0.02 0.03 0.77 0.93],tightInterval),midInterval));
        text(1.2,0.5,[num2str(freqText(iLfp)),' Hz'],'fontSize',fontL);
        hCsc(iLfp) = axes('Position',axpt(5,6,2:5,iLfp,axpt(nCol,nRow,1,iFile,[0.05 0.03 0.88 0.93],tightInterval),midInterval));
        plot(f_cscLight{iLfp},'lineWidth',lineL,'color',colorBlack);
        hold on;
        switch iLfp
            case 1
                for iPulse = 1:15
                    pLight(iLfp) = patch([2001+2000*(iPulse-1),2020+2000*(iPulse-1),2020+2000*(iPulse-1),2001+2000*(iPulse-1)],[min(f_cscLight{iLfp}), min(f_cscLight{iLfp}), max(f_cscLight{iLfp}), max(f_cscLight{iLfp})],colorLightBlue,'EdgeColor','none');
                end
            case 2
                for iPulse = 1:15
                    pLight(iLfp) = patch([2001+1000*(iPulse-1),2020+1000*(iPulse-1),2020+1000*(iPulse-1),2001+1000*(iPulse-1)],[min(f_cscLight{iLfp}), min(f_cscLight{iLfp}), max(f_cscLight{iLfp}), max(f_cscLight{iLfp})],colorLightBlue,'EdgeColor','none');
                end
            case 3
                for iPulse = 1:15
                    pLight(iLfp) = patch([2001+250*(iPulse-1),2020+250*(iPulse-1),2020+250*(iPulse-1),2001+250*(iPulse-1)],[min(f_cscLight{iLfp}), min(f_cscLight{iLfp}), max(f_cscLight{iLfp}), max(f_cscLight{iLfp})],colorLightBlue,'EdgeColor','none');
                end
            case 4
                for iPulse = 1:15
                    pLight(iLfp) = patch([2001+100*(iPulse-1),2020+100*(iPulse-1),2020+100*(iPulse-1),2001+100*(iPulse-1)],[min(f_cscLight{iLfp}), min(f_cscLight{iLfp}), max(f_cscLight{iLfp}), max(f_cscLight{iLfp})],colorLightBlue,'EdgeColor','none');
                end
            case 5
                for iPulse = 1:15
                    pLight(iLfp) = patch([2001+40*(iPulse-1),2020+40*(iPulse-1),2020+40*(iPulse-1),2001+40*(iPulse-1)],[min(f_cscLight{iLfp}), min(f_cscLight{iLfp}), max(f_cscLight{iLfp}), max(f_cscLight{iLfp})],colorLightBlue,'EdgeColor','none');
                end
        end
    end
    xlabel('Time from light onset (sec)','fontSize',fontL);   
    set(hText,'Box','off','visible','off');
    set(hCsc,'Box','off','TickDir','out','fontSize',fontM);
    set(hCsc(1),'XLim',[1,17*2000],'XTick',[1:2000:length(f_cscLight{1})],'XTickLabel',[-1:1:15]);
    set(hCsc(2),'XLim',[1,10*2000],'XTick',[1:2000:length(f_cscLight{2})],'XTickLabel',[-1:1:8]);
    set(hCsc(3:5),'XLim',[1,3*2001],'XTick',[1:2000:length(f_cscLight{3})],'XTickLabel',[-1:1:3]);
    else
        hiCSC(iFile) = axes('Position',axpt(5,6,1,1,axpt(nCol,nRow,2,iFile-4,[0.05 0.03 0.80 0.93],tightInterval),midInterval));
        text(1,0.5,['CSC',num2str(iFile)],'fontSize',fontL,'fontWeight','bold');
        set(hiCSC(iFile),'visible','off');
    for iLfp = 1:5
        hText(iLfp) = axes('Position',axpt(5,6,1,iLfp,axpt(nCol,nRow,2,iFile-4,[0.05 0.03 0.80 0.93],tightInterval),midInterval));
        text(2.0,0.5,[num2str(freqText(iLfp)), ' Hz'],'fontSize',fontL);
        hCsc(iLfp) = axes('Position',axpt(5,6,2:5,iLfp,axpt(nCol,nRow,2,iFile-4,[0.07 0.03 0.90 0.93],tightInterval),midInterval));
        plot(f_cscLight{iLfp},'lineWidth',lineL,'color',colorBlack);
        hold on;
        switch iLfp
            case 1
                for iPulse = 1:15
                    pLight(iLfp) = patch([2001+2000*(iPulse-1),2020+2000*(iPulse-1),2020+2000*(iPulse-1),2001+2000*(iPulse-1)],[min(f_cscLight{iLfp}), min(f_cscLight{iLfp}), max(f_cscLight{iLfp}), max(f_cscLight{iLfp})],colorLightBlue,'EdgeColor','none');
                end
            case 2
                for iPulse = 1:15
                    pLight(iLfp) = patch([2001+1000*(iPulse-1),2020+1000*(iPulse-1),2020+1000*(iPulse-1),2001+1000*(iPulse-1)],[min(f_cscLight{iLfp}), min(f_cscLight{iLfp}), max(f_cscLight{iLfp}), max(f_cscLight{iLfp})],colorLightBlue,'EdgeColor','none');
                end
            case 3
                for iPulse = 1:15
                    pLight(iLfp) = patch([2001+250*(iPulse-1),2020+250*(iPulse-1),2020+250*(iPulse-1),2001+250*(iPulse-1)],[min(f_cscLight{iLfp}), min(f_cscLight{iLfp}), max(f_cscLight{iLfp}), max(f_cscLight{iLfp})],colorLightBlue,'EdgeColor','none');
                end
            case 4
                for iPulse = 1:15
                    pLight(iLfp) = patch([2001+100*(iPulse-1),2020+100*(iPulse-1),2020+100*(iPulse-1),2001+100*(iPulse-1)],[min(f_cscLight{iLfp}), min(f_cscLight{iLfp}), max(f_cscLight{iLfp}), max(f_cscLight{iLfp})],colorLightBlue,'EdgeColor','none');
                end
            case 5
                for iPulse = 1:15
                    pLight(iLfp) = patch([2001+40*(iPulse-1),2020+40*(iPulse-1),2020+40*(iPulse-1),2001+40*(iPulse-1)],[min(f_cscLight{iLfp}), min(f_cscLight{iLfp}), max(f_cscLight{iLfp}), max(f_cscLight{iLfp})],colorLightBlue,'EdgeColor','none');
                end
        end
    end
    xlabel('Time from light onset (sec)','fontSize',fontL);
    set(hText,'Box','off','visible','off');
    set(hCsc,'Box','off','TickDir','out','fontSize',fontM);
    set(hCsc(1),'XLim',[1,17*2000],'XTick',[1:2000:length(f_cscLight{1})],'XTickLabel',[-1:1:15]);
    set(hCsc(2),'XLim',[1,10*2000],'XTick',[1:2000:length(f_cscLight{2})],'XTickLabel',[-1:1:8]);
    set(hCsc(3:5),'XLim',[1,3*2001],'XTick',[1:2000:length(f_cscLight{3})],'XTickLabel',[-1:1:3]);
    end

end

cd(saveDir);
print('-painters','-r300','-dtiff',[fileFigName{1},'.tif']);
close;
fclose('all');
 