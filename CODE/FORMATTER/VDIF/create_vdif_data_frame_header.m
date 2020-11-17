function  [ header ]=create_vdif_data_frame_header( headerspec )
% Creates header for VDIF
% Input:
%   input ... struct
% Output:
%   header ... struct, values per header elements
%   header.ref ... header element description
%   header.val ... values in non binary format (e.g. integer value of 10 or string 'Hb')
%   header.bits ... bit stream (bit representation of value)
%   header.nbit ... number of bits per element


%% Header description
% figure                        | nbit  | matlab var                    | description
% I1                            | 1     | invalid_flag                  | Invalid flag to specifiy if data is valid or not, valid = 0, invalid = 1
% L1                            | 1     | standard_vdif_header_length   | Legace mode: 16byte or 32byte header
% sec_from_ref_epoch30          | 30    | sec_from_ref_epoch            | Seconds from reference epoch
% U2                            | 2     | unnassgined                   | unassgined, [0,0]
% Ref Epoch                     | 6     | half_years_from_2000          | Ref epoch: half year counter since 2000
% Data Frame # within second    | 24    | number_of_frame_within_sec    | Data frame # within second (sequential)
% V3                            | 3     | vdif_version_number           | vdif version number
% log2(#ch)                     | 5     | log2_number_of_channels       | log 2 (#channels in Data Array); #chans must be power of 2;
% Data Frame length             | 24    | frame_length_8byte            | Data Frame length (including header) in units of 8 bytes
% C1                            | 1     | input_data_type               | Data type, ?0? ? Real data, ?1? ? Complex data
% bits/sample-1                 | 5     | number_of_bits_per_sample     | #bits/sample-1 (32 bits/sample max)
% Thread ID                     | 10    | thread_id                     | Thread ID (0 to 1023)
% Station ID                    | 16    | station_2lc                   | The 16-bit ?Station ID? field will accommodate the standard globally assigned 2-character ASCII ID.
% EDV                           | 8     | extended_user_data_ver_nr     | Format and interpretation of extended user data is indicated by the value of Extended Data Version (EDV)

                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        %        |Bit 31 (MSB)                                   Bit 0 (LSB)|%
                        % Word 0 | I1 | L1 |           sec_from_ref_epoch30                 |%
                        % Word 1 |   U2    |  Ref Epoch   |   Data Frame # within second    |%
                        % Word 2 |     V3     | log2(#ch) |      Data Frame length          |%
                        % Word 3 | C1 | bits/sample-1 | Thread ID |      Station ID         |%
                        % Word 4 |           EDV          |       Extended User data        |%
                        % Word 5 |               Extended User data                         |%
                        % Word 6 |               Extended User data                         |%
                        % Word 7 |               Extended User data                         |%
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Reference values of the header

% EUD Version 0 (standard)

% Reference variable names of all elements of all words of the header
header.ref.EUDV0.data_varnames = { 'invalid_flag' ; 'standard_vdif_header_length' ; 'sec_from_ref_epoch' ; 'unnassgined' ; 'half_years_from_2000' ; 'number_of_frame_within_sec' ; 'vdif_version_number' ; 'log2_number_of_channels' ; 'data_frame_length' ; 'input_data_type' ; 'number_of_bits_per_sample_vdif_format' ; 'thread_id' ; 'station_id' ;  'extended_user_data_ver_nr' ; 'default_edu_V0_word4'; 'default_edu_V0_word5'; 'default_edu_V0_word6'; 'default_edu_V0_word7' };

% Reference fieldnames of all elements of all words of the header
header.ref.EUDV0.data_fieldnames = {'w0b3131';'w0b3030';'w0b2900';'w1b3130';'w1b2924';'w1b2300';'w2b3129';'w2b2824';'w2b2300';'w3b3131';'w3b3026';'w3b2516';'w3b1500';'w4b3124';'w4b2300';'w5b3100';'w6b3100';'w7b3100'};

% Reference data types of all elements of all words of the header
header.ref.EUDV0.data_type = { 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'char' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' };
    
% Reference precision of all the elements of all words of the header
header.ref.EUDV0.data_precision = [ 1 ; 1 ; 30 ; 2 ; 6 ; 24 ; 3 ; 5 ; 24 ; 1 ; 5 ; 10 ; 16 ; 8 ; 24 ; 32 ; 32 ; 32 ];

if length(header.ref.EUDV0.data_fieldnames) ~= length(header.ref.EUDV0.data_type) || length(header.ref.EUDV0.data_type) ~= length(header.ref.EUDV0.data_precision) || length(header.ref.EUDV0.data_varnames) ~= length(header.ref.EUDV0.data_type)
    error(' Something wrong with the reference definitions. Programmer fault')
end

% EUD Version 3 (VLBA)
% Reference fieldnames of all elements of words 1-3 of the header
header.ref.EUDV3.data_fieldnames = {'w0b3131';'w0b3030';'w0b2900';'w1b3130';'w1b2924';'w1b2300';'w2b3129';'w2b2824';'w2b2300';'w3b3131';'w3b3026';'w3b2516';'w3b1500';'w4b3124';'w4b2323';'w4b2200';'w5b3100';'w6b3100';'w7b3128';'w7b2724';'w7b2320';'w7b1916';'w7b1616';'w7b1512';'w7b1108';'w7b0700'};

% Reference data types of all elements of words 1-3 of the header
header.ref.EUDV3.data_type = { 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'char' ;  'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' };
    
% Reference precision of all the elements of words 1-3 of the header
header.ref.EUDV3.data_precision = [ 1 ; 1 ; 30 ; 2 ; 6 ; 24 ; 3 ; 5 ; 24 ; 1 ; 5 ; 10 ; 16 ; 8 ; 1 ; 23 ; 32 ; 32 ; 4 ; 4 ; 4 ; 3 ; 1 ; 4 ; 4 ; 8 ];

if length(header.ref.EUDV3.data_fieldnames) ~= length(header.ref.EUDV3.data_type) || length(header.ref.EUDV3.data_type) ~= length(header.ref.EUDV3.data_precision)
    error(' Something wrong with the reference definitions. Programmer fault')
end

%% WORD 0 

% bit 31
% Invalid data (i.e. data in this Data Frame has been tagged Invalid by the data source); valid=0, invalid=1
nbit.w0b3131 = 1;
word.w0b3131 = 0;
if strcmp(headerspec.invalid_flag,'false')
    bits.w0b3131 = false;
    val.w0b3131 = 0;
else
    bits.w0b3131 = true;
    val.w0b3131 = 1;
end

% bit 30
% legacy mode; see Note 1
% 0 - standard 32-byte VDIF Data Frame header
% 1  legacy header-length mode; Words 4-7 omitted from header
nbit.w0b3030 = 1;
word.w0b3030 = 0;
if strcmp(headerspec.standard_vdif_header_length,'true')
    bits.w0b3030 = false;
    val.w0b3030 = 0;
else
    bits.w0b3030 = true;
    val.w0b3030 = 1;
end

% bit 29-0
% Seconds from reference epoch;
nbit.w0b2900 = 30;
word.w0b2900 = 0;
if headerspec.sec_from_ref_epoch >= 2^nbit.w0b2900
    warning('Number of seconds from reference exceeds limit. Must be smaller than 2^30')
end
bits.w0b2900 = de2bi( headerspec.sec_from_ref_epoch , nbit.w0b2900 , headerspec.bit_msbflag );
val.w0b2900 = headerspec.sec_from_ref_epoch;

%% WORD 1

%bit 31-30 Unassigned (should be set to all 0's)
nbit.w1b3130 = 2;
word.w1b3130 = 1;
bits.w1b3130 = [false,false];
val.w1b3130 = headerspec.unnassgined;

% bit 29-24 Reference Epoch for second count
nbit.w1b2924 = 6;
word.w1b2924 = 1;
if headerspec.half_years_from_2000 >= 2^nbit.w1b2924
    warning('Number of half year counter exceeds limit. Must be smaller than 2^6')
end
bits.w1b2924 = de2bi( headerspec.half_years_from_2000 , nbit.w1b2924 , headerspec.bit_msbflag );
val.w1b2924 = headerspec.half_years_from_2000;

% bit 23-0 Data Frame # within second, starting at zero; must be integral number of Data Frames per second
nbit.w1b2300 = 24;
word.w1b2300 = 1;
if headerspec.number_of_frame_within_sec >=2^nbit.w1b2300
    warning('Number of frames exceed limit. Must be smaller than 2^24')
end
bits.w1b2300 = de2bi( headerspec.number_of_frame_within_sec , nbit.w1b2300 , headerspec.bit_msbflag );
val.w1b2300 = headerspec.number_of_frame_within_sec;


%% WORD 2

% bit 31-29 VDIF version number
nbit.w2b3129 = 3;
word.w2b3129 = 2;
if headerspec.vdif_version_number >= 2^nbit.w2b3129
    warning('VDIF version number is too large')
end
bits.w2b3129 = de2bi( headerspec.vdif_version_number , nbit.w2b3129 , headerspec.bit_msbflag );
val.w2b3129 = headerspec.vdif_version_number;

% bit 28-24 #chans must be power of 2
nbit.w2b2824 = 5;
word.w2b2824 = 2;
if floor(headerspec.log2_number_of_channels) ~= headerspec.log2_number_of_channels
    warning('Number of channels is not power of 2')
end
if headerspec.log2_number_of_channels >= 2^nbit.w2b2824
    warning('Number of channels exceed limit.')
end

bits.w2b2824 = de2bi( headerspec.log2_number_of_channels , nbit.w2b2824 , headerspec.bit_msbflag );
val.w2b2824 = headerspec.log2_number_of_channels;

% bit 23-0 Data Frame length (including header) in units of 8 bytes
nbit.w2b2300 = 24;
word.w2b2300 = 2;
if headerspec.frame_length_8byte >= 2^nbit.w2b2300
    warning('Data frame length (including header) exceeds limit')
end
if mod(headerspec.frame_length_8byte*8,8) ~= 0
    warning('Data frame length is not multiple of 8 byte')
end
bits.w2b2300 = de2bi( headerspec.frame_length_8byte , nbit.w2b2300 , headerspec.bit_msbflag );
val.w2b2300 = headerspec.frame_length_8byte;


%% WORD 3 

% bit 31 data type
nbit.w3b3131 = 1;
word.w3b3131 = 3;
if strcmp( headerspec.input_data_type , 'real' )
    bits.w3b3131 = false;
    val.w3b3131 = 0;
end
if strcmp( headerspec.input_data_type , 'complex' )
    bits.w3b3131 = true;
    val.w3b3131 = 1;
end

% bit 30-26 #bits/sample-1 (32 bits/sample max)
nbit.w3b3026 = 5;
word.w3b3026 = 3;
if headerspec.number_of_bits_per_sample_vdif_format >= 2^nbit.w3b3026
    warning('Number of bits per sample exceeds limit')
end
bits.w3b3026 = de2bi( headerspec.number_of_bits_per_sample_vdif_format , nbit.w3b3026 , headerspec.bit_msbflag );
val.w3b3026 = headerspec.number_of_bits_per_sample_vdif_format;

% bit 25-16 Thread ID (0 to 1023)
nbit.w3b2516 = 10;
word.w3b2516 = 3;
if headerspec.thread_id >= 2^nbit.w3b2516
    warning('Thread ID number exceeds limit')
end
bits.w3b2516 = de2bi( headerspec.thread_id , nbit.w3b2516 , headerspec.bit_msbflag );
val.w3b2516 = headerspec.thread_id;

% bit 15-00 Station ID 
nbit.w3b1500 = 16;
word.w3b1500 = 3;
if length(headerspec.station_2lc)>2
    error('Station two letter code is too long')
end
bits.w3b1500 = reshape(dec2bin(headerspec.station_2lc,nbit.w3b1500/2).'-'0',1,[]);
val.w3b1500 = headerspec.station_2lc;

%% Extended User Data (EUD) 

switch headerspec.extended_user_data_ver_nr
    
    case 0 % NO EUD
    
        % WORD 4 
        
        % bit 31-24 Extended Data Version (EDV) number
        nbit.w4b3124 = 8;
        word.w4b3124 = 4;
        bits.w4b3124 = de2bi( headerspec.extended_user_data_ver_nr , nbit.w4b3124 , headerspec.bit_msbflag );
        val.w4b3124 = headerspec.extended_user_data_ver_nr;
        
        % bit 23-00 Default 0's
        nbit.w4b2300 = 24;
        word.w4b2300 = 4;
        bits.w4b2300 = de2bi( headerspec.default_edu_V0_word4 , nbit.w4b2300 , headerspec.bit_msbflag );
        val.w4b2300 = headerspec.default_edu_V0_word4;
        
        % WORD 5 
        
        % bit 31-00 Default 0's
        nbit.w5b3100 = 32;
        word.w5b3100 = 5;
        bits.w5b3100 = de2bi( headerspec.default_edu_V0_word5 , nbit.w5b3100 , headerspec.bit_msbflag );
        val.w5b3100 = headerspec.default_edu_V0_word5;
        
        % WORD 6 
        
        % bit 31-00 Default 0's
        nbit.w6b3100 = 32;
        word.w6b3100 = 6;
        bits.w6b3100 = de2bi( headerspec.default_edu_V0_word6 , nbit.w6b3100 , headerspec.bit_msbflag );
        val.w6b3100 = headerspec.default_edu_V0_word6;
        
        % WORD 7 
        
        % bit 31-00 Default 0's
        nbit.w7b3100 = 32;
        word.w7b3100 = 7;
        bits.w7b3100 = de2bi( headerspec.default_edu_V0_word7 , nbit.w7b3100 , headerspec.bit_msbflag );
        val.w7b3100 = headerspec.default_edu_V0_word7;
    
    case 3 % EUD VLBA
    
        % WORD 4 
        
        % bit 31-24 Extended Data Version (EDV) number
        nbit.w4b3124 = 8;
        word.w4b3124 = 4;
        if headerspec.extended_user_data_ver_nr >= 2^nbit.w4b3124
            warning('EDV number exceeds limit')
        end
        bits.w4b3124 = de2bi( headerspec.extended_user_data_ver_nr , nbit.w4b3124 , headerspec.bit_msbflag );
        val.w4b3124 = headerspec.extended_user_data_ver_nr;
        
        % bit 23 Units: 0 = KHz, 1 = MHz
        nbit.w4b2323 = 1;
        word.w4b2323 = 4;
        bits.w4b2323 = 9999999;
        if strcmp(headerspec.unit_sampling_freq,'KHz')
            bits.w4b2323 = false;
            val.w4b2323 = 0;
        end
        if strcmp(headerspec.unit_sampling_freq,'MHz')
            bits.w4b2323 = true;
            val.w4b2323 = 1;
        end
        if bits.w4b2323 == 9999999
            warning('Unit is not set correctly')
        end
        
        % bit 22-0 Sampling Rate in U units (ksps or Msps)
        nbit.w4b2200 = 23;
        word.w4b2200 = 4;
        if headerspec.sampling_freq >= 2^nbit.w4b2200
            warning('Sampling rate exceeds limit')
        end
        bits.w4b2200 = de2bi( headerspec.sampling_freq , nbit.w4b2200 , headerspec.bit_msbflag );
        val.w4b2200 = headerspec.sampling_freq;
        
        % WORD 5 
        
        % bit 31-0 Sync Pattern 0xACABFEED
        nbit.w5b3100 = 32;
        word.w5b3100 = 5;
        val.w5b3100 = '0xACABFEED';
        
        % WORD 6 
        
        % bit 32-0 LOIF Frequency Tuning Word, unsigned int - # of Hz (32)
        nbit.w6b3100 = 32;
        word.w6b3100 = 6;
        val.w6b3100 = headerspec.lo_if_tuning;
        
        % WORD 7 
        
        % bit 31-28 Unassigned
        nbit.w7b3128 = 4;
        word.w7b3128 = 7;
        bits.w7b3128 = [false,false,false,false];
        val.w7b3128 = 0;
        
        % bit 27-24 DBE unit
        nbit.w7b2724 = 4;
        word.w7b2724 = 7;
        val.w7b2724 = headerspec.DBE_unit;
        
        % bit 23-20 IF
        nbit.w7b2320 = 4;
        word.w7b2320 = 7;
        val.w7b2320 = headerspec.intermediate_freq;
        
        % bit 19-0 rest of the gaudi
        nbit.w7b1900 = 20;
        word.w7b1900 = 7;
        val.w7b1900 = 0;    
        
    otherwise
        fprintf(' No extended user data selected\n')        
        
end

%% Create header structure
header.val      = val;
header.bits     = bits;
header.nbit     = nbit;
header.word     = word;

end

