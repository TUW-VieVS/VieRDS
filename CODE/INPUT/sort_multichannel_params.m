function s = sort_multichannel_params(s,multi_channel_spec)
% sort frequencies and corresponding multichannel params

[ stations, number_of_stations ] = station_struct_label( s );
for iSt = 1:number_of_stations
    P = multi_channel_spec.(stations{iSt});
    [~, i_sort] = sort(s.(stations{iSt}).f0);
    for iM = 1:length(P)
        s.(stations{iSt}).(P{iM}) = s.(stations{iSt}).(P{iM})(i_sort);
    end
end

end

