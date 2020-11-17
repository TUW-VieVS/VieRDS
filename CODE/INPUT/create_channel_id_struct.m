function CH_ind = create_channel_id_struct(controling,SIM_sta)
% creates channel id struct
% input:
%   controling
%   SIM_sta
% output:
%   CH_ind

% pre-allocate
CH_ind = struct;

% for each station
for iSt = 1:controling.NSt
    
    
    im = 1;
    
    % per simulation
    for iSim = 1:length(SIM_sta)
        
        % station labeling in simulation struct
        [ stations, ~ ] = station_struct_label( SIM_sta{iSim} );
        ind = find(strcmp( controling.stations{iSt}, stations ));
        if ~isempty(ind)
            CH_ind.(controling.stations{iSt})(im,1) = iSim;
            im = im+1;
        end        
    end
end

end

