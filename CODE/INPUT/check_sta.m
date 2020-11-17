function [sta, Nch, Nch_max, multi_channel_spec,yes_match,no_match] = check_sta(sta)
% check and prepare input settings

% number of channels per station
Nch = get_number_of_f0_from_input( sta );

% maximum number of channels
Nch_max = get_Nch_max(Nch);

% number of defined channels
Nch_sum = get_Nch_sum(Nch);

% convert (cell array to array) global observation params (length > 1)
sta  = correct_input_format_channel_independent( sta );

% convert/check (cell array to array) global observation params (length == 1)
sta  = correct_input_format_channel_independent_length_1( sta, Nch );

% convert/check multi channel params
[sta, multi_channel_spec] = check_multi_channel_params(sta, Nch);

% sort frequencies
sta = sort_multichannel_params(sta,multi_channel_spec);

% create frequency range matrix
freq_range_matrix = create_frequency_range_matrix(sta,Nch_sum);

% find corresponding channels
[yes_match,no_match] = find_corresponding_channels(freq_range_matrix, Nch_sum);

% check mode
check_input_mode( sta );

% check signal type target source
check_signal_type_target_source( sta );

% check check_sampling_frequency
check_sampling_frequency( sta )

end

