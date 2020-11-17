function create_v2d_file_wrapper(SIM_sta,controling)
%wrapper function around create_v2d_antenna_struct und create_v2d_file

% create v2d antenna struct
[v2d_antenna] = create_v2d_antenna_struct(SIM_sta{1, 1});

% write v2d file
create_v2d_file([controling.output_folder_long, controling.experiment_name],[controling.experiment_name,'.vex'],controling.difx_nChan,controling.difx_tInt,v2d_antenna,controling.subintNS);

end

