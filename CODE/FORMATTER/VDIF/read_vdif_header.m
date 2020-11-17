function [ header , fid ] = read_vdif_header( fid )
% read single header
% Input:
%   fid     ... file identifier (comes from fopen/fseek)
% Output:
%   header  ... struct with header params as struct-fields 

word_length = 32;

for iword = 0:7
   
    word = flip( fread( fid , word_length , 'ubit1' ,  'ieee-le') );
%     fprintf( '%d' , word ); fprintf( '\n' );
    
    switch iword
       
        case 0 % word 0
            header.invalid_flag                     = word(1);
            header.standard_vdif_header_length      = word(2);
            header.sec_from_ref_epoch30             = bi2de( word(3:word_length)','left-msb');
        
        case 1 % word 1
            header.unnassgined                      = [ word(1) , word(2) ];
            header.half_years_from_2000             = bi2de( word(3:8)','left-msb');
            header.number_of_frame_within_sec       = bi2de( word(9:word_length)','left-msb');
        
        case 2 % word 2
            header.vdif_version_number              = bi2de( word(1:3)','left-msb');
            header.log2_number_of_channels          = bi2de( word(4:8)','left-msb');
            header.frame_length_8byte               = bi2de( word(9:word_length)','left-msb');
            
        case 3 % word 3
            header.input_data_type                          = word(1);
            header.number_of_bits_per_sample_vdif_format    = bi2de( word(2:6)','left-msb');
            header.thread_id                                = bi2de( word(7:16)','left-msb');
            header.station_2lc                               = char(bin2dec(reshape( sprintf('%d', word(17:32)) ,8,[]).')).';
            
        case 4 % word 4
            header.extended_user_data_ver_nr        = bi2de( word(1:8)','left-msb');
            
        case 5 % word 5
            header.extended_user_data_word5         = word;
            
        case 6 % word 6
            header.extended_user_data_word6         = word;
            
        case 7 % word 7
            header.extended_user_data_word7         = word;
    end
    
end

end

