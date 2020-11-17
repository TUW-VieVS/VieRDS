function s  = correct_input_format_channel_independent_length_1( s, Nch )
% convert (cell array to array)/check global observation params which have length = 1

list_params = get_global_observation_params_length_1;

[ stations, number_of_stations ] = station_struct_label( s );

for iSt = 1:number_of_stations
    fn = fieldnames(s.(stations{iSt}));
    for iP = 1:length(list_params)
        if find(strcmp(fn, list_params{iP}))
            val = s.(stations{iSt}).(list_params{iP});
            if iscell(val) 
                if length(val) == 1                   
                    s.(stations{iSt}).(list_params{iP}) = cell2mat(val);                    
                else
                    fprintf('Wrong number of input elements for: %s\n', list_params{iP})
                    fprintf('\tspecified: %d\n', length(val))
                    fprintf('\trequired: 1 (if for all channels same) or #Ch(=%d)\n',Nch.(stations{iSt}) )
                    error('Wrong Input specification')
                end
            end
        end
    end
end

