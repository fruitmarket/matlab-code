function waveform_correlation_plot

load('C:\Users\Lapis\OneDrive\git\matlab-code\WMIN-project\tagging\waveform_correlation.mat');

nC = [21 9 13];
r = {stat_nspv.r; stat_nssom.r; stat_wssom.r};
sponwv = {stat_nspv.m_spont_wv; stat_nssom.m_spont_wv; stat_wssom.m_spont_wv};
evokedwv = {stat_nspv.m_evoked_wv; stat_nssom.m_evoked_wv; stat_wssom.m_evoked_wv};

for iT = 1:3
    close all;
    fHandle = figure('PaperUnits','centimeters','PaperPosition',[2 2 8.9/4 6.88/4*1.5]);
    clearvars ha;

    for iC = 1:nC(iT)
        ha(iC) = axes('Position', axpt(5, 5, mod(iC-1,5)+1, floor((iC-1)/5)+1));
        hold on;
        plot(sponwv{iT}(iC,:), 'Color', 'k');
        plot(evokedwv{iT}(iC,:), 'Color', [0 0.66 1]);
        text(33/2, 2.5, ['r = ',num2str(r{iT}(iC),'%-.3f')],'FontSize', 3, 'HorizontalAlign', 'center', 'FontName', 'Arial');
    end

    set(ha, 'Visible', 'off', 'YLim', [-2 2]);
    print(gcf, '-depsc', '-r600', ['waveform_correlation_',num2str(iT),'.eps']);
end