function [SIM_sta, CH_ind, controling, ref_frame] = bbs_input(yaml_file_name)
% converts input parameterization from .yaml or defaul to simulation cell
% reads in controling params
% reads external database
%
% output:
%
%   SIM_sta ... cell with station struct per element. This is the base for
%   further simulations. No other input data will be used for this code
%   (execpt the model parameterization for the kinematic modeling)
%
%   CH_ind ...   

% create sta
[sta,controling] = create_sta(yaml_file_name);

% print controling setup
print_controling_setup(controling)

% check sta
[sta, ~, ~, multi_channel_spec,yes_match,no_match] = check_sta(sta);

% create SIM_sta
SIM_sta = create_SIM_sta(yes_match, no_match, sta, multi_channel_spec);

% read in tone phase offset values
[SIM_sta] = readTonePhaseOffset(SIM_sta);

% read in arbitrary magnitude response 
[SIM_sta] = readArbMagResp(SIM_sta);

% read multi-point source data
[SIM_sta] = load_multi_point_source_data(SIM_sta);

% station names and number of stations
[ controling.stations, controling.NSt ] = station_struct_label( sta );

% create channel id struct
CH_ind = create_channel_id_struct(controling,SIM_sta);

% external database for reference frame coordinates
if controling.zero_bl == 0
    ref_frame = load_reference_frame(controling);
else
    fprintf('zero baseline simulation selected: no need to load EOP, station position databases ... \n')
    ref_frame = struct;
end

end

