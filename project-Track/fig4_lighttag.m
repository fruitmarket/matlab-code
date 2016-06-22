clf; clearvars;

lineColor = {[144, 164, 174]./255,... % Before stimulation
    [244, 67, 54]./255,... % During stimulation
    [38, 50, 56]./255}; % After stimulation

lineWth = [1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75 1 0.75];
fontS = 4; % font size small
fontM = 6; % font size middle
fontL = 8; % font size large
lineS = 0.2; % line width small
lineM = 0.5; % line width middle
lineL = 1; % line width large

colorBlue = [33 150 243] ./ 255;
colorLightBlue = [223 239 252] ./ 255;
colorRed = [237 50 52] ./ 255;
colorLightRed = [242 138 130] ./ 255;
colorGray = [189 189 189] ./ 255;
colorYellow = [255 243 3] ./ 255;
colorLightYellow = [255 249 196] ./ 255;

% four group color
colorPink = [183, 28, 28]./255;
colorPurple = [74, 20, 140]./255;
colorBlue3 = [13, 71, 161]./255;
colorOrange = [27, 94, 32]./255;

tightInterval = [0.02 0.02];
wideInterval = [0.09 0.09];

nCol = 4;
nRowSub = 8; % for the left column
nRowMain = 5; % for the main figure

markerS = 2.2;
markerM = 4.4;
markerL = 6.6;

rtpath = pwd;

%% Data load

load('cellList.mat','T');

neuron = (T.fr_task > 0.01);

tagPosi = (T.fr_task > 0.01) & (T.p_tag < 0.05);
stagPosi = (T.fr_task > 0.01) & (T.p_saltTag < 0.05);
moduPosi = (T.fr_task > 0.01) & (T.p_modu < 0.05);
smoduPosi = (T.fr_task > 0.01) & (T.p_saltModu < 0.05);
tagstagPosi = (T.fr_task > 0.01) & (T.p_tag < 0.05) & (T.p_saltTag < 0.05);
modusmoduPosi = (T.fr_task > 0.01) & (T.p_modu < 0.05) & (T.p_saltModu < 0.05);
tagmoduPosi = (T.fr_task > 0.01) & (T.p_tag < 0.05) & (T.p_modu < 0.05);
stagsmoduPosi = (T.fr_task > 0.01) & (T.p_saltTag < 0.05) & (T.p_saltModu < 0.05);
stagPosi = (T.fr_task > 0.01) & (T.p_saltTag < 0.05);


%% Plot
hLight(1) = axes('Position',axpt(3,3,1,1,[0.1, 0.1, 0.85, 0.85],wideInterval));
hold on;
plot(T.p_tag(neuron),T.p_saltTag(neuron),'o','MarkerSize',markerM,'MarkerFaceColor',colorGray,'MarkerEdgeColor','k');
line([0.05 0.05],[0,1],'LineStyle',':','Color',colorRed,'LineWidth',1);
line([0, 1],[0.05, 0.05],'LineStyle',':','Color',colorRed,'LineWidth',1);
xlabel('Log-Rank test (tagging)');
ylabel('Salt test (tagging)');

hLight(2) = axes('Position',axpt(3,3,1,2,[0.1, 0.1, 0.85, 0.85],wideInterval));
hold on;
plot(T.p_modu(neuron),T.p_saltModu(neuron),'o','MarkerSize',markerM,'MarkerFaceColor',colorGray,'MarkerEdgeColor','k');
line([0.05 0.05],[0,1],'LineStyle',':','Color',colorRed,'LineWidth',1);
line([0, 1],[0.05, 0.05],'LineStyle',':','Color',colorRed,'LineWidth',1);
xlabel('Log-Rank test (modulation)');
ylabel('Salt test (modulation)');

hLight(3) = axes('Position',axpt(3,3,2,1,[0.1, 0.1, 0.85, 0.85],wideInterval));
hold on;
plot(T.p_tag(neuron),T.p_modu(neuron),'o','MarkerSize',markerM,'MarkerFaceColor',colorGray,'MarkerEdgeColor','k');
line([0.05 0.05],[0,1],'LineStyle',':','Color',colorRed,'LineWidth',1);
line([0, 1],[0.05, 0.05],'LineStyle',':','Color',colorRed,'LineWidth',1);
xlabel('Log-Rank test (tagging)');
ylabel('Log-Rank test (modulation)');

hLight(4) = axes('Position',axpt(3,3,2,2,[0.1, 0.1, 0.85, 0.85],wideInterval));
hold on;
plot(T.p_saltTag(neuron),T.p_saltModu(neuron),'o','MarkerSize',markerM,'MarkerFaceColor',colorGray,'MarkerEdgeColor','k');
line([0.05 0.05],[0,1],'LineStyle',':','Color',colorRed,'LineWidth',1);
line([0, 1],[0.05, 0.05],'LineStyle',':','Color',colorRed,'LineWidth',1);
xlabel('Salt test (tagging)');
ylabel('Salt test (modulation)');

set(hLight,'FontSize',fontM,'TickDir','out');

hText(1) = axes('Position',axpt(3,3,3,1:2,[0.1, 0.1, 0.85, 0.85],tightInterval));
hold on;
text(0, 0.99, ['Total neuron: n = ',num2str(sum(double(neuron)))],'FontSize',fontL);
text(0, 0.9, ['Log-Rank test positive (tag): n = ',num2str(sum(double(tagPosi)))],'FontSize',fontL);
text(0, 0.8, ['Salt test positive (tag): n = ',num2str(sum(double(stagPosi)))],'FontSize',fontL);
text(0, 0.7, ['Log-Rank test positive (modu): n = ',num2str(sum(double(moduPosi)))],'FontSize',fontL);
text(0, 0.6, ['Salt test positive (modu): n = ',num2str(sum(double(smoduPosi)))],'FontSize',fontL);
text(0, 0.5, ['Log-Rank (tag) & Salt positive (tag): n = ',num2str(sum(double(tagstagPosi)))],'FontSize',fontL);
text(0, 0.4, ['Log-Rank (tag) & Log-Rank (modu): n = ',num2str(sum(double(tagmoduPosi)))],'FontSize',fontL);
text(0, 0.3, ['Log-Rank (modu) & Salt (modu): n = ',num2str(sum(double(modusmoduPosi)))],'FontSize',fontL);
text(0, 0.2, ['Salt (tag) & Salt (modu): n = ',num2str(sum(double(stagsmoduPosi)))],'FontSize',fontL);

set(hText, 'Box','off','Visible','off');

print(gcf,'-dtiff','-r300','fig4_lightTag');