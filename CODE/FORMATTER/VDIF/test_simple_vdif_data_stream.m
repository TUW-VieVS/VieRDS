clear; close all
% Create Simple VDIF data stream (single channel bit stream)

%% VDIF
% data frame (header + data array)
% data thread (same set of channels)
% data stream (stream of data threads --> same set of channels over time)
% data segment (all channels of total observation)

%% Header
% vdif test file consists of only one data frame
% header specification
headerspec = vdif_data_frame_header_input_params;
vdif_data_frame_header_input_params_print( headerspec );


delete 'test_file.vdif'

% get data frame length in byte


% check seconds
checkvdifseconds( headerspec.sec_from_ref_epoch )

% check bits/sample
checkvdifnumbitspersample( headerspec.number_of_bits_per_sample   )

% check data threads
checkvdifnumthreads( headerspec.thread_id   )

% vdifdate --> date
[yy, mm, dd, HH, MM, SS] = vdifdate2date( headerspec.half_years_from_2000 , headerspec.sec_from_ref_epoch );
dateStr = datestr([yy, mm, dd, HH, MM, SS]);
mjd = mjuliandate(yy,mm,dd,HH,MM,SS);
fprintf('\n')
fprintf('  Time tag %s, mjd: %f\n',dateStr,mjd)
fprintf('\n')

header = create_vdif_data_frame_header( headerspec );
vdif_write_data_frame_header_to_file( headerspec , header );

%% Data Array

% fileID = fopen( input.vdif_file_name  , 'a');
% fwrite( fileID , x.x, 'ubit1', 'l' );

% Ns ... number of samples
% Nc ... number of channels
% Nb ... number of bits per sample
% iDF ... data frame index
Ns  = headerspec.data_frame_length_bit/32 - 32;
Nc  = headerspec.number_of_channels;
Nb  = headerspec.number_of_bits_per_sample;
iDF = headerspec.number_of_frame_within_sec;

fid = fopen( headerspec.vdif_file_name   , 'a+');
for i = 1:Ns
    sampl = randi([0,1],1);
%     sampl = 0;
%     sampl = 1;
    fwrite( fid , sampl , 'ubit32', 'l' );
end
fclose(fid);

%% Check file size with data frame length
vdiffile=dir(headerspec.vdif_file_name);

if mod(vdiffile.bytes,8)~=0
    warning(' File size is not multiple of 8 bytes')
end
if vdiffile.bytes~=headerspec.data_frame_length_byte
    warning(' File size does not match header spec')
end

%%
fprintf('  Finished\n')

%% fake vdif file
% fid = fopen( 'fake.vdif'   , 'a');
% for i = 1:10^6
%     fwrite( fid , 0, 'ubit32', 'l' );
% end
% fclose(fid);

