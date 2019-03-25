clc; clearvars; close all;
load('E:\Dropbox\SNL\P2_Track\myParameters.mat');
mList = mLoad_ca;
load(mList{1});

[~, fileName_mat, ~] = fileparts(mList{1});
[~, fileName_tif, ~] = fileparts(neuron.file);
thr = 0.9;
disp_number = true;
lineWidth = 1;
fontSize = 5;
nNeuron = size(neuron.ids,2);
max_Craw = max(max(neuron.C_raw));
min_Craw = min(min(neuron.C_raw));
neuronOrder = 'snr';
neuron.orderROIs(neuronOrder); % 'decay_time', 'mean', 'sparsity_spatial', 'sparsity_temporal', 'circularity','snr', 'pnr' 

nRow_neuron = 10;
nCol_neuron = 3;
% nCol_neuron = ceil(nNeuron/10);
nFig = ceil(nNeuron/(nRow_neuron*3));

for iFig = 1:nFig
    fHandle = figure('PaperUnits','centimeters','PaperPosition',paperSize{1});

    hContour = axes('Position',axpt(2,3,1,1,[0.01 0.01 0.95 0.95],tightInterval));
    plot_contours(neuron.A, neuron.Cn, thr, disp_number, [], neuron.Coor, lineWidth, fontSize);
    colormap gray;

    hInfo = axes('Position',axpt(2,4,2,1,[0.1 0.05 0.85 0.90],tightInterval));
    text(0,1.00,['- mat-file: ',fileName_mat],'interpreter','none','fontsize',fontM);
    text(0,0.95,['- tif-file: ',fileName_tif],'interpreter','none','fontsize',fontM);
    text(0,0.90,['- # of neurons: ',num2str(nNeuron)],'fontsize',fontM);
    text(0,0.85,['- # of frames: ',num2str((neuron.frame_range(2)-neuron.frame_range(1)+1)),' (',num2str(neuron.frame_range(1)),'-',num2str(neuron.frame_range(2)),', freq: ',num2str(neuron.Fs),' Hz)'],'fontsize',fontM);

    text(0,0.75,['- neuron size: ',num2str(neuron.options.gSiz)],'fontsize',fontM);
    text(0,0.70,['- gSig: ',num2str(neuron.options.gSig)],'fontsize',fontM);
    text(0,0.65,['- min_corr: ',num2str(neuron.options.min_corr)],'interpreter','none','fontsize',fontM);
    text(0,0.60,['- min_pnr: ',num2str(neuron.options.min_pnr)],'interpreter','none','fontsize',fontM);
    set(hInfo,'visible','off');

% plot each neuron's Ca trace    
    xpt = round([neuron.frame_range(1):neuron.frame_range(2)]/neuron.Fs);
        for iCol = 1:nCol_neuron
            for iRow = 1:nRow_neuron
                iNeuron = iRow+10*(iCol-1)+30*(iFig-1);
                if iNeuron<=nNeuron
                    hCraw(iRow+10*(iCol-1)) = axes('Position',axpt(3,nRow_neuron,iCol,iRow,axpt(2,7,1:2,3:7,[0.05,0.05,0.90,0.85],tightInterval),tightInterval));
                    plot(xpt,neuron.C_raw(iNeuron,:),'lineStyle','-','lineWidth',lineWidth);
                    text(xpt(1),max_Craw*0.8,['ID: ',num2str(neuron.ids(iNeuron))],'interpreter','none','fontsize',fontM);
                else
                    break;
                end
            end          
        end
    set(hCraw,'visible','off','XLim',[xpt(1), xpt(end)],'YLim',[min_Craw,max_Craw]);
    for iTrace = 1:ceil((iRow+10*(iCol-1))/10)
        set(hCraw(10*iTrace-9),'visible','on','TickDir','out','Box','off','TickLength',[0.03, 0.03],'XTick',[0, xpt(end)/3, xpt(end)/3*2, xpt(end)],'fontSize',fontS);
    end  
    print('-painters','-r300',[fileName_mat,'_',neuronOrder,'_',num2str(iFig),'.tif'],'-dtiff');
    close;
end