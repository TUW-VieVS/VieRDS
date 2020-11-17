clear 
close all

%% Input data
% vdiffile = '/data/DATA/basebanddata/vdif/eint12_ys_024-1111.m5a';
% vdiffile = '/data/DATA/basebanddata/vdif/eint12_ys_024-1115.m5a';
%  vdiffile = '/data/DATA/basebanddata/vdif/eint12_ys_024-1102.m5a';
% vdiffile = '/data/DATA/basebanddata/vdif/eint12_ys_024-1243.m5a';
% vdiffile = '/data/DATA/basebanddata/vdif/eint12_ys_024-1259.m5a';
% vdiffile = '/data/DATA/basebanddata/vdif/17277ax__aua028_34_0070.vdif';
% vdiffile = '/data/DATA/basebanddata/vdif/17277ax__aua028_34_0074.vdif';
% vdiffile = '/data/GIT/HUB/BasebandSim/VDIF/test_file.vdif';
% vdiffile = '/data/DATA/correlation/eint12sim/ys/eint12_2019y024d11h00m00s_Ys_with_delay_sim.vdif';
vdiffile = 't.vdif';

%% Read line by line
% read_vdif_word_per_word( vdiffile )

%% Read headers
% Open file
fid = fopen( vdiffile );

% Get global infos of file (store it in params)
% read first header
[ header , fid ] = read_vdif_header( fid );

% get data from header and creat params.struct
params = readheader2headeraux( header , vdiffile ); 

% close file
fclose( fid );

% frame id
headerframes.id_frame = 0 : (params.number_frames_file-1) ;

% frame_within_1sec
headerframes.frame_within_1sec = zeros( 1 , params.number_frames_file );

% hyf2000
headerframes.hyf2000 = zeros( 1 , params.number_frames_file );

% sec_from_hyf2000
headerframes.sec_from_hyf2000 = zeros( 1 , params.number_frames_file );

% create pointer to headers in file
headerframes.pointer_header = 0 : params.frame_length_byte : (params.filesize_byte-params.frame_length_byte);

% Read all headers
fid = fopen( vdiffile );

for id_frame = headerframes.id_frame
    fseek( fid , headerframes.pointer_header( id_frame + 1 ) , 'bof' );
    [ header , fid ] = read_vdif_header( fid );
    curr_params = readheader2headeraux( header , vdiffile );
    
    % frame_within_1sec
    headerframes.frame_within_1sec( id_frame + 1 ) = curr_params.number_of_frame_within_sec; 
    
    % hyf2000
    headerframes.hyf2000( id_frame + 1 ) = curr_params.half_years_from_2000;
    
    % sec_from_hyf2000
    headerframes.sec_from_hyf2000( id_frame + 1 ) = curr_params.sec_from_ref_epoch30;
    
%     print_vdif_header( curr_params.)
    
end
fclose( fid );

% Further Calculations
params.number_frames_per_sec = max( headerframes.frame_within_1sec ) + 1;
params.sampling_freq         = params.number_frames_per_sec * params.num_samples_frame;
params.frame_duration        =  params.num_samples_frame / params.sampling_freq;
params.scan_duration         = params.number_frames_file * params.frame_duration;
params.sec_last_frame        = params.frame_duration*headerframes.frame_within_1sec(end);
headerspec                              = create_headerspecification_global( params );
headerspec.number_of_frame_within_sec   = curr_params.number_of_frame_within_sec;
[yyyy mm dd HH MM SS] = vdifdate2date( headerframes.hyf2000(1) , headerframes.sec_from_hyf2000(1) );
params.date_vec     = [yyyy mm dd HH MM SS];
params.mjd          = mjuliandate( [yyyy mm dd HH MM SS] );
[yyyy mm dd HH MM SS] = vdifdate2date( headerframes.hyf2000(end) , headerframes.sec_from_hyf2000(end) );
params.mjd_end   = mjuliandate( [yyyy mm dd HH MM round((SS+params.sec_last_frame))] ) ;
params.mjd_end   = mjuliandate( [yyyy mm dd HH MM SS+1] ) ;
  

% print
printvdifsum( params , headerspec , headerframes )

%% Read data
% Open file
fid = fopen( vdiffile );

% Pointer to data arrays
headerframes.pointer_data = params.header_length_byte : params.frame_length_byte : (params.filesize_byte);

% Read all data
fid = fopen( vdiffile );



for id_frame = headerframes.id_frame
    
    % Preallocate data array
    samples = zeros( params.number_of_channels , params.num_words_per_data_array );
    id_sample = 0;
    fseek( fid , headerframes.pointer_data( id_frame + 1 ) , 'bof' );
    for id_word = 1:params.num_words_per_data_array
        word = flip( fread( fid , params.word_length , 'ubit1' , 'ieee-le' ) );
        if id_frame == 2
            if id_word < 10
                fprintf( '%d',word); fprintf('\n')
            end
        end
        for id_complexsample = 1:params.num_complete_samples_word
            id_sample = id_sample +1;
            for id_chan = 1:params.number_of_channels
                bpos1 = params.word_length+1 - ((id_complexsample-1)*params.complete_sample_length_bit+id_chan*params.number_of_bits_per_sample);
                sample = word( bpos1 : (bpos1+params.number_of_bits_per_sample-1) )';
%                 fprintf('%d%d\n',sample(1),sample(2));
                
                samples( id_chan , id_sample ) = bi2de( sample ,  params.number_of_bits_per_sample , 'left-msb' );

            end
        end
    end
%     for id_complexsample = 1:params.num_words_per_data_array 
%         
%         for id_chan = 1:params.number_of_channels
%             sample = word(params.word_length+1-(id_chan*params.number_of_bits_per_sample) : params.word_length-((id_chan-1)*params.number_of_bits_per_sample))';
%             samples( id_chan , id_word ) = bi2de( sample ,  params.number_of_bits_per_sample , 'left-msb' );
%         end
%         fprintf( '%d',word); fprintf('\n')
%     end
    
    data(id_frame+1).samples = samples;
%     figure;plot( samples , 'x' );
    edges = [0 1 2 3 4];
    N = histcounts(samples,edges);
    fprintf( 'frame id: %d:\t%d\t%d\t%d\t%d\n' , id_frame , N(1) , N(2)  , N(3) , N(4) );
    
end

fclose( fid );

