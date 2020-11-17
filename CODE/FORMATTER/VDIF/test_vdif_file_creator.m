 clear; close all

% test vdif file creator of fake data

% To-Do:
% - Enable possibility to write several channel data to file & several bits
% per sample to file
% - Possibility to write header standalone and then data to file


%% Input
fprintf('  Get Input\n')

params.file_name                         = 'fake.vdif';
params.frame_length_byte                 = 8032; % bytes
params.header_length_byte                = 32; % bytes
params.date_vec                          = [2019, 8, 3, 0, 0, 43]; % year, month, day, hour, min, sec
params.scan_duration                     = 2; % seconds
params.sampling_freq                     = 64*10^3; % samples/second
params.vdif_version_number               = 1;
params.number_of_channels                = 2;
params.number_of_bits_per_sample         = 4;
params.station_2lc                       = 'XX';

%% Data
% range of values: starting from zero to
x = zeros( params.number_of_channels , params.sampling_freq*params.scan_duration );
for ichan = 1:params.number_of_channels
    x(ichan,:) = randi( [ 0 , params.number_of_bits_per_sample-1  ] , [ 1 , params.sampling_freq*params.scan_duration ] );
end

%% Header Param Calculations
fprintf('  Calculate header params\n')
params      = auxVDIF( params );

%% Global Header Specifications
fprintf('  Create global header params\n')
headerspec      = create_headerspecification_global( params );

%% Header Frame Struct
fprintf('  Create header frame params\n')
headerframes    = create_header_frames_struct( params);

%% Create headers and write data
fprintf('  Write header and data to file\n')
fid = fopen( params.file_name   , 'w' ); % discard existing content 

old_sec = [];
f = waitbar(0,'Please wait...');
fprintf('  seconds processed: ')
for id_frame = 1:params.number_frames_file
    % display processing progress
    waitbar(id_frame/params.number_frames_file , f ,'Loading your data');
    old_sec = display_processing_progress_command_window(  headerframes.sec_from_hyf2000(id_frame), old_sec );

    % header specific parameterization
    headerspec.sec_from_ref_epoch           = headerframes.sec_from_hyf2000( id_frame ); % seconds
    headerspec.half_years_from_2000         = headerframes.hyf2000( id_frame ); % Reference Epoc   
    headerspec.number_of_frame_within_sec   = headerframes.frame_within_sec( id_frame ); % Data Frame # within second
    
    % header
    header  = create_vdif_data_frame_header( headerspec );
    
    % write header to file
    % check value of msb specification
    if strcmp(headerspec.bit_msbflag,'left-msb')
        headerspec.bit_msbflag_fwrite = 'l';
    else
        warning('Msb is not set to left-msb')
    end
    fid     = vdif_write_data_frame_header_to_file( header , fid );
    
    % write data to file
    for id_sample = (1:params.num_words_per_data_array)+ (id_frame-1)*params.num_words_per_data_array
        curr_word = [];
        for id_chan = 1:params.number_of_channels
            curr_word = [ curr_word , de2bi( x( id_chan , id_sample ) , params.number_of_bits_per_sample ) ];
        end
        curr_word_32bit = zeros( 1 , 32 );
        curr_word_32bit(end-length(curr_word)+1:end) = curr_word;
        curr_word_32bit = flip( curr_word_32bit ); 
        for iwordbit = 1:32
            fwrite( fid , curr_word_32bit(iwordbit) , 'ubit1' , 'ieee-le' );
        end
        
    end
    
end
close(f);
fclose( fid );
fprintf('|\n\n')

%% check
tmp = dir(params.file_name);
if params.filesize_bit/8 == tmp.bytes
    fprintf('  VDIF file created successfully\n\n')
else
    warning('Something wrong with vdif file creation, file size doesn''t match')
end

%% print
printvdifsum( params, headerspec , headerframes )
