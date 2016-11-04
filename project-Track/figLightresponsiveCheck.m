load('tagStatTest.mat');

colorBlue = [33 150 243] ./ 255;
colorLightBlue = [223 239 252] ./ 255;
colorRed = [237 50 52] ./ 255;
colorLightRed = [242 138 130] ./ 255;
colorGray = [189 189 189] ./ 255;
colorLightGray = [238, 238, 238] ./255;
colorDarkGray = [117, 117, 117] ./255;
colorYellow = [255 243 3] ./ 255;
colorLightYellow = [255 249 196] ./ 255;


for iCondi = 1:27
    actPlfm(iCondi) = sum(double(statDir_Plfm(:,iCondi)==1 & pLR_Plfm(:,iCondi)<0.05));
    inactPlfm(iCondi) = sum(double(statDir_Plfm(:,iCondi)==-1 & pLR_Plfm(:,iCondi)<0.05));
    noPlfm(iCondi) = sum(double(statDir_Plfm(:,iCondi)==0 & pLR_Plfm(:,iCondi)<0.05));

    actTrack(iCondi) = sum(double(statDir_Track(:,iCondi)==1 & pLR_Track(:,iCondi)<0.05)); 
    inactTrack(iCondi) = sum(double(statDir_Track(:,iCondi)==-1 & pLR_Track(:,iCondi)<0.05));
    noTrack(iCondi) = sum(double(statDir_Track(:,iCondi)==0 & pLR_Track(:,iCondi)<0.05));
end

for i = 1:26
    countPlfm(i) = sum(double(pLR_Plfm(:,i)<0.05));
    countTrack(i) = sum(double(pLR_Track(:,i)<0.05));
end
countPlfm(27) = sum(double(pLR_Plfm(:,27)<0.005));
countTrack(27) = sum(double(pLR_Track(:,27)<0.005));

subplot(2,1,1);
plot([1:27],countPlfm,'-o','MarkerFaceColor','k','Color','k');
hold on;
plot([1:27],actPlfm,'-o','MarkerFaceColor',colorBlue,'Color',colorBlue);
hold on;
plot([1:27],inactPlfm,'-o','MarkerFaceColor',colorRed,'Color',colorRed);
hold on;
% plot([1:27],noPlfm,'-o','MarkerFaceColor',colorDarkGray);
set(gca,'XTick',[1:27],'XLim',[0,28],'YLim',[0,120],'TickDir','out','Box','off');
ylabel('# of neurons');
title('Light responsive neurons on Platform');

subplot(2,1,2);
plot([1:27],countTrack,'-o','MarkerFaceColor','k','Color','k');
hold on;
plot([1:27],actTrack,'-o','MarkerFaceColor',colorBlue,'Color',colorBlue);
hold on;
plot([1:27],inactTrack,'-o','MarkerFaceColor',colorRed,'Color',colorRed);
hold on;
% plot([1:27],noTrack,'-o','MarkerFaceColor',colorDarkGray)
set(gca,'XTick',[1:27],'XLim',[0,28],'YLim',[0,60],'TickDir','out','Box','off');
ylabel('# of neurons');
xlabel('Conditions');
title('Light responsive neurons on Track');

