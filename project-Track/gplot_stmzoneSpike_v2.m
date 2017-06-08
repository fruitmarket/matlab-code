% Calculate cross correlation of rapid light activated population
%
%
% common part
cd('D:\Dropbox\SNL\P2_Track');
load('neuronList_ori_170606.mat');
Txls = readtable('neuronList_ori_170606.xlsx');
load myParameters.mat;
folder = 'D:\Dropbox\SNL\P2_Track\analysis_stmzoneSpike_DRw\';

cMeanFR = 9;
cMaxPeakFR = 1;
cSpkpvr = 1.1;
alpha = 0.01;

condiTN = (cellfun(@max, T.peakFR1D_track) > cMaxPeakFR) & ~(cellfun(@(x) any(isnan(x)),T.peakloci_total));
condiPN = T.spkpvr>cSpkpvr & T.meanFR_task<cMeanFR;
condiIN = ~condiPN;

% TN: track neuron
DRunTN = (T.taskType == 'DRun') & condiTN;
DRunPN = DRunTN & condiPN;
DRunIN = DRunTN & condiIN;

DRwTN = (T.taskType == 'DRw') & condiTN;
DRwPN = DRwTN & condiPN;
DRwIN = DRwTN & condiIN;

DRunPN_total = DRunPN;
DRunPN_resp = DRunPN & T.pLR_Track<alpha;
DRunPN_act = DRunPN & T.pLR_Track<alpha & T.statDir_Track == 1;
DRunPN_ina = DRunPN & T.pLR_Track<alpha & T.statDir_Track == -1;
DRunPN_no = DRunPN & T.pLR_Track>=alpha;

DRwPN_total = DRwPN;
DRwPN_light = DRwPN & T.pLR_Track<alpha;
DRwPN_act = DRwPN & T.pLR_Track<alpha & T.statDir_Track == 1;
DRwPN_ina = DRwPN & T.pLR_Track<alpha & T.statDir_Track == -1;
DRwPN_no = DRwPN & T.pLR_Track>=alpha;


% compare stim zone spike change
m_spkLap_pre = cellfun(@(x) x(1), T.m_stmzoneSpike);
m_spkLap_stm = cellfun(@(x) x(2), T.m_stmzoneSpike);
m_spkLap_post = cellfun(@(x) x(3), T.m_stmzoneSpike);

std_spkLap_pre = cellfun(@(x) x(1), T.std_stmzoneSpike);
std_spkLap_stm = cellfun(@(x) x(2), T.std_stmzoneSpike);
std_spkLap_post = cellfun(@(x) x(3), T.std_stmzoneSpike);

min_spkLap_pre = m_spkLap_pre - std_spkLap_pre;
max_spkLap_pre = m_spkLap_pre + std_spkLap_pre;

min_spkLap_post = m_spkLap_post - std_spkLap_post;
max_spkLap_post = m_spkLap_post + std_spkLap_post;

sigPreStm_inc = m_spkLap_stm > max_spkLap_pre;
sigPreStm_dec = m_spkLap_stm < min_spkLap_pre;
sigPreStm_no = min_spkLap_pre <= m_spkLap_stm & m_spkLap_stm <= max_spkLap_pre;

cMinSpk = m_spkLap_stm > 1/3; % spike number should be higher than 10 during stm zone (if not, consider no sig change)

popul = DRwPN_ina;
sub = 'ina_';

DRunPN_act_sigInc = popul & sigPreStm_inc & cMinSpk;
fileName = T.path(DRunPN_act_sigInc);
cellID = Txls.cellID(DRunPN_act_sigInc);
fd_act_sigSpk = [folder,sub,'sigSpkInc'];
plot_Track_multi_v3(fileName, cellID, fd_act_sigSpk);

DRunPN_act_sigDec = popul & sigPreStm_dec;
fileName = T.path(DRunPN_act_sigDec);
cellID = Txls.cellID(DRunPN_act_sigDec);
fd_act_nosigSpk = [folder,sub,'sigSpkDec'];
plot_Track_multi_v3(fileName, cellID, fd_act_nosigSpk);

DRunPN_act_no = (popul & sigPreStm_no) | (popul & sigPreStm_inc & ~cMinSpk);
fileName = T.path(DRunPN_act_no);
cellID = Txls.cellID(DRunPN_act_no);
fd_ina_sigSpk = [folder,sub,'nosigSpk'];
plot_Track_multi_v3(fileName, cellID, fd_ina_sigSpk);

sum(double(DRunPN_act_sigInc | DRunPN_act_sigDec | DRunPN_act_no))
%%
% % activated
% temp_stmspk_DRunPN_lightAct = T.m_stmzoneSpike(DRunPN_act);
% temp_stmspk_DRunIN_lightAct = T.m_stmzoneSpike(DRunIN_act);
% temp_stmspk_DRwPN_lightAct = T.m_stmzoneSpike(DRwPN_act);
% temp_stmspk_DRwIN_lightAct = T.m_stmzoneSpike(DRwIN_act);
% 
% % inactivated
% temp_stmspk_DRunPN_lightIna = T.m_stmzoneSpike(DRunPN_ina);
% temp_stmspk_DRunIN_lightIna = T.m_stmzoneSpike(DRunIN_ina);
% temp_stmspk_DRwPN_lightIna = T.m_stmzoneSpike(DRwPN_ina);
% temp_stmspk_DRwIN_lightIna = T.m_stmzoneSpike(DRwIN_ina);
% 
% % no response
% temp_stmspk_DRunPN_no = T.m_stmzoneSpike(DRunPN_no);
% temp_stmspk_DRunIN_no = T.m_stmzoneSpike(DRunIN_no);
% temp_stmspk_DRwPN_no = T.m_stmzoneSpike(DRwPN_no);
% temp_stmspk_DRwIN_no = T.m_stmzoneSpike(DRwIN_no);
% 
% %
% nDRunPN_lightResp = size(temp_m_spk_DRunPN_lightResp,1);
% nDRunIN_lightResp = size(temp_m_spk_DRunIN_lightResp,1);
% nDRwPN_lightResp = size(temp_m_spk_DRwPN_lightResp,1);
% nDRwIN_lightResp = size(temp_m_spk_DRwIN_lightResp,1);
% 
% nDRunPN_lightAct = size(temp_stmspk_DRunPN_lightAct,1);
% nDRunIN_lightAct = size(temp_stmspk_DRunIN_lightAct,1);
% nDRwPN_lightAct = size(temp_stmspk_DRwPN_lightAct,1);
% nDRwIN_lightAct = size(temp_stmspk_DRwIN_lightAct,1);
% 
% nDRunPN_lightIna = size(temp_stmspk_DRunPN_lightIna,1);
% nDRunIN_lightIna = size(temp_stmspk_DRunIN_lightIna,1);
% nDRwPN_lightIna = size(temp_stmspk_DRwPN_lightIna,1);
% nDRwIN_lightIna = size(temp_stmspk_DRwIN_lightIna,1);
% 
% nDRunPN_lightNo = size(temp_stmspk_DRunPN_no,1);
% nDRunIN_lightNo = size(temp_stmspk_DRunIN_no,1);
% nDRwPN_lightNo = size(temp_stmspk_DRwPN_no,1);
% nDRwIN_lightNo = size(temp_stmspk_DRwIN_no,1);
% 
% nDRunPN = sum(double(DRunPN));
% nDRunIN = sum(double(DRunIN));
% nDRwPN = sum(double(DRwPN));
% nDRwIN = sum(double(DRwIN));
% 
% %
% stmspk_DRunPN_lightResp = reshape(cell2mat(temp_m_spk_DRunPN_lightResp),[3,nDRunPN_lightResp])';
% stmspk_DRunIN_lightResp = reshape(cell2mat(temp_m_spk_DRunIN_lightResp),[3,nDRunIN_lightResp])';
% stmspk_DRwPN_lightResp = reshape(cell2mat(temp_m_spk_DRwPN_lightResp),[3,nDRwPN_lightResp])';
% stmspk_DRwIN_lightResp = reshape(cell2mat(temp_m_spk_DRwIN_lightResp),[3,nDRwIN_lightResp])';
% 
% stmspk_DRunPN_lightAct = reshape(cell2mat(temp_stmspk_DRunPN_lightAct),[3,nDRunPN_lightAct])';
% stmspk_DRunIN_lightAct = reshape(cell2mat(temp_stmspk_DRunIN_lightAct),[3,nDRunIN_lightAct])';
% stmspk_DRwPN_lightAct = reshape(cell2mat(temp_stmspk_DRwPN_lightAct),[3,nDRwPN_lightAct])';
% stmspk_DRwIN_lightAct = reshape(cell2mat(temp_stmspk_DRwIN_lightAct),[3,nDRwIN_lightAct])';
% 
% stmspk_DRunPN_lightina = reshape(cell2mat(temp_stmspk_DRunPN_lightIna),[3,nDRunPN_lightIna])';
% stmspk_DRunIN_lightina = reshape(cell2mat(temp_stmspk_DRunIN_lightIna),[3,nDRunIN_lightIna])';
% stmspk_DRwPN_lightina = reshape(cell2mat(temp_stmspk_DRwPN_lightIna),[3,nDRwPN_lightIna])';
% stmspk_DRwIN_lightina = reshape(cell2mat(temp_stmspk_DRwIN_lightIna),[3,nDRwIN_lightIna])';
% 
% stmspk_DRunPN_no = reshape(cell2mat(temp_stmspk_DRunPN_no),[3,nDRunPN_lightNo])';
% stmspk_DRunIN_no = reshape(cell2mat(temp_stmspk_DRunIN_no),[3,nDRunIN_lightNo])';
% stmspk_DRwPN_no = reshape(cell2mat(temp_stmspk_DRwPN_no),[3,nDRwPN_lightNo])';
% stmspk_DRwIN_no = reshape(cell2mat(temp_stmspk_DRwIN_no),[3,nDRwIN_lightNo])';

%%
% nCol = 4;
% nRow = 4;
% 
% fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{2},'Name','stmzoneSpike light response');
% 
% hStmspkDRun(1) = axes('Position',axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval));
% plot([1,2,3],stmspk_DRunPN_lightResp,'-o','color',colorBlack,'MarkerFaceColor',colorBlue);
% text(3.5,max(stmspk_DRunPN_lightResp(:))*0.8,['n = ',num2str(nDRunPN_lightResp)],'fontSize',fontL);
% title('DRunPN & responsive','fontSize',fontL,'fontWeight','bold');
% 
% hStmspkDRun(2) = axes('Position',axpt(nCol,nRow,1,2,[0.1 0.1 0.85 0.85],wideInterval));
% plot([1,2,3],stmspk_DRunPN_lightAct,'-o','color',colorBlack,'MarkerFaceColor',colorBlue);
% text(3.5,max(stmspk_DRunPN_lightAct(:))*0.8,['n = ',num2str(nDRunPN_lightAct)],'fontSize',fontL);
% title('DRunPN & activated','fontSize',fontL,'fontWeight','bold');
% 
% hStmspkDRun(3) = axes('Position',axpt(nCol,nRow,1,3,[0.1 0.1 0.85 0.85],wideInterval));
% plot([1,2,3],stmspk_DRunPN_lightina,'-o','color',colorBlack,'MarkerFaceColor',colorBlue);
% text(3.5,max(stmspk_DRunPN_lightina(:))*0.8,['n = ',num2str(nDRunPN_lightIna)],'fontSize',fontL);
% title('DRunPN & inactivated','fontSize',fontL,'fontWeight','bold');
% 
% hStmspkDRun(4) = axes('Position',axpt(nCol,nRow,1,4,[0.1 0.1 0.85 0.85],wideInterval));
% plot([1,2,3],stmspk_DRunPN_no,'-o','color',colorBlack,'MarkerFaceColor',colorBlue);
% text(3.5,max(stmspk_DRunPN_no(:))*0.8,['n = ',num2str(nDRunIN_lightNo)],'fontSize',fontL);
% title('DRunPN & noresp','fontSize',fontL,'fontWeight','bold');
% 
% hStmspkDRun(5) = axes('Position',axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],wideInterval));
% plot([1,2,3],stmspk_DRunIN_lightResp,'-o','color',colorBlack,'MarkerFaceColor',colorBlue);
% text(3.5,max(stmspk_DRunIN_lightResp(:))*0.8,['n = ',num2str(nDRunIN_lightResp)],'fontSize',fontL);
% title('DRunIN & responsive','fontSize',fontL,'fontWeight','bold');
% 
% hStmspkDRun(6) = axes('Position',axpt(nCol,nRow,2,2,[0.1 0.1 0.85 0.85],wideInterval));
% plot([1,2,3],stmspk_DRunIN_lightAct,'-o','color',colorBlack,'MarkerFaceColor',colorBlue);
% text(3.5,max(stmspk_DRunIN_lightAct(:))*0.8,['n = ',num2str(nDRunIN_lightAct)],'fontSize',fontL);
% title('DRunIN & activated','fontSize',fontL,'fontWeight','bold');
% 
% hStmspkDRun(7) = axes('Position',axpt(nCol,nRow,2,3,[0.1 0.1 0.85 0.85],wideInterval));
% plot([1,2,3],stmspk_DRunIN_lightina,'-o','color',colorBlack,'MarkerFaceColor',colorBlue);
% text(3.5,max(stmspk_DRunIN_lightina(:))*0.8,['n = ',num2str(nDRunIN_lightIna)],'fontSize',fontL);
% title('DRunIN & inactivated','fontSize',fontL,'fontWeight','bold');
% 
% hStmspkDRun(8) = axes('Position',axpt(nCol,nRow,2,4,[0.1 0.1 0.85 0.85],wideInterval));
% plot([1,2,3],stmspk_DRunIN_no,'-o','color',colorBlack,'MarkerFaceColor',colorBlue);
% text(3.5,max(stmspk_DRunIN_no(:))*0.8,['n = ',num2str(nDRunIN_lightNo)],'fontSize',fontL);
% title('DRunIN & no','fontSize',fontL,'fontWeight','bold');
% 
% set(hStmspkDRun,'TickDir','out','Box','off','XLim',[0,4],'XTick',[1,2,3],'XTickLabel',{'Pre','Stm','Post'});
% 
% hStmspkDRw(1) = axes('Position',axpt(nCol,nRow,3,1,[0.1 0.1 0.85 0.85],wideInterval));
% plot([1,2,3],stmspk_DRwPN_lightResp,'-o','color',colorBlack,'MarkerFaceColor',colorBlue);
% text(3.5,max(stmspk_DRwPN_lightResp(:))*0.8,['n = ',num2str(nDRwPN_lightResp)],'fontSize',fontL);
% title('DRwPN & responsive','fontSize',fontL,'fontWeight','bold');
% 
% hStmspkDRw(2) = axes('Position',axpt(nCol,nRow,3,2,[0.1 0.1 0.85 0.85],wideInterval));
% plot([1,2,3],stmspk_DRwPN_lightAct,'-o','color',colorBlack,'MarkerFaceColor',colorBlue);
% text(3.5,max(stmspk_DRwPN_lightAct(:))*0.8,['n = ',num2str(nDRwPN_lightAct)],'fontSize',fontL);
% title('DRwPN & activated','fontSize',fontL,'fontWeight','bold');
% 
% hStmspkDRw(3) = axes('Position',axpt(nCol,nRow,3,3,[0.1 0.1 0.85 0.85],wideInterval));
% plot([1,2,3],stmspk_DRwPN_lightina,'-o','color',colorBlack,'MarkerFaceColor',colorBlue);
% text(3.5,max(stmspk_DRwPN_lightina(:))*0.8,['n = ',num2str(nDRwPN_lightIna)],'fontSize',fontL);
% title('DRwPN & inactivated','fontSize',fontL,'fontWeight','bold');
% 
% hStmspkDRw(4) = axes('Position',axpt(nCol,nRow,3,4,[0.1 0.1 0.85 0.85],wideInterval));
% plot([1,2,3],stmspk_DRwPN_no,'-o','color',colorBlack,'MarkerFaceColor',colorBlue);
% text(3.5,max(stmspk_DRwPN_no(:))*0.8,['n = ',num2str(nDRwIN_lightNo)],'fontSize',fontL);
% title('DRwPN & noresp','fontSize',fontL,'fontWeight','bold');
% 
% hStmspkDRw(5) = axes('Position',axpt(nCol,nRow,4,1,[0.1 0.1 0.85 0.85],wideInterval));
% plot([1,2,3],stmspk_DRwIN_lightResp,'-o','color',colorBlack,'MarkerFaceColor',colorBlue);
% text(3.5,max(stmspk_DRwIN_lightResp(:))*0.8,['n = ',num2str(nDRwIN_lightResp)],'fontSize',fontL);
% title('DRwIN & responsive','fontSize',fontL,'fontWeight','bold');
% 
% hStmspkDRw(6) = axes('Position',axpt(nCol,nRow,4,2,[0.1 0.1 0.85 0.85],wideInterval));
% plot([1,2,3],stmspk_DRwIN_lightAct,'-o','color',colorBlack,'MarkerFaceColor',colorBlue);
% text(3.5,max(stmspk_DRwIN_lightAct(:))*0.8,['n = ',num2str(nDRwIN_lightAct)],'fontSize',fontL);
% title('DRwIN & activated','fontSize',fontL,'fontWeight','bold');
% 
% hStmspkDRw(7) = axes('Position',axpt(nCol,nRow,4,3,[0.1 0.1 0.85 0.85],wideInterval));
% plot([1,2,3],stmspk_DRwIN_lightina,'-o','color',colorBlack,'MarkerFaceColor',colorBlue);
% text(3.5,max(stmspk_DRwIN_lightina(:))*0.8,['n = ',num2str(nDRwIN_lightIna)],'fontSize',fontL);
% title('DRwIN & inactivated','fontSize',fontL,'fontWeight','bold');
% 
% hStmspkDRw(8) = axes('Position',axpt(nCol,nRow,4,4,[0.1 0.1 0.85 0.85],wideInterval));
% plot([1,2,3],stmspk_DRwIN_no,'-o','color',colorBlack,'MarkerFaceColor',colorBlue);
% text(3.5,max(stmspk_DRwIN_no(:))*0.8,['n = ',num2str(nDRwIN_lightNo)],'fontSize',fontL);
% title('DRwIN & no','fontSize',fontL,'fontWeight','bold');
% 
% formatOut = 'yymmdd';
% set(hStmspkDRw,'TickDir','out','Box','off','XLim',[0,4],'XTick',[1,2,3],'XTickLabel',{'Pre','Stm','Post'});
% % print('-painters','-r300','-dtiff',['plot_stmzoneSpike_',datestr(now,formatOut),'.tif']);
% 
% fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{2},'Name','stmzoneSpike total');
% 
% nCol = 4;
% nRow = 1;
% 
% hStmspkTotal(1) = axes('Position',axpt(nCol,nRow,1,1,[0.1 0.1 0.85 0.85],wideInterval));
% plot([1,2,3],stmspk_DRunPN_no,'-o','color',colorBlack,'MarkerFaceColor',colorGray);
% hold on;
% plot([1,2,3],stmspk_DRunPN_lightResp,'-o','color',colorBlack,'MarkerFaceColor',colorBlue,'MarkerSize',markerM);
% hold on;
% plot([1,2,3],stmspk_DRunPN_lightAct,'-o','color',colorBlack,'MarkerFaceColor',colorBlue,'MarkerSize',markerM);
% hold on;
% plot([1,2,3],stmspk_DRunPN_lightina,'-o','color',colorBlack,'MarkerFaceColor',colorBlue,'MarkerSize',markerM);
% text(3.5,max(stmspk_DRunPN_no(:))*0.8,['n = ',num2str(nDRunPN)],'fontSize',fontL);
% title('DRunPN total','fontSize',fontL,'fontWeight','bold');
% 
% hStmspkTotal(2) = axes('Position',axpt(nCol,nRow,2,1,[0.1 0.1 0.85 0.85],wideInterval));
% plot([1,2,3],stmspk_DRunIN_no,'-o','color',colorBlack,'MarkerFaceColor',colorGray);
% hold on;
% plot([1,2,3],stmspk_DRunIN_lightResp,'-o','color',colorBlack,'MarkerFaceColor',colorBlue,'MarkerSize',markerM);
% hold on;
% plot([1,2,3],stmspk_DRunIN_lightina,'-o','color',colorBlack,'MarkerFaceColor',colorBlue,'MarkerSize',markerM);
% text(3.5,max(stmspk_DRunIN_no(:))*0.8,['n = ',num2str(nDRunIN)],'fontSize',fontL);
% title('DRunIN total','fontSize',fontL,'fontWeight','bold');
% 
% hStmspkTotal(3) = axes('Position',axpt(nCol,nRow,3,1,[0.1 0.1 0.85 0.85],wideInterval));
% plot([1,2,3],stmspk_DRwPN_no,'-o','color',colorBlack,'MarkerFaceColor',colorGray);
% hold on;
% plot([1,2,3],stmspk_DRwPN_lightResp,'-o','color',colorBlack,'MarkerFaceColor',colorBlue,'MarkerSize',markerM);
% hold on;
% plot([1,2,3],stmspk_DRwPN_lightAct,'-o','color',colorBlack,'MarkerFaceColor',colorBlue,'MarkerSize',markerM);
% hold on;
% plot([1,2,3],stmspk_DRwPN_lightina,'-o','color',colorBlack,'MarkerFaceColor',colorBlue,'MarkerSize',markerM);
% text(3.5,max(stmspk_DRwPN_no(:))*0.8,['n = ',num2str(nDRwPN)],'fontSize',fontL);
% title('DRwPN total','fontSize',fontL,'fontWeight','bold');
% 
% hStmspkTotal(4) = axes('Position',axpt(nCol,nRow,4,1,[0.1 0.1 0.85 0.85],wideInterval));
% plot([1,2,3],stmspk_DRwIN_no,'-o','color',colorBlack,'MarkerFaceColor',colorGray);
% hold on;
% plot([1,2,3],stmspk_DRwIN_lightResp,'-o','color',colorBlack,'MarkerFaceColor',colorBlue,'MarkerSize',markerM);
% hold on;
% plot([1,2,3],stmspk_DRwIN_lightina,'-o','color',colorBlack,'MarkerFaceColor',colorBlue,'MarkerSize',markerM);
% text(3.5,max(stmspk_DRwIN_no(:))*0.8,['n = ',num2str(nDRwIN)],'fontSize',fontL);
% title('DRwIN total','fontSize',fontL,'fontWeight','bold');
% 
% set(hStmspkTotal,'TickDir','out','Box','off','XLim',[0,4],'XTick',[1,2,3],'XTickLabel',{'Pre','Stm','Post'});
% % print('-painters','-r300','-dtiff',['plot_stmzoneSpike_totalNeuron_',datestr(now,formatOut),'.tif']);