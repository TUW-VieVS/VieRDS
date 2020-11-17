function [ headerframes ] = create_header_frames_struct( params )
% Create struct with frame parameterization of vdif file

N   = params.number_frames_file - 1;
ZN  = zeros(1,N);

N1  = params.number_frames_per_sec-1;

headerframes = struct( 'frame_id' , ZN , 'frame_within_1sec' , zeros(1, N1 ) , ...
    'frame_within_sec' , ZN , 'hyf2000' , ZN , 'sec' , ZN , 'pointer_header' , ZN );

% .frame_id (starting from zero)
headerframes.id_frame = 0 : N;

% .frame_within_1sec (startin from zero)
headerframes.frame_within_1sec = 0 : N1;

% .frame_within_sec (starting from zero)
headerframes.frame_within_sec = repmat( headerframes.frame_within_1sec , 1 , params.scan_duration  );

% .hyf2000
if (params.sec_from_hyf2000 + params.scan_duration) > (day(datetime([2019, 07, 01, 00, 0, 0]),'dayofyear') - 1 ) * 24*60*60
    warning('Observation very close half year boundery, roll over half year boundary will NOT be consider --> problem')
end
headerframes.hyf2000 = ones( 1 , params.number_frames_file ) * params.hyf2000;

% .sec
headerframes.sec_from_hyf2000 =  [];
for isec = 0 : (params.scan_duration-1)
    headerframes.sec_from_hyf2000 = [ headerframes.sec_from_hyf2000 , ones( 1 , params.number_frames_per_sec ) * params.sec_from_hyf2000 + isec ]; 
end

% .pointer_header
headerframes.pointer_header = 0 : params.frame_length_byte : (params.filesize_byte-params.frame_length_byte);

end

