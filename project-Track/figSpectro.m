function figSpectro()

lineColor = {[144, 164, 174]./255,... % Before stimulation
    [33 150 243]./ 255,... % During stimulation
    [38, 50, 56]./255}; % After stimulation

lineWth = [1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75];
fontS = 4; fontM = 6; fontL = 8; % font size large
lineS = 0.2; lineM = 0.5; lineL = 1; % line width large

colorBlue = [33 150 243] ./ 255;
colorLightBlue = [100 181 246] ./ 255;
% colorLightBlue = [223 239 252] ./ 255;
colorLightLightBlue = [187, 222, 251]./255;
colorRed = [237 50 52] ./ 255;
colorLightRed = [242 138 130] ./ 255;
colorGray = [189 189 189] ./ 255;
colorLightGray = [238, 238, 238] ./255;
colorDarkGray = [117, 117, 117] ./255;
colorYellow = [255 243 3] ./ 255;
colorLightYellow = [255 249 196] ./ 255;
colorBlack = [0, 0, 0];
colorBar3 = [colorGray;colorBlue;colorGray];
markerS = 2.2; markerM = 4.4; markerL = 6.6; markerXL = 8.8;
tightInterval = [0.02 0.02]; wideInterval = [0.07 0.07];
yLim = [0, 120];
% xLim = 
nCol = 9;
nRow = 9;

cscFile = FindFiles('CSC*.mat','CheckSubdirs',0);
nFile = length(cscFile);
for iFile = 1:nFile
    load(cscFile{1});
    
    fHandle = figure('PaperUnits','centimeters','PaperPosition',[0, 0, 18.3, 13.725]);
    hText = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1,1,[],tightInterval),wideInterval));
    hold on;
    text(0,0.9,cscFile{iFile},'FontSize',fontM,'Interpreter','none','FontWeight','bold');
    set(hText,'visible','off');
    
    hSensor(1) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1:2,2:3,[],tightInterval),wideInterval));
    hSpecField(1) = pcolor(timeSensor,freqSensor,mean(specSensor_pre,3)');
    title('Track (Pre-stm)','FontSize',fontM);

    hSensor(2) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,4:5,2:3,[],tightInterval),wideInterval));
    hSpecField(2) = pcolor(timeSensor,freqSensor,mean(specSensor_stm,3)');
    title('Track (Stm)','FontSize',fontM);

    hSensor(3) = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,7:8,2:3,[],tightInterval),wideInterval));
    hSpecField(3) = pcolor(timeSensor,freqSensor,mean(specSensor_post,3)');
    title('Track (Post)','FontSize',fontM);

    hLightPlfm = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1:2,5:6,[],tightInterval),wideInterval));
    hSpecField(4) = pcolor(timeLightPlfm,freqLightPlfm,specLightPlfm');
    title('Response check (Platform)','FontSize',fontM);

    hLightTrack = axes('Position',axpt(1,1,1,1,axpt(nCol,nRow,1:2,8:9,[],tightInterval),wideInterval));
    hSpecField(5) = pcolor(timeLightTrack,freqLightTrack,mean(specLightTrack,3)');
    title('Response check (Track)','FontSize',fontM);
    
    set(hSpecField,'EdgeColor','none','lineStyle','default');
    set(hSensor,'Box','on','TickDir','out','YLim',yLim,'YTick',[0:20:yLim(2)],'YTickLabel',{0:20:yLim(2)});
    ylabel('Frequency (Hz)');
end


    hSpec(1) = axes('Position',axpt(4,3,1,1,[],wideInterval));
    hSpecSensor(1) = imagesc(timeSensor,freqSensor,psdSensor_pre);
    
    hSpec(2) = axes('Position',axpt(4,3,2,1,[],wideInterval));
    hSpecSensor(2) = imagesc(timeSensor,freqSensor,psdSensor_stm);
    
    hSpec(3) = axes('Position',axpt(4,3,3,1,[],wideInterval));
    hSpecSensor(3) = imagesc(timeSensor,freqSensor,psdSensor_post);
    
    hSpec(4) = axes('Position',axpt(4,3,1,2,[],wideInterval));
    hSpecLightPlfm(1) = imagesc(timeSensor,freqSensor,psdLightPlfm);
    
    hSpec(5) = axes('Position',axpt(4,3,1,3,[],wideInterval));
    hSpecLightTrack(1) = imagesc(timeSensor,freqSensor,psdLightTrack);
    
    set(hSpec,'YLim',[0 90],'Ydir','Normal');
    set(hSpec,'XLim',[0.25, 1.75],'XTick',[0.25:0.25:1.75],'XTickLabel',{-0.75;-0.5;-0.25;0;0.25;0.5;0.75});

xLim = [mean(abs(sensorWin))-1, mean(abs(sensorWin))+1];
yLim = [0, 90];
line(xLim,[yLim(1),yLim(1)],'Color','k');
hLine = line([xLim(1),xLim(1)],yLim,'Color','k');

xlabel('Time (sec)');
print(gcf,'-dtiff','-r300','exercise.tiff');
% sampleTrackLight
% samplePlfmLight