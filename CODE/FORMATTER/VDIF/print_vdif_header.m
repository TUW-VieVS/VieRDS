function print_vdif_header( header )
% prints header information

fprintf( '\tstation:\t%s\n' , header.station_2lc )
% fprintf( '\ttime tag:\t%s\n' , datestr([header.yy, header.mm, header.dd, header.HH, header.MM, header.SS]) )
% fprintf( '\tmjd:\t%f\n' , header.mjd )
fprintf( '\t#frame within sec:\t%d\n' , header.number_of_frame_within_sec )
fprintf( '\t#channels:\t%d\n' , header.number_of_channels )
fprintf( '\tframe size:\t%d bytes\n' , header.frame_length_byte )
fprintf( '\t#bits/sample:\t%d\n' , header.number_of_bits_per_sample )

end

