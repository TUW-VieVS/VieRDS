function check_input_mode( sta )
% check for same observation mode between all participating stations

[ stations, number_of_stations ] = station_struct_label( sta );

for iSt = 1:number_of_stations-1
    if ~strcmp(sta.(stations{iSt}).mode_observation, sta.(stations{iSt+1}).mode_observation)
        fprintf('MODE:\n');
        fprintf('%s: %s \n', sta.(stations{iSt}).station_name, sta.(stations{iSt}).mode_observation );
        fprintf('%s: %s \n', sta.(stations{iSt+1}).station_name, sta.(stations{iSt+1}).mode_observation );
        error('Observation Mode is NOT the same for both stations. That can not work.')
    end
end

end

