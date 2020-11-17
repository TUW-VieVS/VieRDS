function Nch = get_number_of_f0_from_input( sta )
% get largest number of center frequencies defined via input

[ stations, number_of_stations ] = station_struct_label( sta );

Nch = struct;

for iSt = 1:number_of_stations
    % number of channels per station
    Nch.(stations{iSt}) = length(sta.(stations{iSt}).f0);
end

end

