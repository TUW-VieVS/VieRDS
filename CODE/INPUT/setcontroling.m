function controling = setcontroling
% setup parameters

%% folder
% create name for output folder based on time-tag
controling.output_folder = char(datetime('now','Format','yyyy_DDD_HH_mm_ss'));
controling.output_folder_long = ['OUT/',controling.output_folder,'/'];

% CODE
controling.code_folder = 'CODE/';

% DIFX
controling.difx_folder = 'DIFX/';
controling.difx_folder_long = 'DIFX/';

% OUT DIFX
controling.output_difx_folder_long = [controling.output_folder_long,controling.difx_folder];


%% vdif
% write vdif file yes or no
controling.write_vdif_file                      = 1;

%% vex
% write vex file yes or no
controling.vex_file                             = 1;

% experiment name
controling.experiment_name = 'sim';

% vex file format
controling.vex_file_format = '1.5';

% experiment description
controling.experiment_description = 'baseband_data_simulation';

% user name
controling.user_name = 'your_username';

% target correlator
controling.target_corr = 'your_target_correlator';

% software 
controling.software = 'VieRDS';

% software version
[~,controling.software_version] = system('git rev-parse HEAD');
controling.software_version = controling.software_version(1:end-1);
%% simulation mode
% zero or non-zero baseline simulation
controling.zero_bl                              = 1;

% color map controling 
controling.color_map_type                       = 1;
controling.color_map                            = define_colormap( controling.color_map_type );

%% coordinate frame
% define trf database
controling.vie_init.trf = {'vievsTrf.txt'};

% define crf database
controling.vie_init.crf = {'supersource.mat'};

% define EOP database
controling.EOPfile = 'finals_all_IAU2000.txt';

% define interpolation method (support: lagrange or linear)
controling.eop_interp_method = 'lagrange';

% define nutation model
controling.nutmod = 'IAU_2006/2000A';

%% input yaml
controling.yaml_file_name = 'input_val.yaml';

%% difx
controling.write_v2d_file = 1;
controling.difx_tInt = 0.025;
controling.difx_nChan = 64;
controling.subintNS = 256000.000000;


end

