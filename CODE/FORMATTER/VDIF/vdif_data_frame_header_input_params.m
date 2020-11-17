function [ headerspec ] = vdif_data_frame_header_input_params( headerspec )
% Creates header specification struct, each header element gets struct field
% Output:
%   headerspec ... struct

headerspec.bit_msbflag                      = 'left-msb';
headerspec.invalid_flag                     = 'false';
headerspec.standard_vdif_header_length      = 'true';
headerspec.unnassgined                      = 0;
headerspec.number_of_frame_within_sec       = 0;
headerspec.vdif_version_number              = 1;
headerspec.number_of_channels               = 1;
headerspec.log2_number_of_channels          = log2( headerspec.number_of_channels );
headerspec.data_frame_length_8byte          = 2^8*8032/8; % in units of 8 bytes (e.g. headerspec.data_frame_length = 32 --> 32*8 = 256 bytes)
headerspec.data_frame_length_byte           = headerspec.data_frame_length_8byte*8;
headerspec.data_frame_length_bit            = headerspec.data_frame_length_byte*8;
if strcmp(headerspec.standard_vdif_header_length,'true')
    headerspec.data_array_length_byte = headerspec.data_frame_length_byte - 32;
end
headerspec.input_data_type                  = 'real';
headerspec.number_of_bits_per_sample        = 1;
headerspec.thread_id                        = 0;
headerspec.station_id                       = 'Hb';


headerspec.extended_user_data_ver_nr        = 0;

% Extended user data
switch headerspec.extended_user_data_ver_nr
    case 0
        headerspec.default_edu_V0_word4 = 0;
        headerspec.default_edu_V0_word5 = 0;
        headerspec.default_edu_V0_word6 = 0;
        headerspec.default_edu_V0_word7 = 0;
    case 3    
        headerspec.unit_sampling_freq = 'MHz';
        headerspec.sampling_freq = 256;
        headerspec.lo_if_tuning = 512*10^6;
        headerspec.DBE_unit = 0; % or 1
        headerspec.intermediate_freq = 0;
end


end

