function SIM_sta = create_SIM_sta(yes_match, no_match, sta, multi_channel_spec)
% creates a cell which a clean station struct per cell elment. This is the base for further simulations

% Input: 
%   yes_match ... cell with info about matched frequency ranges (station ID, channel ID, lower frequency limit, upper frequency limit)
%   no_match ... cell with all not matched but specified frequency ranges (station ID, channel ID, lower frequency limit, upper frequency limit)
%   sta ... station struct
%   multi_channel_spec ... multi channel specification struct

% Output:
%   SIM_sta ... cell with station struct per element. This is the base for further simulations

% Internal params:
%   N_yes ... number of matched frequency ranges
%   N_no ... number of not matched but specified frequency ranges

% number of matched simulations
if ~isempty(yes_match)
    N_yes = length(yes_match(:,1));
else
    N_yes = 0;
end

% number of single dish simulations
if ~isempty(no_match)
    N_no = length(no_match(:,1));
else
    N_no = 0;
end

% pre-allocated SIM_sta cell
SIM_sta = cell(N_yes+N_no, 1);

% get stations struct label
[ stations, ~ ] = station_struct_label( sta );

% create station setting per multi-station simulation
for isim = 1:N_yes
    
    % station and channel ID per simulation
    st_id = yes_match{isim,1};
    ch_id = yes_match{isim,2};
    
    % look at the station and correct for multiparam specifications
    for ist = 1:length(st_id)
        
        % current station name
        stn = stations{ist};
        
        % copy station specification to temporary struct sta_tmp
        sta_tmp.(stn) = sta.(stn);
        
        % store simulaiton id to station struct as channel id
        sta_tmp.(stn).channel_id = isim;
        
        % split up multiparam values to corresponding simulation
        for i_multip = 1:length(multi_channel_spec.(stn))
            sta_tmp.(stn).(multi_channel_spec.(stn){i_multip}) = sta.(stn).(multi_channel_spec.(stn){i_multip})(ch_id(ist));
        end
    end
    
    % store clean station struct into simulation cell
    SIM_sta{isim,1} = sta_tmp;
    
    % delete temporary station struct
    clear sta_tmp;

end

% create station setting per single-dish simulation
for isim = 1:N_no
    
    % station and channel ID per simulation
    st_id = no_match{isim,1};
    ch_id = no_match{isim,2};
    
    % look at the station and correct for multiparam specifications   
    for ist = 1:length(st_id)
        
        % current station name
        stn = stations{ist};
        
        % copy station specification to temporary struct sta_tmp
        sta_tmp.(stn) = sta.(stn);
        
        % store simulaiton id to station struct as channel id
        sta_tmp.(stn).channel_id = isim;
        
        % split up multiparam values to corresponding simulation
        for i_multip = 1:length(multi_channel_spec.(stn))
            sta_tmp.(stn).(multi_channel_spec.(stn){i_multip}) = sta.(stn).(multi_channel_spec.(stn){i_multip})(ch_id(ist));
        end
    end
    
    % store clean station struct into simulation cell    
    SIM_sta{N_yes+isim,1} = sta_tmp;
    
    % delete temporary station struct
    clear sta_tmp;
    
end

end

