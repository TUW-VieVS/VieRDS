function [ params ] = auxVDIF( params )
% Calculate auxiliary parameters for vdif file creation
% 
% Input:
%   params
%
% Output:
%   params
%
% Used functions:
%   [ hyf2000 , s ] = date2vdifdate( yyyy, mm, dd, hh, min, ss )

% frame size in bit
params.frame_length_bit                 = params.frame_length_byte*8;

% header size in bit
params.header_length_bit                = params.header_length_byte*8;

% data frame length in units of 8 bytes
params.frame_length_8byte               = params.frame_length_byte/8;

% length (number of bits) of complete sample: number of channels recorded in parallel
params.complete_sample_length_bit       = params.number_of_bits_per_sample * params.number_of_channels;

% number of samples (independend of bits per sample and number of channels)
params.num_samples_file                 = params.scan_duration * params.sampling_freq;

% data array size (without header) of total file
params.data_array_length_file_bit       = params.num_samples_file * params.number_of_bits_per_sample * params.number_of_channels; 

% data array size per frame
params.data_array_length_bit            = params.frame_length_bit - params.header_length_bit; % bit

% number of samples in frame
params.num_samples_frame                = params.data_array_length_bit / params.complete_sample_length_bit;

% number of frames
params.number_frames_file               = params.data_array_length_file_bit / params.data_array_length_bit;

% file size
params.filesize_bit                     = params.number_frames_file * params.frame_length_bit; % bit
params.filesize_byte                    = params.filesize_bit / 8;

% number of frames per second
params.number_frames_per_sec            = params.number_frames_file / params.scan_duration;

% number of words in data array
params.num_words_per_data_array         = params.data_array_length_bit / 32;

% number of complete samples per frame
params.num_complete_samples_frame       = params.data_array_length_bit / params.complete_sample_length_bit;

% number of samples per word
params.num_samples_word                 = 32 / params.complete_sample_length_bit;

% vdif time code
[ params.hyf2000 , params.sec_from_hyf2000 ]   = date2vdifdate( params.date_vec(1), params.date_vec(2), params.date_vec(3), params.date_vec(4), params.date_vec(5), params.date_vec(6) );
params.mjd       = mjuliandate( params.date_vec(1), params.date_vec(2), params.date_vec(3), params.date_vec(4), params.date_vec(5), params.date_vec(6) );

% last second recorded
params.ss_end    = params.date_vec(6) + params.scan_duration;

% last mjd recorded
params.mjd_end   = mjuliandate( datevec(datetime( [params.date_vec(1), params.date_vec(2), params.date_vec(3), params.date_vec(4), params.date_vec(5), params.ss_end] ) ));

% second start
params.second_start = (params.mjd - floor(params.mjd))*24*60*60;

% second end
params.second_end = (params.mjd_end - floor(params.mjd_end))*24*60*60;

% fprintf(' Number of frames in total: %f\n' , params.number_frames_file )
% fprintf(' Number of frames per sec: %f\n' , params.number_frames_per_sec )
% fprintf(' Ratio of frames per sec to total number: %f\n' , params.number_frames_per_sec/params.number_frames_file )
% fprintf(' Ratio of total number of frames to number per sec: %f\n', params.number_frames_file/params.number_frames_file )



end

