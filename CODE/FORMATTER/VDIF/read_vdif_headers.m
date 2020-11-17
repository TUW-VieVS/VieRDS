function [ header ] = read_vdif_headers( file )
% Reads vdif file and extracts information of all headers within the file
% Input:
%   file ... vdif file
% Output:
%   header(i) ... struct with header parameters, i = 1:N N ... number of headers

%% file properties

sfile = dir( file );


%% read first header
% to get frame size
fprintf(' Read first header of file:\t\t%s\n',file)
fid = fopen( file );
if fid < 0
    warning('\tCan not open file:\t\t%s\n',file)
end
[ header , fid ] = read_vdif_header( fid );
fclose( fid );

print_vdif_header( header )

sfile.num_data_frames = sfile.bytes/header.data_frame_length;

%% preallocate
% header = struct('invalid_flag',[],'standard_vdif_header_length',[],'sec_from_ref_epoch30',[],'unnassgined',[],'half_years_from_2000',[],'number_of_frame_within_sec',[],'vdif_version_number',[],'log2_number_of_channels',[],'data_frame_length_8byte',[],'input_data_type',[],'number_of_bits_per_sample',[],'thread_id',[],'station_id',[],'extended_user_data_ver_nr',[],'extended_user_data_word5',[],'extended_user_data_word6',[],'extended_user_data_word7',[],'yy',[],'mm',[],'dd',[],'HH',[],'MM',[],'SS',[],'mjd',[],'number_of_channels',[],'data_frame_length',[],'number_of_bits_per_sample_powerOf2',[]);
% [ header ] = preallocate_vdif_header( sfile.num_data_frames );
[ header ] = preallocate_vdif_header( sfile.num_data_frames );


%% read all headers from 1 to N
fprintf(' Read headers of file:\t\t%s\n',file)
fid = fopen( file );
if fid < 0
    warning('\tCan not open file:\t\t%s\n',file)
end

iheader = 0;
while ~feof( fid )
    iheader = iheader + 1;
    [ header(iheader) , fid ] = read_vdif_header( fid );

    fseek( fid , header(iheader).data_frame_length-(8*4) , 'cof' ) ;
    
end
fclose( fid );



end

