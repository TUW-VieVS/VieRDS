function printDelayTable(NSt,stations,sta,param,un)
% print delay table
fprintf('table: %s\n',param)
DTAUIJ = zeros(NSt,NSt);
for iSti = 1:NSt
    for iStj = 1:NSt
        iwars = sta.(stations{iSti}).index_for_ptm_signal_arrivaL_time;
        taui = sta.(stations{iSti}).p_tm.signal_arrival_station_first_sample(iwars).(param);
        
        jwars = sta.(stations{iStj}).index_for_ptm_signal_arrivaL_time;
        tauj = sta.(stations{iStj}).p_tm.signal_arrival_station_first_sample(jwars).(param);
        
        dtauij = taui-tauj;
        DTAUIJ(iSti,iStj) = dtauij;
        VarNames{iSti} = sta.(stations{iSti}).station_name_trf_coord;
        
    end
end
for iSti = 1:NSt
    iwars = sta.(stations{iSti}).index_for_ptm_signal_arrivaL_time;
    taui = sta.(stations{iSti}).p_tm.signal_arrival_station_first_sample(iwars).(param);
    DTAUI(iSti) = taui;
end
DTAU = [DTAUI;DTAUIJ];
RowNames = ['geocent',VarNames];
for ivar = 1:length(VarNames)
    fprintf('\t\t\t%s',VarNames{ivar});
end
fprintf('\n');
for irow = 1:length(RowNames)
    fprintf('%s\t\t',RowNames{irow});
    for ivar = 1:length(VarNames)
        fprintf('%f %s\t\t',DTAU(irow,ivar)*1e6,un);
    end
    fprintf('\n');
end
fprintf('-----------------------------------------------------------------\n')

end

