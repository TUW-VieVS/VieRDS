function read_vdif_word_per_word( file )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
fid = fopen( file );
if fid < 0
    warning('\tCan not open file:\t\t%s\n',file)
end

word_length = 32;
iline = 0;
k = 1;
j = 1;
while ~feof( fid )

    if mod( iline - 2, 8032*8/32 ) == 0
%         fprintf( '%d',word); fprintf('\n')
        data_frame_within_sec(k)    = bi2de( word(32-24:32)' , 'left-msb'   );
        k = k +1;
    end
    if mod( iline - 1, 8032*8/32 ) == 0
%         fprintf( '%d',word); fprintf('\n')
        sec_from_ref_epoch(j)       = bi2de( word(32-30:32)' , 'left-msb'   );
        j = j +1;
    end
    
%         word = flip( fread( fid , word_length , 'ubit1') );
        word = flip( fread( fid , word_length , 'ubit1' , 'ieee-le' ) );
        fprintf( '%d',word); fprintf('\n')
        iline = iline +1;
%         if mod( iline , 8032*8/32 ) == 0
% %             fprintf(' New frame\n')
%                     fprintf( '%d',word); fprintf('\n')
% 
%         end
    
end

end

