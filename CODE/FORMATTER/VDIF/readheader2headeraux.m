function params = readheader2headeraux( params , vdiffile )

% header length
if params.standard_vdif_header_length == 0
    params.header_length_bit            = 32*8;
else
    params.header_length_bit            = 32*4;
end
params.header_length_byte   = params.header_length_bit/8;

% word length (vdif standard)
params.word_length = 32;

% frame + data array length
params.frame_length_byte                 = params.frame_length_8byte * 8; % bytes
params.frame_length_bit                  = params.frame_length_byte * 8; % bits

% time stemp
[params.yy, params.mm, params.dd, params.HH, params.MM, params.SS] = vdifdate2date( params.half_years_from_2000 , params.sec_from_ref_epoch30 );
params.mjd = mjuliandate(params.yy,params.mm,params.dd,params.HH,params.MM,params.SS);

% number of channels
params.number_of_channels                = 2^params.log2_number_of_channels;

% number of bits per sample
params.number_of_bits_per_sample         = params.number_of_bits_per_sample_vdif_format + 1;

% vdif file name
params.file_name                         = vdiffile;

% file size
s                                       = dir( params.file_name );
params.filesize_byte                     = s.bytes;
params.filesize_bit                      = params.filesize_byte * 8;


% number of frames per file
params.number_frames_file                = params.filesize_bit / params.frame_length_bit;
if mod( params.number_frames_file , 1 ) ~= 0
    warning('Total number of frames in file is NOT integer value. File writing abrupted before ending?')
end

% length (size) of data array of single frame
params.data_array_length_bit             = params.frame_length_bit - params.header_length_bit;
params.data_array_length_byte            = params.data_array_length_bit/8;

% num_words_per_data_array
params.num_words_per_data_array         = params.data_array_length_bit / 32;

% number of samples per frame
params.num_samples_frame                 = params.data_array_length_bit / params.number_of_bits_per_sample;

% number of samples per file
params.num_samples_file                  = params.number_frames_file * params.num_samples_frame;

% cummulated array length (size) of all frames in file
params.data_array_length_file_bit        = params.data_array_length_bit * params.number_frames_file;

% check complete_sample_length_bit <= 32
params.complete_sample_length_bit        = params.number_of_channels * params.number_of_bits_per_sample;

% number of complete_samples in data array
params.num_complete_samples_frame       = params.data_array_length_bit/params.complete_sample_length_bit;

% number of complete_samples in word
params.num_complete_samples_word        = 32 / params.complete_sample_length_bit;

% number of samples in word
params.num_samples_word             = 32 / params.number_of_bits_per_sample;

if params.complete_sample_length_bit > 32
    error('This VDIF reader only supports a maximum of 2^(num_channels)*2^(bits/sample) = 32 bits')
end

end

