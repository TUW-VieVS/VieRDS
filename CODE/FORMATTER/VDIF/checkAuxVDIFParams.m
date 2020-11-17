function checkAuxVDIFParams( params )

% check data array length
if mod( params.num_words_per_data_array , 1 ) ~= 0
    error('something wrong with data array length')
end

% check number of frames within sec
if mod( params.number_frames_per_sec , 1 ) ~= 0
    fprintf(' Number of frames per sec: %f\n', params.number_frames_per_sec )
    error(' Number of frames is NOT integer values. You might check the product of scan duration and sampling rate')
end
if params.number_frames_per_sec <= 1
    error(' Number of frames per seconds less than 1. Will lead to vdif error in difx library (error -5)')
end
if params.number_frames_file < 3
    fprintf(' Number of frames in file: %d\n', params.number_frames_file )
    error(' Number of frames in file must be larger than 2 ')
end

% check if data frame is integral number of total file
if mod( params.filesize_bit , params.frame_length_bit )  ~= 0 
    error('something wrong with file size or frame size')
end

% check number of bits
if mod( params.num_samples_word , 1) ~= 0
    warning('Number of samples per vdif word is NOT integer')
end

% check complete sample length
if params.complete_sample_length_bit > 32
    fprintf('  Length of complete sample: %f\n',params.complete_sample_length_bit)
    error('This VDIF reader only supports a maximum of 2^(num_channels)*2^(bits/sample) = 32 bits')
end

end

