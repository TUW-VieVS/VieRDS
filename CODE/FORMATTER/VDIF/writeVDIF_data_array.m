function fid = writeVDIF_data_array( params, id_frame ,samples ,fid)
% write samples to VDIF file

id_variant = 2; % variant 2 way faster

switch id_variant
    
    case 1
        curr_word   = [];
        for id_complexsample = (1:params.num_complete_samples_frame) + (id_frame-1)*params.num_complete_samples_frame
            for id_chan = 1:params.number_of_channels
                curr_bits = de2bi( samples( id_chan , id_complexsample ) , params.number_of_bits_per_sample , 'left-msb' );
                curr_word = [ curr_word , curr_bits ];
                if length( curr_word ) == 32
                    fwrite( fid , flip( curr_word ) , 'ubit1' , 'ieee-le' );
                    curr_word = [];
                end
            end
        end
        
    case 2
        
        % start index matlab samples vector (non-binary representation)
        k = (id_frame-1)*params.num_complete_samples_frame+1;
        
        % stop index matlab samples vector
        l = k+params.num_samples_word*params.num_words_per_data_array-1;
        
        % get matlab samples
        a = samples( : , k:l );
        
        % reshape to column vector
        a = a(:);
        
        % conversion from decimal integer (a) to binary representation (curr_word)
        curr_word = de2bi( a , params.number_of_bits_per_sample , 'right-msb' ).';
        
        % reshape to column vector
        curr_word = curr_word(:);
        
        % write binary representation to file
        fwrite( fid , curr_word , 'ubit1' , 'ieee-le' );
        
end

