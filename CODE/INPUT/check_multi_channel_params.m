function [s, multi_channel_spec] = check_multi_channel_params(s, Nch)
% check and convert format of specified multi-channel input params

[ls_glob_array, ~] = get_global_observation_params_array;
ls_glob_1 = get_global_observation_params_length_1;

list_params = [ls_glob_array, ls_glob_1];

[ stations, number_of_stations ] = station_struct_label( s );

multi_channel_spec = struct;
for iSt = 1:number_of_stations
    i_multi = 1;
    fn = fieldnames(s.(stations{iSt}));
    for iFn = 1:length(fn)
        if find(strcmp(fn{iFn}, list_params))
            continue;
        else
            val = s.(stations{iSt}).(fn{iFn});
            if iscell(val)
                if contains(fn{iFn},'arb_mag_file')
                    s.(stations{iSt}).(fn{iFn}) = val;
                    continue;
                end
                if length(val) == 1                   
                    s.(stations{iSt}).(fn{iFn}) = cell2mat(val);                    
                elseif length(val) == Nch.(stations{iSt})
                    s.(stations{iSt}).(fn{iFn}) = cell2mat(val);
                    multi_channel_spec.((stations{iSt})){i_multi} = fn{iFn};
                    i_multi = i_multi+1;
                else
                    fprintf('Wrong # input for: %s\n', fn{iFn})
                    fprintf('\tspecified: %d\n', length(val))
                    fprintf('\trequired: 1 (if for all channels same) or #Ch(=%d)\n',Nch.(stations{iSt}))
                    error('Wrong Input specification')
                end
            end
        end
    end
    
    % if multi-channel params aren't set
    if i_multi == 1
        multi_channel_spec.((stations{iSt})) = {};
    end
    
end

end

