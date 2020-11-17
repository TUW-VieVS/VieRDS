function [ headerspec ] = create_headerspecification_global( params )
% creates header specification parameters which are global (true for all header within vdif file)
% 
% Input:
%   params (struct)
%
% Output:
%   headerspec (struct)

% some assignements and calculations
headerspec.bit_msbflag                              = 'left-msb';
headerspec.invalid_flag                             = 'false';
headerspec.standard_vdif_header_length              = 'true';
headerspec.unnassgined                              = 0;
headerspec.thread_id                                = 0;
headerspec.input_data_type                          = 'real';
headerspec.extended_user_data_ver_nr                = 0;
headerspec.station_2lc                              = params.station_2lc ;
headerspec.vdif_version_number                      = params.vdif_version_number;
headerspec.number_of_channels                       = params.number_of_channels;
headerspec.log2_number_of_channels                  = log2( headerspec.number_of_channels );
headerspec.frame_length_8byte                       = params.frame_length_8byte; % in units of 8 bytes (e.g. headerspec.data_frame_length = 32 --> 32*8 = 256 bytes)
headerspec.frame_length_byte                        = params.frame_length_byte;
headerspec.frame_length_bit                         = params.frame_length_bit;
headerspec.number_of_bits_per_sample                = params.number_of_bits_per_sample ;
headerspec.number_of_bits_per_sample_vdif_format    = headerspec.number_of_bits_per_sample - 1;

% frame length
if strcmp(headerspec.standard_vdif_header_length,'true')
    headerspec.data_array_length_byte               = headerspec.frame_length_byte - 32;
end

% Extended user data
switch headerspec.extended_user_data_ver_nr
    case 0
        headerspec.default_edu_V0_word4 = 0;
        headerspec.default_edu_V0_word5 = 0;
        headerspec.default_edu_V0_word6 = 0;
        headerspec.default_edu_V0_word7 = 0;
    case 3    
        headerspec.unit_sampling_freq   = 'MHz';
        headerspec.sampling_freq        = 256;
        headerspec.lo_if_tuning         = 512*10^6;
        headerspec.DBE_unit             = 0; % or 1
        headerspec.intermediate_freq    = 0;
end

end

