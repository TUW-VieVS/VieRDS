function check_signal_type_target_source( sta )
% check for same signal type target source mode between all participating stations

[ stations, number_of_stations ] = station_struct_label( sta );

for iSt = 1:number_of_stations-1
    if ~strcmp(sta.(stations{iSt}).signal_type_target_source, sta.(stations{iSt+1}).signal_type_target_source)
        fprintf('signal_type_target_source:\n');
        fprintf('%s: %s \n', sta.(stations{iSt}).station_name, sta.(stations{iSt}).signal_type_target_source );
        fprintf('%s: %s \n', sta.(stations{iSt+1}).station_name, sta.(stations{iSt+1}).signal_type_target_source );
        error('signal_type_target_source is NOT the same for both stations. That can not work (at least for this software version).')
    end
end

end

