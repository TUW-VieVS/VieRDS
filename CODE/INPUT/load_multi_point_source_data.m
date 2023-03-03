function [SIM_sta] = load_multi_point_source_data(SIM_sta)

% number of simulations/channels
NSIM = length(SIM_sta);

% loop through simulations/channels
for isim=1:NSIM

    % get channel specific station struct
    P=SIM_sta{isim,1};

    % get station names and number of stations
    [ St, Nst ] = station_struct_label( P );

    % loop through stations
    for ist=1:Nst
    
        % get station specific struct
        p = P.(St{ist});

        % check requirements to load multi-point source data
        k = check_multi_point_source_input_specs(p);

        % read multi-point source data
        [ SIM_sta{isim,1}.(St{ist}) ] = read_multi_point_source_data(k, p);

    end
    
end

end