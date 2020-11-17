


% Write VDIF data

% three structs are created
% nbit.wXbBaBb  = value     --> stores number of bits per word and bit(stream)
% val.wXbBaBb   = value     --> stores value per word and bit(stream) in different formats (e.g. char: 'Hb', double: 3)
% bits.wXbBaBb  = value     --> stores value in particular format per bit(s)) not required anymore 

% TO-DO 

% Header finished but needs checking routines
% Also implement header without EDV 3 version exception
% ...

%% Header description
% figure                        | nbit  | matlab var                    | description
% I1                            | 1     | invalid_flag                  | Invalid flag to specifiy if data is valid or not, valid = 0, invalid = 1
% L1                            | 1     | standard_vdif_header_length   | Legace mode: 16byte or 32byte header
% sec_from_ref_epoch30          | 30    | sec_from_ref_epoch            | Seconds from reference epoch
% U2                            | 2     | unnassgined                   | unassgined, [0,0]
% Ref Epoch                     | 6     | half_years_from_2000          | Ref epoch: half year counter since 2000
% Data Frame # within second    | 24    | number_of_frame_within_sec    | Data frame # within second (sequential)
% V3                            | 3     | vdif_version_number           | vdif version number
% log2(#ch)                     | 5     | number_of_channels            | log 2 (#channels in Data Array); #chans must be power of 2;
% Data Frame length             | 24    | data_frame_length             | Data Frame length (including header) in units of 8 bytes
% C1                            | 1     | input_data_type               | Data type, ?0? ? Real data, ?1? ? Complex data
% bits/sample-1                 | 5     | number_of_bits_per_sample     | #bits/sample-1 (32 bits/sample max)
% Thread ID                     | 10    | thread_id                     | Thread ID (0 to 1023)
% Station ID                    | 16    | station_id                    | The 16-bit ?Station ID? field will accommodate the standard globally assigned 2-character ASCII ID.
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


%% Clean buffer
clear; close all;

%% Bit order 
config.bit_msbflag = 'left-msb';

%% Reference values of the header

% EUD Version 0 (standard)

% Reference variable names of all elements of all words of the header
ref.EUDV0.data_varnames = { 'invalid_flag' ; 'standard_vdif_header_length' ; 'sec_from_ref_epoch' ; 'unnassgined' ; 'half_years_from_2000' ; 'number_of_frame_within_sec' ; 'vdif_version_number' ; 'number_of_channels' ; 'data_frame_length' ; 'input_data_type' ; 'number_of_bits_per_sample' ; 'thread_id' ; 'station_id' ;  'extended_user_data_ver_nr' ; 'default_edu_V0_word4'; 'default_edu_V0_word5'; 'default_edu_V0_word6'; 'default_edu_V0_word7' };

% Reference fieldnames of all elements of all words of the header
ref.EUDV0.data_fieldnames = {'w0b3131';'w0b3030';'w0b2900';'w1b3130';'w1b2924';'w1b2300';'w2b3129';'w2b2824';'w2b2300';'w3b3131';'w3b3026';'w3b2516';'w3b1500';'w4b3124';'w4b2300';'w5b3100';'w6b3100';'w7b3100'};

% Reference data types of all elements of all words of the header
ref.EUDV0.data_type = { 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'char' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' };
    
% Reference precision of all the elements of all words of the header
ref.EUDV0.data_precision = [ 1 ; 1 ; 30 ; 2 ; 6 ; 24 ; 3 ; 5 ; 24 ; 1 ; 5 ; 10 ; 16 ; 8 ; 24 ; 32 ; 32 ; 32 ];

% check
if length(ref.EUDV0.data_fieldnames) ~= length(ref.EUDV0.data_type) || length(ref.EUDV0.data_type) ~= length(ref.EUDV0.data_precision) || length(ref.EUDV0.data_varnames) ~= length(ref.EUDV0.data_type)
    error(' Something wrong with the reference definitions. Programmer fault')
end

% EUD Version 3 (VLBA)

% Reference fieldnames of all elements of words 1-3 of the header
ref.EUDV3.data_fieldnames = {'w0b3131';'w0b3030';'w0b2900';'w1b3130';'w1b2924';'w1b2300';'w2b3129';'w2b2824';'w2b2300';'w3b3131';'w3b3026';'w3b2516';'w3b1500';'w4b3124';'w4b2323';'w4b2200';'w5b3100';'w6b3100';'w7b3128';'w7b2724';'w7b2320';'w7b1916';'w7b1616';'w7b1512';'w7b1108';'w7b0700'};

% Reference data types of all elements of words 1-3 of the header
ref.EUDV3.data_type = { 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'char' ;  'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' ; 'ubit' };
    
% Reference precision of all the elements of words 1-3 of the header
ref.EUDV3.data_precision = [ 1 ; 1 ; 30 ; 2 ; 6 ; 24 ; 3 ; 5 ; 24 ; 1 ; 5 ; 10 ; 16 ; 8 ; 1 ; 23 ; 32 ; 32 ; 4 ; 4 ; 4 ; 3 ; 1 ; 4 ; 4 ; 8 ];

if length(ref.EUDV3.data_fieldnames) ~= length(ref.EUDV3.data_type) || length(ref.EUDV3.data_type) ~= length(ref.EUDV3.data_precision)
    error(' Something wrong with the reference definitions. Programmer fault')
end

%% Your values
input_val.invalid_flag                  = 'false';
input_val.standard_vdif_header_length   = 'true';
input_val.sec_from_ref_epoch            =  2^30-1;
input_val.unnassgined                   = 0;
input_val.half_years_from_2000          = 63; % half year counter since 2000
input_val.number_of_frame_within_sec    = 1;
input_val.vdif_version_number           = 1;
input_val.number_of_channels            = 8;
input_val.data_frame_length             = 2^12;
input_val.input_data_type               = 'real';
input_val.number_of_bits_per_sample     = 32-1;
input_val.thread_id                     = 0;
input_val.station_id                    = 'Hb';
input_val.extended_user_data_ver_nr     = 0;

% Extended user data
switch input_val.extended_user_data_ver_nr
    case 0
        input_val.default_edu_V0_word4 = 0;
        input_val.default_edu_V0_word5 = 0;
        input_val.default_edu_V0_word6 = 0;
        input_val.default_edu_V0_word7 = 0;
    case 3    
        input_val.unit_sampling_freq    = 'MHz';
        input_val.sampling_freq         = 256;
        input_val.lo_if_tuning          = 512*10^6;
        input_val.DBE_unit              = 0; % or 1
        input_val.intermediate_freq     = 0;
end

%% Print your values
fprintf('  Bit order:                   \t\t%s\n' , config.bit_msbflag )

fprintf('  Data invalid:                \t\t%s\n' , input_val.invalid_flag )
fprintf('  VDIF standard header length: \t\t%s\n' , input_val.standard_vdif_header_length )
fprintf('  Sec from ref epoch:          \t\t%d\n' , input_val.sec_from_ref_epoch )
fprintf('  Half years from 2000:        \t\t%d\n' , input_val.half_years_from_2000 )
fprintf('  Number of frame in sec:      \t\t%d\n' , input_val.number_of_frame_within_sec )
fprintf('  VDIF version number:         \t\t%d\n' , input_val.vdif_version_number )
fprintf('  Number of channels:          \t\t%d\n' , input_val.number_of_channels )
fprintf('  Data frame length:           \t\t%d bit\n' , input_val.data_frame_length)
fprintf('  Input data type:             \t\t%s\n' , input_val.input_data_type )
fprintf('  Number of bits per sample:   \t\t%d\n', input_val.number_of_bits_per_sample )
fprintf('  Thread ID:                   \t\t%d\n', input_val.thread_id )
fprintf('  Station ID:                  \t\t%s\n', input_val.station_id )
fprintf('  Extended ser data version:   \t\t%d\n',input_val.extended_user_data_ver_nr)
if input_val.extended_user_data_ver_nr == 3
    fprintf('    Unit:                   \t\t%s\n', input_val.unit_sampling_freq )
    fprintf('    Sampling rate:          \t\t%d\n', input_val.sampling_freq)
    fprintf('    LO IF tuning freq:      \t\t%d\n', input_val.lo_if_tuning)
    fprintf('    DBE number at the site: \t\?%d\n', input_val.DBE_unit)
    fprintf('    Intermediate Freq:      \t\t%d\n', input_val.intermediate_freq);
end


%% VDIF FRAME HEADER
% WORD 0 

% bit 31
% Invalid data (i.e. data in this Data Frame has been tagged Invalid by the data source); valid=0, invalid=1
nbit.w0b3131=1;
if strcmp(input_val.invalid_flag,'false')
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
nbit.w0b3030=1;
if strcmp(input_val.standard_vdif_header_length,'true')
    bits.w0b3030 = false;
    val.w0b3030 = 0;
else
    bits.w0b3030 = true;
    val.w0b3030 = 1;
end

% bit 29-0
% Seconds from reference epoch;
nbit.w0b2900 = 30;
if input_val.sec_from_ref_epoch >= 2^nbit.w0b2900
    warning('Number of seconds from reference exceeds limit. Must be smaller than 2^30')
end
bits.w0b2900 = de2bi( input_val.sec_from_ref_epoch , nbit.w0b2900 , config.bit_msbflag );
val.w0b2900 = input_val.sec_from_ref_epoch;

% WORD 1

% bit 31-30 Unassigned (should be set to all 0's)
nbit.w1b3130 = 2;
bits.w1b3130 = [false,false];
val.w1b3130 = input_val.unnassgined;

% bit 29-24 Reference Epoch for second count
nbit.w1b2924 = 6;
if input_val.half_years_from_2000 >= 2^nbit.w1b2924
    warning('Number of half year counter exceeds limit. Must be smaller than 2^6')
end
bits.w1b2924 = de2bi( input_val.half_years_from_2000 , nbit.w1b2924 , config.bit_msbflag );
val.w1b2924 = input_val.half_years_from_2000;

% bit 23-0 Data Frame # within second, starting at zero; must be integral number of Data Frames per second
nbit.w1b2300 = 24;
if input_val.number_of_frame_within_sec >=2^nbit.w1b2300
    warning('Number of frames exceed limit. Must be smaller than 2^24')
end
bits.w1b2300 = de2bi( input_val.number_of_frame_within_sec , nbit.w1b2300 , config.bit_msbflag );
val.w1b2300 = input_val.number_of_frame_within_sec;

% WORD 2

% bit 31-29 VDIF version number
nbit.w2b3129 = 3;
if input_val.vdif_version_number >= 2^nbit.w2b3129
    warning('VDIF version number is too large')
end
bits.w2b3129 = de2bi( input_val.vdif_version_number , nbit.w2b3129 , config.bit_msbflag );
val.w2b3129 = input_val.vdif_version_number;

% bit 28-24 #chans must be power of 2
nbit.w2b2824 = 5;
input_val.log2_number_of_channels = log2(input_val.number_of_channels);
if floor(input_val.log2_number_of_channels) ~= input_val.log2_number_of_channels
    warning('Number of channels is not power of 2')
end
if input_val.log2_number_of_channels >= 2^nbit.w2b2824
    warning('Number of channels exceed limit.')
end
bits.w2b2824 = de2bi( input_val.log2_number_of_channels , nbit.w2b2824 , config.bit_msbflag );
val.w2b2824 = input_val.log2_number_of_channels;

% bit 23-0 Data Frame length (including header) in units of 8 bytes
nbit.w2b2300 = 24;
if input_val.data_frame_length >= 2^nbit.w2b2300
    warning('Data frame length (including header) exceeds limit')
end
if mod(input_val.data_frame_length,8*8) ~= 0
    warning('Data frame length is not multiple of 8 byte')
end
bits.w2b2300 = de2bi( input_val.data_frame_length , nbit.w2b2300 , config.bit_msbflag );
val.w2b2300 = input_val.data_frame_length;

% WORD 3

% bit 31 data type
nbit.w3b3131 = 1;
if strcmp( input_val.input_data_type , 'real' )
    bits.w3b3131 = false;
    val.w3b3131 = 0;
end
if strcmp( input_val.input_data_type , 'complex' )
    bits.w3b3131 = true;
    val.w3b3131 = 1;
end

% bit 30-26 #bits/sample-1 (32 bits/sample max)
nbit.w3b3026 = 5;
if input_val.number_of_bits_per_sample >= 2^nbit.w3b3026
    warning('Number of bits per sample exceeds limit')
end
bits.w3b3026 = de2bi( input_val.number_of_bits_per_sample , nbit.w3b3026 , config.bit_msbflag );
val.w3b3026 = input_val.number_of_bits_per_sample;

% bit 25-16 Thread ID (0 to 1023)
nbit.w3b2516 = 10;
if input_val.thread_id >= 2^nbit.w3b2516
    warning('Thread ID number exceeds limit')
end
bits.w3b2516 = de2bi( input_val.thread_id , nbit.w3b2516 , config.bit_msbflag );
val.w3b2516 = input_val.thread_id;

% bit 15-00 Station ID 
nbit.w3b1500 = 16;
bits.w3b1500 = reshape(dec2bin(input_val.station_id,nbit.w3b1500/2).'-'0',1,[]);
val.w3b1500 = input_val.station_id;

%% Extended User Data (EUD)
switch input_val.extended_user_data_ver_nr
   
    case 0 % NO EUD
    
        % WORD 4 
        
        % bit 31-24 Extended Data Version (EDV) number
        nbit.w4b3124 = 8;
        val.w4b3124 = input_val.extended_user_data_ver_nr;
        
        % bit 23-00 Default 0's
        nbit.w4b2300 = 24;
        val.w4b2300 = input_val.default_edu_V0_word4;
        
        % WORD 5 
        
        % bit 31-00 Default 0's
        nbit.w5b3100 = 32;
        val.w5b3100 = input_val.default_edu_V0_word5;
        
        % WORD 6 
        
        % bit 31-00 Default 0's
        nbit.w6b3100 = 32;
        val.w6b3100 = input_val.default_edu_V0_word6;
        
        % WORD 7 
        
        % bit 31-00 Default 0's
        nbit.w7b3100 = 32;
        val.w7b3100 = input_val.default_edu_V0_word7;
       
    case 3 % EUD VLBA
    
        % WORD 4 
        
        % bit 31-24 Extended Data Version (EDV) number
        nbit.w4b3124 = 8;
        if input_val.extended_user_data_ver_nr >= 2^nbit.w4b3124
            warning('EDV number exceeds limit')
        end
        bits.w4b3124 = de2bi( input_val.extended_user_data_ver_nr , nbit.w4b3124 , config.bit_msbflag );
        val.w4b3124 = input_val.extended_user_data_ver_nr;
        
        % bit 23 Units: 0 = KHz, 1 = MHz
        nbit.w4b2323 = 1;
        bits.w4b2323 = 9999999;
        if strcmp(input_val.unit_sampling_freq,'KHz')
            bits.w4b2323 = false;
            val.w4b2323 = 0;
        end
        if strcmp(input_val.unit_sampling_freq,'MHz')
            bits.w4b2323 = true;
            val.w4b2323 = 1;
        end
        if bits.w4b2323 == 9999999
            warning('Unit is not set correctly')
        end
        
        % bit 22-0 Sampling Rate in U units (ksps or Msps)
        nbit.w4b2200 = 23;
        if input_val.sampling_freq >= 2^nbit.w4b2200
            warning('Sampling rate exceeds limit')
        end
        bits.w4b2200 = de2bi( input_val.sampling_freq , nbit.w4b2200 , config.bit_msbflag );
        val.w4b2200 = input_val.sampling_freq;
        
        % WORD 5 
        
        % bit 31-0 Sync Pattern 0xACABFEED
        nbit.w5b3100 = 32;
        val.w5b3100 = '0xACABFEED';
        
        % WORD 6 
        
        % bit 32-0 LOIF Frequency Tuning Word, unsigned int - # of Hz (32)
        nbit.w6b3100 = 32;
        val.w6b3100 = input_val.lo_if_tuning;
        
        % WORD 7  
        
        % bit 31-28 Unassigned
        nbit.w7b3128 = 4;
        bits.w7b3128 = [false,false,false,false];
        val.w7b3128 = 0;
        
        % bit 27-24 DBE unit
        nbit.w7b2724 = 4; 
        val.w7b2724 = input_val.DBE_unit;
        
        % bit 23-20 IF
        nbit.w7b2320 = 4;
        val.w7b2320 = input_val.intermediate_freq;
        
        % bit 19-0 rest of the gaudi
        nbit.w7b1900 = 20;
        val.w7b1900 = 0;    
        
    otherwise
        fprintf(' No extended user data selected\n')               
end

%% Write to file
vdif_file_name = 'one_sec_noise.vdif';
fileID = fopen( vdif_file_name , 'w');

if strcmp(config.bit_msbflag,'left-msb')
    config.bit_msbflag_fwrite = 'l';
end

% Method:
% fwrite(fileID,A,precision,skip,machinefmt)
% fwrite ... write data to binary file
% fileID ... file identifier, specified as an integer obtained from fopen, 1 for standard output, or 2 for standard error
% A ... data to write, specified as a numeric, character, or string

% check file id
if fileID >= 3
    fprintf(' Valid file identifier (fopen)\n')
elseif fileID == -1
    warning(' fopen cannot open the %s, then fileID is -1\n',vdif_file_name)
end

% check fieldnames of var
if strcmp(ref.EUDV0.data_fieldnames,fieldnames(val))
    fprintf(' Correct header fieldnames\n')
else
    warning(' Incorrect header fieldnames')
end

% write data
fprintf(' Write data\n')
fprintf(' \t%32s\t%s\t%s\t%s\t%s\n','var-name','field','datatype','value','nbits')
val_fieldnames = fieldnames(val);
for i_elem = 1:length(fieldnames(val))
    curr_fieldname  = val_fieldnames{i_elem};
    curr_data_type  = ref.EUDV0.data_type{i_elem};
    curr_val        = val.(curr_fieldname);
    curr_varname    = ref.EUDV0.data_varnames{i_elem};
    curr_nbits      = nbit.(curr_fieldname);
    switch curr_data_type
        case 'ubit'
            fprintf('\t%32s\t%s\t%s\t%12d\t%d\n',curr_varname,curr_fieldname,curr_data_type,curr_val,curr_nbits)
            fwrite( fileID , curr_val, [curr_data_type,num2str(curr_nbits)] , config.bit_msbflag_fwrite );
        case 'char'
            fprintf('\t%32s\t%s\t%s\t%12s\t%d\n',curr_varname,curr_fieldname,curr_data_type,curr_val,curr_nbits)
            fwrite( fileID , curr_val, curr_data_type , config.bit_msbflag_fwrite );
        otherwise
            fprintf('New data type %s\n',curr_data_type)
            error(' There is a new data type')                
    end
end

switch input_val.extended_user_data_ver_nr
    
    case 0 % NO EDV
    
        fwrite( fileID , val.w4b3124 ,   ['ubit', num2str(nbit.w4b3124)] , config.bit_msbflag_fwrite ); % WORD 4
        fwrite( fileID , 0           ,   ['ubit',          num2str(24) ] , config.bit_msbflag_fwrite ); % WORD 4
        fwrite( fileID , 0           ,   ['ubit',          num2str(32) ] , config.bit_msbflag_fwrite ); % WORD 5
        fwrite( fileID , 0           ,   ['ubit',          num2str(32) ] , config.bit_msbflag_fwrite ); % WORD 6
        fwrite( fileID , 0           ,   ['ubit',          num2str(32) ] , config.bit_msbflag_fwrite ); % WORD 7
                
    case 3 % EDV VLBA
    
        fwrite( fileID , val.w4b3124 ,   ['ubit', num2str(nbit.w4b3124)] , config.bit_msbflag_fwrite );
        fwrite( fileID , val.w4b2323 ,   ['ubit', num2str(nbit.w4b2323)] , config.bit_msbflag_fwrite );
        fwrite( fileID , val.w4b2200 ,   ['ubit', num2str(nbit.w4b2200)] , config.bit_msbflag_fwrite );
        fwrite( fileID , val.w5b3100 ,   ['ubit', num2str(nbit.w5b3100)] , config.bit_msbflag_fwrite );
        fwrite( fileID , val.w6b3100 ,   ['ubit', num2str(nbit.w6b3100)] , config.bit_msbflag_fwrite );
        fwrite( fileID , val.w7b3128 ,   ['ubit', num2str(nbit.w7b3128)] , config.bit_msbflag_fwrite );
        fwrite( fileID , val.w7b2724 ,   ['ubit', num2str(nbit.w7b2724)] , config.bit_msbflag_fwrite );
        fwrite( fileID , val.w7b2320 ,   ['ubit', num2str(nbit.w7b2320)] , config.bit_msbflag_fwrite );
        fwrite( fileID , val.w7b1900 ,   ['ubit', num2str(nbit.w7b1900)] , config.bit_msbflag_fwrite );
end

fclose(fileID);


