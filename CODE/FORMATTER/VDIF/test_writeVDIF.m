%% ys
clear; close all

% test writeVDIF

% Input
file_name                         = 't.vdif';
frame_length_byte                 = 8032; % bytes
header_length_byte                = 32; % bytes
date_vec                          = [2019, 1, 24, 12, 22, 49]; % year, month, day, hour, min, sec
scan_duration                     = 1; % seconds
sampling_freq                     = 128*10^3; % samples/second
vdif_version_number               = 1;
number_of_channels                = 1;
number_of_bits_per_sample         = 2;
station_2lc                       = 'NA';


% Dataset
% range of values of sample starting from zero to
samples = zeros( number_of_channels , sampling_freq * scan_duration );
for ichan = 1:number_of_channels
    samples(ichan,:) = randi( [ 0 , 2^number_of_bits_per_sample-1  ] , [ 1 ,sampling_freq * scan_duration ] );
        edges = [0 1 2 3 4];
    N = histcounts(samples,edges);
%     fprintf( 'sample stats:\t%d\t%d\t%d\t%d\n' , N(1) , N(2)  , N(3) , N(4) );
end
save('samples','samples')
% y = xcorr(samples, samples );
% load samples.mat
% write data to file in vdif format
% wn
delete(file_name)
% tic
writeVDIF( file_name , frame_length_byte , header_length_byte , date_vec , scan_duration , sampling_freq , vdif_version_number , number_of_channels , number_of_bits_per_sample , station_2lc , samples )
% toc
% sa
% writeVDIF( file_name, frame_length_byte , header_length_byte , date_vec , scan_duration , sampling_freq , vdif_version_number , number_of_channels , number_of_bits_per_sample , station_2lc , samples )


% %% wn
% clear; close all
% 
% % test writeVDIF
% 
% % Input
% file_name                         = 'eint12_2019y024d11h00m00s_wn_sim.vdif';
% frame_length_byte                 = 8032; % bytes
% header_length_byte                = 32; % bytes
% date_vec                          = [2019, 1, 24, 11, 0, 0]; % year, month, day, hour, min, sec
% scan_duration                     = 1; % seconds
% sampling_freq                     = 32*10^6; % samples/second
% vdif_version_number               = 1;
% number_of_channels                = 1;
% number_of_bits_per_sample         = 2;
% station_2lc                       = 'Wn';
% 
% % Dataset
% % range of values of sample starting from zero to
% samples = zeros( number_of_channels , sampling_freq * scan_duration );
% for ichan = 1:number_of_channels
%     samples(ichan,:) = randi( [ 0 , 2^number_of_bits_per_sample-1  ] , [ 1 ,sampling_freq * scan_duration ] );
% end
% 
% % write data to file in vdif format
% writeVDIF( file_name , frame_length_byte , header_length_byte , date_vec , scan_duration , sampling_freq , vdif_version_number , number_of_channels , number_of_bits_per_sample , station_2lc , samples )

