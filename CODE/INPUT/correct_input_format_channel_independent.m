function  s  = correct_input_format_channel_independent( s )
% Convert special channel independent (non-multichannel) params from cell arrays to arrays.

[list_params, length_params] = get_global_observation_params_array;

stations = fieldnames(s);
for iSt = 1:length(fieldnames(s))
    fn = fieldnames(s.(stations{iSt}));
    for iP = 1:length(list_params)
        if find(strcmp(fn, list_params{iP}))
            val = s.(stations{iSt}).(list_params{iP});
            if iscell(val)
                if length(val) == length_params(iP)
                    
                    % check if input is num
                    for iVal = 1:length(val)
                        if ~isnumeric(val{iVal})
                            fprintf('%s: No numeric input for %s: %s\n', stations{iSt}, list_params{iP}, val{iVal})
                        end
                    end
                    
                    s.(stations{iSt}).(list_params{iP}) = cell2mat(val);
                    
                else
                    
                    fprintf('Wrong # input for: %s\n', list_params{iP})
                    fprintf('\tspecified: %d\n', length(val))
                    fprintf('\trequired: %d\n', length_params(iP))
                    error('Wrong Input specification')
                    
                end
            end
        end
    end  
end

end

