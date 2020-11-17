function [ header ] = vdif_header_calcs( header )
% Uses vdif header params and calculates further params (mostly to be more readable)
% Input:
%   header ... struct
% Output:
%   header ... struct

% time stemp
[header.yy, header.mm, header.dd, header.HH, header.MM, header.SS] = vdifdate2date( half_years_from_2000 , sec_from_ref_epoch30 );
header.mjd = mjuliandate(header.yy,header.mm,header.dd,header.HH,header.MM,header.SS);

% number of channels
header.number_of_channels                   = 2^header.log2_number_of_channels;

% data frame length
header.data_frame_length                    = data_frame_length_8byte * 8;

% number of bits per sample
warning(' Number of bits per sample calculation is not clear. Need be clearified')
header.number_of_bits_per_sample_powerOf2   = 2^header.number_of_bits_per_sample;

end

