function [] = firingrate(ncell)
load('Events.mat','basetime','pretime','stmtime','posttime');

for icell = 1:ncell
    ttdata = LoadSpikes('ttfile{icell)','tsflag','ts','vervose',0);
    spk_data = Data(ttada{icell});

    fr_base = sum(histc(spk_data/10^4,basetime/10^6))/(diff(basetime)/10^6);
    fr_prestm = sum(histc(spk_data/10^4,prestmtime/10^6))/(diff(prestmtime)/10^6);
    fr_stm = sum(histc(spk_data/10^4,stmtime/10^6))/(diff(stmtime)/10^6);
    fr_poststm = sum(histc(spk_data/10^4,posttime/10^6))/(diff(posttime)/10^6);

    save([cellname, '.mat'],...
        'fr_base','fr_prestm','fr_stm','fr_poststm','-append');
    end
end
