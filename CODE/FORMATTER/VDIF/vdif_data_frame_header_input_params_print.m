function vdif_data_frame_header_input_params_print( headerspec )

fprintf('  Bit order:                   \t\t%s\n' , headerspec.bit_msbflag )
fprintf('\n')

fprintf('  Word 0:\n')
fprintf('  Data invalid:                \t\t%s\n' , headerspec.invalid_flag )
fprintf('  VDIF standard header length: \t\t%s\n' , headerspec.standard_vdif_header_length )
fprintf('  Sec from ref epoch:          \t\t%d\n' , headerspec.sec_from_ref_epoch )
fprintf('\n')

fprintf('  Word 1:\n')
fprintf('  Half years from 2000:        \t\t%d\n' , headerspec.half_years_from_2000 )
fprintf('  Number of frame within sec:  \t\t%d\n' , headerspec.number_of_frame_within_sec )
fprintf('\n')

fprintf('  Word 2:\n')
fprintf('  VDIF version number:         \t\t%d\n' , headerspec.vdif_version_number )
fprintf('  Number of channels:          \t\t%d\n' , headerspec.number_of_channels )
fprintf('  Data frame (header+array) length: \t%d byte\n' , headerspec.data_frame_length_byte)
fprintf('\n')

fprintf('  Word 3:\n')
fprintf('  Input data type:             \t\t%s\n' , headerspec.input_data_type )
fprintf('  Number of bits per sample:   \t\t%d\n', headerspec.number_of_bits_per_sample )
fprintf('  Thread ID:                   \t\t%d\n', headerspec.thread_id )
fprintf('  Station ID:                  \t\t%s\n', headerspec.station_id )
fprintf('\n')

fprintf('  Word 4-7:\n')
fprintf('  Extended user data version:  \t\t%d\n',headerspec.extended_user_data_ver_nr)
if headerspec.extended_user_data_ver_nr == 3
    fprintf('    Unit:                   \t\t%s\n', headerspec.unit_sampling_freq )
    fprintf('    Sampling rate:          \t\t%d\n', headerspec.sampling_freq)
    fprintf('    LO IF tuning freq:      \t\t%d\n', headerspec.lo_if_tuning)
    fprintf('    DBE number at the site: \t\?%d\n', headerspec.DBE_unit)
    fprintf('    Intermediate Freq:      \t\t%d\n', headerspec.intermediate_freq);
end

end

