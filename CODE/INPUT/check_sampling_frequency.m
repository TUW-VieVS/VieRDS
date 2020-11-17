function check_sampling_frequency( sta )
% check for same sampling rate between all participating stations

[ stations, number_of_stations ] = station_struct_label( sta );

for iSt = 1:number_of_stations-1
    if ~isfield(sta.(stations{iSt}),'sampling_frequency')
        sampling_reate_1 = 2*sta.(stations{iSt}).bandwidth;
    else
        sampling_reate_1 = sta.(stations{iSt}).sampling_frequency;
    end
    
    if ~isfield(sta.(stations{iSt+1}),'sampling_frequency')
        sampling_frequency_2 = 2*sta.(stations{iSt+1}).bandwidth;
    else
        sampling_frequency_2 = sta.(stations{iSt+1}).sampling_frequency;
    end
    
    
    if sampling_reate_1 ~= sampling_frequency_2
        fprintf('sampling_frequency:\n');
        fprintf('%s: %s \n', sta.(stations{iSt}).station_name, sampling_reate_1);
        fprintf('%s: %s \n', sta.(stations{iSt+1}).station_name, sampling_frequency_2 );
        error('sampling_frequency is NOT the same for both stations. Not possible for this version.')
    end
end

end

