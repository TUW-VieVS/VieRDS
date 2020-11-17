function freq_range_matrix = create_frequency_range_matrix(s,Nch_sum)
% create frequency range matrix, which displays the upper and lower limits
% of the observed channels of each station

freq_range_matrix = zeros(Nch_sum,5);
[ stations, number_of_stations ] = station_struct_label( s );

i_ch = 1;
for iSt = 1:number_of_stations
    for iCh = 1:length(s.(stations{iSt}).f0)
        fa = s.(stations{iSt}).f0(iCh) - s.(stations{iSt}).sampling_frequency/4;
        fb = s.(stations{iSt}).f0(iCh) + s.(stations{iSt}).sampling_frequency/4;
        freq_range_matrix(i_ch,1) = fa+1e-12;
        freq_range_matrix(i_ch,2) = fb-1e-12;
        freq_range_matrix(i_ch,3) = iSt;
        freq_range_matrix(i_ch,4) = iCh;
        freq_range_matrix(i_ch,5) = i_ch;
        i_ch = i_ch+1;
    end
end

end

