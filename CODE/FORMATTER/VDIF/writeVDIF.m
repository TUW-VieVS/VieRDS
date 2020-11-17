function params = writeVDIF( output_dir,file_name , frame_length_byte , header_length_byte , date_vec , scan_duration , sampling_freq , vdif_version_number , number_of_channels , number_of_bits_per_sample , station_2lc , samples )
% Writes vdif file
% Takes an array "samples" and stores it in a binary file in VDIF format based on the metadata specified via the other input elements.
% (1) First some checks are carried out
% (2) Global header params are calculated, which are true for all headers in the VDIF file

% Input:
%   file_name                   ... name of vdif file
%   frame_length_byte           ... length (size) of frame (header + data array) in bytes (e.g. 8032 Mbyte)
%   header_length_byte          ... lenght (size) of header in bytes
%   date_vec                    ... date of first sample in vector form
%   scan_duration               ... duration of observation in secs
%   sampling_freq               ... sampling frequency of observed data in Hz
%   number_of_channels          ... number of channels
%   number_of_bits_per_sample   ... number of bits per sample
%   station_2lc                 ... station two letter code (e.g. Hb)
%   vdif_version_number         ... vdif version number
%   samples                     ... dataset with samples [number_of_channels , number_of_samples]
%
% Used functions:
%   params          = auxVDIF( params ); % Calculation of auxiliary parameters
%   headerspec      = create_headerspecification_global( params ); % creates header params which are not changing during file
%   headerframes    = create_header_frames_struct( params); % creates frame informations
%   ...
%
% Output:
%   vdif file with specified "file_name"
%   summary table print

%% Assing arguments of this function to params struct
% beginning of vdif frame file names (one file per vdif frame)
frame_fn = 'frame_';

% final vdif file name
params.file_name                         = file_name;

% vdif frame length
params.frame_length_byte                 = frame_length_byte; % bytes

% vdif header length
params.header_length_byte                = header_length_byte; % bytes

% vdif data vector
params.date_vec   = date_vec; % year, month, day, hour, min, sec

% vdif scan duration
params.scan_duration                     = scan_duration; % seconds

% vdif sampling frequency
params.sampling_freq                     = sampling_freq; % samples/second

% vdif version number
params.vdif_version_number               = vdif_version_number;

% vdif number of channels
params.number_of_channels                = number_of_channels;

% vdif number of bits per sample
params.number_of_bits_per_sample         = number_of_bits_per_sample;

% vdif two station letter code
params.station_2lc                       = station_2lc;

%% Check input
checkWriteVDIFInput( params );

%% Calculation of auxiliary vdif params

% calculate auxiliary params
params      = auxVDIF( params );

% check auxiliary params
checkAuxVDIFParams( params );

%% Check sample dataset
checkSamples( samples , params );

%% Global Header Specifications (true for all headers within vdif file)
% preallocation for all headers
for id_frame = 1:params.number_frames_file
    headerspec(id_frame)      = create_headerspecification_global( params );
end

%% Header Frame Struct
headerframes    = create_header_frames_struct( params);

for id_frame = 1:params.number_frames_file
    % header specific parameterization
    headerspec(id_frame).sec_from_ref_epoch             = headerframes.sec_from_hyf2000( id_frame ); % seconds
    headerspec(id_frame).half_years_from_2000           = headerframes.hyf2000( id_frame ); % Reference Epoc   
    headerspec(id_frame).number_of_frame_within_sec     = headerframes.frame_within_sec( id_frame ); % Data Frame # within second
    
    % header specification
    header(id_frame)                                    = create_vdif_data_frame_header( headerspec(id_frame) );    
end

%% Create headers and write data to vdif frame files
fprintf('  Write VDIF header and data to file\n')

fprintf('  processing ... ')
fid = zeros(params.number_frames_file,1);
for id_frame = 1:params.number_frames_file
    % open new file
    fid(id_frame)   = fopen( [output_dir,frame_fn,sprintf('%.0f',id_frame),'_',params.file_name]   , 'w' ); % discard existing content 
    % create header for each frame
    fid(id_frame)   = vdif_write_data_frame_header_to_file( header(id_frame) , fid(id_frame) );
    
    % write data to file
    fid(id_frame)   = writeVDIF_data_array( params, id_frame ,samples ,fid(id_frame) );
    
    % close file
    fclose( fid(id_frame) );    
end

%% Concatenate vdif frame files
for id_frame = 1:params.number_frames_file
    fid         = fopen( [output_dir,params.file_name]   , 'a+' ); % discard existing content 
    fid2        = fopen([output_dir,frame_fn,sprintf('%.0f',id_frame),'_',params.file_name], 'r');
    data        = fread(fid2, inf, 'ubit1', 'ieee-le' );
    fclose(fid2);
    fwrite(fid, data,  'ubit1', 'ieee-le' );
    fclose(fid);
end

%% check
tmp = dir([output_dir,params.file_name]);
if params.filesize_bit/8 == tmp.bytes
    fprintf('  VDIF file size correct: %s\n\n',params.file_name )
else
    warning('Something wrong with vdif file creation, file size doesn''t match')
    size_diff = params.filesize_bit/8 - tmp.bytes;
    if size_diff>0
        fprintf(' %f byte not written to file\n' , size_diff )
    else
        fprintf(' %f byte too much written to file\n' , size_diff )
    end
    fprintf(' Make a re-run\n')
end

%% print
fprintf(' naming convention: (station_name)_(sampling_frequency)_(number_of_bits)_(number_of_channels)_(scan_length)_(special_label).vdif\n')

%% print
% printvdifsum( params, headerspec , headerframes )

%% remove vdif frame files files
delete([output_dir,frame_fn,'*.vdif'])