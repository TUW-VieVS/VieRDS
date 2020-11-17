function fid  = vdif_write_data_frame_header_to_file( header,fid )
% create VDIF frame header 

% check fieldnames of var
if ~strcmp(header.ref.EUDV0.data_fieldnames,fieldnames(header.val))
    warning(' Incorrect header fieldnames')
end

% write data to header
val_fieldnames = fieldnames(header.val);
curr_word = [];
curr_wordi_old = 0;
for i_elem = 1:length(fieldnames(header.val))
    curr_fieldname  = val_fieldnames{i_elem};
    curr_wordi_new  = header.word.(curr_fieldname);
    
    % write if new word is reached
    if curr_wordi_new ~= curr_wordi_old
        if length(curr_word) == 32
%             fprintf('%d',curr_word); fprintf('\n');
            curr_word = flip( curr_word );
            fwrite( fid , curr_word , 'ubit1' , 'ieee-le' );
            curr_word = [];
        else
            warning('Something went wrong. Programmers fault')
        end
    end
    
    curr_bits       = header.bits.(curr_fieldname);
    curr_word       = [ curr_word, curr_bits ];
    
    curr_wordi_old = curr_wordi_new;
    
    % for last word
    if i_elem == length(fieldnames(header.val))
        if length(curr_word) == 32
%             fprintf('%d',curr_word); fprintf('\n');
            curr_word = flip( curr_word );
            fwrite( fid , curr_word , 'ubit1' , 'ieee-le' );
            curr_word = [];
        else
            warning('Something went wrong. Programmers fault')
        end
    end 
end


end

