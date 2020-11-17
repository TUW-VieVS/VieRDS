function [list_global_observation_params_length_array, length_params] = get_global_observation_params_array
% list of params which are valid for all channels with lenght 1

% parameter names
list_global_observation_params_length_array = {'date_vec', 's_crf_sph', 'X_trf'};

% length of parameter arrays (e.g. length(s_crf) = 2)
length_params = [6, 2, 3];

end