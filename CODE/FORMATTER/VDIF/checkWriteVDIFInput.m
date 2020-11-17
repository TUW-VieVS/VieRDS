function checkWriteVDIFInput( params )
% check input of writeVDIF function

% file name
if ~ischar( params.file_name )
    error(' File name is not string')
end

% frame header length
if ischar( params.frame_length_byte )
    error(' Specified frame length is string, must be integer value')
end
if params.frame_length_byte == 0
    error(' Specified frame length is zero')
end
if mod( params.frame_length_byte*8 , 32 )~=0
    error(' Specified frame length is not multiple of 32 bit (1 word)')
end

% date vec
if length( params.date_vec ) ~= 6
    error(' Specified VDIF date does NOT have six entries')
end

% scan duration
if ischar( params.scan_duration )
    error(' Wrong data type of scan duration')
end
if mod( params.scan_duration , 1 ) ~= 0
    warning(' Scan duration is not integer value --> problem ')
end

% number of channels and bit per sample
if params.number_of_channels*params.number_of_bits_per_sample > 32
    error(' N_ch * N_bits is larger 32, does NOT fit in one single word. Decrease number of channels or number of bits')
end

% station 2 letter code
if isempty( params.station_2lc )
    params.station_2lc = 'NA';
    fprintf(' No station two letter code name specified. Now set to: "NA"\n')
end
if ~ischar( params.station_2lc )
    error(' Specified two letter station code is not string in VDIF file creation')
else
    if length( params.station_2lc ) > 2
        error(' Specified length of two letter station code in VDIF file creation is too long')
    end
end

end

