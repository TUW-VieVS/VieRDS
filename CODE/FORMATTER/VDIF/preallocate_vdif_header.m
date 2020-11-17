function [ header ] = preallocate_vdif_header( N )
% Preallocate vdif header struct
% Input:
%   N ... number of data frames within vdif file
% Output:
%   header ... struct

ZINT8 = [];

header = struct('invalid_flag', ZINT8 , ...
    'standard_vdif_header_length', ZINT8 , ...
    'sec_from_ref_epoch30', ZINT8 , ...
    'unnassgined', ZINT8 , ...
    'half_years_from_2000', ZINT8 , ...
    'number_of_frame_within_sec', ZINT8 , ...
    'vdif_version_number',  ZINT8 , ...
    'log2_number_of_channels', ZINT8 , ...
    'data_frame_length_8byte',  ZINT8 , ...
    'data_frame_length', ZINT8 , ... 
    'input_data_type', ZINT8 , ...
    'number_of_bits_per_sample',  ZINT8 , ...
    'number_of_bits_per_sample_powerOf2', ZINT8 , ...
    'thread_id', ZINT8 , ... 
    'station_id', ZINT8 , ...
    'extended_user_data_ver_nr', ZINT8 , ...
    'extended_user_data_word5', ZINT8 , ...
    'extended_user_data_word6', ZINT8 , ...
    'extended_user_data_word7', ZINT8 , ...
    'yy',ZINT8,'mm',ZINT8,'dd',ZINT8,'HH',ZINT8,'MM',ZINT8,'SS',ZINT8, ...
    'mjd',ZINT8, ...
    'number_of_channels',ZINT8 );
    

end

